Return-Path: <linux-kselftest+bounces-5491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0718869D20
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 18:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB4A283F8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Feb 2024 17:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDEC48CFD;
	Tue, 27 Feb 2024 17:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FNVvmOpK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85094B5C1;
	Tue, 27 Feb 2024 17:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053516; cv=fail; b=XM+lip6AxS86M1+h5eCfQ1M6F+uMzNyTp5hutL1/vH+1VXThIvDG4OomNmhMXOMa28lYxQYWDJy8H2RWmi8CaJJEqWSgtHu0mdkO4ayYMl00x29bbHk655aDm4a78pK2VsF7QG1++6EAjTjmGVXMErgPii/fZYqWR8gAs++YS+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053516; c=relaxed/simple;
	bh=Kjk5XM6qXcZf8Vm3tlTp3z0S6tlYqOLOwMBRKsIu/sw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/M1kiqpubjldGHw1vQn6RzC7B7Res5ZTP35vW2fKDDq21FjYASlPdbFeDFn9K8k8C0YUSRWcMVYriTolkZZV14H74pk8Zi7IcZg9AeMWuKf8aFw5XFNXzfAF++pabfosmOiBZ7GBdK+W5wMkEgCpUHMGZEIp980s83Q5Gn6Mm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FNVvmOpK; arc=fail smtp.client-ip=40.107.244.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDF3T7H+xzMrPFRX3YZ/UciiHD2PvRV8siTvL8ac58TQazTMthjQtOHoD0Z5XJwMYtrlWJumZ9InfncaxhwnZSiHXm3DvovRH9UBZn/APFd5tlcAjNMNq3O4Dld44OBPOPnr/isD2j6gcmjCUr+JuB9efuuC303VEFOBWGkltIQrPlrS5pTzHbFrudrJKbPAe7UhCfLokvxyxLUNGSLCdVfdvCOz93X+gI0UZWlNrxizvDL/tCz8EOuN8hLDT9UkNLEGILl7yH3NBHT13CEvd+mDDP+EoI0yH1X6fBhsUBmex1DdbyB8Zzb4oar2od5jA1zwHhYKscYgzkf7wFCzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDXYwIThW91mZXiMv8KT3L8lprQjH+VwGO/ZxccKEj0=;
 b=cZMQYkOiPLAl2RopdhFr28UPUyFFdKRiKKOoKNpdcGwV/a516FqfiTo81daQt87WHbul9TxNh4KdLXc6aQMRSWpHB4AQfvlMd3cvQc/qyhcIPSfx7FhjkqSP6zHN+Xz0BztLRF9IDiy5t1GHDxaalIjjRKspbIxcO5A1SQDY+q1f6KcWrJy30dHwTCJniMtMysF0YSedQRcpSP+PofqYTH2TbIjcQV9gKrtYEU2LrZArJIUFt7MULCXpYJA2hkFTIDdFq5sHJqmLsRVFYrFWiL6PX2DB6n72LjGBySXihfq+tpv5SEjrT0TmNgngMpuRZgS6L9HrtizckOT+7oV/1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDXYwIThW91mZXiMv8KT3L8lprQjH+VwGO/ZxccKEj0=;
 b=FNVvmOpKPKtLK9YJ49ViT4XMYzIE+633q4CGRpzIuY7Pp0DlzowSOI4ScadOvGgu6XQ9qNvCn5Lgy2UVMCrZOX5DO97mw98+1GKje+Uci+v2tWkYvOUZKJpFio8HEUswsKNioIHGiCDDiElaJI6U04QMPfXg+MCH9nIZ2ATsdw7/6jiulDPJFMWA6OurBvYIGn+tlMhr7VSxgJf9Xjjo7sufgOFe5L5J4oc41NA571YHKLjt1jPNzGSk9R4hBjlt0B706WACxK8KveEShIhcs8I9PMU75VvGM8HbxzE/OmrstzYZkw18oCD0J0BvEBBgwotxOVAt3BJG+pSnKikbAQ==
Received: from CY5PR15CA0236.namprd15.prod.outlook.com (2603:10b6:930:66::8)
 by PH7PR12MB6467.namprd12.prod.outlook.com (2603:10b6:510:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 17:05:11 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::9d) by CY5PR15CA0236.outlook.office365.com
 (2603:10b6:930:66::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 17:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 17:05:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 09:04:52 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 27 Feb 2024 09:04:49 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <shuah@kernel.org>, <yujie.liu@intel.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next] selftests: vxlan_mdb: Avoid duplicate test names
Date: Tue, 27 Feb 2024 19:04:18 +0200
Message-ID: <20240227170418.491442-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB6467:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d14507-882d-4bf3-9482-08dc37b641db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LxGFZPKc5lB2wqHZMWnyImMEPBAQ2j4I+iBPhVNZQmRp5IJhW9P8qw6U/bdbRYOxNzaR8yX1mtqdM0qfpaE/GsgPvp8Vj8PkzdbxX3DE5JktWMvSmaya4FnlqNldq78XMmqrL9VjNmCjAQ96/+3Wrbb+ReXGKkcY99gV7Ob60XKuKnuuzZIzBfh9S1q01PcTBOqOqAkuSgSCkNqtowdQ7ExrUt1ukZDnu64r9942L+3bh32tHYosIv5TS/L46ksKSJydLZiI0kriD8juv1OclLp6FMNA2EuN0lq+W0bUAaBGFSsF6Ofgcu6akAsup4NuRTAmLWWH7l2FQVNPG/wW1qwhBq9FIycZ6lKYWK2RwPt+NO8S80Twc5IZcmQvE50hzw4szmy7zQhsLwwb5qpQbI520FF1OqHPcZ+hqIylf0ENiO72NOcF9tcYr5p+osK9YyO/hicy4tGWGTNqF285wYeLiZ/i6Yi5/ZRyfOxdoKUOjDLxGPShahH+AbdO76yM6oP3w1EgWtm0tLEwvRl5FZqWKZijoaARU/7zEpEQolhkVeo6+zBnRIyI5ADvscabQ5unSVKrBjVm7bFhAz7LjMS4/8/vd1bpvQz+LTM5bz4Bekfgk9I6CYeXAL1zFI16ExlsciaO/YuYhI7SZCkDWeUfCnHD9L10YAO6Vh5kWSLqU7LjUkVgDckxEJkafk564M7u6Y2jEXus0hG0HJ2E07WmWYZR39lXWHhbH/5lNi0GOQsSEk2TmZRQX5Ct8J7W
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 17:05:10.6846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d14507-882d-4bf3-9482-08dc37b641db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6467

Rename some test cases to avoid overlapping test names which is
problematic for the kernel test robot. No changes in the test's logic.

Suggested-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
Yujie Liu, please verify this works for you.
---
 tools/testing/selftests/net/test_vxlan_mdb.sh | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_mdb.sh b/tools/testing/selftests/net/test_vxlan_mdb.sh
index 84a05a9e46d8..74ff9fb2a6f0 100755
--- a/tools/testing/selftests/net/test_vxlan_mdb.sh
+++ b/tools/testing/selftests/net/test_vxlan_mdb.sh
@@ -1014,10 +1014,10 @@ flush()
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 port vx0"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010"
-	log_test $? 254 "Flush by port"
+	log_test $? 254 "Flush by port - matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 port veth0"
-	log_test $? 255 "Flush by wrong port"
+	log_test $? 255 "Flush by port - non-matching"
 
 	# Check that when flushing by source VNI only entries programmed with
 	# the specified source VNI are flushed and the rest are not.
@@ -1030,9 +1030,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 src_vni 10010"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010"
-	log_test $? 254 "Flush by specified source VNI"
+	log_test $? 254 "Flush by source VNI - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10011"
-	log_test $? 0 "Flush by unspecified source VNI"
+	log_test $? 0 "Flush by source VNI - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1058,9 +1058,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 proto bgp"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"proto bgp\""
-	log_test $? 1 "Flush by specified routing protocol"
+	log_test $? 1 "Flush by routing protocol - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"proto zebra\""
-	log_test $? 0 "Flush by unspecified routing protocol"
+	log_test $? 0 "Flush by routing protocol - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1075,9 +1075,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst 198.51.100.2"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
-	log_test $? 1 "Flush by specified destination IP - IPv4"
+	log_test $? 1 "Flush by IPv4 destination IP - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.1"
-	log_test $? 0 "Flush by unspecified destination IP - IPv4"
+	log_test $? 0 "Flush by IPv4 destination IP - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1089,9 +1089,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst 2001:db8:1000::2"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 2001:db8:1000::2"
-	log_test $? 1 "Flush by specified destination IP - IPv6"
+	log_test $? 1 "Flush by IPv6 destination IP - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 2001:db8:1000::1"
-	log_test $? 0 "Flush by unspecified destination IP - IPv6"
+	log_test $? 0 "Flush by IPv6 destination IP - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1104,9 +1104,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst_port 11111"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"dst_port 11111\""
-	log_test $? 1 "Flush by specified UDP destination port"
+	log_test $? 1 "Flush by UDP destination port - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \"dst_port 22222\""
-	log_test $? 0 "Flush by unspecified UDP destination port"
+	log_test $? 0 "Flush by UDP destination port - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1121,9 +1121,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 dst_port 4789"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.1"
-	log_test $? 1 "Flush by device's UDP destination port"
+	log_test $? 1 "Flush by device's UDP destination port - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
-	log_test $? 0 "Flush by unspecified UDP destination port"
+	log_test $? 0 "Flush by device's UDP destination port - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1136,9 +1136,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 vni 20010"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \" vni 20010\""
-	log_test $? 1 "Flush by specified destination VNI"
+	log_test $? 1 "Flush by destination VNI - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep \" vni 20011\""
-	log_test $? 0 "Flush by unspecified destination VNI"
+	log_test $? 0 "Flush by destination VNI - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
@@ -1153,9 +1153,9 @@ flush()
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0 vni 10010"
 
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.1"
-	log_test $? 1 "Flush by destination VNI equal to source VNI"
+	log_test $? 1 "Flush by destination VNI equal to source VNI - matching"
 	run_cmd "bridge -n $ns1_v4 -d -s mdb get dev vx0 grp 239.1.1.1 src_vni 10010 | grep 198.51.100.2"
-	log_test $? 0 "Flush by unspecified destination VNI"
+	log_test $? 0 "Flush by destination VNI equal to source VNI - non-matching"
 
 	run_cmd "bridge -n $ns1_v4 mdb flush dev vx0"
 
-- 
2.43.0


