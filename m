Return-Path: <linux-kselftest+bounces-6753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0CB88F5FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 04:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B9AB251B6
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 03:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFE5376E1;
	Thu, 28 Mar 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ohDkPxPF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026492C6AE;
	Thu, 28 Mar 2024 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711596869; cv=fail; b=IyUrV4k4qVEoPRXi/anGHe3L2vBMPISAkgcq6/avH3m66rV+40bC5Ed4Qb3C5JkNfttifG2XyGmJivQNuAIY2iXTTLvo8cwLsnGCjpDY7b6+sf/sMvy13fTNYCOmcif/EwhOm6YFMPXbTFCq83LiRe6BSwT+4D52vkAduc1Yb2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711596869; c=relaxed/simple;
	bh=n55iy/vk4fhRlWKDRGd9F3jOKyZp7oXq4kMQplqzoJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdJIgZ17iILFaRa6AWMolKAmbAo0zzNGXFgya860LJeuhcOJngnSOBvrGprVQHMOzyIfk+/xcnNryFmkWKoxnN4KMn431bIk0C11TXWVBXjlCm3l/1EcH4HCbhX3m5Dako0qeqYd+wsbKPtmAn2MN1mIPb4fmcMZLIeEEZO8okg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ohDkPxPF; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/RM0ocJrDZdgofUAOBVWIRLzoWERNu1AthB2tqNoVf3INw7AEHA/JqEOS+9shY1P8h44zGcaFlUHK5p5s9Jq7dcKhvTswaXOimulKTW5d70K5bP6AlVj63Re6sC0VGbxjtS7+F3hzvuyIOnP4LfLOlw7seraU5oo6r33K0UuKOVCHuSDy9GMhp+qq0+kSdlQ7BQLdYDqnfvA5dWfZ6EFru0ikuYt3yBpVsh9kqlohn3Pkvg7qLq2kXxepPj60aszLOhERvd388l13uon2tgrvf8rCrb4mC9MrmdidGV5cL6Q9O+5oZCVAMBZyMSjgRYXU6mH2I0NE7BmRtvNxaOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNhHfobMEDWuzlS7JbbionFkEvqgOb/lKmGYLiqEtGw=;
 b=WZPUA7QLnE/xFOhb1ZZajoZaLs5hD9cZxdsSVeCuW4d7RiGM+hDCb5Cxx/wyA2VhoZlrC2NbaTr2TEYsCyI6pTR8baUsUzL+iHLO8hhGQuHIKLNbNo5kH8uC2+I5Nkiksx5g3hLJhvai/gCae2y/qXd5kYTl0v9LFD9QUjbeTRuPa4CbTX3R4C3yV7cWgVMPJpgO2X78oRvow8U0ZnoJ0rcrpaQ+9zVWS7/UKzED+hLfnB7vuq5GCO6WpzUxw2XgHG9USX6dvgcbvjISpo9iJ681yTDwcuT97a4EQ3IGx27KjypQ6lwkyid2RVOsAQSgrwknuxQqJC+Rf8CG8r1t9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNhHfobMEDWuzlS7JbbionFkEvqgOb/lKmGYLiqEtGw=;
 b=ohDkPxPF7WMjtAcmHl5WngsoQBRkO9awPwwkT7j9a0kQhQwvBqhqmXt9HPwuSe6XgJ8sr4N+aCKnw48PJzr9J+469XKRFiEJnEn2OAlS6TapLrgvwVYbXLNB3eMdTYkctSelrbT/aTxh1Adr99RBGG9j1010Gu4vkzm/eH2nlIUmYwVZEKApvulANtQfHvC3sxzUKYqJK42r1yS2FuI+o/7WYJ90qJ0Y3Vd1gI/SUVKSOzvzmmgfVYfo7MwXN1o1lmV9AdoFKzxchfQID+swC4rmWjm4N9vAioxTS+oOM7oN330R/X4ynGE3h9w8Sv1WyiGvCy/PIv6sXOPthVGjmg==
Received: from SN7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::27)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:34:23 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::e6) by SN7P220CA0022.outlook.office365.com
 (2603:10b6:806:123::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 03:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 03:34:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 20:34:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 20:34:19 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 20:34:19 -0700
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, "Andrea
 Arcangeli" <aarcange@redhat.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "John
 Hubbard" <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Suren Baghdasaryan
	<surenb@google.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/2] selftests: break the dependency upon local header files
Date: Wed, 27 Mar 2024 20:34:17 -0700
Message-ID: <20240328033418.203790-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328033418.203790-1-jhubbard@nvidia.com>
References: <20240328033418.203790-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: deb24cf7-5bf4-44e2-75ab-08dc4ed7f5d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D+3HxM5SCBfV1nnapqq89UylFlWZaGJ1LoX71iFkc4B3YPU1Bmn4+i45nj1/g5NvdGrfOJZQdTeD7Y6adhuiiShAmPkxi/f7Sx/LO6BR7rzLAopdKyx+zu79NPBflL66BGGepDBYDecd+xsHeeRbginL4XnhLlShyVqxE7MQ6iGfNcgWIxXx+rZwaBjHf8/XxB/BX0PeCq06Mj02Jfh1CtN51yyWfLzDFEo7YmlgBEzhuI0gZqbEMcxGnZv6vkDT/Bl+ZLRwJU1EaA4+coBGw4N7X9XjiyYWwp1kVV3imxdzCD40UesD/FgBZfocenl/KGRwCzO4trT+GcoCxmbyffkf34vq9YQq4CDHtsdY4+gHL+Ep2r7u/IALAhQngswZW/1LZuXfo6QXJz7HqyV2kvjiKxRaw/9ET/jFsfiGriNqZDU2RISH6XlNdWS2rdImYnOWrTfnzbWUGduoFIs65WbLTH0yWH2OYCf1j+zD4wejE7wUf/r5+TSFXcs328swen+D5BUFcWiuTg91OdxClIT2zTP4u0+Rbh2eKQAcJxIIZPL4YOn82J1qgggPPl04s3uJFYKOw0gdSCpCyCfzJoWgWBIGuV5pIGr2n3DhNeC8PYBedjJ2Wiyr5hqT/6y70wd6vtzxtrU0D5neiNLwvk59QoBtQSVEMebf2QLF0dUmSETK1jIH9R/CserGG1i/ssXFfrzAMsLXd9KkAq+XFKf+SbNwESt571XqiCZ/VufuXYWHpfJDfXe2uutPWyQi
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(7416005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:34:22.8055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deb24cf7-5bf4-44e2-75ab-08dc4ed7f5d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250

Use tools/include/uapi/ files instead. These are obtained by taking a
snapshot: run "make headers" at the top level, then copy the desired
header file into the appropriate subdir in tools/uapi/.

This was discussed and solved in [1].

However, even before copying any additional files there, there are
already quite a few in tools/include/uapi already. And these will
immediately fix a number of selftests/mm build failures.

So this patch:

a) Adds TOOLS_INCLUDES to selftests/lib.mk, so that all selftests can
immediately and easily include the snapshotted header files.

b) Uses $(TOOLS_INCLUDES) in the selftests/mm build. On today's Arch
Linux, this already fixes all build errors except for a few
userfaultfd.h (those will be addressed in a subsequent patch).

[1] https://lore.kernel.org/all/783a4178-1dec-4e30-989a-5174b8176b09@redhat.com/

Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/lib.mk      | 9 +++++++++
 tools/testing/selftests/mm/Makefile | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index da2cade3bab0..1dae4a02957f 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -48,6 +48,15 @@ ifeq ($(KHDR_INCLUDES),)
 KHDR_INCLUDES := -isystem $(top_srcdir)/usr/include
 endif
 
+# In order to use newer items that haven't yet been added to the user's system
+# header files, add $(TOOLS_INCLUDES) to the compiler invocation in each
+# each selftest.
+# You may need to add files to that location, or to refresh an existing file. In
+# order to do that, run "make headers" from $(top_srcdir), then copy the
+# header file that you want from $(top_srcdir)/usr/include/... , to the matching
+# subdir in $(TOOLS_INCLUDE).
+TOOLS_INCLUDES := -isystem $(top_srcdir)/tools/include/uapi
+
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
 # custom build rule and prevent common build rule use.
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eb5f39a2668b..7ca9186a0639 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -32,7 +32,7 @@ endif
 # LDLIBS.
 MAKEFLAGS += --no-builtin-rules
 
-CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
+CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
 TEST_GEN_FILES = cow
-- 
2.44.0


