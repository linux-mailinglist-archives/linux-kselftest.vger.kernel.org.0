Return-Path: <linux-kselftest+bounces-49276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 958CAD39600
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBE24305854E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D924233986C;
	Sun, 18 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="biOrjgYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020076.outbound.protection.outlook.com [52.101.229.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22FB33507B;
	Sun, 18 Jan 2026 13:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744523; cv=fail; b=PEdEoXfzzGWh2q1Ml+tRLHlZbwJYnnD3JK9Sy927BkrHsx4W9/kC2iOW92zXvGH4Dz88m5BpNFkR7vpDjQX8lPf6Rg9Exb6GGiJJ6P8hPsnDQjdFFbW9k/4wTmhboARrq+Qy44pOO4nvAEZI02c64epzBSVaLxroLkOiFNZT4lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744523; c=relaxed/simple;
	bh=DrTn6qHB+0v81jQAXyAPn6aPzrHivnTVhQx2GTgXvH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=atonHlE7gbWtwzsTpCM//1gHqSH0Ks1xHj+UySkfPTGDky9utONh+NYqRB55VMFP2e6rEOy/DXE84djsDB5HdDaaSYjzxzV85uWdReRA5Vbesfx4b3zPguAu5ruhEjCSCsneZdAzxx0IQUQxy3+pYBaoef7BvNljXYuI3bsDtT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=biOrjgYF; arc=fail smtp.client-ip=52.101.229.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbMe3R0DZq00ynFakhsb5DN5l5LGx1dlIcWe0wuzmppwsQzYu0yYbBxv7kJFmRwlKnARM4yasUYWQQe9NXAroL4joDIi+zusVbxZX/FUYjLTjHrtWqECIlF9C5w27AOs+0XT9vF4EEScX5Gck4n6zaCqPjzwCFbibcOi2nbq5z4hoklVre5IqTHBOdr/RFwmMfpmYCVpph3jcvxj886bn2XqmuXyW6bWTLYATyMiQiChHkbIpXhrSGLiSIOtaevcIgUSvzu+/ddynqcG/2JaOmpoFUvg7f3oi/vast4dg+EXQtCt3qPq/jo4/fG7M76Nlld5p4L6BQQ/CJxkvi2/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqSJE+I7QlsRgNp763mkkBx+mt6Cf3MvlK7qw4pKHAI=;
 b=AMVLAgx6hxMN+HpnCgo6/QrgsqJpMR/hXtGITcuYYwQiJJU+hsZXidXLHXX72c5F9wiOJJu8WEdqnW/T5u0b+PP62hLsCErYOvTCYTkXMb7vD6o6Qd1RtK2cHh/5STEF2w3bKRM1QtPyAsDfM0g1o1AAUMn+UneFhV46JhFhgq2O6+ujil4vXop63AGIlXUgLYCzcGUtB2mmNrDm6KEgvSnVspsD2u/1kV0rEQvEhG+rEJBWoUZpzYll/00Q/O+bPjlG47zqxncGKsoAf/LX1kPiCpmd5xfBoBA9K3CFtolxtr+lyefJpqxCYwbmXtmXLYOYR1+InfnADbEwBVHvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqSJE+I7QlsRgNp763mkkBx+mt6Cf3MvlK7qw4pKHAI=;
 b=biOrjgYFnCF0Coni6rlfIUSEvuE4BOFVkkRhObgpy3mbsV7wO+MzRvas2l1wayn5SrNC6Rxi6mcjgopdLbNfPnYApNN6CRE3J2WlU1rGJti9uwa+medfZjLMkvWwmwaRi12VSHF9iXqXumTTIeaQgkLjtiXMa63YGgYqqIZHALA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	cassel@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	robh@kernel.org,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: [RFC PATCH v4 11/38] NTB: core: Add .get_dma_dev() to ntb_dev_ops
Date: Sun, 18 Jan 2026 22:54:13 +0900
Message-ID: <20260118135440.1958279-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0026.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 60eb01f3-0602-4362-af5c-08de56992c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8KH8sloEuwsTKGb8OvnVBAwhyfoqX3T52d1Ys71pG4mwepWMja9/pvgqOHg?=
 =?us-ascii?Q?YYDiRZNY5GNdSmBnO+WXlpGZDjKmbfKDv4kF0nHz4lbdrjruTdAlESJFgJLk?=
 =?us-ascii?Q?dwoJL+8JtWhDWGH2evugBhO94Q1UWpsRFRHD3F/dPS/K9GdMlnRkm83NR5a5?=
 =?us-ascii?Q?uvDcDl9Rrocy56Im9B07+AIJBAosofy4naD6Ew4GLGt3hndNT8vb+bBDwsvf?=
 =?us-ascii?Q?L1JOXFSinrEVFUoO7NqNM5vgQ/MUUjpKqWY7y7YksblCVPj2PZbWvEC/aOFT?=
 =?us-ascii?Q?3A3+DLSxROcFuqRQ8b8V9KYuxKk42ei0NzuKYPB+LTOgy+UzCS8rXCEZQUuQ?=
 =?us-ascii?Q?ulZj1b/ceM9d2KcXJl+/LOBdeKroxmu99WVOfv5J8y3Aa+hwH99P2L1h7Bf0?=
 =?us-ascii?Q?V8+ilIj8lrjGQuDoBvNjUYkEcEcHEfCfAOxr4yazpRurvAhpC0Z/KGI1tjR7?=
 =?us-ascii?Q?14dkpmJFXcWAED/yaX8gRWVyPESeIHc5VUlZSX4B91JBCfa2IS1aWcu2QyCE?=
 =?us-ascii?Q?NCkXWo7zyFbMjoFSZEEhpGluVig7KqnN+3Z6wRJ8uhVs9QR48htgr/BzGhYj?=
 =?us-ascii?Q?LwIcOLgsdCqdzBUywSM/ASd77AgQsouRIcG4QfcqkPVsuto2TEV5cjXBSOBY?=
 =?us-ascii?Q?XuxKOD8lgGzzCr+NEFcjiugF/baGrZcj7LG4CXBcEbblHhlWKiMz01HdNB4b?=
 =?us-ascii?Q?kzXZCOKWYNqNBwr4xL0Y2HCMkVFJBUjmwyHjmoQCjihBqo8fb8eco9aYYWi0?=
 =?us-ascii?Q?5LSSdGEvWxziKS2anjpprAHWFZEM4y+bCGz0GFXzZ503RxZR0UvA/O7JrXm9?=
 =?us-ascii?Q?hP243NLihbDGMyLOko2lQRn3WvBwaSrMxpF80kVoRkZbKKnzAkqsGv9P3oBh?=
 =?us-ascii?Q?kLVGK77P6aAN23MLhB+1CKDDTmMzUefZduyDuhTJl4TRmElap0PN4rNAIitm?=
 =?us-ascii?Q?tPAw/hvP/Kgkrcn+zBeqonnCDAAiHaWPR9DlrYlshNNCXr3MZwqRccasEDPz?=
 =?us-ascii?Q?ost2324oZf5YeJqlbgDJXzuDDtwwKLBeYxGg3myN9B2LL3u82k8GN7Kbs4uY?=
 =?us-ascii?Q?DQsDsohd3IbQFhWEW+svUi27jfQAIAfgF7l+S/xeY4QFWreMwqIob5xKL66R?=
 =?us-ascii?Q?dwRuHsxEcoYLdPq9uMOt4z8fUBkYs3urXg3LczzdiiQ6Y7ITRfKRlZCnQ9ye?=
 =?us-ascii?Q?HFbunJa46GSxEsl6BZBx5CQntErYT6Ax1Y9HDYGn9rJzI8cCEfbnYhO5t48k?=
 =?us-ascii?Q?OO3Ap/400XUiYsUJEPP5XmaHXry9PdsT/fuSlfFrhOyTViOJnsnSU77uRI0n?=
 =?us-ascii?Q?YIT/tC9TXeW5NWnsKt2IMSSXn2DH90246zO+TwM7bFWqpdazUBQ7y0fwWp7r?=
 =?us-ascii?Q?Us1DkBybUHBPwoyXG+WKcv8m7CMnDRQOvRMwxjwDEC3YtE+FcA7EHBmBGUGJ?=
 =?us-ascii?Q?wxzkCEPS42fbwM2K35wbNzElNJM1Ul8eiSwUso2Rt9shxLv84tQf3YCOK67F?=
 =?us-ascii?Q?fkqZ+oM0PF1iXoQuHFUpzlUFfZjlXu5gRubQVDXhn4s2saDhqUDNQXt6a1Nh?=
 =?us-ascii?Q?9o+9spbM83Qe40TOK0+2/35gaxooR5OG4soFBi8nevZ3i/qPRobLsHOz4ocb?=
 =?us-ascii?Q?2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rp0xkuyC2JgXI5xsMsHmnkYGAaAvkVvJvSPDTHj6PODIu1pGn/uqL3qkju8s?=
 =?us-ascii?Q?nsdEQwIIx87cpRT7XbewPMQM6iYcN3jcgvtyUXksQOwpcxxy4Mub+ThJ1UzG?=
 =?us-ascii?Q?ePO9PZWQCj2HivFZczXy+0G3Bw5IyZZuL6wVyBNmvHoBAcaI4yQqqwIRZgW2?=
 =?us-ascii?Q?tBzfaZsWFmiJKMt/nfPTRRqDslfOPthXdcsgV+r1LTEgkahyeUbBlwsaBI23?=
 =?us-ascii?Q?LnuIqXTOrCGo2dGlznapeQ0EZNIU4cxXRWOG7OpnSxgFYtVtj7IYtVVti8vc?=
 =?us-ascii?Q?HfGTFJ3wtrym6g+0kTylWuzhiEQ2LeGKU5x8qJM3Vsfdk9p14Jy6cuwaWNmU?=
 =?us-ascii?Q?cpe8A2Z7svmdx5eC7bOHxGM7sPX+aANXoIrlHUgT4qtiyH23xwge68xzoHgb?=
 =?us-ascii?Q?ZPeFxFLmpHB0/1yfOWnO5CbSaExsGAk4gADjkJeRWvXIOt3dCcp0x0dg45c5?=
 =?us-ascii?Q?vzJHK9JP69r6n8ycB5QBbiUdqpKO8IvJBHsiULeul5yyDoBv16mN+vV6etrU?=
 =?us-ascii?Q?Oi5nca7LC4u9tp4Vx4qzkHvhlB4A/ty+abeCbbWUKCHnFU7A68lZmTlwNKtZ?=
 =?us-ascii?Q?z1ofdFTSrkC/djPOA3c1YVn5NGrCEEURKcTSgPPetTQP0aXijuLw0LWczlpo?=
 =?us-ascii?Q?u16IEAJb9Hkx+0+Dd1lwGHs0IQcwj57xgh76/SASZqPKjGHnCuM+YbjtOLql?=
 =?us-ascii?Q?KrpOhgFlkiUTgoZFrO662CEflNLlXV75HKtCwM2gCTT8ali2qcUPsLYyCkcL?=
 =?us-ascii?Q?UgtCQXkwI+oqscKQahI3MwhKP1NQ9GDQzWyRIF1/15rd0oFPG9COLnQIi8NQ?=
 =?us-ascii?Q?ZescWa92M0ysEZ0YjqoL57mSHknXUYGrLeoloCAaFdBaecuW8za2In91LguK?=
 =?us-ascii?Q?ffOiT3lHe0HhM4VhLCnv+ceSFszh+6rIevaaRhJ0/f5fe/gjY/+3oy0fI0s1?=
 =?us-ascii?Q?kZU3tAwRAkJDHa8NckbHH/Q+3rW3cLd3MZpC2ocFUwyXgaBTKsSyWF5zMonq?=
 =?us-ascii?Q?/EUChsv54JmwmO7rjDqlJZtg1sEk/aBiNjoilu5WSlMHXWYFUAbRfXPEkdj8?=
 =?us-ascii?Q?ot5cPg5942wS2ZMBpMbj2pqa+Q+ZSh+F+NkNCx7xzHv0h1V/skT8I1D2TGFC?=
 =?us-ascii?Q?ijBIW0y0UsZrIMmL6Yl7IcZGT8UiAOvhqYlBb5czTqGSw1XNQablhcFw9gP3?=
 =?us-ascii?Q?atPWaxDnZpGw48rI2lO8vNL0tucmCMowxsGV74M90AjM8rKVvsmXnBCEhNzj?=
 =?us-ascii?Q?RY4r5ovaaSSR83MgSmDdy8dkfrfyEjMfLp2puUHvSgaHCd4ggsLdXmIS9v5o?=
 =?us-ascii?Q?uVAQDxbtvBvjAf7rg8SO2NT2i4n2hgKalYr5uDOuJ6X07KTjYJuBqlQaXwx/?=
 =?us-ascii?Q?vO3mzPFb0yc/G6xSwLY8HGiPvCbclUQmn9vzOqhvfnyd9OAD5WbcuFXvr2+t?=
 =?us-ascii?Q?gP++x1wMNVYYO60xN67LqzSP1l7bqjL9DV2rWgr6cV/o3vTV4Ml0WlbsEJwW?=
 =?us-ascii?Q?5DHYkhDLVrBcWGH5RvuKwrsB4tOBFNSZSGwM2aRiMrQhqvXNsEqT02qDC9xC?=
 =?us-ascii?Q?oowQsNWWpdj/yEFR1DT28H9YAK0HPdmXjtiuss8c41maW1Dtle3hhNQm1SdR?=
 =?us-ascii?Q?Bz3xj+HHPN0VsfOz4XGlAXkZSLz6cdtTnYV5LrmZ0D7hgUIc80cMIPauX/K3?=
 =?us-ascii?Q?BY5HIv/gzP3kXgOVXnwBn05fnBab/qxHAuyQkDXBdFfqGY69BxndNFnyas2X?=
 =?us-ascii?Q?R7DBFONYotGTINbR0dIM0Ld8bGgLQHwpW/lOBKLuIGOJ3rNSIvx9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 60eb01f3-0602-4362-af5c-08de56992c94
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:01.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ReD9DqfYtcYzhUB1JtgSPwlpOFSHY5YGmLGuFiY3dNKJlKOQEot1Dx32GOYj0zscQpczdtbwWPRnPd2VabgQ9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Not all NTB implementations are able to naturally do DMA mapping through
the NTB PCI device itself (e.g. due to IOMMU topology or non-PCI backing
devices).

Add an optional .get_dma_dev() callback and helper so clients can use
the appropriate struct device for DMA API allocations and mappings.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 include/linux/ntb.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index aa888219732a..7ac8cb13e90d 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -262,6 +262,7 @@ struct ntb_mw_subrange {
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_dma_dev:	See ntb_get_dma_dev().
  * @get_private_data:	See ntb_get_private_data().
  */
 struct ntb_dev_ops {
@@ -339,6 +340,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	struct device *(*get_dma_dev)(struct ntb_dev *ntb);
 	void *(*get_private_data)(struct ntb_dev *ntb);
 };
 
@@ -405,6 +407,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		!ops->peer_msg_write == !ops->msg_count		&&
 
 		/* Miscellaneous optional callbacks */
+		/* ops->get_dma_dev				&& */
 		/* ops->get_private_data			&& */
 		1;
 }
@@ -1614,6 +1617,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_dma_dev() - get the device suitable for DMA mapping
+ * @ntb:	NTB device context.
+ *
+ * Retrieve a struct device which is suitable for DMA mapping.
+ *
+ * Return: Pointer to struct device.
+ */
+static inline struct device __maybe_unused *ntb_get_dma_dev(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_dma_dev)
+		return ntb->dev.parent;
+	return ntb->ops->get_dma_dev(ntb);
+}
+
 /**
  * ntb_get_private_data() - get private data specific to the hardware driver
  * @ntb:	NTB device context.
-- 
2.51.0


