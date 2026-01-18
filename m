Return-Path: <linux-kselftest+bounces-49283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D7DD3964A
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 967FE303367F
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE85433C524;
	Sun, 18 Jan 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tjcBv6Ty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601C334C11;
	Sun, 18 Jan 2026 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744529; cv=fail; b=Mz+b68/pybVhppnzlglnCf4NZzqwMOHN2t1du+OxnDE2gtsQrT0P58Z9LcyRWoO/GfkJCbIliuniBpqRvL3yIpeVEakpTn4ZT2p1EVrFmlxEWDAb29jk9iZRtAeRBJA/fnLsVOd4KEizP//z2Hi13Zn+j6n3viCftFxPUSRwX1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744529; c=relaxed/simple;
	bh=JvKmW7ZssHBp5C2XY00R1o5zga6ehzCwLe3nWFQHBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E3WcninqvpBnk7U7vP9QmDu69BAx/MsRfr9gpxZYjcSZeo089sTsRTEB4wsmkxNLlDaY5iDjBa5l6XPfgok/4SL7uO5n8QsrZkJX7hkwRqsQzKqeSOKuYxvgJD2laZ2GAUECat8RMHScRmHGWEJVnjJqG9+L5d2HO/SJddP+GDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tjcBv6Ty; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6RExKCuHGRQfpBlrSVKPPhMWaH0rc86lXehMcGqnXZ606vaCDXcWlRJkcaLs/BIdep7vPNii5luqX8t0L906kyR1l+OGJFsQrWt9DQ+DbrussB4ew4DSFlL0a4juf3nkp+YxkrNKKbBR6BZFOwbdN6au6WMZzk65lf11gVwfBGDipOV6l64UafbguT0BcHs3sBxR1GWYCj9mTlpSWyDR87iqTq60MvCRcQ8DslUn1Rifz4pY2CSudKP8O9BbZ5nUJ73xyRciQsWMtMXdydXY4d2jf8YrXUtRFM855BFJDfBNE0vFQ84kSz0iEhv6mKvpQfNf0bOJe7YHJIvUEl6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zswC/WL1m+0wWV0erwBLM9QrWKu3KjjqN0lYeTSaMbk=;
 b=uvSvyXYethlG/w/PtPhO47/2mTMOkUtACJjN5XMQTRwlUFdkJ8z9FgiOMlqU/d9XJTHUU97U9/wF6ka+UtQNWpRAyRoy+lnY26fF5k7ucLogZ6eRxsTJy6neKxYmIZjHAMEUQne3/X5A8pwiobxafsbFhABjaDNIASThi2kX11lUQi4q2LNI0uMHoBoL/ph7nyQB9ZLL/YBe2A/xg9IY+z6FCsT5mEjYRwHlFVJYCw2JB4vFfd3mKJpeEdDQRQ1KWO7WZj8LDJsKkL98kiS/cw2r0tO/m1kBCXLqPaB60pBrQjUNoYvivmFXKbZPQErQNUppQbmG9ilhY9eOBAtNcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zswC/WL1m+0wWV0erwBLM9QrWKu3KjjqN0lYeTSaMbk=;
 b=tjcBv6TyAZ1rVo0Y2hTtYNt5hWDQBFYL/CKezdYRa+G5X4GdL6AC8vKlWdWkLZUzI83Zpc7S2rHr0Afl6YCZTgCZyEl3TZu1UYBO08iEfFMibajwr70J1+nygOum4MhBnzv2b41TPY7gcHT0wTgfGAwnE7S9A0TviURXAZ78F6M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:10 +0000
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
Subject: [RFC PATCH v4 22/38] NTB: ntb_transport: Split core library and default NTB client
Date: Sun, 18 Jan 2026 22:54:24 +0900
Message-ID: <20260118135440.1958279-23-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0044.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: c01f8d4b-7e78-4607-335f-08de569931f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FPiF/Akjze1wlbzLSjxYXRo54tzmffN1pu8ryBavLvCS053W25YPfpMjar0f?=
 =?us-ascii?Q?bXgZYPftfFq/oglKxh3UvbiInTm177kiIfgMIATAdFnBy9Bif0D5MJa68tFg?=
 =?us-ascii?Q?/q4DiVfJAgFtjIQ3W99VvL2DFHQge6ZOMKlHnK4WgNwJzQv0yveN0yixFUxq?=
 =?us-ascii?Q?5DionEcSoOGM1Z+YaYBvxV19UKwnqCQWgrIMr2kq5oOXqcleQuhvQrNnvXM5?=
 =?us-ascii?Q?651O+CFbTsrxXPhBC8aJBgzu0tp7nhjaRIPI2QuHTQy+4BaDqV8vaunufjpw?=
 =?us-ascii?Q?pPozk7KaFwQuke0FMyactS7nYwYU0o+3m0K/PVy/szXmb1xM8Fcag+BJPpYX?=
 =?us-ascii?Q?rEJT6gu7hBz+WyILwa9yBp+VMVnuIEmBy0x3OpApe1XEh+VVX4k6eG3dcoRx?=
 =?us-ascii?Q?wlXOPOWnwdnqWHDVbTkh9iPsUNUgI1fcN/EDWIL9/Xt/+e2YJTwGBB0BKv+Y?=
 =?us-ascii?Q?6mr+wzHyWGgOGRgGF+tsu6j5hTkJKu2PFv+a9D3JS/4GS8AEu7uJ1l2tTuTN?=
 =?us-ascii?Q?34Xx2n1p5YmkeroojJwZyXO0tJiRywbJl+amsWVolsXRe2pG3EwI+VfEreCl?=
 =?us-ascii?Q?4qmZcNFFXnBtTQ3QWmkqYuxqX9ppGQn6hDccdZZXEni60GOido0JXUc6aCsv?=
 =?us-ascii?Q?7ySnTy4uJTZtP73EoLBd+iSkfKbKAHZtLpZUkkRTQEQTH00rno1IZFeH0LY/?=
 =?us-ascii?Q?eHpxWC75dWYCDoKtsRnI5y4A6eCBvB4nrBE3R5GMuXhIONwyn+3NXPqcwmYP?=
 =?us-ascii?Q?hiUuaOTtX/QJbo+/zvT6//Wv0dwQDyO4ntAPPCs7xVJgwowNuoqky0+R/xde?=
 =?us-ascii?Q?EPoik7OkHhcPcPfW7n3fGafy2/igxlYdBpQrjeNtK+e1/Cm4PTGdXw2VINBO?=
 =?us-ascii?Q?7HFntAoRzyvG11KAD4ee6VTKbFzfwaT6ZIlaZqabcdL8a60FnZK+dCMObRU+?=
 =?us-ascii?Q?ZZZBBuGNMXGfW0eY263uQujAp2gIAcl5PiQPRZ1hhglfw7rbST54z/ITsuoF?=
 =?us-ascii?Q?n5npiwNO0m9FbiRHFkjEs1zWwy/aoYu7c92fj/PYphyyOQXoTa2IIZ3xhrRH?=
 =?us-ascii?Q?2WCqTfrM8lNWUckSCkBZREoZLU4TNpfVhSNAR9FecgybulugJYLGqdG3kC2h?=
 =?us-ascii?Q?4ctiQqwlqbRNi1oPXb5n6UlylLAjgjDuJ2rP+lWDP755ZRYdBR2mO2/rjJvO?=
 =?us-ascii?Q?eGWpPI3prIIE91B0fRsXwprCdOyTCU0KrgQjrV76ht7+6fYGr2XqWZ+8wSWD?=
 =?us-ascii?Q?yb3LK9xiNP7zUeVmoJgi/T+Ec2qu7tT7UWkDDxfNqh1LE//npzz/Nxa/ewHZ?=
 =?us-ascii?Q?sYcn+L6yPcoFGAdLZTYv1K9b1uOsdkFNO/ILPynBBK0WLjJHj+e7MiPC+IBm?=
 =?us-ascii?Q?B/cso8cuRovbyIQZ6wgOC+yQYff6WlDwVeLxd+pIy47U6pDvW1Im62TsrX00?=
 =?us-ascii?Q?tH69i8AOC5gmcrWyckmJBz1xHsW60wrRTFIeN1QD4dZy1kEOz3+mUeYY93i/?=
 =?us-ascii?Q?8QKhgv/nA4ashFa/2APzm/N4imzLWor3vEeMtQqhBBZmnIOSTPMD11SS02xF?=
 =?us-ascii?Q?7B9vXQUlHmN/u2bhuFglPUctKnXH0XUdG4ZqOpzi1qQf/Dw5qy32KhYYMtkh?=
 =?us-ascii?Q?YQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2XKGMr0Qc5uLhtklV4v+VOf9yXNG+aQsMGcPIHBUvnH5Q1XzafO1dx63wUL4?=
 =?us-ascii?Q?g44ozUGD32B2uECqqO3Bp80zB29QBAw6DMCsmpO3mUZuTqxFJKXW5e+yWiVN?=
 =?us-ascii?Q?3jHlEjOwPc5VMUwSBvdR8H5edyEdBXi5t7LsV6QR/02djlgpQV+EVSmY13DM?=
 =?us-ascii?Q?IOgcD+6ju7KNs66FjmdCF5YcxmdEJfHGXajisdveJ1qzBGhi7WsYfQaV/8CP?=
 =?us-ascii?Q?wPAhL2LrUUE/8Z8aODnDw3Ve9FkQt82Sp8oItmsUBiYzzhKTEzheDS3tKEOO?=
 =?us-ascii?Q?c+87DqC2NSIhi9SeWZ7kNV9NJjRVFkb+P/gX7ORZlotsjHdAO9WuuvCjm51A?=
 =?us-ascii?Q?Ho5UXNLoumEzt1BBaa/VXqxFhs6P1BgFHHHcyqUFVPOuGYfxFPlHBBS5RtBL?=
 =?us-ascii?Q?hHubMxCbnNFQtuWcFEgsvxGh0nN+PaWXhW4bu7QuojqlcXl2dIWtuefWQpf7?=
 =?us-ascii?Q?9ngM0x2cEXccGYqmgWTx9RiMq8Y7stt6L2c5aVCFgTy1VvMqTR4lOA0vqQ2E?=
 =?us-ascii?Q?wA6CnoEGsa9Zpfo1qP3/mggN9UVKPaJKsiHGINnfWaCDj+0P3OozzQYs1JTY?=
 =?us-ascii?Q?7nRPpxeWGlqnzm8HsZC09QPtegSel2W6mvO0qutiZyf/zfrlCB7+A0LTO/Ki?=
 =?us-ascii?Q?ab+3e2JhsOf5m3CM4poA5qog8zUGNUaLir4TM8VEpF47TOZFHYzuITymAvjq?=
 =?us-ascii?Q?KYVvSRyRPMuRsftt64PmlA0lw8qAw0BRubKlXuMoud+IgigZBQ21Pu99ukqB?=
 =?us-ascii?Q?KinKSx9YZ2UNLa+gafeK7OGAkbxixU+oVR7Bn2HjDZyRV6ssZ/25RqIqzvql?=
 =?us-ascii?Q?bapEAfjH+VWLbGPiyehGHU/HzDz0YiEgutjw7kHDkeZowJNIN83lh7VpsRjA?=
 =?us-ascii?Q?NyZb358TXB0wQjQqH8XdSy0AiGm/8KNe7qcO+SGPZdIW28JNbnb/lfYr8MMy?=
 =?us-ascii?Q?GNGmfcYNLAufNzsu0xRhRyFOMbHBVl4NDoGhbwECDvJmb8NvEgNvBP2mtMF8?=
 =?us-ascii?Q?RsXe3XsjDq9oyQvJR+M2ueBeOEsqBvmDM3GnxhtLOq/kLUwf/EvKy0BfzMzP?=
 =?us-ascii?Q?DDDKgrDImoLNqooOeBJ+gLgcHflZWvowmMkZO3jeS7y5LQk7lhQfOc/5RV/1?=
 =?us-ascii?Q?DjXAutoM5AH31hktlu9mwZLpZe1E+3z+fnnfz0y0NNxCyGD1ph5U3LO6vX0o?=
 =?us-ascii?Q?ZTkq08UOcLMMmtuxJr3Eg46nQl0D4PIiwWj7GXqhhhjGDOJvgVzsEmz42YDc?=
 =?us-ascii?Q?svYJtFZ3LtgSOmUqEd96l781qVMIYgXfcQL7p2J1OM7huaRFIOR6hfzIFbna?=
 =?us-ascii?Q?6MSoN4wZ38PkpbSu+3TRPBi/zUKCcCy6k4DEwcvOEc/n3zufRJJFrbjryp9O?=
 =?us-ascii?Q?1pp2mKqoZ8KnLmKyZpmly6EqOm5xFPRrBQvkgjhK4O2xkWS4g0lSdx2N2lf2?=
 =?us-ascii?Q?EPEZW8+hQZkM13VVorR+VYZwiBCVOjzA205XBuMgZExNF6IJvIcjqhFmK87l?=
 =?us-ascii?Q?QXplCmHclc1lV0DW3mPN504crYrVPZHPZJRQWY+i1ykSscGy/qkiBqnd4Bl/?=
 =?us-ascii?Q?xQYOVaoItgDc4iwrmVsN9CvwQTSfNEyxKA3uqE/37H0sp0HmHL7/58IhY/Op?=
 =?us-ascii?Q?Krpe/EJVM5wuzcO+ZDAo0mVn8bMzdksV3kJDnsgHlVb7hsk+7IxYp/olMm5w?=
 =?us-ascii?Q?8MJ7XWuL/yZx2wGIe3OQ/Zeg8sghM1T/QZM0lC6BXtHe/Sa4bcS97DEdzDvx?=
 =?us-ascii?Q?WYCTMhIpXj8Xxfd2KGRNAwni4pI1daGUp5iTy0AEjQEyWkp4asgw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c01f8d4b-7e78-4607-335f-08de569931f2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:10.1602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpHqTuaAcRuwW33HxeQHq4YGPG4wnwDNXEP4zj90/MSyWIxGt+Boy2Pbk/Bu4gwCflpaV9wtbSP8OMXhedDLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

The transport code is being refactored to support multiple clients and
transport backends. As a first step, split the module into a core
library and a thin default client that binds to NTB ports.

Move module parameters and the legacy ntb_client glue into a new
ntb_transport.c. Export ntb_transport_attach()/ntb_transport_detach()
from the core so other clients can reuse the common transport
infrastructure.

No functional change intended for the default transport.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/Makefile                 |  3 +-
 drivers/ntb/ntb_transport.c          | 81 ++++++++++++++++++++++++
 drivers/ntb/ntb_transport_core.c     | 93 ++++++++++------------------
 drivers/ntb/ntb_transport_internal.h | 15 +++++
 4 files changed, 128 insertions(+), 64 deletions(-)
 create mode 100644 drivers/ntb/ntb_transport.c

diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 9b66e5fafbc0..47e6b95ef7ce 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_NTB) += ntb.o hw/ test/
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
+obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport_core.o
 
 ntb-y			:= core.o
 ntb-$(CONFIG_NTB_MSI)	+= msi.o
-
-ntb_transport-y		:= ntb_transport_core.o
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
new file mode 100644
index 000000000000..dafb97e38883
--- /dev/null
+++ b/drivers/ntb/ntb_transport.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2012 Intel Corporation. All rights reserved.
+ * Copyright (C) 2015 EMC Corporation. All Rights Reserved.
+ *
+ * Default NTB transport client module.
+ *
+ * The transport core library and backend infrastructure are implemented in
+ * ntb_transport_core.c. This module provides the default client that binds
+ * to NTB ports and instantiates the default transport for consumers such
+ * as ntb_netdev.
+ */
+
+#include <linux/module.h>
+#include <linux/ntb.h>
+
+#include "ntb_transport_internal.h"
+
+static unsigned long max_mw_size;
+module_param(max_mw_size, ulong, 0644);
+MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
+
+static unsigned int transport_mtu = 0x10000;
+module_param(transport_mtu, uint, 0644);
+MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
+
+static unsigned char max_num_clients;
+module_param(max_num_clients, byte, 0644);
+MODULE_PARM_DESC(max_num_clients, "Maximum number of NTB transport clients");
+
+static unsigned int copy_bytes = 1024;
+module_param(copy_bytes, uint, 0644);
+MODULE_PARM_DESC(copy_bytes, "Threshold under which NTB will use the CPU to copy instead of DMA");
+
+static bool use_dma;
+module_param(use_dma, bool, 0644);
+MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
+
+static bool use_msi;
+#ifdef CONFIG_NTB_MSI
+module_param(use_msi, bool, 0644);
+MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
+#endif
+
+#define NTB_QP_DEF_NUM_ENTRIES	100
+
+static int ntb_transport_host_probe(struct ntb_client *self,
+				    struct ntb_dev *ndev)
+{
+	return ntb_transport_attach(ndev, "default", use_msi, max_mw_size,
+				    transport_mtu, max_num_clients, copy_bytes,
+				    use_dma, NTB_QP_DEF_NUM_ENTRIES);
+}
+
+static void ntb_transport_host_remove(struct ntb_client *self, struct ntb_dev *ndev)
+{
+	ntb_transport_detach(ndev);
+}
+
+static struct ntb_client ntb_transport_host_client = {
+	.ops = {
+		.probe = ntb_transport_host_probe,
+		.remove = ntb_transport_host_remove,
+	},
+};
+
+static int __init ntb_transport_host_init(void)
+{
+	return ntb_register_client(&ntb_transport_host_client);
+}
+module_init(ntb_transport_host_init);
+
+static void __exit ntb_transport_host_exit(void)
+{
+	ntb_unregister_client(&ntb_transport_host_client);
+}
+module_exit(ntb_transport_host_exit);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Software Queue-Pair Transport over NTB");
diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
index 04a13fdce71c..86181fe1eadd 100644
--- a/drivers/ntb/ntb_transport_core.c
+++ b/drivers/ntb/ntb_transport_core.c
@@ -69,7 +69,7 @@
 #define NTB_TRANSPORT_VERSION	4
 #define NTB_TRANSPORT_VER	"4"
 #define NTB_TRANSPORT_NAME	"ntb_transport"
-#define NTB_TRANSPORT_DESC	"Software Queue-Pair Transport over NTB"
+#define NTB_TRANSPORT_DESC	"NTB transport core library"
 #define NTB_TRANSPORT_MIN_SPADS (MW0_SZ_HIGH + 2)
 
 MODULE_DESCRIPTION(NTB_TRANSPORT_DESC);
@@ -77,31 +77,6 @@ MODULE_VERSION(NTB_TRANSPORT_VER);
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
-static unsigned long max_mw_size;
-module_param(max_mw_size, ulong, 0644);
-MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
-
-static unsigned int transport_mtu = 0x10000;
-module_param(transport_mtu, uint, 0644);
-MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
-
-static unsigned char max_num_clients;
-module_param(max_num_clients, byte, 0644);
-MODULE_PARM_DESC(max_num_clients, "Maximum number of NTB transport clients");
-
-static unsigned int copy_bytes = 1024;
-module_param(copy_bytes, uint, 0644);
-MODULE_PARM_DESC(copy_bytes, "Threshold under which NTB will use the CPU to copy instead of DMA");
-
-static bool use_dma;
-module_param(use_dma, bool, 0644);
-MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
-
-static bool use_msi;
-#ifdef CONFIG_NTB_MSI
-module_param(use_msi, bool, 0644);
-MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
-#endif
 
 static struct dentry *nt_debugfs_dir;
 
@@ -135,12 +110,10 @@ enum {
 #define drv_client(__drv) \
 	container_of((__drv), struct ntb_transport_client, driver)
 
-#define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
 static void ntb_transport_rxc_db(unsigned long data);
 static const struct ntb_ctx_ops ntb_transport_ops;
-static struct ntb_client ntb_transport_client;
 static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 			       struct ntb_queue_entry *entry);
 static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
@@ -456,8 +429,8 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 
 	if (mw_size > mw->xlat_size)
 		mw_size = mw->xlat_size;
-	if (max_mw_size && mw_size > max_mw_size)
-		mw_size = max_mw_size;
+	if (nt->max_mw_size && mw_size > nt->max_mw_size)
+		mw_size = nt->max_mw_size;
 
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
@@ -481,9 +454,9 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	qp->rx_info = qp->tx_mw + tx_size;
 
 	/* Due to housekeeping, there must be atleast 2 buffs */
-	qp->tx_max_frame = min(transport_mtu, tx_size / 2);
+	qp->tx_max_frame = min(nt->transport_mtu, tx_size / 2);
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
-	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
+	qp->rx_max_frame = min(nt->transport_mtu, rx_size / 2);
 	qp->rx_max_entry = rx_size / qp->rx_max_frame;
 	qp->rx_index = 0;
 
@@ -909,8 +882,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 	for (i = 0; i < nt->mw_count; i++) {
 		size = nt->mw_vec[i].phys_size;
 
-		if (max_mw_size && size > max_mw_size)
-			size = max_mw_size;
+		if (nt->max_mw_size && size > nt->max_mw_size)
+			size = nt->max_mw_size;
 
 		spad = MW0_SZ_HIGH + (i * 2);
 		ntb_peer_spad_write(ndev, PIDX, spad, upper_32_bits(size));
@@ -1084,7 +1057,12 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
-static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
+int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
+			 bool use_msi, unsigned long max_mw_size,
+			 unsigned int transport_mtu,
+			 unsigned char max_num_clients,
+			 unsigned int copy_bytes, bool use_dma,
+			 unsigned int num_rx_entries)
 {
 	struct ntb_transport_ctx *nt;
 	struct ntb_transport_mw *mw;
@@ -1117,6 +1095,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 		return -ENOMEM;
 
 	nt->ndev = ndev;
+	nt->max_mw_size = max_mw_size;
+	nt->transport_mtu = transport_mtu;
+	nt->copy_bytes = copy_bytes;
+	nt->use_dma = use_dma;
+	nt->num_rx_entries = num_rx_entries;
 
 	/*
 	 * If we are using MSI, and have at least one extra memory window,
@@ -1241,8 +1224,9 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	kfree(nt);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(ntb_transport_attach);
 
-static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
+void ntb_transport_detach(struct ntb_dev *ndev)
 {
 	struct ntb_transport_ctx *nt = ndev->ctx;
 	struct ntb_transport_qp *qp;
@@ -1262,6 +1246,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 			ntb_transport_free_queue(qp);
 		debugfs_remove_recursive(qp->debugfs_dir);
 	}
+	debugfs_remove(nt->debugfs_node_dir);
 
 	ntb_link_disable(ndev);
 	ntb_clear_ctx(ndev);
@@ -1277,6 +1262,7 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	kfree(nt->mw_vec);
 	kfree(nt);
 }
+EXPORT_SYMBOL_GPL(ntb_transport_detach);
 
 static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 {
@@ -1438,7 +1424,7 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 	if (!chan)
 		goto err;
 
-	if (entry->len < copy_bytes)
+	if (entry->len < qp->transport->copy_bytes)
 		goto err;
 
 	res = ntb_async_rx_submit(entry, offset);
@@ -1718,7 +1704,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	if (!chan)
 		goto err;
 
-	if (entry->len < copy_bytes)
+	if (entry->len < qp->transport->copy_bytes)
 		goto err;
 
 	res = ntb_async_tx_submit(qp, entry);
@@ -1856,7 +1842,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
-	if (use_dma) {
+	if (nt->use_dma) {
 		qp->tx_dma_chan =
 			dma_request_channel(dma_mask, ntb_dma_filter_fn,
 					    (void *)(unsigned long)node);
@@ -1892,7 +1878,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
 		qp->rx_dma_chan ? "DMA" : "CPU");
 
-	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
+	for (i = 0; i < nt->num_rx_entries; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			goto err1;
@@ -1901,7 +1887,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
 			     &qp->rx_free_q);
 	}
-	qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
+	qp->rx_alloc_entry = nt->num_rx_entries;
 
 	for (i = 0; i < qp->tx_max_entry; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
@@ -2301,13 +2287,6 @@ static const struct ntb_ctx_ops ntb_transport_ops = {
 	.db_event = ntb_transport_doorbell_callback,
 };
 
-static struct ntb_client ntb_transport_client = {
-	.ops = {
-		.probe = ntb_transport_probe,
-		.remove = ntb_transport_free,
-	},
-};
-
 static int __init ntb_transport_init(void)
 {
 	int rc;
@@ -2318,26 +2297,16 @@ static int __init ntb_transport_init(void)
 		nt_debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	rc = bus_register(&ntb_transport_bus);
-	if (rc)
-		goto err_bus;
-
-	rc = ntb_register_client(&ntb_transport_client);
-	if (rc)
-		goto err_client;
-
-	return 0;
-
-err_client:
-	bus_unregister(&ntb_transport_bus);
-err_bus:
-	debugfs_remove_recursive(nt_debugfs_dir);
+	if (rc) {
+		bus_unregister(&ntb_transport_bus);
+		debugfs_remove_recursive(nt_debugfs_dir);
+	}
 	return rc;
 }
 module_init(ntb_transport_init);
 
 static void __exit ntb_transport_exit(void)
 {
-	ntb_unregister_client(&ntb_transport_client);
 	bus_unregister(&ntb_transport_bus);
 	debugfs_remove_recursive(nt_debugfs_dir);
 }
diff --git a/drivers/ntb/ntb_transport_internal.h b/drivers/ntb/ntb_transport_internal.h
index 6b45790cc88e..406033dbddb7 100644
--- a/drivers/ntb/ntb_transport_internal.h
+++ b/drivers/ntb/ntb_transport_internal.h
@@ -134,9 +134,17 @@ struct ntb_transport_ctx {
 	struct ntb_transport_qp *qp_vec;
 	unsigned int mw_count;
 	unsigned int qp_count;
+	unsigned int max_qp_count;
 	u64 qp_bitmap;
 	u64 qp_bitmap_free;
 
+	/* Parameters */
+	unsigned int num_rx_entries;
+	unsigned int transport_mtu;
+	unsigned long max_mw_size;
+	unsigned int copy_bytes;
+	bool use_dma;
+
 	bool use_msi;
 	unsigned int msi_spad_offset;
 	u64 msi_db_mask;
@@ -162,5 +170,12 @@ struct ntb_queue_entry *ntb_list_rm(spinlock_t *lock, struct list_head *list);
 struct ntb_queue_entry *ntb_list_mv(spinlock_t *lock, struct list_head *list,
 				    struct list_head *to_list);
 void ntb_qp_link_down(struct ntb_transport_qp *qp);
+int ntb_transport_attach(struct ntb_dev *ndev, const char *backend_name,
+			 bool use_msi, unsigned long max_mw_size,
+			 unsigned int transport_mtu,
+			 unsigned char max_num_clients,
+			 unsigned int copy_bytes, bool use_dma,
+			 unsigned int num_rx_entries);
+void ntb_transport_detach(struct ntb_dev *ndev);
 
 #endif /* _NTB_TRANSPORT_INTERNAL_H_ */
-- 
2.51.0


