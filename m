Return-Path: <linux-kselftest+bounces-26409-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21619A314F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E7A216707D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9350126389B;
	Tue, 11 Feb 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c+k/ebEE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB6261369;
	Tue, 11 Feb 2025 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301739; cv=fail; b=sBPSM/xIjANQCtjIL1pBdMlgfq/BQgfSQafn/3yNIllhODEnMP2yYaLEun4plia7WGxilW4oY1bKxTtUS2gq5rsA1fpW4L75kTpXZrubCdmbM4aMG3Gt3C70tWlMzwhs2Rkvx6O/FlQ8jOf8VVUtTum0IQs+CEj/NkupWh1vWwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301739; c=relaxed/simple;
	bh=J7HfnSyU8azP0i+o1RPxj1D0gtVxDW0e9yd4XZUBqzc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=UuaXH2yjQDz8w2zlSG649syM9H/RWvIvFb3S7pbBGhBW4C0Dqa4cVNy3em7U6ZatwOLUJ7fZTTFXS2E4pXDoCcuwqtEOZxRAQicU5HplFQGEvLbZYKy3uiUn/ucmwZY8EbpBewlKodNstrTWH0+NvR7H23tUqszwyVqbQO2bhqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c+k/ebEE; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMMcGvxXfw8/Si//AZjt6RqYag1Gdk+qa7fHABvbM30K+MC87zjKzRm+P2sf+LETFccLImhxwMSCo8K1FXgePClkTjJrSGVRZowClg7qPpkbRwQ+d+SWJWhvfOoT0qgGyDdwb26FaKVERKlDTApb1C4aTm/L7RAXz9TjQViZfN5d0dyIiLDtlgBE8YPz6PSywG7oKQvVuBOj3Ej6/Alpt2j9/+2SV4mBvBISPXkpQefaWgCdH70l/ID1Q3w0Df2hDmKfHbI3/to9DuVlGhMuJgzoNQBcf/vx4WnOYOa6OuZQSCb8iMyXm2+S9Bm0E53B0fXsNDXGkfhfuhYoNyxfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvCn+Ggv3GXEmXTt486rBCKpXSrSq6d1Imq3HVo70dI=;
 b=Cif2o0BhLf8W+ol914fykbmsYLJkHmpS3Jr2L8X/yZ8X38mx4oa6ChadyaqifHH05ltExihuqHJRGpNhdv6YXuLDfIUEFfhBuLZlDYSovwM9DC6sbPOrtPC0j1vaeJgRx6n4y8tT6oKrlJXwQEpDRas9ib9PP57sp3KA1KGRb3fEcuVg/iRnWgTO9ylA5UrfJD8DaSqvOdXDcBviSj2AZ5RBDDYmgSO8m9O4pyOey1rKYBhb+9QDojj2fo5u1cPkNCA92N93K3f5fyHSJIhszrWMoA5+xA5TCtyVDRZuQQ9SgtFqDOVZQuLP3z0AvFBpWs61rbu1af3DrwUqtF4hAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvCn+Ggv3GXEmXTt486rBCKpXSrSq6d1Imq3HVo70dI=;
 b=c+k/ebEEwEdDfinNQhkyJsA/HFvvBPM3u9Wrr8uPwduFz3WhcVC3Qub+INT0XTIOln1whtgAf44WioSHfw8PnBt0FvL+PgPJawLxRXuP8uKbSGlTpzDWEo6h2mIx0ezFALc4i1CP/isCoxnVghZqz6V4nLcLHrWLo/Rlx+WHN1LuEbcUCX5NpNPbfRHWLt5zET+RpstI/VfDovddwCpUyEIwDA6T9d8pdanyU8Ukp+RtSh7TA7gzrx7bMWPAt3apV1leMBNr1w2yhx5EAmjVbmL+RZbvwnrxn+ENXwbcr9rj+rpG0S5UgnOtmkNiEPRJ6JGxFW76IquiFjJh5/h4pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v15 00/15] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Tue, 11 Feb 2025 14:21:53 -0500
Message-Id: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFKjq2cC/13SyWrDMBAG4FcJPldlFq099T1KD1obH7JgF5MS8
 u6VA7FlH0fo+xlp5t6Neejz2H0c7t2Qp37sL+daoHo7dPHozz9Z9KkedAQkERBEvorT2AsbZPS
 BOWDIXb18HXLpb8+kr+9aH/vx9zL8PYMnnk9fEeoVMbEAEXOK1nnUEf3n+XZ9j5dTNwdMskGMC
 5IVGTTJU3IukN0itSIEuyBVkUfpFEZIAGaLdIOQFqQrkqo4Q5Q50q490yK5IFNRkj4a70tIFLf
 ItkgvyFakCxZtS0kYwha5FRHwgtz8Jg0pRC6oUtoihFat/dUJgrAmsrFVJr1n2DK3Mpy/XbIs3
 rIzYc+oYbgOq/4mCOYkFVPximDHuGXruHDeDC11JnSUIskdW1ZDAYFZ2bwbThsMyLpQaHbj8Xj
 8AzKhufXsAgAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=10831;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=J7HfnSyU8azP0i+o1RPxj1D0gtVxDW0e9yd4XZUBqzc=;
 b=v08axDfA61CNKB9TW3Pu1KNJpoBAVNk9T9wswCmj/X7ojrStvBirh7YuMbs20k8chFe+zjSTn
 sqwQhVxocD9D+rJWpFcvIHKvtFy5fZiadcRCvdYy5Qvn1hr3srCsfMq
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a287d55-44ab-4763-dce7-08dd4ad16243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2lPWEgyc01ETWlzWEZmcDVSTk5hTmNXWE54Uklka0tTeUQ3YVZyWmpCWW1O?=
 =?utf-8?B?Vzd2TTVXanBXa0Mrd3NGM0s4MzJ4QWFsYm9aL1p3NVFENjJSYW1uKzgvZFJB?=
 =?utf-8?B?TStmNDlPaTZQVE84SkdRYy9hcnd3dVNxVEtHdE82V1Q5R3NaaWRLa2RXcjRt?=
 =?utf-8?B?VFlCWGh3blMyNzVRWHlpcW5mOGJFc3RXbXJqbEdHMXZ2RjhONmZoZmZCT2po?=
 =?utf-8?B?Yi9kRnVhQVBkZjM3YmhZWVBqdDllaUxDMElOYXAvLzdoSDZiQStrTnBOSEgw?=
 =?utf-8?B?TUFYeS9UcE9ONk90UHhFMjRlK21GdTBwdmw1NFFGNVFrZVp6a1ZjVVp3Zlox?=
 =?utf-8?B?a0k1UUxmMVNIUWViaHJ0OTFEN0dxbkpJMW1Ga2NtWWVhL0RLZ3FISkduTHBY?=
 =?utf-8?B?ODh6UXBIUkt1UVV5R0M0dXZybHUrRm1GQkFKSkV3RERHay9xYysyQmk4YThW?=
 =?utf-8?B?czdlV2Q0RVVLd1Y3MjFER0NSaURTOEI2NGlkdWxEekZBajhIUTRVTVkxU2Jw?=
 =?utf-8?B?d0JGUXdNRHQzeGR0TUkyUDZGWGN1Q3QvczIrS2hOU1d0bklkMTZPVEhkeG5X?=
 =?utf-8?B?Wk5JMFFHZzFaQ1dZYjNlOTZySk1SVklzZVV2djJoeG0vQ2tzalZNeW5ldDZz?=
 =?utf-8?B?TkNXZ3BvVStQcVhOZWsrZlhwZzFnREZXdkdFeVRHV3gzRlE4RWhpeEhiMGFH?=
 =?utf-8?B?K29QTVhlTTBBZjJmY3ZkTnlQVTZPbWMwNHRNSFMyMjVPNUJiZE9la0xsd3dp?=
 =?utf-8?B?ZEtHc1d1b0hMSVk2azkxcnRBbVlTNmI2dERqNG1SUXE3d2FEWDlpUGtJUmh5?=
 =?utf-8?B?eTNvbzJRZENzVVRYQmZLbXNTc0dwaS9ud3hNYWRDWHJnZDFxN1I4cjBuRWhN?=
 =?utf-8?B?MVBrOGNTbU5VRFVNYXREYzNjYnJjMW1IbDFlZVFUVUE4SjV5cnhtS2VDV2Np?=
 =?utf-8?B?dStxTEd3OUlQTzZONnlETmVKMENNaUVhQkRNUmFrMGxHU0hEL01LNWs2TEc4?=
 =?utf-8?B?a2sxNFh2eEQwWVg1Wms0V2N3MXFvRkxGNVIwZjdQaHYwdDYwS05hT0d5Ykcr?=
 =?utf-8?B?b2RyN1ZuZ0NiZy9TWEVibVhHS3dnT3RlQ1VYb1A3LzZaUWZHb0tZTlZMQ2Rh?=
 =?utf-8?B?NXMrVll2anYrcHJsYy9NamRKWmRYZFNEcEUrb29tdVhYTzJ6THNEcDhBd3Rz?=
 =?utf-8?B?YWNCT0hQdGVuQ3VuYWo5bGJrTmlKbWlxWTN4NlNLRUthL3hZU0t1czJiOGdo?=
 =?utf-8?B?NTlxb0REaTR5UG1UZFZDQWw0blFFQSszWVF5ci9YK3gxaGMvbFpNVHhkcnkr?=
 =?utf-8?B?TUEwL3ozbGxoN3ZMNXphYmJGdDZwSW5OcXp1NXhJOUx4SGdBK3B1dlBiWFV5?=
 =?utf-8?B?Rm9CVmlzeUNBS1U1MHIwWmRxR2lvQmtRRXdxYkx0V3pkYklpYU9uZ1U3Tk9H?=
 =?utf-8?B?WGVWeWZ1RnovR1Vtb3MrdFd4WW1URWJxemxiVTI5dHlCMFZmRlhJS0xEdlFV?=
 =?utf-8?B?alE1UzFFWFl3Y25uckE3eU1qVitLSEU4UGRJQ0JKWGpBei9uMFhnWVBvYjdU?=
 =?utf-8?B?RHlOR1VSWkF1MnBkdjBPdFV6T2dRcm5BR1lYb3RxM0dWR1lhTjlZT0M5WmQ3?=
 =?utf-8?B?VlpRL0h2V0xHdVd1RnJkWlByd2FxcWlDLzZiVnF5ZDQvL3llaXRncE5sSlJ1?=
 =?utf-8?B?TXdOakRoTGJvRDBJQWJzaWRJVjh3a1ZrdXpBakhDTE8vWEFnSTRNZUVsd1NU?=
 =?utf-8?B?dWVFRGppbCtybnVxekxlMmNmNmZJOHhVc1d0UmdpY2hHNzdLUDdJRmF3cC9R?=
 =?utf-8?B?anFGOUJtYVVUMTd5N0Uva21RZlhMUVRGNkphMXYxRUdpcU5XenBUUkhUWStE?=
 =?utf-8?B?akJ5czZYNkVQOHk5bkFMRzlET1pGQzRMZkJGdnBiSXdjS0Y0N0tvTDZqZnFq?=
 =?utf-8?B?TE9xbjhRUDRVejd5WHJQeFEzVWk5a0FaaFdwWlN6enp1eUhsbXJlYTIzSnM4?=
 =?utf-8?B?V1lVMnJMbG9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czJCbFAydzlSZnQzVmpKNkV6bHgyaFNnWVFwS2RPYVlqdmhSM0xweGdBZUVS?=
 =?utf-8?B?WkxjTS9ZMzNBWk5qUGJxeTREVzZYQlVBNUI2OVliUnZoY05iZ0ZQNSt4UFZ1?=
 =?utf-8?B?blcrKzRSaHowUXcvS1RRcUk4c0hRS0JGNVRhVkUxZWNGT21PMmxaVjl4d1dJ?=
 =?utf-8?B?UWVNWm1UU3R0cU9vTElTZVN1QkxrU25UVmdnYk5rd2FBTVBEMnhLSmR3TlNL?=
 =?utf-8?B?YS9oOFpkMFV5bHVpdFQ2dWZvY2t3aHhUZjBiUHE1YzdueUQxUjl0RzEvWEpj?=
 =?utf-8?B?R2lVQ2EvNi90UzVpRVlqakZGRXBXZjhuVFM0anM2ZW5pVFkrcFNab3dkSUlj?=
 =?utf-8?B?NkU2blYvVWtNKzA2NGFXMHd0aUtFUmk1TUVUNDE5TDUza3FpS1pra2Rvakkz?=
 =?utf-8?B?NDI3YlcyTmltQS9BU2JFTUN0Q2xkc0N1K0cxWFVhRVN3ZVBRY0JiWVJLL3F2?=
 =?utf-8?B?V2FOZ0NDK1NBaXBvVzN0aUdIbXJITzhWdFhSRVJmTno3ZW9tM2h0ZXlvSFpj?=
 =?utf-8?B?eS9uNjRmYWt1dlZjQ3lHZjJEYWdVeHBrSEg4OEdxTS9kcWU1SFQ3U1k4UGh3?=
 =?utf-8?B?ODUyUVVqSDVVblBsYnV2bXJvUGh2QU5rWVFjOXZHVlFNVWRGVWNGUUFubzZY?=
 =?utf-8?B?SlhkQXExK243SXFwZ1FZVTgxd1EybDJqTjRYdXFHWkJTbXBCNW51WkY4NEdt?=
 =?utf-8?B?cTl2cTBjS0Qzdk1BTkFJMXhXbkp2eFhUamJvS3p4a3E4UWlnbW1hdmFyT3pw?=
 =?utf-8?B?K0k0ZnVyT1NJbGRWVE1iRXNGYkhmczJlbFJ4cW0rcHBjamwxRm43U2JSSVhD?=
 =?utf-8?B?Qm0rUVovcW93aTNmRFdpd2g0dGZMMHdodUhQcElna2xkYTltWXlrT0JNKzh6?=
 =?utf-8?B?L1pqRXIxZk5zMlZpQnVjOGZuODh6ckRnSGxhUjNiZWNFRmNMWlpnTnNWRHNJ?=
 =?utf-8?B?eEVOZEdTU2dxcGxyM2MwcHRCTFR2OHpJSFFpcjNlZnlyb2s0YmJMcWo0bHRJ?=
 =?utf-8?B?eXJKdE9GU3ZaUkh1N3RjaFVJc3ZtbUdyQUQwTGp6VEhQMnk3R24rT3NSTlRk?=
 =?utf-8?B?ODI5YVRXSW9Va0hLTEJDS3orYjZ3OGViZTI4M056ejNjQW1IbW9FT2ttNE1D?=
 =?utf-8?B?enZSRk5tTFkxZDh3am9BTktOVldaU2VlRTJtcVJqRTFWVWUrMUZwbjRDN0Jt?=
 =?utf-8?B?RDU3NE5xSlhCbXhueTQrazJ4K2xrWEhmT3lhTE5jSENKMkNKenhwdVNjeFlZ?=
 =?utf-8?B?ekdtU1o4WTlJTmtTc0lJb1EzaW1aWnloeEYreEpkRjhyMFowdTFseWVPYnJ6?=
 =?utf-8?B?b3FVb0J3dk1wQ0ZScnZrRmcyNGtvQkNoRDNENjBIYjRLZ3VUNUxHRjJ4dktr?=
 =?utf-8?B?ai9yOTlLWDVoWWlaUEwzcUtkbzM1UVMycGl4N1M1TWY5aWpMRUltQnd0ZHU5?=
 =?utf-8?B?cm9iNW9OeVZ0aFBmMDRFTU0yUHgwci9sWWdZMXJPR2ZoRkhyQVZxeG1iSHBu?=
 =?utf-8?B?K1N2ajQwWXhSUW0wRU1HcVVMalhTY2pNaG1zdFFISkxtQTJVRmVtSzBzVHR4?=
 =?utf-8?B?ZEMzRGplL3BXYVQxbzRVekN2NHpqRC9sU0ZqNHBPdUJueVkzVVdRU1RVSEdU?=
 =?utf-8?B?TmZvbHBKbkdLaGxPcjRBeG5tSWxWOVFBUzNrLzgzUkFnejJNVmpqU0lkYkEx?=
 =?utf-8?B?d3BRYUpwQmdaLzB3d2pxZXVKNlNyODZqbHhYSTk2Sm9UMTV6SDAzOFpKYlNu?=
 =?utf-8?B?OExra2psSERpQmJNWnd6NnFUVHE3UGZBb043enNtVnZ4TnUxaGVSR3pHYUhh?=
 =?utf-8?B?SnFaTnRna0Q3WlVDeEZpakIwY3AwWDQ3b0o3bzF6ek1PaUd2OTh5ZExxWm95?=
 =?utf-8?B?NCtCbnE0STY2Z0duUW9SdmZuNFBURHdDY1VlbHRNam5rZU5UT05NMUVtdFVJ?=
 =?utf-8?B?TlcxUWhwaXdqMTk5ZHIwMjB1ZEJPUDNqdnBkTEJZU3Q4aFN6a0hwaHhwaUhM?=
 =?utf-8?B?QW1sUFpIUVNXWU9QMHU4SFVnYUtRakkyemd6K0U3Q0VDYkVWVjh1OG9Ya0VZ?=
 =?utf-8?B?b1l0VjMwbE1ZUENkMDErNzJreC9UT1Q0WFlCTXJLT1N1ZG5sT3B0VWRvbTVo?=
 =?utf-8?Q?IrfwS4+Pt8CIUddP/ZQ9DxxCK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a287d55-44ab-4763-dce7-08dd4ad16243
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:11.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJrRtJUb0nbwCFqll6VuB0X/T2BsdGtysPBpdknwOCdEwiHo+qHsRrI2amQFlMtWFIrt0Jw4jkgcLoACat/Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

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
      arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file

 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../dts/freescale/imx95-19x19-evk-pcie1-ep.dtso    |  21 ++++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  81 +++++++++++++
 drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 132 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c                  |  90 ++++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  48 ++++++++
 include/linux/irqdomain.h                          |   7 ++
 include/linux/pci-ep-msi.h                         |  28 +++++
 include/linux/pci-epf.h                            |  21 ++++
 include/uapi/linux/pcitest.h                       |   1 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  25 ++++
 17 files changed, 486 insertions(+), 9 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


