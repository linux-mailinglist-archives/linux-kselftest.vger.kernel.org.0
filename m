Return-Path: <linux-kselftest+bounces-42394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A871FBA0EA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255A617765B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0531329F;
	Thu, 25 Sep 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D0IkbGP/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2C3128C8;
	Thu, 25 Sep 2025 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821659; cv=fail; b=ZaO/ffX7RiXdy2A6AvUuQ/rGWpGWzwARwQxUUu3cGFryZrH3xGn3V9EsIR7wK3cYhdNPo0UFeKKbI2UafjClIyXeEt+hNxF9skaeg39nOQrW4gLTGY0j/ZZJP7KD+uagYPD12uW49aWwygh0PrqsSThIWxYyOH7lb8EzT6V0V6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821659; c=relaxed/simple;
	bh=8sgveMVHScujp1HG10M/PBRLj3gQr0K09du/45jrQmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4MQgkCJj+RR0fIlFzWP5Ref3WqHzgP/ibGTayqKDgo/mUyiDgPvWBjEilqkNHjO2BU2uph/QZHX5y0mqBnI1VPPGK83KOz2nHQE8vWeoQzdBEyCoL4sKXv8vm5u4siRJqmx13yfALUGiQ1gGLipGWdNtwy4RRO9BmFNlVNM/s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D0IkbGP/; arc=fail smtp.client-ip=40.107.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGeyXeVmMrWi6wOu/ScNrbOMHSbZkNdhveGrXlb+5awFVVafJ8wlxWRiciT3I1QMTIgccu/6IKZpeviBndkI8KtLMgnD+hQpyjojHKiaIeI3q8wRGofu/QYoPmglKkspFJQh+ZtIpBgBFwmZXG7r4TJZfO4QBciTjo/agEvdF0EDcskUXJicT4R+9tKqe3HQUU4CNEJGyHyxvzdV8r4292HhelaPV8bdKkAa8sMVaTyW7P2GQb4WTdRbDpea7DVh0DYj5NL86BrJHE9s2j0ckF/JIAhuAHoTIzNrc2PEhvRRWp3FVFE77Vsc+ol5Q86opB8cw6k4YpX8UX+YkVEbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/NBNG7rlhpB/Y/MrVXZNUvSNvurUNQvYEsbR9nlfFY=;
 b=V1/ri94UXfcTCTYNZR/D+KX+nYVCsvIPd/o5d79qtUc3T1rjnGmU/6zE2434vLFNrf5zvOcDHlvuHstxxBlCgdtj8AQbqxzR5N8ualwsvrs4bHm+NCiUWh+vy63LRQNQgklghPyc6tLlFhmGI4nJJH/X5fB5zV2Xca6fMfIQA+GR3wBcJF+kpvpC9jykFq7m9uHiB4Ih3JlbKrG6RrNURt2JW1oqsKa7iyl/J4Oi9rIg95TVGFlcnnU4Y51C9a9FV8qKKFrmuUQtmSZO3L+7owQmwLVrirquDQXo2KQmkiymZ2bvgSsGc7jTFoLOV5I7QwUKrCjgb0utKlesPHwEOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/NBNG7rlhpB/Y/MrVXZNUvSNvurUNQvYEsbR9nlfFY=;
 b=D0IkbGP/1SdOUVY2F9p5ih1MDiOIoyIT4gQVL6OxJMRnGEjr8idV7grhaxGtxp5xY1reaFtv6hoER5Sb4MfFKNVsi8cdpBghdcYUm2QmP3oR8buPan5Tm4FZb2XXlDXf4gYkBwnh1YCCea8NjYRMcwOpDZb69GeuDfcdzE/9NZNkbJcRsI/TTGGSgc10tja8zGq/LenA0aZyGExag+cltuJrAzTRhlPkloWZJwWWGQXikLOudzDpFRyJhBaJTL3EdwPcjmeUQfiZ8FqNzzyqXrgHHiwl7221+dj37oEnL1eBdeFSOrTVZ0VwRKWoS11X7V0YoFUKOVzHaDqzNT9sbw==
Received: from BLAPR03CA0152.namprd03.prod.outlook.com (2603:10b6:208:32f::16)
 by SA5PPF06C91DA0C.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:34:09 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::c8) by BLAPR03CA0152.outlook.office365.com
 (2603:10b6:208:32f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Thu,
 25 Sep 2025 17:34:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Thu, 25 Sep 2025 17:34:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:33:52 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 05/13] selftests: net: lib: Rename ip_link_set_down() to adf_*
Date: Thu, 25 Sep 2025 19:31:48 +0200
Message-ID: <e5bf4cb3405fb50fe6e217a04268952e97410dc2.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758821127.git.petrm@nvidia.com>
References: <cover.1758821127.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|SA5PPF06C91DA0C:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af8f4a1-4dc1-4a58-342b-08ddfc59bc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u3lAQQoNm2kwpcjUAznx7mjt70l/lPX7s08KXAYNd98ZwdMj+gFJN056cjCm?=
 =?us-ascii?Q?eurw5VoclhZdT2gbNgb3W99omlDh/BZuHP/CjAGw3VHg5OzsmUELCT3PhwP7?=
 =?us-ascii?Q?tpNb90GY7HGkUU+HESSXV5Mg+ayWoINvmv/cl3aENmyBaRFy1clOlvTq8R1x?=
 =?us-ascii?Q?FCJ5rzEb51Mytusgu3uYY093sgVgcAAq3Dh2gTKzUqEQYP116lhpmKzP8gQ9?=
 =?us-ascii?Q?iH1Ve72ir/e6erz6yz6cUSdghvGfMiwM+2GTUWBuXfrOKCphL5TfRI4md+uM?=
 =?us-ascii?Q?urZVgdMVsw6t1TJBjuPCi4qZp2K3y0HKwcW0elrGajycFxt1ROaZteN4IGki?=
 =?us-ascii?Q?A5NbYWBi8/8ABsFRH8tmNS11uUrd4i5de7t5vVmWgYt7BSqzjthw5MmIxC4p?=
 =?us-ascii?Q?H60inoZJnRYvMHUSx1ztvh/IU93/oO3wk94bdqfvtvV6VE/J5eS2PTQ3q/tv?=
 =?us-ascii?Q?0bUbpQHSKpDBfG8POSFUh0RbZHzOGsr2h+/UBXjwIfc78iynUka0pim6M8ir?=
 =?us-ascii?Q?5eeyIw+sPJvez4+svZDsSRpWfEhd/aw8OCAKoiZybkycraiKXjvS9zz/vwWF?=
 =?us-ascii?Q?eo7Sw9gPkO6wkHRYP+dkUK5v8Ry7shKBfIuYTzRgvw5XPkursumCJtjUi4mg?=
 =?us-ascii?Q?wIbmfUB7EpOt2juIowuoXo5SX9VX2fJ/acxvrrSTlEGZrqdpbR3bRZi19D/1?=
 =?us-ascii?Q?MWy513pjMfYz6D6MPLo5WDmg51RJTErDvvdgO/uWFbCftGjknTcpC2q1HpDy?=
 =?us-ascii?Q?8cOrbOg/PHVZFRtFOrOL6foflyiXrfMtmz2+LmI2+ozYlMGfxbczJ9E5k6r5?=
 =?us-ascii?Q?zSwp9VjoHzuCPbFaT3cDoCiwLrE654BKagZB4R0yjlTsCpZN2/WstaSdMfdG?=
 =?us-ascii?Q?Zol51UAvsqrLNRCTDn9lPTbJOZ/4fNqEJgFg7Fk2Q1O/8iAOH+RcuM0PoZ7z?=
 =?us-ascii?Q?0X1U002GNhtrrknb1M0AoBASKkQJbs4JYT8JaT0IL7OzzbuK+LkMRowrTSdH?=
 =?us-ascii?Q?Ecxy7bhDMie5sLC5JC5AJ9oeZbuV+Nv45svZS2rJhvaTKO/QeAyC6oHnpaFH?=
 =?us-ascii?Q?BHLTEAlUWehS0wqcKD2NBcLLqFrAVa50ttsJOt/ktDkF+QyM2QL7q+ai2w34?=
 =?us-ascii?Q?u7kD3Jjn7QshsS8ATaEkFgpBS1DjcjtwD+a+1GTzWDU25eiEzabKB8cQ5R9x?=
 =?us-ascii?Q?qijcU5BTOLDOfYPLuPrYe7jJiHk/a7Zf4wgTTjKCUzyqlI21NYrqJ7rsTE9e?=
 =?us-ascii?Q?fr9Ui987nucfZOw6u+9iI26Pr4vD6kUYar0hbu5GpCnxEM7pBN0nsz6k6xOU?=
 =?us-ascii?Q?76JovS9Qv/cenY8gPcgodnitlFiWYrHWS9x6VDlX/ubMD1CDvHR4s4D+cSam?=
 =?us-ascii?Q?MAD+ymG5dZpwz/0hCr5c8oN753MZRUo5aNiT481mW+9CH+D6yGetd7KdfUg0?=
 =?us-ascii?Q?ZX4JA2IwWf2OuQJv7OP2VDsgT+CSFppKNvbjiWBXEE5kr2Oi3DeSO40rzEZn?=
 =?us-ascii?Q?D0FoVSPRRYYgVPf1LVJHcUXbtBQvbsd6zbg4IoOuvcKxxaz9B+0TWfozLwyl?=
 =?us-ascii?Q?GH6grQ1PM0qBzfEUmGc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:34:09.3778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af8f4a1-4dc1-4a58-342b-08ddfc59bc28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF06C91DA0C

Rename this function to mark it as autodefer.
For details, see the discussion in the cover letter.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/lib.sh                 | 2 +-
 tools/testing/selftests/net/vlan_bridge_binding.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 691f58fad0e3..98c62ff4bccf 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -595,7 +595,7 @@ adf_ip_link_set_up()
 	fi
 }
 
-ip_link_set_down()
+adf_ip_link_set_down()
 {
 	local name=$1; shift
 
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
index c6f5d63384f3..09081bcbfcc7 100755
--- a/tools/testing/selftests/net/vlan_bridge_binding.sh
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -98,7 +98,7 @@ down_netdevs()
 	local dev
 
 	for dev in "$@"; do
-		ip_link_set_down $dev
+		adf_ip_link_set_down $dev
 	done
 }
 
-- 
2.49.0


