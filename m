Return-Path: <linux-kselftest+bounces-49284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D77D39654
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86893302E071
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139EB33D6FC;
	Sun, 18 Jan 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="r03xJ0nt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021125.outbound.protection.outlook.com [52.101.125.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9C233B6D4;
	Sun, 18 Jan 2026 13:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744533; cv=fail; b=OMqgHqx/v40oiXlt9JaEnonkRj+pp3rdulW1IVvbXYYf2vKzQ+LwLlF6D0ojipCCLfbdI/WM/YtHCQsRrCicAG8akZSR5CCfgKkhF3p0xH/lM0sn+8cHfJvU60C/tUGOxyJfuslmM+sNvqTOLyftEHBkTsV9LqZZROKgpPuSL6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744533; c=relaxed/simple;
	bh=gzgZedCB/qwlaSF3AEDEJihH2/K/+5aMsbA+b3VvbBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nplKNDufbWOe9cDXSXEcjeYg4isPpmrhR8FDmv4RUTYEqyY/ft9tYMjfpctXPAWWv/2pgsRfDARt7Fz9UuIhAjij8MifmC0xL6ogHqToS8iWep83P2ZiW3MUusanBDdvsd8vYIVukBbbAsQb+iECplZjS7pSjX05dG4Lf9+v5k0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=r03xJ0nt; arc=fail smtp.client-ip=52.101.125.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1sjbzgQcN34PRtXpKXBdAwv6XkymgEQUk5//DG/JlL/1UPMJ28d0p9QWAhVkiPFvBBVkXj4RX1O1wg9vkGtnJ9d5lvg4dVWciKZn4qg7XgAtXFm4e7hNiLUCNcLxK5rbEpthVSHGkl6LCfmyBzY4T9EJDvZg7MzmRrpW4PhbYVlHGJ9QBgqgS3kGjXmhfjMj+zdfGOT57Q9u/xYL7irwUmfwnI7Wb63tpQNszvltahqYL7mV3+NLBnluhN6RRtI/pl1kty7dJs6YL5wBvTe3LjEkZo4VqMvrHm8jMaDtr5AB/rtmW0jFiBX5WQdtqz5/NFk4sEVF+HMsr5mSgJK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nqVYjK3c66uhhQ5bU6dhh9UpoNamVRONI0t7AFi6xIU=;
 b=dUFwlz6qD4K6GeDNqV5c22dS28CzfH10aBpYV+1hEIi+GP0tlx5xf39ehZQggSMmSfKlSbgQLSHKDagPuZqJhDp5VtMGrlFn1+xlaWrL1/Y46XIW/KikPG1GPs5g8uodqqWyFDC6f6E0o/z1zUqv43nV/aXRbm8PK3NF85WrGV99rNRnSetksnC6isTtLv+TGY3Ww6debHW38IH3050CdD4CN5VbJMmh3/t75gjIQS1Oq+6IaJo2FVMdCT4HTwuIdiVLs2Nt+mHUzVc1XQVeNHznCzO61UD8aVk90QULKvz+XV8Dya/L7Ia4J+gTolc1giqubuuiZG8hxqeuoxbfYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nqVYjK3c66uhhQ5bU6dhh9UpoNamVRONI0t7AFi6xIU=;
 b=r03xJ0nttW/hidNdQE7jP4DlFXMz3uBCkcvlmUYB9LAgYBlcnI7pCLQKvpI1ozRPAKsMZ1U49ILmvAKL/Xmus8tFaaOYlRe/ZvVNiRkdreZXxuDDMxQKUY6rwJihLpiBUOMSRv4tNIAO7Pvp2JF98C3Ezyx63BFUAWaqfQTcrGM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7353.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:440::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Sun, 18 Jan
 2026 13:55:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:06 +0000
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
Subject: [RFC PATCH v4 18/38] NTB: ntb_transport: Use ntb_get_dma_dev()
Date: Sun, 18 Jan 2026 22:54:20 +0900
Message-ID: <20260118135440.1958279-19-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0080.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7353:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd928bf-7815-403f-c8c2-08de56992ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EGEaASkco/ECVHIPI6saI/MGf8mviMi6ExAJhh1boQvpD66XLrhjERNZ65NH?=
 =?us-ascii?Q?Ss5ArcIhRDSV2f2u7JSE+xsl7BnIdYE6F/FUHxkRWceI5yvvbA+8VYBZSdq2?=
 =?us-ascii?Q?ftWTcp+M7HnJ4APTEckzClxQPL6uPFezexh521WDHjPOYlzZopJJspsrGOwS?=
 =?us-ascii?Q?sBkXN6FITYA3TGygW9BXp130nocLoUToClCZq78yQu6QRV/tGRak1SgBcFMo?=
 =?us-ascii?Q?CoaKz+3TxJH+wqndf6o0fh7dnoJRhdX6wNdlhp1WX3ArxHw1hisBHW1y3jId?=
 =?us-ascii?Q?Vq75ATtROWemkgJmmoj32ovNAjrd38tkU3S+occ5J0XGtW3VldpnlDUEPwnl?=
 =?us-ascii?Q?k0Q3ickpbMW2YtvozEBTrKzmW8rzN6KDBPFGfl5OnIL+uW+SJRvuA+1Z9Sut?=
 =?us-ascii?Q?PL5ltFZxMLygFkrDkgzRrNbVQAKS8CDIWpJlNooNpvKYeTvxHK0GkYtPNWg+?=
 =?us-ascii?Q?U4/zbEStF/r4+mBYGA6Uxkohd/VC/uOat/79K2LEyik3N/nHeSYFPDNCBfty?=
 =?us-ascii?Q?xcvYm08qX4kCSokAI7bIWEkwfQRO++bOPNoCyu0zOLaYlNlkJH2C57zRBVeX?=
 =?us-ascii?Q?UPp//DSIQGV3C1bLfTllXTss8HPCVS70ANclpfxKABjeJmlkdDE/2LykmPEL?=
 =?us-ascii?Q?ANHzjMUt/7QFokRfRaZNQ761FfZbHaG6PriApaq3GivSLvOB3lx0OAw13gkY?=
 =?us-ascii?Q?hzB6wlHoempmfMxUqf6drdb2aunwWAjXjOvHA4ilpnVLRXMvHRaqlOXep3H5?=
 =?us-ascii?Q?TWZGIGEhLgHXD4qftepXwLjFIsmoVZY+aUUE6wO6NuAtOceBX6XyBVrwj8IM?=
 =?us-ascii?Q?fQg+meajKqpmPjC0tUssxlm0CgAY58BYNh+dr6ac6SlIklqpD+Na0A+JlRDk?=
 =?us-ascii?Q?kxYY1r/8+46cUeYHamnxb7zxnTBUB2arV55nVYNiYmQAzoiJl7XzzI0Wmrhd?=
 =?us-ascii?Q?alV7tJCCBezFjb4gA+fZP6lTmpys0UPF2nrJDlEK1J7xTjMr6M9J7yQxy1HX?=
 =?us-ascii?Q?ej+02TxlnjxWflMWAqOmpKhaVVWD775D9dYd9qQknICh2UfMebuR0uCuRob9?=
 =?us-ascii?Q?bcSHKZH/QvWBFnVfCMwFh6ycggLr1ifk856py9Vp73h+9gQrZocS/Mm0fQbq?=
 =?us-ascii?Q?tlB3UBER+wZIe15JR8KH57fc5iqExiRPINIMJtgud4VfNcoXXdkNkNy16tuO?=
 =?us-ascii?Q?vno3p7s8vy48QHDn3iPnQopdrncgKHDKv/n7Yk59W/tG7+yTmFj3zssmNgRt?=
 =?us-ascii?Q?Fh5EHuMaaNrP2sI+mgQAeLIswq+l/0nOR9aDx/8bb4+ybXAtED6whDHO3U0g?=
 =?us-ascii?Q?CUoTR5OGVSi7fuKUHVZjEfYPkdYbNHfhAuaHmq0mh44cKCAd1+1NLXKjFCpV?=
 =?us-ascii?Q?b6crQDIaelfFLcmdJiSn5MTeIB86ro50+PFDlvHg1hiTit/6oVyb6abHAuWs?=
 =?us-ascii?Q?ki9Yr0xb/LExl/zz6xG0f6cvnPN8Cf9SvB7aMuFB22dpMAKLmYL/SpRzYgsq?=
 =?us-ascii?Q?DrSO94oFUNVeVdyiCoc6x53m6EFrDZG0A/Rq+UZd2XcNwYBDq9ZXFSb9JO6x?=
 =?us-ascii?Q?a+bnGfFl/qT7eJmzCtGOnO9eaqX+xGLM8S1jvVf73JWJU0UjOfCPzlpaFG8W?=
 =?us-ascii?Q?uw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b6VYvHpQTTKdzuMyLBgU23TrUyGOwsO/vi/XIro2W9CwQ/fRXyN0txiyBDaM?=
 =?us-ascii?Q?iMpnpRevU2viKAnRM7In9G7bttLuaWNeCMFWkUyGCCWn8NNA3Hkz9bD2reZu?=
 =?us-ascii?Q?1N7lKIEtNoOyVQjq8neoP5S9UBqGBVYeWIXUAV7ccjtB2647NyruCHX/G56U?=
 =?us-ascii?Q?SVCDISHGBcC2JFXCrzPeeISYctHERP52UpdUdqTtnuGz1EdR8bxWIf4n+9Yz?=
 =?us-ascii?Q?yGj5w6KLqVSl1PPQiNhtSy9oCfeezF/brvphrR4JdJlRUVH+aAOBBldy5w5v?=
 =?us-ascii?Q?zQEsKX2E8fGwlSLLYmFoTXQFFVZNMXoxVHc8Qt98OnDYwshtIJ/zBw/97FWK?=
 =?us-ascii?Q?9WGpuD98Q8rNz9ShjYT6ci01c4U9JmVh8X+hGAh6QXwkAMyXD4q1cWmsW8VF?=
 =?us-ascii?Q?BhdckU2m8HaNZUhfIErJXxAw4DG/r9g2Dd1q0ovHNPymyEp0O99+z0E3MG+c?=
 =?us-ascii?Q?RE//Uww3Beh4YXI4Jv9lOpUF7ioJRMX6quilzVhFPJOMI6+EQMhijdkDy4+U?=
 =?us-ascii?Q?vumCfiIX91MBIgJHVy/04D7S7EmrC5ue69dFZoGcqHg9wbGnLXCnnGWGuxHD?=
 =?us-ascii?Q?a616Rr2GXwUUaaJ9dYj5vmIrtr7P+Y4Fu4YCHGz6iUTgfqWAoaKlq19VHTSn?=
 =?us-ascii?Q?pXhNWsaL/gGLoABoEbmc1YoU7gx+HiFFLM5getGbGE0//42Uhll1KCZFETvp?=
 =?us-ascii?Q?MJ8vfpZ5N3DZtksn2MCI55QCLzTt11FxREG43YgpNjOk1lU1Qh1wGTPDx5x9?=
 =?us-ascii?Q?NnwmQHcxadi9xHV5cEHM2duHdn0EmRYKRxd7RmCaRvm+CifkHGqyNw6O+FUR?=
 =?us-ascii?Q?wb3WChqXmYn/rjWl+guokNsFFV7QWuSBK66dKSKIakOZleZS2IeKCDH8thIL?=
 =?us-ascii?Q?UPHJGPpi+b4TSfBJG53DRALtBQyReB2yO/h3s2892EVUgL/if7B0jE7caRFd?=
 =?us-ascii?Q?+Zxn5xS6pbR5ZXAP9YHZ70DPsV8HRyx+/4d9AMCflwWgrY9owAF3jl08/9ah?=
 =?us-ascii?Q?766HeyZEc4mtoMp4OSgB2EDmkUAofdmrHXDrFP7MSzrlln79YhrgruRTrjXP?=
 =?us-ascii?Q?nd1NXwPlW4Of9sDeQElNOKwqdGwWoUQgJ2lDY/XaFMpHAte97/ddWv7lokq0?=
 =?us-ascii?Q?rqwvLzBzCD6q8qg1YJ7RduAbi3AK5c28uCUt7bWTW2NdAcE9M0KebCd2h7hA?=
 =?us-ascii?Q?moPzLF8uWP4WxmdvDzYVAp1mV3HIKe3kEkBevWlunWnijood6AGR+nHzXRf5?=
 =?us-ascii?Q?7ok1sU67n1+nKUAhQJSgEv+nk/tOvrrFUXqb97nUNNnT27ETHUZi7KBtednU?=
 =?us-ascii?Q?g2m5FrANr31U9em7szWonHj071NQc70BHcN+bNi70Q15tSejGxPkzmVj/q8l?=
 =?us-ascii?Q?eOUFIR7twRdBthbfcamt94Iu6/2OGutFN3JFSxSMLBaFxq6XAMru6xUvC5s3?=
 =?us-ascii?Q?bwpTr5wAtDPq+z3TlhNwMQ3i3l1DwSSg+N93eFFKgPvET9Jr2Bw+KkOE/fgB?=
 =?us-ascii?Q?Cr97TT31Rhu9PEpBr4nUvf8MR3L4jlM4c7GtZ67eKGfMS7uUv/2Zf2So7Yq+?=
 =?us-ascii?Q?rDAIt9BttZANmlSlS5T3CX5cy+hRcRFL42a1i36abU7lEhpapeXtDu//dVjm?=
 =?us-ascii?Q?jTwTDXQ9vRHp6suxwT+6NWWGvQ7fAg/s7ot408VIJnHqthO1LlBfT7ENE1OR?=
 =?us-ascii?Q?xLDgTVTfoygvXJN/QuYo7FP2dBiJ9jKTdSkw6g7KYDEMQ+9/miZTPdE44/Th?=
 =?us-ascii?Q?WJIIzsnkl0aiLyHAksQOedGJ4tg4Ues2mDt5giX7+2qdOfaqMaRA?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd928bf-7815-403f-c8c2-08de56992ff6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:06.8279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMoCg7nZ9objVO1iSapuRNZYk6XDYfLzYa4H4qmwUA1ZPqfgm9ZuxWgs0LHHQ7e1B9WCgVrD2fSpsxpYb2muSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7353

Replace direct use of ntb->pdev with ntb_get_dma_dev() for DMA-safe
allocations and frees. This allows ntb_transport to operate on NTB
implementations that are not backed by a PCI device from IOMMU
perspective.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6ed680d0470f..7b320249629c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -771,13 +771,13 @@ static void ntb_transport_msi_desc_changed(void *data)
 static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dev = ntb_get_dma_dev(nt->ndev);
 
-	if (!mw->virt_addr)
+	if (!dev || !mw->virt_addr)
 		return;
 
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
-	dma_free_coherent(&pdev->dev, mw->alloc_size,
+	dma_free_coherent(dev, mw->alloc_size,
 			  mw->alloc_addr, mw->dma_addr);
 	mw->xlat_size = 0;
 	mw->buff_size = 0;
@@ -847,13 +847,13 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 		      resource_size_t size)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
-	struct pci_dev *pdev = nt->ndev->pdev;
+	struct device *dev = ntb_get_dma_dev(nt->ndev);
 	size_t xlat_size, buff_size;
 	resource_size_t xlat_align;
 	resource_size_t xlat_align_size;
 	int rc;
 
-	if (!size)
+	if (!dev || !size)
 		return -EINVAL;
 
 	rc = ntb_mw_get_align(nt->ndev, PIDX, num_mw, &xlat_align,
@@ -876,12 +876,12 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	mw->buff_size = buff_size;
 	mw->alloc_size = buff_size;
 
-	rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+	rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
 	if (rc) {
 		mw->alloc_size *= 2;
-		rc = ntb_alloc_mw_buffer(mw, &pdev->dev, xlat_align);
+		rc = ntb_alloc_mw_buffer(mw, dev, xlat_align);
 		if (rc) {
-			dev_err(&pdev->dev,
+			dev_err(dev,
 				"Unable to alloc aligned MW buff\n");
 			mw->xlat_size = 0;
 			mw->buff_size = 0;
@@ -894,7 +894,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 	rc = ntb_mw_set_trans(nt->ndev, PIDX, num_mw, mw->dma_addr,
 			      mw->xlat_size);
 	if (rc) {
-		dev_err(&pdev->dev, "Unable to set mw%d translation", num_mw);
+		dev_err(dev, "Unable to set mw%d translation", num_mw);
 		ntb_free_mw(nt, num_mw);
 		return -EIO;
 	}
-- 
2.51.0


