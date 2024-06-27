Return-Path: <linux-kselftest+bounces-12860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B2591A9CD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07462825C5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE20197A76;
	Thu, 27 Jun 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B1DbU8VJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314D91514EE;
	Thu, 27 Jun 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499817; cv=fail; b=V7KZN9ou5LIAjLPg/c4POaTM+E9uA0Xt7Jo6ReN3BCjUH+Z7TXtnx3C2w9DLAQU07g0FvGwaP0s9GJkwis+xefD+5TBzTlHEB4alFK3FJs+VELWPsUYm68f1F2oGXekVmRRKiL8J2NP7G1AYp2bnRRaCWHUZqp9Cfip+4kk1UDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499817; c=relaxed/simple;
	bh=1ER9F8Nc6O25JXIqbiwPmmMnw5hG2w9Xbs+Pn9AbN1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/EojjRNnfO9sV01ujvoHwG221MKXd9YUA++xraSQxRSVYp7l+P5FuO55jQRVWuznvT3arUrwGZzAqoIuuWstLmzpDxCGMMFlqehhiBTwuxTkzbMa7onAwNPI20AwcOU9eefFrHO6jIFxvQ7icy0grMunagYxk6EAJwJGB1aN8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B1DbU8VJ; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtNze17arHjcSXD4yCyCH1BYqZy0f+WXPsf+LcEQSpAUOgw0k9GWxSElOqM1jH7LyHfmFt+WSt9fU0hAS79yNtJnh4Iar76Iq/pwVtvtBXa07KcVfZmUgCAWpQvVXLt/xTvr3naxlMrsxC+8hIs1yabUrBY/3Ey3WbQblVscIX9uuJCEaUwcVVN3tJAUSF7O4kOetKDCQAapj4pCcKuOENTnng2qs+iOs9xjddtripbRCuTrQHYBdfptjb830ePTzHlCpcVfz2dC25udtkb/CWKH91RSMA6P74YeBJRWLOqo9sMEM2XkRO5JKnrXKQCnN3wwFWtcGwa0EV2cpLfcgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hDTKGw+NIaZglVPeNcnnWDO83EzK1dFhVkge87ZpHQ=;
 b=WeZrlHELMUNrfaVERcQMWBUpGk6GDZzoVGa5x2pgMcvfZ3KmJTyZo7auGiWEzGP+a3T8kPo3sJ/PnqGeMNMSs0EdnL4tMneHvr897Z5IV87LYKp4E4E6pbLKRJwGoPTsyBvtyf33kRE0rBAYW5SeDjh8GZfQ9Cd87BLuoUNXGxRCfKCxxsNHeyYLWwmFqbZqM/nDeuMXQdXprWuLKH7yeBHrARn82WYhvFf/MJfrx/VkhXxCP1SD3K74ZjqdnA/q6nqH/q6zal4rrXevVqKasBOUvFro6k4RipK0/xruUqwkgPwVc+4OPMoCmL2zn2RwucjC2Z3iK23JH/E8xOcD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hDTKGw+NIaZglVPeNcnnWDO83EzK1dFhVkge87ZpHQ=;
 b=B1DbU8VJbHoiDyLN2CZ/nUuXL4NvTuhhP2XVKWpRF0ON8LUAiy1EOMFQC26lDMRPzHEEL/iV+Pvfjrlhfb9Sn+yNx86GiKgPGd4V3lK3wK07NYuYPzw4kiAni4F8vWfoRljGnBKzC9rKOhljGoCt7CZZYIGUc3hCkMpkH/UUOntBNrbOu08hVeBWudp+V1dnEdBLeZtFDyPL9TFg3IVwhnrdGklJ+XXK2YfkAXKJXwTe/EeijHJ7fis49UE+Tf3uCPQ8WODC3+MWZkglDwHZstuVjjDNaRHmpEiOT861yEKAUJNSSS8rOwziHYZWEmxGAinWJoSwMxMID3h6yEl3oA==
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by LV2PR12MB5991.namprd12.prod.outlook.com (2603:10b6:408:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Thu, 27 Jun
 2024 14:50:05 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:114:cafe::eb) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.8 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:54 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/12] selftests: mirror: do_test_span_dir_ips(): Install accurate taps
Date: Thu, 27 Jun 2024 16:48:42 +0200
Message-ID: <c66248f2825a2669898534b0034da85ea4f94e5a.1719497773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
References: <cover.1719497773.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|LV2PR12MB5991:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7c1fec-cfb0-4576-7bce-08dc96b86e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6+rYVa5x8YtUx+z3VQtyb2A2CQV62SirzKPkUW8mExts/Nuo8iYTbpQuY+nk?=
 =?us-ascii?Q?LeVDNRm9ecqwaWmiHF/wQY3UK/adkTbjtdnlkps71ClbMqrwB21NV9DVSg8G?=
 =?us-ascii?Q?VHwEa6xPB+mLvpxi/vmTuhmAyB6FIhAH1p5V97bXyvQcfv888oOUb3f87xa0?=
 =?us-ascii?Q?zibf1PbRcLc/50f+uIP/FegvuE1utqepsbpfjtirXu0K7gNYMDF8GTzd6Pfy?=
 =?us-ascii?Q?IvJ4rL3B1tMiCoXTTMIxGH0/yyG5kq5Mk+rmVleHfNfxkqrstize3lB1+3il?=
 =?us-ascii?Q?jJD+uGhLW4fBBOUOrlNDe3ohO97JyXSFuxFYRdivXBt/nFfivv2p2ZEwXf8e?=
 =?us-ascii?Q?eY/Bq8su44kIEVABWBTpUfFc901YyIP5C7dIy4cEmvew3c/zzW8i0K6T40qr?=
 =?us-ascii?Q?ibmMDAixZZT/hG5XDJSN444hcyT/1bUhX7vhc9mH4kK4mVWfa50OGW0xG03P?=
 =?us-ascii?Q?gFparceNut4HE6YlcvqUEKea/bhIoN6n0FomG6iswPAau141aW9f6lZS46tJ?=
 =?us-ascii?Q?Cs3vRopE2wTIf6aNCMfn+7q2y0Y7yOagS5Zom3miz9/6YNJ8f40/mKrMGXiO?=
 =?us-ascii?Q?WXXR3gR88Nm0sXx9aU0iNUfZdr3A+EUj3YuYvvqIRwImSnrJfMCm5mW/3cDW?=
 =?us-ascii?Q?xPYSXv1OkYAlcDVIiiBz6kLuE6THbkzgYgsBqoqikCUXtT/wyIdG/b7xp3Ky?=
 =?us-ascii?Q?NYGc1ly9gveitmIQGWyFw2jR6idTJiEAOeOG8YiEXnyqoOioUpKLFjeLkJtR?=
 =?us-ascii?Q?CMO4gb3v5CrBtYlZ7HKLD/4HvGuknnDf9iCjYF8VANDg0siEhcz5a+KY0fm3?=
 =?us-ascii?Q?wGKQns6JZAmDzZ34LHSUBL+t1UHv41PgyNP9fMVhgl/QdRVlSmQi6kzcS/0r?=
 =?us-ascii?Q?76Ghg8iHLZ8BG+pmS2SzvE+H4gSNVRFyJin4I4lLxOCoEfIqP3JVAGl+Ocr9?=
 =?us-ascii?Q?GT38dF4LDNZVfZwzplfpB06LHqDfjZ/cFAFY1KvgRvYh7Jc/RKdHzRxUQmzD?=
 =?us-ascii?Q?atm+kOkDFDAOpZrNGvLZWkru45mDpDTdMga3sRjgxVjphkyhunH5UB32l633?=
 =?us-ascii?Q?LJWWVZlrmo7cqlIX5j3REoDidXhSgcRfBRZ9R9QXqlPv8hz1KOAECp/rVYNl?=
 =?us-ascii?Q?9ttrclv3zmWUjkSdPy7VkEe99cAIPE268DtRX8j6cYhDD2Xzx+4tQ4Mn5nfG?=
 =?us-ascii?Q?tIBfLiWns+WabDUd0aPXfEt95gvoCZNl9cM5OgSm22IE1dnS5lqAnoG0Em8X?=
 =?us-ascii?Q?v2xbgF/BI9CzIp74FEob7BfNfbaWIMzL0iSVdizJ6o5GSI6u1lB29hCuSCbU?=
 =?us-ascii?Q?BKkC5qVJCLWwBVq1JfCazUAlpcp5TE790g2oR519ZcRiKE7TX7C77oV8Psrw?=
 =?us-ascii?Q?e5K90xEoPP1/yojzsFxBb8oz5nLkPH0f+4PvpCF7/l28LLBqUEw31lsj4+8h?=
 =?us-ascii?Q?Ky4kqNCIrKYrRCuxZv+VzJ9qOJMR7bJA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:04.6431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7c1fec-cfb0-4576-7bce-08dc96b86e30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5991

The mirroring selftests work by sending ICMP traffic between two hosts.
Along the way, this traffic is mirrored to a gretap netdevice, and counter
taps are then installed strategically along the path of the mirrored
traffic to verify the mirroring took place.

The problem with this is that besides mirroring the primary traffic, any
other service traffic is mirrored as well. At the same time, because the
tests need to work in HW-offloaded scenarios, the ability of the device to
do arbitrary packet inspection should not be taken for granted. Most tests
therefore simply use matchall, one uses flower to match on IP address.

As a result, the selftests are noisy, because besides the primary ICMP
traffic, any amount of other service traffic is mirrored as well.

However, often the counter tap is installed at the remote end of the gretap
tunnel. Since this is a SW-datapath scenario anyway, we can make the filter
arbitrarily accurate.

Thus in this patch, add parameters forward_type and backward_type to
several mirroring test helpers, as some other helpers already have. Then
change do_test_span_dir_ips() to instead of installing one generic tap and
using it for test in both directions, install the tap for each direction
separately, matching on the ICMP type given by these parameters.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/net/forwarding/mirror_gre.sh    | 12 +++++-----
 .../net/forwarding/mirror_gre_lib.sh          | 23 +++++++++++++++----
 .../net/forwarding/mirror_gre_neigh.sh        | 14 ++++++-----
 .../selftests/net/forwarding/mirror_lib.sh    | 15 +++++++++---
 4 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre.sh b/tools/testing/selftests/net/forwarding/mirror_gre.sh
index 00def4b04145..b645cb8d696a 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre.sh
@@ -91,17 +91,17 @@ test_two_spans()
 
 	mirror_install $swp1 ingress gt4 "matchall $tcflags"
 	mirror_install $swp1 egress gt6 "matchall $tcflags"
-	quick_test_span_gre_dir gt4
-	quick_test_span_gre_dir gt6
+	quick_test_span_gre_dir gt4 8 0
+	quick_test_span_gre_dir gt6 0 8
 
 	mirror_uninstall $swp1 ingress
-	fail_test_span_gre_dir gt4
-	quick_test_span_gre_dir gt6
+	fail_test_span_gre_dir gt4 8 0
+	quick_test_span_gre_dir gt6 0 8
 
 	mirror_install $swp1 ingress gt4 "matchall $tcflags"
 	mirror_uninstall $swp1 egress
-	quick_test_span_gre_dir gt4
-	fail_test_span_gre_dir gt6
+	quick_test_span_gre_dir gt4 8 0
+	fail_test_span_gre_dir gt6 0 8
 
 	mirror_uninstall $swp1 ingress
 	log_test "two simultaneously configured mirrors ($tcflags)"
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index 2bed2a4013aa..e49535ce1cdd 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -7,8 +7,11 @@ quick_test_span_gre_dir_ips()
 	local tundev=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
 
-	do_test_span_dir_ips 10 h3-$tundev "$ip1" "$ip2"
+	do_test_span_dir_ips 10 h3-$tundev "$ip1" "$ip2" \
+			     "$forward_type" "$backward_type"
 }
 
 fail_test_span_gre_dir_ips()
@@ -84,8 +87,11 @@ full_test_span_gre_dir_vlan_ips()
 quick_test_span_gre_dir()
 {
 	local tundev=$1; shift
+	local forward_type=${1-8}; shift
+	local backward_type=${1-0}; shift
 
-	quick_test_span_gre_dir_ips "$tundev" 192.0.2.1 192.0.2.2
+	quick_test_span_gre_dir_ips "$tundev" 192.0.2.1 192.0.2.2 \
+				    "$forward_type" "$backward_type"
 }
 
 fail_test_span_gre_dir()
@@ -139,12 +145,15 @@ full_test_span_gre_stp_ips()
 	local what=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
 	local h3mac=$(mac_get $h3)
 
 	RET=0
 
 	mirror_install $swp1 ingress $tundev "matchall $tcflags"
-	quick_test_span_gre_dir_ips $tundev $ip1 $ip2
+	quick_test_span_gre_dir_ips $tundev $ip1 $ip2 \
+				    "$forward_type" "$backward_type"
 
 	bridge link set dev $nbpdev state disabled
 	sleep 1
@@ -152,7 +161,8 @@ full_test_span_gre_stp_ips()
 
 	bridge link set dev $nbpdev state forwarding
 	sleep 1
-	quick_test_span_gre_dir_ips $tundev $ip1 $ip2
+	quick_test_span_gre_dir_ips $tundev $ip1 $ip2 \
+				    "$forward_type" "$backward_type"
 
 	mirror_uninstall $swp1 ingress
 
@@ -164,7 +174,10 @@ full_test_span_gre_stp()
 	local tundev=$1; shift
 	local nbpdev=$1; shift
 	local what=$1; shift
+	local forward_type=${1-8}; shift
+	local backward_type=${1-0}; shift
 
 	full_test_span_gre_stp_ips "$tundev" "$nbpdev" "$what" \
-				   192.0.2.1 192.0.2.2
+				   192.0.2.1 192.0.2.2 \
+				   "$forward_type" "$backward_type"
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh b/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
index 0f2c38eca2a3..0615f9244406 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
@@ -60,15 +60,17 @@ test_span_gre_neigh()
 	local addr=$1; shift
 	local tundev=$1; shift
 	local direction=$1; shift
+	local forward_type=$1; shift
+	local backward_type=$1; shift
 	local what=$1; shift
 
 	RET=0
 
 	ip neigh replace dev $swp3 $addr lladdr 00:11:22:33:44:55
 	mirror_install $swp1 $direction $tundev "matchall $tcflags"
-	fail_test_span_gre_dir $tundev
+	fail_test_span_gre_dir $tundev "$forward_type" "$backward_type"
 	ip neigh del dev $swp3 $addr
-	quick_test_span_gre_dir $tundev
+	quick_test_span_gre_dir $tundev "$forward_type" "$backward_type"
 	mirror_uninstall $swp1 $direction
 
 	log_test "$direction $what: neighbor change ($tcflags)"
@@ -76,14 +78,14 @@ test_span_gre_neigh()
 
 test_gretap()
 {
-	test_span_gre_neigh 192.0.2.130 gt4 ingress "mirror to gretap"
-	test_span_gre_neigh 192.0.2.130 gt4 egress "mirror to gretap"
+	test_span_gre_neigh 192.0.2.130 gt4 ingress 8 0 "mirror to gretap"
+	test_span_gre_neigh 192.0.2.130 gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
-	test_span_gre_neigh 2001:db8:2::2 gt6 ingress "mirror to ip6gretap"
-	test_span_gre_neigh 2001:db8:2::2 gt6 egress "mirror to ip6gretap"
+	test_span_gre_neigh 2001:db8:2::2 gt6 ingress 8 0 "mirror to ip6gretap"
+	test_span_gre_neigh 2001:db8:2::2 gt6 egress 0 8 "mirror to ip6gretap"
 }
 
 test_all()
diff --git a/tools/testing/selftests/net/forwarding/mirror_lib.sh b/tools/testing/selftests/net/forwarding/mirror_lib.sh
index ee0fd71ad2fd..6a0c66d7ba7f 100644
--- a/tools/testing/selftests/net/forwarding/mirror_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_lib.sh
@@ -61,9 +61,14 @@ do_test_span_dir_ips()
 	local dev=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
+	local forward_type=${1-8}; shift
+	local backward_type=${1-0}; shift
 
-	icmp_capture_install $dev
+	icmp_capture_install $dev "type $forward_type"
 	mirror_test v$h1 $ip1 $ip2 $dev 100 $expect
+	icmp_capture_uninstall $dev
+
+	icmp_capture_install $dev "type $backward_type"
 	mirror_test v$h2 $ip2 $ip1 $dev 100 $expect
 	icmp_capture_uninstall $dev
 }
@@ -73,8 +78,11 @@ quick_test_span_dir_ips()
 	local dev=$1; shift
 	local ip1=$1; shift
 	local ip2=$1; shift
+	local forward_type=${1-8}; shift
+	local backward_type=${1-0}; shift
 
-	do_test_span_dir_ips 10 "$dev" "$ip1" "$ip2"
+	do_test_span_dir_ips 10 "$dev" "$ip1" "$ip2" \
+			     "$forward_type" "$backward_type"
 }
 
 fail_test_span_dir_ips()
@@ -95,7 +103,8 @@ test_span_dir_ips()
 	local ip1=$1; shift
 	local ip2=$1; shift
 
-	quick_test_span_dir_ips "$dev" "$ip1" "$ip2"
+	quick_test_span_dir_ips "$dev" "$ip1" "$ip2" \
+				"$forward_type" "$backward_type"
 
 	icmp_capture_install $dev "type $forward_type"
 	mirror_test v$h1 $ip1 $ip2 $dev 100 10
-- 
2.45.0


