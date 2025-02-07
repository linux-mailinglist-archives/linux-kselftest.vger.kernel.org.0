Return-Path: <linux-kselftest+bounces-26034-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D2A2CCC0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91ECF16C6D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC8419CC28;
	Fri,  7 Feb 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WH1FyLvI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACCF19CC0C;
	Fri,  7 Feb 2025 19:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957238; cv=fail; b=MJjcQ+8P9V3OsX1zDzdMOqREkHZuKr/uiGHUB8A+uAmsTv8bIyTsfkiuceMyA5WQezMbuAz+ia/RM3jrwZvWnrobRcnowx+XU5I7DBvM1rCAXpjI0FPVdhYsjGlTCdBw0tYgkWT1BeahrsjtpCw75Iwvc99m4qAsoMQ3JPwp478=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957238; c=relaxed/simple;
	bh=tFCwUJJEWu2nad8ZSQjtrkep5Oi1l4TU3gTKgOYxE0A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UtkXd00FV9xOy8pNb8F4m/Baaruxm4gaTnMbleyzQg1YJuwLZf2tixGfgxgoCser3dvxmLnoJnPW+ebZP3rDEvh+s4fTbn/sSPebsleLRDvrpejunuNSv4hFCJF1y3Ska5GbFVNTh8qbbIcYia7bGaO/OYpgbd/xpCoaj1gxKYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WH1FyLvI; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+ukX6VrG9e+2al4Y+4opbUbLf/vhAJc9wCE1ds1ZYWV+r2LDfXPt7mjQTzpA9BP1m8VAIUpohmAaSimVuNogAkmopdB/ILAZuFTzF8a1OTgO11LkhHxyO95jJnDv+072McUpzUUlnWcHSXShPay1z3V5Mndtg4AXSDRTqSszUqf4qeRSK9ba0XjskqawOtIGYvWqKi6SkwSBuJj4MxsiUrZnBJ5Peuzla5DUaNpZR+g2p5MmIzIdmX4mAgtIjasRpLP2rv1lryK0bKFl/YfChwY50e70snjcieBJJutHRHYyKcjv/tLPKqRUGFUmuAJsCEq0dJ0+yM3mK77gbPHnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu2jtsrvrNUvxKDoegy3f51W2P72WzWiAHLQ21+9+ew=;
 b=NYBzPY/hzfklfYR1/5Ejdt+KEUjQwREJGzTNXoraVdi+9c2xaoWCzrED0mkJxoqVCe5KifxJELhbjF6niCXfya24kMywe2ofUxy91WM3q+5++1VD5wUGR6iL8SqNTwWlonZjVED1dyDDCj0dkByVLG8jsMKQjojndyBg9RTITBX1HcIznSQca1FSh8M/cTeZc68DBpW+098SHSjyzfrASfScovsySIZz00NdovC3QM0fWfdijNI+TTc773cc5f5RDJw09LMTlHEp9F8GbGRcOgCKtoMonqeIzcgQi/+CaRzwlr6/fPu3EKx2SkiTNp9rfZ0tUOXRylpM/NUHUC7fXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu2jtsrvrNUvxKDoegy3f51W2P72WzWiAHLQ21+9+ew=;
 b=WH1FyLvIGXwa9a2DnHhcSOKRrZosYUl6u0SVF1+CQ86YUGLxDAUVHqUrAbvgsB+U8USVARcvxzXIEaTdqMy2+AGFj2c34xBQJSeuTey8GdaNvjBLsO4B6Ku5q0sWtliB9BO7DEgkNvDoazdzfQG6ARMaiHah5SF/3ERbNdMK8k5c6/AthAuoqc5QymjFh2NtIzPejn26ccCHjskLHEZkxqbV+B1nE3Bg3Kl7V5/XVaB8majumD3uC84dv58shhK4Depr7g9CwH4KhZmzXSqwzi0IQob3q8wi2XOg7VRT0qId4uKjeWbROhKXfkPJrAwOWAYN/0Bb+AqcqHyRmhPO8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:45 -0500
Subject: [PATCH v14 03/15] irqchip/gic-v3-its: Set
 IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-3-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1292;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=tFCwUJJEWu2nad8ZSQjtrkep5Oi1l4TU3gTKgOYxE0A=;
 b=26v+sWm0TBA7YRe/SXsOihaunt67ZG7zMPnsKNZOruiTn7kxfl9LaiwFtuIsKEDAMoDyXVMKp
 X0d8a+uASb5B7fe/9gfYcbvLxbod25hFFiW4o1PBs0QdxuKpMcptkcG
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
X-MS-Office365-Filtering-Correlation-Id: 9a6b0aed-fb41-4481-3d7c-08dd47af49ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bER5Ulpvdk1RNU01Nkw4eDUzS0lJWkI1aEQyaGo1L2ovM2w0WEFzcTVBN3Vt?=
 =?utf-8?B?TC9SVkY0MEIvdmxjT21XMEZPaVgva2lrd2p3MWxoS1hnRXZBc2dBVkZQanhE?=
 =?utf-8?B?cE9WS0RENlBHODM1S3pPTUYzVW80SUJjRS9nL1UxQS9rZExkSnl2VEZ4L2c4?=
 =?utf-8?B?K21zVkt6WnY5TGw4Nk91VTR6ZlN4NkVkN1daeTY3M2ZFWXdCbk9lR3RuOFl5?=
 =?utf-8?B?WVJPMmRBY1JOc2FsaHM2UytSZkhId1VHcFFNblRLU1dSbjBJdUZVRE1DS3JT?=
 =?utf-8?B?Qnl5Q0ZuWnVnMXBJbitOT0w2NjhXQVc1QlJqWkxhWk9zbWxXWTF4MWhiZjVL?=
 =?utf-8?B?a3p1TjNhbUhVY25IcnlpNEljdzBRTWhWVXAvU0VBZ2YyMGNrM1VQOUZHdHdU?=
 =?utf-8?B?dE1yemRsdFZYU2U0U2tqZDdaZGp0WVJ3Ykk5Z1NrMEllUndtUVkzM2hURGVz?=
 =?utf-8?B?aTFFRTFrZGJTWE1JMTNCc21GRTd5Nit2czBJL2d3VUpMWXVIdU5JM2VFZGNN?=
 =?utf-8?B?Y2FBVlgramo2YWVBY1lyUTl6clBIVkJURmVmTHlyZHZ3a2dTZW9ieGdFdmpo?=
 =?utf-8?B?MzVicmcyMVZhYzZvRGt5dDR0dzd5SkR0NFEzTnRpME1TWUQ3eWlMQTJxTi9a?=
 =?utf-8?B?UUs0SUhUVHFQNlV1YVUwV2FYdXVkbmZ0Y0RyOVdzTVZBa09tb1pMNmFxWnJE?=
 =?utf-8?B?NnVhSU9KekZYd29uMTRkR0JhK210MDFLWGlwMTJ1emMwNWswU25kRCszTVh5?=
 =?utf-8?B?ek1MdnNldlhBbVdtSXJKaWxoOXpmOW9XUjZSbldmTnFIZ1VFbXNwMGVrSTVE?=
 =?utf-8?B?dzhHeHdzcWVxdi9QMlNnTU85SUlFQmNDOUJGZlZzalgrMHFmMjJEcmlWejgx?=
 =?utf-8?B?MzdKZW5SUWpZbEpvT056T3d4WFZpQnB4YWJZNGc2WGh5RlhFSkFGajlrUDIv?=
 =?utf-8?B?U3pzVEJuZVpnVjlNZ2VjR20vNGtvVzVDcVowUkpZM0QrYUF1RVNXSVl1YjZ3?=
 =?utf-8?B?aHN2dWNNa29jMTBVa1BvcnBFb09jZEtMc05XbURUYlYzZHNkTXVRb0JEbXZu?=
 =?utf-8?B?dDNNQm54YVpZaStrWlZPU0VwV2RKQjkyZitVaDhDenRMODZ1TVdwaWhhTlhN?=
 =?utf-8?B?RmducUNXTVZobkJUbGdzM0hoR2s3NTFNSVYvTDZGenZvT0ZhOWkwVk50cy80?=
 =?utf-8?B?UDY2ekp4anMzeGtILzQ4dHIzQkdYQlErQTUrNWFhOHFETHhYdXF6KzNIK1FO?=
 =?utf-8?B?RnAyaktoVUJqUzRUU1JKZ0ErNWxGUW1wTnE2MWw3L2NzSGt6OWx0TERRYlYw?=
 =?utf-8?B?Lysrc0Q0K0QxMThwOXdKbEJsTVY4bVI0K05aSmVjSmQ3Qi9Qd3YyZmJiWUs4?=
 =?utf-8?B?TGs4M3NhaXluRlBudytGcVI2NVFWWm5lWmwzTitmUzZaUzVLRG1tbTJtZHNn?=
 =?utf-8?B?OVZqeFkvRHZzNmtsZjVBOFR3Mnd6UFVhWXJSTWplbElIN0k1ZCtBdmlOcWlH?=
 =?utf-8?B?ODRWWkdrQ1p0SnBJTTNmcWU5RUtSbHUzam8xWW5uU3IvM2tkb3JqSUpsTlJi?=
 =?utf-8?B?dHVuSDFsUWtKQ2tRMDVKQXJnSDFlV3MzVGVCTm5RTzJ2ZFFlMkozTXBOVnNy?=
 =?utf-8?B?TlJsMmcxeGp5RFB6ZlNyRlB2M1VjNGZQbjluTm80SjZXdmVsNVh4Rm9NVlJO?=
 =?utf-8?B?RVJkd05kaVVBRmNJamRRT0VyUWVKK1ZES1ZsZjNweEg0N2t0c0ZjVkJsb1ZR?=
 =?utf-8?B?S1NVc2R0UFR2VjhwNklDdDBYaXBja0pxcXBIcy9VZElMeHJNeW52RWI5b09i?=
 =?utf-8?B?dzJUWWZpckZhVFZlTGppVHkvUlN6ZlhvazVJY1NWby9qU0xKL09UVWs0MkE2?=
 =?utf-8?B?aFlZTW13aCtpS3pvclpOdDcweW5nSWtxUkl1Y1orbkZreE1rc2ZVZVdXM1pv?=
 =?utf-8?B?dlhpTHl5bnk0czlyYUptWld2NmovbDVrM05NY2toeks2Q20xNy90OE1IWXlD?=
 =?utf-8?B?cGlnUmEwTEFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHY0YkJqOGc3eVZDUWRtRTlXQXN5a1NUMGg3UHNMaDJwaW1pcjdrZHZxYnRS?=
 =?utf-8?B?bWNjenh4UFdXYTZVeXM3bUpEWHFvRjRqb1oyQUVQaEpsdzBWZlZYa2JvUk52?=
 =?utf-8?B?dWtqaVAzZzBkV1J2eTlSUm9SVUozZCsxSkhjZ3RidXN5WkxQbkd2OEg0Ylh1?=
 =?utf-8?B?MjVQTVFtbXZVdUF3bjBVRThpdUtNR3dKc3ZRQ28wSTh0WXJHcEhSdUdDSEsy?=
 =?utf-8?B?MDFiSUV5N2VRZFRWRnNDQ2pHYVdhci9HSDEyM3JERDBzRGw5NEJrcHZ1dFZh?=
 =?utf-8?B?Y2pVbEsvVGJaVnR6cXJuUk8rTWIrZ3JFZy92bGNzQWV1NTNOTGJBK29PREY4?=
 =?utf-8?B?bVR6aENtN1Bqdk1GQ3JLcU0xVlVXWldwdUQrMm13Q1lmVHlMSFJ5c25NNDVo?=
 =?utf-8?B?S1U4cmJUdy8zeEpneGwrcmJWRW96eC9CcXBJT1FCM1A0K3dybzFNM2svVjVm?=
 =?utf-8?B?dmtENkgyME5nSEszbjBPaCtsMVBoT2EzV1ZVYnRERlRzb1IzRGdwZmpiSllC?=
 =?utf-8?B?TExtTFQ1MWV1VzBpRW5vejdUZjcrY3RVRlRVYkRnc1FYVUFhaHRCYWUyZlpN?=
 =?utf-8?B?NzVnSHRrenE2TndGbkZQRkw4K3NETmhOaE1peG1LRjJRYjFicHRaSFlORlFD?=
 =?utf-8?B?T0g3dWhLYkVCc09yR0VaeEt3OE5mdnpNTUhlcEcrNXVQWGZJSHVhODRXRkR5?=
 =?utf-8?B?NFY4UDZySHNRbWZ5QSsvbWc0VFQyZStsWkd5WjhPWndzU3ZuZmlZOC80a3Rz?=
 =?utf-8?B?M2xuR2FaWWx6UFpsTFZFNWRXNi9zeTZBQmk1VFk2M2VnSDlqbGxtdkQrK0ZD?=
 =?utf-8?B?dGp1MDVDalFBd3BLNEhzRnZoU2g5dE9xZGhVQy9laGtud1FsSDh6ZTRRYVQr?=
 =?utf-8?B?SkpHTHV4TGMvUW83a3RmdUg4WlBmaHFLVk05elBXa04wM3pKWEt0UC8xTXUw?=
 =?utf-8?B?djJwMGwwaGJLL0YxK1A4dFVJcGx3N2JPQldLK0F5aXBRaGZTamhKN1lxY0JK?=
 =?utf-8?B?U25wNXBlOHowV1VERFZzWjV5UmRjb1JwWHNLNW5pVFVkZGxzaE51QmF1OXdE?=
 =?utf-8?B?cU1NVnFRbHJXSmFqSENJdjZRZU9MNG43anE0Mzl4V2JDRHhrNEtQRVcxVU4v?=
 =?utf-8?B?ZFdWeDBwOUNyMFA0WVovYkplbTc4Y2poREhxUjV0blNEZHJ4bUFGNCt0ZWFh?=
 =?utf-8?B?TmxwMVNGSk96NnFUSWhJeTh2OVNmTkFCMlY0OTFTeFdua0hqY3YyeFJiaXBt?=
 =?utf-8?B?UHdWelZSeUtHMDZIR1JDaE5DUEpDMGNwTUhrVm9hWmcvcTIxeE0wUWJIWXp4?=
 =?utf-8?B?MmgwdnhBYUFlSmwyU0VjalpMWmRmVFdWdUova3JZczcvVTY2a2Z1cEgvVnRQ?=
 =?utf-8?B?VmQwVklFcHNTQ0J2L1FLdEhzNWJYeWtmMUgrMWpxbDBSb2laSjFad3NhWCsz?=
 =?utf-8?B?MmhQQ09vaFE4ekxkZDNNOTFYZlNTaWtVb1hvN3FiWUw4RlpLOHEzU2h0cHRK?=
 =?utf-8?B?VVhJMmU0ZnlDWnFsVjVRMjZpd3ZXZThrNWpBWm5ZcFVRNTZhQ25UUzN4U2Jp?=
 =?utf-8?B?NzBmSVVQdi9WRDdvemlDTGtQb1Rkd0o0dWZEOXFUM0F4ZG1BenhhZTF3Z2x5?=
 =?utf-8?B?ZlNhZzdsSDJlZi9OSENJTUpzSGpKWEhxSnBUN29pYnNGSUQrR1BsaVg1Ujdp?=
 =?utf-8?B?S0Zqc1plTUxmQy96NTBpNnREZGxpQXhnVE0va3FHWDlSdDN3SjErRnlJL1Ux?=
 =?utf-8?B?M1FyNk1IOG1TSy82UDBxYWN4RkV1d28yS28yRk5YZmpSVkZxMXZLM05pckxv?=
 =?utf-8?B?MDJCdmxaL09kT1BPKzA0aTNVaUlhbGN6NTUyU3hOY1hsTWdmbVlLVHY4c1ll?=
 =?utf-8?B?dEhwYUxmSnV2SlR3enpIeS9aYWhEZlZJWnBQV2prNjZNOThoNkFXVTVjdFFN?=
 =?utf-8?B?Y2dmbzh6eWhBY3d2aDl3N2JsZWNEWHhzWEdaRzhmL2ZzWjFpb1NWbGJ1blBz?=
 =?utf-8?B?ZGExR0RzbkF5dTNTZmFhODFCb3F0VFpKMG85aWZGNGFWeFlpOFVDVzhTaDR2?=
 =?utf-8?B?M1ZXeng2TldqZkU3amRKMGhMKzg4QVdCbmZjT3EzYml4eExBeUpDRVdFaTRj?=
 =?utf-8?Q?WUbZnDl7vjoVVjpmnFjopfnIa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6b0aed-fb41-4481-3d7c-08dd47af49ad
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:33.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wDUV4IUfqbGChG/SlNpE3M2PA2k6gFtLTdXQHYaAXsVexYJwserDTNoMLYsuq0l0a28e78YC6wCuZA7E+p3cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Set the IRQ_DOMAIN_FLAG_MSI_IMMUTABLE flag for ITS, as it does not change
the address/data pair after setup.

Ensure compatibility with MSI users, such as PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged. Enable PCIe endpoints to
use ITS for triggering doorbells from the PCIe Root Complex (RC) side.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v12
- roll back to v12 version because Marc Zyngier have concern about add
DOMAIN_BUS_DEVICE_PCI_EP_MSI.
https://lore.kernel.org/imx/861pxfq315.wl-maz@kernel.org/

change from v11 to v12
- new patch
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 8c3ec5734f1ef..7c0a97a1bf8be 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5126,7 +5126,7 @@ static int its_init_domain(struct its_node *its)
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
 	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	return 0;
 }

-- 
2.34.1


