Return-Path: <linux-kselftest+bounces-49265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 246C2D395A2
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E308530084DD
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF49332EAD;
	Sun, 18 Jan 2026 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="u/HVnz2P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D6E32C92D;
	Sun, 18 Jan 2026 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744503; cv=fail; b=FFiMOAQav4XMQ6CJpLpLylPCCVgmY8Rs9n1+8IVhD2Ua6BDIyA8HGt17NlWJcUPYTh6g/EeqsXnzKmpqw43fHeeiEGR1v2uIiE0wxtV5gwzOKly/9s6VnJe1bw08q2RTd+5CQjQV0u7s7TzkfNf18ua2Fq6X6bbgVfp1W5GzoNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744503; c=relaxed/simple;
	bh=+iy1xqR4pk8RoncmPQ1Wc8ymJtYNMQg42WJeRMFjjgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UmbPE/Kwgize1oXlrSw3Kq3NAjuK2a0a+V9Ru6rkFXt/s2dNUAAMkBZCs2BXDk66Iq5EtEsOMRiHFJh6ftZdN7dLjaFoxxyjy2U/KKlLvgUaHXVadn+kIgXrvGVPM18B7VeS/lZ1SYxXszG8B/cpGoAdoqemlpBm6FaMnX8Nhlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=u/HVnz2P; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WQGwLUtsUZ7Wlaoii4hddc5oCIY9poxhq+x6QGfLcaCIgHIja+nctTMvZz3J3V0IpGB5Z/iYursU30f7B3HO9VZD+nSHNLoeMwF1rFyxxPoUUiKr3VH6EEIlJuAFhLAawGga0H2g9uc5UiKLuUErLXfaLP8+a9/92yJ5o/ICYyIYqhIxe47Kj4u3cpPTYPGF+ilJz2A41DUvAPXLDolmXAK1U1aCDXKcE+ZKomHdCtUdj1azlcRTLs/9PmLPbiU2xwQW5MYG+DqLGzYufVIJOBMC8WQFEHVYqKBPaoNdUeaFXU7QjVKDfOM0zx1iNIqttX91jqnnTCwX/x+UJMpCVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soYmfl9sH1N0V15SoLhCRg52Cnbyyy1W+L8vWv95LAE=;
 b=uM6ZumJvNaOjuL2Hz1DWkPzKoGx1MsduNv5dY3+RyBCELdW/xLtNhahiD7u458SRsbpYLiSv56Zzc40qbGHspB/XeJhRLEYzl/KdHsLVKjr2L1y/3OL4x7o7MmZeY2eXiAaklvrlopyj+Q0p4r4Bf0bghu1IVm9zNT/r5jkd3C3+jjMlYmPaLsFmESJ84wsDcXzq6TqLya50K0HM28BpbaoXg908qoRHIvYyzxFs8yKEnEmW2rfLT4Wub5QYvLcYx5SwGQComP0xrTYT49EJbNHdTYOTBruIUYSFilc6zX7hr3HADQbw0del+hradPZm/vRHsBzfpt624O6t1KmeQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soYmfl9sH1N0V15SoLhCRg52Cnbyyy1W+L8vWv95LAE=;
 b=u/HVnz2PLD6fK/lgbSKqofKWrQvFbxppbhJCWPafY2lhsvsHXorsVu2yShoAkOVCLykG5aPM0LNZgRStLAjE3LTrifiZ/xf3lb8MKLvtWpt/6KJauoYjF3ho7egq/k+cgKDns9YtE90EvaoGMJEDJR7IjpWTGfIiYPoylycanE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:53 +0000
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
Subject: [RFC PATCH v4 02/38] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Sun, 18 Jan 2026 22:54:04 +0900
Message-ID: <20260118135440.1958279-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: d541e4a0-66f9-4155-4877-08de5699280c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URMDkoZV9k/+BfT6aSq4pe7Dp+TJNceVpyszZWPcIOVaVDqvXCtFbp9M9TaS?=
 =?us-ascii?Q?luuXpqCWXiix6dwZX9buJ5M5wauEfzz8c4IPfUFoIGBX+gcYI8gM2EXEzUB0?=
 =?us-ascii?Q?/ho6zf/yodmWHERmEsEhfSXOae1KkNBqq1zO5U5ausL5ACe4tkmaNtVpa0x2?=
 =?us-ascii?Q?qp3TW6QTH1F26LAA57d5Ps8uSg0kX98o8g/nwjiau6EHkCdsVdKDn138TZ8X?=
 =?us-ascii?Q?JhZNbNwIa0fam84pAUu3Ekn5ZmS/dKzpkzqy/ynifvmotSPfcK6qjnSBrkK7?=
 =?us-ascii?Q?y8u3QlMItxiWpQRj3cQnQSndqORudnaDcP4CivLF/cKPuP5X1ubjCGBFof+x?=
 =?us-ascii?Q?S87T4Z2q54+Hi2wsD9N+BknRY/wePZ8RO5GSQ7+eiZRBfFfY5hlaHyreeMK9?=
 =?us-ascii?Q?hccNaBkSUlU2CAPDyktcYjq24v+kHrWRHjpDM+fLQDRIVNEh3sR001xDt8bj?=
 =?us-ascii?Q?oIR8uxhBmeLuYs7iCNdNPxMPlZiw4p1xBZusZWyGfwt47wZcx6pQKgvs4mIL?=
 =?us-ascii?Q?ROK3+6KisPHwus/P5/F4q4hda4fX/5Ggrp0QftB9jQqlAr3O91OiXLBG1g8v?=
 =?us-ascii?Q?0jKLnabnhTVHWo9L/4S+EJJEs8AmKtbLVaBzNHB8PRpoTOR0S1Kv/Sl5ol4v?=
 =?us-ascii?Q?vy/Yn2B0YCRmk43KZz/uwMzybIj/I/Wf5/PEC3ezujabY1b2n7WLSQMDTwRA?=
 =?us-ascii?Q?bQBOkFJ5/vSEpfsL+8XxW5yPmOuU8BX++LC24E4Jv22AMHPu5HQ7NxrQ0OZb?=
 =?us-ascii?Q?j12MhdZYj/nH2Jb+1BiAnglzkGqjCOd6NHqkoMk4TbK6u3tGF9tNImSpn0Y3?=
 =?us-ascii?Q?pgr9T1rO12hI9cGCmHqGt+zQJc6EGkDBisNK+2Y10ZgSwK6sJGW7JpPEys5a?=
 =?us-ascii?Q?AcyWtAMasBvKD7LNxOKTicYO6Fts9R8XmgW59InMlW2SPA/xAYW7dezELww1?=
 =?us-ascii?Q?qIPdzybsZluxREMszv86S9XbNJyfIGqSGdMuqGWHx3V/gQYRKsr/VDdLYagS?=
 =?us-ascii?Q?7Y0zVKKcB/kTuglFvdaUDiBUYdTbYxB3Pi9rVXOwEfMNZM0I96J8RzypVczJ?=
 =?us-ascii?Q?vOtms0bMj66wnSHzWCC1ErPidvwK0UTm7OuTueCTq77HwZHqGE8Xj3sYIe7i?=
 =?us-ascii?Q?xkecx8QRDDkqEAcuNI8CDGsNk+SL9LjEHO1/WbzsOCtWZ4Jq2mr/GwPkj3vt?=
 =?us-ascii?Q?/NB+DWfeiw7L/UPYzaACCs+DXrpV3/uDEAITta/85N4yUSPuE4vJxqoLInFd?=
 =?us-ascii?Q?5EaVvuVZdSiDUJLqaYrqe7dRoMZtPlqwY5vAlTj+pVvM99tAYDOqs0AfWQiG?=
 =?us-ascii?Q?zHsRbTppNLC7LZ9GVZdoP3W00BQiWY1iXzBKEN8P/r02irf8NqO+ZM4sR7Bk?=
 =?us-ascii?Q?fjfzAG30g20aJLZTA/WKF0iDrBC5Hux80udvRlGNtfez1Ydl7NWZSbRgIlpe?=
 =?us-ascii?Q?x2bJCmKYVUIWwC4/Rz0YlDM7vAAksjWUd3fF7AQns8CU2K3Bh2bVaaCXqs96?=
 =?us-ascii?Q?tAT7Ntng3c6ubXq5Pcpw1IK5XSMVs4YGQzalBClTMSJX2GkNy86xcLrw5HF2?=
 =?us-ascii?Q?wLRCBCiyOEC21Mftkh8MK9FB3EObSZxGxuSBAI08jDk6bxfdpO15Miy5drN3?=
 =?us-ascii?Q?Yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8vK/TIeiPMRHso3/LedEx28AvTZ0TDVEJmwNtOFHAgMn331/eF9NAXlcXXoE?=
 =?us-ascii?Q?G7Llxk4vF47JzW4V7jWtGwOxC3nOdl6q6lUAKL5Bzom7UqVgUZ2eJRD65aO1?=
 =?us-ascii?Q?4VJPaIOCTHcNGHsrojXa6nF/Gddy8oCBLhEnZ+XkdjVO8UjVjJhqtHkXxNnl?=
 =?us-ascii?Q?9MsYKRPPJTjKHzrZ+FyB+A1QdostDodaBO9Jxe2Le3VAMotN/zrh5MtcfKwM?=
 =?us-ascii?Q?MIr9C0iEajYCQ67QZqOPIZwhCMJl+d1fPI3EJu9TFApX6gGGp3wBjBBOrWWg?=
 =?us-ascii?Q?F0iQ5LD1ZgeXvkRvK1QcX76kr8POltlQf+mFnuiI7NVFAMS4smNXtbg/F6W/?=
 =?us-ascii?Q?Z+37QMLW1t3/8WXg/MbaH7p+X1z5aQ2NxMSNAbH5Ya7cG/smrezzSRZFt8+C?=
 =?us-ascii?Q?WDxonzEdgOcGpyTqsVbpkc+WrunwFNW0BNNFhaiB0jXVlEinrM6++YXhMAtf?=
 =?us-ascii?Q?C/TSs79HQfOChrTY0ndf95AAKzF+cahVG42bh2JScCbHV28ZCBkRtWJ4c2v8?=
 =?us-ascii?Q?5Pk75g0En5eo5FIZrtL6QHOniCabXqNWhgeCHDAOenhsuqaMIipL4USSxGA/?=
 =?us-ascii?Q?BxVQ3zIRJpuUK1J2HHtkCD473+MZuwQ7uDl0s9M5kDrZj1Zpo0ARRSleaSiR?=
 =?us-ascii?Q?Vzco2xMjwbm1cLIqfbXO/nT4siKBEbJzz2gvA5OMWuO8QAcDcTeSEZ8mtdV3?=
 =?us-ascii?Q?83j+OYWhVpsfzVntMF3DMplMGmO352aTBKEaTHZDkNl3SMV8dPmEZda0YHXC?=
 =?us-ascii?Q?lN1KmcoD8+mpfAiGATGfWJcB2nIdIkhEwgRo8wPppyKyV9Dn6gWbic2p1yxc?=
 =?us-ascii?Q?Q9P15lPuVchoBJCgpZ1+UqIdSfoI5Q5g+8ObXrnD+ip+77UBsmibgqmyeudf?=
 =?us-ascii?Q?TSSo2F9D58ksUgqz4Xch1Wv4NMIklH4Nsaa56alp+DNbviicc1syjnrbXYQd?=
 =?us-ascii?Q?r9+FhyBfMViI84Hc1Kh8mzTXoqPH5VYaTZsPNzzMUXlxsd1+tjspxYDd4W2I?=
 =?us-ascii?Q?XR8TT3GLqbOZOtMF8iOToO1pK1Z/SbXZMxx5Fh/4jOZE1r/1aFp361/HjpIp?=
 =?us-ascii?Q?JDhGA08+1xW53c2Jt95/ZGAc8g4zqddefJo+leaa1vIicr+LLEhGgmsYm1un?=
 =?us-ascii?Q?OgRo7Wbhco1yjPX74WraczSP8mupW3OHfwK6xkin80MVrI24Mbcc7LYLkLuX?=
 =?us-ascii?Q?uTZJYPcla0uZiNQ+nSUUd1KAYHY86lI/LRax4FVPik237MS7+CcPkh+EoyE0?=
 =?us-ascii?Q?yaF2H4XnMOdl6Xo2m1uNkszo/ZLP6oED2wtpOBgnDgFks0MSZfqaC7NfD3bO?=
 =?us-ascii?Q?AePfV+DvS3xeyERlowmNM7wr+r+Y/I/RMKHGxV6uebTokdd5ov/up/Tz6C6p?=
 =?us-ascii?Q?zRVvnZBZdfTJx9zLFkNhgDUxwFta7EOPasJyBz8jB50IPSd9bZ4wjymVzdRV?=
 =?us-ascii?Q?YyCQgJxGzb1l0wBtWuL0hO6P/vxCDCG2ENk5Rj/+qlu1pPEgVDjaObX1BRLk?=
 =?us-ascii?Q?sGaN7BZfijxAOiYnHslWOcrv8LWB6LRohs/vphc8i2pXgm2RVzySTUhMRAbI?=
 =?us-ascii?Q?sVBlEfZgKzOdOR1cMoEdj0DA1bKat7/cnc4CRyTRB8l7mhQUVi0xJfHMHZvb?=
 =?us-ascii?Q?fDOsCKody9FYrzFOCrfLeTM5yk8duMQ73ZW1PkNsN80eEx2OBvBb0qlRMHyW?=
 =?us-ascii?Q?chZHXniB1SE1h5kJRCTUPyHgtEvLwyv+MiaI0+0c+7g/88wRp07PgNoyBalO?=
 =?us-ascii?Q?ZZUggd7FoN91JAQUxnub9yCRF4Dq7oBXSJ/fmZaPW8Atw/rX+IEp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d541e4a0-66f9-4155-4877-08de5699280c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:53.5483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iK88wo2bkBaQmjOHn0TZwgW7VIBPAcMuRtY8IlcxCusjLVlqwaoxE7knQTOZ6dbDwSHrrlC7rTUk2Sxp1M7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

DesignWare EP eDMA can generate interrupts both locally and remotely
(LIE/RIE). Remote eDMA users need to decide, per channel, whether
completions should be handled locally, remotely, or both. Unless
carefully configured, the endpoint and host would race to ack the
interrupt.

Introduce a per-channel interrupt routing mode and export small APIs to
configure and query it. Update v0 programming so that RIE and local
done/abort interrupt masking follow the selected mode. The default mode
keeps the original behavior, so unless the new APIs are explicitly used,
no functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 52 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
 include/linux/dma/edma.h              | 44 +++++++++++++++++++++++
 4 files changed, 116 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b9d59c3c0cb4..059b3996d383 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -768,6 +768,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
@@ -1062,6 +1063,57 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+int dw_edma_chan_irq_config(struct dma_chan *dchan,
+			    enum dw_edma_ch_irq_mode mode)
+{
+	struct dw_edma_chan *chan;
+
+	switch (mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+	case DW_EDMA_CH_IRQ_REMOTE:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!dchan || !dchan->device)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return -ENODEV;
+
+	chan->irq_mode = mode;
+
+	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
+		 str_write_read(chan->dir == EDMA_DIR_WRITE),
+		 chan->id, mode);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
+
+bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan;
+	struct dw_edma *dw;
+
+	if (!dchan || !dchan->device)
+		return false;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return false;
+
+	dw = chan->dw;
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..8458d676551a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 2850a9df80f5..80472148c335 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		raw_spin_lock_irqsave(&dw->lock, flags);
 
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index ffad10ff2cd6..6f50165ac084 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,23 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/*
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
+ * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
+ *
+ * Some implementations require using LIE=1/RIE=1 with the local interrupt
+ * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
+ * Write Interrupt Generation".
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -105,6 +122,22 @@ struct dw_edma_chip {
 #if IS_REACHABLE(CONFIG_DW_EDMA)
 int dw_edma_probe(struct dw_edma_chip *chip);
 int dw_edma_remove(struct dw_edma_chip *chip);
+/**
+ * dw_edma_chan_irq_config - configure per-channel interrupt routing
+ * @chan: DMA channel obtained from dma_request_channel()
+ * @mode: interrupt routing mode
+ *
+ * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
+ * not belong to the DesignWare eDMA driver.
+ */
+int dw_edma_chan_irq_config(struct dma_chan *chan,
+			    enum dw_edma_ch_irq_mode mode);
+
+/**
+ * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
+ * @chan: DMA channel obtained from dma_request_channel()
+ */
+bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
 #else
 static inline int dw_edma_probe(struct dw_edma_chip *chip)
 {
@@ -115,6 +148,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 {
 	return 0;
 }
+
+static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
+					  enum dw_edma_ch_irq_mode mode)
+{
+	return -ENODEV;
+}
+
+static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
+{
+	return false;
+}
 #endif /* CONFIG_DW_EDMA */
 
 struct pci_epc;
-- 
2.51.0


