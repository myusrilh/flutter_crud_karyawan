class MemberModel {
  String? rmBranchID;
  String? rmRepID;
  String? rmName;
  String? rmCurrentPosition;
  String? rmManagerID;

  MemberModel(
      {this.rmBranchID,
      this.rmRepID,
      this.rmName,
      this.rmCurrentPosition,
      this.rmManagerID});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      rmBranchID: json['rm_branch_id'] ?? "ID Branch",
      rmRepID: json['rm_rep_id'] ?? "ID Member",
      rmName: json['rm_name'] ?? "Name Member",
      rmCurrentPosition: json['rm_current_position'] ?? "Current Position",
      rmManagerID: json['rm_manager_id'] ?? "ID Manager",
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['rm_branch_id'] = this.rmBranchID;
    data['rm_rep_id'] = this.rmRepID;
    data['rm_name'] = this.rmName;
    data['rm_current_position'] = this.rmCurrentPosition;
    data['rm_manager_id'] = this.rmManagerID;

    return data;
  }
}
