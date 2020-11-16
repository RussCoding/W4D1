require_relative "00_tree_node"
require "byebug"
class KnightPathFinder

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [@root_node.value]
        self.build_move_tree
    end

    def self.valid_moves(pos)
        valid_moves = []
        moves = [[1, -1], [2, -2]]
        moves[0].each do |i|
            moves[1].each do |j|
                first_move = pos[0] + i    
                second_move = pos[1] + j
                if first_move.between?(0, 7) && second_move.between?(0, 7)
                    valid_moves << [first_move, second_move]
                end
                third_move = pos[0] + j    
                fourth_move = pos[1] + i
                if third_move.between?(0, 7) && fourth_move.between?(0, 7)
                    valid_moves << [third_move, fourth_move]
                end
            end 
        end 
        valid_moves
    end 
    

    def new_move_positions(pos)
        arr = KnightPathFinder.valid_moves(pos).reject {|ele| @considered_positions.include?(ele) }
        arr.each {|coordinate| @considered_positions << coordinate}
        arr
    end

    def build_move_tree
        queue = [@root_node]
        until queue.empty? 
            current_position = queue.shift
            move_nodes = self.new_move_positions(current_position.value).map {|ele| PolyTreeNode.new(ele)}
            move_nodes.each {|node| current_position.add_child(node)}
            queue += move_nodes
            #queue.each {|pos| pos.parent = current_position}
        end 
    end

    def find_path(end_pos)
        end_node = @root_node.bfs(end_pos)
        path = trace_path_back(end_node)
        #path.unshift(end_node.value)
        path.reverse
    end
    
    def trace_path_back(node)
        path = []
        path << node.value
        return path if node.parent == nil
        path += trace_path_back(node.parent)
        path
    end


end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]