Return-Path: <linux-kselftest+bounces-26955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34870A3BC10
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 11:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136F53B4434
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CD91DE4E9;
	Wed, 19 Feb 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cqllv9LR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB721DE2B5;
	Wed, 19 Feb 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739962405; cv=fail; b=bzANP2TCRplN4H7Rn5r/Etpwu7Ee4bh7sFPJPdno0GtDFPGJX+IZvBJtCnhRMKKnFr9wO+klZUnmZ+ScgCAAyRXLhzBSyBE/CQjIlcZB3oOtkGmoYJSwJki5fMxial/20Ll19LFEHDxl9f3d24EI9dIImHbmu7s2bn+jAEhVM0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739962405; c=relaxed/simple;
	bh=1LhNgXXrmq0XmFQ0SYxDFaipDPrVQFcJycxzGdAsMMU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cJZ16xhIMwzOn2Iazji3ZRwsO1O/6PWG2aeosCmCr1skg62G8ZrsCff50tuvitIbzv9CrbyGHIKoCLxp9+SjMTuMD1czt0TjtPEQjOOQBlM03cTRjYaDMEOr6AaXKZ36bqNAtprv//xI00ms//39AmBKYkduaokSPStryiSruX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cqllv9LR; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTfhaZSt9H0h9hr4hQq/JCpidc2BXphjG+nZiNyTRV9CUgchEPtU0NXSxeDovQd2qDTMYXK4XICwDl4cIlDRRKkpw3YnRcKolvcAMy8C/2QPa756iCVaPqKR1XlxXio7vrCiO+WGwkBViDwtw9ykc4Xi54zfXqW3Ayj72tO7YyfVZuxaYZHb5a9cPDvciVrvD7qiuboEFeP37rgC+6j+j7+hHEyblyAxcuZFsKCnSeJ+RVO38NitUO8IjtB7Sgj3G1feVnHGUCEa0rplF93cxMK9YK5pdObgBIv+dUPP136QNuKgaDzsrEkq21mAQHb6K7zgY5WnEp7/4fcAoLs8sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjRv/aQIlZCwzRrqncZtd0QC35Zz3Vbijglmovz3/p8=;
 b=M70zwzITNpEfv+GH0NXFO0GAGdyQv3yFRC7IMxlRLzVjBaP6gnbmZOnNAeeJmjdrTWLxWCLe+Hofagac1kkMhiR6gY9J+Tmwv05cJVmni4aNPIDJn7tKY0S8ViWTvDz66+S9j6fcIReH/nurkdXjdr3E9iS4RAYJMzikyShIsXu1KaTEaNeVhNLBb15wrvkXGydcPqdLsrC0vSUvRbB6OZO4VKGz9okE4pVbb9yOn1+rc1p1PXSuTbiwQPx9k3m3EgGmuo+URNfWreHps5KaVMhxEt9BO2JxQOn14ValEbimKW4uSYCCxYbsSjIQHydSZ7ZwE3Zm3AVrccaEmYn6tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjRv/aQIlZCwzRrqncZtd0QC35Zz3Vbijglmovz3/p8=;
 b=cqllv9LRHiv3r1iBc5GaVBifWZUMoPv+4pYgW29zC36xy2YoQ2WGIp14W/5UtUz4sFjfHJfvWCh5M5hE4Orvp2qlXByhvPkXJ+IetkKe/7na2K15eAEQRrmm/luCxSZa/yM9UpO6g+4v7+7VkpErlWOJuOkGOSs4GjLvaTY4K5S33qSL/G0g5DMZG4iQQu0KfidncWnsoE80ILac6jxA/qtY8bSAYSFNQBY5TnrV9JUv3FuE1RomU1f4Z1I/uEf1jrVu1oV3UMXFbxUggneENrMildiUwXZOMOffkIry7fYfZgGt08meS/s23UpWT3JpC9Ti3wQhXinaeumSCmnlBg==
Received: from DS7PR03CA0241.namprd03.prod.outlook.com (2603:10b6:5:3b3::6) by
 CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Wed, 19 Feb
 2025 10:53:19 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c1) by DS7PR03CA0241.outlook.office365.com
 (2603:10b6:5:3b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.22 via Frontend Transport; Wed,
 19 Feb 2025 10:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 10:53:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 02:53:08 -0800
Received: from hive.mtl.labs.mlnx (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 02:53:04 -0800
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <linux-kselftest@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Yael Chemla <ychemla@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net] xfrm_output: Force software GSO only in tunnel mode
Date: Wed, 19 Feb 2025 12:52:48 +0200
Message-ID: <20250219105248.226962-1-cratiu@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 4008cf99-9596-4dd0-3dc4-08dd50d39f53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfJzpaCuJEpfFMWo0+d1s0Y62hOABeOH0jr6JGYGK9Iuj2NrKHZwQEK6I07I?=
 =?us-ascii?Q?GiDzICnnTgqCnH0c01iyyPBKEzRe6f8Wgc47aTfPRTI6fVi81zb3vpI4DJbd?=
 =?us-ascii?Q?rGq9aGhB79R0fu7yfa0wjFV5wgsaDv3FjzHeLH7hGwbzeTwOciDzw0OW2O7t?=
 =?us-ascii?Q?0k5F3kBMzcSaNfcybFlL+5Q7mSxdfYb0tIjZjscpv4eIv/bhM1u9OflOnxsY?=
 =?us-ascii?Q?Te5uSCUP5L+YpaFwybBwtotMm5wntVHpXFORMOKfT4PscJK9DqSa/Gx8SHJE?=
 =?us-ascii?Q?pK0DC4h7a/le1ZzJhmhr7IpysT3ONrUxHKhKUPnyaOOCSq8F909eZ/LrFtih?=
 =?us-ascii?Q?qj8hNjKQAOt+oqzSI3aZ4OleHKIezdUhK0zWN+n/wZ5ji9jA5pbM2D3docfo?=
 =?us-ascii?Q?4JbH4VA34yXhWWfG9Rcm8MPCuVCSif4XDRG6eb5Zavaq2BuyqI1yFNiC/vPo?=
 =?us-ascii?Q?KRtF1z9Bn/Dw6ylaEv2Yos2V2yZ5UDNjPlqhcS2UB5ibKapsTxJIsIeYiwoi?=
 =?us-ascii?Q?AwfPRNc3+oOjQ8J6/6yd9cfqzZROYqyqSItJRw803wX9cU7Vnf1ipLguVl7i?=
 =?us-ascii?Q?N3J6E+YgnGxCibqa6qOv8pDZ4E04NZlXaNtU86y9HYOxqcZZJGpBKxfmSbx+?=
 =?us-ascii?Q?w84EuA6TwgNxVmVJOgRUaGJ3XVWRXQyOPIr4ymK1msL+dGyQ1Ovq7U3TzqYF?=
 =?us-ascii?Q?vjz0BuZay2gvWLHdwDVS69Q7kav5wlztnEqpauV+fpOkD0WXfBoghxraL/6i?=
 =?us-ascii?Q?CX3UFXBqIC7lu1oCM1XlOOc3UBeHClXHxJ/8RzCQYwlLsZL3DdFQyQk+XG2T?=
 =?us-ascii?Q?Rbb77hwN00TMbLi/yMeFeAeIVAAeRupH0b6fE5i1uVQwxEb6rDtXfAJnUG6J?=
 =?us-ascii?Q?oDUnd2XePDUPznPowACjhv/jHRaihZwervC4bSlMxvhU7szKWWL3ZAfGm382?=
 =?us-ascii?Q?y5Cz91Li4vM/FlslbDDK5ymkeUDJYKVWY9SixTo1628QmeptZj/OVp0pXPpl?=
 =?us-ascii?Q?FSbftX57z4Ln7iF4SUBFuUIenV1JLXoKCTFCX8bjbTMA2WdfDQYkmP8l7k/W?=
 =?us-ascii?Q?qilUvuBCeFdi8uwUVrbm8a6pBSc/YVAn6zBkET6/RCHl/LVFDSzUXCCGCKjx?=
 =?us-ascii?Q?/qJIcTRt5byIJzJsGjYh8wyGhZI4l3wxNDcj3DN2nFHKt/MmFsbQ4XWZkMYW?=
 =?us-ascii?Q?hZM50pvKoM7MQICkPY9zwDCrjvstkurFTqyU3910iPWmzKDsRy4ymKQAQwne?=
 =?us-ascii?Q?F0msncG3i2iCsH1kPPkLk3rpAv4Muu9FumVgo0gU18o26z3nz1Yf/hTxxw2i?=
 =?us-ascii?Q?ob+GEPMWQwhoKX07UXIPKD8QS7L87gL3B10tTFQKGpjwz+cutgJmPLR6SoA8?=
 =?us-ascii?Q?sCeNcGmxbCPjrrdvXW+5xLXH2YEhGJ2i0KLxZLFj+06rqCz9oE0yDDadtTG/?=
 =?us-ascii?Q?oiMOwTJ9h1CwB9nJhgRxGGf/L00l5bdbhrZ66aJbDK3i4zJcgAH4VR/BE0ph?=
 =?us-ascii?Q?9M0jUUZKXfhwxVY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 10:53:19.6113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4008cf99-9596-4dd0-3dc4-08dd50d39f53
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6

The cited commit fixed a software GSO bug with VXLAN + IPSec in tunnel
mode. Unfortunately, it is slightly broader than necessary, as it also
severely affects performance for Geneve + IPSec transport mode over a
device capable of both HW GSO and IPSec crypto offload. In this case,
xfrm_output unnecessarily triggers software GSO instead of letting the
HW do it. In simple iperf3 tests over Geneve + IPSec transport mode over
a back-2-back pair of NICs with MTU 1500, the performance was observed
to be up to 6x worse when doing software GSO compared to leaving it to
the hardware.

This commit makes xfrm_output only trigger software GSO in crypto
offload cases for already encapsulated packets in tunnel mode, as not
doing so would then cause the inner tunnel skb->inner_networking_header
to be overwritten and break software GSO for that packet later if the
device turns out to not be capable of HW GSO.

Taking a closer look at the conditions for the original bug, to better
understand the reasons for this change:
- vxlan_build_skb -> iptunnel_handle_offloads sets inner_protocol and
  inner network header.
- then, udp_tunnel_xmit_skb -> ip_tunnel_xmit adds outer transport and
  network headers.
- later in the xmit path, xfrm_output -> xfrm_outer_mode_output ->
  xfrm4_prepare_output -> xfrm4_tunnel_encap_add overwrites the inner
  network header with the one set in ip_tunnel_xmit before adding the
  second outer header.
- __dev_queue_xmit -> validate_xmit_skb checks whether GSO segmentation
  needs to happen based on dev features. In the original bug, the hw
  couldn't segment the packets, so skb_gso_segment was invoked.
- deep in the .gso_segment callback machinery, __skb_udp_tunnel_segment
  tries to use the wrong inner network header, expecting the one set in
  iptunnel_handle_offloads but getting the one set by xfrm instead.
- a bit later, ipv6_gso_segment accesses the wrong memory based on that
  wrong inner network header.

With the new change, the original bug (or similar ones) cannot happen
again, as xfrm will now trigger software GSO before applying a tunnel.
This concern doesn't exist in packet offload mode, when the HW adds
encapsulation headers. For the non-offloaded packets (crypto in SW),
software GSO is still done unconditionally in the else branch.

Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Fixes: a204aef9fd77 ("xfrm: call xfrm_output_gso when inner_protocol is set in xfrm_output")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 net/xfrm/xfrm_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index f7abd42c077d..42f1ca513879 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -758,7 +758,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol)
+			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
-- 
2.45.0


