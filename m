Return-Path: <linux-kselftest+bounces-30133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7651A7C37C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D213BC72A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF49621C9EA;
	Fri,  4 Apr 2025 19:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hfueyeLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A220917A318;
	Fri,  4 Apr 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793330; cv=fail; b=O7KLVhSUen8s6Fb2f/LoqlsIgS9wsPMQqcLHadlKF24kcYpMPNwl2xK/I6nAfZDjkWPqDAEhGsoIDqCI9dLNTwmeLU1EAkj7kqmdrZePinKUbHZxdyR/eVfyDDCSfuLyMovuDrApMrPSQZR4u+IUhBeE7vl8xurPJjQBuEvw/Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793330; c=relaxed/simple;
	bh=jis4uAlk2Y8+00RUPuARjfibBzjm61NUigLnBik7ARw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ak7m7+eetMX9ve2j3CEAz89mW+D11sanJhNyoxFoqbtagk90Kr3OruH3wwj9gFxg3j84ElEoX1O884VNWLWG21hTxc5YCGdSbWXYONUNgeMWLVWjo4KpVJAqmo2IE3VDivc+zauFJFSSOkbN26LmwhBp4FklbBWgyiE5BHiB6eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hfueyeLo; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlSnfbD2Owtbow1LlCa9udVaZ6JdWRUVeDw3nZypsMyz+j7YpBI465CsE0dbtEFk/ZMJ7xkqctoYbhodOWfnvM7RqJbxGbPpbFgVYNoZuRzWZASA0VUVOSEH35OnAMve1ruPusPy5EZOspJ9c2xfSvboOgjbLsvnQQzRNtPs73fxS2njT6VYUWpPEMOJ8pmYJIC/au75xc2WBrG2WvmHsLfvSofw9hs1ew7RHV8Iv8ruYTgw35S/creKazEIGJt4Fq74EwWWrNABxTaASIZQSZEeEIJBb6lwOCQ+IOkTiALaLpuzuYNCgyyrAQotDdY7nbWXhnDCyiPN/stCA9WFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGHcDy0qLXRPv9bDtIJ2M7IEz1TWHDvcXEwtams7Bbg=;
 b=gqvzD3MR/BycDxMcr6+tA7ORBxU6E+uVeX3fHaMYjp13BWeqUT3A3vFgBFDOY13Z74LO4eFLXRLJc9c4Qzw4zapuc1W/2Z9uQt/jbf58Bo6oZqyrk7TZiq0M2/PZlbppgFPzLPXGowLnPW3GMB8XMdIPXZlE4pow0626BAVC31a3mGykyo2bpnS9czAmxKtdeaVmhxEomHcEmaSR22GDLrbS5otvBVU1dXkitOdr8sJAdtVQgtms7wL284lQlWVN0s4BnnFHGEXGYUBZf82zCzaiYzqIbjWsEaokp67mkGETL1E35HIgOWzyWe+7GpiA52QFIfdT78I64phEeDAyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGHcDy0qLXRPv9bDtIJ2M7IEz1TWHDvcXEwtams7Bbg=;
 b=hfueyeLoZBKmyGTUCQO2kVpdhJxh6JRujb+AG/pf44BhTj0YmLYQdw5yY/jyc80L0/5ee6xsEseOgTmcwNE/atavGOtwC3G8OTMksWq3GLYnfQCmrysUuk/s21OTmwhCGaFsZ6Se43FxYZWgYKSrH7dHwoQTn9kqVyNu4URNTi6bOPgJex6hnyHLWLOt0XNcJAJns1fuvCG5kXIhA6muU7dkhWaxtqNSqupl/57Bjum9g3m+9WGfDaU0+ygtoYvayYDht/Qi8qvzNwZg+QgdKQAC8QLsMI2qhuLVjK16XQzHm2cAAaqxp6ihd9TxeCxIrn8ktvvZIrpLOS4riW7SMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:06 -0400
Subject: [PATCH v16 05/15] irqchip/gic-v3-its: Add support for device tree
 msi-map and msi-mask
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-5-d4919d68c0d0@nxp.com>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
In-Reply-To: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=jis4uAlk2Y8+00RUPuARjfibBzjm61NUigLnBik7ARw=;
 b=NIrp1x98RNU/VYfQH3F+6l6UhgVDtBKI+BJrKl2sxCA+z0mTsJy3fupe5ZFv8HWumNiZC8M6D
 oQZ7Hxe8SBTD+Y7TrRGCbfpPTsgrL+8odIJbbQIia40ydA1YnD2XGJB
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: c51245c6-d72a-4213-f970-08dd73ab3129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHFFUG03K2RRY1YwdUE1Yll4SERZQnlqemwvYkhPUHIwbE95YlAwNUJnd3E2?=
 =?utf-8?B?NlBjc0IyZE1tMWp5RVl2SFl5UWpsUTJDL1l1UytTQytEWmw3RmxRMkJqN3pi?=
 =?utf-8?B?UlJPV09IRmdJQnR0QVlwcGd1Rm9GcHk3YWUxcDE0bmtKRHNHSE5BQnlleEll?=
 =?utf-8?B?c213QTRxK3huYkdrQnJ2NkR2ZVUyVHEvbnVTOTZJc2MvOUF4VkVvVkNFNERn?=
 =?utf-8?B?V01qaFVMNWFvQWM5clJ2K0l1MlRUS1dZOFRJTmJkS1pGTmFvampkenZoN3Np?=
 =?utf-8?B?SFJFQ3dOZUxkQ1JGUkRXZXVuUXlxSG5tZUdMRXkzcUhtbW1YZ1NLT2Q2N0Nk?=
 =?utf-8?B?c0hjMGJwdkFvakxxRXRiMlB5TDhIMytFSU0wOW9MZ1o3dThaY0JZNm9xTlBJ?=
 =?utf-8?B?WFlpckRKeTJTZEpFcUJPRVBUOUR5RjZJYU42QTRJME9pMGQzdEd4dGExc1Bm?=
 =?utf-8?B?ekZMaThvZGtOaHppN0MxNCswYVZ3b2c4ZmtoYUF0OHFnajljYWNpZU9RcWxR?=
 =?utf-8?B?Ni9uZElFMlVoWW5pM2ZQc0RKWE1oRG9FYjBXL2N4T0VnbjA2czBCZTFYU3dS?=
 =?utf-8?B?dkdyRVVta0Q1c3BEYjk3SWw3dW1idTlTTHgyaWk0S3h5Q0hRVDRGckU1WDlu?=
 =?utf-8?B?WldjQ2prOWJ1VzUxTTN0dkozSWl3U0hOSWtLYVNCV0ZXQklFdS8yNEY3Wk93?=
 =?utf-8?B?RHIwbnB6NXlVbTkybkZWbndoV21NR1dLZG4zSS9QNWhQZ0s5UTE2ckNuQnZ3?=
 =?utf-8?B?TE54elVPMDB3TWUxM3ZqS2llbnJtSS9hOGFjNjJrbktJZDNGT0s5MksrZ1ZK?=
 =?utf-8?B?OG9rWFFaRGxOTWJMUU9MUWZrblJ5VVVSN2YyVm1WS3BYemRVcmE4VWZ1Yi9M?=
 =?utf-8?B?ZzdLTThDYy9aY2sxS3loUWhvT1VGSzkxSkNIY0MwdWlDdGxxQTJja1ROVU9N?=
 =?utf-8?B?bmtwTHRGZVkreXFjbCtQTGRTc0dTNTdhbWlwNUhxZElhaXJicXF5cm45N0lR?=
 =?utf-8?B?RUQ3NUlKdTNKcWhaS1hEV1pLSTVIZ2VndE0vSktPTU5CdUFqRFNnNEVIdS9O?=
 =?utf-8?B?RGRZNXp5ZVNQM2JrU2xldkRoamhySWlnYnUwOVU0QUVtTEtNZUJoZ2VWc1o0?=
 =?utf-8?B?N2hyeTd5bXhxdDR2YWJCeEt4Q3E3VjBQa012SmhkUHpLRUkrbW1iQUN3SFU4?=
 =?utf-8?B?eFdycEZpdWNXdWxPbXlILzYzZmJOKzFWakRuaWkvTVpodzUrNkRHV2F1Y0NC?=
 =?utf-8?B?Nk9aSHh5eTJZcHgrc0lCdFpmY2k0Qi92Z1pFa2ljaTcvVHpXaWxWcFlzcVl4?=
 =?utf-8?B?N2lnWDlhNkNSZWROZG5IZGkwYW41bzVCTlAzWmRjQ1BoeUk2ZTkyVUkvVWl0?=
 =?utf-8?B?N2xOMVdURm9SL0hTaTFBUWk1VVlBd004SURxK0p3TVI0NEtxdTNXQVVRT1pu?=
 =?utf-8?B?SDJqVC8yeWtac1gyKzNZZ21wKzh4NldyMzBTUFhDT3E5dFQxQ3RtWExveFBI?=
 =?utf-8?B?ZGUzaHJ1aWhaMEJJL2ZkaEhYVDU5UDd6RjNBTGlqbGNpOUlIOFd1Uno2S2Fa?=
 =?utf-8?B?dFAzVHpvVGZQTUd1Zk8wbmp4bnZNbUhkWFNubHVKU2xOZzdvaDBjNVJwdUVM?=
 =?utf-8?B?UWNadm9MVmlaYm9JU01wcjNqbVJpNDN1YnlUZWQ4RFMzc2VWWHkwdHNleGw4?=
 =?utf-8?B?TEpPR05ta0ZiT0tZZlB6WW9DaytxTTFHbE81dCtMTHlJaVIvRzZlYW5FdFVP?=
 =?utf-8?B?ejhON1phMncrOW8ydzUrMUw5RFFsaTkvdU82d2hkdXNVaVQ2SVE2QVdaYmNH?=
 =?utf-8?B?cFIvU1JCM05zcG1aVVptZGZ0eGdlTmhUQnZhODU5Zi92ZXNCWnNFdHd3Rkls?=
 =?utf-8?B?VlFoaWhTZzNVMWxVdXJjR0VlRXlXNmhjR0FzcnBjVEpXVWhidjNJaTAxMEZ0?=
 =?utf-8?B?RWkxY2M3dW4vL2dJQkpsV01EUE12TFoxTTBYZXJKM1FkWnhHZzcrNEU0a2xs?=
 =?utf-8?B?NjBxVGxoa3pnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUNBYlE2dWFQcGZjdks4SnpaN0NsOFFneHVEbWFZSXA4QXY2cGsvUXNqVmVp?=
 =?utf-8?B?TmlYaHhuZ21STzFmcXZLVjVhQytEZENicktUTnhEcUdhYTA2R2p3UittTW41?=
 =?utf-8?B?azZPem9UblBiaDhRT1BRbDFsRHNRRGlGbW82dkYzOG5QNk02MXdQYlBhRi9j?=
 =?utf-8?B?ak4zZmNVYUJaT0VwbHp3cUJ1S3pOenFpWThqWWJGRUwrNWpMekhjMUZKOFI1?=
 =?utf-8?B?U3NBY1N4MU5aNjAwcksyMGJKdVZTVXVLdlIvcjFsejhQNUpTaTFjMWZMYkNI?=
 =?utf-8?B?c1RSK011YXJSZWVRTGhqVnNGM3E0NXJ6Rmp3UDBUMzAyQkhSdy9OT3VpdnB1?=
 =?utf-8?B?a0xMVW1jODFxalJEVC9SZmd3NUJWSjhXRnNVTkp6S2hZc1p2QmdEbXNaV3M4?=
 =?utf-8?B?Qlo1MWw3Q3FtUlpwWWVkWkQ0dDRlMFhrOG5reFZDWm5FNnRibTYxV1JHTFhq?=
 =?utf-8?B?TC84ckpneVRhSmVOQnhKMnIvdXNKaWZNWGpZSGlpRjVnaXBHZnM3OVRQbHU1?=
 =?utf-8?B?S0dzejNoTjdxc2VIMWh0cmhrUkNTdTRmQktEdlRNQVluRklVZUsxQjIyNHJx?=
 =?utf-8?B?anNiYXpUM1czQk83RERsdDB1aW9SNDFhVks2WmFKdkljYWNuN1MxSnh3aEdq?=
 =?utf-8?B?R090bm9HY25PVzJJSzlrYmdmb0xvV2pwRGM4VkpITEdjcG9pY1d5TnFoNmRO?=
 =?utf-8?B?bEcrbklUSVh1aEg1ZkxTN0hzYjR6NXJ2NDlVbFJJaC9wRXJlMkw4elE1OFVK?=
 =?utf-8?B?MW84dThaRE1hZGc0L2JMS0R2MWlBbnVqRTBiYWFlU0pxOW1EUnZVbnFhQVVS?=
 =?utf-8?B?OXEwajAvY01UUTgrZ1JjQUJ0ZTcwem9idnJsZXgvY1Z3c0FCbXpxbjdEc2ds?=
 =?utf-8?B?ZzhQdXNBSHc1MkordGFrZWtmc21JSzdpemVubDA5OUxXYzVpUFZlb2ozekRX?=
 =?utf-8?B?RHRNOXFpMnJRb09tK3FVQXlpZDZ0SVlXVGVraHNHTktvUFZTL1EzYzNoWXAv?=
 =?utf-8?B?RC9wQTdYdER1MjlHU28zcjZPWE1XWnBlME1aVnVRaVlMbkg4cks3cjhZbVZR?=
 =?utf-8?B?em1HcG5YUm5maDlVd094RENxakQwVUE1VUY3YjVIUi9PdGxCY2ZjbW9ZVlhh?=
 =?utf-8?B?MzJJNEpCRWNUb01JTjNOaVBTUUZkL2JLRU9EZEJoZHJuenhKMnprTEJINnJv?=
 =?utf-8?B?bGlvSWlWRGJEUWZ5UVEvc2ZIOFZEdEk0YnAxckwyVFBRUkt2RktCbUl4T04v?=
 =?utf-8?B?ZWNBRFhSd1ZpS1NaRFdHTnJ2V2JMUEVCTk9LTGxMQW1rS0xJSzlCWGVRSWh6?=
 =?utf-8?B?S1B0WllFUVV4UkJxSTh3VUp5T0JiT3FNSkdxV0pHWElzVEVwSWo1c1Zzd3k2?=
 =?utf-8?B?emx4UERXZWpLbXNnSkYzRTZQdDNhQ1Q4ak9LVmR3R3AyeFFpL1FqZFF6Z0tI?=
 =?utf-8?B?bTEwbDJUVjBEOTEvOSsrS3NUMFZ5bDRKZnhacSs1ZGxZUEFqeG5yaHBFRGc4?=
 =?utf-8?B?NExJWERWOTZweHZnUWJ6L3NDbklLcTRnY0N5c0pBemtpK3R6SC9WQlFsNlRX?=
 =?utf-8?B?dUJ6RTJvenZCdmNiRmFpVlV2dy8vNTlzeFRZMVdvekpPY2szbk1hOExnOUVt?=
 =?utf-8?B?bTN5OEJYZWJOYTJjTUFCdGlpbStSaVhVWFE4VGlvTnJkVTBSaDFYbHJ0WEUy?=
 =?utf-8?B?Zm5QNjcwSEV4bXltZlhRZGhzV1Rmc1YvWEE4QWVZUUNBb3duVFhVQ1k3Qyth?=
 =?utf-8?B?MDRrWVQ2K3hUc21yaW1telAwR0x1eEpxYlRJOFFBeTdaSjNFTW5TSGxibFBP?=
 =?utf-8?B?KzZ0ZUtiNVI1WTFPbWFyVEpWU0ZlRXEwRjlSRXpNZTY2RlZHQk5ydnZCWTJl?=
 =?utf-8?B?bERXUUVrN1FSWDhERXhBN0JpY3BxMDVMamJ2Z2tLY3g5blZaVTBoVDhrVEh0?=
 =?utf-8?B?RG1sRGl3OUovRnQvNUJuMnorYlh5Z1JrTGMvVUExUStJL2o3YzU2Ui8vNThE?=
 =?utf-8?B?aWViWVJURWsydzhiN1NPOWgwVmlsYUlLUEQwQVVTQ1J6dkEyRHVJQ1RGclE0?=
 =?utf-8?B?UnV5S1VXNituNlNtZUNuOWtRckQ2eDllaVdnSmRUNm11R2ZTaWtyYkhiR3FT?=
 =?utf-8?Q?k7WI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51245c6-d72a-4213-f970-08dd73ab3129
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:05.8855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fuSFpjWfPJ4M+10/5xEwYolW4AQFZ+cZ26aEl9kiiMgtSjSwenTcxvEofEj6g6pEOGUmHzFjg9t0+MJH4MGxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Some platform devices create child devices dynamically and require the
parent device's msi-map to map device IDs to actual sideband information.

A typical use case is using ITS as a PCIe Endpoint Controller(EPC)'s
doorbell function, where PCI hosts send TLP memory writes to the EP
controller. The EP controller converts these writes to AXI transactions
and appends platform-specific sideband information.

EPC's DTS will provide such information by msi-map and msi-mask. A
simplified dts as

pcie-ep@10000000 {
	...
	msi-map = <0 &its 0xc 8>;
                          ^^^ 0xc is implement defined sideband information,
			      which append to AXI write transaction.
	           ^ 0 is function index.

	msi-mask = <0x7>
}

Check msi-map if msi-parent missed to keep compatility with existed system.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v15 to v16
- remove ascii figures in commit message

change from v14 to v15
- none

change from v13 to v14
new patch
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index bdb04c8081480..68f9ba4085ce5 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -118,6 +118,14 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
 		index++;
 	} while (!ret);
 
+	if (ret) {
+		struct device_node *np = NULL;
+
+		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
+		if (np)
+			of_node_put(np);
+	}
+
 	return ret;
 }
 

-- 
2.34.1


