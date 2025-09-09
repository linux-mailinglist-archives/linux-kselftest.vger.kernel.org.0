Return-Path: <linux-kselftest+bounces-41031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C9B4A5FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 10:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B11716712F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 08:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00691274650;
	Tue,  9 Sep 2025 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RHV8byxJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AFE3FFD;
	Tue,  9 Sep 2025 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407980; cv=fail; b=mP0qTjU38IOEQ887KpmQqleakiX7i3viPiJdDRGPP124cPug51vbDUPcw3OF4/IycBFqJwPqAuOJ0oB4OYWd+obdPbVLmRtCFdAWZE3c7QefjZ1qjEDnidyo0BhTTzIwWlgSNdOcqX84yEx0flv/JN8zy2z9Vjix8/YvMlsKR18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407980; c=relaxed/simple;
	bh=SvMZtN5gwc7dlVNTPbxRNXYCvnevsJ9XhRQM6Ft0D1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XqzYgd8oKijsyw9U6oXRgLpaF0cRkizdUPBWaD5Z+U+rNdxwn5tnS4I/TU5ehoVV30sWi9S3hQtFYHVWzyWJjzaqWgzvdOUA29mX9rJOiLqE6fqXJc2YPvO7FfV7ZHoL7nMTHpPShKI4uHAFg23kIAn3EeEw5jdjq8Qtgkt8NNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RHV8byxJ; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc5cyLKg+fb5Nw6waraSEqBqHqzuxol5ySo3U43UlxfECEvMr+o+6Bz++5/lDjqWOBk6H/KBdjqFK4LbPn0QKNy8D6PE9iRR94RzhR2Qj4iwXNkID8/Mq0I8FYoHpOWHhPFIKjae3EbkXEXDD2UT9q70hlxfRzKlRtXCQS6Y4rlqcj4nObej5zAhrBBrnDcYOE0iP+UziqXnKrD+veOUu4AYeLC8gvTa3aK8lT8s8+krhZSKf9QYJ7GO4DYYvHlvdVGuAWpKWYS47rB/ctnOt3/uBUFHHr2Z5A8OSPEG7HcRBqHN9Y47iSxRJcGRULiOceYHf4qdsJ5FR8joPaCcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elSaF+0E5ZJoPT15/fSkcURP0h+DIbnGSdobXWMcR3w=;
 b=M8NCPkqrt+iITcVWnUZEKiN4t1IdeJcc+vM1QzNVFp0DQZbuilPrcsBJ0uaOi8e+SMG/CfFUhWr2+2vkhgM+OlrKHj40Z8Z31BSZSa6QKlhRq/e7sJv+SYH9Wzeo6PuELA016NsBSOeY3qgpS6CrykupccCoGpedk6kgWJS3Cx6AinP1BBEDhdP75tZ5K1Oc1ZC9mS7sYpGrdus7oMmUZHlasx+1Q3yIxL6ikwYHp0WM6e6KhOGwGmcHI/J1EgdoLO/UFZMIUs1J8Ub7P7Y3DTRR66GW3qYEDqg7LG/Ijwf1DwkgODvpfEe424POiYtXHfAE8DDxZ+BLmhLVghIO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elSaF+0E5ZJoPT15/fSkcURP0h+DIbnGSdobXWMcR3w=;
 b=RHV8byxJ7LiTRs5khl140nLirU4PYseevDu/kZqjALQ5DEgvIDNYn0Bsl5gl1uecUWa13TS0gDKeeN4u1A8l3dmlsxHHpbBAMpxvQB6dG17HE0H92lphfb5W0lDaS+LrovTyuD5WvfvncqVoDUURncwEZhJ8iTR2OXwzBsZKRxcSOHhsRNGyOlZ8PO6U2mckSfFVv11VbCGk1RoW5J8Lmkk9Ml7hc4+4R022WeCiYBpl7joVjpTZuxH2PGJdA9v7YALbWv74YKpby0B4yxNPw1TslG7mg5+p7sPqbXwEe3dvOL81Hlk/CnBBHKsL2W1KHb+TTCyBHhUhuQ4W4rElTQ==
Received: from BN9PR03CA0561.namprd03.prod.outlook.com (2603:10b6:408:138::26)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:52:53 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:138:cafe::ba) by BN9PR03CA0561.outlook.office365.com
 (2603:10b6:408:138::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 08:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 08:52:51 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 9 Sep
 2025 01:52:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 9 Sep 2025 01:52:35 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 9 Sep 2025 01:52:31 -0700
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
Subject: [PATCH RFC net-next 0/5] selftests: drv-net: Convert XDP program to bpf_dynptr
Date: Tue, 9 Sep 2025 11:52:31 +0300
Message-ID: <20250909085236.2234306-1-noren@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ec681cf5-e896-40eb-8540-08ddef7e429b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kuh5kBgbu5Zj4kfe+hMErNlqGNDr19QcTwucCBFJPhTxkGYFk1U4WDCm6kqp?=
 =?us-ascii?Q?nGrrRcNa1dwKXE+N+ATlDAKSgIB6/tfQle5auwE9QBINWQqVL96noE+t4MKk?=
 =?us-ascii?Q?s0dx2ikHCXxLo767gFDebRp650IBJCQFyyUpKA7BZP0UJ8UPaa27E2BPmF7S?=
 =?us-ascii?Q?UbXbyvTB3+YRsby5RU2XULHA7yAH/znwSeTK8+xy5i9R3QdoY6jbcmEj+D7c?=
 =?us-ascii?Q?PUlxxgOra8Z5fcNfK7UZTXzZ19FD0mjR0ghhPr6aw9IhUV4LuXoJbKOCL0jl?=
 =?us-ascii?Q?qSjzfQfu0YzU2iEuEuo9O+KnXQ2GD6zIos2iFrXfS1RWyejSQgl8JKhcQGlE?=
 =?us-ascii?Q?GywI/RNPXvAluBUYudLM0lLcpilQKr8pZnY9p9n4MCLoY7RfjUYyQ7O02tWk?=
 =?us-ascii?Q?E11e38shar2pSiyN0EYaRAeJufFmZ2tjULT4NMM7Z7AXMZ2aXifdPRpUzUAi?=
 =?us-ascii?Q?3IyZ98sFmQ135zm9N8J05DBYwAungGaucj6nM+ynGosFOA0KlCpqtV+5DT2c?=
 =?us-ascii?Q?z0tXQaC0k8/VL8Nlm51q92qlogwJexpCTYmJ2UnHMpA/vhDN6wxIpG9LFZMX?=
 =?us-ascii?Q?YHKHO+RVbEUY1djOlBAp9PTlWYvIvfXN9ittvda7y0SzGtxThkZxtm/SPb+j?=
 =?us-ascii?Q?QfDYF0GvbQNH8ZdvV3Urap0hXPDo8qjZNckX2pbc0E1qRc9+m+zo5Udy5nUj?=
 =?us-ascii?Q?18narPDTjM0wu5inMNWDpc/BxwitHoXASkrsMtTXXwKubucY9QYKDnYdNtA1?=
 =?us-ascii?Q?g3jIlTugfVyH8TTtJR4d5nkrop71aOIVOaTp7o5QoiMH1fTU9ez5REXy94jL?=
 =?us-ascii?Q?vy7XGOoY9LhafvGyJO4notfDfXOl0jGTW9eJ7kH4onDJRG0OgX/Tuk6v+iO9?=
 =?us-ascii?Q?UbpeH5yoZ6jaiadI5EJKYiY1ENZOWda5qiTGqFYufnbhbbuLeEQV/XMYYrNZ?=
 =?us-ascii?Q?6J40bsM7kuObqcibRHP+5m4N1rp7vAxINaFPddiHZ6GP95vhgImaDGA/bAT8?=
 =?us-ascii?Q?UlNff2yld2cDoVTFN/QJa0xWWaKto4+atLWzuJE9cCgYdsAZwFm6DsdXoKeb?=
 =?us-ascii?Q?ES8hhyj2DQak15QaTOBCiZINlw0ISAz2JJ8JqMtiwE6Fwh5XaySp8+vbUj4l?=
 =?us-ascii?Q?h1CQelYk5c/Ro+f2fyGB0Z+f3Y3oNPnGjBODIXBxPmO9AX00M1gdFXk517hB?=
 =?us-ascii?Q?eyuHFlUDxs+je7GINSPNAteS781pEjNHY07u97bosiJx6vvqAd87kbwVJNHR?=
 =?us-ascii?Q?2Yp45uh9sTJny6+TDm6JCcGdPb4bWHef3gO2mH/2fYPyqHUFpqVi41693X0x?=
 =?us-ascii?Q?CfJAIBOfr18KlMuGuJJhEmIc0zb7F3AaSKZCJZHT9OKSLdkIaIskCo2kHlHA?=
 =?us-ascii?Q?znQOLW7DV6qhXNJ5LkkttRNtlarKmS2wKRoh/IczjZrdF/bYtcXk3VDlkHst?=
 =?us-ascii?Q?EsmFZIpFzq6UkJKMZ/wOguKjj5si9bG4Kj+Vl1XqGqjLNtQS7vZ7YDhtscK3?=
 =?us-ascii?Q?APHx5Bk81Kef5Wiql2v0OswX0DwZ5NJdfOvOEyNO1F3A8HjS+tlKDzwC1Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:52:51.7202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec681cf5-e896-40eb-8540-08ddef7e429b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821

Hi all,

This series updates the drv-net XDP program used by the new xdp.py selftest
to use the bpf_dynptr APIs for packet access.

The selftest itself is unchanged.

The original program accessed packet headers directly via
ctx->data/data_end, implicitly assuming headers are always in the linear
region. That assumption is incorrect for multi-buffer XDP and does not
hold across all drivers. For example, mlx5 with striding RQ can leave the
linear area empty, causing the multi-buffer cases to fail.

Switching to bpf_xdp_load/store_bytes would work but always incurs copies.
Instead, this series adopts bpf_dynptr, which provides safe,
verifier-checked access across both linear and fragmented areas while
avoiding copies.

Amery Hung has also proposed a series [1] that addresses the same issues in
the program, but through the use of bpf_xdp_pull_data. My series is not
intended as a replacement for that work, but rather as an exploration of
another viable solution, each of which may be preferable under different
circumstances.

In cases where the program does not return XDP_PASS, I believe dynptr has
an advantage since it avoids an extra copy. Conversely, when the program
returns XDP_PASS, bpf_xdp_pull_data may be preferable, as the copy will
be performed in any case during skb creation.

It may make sense to split the work into two separate programs, allowing us
to test both solutions independently. Alternatively, we can consider a
combined approach, where the more fitting solution is applied for each use
case. I welcome feedback on which direction would be most useful.

[1] https://lore.kernel.org/all/20250905173352.3759457-1-ameryhung@gmail.com/

Thanks!
Nimrod

Nimrod Oren (5):
  selftests: drv-net: Test XDP_TX with bpf_dynptr
  selftests: drv-net: Test XDP tail adjustment with bpf_dynptr
  selftests: drv-net: Test XDP head adjustment with bpf_dynptr
  selftests: drv-net: Adjust XDP header data with bpf_dynptr
  selftests: drv-net: Check XDP header data with bpf_dynptr

 .../selftests/net/lib/xdp_native.bpf.c        | 219 ++++++++----------
 1 file changed, 96 insertions(+), 123 deletions(-)

-- 
2.45.0


