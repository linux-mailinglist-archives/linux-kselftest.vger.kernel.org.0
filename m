Return-Path: <linux-kselftest+bounces-28085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D60B2A4C904
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 18:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3CD116341D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F12D22CBC1;
	Mon,  3 Mar 2025 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RpF4KPH8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73A725D8F8;
	Mon,  3 Mar 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020786; cv=fail; b=s2RB48YAm3YGAZZ7wNIO1vIvYvKfmAogqL2k6fjFeG2ZVB9HbqgvivfEAAUH7YcKcHovGny87S41rq4KHNuhNSSx5zDKsXbr1zBDbqd4pM3w2c3sV7ZLxvUSuBXAuooIdzv8/091LAtadVlwP++AzFbQF3NnYrTuc+m/jVMnxZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020786; c=relaxed/simple;
	bh=jDugEXhhIv6NCOBgsgY1P6aik3up3A3GatAgZ9Q779A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sPQU9StdLW6sZbNg00wxGP/GEBehiGKnWZIB1WqvZwbvKEiGvr66iCSnAJ70ggOxFp3yQ+uKJNF/MtLgHjGbRkz/k3KiRmee223rJ9MyHTUeFLpMIWfHKiQ/CqKbuYkjwm/9zPlaVA1qEDTdZb98ddNz3890Ot0nPVlr+Lmhh1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RpF4KPH8; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itUafwMjUKkFZuCJT2IFK4Ye+bL6XdDyl2iDWb1j4IfrmABL0cIBLYMnIaDndfB9ZrRBaLGn6JaJko6hWUFV1MYaHnrUewGmgyzw5fp37IZuv9lijXHzAZpOmLgbVtIr/oB3hOKOhBFfF7gskWyMAo+TWh9Xorkr0ke4p1FlQDSTzRFtwR8D3oQEVsLPp638va8G/ev121Y8HR0vrPSJc2OQbGz5knJ/zLVZ4wjUpljWX9nXUIZyTah4Vx1Wd6U/uEFNBzMs3QisAczt+tljP/no5t0d2hKZA6QdBT7+b5tqmq4vIRv/XxwYnHDIbnFKev6isVfrYmToGAX+WnORww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+v/1Lkds0Vv5rwuL9MbYPnHfUe94Fg8Ezdzqwn4r6E=;
 b=w/R/C6eULBrRhEur44AT8xFeyA/AzXuzmKwZbUo4MsPIP1v8Lcf4+Fc9Dqq87dOcVAhjLtqvyYjn89lPBY4b/WoPyONoO6obnhuSqpTcM97UAQnZdtO2+2hKZBZqAAnSb/GncfQHJ0l41ehZHs20zHNO2O6w587JEcBGZEZKLKCmFjHf4vl323J3bWQFPFAk4O5hPQGIzqHLtf36QigFyblYtlowDaPj0/VJnlSbxwhUSajHwxIIXaUbU8abw1D892R9COiw7/p+ZGtbMad96qdXRlxMBs8wg117aEHZEPtLSEB+TWOm0hXZ08UISoVhvfMwfq/9USEhyJSoMC5IWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+v/1Lkds0Vv5rwuL9MbYPnHfUe94Fg8Ezdzqwn4r6E=;
 b=RpF4KPH82wI9pY1hMIKxkb3dsstXb8aVQqk3HPt8/2x6O2nE3hDi10O7aLpzxaA+i8WySc9QGgf+YNaxnp8czR9ZiLgJv0Itdez/n2CLA9UGA1Epl25+QoEdoSTJ/xsOju8TdIwiIBKNogPknMKSyxN7UbMSMwovNxDWX6fSLCBU9VZaPlsLU9SetEMF4TkWITEJhHxW1Wyb1iiqGa8SrDWC2e3kL2QZ6FNpq5MD9lWq5coUslo4rZablaTmZ3mQbanLpNf+N23LGK0LfIQAsxAPhpqqPS1qCLjZK4RTztMR0tqG3SekFBr/fXMWMQ+EyE8IM+h8MKu03psNDZT3yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9569.eurprd04.prod.outlook.com (2603:10a6:102:24c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 16:52:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Mon, 3 Mar 2025
 16:52:58 +0000
Date: Mon, 3 Mar 2025 11:52:47 -0500
From: Frank Li <Frank.li@nxp.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>,
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
	Conor Dooley <conor+dt@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v15 04/15] irqchip/gic-v3-its: Add support for device
 tree msi-map and msi-mask
Message-ID: <Z8XeXxg5WhDpcAoo@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
 <20250211-ep-msi-v15-4-bcacc1f2b1a9@nxp.com>
 <86o6ylouc5.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86o6ylouc5.wl-maz@kernel.org>
X-ClientProxiedBy: BY5PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9569:EE_
X-MS-Office365-Filtering-Correlation-Id: b57c93bd-39b4-44a4-bb83-08dd5a73da42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTFWR3krTDNsTXIzNjRHM0JKdnlnS21xbGxsUlVBMU00V25MTnR6R1ZNN3o4?=
 =?utf-8?B?VnJSdUx2NW13bkdXQmpHK1V1TDU4M1JKTG85akdsekRzZ3R4dmllOStMUkFl?=
 =?utf-8?B?cE53UmVSL2M0L0daajR6SUJSQkp5VnhEM0N3YXVDd2lUZm9waml2ZTJLbWd3?=
 =?utf-8?B?TGFJQWdyUmhGT1lkODZPN0owd1dNQUE5SlZMei9iYmhMNzRPanFiTC9qSnBs?=
 =?utf-8?B?V0pZT0IvMFNqeWxDaU5EQ1FjZDVyT3FXdDZHSGRKS3EzVHhQd3k5cldZVFJN?=
 =?utf-8?B?VWUxc0EvTTdQZlpBcXA0MGtDV0xxM2FPUTdLME96SzhVRHNrRUxRVjFsbTAv?=
 =?utf-8?B?K0tNUit3L3VsM3dmT3YrUlhmeXVUOUpUQ1ArcTZGUVN1bjRZdytDY2U4L3F3?=
 =?utf-8?B?ZXlScUhRaE5CRU0zc3BKeGJvTFZ3elNMaEJrUldDL254WFI1NitpVkhORWRC?=
 =?utf-8?B?RlFTRmZUOUpOYkZTZ0t4UUYxQU1OQU5MUGY2UDdFTWJ3T0dwc3RTNTBZblMy?=
 =?utf-8?B?TFh3M2ZRVFBsdVdya0s0NDBGN3oxdEplWkk5WG1JcFgyeGNWN1BUMlNZNVlP?=
 =?utf-8?B?RTRVQWdNWkNldXdYTlhZMmxiZ1JtTHhJcUk3UE1MSm1RYWYySGxLZ2VSMklv?=
 =?utf-8?B?eWxZUmdFT01wZmkzWGp2NVhpalVmMlA2YWhSWUJ5bGdKM2c0ejRjODB2djJw?=
 =?utf-8?B?NnVqN0tnd0JWdmtzWWZqcjVraFVpcmNXc0VudnZCU00vVGdSbWFCVWczTFNL?=
 =?utf-8?B?S2V2QXUvUHhLZSs3VTNrNEJkZko4MW9FQ1h1ZXNnZGRkdXViVkNwRjRMZXZr?=
 =?utf-8?B?dzBpTXNhUFhnVWljYUYrcjJ2NGdSbnJjcFRsU2F3b1lrSkgvUXZyR3Q0Kzc0?=
 =?utf-8?B?Z2tQc0ZYNWxZQlRKU1FNSVlzUzNLcmVla0R6SVRKZjJBSVlCUUxnVy9reWpy?=
 =?utf-8?B?VEF4VnRKN1liQURaWldXVHkzVW1ob3g3UlFkOERIZDZ6SHVHekh4T3pRcElq?=
 =?utf-8?B?ejY2SE9DMmZyQTdxclVtQ05qT05DdnBCbDJIb084MVBhdDZGaFhPSVV1Mll3?=
 =?utf-8?B?UExvZHlWd2xkSmJIS0dSMExqVDNuZXVYVWM2dGFVa29ZaGFYZkRRNXQwWlZC?=
 =?utf-8?B?N0xNZW4xRDFhV0J5aUVycjhUaEZENDNWNWpPY3VyZ2JzTWgrOHVleHdxTWRi?=
 =?utf-8?B?ZUZQQ2pNU1Zkcmp3Mnp4TDJOVWQwTUhvUGtyMWhEUHRLd3pZUEZCNngrRjFa?=
 =?utf-8?B?VjVWcEpHMjY5Y0l6eS9tdlZPVzltZktBL1Z2WVJSamQxV2ZuVnAwM1NWbUsv?=
 =?utf-8?B?V3J1RDFuNGNGWGgyZzJpdWpTcU0xZitxbnh5VTlhdEU4SDBaeXQwUlFDNG5G?=
 =?utf-8?B?OW1LQTRBc3FkNmN3UXBBOHpmNWRDWGE5SjFGNlNvMk41QytxNW8vM0N0cDh2?=
 =?utf-8?B?cDdYcXpmY3BLWGwvZ1JybnZUZ3FVQTV0SEQ4bURiWko2VUozaWxLVWYvaGVP?=
 =?utf-8?B?ZXJmdUhQdFNZY216d1MrdlhYMGNJOVpEZHNLeXpOa0NYb05jcGdDTmpNMms3?=
 =?utf-8?B?VUNLdE9GdU9hUnNNQWtTc1RPNDNFU0pDTFo3d2pQVGF0cXRHbEtXdzc5aUFT?=
 =?utf-8?B?WWxBc0ZMQnBhM1FwalNhcmNvKzFTcUlzVDRZaEd2VlN0Y0JISkdqWUVjUTBy?=
 =?utf-8?B?bnJYTmk2bTdxdTY1MEF2ZW41YTdyWjlMczZvaE1oM1ZKK3ZkYlRoZVUvdjZO?=
 =?utf-8?B?UmtNdk5KV0M5RzJ5Y2Q4WWc1d0NuRGk2eDhvb0RmNEtPN1F1YWNmcEVDYk9G?=
 =?utf-8?B?UEExaDNzeDZrT3dqWVJYSWtBRm1DbEQyMjVBUFpabDI5ZFhFaW5jeWZZZGdU?=
 =?utf-8?B?NVd5S3NuSFd5UmgzQ2xkQXZyNkV1d0dRQUlBK0syVTJwUjZuYzEwbERDcVBZ?=
 =?utf-8?Q?z39a0GpsfqCeruucKWY9EUf2zKzy8Upg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aytqWkE3TUdBc2FZOVhzbUhGMFpLZ2cwOXI2bmFRZ3VRRGQwanM5UmkrOUN1?=
 =?utf-8?B?RXZiWjVLcEJHTmxRMFRHZVZVdTN2MVM2MUJlT0R5VW5OaHRDY0NuTHhqTUYy?=
 =?utf-8?B?VHp6NFl0VjYyRTRhVWJkK210SE0yR0Z3VDQ1bmRINFB2WXczVjk3UHR1cWlX?=
 =?utf-8?B?T3lxc0JMRlpFd2plN3d1ZDVWQURlWTM1RXFIR2UwaHBhc3pHRUl3SUNOaFgx?=
 =?utf-8?B?RnZCbE1HQWlSeWlIQVdPS1B5NjhXbnJDRk5tSHlMQjhJenlyYWxoTTBYR2cr?=
 =?utf-8?B?ZkErRzkzV1lCN2dvOUJhK1BudFNFamJvN21VbUJjUm4xbHRwRHNGZFEvRVRK?=
 =?utf-8?B?TDc0dFdFdXFOZkRmZFFDcklIWjdRMzFyYkJCV3dyM2EwbzlaeTRPbEQ0ZGty?=
 =?utf-8?B?NmFobGpKeUtlUkN6NSsxK3NHMkorVDdLcjd0QVhlTzFVL28vZWFvR0NndGl5?=
 =?utf-8?B?MzF4ZlIreEVNd2NXRE5zM1B3dWhiQ3JCL011S2JkTUllRlpTNkQ4cXVLbG82?=
 =?utf-8?B?RFhheFhTZm96ZGJlUURaaTAzOVBOSW81V1FlaHVoMnVOM2daT3lGYlM4dDJQ?=
 =?utf-8?B?b3dxbWUwN2tvZGJnK2xNN2RTS3cyRVprLzlXYVV5YXI5QVlFSHp5STNaNmV5?=
 =?utf-8?B?ZStISXVNdkNjOFhUWmlqaWVYQTNUQzFENTJHcGpzM2pYb3FYSjEzVm1wZnpY?=
 =?utf-8?B?MDlGcVFBN0RYQXVlUWxsTnA1by9TMHpsdXZFMkxkT01nQjlSK2ZMSVZTL0E3?=
 =?utf-8?B?anhIdEJzVzRrYVBqd05TZHZqOHIvTWZMd2g3d3dzYWJPMHpJMlE5MjRFRExy?=
 =?utf-8?B?UkkrK0FXYzMzTTJTOWY1N0RLWDIrU1F5ajFXOTIyeDliSjgrTXRzcnlQWlkv?=
 =?utf-8?B?MGFldSsrTFRwaExWS3ZuYmx3dTBJeEIxcHJvUkZiUlpNbitoMWxmbnZqUWU5?=
 =?utf-8?B?MjlyaGxRS3pqRnAvbk1XekZwOXBlZ1NHWHlXSHdwRnQrK2dBb1BINHRNb2V5?=
 =?utf-8?B?RFRWSmZMZ3AwcGtBbzVkaFRCb1FsOWdNY09mdzBtdStXSUpyaUYxNDllSnF1?=
 =?utf-8?B?QmxFeTd5c1kzQTBvMDh2OUFZODB2b0ZFSS9CbWZCVkVtdFR2ZVQweDYyM2hy?=
 =?utf-8?B?MnhTS1VCbXlDZ1B3Q3FrUzlEUDF2aXhZRlBBMFNCV2xtcWw1anRkQTJPNUlU?=
 =?utf-8?B?bk5WWUV3VWNMclJXcUtZZGwzQ0dxVXoxWWxCSVI1NXdobFVQdVVVVy93Zm9w?=
 =?utf-8?B?M1NFOG1IaFZHZXBvNVk3cWI1bm4vNi9BaWtEbnNFQkRPMEcxR0VvVEYrTkRy?=
 =?utf-8?B?b25LSnBGaG5QaDJPVnhDNUNlZ2c3aS85RXBQWG52Wk9nUkhHK1pTMkpkdkZG?=
 =?utf-8?B?OE05OWRldmdjeUlxQTM2RTFCNDdYYmg1U28yMmtZaDIveE1vejc1L0ZLTUda?=
 =?utf-8?B?RGNwZXZoditVSEtOa2JRQWphYUNwbE5FZDl0NTZZMWNSY0ZlMTZSWGFWek1G?=
 =?utf-8?B?cXIwV1JUZkJ3SU9PL3hHSTFLWHNCYXYzK3AyZlVYSkxXUHo3Q2c5WUVWSWNI?=
 =?utf-8?B?YjV6RTlPQzYwWHBWNHVxTElwTW9LZTd1WU1qL0cvQW5GeXBDN0p0d25PMFRK?=
 =?utf-8?B?VlFaTEJBeWx3MDQwOGRHQVRJbytVWHNoWHNqYVhTOWN6RE9MWVBZbmFzVDJx?=
 =?utf-8?B?Um54ZXRhYU9jbXVNTmhoK2tGeGNVbWFvQ2Jxd05KandYcG1qTmNxNTkzWEFp?=
 =?utf-8?B?RGltc2JTa2oyeWd2US96YkYyNkZoR1puMU9LYUpQZWtXVkRJTDlqZmNnNUJr?=
 =?utf-8?B?V0JRVHVoS0NXQjZLWnl2TnB6WXdtc1BlUkU5MWFvQUpuK2RZeWU3cm9QQjZR?=
 =?utf-8?B?ejQyazdTNy9iTkM4cW82K3FjaFpMMjVQQWNrWGR3c1dRMzJ0bHR0TmdXY2t3?=
 =?utf-8?B?TnpJVGNVek9MTHNSWmtvaVc0Y29SWGRvRHVRaWZpcEs0U2thOVlaV3pCQnVu?=
 =?utf-8?B?bXBFakJTU0cyQ2JhRzJZK3p5VnpBWE5MSlpuSk5WNGxJVWFYRHNyQjc5OHc0?=
 =?utf-8?B?WGl0MFZJREFNTHRWOUJXd2FrT0J1YWYva3liM29DL3lwVmgrQkhSMDNSTU5i?=
 =?utf-8?Q?dacc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57c93bd-39b4-44a4-bb83-08dd5a73da42
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 16:52:58.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMVC9tLjz+gyKZ0oZ2C+VcObZ9XCOuVGzql8Q+S30b5FxrrbBOfDrj4IiD4k7UErmMr7wFL7ZJWCjqhwgr2zWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9569

On Sat, Mar 01, 2025 at 11:37:14AM +0000, Marc Zyngier wrote:
> On Tue, 11 Feb 2025 19:21:57 +0000,
> Frank Li <Frank.Li@nxp.com> wrote:
> >
> > Some platform devices create child devices dynamically and require the
> > parent device's msi-map to map device IDs to actual sideband information.
> >
> > A typical use case is using ITS as a PCIe Endpoint Controller(EPC)'s
> > doorbell function, where PCI hosts send TLP memory writes to the EP
> > controller. The EP controller converts these writes to AXI transactions
> > and appends platform-specific sideband information.  See below figure.
> >
> >                ┌────────────────────────────────┐
> >                │                                │
> >                │     PCI Endpoint Controller    │
> >                │                                │
> >                │  ┌─────┐   ┌─────┐     ┌─────┐ │
> >     PCI Bus    │  │     │   │     │     │     │ │
> >     ─────────► │  │Func1│   │Func2│ ... │Func │ │
> >     TLP Memory │  │     │   │     │     │<n>  │ │
> >     Write Push │  │     │   │     │     │     │ │
> >     DoorBell   │  └─┬─┬─┘   └──┬──┘     └──┬──┘ │
> >                │    │ │        │           │    │
> >                └────┼─┼────────┼───────────┼────┘
> >         sideband    │ │ Address│           │
> >         information ▼ ▼ /Data  ▼           ▼
> >                    ┌────────────────────────┐
> >                    │    MSI Controller      │
> >                    └────────────────────────┘
> >
>
> Please stop using these figures in commit messages. I don't think they
> help, and they are not in consistent with the way the commit messages
> are managed.

Okay

>
> > EPC's DTS will provide such information by msi-map and msi-mask. A
> > simplified dts as
> >
> > pcie-ep@10000000 {
> > 	...
> > 	msi-map = <0 &its 0xc 8>;
> >                           ^^^ 0xc is implement defined sideband information,
> > 			      which append to AXI write transaction.
> > 	           ^ 0 is function index.
>
> What does this sideband field represent?

ARM ITS use term "streamid" for this sideband field, which indicate which
MSI consumer write to address/data pair on bus. Such as PCI1 or PCI2.

> How is the ITS driver
> supposed to use that data?

ITS use a as devid, or info->scratchpad[0].ul = dev_id;
msi-map actually given a start dev_id (it is 0xc in example) for fuction0.
function1 will use dev_id + 1 ...

> Is it the full devid as presented to the
> ITS?

Yes,

> Something combined with the "function index"? Is the "function
> index" a full RID, as defined in the documentation?

Not a full RID. RID is related with host PCIe's topology. The EP function's
RID may 1:00:01 at PC1, 3:00:01 at the another PC.

So Endpoint driver can't use RID directly. It should related function and
virtual function number only.

PCI define 8 physicla funciton, and 64000 virutal function. Define device
id as vfunc[31:3], pfunc[2:0] as msi-map's input. DTS provide information
how map it to real streamid.

>
> Also, msi-map is so far reserved to a PCIe RC, not this sort of wonky
> contraption. This needs to be documented.

Okay, I can update document.

Frank
>
> >
> > 	msi-mask = <0x7>
> > }
> >
> > Check msi-map if msi-parent missed to keep compatility with existed system.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change from v14 to v15
> > - none
> >
> > change from v13 to v14
> > new patch
> > ---
> >  drivers/irqchip/irq-gic-v3-its-msi-parent.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > index e150365fbe892..6c7389bb84a4a 100644
> > --- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > +++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
> > @@ -118,6 +118,14 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
> >  		index++;
> >  	} while (!ret);
> >
> > +	if (ret) {
> > +		struct device_node *np = NULL;
> > +
> > +		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
> > +		if (np)
> > +			of_node_put(np);
> > +	}
> > +
> >  	return ret;
> >  }
> >
> >
>
> Thanks,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

