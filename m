Return-Path: <linux-kselftest+bounces-30758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E56BA88B58
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565F17A57CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106842951C4;
	Mon, 14 Apr 2025 18:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNikwv/t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18ED2951B8;
	Mon, 14 Apr 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655568; cv=fail; b=dxkATY5hcqTSk3Qgf/hvDu57VRT9J3AjTFPBifObkDfCPAkzsaS3ZqUITBiDkU14tFLTzUO1qKF1tq8Q9E+adjF1i96chXbiXhbnHcjBN22d87eSjOKmdhjm/RUSv6hDPb6jmoLpXM23Izs9poYWonfuQvaYTnYtCTGYFlUBqZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655568; c=relaxed/simple;
	bh=y13NGoBJeE1mUHUBweMBxtJI2C8OON0QvH2vvgiDgJs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eUESHE2Qh0IUgsGa2xVDJgqV0CplvzUDPCLR/KmXu+deFbA8l3iRcH4fFpLTgohmeBLOcmjdVomWr9YF8ETPy6kga/ceg7Ua2Y+s0t1xlfiQ+FTUvioXEwZQ8YdGedqlFSXcYZ8tkpQEM4MgN2SNMcPFxwyfg0DHRZegXjMvg00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNikwv/t; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZHzZ90nffCxaIMMdtFtCfcCG5CQUru0k9wUvzJ2pVSIhUpyN0UUG+sbhxUtaG7YuIawXRNFRyfaZpRfnYY0kR7z1NxDAnjPYc1jnhd2SAR8I4TDrK2nLF1gAOpcAoefqsajc9HRKX/gL0EEpKqnMQmKdsyQNGUzompMP0wxn8byQ7G75xWYwuLPMYGtd4f0YZ0uoTog5ZLYVoURPRtCIW/MwWLMbvgnNJUPhG1dW6BUsw1BtlTWei9kNPsEwLGz74qCy36jgYzbU75f9YgHIKYkMUj8hr1Al3QidZR2mD2G9HaAfh+9Wi+Q0h0MeWFvNqKOQLUoskoG+4oj4S1oG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbXHpTIvY3lK/PUhp27uVmw/pyQFw3cH2yjbLrE9G6w=;
 b=OZ3XoSqyYjShnziv5xx3vSa5ZD0wAoxdScnE1DSvsxpUv6FMrZKqP6+f6T+n4wlMco01m/RtGBBaTgGlKeBSoRGw+nSNIy1IWcafxN2XpzXSI8Bv20KX4O70bouJ601jdarD37uS7foQD9j2aKNIpQ/QKcRnox6MCfOAeLIlb3pxOnMuLNiJEtmXKy+8NjtIpxlZiCUW6jG9/SZk/AxhdZraw0ZaUn0+YQFu9CLFXEVUpWWfGLIbbbIZp/gDYDon1tkkoAHxhgYIwWW3W1BuJOyK6MuQDkDfbaERodyYUaby3Uhs7GuQ09W75bElIpnPsy9AnVx1DiRYX5dso7ao0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbXHpTIvY3lK/PUhp27uVmw/pyQFw3cH2yjbLrE9G6w=;
 b=TNikwv/taLFzK3s536UbEO6EmDPU3lyHevqu3508mjZaHBqkPNzOk1TtHJeqyknUtntGwVKrgtCwgaj/79gQ7ZbDDt7WA0qvrD8lKtQl+8DNk1QmpattcZeX4JSTPARwQOgK1/t8ic2CHsSOH9EGRNju5lRDKG6YxkCMKa4tJwVlGNG9jjJA0nKYmMXj0TXtz7Zk3RjHlVZ3fDMtt9dgouCdNpaQFwj4sD504CzcXwwZL+/exi6s6EXZMZE9GBz3sY7KnWx2OSKVy0wN1+Yq8QYBr9kuFBUvXCdgJ7Nt2GMriPikfCzS2ZmF5JgdTmCwefuJDdV9D5AI1pW6/ExRCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:44 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:08 -0400
Subject: [PATCH v18 14/15] pci: imx6: Add LUT setting for MSI/IOMMU in
 Endpoint mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-14-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1486;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=y13NGoBJeE1mUHUBweMBxtJI2C8OON0QvH2vvgiDgJs=;
 b=G/17/COGstLE1tHnTP3oVWqeE0YhVFBNgA5LOQviUomcrEJRo/CvYpvszT+OJj43e/zVF7Lta
 qFitKfz4bg5CQCcDk4ndRfGys0zVM61zIolTAPUmMi+LllrbYegkjlu
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
X-MS-Office365-Filtering-Correlation-Id: ffffdbdd-b271-45a5-354b-08dd7b82bf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzdTempTdGxHYXpCUTVLQ2lUY0N0a3cwZFRlTThNWElqN0Z6Unpwd3JZRUNH?=
 =?utf-8?B?M3hqWDZFeDhxamVCUHU0dXFSN2VrUHNmT09mMm9GeFZSSEw2NXNBNUlEd3Fj?=
 =?utf-8?B?Y1NoWnQ5M0h6RFAxTlNnT09kNjEvQ2w0d0tGN2ovZm1ZTU4zTjRzdjJtN1Nn?=
 =?utf-8?B?aEZDRi9VZGZyai9JZUl2YjNtOUJGVTJqc3M0VUFjOHRzc3ZVV0NGejZiQ1FK?=
 =?utf-8?B?c0pLd3R0MVUvOGswcjVtbmNtK0ZORDFZcmVvaVRlNEJsU084eWJja3E4NDNk?=
 =?utf-8?B?allSendlNDRDQ2pxeDNaSGRNcnpRSXZxNHFZeUZVaktoNzcxV0RYYlpVSzdi?=
 =?utf-8?B?WUhiRUJ2WkE2NmdncXd3SkVDQ0grVVRtOSszTUV0NXlwTStyWWNQblBTK1kw?=
 =?utf-8?B?UUF0aEtsSnNiQ2ZwdVptNGdBcEtJZ1gwR1RXdkptQk5lNHR0OHlMU3dNQWQ2?=
 =?utf-8?B?S1dhUm0vZjNHeTUrNjdCSzlqbmpybW5oSzJUWCtKN05nenhHbGZnMjJWU1lh?=
 =?utf-8?B?OHZBWXZkdFNFcHdQOGRsN3pPME9POXRqanJQeEYxNnVseFg4cGJYUi9BM0xa?=
 =?utf-8?B?NUJZdHJNUnhmT2RYTjNTQ2lhNXZaQnNibVBDOFExMjc3L1BPR25Qem51R3Ri?=
 =?utf-8?B?b0dCRkZIclJGeWxFakNXRWlXajFhMTBKaXFwekRVcjR2MVBiRGdxSkcyb25Y?=
 =?utf-8?B?MXEvM25LYTdML0k4V1p3WkdWaWxkUzNHQzcya2MwYWcvcTlQdU1FQktCdjBp?=
 =?utf-8?B?NFhuSXpPdzZKMDBENWduRWxiYkYwakZFZHNORGpncmhaNFJ2V3FzQVdxSDRs?=
 =?utf-8?B?clRQUzA5dGF0RzdPMHhVMk9pZlNyNHpvTXFBTHZyTGRwbkhacng0VXFTL1JK?=
 =?utf-8?B?TXY4YTRSK0ZmMWVWRTlWbUF5ejI1aWlNUmx2SGNFU0JXRHAxZVg1MWxkankx?=
 =?utf-8?B?dUtBTXVBVXNIbVVsRVAzY2NpNUtpNmc4K0d0V3g3MHYrK0laNUUwb2xsSjdp?=
 =?utf-8?B?b1IrRVh6MGU3K3BhWGNaNGljSGVLS0t2WGtWTW5zdWUvczlYMVlhTFJlZVNx?=
 =?utf-8?B?anJxbGFKQzh0SGxLclNrajM0blpDaWxYdERlcENhQ0pZYnBueTRodUNZYklW?=
 =?utf-8?B?Z2lFNys0S3BRT2NLQjc2QlVobnA0TzJSSzh0dzFKWlNhUmkxOEJmNmsyQ0pO?=
 =?utf-8?B?SEpVTTE3Mk12aGxielZUWGNOS2xHSjlRMXpFWFVSTHVEaVd4WXkyZDdtY1pT?=
 =?utf-8?B?U0R4enNqQWEyU1Z1RE9GaXZRZUJjaWRpeTlKRzloRTBYeEltaGFscHlHVEp0?=
 =?utf-8?B?WnQ2RzhxNkJvWjZGdkxZUHVWdGw0YTlId2toNzhEQlNZWlE3bE5YQjVuaG4z?=
 =?utf-8?B?SER6UXBjWDM4eEtraC9wR1ZVT0pBSXgyTGZOdTcyYVF5dGljZFF6R3ZRMzlm?=
 =?utf-8?B?dCtjaFV4THMvUE5ieW9OR0cvVjJ6RWJnTEgwMkptbVMrMUZ6WG5pUU0rQmxN?=
 =?utf-8?B?RWc1UGg5c2k1Qlc1VEJseGUvWmdYc0NPVlBYSlJKSXVsSVBEeGhUVDlQeWs3?=
 =?utf-8?B?bU5WaUx3R3lnWjQ0OU5kWVk4UXlwSzYyaEQxbVdaQXpEdndTZEswR1EvZVU3?=
 =?utf-8?B?aXpJWFgvenMzK1BDWEpwRU1lWW9seDZJbm5vbzhQdlBMK28rUk1LWDNqQ05s?=
 =?utf-8?B?SHJic0ROdWZrL09jMytWVUdKUXJlMnBKT1dNdTUvNXY5Qit3QkJQQUQxZ2Qw?=
 =?utf-8?B?QzJ1d1VSMXNvN0o2K3pSWEtnaU93aHpSVTlFY1FrMmhTQW53Ulc0QVZ2SGs0?=
 =?utf-8?B?TXNHMmJQd0hzaGZpYjJkM0F4aUR6SFNWR1BpdlF1ZndzTUxYdVlFYitVWXFa?=
 =?utf-8?B?d3dsZmlKREVFeXpOQ0J4Z1JKekV6Y3R6SW91UXlYZVN2cktUbHJ4QzZnVC9O?=
 =?utf-8?B?TmM4V2ZQY0FuV3NCb2o0UHkvODZDb3BIaTBkaGlnZ3dmMFUreVFrWmNIL0dt?=
 =?utf-8?Q?d1O2nv8vfs8oHDcOVvoX+vChjD2IFI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckZQMjFKYkdJMW55NWRSaVVodURHQk9kT3NDQ01GdzViNDd6dXdSdVNnK1dY?=
 =?utf-8?B?bU1sUW9jNE1CWFVEaXdDcTU4NjYyR0JXRURtd1Q2RDVjUVZvNnNIVElZK2ta?=
 =?utf-8?B?bDZVMitiOFlKQ2IraGRiNzhZM0F6cUpwMnZXQ1ZVdTdFS3IrNXY3RXRWcE1u?=
 =?utf-8?B?RXBIaU51Z2QvejgzdlQrUUhvK0QwOHA4OHdiajhtRlpvQU81dkVGcTNZNnJU?=
 =?utf-8?B?d3FBbkZ3dkxYWnBnV0VaZ1hxRE1vdnNPTW4ydkc0aFcvRFhlczRMcjYxNkdM?=
 =?utf-8?B?QmJPWU1QbTBmbFF6c2pKYUFaWjBWNkFpQVN0WE4zdmZkY2Z6UG81bUttNE9o?=
 =?utf-8?B?N2JZUm52aGdIalBnOTJQa0UzNFV2NUN3QU5Zc0MxMFlhSFBNZkVUT2cxbEps?=
 =?utf-8?B?Z1ZEMWRkb0F5SmN6Ymt2U0l4RStENGpyUlRvVm9sSDQ5SmV5Y3J6OWxJdEhl?=
 =?utf-8?B?dVB4QUJlS2RNV1ZCQm1KQkxiYUJtZDE1MkdCRXVYY2x6bWcvck1kNzBFME5E?=
 =?utf-8?B?QXU5K091dW5Ld2FYQ1lUVFZwL3U0NHZYdDFJV3ROL0tIV3NWNVZ2SzR1VHVY?=
 =?utf-8?B?R05EWG9WL3hKajdUUDhFamNWVlVEbUduUkcwVUYvMFFCQ2tESjFPMXhFdTVm?=
 =?utf-8?B?SzVkdGJhYUFDM2dMT0Ruc2RpZ0dwV2VWQ2N0S1lyTGpVQ0hyUnR0WGJidUgx?=
 =?utf-8?B?YjFvTU9TZEZYZ0o4UkJTSVBGUlVTVWRBRy9RVU9PMFhraDViOTVDRVd2V1U2?=
 =?utf-8?B?Y2FCK2VpakNRZ0I4NG5sYUpxb0czbU5zNnVoNzkyQ0xxL2Fid1JDYTVEUTBx?=
 =?utf-8?B?OW1DVER1L0dPaVhNbnQ3MUJGa1RQSnNhRmxxeDlqZVFIa3k5SHNieHBZbzMv?=
 =?utf-8?B?VnBxZ05QZTZrSFNMK3FOcExxY2YrUG01eVA1SE9QNkdHand3UVZEUlo5bWN3?=
 =?utf-8?B?NkpmaFFFVzRFandhdGRYQjlIdnE3UHR4UGJyNkVic2FnSTNLSkl1ZGJiVWht?=
 =?utf-8?B?Q3c1MytmMTgxVkdzWkg5a2Z3bmRrOEhJNFpScGx2SnZ1KytHMUY5REZvMS9X?=
 =?utf-8?B?SndjL1hPTlFsbkZVYVNwWGJqL0NBdGI5Z0dCY0RvVTRxTWYyZ2VBM3QxSUlM?=
 =?utf-8?B?UlErQ2o0cXJFNzV4YWRrZ2ZabTBNSU1YYlhPelMzTlFIVlFybEJOUExOT09W?=
 =?utf-8?B?KzdTaTY3N1RCTS9ta2sxbnZNMGtXSEwycFUzQS80d29jRkl1MTl0U2p2N2JP?=
 =?utf-8?B?VCtSb1VGTUNYRlJFbHNGRGFiVzN1WkRtZXplQ055Q1RnVXpXVkk0OVd5bmFl?=
 =?utf-8?B?Qm9xOVliREVEbWJSL2M5dHNCV2RhM2hwOEp0UHJZNHZVZGdpTXUydVQvbG9C?=
 =?utf-8?B?WmpVdFRUNmhsWUJTVFBXemFmb3lidU5zYmtwU092NjUwVUxIQ1J0cEdrWElj?=
 =?utf-8?B?UHN6STF5d0tuYWRlZzhvaXg1YkxEeGxIQ211TWFhRVZtcW5TZGFVQVRFNDFZ?=
 =?utf-8?B?MUgrRTFtdWdkWUI0RnpObGdhbE5GNGprdXRmTExkeWYxR3c0OXEzc2U2Tktq?=
 =?utf-8?B?a2RqYnZOQWliREVQM1lZSEFmdElwTzNpU0pXUHZkNlpLWVI2V2w0MHN2emI3?=
 =?utf-8?B?SzBOYlY5YmZzVEdvMEV4OTVMK1dzUHFTUDBaOHhSbVlGMnlObWpqWVoyUUVH?=
 =?utf-8?B?b3liN0ZoaktqckFFTEFteDA4K3hLOFFNZjR6S2FmMzd4eEZ0dFNKb0lOSW9L?=
 =?utf-8?B?UGc3cjZpUU9IWloyY2lMQXIyNnFhbkZuMkRXQzcxOHY0SlpzSWEyNkZvd1hp?=
 =?utf-8?B?eCtCeFBqNmRhanJ1d1dEQ09UdnBLM0ErRDJWR0kzNEZJeDhROWl5V3ZGSi9i?=
 =?utf-8?B?citCNGVwbzA2T3g5b2dacDhUNGN0Z1ZTMGdrZHZESGNYSCtOS2t2SXNCWnFS?=
 =?utf-8?B?bHc0azhMT0c5S1RmdG42a2ZlbHdNRXVpbEVNVHNVYVRzSTM4MlFpWEk5RWND?=
 =?utf-8?B?akNJMUdkS2VZVG56Q3dtT0Y1aHFRVzVEUGtpaVhZaHF0R3JFNGwya1MrQnBa?=
 =?utf-8?B?b3d6OTJqQmVRbGVxSktZZ2Z0TURyZEdXaUtZSTB3T3MweHQwNDdCQUNGaFpM?=
 =?utf-8?Q?QlBs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffffdbdd-b271-45a5-354b-08dd7b82bf38
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:44.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CX9ELf8dcAaE9e+r9xElMg4pLNHzp5jEmSjYwoMM3wYqqtAnS4QrIH3Mlw9izAZB6FfC91FAzsRC8KbMbrmmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Support only one physical function, so call imx_pcie_add_lut_by_rid(0)
to add a single LUT entry when operating in EP mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d1b1365e7469e..a6e4630fcf530 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -992,7 +992,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
 	data1 |= IMX95_PE0_LUT_VLD;
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
 
-	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
+	else
+		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
 	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
 
@@ -1622,6 +1625,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
 			return ret;
+
+		/* Only support one physical function */
+		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);

-- 
2.34.1


