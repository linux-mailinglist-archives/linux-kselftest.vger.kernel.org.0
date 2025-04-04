Return-Path: <linux-kselftest+bounces-30129-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27258A7C365
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC155178F99
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E5621CC71;
	Fri,  4 Apr 2025 19:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yx1sPAyH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEC321B9DE;
	Fri,  4 Apr 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793305; cv=fail; b=N+8W+3AhSSe2EdcPGKk2lzcDMajxwM+DFdeXaKTetSgYfppiw8jSrvBKRsbYswdjcbklCAygIj/eGHCYL1FJfW6irOUt1UglC4/uwCSAHh52RAMBHVXmBZzHu3UPuhbi0tLFFG8x9pfslSK39jz04eVY8575CXC7WdWOElfQtqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793305; c=relaxed/simple;
	bh=ThyZOhwaDsp4V1j223U0prTZIbMrn8Rf6YEorwRizOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ENyofM6x8JdzGl+8dpdqV2LWkiHF4j6Ug+iQdelzf9OE3GzNYKanrspTJPj2QboJQI9ukhdWqs8KQfLvok2Ca4liTjJHPjwFeSM5w1edQbz5eCY7TKVQ3AMCRIrLnTsLrQNJzx7sW6J7dHZ/UJOdeILPFpUVbWZL6Sec2M07gyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yx1sPAyH; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxGEEq8yF8LAVbOqGMNp5rCrTTu6wmxQOUpQ0fkULJ97uMcF2vRtUI29KZLNVq3BEe04OGdeDqD5vGLnuXVUrv0hw1JO4iXjKEpxxY+lvRtWY0nEoZUxNkf7OZAkx32LX3a1LUfJdTkJbAaoguvkR+qB/s+clzyr9KsY8mmvkk5jGirfmn56a3fdP0Gh9ZB7LCYSOkBXf/8T1LrlRzgV8MQ7zWAukYwv+wPXa3fTEHABn/5DSxEt+AmrFiXU54FlAmH9JNd+0IV84488hOkKzQ5MaFUmUrWcUuLDZCilzGu90H4Mw71UOp6j/wbiLbUVq+49yQQ8fw2KBxJ80i89sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBhEmQ+5keqgx7M1lTMSB3Zen5LLbLZOcXbwQxpRbuU=;
 b=VbSmI0aOeeQsGSgl1caEKRjyDmtfTr1MwEA8XQb0PPLsI47JwSFuoMrlTcKHIFowIyvkJ3Ue0FD1ZaecMpf6raG6xSo6zvIRux6K+o/W7Oj7QG423JaP8pye7zgoysxqcb2PSkpc/gAoTjvulHS6otBuwWXb9AbJ6FLSOZKAn6EUKQUZaULLtxXehD0pJ70DWQEFOEfYNCgYbRe8B2fb61UlxWJ6hy9Z2e9gxGBem2CbRU8eO6RhTNNopGbCA52PR2dx5bR41YdvK6AtonJ7T0XsxkIHTj+hEDdGH1D3uKyldkSUYC/5b22SAVCaYy65MetCfqauJOSG2ACLVomJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBhEmQ+5keqgx7M1lTMSB3Zen5LLbLZOcXbwQxpRbuU=;
 b=Yx1sPAyHntizRq+nveSNCdV1IlsspPAb52/4WArtNxpJLIrR1ipPRJxkGsvWmaH6A0OHVCTwxMleY1058jr7EyHUdu4ivc5nIYxF5wIwPU7sdL1KoRI/0vyS/GAzlUK6JKtRYQUnWDLtv+Z4WIDW2qgM5i21Xo95DtiKX+q49my0cWnNEWDBfRVbUF5Ye6h1GhA6h6viT9vHHX+JebJf1x+HqRRUjlOZxTJvcAuOoPQ0EMw0L0Y6yk/gedtF2ew7HYrZ+vfgalpg+RyClg/OKtF/5o99snEeWYsWjheT8eW3kfAWgkGg81WVOy9cQ6z60o3jAAkZfIyOhx3VEYYlcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:01:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:01:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:02 -0400
Subject: [PATCH v16 01/15] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-1-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1529;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ThyZOhwaDsp4V1j223U0prTZIbMrn8Rf6YEorwRizOA=;
 b=B6zKGe8sGXesVcqUDauE2TytW17eF8afP3JuSmZtZWTTSKyKwuQCN9XQkzOX3VlK+1azNZv9i
 GFGwe/h1HIkAW5zhtNXkZcymgrtszqKhvAbaDEAldP8lfP0p5lreAkG
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
X-MS-Office365-Filtering-Correlation-Id: 8d568149-482e-43c8-9e5e-08dd73ab2235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTZJdDZ1TFFvRUhRZlFBSnIwV2tLTVhQa001QVZMdDRTbUNsZVJENnJyMCto?=
 =?utf-8?B?OElnUzB2aUkwanF6RFhZaE1VWC84RUtZSUo4UFF0QmJJL1FLUlBvdGd6aDds?=
 =?utf-8?B?ZDFhUEhEdmF2N1M4VThlQXpoRW1sZjlvL2E2VkVXam9NMFh2UXJmYnhuSGJw?=
 =?utf-8?B?QzlRZzJVM0JYMlJjYjErNW4xVG9DSlovRVl5YzNTWit5Uy9IRk1MVkZYMlFY?=
 =?utf-8?B?WU5GL2M4V1RnOVptZzIrZHZzS21wWDBUa2xtT2Y1TlZCU1BHcTJnTkdyY085?=
 =?utf-8?B?TkJ0M285d1VZM012VW1NVXFDMTBoZzBESTNwRDlDOWY3ZUFjUlJpK2kzQlJI?=
 =?utf-8?B?VzZiZi9hN3VTL29IUWtsL1BVMWNLbTZReXg4NTlRWVBCTzdMNHVrdTVzNDVI?=
 =?utf-8?B?cG14dGJHZzJYODVCYWxOdTBaYUZScWxwUzZPSy9kVnRhK0dmYStINVg5b2lN?=
 =?utf-8?B?WTdZMUJ2Q2FlU3V3aEFyUXZUY1FOTmhNaUFqb2xtUkxLamprdGd0VHdjSW9i?=
 =?utf-8?B?c1ViaytkeEZqaitMbXhmWFVZa2NTZXMyNEIvWTJOYnRUTk9QdU5qVnFHUEVL?=
 =?utf-8?B?dXEwTEt3Y2wzZkQxMFNGMTE3dUlNYWdTaWVKR1g0WVlyS0VLSERqTXEzREtN?=
 =?utf-8?B?d28yL0U0UmtTWmtCbFlLMklGZUxCOWo0QnJFTkh3VmRINmdaWVdnLzhaUEpu?=
 =?utf-8?B?UGdGM3hLUE95ajlyMk44TmlzdGt3RU4xTXo2YjZKWGxrMDEvUEppRE9FS0Ju?=
 =?utf-8?B?S1BXZlhRK0o0cmdjZWdHQnk5Um15MUlWSWhFVGpibGdKQVJvSC9DM1dualRK?=
 =?utf-8?B?WERDc1ZQTnM3V0hoQVVSVU82VThmN0NFY1ptOEU2ci9FZTBpQzBaeThSWWxF?=
 =?utf-8?B?dzUxTkpzWVJMRkRlMUttSGRIYk5MUXVyN0x3MzJ3VjNnNTM3eWVycnl0b2VU?=
 =?utf-8?B?UTZDbkhSaXIyRVB0UlpkbHN1OUdyT0dvcVBlK0dOMEJSSUZkeGJnaEFEUXdx?=
 =?utf-8?B?WXo2U0RDSTZEQ3B3Y2x1cG1KVlZhM0ZsdFhtK0xuZy95WGc2bXNubThyMngv?=
 =?utf-8?B?NTVmcEpabWNLWE4zOUJNR2F2Uyt5WTVGbGhZZFB6NlpLazBNbnBvMURRZlFw?=
 =?utf-8?B?cC9KUnl1UlpHNjZYN2plcDFsYlZPbDVNdnhxcHpCaHJIaEdhaW1rR2M0alhx?=
 =?utf-8?B?UWo5QzR0TGptR252N1U4YS9PUEpHRkQvRko1QVU0aE16N0d1UjhUcjdMOVZR?=
 =?utf-8?B?Q3EzRUU1NDhpaGNYK1hYRGdnVnhqR1RTZ25DM2J0TGhKN1pPbExqWkZORytO?=
 =?utf-8?B?eDhFUUErYVZDUGdiV3hkeEV0aGE0dks3dGFGVFVTcDJLNVAvWm9wQS9GSE5G?=
 =?utf-8?B?ZmR6cW90SkFQUFZoVUtlVnVKZ1k3MW1LdGJOekFiZVlXUU1hRXZmWGJUZHp3?=
 =?utf-8?B?WGtDSnBrOEh0TVZJTHhiam1XWEEyek5vNVdzOUtzdy83TGY2ZzRaOVRENjFR?=
 =?utf-8?B?K2duemF0TlNEM1E1a0hRaGdCRHovM3g4ejduYXVSMU1UbXJKNG9OMmR0N0lN?=
 =?utf-8?B?a2dtVE1iWThHeTM5V1gwQURDMnhxS1ZVWFdsdzNrc3hMK1NweDJIT1d0cHNJ?=
 =?utf-8?B?UFovZ1I4MkpuTDFzVVBDWTlhMVA0djNkU011WkFRWjlNTFVVelJyUVY5UTRw?=
 =?utf-8?B?OG5RUUlZbmFDTk1ROTcyRmJDaG9SQUthRkNFK1ZGVFVZbWs4NVM5S2Q3b3Rm?=
 =?utf-8?B?bmpQM3E3OE52bXZuY2gwOGhWT3c3RGphUUk4OGFIRXNMSmh3L0VzRzRVdnVZ?=
 =?utf-8?B?OUR4bUhCLzl6MC9JczBhRWFmREtTVU5TdGZ2NmtldGM1d3VJdzhCM3JSUmZM?=
 =?utf-8?B?a3FlbU0zbitOeTk0MzJYZm81aDgzMDRRNi91TWpKZllPSmM2MEpyL0lSd2po?=
 =?utf-8?B?ZEZ1ZWRBa2xKQjZXMkNHdlVaVTE5d1ArOVI2TjlmRjJzNHIrbTdwdDg5MURm?=
 =?utf-8?B?djNQbmdjZ0VnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjlwbFBHUjY0L2xUNm1XanlCeDR0bVhNdFZDYmFpQVNQREpTWDBTQ3pyeTZi?=
 =?utf-8?B?ZnVEQW1BaG1yNENmM3ZkdWZEZExBSnFlOUVEZ0J2SjF4d0hkNnA5d0IwTnkr?=
 =?utf-8?B?R2dZZHptcU9obkEreGV4R1BUcGFDeko3cWFnUXRCcFU5RUgzM2pCSDVEdlRI?=
 =?utf-8?B?Y2FuYVJyQ2NzOXN4ZzZBNGR2eW1zUWZEL3RxSlhkOVM1L1REN2RNZjM4VkNU?=
 =?utf-8?B?ZS85Y1RRbFdwNGY3c3QvZmR5SFVpcTV6OWNLMkJCUFNLNUtkU2M5ZSswMis5?=
 =?utf-8?B?Z09uTlNyZGlNaUxhbjdocWtqMytSU002STR0OWFuaWFlNlBWZ1BiUTlDZFZS?=
 =?utf-8?B?bjJ6czNGQWY0ZDJzb0VEUkVocE5CMXdiS2dlSFk4UEk0TDJqenlrU0N0NDZa?=
 =?utf-8?B?V3ZDejBnb2hGR0ppUVpZaEdWdDlSdEZGaVlKSzhvQmljMDllVHhJQzRZeFZn?=
 =?utf-8?B?b1huOUMrdStXTmxaT0NHZ0hiamg3QUJsS0RyYjNvNkJwOXdJZkh0WHJsRm0x?=
 =?utf-8?B?aGJWOGc3RzZMa1NOWEI4MzdpTUdvSFNaRnVkZHlucnc0Q2NSSHdHNURURFZj?=
 =?utf-8?B?M2VWYlJIc1V5WVlPdzFGTTR2YzRmT3JMbVRxY3JyQ0JLbVhHK2tjU1BIc09u?=
 =?utf-8?B?d3UrODRyd3VMSGZpamcvVEJsZmp4N2EyNDBraUREWFdmdTdmQ1YzMWU2V3FO?=
 =?utf-8?B?eWFFRW9RK2xrWlNibTZIVElzUWlNY0dqRmloSHRaK1A1OUNteVRmVWF1TDdF?=
 =?utf-8?B?MkE4aXNPVVFVZkxHM0lXb2d2Y29Rc3NnakpBSmgvTTdCdExWTWdFYTVHejIx?=
 =?utf-8?B?ai9nUWRieEluTnd4MjFHKzlEeHpOOEcrL05rTGhZVEdwN29KUUJsSUFaS0ZX?=
 =?utf-8?B?L1RDcllWNDRDS0M5VUFpdjVDTFEyU0EyNldiOEdUMVVpeUNoeUlUZVV4VWcy?=
 =?utf-8?B?NUJsRXU3QzZtbGxPbjM3MFBodFVHazljakNNMjZJajlEVDMyblByY1ZYWHVk?=
 =?utf-8?B?eXR3YTlvWDlyZHhuaTNobDcrYWNXMlZJeFIzZXlpckxtQjVYUUVhblcyTFNk?=
 =?utf-8?B?QXRESGJyVFE1L2pDRzhxWkI1dS81eXFjMmFHbUNleWpWQUFQRHJiU2dBUEht?=
 =?utf-8?B?cU10YWh6d3ZsMi9hOHJ6VkFrTkJYNUlFcGNmZnZkUk9hMVRWc25lbmozckNh?=
 =?utf-8?B?ZUFKT1hvdUtGM3pnaDdGNG8vZjRWSDhrc2xwa1o5dFZXUnR3c2hPN0pzL0VL?=
 =?utf-8?B?SnZBWTlQcHdBU2V2MXRXVERwd1liOWZQMUxqTGJ1WWJzSnR1UzNnaERTNmZS?=
 =?utf-8?B?d0IvSmNqcVR5OW45M0RJWDdxQnphK1htVkJuMW9MM0c5ekJveXJzdEtSaDJl?=
 =?utf-8?B?dmh6K0ZVZ3hhL1FiM2lTUHFVdTlwa2N5bmc2S01kZGVoLzc3ZXo3WW5qVmtZ?=
 =?utf-8?B?K3I0c2lkTVRkT1R5TUVxRTBCSGJUNjg5SFVrOVBWL05saFNJTkJLOUhmOXJw?=
 =?utf-8?B?UEd0SExxNldVS2VZYmVKL0lvblRmUXRhNklBb3ZORGFRUWFhbGZWV3Y5T2pZ?=
 =?utf-8?B?REx6bU1vU0xXTGRTMEUyckFjQnFtbTh1YWo0OS9pelkxV2c4SXhKN0NCbHFP?=
 =?utf-8?B?UUhzTWhnTFFJc2NMVUo1cVoxd25JVlJlV25ON0hXYldwdXB0dy9SanN2RDR1?=
 =?utf-8?B?dlhYc05JOG9Qb3VML3kwQnBkY25zK3cxQ1p0ZVJWSS9uZ2lacVdVZW9FSTNo?=
 =?utf-8?B?UWVZYkdwMnN4ODlBUS9zRlovdDRqbjVLNFNmbXNyWElkVHBGMitzZ2l4MTdo?=
 =?utf-8?B?T3piR1pHZjdiRXUzUnI4NDA4QUplNWp2RzRYZ3lzZFluckZXY2pXRTc1Yldn?=
 =?utf-8?B?eEZsN3lXRTcyejhPVURLa05pcDNjVE5DZDRVRWc5TitSRm1uM2VSUUdib1Bn?=
 =?utf-8?B?UmhPNWJHNFVGVHR4UnRnUk5ySkh0UmszTXZsOUEwRW5qTFNyNGRKcGlWTWt5?=
 =?utf-8?B?OWdsdzZrQWdXSHJUREd2ZmR3NEZCYlFIM2Y5Y05FbUZ3bTNXUkNPVU1ocCtT?=
 =?utf-8?B?NG90UWJoaVV3dmpJcVdmeXVVUWk1dVpFUmpMV2tkLzVNMU1JYnhaU3RrU0VW?=
 =?utf-8?Q?ZlFc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d568149-482e-43c8-9e5e-08dd73ab2235
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:01:40.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XiaLS+5lDOHRQo1lLOKfXBFzLX5W+WyAB2J9nMEcCabTZB6Mif0NK1gAiYPyQLtYni1vvoUJ6FRuO8YcvPaiBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

platform_device_msi_init_and_alloc_irqs() performs two tasks: allocating
the MSI domain for a platform device, and allocate a number of MSIs in that
domain.

platform_device_msi_free_irqs_all() only frees the MSIs, and leaves the MSI
domain alive.

Given that platform_device_msi_init_and_alloc_irqs() is the sole tool a
platform device has to allocate platform MSIs, it would make sense for
platform_device_msi_free_irqs_all() to teardown the MSI domain at the same
time as the MSIs.

This also avoids warnings and unexpected behaviours when a driver
repeatedly allocates and frees MSIs.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v14 to v16
- use Marc Zyngier's suggested commit message
- Add Marc Zyngier's ack tag

change from v14 to v15
- none

change from v13 to v14
- bring back from v9 and remove fixup and cc stable before it is new use
case.
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0e60dd650b5e0..70db08f3ac6fa 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,5 +95,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);

-- 
2.34.1


