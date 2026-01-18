Return-Path: <linux-kselftest+bounces-49274-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64643D395ED
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21EC0304C0CC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84DE332EBB;
	Sun, 18 Jan 2026 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RzpnR/Dq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187EC332EA0;
	Sun, 18 Jan 2026 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744517; cv=fail; b=Bc4KZ2qjsbCOvjXm2a78xEEuTudwBP1DvXzGEQ1Qbnlx/X9FJGtcPEI7TcSyWpPLQxCzKOnLNxTKEdVuBPlIMdpZ86Zkeyc/ILaGfmiK4XfGCmiXZIxfVf/WBdvSmQnilYTRBHrMkZ9BJUuW7xzCxpyrDrRXZBDhTYOBJ+Zjqlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744517; c=relaxed/simple;
	bh=psK8XV1Jf+m6hfSPEMDO2z4ZEQzD80YIuu/VBJGR4+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFAM3BU6rsEP+JMZlbCkxOTEurVo31+dorb+8EVvTwdrB4bqokz15SvidIaIRfG1US33SqA9k6GkgQJzYbGTyJIxBBxypGlmNS5olybVMKVP7qC8uP9kd7NhPvoPj90HaSbOVXZIIysEODYRsyxl4RlNuwOdbBhtJcj41XuNpQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RzpnR/Dq; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWVZgXOZgYBccgbq2iDjcKgX4os40C/xfg+CadjihTXhHdj+kWv0vSDseyvvE2Xk3PUYYcVsAW9Di9zaEEM2ElaJexYtr8+6pV27ipXyYQF07jgkXfDFwGo+1yhyg3E7wdlAtuFCVfHxj9DWmOxTC9B+yuK32+is5lHHZtS2dTF708HAu9Dk+gGSvbF/doOFJKEQ3d25+RbjfcDvVTrE+qf+tMsmOt9PX/FckqkfkFSxEMUsreQlRZswIUvI2gGVtyh7tNHsi/iQ4SK8o7BmjMWDkTWlANihiaDHM3NzwsnDeVjTSl8bLWEetpQlZ7OkLE9Qt53oavON935W0MpO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPAZ38OvBjz/v/kmg2tU3uhG7uM1sHadEjLyI6WgQO0=;
 b=UQyw/Svx1/pj7qh7RTSu3lPn65DWSspQiyHTkb+ONqm9p05qsXMapx5bbE2NULwLX99Ela0XtbdLIGczlcj0otRTadIWD7CNLuLQi0pG2haBlApOW6NqV+PXYbTKmVT60c7Coxpzz4VxZAnh4pzLiX7gJ4V0/MY5KkZ/2vpbI8uCCfE8WxBu+HJQIqKqEcDQ6swG8/cDunLo9oe2qmPy2GbddGypA26fkYmdtsZ4j7119eR5XtypjrObxHIU+hNHp4Fp/ErmvXaIA3BklXjimL5rilPIzsoiIwLY1n1XKQr+3SerMcc3s8gylyabs+3Rm0oD/wXbHJ+tOpJSw/KjrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPAZ38OvBjz/v/kmg2tU3uhG7uM1sHadEjLyI6WgQO0=;
 b=RzpnR/DqGnfPFwjsmTXmOEmu2e8LbpD50BL8yJNTI0pjm8AnJADDYxo+d7RKZodgC6GxuUYm6P4UlCMO2FV5ObfhVs+TpJ0RQwRmXD4pXJ8py6XxnU4TmwFBaeF9iQ/3uootlVJRgQjJU7yFoFiI9CX9ebOWxl4aTln+tD0KdIU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:08 +0000
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
Subject: [RFC PATCH v4 20/38] NTB: ntb_transport: Move internal types to ntb_transport_internal.h
Date: Sun, 18 Jan 2026 22:54:22 +0900
Message-ID: <20260118135440.1958279-21-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a8ee73-9767-4d60-8149-08de569930e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9peVkA0ZaYrD6O52xHt0OgPe5ud1aRyBD8Z7hdGcWK3KzlYqVUemT20Mleh2?=
 =?us-ascii?Q?wPHgs4cKPKwyxeldmM+fojh3cSzV5yzOlHYRywNipHa0fT7F+F+nrBwlujA3?=
 =?us-ascii?Q?EBVD1Ycv0zdKK6QB0QxXbApWBg2rNx5+SjNvwDKlEgFLfIu5f4nTtLwVcKZ/?=
 =?us-ascii?Q?uQltthLJ8mSWQAonDrQKLNacdJMFV8+93s+L3FbnbDfRs2z+xr76sVUXe9vc?=
 =?us-ascii?Q?a4g0ZPUdTWa7hcOVo6JBxNSxJq8F0BaDiargYNmH7IPAS3NNOj4TMJjCk9xS?=
 =?us-ascii?Q?VoEFZjSFtZ8RUqwXjTZlqO+10VxsmUDeH0BvlPj1hOzgshk/LPRuKNY+u5nU?=
 =?us-ascii?Q?8IvLhk6fefgGzwLqcJFjMbRk2fCjiIO+2cILCQ2IVtzzCsZQw4FrWiIci1AW?=
 =?us-ascii?Q?F2KUkH2gmnxGy4LQZg/eW/vDJX6rDITPqYZOsyzQg1HaCraW8gbLvi6E5Rq1?=
 =?us-ascii?Q?JcM7kICbhwkbZLYwvK7CpZOl7sspqPTcjDpqlXxofXgSGmk0gu1VukEL54EQ?=
 =?us-ascii?Q?Fp5WouPngCEL6fpQdz7tur9jlY1G1q4F0uK02x6m70kF54ulkhL1Cm1DZA1B?=
 =?us-ascii?Q?knPdYUAsq4RWgspeRZR6dFN4Jgr1JCEcWBd89ZHlNoP7om+lHwyi+cr7Rc8O?=
 =?us-ascii?Q?7xtNGXcKMeBB3qiT1xiJiaESNHursO8HX0IqgJU5V8EOGGC9MFciQB60iEaS?=
 =?us-ascii?Q?tkGP2Z/keOAwr8kbGlgPmYzHXe7I5iXAwLCcvyX5uQ6wMMGRSdBJLUWug/wn?=
 =?us-ascii?Q?TzZNtVgKHtEdvqSUptcoP04lu0IuNBbQ8oiVG6rSc9xK6zFsU+fQ3BA2arQF?=
 =?us-ascii?Q?SA1y9JbmkjWxJm8MZ5T8v/0N1luz4kxEnZaHCRPQo5DtSuOU76dIxK5uU/ZP?=
 =?us-ascii?Q?YX4Y7Mtbvg2aTJyKNMJg3GAUwppJxSrkV63f64XCedXoOKRz3WIuGudLAhY0?=
 =?us-ascii?Q?eqSDQkiyDancE9Iy/IPphNyfbOiXD91mE5y7xTsk+o+s3hmai+blhH+ba4z/?=
 =?us-ascii?Q?8EY2dWJ29V7f3fYWi7MHJKhdpm/npFJ475lWFnYuhYiQ2/wLRaBYv35yOpoL?=
 =?us-ascii?Q?DiH4nOSLRTSDUAM4CT/5VmQRkPiWjAMVtnIg1BuHo+ha62cxDAgQhZ5XPdjV?=
 =?us-ascii?Q?d5dXVQtxiASYI5TOQaGiTZyVHZvMnLx1FxFTURhSGeUv67MhcYsgLoCcfT4f?=
 =?us-ascii?Q?RsMWmniLZ4yqd+LorqyNStkpQPs3RQLaVX+VR54E+cAu2rUNmrREJFW65Ug9?=
 =?us-ascii?Q?IVOB2RoTWbMDQYXop+5qcMXmM4Y4pxBQauWyV3FL/4Udw4xrDc8LY48XTLGS?=
 =?us-ascii?Q?RCq5EYvZYmAR5Mc+VXrOUh0Ol2u9xt1ytpfdkUOes0K95MVO4OwJhsvr1k6A?=
 =?us-ascii?Q?RX7QF6uih55R+7kl+NkTBAfHA1sUPslBivbzSBIrk2mrmp8NBA6fFaiRZN3y?=
 =?us-ascii?Q?MifqeU1XkP0L6Gb4fgDUW7cIZr91+jmfuriF3/KiNhtag5/3qGczdt++Eyzx?=
 =?us-ascii?Q?Wt2NrE0meVskmlqTjnl4WGkON1sn/r+M/ksTNgQY9jAiPJkUBi6wSktCc/Wr?=
 =?us-ascii?Q?qHhvHGwanEkt+RvtJwiVAm0+tK88rOyLDW1IevucPqtumFqQzeTgxe5tf6WA?=
 =?us-ascii?Q?nQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LTpJ0RgPhNC3FKfQ9W1OiY5Dc5U0lHTagcyCSKkdNcnFcP+fsWAowQe0YWnS?=
 =?us-ascii?Q?+5RpBEVrbmt+kEApP5OMhiRmDo8EJ+leOMBsIfFnbulIdSSLFqCT8nT6nNUW?=
 =?us-ascii?Q?8H2gRsjIKN4PHqQQDl3RjDxdbOI/lGHZY5eEXnCORlxcn/YHBNHOE0G2kOak?=
 =?us-ascii?Q?AhgC3P9xTubKnvL6dTRaxvqKtXeW5T2nD5/uHLHicEMfrJcZ/0sfH3KSgvDp?=
 =?us-ascii?Q?U+o+gmmSMzAtXLxpmHBm4R1eNFAzybRNXz6LsHU8gx3F4WU9s1/GB/qk989C?=
 =?us-ascii?Q?jZB6Ru6ZIVmaxdMJybyHXuaOgp+diKsZCckEAvyuCjJ/+ewkHFXpJFkIsy8P?=
 =?us-ascii?Q?teHFGcZ1AxvnF5nv4Lx3f+OKKeTj/x7i6gB2iZPzUNHAO3sDKrttU4Q1mamB?=
 =?us-ascii?Q?QOcsPc8AomZMOiyMNywU6IgNx8aMj9eklI2bkiXkgQNBpeVmITYIyGJUWhum?=
 =?us-ascii?Q?Asz83KAKEmqywwAHJIymJP5DNdqB760mMXgjz/7EpGGFFxFXkIJaQhGmZi3H?=
 =?us-ascii?Q?PzoRbotcRLHFXUdUTEkcsKHmL5WhEdU/YR7tS1DzwmGUkDlOwNvflX0P7SiX?=
 =?us-ascii?Q?ApXUwLSCcZUs5q5pF4Od2/Hrptk3rZ2uR9/S9SCVavWagAVjjgRZSrjgz4hf?=
 =?us-ascii?Q?YBvEnSZOpiQIQJ7WRkLINgTbWa5xn8nXlyy/kiNWpoNFbbbBubO8pDC39EqI?=
 =?us-ascii?Q?/n9emoNiD/zysFtAxikuYXmh1ML8xuBGGSE3nDuXedafQE8raUO/cz98iF/U?=
 =?us-ascii?Q?HsFtXEcpe0A/84eiNe//nlFsc82jN/drg+sBjDD4aV4OCVs0HJP0QJMWW/NL?=
 =?us-ascii?Q?EdISgsHN6LNco5cc2WvEyjJ3/dvUfT+8Hu4GITJC2ZmgGEKxG8rSLUrulxCI?=
 =?us-ascii?Q?l3IcYVSHucJ5W1bmoV5/vQqwwomMuyFZhXBxEsMhm+hS7wa8b0bTc+fSOrJ8?=
 =?us-ascii?Q?O6T6tdigPMXhAB/HGJuZ6Qdg+AyxXffBc0k9nlN163YDRb4E7Lfk+4AOc1Kv?=
 =?us-ascii?Q?fCeAuKlIM4faEHA9b1onGyfyJnsBcAxsqOtnbDKTj+ZZsIY3PTVSO3Cg9YuM?=
 =?us-ascii?Q?hTFOykAITt7HpIdqGQ4AOc6/GDZmw71KY31NDlBlA9LodHgzaipLzskZRdnH?=
 =?us-ascii?Q?8LIOp2L3HY8YL2ZR/VkRnCAaSAwB8ac0KPN/MeEwwXggQM0AP+YtjBkJwfgO?=
 =?us-ascii?Q?Y5JOOg3XBjJVEfE4dkwFJfYrVpPimzTB9D+/MOCGjRShYkJwb4C7mD2XH5ky?=
 =?us-ascii?Q?6odmm8GwozAHXy1CQcuSPrSXOWwrYPELbuvZyTlT4dJwDyMhciGg4GKelZ2v?=
 =?us-ascii?Q?FL75nLP6buk9uVjOiLEuwslLQQ0/pc/3zVqW581Q7Mve2P9HEgNzHPQS96LZ?=
 =?us-ascii?Q?kfyRq2XSa6jPcJlJ8yN4kHH8Cl2w6GYFWfUQcZzhpOi/ntsgIUZmR3LWQ6D3?=
 =?us-ascii?Q?OaYajVQUzfSgDB4dgVDlTSIO2qDSgq+cd7yO7i9+dlX+W/+P8VMxQ5R4atcK?=
 =?us-ascii?Q?o3zswOU7nkxCxTx2KnlkYGmcyci07hqvMVtGdKm741mJjHZyvQ8RVqEYvuVY?=
 =?us-ascii?Q?5JLJm0Dp3yI0ExdwMviO2jE9cmrEhIHN8phzEQHr3vsa5S6gJziyQ3TevdSb?=
 =?us-ascii?Q?LAt85OpOJqebzsUyNK6QYAqSQa/ThyoRg7KXj7FbPkXinXN84VE/jkgQwaV/?=
 =?us-ascii?Q?bgVW9AK3MB0fEjlLuQBNCS3Y5MbBy73ZJnEyG5aQhqN9lrlI59iBztsHHk2g?=
 =?us-ascii?Q?60Fzcfi4gC6QBS03gkb7jxjW/o9LJaQT+w816dRUcoa9UqcwTpFN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a8ee73-9767-4d60-8149-08de569930e6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:08.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zFYbUjZUWicuV5T/SquKYn/tzNo0SrOmB+OYY9QUBDslqxgs563lEqR7VJ4uJLHYbeUvXLAdz9HBRzkuKgUB9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Move internal structs and definitions from ntb_transport_core.c into a
new internal header so they can be shared by upcoming split-out modules.

No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport_core.c     | 144 +-----------------------
 drivers/ntb/ntb_transport_internal.h | 159 +++++++++++++++++++++++++++
 2 files changed, 161 insertions(+), 142 deletions(-)
 create mode 100644 drivers/ntb/ntb_transport_internal.h

diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
index 7b320249629c..71f01fa0ff05 100644
--- a/drivers/ntb/ntb_transport_core.c
+++ b/drivers/ntb/ntb_transport_core.c
@@ -64,6 +64,8 @@
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
+#include "ntb_transport_internal.h"
+
 #define NTB_TRANSPORT_VERSION	4
 #define NTB_TRANSPORT_VER	"4"
 #define NTB_TRANSPORT_NAME	"ntb_transport"
@@ -106,153 +108,12 @@ static struct dentry *nt_debugfs_dir;
 /* Only two-ports NTB devices are supported */
 #define PIDX		NTB_DEF_PEER_IDX
 
-struct ntb_queue_entry {
-	/* ntb_queue list reference */
-	struct list_head entry;
-	/* pointers to data to be transferred */
-	void *cb_data;
-	void *buf;
-	unsigned int len;
-	unsigned int flags;
-	int retries;
-	int errors;
-	unsigned int tx_index;
-	unsigned int rx_index;
-
-	struct ntb_transport_qp *qp;
-	union {
-		struct ntb_payload_header __iomem *tx_hdr;
-		struct ntb_payload_header *rx_hdr;
-	};
-};
-
-struct ntb_rx_info {
-	unsigned int entry;
-};
-
-struct ntb_transport_qp {
-	struct ntb_transport_ctx *transport;
-	struct ntb_dev *ndev;
-	void *cb_data;
-	struct dma_chan *tx_dma_chan;
-	struct dma_chan *rx_dma_chan;
-
-	bool client_ready;
-	bool link_is_up;
-	bool active;
-
-	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
-	u64 qp_bit;
-
-	struct ntb_rx_info __iomem *rx_info;
-	struct ntb_rx_info *remote_rx_info;
-
-	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
-	struct list_head tx_free_q;
-	spinlock_t ntb_tx_free_q_lock;
-	void __iomem *tx_mw;
-	phys_addr_t tx_mw_phys;
-	size_t tx_mw_size;
-	dma_addr_t tx_mw_dma_addr;
-	unsigned int tx_index;
-	unsigned int tx_max_entry;
-	unsigned int tx_max_frame;
-
-	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
-	struct list_head rx_post_q;
-	struct list_head rx_pend_q;
-	struct list_head rx_free_q;
-	/* ntb_rx_q_lock: synchronize access to rx_XXXX_q */
-	spinlock_t ntb_rx_q_lock;
-	void *rx_buff;
-	unsigned int rx_index;
-	unsigned int rx_max_entry;
-	unsigned int rx_max_frame;
-	unsigned int rx_alloc_entry;
-	dma_cookie_t last_cookie;
-	struct tasklet_struct rxc_db_work;
-
-	void (*event_handler)(void *data, int status);
-	struct delayed_work link_work;
-	struct work_struct link_cleanup;
-
-	struct dentry *debugfs_dir;
-	struct dentry *debugfs_stats;
-
-	/* Stats */
-	u64 rx_bytes;
-	u64 rx_pkts;
-	u64 rx_ring_empty;
-	u64 rx_err_no_buf;
-	u64 rx_err_oflow;
-	u64 rx_err_ver;
-	u64 rx_memcpy;
-	u64 rx_async;
-	u64 tx_bytes;
-	u64 tx_pkts;
-	u64 tx_ring_full;
-	u64 tx_err_no_buf;
-	u64 tx_memcpy;
-	u64 tx_async;
-
-	bool use_msi;
-	int msi_irq;
-	struct ntb_msi_desc msi_desc;
-	struct ntb_msi_desc peer_msi_desc;
-};
-
-struct ntb_transport_mw {
-	phys_addr_t phys_addr;
-	resource_size_t phys_size;
-	void __iomem *vbase;
-	size_t xlat_size;
-	size_t buff_size;
-	size_t alloc_size;
-	void *alloc_addr;
-	void *virt_addr;
-	dma_addr_t dma_addr;
-};
-
 struct ntb_transport_client_dev {
 	struct list_head entry;
 	struct ntb_transport_ctx *nt;
 	struct device dev;
 };
 
-struct ntb_transport_ctx {
-	struct list_head entry;
-	struct list_head client_devs;
-
-	struct ntb_dev *ndev;
-
-	struct ntb_transport_mw *mw_vec;
-	struct ntb_transport_qp *qp_vec;
-	unsigned int mw_count;
-	unsigned int qp_count;
-	u64 qp_bitmap;
-	u64 qp_bitmap_free;
-
-	bool use_msi;
-	unsigned int msi_spad_offset;
-	u64 msi_db_mask;
-
-	bool link_is_up;
-	struct delayed_work link_work;
-	struct work_struct link_cleanup;
-
-	struct dentry *debugfs_node_dir;
-
-	/* Make sure workq of link event be executed serially */
-	struct mutex link_event_lock;
-};
-
-enum {
-	DESC_DONE_FLAG = BIT(0),
-	LINK_DOWN_FLAG = BIT(1),
-};
-
 struct ntb_payload_header {
 	unsigned int ver;
 	unsigned int len;
@@ -274,7 +135,6 @@ enum {
 #define drv_client(__drv) \
 	container_of((__drv), struct ntb_transport_client, driver)
 
-#define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
new file mode 100644
index 000000000000..aff9b70671c6
--- /dev/null
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2012 Intel Corporation. All rights reserved.
+ * Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ */
+#ifndef _NTB_TRANSPORT_INTERNAL_H_
+#define _NTB_TRANSPORT_INTERNAL_H_
+
+#include <linux/dcache.h>
+#include <linux/dmaengine.h>
+#include <linux/mutex.h>
+#include <linux/ntb.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
+
+struct ntb_queue_entry {
+	/* ntb_queue list reference */
+	struct list_head entry;
+	/* pointers to data to be transferred */
+	void *cb_data;
+	void *buf;
+	unsigned int len;
+	unsigned int flags;
+	int retries;
+	int errors;
+	unsigned int tx_index;
+	unsigned int rx_index;
+
+	struct ntb_transport_qp *qp;
+	union {
+		struct ntb_payload_header __iomem *tx_hdr;
+		struct ntb_payload_header *rx_hdr;
+	};
+};
+
+struct ntb_rx_info {
+	unsigned int entry;
+};
+
+struct ntb_transport_qp {
+	struct ntb_transport_ctx *transport;
+	struct ntb_dev *ndev;
+	void *cb_data;
+	struct dma_chan *tx_dma_chan;
+	struct dma_chan *rx_dma_chan;
+
+	bool client_ready;
+	bool link_is_up;
+	bool active;
+
+	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
+	u64 qp_bit;
+
+	struct ntb_rx_info __iomem *rx_info;
+	struct ntb_rx_info *remote_rx_info;
+
+	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
+			   void *data, int len);
+	struct list_head tx_free_q;
+	spinlock_t ntb_tx_free_q_lock;
+	void __iomem *tx_mw;
+	phys_addr_t tx_mw_phys;
+	size_t tx_mw_size;
+	dma_addr_t tx_mw_dma_addr;
+	unsigned int tx_index;
+	unsigned int tx_max_entry;
+	unsigned int tx_max_frame;
+
+	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
+			   void *data, int len);
+	struct list_head rx_post_q;
+	struct list_head rx_pend_q;
+	struct list_head rx_free_q;
+	/* ntb_rx_q_lock: synchronize access to rx_XXXX_q */
+	spinlock_t ntb_rx_q_lock;
+	void *rx_buff;
+	unsigned int rx_index;
+	unsigned int rx_max_entry;
+	unsigned int rx_max_frame;
+	unsigned int rx_alloc_entry;
+	dma_cookie_t last_cookie;
+	struct tasklet_struct rxc_db_work;
+
+	void (*event_handler)(void *data, int status);
+	struct delayed_work link_work;
+	struct work_struct link_cleanup;
+
+	struct dentry *debugfs_dir;
+	struct dentry *debugfs_stats;
+
+	/* Stats */
+	u64 rx_bytes;
+	u64 rx_pkts;
+	u64 rx_ring_empty;
+	u64 rx_err_no_buf;
+	u64 rx_err_oflow;
+	u64 rx_err_ver;
+	u64 rx_memcpy;
+	u64 rx_async;
+	u64 tx_bytes;
+	u64 tx_pkts;
+	u64 tx_ring_full;
+	u64 tx_err_no_buf;
+	u64 tx_memcpy;
+	u64 tx_async;
+
+	bool use_msi;
+	int msi_irq;
+	struct ntb_msi_desc msi_desc;
+	struct ntb_msi_desc peer_msi_desc;
+};
+
+struct ntb_transport_mw {
+	phys_addr_t phys_addr;
+	resource_size_t phys_size;
+	void __iomem *vbase;
+	size_t xlat_size;
+	size_t buff_size;
+	size_t alloc_size;
+	void *alloc_addr;
+	void *virt_addr;
+	dma_addr_t dma_addr;
+};
+
+struct ntb_transport_ctx {
+	struct list_head entry;
+	struct list_head client_devs;
+
+	struct ntb_dev *ndev;
+
+	struct ntb_transport_mw *mw_vec;
+	struct ntb_transport_qp *qp_vec;
+	unsigned int mw_count;
+	unsigned int qp_count;
+	u64 qp_bitmap;
+	u64 qp_bitmap_free;
+
+	bool use_msi;
+	unsigned int msi_spad_offset;
+	u64 msi_db_mask;
+
+	bool link_is_up;
+	struct delayed_work link_work;
+	struct work_struct link_cleanup;
+
+	struct dentry *debugfs_node_dir;
+
+	/* Make sure workq of link event be executed serially */
+	struct mutex link_event_lock;
+};
+
+enum {
+	DESC_DONE_FLAG = BIT(0),
+	LINK_DOWN_FLAG = BIT(1),
+};
+
+#endif /* _NTB_TRANSPORT_INTERNAL_H_ */
-- 
2.51.0


