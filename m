Return-Path: <linux-kselftest+bounces-30751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B142AA88B3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAE8C189A6C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603BA2918EB;
	Mon, 14 Apr 2025 18:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8jNkT0N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375C2918E8;
	Mon, 14 Apr 2025 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655522; cv=fail; b=OUNT7WZz6rfKAp/j8xXwxX3Jjp+IoWBknfhz4mKwRgficrLzQArJcFVeTfH9LJuEx+/GhxPA17fvUJfBNG2ZBr+h6KH7JvUeLQ/RkbLflSHvDZAUDlLTO6pYZOGdqMzg+bVOALeEmF2B3YyK5lR9311zT4TxG9BcA+Zzg1RcF1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655522; c=relaxed/simple;
	bh=zWJgc1SPoeJ2QBwxQHqDEE5KTaCTR3/w/iApYH7Ymro=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qIaVXj0ThX6aeS1eqIMVS9G1mBkXOksWNzYML/U7WAtJ/dIo0to5QPpto9ZIjuQKoas2ktqbgPiVvgNQyQuAGxDcBFXlLmnRvaJue6z2oj2caL3sIhCktmJEkPkGRjBr+DJxuyl6ZfRvTC6m0LyilKRtmpNZrnNZsYCP3x4CDiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k8jNkT0N; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixtZJFa7QQPJxkB5GNEaR1yG73v+ZJ3ZyhfVURDK1PAaCYwnIz5l4y8DOn3cfaPiOeryYbyuzHIFEIQ1Bjg2SPX2WXLxq89I9yZn8BVXcjlrP0TcEiIzIT0QYTzp9f8ABWM/cOmV5k9db/JolZrmkYNWcOqwDuCxeCw16j4jdCEg2yW8bz0yzIhhiYFk0pYHeOQRr9x1ySQ30dl+sJsmDJWQC6ZUHCOEmI5yYw+M50E+Kod4xBBfhJOhRpkbMG5lqLcR/20mRVD4lmZqIrUBZxIch8IQbAXR5pR8DXGuUy/l30Z5k7XWGk6kGMKg494A7OGystmh472kvscmN+HVow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xqxkgKvm1gj3A6xt5BIY8xtOtyrPDV5+Mm8vHnWShk=;
 b=Bqa7i1Vhplp7wxYk02+CgadblV0NLFYXZXvQn1+8ZEyt0iKwZtWz4HiQLxKFtrdwRIsudDMShDBDPd0T01tSPrxlMUmCMX9jOxpQbFmmTXgxOJLZ8mJ8sAR5Dp/sOLp7ru66U7PAx+HXQPhXyZRCt4VgBo8T4PDeIUWDLEze/aSKIRRPkle3XgTfpay6F1Eg22PZU6l3XgyVB8lgbutGZeG+rAJsvmUKnH4SwurC1+5kvZ/sT1MywULfnQWlVfCRC+h51XXNnZ/HpklMCmz2N3xvpVb+DmJGsTdeNyHxKlxLLfB71yhFwbLxZWctZJUITelklMm/UnmqbLuBckTSFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xqxkgKvm1gj3A6xt5BIY8xtOtyrPDV5+Mm8vHnWShk=;
 b=k8jNkT0NqguI97p6lFbeDPeOXRWrahmv2xNNACPZABXfXsT+aJ1HcecIMwtklTp8tFvs5mcFBmUsUb9QGsMJlYANzzCDctj34v4d68wSqKzAEV/zwt5UXccgaSWv1C/zIW778EZXMcJQ9a4IfpBgsFC7G+LyTlinb8BvKlVubzxzxP7Gxr94/fSOcvggbFvz37++sPJTpOAm9uqykiIfxnepZTXU/xMAxW2gCLowm7I8O4pzptwlWhikUMoXH0dkNzyQFYH9Vx9CqUzoNbmBwkqPWbvnfMrzLsOhTdFzAjwtqPzRRVfF01J/68Gfg67ubMuJCFB9MV+nIMIklEyqGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:01 -0400
Subject: [PATCH v18 07/15] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-7-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
In-Reply-To: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=8330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zWJgc1SPoeJ2QBwxQHqDEE5KTaCTR3/w/iApYH7Ymro=;
 b=cFdEOqN1WpyeEwRmGErVYyxabXs3IiyDvRFwvHO+AdT2sw033Ha+HSjJew43mhwn4zdtBUxX+
 tDim1d0Z1duC1/Uzu9Yg3HIEAk+E432+CwM3rAPEGwdLk3TyUxo8g+6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 759b0aca-b383-4727-08c8-08dd7b82a2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXc0Ti9NWDZodUxaN0ZXQys3b1dOdUYwVmhjYk1HdGRlSFVPMWRDVkVBNVhZ?=
 =?utf-8?B?UXRKcUZqQk00OXpCWjZWSzkzeWlkMk9lUnhtMFA4N3FIMEdJRFNNTmZnb3lq?=
 =?utf-8?B?YlZ5aFRKdTRmSGFOMEE1YU1CbTQwd2k5c3YxRFR2d2VEQ053aEQwVnkvUitx?=
 =?utf-8?B?MEZBWXFmSkhCbDJZSXZiRFhKV1hwWlVFbk9hZ3dKNHpLL2dTUnVYVEpZMmFL?=
 =?utf-8?B?MjRiVVJhdEZLT0c1aXIzLzYzOHU3L2pKMWJOTVE0L09rMjFQcStDdThyZ3kr?=
 =?utf-8?B?M3NPTXYwaE5DOHl3N3pxMXRITUdNZ1d0dHVEendwcDROdWhUM245RG4yZnR3?=
 =?utf-8?B?NWJibjkyVmplY0hoNGFVYXZzcVpCZmpRc2JWaTVvbkVsSXErV2tDM202NkJ2?=
 =?utf-8?B?WmNiSVN3bkxKS2J6MkFtbjRKdE9OWkhtZlRtemhzaFFXR01GL2hjYktrQlQ0?=
 =?utf-8?B?WVdZWTd5SklzRDZtejUvY1pIbXZKWjcrekVQRG43NEZoTkIxbzdsNXlXR0E0?=
 =?utf-8?B?MmRCNkJiWSs1QWVUa0dCT3hYUWJTZDEvYjBMWi8rU1ZLV1pSNjREakI0MGNH?=
 =?utf-8?B?dzlVMmR5dFhBMStOSWRUc0QwcnprUGRGMVVYeTNNNlJ6SFFjaTFBeGtlNHha?=
 =?utf-8?B?bGxmbjUyeVNsVjlQd0RxYVh5VUIvWUxaT2tUUkk3RHlrYnhleFJ3TDlYRndT?=
 =?utf-8?B?ak9hOE9PMlpQMlo3ZTlXeW9ET01WSVdHN093OGlaR3NrLzhqV095MXFpcmxV?=
 =?utf-8?B?RFBFNEV6LytIcVZCTjVqWGVCblNSaTVmZklmWUNQYklJbys5S3RIWWYvM0Fz?=
 =?utf-8?B?eVdIMHJiSmh4THM5bEp1RXgvVTBidVRLVThLL3NGL0RtbW1vRlVaMHFhU1k1?=
 =?utf-8?B?STJ1NDdTdnYvdEpVbURPaXl0YXhld3ZMQkNYNHdGZHdKT3RRbHdCRURvV0JS?=
 =?utf-8?B?UEpad1hWNXgyR0kwUWhwRjBpQ0V3bStHV3FLVC9GeHRQTVZ3TmlNM3FqaUdP?=
 =?utf-8?B?Q2dSTWhVTVR2MTFjbXRFeG9mWGJia2VqSUUzd3doRDR0WFlIWDhlTXBNcW50?=
 =?utf-8?B?M2twNnpXMzBiSUFzaytoSFFJTkFsWWg3eUlpQWdWOW9iVmZQbmtKVU5WNlVO?=
 =?utf-8?B?ZHpXVmx6eUVZbld2N0ZCRXFGb3RVaEczR2ZsUGJSSGRMNDhHeFRHdUc0ck8x?=
 =?utf-8?B?am1lL2ZIN21YOXU1dXZNaEZsUVdhOWQ3ODNuNHg3VGxObGVOaVZ1ZVk5dFRj?=
 =?utf-8?B?VVI5TXZWZ1JTMHVNdzBsL3ZjbHBsRkJWSlI1Kys1RnZXenVTTXp1UTlUSFl2?=
 =?utf-8?B?dDFOemNQT1hJdTJ4TUoxNWtsMmdrWGFsbytqbGhnYlQxZVA0ZHNaRmpLWlFW?=
 =?utf-8?B?ck1KemUwU0h2dURBQ2xGY2tldDhqTU1TMmtleHZBT0oyZWRvYkRtWmRTTTZO?=
 =?utf-8?B?dzA4b1VmdG13ejYrVkcvWXVEYitYcjhESUhxWWNZNzB3K3ZDcDhaaUZjSFhv?=
 =?utf-8?B?WlBkb1A1eFE0UE5JanFmSTFVNmwzVHM0SmVaZXNvbmdDbnhrakFSOElNUjRy?=
 =?utf-8?B?cHFTTmgxdTRmWE40ZktrbENha0dyRTF2bXZydDRJYlJieGcrTGtyTmJYV0tW?=
 =?utf-8?B?OW1FU2JXNXBYeTRPdVlRL2tVUXQyVnBnRWw2Rk5VWXRWSmhqSGJibTcxTFd6?=
 =?utf-8?B?ZDFlTS9BYnkxbzlBVlFKbmZCVm1ZV0d6SkNnTS9BUm1tZ3dqNHRkNUd6QVFt?=
 =?utf-8?B?RmVOeFVGem5YMGF3QmNqZzVSaEpCREpQd3dBRzd3akhzWWNML1IwNlB3OTJ5?=
 =?utf-8?B?QnpKa2ZEN09FZ0duSW4wR0V1NTdCYWtCL2szdmc0T0dVSEpVZnJSNkltTEhF?=
 =?utf-8?B?TTRnWjVqUHQvLzd4SzNFTTVaSmt2bGpNVDlPSi9PNnlVcVdWTlM3cnhROFVL?=
 =?utf-8?B?VzNVN3NrNXcyMTF2SnZyLzZCWk9HdXkyRENydUoxN1Z1YTdDWGZBQWhJYjI5?=
 =?utf-8?B?MEpYbVNvWEdoZVJBMmhzZi9JRXgremFrSGRXbEdqNUZUTVo2YitEOFFTNFVT?=
 =?utf-8?Q?rAn9rt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm80VnEveVJjVDZjNE11a09MUk5YcThuUG9YOVdQUjdja0FyUGFseFVSdkly?=
 =?utf-8?B?RFJpcFZUVm51UkFLb1pNTTVFMG0zZ0M4VkV1VEhTZ3UxN1pKZlpQUDkzZ0xx?=
 =?utf-8?B?L1NTOTcvWVRWWlRWb0VTSEhKUE4vM1ZndlJ1VFQwbWJMLzR3NTFOQWxoeUVC?=
 =?utf-8?B?SHlZV3czQnM5NWNpZ3RDSG1PTE9Vd2NEVVZjeHVlbTl4cTB3dGRXWllIMGRr?=
 =?utf-8?B?bXlxWitsT0E5c2l0VTdUdjNOa242c3ZaNWVZZ3FrSjBGaHNEL2dVYytKMDRy?=
 =?utf-8?B?aWhpSXArcnMxWGtaU3k3ay84UyswZ0xON2FNMlVUaWhvM0ExNHZvTUFINFVQ?=
 =?utf-8?B?b2dzQ09sWTVROGVpQzlsVTRpYkNqd21wRXYwN0N0VHhUOC9VZEI3SVFORTNU?=
 =?utf-8?B?TG1MMzJTamlWdStSRVpFUWlJR2xVNldDem5iQWxCV1RyWUZqZlhWWG1hSWpX?=
 =?utf-8?B?UzhYZlpCRm9mZGJUSWFtbmU4bCtCQzN3QkN6bHJmQkhOZ0g3RXQzaTkzOExG?=
 =?utf-8?B?cTBORXlyR2Qwb2szMnAwSmgzejZnbk1jbU5Uc0RtUlZ5UmhNTE1UVGY1T2Nj?=
 =?utf-8?B?anhXT0t4SjBwV3l4ekdrSFdKbFl6S1h6eC9XN2RjVHkzWURQQWVJS2phcCta?=
 =?utf-8?B?eGxhN1l5TWorVkNNSGEzdUQ4QnBJck5GYXVndWMxZkhWNWNBQzQvSm53c2Fr?=
 =?utf-8?B?UGlBS3lzdUdZWGxHSEhXYjNsY0pzcnNTUDViODN3ZEJiTDhmRmpXdHRnZHRZ?=
 =?utf-8?B?Q3lwbW9XZC83cnZjK1NVZklFOVRnUm9KeTByTTMvay9OV21IUndFWEpHK09i?=
 =?utf-8?B?ZDR4clpoRGErTlIyazdoVmE3MHRoeVZnVUZlNFlNb250eWZqYkNTdEdXL2gx?=
 =?utf-8?B?clVsZUtlM1dlVzZ3eEVOZzBhNnBXcjZTSElJRVdYWk9valV3emhFeXEzdUZQ?=
 =?utf-8?B?eHJRRWZhNDhha3hUMm0zbVExaC9QM2JicElmS0FvWEdZSzNaMmlmdWxPZGR5?=
 =?utf-8?B?dVFCcnp3bnNKVW1nNWgwbDdaMEloTEpldHMxaVBkc3pTWS9GTHE1Si9RZmRG?=
 =?utf-8?B?WjcvSWdTREZCczc0cVlsY0xacXRIZlQ1dk90MVhTT2VXV2ZlM3JYbFlFSlZj?=
 =?utf-8?B?RmdpdDhVU3JDNWtEeDJYK2lLWTA3djYxOEFaYk9Ub0k5RWxmcy9nbjI5dVh3?=
 =?utf-8?B?L3FaK1ZheldxTzc5K3VsakNhV2FqRHVSaGJ0dVVwM2FVOXphazFVZjAxbHpE?=
 =?utf-8?B?UUlBN2RvY050bGlVeUtvNjZucUpBMittVjU4ZllqaGp1SVRDRVFTZTBIRG53?=
 =?utf-8?B?aEh4cm9JWWhxZjN6dHdmMVZwdVp0MkFFcmNnd2U5UWh5M0Z5aERkQzNheWVa?=
 =?utf-8?B?K2NsdFY3bm1RU3pPbnJnaXhsRnBSVEVkQ0hDRUg4bVhOZXBGQUg5dC9WRjA0?=
 =?utf-8?B?UWFxRUpCdFlmRDN4WnpwUm9OaE9TTE5PV3R0YnFzZDRHTTRRU0tMK3VQZU41?=
 =?utf-8?B?THFWSHY2ZlNjRlI2VGYxOFdxZzhrT09DZVJ2Z05PcTdsazI3Q3ZHSVI1REEr?=
 =?utf-8?B?QkZTaXcxeEFKMFRmWURlWnFTNmo4TURCYjduN3MzMUpEMDBudDdaVGgvY1RJ?=
 =?utf-8?B?dHZwS0tnMUpzdk9UWEhtS29xRmhLd0NiWUVqSlJ4WkRPbjRqMU01QlBkaW5B?=
 =?utf-8?B?VU9ycmV1VFRXMXY4TFVyU0c1OUJ0ZHNpS2xtc2NtTWVNTHJwbERoM1E0VGVF?=
 =?utf-8?B?Y3pYTWREc2N2M2FOd0hHZm9HVmQ4bFUwVStHSWtoMFIwTzc4NXZKZXUwZy80?=
 =?utf-8?B?RkV3RWlhY2ZEOUk5WEticnl0UEY4aUVWcll2V2U3SWhJeGU4K0dzb3NsNklo?=
 =?utf-8?B?Z3pjSkhMSW54N3J6QUhlTHJveGpzem92dWJPR1I1dnZnT0NzSlY3bXpwWkJL?=
 =?utf-8?B?MVFCQ2xtalpsMDAzYkpDVG1pd1BzSjZNWFNvM1p5MjBkT0NHeTBYM2YrQmtM?=
 =?utf-8?B?Qm82WGg0d0gxdGdkamJWVEF3T1lmbDNkOGUrKytra2FpdDdITTIzNUtKRXlM?=
 =?utf-8?B?RHJTd2FEUE9YNk5iRUFZNWJVdk5uaVF5aEVMK0dhZ0hLQjU5MENYU2t4NzBH?=
 =?utf-8?Q?RUUE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b0aca-b383-4727-08c8-08dd7b82a2e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:56.6511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJipJgVEm2ecVsIq0Bp6MIfgvdTX/zMzhI0Pvr5jPZswVI4Lo8nSPbdsMb8tl6pNBhR4+oimsdrPGOyYOYYvZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v15 to v16
- fix rebase conflict

Change from v14 to v15
- check CONFIG_GENERIC_MSI

Fix below build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082204.6PRR3cfG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:53:15: error: implicit declaration of function 'platform_device_msi_init_and_alloc_irqs' [-Werror=implicit-function-declaration]
      53 |         ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082242.pOq1hB1d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:49:14: error: implicit declaration of function 'irq_domain_is_msi_immutable'; did you mean 'irq_domain_is_msi_device'? [-Werror=implicit-function-declaration]
      49 |         if (!irq_domain_is_msi_immutable(dom)) {

Change from v13 to v14
- basic roll back to v9
- use device:id as msi-map input, its will handle it
- use existed platform_device_msi_init_and_alloc_irqs()
- pass down epf->dev point, because epf->dev of-node will be the same as
epc's parent.

Change from v12 to v13
- Use DOMAIN_BUS_DEVICE_PCI_EP_MSI

Change from v10 to v12
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |  1 +
 drivers/pci/endpoint/pci-ep-msi.c | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 28 +++++++++++++
 include/linux/pci-epf.h           | 16 ++++++++
 4 files changed, 127 insertions(+)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..c502ea7ef367c 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
+obj-$(CONFIG_GENERIC_MSI_IRQ)		+= pci-ep-msi.o
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..549b55b864d0e
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2025 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = PCI_EPF_DEVID(epf->func_no, epf->vfunc_no);
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	platform_device_msi_free_irqs_all(&epf->dev);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..6dfbe9353f0d8
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+struct pci_epf;
+
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+#else
+static inline int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums)
+{
+	return -EINVAL;
+}
+
+static inline void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ */
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 1040d83740f9a..dcc6e2a2c6b3c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


