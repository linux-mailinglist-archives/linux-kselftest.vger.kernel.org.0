Return-Path: <linux-kselftest+bounces-41034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7CAB4A60B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811DA1C23B8D
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E127603A;
	Tue,  9 Sep 2025 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lJAbYhcp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9582459CF;
	Tue,  9 Sep 2025 08:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408012; cv=fail; b=Q5rE27Q5orp7eJXuoqAc0IdvxrpvumTr1aw9Mr1hu05c7AhW69DT5h4kErmPtt1IdIr/8PAed1LEgERba/r2xzd2IJpG6reJNQeZaVeghTTkrTF548bxpmICehlQzIrSV7Sq6nt+GaadwovTDqFTASiYQBeJrjjCCL7VFzayLfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408012; c=relaxed/simple;
	bh=KtibvBy2Pjm99zA8yO57lnUZHBlChy+pb83ZiB97hi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaRoSaFB2wQub28ZW95j6skOsESHDfqUxfQkZrZf/mlNl+aZmyt8pbpHYSXGMBuou1VQKROQVhi5lLrlRcvmQybgu3OetPEzmiId3kjX9NF4N3/3a/N6UNUJP/xgX/sVHWaoctKaxdWiYme3nBMwFTUpDD3Mi5P5SKgWxHGc7Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lJAbYhcp; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mczcpiZTEH4MS9FKqawiYt0kVLPkvrpjgiroQrfBnSKE5jt3IWU+A1RissDYj45gO0vmD+0+GmLyY8da7BUJBpbR8AepfbuLhxHvPhlnxNP8XzZzmrB4WrZCLhrrDKAnlSBaZIH/h+W7VgiToBdPIGaz2N5blhz9QMoWuU//grGXBqOGRW4Gvot3KuFiu8ohBzbJwZTLKaqavNyC3LvfbfSXviMAaHs7R259lHmY2/yijac1wv69VDgWn/sqHsct8ugCBkIKX7nevv0wxfbOWFcokM7PXYaRtELganq0//6tF8XPGeEaV6rVQTJN9DIusykY/fvVpINWBhDxbuPYMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCfMsUVYPwoQbtFuQ1Rl7bwxzhDON4xa+JrT23RgrTk=;
 b=aq5uAPjTXAmkuq4s35bvss0tLiUa4AUP43dECDky6mAxvvbD30bJ5m/5ua1jE4qgZ8KAB4y1GTpAeozVNqzi3XDseS4BVqiOqu656KENp4qHuOvO7+S1swdYv1ksDJxW7jTOJcxFiHnrMMwLYBCQC4JhR3whXoYev6eMBrvJnh1ASJw8rf9K2uXWmWQ9+PIZV//zCAJ8otIBrvqN21YGpfszIlZMiOBo9Qy+yiBfBmWu50nE9szqJWLuNGpW6U9w4dK1uL/+T6ODPutObYRYBDNYcc9ZZo5ApehB7vsNIaaQpZJNm6ZpGOry3DthoLwRl0phDMm9k9/QiVRakRVxjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oCfMsUVYPwoQbtFuQ1Rl7bwxzhDON4xa+JrT23RgrTk=;
 b=lJAbYhcpReXY6/8sqFVS8l862gwNvEApX6cyCPv3JFClmgdvg1XVUUixfSzmV/bYmwRczYhvg0+XYSLwtI1pveyEJrg01QlN6f7WWkdy5oBywAIbmzgZF4BQ5Istq2NaqMiMS2N9ienwgOYLqKCaHUsBh/Ijear4x0GsiuVUb40Jm3U7T2pvlRQNi1Tq7GUukyGezONZiLYRkxcRdqk27epLz47FiAU83rhorYYnOVgqeJVOWrK+iuR4XHZQ73beCm7mUO5FlCmZHwerejBZikiR49jzddEYD8dv10co+vPHmNWD/bEWJY4C/6U7wt/YZ6both+LvrmepuboMLQgNw==
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:53:26 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::97) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 08:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:53:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 01:53:07 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 01:53:07 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 01:53:03 -0700
From: Nimrod Oren <noren@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Nimrod Oren <noren@nvidia.com>
Subject: [PATCH RFC net-next 3/5] selftests: drv-net: Test XDP head adjustment with bpf_dynptr
Date: Tue, 9 Sep 2025 11:52:34 +0300
Message-ID: <20250909085236.2234306-4-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250909085236.2234306-1-noren@nvidia.com>
References: <20250909085236.2234306-1-noren@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1ab70e-47b1-4f34-1339-08ddef7e565d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r+0gjEPMCu4sU7OApkqrGdCQSG27old3MxwbUi+PFA3L0kP4GUnDqQszNU88?=
 =?us-ascii?Q?8jKKzhe8lG/Ugp8q/0HQWh1w6ppxNrx8gk+H3hMsrFv8Tp09GnfsFhUOQ7qA?=
 =?us-ascii?Q?OCAF7vLTMXBZljOqpngQG+IDfvmRU3A8sCrkh9woNUcRjwi+FM2StfUekrXV?=
 =?us-ascii?Q?T73++gGp5DQIwfC0DY+mgy8W9n0KjVGVTUIlMI1dkOo6hQZCPptgVx0uUWCZ?=
 =?us-ascii?Q?9RZ3IvMqMHYx+Q4MptEIwa0+nj4m5u5EqdP/UnATUcF80eqJ7IA5X0T5/Zmn?=
 =?us-ascii?Q?rNtuMG/ZcvrRAUb5WkuXS5DitlcX1R8BlZ3Kc+9iGfBKxyoGt9akrrxj5yXu?=
 =?us-ascii?Q?+MlMyhpZOnholDE8jx3CaKwEKvvNEwNj6QNecc4MVHhjmNancbvte6h0tIeJ?=
 =?us-ascii?Q?i5abPPUW5SSpj4C5Uii4/LQCMZmYL71hWcQhLo4Lin7y9fvO/DMKWYcFnnUw?=
 =?us-ascii?Q?pyBCDs9ThqkvzIdbkNHQYzbc25ZLqUlvF1rR/h+5ug+6IP/vnL3H41UzcNep?=
 =?us-ascii?Q?HSuHZU3iSMAoAG4cv6KStG2PZG6Zg+Zlgmk2TjCHiWzUxvvf8hMjV32czSJj?=
 =?us-ascii?Q?vcIRp8LTA8+yBi4SsistRmvetK6MLtCwa/9qZtWKlhhKyIx3z4/rxY2DsaE6?=
 =?us-ascii?Q?xWfoszzCeRcWLA2o5W4kvcDyPSkqrViX3ytfpFbKsLsmmiURDZ105aif9Nnb?=
 =?us-ascii?Q?gleLBY68TEPWrbs0pWQv+3mmtcpNHzingnALM7sCrZp3R9V66fy+3vBEV7DG?=
 =?us-ascii?Q?RUuofrXauCq9623wi7Uq5C+Z7vG6JxXFpDeBJtmuoQ2VZGm56vlcrsW/fEle?=
 =?us-ascii?Q?tchKVttswOOQqg+rFC0ojnTPxmsYVJjVMAfFhGtmB5o2n9z71OLH/ZAdF9Ro?=
 =?us-ascii?Q?y6NpsUsVzS/xfCl/j++/x5Dbd349tiXbrCVTjlWCILsS/+NHEIHCuOyxSqpv?=
 =?us-ascii?Q?wna+u4vAFWURI9HKYJxEEgbOb6V4248DPEo72WuitMnW7W7RgOzBEKRy3EMM?=
 =?us-ascii?Q?17AamkTqfkXuTWH+EnbJ4fMOtd2EoKDNngDaWsHpDEB6Mfx8CmIx1wRNlFnD?=
 =?us-ascii?Q?IL2nOe6D9E+1JEmagr3669bsVw0pu8FJEMXwnu53S77vLq2yAkvt75hC1qG9?=
 =?us-ascii?Q?WsJtLMQMQeHtFxMzgW6wdRBJ5vnVe7/Ux+JoXrBCLFJsjhOgBHAEAFB/lG0C?=
 =?us-ascii?Q?+oCmkdpzh3UP3xd4oLO+AaqrIkOFhuUNsyYN66TC2ClU5Igt9aAyUFroRdK7?=
 =?us-ascii?Q?7W0KR6f0Puqz01mV044NvvqvT8oQAVu0rnJ6iFmJltJS+eEvNLxUKOF2U0rc?=
 =?us-ascii?Q?NghQ2XMN2QZgx4/sjoK6IPiD0ke5YdWkeUkamt+h+QOD+rtmyyiqyi9hXzTA?=
 =?us-ascii?Q?uzbXkQzrZHGc4RS02DG+PkXVMKj/uS4z62wAR76WKQ+C998t9Yoa0cGDkMbp?=
 =?us-ascii?Q?myIYGO9rsuGHOsG4OJViO5JP5BbL+RG194ETG56sX0ZKEBRVgy7UHOETTSkM?=
 =?us-ascii?Q?pTHzaXHcXfEf1k1QlpAFfMKFoUXLMs7meT35zq9zIjTjfB4uKjylQ08yhg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:53:24.8578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1ab70e-47b1-4f34-1339-08ddef7e565d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

Update xdp_adjst_head_shrnk_data to use bpf_dynptr_slice to read the
data right after the headers, instead of bpf_xdp_load_bytes.

This may avoid a copy by returning a direct pointer to the dynptr data.

Also, use bpf_dynptr_read and bpf_dynptr_write to move the headers,
instead of bpf_xdp_load_bytes and bpf_xdp_store_bytes.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 35 +++++++------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index ff768fbc8606..71172d32c529 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -398,10 +398,11 @@ static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, __u64 hdr_len,
 				     __u32 offset)
 {
-	char tmp_buff[MAX_ADJST_OFFSET];
+	char tmp_buff[MAX_ADJST_OFFSET] = {0};
+	struct bpf_dynptr ptr;
 	struct udphdr *udph;
-	void *offset_ptr;
 	__u32 udp_csum = 0;
+	void *data = NULL;
 
 	/* Update the length information in the IP and UDP headers before
 	 * adjusting the headroom. This simplifies accessing the relevant
@@ -414,37 +415,25 @@ static int xdp_adjst_head_shrnk_data(struct xdp_md *ctx, __u64 hdr_len,
 	if (!udph)
 		return -1;
 
-	offset = (offset & 0x1ff) >= MAX_ADJST_OFFSET ? MAX_ADJST_OFFSET :
-				     offset & 0xff;
-	if (offset == 0)
-		return -1;
-
-	if (bpf_xdp_load_bytes(ctx, hdr_len, tmp_buff, offset) < 0)
+	bpf_dynptr_from_xdp(ctx, 0, &ptr);
+	data = bpf_dynptr_slice(&ptr, hdr_len, tmp_buff, sizeof(tmp_buff));
+	if (!data)
 		return -1;
 
-	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
+	udp_csum = bpf_csum_diff(data, offset, 0, 0, udp_csum);
 
 	udph->check = (__u16)csum_fold_helper(udp_csum);
 
-	if (bpf_xdp_load_bytes(ctx, 0, tmp_buff, MAX_ADJST_OFFSET) < 0)
-		return -1;
-
-	if (bpf_xdp_adjust_head(ctx, offset) < 0)
-		return -1;
-
-	if (offset > MAX_ADJST_OFFSET)
-		return -1;
-
-	if (hdr_len > MAX_ADJST_OFFSET || hdr_len == 0)
-		return -1;
-
 	/* Added here to handle clang complain about negative value */
 	hdr_len = hdr_len & 0xff;
 
-	if (hdr_len == 0)
+	if (bpf_dynptr_read(tmp_buff, hdr_len, &ptr, 0, 0) < 0)
 		return -1;
 
-	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
+	if (bpf_dynptr_write(&ptr, offset, tmp_buff, hdr_len, 0) < 0)
+		return -1;
+
+	if (bpf_xdp_adjust_head(ctx, offset) < 0)
 		return -1;
 
 	return 0;
-- 
2.45.0


