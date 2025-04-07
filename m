Return-Path: <linux-kselftest+bounces-30304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73708A7EE04
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AB0F1895917
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0847229B0F;
	Mon,  7 Apr 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qddqj0p4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4622221703;
	Mon,  7 Apr 2025 19:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055479; cv=fail; b=RQZRKN8yBqb76JLuoRMcVfP9eKdGyWntAFkf/puFVcIYjip0fvKGPULwIJBbmuYRdW2xEPEuNKuQk1QwS/tN2PtSoHnyCK4lUxkJ6/p81DeEduKbgRHmk2Lm0IQ/z37kXc//D+dP3/Oa/UkGOtY9SzwsoP93rrDhnZ4FmfsJLn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055479; c=relaxed/simple;
	bh=cwQwazNGt5TAURYXzEY8PQG1xR+n8Mcap5euP4EFG4Q=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=CpJkRgFD8AJRSyG+46kTFZSUE87ak7wW2nhVVXnt5Y/1hRNE+ACNslHKG4qIuA9hd1m7E0z64v7lYVovMjOiNscfR1Ps8aR/bRY2y766IMCTUknqqSy3isOfoRa4nOidtrURcrt7+mTBApmXqSb2njzUEbgFLxg2+gePuqzXLmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qddqj0p4; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vN085f8X/Y9t4l4XZl40pyrdg1o+X499UQkV+a60tKann0GNwN3qmgmYY8Aqi5KPxW+Xim+Xf2b3mUsobk9psU/RCK3K1oAP9KEA8WGQd+O05I8qnnjnQB7fAOKcGXOMKvU/pb8p4/+CHeXct5YTXU46oPHqj0eWxWhcon7OZ0pSJZAgWR3WZtA3VGaIOZKgYnBKVsYNNddiuZWt6Jn68BvHMSnjnUY+gPMLYGX0DFTzVpo09IBJGZLPIyX6MP26AfDXlW47gbKXf+UwSkUZy/Oim/20dwvJYE5qolJ9cMBxzH9TClTr6FmSx9nFt+lsSocEWxw62nmvAGOhYYogBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMOS/SW/9rBYs1OSR7NMZ+/rhzaPcgwqfagWFIa9oA0=;
 b=Vb6Mha4F0rkAtRQtRonCOQVCgDUwVCJeGhS/B+SLGshT8OfH1S5PxuCyD2Q/H04Ddksc5o2OWTgfCh4lJMwldlt3hvFO9IFqonlLsPzD6FcPrTESR5rkD/nLbjfEJF0+sd2L+YfK4Cv5Sq3NoaXmjqPirruoOP1MEr4EKQ/Lku785P2b8aI3+MRJQRKqnUXIQ9GRYMqANnxxnTyS7Q/hDawr9vo47E+DDapfTe0xnW0d4GSlWavxIXmfSYnY+HaBtVcTH+ouuA04hlMgdFPpXGdfp9lBokoPKlpXVewHugOHDtYjjPlzYdsG9Aeo2h1DfTNyJyYHMGm1oG133PkuQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMOS/SW/9rBYs1OSR7NMZ+/rhzaPcgwqfagWFIa9oA0=;
 b=Qddqj0p4qKLumgz63lZ4YDuBAu5CYMC/juZeYZBzBxzAhWbmtmvPgpssqLSnCHI0NT+AgEYKrF0Cm+kVATSBiMDz6WWgbFwzQnpBu0UCEzkdR1tODkGRJB8k00j+Qb3aeckdvjcojQk/3VuK/BHIwi6YObuo1onTgP1BbftYAl8LU1PS4jt8VwlS20PETF9ukg5dHQwEoQgldw0g25vbHFFv+cSwP9PCz249d2BpulH3dFJxPOzVYBGq18Kz5T96ZrAhIas319gTqdjG+0Pc39T3QcYY+EA+1cb3vB3YyK8IfQw7jrcwE3phv3gKlAzcOHH9zKaF8rRbr2Yl34St7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v17 00/15] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Mon, 07 Apr 2025 15:50:50 -0400
Message-Id: <20250407-ep-msi-v17-0-633ab45a31d0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJss9GcC/13SSW7DMAwF0KsEXlcFSc1d9R5FFxobLzLALowUQ
 e5eKUAs2UsJegRF/vswp2lM8/BxuA9TWsZ5vJzLAfXbYQhHd/5JbIzlYiAggYDA0pWd5pEZL4L
 znHv0aSiPr1PK4+1Z6eu7nI/j/HuZ/p6FF15vXyXkq8TCGbCQYjDWoQroPs+363u4nIZaYBEd4
 rgiUZBGHR1Faz2ZLZINIZgVyYIcCisxQATQW6Q6hLQiVZCQ2WqixAPt2tM9EivSBUXhgnYu+0h
 hi0yP1IpMQSpjVibniN5vkW2IgK/I1j8piD7wjDLGLULoVeuvbBCY0YFrU2RUe4Y9s41hHbvgI
 jvDrfZ7Rh3DtqwyTWCcRyE5ZScJdoz3rK0LazKUUInQUgwkdmyNhgQC3VjNhlUaPXKVye+ygbJ
 jfZM1HT64ELAgdHbHVGOin6R6rtqijcrUWDX2eDz+AYnuzzZaAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055467; l=12269;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=cwQwazNGt5TAURYXzEY8PQG1xR+n8Mcap5euP4EFG4Q=;
 b=FVDv0mFu0riL7i0ttQr8RopM9jkuabNA2lsougCWYrhnq7vB8TFAn8LNLI2Fgeu9IVWdvNFSW
 1lUj1w27FJ6DPuT5xnGZUKqWcTUtblRTBIkDyQdHfVULP5oBKh0YoXs
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: dd9e6115-31a5-4f72-4eec-08dd760d8d43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWthaUxwUjA4Z1Q4bmR1cXA4SmlZZ3pDM0JoazVSb09YZkhWeExCelFpVTJj?=
 =?utf-8?B?SUNsS2lISkdPdk9iOE1yVk42eDZnekFhMmt3TDdHOGhZaHFFVnhaNUhacnNW?=
 =?utf-8?B?djFXeE1ycVFBRy9vWTd0LzFVN1BZOGNIVGpLZDR3QXdsTm1hU2ZKM0dYRzBX?=
 =?utf-8?B?U3Jubm5FR2ZBcTc2RVVneDlXcENGSzJCN0JPYmNoZVNwa28vOXh4Uis1eG5L?=
 =?utf-8?B?NWErYnlKN3Jqd3NNK081UTBXTlJabFAwUHFJelZTTnU4ZzRvQy93M3Zjb2RG?=
 =?utf-8?B?OExvMlowRHpNNzZqYzZQSGZSLzAvekttWlR4WTZJOFpUTXFuQ2VnWnZGTS90?=
 =?utf-8?B?d25OYlo4cFZNY3RQZS9qTDRuQ0V5OERMeWprY1FnL1EvTUJoQjVmVktmdUNa?=
 =?utf-8?B?MjV6L2VabitLdGFuZWV2V0kvZmNVb00rcXEwZ3Q2elZyRUJHeVhRNDR4czVu?=
 =?utf-8?B?NzJVb3NpRFgvL1VJY2x6SjhqbVFoaFRaUEtpUjFON3pHRUVQc0VFenowWDh0?=
 =?utf-8?B?clI5SlZaL2syS3FYT1kvczNValVlTW9FclZvZkE3TkxuV2ZXcm5vZnpBdmJE?=
 =?utf-8?B?aFIySGhrNnkwOVBjd3hyQmM5bXNKMkZoZWU4Rkh4RTlpa0NvdVBtclhXQ2Ja?=
 =?utf-8?B?anREcU05NmlsN1NJMVVETWFUMjBTS24rU1FPT3hTdXJPMzBYRkxGVk55RzR2?=
 =?utf-8?B?d1NwVG9meHlaeTdmZ0lvMWwxTW5sODRYZko4eGJvUlIwQlNteno0S0o4cnNt?=
 =?utf-8?B?YXloemk2TVhQandVdnBSbDRoTEhPM0hZY3phVWlYTEtjZFlMRWNEWXZuSi9q?=
 =?utf-8?B?REJ2WTVEYjdQSjE3dklBVzNOUXYzUWx0TE9FdlloSmRjenZZbGVrWThvUUJE?=
 =?utf-8?B?dkFoNkZnL1lhVFVmazdUUStGZ1FQbGk3ZE16VXZyRGFqVkRoYm51aXhzVVAy?=
 =?utf-8?B?aUZudFJYR0hRM0ZGbXZZTnUwZnBwamI5ek9LRVBBTDcyTHU2Rjh6RlQwZ3hq?=
 =?utf-8?B?Q3NFUHV2TUc5TGdPVllGSk1YMjF1OFlBZ2hOaWhid2VVTjRSL2QyL1NQanZ4?=
 =?utf-8?B?YjMvaHI1ZzFIdUdnV2txdkxPRzVZeU9mV3g4RjE3SVNuQzRPQkZmdStodU5B?=
 =?utf-8?B?U0V0T0ZINUd6UDlWWGVORE0wUkZvZjhLNmFmYkk4US9oalRhVEllQjY2Y3Er?=
 =?utf-8?B?YXFxeTdUM3FXaWJpaUovbEdJUVVmVHh1MnlJZ1hlK3Ixd2FGOXk3NFh0THdm?=
 =?utf-8?B?S3FWWmJQTHNDWFZXdGVPdyszd21aRUw3TG1uR3pmYzAxSGFRN0lxektYdmxO?=
 =?utf-8?B?aHl1YWFTbkJzcmVSd01jRHdnSkxrNTZhcGxLVUlmKzFaYm40elByZ0JtVy9D?=
 =?utf-8?B?cHAxc1lSalA2V3N4V0FJMElEeXhDd3p5VHVsUkpUUWRMVzRnbGJrSmJZeWdr?=
 =?utf-8?B?NysrVmtsL1B2Y2pocjczdGtpSTV3cE5XNU95T1ByejVpQVIwaVhmV2VFRXIr?=
 =?utf-8?B?U3NXemJFM0ZRR0JwSUludmVObWloakZKYmxweDRTbGhtODRZZzlnRzc1UVJW?=
 =?utf-8?B?dThnSC9UOVV1Y215aVJSZkpCOEZMWGNHRzNDUmlHT3FUVFMwNUNobWhVVFpP?=
 =?utf-8?B?aG1yMUF0OUdVa0lNQXhJSnJaQ2kwcm9FSzEwNGhEU3NPNUgyT3BzRUYwbXVn?=
 =?utf-8?B?R0l0YlBFNDlNaWdyN0FvdEp1YWhBeE5yVkF4RzhwVHI4bWtFYUpTQ1plbVlW?=
 =?utf-8?B?MUJybWJjUzJvZUNIaEFiTnlwVXN5YlJFbU1mVVh2RHkwd1hZUFUrQ1JGWjE0?=
 =?utf-8?B?M0YwdWFWQ1NDRWlkS2ticnV0VlNYeE4vSmRpRVpZeEV1aTVCc3BMcVFKYm1G?=
 =?utf-8?B?VEZDT29TdnoyME9adldvME1PK2JmWW9udEdrRkZnY2N0Z01VVXZjbFVUeGhO?=
 =?utf-8?B?c0IvODBYdnpuaE5reGo3ZlR6azduK0pCa3hQREk3NWIvZTNOSE1OaG5qL1kv?=
 =?utf-8?B?dGFNZ3pJNHlBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0ZXTFlQLzJuU0VDRjJCVzB4dS81T0w3VXU1K2FpTzkxSlk4Y0RTd2RXNTNK?=
 =?utf-8?B?Y0haYndjV25DUXdZYm5HZjZKSlBaWm10VXVFQ3ZHMXpzbzh5enFLU040Y29G?=
 =?utf-8?B?Z2FrMVFFa0FaMm1qU3lLT1ArWVBEbEVROEsrcGpyK2cxcHNuZDhmMmg3Wloz?=
 =?utf-8?B?VFFGby9XcDA2THg3SUZkeUhxNDY5L0Jzci9Sd0pCY05LYVFjSEJELzJyT1lZ?=
 =?utf-8?B?aWUrSFp1NDB4MnpMUmNvTmp3Z3FzZ2hxanVaQXk0ZFBBVHZyWm1qQVpUZVlw?=
 =?utf-8?B?SkRRNERBS1VIbU4rT0ZpUS9zeHBrUHdEekQ3ZmNrRjRERFZ4Q1RwYnAvRmI0?=
 =?utf-8?B?S1BKdFZ3YUhJU2RRZzZQTEo0dmtDem1yZGJxSVhRSnJmOXdweWQvb0c4OE5t?=
 =?utf-8?B?bENGbFhHWFBSU1YzZm5EUjFoSDNUUHRtN2VLMEptQ2xRRi90VTJsbE0ranZk?=
 =?utf-8?B?SklqYUI1MTJWbkV4Nk9qaU90VWxmVDc2Z0tqVnRybVloQ2dEZG5MbmdNbTA4?=
 =?utf-8?B?K2c3YysrOGRnemRPcy9rZWhyT29YMHJrSXNYU0YvQXEzWlhsR1kwb3k3bE5X?=
 =?utf-8?B?aG5oWGwya1pQdWx5Q01VaEtJbytJcllGTTR5ekdUN2NQcmR6ZmxWZEJsZXVl?=
 =?utf-8?B?NUV1cjVzand3TXRsWk9UMk5IazV0TGF0d09OcTA2a2xHQTMxRXJlcDFFcm5m?=
 =?utf-8?B?QkxJeG9KYjVCSTlYRWw1NGNzTCtxUmV1LzhENC8yc2dka3ZCdzdCRW5kNjZG?=
 =?utf-8?B?OVFJTFZhSWc5TitLUXZZZU5uWER4OFd0SE53bFp6b3BwZWZMRVZNbmdkTUJI?=
 =?utf-8?B?S1RXTFZZZXd3OGFGaURFdDlLVDdnR1djbFExcDhybERXbktTZXVHVUlYU1Rs?=
 =?utf-8?B?ams0NjVUMlFFOGo4Mk10bnpNR3ZxTmk5aFRiSGRkcERuNUlMMTdZc0Nzb29B?=
 =?utf-8?B?TjBVSEpINGprb2I0elZtVWhtWnJZeXZ0QWo2UXpRUHJ0YlhKSXdqZEtwbkNK?=
 =?utf-8?B?RTJyRmJWbzVsR08zK09LRkFWdklxTWcyYmREaVFSU2ZpeWs5TXYraVhNaFMv?=
 =?utf-8?B?M2I3TFBoNjlrL1YyR3d2bjBoWmduaEc5Qk9XM1NLKzM0dXNabDNhYWk5N2xN?=
 =?utf-8?B?TTQ1UEZXbGxLWkJrck5oeGVQUkhYVVR4amhQdTRpZEF2MDVTRUNNeUF5alhz?=
 =?utf-8?B?S0NTTXhXRWtPZndsdjJmYkN6eXZDZjhkYnRiaVdmNW1xQ2hNRGRNVTBwN0hs?=
 =?utf-8?B?eTl5SkZjL3lndHFaMEk3ckRoUFd1UXByUWFGK2VjbWRHUFo4VGpnNG04MkhT?=
 =?utf-8?B?aGUrTzBUWjJHQ1QxSDRFWkZCektFbnhOWE1WYUN4cmNRWUtjc0ZaVFd5UW0z?=
 =?utf-8?B?L3pmWkJwNDJaRGZiZTNFcGZidTRzaThpMVY1NEZOVGRlalpWVHp0NllXbTY4?=
 =?utf-8?B?Zm5rdTVtSXVzeGhzTE0xZ3E4YzVxa2JBdlRlQWtJRGpob0lmcC9tV3NBUHFX?=
 =?utf-8?B?R1J0VTZBWTJEdTU3Q1I2VUpERU1LcTUvSks3WmFkTUZVcEMrZ3dqTkYzWGky?=
 =?utf-8?B?Nnh6L0dEOFg2cHdEMEgycnNsMzhNS0swVEoyUUlEazFaOW1udVJybE9KcVJ0?=
 =?utf-8?B?QVVnRVRyVk82Q3JIOGgwS1ZhUFhtV0pTY0ZkRzdwMkNDUkRPWGdlYVYweXJK?=
 =?utf-8?B?aXJiclFhd0NxdldqTDBFSjh1OTVKeTFvVU1sMmZPaUVlbDV2dEhpdmdjdUE1?=
 =?utf-8?B?aG9LVFB2ZFFUbW0vVkM4aGIxYWQ1ZWE3SjZoZm96empXSnhEUHFwaDNZWWRa?=
 =?utf-8?B?VEt5WVZHVzFacG5LZnZrY3RFekY3eDIrSHBmczcvZndkQUNoMTlNNUhZbUN3?=
 =?utf-8?B?azZDY0UyTklRRG5yZFk0M0t1YjE4REM5SnhVZUVUTzJCWjVpbi9mejhUUDEz?=
 =?utf-8?B?WjhZc0lub1FoMkdvVEM0NDhucUtxVytONC9GdmZGZVQwdHNMWlllZDhrMzBv?=
 =?utf-8?B?QU9UdFNNT0VvR1lHRHAxOU5MVXFXU1dwRDJ2amNnenJVaUZQenB2UTEwdTQx?=
 =?utf-8?B?OFdQVmdOMnJCMUFIbG53MWFseDFEMXNSNUoySXA5em1nbGlzdTdEWWJmQWl6?=
 =?utf-8?Q?MsuvU0jHpD1bYOeXYPZtfFSJy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd9e6115-31a5-4f72-4eec-08dd760d8d43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:13.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA9QIL+DatIH17WQhgV+MEgeaErIVSS4hBrmiLwrohiRybrrd0owfcu/+hr4+P2PGQo7RmRJf7Uq256+gRv1AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v17:
- move document part to pci-ep.yaml
- Link to v16: https://lore.kernel.org/r/20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com

Changes in v16:
- remove arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file
because there are better patches, which under review.
- Add document for pcie-ep msi-map usage
- other change to see each patch's change log
About IMMUTABLE (No change for this part, tglx provide feedback)
> - This IMMUTABLE thing serves no purpose, because you don't randomly
>   plug this end-point block on any MSI controller. They come as part
>   of an SoC.

"Yes and no. The problem is that the EP implementation is meant to be a
generic library and while GIC-ITS guarantees immutability of the
address/data pair after setup, there are architectures (x86, loongson,
riscv) where the base MSI controller does not and immutability is only
achieved when interrupt remapping is enabled. The latter can be disabled
at boot-time and then the EP implementation becomes a lottery across
affinity changes.

That was my concern about this library implementation and that's why I
asked for a mechanism to ensure that the underlying irqdomain provides a
immutable address/data pair.

So it does not matter for GIC-ITS, but in the larger picture it matters.

Thanks,

        tglx
"

So it does not matter for GIC-ITS, but in the larger picture it matters.

- Link to v15: https://lore.kernel.org/r/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com

Changes in v15:
- rebase to v6.14-rc1
- fix build issue find by kernel test robot
- Link to v14: https://lore.kernel.org/r/20250207-ep-msi-v14-0-9671b136f2b8@nxp.com

Changes in v14:
Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
a result, the approach has been reverted to the v9 method. However, there
are several improvements:

MSI now supports msi-map in addition to msi-parent.
  - The struct device: id is used as the endpoint function (EPF) device
identity to map to the stream ID (sideband information).
  - The EPC device tree source (DTS) utilizes msi-map to provide such
information.
  - The EPF device's of_node is set to the EPC controller’s node. This
approach is commonly used for multi-function device (MFD) platform child
devices, allowing them to inherit properties from the MFD device’s DTS,
such as reset-cells and gpio-cells. This method is well-suited for the
current case, as the EPF is inherently created/binded to the EPC and
should inherit the EPC’s DTS node properties.

Additionally:

Since the basic IMX95 LUT support has already been merged into the
mainline, a DTS and driver increment patch is added to complete the
solution. The patch is rebased onto the latest linux-next tree and
aligned with the new pcitest framework.

- Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com

Changes in v13:
- Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
- Change request id as  func | vfunc << 3
- Remove IRQ_DOMAIN_MSI_IMMUTABLE

Thomas Gleixner:

I hope capture all your points in review comments. If missed, let me know.

- Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com

Changes in v12:
- Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
irq_domain_msi_is_immuatble().
- split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
- Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (15):
      platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
      irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
      irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
      dt-bindings: PCI: pci-ep: Add support for iommu-map and msi-map
      irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
      PCI: endpoint: Set ID and of_node for function driver
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      selftests: pci_endpoint: Add doorbell test case
      pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
      pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
      arm64: dts: imx95: Add msi-map for pci-ep device

 Documentation/devicetree/bindings/pci/pci-ep.yaml  |  67 ++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  82 ++++++++++++
 drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c                  |  90 +++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  48 +++++++
 include/linux/irqdomain.h                          |   7 +
 include/linux/pci-ep-msi.h                         |  28 ++++
 include/linux/pci-epf.h                            |  21 +++
 include/uapi/linux/pcitest.h                       |   1 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++++
 16 files changed, 543 insertions(+), 9 deletions(-)
---
base-commit: a4949bd40778aa9beac77c89e4c6a1da52875c8b
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


