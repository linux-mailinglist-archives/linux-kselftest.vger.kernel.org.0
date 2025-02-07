Return-Path: <linux-kselftest+bounces-26016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF6A2CA46
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E64D188D148
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7DF19B5B4;
	Fri,  7 Feb 2025 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UrZAOXnU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1919DF5B;
	Fri,  7 Feb 2025 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949724; cv=fail; b=nRjw2ijWMi+f0eTL9UbGfnX79+RVBJsq4w+umiggx5Pcs9OwpH+nfwVh91m8/htSBAdQCDjQYa90BWa4yuKzSA2r4gH/fxBmqdwPh7R6zu9Qb8nSR/rH0Wbhf8cvH4Gd/jfWKx08bNKTR1WAzQpIZrim0dZJrUFj9XDEXGcHRgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949724; c=relaxed/simple;
	bh=3XjXfto6P0qjsR1W/QUmd/jm5gfgVp+P/JnETw4EcIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jdr5KKeiqsTAHCV89mDuUe5E7OpWcNtM2vnJX/uS1BZ5278LAHtPlkgUVzQL8CCh3BtXFQrogWSgMVsMybkOdIR56nHejge5haj+8Iqs7D/D+i8Ikc95lLcsbaMa4R7uFKTE2jjY0/tW+IlL/eCE5VL7d1wAKG2dAW9RSEBSb3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UrZAOXnU; arc=fail smtp.client-ip=40.107.101.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFTpsZak8libZ6+RTDBpI53r1lIu8+6g2JkOxiY/0+5c5q1BG3guFk05AnJrZT79n7kBHMfaagtauc41hxES4JJOpzDKHteTjgieeIh/fBUGR+kU4lGBHwYxX/Tbvjxk8Kvvq/OrQ5q1alsFLspneriRksmD831KzjKaEmX/l556R8Ubb4m5XqJNJCN+YNdOG/vtuEWa1bsFR5v0cwBG+vMek5YLX89zk6mGZup+HrSw0Upj/TkmRIRHp+wDdQhiQoGJBJKWNhtH38UgYgxFqSCNfDnRGVdDBOQqgSng38Eud4PaSBrkkUqo8KGGdlIVy2isgXmjXioZRpJnzM+4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MhM3Xjkb5YFXMq9KAAa9Kh5EpeSR0kvyyOKsjkwjA4=;
 b=JHEORm8PoaBTyfqhVb7x1rYfImmPJtYnzpbmWUOHIDyYrarqJvgSJzeKfvue/OyPMSMxSmLkKmRG6DYr7QyeYhSm7tZGXPeB/+84ywHIqTvsvqMVR07vH8XAfKRI4yXKuTHz9lOQvOqZZeqaZTjIDjtivdOTsAufsH3/q9xPImrn7tvS4f+CxOcBgnZlh+s4+r6n7TgvEFH2X86SDE3jt5UfI5zWa9+MRU1IWsO+BW2QmlnmbqeSDMs+bn1pMI4WuO9iQBh1buhl4200IIwgTQKLnwt1yQxlZ8CBaWFJUQaaJMW1ESEeyUaKjCfqRuibMg5t1v+Sp3FhJhaeWVOTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MhM3Xjkb5YFXMq9KAAa9Kh5EpeSR0kvyyOKsjkwjA4=;
 b=UrZAOXnUkSFneSYfCuis8p8keQcNlZoTpz9VyCEmlpqFoWeaxQVFUJlfNWXfSd3BM4vMK4iY6mEZn88Soi3uKlrs9niU+BOL7and90TXvFvuRFd7rafgCG8Ub7txbfPoNNouOrDWiODhqTAi/MKeKvzmXr+Dgcp8jSyBdzKD0pwi0UsK4WXBUuv9t3wt63NhN01OY70IKcZCukJmrQYPrhzFVm5vYHfI6eh880zcj6njULKWQajR6zwXRvi5Ct0ZV4WlTZmwyjW2Jel3kgufQqw01gaGUMKzlZNcgsPQHoWSKvJkkO5AaUbQpB3BzhWzEvcqhcyEE4bIQzJgJPKIig==
Received: from CH2PR14CA0059.namprd14.prod.outlook.com (2603:10b6:610:56::39)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 17:35:20 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::d3) by CH2PR14CA0059.outlook.office365.com
 (2603:10b6:610:56::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.30 via Frontend Transport; Fri,
 7 Feb 2025 17:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 17:35:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 09:35:04 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Feb
 2025 09:34:59 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 4/4] selftests: test_vxlan_fdb_changelink: Add a test for MC remote change
Date: Fri, 7 Feb 2025 18:34:24 +0100
Message-ID: <ae8722bcacbbafe05b8f41a1d3991fcbbaa7b973.1738949252.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738949252.git.petrm@nvidia.com>
References: <cover.1738949252.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 75934141-9c12-41f5-1527-08dd479dcb3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5nmD8ybz70xTVfVd5b/nWxr8EyVQpRRCULdj47qLGdq7xOAA8zbNl/rE1RLx?=
 =?us-ascii?Q?HuD3TRd65TIXq3ks4ZaejoxhEjWCv1D1LJ65tkMuJCnO86UHDHHOb/r3+Y+K?=
 =?us-ascii?Q?M4Ti9L3vg6CtMzbq7aThX3GJZy7wE76h5Ut1niNTTEeal0QrFThhqBikX4F8?=
 =?us-ascii?Q?x1x22pvD/HO5PC/FvCzlEv8MYHiudyDX8bazsAhwaD2IR+L0uTIMReA1Nf20?=
 =?us-ascii?Q?2R+ZYy5cJaJ6WvueRojXbYyZBNR1GINdFZIOPKEHVukt5i5o5piUAK03tFCF?=
 =?us-ascii?Q?ry6LqNEYmmUX/W2quQKpvtZc57iJP8CrMLkS5ASjEnUFCJ4kdDldn1FAmV7A?=
 =?us-ascii?Q?gmibW6Rp0t2Yw+cZIyvIPg7i2Pi/V5j9Ef9IEVvTynRahqCt2xWJeQg8QADI?=
 =?us-ascii?Q?mAGQmpyM6GQx9fG88f/e1A/3bHzDF5TdIGMih4zeWcB/+4kPjy10PG30uT+V?=
 =?us-ascii?Q?/3nAzqgYAk1iIL3+fUwudBxbi/BYxX5mrr8Rqkj9sNnmvqMP4oh3FIxUjSuK?=
 =?us-ascii?Q?m4EFPEAUHf0Ol+07KYFYZQz7xhxrdxbz/XKL7CJct9sqj9QDjJPc3Zty1Ek5?=
 =?us-ascii?Q?3CjwjNPCMfmkrxnBT7avTuRMzkmE5o3k5TiCQWs5ZE0phjY9DfMlpzMVPjas?=
 =?us-ascii?Q?GuS+GrgJ03UQF4LozFhhgj6DVpTuWZh3MwGyJPD+q7iAN9RE4Svu0jcuiw9l?=
 =?us-ascii?Q?yIPmWdi8EfViAKwGW9tpyIsNPyCpDYgMbz0xs5ejchdRnKyVizARMR7Tlvps?=
 =?us-ascii?Q?125nyQ+QkaWeCao8X2qTcOZAqHkjGHQOPKm+/q+V/qtd1KaIerPO9Z7wqOAN?=
 =?us-ascii?Q?WqlU/biy2hiLyDro7kGeNIymEtcwIWztjI+ADjSM8BB7EGxZq9DfPVlAwMiz?=
 =?us-ascii?Q?R+IJFwWIYqotW1weB5UVXnBTa2rwyQA3nveixMo6Mt2jhj7tySLGa+4GcFSY?=
 =?us-ascii?Q?Lgeg+fX/sM9PtnrUK096Kdf38tu7bSt86RWG3OdYU2IK7UnbsrPrGoMfhLXO?=
 =?us-ascii?Q?s1DBjcDz+/b7dQUlpjARO3wcfacWGgXTP71sdDzBJDf6L1lZ72oA7n2GlFBa?=
 =?us-ascii?Q?GWGfaO1XOGpCg8Ge7a14892cmbDXu3IlIwdH8wU5rpNkfUEj6SkUlnKYxfLD?=
 =?us-ascii?Q?hS3myDpo2DtaPAs5oskyiGDWegKIfCdoKhK7Em4LB7xGF6esr8YqvdVjpdWc?=
 =?us-ascii?Q?n8Lkm0em9yu4SRKOnYW7U+1VaU5ZHhwMviJXXhSJy0+Hx8n9Z4X23jpZ5b8c?=
 =?us-ascii?Q?EHjhaVSeBotWh8TJU9BbhYLQMapmkRYiha7T8PoJyox7604jiXagcB8I4RXs?=
 =?us-ascii?Q?uT4uNhWFa/J8uphZaPEUXxMknhFgq0HgnNvPvTHuo/57SpUAguWZli2QopJJ?=
 =?us-ascii?Q?dwyveaRHJkE32PjlbKQPb+bvndi2F8kpR4ViFturGmpFDVrNYplFGV3+pCv2?=
 =?us-ascii?Q?HGR2+hk7lQPhMgmrEVy27dsMAAgR11o3DsHN6Wn8fFuvOAxtOkSOv36QA6cP?=
 =?us-ascii?Q?TnxI6W5O2sW0oUU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:35:20.0197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75934141-9c12-41f5-1527-08dd479dcb3e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

Changes to MC remote need to be reflected in actual group memberships.
Add a test to verify that it is the case.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Simon Horman <horms@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../net/test_vxlan_fdb_changelink.sh          | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
index 6f2bca4b346c..062f957950af 100755
--- a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
+++ b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
@@ -3,6 +3,7 @@
 
 ALL_TESTS="
 	test_set_remote
+	test_change_mc_remote
 "
 source lib.sh
 
@@ -31,6 +32,81 @@ test_set_remote()
 	log_test 'FDB default-remote handling across "ip link set"'
 }
 
+fmt_remote()
+{
+	local addr=$1; shift
+
+	if [[ $addr == 224.* ]]; then
+		echo "group $addr"
+	else
+		echo "remote $addr"
+	fi
+}
+
+change_remote()
+{
+	local remote=$1; shift
+
+	ip link set dev vx type vxlan $(fmt_remote $remote) dev v1
+}
+
+check_membership()
+{
+	local check_vec=("$@")
+
+	local memberships
+	memberships=$(
+	    netstat -n --groups |
+		sed -n '/^v1\b/p' |
+		grep -o '[^ ]*$'
+	)
+	check_err $? "Couldn't obtain group memberships"
+
+	local item
+	for item in "${check_vec[@]}"; do
+		eval "local $item"
+		echo "$memberships" | grep -q "\b$group\b"
+		check_err_fail $fail $? "$group is_ex reported in IGMP query response"
+	done
+}
+
+test_change_mc_remote()
+{
+	check_command netstat || return
+
+	ip_link_add v1 up type veth peer name v2
+	ip_link_set_up v2
+
+	RET=0
+
+	ip_link_add vx up type vxlan dstport 4789 \
+		local 192.0.2.1 $(fmt_remote 224.1.1.1) dev v1 vni 1000
+
+	check_membership "group=224.1.1.1 fail=0" \
+			 "group=224.1.1.2 fail=1" \
+			 "group=224.1.1.3 fail=1"
+
+	log_test "MC group report after VXLAN creation"
+
+	RET=0
+
+	change_remote 224.1.1.2
+	check_membership "group=224.1.1.1 fail=1" \
+			 "group=224.1.1.2 fail=0" \
+			 "group=224.1.1.3 fail=1"
+
+	log_test "MC group report after changing VXLAN remote MC->MC"
+
+	RET=0
+
+	change_remote 192.0.2.2
+	check_membership "group=224.1.1.1 fail=1" \
+			 "group=224.1.1.2 fail=1" \
+			 "group=224.1.1.3 fail=1"
+
+	log_test "MC group report after changing VXLAN remote MC->UC"
+}
+
 trap defer_scopes_cleanup EXIT
 
 tests_run
-- 
2.47.0


