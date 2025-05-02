Return-Path: <linux-kselftest+bounces-32142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73752AA6838
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 03:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF9C1BA5C03
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 01:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E061411EB;
	Fri,  2 May 2025 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jPxhPyWX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EF62F50;
	Fri,  2 May 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746148260; cv=fail; b=d2/CPsalZ6bx3RR9Md1kme3JysczwDaQh5TtgB4CouxvL1nbJJh5VlU973IF2A9QKyudMWe0CReqJjPPkDXxxN1IUySmbvZRqa2e9XwcaL4D50f8wLy5BaBYSv8QH39GyUlpWtvVvrKSdC8camcbGtPuurcSXkc7Yw8TBFdB6Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746148260; c=relaxed/simple;
	bh=oedcE9kJfU8WHl/+NmC34k6tUt2tF8D8TTXEF200MjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RNKLnv0ASsgyBXZ/5GUitF3CquSvIrPHwaqKQkjcd9XYyx/YqibksURKE9u5ww40A81ejP+FIMjYnU4o1udm7xt61kkQxcKuuGQAtKQPsHqpTTBIY9j4hFNfMJ64dnMqpO/Jax6WJN6L8NiNTS/sO5IynisusPvFl/5nzFelH4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jPxhPyWX; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqCNg4Ucz4zNH4yDg0nfM9FAXr9jgzYbNAsN5DlcnyYZjZGcCxtDE7UBeRB+jjeomqnpx9uy9MfmKFR4WGVDOPvZTs3NTeVeW/CRHgD0fLYGXe2F49ZBk+yT22Pi92Yzbmv5GK5/wzodkm72fwP3klbwQE+aIBEUjtk0blf8BNFbOWif+gFJmZUin853ZizX9Go/k1rkjo0hbvWPimPquk82AU54WpxuRL2bAFV2mCTV98yz9TLHLilg18hvKMRe+/djJ+FOEqApatlDNTsyWtPGXORL5UHjp2e0s6mEFmzrEvUXhEaWTru4K2hrq1CUAzulNPDHbtS7U5ssOT2LfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyaLB2f/fUne54aZo2WkrSDyEQPfanYA7lgIHbHmZWY=;
 b=ygt+pupoM1htm/KhOgOOzET5gtiDgGnyKTl8Y0JZ93IPcM4MNpnBNHfb1kJ16e4w4+8AVf2iAh+6DuX/3Ol7akVyBXv1rRGUrd6omPZT0Ct4GVnD8zq7WfRtbT/p/Dq83Y/opl/4JDYjVlxeON1G+Joi8Jy5Hf2GRjd8tZIBRRfw/rg4jBJ5aDuWCx3Yf0pgg1vXhON8l4+I8UGWbeSfOzpnipiDj12fELnBjlg5XNhYsIarbw30GdaMe+z0a7CCgcGKO+GSlIZsjrxk5S+nvWCofFGqF0cIdrWfRi8m3FXBfxh1SgzVRQG1Alaio3BTGCdW2XyQljaO6dwHRTqoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyaLB2f/fUne54aZo2WkrSDyEQPfanYA7lgIHbHmZWY=;
 b=jPxhPyWX8EPs0QOEL8ZRZGBXRHYs3sXfvFC7PCqRzcZ8RDG6wQa68nc3TPTaPxMVjvxRJPhGwIese+uLqHHriQ3BTP1nZCdkCWZ/4MOBwduJ9JgdAmg8mtwfFT/24eouwsR3ZQJLJjREJcO+vXix1xRi/0x49K17qpz1LgYGGtx+wGdrkl7a6hxnLgzVCvtHplQfcNXTNtGOw/CtC3AyDBYNxQEAd8MKeG3683uD1ReB0mwYyEbioJnEK4XtjwnIMAAH0xuMKhK6ToG3tztHa4JWahymZLq3/VrqBHU+ZbqHXZe5EiLF0QF4rsBbjlA7s7mv6v9FW3zIwvhlz9gVYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8716.eurprd04.prod.outlook.com (2603:10a6:20b:43f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 01:10:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8699.021; Fri, 2 May 2025
 01:10:54 +0000
Date: Thu, 1 May 2025 21:10:46 -0400
From: Frank Li <Frank.li@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v18 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <aBQbljvNQvoOHZ+S@lizhi-Precision-Tower-5810>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
X-ClientProxiedBy: AM8P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b639b35-b366-4439-61ac-08dd89162ff6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RERiR2ZXMU1vdTliNGpaS2RWaXhzNmY0aXVsZ0kxcWlOeXZBNUZKNTFEd1BH?=
 =?utf-8?B?SzdkdGIzdE1lbnZiTXJDVnhTY3NKRTNJTmlvL3h3dXVTV3lkcDRtZ3JEcXFW?=
 =?utf-8?B?T3A1RjRCanJrdHhETVVTQ2hIZGk2ZkVOZk8rMTJnVjZQU01YNFYralNuNFYy?=
 =?utf-8?B?TFhXbHkxM2hGNkM3cjJuOGMzVDVKSEdNTTVmcWxST2FuN0s5bXlKS242N042?=
 =?utf-8?B?WXRTQzZKeHlrdCs2M2FONzFMRVJkbmI5WUh2NDhRS1dCaDJHdHUrU1BPdmlB?=
 =?utf-8?B?QzA3Z20vcm9WOW1rU0tWODVuOTIvT1ZYLy9sdVdUVFdZMXNrbFpRVUVlaDY1?=
 =?utf-8?B?NDIvS2UxQjdaWG5CUDkxRmhtQURlUkFncjdlclJleXFkQ2tjSlRoaC9nS2Ey?=
 =?utf-8?B?bHJQSHB6NXdNVVQ2K1BPQkNDUWoxZm14MXBERW5MT3RoaUFvVjJxaG1tQ29N?=
 =?utf-8?B?OUVzSGdyWGhWNFhnN1puWjNDUmx5YUNRZWxzSEF4dTlmWldHL08waGtzRSs4?=
 =?utf-8?B?TFRwUmRMSkZ5UVVMN1lEVTI2MWNVZUZla3k1K1JpUTgzSjhYdmpzQm13NCtm?=
 =?utf-8?B?UFU2ZytURnNpUjdrNHRBd1Rpc09id01ZL0IwWUh2K1JNKy9pMEpCTmI4RmVI?=
 =?utf-8?B?TE5vcEFrYnVVOFhZd3c5L1NpZTFxb0NCdTJsaW1VSUtQbExCaEY2ajlWVHln?=
 =?utf-8?B?WjU5RXBwbFRQU3NyMWVWVGdxWVhTK0t6KzhLbktaN2FadkJCNENJSjJMNTFK?=
 =?utf-8?B?aVJaQk10YXVkblBteDJ4M1dwd3kzZTdHRU94cjZvd05SQ2xLbDYyOTVCd3JI?=
 =?utf-8?B?MTF0Ym1LMnNaa3pXYm9uVWdESTVuTjJUVVFSR0pQR1V4VGlPSVpnNDVBQnVu?=
 =?utf-8?B?WjExb0Q5MnFxY1ZYQmRxNjhQTzRSekc3UWpCeU82cFRqcmVWazFyZ1FlK2Vt?=
 =?utf-8?B?V1lCeW9UVkt0Y284ZjlZZFh1ek1DYTl4WFI1UVN0M0JwQ2Uwc2ZnTDJtQ1pR?=
 =?utf-8?B?N2NsbHB6VmlNKzgrUFVTRVJYL0xRQ1hmNmNRdkVBNGxFUW5XbVpCdnYrR1Zn?=
 =?utf-8?B?dVhUMThmWnNuU05wb3J3SjZCSXo1Rk9vZUZrUmVIdy9UZ2dZQkVGcUpDVkIy?=
 =?utf-8?B?OWpHNFdlTWg0NnkxRk9IYm9XZWJHVnlEUytnbEIvaFJ4TkFVSFZacmVkK1BV?=
 =?utf-8?B?N1VYNExadk1lbzZTV05iVVpxZ2gxbXV1N0Z6YWlrVHdwWWtKWEVFbFppVzVB?=
 =?utf-8?B?aWtGa1p6UWpVWWJqZmh4Qzc1cFZTSlU3MSswdHVUUDBPRjVQR2QwOHQ1UUR6?=
 =?utf-8?B?VVY3bGdUSmxLbzVBREQ4TEVLcVNkaTlxbVl0aHArSjEvTFV2M2x4dm1zcWpq?=
 =?utf-8?B?MVFpeGcvd1ZUNUhvNFl1SjUxcVpTdTJtUzZ6bmN3L0trT2tiNFYvd0NPYTBx?=
 =?utf-8?B?SWhESW1qSzU0OVZQMERaK3BMWUpha09tOCtnaWgxcEdDVjZOdFVhMmxWcWZU?=
 =?utf-8?B?R0tRdHFkNXhxRFdXZGFpOXgzWDlHMi9ZZkJ2UTducCtpbnJPd3pIMlhEYkxl?=
 =?utf-8?B?NWkwL3lES1BvUHZteDVhdE0zUEJONnI4MGhCNzl6SWx6MTRUaWYyaXZ6R0pC?=
 =?utf-8?B?SUZwSW5YZW1yWG1OeXNNTmlCRnJpaXdsMEhUa2VpcHJFblhnVk91Mk8yUHU4?=
 =?utf-8?B?RGp2dTMxalE4NGdLRG4xOHBBVzluUllIKzFYVUNnWC9jUFhVWktBQVVCYUZQ?=
 =?utf-8?B?YWhzUndGWk53R3NFK2hsa0dQc0VsVVdzVjlXS3g4VVppUll4QTBzanYraEpj?=
 =?utf-8?B?RlU0UVlqUXltdG9jMnBpNjNZeXhNem9xcHhCazdHd0FNa3VGZDI1ZDVGZEwv?=
 =?utf-8?B?S1ptNHc5QUp3RHBpY2ZBRGc1ZnhxSXMzenBMamY1ak9rRHJrb3pUTXl1amFM?=
 =?utf-8?B?SVM0YlRxSHQwYlEya1hpYXYwemRlOHRCRFYwSmVHTlovSERSbW5hKzZrVG5H?=
 =?utf-8?B?NFNydUdFT1ZpbGlEZ2d5Uzk3STdDRnNKN1VRU3U3VVU0VVl4R1oyTUhHdnNi?=
 =?utf-8?Q?sHj2+j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGZSSlVScTc0Y2NSNDdYeUtzQ0xJck5zMGJjQjV1NmpsSUc2MkpmQjhXVzBx?=
 =?utf-8?B?c0ZKQnpkL1BxcG5ETk5Rdk5Oa2paL1FyOFF3UzRZaHc3bSt4ZDE4OE5xa3ZS?=
 =?utf-8?B?UWQvcDRvbExnVE40UTh2SzJpbFBORkNYSkxvK3E4LzRZKzdNSVF4ZlZLTGtD?=
 =?utf-8?B?VkhmUmlVYVVCcnFBcDMzZlFFNnZ5WHRKc3Rkc09NZVBUOFp2OERlV1ZpbmVS?=
 =?utf-8?B?VHJJbDd1Zy80dzFYZzRaVlRnczhvMXhDVWp5S1kxT2JMYnZmQjhPL29QbFhj?=
 =?utf-8?B?SFpJUU9Sd2ZHZUtlR2pRR0tDU2NxKzFpa1RUVW42V2syR1ZoWG9hKzhJM0FU?=
 =?utf-8?B?RkRkZ3RSUmRBQ0ZqeG92NVRBN20rSE9EV0kzeUgwNUdCbzg5OVdFSmxiTGFU?=
 =?utf-8?B?aTFESFBJaTFTaTN1WWo0bHljc3Vsa2NDdHo3QTFER1JlNllwOEJlZ2xHT013?=
 =?utf-8?B?bHZWR0NFVTJhQkNhUmJmUFh4NExlTmNuVlYvWmZMMXd5b2ZuYnVmRVFTWU9o?=
 =?utf-8?B?NVpmTmlNMkIrYjZVWkkvaGpuU1RZZGc1cnRoR3krOW1PTjZvOEhkbWI5bkRp?=
 =?utf-8?B?eG1RdXhmZUpMaXB5Qmlpakh2ajF5eEc0bmw5R2dNL2NhZTB3UFU4M21lZ1Ba?=
 =?utf-8?B?TThzRzNxbUM5U25IZWROSVFVQVdaWnR3SGsyMnJZSmxMMHBSakl2U00zYklH?=
 =?utf-8?B?VDYxenMvRW5qc0dVWXpjbGN1MU9ld01kOTV2cU8zOXNiM3ZjeXhadVRmVUZi?=
 =?utf-8?B?M0U5NGNoVW1WRDJWMENKM1NTcWxuMHBhemE5VkdwMG1ITUFldW0xblVJWU03?=
 =?utf-8?B?KzZYUy9ncXBWaE10cm9PRmJHSHNHdU1NMDcrQUUzOVZvYWwxUWk1Mko4S0h3?=
 =?utf-8?B?U09IQkNWRy9NQzczQ2Z6WVp5b3lPUGlCUndDd2trbTRYRjZ4RWJuZ3FwRjkw?=
 =?utf-8?B?M2ZpL1BsZkhiUGJUS3NFWlBJWDFnZXRSM3RsQlFCdHViaDZ3M0NPTDJWeXh3?=
 =?utf-8?B?M2pvRElwNFREd1lvUGxMbkpIL2R2amdMNExBamJiVS8xbG9IcWpQMGVxUlhQ?=
 =?utf-8?B?Z2dHZ2NldzU5cUl1cUVObmZqSVFsaWUza29OK2ttbDdmdDZVN2IyeUZGRnRW?=
 =?utf-8?B?eG1lTFBCcFpXYjhsOEFDcllYWjM4a2cwRnBKSXZudnl4d0F3d25uelNiYndn?=
 =?utf-8?B?UkpQdDhKazNtNEJjUyswV3JNdVIyQnM1MUtkNDBUSkxpdGpBdTlxUEJqZUlR?=
 =?utf-8?B?N2NMeHNYYmx2NCs5WmJRNkdVNDNpYmpVU3V3bjd5cXNlSXh0c1J2c2cxZjN1?=
 =?utf-8?B?SG5YcURreTFKS2JkVUVaMGpDMTFCbEh1ak00NmxpRk13c1Uya1NVdDgwZlBU?=
 =?utf-8?B?dVJ5VHZycklaVVMyRXJ5L1Y3Zkx6UjJRbHNwdWkzb2V2aSs2Y041OEdUbkdZ?=
 =?utf-8?B?SFNUZkhIdGxaRGsyRGtTcDJMS3JCTzh0NXU4S3FRYmNseVF4UGZhM0pEZk9G?=
 =?utf-8?B?eUpZbnNIRGh1LzhTYm4xSHVLaFBJajU5NnFpTFFIMUlPZ2lJUjloaHlyYUgr?=
 =?utf-8?B?Qmo4S1BkNXJxNkhCWm9VbzI5ellHS0Q1QXhTeUk5d1IyUzMwN3NMLzdTTFpS?=
 =?utf-8?B?OG5tcUhEYmdMZFl6cEtsVkZ3V3l0WnkzRWNRcTlsTkFCMzRWMDg3N3BJZ05I?=
 =?utf-8?B?VEx1TGdCZVc1WFZFTTVQTE1PWDdpZ1AzclRBWjlhaVh6a0tBQWRuNTZoOXFZ?=
 =?utf-8?B?bFhxVnZKWXd0NDB2TFRqaUM5Q29ncDA2YmJGSURON1REa1E2dENVaHJzcVBH?=
 =?utf-8?B?Z3hMdiszVDNUaFJlL3NzRkFNaTFWT1pWN3JwV0krMjB2NjYrV2NHeGpqU0hH?=
 =?utf-8?B?RGgwN0NNdmQrZis2S05QdGNoWXhMUjhnbWE5bUFOdkdXZ3lFcDRJY2xFVmxF?=
 =?utf-8?B?NWlqWTN6dS82a0pJVnBka2JsVzZ2Z1Z5QU1XWnpjcGJxRTNXV3N1N1AyVEY1?=
 =?utf-8?B?NmxXa1p3SGNUVmRwUW0xT29UOTdOUk1BeUhtdnBkWVY3Qk9JanpISDJQMmh4?=
 =?utf-8?B?MlBnNGw3OWh3YXRjMG5Bdjh2eC9jQjhjRVI4OW41WnBrblhJVHlHRGFQK0RS?=
 =?utf-8?Q?nvII=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b639b35-b366-4439-61ac-08dd89162ff6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 01:10:54.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6nlCXVnmJQq9eYja+fuzaMnUJAXKVUqYbpflergd/ucMGadxRB4mWGfxszO75Rq+sJCxcHrl+W09/ZR5l489GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8716

On Mon, Apr 14, 2025 at 02:30:54PM -0400, Frank Li wrote:

Marc Zyngier:

	Do you have additional comments for this version?

Frank Li

> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
>
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
>
> Original patch only target to vntb driver. But actually it is common
> method.
>
> This patches add new API to pci-epf-core, so any EP driver can use it.
>
> Previous v2 discussion here.
> https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/
>
> Changes in v18:
> - pci-ep.yaml: sort property order, fix maxvalue to 0x7ffff for msi-map-mask and
> iommu-map-mask
> - Link to v17: https://lore.kernel.org/r/20250407-ep-msi-v17-0-633ab45a31d0@nxp.com
>
> Changes in v17:
> - move document part to pci-ep.yaml
> - Link to v16: https://lore.kernel.org/r/20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com
>
> Changes in v16:
> - remove arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file
> because there are better patches, which under review.
> - Add document for pcie-ep msi-map usage
> - other change to see each patch's change log
> About IMMUTABLE (No change for this part, tglx provide feedback)
> > - This IMMUTABLE thing serves no purpose, because you don't randomly
> >   plug this end-point block on any MSI controller. They come as part
> >   of an SoC.
>
> "Yes and no. The problem is that the EP implementation is meant to be a
> generic library and while GIC-ITS guarantees immutability of the
> address/data pair after setup, there are architectures (x86, loongson,
> riscv) where the base MSI controller does not and immutability is only
> achieved when interrupt remapping is enabled. The latter can be disabled
> at boot-time and then the EP implementation becomes a lottery across
> affinity changes.
>
> That was my concern about this library implementation and that's why I
> asked for a mechanism to ensure that the underlying irqdomain provides a
> immutable address/data pair.
>
> So it does not matter for GIC-ITS, but in the larger picture it matters.
>
> Thanks,
>
>         tglx
> "
>
> So it does not matter for GIC-ITS, but in the larger picture it matters.
>
> - Link to v15: https://lore.kernel.org/r/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com
>
> Changes in v15:
> - rebase to v6.14-rc1
> - fix build issue find by kernel test robot
> - Link to v14: https://lore.kernel.org/r/20250207-ep-msi-v14-0-9671b136f2b8@nxp.com
>
> Changes in v14:
> Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
> a result, the approach has been reverted to the v9 method. However, there
> are several improvements:
>
> MSI now supports msi-map in addition to msi-parent.
>   - The struct device: id is used as the endpoint function (EPF) device
> identity to map to the stream ID (sideband information).
>   - The EPC device tree source (DTS) utilizes msi-map to provide such
> information.
>   - The EPF device's of_node is set to the EPC controller’s node. This
> approach is commonly used for multi-function device (MFD) platform child
> devices, allowing them to inherit properties from the MFD device’s DTS,
> such as reset-cells and gpio-cells. This method is well-suited for the
> current case, as the EPF is inherently created/binded to the EPC and
> should inherit the EPC’s DTS node properties.
>
> Additionally:
>
> Since the basic IMX95 LUT support has already been merged into the
> mainline, a DTS and driver increment patch is added to complete the
> solution. The patch is rebased onto the latest linux-next tree and
> aligned with the new pcitest framework.
>
> - Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com
>
> Changes in v13:
> - Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
> - Change request id as  func | vfunc << 3
> - Remove IRQ_DOMAIN_MSI_IMMUTABLE
>
> Thomas Gleixner:
>
> I hope capture all your points in review comments. If missed, let me know.
>
> - Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com
>
> Changes in v12:
> - Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
> irq_domain_msi_is_immuatble().
> - split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
> - Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com
>
> Changes in v11:
> - Change to use MSI_FLAG_MSG_IMMUTABLE
> - Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com
>
> Changes in v10:
>
> Thomas Gleixner:
> 	There are big change in pci-ep-msi.c. I am sure if go on the
> corrent path. The key improvement is remove only 1 function devices's
> limitation.
>
> 	I use new patch for imutable check, which relative additional
> feature compared to base enablement patch.
>
> - Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> - Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
> - Remove only support 1 endpoint function limiation.
> - Create one MSI domain for each endpoint function devices.
> - Use "msi-map" in pci ep controler node, instead of of msi-parent. first
> argument is
> 	(func_no << 8 | vfunc_no)
>
> - Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com
>
> Changes in v9
> - Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> - Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
> - Remove API pci_epf_align_inbound_addr_lo_hi
> - Move doorbell_alloc in to doorbell_enable function.
> - Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com
>
> Changes in v8:
> - update helper function name to pci_epf_align_inbound_addr()
> - Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com
>
> Changes in v7:
> - Add helper function pci_epf_align_addr();
> - Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com
>
> Changes in v6:
> - change doorbell_addr to doorbell_offset
> - use round_down()
> - add Niklas's test by tag
> - rebase to pci/endpoint
> - Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com
>
> Changes in v5:
> - Move request_irq to epf test function driver for more flexiable user case
> - Add fixed size bar handler
> - Some minor improvememtn to see each patches's changelog.
> - Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com
>
> Changes in v4:
> - Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
> - Use new method to avoid compatible problem.
>   Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
>   pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
> remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
> driver don't support new command, so failure return, not side effect.
>   After test, DOORBELL_DISABLE command send out to recover original map, so
> pcitest bar test can pass as normal.
> - Other detail change see each patches's change log
> - Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com
>
> Change from v2 to v3
> - Fixed manivannan's comments
> - Move common part to pci-ep-msi.c and pci-ep-msi.h
> - rebase to 6.12-rc1
> - use RevID to distingiush old version
>
> mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
> echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
> echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
> echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
> echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
> ^^^^^^ to enable platform msi support.
> ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep
>
> - use new device ID, which identify support doorbell to avoid broken
> compatility.
>
>     Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
>     keep the same behavior as before.
>
>            EP side             RC with old driver      RC with new driver
>     PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
>     Other device ID             doorbell disabled*       doorbell disabled*
>
>     * Behavior remains unchanged.
>
> Change from v1 to v2
> - Add missed patch for endpont/pci-epf-test.c
> - Move alloc and free to epc driver from epf.
> - Provide general help function for EPC driver to alloc platform msi irq.
> - Fixed manivannan's comments.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (15):
>       platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
>       irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
>       irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
>       dt-bindings: PCI: pci-ep: Add support for iommu-map and msi-map
>       irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
>       PCI: endpoint: Set ID and of_node for function driver
>       PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
>       PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
>       PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
>       PCI: endpoint: pci-epf-test: Add doorbell test support
>       misc: pci_endpoint_test: Add doorbell test case
>       selftests: pci_endpoint: Add doorbell test case
>       pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
>       pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
>       arm64: dts: imx95: Add msi-map for pci-ep device
>
>  Documentation/devicetree/bindings/pci/pci-ep.yaml  |  68 ++++++++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
>  drivers/base/platform-msi.c                        |   1 +
>  drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
>  drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
>  drivers/misc/pci_endpoint_test.c                   |  82 ++++++++++++
>  drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
>  drivers/pci/endpoint/Makefile                      |   1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++++++++++++++++++++
>  drivers/pci/endpoint/pci-ep-msi.c                  |  90 +++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c                |  48 +++++++
>  include/linux/irqdomain.h                          |   7 +
>  include/linux/pci-ep-msi.h                         |  28 ++++
>  include/linux/pci-epf.h                            |  21 +++
>  include/uapi/linux/pcitest.h                       |   1 +
>  .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++++
>  16 files changed, 544 insertions(+), 9 deletions(-)
> ---
> base-commit: a4949bd40778aa9beac77c89e4c6a1da52875c8b
> change-id: 20241010-ep-msi-8b4cab33b1be
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

