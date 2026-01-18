Return-Path: <linux-kselftest+bounces-49267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D7211D395B0
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D0D301B486
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A95333740;
	Sun, 18 Jan 2026 13:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="W+V5JNC2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021073.outbound.protection.outlook.com [40.107.74.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9253314C5;
	Sun, 18 Jan 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744507; cv=fail; b=ahraC3AR0j9HAT+KqENvhCqt+uL7sewTsHK2jdeY8v4yhBAqP089o2Le0eyEFOBwJ17spYi461JqyBwr6lbWSqDvrZF7csyYcfy3Fp+XwQ5dgh2bp7SuENfIXEQpaZ+8n9b1Nr/wm70vio92UmLMpolv+5URRc07/tTT4GiH10M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744507; c=relaxed/simple;
	bh=LbA1Pw4Rm5yX87aTtHjar3yLT506wGvrd8ACC2EVG4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k7CouLp2kTV5M8XyIu0hHWF/O5+KUW3pVFFNZvFvplCE/4vg84Z11QaNr8J26h7ivA/pmZjZuSk+wJ+XUIz4gl1P0K3bpGl23RYOwcArEmfQouoIWrdmlLt8bb6fC+XJTd34TvdETzgxypaUQTK4MVDj8YhifA5Jwi+5BL9TwVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=W+V5JNC2; arc=fail smtp.client-ip=40.107.74.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVJyMCq2gNf1aq52bF8QALxyKipebKbPZNFKV1+lQXngWthlGRYvOWqfyUil98z/+IeM0u2VdeSVvLqIrlTaccPU7x+JlYIPygLiyCLeSQO7sRXddq4PkpaVJILg+ePPqQUTQFFVsQ+KFEBMJXqPhe2DIr6v12jSyRpOiT6FuGSj2I0R7/LjAxEb00BQgwtZXKXTfNUYI9ANpoBmwHkxwTOptZv2SeB7WLyu091FyliR0iVAbbyum+8DYGdUpBhadLTkkO3LO9tFSFg19c/jOlMJZ8fAwqPIKljJCYd42VCcO5wK7w58QuekHs05x7JtAZ7DKkgbtZIh0ga1zg+M+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS9NFT/Lcpewmml5A4Y5Mt5X7kFL1195M69cHaM411Y=;
 b=H/ofkGuTHRbrFufoVtFE7zXQjJuGe2CTqbx67WX8r3wrCVF6PdczCsrnBDFQRs7BsSlPeOSNUrs5Im9KwFne7MARzwttAN7cGvGrQfbVZWFHqisomFEW3B/CL6QXY6Z803vN1uE3UpVrao2z1B3qXxxLPYIIUzIkuwV0os9KxAP1NbXmtkyjeMrzD7nhdRe0Rj1kGp44oW93EguxFrhhvlIrSvmNuNXljI3BOgV3Qbdzc5kYx+HfK35ZDmdxSuhUptqXyHuxHBPnuDKTKsC1aABdBlaX7mIoMqo0b8Fw9DwhB9oItzOvpjrLiy9plGpglJvCQT6xh0r9aESJ/wAYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pS9NFT/Lcpewmml5A4Y5Mt5X7kFL1195M69cHaM411Y=;
 b=W+V5JNC2nqe0rDJyH74cuJZaSCCnzLgovLMfmOEV1V2493Vthvq/Dhho/cBEPao07794mFXFJlQroATs2g2WpJ1VEg6PVq68LNWsZ2jlc7FNt+zVPy0EIeozzvVK3H9a9/Od2yvZVT0SIc0iD4m/kB/CAPjcsIm/XDilANRnSPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:54:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:54:54 +0000
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
Subject: [RFC PATCH v4 03/38] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
Date: Sun, 18 Jan 2026 22:54:05 +0900
Message-ID: <20260118135440.1958279-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c433e0a-3b34-401b-c79e-08de5699289a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4ECmIjxSUHu3oqQUmcVeLggcsf3VJtuH3xCWgIsAzPF3Aa1Z5o2CGmBydUu?=
 =?us-ascii?Q?ea4+H4Wmrl3SrxVZXJmImBpSO+pDbJUHFOy1N9szqfepAAIC6YRXfEWv/9ez?=
 =?us-ascii?Q?i4Bc9iP9X8AvWqzDMizvAxjD7frofCjCAL9wrIn7oMT3z/rP9EW6JPL8Y34h?=
 =?us-ascii?Q?nGUXdyd0WXkODY6Q7zmBnwmJIyBZxTZ5zEbJXj8h23Fq6h6ezAdADfxoC/xl?=
 =?us-ascii?Q?HGT0iPhWIxvPVz4Th1DCKUUvY6pA3Shk31c7wVt5eKCrho0ig24HT9lsoegi?=
 =?us-ascii?Q?N6jar53Y9inup4mcqQwwfxIBQ3WPaQF8KjHV7a43SjuTvmJ9euNJP2oBrtil?=
 =?us-ascii?Q?+Evpzj4/BNdQR/XVU+LObRWVNlWddiUZYs+BQy5/cC6J1jS211x8tay1TKLz?=
 =?us-ascii?Q?Ynne6bYvLIJZrEmmFNw7mow8n3HgKr0z8lvploYG+OeIwx+Rkb+o4BcgMTeu?=
 =?us-ascii?Q?2eTAGzie88j1w+YVEdI56r9UMC/8/w490dIZhOU69L2LrZfi0madLQo2Fezd?=
 =?us-ascii?Q?O3EwNcCHPE3Ui/HvrN2C1IbRbB3K7ABeN9GPVQEGvGiks+hpzaj9s+CIiVkw?=
 =?us-ascii?Q?g7pfiiEUuPF0nJriVZnZ/kw8a7NlL7E86gCt+Fmg/+KDhAEhFbe8GrgXE+ji?=
 =?us-ascii?Q?XUlSR3eiJsDYDU/wS0xj2bcXAXIaSSyyLm7GjLwiiPs393Sk2j1L3PjBlQMs?=
 =?us-ascii?Q?nABs8GcG90/m7kUzMM21WvH532EJ8rh7Pcne9llLEj/RZ9KspyhaJ78+vYpF?=
 =?us-ascii?Q?JH9/FU//fA5vS4XKnXigl0W2P8bgDCkQFUH6aTPrlvwCfIRGbeYKwBBNNGlJ?=
 =?us-ascii?Q?Xi3ZOJo2p8/2rh9+GKLXJef9kYJuUoJg82jZsjxQZ1ZFeI+gfNPwMrXk2XEN?=
 =?us-ascii?Q?gB+HnriWKl8wdcxIREtDZvNgRK5MKvYiwKaJM783uhdrYbS8XJKJ2DtuYPt7?=
 =?us-ascii?Q?nAv26aoWotcEfzLpFjCGuoErd2UUEvFF1gfgESytmfBI46i+9lnyiMfQexN2?=
 =?us-ascii?Q?duGr/e01GRL064pzMoksB+Ii6Th5Fdc/fqTu+U8kRh6kj2MxOZGE6Z2+yo3I?=
 =?us-ascii?Q?US6FdDQEKg1ANpNQgTiGapUEzC6sx7phAzk0PyFoFDxPIL9Qu3MY1vTz69kz?=
 =?us-ascii?Q?szRRyzSRB66Mzc84ePAKm0sY17oIYMkL1mSV/8n3XJuSZMROhToL8rjSQ5Z9?=
 =?us-ascii?Q?Ey5VOjXwa1K5Ny7oxyViSN3PMUp0stqmz6fY7fe9QM51Bvjjo5h2GqIaFfk1?=
 =?us-ascii?Q?qZn8MLEXnSRMgY+DyaSFeArrPmAPujMLIDV0JjPaNOcFjnuahkyf/pc7B7wE?=
 =?us-ascii?Q?VjsxKSxKNXMTPSwFNEKg3kJOYrP5rEnqxa4+LsRDL1m/e2UvIv1MsReelr8a?=
 =?us-ascii?Q?1YynYPRQYk8JiClYB8iHJWQz5hQn1g3A3dK36WTddifLvRyyR4Ejo433egea?=
 =?us-ascii?Q?HA7cygW28x3kXL6LBAAClvPa7wy0z/Qp79NqKeRXjTjoeSq9smQuMqLGX8Jx?=
 =?us-ascii?Q?GD9Co2BgPcj9qfROnNArbrMto3HRVRemC4VFJRd8nI7KgjJV6TNghViiqLgA?=
 =?us-ascii?Q?of379vLtfG7xhvL8iK+gHvO6eLZ31nFQ7hpKPxa0cn+glKqoNj5l8Q+ovMhh?=
 =?us-ascii?Q?RQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6l8pWCYI5lffLP6jjH1vQQ4exAPLelHajBz7xXoIIsc4e6Y4trVu2OxRg9/J?=
 =?us-ascii?Q?r4EB0/F7Xxbnhe8DPHOw8fA5048OySSaevO6uMH7dClhUtpu+JsWjD7+CCEW?=
 =?us-ascii?Q?n8kjH3QQ8shuyAlEpzV46yEuv7FXHPaYRJONCmD4uYAZziwDQCzzpnGhzSrP?=
 =?us-ascii?Q?8r3Mg6yAVMN2Ke5+lydzSUEi4G53VdrcEWIOhySpkXxYrZv3+M/mT+AO0Ony?=
 =?us-ascii?Q?UGZBVLrxAN0k47sl+PQ+u2w3+52NpZXfZbRyPycOgA3p1BpvJVDmYJ2TMdxo?=
 =?us-ascii?Q?Rvs/FDUuYrfAILDuONRRItHc3kGvKNVBgG9pInyOtIcr83wypgx4gGMH9/oN?=
 =?us-ascii?Q?jq/pbExoFtfPd3K4C+IZKcs4Kj/38Zq1gV0QRKwfPACAkFXMJViZbkslqeJM?=
 =?us-ascii?Q?GPNIEHJPtkDyvbi1RBQ6N2D2klH7+5eLHCMW/07cB+qZj/TI0q99xUET2Jja?=
 =?us-ascii?Q?fbspUb18OeBuDOskqok3hqNJF/Th+pwu+oUAvHeQXKtPljAPRJrM4HuT1t6Y?=
 =?us-ascii?Q?SCgeWBSE0Nfui8B4laDLBDnOT2nlLTk/gMDHQZHQ8SdWTUUpxsD20JdSe7tS?=
 =?us-ascii?Q?H9BKDcn5wo1PjVDdhPg5MZax9Y5NXOcyXF4fdpdVwHH7C6a3onzRJuys1Ly3?=
 =?us-ascii?Q?Rn7Pm2sY4UDI8V4CH9sr1rfD05AnK+/ZAiM2I4EFo7XBH7/ZYOyHNssRKCrP?=
 =?us-ascii?Q?EOuNEchiyF/dcYphrvea5fI4RwdyJ29KUb5XkSuIGJm+sxYYqpYRXQVMNS+/?=
 =?us-ascii?Q?w7u/TCsd7PaSs5gSZXg/tQ12Zo0sHZXKgK3xfGbewbcSX2LY5wCL9LgdbhHa?=
 =?us-ascii?Q?jvmqyBInjidK6lQWGt5gL07aGOQAtgcw3+Cn4YdM4wGA/mjS+Vu6SGDmIWCh?=
 =?us-ascii?Q?BMES2m/WOueg9RocP+Sq7XgutlYP0Kpg1DDNRJPGyWqOVQHrdQvkCu/+AmuA?=
 =?us-ascii?Q?lI5LA5LI0BlsraHXiVOdwsPqEOauJ3H1r5EsdKf1BohxJR+PRY6m8TfBuAXK?=
 =?us-ascii?Q?Vj8oZ7JEXfJkiYdvYekmfFUCPKlpf6HCCMzoy4cVi6jARKpFAk8Go6Vuf5jw?=
 =?us-ascii?Q?nHBeh8lPluRdIgahBVz/alKB7AIpuH0BqEsOT95JfWFAy+OBQJyRBF3xfjJc?=
 =?us-ascii?Q?U0A7SvH4qpk7WkuiDRG6J69Gf1l4IVxIBY8wxYfiguy3maQjbRaVLFjfYeVm?=
 =?us-ascii?Q?DaXRCK/jjrsVgmKQ+ZKsLOcIzvsA8P9MfvkLQA61eNnCH4pXEVo6M197WxHs?=
 =?us-ascii?Q?r82Xkg0hFu0SIxDgaSXmomBa32ETfnjutebElz6NVUjQqAPTtBMJbzMXaKoi?=
 =?us-ascii?Q?VFf4nP56eIDbRqWymY1mSyyGrSZTFSfx706kgamb20X3l/ci3ZXX4bG6iK0J?=
 =?us-ascii?Q?59EJfgwgX/lenYPG83oe8t+G4F88LqqxdF4kkOdVLhx7wXHMfmnHNBmyrmMa?=
 =?us-ascii?Q?V5BrB9EYCPzwoJrpDRZ/JJrIvOS0Lj4f4n81kW7LD12DaCCVRXHSBScHe0Ky?=
 =?us-ascii?Q?P6VB75PYZAxBCToJLFkEweoEpuojEU4KX4LidNaf8Z2XAcNceM7Zs/oTXRhH?=
 =?us-ascii?Q?ZF2NIahneVjJ9QzrAEzOVAruEWuCr+G5a/Wyk7Hy8yR7aIvkZRh8/Bzf5lKM?=
 =?us-ascii?Q?mxKZQ/5+MH0TqCC5n84yzf+oLmmF1HKEW43DKHlGcmatgOcZmgeu2IpLwL+M?=
 =?us-ascii?Q?v4TVLNbm2D9A+Ha70ToW+GvZj9HMcwFl+XS4fmwf86EkyBhUfjCLPjFtLmVl?=
 =?us-ascii?Q?Qj9qCQvCO++Hgylgg9LjUOP61CLgvE3H4oNZweFipQXvt97UVYmD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c433e0a-3b34-401b-c79e-08de5699289a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:54:54.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: os01Xk2e4nZ21Ey2wQputIQpTxuPGuzEvWQiMYVYOeMbuGRF+FzhbtKzUiUjrf4VS98hllDNKtYOFIFpjveXHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

When a channel is configured to suppress host side interrupts (RIE=0),
the host side driver cannot rely on IRQ-driven progress. Add an optional
polling path for such channels. Polling is only enabled for channels
where dw_edma_chan_ignore_irq() is true.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 98 ++++++++++++++++++++++++------
 drivers/dma/dw-edma/dw-edma-core.h |  4 ++
 2 files changed, 85 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 059b3996d383..696b9f3ea378 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -308,23 +308,6 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
 	return err;
 }
 
-static void dw_edma_device_issue_pending(struct dma_chan *dchan)
-{
-	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
-	unsigned long flags;
-
-	if (!chan->configured)
-		return;
-
-	spin_lock_irqsave(&chan->vc.lock, flags);
-	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
-	    chan->status == EDMA_ST_IDLE) {
-		chan->status = EDMA_ST_BUSY;
-		dw_edma_start_transfer(chan);
-	}
-	spin_unlock_irqrestore(&chan->vc.lock, flags);
-}
-
 static enum dma_status
 dw_edma_device_tx_status(struct dma_chan *dchan, dma_cookie_t cookie,
 			 struct dma_tx_state *txstate)
@@ -710,6 +693,69 @@ static irqreturn_t dw_edma_interrupt_common(int irq, void *data)
 	return ret;
 }
 
+static void dw_edma_done_arm(struct dw_edma_chan *chan)
+{
+	if (!dw_edma_chan_ignore_irq(&chan->vc.chan))
+		/* no need to arm since it's not to be ignored */
+		return;
+
+	queue_delayed_work(system_wq, &chan->poll_work, 1);
+}
+
+static void dw_edma_chan_poll_done(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dma_status st;
+
+	if (!dw_edma_chan_ignore_irq(dchan))
+		/* no need to poll since it's not to be ignored */
+		return;
+
+	guard(spinlock_irqsave)(&chan->poll_lock);
+
+	if (chan->status != EDMA_ST_BUSY)
+		return;
+
+	st = dw_edma_core_ch_status(chan);
+
+	switch (st) {
+	case DMA_COMPLETE:
+		dw_edma_done_interrupt(chan);
+		if (chan->status == EDMA_ST_BUSY)
+			dw_edma_done_arm(chan);
+		break;
+	case DMA_IN_PROGRESS:
+		dw_edma_done_arm(chan);
+		break;
+	case DMA_ERROR:
+		dw_edma_abort_interrupt(chan);
+		break;
+	default:
+		break;
+	}
+}
+
+static void dw_edma_device_issue_pending(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	unsigned long flags;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+
+	spin_lock_irqsave(&chan->vc.lock, flags);
+	if (vchan_issue_pending(&chan->vc) && chan->request == EDMA_REQ_NONE &&
+	    chan->status == EDMA_ST_IDLE) {
+		chan->status = EDMA_ST_BUSY;
+		dw_edma_start_transfer(chan);
+	} else {
+		dw_edma_done_arm(chan);
+	}
+	spin_unlock_irqrestore(&chan->vc.lock, flags);
+}
+
 static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
@@ -1063,6 +1109,19 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+static void dw_edma_poll_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct dw_edma_chan *chan =
+		container_of(dwork, struct dw_edma_chan, poll_work);
+	struct dma_chan *dchan = &chan->vc.chan;
+
+	if (!chan->configured)
+		return;
+
+	dw_edma_chan_poll_done(dchan);
+}
+
 int dw_edma_chan_irq_config(struct dma_chan *dchan,
 			    enum dw_edma_ch_irq_mode mode)
 {
@@ -1090,6 +1149,11 @@ int dw_edma_chan_irq_config(struct dma_chan *dchan,
 		 str_write_read(chan->dir == EDMA_DIR_WRITE),
 		 chan->id, mode);
 
+	if (dw_edma_chan_ignore_irq(&chan->vc.chan)) {
+		spin_lock_init(&chan->poll_lock);
+		INIT_DELAYED_WORK(&chan->poll_work, dw_edma_poll_work);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 8458d676551a..11fe4532f0bf 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -11,6 +11,7 @@
 
 #include <linux/msi.h>
 #include <linux/dma/edma.h>
+#include <linux/workqueue.h>
 
 #include "../virt-dma.h"
 
@@ -83,6 +84,9 @@ struct dw_edma_chan {
 
 	enum dw_edma_ch_irq_mode	irq_mode;
 
+	struct delayed_work		poll_work;
+	spinlock_t			poll_lock;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
-- 
2.51.0


