Return-Path: <linux-kselftest+bounces-34505-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B78DAD2424
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6531116EC6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E627721C18C;
	Mon,  9 Jun 2025 16:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J6W6eVlX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C521FF31;
	Mon,  9 Jun 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486917; cv=fail; b=Fh4lsgasNLLHZ8U/UA0ne1oHF3nv/fbffwv7DF1vVRJe7tFFZY0CeCCl4+Fh1xMIAz6PY+jZVHUVZ2hcOsCbP3zwpDisDXSo12mOFwWM044M/y28t1VIxipx8S0QwyK6+LAr8tvcvlbgfwpYlOKAgpoHmp+P/vFaMcL5ZisfoRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486917; c=relaxed/simple;
	bh=/VaL57S87iTWyhyr0cQP/C9mvzZlrDtUtC1Vhm7gNyA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UuWAo12FAnxiui+3dPRrAeEML3fEzLGomYL02GVkQaX7D65awpwkDqKJLYZlUOJjGAcis1Jj0TICI1j1uZlOthUS7oHvI6LerFcaPTJVS2PUw7n5zh9DfylC1syIKEMBvIH7i5EP8/D39hyG2dyH6t/ZfjwzydoznAR64dHAU/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J6W6eVlX; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLOkbwMIirrLeXdSSoQ2StRbVUH1wsPOBZqm/1i6gQ96eyFrqeYG8i94C5G4sDNT88U+0rSmHNZSK0f4rnK6oXnL+eenMtSPBwgD9iLmeSbaK5eZsUAG1jt1Ql1iHxN6+pVZxGU+knP68yp7Q5nP5ZtgYgjYS/ZiUo8hA2N6Tb+1NtyQiZEz5YSov/gDq6I0N8ifQdptJ1FpvDvkTZWEJ6e/hAVn1kAsHgRyyJHu7mryIaF6/KR80X4daUWD7wmVdu34quV/mDsUUwmZTPtAYUhJOfC2oTTD4dgAtTAH+/h8Bpf8Dy9OqGyUIbVoMeEOOa19GgCYKv/j6o7GLSGD9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1VxgrUfI6zLgKn73eQ7Mq07nqcKAurzSHswHOxtOsc=;
 b=IWdmMALMNybPd/e9UMhZr7l0H348njUMLypNYPkOPY2QIuuXFHjPI68CWA/P3lXhUtbzplv8vXtG5U6Lg76AMEr0V+ItWWpe1oA5UqoR8EeePV/P9lwoBbkOD+TPlWRv/Hs64Q6Buj+2qfi7TWTMR6kipBoVr3lbbUTz/WzHLF8HdV0WkKWttsWxT6xN3n4+XQWWUJSkJ/DXIeKxzOauLCbQ9gjOPQxxb9YczxUjIU4pBfzjR90ZSx0pQm+vA16VopUXDpLviwV/c6A+IvvhXIkyHPiJx58jo2keGD4qSquAI0jYUeQ6g+aCAiUYc5wFgk8ertBPNrEd0gqMutVcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1VxgrUfI6zLgKn73eQ7Mq07nqcKAurzSHswHOxtOsc=;
 b=J6W6eVlX+MtWGqt/mP2+WJspqhAtTiKmgh4ErOylvc00XugsqjFkmUA5Ck4lTga/vMOHsQL0wpZTvu+D830XA7lSW6/ZhTqQtsnIhmGCY2U4ACNRk2uznGwyV4ES/qxm9LcbMwZ/+t2UgrAJ/5ARSsyHZukKvVl6Fx2MzLC1iPe4cI1xgDrAud7TifRcOzB20MZRb0xY/kQp3UiTKrf2nwQVRwafSW3muw+s5L85Y724KHPBXoSN0UTYFyfUJOKUiKeXJ+XkQuB8PZhmppHGrDKIKwoc8WaZ5+S63nqxkbj0CM6OQirQQmR5HGnO5MHxhdWsRNbAYEm5cS9MA9PMZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:35:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:35:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:20 -0400
Subject: [PATCH v19 08/10] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-8-77362eaa48fa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=1816;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/VaL57S87iTWyhyr0cQP/C9mvzZlrDtUtC1Vhm7gNyA=;
 b=gBZDe8meYFD/Ekpd9vw8SXVyZXfAR8aI0zlm2GcHmQgHc5KFLNv7KPByaI/OvA2VRFnGgQV3W
 0EUcPA/zLpzDI1njWzaDUNA78SkQyuA35Y1RW6j+QQbQPpVS7U36hZN
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa5c48c-2eea-409a-1178-08dda7739be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitJeW1QVXRPOTJzSVRTWE5KTndHR1ZEazUzTXJRTkdIT0I0RFNmR3crVUFN?=
 =?utf-8?B?UjhXU0s4QnI1bURzTE43Ukg2OGxtRU9RTmkwTmUzNnNCUEtPb3FGdUJ3MlZF?=
 =?utf-8?B?N21IQmE3UmRoMmFqeFg5bFFNSThQa0hlRzlQczFOUENBWDJyZld4TVhCdVUy?=
 =?utf-8?B?enpHVjhqeThLRkx1QVRwTzBqT2RvQ0RZM0NtU00yTzF2REt1dWVQRzY5bENK?=
 =?utf-8?B?L2REVDZ5WnRaWjdmNUgzNWozeW9wZkJ1Vmtlbmp0eisxVEE5cTZZcXp2dG5H?=
 =?utf-8?B?MkZ2ZVBsMURpUG1Uc3dOMGlOUWNjdnJQOVA1bU1FdWhKd0w0YWl3c3B4L204?=
 =?utf-8?B?eTN3eGU5N3FyUHhKYWdvV3l0bGM4YzRzWjJ3MVZsYXcxN01JTk9UWjNIQTZa?=
 =?utf-8?B?amUvNlBDRHVSNnYzUTl5SkRETTJhVkV3amVvNWwyblZLU3FGSnZYdUhucEt6?=
 =?utf-8?B?ckpuYS9RMW41YTJLaGlMa2UwVzlOdVRvR3FlTXJRTEJxUldTSEYwMHJLR1Mx?=
 =?utf-8?B?U3NPeWFvbzk5ZUlDaTJ0SlA2SlgxbVV2bTR1ZENjYzBZMVU3ci9HSW04STNI?=
 =?utf-8?B?NGdVL3dVejkvRWxPczlnQ0tzd1lab0hiTCtqankyMGRFZ0hDVHpXNzUyMGc0?=
 =?utf-8?B?cFp6aU1rM2F2NjJjNWJEdUw2SmlGZGh1dTZpcERSY2xGb3l5bFNuY0dQK1JU?=
 =?utf-8?B?ZjBqK3FrUWhGOTk2S3FEb0t6SmF6RUhTZWd2N3h4MG13ODlWQmZXT3BITlpl?=
 =?utf-8?B?aGhFQ2xKYXdQRjlYaHNKUldHT2xoVmFrc25wc1dUMFFGQmk4S3JJcXA5bjZM?=
 =?utf-8?B?YmkzTXBqYitaTHJVMmJsdWR3U3Y0MkxJeDFYTG0vTzJTbWg1b0JEMmdGY2hF?=
 =?utf-8?B?b2EyUTFFbWwrYWwyN0VTN3ZrOXdoMjFmRmZOSXNac0lTWHdQMm04WlpQMXE2?=
 =?utf-8?B?QzJGVHlmTkRJSW80ZWFsbGE1UmM4RlFra29tSlo0cS82OGlhT1ZJWkJPT055?=
 =?utf-8?B?eDBmc2lJS0xLOW9vN0dkdjREZUVYSFluVVIvc08veXpnc3dzNkRMSUk1YUIw?=
 =?utf-8?B?bDFMVnZVdERydlpoWWFKRnBpUGtRVWMxZmhsMUpYbGNKbXVUVjB0RE84RHpH?=
 =?utf-8?B?dVJOcW1DSWp6TnF5QzVPRHp4aUM2NHoyUXpqL2RlbWswZnBHS01zTE44d1Fw?=
 =?utf-8?B?M0Q3Qm9TUUxjZkpNQzFPczFWejhJWDlyMVRBaUZsbVgxUDJoQ3JPbU9UM0VM?=
 =?utf-8?B?WTdNcDJGamcvWmZTZ1hFWEQweVAvRHIxYk9oemxXRE11UE5RQkdudVd2OEtP?=
 =?utf-8?B?cEZRNUdJa0J1RUJnUWh6Rlh6NGlzM2JsbjIraDNuMk1FVE5WTytKMFlBd1B2?=
 =?utf-8?B?Wld0YjcwUjgyUGx3MHpEYXhVNzBua0lBSTgxVEEyQ2xRZ055dml6MWVxeHdl?=
 =?utf-8?B?TExxYzZNMWtxQnBFaS9sdys2WURSd0p1M29lT3kwb1RuVStMbGRjTDhJUHNt?=
 =?utf-8?B?ZUYvQzl0RXRLUWtyTU1PTkhybDNpYTJwaDJqOWdDWktOTHZ6c0Y5TW1nSmpI?=
 =?utf-8?B?ZTNJdG9mWUZQVmErL2p4MHlWd1FPd3hqNFBHU1pzUzFNbVdDVThVODVaUE5K?=
 =?utf-8?B?bXdGMnBLSE1vNmloTllFeFE4S0Vib0VQaXFWN1RadGpjVGJHSmVtaGVmRWpK?=
 =?utf-8?B?RHd5ZGhwZGtXVHZyVklaYWFoYUFZS2NnRmxFeXdCd0xKNlh4M3MxamliSGpp?=
 =?utf-8?B?aHF5MHJXa2RKU0xzeTNxeVdRclhlVkdsN0kybGZIM1FjT0xiL3BQMVEzeWNn?=
 =?utf-8?B?YWREd1JGOUJhU2hGVTVyNUh4ME1HYkQ2d3JtaC9WTk40YUNvbTBOODFKUlpx?=
 =?utf-8?B?aUlFdCtwaGpPWUxhejhXQVZ4SHhEaVpBN0w0UmZlWUJBN3Z5TkRacDIvQnFm?=
 =?utf-8?B?Mk1QQWU1Yk1aMHZSUDZoem8yYUhpSEcvWnBvRHlJdGQxdmlXT01rOFVLV1lS?=
 =?utf-8?Q?RxA3n/ucpa6wg9kG+GB7m6eVPYEe4Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnU3VnNJdFJraW9UWHlrbUc0ODNYcWE2QTdIVy9udXVPSDA2SUx4N3ViTUk0?=
 =?utf-8?B?ZUMrdFZTQUNwamFZNi8xUUVRUzZ4bWYrU3F4dHNXa0NNcVFKSDd2VXkwb0Vh?=
 =?utf-8?B?c1VQOTZRQmRPRForQlpleXRQUC9XYnc1RWRtQnI0SXc5K08yQWVncEFrVGlG?=
 =?utf-8?B?ODh2RmREeWpOc3E5MzFqZUxPNmcxd0VBSFM3Q01YWHJuTmpIUVBjUWgvQUk4?=
 =?utf-8?B?a3FXSmU5Nzl0dC9YNHpUNjlhQmVNTjBzWDhWMW15SlhlN1dmeTBidzFCNWow?=
 =?utf-8?B?Mms5SHBxdzB6Z3F2MHR4T2lJVm5vOWhJTE5PR3lNd0dhZCt4Z1ZiamRtQStJ?=
 =?utf-8?B?Zi8yRU9RWUtac0ZhOUZKak9TcmhFS080ZFJBNldESURmbjJOM1ZTRDdOVTEw?=
 =?utf-8?B?elh5VXFvdXd5cHNSSFFBcm51azZNN0ZGd211d3Z1NkdsME1CMitqc2FBWTRn?=
 =?utf-8?B?cjh0UHhqaUdFT05wbUFxRmZHeTc0Z1I4ZEd5U044M3lKZGlpM29RenVNSUow?=
 =?utf-8?B?aUJjZkxzRU4rN2l0cnRmWE1GTjBWeWp2dGlEdi9kM0RqaFJpUEJrcVZjd0gy?=
 =?utf-8?B?R0ZpcFNac3NZMFRwdVZLWVExUWVXNmxOdXROS1NrRmx1Ti9KcjRPaUFMNlNE?=
 =?utf-8?B?bWV4TDFQS1FmVzVxeDBNd3hBUEIxTVpWa2dJeFpNcTFIY3lDQksvQ2lyVjFs?=
 =?utf-8?B?VmZWamY1aFd1UTBVd0p2RnlBT1NLaWlteERQS1U3SUdETmhnbytDMVNlRWgr?=
 =?utf-8?B?MFRtRzBYWTNJMHZueWlzRmxTM3JJVXlHaGlNRC9FQzdqYXNlZ3hNL1pQNHlI?=
 =?utf-8?B?M3RtQTdGWEVyU280MEpZc1JVdnRkaW5UbEw3bzFYeVpIREROVXFlcVMrZTNK?=
 =?utf-8?B?dG1DZ3ZXSVJpVzVqaDR4TTlWZ00ya0ZvanQ0bnlWTVNabGkzaUhHN3FRRzlr?=
 =?utf-8?B?NDdHL1dwb1c1cnovMzB4cktnWFRCME5hRHlxZ2Fna1p5dEJCaU55Szc2N2xj?=
 =?utf-8?B?dzluUnl2S2VldEt2ZDR4d3Y0bG10eEJUMlMvTkN5N0txb0lGR2JxdDkrRXRG?=
 =?utf-8?B?SVc1TXoyV21HaklYSGFYNGVybVBGT3Y5Vmk3Z3M0WmxhMU1mekcrMHNreGhp?=
 =?utf-8?B?STFTYlVmZmtyckM5bjdxaWk1ODllRUVBdTFUcHplR0tqVnRKWTVJRzd4THRj?=
 =?utf-8?B?Zk5SNzZYYUNaS3Zha25VenB4SmEyTDVlRm1JT1hDTExtV01MWXV4ZFoxVVUy?=
 =?utf-8?B?Ukd1TlZ4akR6YldwMTZnQTJvcHNMakM1RWIxdVA2N2VKaGlwenNZSHZTSzc3?=
 =?utf-8?B?Z0k4ZkNkS3BwQXJueFZrMUpRZllJWnNkSHdSOTIrcDJyMTlrYThVMnJyc3Ry?=
 =?utf-8?B?VDArTTd5Vk1tVmxTYWdTZ2JRNGQyS0R3NG1VNlY1Qk1TeVR0QlJxWlpySWVu?=
 =?utf-8?B?dEdXd2ZXMjNXUXVrYUdNM1J5cEc4amMrQXdteWpicjljM0hISzUxcjZxeWl4?=
 =?utf-8?B?emNhaW5FSlJCKzNnUTVLcDY0Uy9UL3lsaDB4c1daNU5JZk8zUEJXL0F5MmFN?=
 =?utf-8?B?RlFhNmZhV1owRWVjTnQ3WmlGZU4rLzZSLzM0VCtMYlFGbDdtM1VuVHJVSVIv?=
 =?utf-8?B?NTRPMVhPZ1BIeUdETWVDZWFHb2hNWU5MejdhSWM0TVkrQS9xY2Y5RnJKNWUv?=
 =?utf-8?B?ck1NNGFMWFcwd3NRVDhseXh2NnBQdDFHd25acThtWXBuMDlUTWFjdStZd282?=
 =?utf-8?B?NUVyTUMvYVlTZFFyNC8xdjhYdXVHa2hhdEovNkZrVENzTlByUjZQTjhIaFB2?=
 =?utf-8?B?THdxU0pYUTJ1ZTRiTWZSRWRzN0I3MG96b3BwbXM3V2krM0Y0aEJVb2hkVGtE?=
 =?utf-8?B?MFdOZkVzTm84V1Y4eVJzSGRNTCtzU1BpUjZxYTNKK1pXbW51dkJISFlpYnNp?=
 =?utf-8?B?bVFKOHdMZE54UTNmUmtzaEI0SThrSUcwdTZhSUpLVWJvNmU2NTV6Uk9HNDd3?=
 =?utf-8?B?cUozNzdGcFFRNWRIMGlnUSs1Mnlsa05OZXA1am1NRXRZSWEwc2JuYUJUaFMz?=
 =?utf-8?B?Y21aallRTFpUMVRkZ25lbG5PY2Z2WUVqeDNCUVRUOEYzcStSMGxuTkhTd25h?=
 =?utf-8?Q?cJCnhADqb4yr73Ekh+ytVE5/k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa5c48c-2eea-409a-1178-08dda7739be9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:35:13.7696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUGNwywkwLmT8oayADLVaVsefgVFiE9s6Wcxju+WPkJfGYjcLit+x/dcgczZXb3CV5qvBF7mMRUAQwdMkEXGKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

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
index 5a38cfaf989b1..032b906c44dfa 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1096,18 +1096,14 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
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
@@ -1182,6 +1178,13 @@ static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
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


