Return-Path: <linux-kselftest+bounces-26040-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1175CA2CCD5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7BA16D101
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6951ACED9;
	Fri,  7 Feb 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LyayMiQm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFB19EEBF;
	Fri,  7 Feb 2025 19:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957284; cv=fail; b=ouS2y7M+AtY590tnjhliNzY6FPq1Zn+bUoYRikuyZ1b/9p4Ag0e5K+NzM+ZRWOpRxSUYY9B6NNbiuQ56dSK0r7JeLKaRDdrwt8iHSufh9h2y5N4iCzb5uMIKwmjJ3Bl3KoC+mb+wstsYrkOohhUL4vygJnkaP4sncvmqHc8eNoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957284; c=relaxed/simple;
	bh=d2xjjyNTJZsGn1kAFZa3ob7gS3KSYxktodeMrPpodR8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=giIoUUUMtGuNDoi3/zzcBYy5eslPHS0WutBCkJM39uGzAOgKkGj0FqssKd452X9Cu221wsjd97iQBR/rhZuJWSRgtVJ4fGXhZ2vBX9DTkv8ND/vvfNaXfI1H84yzeuRgztbRTgK42MujuLYQOH+il/g7VQI4UdziDF5+D6ogcuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LyayMiQm; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfC3YASZNuv+z5oQh+7JyBT2ZJZ3PtzpPvOuqYYbV8RuswOfy4iaCwywfZWdm1OaDTsFxjGHoYuVa+AagC+tQ7yDR7iaFxRC7HF9934oekvdA9Cgko9BALIOU8mBvZ6sHjE1NH9XHNuTXkGroXZiWzGi9OeHdljIeS1DbfhIzCi3L4cOd2u11GrZ0Ohxve+9nodK0deWJXeJ94viVD/+OFmBf/yWOFHJxj4/ShIDeS3jZMkL2jqGAd45LtoXv6oYTlwA5F3pavC5QHT+BhOmyz/RZmwkkd2Ii5+VhNEfLbfYs65kzkq5zJiK3D0ZOhJ+3A99HFrmEHySAfRanvrYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pMYycU/icqBmMl3n6WN4hCtVJg4Dno0o86n1YcETS8=;
 b=RE63rDB17EiMWtLcI0SoY8Fu86djTCElxncK6nMEe4/mpZwpKKf0jlc4LFYoWcISc1Ck2zICsVs7S7Jtx9iGKfsr8ib2YDZUuVxPWK8rohnpXC5/9F5BebIPiz4oE4qIKaKDT374jVz+xImkdsBXaEaeiruZezoaKBbjUwz2wIS/ZcJmxbZ8DL3YFy/X+cnA/Q7tJ+UA4QziaY+ECqZ/nLmc5RymMbRbeeSWP/rkz4AzH+QnNExPQvR6CfLUX6du1Wqix8Xm55WWQ/OK0dopWQ6Vgez33Ocf3t8jXEokZ4rXwvyrv4ZSJ1BBC7vgpBuVPyHZlJCk4DfFtA6vxgwhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pMYycU/icqBmMl3n6WN4hCtVJg4Dno0o86n1YcETS8=;
 b=LyayMiQmI6yRSsYbMa4vnD15057a7c+UfO9rzyHb7m1AhryzOOEE2stCUD6qM2wBjWPDaolX9RFwXVTx/cLOlDA16xegw2DR5Q4W8BZ9aaB6L+D1O5dXgKz9AeSROrz1j84ttDGuj+xJxuH15czgl2/dkHtgVkBWnU7/CWCTdvTME3CKaJZgnJZiLDh4nLAyQQvmvMqBmuwgueb1yHnOfWFL0vJPrioHebGJBpJA2prsXyutcNfslFb8XGTbakZmwp6PKkPED+PS8z0uXMnCn3qxcXAsWVThqkDuDKuhVC87whcz+gTmX3uIaNFePn2KOzsv+sKp9FXqCN4bgNMVjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:51 -0500
Subject: [PATCH v14 09/15] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-9-9671b136f2b8@nxp.com>
References: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
In-Reply-To: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=8224;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=d2xjjyNTJZsGn1kAFZa3ob7gS3KSYxktodeMrPpodR8=;
 b=yrPDShs4Q95rASE0p3F81wDoU2lzXDLCz1qCSCI93hrT7eAqrYiZWHjatkbOBW3ZgHck9I0OS
 qyR8NgyVnKsBltMATuWcpDx+1hoUQZoYPtJ4W6aHffwaDzg8vjIvzCn
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: f10a6c1c-985b-45c7-5a43-08dd47af6497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0xmRWdTQmZ6M2I3OWI3b1VRczR3TWcyM2VVSGVMdTJ4NW8zQ3BuNzRhNDl1?=
 =?utf-8?B?ekVJV3JJMWcrb2FFQlpvRGtxbXNiV2dEcFd5V2tjWml0WGlPeitKcVpaRHRm?=
 =?utf-8?B?MzhuVXNNK05USG9ZUXJuQ1RSMml4bVRUajFtNHpGa2M0OGxDMVQySlNQT1lt?=
 =?utf-8?B?NlB5QXJDMmVhNENDRWcxdmFXMy9zSlRTUmNyYnFMVUNvUkRIajdudEo2Ynlk?=
 =?utf-8?B?OXpudjZYb3dpSjFPc2h6TzY0ZVZBV05TYmErRlhFUkFta2RWeWovRmZvQ3oy?=
 =?utf-8?B?YVl3THVaMXM3VG54RTlJSUxlVUFlQ2xjL1RqcVVzVlNyR3hlUk1QR1V5eDAr?=
 =?utf-8?B?T2lldEZFdjZsMWkwd24vNUNsS01keDZodHRBTU5XRUNMeUZUUWJodExIUDVa?=
 =?utf-8?B?Z0ttV2xSMGRtbURNNG9EQ1U4OXhKeFU0d05HYU9UQy9rRlQvMXl5VE9SbjZS?=
 =?utf-8?B?Z1FtcDBCS2hOcUVLU3l0VjRHU0ZMalNPUnI2cFdqMU4xOHRSVHlkd2VlQTlX?=
 =?utf-8?B?b0RsWUlrZGQ4RlE1VDUzRGFFWTk1SmpQbnlxVTZTenNIK2RGVzZDVG8vMElt?=
 =?utf-8?B?SndWOHd1OG4rMmNvUUlUYzBXSFBFRTluR1ZWN1dieHNFQ21hS2QwSThNU0p2?=
 =?utf-8?B?c1BINXhOVDBFUnNueHdqSlVES0RidHYvQ0hndjFZUjVPdnF1SnpLYXd1bXkw?=
 =?utf-8?B?RmhldTRPYmRDVFBBZWw4UVdZakloUzF4aW1LNzQ5SitUOUtvaVRoZG9IKzNP?=
 =?utf-8?B?MnRxMGs4QVk0WWJ3UXNXQXZHd2hMNzNTWEQ0ZkI1VUpHdWFkeEVmN1BiQXFm?=
 =?utf-8?B?ZnRQWWFhK2dWajNCWDEyOFFPYjQ4Sk5pS0ZLUVRHU21wcngrUW95N2czSUFT?=
 =?utf-8?B?R3ZjUllwZGt6SE9zOTZxdVRUbklWTXA4eU9iWEtrbWJjWEdkdWJVRXdQL3BK?=
 =?utf-8?B?MnhqSkRvekpNQjFsbTBacll5b2Y3YWMvaTNhNy9UUElEOVBMdFdnTVYxN3N2?=
 =?utf-8?B?TEVsdkc1bUh1ZGUrN1MwVEdtb05oU0hEREIraGliTnJZaEZIeEltaURLMWhR?=
 =?utf-8?B?K3gxa2sxK3FLeDdxQ0NJR0c2bys2bkFzVFpWK1V3STE5NUcycFozdkRQZkNu?=
 =?utf-8?B?MHNQaDliTmhyNHZWdnJkNG5wSjNCVTJVNTQ4RzBrMkc1RG5aMExhdUlWenRD?=
 =?utf-8?B?MmN4a2NQb0sveGFMblZrNm0vOWhBYkE5eDZZNzFNTzdqVStSWG1VYXZ0aFJT?=
 =?utf-8?B?SDRlUjFpcnBHMGQ5SExmQUtBa0wwQVZ1UUxsQWM3SE4xSHhiM3Y0T0dqOUNF?=
 =?utf-8?B?TWExUElHa2E4MTZuOVFkL1Zrd1NQZFBzaFpGdTN0LzRuTE9QREprOFhkQkdG?=
 =?utf-8?B?ODM1UDV1dE5hU2RMQXpRVGJMeGlmVmlnL0tjcTJNM1N1emFpYXhYa2Y1OWRX?=
 =?utf-8?B?RHZFUVJpZS9vaTRMZkNNbk5Bc3VBZVhjS0VZbm5rVzF4b2lTcmw3eHY5ZXBG?=
 =?utf-8?B?cHBBbHp6OStVK0hZOWs2WmZ4WmV4eDBJc0Qwa0tJVU9pd3dRRHUycjNxNjQ3?=
 =?utf-8?B?QUNsZVM1Zlpia0VrWnlsbU9qYndjTGhWNzNiWlJsUWFDYWxubDhpUCs5ZUYw?=
 =?utf-8?B?STMya1NpREVpUDRvVldURzJSeVllUHRFQXV2TE4rdWVNRTgzYXBOMkJZUGcw?=
 =?utf-8?B?UENscWNpSjYvell6eEpuMFlKRjhqa3RXRmYxaTY1ckJqWDYwQ3MwbXVrU2VW?=
 =?utf-8?B?b3JwWEl2alE1ZFJMbCtMeEl0enc0RzJjd2N4RG5SMUxubkNTNTI2NDM4WUZy?=
 =?utf-8?B?UG04VW9KU3BER3ZUcU9kUzNka0tXMkJwMS9JUnRQS1dXdXdXNll0bEVzK2NL?=
 =?utf-8?B?U0ttU0lBUWtoVjM5RUdSNi9Ea0ZySlZSSlptZ2szRmZZYUhyYW5UUk1tSXVJ?=
 =?utf-8?B?QXNRRE9keU1GeVFzWGtIeFBnNHA2dWpLb09KUTJpbkFXYlhCWEhLVjRPSE9n?=
 =?utf-8?B?NnRCc0laMkpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEhRei9ZYVhYTG9kR1c2NHplODRwckJPb1FrOTkwMkpNdkxFdEpyVjRBbnhZ?=
 =?utf-8?B?a3ZWUmwxLzJVNHAyNjAvbW10MmJXS3dWUjgwUXdVaFkrd3lVSjVOVDBYMnBG?=
 =?utf-8?B?akErZmhoMHdOM1Z2SURnTklSOWIvVklOUjJJZHRidEhWSkR4Vy95emRGR2h6?=
 =?utf-8?B?Qy9PV3RhOE9RNTUxYkZ6ajZ3alprS3c0VWluNjljaUhhNFVuVDhVQ1FCUnpl?=
 =?utf-8?B?T1ZqUnlBMk1LUUlIR1dBQXZFcnl3UHRNL3FQcmx0emc5U0pkak9oSzJTU2pa?=
 =?utf-8?B?Rk5ZbG8yTkNSL0lqWjVuQmdUYy9nWno4SUhEKy9yeXl6T2t5Y3V2bGJNZUlS?=
 =?utf-8?B?TXc4cjBIc245WmJ3R3VpQmR6T2VaY3JyaFBwWUx0UE5OenVWaFBremtMODVU?=
 =?utf-8?B?QUVTWjZqcFpIMFBLeWYvUFhsbDhsVE1IMGRsbW1SdmlJeVhUZGtQNkVQd2RY?=
 =?utf-8?B?V2ludmx5ZG1rVi95RlFkb3Z2aFdLZTZYNkp5dmo3emVoRDBVc0l2aGVhZjJW?=
 =?utf-8?B?QzVqbmp3N0hDNUQ0YzlOb1NZS1VLQkY5ZEcvSm82T0RudXlaaTh4dzBSTGI1?=
 =?utf-8?B?V04rMlhCdktybFcrWnQvQ09GMGNoOC9lNGdCSFAxTG9oRHpKYVhDZUVLaW1I?=
 =?utf-8?B?M0RWTll1bHA3YktIK3psYXRNcStXSWdqdlo0VVJOc1lEYXRDcjVhcnU2Q1Mw?=
 =?utf-8?B?bTc3bjhxSjdzWTZsZ2YrYkhTekRFN1V6emtTTWU0ZHJjNTdReittRy9sbkM0?=
 =?utf-8?B?U2lqaEhIamltOTRadzgydjBJaVVZcURTRUNkWG82aHliQjlkb0xZV2VITFpw?=
 =?utf-8?B?YmhLSXFVS0NMVk0xUnlmZ295SzI1NzR5SzEwVmJyeHpLeEorc2RBWUhHaGU5?=
 =?utf-8?B?c1Bvc2JrOEFOR09RdCtvMVJQMnRnalUyTVRwYjM4Mm5vdkJWSGIzYVdmTlly?=
 =?utf-8?B?SzdIckFDbGozS2xNb1lpL01vb2VYeWNPMk1tVUFadzRQME5PMXVzL21VZmZJ?=
 =?utf-8?B?bXVRd3VJcjNEMFMveFNYMm1xVmRnSG14QmNzK1M4RGRPd0RtYUVXU0RLTVFy?=
 =?utf-8?B?SGFUWW1Xb2swMGlidFlpbUdYazRkenlvZjJLYk1WSVlJaEtNWENTS1N4a2xE?=
 =?utf-8?B?bDRnWEpJdDFCYitmOVJDNkNjSTZlVlZvUGdadjMrcmRhVjFsT0FGOEFMSlZk?=
 =?utf-8?B?akREN0FZMXpXdDJTYng2dkpmZjR6T0M0SGpPMDlEekJqbENnd3pjMmtDSCsr?=
 =?utf-8?B?TWZXM293Rm0xRUhUcmxLbUZDdmdyWVhXdWRqUVpkeE5mdXlPNUN2RGJCbkhF?=
 =?utf-8?B?Y3dUT3Z5TFdQWEM1bG1mNzVURUR6dTZkbjBmYmFJbGVRbmFVaThpZ3BWanZk?=
 =?utf-8?B?ZjJiQXd3ckdDY0pMN0xRZnlnY0NHRks3NUpRaGVBUzZsUHh1Mnh6WENoa1Rv?=
 =?utf-8?B?TzE1YVdlSWgrQzNjZzlqUGZrV1ZtaklmWGsrenBlTE43VjlYTmlEZmF4Nkcx?=
 =?utf-8?B?Y1NRN2I3TjJ5cVEwbWxMbVAwRUZvVXAxb1lrVEczc0F0Y1BUZm1UcGhSd0RP?=
 =?utf-8?B?MGI0aFFBeGJWMHgxZm5qNHVIZlBDNXJOLzk5eXBuNXBlNXlrd3JHOFhPY0hS?=
 =?utf-8?B?cktjaEJWNHZNY0pnSm9LNDJWSlI4cWFLbHNRV2J2Yml1aW5KbnpoZlduSUI0?=
 =?utf-8?B?NFNuZmRuM0FYZDJBNmh3dkREdUdJaDE5N1ZiVnNYVnRPUXVLUTBjWU94NEVE?=
 =?utf-8?B?TmxWd1cwNkN3T0I3eUYrT05XaURKU1ZKVWRXZjQ0UDk1aEtZMHJQRjZQcXVJ?=
 =?utf-8?B?bEpmZkN5TGtZUzlxU1ZWa0xxREp4eCtIRXg0eEZCZGtXTU94a2Mzc3J5WXFn?=
 =?utf-8?B?Q3lGTXdmd1VIemxIdDJNcU9mMGpEUFhPclh0UzU4eEg5Ni9lcjhQYURhOWZj?=
 =?utf-8?B?RW85UFh2NlZleFFsMkdyRDNZcFZFeGV4OGttSTc0anVkT25zN2E3OERtUmVj?=
 =?utf-8?B?V29pazNUaWNZM1QxWHp6LzJ0TG9paFNubUJWZHhMa2IrdjVOOTVaMG03OXp1?=
 =?utf-8?B?S0hmVlQ3VXdZOGQ2cTZhaHNMYUo2N3JXQm9ubUFpSjExdGpTUjBDa3QybCtC?=
 =?utf-8?Q?dsbxA8tpr9B4p/D2Ve88c2TRZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f10a6c1c-985b-45c7-5a43-08dd47af6497
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:19.0625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NJG8ZT1zdZYgogazv8+c41VrBv0X0UNu8dWfL3Wm9OEWC2oALup5M+e/S5pX5qVIz1K1RB8KY8Gp5xT+mKRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v9 to v14
- update commit message by use pci_endpoint_test -f pcie_ep_doorbell

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b94e205ae10b9..bba1229c46f14 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -63,6 +72,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -77,6 +87,9 @@ struct pci_epf_test_reg {
 	u32	irq_number;
 	u32	flags;
 	u32	caps;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -645,6 +658,116 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = NO_BAR;
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_data = msg->data;
+	reg->doorbell_bar = bar;
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -691,6 +814,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -953,6 +1084,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


