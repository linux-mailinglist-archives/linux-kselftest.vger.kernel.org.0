Return-Path: <linux-kselftest+bounces-43885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8764C01E87
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809143A7AE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDE433030C;
	Thu, 23 Oct 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EOVWheoo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FC318136;
	Thu, 23 Oct 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230841; cv=fail; b=NOeiLCTwrMWOw6vrcU29HWQF8vu8zpzYdTD1bCIZ+3gvKQnA/dV4uakNonhf1tO76Kju84VZw5auNVLSuKehSGiY6nt8N1J8temYTufBocnflZiDH6CbLSrBOoouM6xdWVvQAKe3HwueZunoiKTvzdr1Ep3zkt9yoCnlAdT6wAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230841; c=relaxed/simple;
	bh=Q46LWJB7pQ+ZoBLsb6KlyjXwTgf+AJpiazl5aLz8xMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDBSjQbCQ+qtUvGXPKALjDGh1KYT6g5u9A6Qppod8HBrkfvKqyekW7hXT2kPIFuYKzdtQVB3j5VL8IQDlkrv/jEtQi+JIJSRBq5plJV8dUMEPAqbr+v4QUvojgT3XmCHw3DM/n/mXwLPCPPwprbGBHfmbteyrbQX5nhCKa7f+RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EOVWheoo; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru1cNa8jyldOMSohrrkHy1b0+zC2TRP8kMKsjWVGWdx0YvqvfSSiCo5QdVBXmoGCUWkGsx9jD9nVuxPBnazWtu7ZuhUYAL+879kbInSK03YjuJIgaqWjDaS+ahFMXmt556SV4LTAES4gw4pp7olVcLiJOZLUkGJKr2631hSFupL71CIIvYsoLlM3CYJ9PHtNhMJWplAU0zqaGPYJ1Ircw27ZFdLr5TU+I1l6hP8AMQqOLfxAYCLRFYpgoex2XYex4j9uMVGOlRLnsDaTsND7BV4y9nT0UFEy39G3tdq8DCxfCaYGFiyVLHsBCoCr8weqTwsyuL6tnMvONHYvQ+JJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAln3LAW5lLTHwBF9kSsGEHmUS/RQvaY2PTpHo0CRPg=;
 b=CVDjfFWlEGZeKKTOlnkpF0QRZR8PBBul/neYnOzdqn0GLOvKMIYZ96efrg0q3NRe3+fhtXN3Yy5gwYSZH996gLpCCpDrlUxxhzhNwvuwKU8PNDYqVxLcn+bS4XCihUqQDAbdSZuV0s94edptsxbKUYSbe9hTnh5CWEj9xAtBZt8f5a/85gSfw2IR0+1SrlkHq/cAuMdZyvyxWBV3qcjHVPEgM0/UC0uhUh9t7DMB+QCfOs6YIm7sWcTyuhQ6QRUV3v7yLA2fFQXyC6LSyfn0jJMspjKdsJnOWzo9ybaobrHMRgb0kXzg3YAq2g2ylc4j65SsXB1bav+WoDppOneszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAln3LAW5lLTHwBF9kSsGEHmUS/RQvaY2PTpHo0CRPg=;
 b=EOVWheooDt4n346k7uyPPkNkHqQXpqkZaXYUXzMSP+o0cCLrH8o14lkevM7z+65SmsdvasJ5DoeawWIBVC/YcwXsNY4/ncOREpWyN4PTrAuG+H2pNQarKpY5gW2LrBw+DZSeN8ReCdcF2i77+ba7qg2effzzHO7Nxyb/LncJWQFQUnr906V9C5rCVCRnY6PVQa5Vg9taR5yFYMTuiTboiEBfp/TsnpCP47ZrtPIW/rKGcjuejRJfd7c1LlJJcXY773ScDBv7+GIA2vK6gmhX0yvskeIe/ob9ZDyDRVwh9nBVilLcuQ1/LBi3aVKS9bDA9cQxrn1z56Z3lvzKWQX5Mw==
Received: from BYAPR07CA0066.namprd07.prod.outlook.com (2603:10b6:a03:60::43)
 by DM4PR12MB7741.namprd12.prod.outlook.com (2603:10b6:8:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 14:47:15 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:60:cafe::6a) by BYAPR07CA0066.outlook.office365.com
 (2603:10b6:a03:60::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 14:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 14:47:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 23 Oct
 2025 07:47:02 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 07:46:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 2/2] selftests: bridge_mdb: Add a test for MDB flush on snooping disable
Date: Thu, 23 Oct 2025 16:45:38 +0200
Message-ID: <9420dfbcf26c8e1134d31244e9e7d6a49d677a69.1761228273.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
References: <5e992df1bb93b88e19c0ea5819e23b669e3dde5d.1761228273.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM4PR12MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 0985a30c-e4a0-4eb6-4d2e-08de12430ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?viqM8Oi+RALw8w41ARB52i6cCLS2bviwtaxjyPGWQtkzI7o7pSUWhT+zDOst?=
 =?us-ascii?Q?4chIMLVgZnsrfnyN4X+i2flIyV0IYD83Tc8kUwPxpeKxlN5VgkflzSFnYO6T?=
 =?us-ascii?Q?1GIhRFfXD0jI2KcMmp0bRg91Aj/uCudDaWXtRTEWWWdLVQCClqPIuoyucpSk?=
 =?us-ascii?Q?Sm8DN9Dbg/ikBwdJGwHwdlRjWSbIxyM28fmCvRfZ9DigfpLhnf3WIwhBt4E/?=
 =?us-ascii?Q?c2tMCn9Xr3tkucS1k10hqKc7LA229c90Y6RoKujMvx5jt5UQE9HrOXM1nZwQ?=
 =?us-ascii?Q?3jW376dKGWomC0eUx6Ah91XuJWCYMRs21vl1NBGXexnm4S3v0WTG1jtxqGNN?=
 =?us-ascii?Q?cojLT9ZKK7GesbfS2lW0Oq2HUSVVD9eokyWFzcU5fN9JhzH+FSw2tvs5sZOa?=
 =?us-ascii?Q?c/+IgBeAwwb4NGsZwRqwhbiHSxgZaNQ3Pf9SaLgTALFNo8Sj8KQ8dIApuC5C?=
 =?us-ascii?Q?hszw2NilCs5MZkVsQgc0ZfO2GF4hPl3bn3lRaCF5p9SAhOMCsHIitozxlp9U?=
 =?us-ascii?Q?0eUpWquf3zZcYyu9mbthvW0NdUbTWXb+LGGfyxmjkWDsRP9UZoKbRTzxKYlV?=
 =?us-ascii?Q?02V3cJrgyX3Cl0YSJ1R4DogGZYJ0nz9hSPd7q4cRcY482H0Q+d41FoEj4Fqt?=
 =?us-ascii?Q?gcVokUgfi6eTDenpJA9P3QXhjIz+qMpr1KArL6Oe0CtoDJosa/Rr/Cp1CTXt?=
 =?us-ascii?Q?+DPL9AUWg6ocAqoDRtIx8WawLhXVQIY4Jh+ISaioTXh2bSaC5ihWAPfk2KDh?=
 =?us-ascii?Q?yzEP+0vZLFnYD1K8h+L8e/aD0CczXeNGFaPejOnMrJC9lrpl3+IfR9aC/vL5?=
 =?us-ascii?Q?+H9UCAjRha3+CjAHNH2m+ltzGm0On+pSyIvi4cPMrJdzpx47BcxmSiTnNQeC?=
 =?us-ascii?Q?t1icA4HlhQ1lKppVlvqS+5sQ27296Tpz6ZXDxMW45z4mzk6l4zutVerNfHYA?=
 =?us-ascii?Q?ewBJC07k0K8CuP9GgM5Heghyxwz1olHDW023l0u/PGzRJnmAnDJ4uJyedsCi?=
 =?us-ascii?Q?XlFwN/5aqbZoNnNnwIQGBxhPfqx2LAzLTNF3x3NedcFxBU39Kvue1m+qzsWP?=
 =?us-ascii?Q?6iUR318mgPMSvym+Gm3nNkBRjtiMTuyvz3uyx4aQTwqRKoW0nuiNMhejkgdc?=
 =?us-ascii?Q?YJoZWuu1SekAAMHLuXcLlLCIIjX4X40ms6ZSCZCm/tv0c/4M5ksIM0oF7YCB?=
 =?us-ascii?Q?NBnB6RvJNfWfUsQ2UOAagejujqmLohz6YBQcSk6rSfy052njay6PL82Q6PKT?=
 =?us-ascii?Q?oGBwLeLdRROCpf6xjNP5wH04OKJ9DvT1oIVRWQ4MoNA7XwhxXYXqR98QUQC0?=
 =?us-ascii?Q?JzB2+tUQtggkk1FxUDs0G1fZtFS/kq/EkAplw+7O0p1KSTieOECbb72G01Qs?=
 =?us-ascii?Q?xxtmkXooRK0IHUbLKAiFRpb4v3wbB5AUvKftAFpHoqBenLOqS5mjJpSTq4AK?=
 =?us-ascii?Q?1vxYtqpve6Oi99HpJVBEZtTqXFvqyFz6VLLUZKY3cp9XiNuxwq7D8ChDp1in?=
 =?us-ascii?Q?nbnAWllvI6Vpk/EuvcHkLB3w6+hiYmwSO8Bgw792cqmLsuLWtTJetLl4CMhU?=
 =?us-ascii?Q?LY3Nqq9iRrd+ilEiEYA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 14:47:15.2828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0985a30c-e4a0-4eb6-4d2e-08de12430ec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7741

Check that non-permanent MDB entries are removed as IGMP / MLD snooping is
disabled.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: linux-kselftest@vger.kernel.org
CC: Shuah Khan <shuah@kernel.org>

 .../selftests/net/forwarding/bridge_mdb.sh    | 100 +++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb.sh b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
index 8c1597ebc2d3..e86d77946585 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -28,6 +28,7 @@ ALL_TESTS="
 	cfg_test
 	fwd_test
 	ctrl_test
+	disable_test
 "
 
 NUM_NETIFS=4
@@ -64,7 +65,10 @@ h2_destroy()
 
 switch_create()
 {
-	ip link add name br0 type bridge vlan_filtering 1 vlan_default_pvid 0 \
+	local vlan_filtering=$1; shift
+
+	ip link add name br0 type bridge \
+		vlan_filtering "$vlan_filtering" vlan_default_pvid 0 \
 		mcast_snooping 1 mcast_igmp_version 3 mcast_mld_version 2
 	bridge vlan add vid 10 dev br0 self
 	bridge vlan add vid 20 dev br0 self
@@ -118,7 +122,7 @@ setup_prepare()
 
 	h1_create
 	h2_create
-	switch_create
+	switch_create 1
 }
 
 cleanup()
@@ -1357,6 +1361,98 @@ ctrl_test()
 	ctrl_mldv2_is_in_test
 }
 
+check_group()
+{
+	local group=$1; shift
+	local vid=$1; shift
+	local should_fail=$1; shift
+	local when=$1; shift
+	local -a vidkws
+
+	if ((vid)); then
+		vidkws=(vid "$vid")
+	fi
+
+	bridge mdb get dev br0 grp "$group" "${vidkws[@]}" 2>/dev/null |
+		grep -q "port $swp1"
+	check_err_fail "$should_fail" $? "$group seen $when snooping disable:"
+}
+
+__disable_test()
+{
+	local vid=$1; shift
+	local what=$1; shift
+	local -a vidkws
+
+	if ((vid)); then
+		vidkws=(vid "$vid")
+	fi
+
+	RET=0
+
+	bridge mdb add dev br0 port "$swp1" grp ff0e::1 permanent \
+		"${vidkws[@]}" filter_mode include source_list 2001:db8:1::1
+	bridge mdb add dev br0 port "$swp1" grp ff0e::2 permanent \
+		"${vidkws[@]}" filter_mode exclude
+
+	bridge mdb add dev br0 port "$swp1" grp ff0e::3 \
+		"${vidkws[@]}" filter_mode include source_list 2001:db8:1::2
+	bridge mdb add dev br0 port "$swp1" grp ff0e::4 \
+		"${vidkws[@]}" filter_mode exclude
+
+	bridge mdb add dev br0 port "$swp1" grp 239.1.1.1 permanent \
+		"${vidkws[@]}" filter_mode include source_list 192.0.2.1
+	bridge mdb add dev br0 port "$swp1" grp 239.1.1.2 permanent \
+		"${vidkws[@]}" filter_mode exclude
+
+	bridge mdb add dev br0 port "$swp1" grp 239.1.1.3 \
+		"${vidkws[@]}" filter_mode include source_list 192.0.2.2
+	bridge mdb add dev br0 port "$swp1" grp 239.1.1.4 \
+		"${vidkws[@]}" filter_mode exclude
+
+	check_group ff0e::1 "$vid" 0 "before"
+	check_group ff0e::2 "$vid" 0 "before"
+	check_group ff0e::3 "$vid" 0 "before"
+	check_group ff0e::4 "$vid" 0 "before"
+
+	check_group 239.1.1.1 "$vid" 0 "before"
+	check_group 239.1.1.2 "$vid" 0 "before"
+	check_group 239.1.1.3 "$vid" 0 "before"
+	check_group 239.1.1.4 "$vid" 0 "before"
+
+	ip link set dev br0 type bridge mcast_snooping 0
+
+	check_group ff0e::1 "$vid" 0 "after"
+	check_group ff0e::2 "$vid" 0 "after"
+	check_group ff0e::3 "$vid" 1 "after"
+	check_group ff0e::4 "$vid" 1 "after"
+
+	check_group 239.1.1.1 "$vid" 0 "after"
+	check_group 239.1.1.2 "$vid" 0 "after"
+	check_group 239.1.1.3 "$vid" 1 "after"
+	check_group 239.1.1.4 "$vid" 1 "after"
+
+	log_test "$what: Flush after disable"
+
+	ip link set dev br0 type bridge mcast_snooping 1
+	sleep 10
+}
+
+disable_test()
+{
+	__disable_test 10 802.1q
+
+	switch_destroy
+	switch_create 0
+	setup_wait
+
+	__disable_test 0 802.1d
+
+	switch_destroy
+	switch_create 1
+	setup_wait
+}
+
 if ! bridge mdb help 2>&1 | grep -q "flush"; then
 	echo "SKIP: iproute2 too old, missing bridge mdb flush support"
 	exit $ksft_skip
-- 
2.49.0


