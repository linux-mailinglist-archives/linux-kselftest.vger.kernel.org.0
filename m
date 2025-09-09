Return-Path: <linux-kselftest+bounces-41033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB0EB4A608
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C22A71C23B09
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C5277C9E;
	Tue,  9 Sep 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ladnPKlO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554232773D8;
	Tue,  9 Sep 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407999; cv=fail; b=HYwoMmVpRo9C6uixwDQYDmzNbGyFfiIkbP/+x1BKjqzuOKVQu/bVk7n1BAUOiMg5SsyvXVdZvdNhmoEohc0DufI7lXppSYhvuCuUVGVG9OXgH9Lz10z7NGLJ6H33IZIOvGfgWjSdqNs9TT2fsWqALmXOyy5yzANBSheNPTbudJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407999; c=relaxed/simple;
	bh=gq/khDIlMhd0OyYU/8UyzI/2W/URMKVCXwLJdcrp+zI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b87U/Fn1mNeN/6vo+6RmU2j36fd94fjfO2HgJZ1Wo8alJd9yXNeNppnyN1tTSnWIjuvxjxdMhDb75kD1ZYzbVTEPedaQk/KFMtGB5lRVUJMoyB8gVPmArtM+u0pVXBH+V5Iv6UCUR4HAbg9AWtv8r9SdFh/E79WZj+Kr4IYcEtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ladnPKlO; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXYMS6526rxRbu1dLglVhNZNgy+VT76xP7G4vUzyBNO4puVHlvOpui9/9dMeJkvZgkdCd2C/kXlQ9doTvTyXfJCtG3U8cxg/oMoMImqByuTRGy7rstrv9mP/Vmq6QXVgoTo5GtU1CniMiEiUOnzMDP+2f03iHvpm4njFQZXRw7kTuUGJl/vxzVTUf75N6cSfTRxuiZYKYOsrcqyqdSBImhqj7mJcub/qHnFzdiepMFW3+ToSSM5WIvjWt2wWd0ku0XXo81mzp9sGpyDFo/wHcq2FuLJOd84MRTR8yvWg7SIbWtEG0X/CwGHJCteYpol9hr9iiCGKRiGdTqraYPGcZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uINVeQA8C8TebQin5XTqWjOxOtcEKAjG2SOTBBqhuk=;
 b=e73fz0CW3ztNh1pvHYFx77gTnoLy7kOE7ad2UZRSpNo/9w4y2k60QR5d84LXxTiOwxdxlWIKnJBwabtPwTN7aEBcNzGCumhHV807JhTycNWOhOuUa3SE3Ui3fbQqfR/Ji6+yh0C7OpW84UrPh7bRcrLl1zL9rvJfzAvhslLDUwqGq92nNuInPasHXKEQgo2kH3a61erjPXOGTE9/wG3CCoBdlcE6fQY5qwDCOcjNExxFJM4uDwPhan451f6dvjzfhBT51G+HrnmlQxex7J6EaUT5arH4vqaygM/iycqQ24hqqOti9KK8FHqBB/THOj631+4b726/V3PD3tY0LDc8YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uINVeQA8C8TebQin5XTqWjOxOtcEKAjG2SOTBBqhuk=;
 b=ladnPKlOoqf7ygGPmYR/qiR0MrRKDU7faT9T1u3rkv1H0cbi39TY6Q5FH5NGrvnNaxCb2GG5T2lkU1esml5vNhDORGba+yVxyQ5s33PYeJfftCdmPsD4237nCWVWv1DY+6IkV9aAE7xva0pV/hyUxEMleDzc8Habd5KtPp9/J0HsGILolDVzmHLfMrBb2Ho1DnRL11PClkszbvOiENfwn3saCbhZrJGZmwED8LjCQ6G+0Xgyj8eYUpUcY56dpN0pn5/Edm3fmvuLrTr00YXBnqSiNejyAznUaqTblVRSnLYjzaDElgm81ho6/KZZ35wJ2cQJ3Giilon8nsgIpt/o+A==
Received: from BN9PR03CA0118.namprd03.prod.outlook.com (2603:10b6:408:fd::33)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:53:13 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:fd:cafe::48) by BN9PR03CA0118.outlook.office365.com
 (2603:10b6:408:fd::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 08:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:53:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 01:53:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 01:53:00 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 01:52:56 -0700
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
Subject: [PATCH RFC net-next 2/5] selftests: drv-net: Test XDP tail adjustment with bpf_dynptr
Date: Tue, 9 Sep 2025 11:52:33 +0300
Message-ID: <20250909085236.2234306-3-noren@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a5c633-0732-4399-cbfa-08ddef7e4f12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BwQwYoO9gurI4Cf/Cj8i/fpUbX3KYCNTtPDXcf2LzMP1icZ/LRhqaX2GG99/?=
 =?us-ascii?Q?6IazlPIFmzsMABYqTTmjDfpzejbe6rsqFeALeTVCY+vgchf2/Kyp2Z5GhUrO?=
 =?us-ascii?Q?+Gntl4gfbtQVRQGOFXiIsSQTq4LMM2euvxzEpkCBgTxPXKRAB/r/Z/aR9fnh?=
 =?us-ascii?Q?SPmqau3ebdi2pkD9IpHNZ5u4GXnmE7KhHCCRzdy7CKauNNFdSRQHG6/Y+zcR?=
 =?us-ascii?Q?DOwzL0VnVQzqKSXTOzB6ZDFtiNVQwaa9KTgJxd2Xne92UtlofFrHiiRIQ5ls?=
 =?us-ascii?Q?N/NtIINWcf/54T98QtWAqu+2RL096sfxXr+S8JJeS+quZFTBZ5pca3qYSwWv?=
 =?us-ascii?Q?7QgYNCaZ3EDxEJ1LWcFvwm+fytUKHb0LgiifgTAGE3XXmFNCif2EL06nfnL2?=
 =?us-ascii?Q?gcQm7GqU2mhcofhoGbOu8th/xU4OCOXKlwfXC170UFTUUSVEiynOQaV9fgkC?=
 =?us-ascii?Q?D5uW7FUJHFqN2gSHENqq75HeGQMgBpj2wCej8GSMvcNxM59TfObzoGmsScVk?=
 =?us-ascii?Q?BKts/rbRWHI5Mgb/ksveZy6sob4nxIsCP1u1Xy6I5qbHqzE/6C4Q5XnVkz/u?=
 =?us-ascii?Q?VFDAGUkfNYOnbPSI4zK4jvgqJL4dPvVvqJdTFOGLPwvzqU4WQ9ajv3hIOVjV?=
 =?us-ascii?Q?oObHV/vWCVoyD4cLrXYvdAFkFDMKoa+lqFTSQQyaSK8eTiz7xlHDP3wFSg+4?=
 =?us-ascii?Q?eWGq2F6g1wjZCa+ea5UKgspJ9tCcxHwgj4LaqnzbcZD6c3bZxblQCIFdU92R?=
 =?us-ascii?Q?5ZXG654QY6vQ6nmnn84kfinYQAIY0X08OFAzqBElxlTsrC/Lp0646cBqbm1e?=
 =?us-ascii?Q?4iaPwFkB1q2y2GdasHqUzth4vkMZqLKutxe2Kw0oPJbidhJGumknb+px+nrc?=
 =?us-ascii?Q?wmSjjMm7Yd0/Dh5Y5WkB3II7XGDpKhBwkqhmB1o0fFee/ILFUauLNIX6mVUg?=
 =?us-ascii?Q?fk2Xv1FNeT7w9rqKhW4g9zKqE8M3gsmhgqyhd1RvjzuoLKM5YUJAcHrx37Lz?=
 =?us-ascii?Q?ljBwgtQpiAKaDjx4uKF/JYrKRo0NW0BmdiWUlFSUjMM698c25ow1xg7xFM/f?=
 =?us-ascii?Q?+bAOJ+kbfxd+P87aYb7nRTaRU7x6TTo42darevAyulJxdn6WL5QkyscCfSDf?=
 =?us-ascii?Q?LJs4MQr1IdKQ0oZfO6L1TPq+/S6sty76KvVa6lmabW6BHbPbcST9CzyIoAs5?=
 =?us-ascii?Q?UvIeEO+TSaTNbcbZ6sc08E46eKJad2o7QDACnxaL5oJLteCpjOPHXY/y4cxg?=
 =?us-ascii?Q?JTalI1LmP6BeXzHv5mMyDPfMaBwWUcQPPXqXTUHgyK7J5n9zu3MUZTf1nJ9a?=
 =?us-ascii?Q?Nz7JHH/545OONQlmHQACkcZc2ym0LLJTz31vOCXpHalq5czn6nEJOzfxtFc5?=
 =?us-ascii?Q?RlUnMluXuYIOQtwWUgGJpVRYnjOjOnpiUBYdtwQREP9HstP5F/83x+/X74HI?=
 =?us-ascii?Q?HFHT4EvvvdADL1AGoS9TE8xViPt+doGyXWk3ODZIwKP2GzMgK3TVn0E/1dfC?=
 =?us-ascii?Q?AMLatVLJoRQK1lPQxqKiiRigAQflXeTNRHjHVgqb4XquMokm+vafw2qVPQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:53:12.6144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a5c633-0732-4399-cbfa-08ddef7e4f12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744

Update xdp_adjst_tail_shrnk_data to use bpf_dynptr_slice to read the
data at the end of the packet, instead of bpf_xdp_load_bytes.

This may avoid a copy by returning a direct pointer to the dynptr data.

Note: since bpf_dynptr_slice() does not support variable lengths, we use
MAX_ADJST_OFFSET as the slice size, and update both the size check and the
UDP checksum calculation accordingly.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../selftests/net/lib/xdp_native.bpf.c        | 20 ++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index 346cbba9afec..ff768fbc8606 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -272,10 +272,11 @@ static __u16 csum_fold_helper(__u32 csum)
 static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
 				     __u32 hdr_len)
 {
-	char tmp_buff[MAX_ADJST_OFFSET];
-	__u32 buff_pos, udp_csum = 0;
+	char tmp_buff[MAX_ADJST_OFFSET] = {0};
+	__u32 buff_len, udp_csum = 0;
 	struct udphdr *udph = NULL;
-	__u32 buff_len;
+	struct bpf_dynptr ptr;
+	void *data = NULL;
 
 	udph = update_pkt(ctx, 0 - offset, &udp_csum);
 	if (!udph)
@@ -285,18 +286,19 @@ static int xdp_adjst_tail_shrnk_data(struct xdp_md *ctx, __u16 offset,
 
 	offset = (offset & 0x1ff) >= MAX_ADJST_OFFSET ? MAX_ADJST_OFFSET :
 				     offset & 0xff;
-	if (offset == 0)
-		return -1;
 
 	/* Make sure we have enough data to avoid eating the header */
-	if (buff_len - offset < hdr_len)
+	if (buff_len - sizeof(tmp_buff) < hdr_len)
 		return -1;
 
-	buff_pos = buff_len - offset;
-	if (bpf_xdp_load_bytes(ctx, buff_pos, tmp_buff, offset) < 0)
+	bpf_dynptr_from_xdp(ctx, 0, &ptr);
+	data = bpf_dynptr_slice(&ptr, buff_len - sizeof(tmp_buff), tmp_buff,
+				sizeof(tmp_buff));
+	if (!data)
 		return -1;
 
-	udp_csum = bpf_csum_diff((__be32 *)tmp_buff, offset, 0, 0, udp_csum);
+	udp_csum = bpf_csum_diff(data, sizeof(tmp_buff), data,
+				 sizeof(tmp_buff) - offset, udp_csum);
 	udph->check = (__u16)csum_fold_helper(udp_csum);
 
 	if (bpf_xdp_adjust_tail(ctx, 0 - offset) < 0)
-- 
2.45.0


