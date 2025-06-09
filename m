Return-Path: <linux-kselftest+bounces-34497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D5CAD23FC
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5812B16A828
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9282721ADA3;
	Mon,  9 Jun 2025 16:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihfVnPt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33020AF98;
	Mon,  9 Jun 2025 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486878; cv=fail; b=PSujWeeQojc9Zqt0u+wsuElCK8wm/oQBqFhdpX9gGL4jgO7Ul6Ur6e/N8QfrdMOfXfkh/dlF7GB+nM1F+C+m0cuX+3wUcnir2wTyXMwhqlddCSiVyWd+YAKMcZdnFhZqTDhQT/EQKTq2gaBWh2G0u6xZu9O8WRxSnBY7mx1MBYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486878; c=relaxed/simple;
	bh=VBkCFSbC0zrohz26cWWLOSBEwzvviEfZMBEQ6Sl7eWA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=H4hu52GFiBzw8zSZQwXf1xei3/jxJ2eyihK3vu7Cs630NEaMSs/2YbCNQMdfUZ4B9MmojM9R0J5Y9VAghcmTGvuRN90ezWPBGdDtzN5xoTH6FAWORWwEq1kN7pGnuTlraN/WOvlu4sBx+l7L7EWx5VIxbGA9cvdEeiHRh5SKRXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ihfVnPt8; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kghBZedbc0xEfsdAG9U3+fq4jLKypfAIeCZnE10a0b1lFnOadQbrgocxYG35pIwKAN3JFHdFip04v3lVG4kkEQIL+xxCbvj097nLBwmSZW5gYs0oIJrU54hANkrsv0UpnSO3Q2ZoC4eEXGkZ+gDlIpVPqLH19NSLsRNwsrdfAlUloX0Z5pefvecoC9FOOaKuU+BBXuMQXcYQNa5F954gVnj/IVkh/NmW3yG3kK3TTdtVtXJqZx4ap04NaCOlJWoTCgfSu0U6ZBa4SOV6PRZfXGObaBoATUmE9XDlFBZU7XWg11Y1RrAqrRC9WjajTAH22tWvIQCHvIWThBicXezYnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rr78yXiH7oBeZuysL8Evuhp/feTJjkkJoZJY34T1CYU=;
 b=VugZJm1U4cStGUaJPPfT84wDdBjC4VvmVbuabVQX1NjvdwNAkIbYO3bT5aT050WzmRGXof5ZNoJqwFhARLzJYtKD6ZbSwS2WuWjXuXx1DuF6+jbisXcYzunIobR89jnVHv9Vd7eRjbUBhM/cDxVKq0vGoRfA1scxna2Qb2VkGdNWLQDwCc/YfluigpIJ1OfsEcEIDtLfswDF7gDa2UizeEKH5fWOjvG5SfT1kJUITQlVsiMLo03BfZ6CRaSFtsiV87NUzZc8b+1FDwigXzgm/g4HWMXwYZZdZh9YNXCMP2owKBDww3/vaKV/dvy8T1y+0AenzTmRSPtxr42nI/n/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rr78yXiH7oBeZuysL8Evuhp/feTJjkkJoZJY34T1CYU=;
 b=ihfVnPt8BzUBe4F5ZTI241yHyaIuZrVyjK/uEA3yTGDxYdvpIc+KhR7A3QuP+oUK0Q/y2x9EP6xxzCiWFVOtXZ4CbemZ5AnkJiNlUCRIb9CbcIAsHoE/g6J3HjK6gkwl4tmK3PW0AtaCvI2L25JDusjjp8P4UcuOiP1DrUqPRSYApoLZ/9agi9ooYZXLQVct01tBdgWOXUOPWdoXcz9Td7TWWTjfhYSAO1bMPw6t5e3UybqA9M+YRN93Zfj2tjzusZ3Uintr9TjLJrSEBbQw5z25hfAeMkrf+uz1LDL2kZd0vlVoSDDBHSDucmAsW6GmKP2u8RIZ6u8rNDazvxo5iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 16:34:33 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:34:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v19 00/10] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Mon, 09 Jun 2025 12:34:12 -0400
Message-Id: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAQNR2gC/2XSzU7DMAwH8FdBPVMU24kTc+I9EId8Qg9s04qmI
 bR3J5lEm5Zjovwsx/7/DHM+T3kenh9+hnO+TPN0PNQDyOPDED/84T2PU6oXAyrUoECN+TR+ztP
 ogo4+EAUIeaiPT+dcpuu90utbPX9M89fx/H0vfKF2+1fC/JW40KjGmFN04oEj+JfD9fQUj59DK
 3DRHSJYkK7Igk0ek0hAt0VmRaDcgkxFHrQYiCopZbeIOwS4IK5ImyIWMVPEXXu2R3pBtqKkfbT
 el5AwbpHrES/IVcQFCrtSEoSwRbIiVLQgaX9ilUKkAialLQLVq7W/ukE1OhvJuioT7xn0TFYGb
 eyadPGOxIY9w47Buqw6TTUSJW0Iizeodox6tq4LWjJYc0YQTBH1ji3RMAqVXVnLhrCFAMQFwy4
 bYDrWN9nSEaKPESoCLzvGK9P9JPm+agFJ7Fqsdsz2rGuyJYSJfNDGE/xjrmNdrqBlpLAELQJWc
 zeS2+32C9oaV6LIAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=11997;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=VBkCFSbC0zrohz26cWWLOSBEwzvviEfZMBEQ6Sl7eWA=;
 b=nMAdnkQ7ztGasJYK+iHMiYF99JK2ByKAW3cwMUpR5v5dLl+75y1gQDPsxEXCpkle5l/B1ZnOA
 1V3rBPd4CZ6AAB0QgtwR7GvS3JAH3EzKOJqhtWf91UCEavwFlrPekaw
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
X-MS-Office365-Filtering-Correlation-Id: 5a6fe29f-6dfc-4ab0-d36e-08dda773839c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUwwM3R4QWFjN3JMRUh1cDBYeWozY2hBNDZHYVVZZ0phRFMyUE9QN25JUndN?=
 =?utf-8?B?eEhWRno0WDl0Q2FrMWdRL3k4Rk50SXEzelF2cUZYMXB6c2Fid0U3Q09YUFpO?=
 =?utf-8?B?bVd3aGo4VC84dnhmTjZtYXJDQ0hpYkU3VFYzK1RoK3ZlN2M0YUJmaVBEdWVK?=
 =?utf-8?B?bnpVUHBJd2toaHZ3MlkxZktzeUd4OEF0ejZVWG9lMEExSXFiajZ5VHRmU05j?=
 =?utf-8?B?aVJnNnRqQnNvdEJFbHh1eFJqMkxKV0FOcEJRVHZUVEt4Q05VSHBOdnVJSGZY?=
 =?utf-8?B?ZkplU2FES2ZQRjNOYnlHcFhKN0JaZ0lwNVBta3c4L0hycjNNdk1qRkhYcXhS?=
 =?utf-8?B?cGpCM1lFa2x5Wmt5VWRxeDlTNUZ4WXpmMGhFVGFUNm1hYjROWHBnZ1F4UVhy?=
 =?utf-8?B?RE5KUjlEM0JFRHo0TTlJcGJSTFAwcVU3Vk1jQnlOdXVtcnc2bmEzUUNWaHQ5?=
 =?utf-8?B?U1ZvNVAxOW1GdS9CekEyYzQ3dWo1bUtyT3QvenpGbzc0ZXhIamVzWUR4K1Zt?=
 =?utf-8?B?Z21XdnFrclMxZ1pYYW9CR3lnSE5RSTRkTnN2TWZuQUlPdjdpUTZ4dTNtNjdI?=
 =?utf-8?B?WWlGam1LTTdTa2dvTFNTcjViNVFZWjQ3RkZSVmVJNW9NVWJ4bithVU1ndWha?=
 =?utf-8?B?V2M2bEExdmc0N0JuSDFJZkpHRmpBNGF2VnhOeXZBbGVRbjJsd2paNFV5d3Fk?=
 =?utf-8?B?UC9mbHJGd1hsYS9WcmplMTJVUmp1elJHeUpZb0IzenFtSXBFa3B0ck5VTDFK?=
 =?utf-8?B?ZWQ2cXlYQWNwMGFFaUI5d042OWRPZEFzdTRpenVFam84U1g0K1pKYk5PRDZE?=
 =?utf-8?B?RUF6YUxkeTRGNytla284Y21kVG4vSkU0K3N1TUc0YWk0aUN2UzhvYkYzMmxz?=
 =?utf-8?B?RjRMb2s3Mm4rem5WZlg4Vjd5cVVLd0NZQlJmMFR5bGVEZ1ZYZFNFa2h6blFF?=
 =?utf-8?B?T3BQN1BTdVRzRXFyVGlJek5vek1SSjRFSFdZeTAyV2cwYUcraWVJc1M4cGVm?=
 =?utf-8?B?QTJCdHhSQTJzWEhCUzRWKzBIRVJnb2NMOVQyQVdCRVYyZ1JHSVRrTk5lSEdB?=
 =?utf-8?B?YmNsaWtvN2VPbjNLc3pxc01jaFJJZkg1aldkWUpYdzVSaS9sM2hMNDZjaWdv?=
 =?utf-8?B?TXhYUDNwTSs1L2xvL2Y2TjhMbXlxWmY2cmt5MUNoTW9jNzd0R1R4UDVKc2pH?=
 =?utf-8?B?eThyZ2p0ajJxejdWSWpnTHpzVXJiTUt1L0xDdElXcWhQYlJwaEtVWHFZNkwy?=
 =?utf-8?B?MXB5YUNGNFIrRnZ3ZE9oQVpvUCtQRUpxUkx3SGRJVTg0aWlXVzVYanlDU0or?=
 =?utf-8?B?ZWxEVENkQjQxM2JIMW10NTJkbzNJVDc3czhMdFV4NmtLR09MZ2ZmQ2FYNW1O?=
 =?utf-8?B?OHRkYzBOZGlhUkliRTY5OVVVdEF5VEdmY2NTWm1aUjNnU3M0d0VDNlpzckdk?=
 =?utf-8?B?aHhtQTZHUVNkakdkZVZRSmJ4K2ZiazkyYVhFejQvR1l0c3NTN0U4OG9XNUpB?=
 =?utf-8?B?eHdJZTNZOTBYZzVQdWFueWU4VFE2N2diSlhGUVl5S1RJdXhhUDhTdmNkd2FQ?=
 =?utf-8?B?dXVmZGx6bW1MZk13eVNCKzlqcWkvS1FJOFp1ZFZsYm84YnhkVEwvMDdmQXFu?=
 =?utf-8?B?T0hIUnVlSFk5V0w0R2hGTW4rdWZncC9HUy9NUm9WN0Y2Vk9Ob25PbEJYTDYv?=
 =?utf-8?B?Ym94UnJZUUZVSkVyU3VGN25NWWNWYW13T0xxbURzbkxmUWlYczFTODVPbGw1?=
 =?utf-8?B?eklWOHB5NWJVL1ErbjMxZ254b0lnUEJzdmFibDNmNVlHOUFPSjRRTU5GZnlX?=
 =?utf-8?B?Sm9zN2JQc0lGY2JyK0hpMjVkN1ZSd0l5c0ZsaCtpS1R3S0piK0JlVFcxU2p6?=
 =?utf-8?B?T3F3dWxwMERBRU1LbjA0RWhpZHBVVXZnUURQTkwvT3ExWmUzZWhTc3lHck5D?=
 =?utf-8?B?UEpiS1llcHNHeVFBM0hVYjR0OU81eXRZMmdKb0dsNUdnT1I4TWhFZ2Y1SS91?=
 =?utf-8?B?Y2tBZjlRS25pV2pxREY4MFhjTkJvUm1HaFFoMHBtdWlPdlREbTFGaTV4cTE4?=
 =?utf-8?Q?SWRyOO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmE2VjM2RGFZR3FLejRneTRLQWNtYjh3VjJRdlpmVE1WaUQwOG01VlR5c2xw?=
 =?utf-8?B?V3F3R3VRbFgwQnMwOEJaY0ZUYjRaUW9DS2lFZFptalgvdkJsWlBKUVp6ZGx4?=
 =?utf-8?B?MUx0ODI0MWNEVUFta0MxNGFFSXloQTVxZkE3S1NFUDJ6MzJDU2Q2UHE2QWpP?=
 =?utf-8?B?QmJQaFFac1dhK21SdHgrbHJ6ZFNMNkFaNnlIcFVEdUN1NUhaQll1SUxBUjJZ?=
 =?utf-8?B?bVhmOTJPNmcvZ3hXWjR2Y1BLaFp1M0FPQWl6Z0c0a3A0UW0xWEhnOFF3UDM5?=
 =?utf-8?B?d2xlREc0NUFSa0FSa01RdUJzaHNSOTFnNWlOTG05RUNpbDhzdms2L2pTTHha?=
 =?utf-8?B?SHpVR3dDS3prVXVUQzYvQm0rQ05BcTEwTThqeWZzS1J4TWVmV0lXY2kyME1x?=
 =?utf-8?B?U1Nxc1hnNWhWRStNY1haL2VKZUxZTmo5d0I4ODh2czFCM0hCaUNLWVEvSFc0?=
 =?utf-8?B?V09HQ0dpRi9vZWovaWQrZGdVbVV4UmNrMHZKdXF6eHJaeTg4dXZ2Zk9OSCtn?=
 =?utf-8?B?eksrQ3plQWpJTmRqTTBWclRCSFI0OWRZUW54Mkp0Q3BoQzRwZTZ5cFBlR2Rp?=
 =?utf-8?B?d2t6QXpNWVIyOFZpUHQvWitpQkZrbXBwR2trNXV5UE1yZEdGY2NwTnBKSGJW?=
 =?utf-8?B?bWpaT2ltcDlVeG55eDFkVCtTdXkvWktXWm5mZm9xdWcrUzJZV1hyTFZDWCth?=
 =?utf-8?B?bkJheDN1UzkvVUMxNWVXTlRrWE5DSnhSa3FBTUdqa0RuUCtsS1JVNDVmTEN1?=
 =?utf-8?B?K09EYzF3NUcrTHZGUlgrVVNWZmJSdzhadE5MMzF2Z2hoWnUzUzJpSlluMlF5?=
 =?utf-8?B?eFBxU0VoMzlCZjIxckN5cDBENUorOEphUDRqN3NKcHoyOGhZNGRoY1l2c1Jz?=
 =?utf-8?B?QjdHZVNxVjlPWWV0UTJZTzBxblZIL1NOdzFIdG8rdFJDVjMrMkNYN2g4bDJH?=
 =?utf-8?B?VnAyaVllbjBOWWR0TXFKQkpxN0Q1ZUYzazdJUGYwbHZjYVVpRW83Qm5NUFc1?=
 =?utf-8?B?UDBoV0tkaFVua3hHNWUyeXU5emRzZWx3dXFzMU9vakVubE82S0VuT1BVVkZS?=
 =?utf-8?B?TjJhSHBMdEIzWWp6bDcyWTNNYlk0UmNXbTdFTytzK1hLY0VjeVZKWnBYZWYx?=
 =?utf-8?B?SEducVNZUEMrY2FjeEh2bVVxL2p6b0wxRWhLKys1Sit6djRYQTh1Y3dzTk1r?=
 =?utf-8?B?cDFaemRwcGpWSStuc1liV0o1dnBJQVlsWUFnYUlkSW9wZUVBUm5UMUlpbnN4?=
 =?utf-8?B?Y1EyaXRSeTd5UndndFNxbTMvZE5iMU11enB0ZzB1d3ZockVxTDBmRFhRdllH?=
 =?utf-8?B?RWR4U1kyQjVNUVlTcEI5MGhGOFFrK1JlbzFyZHprTEx1MEVLb29JaGhDbFVH?=
 =?utf-8?B?NlJybW4yMjMvMzFtczNCaWo0QWhVMFJIclpSWGdaTFdSZjNSaTBLZkt5MTU3?=
 =?utf-8?B?dEpGTytZUzhHNDlKOWVSUjVxMDk1R3hJVzE1dnNvK3hBT0NnNWd3NFNQWTVk?=
 =?utf-8?B?TmdIWnRNdWJTU2VMZEp1aXNzV292WmMvNTJxS2hFTjdlalQ5NENuT2g0WUk5?=
 =?utf-8?B?UVpjUnZYL21RRGpWdXk1bklNS3pGVUtrTDF6VHB5S2dUMWZWMUtpYWVKZFFW?=
 =?utf-8?B?RmdQT3N1NE9EeTVoeFNpZmtPbjU4M3RRbXJCSm03eWQxbldydzhOVjB5UXIz?=
 =?utf-8?B?czRzQTQ2ZlhraktjRFdralg3ckwvSkVnUEIvY0xNNTJxdktubC8zQUJydnB2?=
 =?utf-8?B?V2MxNXdrQnc0T2JIR3owZlpDOVNhMldVL1o3KzZmd1VrdzZ0RkFic1pLYmJh?=
 =?utf-8?B?K1ZpU0FyWGtzcllnREt2cEkrOEZwWkdhVkI0QnlHZlNEQ1MwTklscWpxNGln?=
 =?utf-8?B?aDdDT1RSR2o2bHhVdWxVTHZ2YVZWYThvNm9USjlCV0t0V1VzdmVPM3lFblhI?=
 =?utf-8?B?bkI3YVNxaHc5ODVWSjFrZkJtRkk4bEtaT3BVY2M5dFNZcVhEdXlIeGJBb21W?=
 =?utf-8?B?VkQ3eVd2bFdJQWZVM3pUV2hEbGp6VXVhaUZMcG1yendaYlR0eXVXRzVoL1pK?=
 =?utf-8?B?QkpLQkhsYmhWVlhGQWZuRFBFcGl2MUhuSkl1M1F2eThDMU4wZ2pJUWtTRG1K?=
 =?utf-8?Q?ao+KLSUQGTNuQWwb5yP2NSsjj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6fe29f-6dfc-4ab0-d36e-08dda773839c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:32.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qelAAjlvizdmsmTBCbu9sO9dKY4cDFnW7rY/9xdGc/xrOa5nQFisRFragfvCQJVWQv39w0P5Uq3MD37ERIgShA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v19:
- irq part already in v6.16-rc1, only missed pcie/dts part
- rebase to v6.16-rc1
- update commit message for patch IMMUTABLE check.
- Link to v18: https://lore.kernel.org/r/20250414-ep-msi-v18-0-f69b49917464@nxp.com

Changes in v18:
- pci-ep.yaml: sort property order, fix maxvalue to 0x7ffff for msi-map-mask and
iommu-map-mask
- Link to v17: https://lore.kernel.org/r/20250407-ep-msi-v17-0-633ab45a31d0@nxp.com

Changes in v17:
- move document part to pci-ep.yaml
- Link to v16: https://lore.kernel.org/r/20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com

Changes in v16:
- remove arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file
because there are better patches, which under review.
- Add document for pcie-ep msi-map usage
- other change to see each patch's change log
About IMMUTABLE (No change for this part, tglx provide feedback)
> - This IMMUTABLE thing serves no purpose, because you don't randomly
>   plug this end-point block on any MSI controller. They come as part
>   of an SoC.

"Yes and no. The problem is that the EP implementation is meant to be a
generic library and while GIC-ITS guarantees immutability of the
address/data pair after setup, there are architectures (x86, loongson,
riscv) where the base MSI controller does not and immutability is only
achieved when interrupt remapping is enabled. The latter can be disabled
at boot-time and then the EP implementation becomes a lottery across
affinity changes.

That was my concern about this library implementation and that's why I
asked for a mechanism to ensure that the underlying irqdomain provides a
immutable address/data pair.

So it does not matter for GIC-ITS, but in the larger picture it matters.

Thanks,

        tglx
"

So it does not matter for GIC-ITS, but in the larger picture it matters.

- Link to v15: https://lore.kernel.org/r/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com

Changes in v15:
- rebase to v6.14-rc1
- fix build issue find by kernel test robot
- Link to v14: https://lore.kernel.org/r/20250207-ep-msi-v14-0-9671b136f2b8@nxp.com

Changes in v14:
Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
a result, the approach has been reverted to the v9 method. However, there
are several improvements:

MSI now supports msi-map in addition to msi-parent.
  - The struct device: id is used as the endpoint function (EPF) device
identity to map to the stream ID (sideband information).
  - The EPC device tree source (DTS) utilizes msi-map to provide such
information.
  - The EPF device's of_node is set to the EPC controller’s node. This
approach is commonly used for multi-function device (MFD) platform child
devices, allowing them to inherit properties from the MFD device’s DTS,
such as reset-cells and gpio-cells. This method is well-suited for the
current case, as the EPF is inherently created/binded to the EPC and
should inherit the EPC’s DTS node properties.

Additionally:

Since the basic IMX95 LUT support has already been merged into the
mainline, a DTS and driver increment patch is added to complete the
solution. The patch is rebased onto the latest linux-next tree and
aligned with the new pcitest framework.

- Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com

Changes in v13:
- Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
- Change request id as  func | vfunc << 3
- Remove IRQ_DOMAIN_MSI_IMMUTABLE

Thomas Gleixner:

I hope capture all your points in review comments. If missed, let me know.

- Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com

Changes in v12:
- Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
irq_domain_msi_is_immuatble().
- split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
- Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (10):
      PCI: endpoint: Set ID and of_node for function driver
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      selftests: pci_endpoint: Add doorbell test case
      pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
      pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
      arm64: dts: imx95: Add msi-map for pci-ep device

 arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
 drivers/misc/pci_endpoint_test.c                   |  82 ++++++++++++
 drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c                  |  90 +++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  48 +++++++
 include/linux/pci-ep-msi.h                         |  28 ++++
 include/linux/pci-epf.h                            |  21 +++
 include/uapi/linux/pcitest.h                       |   1 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++++
 11 files changed, 459 insertions(+), 8 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


