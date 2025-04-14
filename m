Return-Path: <linux-kselftest+bounces-30757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDFFA88B55
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F56189A8D8
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC99294A1A;
	Mon, 14 Apr 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O55pMEq0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A954228F509;
	Mon, 14 Apr 2025 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655563; cv=fail; b=QqmHzmJWh2tOLDJsXofVvWFuC7tK8K95AnK2NDBs7Ey0wxMeW3tTbiKrRIZSdSzzGo8/3/MUuoi7ZP24y7PTgRbTJ90ujJjSmpCa82ySZZlCeVpAKJ6TBNNDsVdAJ5+13FwuSnYVMBiYU0aP5XOAX/xPuURQWgHJb/8fw039L10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655563; c=relaxed/simple;
	bh=E/+49PZzSike5Srwi1bFi+VTiZ02VK7QUYMJGqtvfmU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CAS2owUa5RvycEh4ZGkqp6GGFkPb2r5YtNrPGEO6iJ3fOx0HIKkg/7EO+aFwsyXFfA1JdggCPtbNSqMfZfF77PmFRXav5dit/PaFMns2lUxaF83Gd2qfsEdaVC/WoXgSJy4rvcUuXZ0cWk2eJR0iVVhpd5JNb1lbviGpUB/D8zI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O55pMEq0; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjUG2bHJDbLzIBgVThn8h1YM1feYbd+73QJeQg7RsepJfuOkTtK0JXp+0ztonVBxjlKYVJ0qXQw/34l/Qg6mz51zlAtZAmNsBFN7Y82/5p+x963vgNNqbUMsarO3x+4rmT5YgVp4VMA+HlrUG5mtHknXYPhNL0KwDBVyefV+3l1n+qGJm6R1BN0T9R4ZZqAae2pnEGgKgnrpZS3kwUER/iO6DRALeS/gj3nxOPLiGHRdm4D0tVutUFyOnV0Fw5WyB/SHqVawPL2BvJChu41C3yYdXZ7mW6QUXaP/BTJUAn1ZsrkE3BM/WmImee8ER/KPgHoEXFFHHVPX9bZ1y+C+LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Uw8VyfQPkoGAJ9vh4Z/t75FAVRHjabfWtBpwRAHpq0=;
 b=jv5RjJiT17XUzmoy7JWhx88PTdFYf8rAj2thTCuSwsEGfrJkEOBAk1eQM3Gv9fmWyhdTAQpwkHMhNjsm6t4uzUpKujqaamiQziwnEq7AhrTfTW446EDjOaCpnaLZUO+D83kztdYPN2x080hxUhxxNrL4zdWx1iOJvBOxuTlKZ44VXvcqnMTqgo0zfknIFD5fTF9Txss3vvESqGuvf024nZuUE/cz51ekV5wfyCRglGvFx1/OTiv1TKo6DMJufF/5lQRUY6eKSVK9rx6jTU6bqj28RFKG34Aik8FfL2g45aObq/vLAYxBIIvBuLz7cBLIhqA25CKE67nrbifw7ZJvgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Uw8VyfQPkoGAJ9vh4Z/t75FAVRHjabfWtBpwRAHpq0=;
 b=O55pMEq0shoJ5ObABAhEHwjoRK1pKNOKUwh6qnGeerzFTGJg6SSefSWjhXjdJA493n/Ts68rIHHgslPDHTEDL43mihYrS5zgcXTze/I27KZhV1ins1v0RxKdSUwi98pFdyVPFvehwcqJoYbbvvLs7WXn3n2k4565T/5hhkb+ng8V2lnlDNBYJ+XxnjY3cLYQfs63xZ88fvOo2HhkUsuJ1/NBfnd1zmh2cM3xQn7PtvLwXKKNp1HS3+WQ3gKaPVgX0TvjjEGxxkgL8HqHoY3plBFpwDCQ6EEGoCm1EvXJEJsvo2vzF0YTF4/EwUToTEStjw7xVRxU0bO4FW4o91wJTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:07 -0400
Subject: [PATCH v18 13/15] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-13-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1816;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=E/+49PZzSike5Srwi1bFi+VTiZ02VK7QUYMJGqtvfmU=;
 b=rC6rKjv1mazcvsk0eTe9Dinhuwq/5ME+KshqrH42IOh/pdPHQjD/XQo00jBATNrJ9wz4Xjfx1
 wBE2EC0ad8fBpoSYC3dLBRVwA5PqRyzIx1NczTrTOlwpTyTc35EUJap
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
X-MS-Office365-Filtering-Correlation-Id: 26abeedd-65a0-46a2-db46-08dd7b82bb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QkhvVk1ienVCVFFnSWE2MHM2NUtmOG9WYktFcjdCNTFhejlMSExQelQ3TVgv?=
 =?utf-8?B?UnlSUlRnZTd6L0VMUHlyVmIzK0VrNDd3OGk0VVlRcjFLTHptS3FoWDdKTHNh?=
 =?utf-8?B?eEJjdW5SN1pza2RxUDZyMnZCNDN3WnBwU2E2bnpTc0lJYThXMk1JcDZTRmJF?=
 =?utf-8?B?b2xKbzR6V3cvUHp6Y0tHMzlMNHJ1Qkh2d1NOS1ZXYlNJL1NCNENpODVsaitF?=
 =?utf-8?B?NHRkS1RqaTJuVFM1dzJ2a1FWR29XLytsL3VBcFJpZmZaNkExRjc0OGI3a3da?=
 =?utf-8?B?OTRFSlZ4NVVmK0xJQm9rMGU0ZFd0TzVHTlIrT1k5YXZKakFsb2NWTnUwYjJ1?=
 =?utf-8?B?OExUazJ0bWpzdnhoeU13c01XV3NHbGZralY2Q3VRcFhwSjR5QkdlR3RmV2Ey?=
 =?utf-8?B?L0JlRDhaZmRaOHhtbGk4K2tVMVluNmVtZW1raDI0ZHVlMDNlNlJ0a29RQVBE?=
 =?utf-8?B?UTlFWDF1MThlV3hNWkE0WXN6Uzl4RHc3WmZzeEdMR3UxZjN1dDg3M1NpQm9T?=
 =?utf-8?B?Vm5jVjBsWWlGQldsV3ZJUlJrSFJKVjhqUzVudnIvSW1zaVRPbGI0V0FMU2U1?=
 =?utf-8?B?WHRiTDR6bCs1cUJYbmJab29Nd3N0WmFWTnQ0YWpXeFc0TThLWGtOTjQvbFFw?=
 =?utf-8?B?Z25NMWxrOEJlOW8reklrU0JCSldMcG1wVU1YY0lUZDVDS1kvUEFXTE94dkxx?=
 =?utf-8?B?MWoxcVM4MnYzS3g0VDdRY3lMRXZTMUhjSytkc0NaRE1Ha0thMUZIVmFzTGwv?=
 =?utf-8?B?ZE9MaTBjL2F6Uk8zbFZ5cEhudGlIaFBjcVltaldTYmlUWVIrNE5HSlR3Q3B5?=
 =?utf-8?B?YW1zUmNRMVdJNmpKamlQWjRhd3pwd04rSmxyUHZ5b2xIY1JRUmlPKzFhNEVh?=
 =?utf-8?B?VVo1bWNiT2paRlc3Y2RXL1NLUnV5RlhFd0FRWDBjbC91VlhrV2Voc0huRGlX?=
 =?utf-8?B?RmY3TEsvanljM291VWtYRUYxMng0YXNIZGJ3bnJnMG51alkwS1dzbDZYUXI3?=
 =?utf-8?B?Umd2VmdFWEJjWVY1RnFSTjl3eGt2YmIxdHVwQlkwYXdtTHpSRGxzNDB5YUVI?=
 =?utf-8?B?alorbFhQT24zVkJKcFhGWlNCREtiQTNlNy9zeU5WQlE1N1R0QTYrenREaXdE?=
 =?utf-8?B?Z2MzVXQ0K2J6d1IvZEI5SUovUEFCczArZFVVcjVrVkdDaVRwMGpudXhyTTl2?=
 =?utf-8?B?M1Q2WU1uMk5kTG5uQUlPU24vNkhsYjFFSWtmd01LQm01dG1mUzFneU12RjRr?=
 =?utf-8?B?cEtSR1l2UCtGaUJFNzFwWjI1Z1o2eC9Qb2FOWkRtNCtyU0lQRy9NVE1oTzhq?=
 =?utf-8?B?clpxZkV0K3FralJpZXpXS28xVWR6Yy9tVXF6ZE9jMjQxR0ZKVzFrblpjbE1R?=
 =?utf-8?B?aVlia2ttSDF4blRiM1NkdzBIQjRQcG5Wclc4dTRzQmFWUllHWUs3TTNISVJi?=
 =?utf-8?B?YlBDTGxtNzVLNWcrcGo1dGRCRFZpbzNGL0IrVkJiQmFWYVdSczBQcWw5UnZt?=
 =?utf-8?B?c2d4VHJEaUlTV1VlVENlejFmRFdGcldNVy80a3dFd2d3S0FVUEFGOThpNEN0?=
 =?utf-8?B?U0xtd0MrdW9MRmVIRVA3T1dZTFdBZGdYaWU4VEZlUUtENEV5NUZRM3h6MjNS?=
 =?utf-8?B?VlM5ZVFOcXJkVFJldEdrUmk1M1lYR2wvUVBhU0tyZXdWb2FXZTYra0Y0aHZ0?=
 =?utf-8?B?Mk8zNDArMVU4WnlxazdvK0U1WU8xRkZHMmdxczRKU1FaM0xLOC9kRHl5QzY0?=
 =?utf-8?B?Qi9NcGpEMlp5UmdBY1JmeVFXRjlmalRPT25PWjhWYUlSL3ZxZWU1aVdLa01Y?=
 =?utf-8?B?encyQmNYcWlyOHcwM3MzVXlEajlKZzNiKzFhYVBRU0JMdXNDazh0bG5Qem1z?=
 =?utf-8?B?SlE1MU54MHkzQUk4TUE1dHZ6OGJLQUJ4L2RzNHNUL3VUSFJOL3pBd213ekNx?=
 =?utf-8?B?WitwdlBjZG5rb3pwWlIwdGE5NFRaZEoyYnpXUG82cE9ya0d5WDZSaEh6NzQx?=
 =?utf-8?Q?fnrSQbflDZyCwllrjLvEs+AAs/TyBg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzBOV2NJVEdVenArNjh2Rk91RHVLb1FMc2txQ0NQamNuNzdMVXpFVkY0K2xI?=
 =?utf-8?B?MWNjVVFlYWEwUndtaGFXQzNsNmdmRnZUWXV1SFpCR3oxVkVuUHl5Z3dIVDFu?=
 =?utf-8?B?TWdxL1BLM0VaaHRHN1cxSHlaWlpPbTdkM0d5QzBzNysrTU9xV2g0NmlDR1RL?=
 =?utf-8?B?dS9rbldDMURoMjdsaENYeXkwRk1PM2F5am9Zb285bVdrUUp5YXdITEoxY1pp?=
 =?utf-8?B?WGlZcS92SUJ3NUpidUJUOU0yaitYcWprc3gyWlNySmhiaGNET3hzVG1ObHVC?=
 =?utf-8?B?NUtNMW1leWw3ck05MUpVZ2cza2RzeUVFaHlhVGFBMFpkd2tJbnpqSmltQURZ?=
 =?utf-8?B?d3g3M255WnVDVlRla2xRVVFWU0d1VnlLMmRsMTJmYllBQWhCRUtPdFcxcVNO?=
 =?utf-8?B?UTI1SWNrQ3RyYWtOYk0wSUtDTjIvR0taYkhxMS9CVVpVTytJM2xYazZUQ3dn?=
 =?utf-8?B?dFdncDB5MjhOQjJEa2ZsSlo0NFBkRmJvWVoxYzNsZjdoamhESVcweGtnR0kv?=
 =?utf-8?B?cHRmMWNaQ0NhL3FkNGJnWFVpWE9lRXJ6c1lwdmFrZ1NVcUlvS2lhOVpGcGNL?=
 =?utf-8?B?U09KYTN0WERHL0NRNFIyYitxQWJsWnRDb1ArUmJxZVl4cXhvQ1h0OWMvcjgx?=
 =?utf-8?B?UXpJa1QydWJNOFVVcUpBLy9HdG9JUXdPZDRCUlZ5ODVHTlR5SzZ2SGw0SUpG?=
 =?utf-8?B?ck13MVV4SGZIc1BnNDJXMDZVTDlFbzFCM1RjQUVYYThHUzNqWjlpRFlrakIx?=
 =?utf-8?B?V25pVEpXMFJodlI2cFJ1MUx4RENUSm5CK2cxUFk5MzZWMkNISWFndE9tYktw?=
 =?utf-8?B?d0dVdXpUc25BaTRvL1dpeUJnREZrNC9zVW1GQUlRYjdNQjNqaGJQUElLeVFI?=
 =?utf-8?B?TnFGUW80RUlRWUJwcXpyRGloYlhOVDlWNloyWUxaZUV3bEhiMEExL3J5aVJp?=
 =?utf-8?B?RE52bFVLMDFod2VkUEJybkpqYUQyZXJjWVRsK3NtdkgwSUowQ0pMa0ZKUjVK?=
 =?utf-8?B?RjM0VVl3OFg1THVMbTZ5NjVZU1FHcDM4TVRQMm5qcmorYS9UYW85cThWa1Br?=
 =?utf-8?B?TjdFblNodWlOWGx0bWs3NkNiS1hnUnBUdURGZFp1WHMrL3BFMlcrMFVMZ2pN?=
 =?utf-8?B?WEdaQXJUNWoycFJmc1hEbEkyWU5QWmQ4d2RyQkhpRHp5WHpwSHdNVDloc3o4?=
 =?utf-8?B?L3hCUm1Mc2JySlY5L3k5Tm9YWHRubENFMnZKMXM5WUVEbW1pcjJrTGJSeGI2?=
 =?utf-8?B?THNRTUR0VVM0dDBvY0l6YWxVZm1yK2srUnNHZ045eHcxUXNRRlRYajN5dk0z?=
 =?utf-8?B?SHBIdytHaThpditjQmhjelJ1VFd0R1lxcmlEWWEwc0xST1A2Ly9Td2xPZTVM?=
 =?utf-8?B?SEorVTVwRDJrZEthQWlrZ3JKYTBDZVdXaDRZTy9KM3FsSktYakRyN3NUNWZY?=
 =?utf-8?B?SnhVMm1nSUNaYVlxWW1vRFp1QWpRZUFGTXhFMWxoTUI4TnhiTk1JSUpjZm1G?=
 =?utf-8?B?TFRPVTN0aXNxTWFOdTJLRnhwVVFQWlAwWDFTVVRpN1Zac1B3UTNGWDNpYUpP?=
 =?utf-8?B?YmtLMmxkY251emNBdG9rYnZ1K1hFZXdxZG11SXBkaGthSWNlOWpQMmFIUWxj?=
 =?utf-8?B?bXhBTkdQTVZIZmFvM2dncVF5TGxqdE1seTFUZ1U4cHhZTHpsdy9NMSthVVFI?=
 =?utf-8?B?NmhpKzZPVmZUUDg0bEdZcTRvSFVsTERiSy9JM0F6azFxMGVIMElDWUUxM3Ar?=
 =?utf-8?B?MUVsd3R3SHVxVDJyQjJwK3BnOTcvUTNMeUlLRHdpVm9DcWZYRjRFQStOMGZR?=
 =?utf-8?B?YVNsVEVuMGNNU1B4cEEzTGV3MHFFaitlYk82b3EyWm8rNUZPSGdqMEcxZklC?=
 =?utf-8?B?TFBPYnFrY2JNMitua0tVdXJHZWRVeW1LUWdFMENPYTJhR1pmaVNReEsxSXNj?=
 =?utf-8?B?VXA3eUcyanFiY2EwZWZsNXFEZmpseXk5N083bFdaVHc0RGhRMlJSb1BlWGRB?=
 =?utf-8?B?UEdCZUVsRnBTd0o1ZFJ3MmtZeFk5akh3M3dBVnZFWkFoeURZc2xMcmdoNEZv?=
 =?utf-8?B?c21CdWZMd1lpOVNLRkRlOEJqZkJEaUY3V0QxRjFETm9LZ29yVFdRMTR0RHk5?=
 =?utf-8?Q?Dxxo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26abeedd-65a0-46a2-db46-08dd7b82bb33
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:37.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wb+tWrchVnP5KjuOSRLhzR4s0F/jJ/D9qk6oVv99k/fgulpf/aG1HD2ELzEMfJIfRwqtNJGVGyu5f+IHSrDwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Add helper function imx_pcie_add_lut_by_rid(), which will be used for
Endpoint mode in the future. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b51..d1b1365e7469e 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1025,18 +1025,14 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
 	}
 }
 
-static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
-				  struct pci_dev *pdev)
+static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
-	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
-	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
+	struct device *dev = imx_pcie->pci->dev;
 	struct device_node *target;
-	struct device *dev;
+	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
-	dev = imx_pcie->pci->dev;
-
 	target = NULL;
 	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
 			  &target, &sid_i);
@@ -1111,6 +1107,13 @@ static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
 	return imx_pcie_add_lut(imx_pcie, rid, sid);
 }
 
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+
+	return imx_pcie_add_lut_by_rid(imx_pcie, pci_dev_id(pdev));
+}
+
 static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 				    struct pci_dev *pdev)
 {

-- 
2.34.1


