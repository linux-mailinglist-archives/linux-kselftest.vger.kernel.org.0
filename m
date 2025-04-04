Return-Path: <linux-kselftest+bounces-30132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE776A7C374
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529EA1B60D7D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F42206B6;
	Fri,  4 Apr 2025 19:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ac8AHJRq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982421D3EB;
	Fri,  4 Apr 2025 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793324; cv=fail; b=rTUdZXwNHe5cP9nGAtSokzxq54KoGyI7kcYWSEJzltXQPSdnrcvf/GjTML97MtgotmpHXPNcCLyAs7/av75LtnkwsWHzSbrnzbs5sijZCn3ED1mmLdsudliPhT1F2Qc7mXSHknb80QSdUWNO/rlx9dF8nmlqF8WWyBeVnM6OdEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793324; c=relaxed/simple;
	bh=EDCkhLlbHI2hFy+q2eIJrdZAgXhyMONM9CzZZ/faG6A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rhqvaeIvsUtMbqZOTKakntJ7om8Y6W8z/OdzuHndOx+Rvz5TrQHUDSHsS6l4vAzFW+BNpoQbdK8hUsTTcfole9Vb+IsdfQTMPeWA5ewLa80IoebVKFXV0qZBEWpzVnwsok4JEqItEY3Bm8CdRWi0FmvdwLjxESRc4qENahJ8lAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ac8AHJRq; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukVQReMiqEWDw03eE2hSMzh8IJoB/5lsyx9EKSkVsNszr738nzw6gBDQ73Vo7k6Cj3gg9lKg+5DL+CMd9F0hcWf7UZ4VGDYXsqnNON6On95//AeYmvE2SvmlpwDDvTsZ4ZrEo/3ilBESrVl2ETo+QpLCFf4OzeJUrEsiUv8HmF1eIfqv1GZfgjsSeLhP5R6cV8kEorLprRN8LEWiWSnHJKGxdngSucKweGa8xzuciqzXszJMpCm8uQD2JqaR1IQMmoK2yzNOyJjev3SUwBwHw1Vyh+W5Nm9pKsr0yTMrvUM6hTlEVQH0oZ+7jpedRaAOpf+DiIe6AJ//UwI2105pSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtWTeooM8CqBue1hpkVfKMqyxGo7QdxdI526bind1kc=;
 b=n5J0LqlZiYQ8BX/m3wpFOQGbjZl0yTI9XTi9QA89zcfE/dM3FTQG+l4Q27X8KJGnicXr43fCP4uwvdORj32M2W7uU+DO2y2bTRS/Wgj37GhtiBOSPqTuoF6CoHW28mqviFbxaYd3kXxAf0ngweqPP6bQqoxFX6fvKui0rkMj5sAYikT6tqpUTfyk/gtosnVHNr7v8W855qJz26K4tDMI6Sydku6oDX90rQoXKX5LdXAQx0YDRuiaI34gWQZcyHxr4ugdJNyb3YNi/9A/t8V0ZAETUBPOw0fTZ1b4tdUvtPP9ASEM0LX00G+sDXQ1Oj5FFQr5QQGUuP+XdUOwSQ8aZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtWTeooM8CqBue1hpkVfKMqyxGo7QdxdI526bind1kc=;
 b=ac8AHJRqmHgC+rfZsKChsFBnHTSFzIxkADs2Mr4bHky7+DavMbO3WBJW6tumrHLvpF7vFYaTfuP/XbmcgngvgUuisf2myLxwogYJtNhOJbh2dUzY0APGNBb99fDphi1GsAJD9XXQIc1Y1odpVZ7dVbkI+OfQRMqnXElwrDf2VnF3X/7O0hBMUTDwQevzfdNIZYbrEOLzDxqaHjrCqlOvc2b3eCYhFWFou5mA4Dj6EIzYfiZm35cw8uW799GdRiGtXat71j/ul1dDPp+bJu15JH4kbbG5MbzH+f9bYfK921dHPXW+A9TqnHZgF1OIDCA7mW3p/shaO1ueI6Y62wtrLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:01:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:01:59 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:05 -0400
Subject: [PATCH v16 04/15] dt-bindings: pci: pci-msi: Add support for PCI
 Endpoint msi-map
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-4-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=2774;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EDCkhLlbHI2hFy+q2eIJrdZAgXhyMONM9CzZZ/faG6A=;
 b=JLLABNk6sN/MeZvbGiTPCiRlSC/oxrSatmV5K6rYIREPsIl1QnEB0KGaBhTApl7I2UA7ikcUr
 zVXJ3Sew8mSC+snKpJFtUoJUdCI3UG341gi8bXWGmiTLsW96UyTf0tE
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
X-MS-Office365-Filtering-Correlation-Id: c43d8927-2443-4d6c-c784-08dd73ab2d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2Z1NTBXL3grNGt4WmdIcFBmeTI1ZHpDdGtuVDROakVyUjM0K0dzdGh2ajlo?=
 =?utf-8?B?dVN6Q2JpY3VPOStFamZHVTVlbjJNRno0UGtLZ3pMazJQMERxb0tld0hXak0z?=
 =?utf-8?B?L1dYVGVOc2FBeU9RNk54Q2k4V2lMUkE2eVkrUk81SEFWTEVmK0QxWDdIT3F5?=
 =?utf-8?B?eUtzdG95VkxZQ0VHZGdaSVY5bW9Fb3BYTGI0NCt1VUZCYjcrTS9Vb3RoRHJh?=
 =?utf-8?B?V2V6SE1FOVlMaHlZYXk5WHh5bUpmWW9FNTh1aEtacmRxOTB4Yks2UWI1eURV?=
 =?utf-8?B?YTNsZStERlNFa3V0Ujh6RkNuUG5rZVZvenpQTmdzZTc1amVLcFc0a1pldHlD?=
 =?utf-8?B?d1dXNnNuMDFZemp4Rnk2RmpZNFMxbmIvY2hTME1vV21IWUVKWVNrZ3hQSHZo?=
 =?utf-8?B?cTdBeTJ4dnZ5bENwYjNyS25ySjBLQytiN0dWOVNCMGIycDlXT0NMR0dFOUlt?=
 =?utf-8?B?Q282VFQ1b2Z4NG1KaVE0aW5CRmZwM2ZsVTdXRzAwajlQVWRGelkwT085NWg3?=
 =?utf-8?B?M2h0aEg0NktDL2VUSGxRTGxCTEtpYmFHUDVyellSaG9rbURBQXlaRGI1OWhP?=
 =?utf-8?B?aUtpekFoK1VDN2xacmtjY3d2ZzFPdWM2c01UTG10akRTWHE0bUJJSGgyb05C?=
 =?utf-8?B?Y01GcFRWMmRvNUhsNXRuSWZ3U0pMMlc5ZXhkcFMrOWJ3bThoTzhqdDcvMkJP?=
 =?utf-8?B?ZXdxWDZjUFVQL21kMURMRVRnTzdHRVoxdWdxQld4bGh3eHh1aXRENGVXbFhm?=
 =?utf-8?B?Uk5uMlc4TjRibGU2TlZOdlZudnNzSy9rMk55Z3I1MTRoZDczNUtzWGpLYWVD?=
 =?utf-8?B?djhLaFJ3emplTHZld21EaTMwZzdNTFQ5OHBodHVjS3Zlak8xbjdqQmZIM3pP?=
 =?utf-8?B?bklTZ1ZRN0tVZlJrNjk1QWFaQjA5RjJxaC9xY01HZnkyV1d5U2lNMm5jOUg0?=
 =?utf-8?B?VWQ3WVFWYlZhekxGeGxsSUNKNkErL0tsdkJrWnN5RmxkaG9hc05PUkIxZTV4?=
 =?utf-8?B?YmxRMng4ajJSNklNVUw1VmZCV0FacWN5NkJXQ3dCLzNWc21EYkQ4SVhyNGY5?=
 =?utf-8?B?c3RNTnZobEU0c25Mcy8yTzF2Y3diaTlGUGpvMC9pNXpvWGJXL3c3V3dXS24x?=
 =?utf-8?B?cnBmYS9jMzlmNXNVYVNIY0sxN2pBdGlrNG9pUnNnQW1tOW1qY1Z1ekR3dUxj?=
 =?utf-8?B?bTRESW9SRU9iaDE0dE1iR1FyK2JORnl5TFdZd2IrNy9xVlRVbEdNeUo5dFFJ?=
 =?utf-8?B?cnJ3bGdvTU9jUW1xcXVvajBiR21WQ2kweDFsWjdFNnJGYWR3MnFzREZyQm13?=
 =?utf-8?B?a1h0cmhSSmJCaVZKQ2NlNVZ4NllMRzVacDlGRCtnMW9pdXpVMFVSTGpLZVVs?=
 =?utf-8?B?cVB4TjdPbDVyZEl0b2dXOWVXVDQyQ2VPdEdMaVVSbUdwaGFxaFl1YUZtZERS?=
 =?utf-8?B?aUVsUkdzYitzcDZqbkdacnZ0UlFzanpXYXVaN1c1SXNVdkxmNFdxc0IxNzA4?=
 =?utf-8?B?VGl3Mkl4T2duY1JrRnYvRzBqUVFBclIwWG44K2FuWjNpL2VtZnUyTFRmQzBs?=
 =?utf-8?B?MGNhKytzMUdqQ1M1bCtyb1JzcktHdmpxWHVRYVM3eGhoRERTVWN6L09DWjJj?=
 =?utf-8?B?d3VRRTN1MVdqdnpxTEc5S3dwRmRCcUV1NlBHWTNiZFpjYXdrVk1rbFVWdGp1?=
 =?utf-8?B?V2UrcEJ1enlDVk5HdVNnR3RyUVhKcCtTZmVkeVVxUVRMTkJoRnJJRldTUGtP?=
 =?utf-8?B?ZzJVaHpEbjVZSndmTTVXd3FoTkZEWTVoNHV5S2VhbDBKbUQ1WlpnTUsyQTlV?=
 =?utf-8?B?aFVCeG9wV3QvbHQ3YmxJajk4aUFtVGRMSHRDU2R4Ny8wV1V4cjk1T0NWNVhM?=
 =?utf-8?B?ZTBBUXc5M3dsMTFDUmV6MjFmMnNXd3d4c0NyTVZsTFkzTkJjL3hxbXVwYWY3?=
 =?utf-8?B?R0dRaTFSd29PcVVDQUl1SkxBd1VDVVZpZERTaVZ6RzE0ZDBYaEt6SWJySDNE?=
 =?utf-8?B?U1dzdU9rUnNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFpDakh3QmZOWEhyZjVqWVVqdEx0cmRNakZ3cXppbkduSFpFVDV6Y2pXT3BD?=
 =?utf-8?B?ZWRrY3lhaWJNN2lGdFE2eDZ6OEgweUlPV0dNUUdOUTl3TXk0WXlyNS9rUzJR?=
 =?utf-8?B?bVVFSUx6aEpQa2hOemQrOUtXZUlNYVgzb2hSSXA1K2d0NDRvMG00S1AvYnZs?=
 =?utf-8?B?TXVveUtsc0NnNTJRb2hhdWVkSU5id2pZN2xENUV6UGdiUlpGTjl4UFQ1Tkc2?=
 =?utf-8?B?WEl6YmNEMnZHVEdiU3d3a2dtRmFUZHgzYklXOGNWbHRndTIveVQrSlhrWFY2?=
 =?utf-8?B?Z2hBQ2Q1M3lZM1BZS2ZSczRsUlB0T3NZYUpqUmZHLzZWaWt4RFhqaUlsYlBv?=
 =?utf-8?B?MXU0YUpERW9Qa2tvZC9McDdtblZEOEg2SUVPWHNmK0ZPZkdvVjh4em9yMXJU?=
 =?utf-8?B?QVNwTG9EY242L2pVUnFQUElyOUdlQW4yWVBNZHByRzhEWUk3MGRjaitiRkRt?=
 =?utf-8?B?T0U0Z3hrMkY4R3VsOTV2UzBCa01NTUNsVDJabkNiUXQrZDRuWkNtSUhVYzRR?=
 =?utf-8?B?TzRGVEJwZno5TVJuN3Bja0R6V1dadU8xaVE0MVdIUkxFSDZ2L0o3TWdjdlBu?=
 =?utf-8?B?L2JpQ1lnNVA3eHQyeEg4STVnRGNEU3Z3Y0Qvb0RrZEVLd1c0cmk2dGJKSTE0?=
 =?utf-8?B?endHUWRTdkhsSnk2T3VIVG5GZUNHaDZQbFpuRHJUc2tUNFRVYmVuUC9jT29Z?=
 =?utf-8?B?NVdrcHg5aVQ2TTlvYWxEekhkTDVUaVRYMjlpcFN3VkNNUmVNMmxQMmI4N2lj?=
 =?utf-8?B?TUF2eGFENkQ1T2pqcWRCdTNhc3laZzJlR0RHcW53Tm1uWFQxV1d4ZGw4VlFm?=
 =?utf-8?B?RWNsZHFQOWFIUUlEY2tlUW0zVHpHemJpQTA4cUF5aUV1dnpFL3A3OHBHMVIx?=
 =?utf-8?B?cWVpWW9TZ1djUzhuY3VjR0JLWUlXME5Wc1BqbEd1SGxHYmVVdDBpU0xYczFp?=
 =?utf-8?B?MEVjakVQL05hTG0yM0o1MTFZU1QwZmNGUnpRVU8vVTdkNjF4dy9tcWtteStB?=
 =?utf-8?B?MjUvT0JqQ0t5VkMvUG5ncStOeU1LTTRtY1hTQzRTNkVlTlg3LzRTT2RKMTUv?=
 =?utf-8?B?OHhjcGVoRXkranRkc3l0blArOTZYcmtNTmppN1lHMUplVmUreXdXY2FMU0lh?=
 =?utf-8?B?ZjJBQzcxSzhwc2JkY2tnMmZFa21IL1pNcEh4OWFWbnFJS2tFUTFtc05wdVRQ?=
 =?utf-8?B?a0gvN2thd2pUNDZWSHRyQ2JBOXZDM1hPVHU5M3R6eTJTc1kxNEpnRkQ3aXhT?=
 =?utf-8?B?SG03Q3RWbGF5ZDc0dU5mZGYyb1JyMFdrUzhZUmZKaWcwd0NZYk1EQ0Z6dmw2?=
 =?utf-8?B?a3dxWXNSMEpCRmZ3cVBmU3hVd0Z0cWVHMDJ6K0dCMkc1RjNqL1llZGdjVDR1?=
 =?utf-8?B?VGE1U3J0V2h3ZURwSis1UzBkLzBTNXRWditKbUJzSzVqNVoxYXFzbnFRQ2Ns?=
 =?utf-8?B?SVhuWEs0c05SNzcreDIzRnZpRXA0aGovYk05WnJBQjYyZDBKeFlOVmhXT2ZP?=
 =?utf-8?B?VStvRUVscklpM216MkszSkUyeW94RmUvVWlYNGtCN3FOMjdvT0dQaDFpNHFk?=
 =?utf-8?B?SEl0dm15RDU3eXVBWCtFUUFSejIwTmJuYU5XOUFGSVY3c3Vwakc2NU8rNm5n?=
 =?utf-8?B?ck13QlZoVktiNFFnQjdRL2Nicm8ybm9IRUFIQitxY1FXTXhsQUVBb3dIdUhn?=
 =?utf-8?B?ZE8wdXdXUkUyVGFzZHhaWlMzRldNaGowcTdyYmxIenpJZFh1UHpOU3FSc1VF?=
 =?utf-8?B?VCtxRUtteDdYTWxoS1FWUnBzWXVOWDJBb0lFYnBaVmdCR1cvRlZ2ZDJqTEVq?=
 =?utf-8?B?T0x1WWFyYmszRjBsSTZPQnpDNVFhUFBZSHd3NndVZ2FvYkFnTXFzdWZMcVlP?=
 =?utf-8?B?VFpRVzErM3lxTzF2NDg3ZXVVa0pvcDhvbmxMOSt2dlZaU2l0ckVsb0NVSlpr?=
 =?utf-8?B?NjZlMndrZm5IbXdablBiVnd0YjBaVDFySW1xM1dMY05PVnIrWGFBVGE3TlJu?=
 =?utf-8?B?SFlybWpGc3M5R2JnQXRmL2lER2M1NDFHcjR1dW9TRUlnZDFCZzh0VG42YjR5?=
 =?utf-8?B?dVFOaVdFRFhNenp5ZE54S1VUZVBIZnh2VFJWd0RENkZSajV6YW44bHZvbnBw?=
 =?utf-8?Q?8Paw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d8927-2443-4d6c-c784-08dd73ab2d40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:01:59.3925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFblLU2HtAW9DK8cMLl/H1BwJEXBMtcC3d6d5qIQ/wgUKY36c+MeRIGfKukgbO5i9FfvfFi8lJ06qVyYZIICWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Document the use of msi-map for PCI Endpoint (EP) controllers, which can
use MSI as a doorbell mechanism. Each EP controller can support up to 8
physical functions and 65,536 virtual functions.

Define how to construct device IDs using function bits [2:0] and virtual
function index bits [31:3], enabling msi-map to associate each child device
with a specific msi-specifier.

Include a device tree example illustrating this configuration.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v15 to v16
- new patch
---
 Documentation/devicetree/bindings/pci/pci-msi.txt | 51 +++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-msi.txt b/Documentation/devicetree/bindings/pci/pci-msi.txt
index b73d839657b66..6a356707d01fc 100644
--- a/Documentation/devicetree/bindings/pci/pci-msi.txt
+++ b/Documentation/devicetree/bindings/pci/pci-msi.txt
@@ -218,3 +218,54 @@ Example (5)
 			  <0x0000 &msi_b 0x0000 0x10000>;
 	};
 };
+
+PCI Endpoint
+============
+
+A PCI Endpoint (EP) can use MSI as a doorbell function. This is achieved by
+mapping the MSI controller's address into PCI BAR<n>. The PCI Root Complex
+can write to this BAR<n>, triggering the EP to generate IRQ. This notifies
+the EP-side driver of an event, eliminating the need for the driver to
+continuously poll for status changes.
+
+However, the EP cannot rely on Requester ID (RID) because the RID is
+determined by the PCI topology of the host system. Since the EP may be
+connected to different PCI hosts, the RID can vary between systems and is
+therefore not a reliable identifier.
+
+Each EP can support up to 8 physical functions and up to 65,536 virtual
+functions. To uniquely identify each child device, a device ID is defined
+as
+  - Bits [2:0] for the function number (func)
+  - Bits [31:3] for the virtual function index (vfunc)
+
+The resulting device ID is computed as:
+
+	(func & 0x7) | (vfunc << 3)
+
+msi-map can map it to an MSI controller and associated msi-specifier data.
+
+Example EP
+==========
+/ {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        msi: msi-controller@a {
+                reg = <0xa 0x1>;
+                compatible = "vendor,some-controller";
+                msi-controller;
+                #msi-cells = <1>;
+        };
+
+        pci_ep: pci-ep@f {
+                reg = <0xf 0x1>;
+                compatible = "vendor,pcie-ep";
+
+                /*
+                 * The sideband data provided to the MSI controller is
+                 * the device id, function<n> maps to 0x80 + n.
+                 */
+                msi-map = <0x0 &msi_a 0x80 0x8>,
+        };
+};

-- 
2.34.1


