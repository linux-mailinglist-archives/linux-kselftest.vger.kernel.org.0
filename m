Return-Path: <linux-kselftest+bounces-26419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAB9A3151E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DFD3A6D59
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769312641D1;
	Tue, 11 Feb 2025 19:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d26wn6UV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340DE2641D5;
	Tue, 11 Feb 2025 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301812; cv=fail; b=cwsq6OCmDYIZSbJkztz7dkk+JzwNO7n+XfNlEC+9jl78buAxfLzKnF5KFF24vrXWPFJ34aLQvNj0TVm52YZJGiLAF4IZQdZ5tv+56NWnKCgRBigdGcZT56C+ByL0Yp7RdZ5L1iyakK4cPY/r2S9kMKrn1qUldVTb9o3MfDfrcNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301812; c=relaxed/simple;
	bh=UlDKmhIPNgdPqhQOfM6ZLjMvuoDnzZk8pznO1GKD4fM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MPtl8ZyuteMK2DU0eAqZp4G14Ut94+fKLK9+7tmtcTUl7/mkDW51afWZH6/Kb+/cSZNF73Yr0wwbg55rYMnPYBp3rqVEhxysZJcX5jDPdtcJAXYH3CTGePPzpWTr1HOJp/MFk05xzbiCWkeQexujJn50KtnM81zYT/HSD965UlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d26wn6UV; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj4u+9uUcb+h+4k29lhU2I+D+AYHrntqWi6tXdhk4BKxEno78Bcx07sRiOp6OhJbNW8+9QXlmFKizFuDquIaMKK210ysx6R2MkffcOdIgc8BjYcHPE0LeTF2ihrTR7498Y07jurlCt/C4Ae+PSDTwaH6DwqmIg3o7PN11CP2biMFfgL7HhraOYoa2InEe9fma7NSXTSV5JDsSjLNUEdY9eHSBuH2QWRxXgvu+FyCcy7sGIwx75lOF0o0w1I/RKWUBI83eWQpIKyxCj6N8474HsiKrTdVnRL4yVMzpQYZrtN4CJD8gva01CmLU8TXj+9wg1p2MN6mIWo1ihXPpQKohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOFt8LX5UPTafSuC84L8Wuvjx/N1K1KamY3mQ/+ddjc=;
 b=HpHFfpG84y/nE/NMYP5Sdun5/lQbYbmSIWViO5ql7QNYFUVzlZKP4veVxkREw30j8rzu2gNe90XnEAmzXl+r/9p35o/QRKbApTu8jE9XWg6BvQcM6RyxI6dPL2C3xaoijF3lWgtmZyjD5I7LYT2KOy9wdOnWr2KIALJ+vP3rmnutg0uH3J32DPyYBoDsj/6gBxy+8aOPmrPVkvP1zEKPf2O7Zqs3iHmxQlfbMcv1Pkd+asXxShfuqYOSUeHdUv/sCGDVpUf+yFTNhwUoMNBsIT7Lc3ZrYsztLGlIkDfhns8w4spZbtbq4zwiisGzC2kKF3ef3dwv0yw1rcyiLS3rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOFt8LX5UPTafSuC84L8Wuvjx/N1K1KamY3mQ/+ddjc=;
 b=d26wn6UVxD3vpBZ/oNszaaVP5uomJGoNqXn4c9Av9VfZ0Pgu+41rhmjwyiDK1V0YNkuHYfEiSNSYrj7kMpXoiqjIdJJabhLwXYgRfAwReG2EUAHki3cQxkHgID4kG+oywU8mcdjdlRep7ymjU9ygfTUXUN2TaXl7SRtgD2NoirqcudVi4AHR7Is1q8G1C4S10OmmPBRmOc8XnKgqA0OmtiHFH6aPXEH9bxL49HA9TxjIVLPBHyjqKex5UDo9/Si6yQuCnvnKh+Y24Eks1kBUUphZJxjsU66lnhhchdpEt7W46SysvLkTTPUhzsTeeJTT6QfYpi3oZ8IfcOUs0XsdBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:23:27 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:27 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:03 -0500
Subject: [PATCH v15 10/15] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-10-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=6351;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=UlDKmhIPNgdPqhQOfM6ZLjMvuoDnzZk8pznO1GKD4fM=;
 b=KRa+YQI1Ef4Kh0XipCzg+dHbW3HtpPExBhBXmuLI8GcRVcMxHjtLFf3ZieAm4xFugxbga/bY9
 sP9utOCHyPCB3tsQMglFKJ7GEtEEVr4bFmy4Fr7MzcmV6uMr0OUyQTX
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 021f3305-3919-4ac9-6141-08dd4ad18f8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmVYVXh6aWNUbmJJL0MxR2VXbDNDSDlHRkpuQ2ZITkc1T2VFWjIyQ1hQNG1F?=
 =?utf-8?B?VG1Dbm1lQUw4aC90Qkt4ZEcrRGpaRnA5d0FNZXY0T0x1QlcvWFY0SU4wUGNB?=
 =?utf-8?B?NmtDUEVwbE53Y3pmOWNYazQ3bzhDcUliTzlzSTdFTkhaVkNjL3lRTENteW8y?=
 =?utf-8?B?UWVGYXVZWHdzaWQ4UW5Lb1c5UExxZTdZeUZLemhJUEU0ek9GVU1qUHpBZ2pa?=
 =?utf-8?B?MDlRZWdiRjN4dmg1YnNTWDJWKzMwNTU4dzVwM05YVzJXa3N5ZXpUbzZKUmN0?=
 =?utf-8?B?a2s3OWIwWG5YV3ozYzJmVTd5SmFQMi9oNk9sc0hHbHFOOG1xZjc0TStqbTFm?=
 =?utf-8?B?VmZ2dHF6SnptSUgyVDJ1TjIvb05MWjFFR1lweGx0bDFhcytlMFpScVA0TEI3?=
 =?utf-8?B?aDZoK0dHSTdPQU9JZWpCcUM2TU9DM0E0WWw0Q3l6QURQTFlzd3N1MlVjTE1Q?=
 =?utf-8?B?ZGVJZ1JFYkVxNTI5b1BjZU5TZ1FJazNUSGRQMWcwSmkxMTdSRng0T2puejg2?=
 =?utf-8?B?U2QwTHIra2lneHNLWHB1clRDMDdOZit6YUdhTzhCek9uVXd5M1dUbEl2TTBQ?=
 =?utf-8?B?N1R2dkJHSDhaSXdWT3F0U2xwYVd1Z1VEdTdCeTlmVlgxRmZsSXZwc09BYXVF?=
 =?utf-8?B?NzNEQndrcE5ud05mMkErYjAyeG5yNk8zUC8rNTQ0V2xRTU9CYit6RU9LcG5N?=
 =?utf-8?B?ZjNKbDJYeEwwc0UwUU9GN3MyM0QwVDNmdUU3NVUxNGhLM2cwNVQwR2FmbTNB?=
 =?utf-8?B?aHNqbnFYMHB2UTBRSGQxTWxXTGRudVNVOEJFZVVSWGxKSWc1UXVTc2hZeVJV?=
 =?utf-8?B?NkYxT1FFMlRpb2daZWVra3pWK0p3OThpN0w3Uk4zRkJrVU53NG14MkhnYW5V?=
 =?utf-8?B?NTM2d0NPRFhFZTVyOTRpNnRiTWhGQ0ZYSTI2cmN4Ym9oUURwdGREY3RqaTBW?=
 =?utf-8?B?aHJ4RVVnMFZBK0hmUnl3ZTJNR29MRXZVd2QwaDIweWN0S3EyaDZrcndwWFN4?=
 =?utf-8?B?OFAxaUZjS2V0ZEZRTUIzSlhxTUtYcXp6ZzFwYlA0UGNJVEFaMGt1R3QzQXc0?=
 =?utf-8?B?QlhrV3V6R1hIMW9tQ2NXSlFEa1puYjRtRnRNUmk5dVpRckI5RURRL2lGR0pl?=
 =?utf-8?B?Zk42cEJZdWFrOG96aTh2MTc0VjJobmx2SlpXUnBVNzRyUllyMFpBcFQxOXBO?=
 =?utf-8?B?eUhMeXVhdjVnNXNuR2J0dmFnNEVXZitkZm90eUVDUktZR2MxSjh1bExzTUxV?=
 =?utf-8?B?TnhKQ3VFY0RtOVlkTXJGRXBQRlF3aVpmZnFhTWFqQXY5SHdJdEt1cU1DRUZF?=
 =?utf-8?B?MDNTUGptbTFqZWpSdzNBaTZNNHhCUjhERFNtSDEvK3pPYzlCZ3Q4bURWNkJs?=
 =?utf-8?B?ZGpxZndQY1g2OG0wejVZb2p6ZHpETkZiWmk1eTB2cDR5K0dzRGRObDJveEhC?=
 =?utf-8?B?Rzd6Q0loWCtxdTA4cTd2aUVPbTdqMUgyN0Zqc1IxNWk2MnJ0RXNRdW5wTFVD?=
 =?utf-8?B?Nkh5cXprSmc4MWhJSFdLOVNxaEdieTNCUzlWazdiWXBGQTJVZk1vZ3lCTkt5?=
 =?utf-8?B?N1FrcDhoZ0FFcWhiKzdLNTV0T2RaRUVDeGtYUVgzMG8xSVBadFoyalFYVkRo?=
 =?utf-8?B?USsvNHpja2JXSlhHdVdRazdVMm40dTRkc1ZkYnQ4NEpoU3hiLzAzb1Rub0E3?=
 =?utf-8?B?K3NnWVkrYjFSWmFyV2VQV0dZVDZjKzdTaytOOGMxa2ExOHJUYzlaZVU3Tm5E?=
 =?utf-8?B?OWV1eXhneFN2QytsL0tsWlRvZFJMSHNMOGtEMzNRenEvN1VwZGVlY2VZaEN4?=
 =?utf-8?B?ZGN2MG5lVFRyZTZYOUN2ZTVqeWhyR25DWjd3SG9iVXJaWXVtTzREZG1NZGNT?=
 =?utf-8?B?KzVkK29yNnpMMHAwczQyamFNeWRzZnU1VUxQeXJPdmo4dzRCT25PbUN4WjBF?=
 =?utf-8?B?eExKZUtndmorNGFXaVNXd2pabnpjS1BPbHlubkxENVZVSi9JOGlVcFFwRWI1?=
 =?utf-8?B?dysrVjgzd0ZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzlKVU1XVy84aEhyTWVCdjc1YmxCN1RrV21mQVcwaDhGQ2NBK1VkaTlTbE5L?=
 =?utf-8?B?clJIMC9xV0V3ayt3M1FHcWJTdXlDUmVkMWpIYXBHRHVXMUp0K1VzcjZxT2F0?=
 =?utf-8?B?enpwUE5DSkQ2Q1dNcVUvWUhvYjAzRlVQQVJCWVU4d2Rsd2xPRDcyTXJKRTdm?=
 =?utf-8?B?TThBRkpvQUNXOUE1MHFONUZMRHdUTEI5cVlHM2pOcnhGQ3E0a2Vvb1U5V214?=
 =?utf-8?B?YVRWaGtoT0lBTmtIMjJMa2hrZWRlL1VWdGM3dGlaelNrbXF6WmRialdSd2U2?=
 =?utf-8?B?ZVlCOUFQYjVUMit2Mmhwbk91S011UDVYOXl2TDhNUkM4di8raGZocjhVVXZ4?=
 =?utf-8?B?MGJDZXhJSEY2d3BJL2JWVktvQzV3a21IOHZmNDhDRlpoOFZZQjNzYnJOS1A0?=
 =?utf-8?B?QUFzM1ZuM3Q5elpsZjJLT25CNFNiR0xCaUdodVNXTUY4MjQ2QVBTemlsNXhP?=
 =?utf-8?B?NVZMSFZOZEdjallJMTAxQ1o2SFNDSGpYZkJPY2dUTUhXaEpHU253M2xmOUdw?=
 =?utf-8?B?cStHdThFbXVwMGQveWsyUHBBeDh2b0hHZ0ZOblpxRU9kSG9UbWdrcUZYOEhD?=
 =?utf-8?B?aUFkWE1IOVBPQms2Q21vUWtNVW44cUtzemhXL2tYTWNLZnNCNWh2bnpmRFpL?=
 =?utf-8?B?Y1BTQVJWbi90UzBZNit4S0lGNVNWYlpjV3ZLUllHR05uRnNXRDVxTldNV0tH?=
 =?utf-8?B?UWlRME9UMmpaK0o1dGNSanVERHlIUG8raGh0VGc2dEZTNnQzdXVVTTZWYThv?=
 =?utf-8?B?NFUxaXlkaXcrc00wR1JydHVTdnZ4S1l2VXVSczFYODM1c3RHUzZCUnpqcmVT?=
 =?utf-8?B?Nm9WbWxxWlJac2VtZnZneU9DeVlRV0pyRmRZL0VVNE9NMkJ4N2E1Sy9hSktR?=
 =?utf-8?B?cE51ZmNKN0g3WWZKZ2lVMXRvNXl3OTBieEhEZURTMEU2R3A4bndwU3l6aUdD?=
 =?utf-8?B?MzZrT3BZYlZvVEN3K2dzRnNRVHZoYS8xUTE3NXAvUXo4cENIekdOY25WV0h2?=
 =?utf-8?B?MTlTNjBzQXpGdVNuc1QrbnhlME1iTVpiMTcwT2UwVTE1ZzljUlZzY3U1M2R1?=
 =?utf-8?B?TnVabGRtVmJtbk9UMUlLNlprOG1UNGVJWWtWbzJlS2doYktTS0VGQ0VTbEsy?=
 =?utf-8?B?OXB0ayt4OHFodzRJRTJ0V1VwYnZEcy9xUlVGTTJKWkxLVStSR245Y29KN1pR?=
 =?utf-8?B?TkhUWUlUOXFzNk5UamRid3BzWlQwa3QxR3dTc2drVEUzUjVDYlVSVXQ5MmtW?=
 =?utf-8?B?UlVrTitxTUU1ajdqbTlyYTlSRDJ0RWlTUmpIckdKbjVKd011QzNEeUtJRUZi?=
 =?utf-8?B?a05LblNncWFXdVcyR2N1RGwwOVFlbTg2STA1bmNCOGtMN0JEZVlubFJiaWxT?=
 =?utf-8?B?WHpwd3RyWHQ4SmtoN3ZrL1Q1NHVYdmR2aithblJKU1FnZXB2TU9qNHh3S0dY?=
 =?utf-8?B?ekVoYkpRK1lmZnZEd0FZckxKWEZCQmlEcUc1ZnMycyt6K3YvdEFpcDhPNHQx?=
 =?utf-8?B?MzJTeDI3dXliYmREdHc0NEdGYVhxTExmamh6OUprMEdrKzJnRFFYVkRaaEpo?=
 =?utf-8?B?dDVOeTk0R1d5SUZWcDFTakl6TkN2NTl5ZmJZN3N3dUhwNnBVYTN1UVlZV2tn?=
 =?utf-8?B?VjdSaWRMY1VsOHpQVkVYbStUbk80V0N3NHZsRmxyVFIxUlA3dHM5RVJRZThW?=
 =?utf-8?B?Slc0dzlmb3d3QjJ4OFpkVmNONklSZ3JOalhzdDR2TXhQU0tVaVFPcStKemRL?=
 =?utf-8?B?Y3dNSDVQOHRGUW95VVpydFNUK2VIcnF1NEoxWjFrR3UycC9qY1VUbUhpWEJL?=
 =?utf-8?B?dENDS0VOS0RueEdmZkY1QTlFRnVZUjNGdDRkRjdYZU1UeldkSGJ6TCtRNlBV?=
 =?utf-8?B?Lzg4U3N2UGREVzZ5VUhvNW9xOWtnS3hZbVFWMVJBR09JejhsS3JRMjlQQ1di?=
 =?utf-8?B?cW5DWmhZQnZlTDlMR0hIUG5hS21lMEtyMGJrdEFWMHJKWjc5R2VWYjRkREZE?=
 =?utf-8?B?cjRqMFFKQVVyOURpVGRGbVZvckhYMXNRVEJ4U0FvSE5tM3pQNFkxNjNseTdX?=
 =?utf-8?B?UVNXZTFJdXpRZ2FtUHlsT242VWVjdGRmY2RtS2Ftb1BxZFBOSlk2UW1LckxE?=
 =?utf-8?Q?22i913h4WM4Ylvvc8AoIHApaI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021f3305-3919-4ac9-6141-08dd4ad18f8d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:27.4528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XFaU1cDc8ROXj9inhACXjNg6HtQOvNGeqRpCyMxaKMOyrYKomL+OZk0q5W75DKMhXARwMdLPYLmQrJV0IQh7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

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
change from v14 to v15
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
 drivers/misc/pci_endpoint_test.c | 81 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 82 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index d5ac71a493865..7ac021bcc7152 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -42,6 +42,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -53,6 +55,11 @@
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
@@ -67,11 +74,16 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
 #define CAP_UNALIGNED_ACCESS			BIT(0)
 
+#define PCI_ENDPOINT_TEST_DB_BAR		0x34
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
+#define PCI_ENDPOINT_TEST_DB_DATA		0x3c
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -111,6 +123,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -829,6 +842,71 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
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
+	if (irq_type < IRQ_TYPE_INTX || irq_type > IRQ_TYPE_MSIX) {
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
@@ -879,6 +957,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index acd261f498666..80f4c0e05679b 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_BARS		_IO('P', 0xa)
+#define PCITEST_DOORBELL	_IO('P', 0xb)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_FLAGS_USE_DMA	0x00000001

-- 
2.34.1


