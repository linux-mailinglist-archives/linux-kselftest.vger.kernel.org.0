Return-Path: <linux-kselftest+bounces-30755-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 441CDA88B4E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F78189A794
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A962949E6;
	Mon, 14 Apr 2025 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W81TDJKB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012003.outbound.protection.outlook.com [52.101.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198D28F518;
	Mon, 14 Apr 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655548; cv=fail; b=ZzQQpxpqWa2FpwxUzLLcXLJviXCxxhAW1bZl1xkNSxTI7Vv1LR8jrdufvP86cIoYv2+p9AYKCKzmEfSv2p7SVxyfm/dOv/fPSs0eUp0SmcsAIl608jwYiiTUoVD4IN2Nnp1w9oHuFGCPvtSIzSzAdbPfevcmN9pDCZKgsmbRP7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655548; c=relaxed/simple;
	bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Dtlt/kuFaAe3wzPFldI/71dXU7/D7jzDrpQs1dgrPA2SZBT7ena1V46TBld2jO0i3p295N9m0J4BA0MXxZxj0+SC1TKoJDFad8jTs63uknFa2hVXIkXhBvWsBhJolVT+TrSyHyseXtvQpx3Fi2ivLgdbP9I9gaimyYQqozTOpec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W81TDJKB; arc=fail smtp.client-ip=52.101.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY54cp5mFEyMR9cT83dgnPTNM79j2hEAv1Amidj+AUS6Z+4GwV3xdgcZlwGiCl86kQ5Pk3pLm5E8gXCvICY5+bk5rnVkliG0CPq47ktVr5t2ed21izY/qdpp0z/TWl3C1PeJJxBS5NVtVQAwiabuw18EKoS2AIkB7WegXNwTP6TZUarJNVN/zYFf/vDvX86RVYzbvcbzy0uN7jue2RPLgCIK0DMPymLIlG/lb0c2ub+OE+u5ajFjtdYum7jWVlVmZB3bTtmD5BIQS1IG7ffRnYz8z2ToleEdku+JjJqYDkqOxkHWDVnzZpZFDrfwb9MVAgyt2r6eDzOpRUqnreKkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=Cm0OWV5zP42TpTG6moyHX8YWBrJ8azfvYi3/k6//v/svCvfUhEriBNXzV9YGL192rdBH4RWsPKcrv0Rh804Jmyih4mH0pmCuyNmyh1wOnQhydA4hdKtm6auHWwNfhHVU8TIWVwhihSkfgCGaaw8+xt31PM38iF3bMaJtw/OFh6zlBykjt02d20ownRmQL31I4z8VBSJflqbJi1Ng2PysXYuHwTLQ6zIsdxs5RBLNsxl9MK7iW8hFUHFt6JOiVcp/Vj81LcXbboIznA8KjCpsNBivG7BdVVonrpq2Q+Zh5/8a8RLpnzNGGkTjE+vKHyFBv8hBthG+x9CisiBxMQcvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=W81TDJKBgVzdlxIX8babS1AZw4kuueV65fN8Eyb94Rk1HfKWtJc9eZRwa9PVfStSSfqdFRvPT3SGhr2XXmuM9IRRUE2ufCzFuj5UUiNjB4Zosr3+H9AXHVzmjc0MgBKiuTp0m4aOoQwuPgcHZqx08MTxuEE1X9Q8I7o2Deicb9DS3IWFx57oP+7ExG619E92aa5K3V1bStO56svFWJZB/7gzUPFDktUrbacSaPpN082JNhGnWabFDP5Sjm0Yy8pc86NFGOkDZ2jxH1c13/bCxeB6cM1GojsiBcUC9xUtIAoevsip6YHPOHffcguHGrJ0qsV3ZCyp3VD8DD3IcYEcUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:23 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:05 -0400
Subject: [PATCH v18 11/15] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-11-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=6407;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
 b=3oM3ZicDSjq1fM5V+zNEEqoxvMCosTgFqPYXLw8Oc4ysynjGxwUgD9oWMvDBPIoZCp3CotdUF
 L3gta7UCD9QASlDW/c1Mue8O87sJ5zljSyBiAEZ/Hpufmm9INwaBHtq
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
X-MS-Office365-Filtering-Correlation-Id: 1dcb41bf-876a-41f8-f9de-08dd7b82b2cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VnBXUHVrZ29kZ1lxcEUyMVpMVHZiL0VCMjZSYnYwMWgxMHowZ3N4N1gxWDNB?=
 =?utf-8?B?SnZOZVUyQXpjVnVwZUVKYUw5dlZCYmF0Q1grMlFNME13ZnBCeC9PN2RRZDJN?=
 =?utf-8?B?b0t2Rm9QYXhidDJicmlGZzViNzYrQUl1UnMxSzVxendrcUlseVZQTjU5M2J3?=
 =?utf-8?B?ZDN3blcvb21sSE10K0lHbjhFTEd4MjM0bDg3aVJYaVdHa05YenF0NWFvd0hl?=
 =?utf-8?B?USt3T0szZmU1WjFVc1g2d3VRcFZvSWlOSndQME9TQVJkTGNaWUF6aXJYaWdL?=
 =?utf-8?B?VTEwY2pIamp0MmNpNG1TeXp6YVp5VDg3N21yeThkcll6MEltYzd4N3loUFJO?=
 =?utf-8?B?UjlScVkxNGp5ME9ZRzVMRU02anNHV0ZCR3NhakVZTzZzRVlVY1ZveE5oOGs4?=
 =?utf-8?B?V25QQW8vSVRhdEVoNTdMWk1JWVVwWTdmMTdxSisyZzNCZ1p1VmpvNVA1Tm8w?=
 =?utf-8?B?YVc0OWFxMmhWMUh4RDMxWms5Y0NUeXBvSVR0V0ZMazFtYyttNVhMNThEVUI3?=
 =?utf-8?B?U0trWXZTZThBMWJkQytyU0NCNGMxTUprSHRXSGNRMFIydW84TXM5NXN1cXpj?=
 =?utf-8?B?aWlBSE9zN3lpSWdiM2lHT2RxNGxnU3lQWGU0N0tsSU04QjRDYkZOS0ZGTVVu?=
 =?utf-8?B?ak9hZHlIVmZPQTFSU0JwdFBlN1VHUk5JVUVDREZkeFoyZFJ5eHhVUVdtYXp2?=
 =?utf-8?B?dDNzTUh5TUhRd0FwNi9Xb2cwUTNXSDFoS2h3M29PWFpCc1Z6R0N0SzZWdnBv?=
 =?utf-8?B?WjJEcjA2SXc2aSsyTkFkUzJrSXdTN3NNZEJDQVloQk5yTW83a0JxaDVuV2Qz?=
 =?utf-8?B?QktYUWVCSWlveEp5NnVZanRyYU9PZDZjTTFuN1NPNTRudnNnUHMzUFNCbXZZ?=
 =?utf-8?B?aFlXK0paKzVlUXA5N0xaNTdMdkJ5ZmlpVnlYc1ZOSHNHSGpLSS82OElLVW1p?=
 =?utf-8?B?eGE3TEhOam84dDZrcFVUSDFLQ2UzdFA5ZkJFVmpqT0F0NVh3QmxveFdoY3pz?=
 =?utf-8?B?UXkzS051SURXemhhMFZmMlUvaW1saW50UWJIN0pkQ09QbVFha212WmZ4d0ow?=
 =?utf-8?B?eWl3SUM1eE9CMHIvWXZDZHZPMEgvZDA2bHZMTGZsRkxHMmFXNGdpU25MeEpP?=
 =?utf-8?B?QTd5YldmMmRVazVvNldKclg4bVFTdkFFQk5xeGMrSVJHSTNQTWlLWTk1MWlM?=
 =?utf-8?B?bkVEVFN0Z1BOSHBDUUMySW9UZklLRlJPSlp0MXRMdTZiMnNNbjhzZC9hTXJh?=
 =?utf-8?B?NENHeEtVelBJS0hrRG54TmUyb0xqcXdWS2JYbkVPYzh2YU5VQ0w5dEF2VDRa?=
 =?utf-8?B?ZG1BZGd6K01KamhoOTRjZ2Ryd1ZZQjAzR3o5aDI4Q3dTKzJvaFdqL2pKODdO?=
 =?utf-8?B?Mm9rUHZ5WUFCSVN1NWxxVzlZTlBmbGM3OTZBZnFiOWlXVTB2QTNhQmpoanVa?=
 =?utf-8?B?WmMwbXppQ2pGU0VuY1FJRC84OEpzeHdzWnBOMjZwaTJKNW54dUxRMGdBR1VL?=
 =?utf-8?B?QjAwMEY1RHlsaWxYRlVMSzY1NktsejYvQU5HY0lGbDQwOFRsYlVqRGFKWENN?=
 =?utf-8?B?eHY1VHdFQ2ZpT1Awcnd0NzUzSmQyMTkwd3VZSThnMnd6YXVaTnlueTBrUC9O?=
 =?utf-8?B?SUMxSjZBaHAwRUVtWG5IVVpRS0JrTEVyaTIxTUFwVWwrL3M0WVZQUHNFSzl4?=
 =?utf-8?B?bG5abTFzb0NOYVQrUlZJWXl6Qi94cWlnN2xTSG55RG0wbDZKNVFoR2I4QzRn?=
 =?utf-8?B?eWRiZjJWZ0R5ZEhBdHcxNktJV0kyRFZpNDRWSkZIZnQ2NkNNU09DcXRSQThL?=
 =?utf-8?B?R2ZGaVFLcmFIWi95YjBNSElqMlU1dVlzQ3ozand6YWFTaWdmSERjYnIveWVq?=
 =?utf-8?B?U3ptTDJMMGo3bmo0NDg1WkxJZDd4UWt6SVh4ck1RdDkxSy9VYlArMkZlMS8v?=
 =?utf-8?B?UzNOSUU3cUZldW5DSzVqK0Vlb2R5R0VkRTNDYVBsTDFlcHN2QklQYmkrVU5a?=
 =?utf-8?Q?KIx2JjsvqBudjQd1nRAs4fzSXYWdBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1NoK2JBV3NqOVFjdE9BRHl6Smkzei92SnZSRUlYSkFqcngzaGpLYUJWMXdr?=
 =?utf-8?B?SDdubTRPM2J0MHUwVU9jZzR2MWV5L05jdjVUb2RnbkQwSE1rc2h0bUVFcGN4?=
 =?utf-8?B?VDVHaXdBekp2MUVPNEtIR1JHMytyQUZ2WU5uVWtkWERxS1dyZmt6R3FKWVpF?=
 =?utf-8?B?OUlLRDkra1VPa2orT3ZEMHFsSUFPS3ZPTHFvMnVoMFFicnYzNmZlVUE4enVL?=
 =?utf-8?B?SDhwZmFXU2dMV1dqTzFHWWZvN2hYbXpONkQ3T0EvSVRWZ29zemhDNlJRSE1p?=
 =?utf-8?B?dVpUd05BNDRxTUQ2d3hXaFRCU3l2Wlo0MkdFTVppVGxyQmlONFpBRVQwQ1pC?=
 =?utf-8?B?T0ZWYVZ4QjExVXFGNWY3a3haODV5NC81bXdvNkUwZWJFNFlSbEVDQ1BDbVN5?=
 =?utf-8?B?V09iZXA3VkdiWXpvaHhtcmFMcEF6NjVwc2tHRVRUZ2RwajNoTGxVQWowZFAw?=
 =?utf-8?B?YzAreU9vRzg5cWpIMUd2UzBQZmo5YW02eUxBaHl3bk1uWnJZM213Ty9USHd5?=
 =?utf-8?B?WC9nM0V3eFJhVXV2QU9qNVFIODNoRjJYK2VtV29yaG5ZZmhZSW5KR2FxK2ky?=
 =?utf-8?B?L1hsdkFVcDdVMlgyZ21oazdoR01sOVRRRnhGUEs0MkRCUE9QREw3UHhuY2t5?=
 =?utf-8?B?TENyalBGQlRCalB3UXNzQU5mL1dCTDVrTVgyZE9KK3plQW4zeHY3TmkvOXFE?=
 =?utf-8?B?b29Iblh0UDk4dUFucDFYbXdkT21KaG05T0ZBM0hmQjRvWU5URTdHaGxoVytq?=
 =?utf-8?B?czkvZWM2Sm1acFFpc1lQMlprc1BYVU9UU2RMRmliSGU1d1lQaStEZkRvL3I2?=
 =?utf-8?B?MTg0aWQ1VFlRcGpjWWVvUW5UeXZ3QmgxSnV6Vi9DdkR6T0xqTWYyeThES2xy?=
 =?utf-8?B?c2oydGsrWmFtNjZMc2JRSXBGNEtxRUo3WUtxeWZBbkJCbVNoYWpaT2thTHF0?=
 =?utf-8?B?ZElXRGFmaWVGTXJCTW9XVmc0d0IyY3pOemFIdENCL3M4RVFNU3FGdkRKY2Zn?=
 =?utf-8?B?ejArWDVPNDVpK1A3T1JNUnVSMDV6VzEwbnV6NFlqRzY5dThIUm9JaTNIUmVO?=
 =?utf-8?B?b3dIeXFIL3kyaVZ3US9FWXRraXIvMEZueEFCY3Z6RnlObXNJa1pFcEdTUXFT?=
 =?utf-8?B?YjlQRDB1Tlg5M3FRYW9NY08xVnd2RFpiSnJQQTRrYyt4dGNHakp4L05jQ0Ru?=
 =?utf-8?B?d3ZoeGRtYmtWRTdEWWlvZTgyWjJUVkJ5a3p1dFBXeVFrUjhXMitXVHE2V09Z?=
 =?utf-8?B?OEVjOFJ5ajlaVzRWWkh2RTJ3NDF4OEUza1loY0hpeTBKVHNMS291WXZyK2d5?=
 =?utf-8?B?N2FNTW1laU5qQjBwQm9BTWg2YWU4S0ZpcEluTUFjRElMQ2p2YWZ6L3ptNExU?=
 =?utf-8?B?blZXUmNjKzdCOGtQR3BjRnQyNkxjU1lDd2FpVzIrNnFPU29LbHN6M2tpNjFT?=
 =?utf-8?B?VStmWTZSL0E1eFRodXlQeThPeDUrUEdQZmh4RzNubHUxeEVxaWlrWlhqRU41?=
 =?utf-8?B?VXIzZlBaRWU4Rk5GemRtOGV4OUc0NWFHcFVHMWZWYmlkVkZHa0NpZS9wdkEr?=
 =?utf-8?B?bW5ka2lWWUlnZ21odmtiT25PdU1sdXlsTUNZUU9zL3A3Z0dSdzVrdjZFbHZi?=
 =?utf-8?B?VmtVYlBzWE9FWDZmWiszUm9TVnU4dWZaMkxPVlFzSG5PWndSZzMraWU3M0Iy?=
 =?utf-8?B?dXlaUGpKeEtXSG0wa0lvVDRqYllDK1JIaHl3NlBoQmtjK1VJeXU3Qk5KOXFL?=
 =?utf-8?B?dXZabHZ5Yng5d1QyLzNIczY4L0xzS0xWNDNIN3VKWE5YcVdJNHdhK0tqakt1?=
 =?utf-8?B?SGVqTXYvZlE5TVZpSTdqN1VLL2FoeXJJcENxU0dmaFMvWmlUNDB4THRnTDFq?=
 =?utf-8?B?ZXphbUhVWkRHSm1RMTZYc3lsVzJVZW9YL0UrSCtGSWJqVThZVy9qbzVvcjBP?=
 =?utf-8?B?alkxUXFiaFV2bG1uNVZSWGFWaktuS3IxSU1DTHlSbXhnTnQ2RmE0Y3h6blds?=
 =?utf-8?B?YzRMd2gvTWY1VmpVQmJ3aEFXYngyTEpOazJQZVF2bnlEdE1NMStYVXNQWXA3?=
 =?utf-8?B?NVJMWUNqYnI3bUJ4dktPNUpWY1kwUzRyVEZPTHNSckJHR2tRZFIzeTgwNXlT?=
 =?utf-8?Q?z4N4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcb41bf-876a-41f8-f9de-08dd7b82b2cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:23.3826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg2anMZeRCxpgn2lTcP2CiIMz7YAR0j3Jiv6YMLROe8X+dY2rr/c/1IHMWT0mgCXKAMQSuMbWnqUdKdaJIXcqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

Change from v13 to v14
- update to use pci_endpoint_test -f pcie_ep_doorbell
- change ioctrl id to fix conflict

Change from v9 to v13
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 82 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c4e5e2c977be2..0f3af7adea107 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -37,6 +37,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -48,6 +50,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -62,6 +69,7 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
@@ -70,6 +78,10 @@
 #define CAP_MSIX				BIT(2)
 #define CAP_INTX				BIT(3)
 
+#define PCI_ENDPOINT_TEST_DB_BAR		0x34
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
+#define PCI_ENDPOINT_TEST_DB_DATA		0x3c
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -100,6 +112,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -841,6 +854,72 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return 0;
 }
 
+static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return -EINVAL;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return -EINVAL;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return -EINVAL;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return -EINVAL;
+
+	return 0;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -891,6 +970,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d3aa8715a525e..d6023a45a9d03 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_BARS		_IO('P', 0xa)
+#define PCITEST_DOORBELL	_IO('P', 0xb)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_IRQ_TYPE_UNDEFINED	-1

-- 
2.34.1


