Return-Path: <linux-kselftest+bounces-30753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D0CA88B4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4446E1621E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9B829291F;
	Mon, 14 Apr 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fu6H9394"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013010.outbound.protection.outlook.com [40.107.162.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7468129290F;
	Mon, 14 Apr 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655534; cv=fail; b=Tfzzqv31q4b7lYzaWukKb2EwWG6QNRebXgbStE0+Wtr3DJVLt3biNfd+KMODZHdmK62j5/gRd91FqpO3vsafbL67QF7x70lG7e9AAxX1jqf7zdGmrrpQg4CIHD/9aszFBalev2GehiLoE66k52BOhU4Qph0ffyipQrWQmX7Hueg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655534; c=relaxed/simple;
	bh=Mp2cXn9FsMWsG/hvucQeIBBPPQdjWFLzH+Ukbq7aPzU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PNcWD6VUrnyKdupcOgDjOO4NMWev3z51iut3J1DoKJ/bwZOMowU3VPHtx4AluV8hVtQruN6fgsdleT3eT/9Dbb9BoZa1ogz1k9/9hcbv60W8XumQQAS1UL9TdevEruHnEc78yyvgfhJj4fBkTxH1EUc+mURxKNfCbIXddIRpPMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fu6H9394; arc=fail smtp.client-ip=40.107.162.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8zTSw6B8N91TcgYHJ/UO46XWS0E29wi4QnDoucr24Vgu8rI2W+9muQC9FuDS032cfENAd6IngYOHi6iLShrMGcFEkrHTi/0z8r0fk8Oh7USQ3OXK8pkh0g2ShRnJZbX9Ti0xrpOA2ZLVIq1Ntmv/kPElsmZqyVfgpvimUk0MhArVttRNsyJckuy+aRh2TIA+DAPCSKidM8huk8lQ8+Lbm44+/p0ug08RGvkLJg0ut35iDutMYkEMnLRi/KlS/DMY4REbnzC9D2bh8biU6h1spk/Oww4CYECmSQFOdYSCG5NmcmpfJNMMQ2eTF/ckv2TXl9XETqFPIONDDLCCL1OsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+qwraQmG61cZxMtmXO5VrRkCys/e7X2Bx0RuL0d/hk=;
 b=tzfwzwtpzlMhf52vesr7XhDq8UjppPWqq2SVnrVjDKZW81RNUo4+ZkYPatHle44niycI442lBgUWnowLgHzORHxp2t+9xXbseKCkIw31bltP6j25AX21NIQU+Ui4JKj5I50VQxH5Xp/RxmPDqA8QYeJ2huXNMBq0n4ymlO29SwAVdSFzIsXkLBW3OpP89rNrRCVo8deOLCNyXMiA5iWlvGPmdiZA8pqOT+aFjrj0Ug3FQ5B730yQ763B798eacHkxnQGRVpBTKA1nQQiJk8cHGwEBMnTYECkbeKowzFf1GWS5P7KSc6zoQriI0RlIhbFERqQhzuYwK6q0cPNfV2YYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+qwraQmG61cZxMtmXO5VrRkCys/e7X2Bx0RuL0d/hk=;
 b=Fu6H9394QD4wPRftd2blMvNnXiCWB85fVvom76ROnNjfv3ulWP9do+Vse8WtdF6KcElCaRpVHdceliibeY2yAEkiUwbaa1GVqXanYpiUgDE6ugMlOOIYVMz44w91i2+bB3Jc8iFLQjONbDl2KYA7z2RSPvIXBS5jrmggN0/xf7Hgt6qT/7ZbLqL9KvinNB1tJ4qd9Xne9JDnZWJxv6TsZqzpNYrND9yVkJgDZP78YiY9wVyclYkFExL2vDkYvnxDopxiWkJl6PtRmqM7gJcZF3X8fqLKAZpraHJ0LfLskBvOB2TmSRxyKcP91D0AmvUtQnktYzTYEqWMTWKtKgSqZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:03 -0400
Subject: [PATCH v18 09/15] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-9-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=4364;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Mp2cXn9FsMWsG/hvucQeIBBPPQdjWFLzH+Ukbq7aPzU=;
 b=Dg9HNgYvd+aJfWpM1GSctMJ/TmWfRkrMLouKSAGPXkPQmxWAmKjX7tfqsLcLulk2zdY4a0PWZ
 PDSQ9kxMpkiAlAY/r5c3juCKV1GE44eJXXaxXD3k7NYcTZpIDvzGwxP
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
X-MS-Office365-Filtering-Correlation-Id: 60038eb4-764d-4c94-1595-08dd7b82aaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azhhQU9BNFA1eTdiMG9FUTFkekVhd2o0ekprdlNEQnFZUmRyNCtLS1BqbHlm?=
 =?utf-8?B?NzU5S3BzLzVkeFZ2WDZKbVRWNVpFREFKMzBHRkk0VERzZnVpNWFFMGpqc2Fs?=
 =?utf-8?B?MmUveWRrTmY4U1RTZWNOazJSeUd3YUNEQjNtOXVueEN2dXRLSmlxZktNWEU5?=
 =?utf-8?B?RUdVSDVTS0ZuN0JVeHdxNmt4RkZ1REUxR2pHOFRCSUhmN3FVbGcvME90TVRS?=
 =?utf-8?B?TG9sYVE0OEVDY3JiNFNFQmtOOVNyb1Vhbk5TVUtuZDlCdHpEZW1JbVpWVjgv?=
 =?utf-8?B?RkhxU1BxWW1Ma0JrbmJ4TnlJRTJSM0E2aElyaXBxV3VpLzNqK0JCaHdkemRE?=
 =?utf-8?B?VGdLamJGR3NPVUMyUU9FZFgxS2lKbCtGd2VDSVowUDRMTTZtR3Rka1lmYWNJ?=
 =?utf-8?B?UTVMbVRoM0JwTFhnSFk3ejk5TmNOb1pTcmNqbDBlSDJ6RlZwVVgwdlVyUHl5?=
 =?utf-8?B?d0MrK1YzVS90VVB1QXczZ0J1dm4xNG4rNjhCdTgrTkZQTzhxL0pHU3RZZG10?=
 =?utf-8?B?eTR2QmViaHY5UVZ6Z3ByaURDd3haYlQzM1hyUzEwc1V2Q2ZaSDlick4zcXo4?=
 =?utf-8?B?MGRGU21lR3NkS3BKKzhuMTdRTGxzWmpyL2w5WEZjand0Yy9lNFBsNUZhK1Bz?=
 =?utf-8?B?UW5RS1JOZVRBaGJlWmFKQXVGRC9xVmM2QktteFpTMVZiMERrNlhONjdPaHRN?=
 =?utf-8?B?SldkS2FmNkhXNWM0MVdRWXV6VEFrNUdpOWNxeDhPOVhia2MyNy8vMEpsK0Rn?=
 =?utf-8?B?eGVhKzNxWHhLeEhqNW9QelZ3RTRmV1o4VDI0Zjd6R3JLTEQ2d2JibGYraTNW?=
 =?utf-8?B?aXVBdmNiczl5RmRSeE9XdE9nd2lXUjVIWUFpenFXRTY1OFZUSCt4V29OcC81?=
 =?utf-8?B?ZS9ic3lMaTJmc0NkZVh0ZGNtWmdlZlhDUW0yQ1BtNWdtL3BSVTdQNUR2Z0sr?=
 =?utf-8?B?RDNEM3NNTTRhSW9FdEpyNDZWaDkvZGZid0JsenYrQVMwdkpTZVd5MC8zQjNa?=
 =?utf-8?B?Q3UyVFJ2dTd4TTVhRlhON1gvOC9wK0hwR21lZ09FZ3pQSXdyMjI1aEZnS2Nh?=
 =?utf-8?B?SDFhVjZ0Q1dGUHRTSCs2bHViZ3JHYXlqWU9SOFc0N0hJQVFTWk1wUndjajcy?=
 =?utf-8?B?b2tEUG15c1pocU41NWhPMHNjZHROODdJb2V1dUcvMkdqd2pUZnhxY2ttWkNy?=
 =?utf-8?B?MmxMVmt2MzVKQTVUeGxvYjVweWIrdXoxSjhrSTlaTDVoUnBCUlJNUmNHQWZ3?=
 =?utf-8?B?NU1STkRNdjdCcjBnZG11eDlVcTJGZjFSS1dISHdNRStzNUYxMUE3NVhCRjBE?=
 =?utf-8?B?R1FpNkRVNTNrZmNzdXhWZGlDZ1hwNlo0R0J2Z2pRYTVqd2lQUTBhZUNVbHkv?=
 =?utf-8?B?MUYwRlh0R09GRE1ybjlIU1hzSzlFOGdqMnh6QUllRXgyQzNtZ1Y2UTVOYkpw?=
 =?utf-8?B?MU1kcVh0UngrY1J2bVZ4VGRaVGhjRFU2NldoVGZrOWExaFQzOEJMRHBOSGxY?=
 =?utf-8?B?R01MZ3hFcllXQzNRMmJ4L0JmL2FMUEdLWnR6RTBHbUVTSXNnTUhGcTJOMWNm?=
 =?utf-8?B?ZkZpY2toc2drallDcFlQdm1RcmpFQWI1eEFDdnBJZkNNM0FEN3cxNDg1S1hS?=
 =?utf-8?B?STFIdWRheUoyQ2xWNjlsTDI4ZVhEWDFETHRPb3V2MEliOFVDUGI3aDJQa1hN?=
 =?utf-8?B?LyttcWRtZmFuL25JdFZtVnl5U3F6c3l3OWhLdXhNSnA2NGFjNWdYdjZHRmNi?=
 =?utf-8?B?N2l4Z0ZleXhMcjc2OEp1RVdrZ09uUStxTkpMM2VBRmlCSVF5NEZHaHJMU1lQ?=
 =?utf-8?B?VXUzMGdubGZ3UCtPN05Ec0VKbjgzTEVsdG5nc3AvZCtYRUxGcDZPSnBaUVF4?=
 =?utf-8?B?QkJtR2I5cVl4bGlKUnU3YmgzUUdBVktwc0JnWm0ySlZ4a0NXNzk3bnZsNXNY?=
 =?utf-8?B?RkM3WTBCcFJ0Nk9mVnJNeDUyRWhsblFTNXU3aWdHQUZFWnd1cFBNYTMyVnFX?=
 =?utf-8?B?WW5DNjBsajloMFpZMnIvZjBqSzJaZHB1SzFBSzhJa2ZQVURwa2U3VWxSQldM?=
 =?utf-8?Q?YENcwN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWk1UGZlRkZRNWJyWDUrUzhxQzBWUHAzNjk5ajl3eDJuRm5pTWFWOGhvQ29w?=
 =?utf-8?B?N3N2b1NlUEo4SXJXcDZpQXE0MFZORTlaVXJvUmRTYjVtVzlNcEVsaWk4ODFR?=
 =?utf-8?B?VHVsOGR4KzRCcmtpRzhBWVZtTHpTMnhiY1BpMDVNUlJSMEFFWTlKMDdyOUpY?=
 =?utf-8?B?bTlIVStvVXNhV0NVNVJ0eTQ1QVphM3RFald0aDJxUWJTbmV2QXJheEtBelJ6?=
 =?utf-8?B?V2tyUU85UWlDZEFqL3J6ajBPOHhGRzJTdFJqMXdJQmY1ekJjb1NvN1BzTmFw?=
 =?utf-8?B?ODFjSUVkemhIY3R4Sm4vMWNvOWFlL2dIN21ZWUNzVUdvekVmVkx1VC8rNGZ6?=
 =?utf-8?B?TmM2cVM3ZWJUZkRKSStLbTRJb0hxSWhPcDg1UHd2aU9wVnIzYnBDclVrZmVp?=
 =?utf-8?B?WkRjdUdJWm1sYTczM2k5OStQMDRHNWNxYzcxSHQ3bVo5cHRUam1yODllTk1E?=
 =?utf-8?B?QjExV3VqblI0L21ybFZ2WUVuUWhyMmFmNUltSEQ2SFNyRW5tU05ZbUsySk5w?=
 =?utf-8?B?Uk5jUmdCejRSTEZXNFpLVzhIQ1NSRS8xZTBjTXpkYUtvdENjeHZFVjhMek1X?=
 =?utf-8?B?NmdFdFBjc1A4M25oSmZKSzhpWkw0MnZ4aUdiNDdSQVVaVkpvdDVTcmlub1ZP?=
 =?utf-8?B?NkpDbWFsZWdVNjRmZFBpd05IYlNqM3d6Ujk5dmNERWMrL0l6Wms0MEVxTm1r?=
 =?utf-8?B?bXE0YVcyMGxIdGRHektSNlJYcGxPbjZZRTBhQmpYTzcrTVNDV01JVTdYdzA0?=
 =?utf-8?B?NTlUOGQyNGh6a3kyU2c3L3MxSzY5V2ZYc1N1T0o3cEhCaWkvWG1TZGE0bk1T?=
 =?utf-8?B?SWZlZkVmUzQrNzZPalFpS0JiV3Ira2hFRW1FUlVEaWxucHlpQ3lPeGV2Vi82?=
 =?utf-8?B?TUE5Uk1wY21lTVZ4eEhuK1RCQzFEdnpxYjhIZm85ZWZQdUxmZTBCc2pEZG5j?=
 =?utf-8?B?QlVBaERjanpYcWZHN1VIT0VjcFkwMkhRWlRnVVFsUVM1SXFzcHNzaHVHNDdO?=
 =?utf-8?B?WHFIMzhmeGtxblVrVU1IRnZSaGRUTWJVbkJEUkNDNnZJcUVpN0xNL1crckND?=
 =?utf-8?B?WDZyZnZyaXVEQUh4S0pLQkk0TkxFVjdzSFZ3UjhuM25xVjRGRE45OGdwZm02?=
 =?utf-8?B?K1VFM1lWR3lCb05xT2lvMzhNWVd0NzFqMUI1VWk3TXgwZC9FbjBrZktGL3Yy?=
 =?utf-8?B?UmpoS2pVN2ZmRzd1dysrRjFYUnFjejJNbldjRmZMQUx5S2loVUEyeEQ1Smpy?=
 =?utf-8?B?WUxuMFJnMmFxTys5cFZjMVlWYXJWNDhXaDdHNlp3ZEJFSGdEQjV0SGlNYXRj?=
 =?utf-8?B?KyswL1ZBZlI4b2tSU2VkNzJjbGdhT0k0US9PemZiS2hWdXYxRnVlVkdleDcw?=
 =?utf-8?B?QmY1ZWo1cGZEOVdPdHJxeDlCV3B0TzJoZm5QcDhCeUF0NWdwNHBCMWN1NERH?=
 =?utf-8?B?cS9qNzg3MjhJWUxDdEl6VElNYVEvMFFJLzFPbUo5dEwxeCtKbVVkRGpaSU0r?=
 =?utf-8?B?SDJEQmtUN0NvQVdWd29wblJNckkzZGYzRVdvN1lia09lSUprcldadjBMN2Mv?=
 =?utf-8?B?Y2RZT0pyam9seGZ1cDNpZUJSTG5xbXVjVG4yWXc5ZnpTUmtpS09lYk96YWZk?=
 =?utf-8?B?YTdmNW9rYUdXTWxGdHJxcXJHNU0ybE05aG5rdlNELzk4blVDcW1sWkt4SFE2?=
 =?utf-8?B?QXdoaGhKNTVsbmdTNVB4RWhXTVQ1RWVtd0pDZ2FPYzExaUlVTEdBQVI5dzFM?=
 =?utf-8?B?ZEY0UWZvVFNDaGRGTkNDaytnQVhqYjRJcTdyTW1VVHRhVmk0ZjhlbElIRERJ?=
 =?utf-8?B?clI1bk85eTEvVDFRUm8vVDMwaVZxeDZZcTZSSmN0VGtnZXZlaFVLRk03VjJv?=
 =?utf-8?B?WnRyNlJTampzRmdhcVJydE1uQzd0RHZ1eDQwbUIxWm1nNWZjMTdzZDA1Tmd3?=
 =?utf-8?B?S0NEa3hqL2MxcGRCRnBzR0hKOTV0NTBldjJ5a2c1SFFOdVFHb3lFcUpQTDNo?=
 =?utf-8?B?SFJGQm1HNlhkdTl3Vm9zME85Y3JuUGN3dUlKWWx2ZGtDWmR0MG1VdGFzVnpa?=
 =?utf-8?B?V3M0N3lzKytiRFRKZzFJVTl2ZWpZc2FneVcvRlZuZEU1MGpSOW55VDZLcmw0?=
 =?utf-8?Q?3g3g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60038eb4-764d-4c94-1595-08dd7b82aaa1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:09.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFacAYvx5tA9m3oi7SR//LapI9OIej1kJxhaZkmotVnaKS76xmjc+fyJ2vadg9e6jQFnCBbRGdTsFmlmnuov9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v15 to v16
- none

Change from v14 to v15
- change out address type to dma_addr_t to fix below build issue

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
>> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     726 |                                          &epf_test->db_bar.phys_addr, &offset);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          dma_addr_t * {aka unsigned int *}
   In file included from include/linux/pci-epc.h:12,

Change form v9 to v14
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d04224b8e1631..529dbaaf76750 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -473,6 +473,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index dcc6e2a2c6b3c..299ce1f1e2d80 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -241,6 +241,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


