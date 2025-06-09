Return-Path: <linux-kselftest+bounces-34500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF24EAD240C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D6B188FBEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C521CC6C;
	Mon,  9 Jun 2025 16:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xlg1+bJi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012008.outbound.protection.outlook.com [52.101.71.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEF2192F3;
	Mon,  9 Jun 2025 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486892; cv=fail; b=EI9t8hSwWwRi+FGaqMikAoJCcOLTMN/eJsKOEcbAMmhydnRwHVGnLbOElX2vpQCmQ41Ww087GU/XhaDgARqnGXf+WYZsegDfTaoM67UFbn90haMgq9eh+lDNFi0Ziemoo2NTs0zNbbUMTd0uhmLvbl7hqP12QcHWUXQ/UEj1F+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486892; c=relaxed/simple;
	bh=KBtuF8miMtkby9wBmV/5EQTm1CzbNkKTi323WUC3f6Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eoiG/5zyavCSgpef4BP4cVQ4OrX3o8fulBH8vYgFyuOihWcjA+3/DqjnK7ovrQ2H0ZJ/lSYp8ZVXh85IrlAeFrV9F/H2wm+povggSeIECvccmINY5JthtizYUBQrnmyOMG4BokKKF8kw/c8GaIU6LbA1qDtbJZwkzBYwgxOwtuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xlg1+bJi; arc=fail smtp.client-ip=52.101.71.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5yfiKhFF4MS/HZ/tTqkFPx4FYjwwiPiq0bBnB/hsB04qL08ijVCAv/FOlk3xwXT8JMwzO2dY8ypGewgj4Ar76qflLfSqYE51f/E8xuxAmJYo/qQ3X2Tdh2bomU7MCmnn2mzjLds8E4+nWcWIAbQl3y67Hs0RojaaNFvDtgtdNtBV6veNFXPA7QDPgWy1Ge+OnP0Scf78jYhM3bIB02W9skr7MW0SFvIx6smxqum/OzHZ57YueUWt0larNPPCn8cY6fwf+xWT1cZR7ZvOMDW425uoDVUrxI47ev9lTjvKCaCSAWDzyBCGavyBVBVyC/fOUuLoCjyc40HrIvKEmwb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjTxygeOethmpgmU8zeL27rZ+uIJQAxjOYpjcexzjvg=;
 b=dgRkqqOcaXhIVe9wmx4u0usHwi6lb9G6MWgJKbfXC6bvovlOmsOuvJmOcah3P0MxaYyuWK/KPQJyiGugeEBxydesl+o4AjMTACBf9jiSmdy+1kD+YxaQ3Z87dqDDjsnUP7d3rfuGhZs5AoQmN2AwTcUG57r4O1Fx53yY1479AxNMRcHfEsnhLdEImRLn3HaB/K6xR1bni5UY/ikd1B+wcNm7jl81U3GifHyf8sEPyeQmcRgoCNqmX8BCZg8eLaQ/DF5D4HGTMdP/fVwr9o9f2g/VozUK9nxXVv/TcEvBb1Yk+6+t9HmXcot+va7557Cfq9B/aEVw1icNKOcrr4W9XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjTxygeOethmpgmU8zeL27rZ+uIJQAxjOYpjcexzjvg=;
 b=Xlg1+bJi9keVdlSBp4DrmZENRxN3TsFiAraS3YsxHs5P/J50iNKpIc6YLkKVB3ApeDumDCKFwNJNFDNNvuq2OySBhx9X0sGSmyvgZfR3PDxu0In2y+ni4MZiuVIbgWrS2mj/+zc17CXuqaGyULrapZYhOdB5tLhPdc66YlgTFH1SVR55BZXRHa4MiMexInKl3BjMXOoqGgeWfNJaI8J1HmkhwNTS3Ly5isqBMaMCrCWBrB8jXyhcafGcGOuSkaXY5Se0D8z9NlOMbk523diaotIkQW3mZvZlzKXDogwJekLqCeCEBT1QVc5N1/90VhzVclY4ni+xEPf8tm3VEgt8ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 16:34:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:34:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:15 -0400
Subject: [PATCH v19 03/10] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-3-77362eaa48fa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=1204;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=KBtuF8miMtkby9wBmV/5EQTm1CzbNkKTi323WUC3f6Q=;
 b=pGs4ODVQNxu9xPJes726sq8T4tTaBNWu+bX59FuX3YSynVkCANiqq6WJ56RWIzM9GmYRWYNI4
 n0QU8v3ZbgDCqwe4kkxGHQwpPIVKLrZobBbKuZQyGbU3sMS/MbpNd0y
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2a0d4f-c1b1-4198-3038-08dda7738c9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDZLNEl3WFZQdEVldE9Xb2EwWHJEc0FwZElWTTI3bEFDc3l5ZURTQUxXZFgr?=
 =?utf-8?B?VTFYa1VQMFRORG96Wm80R0MwZzFnTnJBWm50ZEwrTlpKajRGbjFIZFRrTjJV?=
 =?utf-8?B?a0thMDZhS2VSeERrcTlUWVZqL2F1dVVyTVNlK05ReWI5NllPMENOdWdldk5w?=
 =?utf-8?B?bjBOSjhjazdsVVRRVGE3SncrS3pBYzAwNWQrQTYzSjMydE9aWWVsUDdMUk9N?=
 =?utf-8?B?QkFWN2RQSnU3WmxlSXVSMWFSK280cnRadWpvUUpVaE1RVzQzUXJsVWN2S3Nu?=
 =?utf-8?B?QlFHY0xlUlIzcURITEN4OGZFV0ErVWZQVkRFOEVUL2NIMFJEQUxyam1NaHdB?=
 =?utf-8?B?bVI1THAvczVveDlnMUpOT0RRb3FhQ1JibHdDT3JSRVk1d0M3bXZzM1ZUMko3?=
 =?utf-8?B?Z3pwRzdkRzJscGYzT1gzdWNVYWR6N3hYSUxsNTIwU1N4S0g5Q3RIQ255dWs2?=
 =?utf-8?B?UEFTUEZsYWpTdGdKNEpEcnVvZ3dYQzZGTjBHaFp1R1dLcGZ0MG50ZFlGUkpi?=
 =?utf-8?B?dFRpb0RXN2laN3ppNXVTSjd2SFJOZ0VOSkprc0NEaG9KYmJYa2UxMjc4WGJi?=
 =?utf-8?B?RjNoOHJ2YXc2YklTU0w0NzlIMTh0OXN4dnFHSE9BZVFrNnozL2owQ0pBK3E0?=
 =?utf-8?B?eUxLaEw4Mk5OYmF0NExQS29ObnptYVdwV0kxNFA3dC9zTmZMZ3NPRFhGdXho?=
 =?utf-8?B?d2ZKVE9uQSs0MSs1RDMyMitmV25sTGZEd0JMUHZ1c0NCMnMzcFlZUDhVWFJN?=
 =?utf-8?B?ejRtbmZJTGFHK3FGbzMwdDIrNkJVMDNwWEF6KzVVZTVMK25aVm1FWWdyOGZy?=
 =?utf-8?B?b1FxYjN3dzNNR3d2MFltaG1NZGtsWDFFZDFhbGN6eFp3OTFvKzh5SHQ1cUsr?=
 =?utf-8?B?VWEvVTdzL05Va0dnZHZzTTBreWVMQkZJR3NlalBSMmp3LzEzS2FPaGRZN3U0?=
 =?utf-8?B?SDV1OFl4YzgzdkxwQWhCd01QRnBNR1RHZEdVaTZOa0prSVJjc1U3MGVHL2dy?=
 =?utf-8?B?WjdOVE5CUEpySUMwRUgyUnZKWWQydTMxZUlZVVF2L0lSNkw5N3ZoUWlTV3JZ?=
 =?utf-8?B?NjNUdG13UzJjSlNIYWxJNFo4STFXbUdWZ09iYndDdi9iSEpVU21YZmxqcUt2?=
 =?utf-8?B?UmNjNFM1WVJWSE9uSmVaRjZJaEpxSW9OdGJhUU9RVzZnWEQrSU0xWHprZk5B?=
 =?utf-8?B?ZnMrSXhaMFNMTHUxdFM0ZnM0NVFpc2VtdjNkUzJ3cTExUmVyZWJvV294ZUZT?=
 =?utf-8?B?SDRWUUpRdUV5bDBuaHJPQlUvS3ZDbEl5Rk9xRks4aGJTcmk5eExjQkZlellT?=
 =?utf-8?B?S1hRajUxR3VtNkR4UmdmZkFtemc4UmtvVGFFQ3VRYTZ6MXpNNmJ3c3N4Nktt?=
 =?utf-8?B?allwYnhmZW4wMGx1RnQ5N1FGL1ZUempxOFNWZlE4MTdvYjgzTUJBT3hudCs3?=
 =?utf-8?B?enpYUlIrNUkvcXBBUGEyYTl0dUozY2JXMjZrT1kxY25FVnpsNFEyVFJZcWsz?=
 =?utf-8?B?cU5ISEU3QWFxc3IwQzB4c0NJWTlxWGRmMzkyVEt2ZU9zVDByL0c1KzJOMVJ5?=
 =?utf-8?B?emRvTGNRU0RDWWppSTVoTnJGVlA3c0Q4Nk9OdThRUEFzWS84KzZxUWlnY1Ew?=
 =?utf-8?B?N2kvLzJ2QlkySDdKOWsyOCtaK2dGRnMvNEV4TjB3WXdEUWltMktFUG1LcTVt?=
 =?utf-8?B?dUtPSWsrU0kvb2wrNFF1YXFIbzVWQzhpN1B6YVlnQUpRc0hyc1ZRUm9iekJm?=
 =?utf-8?B?dGNOSlpFZDZmSExVUVRwci9RcVJMZndRK3B2N1N4VjVsNnk2K2RBODh1V0Vw?=
 =?utf-8?B?UC9nVUJycnF6eWU0L0JMU2RvejlTdElXRklVcmpGQ2paMmkrRkc0V01BdEZk?=
 =?utf-8?B?Y2FPS0tzRzMyaFBrSFlkMjJzYmRLbFRWVlJqTXF1c3d5UUkyWEpJTWE1Ylp2?=
 =?utf-8?B?M1YxUXFPb3JmZ010OCs0Wmc0d1hLclRCWXF2UWVWMUI2RnRrdWhGbFJmR0JB?=
 =?utf-8?Q?t+XNCQUAMNSt/3imXtBS+uw8e8HASQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWxHUVNQUzNiYzByWTdFUWpnbzhpVWs4QTR3Mi9XbktVRURhMzJGSXh5TTJs?=
 =?utf-8?B?S0p3cGFsSXFaOStIdmZiT1NHK2IyMjZ4UVptK1BBR3lsdHloMHZ3a2s2dFVw?=
 =?utf-8?B?dUNGZEoxL1NReWRNcFVMM3RTeFdhQ3psT3YvWERxSWNVZ2F0TFRCN2tadW5J?=
 =?utf-8?B?TjA5U3lkYVMrancxVndZNGFRYWFwOGpJb01JZmFyUHg2RUd1cnJrS3BIRHhR?=
 =?utf-8?B?NmhUejRrNVB5Y2hHV3FtVHFvUlJZQmpvcHRUK2wwSWVSRGNubkozRHBzdkN4?=
 =?utf-8?B?SE12UVlad1A4VXhlaU9IRHNoTm85blNEREVWc29aeTE3KzFuc0kzY1hlMHBR?=
 =?utf-8?B?TCtJeitGalZJS21sRVJIMXFjOUlZcS9qdk9lOUQ5L1hJZ2ZDTjF3TVprQTFW?=
 =?utf-8?B?LzlPOVAzNnBhTHB3WnY3STYzRDltVUd1ZVExckdaNDdsVUNwUUlvQnRkSWhC?=
 =?utf-8?B?d2ltM3UzRW1qYkFhN1BSQTNLOU9BbFVId21iYk5RMlM0T04vODRpSGYvUlNr?=
 =?utf-8?B?T2F5Q1Bmdi9xQ0pqMlozaUdkVi9Ec1AxTmVqeHRrditFZHozcWt1S0QzUXQ0?=
 =?utf-8?B?U1ZXOWdGeCtNNTEzRkdXSTVxR0t0YTNTaUppcEE2VjJ5VGpBR3ZKUGNrcXdq?=
 =?utf-8?B?Z09aaDZ4V0VsZ25yS24vd2ZNWDY4R3RuK2RUM2VublI4Ry8yVU5KVlo1MlV6?=
 =?utf-8?B?RmZIOTY4NEd0QW84VjJ6SzRRaWxCL25ZUkxUa210MmJHNXpaYXpWeDBhK2JJ?=
 =?utf-8?B?ejdhbFd6TTlZTStkajBwaWpTd2Z3MUM2Zm9TMEFsQlpOWkNjRXUrRGExa2Jm?=
 =?utf-8?B?N2FUVUJneWdLMEhIOWhSbDgyTGJleVhDUkN2akpKTU1SUWljMFBLRThpQWp4?=
 =?utf-8?B?bzlueUdmYTZwMXRCUzRsOU42RXVzQWVCVzVZbDlRUHV0VTUzOSt3aTk5TERp?=
 =?utf-8?B?dVg3VytaM1V2UUV3bHA4b0IrS1lEMnpSTkk0OHdNcVZtMVk2ZVZzMEUvMmlB?=
 =?utf-8?B?MUo1YmpGbkIzRk02czMrenBNdmdZRGE4aVRDYXdoeGpVN2RhSzVMWEphaGVO?=
 =?utf-8?B?bEtzOEY0QnlkN2FMa2pxajlWZFRYQ3ZVeHJVcldBaENLc0Q4RW84Q0lWUkJh?=
 =?utf-8?B?anBzaW91S1l5djVETldiVXhGQy8wR1VvSkJmY09RYWxsSkdJUXBnNWVaNExy?=
 =?utf-8?B?T2FBWXdaRWo1N3FVYXdHczU3a09Cb0lTMytXZzVnNXRZc3BpbWFBNlhralFw?=
 =?utf-8?B?eVFCYjltemxPTTlEYkd6Rkl4amh2VDAvaFNmQVFzRmN0ekhNOUFtSUtmbGlt?=
 =?utf-8?B?c2pKa0xjTHZkMEdibkdLVlNhR3JIdnpSU0w4eE9sUTNiQ3ZZTEkzeWdsM05u?=
 =?utf-8?B?d0pFZ05TckxVQllPS25kMFZJZTZNR3J5Wlp3b2N1aGpNZTJFekNnYjNsTVZH?=
 =?utf-8?B?M2NOUzA2VE5EUHVLNEZqc1Z0QmNZWU9ROVc3UjZLOVAyR2hMMWxYZFFXWE8w?=
 =?utf-8?B?YU8vMHRCUmJvOUhXVU80cml2eVJYcmxyRXVsUng5ZzlDMU1oNFI1RFVvaGFV?=
 =?utf-8?B?YkJrZWd6MnpDWDFFSXZ5SmRwdW1uZ1pISEFCaGpoc3lXK2IzdGpzVURvY0Vy?=
 =?utf-8?B?RHN0ZEVIRG9hcWZmV0FGdGttM1dwSnlKdEtUQ0s5REprSm1jSVJ3czJMV0lB?=
 =?utf-8?B?L09zZnFGZ2Q5bDJiUE1ablZsaDJNVXh5d1k4eW1DNkhWN2dNVHl6MXQxSm4y?=
 =?utf-8?B?aHRtRHQ2NjdmTW4wWG5hbUJHMWpOeUt5MzhtV0llMmtuTDUwTEFhMWU2U1NQ?=
 =?utf-8?B?K2RVNDRVVWFQMXJxWkRSNUZWSVhicStidFZ0U2dsdTBmcWUvRkZEd2VUZmRo?=
 =?utf-8?B?Q2VqdTZaTG0rZ2FWYVJHRER3a3Y0TnJ1TENpUXlSV0UvYjI1Y2dDY1Vic2FU?=
 =?utf-8?B?ZTlndjdxOS9qc1A3a1NlNUFQcDBzcnVkeFB6K2ZzN3VjMkpTRGhENVllNzc2?=
 =?utf-8?B?dWhPRmJlTU5lUERCMTZJM25BVTBXRVFCS1d4V3BTaVlBR1ZWS2p2L2h4TVRQ?=
 =?utf-8?B?S3RKQmpiRkNHOXFFaXJlck9KcSs2QnhGcFFDOHFpeUhzZXlOejZBZjBrMmxo?=
 =?utf-8?Q?CeMzU8Mh4c+XeIZI8kd7VMgIm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2a0d4f-c1b1-4198-3038-08dda7738c9a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:48.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Whl+8i3eQ6c0ngGkAmI04vhId+z5MYSxGqPosys8plvG6KgZPd03w2Ve3n1tnC+EQ/tTMPfzln5/Eda8s66T2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. Call
irq_domain_is_msi_immutable() check if address/data pair immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v18
- update commit message. remove 'include/linux/msi.h' part.

change from v14 to v17
- none

change from  v13 to v14
- bring v10 back

Change from v9 to v10
- new patch
---
 drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 549b55b864d0e..c0e2d806ee658 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 
 	dev_set_msi_domain(dev, dom);
 
+	if (!irq_domain_is_msi_parent(dom))
+		return -EINVAL;
+
+	if (!irq_domain_is_msi_immutable(dom)) {
+		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
+		return -EINVAL;
+	}
+
 	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;

-- 
2.34.1


