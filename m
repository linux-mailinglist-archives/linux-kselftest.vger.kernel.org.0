Return-Path: <linux-kselftest+bounces-26415-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7050A3150D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636FE3A6C65
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5DE262D39;
	Tue, 11 Feb 2025 19:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIqdg6Et"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012010.outbound.protection.outlook.com [52.101.71.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B23267B93;
	Tue, 11 Feb 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301781; cv=fail; b=AgUUqKZv73LEz2I+H13PK+B3c2Crxfakl3U1QUmmRbeV4pDObYVOXT6oUA3roGpXBGpmxSCaODeLm5o6XVVzThKolfPkiZo6iwZNGL1knxfy30F3nmK0/yzRFfaU1+Pex15shkCNwc+jMFAuKJ2Htzckz3Q0m8bVvY7cr0gANKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301781; c=relaxed/simple;
	bh=XAph/8r+ALGWqIY64EB3n2ko6vnSDAS+25h6Hio+ol4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aOMVIBrZCEJu7y4Qphpx3bJZCDT0y0xvxScylo5dVHyed9IimIhghtU/aVe1K2DJf2jAYlisGyIKjkJaPih9b1LLSXT9DOZLNHSF2pqwDsMStqo56MhR3P2ZUVNRw4HamPz5uePYgphxASvOaSqbf4R9n0nmZ3xCQIXFXG89Op4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIqdg6Et; arc=fail smtp.client-ip=52.101.71.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUezZvRtUkOE78KeL+LN1LByPTpyuRo+Q/fEvuWfK5HpZgSCpooZ//LyDF6Dkx0fMOBbRoDSieUoA90vXeBecql2a8tSAB/Bn6T5e2dxotApGZO0bztIM37H+dngeJJBcyvzRbetrbRrDFuN4kcKBzQYHyUA2YreYKNiD9ASG6aOXuumzp2XK0hOy1EC8LZHO+kBK/+on3Ke3Zrfl8soPbwS8GlB/qbFNnp1cp/FnP0W7CSVZRJ7b/M/I0HmKcBTa8i6iRibze3VjHXHDfJYX4vFYXx/fvriUAV2tolGC79ypQEfIir7nPFPHyN+kVSEDyo+md4lwZAfoVMl2N1ZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBCNxP3+P0YaG12y7u44/+2A0OL7eWfFv9lPkxDjmb4=;
 b=sFVaKHBgPLmikocmNMmyH/n4dYlF57zAeYHUH70jOWex6ws14DEfuv4CGk69dYTDh6/C8hndKIDBx8HV8vREIXYxu5euFD7lIrzgtNudKY7BzkiPM8XFchZUWY3bcVDugO1GJQ+GyG7RZVBBgVnaKdDKvuaa499qsw8YenWWYDFqXggd6XPBzDIz6aUMtQuWcSaaPnJtQPOyNLmGfY+ZIYBKmDxNNzXWWA36KgE/fswsw6ELJeeZE8WJqDISKub5IPgyT2U41k2EvFLnu/hkU9XdjbotE37g8PdO08kuRJKxoCZwCWgaXQpGGckYJY5jFmGHxl7KjDCtETq1sTZM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBCNxP3+P0YaG12y7u44/+2A0OL7eWfFv9lPkxDjmb4=;
 b=XIqdg6EtsYkaN+U8R9zs2vMNIXhCueQXTTdHJO85O+To9+8+5d+A4ePMR8qqSsh+smBf3Wiab40NpbDLe2kDROs8gGwqW/t5KmgGY6RRFHw7OipIAGftzFsf94rJQDOMw4Tigd1OPrJf0l8uK9Xjn+6VKeCaS5gLIcxKKDfIBcF9QBEY+3nqk0hveiBTjk2E0uIOsluekJsuO6fSABb3vtVqJCCLijuDZkg4BY2cOi6E/vvbNMsNk/jKr58xalrd9peuTJnN1/3vkQeWRWzAHp1gcEU2us3+GGk1Dyse7GISJW7tQhKAw07X4WnGvlkFgv88UpqiH0BZuNYkYDajLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:21:59 -0500
Subject: [PATCH v15 06/15] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-6-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=8281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=XAph/8r+ALGWqIY64EB3n2ko6vnSDAS+25h6Hio+ol4=;
 b=NyTBqy5Cqn+ax4c+uCx4jAmC27Fi9cGARZVAqhXzqnRvO+lj456ej4B2+FmwigYtiJDft/DMX
 CYJY92Uy5UbDlGS6Il/c77x1gHfaT77FWYOOOHCCAFvd174y1FZTLZO
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
X-MS-Office365-Filtering-Correlation-Id: 2a1f1414-763b-467e-d797-08dd4ad17d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1l0blhaNHJJRFluYTVhUUhKK2pBUlV6WmtKVEhiK1hBeDJnSi9qbFV5Rldz?=
 =?utf-8?B?UDR2VTNwb0taakkzR3JuKzlDTWpvanZDTk9GVEEwQTF1VmZiS0VKSFFxbElU?=
 =?utf-8?B?ZVlzTG14QTR0Y1ppbks1d2ZNdTBiSlR1RFRjWmRVY0R0cGZMM055VjNqckZk?=
 =?utf-8?B?STdSU2MzaGJiTHpRbXY5aVZ6Y0MvaDFRS0ZRRjhXK09lV00rTEYwZ2pxb1hm?=
 =?utf-8?B?NFhSY1RpSldibFBlRERBR2xscU15TlN2UXM5TmgvMzk5ZmF1N0lxVnFObEZP?=
 =?utf-8?B?TTJ5aFdLdHV3cFNhRmJVVWJKRWNjdEp1aklkbmZsU1k2TXRYTE5NdmVtVTJ4?=
 =?utf-8?B?RFRlcHFWcTBBemh0YURsVW5Ib1BlaS80d2s0RmI0ZzVleVI2RWR3NEluaGhC?=
 =?utf-8?B?aG5DaVhkSkd3cHVkSTRjZ1QvQ0VneCs4b0pITS95S001bUF5OHoxTkJKU2RO?=
 =?utf-8?B?VGFMNGNPaTJYWHpyU0JmMHVWQ2dPdEROMFQweGh3UWxZUVpNMjJ4KzdIc2ln?=
 =?utf-8?B?djdKcG1EdWZhemhBcHN0YXpiMGVIZDA4YktZTGs1aUpGdmhRY09oandCR2M0?=
 =?utf-8?B?K0xvMlJlKytnejY4SEtXdmRrOUdWck1xQWpMZElKRWxrRG9MSnorNVRBREIr?=
 =?utf-8?B?dEgxYTZ1YzJCUlVRcXBwZkQ0QWJydk10ZFdwUERZNjFrSDJsQVNtMUw0UnNZ?=
 =?utf-8?B?OXFLQXlmcnJuT3hEQlRKN1NxVE4vc0VtR1JQMDMrWGw0aEMzanlmMFJra1FB?=
 =?utf-8?B?ZzVmVkcwRGpZOXQ5YVRUUjEvYlpmUVJxY0I1U29WQ3VIYVNTQUU5VkpUYm5W?=
 =?utf-8?B?N29uU0dzN0lMMWNGMG5ZQ296d2puSXQ1QXdJdnU5bFBob2ovTVErMnZTM1pi?=
 =?utf-8?B?VWJVYkx6bC8vZC81WCtjWldGS0huQTJCMnlwdFdQVFdzdDR4R0RPNHdHMEZG?=
 =?utf-8?B?VGV2cXhvVmhyWGI5Wjd0VjVubjJYdHVPdEQwdVFZQnc1aW1ZdUNaUmFzRk5o?=
 =?utf-8?B?cGRiYjI4UisrSnRBRDZNdUNQeUpZclRYajdxN0ZVYmtLd1JlVFVsSTlDaGhH?=
 =?utf-8?B?UzhrbjBjY3VsQklrMXcwMm9OczFpelo0cExTaXhKUE5hV1VEclQ5SGh0RVdY?=
 =?utf-8?B?Zk1SYzNnUXVyTWszWEozb2RHam9GeGtHbzA2RHJJbkt4V2txTmx0OHdSdkZk?=
 =?utf-8?B?VWxrcDQ0amhMMmRheGZ4Mk1jN3pkb1hxMUxjeWUrK3VJRThzOVVpSlhEOTJY?=
 =?utf-8?B?aXljZDJSS1dpYmZIcUtxYzRERGZBMnl2SXVuRWtBMG42RVR0aXowS3U4OTdL?=
 =?utf-8?B?VzZ4R1ZaZ1Nsa3hTYTNOaGxFU0QxSVAyNE5VOWtyaTdsdmVIR09CaWlUWlgy?=
 =?utf-8?B?RHpUZ25zYnJrcmxKemRqOEd1enNjZE1SOGVqNFlJMGNaTGYvTkFLRUdpVG8w?=
 =?utf-8?B?SjJFMmZuNTVrbUhCSzRaei9wQ0E2TndDckE4VTlIM1F1d2R4Nytiei9vOVRK?=
 =?utf-8?B?S3JpN0VWSENKN2M2Sk1qc2ZMZTdzRGVLVGhpRGNpdTZEUlJ5SjFsM2NXdXA3?=
 =?utf-8?B?eHNteWQxclRENWNRZXl4djlFUWswb1gzUTlJbml6Tk5vK3FXUzhVczdTOW91?=
 =?utf-8?B?YXJkc3luaXprZnA2MENFV2V2SkZHRUdzWnBNZ3lBYVAxWExWQzRINU1GM1FL?=
 =?utf-8?B?aGJSMHR6RHVwQXNYOExvSHk5R3d0cmJWNXlZOERWdkpIT2gybHlDdXVCeG9s?=
 =?utf-8?B?ZmdRNjIyai9kL1h0R2ZFckFxUE1nc0cyb3ZWenFhdm5kazQvRitNb3QyS0xW?=
 =?utf-8?B?MlRBOHRCeWhzS2VVc0dPSWluVDBNWGdYUjc3bGFROWZHTlIxSnNuQU1kd2hz?=
 =?utf-8?B?QlJaLzYraCtTV0ZBUE9KZEJ4U0tBWmVsMVc3WkJzbXZ3ZHU3Z3Zvc3FFYk5W?=
 =?utf-8?B?ZmF5Y2RGLzYySGU3SGYyeWV6SnpsZjdUekJ3UEhjT0dDM000eEFlU0VubXNl?=
 =?utf-8?B?SUdFdXhzU2RBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEZWYStWaTFPaDAzMFg0blplOVV0bnp1aUN5emJkMkRkME5TS2p6Qy92RTJx?=
 =?utf-8?B?VnpMdEU2OGQvSVlWNnUvLzI1Z2IwMEFoempUVVN5NnNVeUYzRVlvMSs3Rkdp?=
 =?utf-8?B?aC9vYWNxck9tU05Na0k4MHZDK01yZitzenBWSjZCdDV1eHlYUzRkNHdYaUxa?=
 =?utf-8?B?OVVNQkpialBxS1FOZzIzS3ZpTmR2NFJCS3lGSnR2RDl5eG9PaUs0QUdYeVJx?=
 =?utf-8?B?U2YrWFZrZUZhZkc3MlZTSlZpVXBqOVczRjBKNzBFVldVdFhmVFJRNVg4RS9E?=
 =?utf-8?B?cDZoTHdGZWRiQU9CMXgxZ1VUM1YvVXdSVzVFSFVqazJ3blErSkxuSU91WXkr?=
 =?utf-8?B?a0FkL09taXVIcGQ5dzJFUitVY3lTc293dDhsZFNsOTN1TldUYXRXQXAzZzlS?=
 =?utf-8?B?RUEvMnpidURJTVFDM1pvT1cyOUNHaXJTVit4TEN6RTJ2QmdiL09sUUIvTkF1?=
 =?utf-8?B?cmtZZEZyL2lBNWwzRDdYNkVWcTBjWW1JRVVLTzRFVU1tQ3J2RDB4Z3daeVVV?=
 =?utf-8?B?Tzc4d2pXK2dEMG8wNEh1cUNuRzV5RkxjWDgyOElGOG0vZUNBNWxtYysvM3R5?=
 =?utf-8?B?RCtKSStFa3lNT3E0V1M1bjBvK3ljWGcrSnFnVWlaSDU0d29Cc2tvdmxMQVhv?=
 =?utf-8?B?UWx5ZmhGVUEyUThDRjVEVFdNYXdQeXhkQnpHcU5rZm9GQ1VKcnZPcS9CRGxP?=
 =?utf-8?B?cSsxVHRRUXVtOW92MHJYenZUNGhNMVg0TDBOT0VtNFVNdDZDV0I0ZVV4YXpq?=
 =?utf-8?B?RUtFWTJxVTg5V1Ixa20vdy9KZDVsa3ZCUHRDRWFJek1CeGhHa0d4UTVUQWpa?=
 =?utf-8?B?MGFYOUpzT1JIakJZUDFmb2NmVW4rZHRKeDF3WFZ1U042S25xdUwvdUVwV0ta?=
 =?utf-8?B?SEtIS0dmZXF0U3BaWFZLTDl2c3Rtc2ZTeXpvS2J5cGg5N0F4U3greU5FQko3?=
 =?utf-8?B?eThQby9IWUtHQVd3Q1VJVkwwMFB5Ylg4V1VuVFo2alAzYmhIZGo2SEw2eFFG?=
 =?utf-8?B?ODIxcUE2ek9jdVJ6RjVMWWp4RjFmOFpOcExhQWIrc3lCdnpFeFhDdnN5WDdE?=
 =?utf-8?B?eXgwNzdIK1RKTVN2L2MzRVc1VEZzNGRYU2hyaFQxanhTWnZXWUFlZWRCY0M4?=
 =?utf-8?B?NkxvdVF5YlZPQlhTY3l1UCsyRkZNRHJkVkRLT21vVDJyd2ErS1dlVEVUWG9I?=
 =?utf-8?B?eEtaOUp6eWtuSEFDRmRQd0pYQkV6UkpzRTRDaXo1ZkpTN2d1TlYvci9tN3VF?=
 =?utf-8?B?OGRkSGkvU2RlTnptSHIzQWEvY0VCUVUxb3ZXTGtZR1RDa1hQYnM2WkIrbGta?=
 =?utf-8?B?aHgzblMxVTVTdlU3NGZ0SUlqVFBBZHU0WS9LVWxYUXZoN09LbmVtYXhhZzVy?=
 =?utf-8?B?Q3ZvWWhLNHJaT0tJYWJUZDVrT25rSWd0V1pRY01kYmt2QytjUllPaTFmK1Ry?=
 =?utf-8?B?MzZpRStMR0gvM3FSMGFaS3N4N24wWGhDNTU1Wk9Pc2U5dXVPY3VXZ3laL20r?=
 =?utf-8?B?NXZvL1lPckU4aDEwcTRPMTRnakxhY0RRM3kvKzB4MXN0U3BBUmhJUUVHR1VO?=
 =?utf-8?B?SVNKRCtkODZjWHVhVEJMazRyZ2lRZDhrcTRHWmdDUUQyQmZmczBiK1pld2NO?=
 =?utf-8?B?WHRzOXIrekNDd3d4TFRhV3dBcmhBTS84eEkrdGdSbVJSUElsS05EOE12Wk9w?=
 =?utf-8?B?YkV3N2NwajlJSTg2Ulhrd1Bsd0NqUk1xQW5ib3I5QXZSSUxLaUdkV0hTTlBp?=
 =?utf-8?B?QzdrODVVTlFkcjRNdzh3T2hpWnk3NGFJM3hlRDlNUHc1OTV0WC9tVjNwSEJt?=
 =?utf-8?B?aWlnczBwbkZ1aXNsTk12OVBsckRJWU1kL0YwVXNyeWtxYkJqaXJpckxoWjBv?=
 =?utf-8?B?bS9KS2tJR01NTkR3VytGdjRqTVEwKzUvU1FzaXRDTzB0VUVLU2J3Y2lBTWJI?=
 =?utf-8?B?d0RpQVNJcGxyRjZBdmlNVEtxRWRveExDQ0IyQTlSanQ0Z01sVXJVZHBWRDBt?=
 =?utf-8?B?LzdUeUJWWVFGckVRd3lxRnc0QklHNFRYbUFzekc1c1ZLVVduNk8wZ1A3emll?=
 =?utf-8?B?TkxEdGF4Rm5BT2ZEVGZXcW90bkdoMDRrRzB1aHpPTWRjWWIvT2ZYdVFHMDBs?=
 =?utf-8?Q?OK8NK7abdhTuIApWpk69oZQ0X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1f1414-763b-467e-d797-08dd4ad17d1b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:56.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yn8o1mV0qo3faDq7WENodtOZfpJzl0zBI+xvnnw5zg3xXcjnB5YwCN3Y9Ll9FzUDo79SSuQ3sBk9K1Ailf1GbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v14 to v15
- check CONFIG_GENERIC_MSI

Fix below build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082204.6PRR3cfG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:53:15: error: implicit declaration of function 'platform_device_msi_init_and_alloc_irqs' [-Werror=implicit-function-declaration]
      53 |         ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082242.pOq1hB1d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:49:14: error: implicit declaration of function 'irq_domain_is_msi_immutable'; did you mean 'irq_domain_is_msi_device'? [-Werror=implicit-function-declaration]
      49 |         if (!irq_domain_is_msi_immutable(dom)) {

Change from v13 to v14
- basic roll back to v9
- use device:id as msi-map input, its will handle it
- use existed platform_device_msi_init_and_alloc_irqs()
- pass down epf->dev point, because epf->dev of-node will be the same as
epc's parent.

Change from v12 to v13
- Use DOMAIN_BUS_DEVICE_PCI_EP_MSI

Change from v10 to v12
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |  1 +
 drivers/pci/endpoint/pci-ep-msi.c | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 28 +++++++++++++
 include/linux/pci-epf.h           | 16 ++++++++
 4 files changed, 127 insertions(+)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..c502ea7ef367c 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
+obj-$(CONFIG_GENERIC_MSI_IRQ)		+= pci-ep-msi.o
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..549b55b864d0e
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2025 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = PCI_EPF_DEVID(epf->func_no, epf->vfunc_no);
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	platform_device_msi_free_irqs_all(&epf->dev);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..6dfbe9353f0d8
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+struct pci_epf;
+
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+#else
+static inline int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums)
+{
+	return -EINVAL;
+}
+
+static inline void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ */
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index d2790b8b29394..518bc4171285e 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: Callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


