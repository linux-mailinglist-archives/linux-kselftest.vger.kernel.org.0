Return-Path: <linux-kselftest+bounces-34498-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969BEAD2400
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70D633A7868
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E272A21B9CE;
	Mon,  9 Jun 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jodat9U6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC2421A43B;
	Mon,  9 Jun 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486882; cv=fail; b=Q+2T+aYlDY6/JRughLqw6oaWth5NVQED0svSU8hNV+DB2CZLaRxkspjG7KvDTNFwtfTpL6OwU14LYphPE1GlioyllXganAHQyRBcvziXLnLQwaZ76GA9rM+i4BNHoZonxRWgP7wrwdIx5lqy2h+SqOQvtEzMY888ZjJu7b+PffM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486882; c=relaxed/simple;
	bh=29jELxy+tM5exRX1qIoQL5ZH7cxLaiYDa75RWhw/ctw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=LbyiliF2DqLhzZcjXGkb4tlykhfntaKhosfkpECELMEquBdOOlY7mwJetQg4CxieJiTU7NxE27s9s5/aBQ7hXw9+2SIk82AMvM+sstjUc1tCYoX1jmmUpvqfPLYtEVxjHOY18kyD9GebFOJ6sFwSZP7qWsu4SrNnzNeQkGLJ5DQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jodat9U6; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihyJTk7onCHUCPR7WViyZ0iqlsM8ho4eHsU9XOhI7UctFrEgmpuCtz51ZwNSK993oiLWjz9xp7wGjEjQQadMVpu6KortdDk7kY3kpmrCVvCV6Ge6ggGC8f8tGtY/UTEFGyUx5eYHhoXWUEUp7JDeXGo871Yq4n+vH+hhGyKiWHRFn+TcVIzAeer/a8w4tpT1F9ZmxD3Ni66t0hlL/UPQR3YZPYh1L+u9FRJ7ihPoPvHi/KqiN6FtKgW+0l87JvaK2ihkW2GdCWV6m6I3ZbAati00ps3UIT4LEjDbP3yupKjS3+6kW0zSCA67QYxX/SMV/XgBnpmRU9kKZDlZzt/uQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0CbIqwMkZB92S1LrZFSA/KdAkKOVehkPJdrtyx9POoY=;
 b=Hn2Fsf8PJSNBi2uGJAHYxS8Q8IxJ78ykqSNcIDtwiBqVZAP+7+kDrPs/gbc/sngKJZKu3yDx23rPH0aS8VSmf6jYcu3QQhCF7wCuQ4nahO+4EZ1O9Zuf+w6Q16W80v37MfPdrnnosq9tDRUFCw7nhI0A/zTYr1X2c89jLwo/T8+HuF8XwG14E1iVM6a0Zc+dJ7zLgLccR53FQMB6216GbPE60VzTqvpDZps5bx3DjNfOvXGEOhEpMwF4zU13sFVZ37c9+6nEvP2h1vPYtfzyOqPW9MlH+Md5V+c9twvQj+cEY573R0cCQHSUCXEOI60f6Bgj/Ds2BgTMiWWElgXA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CbIqwMkZB92S1LrZFSA/KdAkKOVehkPJdrtyx9POoY=;
 b=Jodat9U6SUtqqmGzv3TjVNYJ8yZ0aVLFatz7cz1c5n9uOA2ePBZIqtGlLyp+72DdY/LmjqOmFCKqPObIbvR7vlVvEPyNHmj2DzAjd25Vb9uv5IETFP3Who7/tq3+mz2dCBIFp+s2kxHG5Uuip9PxgEynjRfVEqAva5nVYh0F0pdYYIPwQTJH73/Kzmwezy4290qe03S3wQ0oJEUJ8RpyFJLmGHOhEnKGDxkJlEpB+gL0OLR7SmKo+t9FfcFRDc/8XMFLBAtJyqE0ftGT9FbwuKXj0icnwx6QSE0BAS2zaCZ4YD2C6NRl5uCSxyGKIl/9PgW1suphe3arSVWBJPnU0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 16:34:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:34:38 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:13 -0400
Subject: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=2203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=29jELxy+tM5exRX1qIoQL5ZH7cxLaiYDa75RWhw/ctw=;
 b=F73B0oqNAKL68Ia7GJo8sFRgapx88X4KOJbQXge07K66pkaB8Z4cae1MieaD04V+LysawaG05
 N+5xS4HGrIDAy1odnmxRPBfOKH/Dq79UdsLPtJco/zNwHn7Ny4s7PT3
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
X-MS-Office365-Filtering-Correlation-Id: abd41355-4216-473a-266e-08dda7738698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGszMVFxVnhEb2Z2UHFyQVBUM0JQY3NuMDQ4QWh4VUtmVDIzcG5rRDI4K25t?=
 =?utf-8?B?ZzhlL3R6NmxnZ1RQMjErQ2VCVHZiSktMU1M3VTdxeWJ6eDJUTEEzZmxFdG5j?=
 =?utf-8?B?MjRkeXFhSENvVVZndU80S3R5bW9uTE9nZG5LeHcvVUFaQkp4cXRGblRmUEpP?=
 =?utf-8?B?L2VNU2NSZ0lOdjlBRTV0K3A1ZDBIVjRxdGJ2SUNBcDFsK1hlWkljYTQ0czJj?=
 =?utf-8?B?aGZBcVYxWHp6SVlKNTVyRFk1bzZ4THNrbHQ4RGlEcHIxQlRLZkMxdFErVk8v?=
 =?utf-8?B?WTJCVFM2Q0Zyak4zdkl1dUFCbWthMlIwSlYvbE1BdngrMmdzWTJGdlkxZGdq?=
 =?utf-8?B?Nm1LN3pTUGIxNXVJZWZIV0d0MlBGTzNnQkNlaW5iVmM2NkxyK1QveGg5VGdr?=
 =?utf-8?B?ZFRHQStWWXNIaVRWdUNNQWV0aWh2ZTJ5R0ptaUVGaTIvWVBmTVZkTnQ4eWo2?=
 =?utf-8?B?cVBvNzlqa2RSZ3Z5cDRnNVBjQ1p3TlpMdnltcFNrUE9oMTVYY2t0VVdLVGY4?=
 =?utf-8?B?bGVvdURycUNVWjI4S2p5eFFiSXc3eFhvaXNTYnhEa2FZOEhVZE11aW1MWnUv?=
 =?utf-8?B?V3oyOFNmMkhVS3FuWFBvblZTdTQ5WHd5d2c5WVFIVWR3MWszVXN0K3ROa0RU?=
 =?utf-8?B?THlsUWRUZXVtVkQ1YmV1c21NWFdkWEMyZ3lORCt6QkdPaHBIM0dsUm1meHBV?=
 =?utf-8?B?dEs0M1YzR3VFeDlZbVlHS2dIcGdEc3dwL29SR0NJaEp6SFJsOWp0NjJMWVMy?=
 =?utf-8?B?SDYrSGdwb3FLQU5hbVpmYm1kVkU2NHo5ZE1yK3dKN29YSGdCZlMzdU5nV1h3?=
 =?utf-8?B?TnNQYm5ML3Q3dy9OWHA5TkdtZk00eDg3b3JqajRPaXZvcXhTV3lLZ1ZaWkJW?=
 =?utf-8?B?L3N6bDJMOG9qV0dMOXNkTWcxS0JUZG83UUJFYmFLSmsxUnY2QXNuUUM1YUtK?=
 =?utf-8?B?TGp2UzVCZXNLTWtHTmwxa2tPVGZDK1lDVjJjM0RJQy9UTXowN2JnelkzUWF6?=
 =?utf-8?B?bHlZK2VTWXpCWlZSNW1UblFwZnRsbkFtZXNHbFBud29BSFdmMS9oNSt6aksx?=
 =?utf-8?B?OEpFQktOQzVvSnFoRXFkWEp6NHh6NE1LUmlEUXluQklhK3BHTFBnVm05MTZw?=
 =?utf-8?B?VkQvSHFzNDBQMUdqa04xZGpWdjViS0ZIbmNNUnhwU2dMamRIejBhLzZFMHBQ?=
 =?utf-8?B?WWE0YndnK3lRalRFYU9XbFZ6UDBjeGhqU1VhMEsrYjYvL0Y2Y2dicWYzanI3?=
 =?utf-8?B?V2MxS2hWeGFTV2pYY2pnSmQ0cTExem5uaHo0TFdjakdmd0NlOUR3SXUwYzE1?=
 =?utf-8?B?Y2JTZTJUT3RrWGZsSlVyU0Z6b2k5OFJNeEZqdXI4RWNzWHIvVW02alBRMWg1?=
 =?utf-8?B?dmpyZ3NOMW52L3hMSlVmRmNQQ0RxSS9FeXlXcUoyam43MnVnb0h1YytQNXhk?=
 =?utf-8?B?ekNsMmd5eU9STjd0SVp2Y0lEc2ZZUnAzSm5iODdNU0tQdk5FZzYyQ21ZQmRU?=
 =?utf-8?B?bFRGYUJEUUExUFRvbVkvZXV5ZXpmTHlrQkI1NHFJc3R6a2VNR0VENm1FcG9y?=
 =?utf-8?B?bmErK0ZkZ0FGejE0bURVNmR5S2VETDBEM2l2RnNyeU92aXBBSDRmZUNUMk9M?=
 =?utf-8?B?b3ZuKy9ieVFlNzd0cVBvMENiZVJuYkpmMkh1d1BTNDJBVEhaL01jSzBCSEx3?=
 =?utf-8?B?NXF4bDdiMmh0UDdUbFFtN1IyZkJqbnhnRzlKTkFWelhmNW45c3Nld0RYUzZ4?=
 =?utf-8?B?SE5QYkt6SndDa2xBZ2NkdkxWSncrU0NuREI2cUN4Y3grWi9qUDNSQUxCbVg5?=
 =?utf-8?B?c1lNMnEyMlZSUVJKU29xMXhJcVljc2dVdFF1dko5RVpLSm8vL2ZHZ21vYmt1?=
 =?utf-8?B?K2ZDMXlpczVld3pZQTB5SGtlM0haOXA1RmFaVHlERGZJRk5IQVdueDBnY1Y2?=
 =?utf-8?B?R0REbUdPMkRMM0VSYjJxSitJVE9TRVRFcFFiWEtNZnNxWC9pd2tkaFJFQU1a?=
 =?utf-8?Q?4tJTpXblqElgkMhv7HKEKdJWTwDd5A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWZEREUyR09pZmlIK3dRdE5XSGlYUjVFLys3Y1R6c1oyTXh0VkZDRTVjd3RF?=
 =?utf-8?B?Y3UvZmVPVFZiVE1PSnBNdmR3eFhYUGp6WWhwYmxla3Y3WkdaU3RoUFJpSjBS?=
 =?utf-8?B?enZXL2lXUXJqSE5PZ05ocnBROUlVeWpibWF3UHlNbjJ3SXBWT290Qld4bWdY?=
 =?utf-8?B?UmRGYURUL2lzbVVqd1pWbHBpRk0zMG0xczVRMXRyZmljcGJjL2xldDllbVRI?=
 =?utf-8?B?NE1LREc5MFpmWDQxNzRDM1pqYXAyVjNRemJYbllNSFBVeEQraFM0bk5JbVBO?=
 =?utf-8?B?RWdDcmtHUXA3cDRUZnNHSXp1QXpmcWYxS2pvZDJXL0Y3ei92elhIeDA5UURr?=
 =?utf-8?B?Qm1RYUxRTVVhcHBCeDZkZC9rWE5FRVpyeWdKblZ4YU9TN2FGM2M3SGpHSFhS?=
 =?utf-8?B?N2Mzd2MxV1J2UFlFclZTTnlXbitxTmJoUmpST253M1R3N3lZZFQzTHZDUGt1?=
 =?utf-8?B?ZnBwc1RSTXdZd0F5Sk1oVnVKYzNvKzJqdUlpNmZOM3NEbFVFbkxrYkVnMFZ4?=
 =?utf-8?B?RG9Md1pVOGRGN3FNVEErVzJrTExKWlFjWjRpVmtuYmRQOHUzRVNTN1E3VDJh?=
 =?utf-8?B?bUF4ZXZ1MExISFBKZ2prcmJYbDZhSTRvTk5BR1JhODZWOEZybWtxa2NTNlZ3?=
 =?utf-8?B?SjFDRHpoa2VXSU9XdW14TlJqTm1IODVTaEdHemxxcDFVb2JhcGtHRUFGRStx?=
 =?utf-8?B?aGM5K3hCOUJGUHZvZmJaZXpFNEJRZnpVcXhDQ2thVVVoeWR5QWRBZVdRS1pW?=
 =?utf-8?B?SjdlWWRsNVBmR3ltbTh6dzhEckhHRjZpVXQrM1l1Y1Q4S01UcHRUVitkY1Jo?=
 =?utf-8?B?dFdYRCtrK3pRMXdsZ0R4MHdzS0VtQW1Pc0ZsZ2hpY3JsL1FuRTdRUzNPN3ph?=
 =?utf-8?B?NHd2KzdUWWgvVE0vZVJ1bWJOQXF3emQ3MW12Z2xWb1MvSFBQZHU1Rm9UTngx?=
 =?utf-8?B?MGE3R3BVWFp5aXh5bE5LaG9mL3gwQ3VZUjc0N045Z21VM09sd3QxSFJxeUFK?=
 =?utf-8?B?Mlp5cTNYZzVESURYTm52THY5eDRYeWpJRTFOUnhZTHNGY3RKaytUTnEwTEpr?=
 =?utf-8?B?ZGxGRVI2dTBDMVNWOWcvM28yRHdJLzlQUi9qczlaZVUyaFY3OFlmbDg5QUxO?=
 =?utf-8?B?MHdzcTI5WU4zMXRFUUtFVjRaZ21mOHcyZDVUakdQdnlIeXdYcGxjZXRTeWFq?=
 =?utf-8?B?NWkweSs1b1JVemk4RTVvMGYvNEpaWjZlTGtwclFWckxlY2IreWUvVTJuNWNq?=
 =?utf-8?B?VDN3M3dhZHIzbFprZVhVL2lPOVh0YUJPZ2dFenkzWnozS3A4TzZHcjNVOUpo?=
 =?utf-8?B?ZC9xZXplRmVyS1dXK25wV0pVUmxUa0VmZThXQzhQTFRsRHhHN3VnS2c4aHZa?=
 =?utf-8?B?K2szOWFwRnpMTW1XL1NJWmFXV3Vpa1ZkSzZONXc4a3BVZW5RRjVPM2hKSzJ4?=
 =?utf-8?B?UmRZaXFOLzBkejRyUlZnVXIzZzRLOWcrOXk3RkhwcmwwSGxBWG1xR1E4cFhO?=
 =?utf-8?B?WHB3eXRvWUJSSFVYNkJZaXVkamhOQWV5bndudTc2bGIrL0lYZWdub0YvQlZ6?=
 =?utf-8?B?cUplVk9vcHdTZlNlU2lKei9TeXRwckNCNFB6c1A4aE9TWENER0Q5VUgyRnZL?=
 =?utf-8?B?TkM5bG1GelJXYWhXZ0hjNE82N0pXcGhwWVNsZnVXdXlXMGhKVnc3Y1dERXox?=
 =?utf-8?B?TjRoK3BqbDBCUDhFT1ZaRGZYUHBEemFsVlBuTmExUkVaeGZLbHZSNjhPaVNt?=
 =?utf-8?B?b0kwbkZEd1NXVm5NRjNXTVJPRXdhSk1pMnpEY2dWTmxPakw0aFBXcjNRaG5t?=
 =?utf-8?B?ZWRtelhhMWQwUUNDT041MUJPNHBTcENVRy9sK2lJSmwydjRNR0sxenE3anoy?=
 =?utf-8?B?WGdYenF4YUJMRWVwQ3B6aFk1S0FUY3ZHb0N1ZW42ZXQycVVRRFZteUZncThH?=
 =?utf-8?B?amtOUFFsSEQ1WDBNSHZ2a2hwMk5ETC93R2R5ZUpwcEwyaFpKV08xTzBaTlJU?=
 =?utf-8?B?Tm1vbkFTTEJ0UjV3Nnc3SGZBcEd2VjI2Mm44QStBZDg3aWVJbXVOZ1M1K3lM?=
 =?utf-8?B?Tkl4RUFkVDBtZXQvODdTbG9ndWxzT3BiWHhiZERaYjJzUFNJY1hyTnhoNFBu?=
 =?utf-8?Q?rOdOzPz5BfXxl/+j6cms9p2Zf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd41355-4216-473a-266e-08dda7738698
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:37.9354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lpfYD3MyOtwpCnwzk2EC+b5Xa5+Jla6ZBKHxKDU3hBlFbUknuyZbdh0rKrrV45FYoo8/l5jwGuuD5C+g30iZVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062

Set device ID as 'vfunc_no << 3 | func_no' and use
'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
device.

Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
functions use the EPC's device node, but they should use the EPF one.
For multiple function drivers, IOMMU/MSI should be different for each
function driver.

If multiple function devices share the same EPC device, there will be
no isolation between them. Setting the ID and 'of_node' prepares for
proper support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epf.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 577a9e490115c..95fb3d7c1d45e 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -120,12 +120,16 @@ int pci_epf_bind(struct pci_epf *epf)
 		epf_vf->sec_epc_func_no = epf->sec_epc_func_no;
 		epf_vf->epc = epf->epc;
 		epf_vf->sec_epc = epf->sec_epc;
+		epf_vf->dev.id = PCI_EPF_DEVID(epf->func_no, vfunc_no);
+		device_set_of_node_from_dev(&epf_vf->dev, epc->dev.parent);
 		ret = epf_vf->driver->ops->bind(epf_vf);
 		if (ret)
 			goto ret;
 		epf_vf->is_bound = true;
 	}
 
+	epf->dev.id = PCI_EPF_DEVID(epf->func_no, 0);
+	device_set_of_node_from_dev(&epf->dev, epc->dev.parent);
 	ret = epf->driver->ops->bind(epf);
 	if (ret)
 		goto ret;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 749cee0bcf2cc..c0864935c6864 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -216,6 +216,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
+#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
+
 struct pci_epf *pci_epf_create(const char *name);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,

-- 
2.34.1


