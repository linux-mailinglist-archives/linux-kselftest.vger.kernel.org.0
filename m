Return-Path: <linux-kselftest+bounces-26424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6007A31538
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2423A48C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB4269D1A;
	Tue, 11 Feb 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kr3yDnVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2083.outbound.protection.outlook.com [40.107.103.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCB267B77;
	Tue, 11 Feb 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301849; cv=fail; b=c+IM5OPIww60HMCECHksroIuRI1oxjquAXUdgLzxW+IdTUTfQJFJb7kQZnFyxzLANjehzxbsdus/abscmXJeL6jiOgtTOKf0Ct51bhp4f9j2mEm2/E2uYydTESsIYfulnB8GSpsTygcP0+ldU4/BH+i/vGPK3DkXitzMRsM5qkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301849; c=relaxed/simple;
	bh=knE/CmvE46T0/xnSlVa71FJ0CBWaqIRqeEskbx5cLUU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Iu+N9toAW9H6a2EPJztZAtUJ97SKtsFnod0nxGBl7mR2xiFx1QxnjuZ4Dd4/20saJINa2aCg+9A1Qefdm8nuvazur+ngC/pogoph1R825fkAQFpS9vdazyzawg6QYPsUqMaw55MW7PP7pkwuE3Kv7xJRxNrR3WroLrcDPkYdrFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kr3yDnVK; arc=fail smtp.client-ip=40.107.103.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTnoqYelPTPz76iTcijtoEmqCmHbnFNAa8w2jXODmtsWnKSls8Z2wXRiRmwdVntnsTsORLbiht2qpCmZZRP6gJ6O5nafmtAFS6aq70dClNo5WdeBgIA+hPAcLQn3Z3r6G3KS3ngr646ubR49+bkabuU84VMhPA3sSSCdkndLv+hPq2Gsg4Wzj1f2ZXi73KZK48DHqwoOP209dRMAyTCPiqabNcZy+ck1mE1/wJRfdDBzgwwcIJMC2DN+J7DJCNCRSdKBHVW4ThEpxfjAdQf5u+O7a9j0sq0Hg26SbrN1kahW/qV4CYU4t40eKi9c2Tu+5d+s3lag/YT58GzEJprCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlHb7U9d3KXCJlq+jCIbt9HbEtcylYi+Lzqvx5LyCdk=;
 b=FC+3LS7EcIs11Gq/6tTK0W+h7DJEuxT+LwW3wPH9aiUksofwn1wMMZ/HFKwiNBGwfUhg2jUQYyEORDp4oeU1pRVwi6oyU936k7BBfu/u7naANgZbnd/MkCDDlO0srTInchBxw0ld/N7REGvG4nmvH8uCBaPNqyihW9iTaCI45BvjWgy8ApOG9yzIUxKvmHubGnSwMqgxAB5TV1dEQcN8mwZ9DY4/7gufHeizB9V8eQBpmEZ50+FF6XPJQr/lj8tKvClcOEIowlsnXh0A3pNsYo2Auf9y7xAkUYL0mF4aCOSdGvGYZoUqoHZDIwTP875PdrZkwKgzNKnrlj8vGsmUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlHb7U9d3KXCJlq+jCIbt9HbEtcylYi+Lzqvx5LyCdk=;
 b=kr3yDnVKDg7UpNBQQoPtmt6d1/HTC+lNQLAiXv3MBIasQFl/xFUsWAO5FJBYO7EfQi2kijYEXPrvjN/vKv8eVjuVW4d+y7cZycgxlDyyxnjBOT6/oXOmfWW5wNUQfZ7i/TdjiwjmWAVyfFhBBe+gjig72VWybIfTMBPtU0KMQtCoq0pftoB2tm4VEqk0EUn7MezfD0WgiiYJRL56lI49ZOYp6P5wUPx0t0JGrATVnDyZi4F34aTIOWdi+nlc3HSevD2fjGvLp2SFW4Yvz0S39W6RBeUtKVESfsQssAvAPTKW4B/zZVHi13kBXtjutGCPwn5qMS2+zpxaoIGGu9MCzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:24:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:24:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:08 -0500
Subject: [PATCH v15 15/15] arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint
 function overlay file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-15-bcacc1f2b1a9@nxp.com>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
In-Reply-To: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1989;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=knE/CmvE46T0/xnSlVa71FJ0CBWaqIRqeEskbx5cLUU=;
 b=NmSTvsOMd+rcSrB8g9NxDgzAajLWBpA+oriEwFRhJqL0Q9T/bxg1LDnaPTDtbvq8P4xoqKm5w
 WUShJNJolYMB29EmpawSg+QQdLltLy5BR/KXgzyV0e3Sin4L5pnfVDG
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db3e0aa-ada7-46cb-111b-08dd4ad1a584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzIxRDRXZ2tCZnplYVlBREs3TFlHYWYzcVpPZGsxR1IvQkF2TCtBWnA2a3JS?=
 =?utf-8?B?UzNycG5yaFRlMDZsdFV1bEgxdmlSOHFOd090TWY5MjMwQlYvNFRDRDVlQ1p4?=
 =?utf-8?B?d0dOeXh4VHFtbzlKUGltbWVYUHJEYlR5Y3FWWDdhdThQYjMyV2FwYmFxT3Uy?=
 =?utf-8?B?NnRaUjVBWlo5V2NJWTVYTit1WEVjVEtZR0YwV0UyektPWFdlc2RtejJxbUJi?=
 =?utf-8?B?MTdpQ2VjL1EwZUl5L0JTQnIwa0lrRC9qSDhMRit6bjE5b0MwbzFrNGV3TUM0?=
 =?utf-8?B?cmJGN3Z4aHk4V1Y1cDhaSXBUYzdrMWdyVmg1c2ZLZkw2L29aMUNQaGI3YVhC?=
 =?utf-8?B?NXFTZWVvc0VGaU45WFV0Wk1CYnh2eHhXRjdoQTJVN1djK2E5Tm9aQjF4c1dD?=
 =?utf-8?B?dXJPcWZHOUVtaFg4cTF4MXlYSmNoSHRLZVE5M1BVZHdPTDhjYnpJTVNTbFZQ?=
 =?utf-8?B?eStxblBQVGRKUE00NDZkeGpvNjBDVUJsSzl2NnQwRGRmV0UySW82ZVVyZ2Fk?=
 =?utf-8?B?K0VZa0xLcnVqUVREc01YckhXa1hpYm85bjNqMWp2ZWlHckJ3cFNMYTMzdE9x?=
 =?utf-8?B?bzBXSnI3WXd1WFJJYkJxbXdkMzVRMWtXRVJvMExFTVU5QUJodGhHSWFkT3VP?=
 =?utf-8?B?c0dDOEFlSmFnbXh6UnJUYmRJdnlEbWxmWmo2MytCUTZjcnJ6OUpJMnJLRU1K?=
 =?utf-8?B?TTZBek5qYnMwTVpmMnBYTE1mTGdqc2VxN0o2b2JxT1VZMEF6TVYzQUNpOEo2?=
 =?utf-8?B?YVBYL2tsODlmN0YrNGRjMXhRdnBJUUJXNUJnM0xFMkVsSEdIbm95QlFsdmpT?=
 =?utf-8?B?MHptK2E0SzB3bzR6UXJMNlA2ZVQvWXFERjVlZHAxeGNscGQyNnhlRmVpdHd2?=
 =?utf-8?B?OXIwNDY4NjJvS3lUQVVYN3IrMStWVDl4RElnZmNHOHdIbmVhYlRkUDZibWJt?=
 =?utf-8?B?YXFoRVZERG9jOTdrVWdkRzVNN3BRNDdaQWVpWWNYWVdjQkNVSHZhMHkrTnNx?=
 =?utf-8?B?VnZ2aWRacWVYdUVIb2M3RnArUUNHRTdGVlpNL0tkMWlrd2dGeHBHU0ZGVU1z?=
 =?utf-8?B?enZpaDcyTXVjdldGaG4rQ2RFZzBBZnFhblZFT1BXVEdiLzRjYmlFaHNOMFRC?=
 =?utf-8?B?eEtrc1VtclRJTlUwSm9XdmhVK2ptTUN1QVFXaHBFbnU1T2MxRlorUXdpUXJt?=
 =?utf-8?B?ZEVmWXdKbEZJY2RwVUhWMUdVYy9IN2lSWEY3b29HN2lyZTZLS0pkSGw1MU1w?=
 =?utf-8?B?OHQxRnczd01lQVBPRFVCd2c4MjFZNFJML2I3K0lEMFh1bGZRcEIyRlVYZXB0?=
 =?utf-8?B?T1ZRQUpXUmtjSHlTQUE3TkVCM05ZQjZrNllpbEpaUzFqbXlMK1BHL013blR3?=
 =?utf-8?B?MjU4K2V3Z1pyYW5qQlpYZU9OYllkbm53UkNZV1pJMERCWVBoTzd5bzBNbERR?=
 =?utf-8?B?MU9rVnBESWRTQ29vMlRob1VoUmx5TUJOb3pRajZldW5LblFmWHZDaVJmV29t?=
 =?utf-8?B?eStXWlFKbjhENjBBeEZneHUrc3g3RUdXMVMvcTF5TWlFVzJwQlZ2NmFaTnNx?=
 =?utf-8?B?R0JMNjVieDB5OEYwTE1xNFY4cklIaXdPbHhnajNLaXFoaDh6V2xaZ1ZpVUxD?=
 =?utf-8?B?VHJoTFZjZ0N2SE5STStPd1hsa2pYS01uSzU5VEMrdWFhTmZOdEtwSjBsemh1?=
 =?utf-8?B?dEdlbmxkK3VpK3lmNEpES25xWnhtVndjVHUzMnp3QnB5TkpEQms5SG9TMERT?=
 =?utf-8?B?UnNYenVpbnFGa2E2LzN2eklybkdOcXlzVVFYUzE3QjFJd1JFMTVPamkzT1NB?=
 =?utf-8?B?L0RxS1oyL3I0RVJWRmN1T1hNcHVxVlhGbjM5OU5ocUtITllaWUQxcTJuMVhP?=
 =?utf-8?B?allSeElna1FyT3VXamExd0R4SHRyalZuekphbG9tcE5RaWh4MnNCSHRoK2pm?=
 =?utf-8?B?SDl2UGZyd0pVYmVtQmROeVh0Znh4U2J6cmZFT2RYUjYxVGRHb2piNnlzS2ZX?=
 =?utf-8?B?VzZ2NzFkelRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjlKWXMvRFNOVjdlQ1ZWemFsZ1M3bnYzRmZML3A1Q1BCUmxNQ0c0UmRFd2Z3?=
 =?utf-8?B?b2xVYTd4bHo3SzJBMmZTWTZnRjlPSlN5Mi9GNXUvMVgzMnluQnMyanZwaFhu?=
 =?utf-8?B?YmkrMm5XYmtWOVdHa1VwcVppYkVXcmVENVFsNmtUS1FVNXYyQS81YlNEUlFD?=
 =?utf-8?B?dDNHZDY1ZWFmSXhPWFdZWGdGL1d6WTFNQyt3bXczWWpmcmUydlFETUIrWTN1?=
 =?utf-8?B?STJ6eEc0MjlYMHB2UEFubCtJc0dsL3lzYW9tU1MydTZ1WndMQnlZOFRBaXJZ?=
 =?utf-8?B?OXJ2UzdORktWRkpDaFVxcGoxbW11cFdJU3p2WGJxNlBmYTRJQU5sN3M5dTFG?=
 =?utf-8?B?dUQwL01nWm5zYlgwM3pDeXNaRHRDWEZqSEYyb3BHajZTL0tHOHlUMGM4ZnA1?=
 =?utf-8?B?aFhEekFrbjNPbXp3ZVVpcFhtVzB1OVJQc0JMWmdlTlNlRnduSlg0QkxsL2FP?=
 =?utf-8?B?bHowUm16aHpVNjZBR3I2OHJ3amlWU25DRFpDb3BCMWU2Um9iMk1kMURLWnYr?=
 =?utf-8?B?U0toOTFlWDdwUjJpM29KWC9lTVZoZjFzbjhydjl3UGUrMEhVVEpndnozQmp4?=
 =?utf-8?B?NGloTWI4TVhjSmVUeEdDY1praG0ra2pTT0F6d2JWWXlUNm00WXJtUllhKzB0?=
 =?utf-8?B?WXBrUnFmYWdDVVB1U0xOUlVkYjlLc3NXOGxUR2FidDhuSGRiRUVsU3l1NzR3?=
 =?utf-8?B?eHdud1NYakpSbzhXVElLVzM0cmVpL3IxbmdMRGllSnlIWlBPcVFRd2ppRy85?=
 =?utf-8?B?bVprZFdpQmNsUDI0OWpBOE9keHJjZDVMOWZLRkQraTgzNi9RQVc4RUM4NHZ1?=
 =?utf-8?B?blFpWlpINUFvd3pSOGQ1Znl4RDZTVnNqNHBHUWFXTndKYmlNSE9IZmU4ZTFL?=
 =?utf-8?B?S0N4TnFldXFDTUJTd2ZhbHI1ZE9mM2JZdmFVRzltTFFSRXZjRlNOTXpoay95?=
 =?utf-8?B?akFTMTlvSC85NVl1OE1vRURtUmhQblFPbFEwbFNDcHNHYWtubzN2RStOc2I0?=
 =?utf-8?B?eUlSOTJ2cWdzQlZTTHBUUkNQWHhjbXNYSVZXcnFKTWJxcjJBdXJYV3J0VllH?=
 =?utf-8?B?YTRJdWppL29rY1gzM016VEhRSEdqSFFka1ZieVEyNWJyRHBxeGkrY0NnVUU2?=
 =?utf-8?B?K09aR283d3dLcVVhVXVQZmJvdEE4Y01vTUxReXNuMXJTbVRIeUNrRjNVUWRk?=
 =?utf-8?B?N3Ywc0oxT01IbjhjZnh2NGpHbWpaOHJhUTVNS2tYNlBrTzdpUlhySVJBRUgv?=
 =?utf-8?B?Rko1U0ZYK2M1K3NjaCtCVUlaUzNpQnNtanZSaVh3c0R2SkxVTTVsd2VqTzFS?=
 =?utf-8?B?ZnJLY2s5Z28wQ2oyRjFRelplVlFWenlqUUVoVmY0K0dTT3pjWnRKOThHTGJm?=
 =?utf-8?B?cy9SNGNCTzlwcGpScE9ObUxvc1gxREVUOVl4Y3dzaVI4blQrSFNFaHVsa09v?=
 =?utf-8?B?NUVyQXhNK0J3b0xIOTV4YmVQQ0lKN0tnZ1BLU1QvV2ZMWmJ6U2MzMENTanI5?=
 =?utf-8?B?VDNnUEZrU3NSbHRYdS9aVkk2WVF2d01SaEtJbnVrUXdLTGE0RERBUFhhTWcw?=
 =?utf-8?B?RGdKQ0RRb0xaTE0rbVJNSkRHcEgydDdJVmRDT3ZUZFNaWi9VazhCcERKOEla?=
 =?utf-8?B?bkFWSVdXb0sxOVIxeEZiUllFcXUyT1Y5NG90d2NSSHliR1lMUTNGQVdtNGdL?=
 =?utf-8?B?V0E1R3U2Sy9xZFgvdDJzQWlXU2pDcTMzaFhWWHJFOWp5SXFvZ0FnMUVZdzVQ?=
 =?utf-8?B?SG5sS3JBUnlYRkpzWW5CZFpzdWRiSEZuVGw0VUU5ZDFkUGtvZng3bk5RdTBX?=
 =?utf-8?B?Mlgwd3dSTUw1K1g3eTd1MjZLSkFpbUg3TGpVN1hiZHFKTXZmNzZWam5TQlEv?=
 =?utf-8?B?bnAwckREVjhvalRoY3dBQy95QmtJMjUwT2RPNk9BZnJ5eXdoc0FEb1F3L1RU?=
 =?utf-8?B?cXQ3MzBMNGhjMk5XTWxLN0syOUc3cGxJWjZoRDkvTEY2cWRzNVlRMXRGeXE0?=
 =?utf-8?B?SXJ1TmpBOEVPSEhPN1ljRU9Hb0FHSWVHZ2xvY1k0U0crRWJsR2lPZ1dWS3VG?=
 =?utf-8?B?alhmc3lGSFpHbmdabGRhQkpxVE4weG1VV1dsZG4yQjY1VnRBa2YvQ0pMQ2Jx?=
 =?utf-8?Q?NNHE08ggvYsDkNa4h5vHk0B14?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db3e0aa-ada7-46cb-111b-08dd4ad1a584
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:24:04.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCWuIIuo/LDvZMDO/FuGoHPV7m6laEqkajR4ovGCJMGM3aypFzWRssfAb0AePDsEa2lYHd2zFEm1sEJ9OoLE9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

Add an overlay file to configure PCIe1 to function as an endpoint. Enable
PCIe1 to work as endpoint mode on the imx95-19x19-evk platform.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

change from v13 to v14
- new patch
---
 arch/arm64/boot/dts/freescale/Makefile              |  3 +++
 .../dts/freescale/imx95-19x19-evk-pcie1-ep.dtso     | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 839432153cc7a..d892303fa7eab 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -287,6 +287,9 @@ imx8mm-kontron-dl-dtbs			:= imx8mm-kontron-bl.dtb imx8mm-kontron-dl.dtbo
 
 dtb-$(CONFIG_ARCH_MXC) += imx8mm-kontron-dl.dtb
 
+imx95-19x19-evk-pcie1-ep-dtbs += imx95-19x19-evk.dtb imx95-19x19-evk-pcie1-ep.dtbo
+dtb-$(CONFIG_ARCH_MXC) += imx95-19x19-evk-pcie1-ep.dtb
+
 imx8mm-venice-gw72xx-0x-imx219-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-imx219.dtbo
 imx8mm-venice-gw72xx-0x-rpidsi-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rpidsi.dtbo
 imx8mm-venice-gw72xx-0x-rs232-rts-dtbs	:= imx8mm-venice-gw72xx-0x.dtb imx8mm-venice-gw72xx-0x-rs232-rts.dtbo
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk-pcie1-ep.dtso b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-pcie1-ep.dtso
new file mode 100644
index 0000000000000..696588e768e61
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk-pcie1-ep.dtso
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&pcie1 {
+	status = "disabled";
+};
+
+&pcie1_ep {
+	pinctrl-0 = <&pinctrl_pcie0>;
+	pinctrl-names = "default";
+	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+	vpcie-supply = <&reg_slot_pwr>;
+	status = "okay";
+};

-- 
2.34.1


