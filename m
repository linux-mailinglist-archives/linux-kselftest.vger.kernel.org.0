Return-Path: <linux-kselftest+bounces-7834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 625A08A345E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB7DBB24112
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FBE14E2D7;
	Fri, 12 Apr 2024 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iw2dVrRW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CB14D2B7;
	Fri, 12 Apr 2024 17:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941565; cv=fail; b=LsZ3oS+eCyASFaQQmdZgb1LXVuUrNzrAon/dGQhY8kRKpmfsqy6MAdCZNpqG26Qv8yGImhmKEdfoOW/dLDb25hjHwtz6p1NWrRL0anFA7ntQpOebbHY1QKJG6jeTxU9ruu1jxWzGdlFI/gtMBPUHLBY7xEp9cH2vk+iwapfh6Ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941565; c=relaxed/simple;
	bh=34TYIFjwAZVJDDkR3S4BqRdwI6qpi7VdlwWVqs+5iFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KU69nrOJO2nFbzdfFdztWNKQml5P+04gTUYx9EADtWSyGRBq+4f+WKYDJtHLjVChKFzEPL9QkKLwbv7i8AIgMhElzWPSQmGu2NUoMQh2uaojsxjVkGuEo+J+56siR3c/6Hp5MYMG4b1aMwDyWy29dr+Iei0V1dm2P3Gg9gb/OK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iw2dVrRW; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1Zkd6ONnHhgwdZPdelR44SQnC7FsUhZ0u1uEwkTgpKhNt8g0wPKAnFW2tSM07ZJWsz2QqhuWQ6u6+Scx740t6ZYN2IQ1glLwLOJJ2wlHGmT3z813TMylwXCkarnp6L5D3hI2ei9Pzqvd0flCyuYh2mtqA+CqG5xCsXZvp8oMZbBM9jdGKi0T5dIRdaR3F/sfRSCxD/6ZVI2ZP1Kyonqb8oA1WA2M5vnx/Dn4OSbG7WQaoIAmQbtDTLqEGLumj3FZr8BjeF3/LJPwM9+5lrxFsTCWwShxs/8jjShnqq/9RUxy5lLlqSqpzTDlDbv3pTMZH39UXEquQNnfJM+PhXl6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwtjWUQDN84A57tCUM8moOjJsU/1SbrWABgTuCj29pE=;
 b=OjtjB5Xv81XMhSWkk4r3pWN7rpyMfBp7kC25MY3IrO9Yjwe83c7fNEOoef6tufHAVbijkaQgx57sNVXgzvNku0/+50FBVz8C2rQ4nj9n7G8MIdiU6GV7IOL5rju9T/9uG2+xOznWm3Jw5Ee9Os3nL3W35gKNJwcz3qANxp3a1sjx2Arc3dRVymi+TXGyDSoMKvsR9R7qWC4cwMW/XRGJ11EmDd5dRp8Y8soboRNsU1r/2JtmtzSEPAbWshxYPWaut4Hrt+WE09RcyaNLQCHM0MiFDfj5sWhsUexdMBs+lIathdpmnzKof0u+XBH0uLuJ1MV61DDyn15PH1empBvm+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwtjWUQDN84A57tCUM8moOjJsU/1SbrWABgTuCj29pE=;
 b=iw2dVrRW/M5Pt0soBCFg0wTHwq3HYOJik6k5HRoJJWgqP2aflXeOMJf5od7Te6tVuvEWRG0XdnMLREf6uUa20zlwkAX88hifPaHTQJ45e+QO4CEgo0TnUhQdRZVRp3lpzYma7LDgAPwcTf7gM+Q+jCnCmPr40jAE1I9QN1NHGY6DtsRWo0mbE8QcbejMFeo2gbujjOjeWCxS6+ilSuRQPJ3AK+bMj8LwM3loKLini8JzqyJZsT1Y7o89ft76JN44Qp1waI2zKBOwykkrlVpSRR9YJISgCWPEAO93rduxQ5//xjTb60Sj1EnfC2QLShGMnP76Cq6Qg1oUH4hoxJZq5Q==
Received: from MW4PR03CA0124.namprd03.prod.outlook.com (2603:10b6:303:8c::9)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 17:06:00 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:303:8c:cafe::a3) by MW4PR03CA0124.outlook.office365.com
 (2603:10b6:303:8c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 17:05:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:05:33 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/10] selftests: Assortment of fixes
Date: Fri, 12 Apr 2024 19:03:03 +0200
Message-ID: <cover.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 9af903ca-55c5-487d-ae6a-08dc5b12d3c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	n+31oAIB3w09xUxxabEh5vJot8IoNPJL5MOO4lIajSRpHO1c+X6zljkDsRftzgbJ3FZEMpMBPSg4aRlEfiCgVo8cD8w9yUXnBp1b0pmGWGFpAE3jjwUSoLL0/qEdheneKLlGNB/IeSwbF8gGOu0WYm3ci5nR8gwZozm5jZIh3B1y/57fWmio/i+fq1z7BhurrLautNb/8yfty7cMmp5Me12lV49E/0MPf4Ibl4/FzVnIemxNtPuM2bwEYxWxnWpuE8ydiXDKTyktLAP8MBlJVZzTBY/h7pB/q28sM52QV+WdzcA+FQKpSeKBucX1OtQSN2/E51QhBm27xtACBI+3Lmw+M2FU+civMnBUO3QOvzdTDG9SGzyPoODTaysHFs3hgxHBXBO28v/m5rcMFoggOXz5ze8vxYQzIOHM3d7AWk2RnC3wtlHA21NX9PrK6c9uZkY+uDUnTKo9BE8dylzUhVHADuajAz0GdKl0FsKD91QxScaVJiozPwVMuNftPq8dn5iCR08W6YARVCUVfMVlUDcpIeMTsXtHSecECp+M8QQtVMy/8BEU84zhVddNGp6b+JJRVr/DzI/+igWYHwMypHOKuk4r19Atv5NYEHA9SZtKVIUETLVZ9mH2vLGyEKrDUzq9M3uAbuWi88OY88rFWAW3ITyMOq21Iuf0iYeU0rU/VqlFCvHDB5ST3PIPNn1tfo1I+/ng8oifrh4oJaiLwKWo11GJWPFcyYWbeNbn8eFOU6mdDw1rCqcsxrMqgszK
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:05:59.9226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af903ca-55c5-487d-ae6a-08dc5b12d3c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074

This is a loose follow-up to the Kernel CI patchset posted recently. It
contains various fixes that were supposed to be part of said patchset, but
didn't fit due to its size. The latter 4 patches were written independently
of the CI effort, but again didn't fit in their intended patchsets.

- Patch #1 unifies code of two very similar looking functions, busywait()
  and slowwait().

- Patch #2 adds sanity checks around the setting of NETIFS, which carries
  list of interfaces to run on.

- Patch #3 changes bail_on_lldpad() to SKIP instead of FAILing.

- Patches #4 to #7 fix issues in selftests.

- Patches #8 to #10 add topology diagrams to several selftests.
  This should have been part of the mlxsw leg of NH group stats patches,
  but again, it did not fit in due to size.

Danielle Ratson (1):
  selftests: mlxsw: ethtool_lanes: Wait for lanes parameter dump
    explicitly

Petr Machata (9):
  selftests: net: Unify code of busywait() and slowwait()
  selftests: forwarding: lib.sh: Validate NETIFS
  selftests: forwarding: bail_on_lldpad() should SKIP
  selftests: drivers: hw: Fix ethtool_rmon
  selftests: drivers: hw: ethtool.sh: Adjust output
  selftests: drivers: hw: Include tc_common.sh in hw_stats_l3
  selftests: forwarding: router_mpath_nh: Add a diagram
  selftests: forwarding: router_mpath_nh_res: Add a diagram
  selftests: forwarding: router_nh: Add a diagram

 .../selftests/drivers/net/hw/ethtool.sh       | 15 +++---
 .../selftests/drivers/net/hw/ethtool_rmon.sh  |  1 +
 .../selftests/drivers/net/hw/hw_stats_l3.sh   |  1 +
 .../drivers/net/hw/hw_stats_l3_gre.sh         |  1 +
 .../drivers/net/mlxsw/ethtool_lanes.sh        | 14 +++---
 tools/testing/selftests/net/forwarding/lib.sh | 49 +++++++++----------
 .../net/forwarding/router_mpath_nh.sh         | 35 +++++++++++++
 .../net/forwarding/router_mpath_nh_res.sh     | 35 +++++++++++++
 .../selftests/net/forwarding/router_nh.sh     | 14 ++++++
 tools/testing/selftests/net/lib.sh            | 16 ++++--
 10 files changed, 137 insertions(+), 44 deletions(-)

-- 
2.43.0


