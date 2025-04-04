Return-Path: <linux-kselftest+bounces-30138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF666A7C389
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B502617CEF5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AE0221F35;
	Fri,  4 Apr 2025 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PEVhgMc+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F0221F26;
	Fri,  4 Apr 2025 19:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793361; cv=fail; b=ULJSmWbz13PFvDqR68AXfIUBx8b1wOvPPVBGqKjRMCrpP+qQZpLKscx5pOhTq91i9OydadtAX0ABjMKqjqVhU6UNwHkUrHr24irAGmPs7NPgCuqip6tGNA1tQYpXUaM7rNI+iU4+5h7XSx8gPvetflodtliuCFf/7JjQ8zh2yhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793361; c=relaxed/simple;
	bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pyJX/UYzn3pbkydoJJilf9WRF/YqYHiToq6bYk0WW62ZVZM00dRHW57oZyHul8jUgViMwljUwVx68ilyqDgkljKdUxt2djMm9r7mFwuNTV3uaqhbNmpzEJfhBRcM0SG4ZnkN1USH67F22moTM8ZUxxLcH2u939Acn9nrfeOw7DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PEVhgMc+; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX3e9RQ3//xkoF94yKt0RgWiR/kgkGELjvPZyaYl+R3CFwNo6CUYPwKCdwfLlrkApQtKPjwTJzEgQzTwhwh42jnzuFMDsNrsWW8Qj4nWgVZ9iK/4aIy0RVMYw1NpCo389/qWWqDmjO0+wUWDqRw2KOw6vVcD6KSz+4je73E+0yBltPQa2sw36BGw5NOHdOhixfgyzJgHWw1QF3coh1JaheZf96tnvsj9Bl5PqwtDTXotXxfkdqBLXdniuOYfQQCQz1nhpwjOafG5RKNiy8IArFNhXxIIwa4SZcImUz5cg0wMgUUKyitl+gbbIYhxOMa7dO7HOmFuIkH2ly6dlc0cWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=p6MZqwOP1tMulbHDZy9Mvb9Ljl2UtikBltz26BHlq6mK84ykgx5iSAnVGX1ZkdrbbnAKDTm8V71Y0Ch4+JnQdiuT7WU7g2yMILsz8EghdBBGLCtsqMv8SbL19hjnb8RP2JAI/1JetBUKAGxTF91XhCqNR5EaOYL7E1yhGIWczi5/oABd6t7439AiDBFykQfk8yYS/EJeD42zJylfVkbiHWriFwh5UVTEN0ZPpJFTJPMP9Y/gUfRGpD2mT6AgFeqdcL3aym1DcIrrPDiPclUuuQHls50Rpg7iAVCe9lxD1pCXDXbDQXFnXzI+IFSKWVJBupigi4lQ3Q5LFMPY9uTUaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=PEVhgMc+3D2R/3Qzi0t6rIb2tF+sSbPWIbjBYd/ahSudR4Z1NqMtr98x8wag/hssPNiZaItxlcpEkZNew6xcN2lLFg98by2diaWWA4cn0Bk9EVy/fea5W9T2pXD0ETjzRZDQgN3oedjYyuyEjvZq018mg5xqqR1eCLn96qVzeiUxfYh3n/3uY5v8GYlcl2SCYdaM6n2SLei2ncWi3VtEFyASAjM0UKyJ/TcQ0+pHOF70sIHs3yoSUBULZGbW1/l68TBmg3p8WmoOU0NiFWekFciMDTToMDnxe0T+zZEC1ZuTNX6RHUBb8mMbdH0epFLZayIIuDF5hazK2fcjdL6Pbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:36 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:11 -0400
Subject: [PATCH v16 10/15] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-10-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=8739;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
 b=VNgx6s12NV0Z48nCnx1GqOaQ124ymogqru/wrUmPfe6kQgvS1F1DECMLXAmWfg9SgFUnYRa9Z
 ozcB6MqJPgkCVjPTgUmiqsDj9oPrX/Y7cMwoDeyjlbC0x5caYPG4tQr
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
X-MS-Office365-Filtering-Correlation-Id: 9a65c832-b880-419d-fb0b-08dd73ab4384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGU1NXdJcEJPTkNhcDZtZzg2ai92dUtyNHNWK1RXd2YwazF4Z3JudjVUeDVn?=
 =?utf-8?B?aE82bUg1ZkZhQjltYi8wS3RnUDRzVUw1aGpnYkhON3BHVjNucm1XU05HWUF1?=
 =?utf-8?B?bVRDYWlYQzBDVmVwc254NWxUNGJ0eUNrTFBqczUrTlg5ZmkzbkpldzFONm92?=
 =?utf-8?B?VThvb1ZMNmk2ekdKcHZ4VFkxVVJROG1ldm1lZHhveXRDYk56bE5zSXFKcitT?=
 =?utf-8?B?bG5SVzhBY1l5d1VhcXRCK1NUamMyYnBrZVpoQWx2bjNCazlNdm5oVUFHRk10?=
 =?utf-8?B?MmZWWExsNElQMUNBUmUwNzBFdkh6cUZVaGwwQlJ2TFM4ZG5uMGRhQUtxSnZ4?=
 =?utf-8?B?VkdQMGU0Sm4wRzhZVmpURXdpczhiMXFWNnBZaUMwUkpnT1ZmY0xoalFMU29F?=
 =?utf-8?B?SzJxWXJERXg4aEhHeXY1aVo0eUpFZFV3S1lhM2tOVG1LWTYzWjcwSTdyMFdB?=
 =?utf-8?B?c3lGQUVQV0sydDV4UC9ZaS83bDBuRHAvWW9taCtyU0NCTzhiZ2MwRHJacWxj?=
 =?utf-8?B?S29qTFRKM0dEK29wYW1HeTNhVjdPWHdqSFJZNEsweVJuMi9JVFNYTGNqWGtQ?=
 =?utf-8?B?Z25DYk9sT3c2NVFCbGJBdzlnMXlMTzVHVmIyL2l5Q1BHdXM1OEx5ZFlrdlBU?=
 =?utf-8?B?WWp1K1F2bXJsZnNPeWxYVm5PWVk0bzc5ZTdGWWtZQWwrUnpkeUNSSndoMmZB?=
 =?utf-8?B?d3p3VjQ4WEhvTEtwRFlWQ1p3ZndYRStJWlRyMnl1OC9EY1NuN09CaFdXaElo?=
 =?utf-8?B?Q2VsK3BKTGhESTEyeWZlSUdDUFN2dlRkSkkwV29wZTBwNklubHVDeGNvSTc4?=
 =?utf-8?B?My91aE5Vbzcvb2V6MXJvN0xUSEVEUFlXdThmMWpPbDJpTTFobnN0aVdsUGI3?=
 =?utf-8?B?d2pxWDVvME5wTlE0Y1l3MklHeUs4WFFnUU1JM2hPaWVVbWtjTkh3ZlNuL3FT?=
 =?utf-8?B?cFViMjBNMzk5T3FOaFlHU1Q3OUh2VGRoelhyclZrZjZXYk9LMk04cWoxaVNk?=
 =?utf-8?B?Q0NwN05pR1hZbi9YOHJMcjlmditYM0pyTnBaMjlRelF5NDlpa2YwMk9PckJJ?=
 =?utf-8?B?TGRmWEhtMFc4MkJqME9uOWZJOWhaV0RBVTBpOUR4WHU1aThDNWJWNVF5L2Rk?=
 =?utf-8?B?dmU0K1hpZEdiSEg2T29QMnIvSlQ5dndmekY0Wkt0eVp4ZGhPRmV1QTEyOWZy?=
 =?utf-8?B?ODNjTUtJRkl4bWxaTFlBV2RweStLTnJFdHB3ZGNpbW9LMSsrVHlVdXk2Tzdu?=
 =?utf-8?B?ZmhoRk9NMm1ZMlRIdjVNTkZrSFllcDYrK1JhcTE5SG9BUTB0MDZNemFleThF?=
 =?utf-8?B?ZzhFUDA1dWtZUjZrNHZpRHRObWVQNVh4SlRyK3JqMXJhTDhhRVJNUjNwd0Nl?=
 =?utf-8?B?aWdJMXV3cGJzSnhlVmp0bkwwZ3JmOEd6T1FpNllvNEtTV3pzS1NwR0hydUE1?=
 =?utf-8?B?bzRwN210NEUvZ1Vab3drU0l3b2szVENmY3Z6L2FVeFJWTTA0MG1ybUtFWUpk?=
 =?utf-8?B?MFpRNXUrWnl6MUlqcUlmM1dXZFR3V3piMUd3cHBWOVMwTFlHQTlVSjUvai9U?=
 =?utf-8?B?WWpORTlrK0NmNjh2KzVUQTZkWHRnd1FGa3BDcWVJNy9pK3FLUmFvSGRDV3I2?=
 =?utf-8?B?VWZESTMwVG0ra3czZGRQNU1HUlVuNUNzRVN1SUMxVzNmb1hqQm1CbVNUbXZu?=
 =?utf-8?B?UnFSWTFyK0ZYMHcvR1JzWHYwc0VFL2pJWGhkLzhqOFlRempISm9qWW5Xa3k4?=
 =?utf-8?B?VWxBSUUxOUVWdkVhN3FCNHR5dmE5b0J2eXRjL0N3TDJmTnhiRzFPeG1yY3o3?=
 =?utf-8?B?dXkrdkZlMXhLSUlaVXdDVzlRWjVVQzBPZDRzZDZDSEZOL3JRRUxrRjlPTEZE?=
 =?utf-8?B?UmRuYUJabGlBVk5Rc1N6ajc0WW05RXIybEtIeTM1U2U3WDM3WUZDRFYyNnpo?=
 =?utf-8?B?ZzN6U09Ha0hXTzhMcnNuZXk3MHJObVlSL2RVaUpJbk1rSGJGT0xDYi9TRVNu?=
 =?utf-8?B?ZWhOSG84MHRRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2o5WCtqWDBhb0R4bUxRMlA3V3M0MmUyb3Z2L2JpSXBMQkNyZUFUc2ZsVDl2?=
 =?utf-8?B?dCtBRWJVTnVZZk9tck41MEJRTitrR1ZVTktPRmR0Rnp1UW1UczNORy9FMWNM?=
 =?utf-8?B?TEdDTnZxRjJSQjlndDNiRlE3cXBLZEs0bldkSGxYVHFDeXhvSE1FWDJWOU8v?=
 =?utf-8?B?Tlhxd3RzU2NLVEFwdUtSNVFJQVcwVXl0Nkp4a29JZEt1ZExISnVDaTlPb292?=
 =?utf-8?B?QlNtRTYrRVViRWsyNDZacE1lUnFRUStacDdvaDZIWU5NbkRsTlRKRExUNllN?=
 =?utf-8?B?SExqTWlWRU4rWTdMczZEYkNnVzMxZmt2MENIU3FVcnJyT1NTa2k0aXpjQVVT?=
 =?utf-8?B?RmhlODl4M1lCY0J0QlltTjlCSlFxLzRUTUxzdzkxNEtqczVoVG54aWxUTlpF?=
 =?utf-8?B?YklFVGRWMmZ5WEhDV3pUTkRkNitXNk8wbTF1K1NTVEhmczR3NUFnWUJUUjJ0?=
 =?utf-8?B?bzhXQ0R0NnJwT1RVVWpxWjNydjdxVTg1REdzSjRNcEx6OUJ1U3M1RzR4Y2t4?=
 =?utf-8?B?dUVjTkI0Z0tFbHBwbWE3MGprL2RnZWZQVHFaVFA2UDFaVGxuaHVPQ3l1Q1Y2?=
 =?utf-8?B?Qi9BbXNUaTBuR2FEY0tzK3ovaXJjTlI1Mm9RREwyVHhyT0RqUWRUd2Ftc2NN?=
 =?utf-8?B?Vi9IdkJod1JJTEFJdUEwVXRoNDdqRFRZSklSdE5jdnNMNGd6SXpRMFNKbjdN?=
 =?utf-8?B?Q1hyaXBSdGJiVnVsMGRVT1MvbW1wUUtSenFHWUxNM3lodVRQRHpLMTgxbmtY?=
 =?utf-8?B?MFJleTlyQnJDcjQ5UTlQRGNmRm5DRURmTnZVKzJFV2d2Szl2c2ZyR29oV3pD?=
 =?utf-8?B?by9xWFltMFcwbzFodlFkN2ZRSHF6aEp1NzcvM1g4NnFndHFMS1g5NlJZWmRT?=
 =?utf-8?B?V3ptcnZabjRUQnNrUm81SVlMVzgvUkR0Y2VxUVJONHZsVWNqbENmY1o3WDVZ?=
 =?utf-8?B?cERYcTNzY1hzUDFLZFdjTHRaSzl4VU05ME42SldKc2pWMDQ5bkdmU2I2elJG?=
 =?utf-8?B?TTBDeGk5TzBLL2xkTHpYM25mZmZHOCt1ZVkxNm5IZldGVHVUSGJ3NitENkhi?=
 =?utf-8?B?eDB4U2RqTUMxY0lxK2dZdVdjUFBzR2VOcEY1THRVNThtUFpXOVdTWDFsSWRH?=
 =?utf-8?B?aHdtSVFNUTNPNS9rV2ZNZnN2NVdLR1VQaEdES0NGVGZuRjErY1BzaVkxMS9k?=
 =?utf-8?B?SVlMT0ExTjlicWthZTNMSGh2ZFFxMlk0S0g0dDhncTN5TmtMM3UxQUdwc1B1?=
 =?utf-8?B?aElzbWFWMkdYaTdtSy9ndEdsdFZOVFAvSmZxVytpWGFQdFFxamxhY2N3R1VJ?=
 =?utf-8?B?bnBTbHpuaWhQU1NnMzNwNk1MVUdEUGoyQ0dVMmQ5QWtEQkswam9QdnJjRjli?=
 =?utf-8?B?aE9ISnJJdXRnWUJ0N2E4YWdwazF2Umh0bDdJa05rMDJzdnVRa3B3Y2lWa0ho?=
 =?utf-8?B?bWdPUk4vSXpaOXRoZWpjRWNuTjNZcUZOUGlkeTRQbnR6aGVJaC9MMXczOTVs?=
 =?utf-8?B?bUVCSmpPWXk0RDY4ODFDTDZ4b3pjc1RLOEhrY1lQYW9iM3lFMXdYTFlKWFU0?=
 =?utf-8?B?Zm4zUTJUN01SdjdJelNWMzRqRk5sUkIrUEMwWEszQVZ3c0pDRVJNUmRPckE2?=
 =?utf-8?B?SGEweVNFM0lTamdBSkFDZlE4SXN1cUVmY2d2YmtsbFZ6bWljUGM4SFVzNm90?=
 =?utf-8?B?Z2Fadyt4WGYwMG0xNXowK2NBeGxFMWZYbE1VbEViT0hnUGFrTWZyN2YxeWtV?=
 =?utf-8?B?dGlxQ2IwbzdRY1g4cGpDOE9FemF0YmYrMVVTM3hyb2N3WitwUTN5TnlYTUll?=
 =?utf-8?B?alM3cFVOZ2VvazRTeFhSNGZ6WjNWWGM3TUErT0hzQVp3S1l4OGFoT2JwWTMw?=
 =?utf-8?B?Tmo1V2RrTGVLZVZYWUcxTVdoSUtMVE9Tb1o3ZGNyUDRMOERXKzE5V1pPYlVy?=
 =?utf-8?B?YUZCWS82N0JTb1pRcnhFWC9XcG1yQzVsOU9Od0hVTWo4VTlGb0Y4bEVmSzR6?=
 =?utf-8?B?ZmxvbDhKQWdIZDZoOTltLzBsZmN6L2sxTkVaYVF5VS9LU3hVbllTN3BGbnVM?=
 =?utf-8?B?MXkvVndpWHN4N0lHRnBwYmdJaUoySzBmS2Z3RmM5amp6QTVHQ3FUWVVVY3BH?=
 =?utf-8?Q?pYQM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a65c832-b880-419d-fb0b-08dd73ab4384
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:36.6961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuNNpvLlDtUgTruyxbmB5hZlvH1vM5KhQO8tDn/oR7l8L1sq8m1s3dE3G6SHsxwSqWK5IxS9tYGVgUZ2WUuFQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v15 to v16
- use le32 for doorbell_* register and use cpu_to_le32() and le32_to_cpu()
when use it.

change from v14 to v15
- none

Change from v9 to v14
- update commit message by use pci_endpoint_test -f pcie_ep_doorbell

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f4..b9cb1ab218f2b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -66,6 +75,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -80,6 +90,9 @@ struct pci_epf_test_reg {
 	__le32 irq_number;
 	__le32 flags;
 	__le32 caps;
+	__le32 doorbell_bar;
+	__le32 doorbell_offset;
+	__le32 doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -667,6 +680,126 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 status = le32_to_cpu(reg->status);
+
+	status |= STATUS_DOORBELL_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (le32_to_cpu(reg->doorbell_bar) > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_data = cpu_to_le32(msg->data);
+	reg->doorbell_bar = cpu_to_le32(bar);
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_offset = cpu_to_le32(offset);
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = le32_to_cpu(reg->doorbell_bar);
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -714,6 +847,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -987,6 +1128,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


