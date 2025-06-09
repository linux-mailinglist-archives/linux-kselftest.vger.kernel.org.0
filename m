Return-Path: <linux-kselftest+bounces-34507-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939BAD2431
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B528C3A88C0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BE5220F4B;
	Mon,  9 Jun 2025 16:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kfZB0Rwy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010058.outbound.protection.outlook.com [52.101.84.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF2A220F35;
	Mon,  9 Jun 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486929; cv=fail; b=i4wD2rji9xXnU0V0P27LkqXsaC8aGx8vrEDD+F0sa9Ytv6trGipF+ofB4mxpY/HyDMgx56m/4dgg+5wTx5apJCXVoHwlmz2mQwFdsaGDDYw2Utv6K9kUCVpMC5Zn/0Y16Oh+b9HnQHkFpvHWvnPfCQGyqXmP9i2lM3SEHhd148g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486929; c=relaxed/simple;
	bh=fMIJiBFW2WMcSOKrhRn5kFjOpXJCZTG3t+Ve2rTIJT8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N1SpgFRcr3ttTwr5e/z7lT2ZTvAtcZpaHeciPpi0AAGrPFrJl//8Z3DXBMg2iYwFn9V4STkp6AivxUBksdBR9UgCWg8ikjIoYPt2Ylo9LXAXNBaNHvi85UhogJFfae5NR2EF+5n32ml41SEdD6dYfXklLyZ0JFoNkc3lp85bFGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kfZB0Rwy; arc=fail smtp.client-ip=52.101.84.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqmK1OQTqvwzFXsOqEXArkp+Y6AeaePNC+lmyLPHTDJvOZnIQs1TyMgQa30bIRwBqmIV7R25F3n8n5lyZ0K2/nof0zBanK91IUwtKoPHji1jeFe6kCMSe/FLDXW1/olen7Nee5r/gTYjYt2dRQ6teln54MAZ+UTK+rBrspIceM69eHVz0GI5AzromI7WVlCODWOhD/lAfRLmyEuN1wL/uLnGEBEadvwMA3aUDDlyd+5EyD2pMRiQszO2zzxRr0WZbHS1p+Y9HAN2ZjigXEdEPs4zgM67V5zeH4jhTRmpQyiEsqfrlVkZQUhWh1fExYVVvcctQjNHOpBRaTOQFdLhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfGOa0qU7A3qwcfXGORo4XDYU7x9PcRbJHxgWdG+2Ho=;
 b=sSSJcG6jvZbO0mdS4SzpzR+VCTW8mGwu98/TdeOAnVuLbhsEfLB9fxrYc6zhGCj5s+xxcw4qwL4hLd7I13tc/3QRupvLBHEXyyWV3svXFNMWCuoZ82bvHRHy6+UUz+4RTKXDzN4J0yjzV34a3/gs5QhF9zgup/NYKfKHQ9tGSTvT6QpeWvYpI03zdz170F5lZaEJ4jxMWuXQrXYDxMAa+bEIR/jb7lX0m/9hsDC2y4PQoZV4wQCg2REWqhxrmwiVRgOx5/ny8XfNLDOj2eiwKidth9Ja8UfszAtmE0ZflRNX6ZqYO90bWGmB9RiTAt/W04LcxRmara76Rk9iNWP2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfGOa0qU7A3qwcfXGORo4XDYU7x9PcRbJHxgWdG+2Ho=;
 b=kfZB0RwyxnNELRUcWqQ1jCkjibGZvCQ+KQSPqKeCf/ZYgyc290Opu1Ce1fPuWU9FMddFjbqRx/VBMuCDnKwO+oF00wo9RH7kLkRvpW5adaYlMaN4hKGwxcr69Gs6KB+ofpH5HXvXd5yrqBhmD7FIJZwRPctAqax/mXQfLZIDn3md1rXmThPorxm9N59qPH1EwLlFLNtqU6A1guNtfK4Q49s7kuZqQnX7I1N6VwjNGaOeXsYWhclL7nNpdMPaNQRcdMxScGlhkH4L0QuwZfPyDS1GJ6CnmNERVv7woZtP5bsC5jplTsYdEanqPse+q5i4I++kNPuWDYd37KHw1qSmJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:35:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:35:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:22 -0400
Subject: [PATCH v19 10/10] arm64: dts: imx95: Add msi-map for pci-ep device
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-10-77362eaa48fa@nxp.com>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
In-Reply-To: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=827;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fMIJiBFW2WMcSOKrhRn5kFjOpXJCZTG3t+Ve2rTIJT8=;
 b=JAZ88iJnoCyLeWQCQjteL44ZjzFIH1KLMgd1ZKaz/Wce/ieREq2e75g9n0F1wYUrMcNJHsbgs
 EehJWdIeBEgAYEdCr8ZAM7knxEtYZYd2cWl2umUWbOfSskMlXPgwOFl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e98b5bf-2cd1-40d0-edac-08dda773a1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTJJSXZsK2NWUTRycUdjZWxncFNFaFY3NGZFZXdXL2gxNnBYL1NJWjc3eWs0?=
 =?utf-8?B?N0cvNFNGZUZQQ3cwWGd1SkdneUt3VzNIZnMyRklqL1JMdGc3ak5UU1VRcVk1?=
 =?utf-8?B?Z3BmOURoVkx0RDFLckhQK29CMkFnNTlJMkppWktDZEZLVzdzdkZpaHVEaks1?=
 =?utf-8?B?K0xhRGQrS1dvOHRzdWhqWWxjdDh1S1BIUGNQdXBMd0dxMDRFemRkazI4bFow?=
 =?utf-8?B?cDJtZ2FsVVZVQUFxZHJXaDRJZ1V1NDNqZmp6dDBvTTBkUnZZclhxSWpmZ3o0?=
 =?utf-8?B?TXl2TFhFYmlkY2FhejdmUTN3YWJ6WUNna1VFMFRrZDE1YXhPYkZDSGJLN0N2?=
 =?utf-8?B?NUdHSURRNDM1Ni9Yc0JOZjR5dkpVNVM5b3ZKcENyOXZVVXM2OCtkSHcvOXJK?=
 =?utf-8?B?S3o1KzQraFpxQjZDOXAxM1dILy9UNExvVHdBN2lVNWJnaU9wcTZoK0JPS0hX?=
 =?utf-8?B?RTVtUHE2alpJSWR6NGpnNFNIYStHaWxQbXQ2Qk5HejNvQ3JZQTFPdnVZdUFs?=
 =?utf-8?B?WXdNSzgwbXdtRzhSeG9ldUhCNk8xdmV4ZFBtN2ptWHZGNmJyMXNIODNGYUUr?=
 =?utf-8?B?THh6YncxQ3NzdEhNODV4QkVEUWJiUVowK0s0WmtuWjdPVXNoaWdKL3k0TFdU?=
 =?utf-8?B?ejZxL1M5eVF3VkFoOHVtWHZDVnFTU0FWOXJHMWxIMVBJS2UyZ1RLMUJudTcr?=
 =?utf-8?B?VFFQclFuV1hhMU5YamMvaUxNc2xwb2N5aXNPemdpNzhBK2U1T3NCNUlhMGFO?=
 =?utf-8?B?cHZqSHVqRHpXdjJEcWhmWXhXOEZmZG9Kd1ZjOWJMSjE1S1BZcVpiZzQyY1RJ?=
 =?utf-8?B?WjdHUzVVdW05R1p2UmkrTUw5U0duWFhyV1FNRTZjaSsxZXFBR2l1Qm0zKzJ6?=
 =?utf-8?B?RnFCUDNiSjBSNEV4SVN1a2RyQnBKK0NCeWpGK0JlZTBFckZOd25ZMVJOOUJM?=
 =?utf-8?B?T3BMS0pMbXYxUWpoV3BCVnIrdWJTOXJRQUZPdWZKc3BVbGpiRFUwVmllMXVz?=
 =?utf-8?B?QmlwSG5UeC9JaHpxVlJPc21UOTBRQ0dlYzRuSUV6UWZIYno4d0J5dGFKS0Ez?=
 =?utf-8?B?NHdhNWUwUlFqSVVmUStaUGt4MlAyNGZZUWFWRFhyMjI0KzVRN3dta1k2cytO?=
 =?utf-8?B?SXRhZGlvYk44VWFFYThVOWpBbmxrbWx0ZzFCUDlReXR4b0NxalVkbEc5T2Fs?=
 =?utf-8?B?dnhUOG1ia1hyK0NIZUY2REV6Q3hzSkRzYzJVcXd6aFA4WTkyV2E0SlROdkZN?=
 =?utf-8?B?WnVySGcxVmJ2azVIc1d1eUxCaDRRYm1hTlpKTFcwaWJmL0VDRFRVaVZDbzgw?=
 =?utf-8?B?cHJwU1V5NVRqTG53MGNUdHpZTjYvaGY2MW5Zb24zY21nK0hVbWtFMHBsNGEw?=
 =?utf-8?B?V2NDWGhnMnY3MTlkSkhxSEppN3hMdFR6TXRpcVY0Z0Vxb3hjM3FHcHh3eTgr?=
 =?utf-8?B?QlgxMU4xTjkvR0NMWlIxbEJUOCtZKzlJaDhNa09sTnp0VDJXVENaeklIcmp3?=
 =?utf-8?B?b0FrUnZpREpCdkV4UVp2RHl0NTN5eU5MNVVUejFvM2t1bXI1Zkl1MVlMaDZY?=
 =?utf-8?B?djdFWVJzY1ZMeWgxNXJ3RWZLUUhQQmRkdEdVcTJYM0JYZytrWnlVQkZvSEoy?=
 =?utf-8?B?WnN4UjkyMjkwOEdoTVZYMXpNS0VVMVJqVm5FT2RabTloamRaZ3ZIVHpTRldo?=
 =?utf-8?B?QnE0d3Q3RVR6U2FkV3JzWVBETWpTSmRNcXVGQTgwR2JiTktJTm13bHBLOEkr?=
 =?utf-8?B?ZzFoU05sdXQ0ZlpUQ29MWWNKa1VqREVLc0d0czMrL0ZEY3B3bmRvMFUxVFR4?=
 =?utf-8?B?cjZhUHg1N2pIZ2d2N0k5My8rbkVJaDJ1cjlScDlQNWgzRXA0d0Z4aVZkbUx0?=
 =?utf-8?B?UTA0SFJ3R3NWUnNDKzF5V0swdVdXUG4yRWc0YXlGTEpSWndQMkJUQUcwWkdS?=
 =?utf-8?B?WksvMUpzZHlXSGpVY0JmckJra1kreTc1OUxZNWJwSmYzYXdsWDFYVThHYktn?=
 =?utf-8?Q?Uk0+tkxCm62E6EeJhssmkJIBoY6c8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnNJU1NncHNWcmpKUnVuMnk3amcrdW5sMjZORE5tNG5SdGhpWmQ3d1dtSi9u?=
 =?utf-8?B?UENERXhsQjRrZzJ4STRmUjdvN0xaZDRFM1VBQWRYTkhpZ3pWdlh1VmFyUlM2?=
 =?utf-8?B?MVdCZE9lWFRoOUJkMiszRmxxSFBORnNVaXBMVVVFdzEwZTF5bTdHQzlXOVNT?=
 =?utf-8?B?c3Q5M1NScjd0MTcyS0VmVVMrU3lOckE2QU8wL1FCVTZUTGJ4QktwUVkvZWNz?=
 =?utf-8?B?ZVdwMFZrbUVZOURicC9jbDJqYmVwWFh5aWViTXE0WURkaVFEWHFldnBIVHNo?=
 =?utf-8?B?d2NlYkpFck0rRzJXUGhURkgrcHRDdHU5U1ovS2o4M3dJWGQ4OTBBSlk3cE4r?=
 =?utf-8?B?bjFBYWd6ZGlnNFgvaXdCcTBQV2ttSmhtbFpPZVZSMEV3NkhaQy9CRklkKzJ3?=
 =?utf-8?B?YWxKZ0tJaU1UaVhSRWtERXlCTmlyN0NGTTNhL080OERacU9UNTc0K3Awd1pU?=
 =?utf-8?B?c0xWdzFyQ1Azemx1ZnlLMkxCVlltNVI1Y1JFb0U4Rk9BU3dObGlWd24zbHVz?=
 =?utf-8?B?aGppejE4OVJaWXU1bzJBdkxvNytsQ0lHN01FSDZDRVBwaFBnNTJrd2EyaU5u?=
 =?utf-8?B?UUF4TlRlaEJOMVkxalBxb0VOQVdvMFJOVElhVjhhalpMcjRsRnE1ZmdHSUs0?=
 =?utf-8?B?dXl6Q0UvWFFDWHcxMGNCM2I0SmcyOC83c3prUHVSdXVqSE5rdUVxRnhXdzNw?=
 =?utf-8?B?YlRiTGtxUlVIRXFJb05kQ3NiVTR6RStoUjlpR05VbzFURVJZdWs4U1FYd3l5?=
 =?utf-8?B?SzRaMDk4Z3FuYkxXTTRqQWUwK1BFWE13MjJtMzhmVm9KUVhDc1VkalkzMGZU?=
 =?utf-8?B?UmZrcytIQldSMjg5MkhFNGhZT3BucHdKOENFZm94KzVBY1VZMUJ2bURnVVBv?=
 =?utf-8?B?Vk1KQ2tIeFVjRXh4M2hmV1cyYjRxN2prVVJ2YmxKeTRGZTVXV0lneEJpK0w2?=
 =?utf-8?B?Q1ZLN081MlFnVDlIWU5nblA3QXFqTlhnNE9EMEtpSDZXYWhDTHBZRlVYSDl1?=
 =?utf-8?B?eHI0T0FVMUhFZ1FuQ1BRZWhZdnQvYzNiMk85VmplZ1hPNWVSZW56cmhRS2wy?=
 =?utf-8?B?bFlHWEZsR09FakQ4dEpXL25jZ204OGpIdGswZnZYOFpqT0ZLTXRDd3BSWVpL?=
 =?utf-8?B?ZlNTWXVUVWMrN0dRbDNadkNYb21kRWlnYld4WVJGRDZUU293cDBPSzkvTXpR?=
 =?utf-8?B?V1orbXlYMnJwTjllMzc5ZHhzeU9ObUJGV0JHNC9sOUFTSXRBcU5Md2VZVzRT?=
 =?utf-8?B?RVUvN1JvQTBFM0hxN1hTZEpFMHJ2RkwzT0FaNFovVHVBMkZ3Q2FMdWV2Q3Ax?=
 =?utf-8?B?WkhHY0Z3M2gxV3NWbVdRNk1la3JQb1VnZklCV2ZBUE1KTGZNT0xlRWpnNFk4?=
 =?utf-8?B?cUx1UmZIU0xwRlQ3ejN2QWFzS0NxeWxLMWl1NmxTRWFxTllHS1JWcHBuYTZt?=
 =?utf-8?B?WnNnWnVsaXpUbXlTcmpHT2RUcWkrZE4ybDA0TlNKaTllOHdMWGVwdEdDeDI3?=
 =?utf-8?B?d3pCR1BURXJpQWtRQXkyUm5ZREU3UWI3NGVZYzR4RjNWS0Q3aFJUTXNqYXBG?=
 =?utf-8?B?bFN3anpEckVHbXNwbVVTNXJsdHlJVndyd1ZMV0x3c3BOK1ZUczFzWE1UY04r?=
 =?utf-8?B?L3EwYzJBdURrcEU0VnBGV2NDUDBKT0Z2YkhPTWVUcWd1bDZyYVBJRHpVZk9k?=
 =?utf-8?B?N3grejc4Rmw0RitSL2lRR2xCbFRVMTY2ZVJBMnpxTkU1WXEwM2JSa0pVaDAz?=
 =?utf-8?B?b3BXUG9md1RiaDBVV0huWnBYWmgvUmQxTWtkQ2Nlbk1Na0w3S0M4STc0eGhi?=
 =?utf-8?B?ZUEzYWRscWJLNFYzWFZVVi8zQjdaMmZCQzhOVU5TejJsVVZ1cmVERCt4V2U5?=
 =?utf-8?B?S0RSSjBva1o1dmcrenFMZFBUQ3BCK3BoOTA1ajlOeXNncEs5MHVnNW9GaDhH?=
 =?utf-8?B?blZzTWllaFRCY0wwajBMZnZGczBHSCthVEZJZEZteXRpcFdmMC9kS2lUdWFY?=
 =?utf-8?B?SUdXT3V2T2s0Y0hGeWhRWGhlQjBlbGlON3kraEx1YnZNL21FYU16ZDJ3QUwz?=
 =?utf-8?B?S0RNMFcvVWpQWjYwTy9MN091NE05bEw4TWMwTEptTjB6MjJMR2h6WDd1S1Fj?=
 =?utf-8?Q?78blPnz2nZrGq8cp9/cl+9io/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e98b5bf-2cd1-40d0-edac-08dda773a1f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:35:24.1609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HiVQNaw7EjlLP4j5kkwvuHySQ/TuPzImmWN3wm9TQELOCq9U8j6Uod1Eo8nBkuCpN3gri2oWs9hqXvda8LATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

Add msi-map for pci-ep device.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 632631a291122..c59d11eb7a581 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1797,6 +1797,7 @@ pcie1_ep: pcie-ep@4c380000 {
 			assigned-clock-rates = <3600000000>, <100000000>, <10000000>;
 			assigned-clock-parents = <0>, <0>,
 						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
+			msi-map = <0x0 &its 0x98 0x1>;
 			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
 			status = "disabled";
 		};

-- 
2.34.1


