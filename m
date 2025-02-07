Return-Path: <linux-kselftest+bounces-26037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DACA2CCCE
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBAD3AC01F
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FDE19E7F7;
	Fri,  7 Feb 2025 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YqjAXZ2T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D71219C554;
	Fri,  7 Feb 2025 19:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957261; cv=fail; b=BT7DLTBYoyEpOSz6mkitUzpz/TOGQPJOnO0+kkgdQXXNZoWy22h0OuWzNfNWuadkk6dz71NcjakYlomt4JeoQZNnDgQNCPaGcbI7aFeVDON/EUq8hIyO/JHGpUeaBhh7/TpQCp7lWLAWdAlqQ1Kyy4eijHRB27WKNolJ03B67F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957261; c=relaxed/simple;
	bh=UTWSQ9BYud4VdJmQue4uH88S+Q5amwr2z4IDdmIuKug=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K30cff6Taentq+ZZiN9XVm/b8Fl7YIDcBxfvqhgv6EZJIEOU4jHfCIXj7YLCmosEJVJBFYp5qgbdhk0A2RBELvoIz6oFbcemuYbTrg3y8leO7FMxLfTHnYRuApSdEBTTFDGKD6bZFwDLIpTazchknGc5UWlE1Bb3VFtVApjmm2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YqjAXZ2T; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DP1kMmUHHKJ3TEA1Le4DolfzggpBIjfaP+oRg4qxQAeJq0o82mbutfMQjJdW0Ipnu50LFF3DI2HISfr1eY9lDm50OPo93BzMf5njM/PrL/X6C2DS1M9NRVpUKew5K239F0vDbUsv8OHYwXbcsO7eILC7/qu+SPXDE4oLQiaElFWmySk/wXXZc8e8lnuWMHCyeD++Nxyl7PgAmOVS+LMrur3xtwGeROVq99LLsJOtbQZOpskhc1myRBKdG+bb7qtoA7Xgjc173sWmP5G45soLtIPLwoGMTomKUAnFfL0u5qQlFUBDCm9zYnJgU7WIXIeYULI3Lu3RKZlZjdv+UytwCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11zjesIx54hnVOJZBhLgNcOrc2hK/+UJ5cRfpoOaclI=;
 b=BKVeBVHO/eanpvyA1GX/eKh5ONuCnAZ9VnuTgsdJgqZ/VIgIctWXj8c3Qu1x58MVUbBm8DVVXvPBwK7GNORVOA3sLhpQGgftI3WsJ5Tae/FHRf+e3uKJ9UZOeZPRnXl5jlyD5X7gXcqN+AQFk6H8Y8rAZtFj1DN+P6Y89Ks2+2IUQdyYurgJICYlhzNDgFxQuLLn09aWQQXAMSAn/bc3J6HXqogLiFXq+/sFMzoG7Kr1GpqHZ6Qzxy/hRxiRuwLr+OUKIeMTkPF4JqGYJO/ziwxwBu91VTpn/s0oHjDx99HfoKxY9iDxDvLFPJ1cB4enoQPieG04teMWPuvG6LiWVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11zjesIx54hnVOJZBhLgNcOrc2hK/+UJ5cRfpoOaclI=;
 b=YqjAXZ2TmqfNXlCEOV396A5fYL+cEEOLrtpFyfAYolemMmn9nu+9eFSG18VNrJpt6IR+gmrIz+FY2B8G9mfMlCVzVHTMBPECQeo04bNjl3UrGOHMyqfROH3qQkCpyqNIzHEpG12tUeKUrrD/JthoMgjXqx8OgWYzozGFaMzdYR7DtJ6sgy5myTF9//BDgmr7TlEt9RhCAEB/cI2obQkoQoIx8x5LNUflqEvxjUGkHDcQuzxKaF+VkDdW2Em21Flb7+r7PVIVq8e4rMfizRddqKN0TQ8To8dRr0O3rkTpVEyciysttReMs2WKvt7PGpvSYd0/LDNYLjpXJhO/OTpeXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:48 -0500
Subject: [PATCH v14 06/15] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-6-9671b136f2b8@nxp.com>
References: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
In-Reply-To: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=7112;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UTWSQ9BYud4VdJmQue4uH88S+Q5amwr2z4IDdmIuKug=;
 b=n+Xjvxy1/5l+3NC619ONrimmMueTq/mbDNy4BM4ztHU03vEvKIq0fJMBkhfApxMSSGOCP2o5U
 YKakqfkL9JiDSmJgOfjoVoBuJyOE+xBCOl4wyxrvOaRLo71TGiS6dTm
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a505ec2-d33e-4c88-3764-08dd47af5723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU5HS3RZS3QrY1I0RWJyRXYvVkwwTmI5RVdLOHgwTjYwMGFOZGtJN0hHeEtq?=
 =?utf-8?B?aVljanNFSlFONDlhNEZmTHYvNWRCQUpjRUk3dWUralpDWi9EYW1jYVR2RHA5?=
 =?utf-8?B?dysvT3YzVVZEQXYydVlQUDlKRVBkcVZRajdrU3R4eUxyMXJENTVxUnNlVGF5?=
 =?utf-8?B?d3hoWFB6aWhFcEx0djBndWtJK2toekczaGhBaHNrZXVkYjVVbzArQklJdjN1?=
 =?utf-8?B?blJWbWxNM3hvU1RFNlV5YkxwRGxYeU0yM05CRVFoMWZWT1cvbTIybFNXVnBM?=
 =?utf-8?B?b2tKWm5ZY1BWY25QUFEwWjZweHNNZndtUWNhYTRiZGNlMmEzSUl4a2dTSU9y?=
 =?utf-8?B?U29JVHlEbFJDb2ppenlnQUFILzNhYTlQaWk2blUwOTFhT01aT3dqZ0pWNUNr?=
 =?utf-8?B?ZHNjR0FFVlFwUmRnMGtEeHBGaFdvaTAzdjVMZU4rRjg1dGtIUEVlVkJVSkRW?=
 =?utf-8?B?Zk9TN1dubTh0RERHQWJXRUQ0d0NnRVBGNTN1cTlXMldJTU5SOVpyclNxSFVE?=
 =?utf-8?B?VWVLMkg3Z2EwVldabzk1WmtPaXBPU0RydHY4K2pVUVdiZXNkS09FWEhmWGxL?=
 =?utf-8?B?dnZNbm5kdWh0dTVsMEpDeDJtclhoN2daamZqcHFuYUp2aDJxdGcrZnhVays4?=
 =?utf-8?B?c2wyZEdrZ1gxeGdWQUZEeEtma1ZCazFEVWNTTGQ2RkRpYTNpWU93WG9RaGpy?=
 =?utf-8?B?b3VSbnY1MFJYZkFYNEwzNkVZTE9VTTl6N2pBWXB5Um96U0RBcWRTcGxva3lm?=
 =?utf-8?B?eDdpcXBhVHBDTEFCUFl6SUtEYlJZQkFWNDVRWFRGWXpEVnZ2VVEzOHpuZDYx?=
 =?utf-8?B?Sm1la1BpNmRMRU1oUTdFQWNiRWxCajg2OW5JTnFWNlN4ekNOaHVkdFgxQkdm?=
 =?utf-8?B?cW80WTRFSVlrcWhORURnU0ovaGhnUVp3UWhXSzNoM01haUd1LzRjelZmQ1dl?=
 =?utf-8?B?WVJQeDBaZlk4T0wzMXdKYW5EYlBrSVFKT2c3YnFENDdwbmd0VTJwbDlBTkpH?=
 =?utf-8?B?RjdYYWxWUjFJaG5tU3RFMFVmdVRhMmp3YytEVzRlVTJnamR3eU9aWUxJNTB1?=
 =?utf-8?B?M0NaangxakZEaFZaQ05EQUJLMGp6R0M3Z2wwcDloTXNUVVVHdStlYStCeE13?=
 =?utf-8?B?Sm5RRHBSMTNYMTc1ZTkzSTZNdGFJRjkvcjhVYWhHNFJ3VEZkZUZNTzZGSlZo?=
 =?utf-8?B?ZzBaV0Z3dDFZcnB5QmpkVjdwUnhMZld2T2pVdkRhd3pNb3p1NUY4OC9JRlR5?=
 =?utf-8?B?enIrT0JZU21TT2JCNjJ4QWEzWFVGM2EwTEU3bkVucTNsNHBuTTAzRGpJUUlq?=
 =?utf-8?B?TzNYSExYakJqVCtDbWlrcWEwalVacmJiZWcwbUpFa2FGdzZlako4WW1sRkpF?=
 =?utf-8?B?LzhteHdrSEhOQXgrc3FwSE9pL2dEVUdjQnNzaHF5dEpOYnBJZW4vK0ZlZVY5?=
 =?utf-8?B?ZzRINTU3cy9zUjVhVzlSemJ1Z2lZNlZkZzdGZWtMcVlwMGsrRHdBeVp2V250?=
 =?utf-8?B?OTI4emFUbWpXSEM0Smx1QnpvcHJWS0tTeUh5RDB1YkZaaDA4Z1hZU3ZSemdW?=
 =?utf-8?B?VTJ2N2tyOERzRzVnbzZnWkRvOHAvc1ZyZ2paT2hISUJ5aXhaYmRpTWpRZWpn?=
 =?utf-8?B?SkhjYW5QWURjODdnR2Vna1RRS3ZuODU3VFBFVjhMYmU0Ny9jWEdiUmFDTENR?=
 =?utf-8?B?dlNWcWlkL2VTaU9TMFlZNUJwQ20yRk9FVW1MTlpnS1NKZy9ucXNCN0p0dGVV?=
 =?utf-8?B?Sm9Md2lwcmF3K1BsN0VDWDNxRjZwMm9pdVNjNWg0OEpRdFV0VU1mWjUreVNB?=
 =?utf-8?B?OHJXOW8wNTR1NVlXOWIxV2x1a3RxZzV2ZlhlZldvWnZHUCtCcENoWSt4Nk1x?=
 =?utf-8?B?L1ZMZk85d3A5QjJYWndwTzVjRzhlRzB2cUNGNjVMTmVJRm1YY0RLejI4RmV0?=
 =?utf-8?B?ZS9pNUhqbUo0bHlYRzRPU3BmYkc5cktaVGI1akhWWkNoSFdzcXlRTWFCekll?=
 =?utf-8?B?SUFjNnlvZXJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnlSWmJ1Z05FeUFUSXd1MjVJaEtYWk9ubVdsSExVSzIxRXBPTGU5OW9JOGs0?=
 =?utf-8?B?VGRzVHM5V24wcGhPZk5ieFdGd3BJVVc4bk9UWlRXQmNRalY4WWV2ZTNqMEk2?=
 =?utf-8?B?L3FHYTRPQXFGWXNYbUl1dU9Jc2dlZXphbE5tS2RSczlPTHZWWUlqUDZidjlp?=
 =?utf-8?B?cFlRMjIrd0FBbmJqL3hwRUcrS1RGdFdJZlJVd1djYlcwa0ZwSGpPd3Z6VWdW?=
 =?utf-8?B?V1RFSEdndWs0MyttWjBla1NJQm5HaHlnalBuOGNNSWJlSGVKell3MVhFME4x?=
 =?utf-8?B?RU1qei9DWkNiclE5dDQ5ZW1oa1Q5S3JxZFFDN0tzU3VrM0xEdDcxSEtWYVd5?=
 =?utf-8?B?Y2ZhaDZxaHVIK1VhQjFuMHdidVE2VFIveVVBUzFKL0phQ2p3c3U2aDZmeW5K?=
 =?utf-8?B?Q0V1RHdUUVgrRFNnTmhzNHg2Qk1jVS80M3BMMDRnKzN4Vy9MdEd2MjRlRnFa?=
 =?utf-8?B?aWZXempMYTVjamU5NTNSaktNamVzQW1iMFBiWUdIaW16TE5SQ1BvVzhPcG0w?=
 =?utf-8?B?dUZjbU1US2owMVVWbEMzNFpRSENwa3c5aUpRUUsxVmhMMjNDS25hcTd4VFF0?=
 =?utf-8?B?aURUTGFNZjFib2pDMlVFRTkya0lmOHB0QW5OcktzUXBoZnNsT3lLZmRuVGZE?=
 =?utf-8?B?MlpmQ1Q0NHdqS3pObEh0bVpEQW5WM2pTTW5IcHF2bkNROG1LSVZRelVTQUtu?=
 =?utf-8?B?MlZ6Z3RxSHNISldqdktpNVRDMXNLL3RHMEh3RlNURndBcFZXMHM1M3ZjdDhy?=
 =?utf-8?B?R29udGt1L1dxZVlzcnM1OThnYXBLbGpYcG9tbTFCUUtzK0F4YzE5Z3hJSHpp?=
 =?utf-8?B?VzZVd2pXbkFORktnWnFUckdycklmcXZ4emNONkhjZnB5T2U5N2xVZkt6dmFS?=
 =?utf-8?B?by9reUZHTHc0bDZNVlFGZ090b3hVQW0yaU1DK21RTXl6dGw1OHphR3R1WkNI?=
 =?utf-8?B?cXFxdG1vdE1iRHdSZC9rSjhTWGJOMUdhWmJNL2V4Mjh3V3laWUZPYVc1b1ZV?=
 =?utf-8?B?YWwwbnI2VnlMVG5VaEd2OEFEVXMrVmJEckM0UFZZQkovWERqOUFzUzRYM3pT?=
 =?utf-8?B?Z0hsenhTZm1YYjY2YXNrS1Q2ZEdwVXI3VHRkYkNzK25mUExsenF1TENoajlw?=
 =?utf-8?B?L3g0eWM5WnF0cTdmaEZHckhqMlB3UGlOYXcyVFpYVDdGRW9DV3JxUHJDMk9p?=
 =?utf-8?B?bVdpYUtnTVBmWm9rTyt5K09GWXlzK0xpZ1RuK0pnTkZCajlwZngrVFB5OWNM?=
 =?utf-8?B?YzdrTWNWdkpQY1p3ZFJkTnNaODErVVNQcWJXZG9aR3Q2UUpOenpXOE1DejdG?=
 =?utf-8?B?SG5wdVVqeEttT3doWHFkVmNWWTliSXJnb1d4c0VuajZob2kwSHo2WW5xOUY2?=
 =?utf-8?B?QnZXK242QnJRSVNwOGZYcEJLSjVPZS95ajk3aXBBVGRvVDZaYUd1RkxzVzly?=
 =?utf-8?B?cktBMzdwRkd6dnNCemcwYmRwMWMyTytaKzJqMUlDR0FCekpZaDlEZ1crVm05?=
 =?utf-8?B?VDBPSWdNSlpTSHNKN045Tld4TFVlbi9jNnZyK3ZJbWV1OEd6dk1aMVVIOE81?=
 =?utf-8?B?dUgwbmRLS3N3eDV1aGZpbzhFRERoYUZOeHpvejUwcHJkQnBGNXFtc0RkMDBI?=
 =?utf-8?B?V2VjaWloY3FqaDZtTndLMzdoVjIxVnVaaE12Q3dhU1NYWXJ4V05yWkwzczdD?=
 =?utf-8?B?cEt2Snl0b1o3WlZMRUFodkVXZE42ak1HT25HVUx4THc1dDJaVExMNitDa21Y?=
 =?utf-8?B?aWpVeGs3UUpVSDY2ME40clhZa2ZBNlRoYlhLYnY0VnlQVTFoZ2tKVTJlS0M4?=
 =?utf-8?B?YlVoRWZaVmlzYUtiMitRQXNvTVlhVzNDQUpHV2FkMENCV3lSSnJUd29tRmx3?=
 =?utf-8?B?d0pVLzdRMEJDZWFQeXJTL2F0SWNWWVZxWEh2MUxiWmJtbVQ2L3IvRUZIUFpt?=
 =?utf-8?B?T2M4aW1zY3Vnb1o5dTNBS1hhTWxvZFlrN1JCZzA2S1I4U3BEZVpqZCtXa3Ex?=
 =?utf-8?B?ZjlPSW9WMWZJT3kvUjBVQTRsZ1BrZXdSemRvYWtkZGMvU2locFNMUFcyaEth?=
 =?utf-8?B?RXN6VGVZZHpJdzlmS3YyVkxRWjdDenBmanRYeTVkY1hBMVJvUGplTlRyRGFY?=
 =?utf-8?Q?fNuAmifoaaskf4BYkQEULLHTA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a505ec2-d33e-4c88-3764-08dd47af5723
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:56.4326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRFh6BWki4XsWLoXEvuZutaVRlv6uaAN7Py8mr+SLFFNR5qSlCB+l37xdDZMuklkIjMQhD2NsmpshSGzXGAsdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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
 drivers/pci/endpoint/Makefile     |  2 +-
 drivers/pci/endpoint/pci-ep-msi.c | 81 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 26 +++++++++++++
 include/linux/pci-epf.h           | 16 ++++++++
 4 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..a1ccce440c2c5 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
-					   pci-epc-mem.o functions/
+					   pci-epc-mem.o pci-ep-msi.o functions/
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..53820744ce502
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2025 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
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
index 0000000000000..26b1c86893ee4
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,26 @@
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
+#ifdef CONFIG_PCI_ENDPOINT
+int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid);
+#else
+static inline int pci_epf_msi_domain_get_msi_rid(struct device *dev, u32 *rid)
+{
+	return -EINVAL;
+}
+#endif
+
+struct pci_epf;
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
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


