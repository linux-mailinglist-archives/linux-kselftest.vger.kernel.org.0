Return-Path: <linux-kselftest+bounces-45077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B7C3F791
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 11:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B1763A419C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 10:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1683081DA;
	Fri,  7 Nov 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9K67o/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012039.outbound.protection.outlook.com [52.101.53.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6D3081B0;
	Fri,  7 Nov 2025 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511413; cv=fail; b=ez0lOjGAPvhkeCW3WZORv0grMyxsPWNKEkDn1MvMcJGM1HIZctakCg4q4a/B+0C8nn65yBhC+fmi/kHttnjRWNDeOSWVKHDr2/XVK/JsOGf2kE+VtJIpCNHIDsZBnXCOA8bthmp2CGD1JG+sFJsDURwIXK5JkDtJPFUmpprgkOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511413; c=relaxed/simple;
	bh=oG8QwivSaj+DyVhNnqQ27jnJ0Q84CvYp9dCIGKX1UUg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JYeW9L1nFtG4Rw1U+QkBL7uyUYS/qsR9Lczh7+Nu4D6vy+37nV0XZeVTH70xHyoPq2JB2C2hsEKrwpHjQVF4e3ZMdtXrLzkfF9tWkDAjDMkot/Kf7IY50FYBslrxVAgYzYdkRqVzCfGe7oYJrCWd0vYsnJ973/vzDTWM2MdvMf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9K67o/K; arc=fail smtp.client-ip=52.101.53.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZM793J9fNa72LcPkw4Bk2yy5Qc/pmwseNHc0Csc/tmOdz0Fu3Yyy0fe7cR1gSO1U+J+t64yLFTKYvbYfdfKs9w1CJpBjfA4bMxEKj4KMW9mKoiKGwaSwpwhWtfoP+LKKhVf4HgMG3LlZ7317SfzS3Ye5ijONmhnBqrC8iFdEHJeHX0ICikgAcSmSlZ56Jq5NOc3SEYKTvW/Ibk3CUb7v0Hz+FyS6E2kZNCvytJTOQFBmcgSojHkSwfhlane4ahooJrLpa1R4MqnDCzGpkzR1mEOEr6RK1wqcHatV8gTWmSZscICn5y0MmzneHSppU23DWMLnPuvWI3FNfQ86nawscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNBJYqR/dGHKK9uZi/9yIhQfQdITT03WPeL6ga6r5n4=;
 b=jKZpTMJtyA+42X38MXfEXtT6CtrlXPxxLs/0GzNA5EsBwan+EsaIIULjZnz+SApbEU6WfDn3wkoEpFr09dPxebiq7PDfRoMbVdk3LAVMJlyAkUClDhCDipdIQpcLSqjSV/EebTqJ92NNObKjf7SHQYCJjhhv4uG+yScIFQbx9XsQeiCVPK48QhxH9V0PSKt9TjsLruFf3VVEM0R8bXUrV2QyJX8HeRvQiyw9wzmU0NGXLGm4IfeMpo7cdMVZA3OXRreDqiKlZDpA+KvZ4MBz8raBrcsBqLES8QSoX7jyVHeGmGnSsySRQQiA5hos4tSJUhmVwPc4lZPq9raZ+4prWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNBJYqR/dGHKK9uZi/9yIhQfQdITT03WPeL6ga6r5n4=;
 b=b9K67o/K11vFvkook/0wkX+ugT79jIkb/6DdoUnZk8vr7rb5povfThPkhrAWKSs7RRKvInfvcShgVfyXZ4Yj6Q3qeS1Rd2DYCtqTn5wpNvscaakoFqcHfbKC990erCR5cqtalUXxMT80k99WDaScGmBZV2nTzF0wJiCS2HGY0e89NgzYFnU8HqUr1Tpu/T3qR8N+Poc1UT8FcerVVrTj2n+QbTF4QZ8l9W4VB8guN0eO0HsS8cm4hQYoIyz380jSdP9N4lFrm3sR+Vs7StQsTQy9Er5UAPnAQYe1igdI6CFZ/oVm83H1rJkiUYz/HlcR24xRMGMjWnuP/9vEjamU7w==
Received: from MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::6)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 10:30:06 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::d0) by MW4P222CA0001.outlook.office365.com
 (2603:10b6:303:114::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Fri, 7
 Nov 2025 10:29:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:30:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 02:29:52 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 7 Nov 2025 02:29:51 -0800
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 7 Nov
 2025 02:29:45 -0800
From: Dragos Tatulea <dtatulea@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	"Eduard Zingerman" <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [RFC 0/2] xdp: Delegate fast path return decision to page_pool
Date: Fri, 7 Nov 2025 12:28:43 +0200
Message-ID: <20251107102853.1082118-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 9559700e-26a8-4f42-7de9-08de1de89e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SAJ7H3trJOumAgLwlluwc4eBqAM/olHk65JNac5Xd7i7SpQet6yBnyqgYkBA?=
 =?us-ascii?Q?9scYbrSRyo9QpGFiYmiBrXapNBiw3HYUBOsuBzd5/PbnLbldNkizRNg08SBc?=
 =?us-ascii?Q?YEh+5EKeNTPSl1+fuKLhtEBfwvp+BRPF6d4ECF1XHedIJ6w9ekImSLh9aGJ9?=
 =?us-ascii?Q?U89f/zTgipx+2Dg8zhq8r8WS/zbUuM18ad0OE0CrPPXaS6kmmh/pCx9y/YGZ?=
 =?us-ascii?Q?1e6Kor/5EkiCPW9cUMVHoBqH5W7qOKlCqz8tMIY4c7bcgprYV5wNsMenK4S2?=
 =?us-ascii?Q?wWcM1RYO+VTGUXOSOS/Io2u4rHYIvvayn2ek69ep6twOIrpaplwyH2z15gnF?=
 =?us-ascii?Q?bnicW+3NFwcvEm4jNX69PrN2T6/RJP6s0Ee0eLCCjgrDVMQlEk4wDVkoTzRv?=
 =?us-ascii?Q?HWkje5vez0SK1jBgSaWZfg3GSuWqjw1GmTA9Hc4goQONVmM4tvEsw9093L4d?=
 =?us-ascii?Q?PpPd1D+xXuZSE1aPGxdVNaHkQh9A3zsNNzL7SGMa37P0sQP9uejKKDihzA9H?=
 =?us-ascii?Q?nkhIVXplKa2w7kXPwl4SqZCbhCptWFPwcxF6WI7Hy6P4CW7X/NcpcGTow3GF?=
 =?us-ascii?Q?bPy7MYDCb1pk5DPLwQARbGezEiRFT4olrCmqDaypkgy+g61zMFEBJGivSHwZ?=
 =?us-ascii?Q?t2Wwzx8B5EYuDSiF0ijxw/eIvIFYIc/fj7yLLyKNZilz46XSN7Hh3LXcutQn?=
 =?us-ascii?Q?E81DQTbV/mBKjckhxKTdAq81tN41UrS9Ql+a9ZbOsI9dbkNd5craxajTJmWK?=
 =?us-ascii?Q?H4qU92KEQAzFGWa2zCfqeiTLmilwwHOlvYxFWx3Y9UigAMxTyNLpGB+tH6V0?=
 =?us-ascii?Q?hjkhg2fDj3gN2PMn0EKVvc8Z38RC5sUSrMjkT9dr8MrPjaRKefPiDQSUFOAH?=
 =?us-ascii?Q?jVzXDbK7zhN4/itFdjBlk4ZGOH7zNceQ/rBNi+w+znyKAyv5Y/+B1+9EE5rl?=
 =?us-ascii?Q?7NbEJfmIYMokrxEWCU3+C2Yr26htCBaJgUYK0B98e5GiquKz9519xoxgRqNh?=
 =?us-ascii?Q?PJqOcBt0aN+UFw6jDki9DvzuCyj94dqADIrt1u+/PT+vcMrgXuyFMM1TXIKF?=
 =?us-ascii?Q?Mqgpd/1vNmJAW5nLwMkZ+NEW4HXd7MuM7SVD84c7b3X+525DFArlSWdPctxb?=
 =?us-ascii?Q?EHa4xCOatdUYCtvqL97ROwGc270yP307gypwPK0wuM0nhkZvwTNbWJ3ZImyf?=
 =?us-ascii?Q?wQPtCOfNDRyJiQCda5lTQ+PZ9xQB9jWD7EUKKJ/nSauLZKhf5DHZIZpctxpA?=
 =?us-ascii?Q?zwdpmHOOEpYlToTkbCSbvhjOjo/mCiU10a2jvBDlywJyI4QevdD8wmOc2TQ3?=
 =?us-ascii?Q?2mIy8djXUgg0gPEpw0TQwX2xK/tNa2trQkd3BbNkrwBd7wTZL9Ocgq3uRe6J?=
 =?us-ascii?Q?pIwl4mltQ8YLOPGYEzFGPyUrLQBA3JmSHiOiJmo/z12hrH562RElZdekiHQy?=
 =?us-ascii?Q?HTDoFkDrt4qTN5NoiU5fXugD/4Vwgrz1EfM4YDXUmFBQQgPbgR89MZ5MoWuC?=
 =?us-ascii?Q?IsRqfdI+hBNQvLywqINSFvZJGbeot5nHB59gLPFCLzHQlZ+FkkKl/H13zqY4?=
 =?us-ascii?Q?WiXJ6L1HXsx42Zxx2R9IHZHsR6yBymZ9tJk4Ey0tz6Rbogu5FHIc7besXwUd?=
 =?us-ascii?Q?tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:30:05.6291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559700e-26a8-4f42-7de9-08de1de89e37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455

This small series proposes the removal of the
BPF_RI_F_RF_NO_DIRECT XDP flag in favour of page_pool's
internal page_pool_napi_local() check which can override
a non-direct recycle into a direct one if the right
conditions are met.,

This was discussed on the mailing list on several occasions
[1][2].

The first patch adds additional benchmarking code to the page_pool
benchmark.

The second patch has the actual change with a proper explanation
and measurements. It remains to be debated if the whole
BPF_RI_F_RF_NO_DIRECT mechanism should be deleted or only
its use in xdp_return_frame_rx_napi().

There is still the unresolved issue of drivers that don't support
page_pool NAPI recycling. This series could be extended to add
that support. Otherwise those drivers would end up with slow
path recycling for XDP.

[1] https://lore.kernel.org/all/8d165026-1477-46cb-94d4-a01e1da40833@kernel.org/
[2] https://lore.kernel.org/all/20250918084823.372000-1-dtatulea@nvidia.com/

Dragos Tatulea (2):
  page_pool: add benchmarking for napi-based recycling
  xdp: Delegate fast path return decision to page_pool

 drivers/net/veth.c                            |  2 -
 include/linux/filter.h                        | 22 -----
 include/net/xdp.h                             |  2 +-
 kernel/bpf/cpumap.c                           |  2 -
 net/bpf/test_run.c                            |  2 -
 net/core/filter.c                             |  2 +-
 net/core/xdp.c                                | 24 ++---
 .../bench/page_pool/bench_page_pool_simple.c  | 92 ++++++++++++++++++-
 8 files changed, 104 insertions(+), 44 deletions(-)

-- 
2.50.1


