Return-Path: <linux-kselftest+bounces-30130-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A47A7C36B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F61517C779
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C3721D5BB;
	Fri,  4 Apr 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cuQI5wNz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FDD21D5B2;
	Fri,  4 Apr 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793313; cv=fail; b=YF5S7cbu3trcpi/kJqulx2VQBpfEndPAbVZVkF1i3kwFSmiKRv96eHmieufJWcS/NrsAU82/IyRn6T2dLMv5W9xTMAdnnNw7g6B2PLFetridk4xxX5zGBpiHrHB5dZ4FAFBMbodbKQUFL3xXJjRPjHRTGF5Yq8yw3ymim2CaYeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793313; c=relaxed/simple;
	bh=p7gntWoxGh4gHuQtzBxv9euNYS3wHZIeRIkw2TEkLdk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=C6iwTueybaSibG7BE0MHVLZ/sLThBTH44XVOi9f5VK9z0zN12hFJJH19FKxQ7UIQlBn0DulW637t1QD3zf77XED8hsJEjiY1zE7UdngPwQidKtAsKu573YQWhTsERQ4trOJjhHXo0oxKjh0nU78dwYfk0aGXVeLbzeRJjxFpjKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cuQI5wNz; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IC6gxA+anBcP5YQrHqQuqcnvgr3gEyTm7i6z1m3xj7UGCiF/RjP3uFqEUm/RpylSVQTpWVj3C+DoSHiCFqz8SZLqPz8HUlaB6u3L8JEHV5iaBWJYNd6UdAmRkzrmiBok8S1ZHCX5YHcOR5gV0aqI4qtRCZTlDUR47L4HzoNT0ihAqTuEKQDDBd5pmaBnrf22LHRUWehf392Oec/V/OfmivezhI7N+ag0o6GAdCFT5Vk1whH+lDi9ncQhyTW3Rk6fWBPLThbB44yADraRJd+SzdX8d8YQ7NkinOZekD/8KDe6vQzGOPxJCqVMjfEkTezAtrWPXx7pePkgC4GS2Mf/Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GR0Z1iTOQebA6NDkRDEaFkcBL+OLXn2bv7Llb/KWBuc=;
 b=mnaEiNJyB2zgA8k506Q7U1ipIu9+sx4RVRjLXDeduML7gqTFr18rcI2IrKT8YhayOC5+HNccwTRmQzxU+lwQNoLD3QXSMvY2CN2onSL2BEgTfGSXCWT8WYTiLp6Y+T5xcWjQkCxfN2STZ2ff3ImJRbR2/hT0dCWSU4v126/h4rIYLoLdZWa9s93if8NNd4EQizsUJV/v5D1NAW2VQxNZcU/8/OVEwH/D8t2Vmyjdk0lrDLXNt8CFUzF14flrNak6PGkrmB618Rj0A2SDXhNN5p6w641CYXr03AZs+XLIRnRt+HHPn0AMFou0LpWEqFc9Ue5No6XybhKMJLB4vUP/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GR0Z1iTOQebA6NDkRDEaFkcBL+OLXn2bv7Llb/KWBuc=;
 b=cuQI5wNzWyHLK7ZQyLe+762KunPRHRjwdAqhSg8nt/Z9vm2OqLnczAVamUZGf104o2z+FaGUlRiBiOa4CAJBMUm/c83Rv3+M6AxuzL9xQXGKmQOLGGO1SjnAsey73oDmRnUD76rqu7PyPJ8r8y/OyuylvD2FPKRtbpZJ18KNDFXQOx4/t6PWXXG0z0cWEBqn5nGz54nUbxqB42Eqd9TpJm8TEbU6RkgMSbRFQ9xy//hKOtPtTBpZPAgiIy5INpZaWq1+WhTtcte2N04Q4LgtNWDWf/BgkD1pfUDY4fD3sAE2VSchxg5zxaFiJ4Ho3HA680qFIe0NfI/dCcKIpS33Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:01:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:01:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:03 -0400
Subject: [PATCH v16 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-2-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=1874;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=p7gntWoxGh4gHuQtzBxv9euNYS3wHZIeRIkw2TEkLdk=;
 b=y4w7VRuSwy4uE/iTIdWKXZJaFYEqE7mC6CDssUsXgAmOn/vhXnkudrvMX72kkHEZauJIs+6dR
 110ye3GJ79qBo5yNBFgBLRvSIf7lV5uRKkPnzcevfO7arfOWk7uv5H9
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
X-MS-Office365-Filtering-Correlation-Id: 04343fea-8ec2-4890-1923-08dd73ab25e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mm5xN0l2S1pIQWdtZ3l2VGtJekRPbGx5cVVlV2RDU084a2wxVWdoQTl5SDA4?=
 =?utf-8?B?UGx2eEFKMUdDK0lIcmgzczhJTUNvU2YxeHhZNnRaRmtKMHhTRkwzNFhXQk9R?=
 =?utf-8?B?alVDbzYwNTNYWHNuSlRwelBrQzlZb05HcTdMNk5Bck9uR0hGODRwZkpucU1H?=
 =?utf-8?B?Slo2RUhVQkwzY2x3UVZ1T2RWNjNPZUw1cS9EeTkyb2hPRTdabXRyL2N3WHVn?=
 =?utf-8?B?a0JCQXAvZEdtSnJSYkxyZzZoenM0eFVNTEZiQ3JoejI1UXZRZmZSRGE1MEZo?=
 =?utf-8?B?cmRSMEFiKzNZUVBLb1NseDVsRnNoc3ozbE90ekNWRGVjT2h3SWg3RUdUaEo1?=
 =?utf-8?B?UklwbVE1eis2WVZUby94SUlsVy9kMG54cHBzVmNnc0dlU0JJSllPR0JXVTdG?=
 =?utf-8?B?NVJZSnFRVENoais5QU5Ga1luaSt0d0ZNaEVCT1VFdTg1OEhjdDczT1JndURS?=
 =?utf-8?B?ZFhySTlXelJtQ2kxQWxNTGRERmgra2p5Ti8raGpQcC93blBJTm1EVnFsKzBt?=
 =?utf-8?B?VTA4S1JhdjgyRXFDeWF3NHJNc0hmSGFESzdsN3RmVjVOa2I1dng4eitwSElo?=
 =?utf-8?B?Q1lUNXNOQVRCMzZnbjZOaFYzOUhaTjUra0kvRGVBemtDVHhaTFJVZlF4K29L?=
 =?utf-8?B?eENxL0RVMTBBOEkxcjlkU1YrM04xUlJ1Ry96dFRwQWdUR255QTkzOU13RWNB?=
 =?utf-8?B?aEhBeVN0eU1MbTRtM2J6WHgvd3FMQTlBT215c3hWMUFjR3RMdGUyZmJwRm9t?=
 =?utf-8?B?djN6Z1BJajltQ0JxcHBJeUptYTlhdTgwZVdtWmJ2MjV1RldNY3pacEhQNnNN?=
 =?utf-8?B?ZU1LVERLOTB3SG02NjM0VzJaVXpCekVWUGRQYXRYWEpTODJYYjIzUS9QWGtl?=
 =?utf-8?B?aGxrRnExUkJxeHBJZmRKd2JoQ2U0KzM5OWQ0TWlySWJzRTFGYVRGajRYaTRq?=
 =?utf-8?B?Z0d2Y1pjTEJKVzlRR3VOWmswNVc2cURQWW0veFJCY3I2QTVVdXRMVG4xWHps?=
 =?utf-8?B?Uy9ucktWb01wbTkrQitpN3lqODh6MlV1dXUram96QTBxUzZKZzg4d3REZ3VV?=
 =?utf-8?B?Y0t3clE2WEhhZEIrYmFmTEVTNEFYMkdpU3JveXV5STkrN3YvMVc2N0pLZDZH?=
 =?utf-8?B?akFaL1duUU15RS9MYzg4R3VORFRWRmdKQW5qSWtVQm1wb29oc0I3V0lVSEdo?=
 =?utf-8?B?d3h3aGg4M1hNd1JYWEQva3dBQTIzM1c1MytnWFlKU1N1OUQ3UXFiaFU0Y25R?=
 =?utf-8?B?cjZwU2p3aHhEYTF0SEFxRjkyd0dqZ0ovb3Y4amtoNm5WTW5IbEVORGtacmhx?=
 =?utf-8?B?VlBwR1BrVnN4QUQxc0w1NHR1TTY1eGU4ZTNNUW94NzhXeFVMSFhqMnEvakh6?=
 =?utf-8?B?NjJHRDJ5b0VQWEI2cDFiUHFoNG9pRGJGV3NiTGJJS1dZYVhmOGw3bEtKZnZm?=
 =?utf-8?B?V1NLYlZRQUFwZGpiVFJ0aTQ3Z25qWGEwY0xkaDdTZzVjSFZMaTZxZWlKN3E5?=
 =?utf-8?B?UjhDWUxxelBiQkJqQ0Q1MTFTZm0wN05HblBTQWFJM0xuRFVKUjE3bmh5aExY?=
 =?utf-8?B?Yi81VGZ5UGNZajFGRmxLWXBPbWY1dHR6LzdzTldJRjgvZGoxSWtxeFA5REl5?=
 =?utf-8?B?K1RhdWNHYVlweFN2KzZmalpRVWhXZmJRNVU0M3RPcE81K3RtNVlyYm5BOXN1?=
 =?utf-8?B?VDFvTm9Wb1BCeGJhL3Uxbzh6b2JVUnF6Q0FJTThHUTY4dVowdysvblBWUUsz?=
 =?utf-8?B?cXFnSXUyT2hwa21waGhjZmVHL3I3enpVdGJJNVVEOGdBQ2wvWkp0cVFybFVD?=
 =?utf-8?B?M2ZicmF2Vkk5V1Q4VlpGcHJBU3dxdmZQN1VDZU9Ma2VXWW1LdEJWQmVPRHk2?=
 =?utf-8?B?M29OVk40U0pwNUROUVlYMGxkU1ZmaVlLaHRvVWo0aFJ1YVhaUkJEWnFZdE1S?=
 =?utf-8?B?aklDdVIzSVk1WnVRbU4zaExIdXpsTFFydG90U2ZvQ0pvQlBDL2FBRnFTVlly?=
 =?utf-8?B?K0ljNkttdlZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE5VNXlTeU5zZmkyWlovVFhUVmhlU0RQL1hoWTJmdVhmWElKN0wxb242aGZu?=
 =?utf-8?B?SjRxVzhPcGhWLy9pa01EV21ZSmpyK3FEaDZmdU1UdTJjR2NncDVIcnpXYzV6?=
 =?utf-8?B?bHZ5YlMxdFV4UmIzQVR5OFJxME04V3BNY1AzQVZUUHh3a2VoaURod1o3Nkxo?=
 =?utf-8?B?Nk16QWpqUFpPQU9UaWx0VkUwWC9laTJDSTJjM3BUV2p3Y0VrR2RtSUJPQ0RM?=
 =?utf-8?B?amtwc00yQ3Y2UkJKWnQyY0VrTndxWGdpdUo4YXB6d0VwVTZnaG5JT25STHNS?=
 =?utf-8?B?UjBNSkloL2wxcVpzUE9YRzkwNVJucVFjSkN4QzFhQkhIY2lXbG55THZLVFpu?=
 =?utf-8?B?WlIxU0lDZzlyQzBnUFhmdFlyNjZjbzQxL1hhSklLQmlsTHR1N05MS21abWRy?=
 =?utf-8?B?WmorUnVUN2RZVnFzZ3FYY2dXV3ZBYWR4bmx2VVBPQ0IzZ3Yva2hFbTl4R1BE?=
 =?utf-8?B?Ym1SYzd3Q3ZITGg5MVY5TkNzS0p5UGV5V01Fc0lmbW5JQUNRSUdVSC9Pd0tM?=
 =?utf-8?B?cWF2RkpsTjhBbDRDNS92NUIwV0taczVQQ01NQkRGdnlHUHZUY0xENjl1Qmow?=
 =?utf-8?B?Wld5UEVnNjl2TVcwL1VSNEs4ZEJySUlYeVFBeXY2Y2tnQnQ0dEtuOEIwazJw?=
 =?utf-8?B?VWFMei9GYS9ZT280K205eGZLNjA1SnNNSkNSZXhPVFhVbm9rbUR1dUFCb3lS?=
 =?utf-8?B?azVNMjFVaGFMbUJHTmc5Tyttb2lKdnJ5Z2FEU3JHY0ZZakFMUTlQK1BNVjNo?=
 =?utf-8?B?NEQxbFNGaWZSNFk2R3IxSzk5cUpjMUkrUW9HODd4a3VFRW9ONVpabk5scVRj?=
 =?utf-8?B?aEVDcGo1ZUNFMVlSeGhzL3gwQnFKUy9Gb1Q1RjZlaWNWcXFtTGlWNzAzUTN4?=
 =?utf-8?B?OWxCTk1YMHVIbFZKSnN4RXhtMHF0SmNnSGRRcnlSNkFGajFMcjlPNTV3dU5p?=
 =?utf-8?B?WktEL2dVcXFkVVpJUzlTaXZHaytMNDcrY1NkcmVMVkxKRzhtL202UjVocTdn?=
 =?utf-8?B?L25YT0wvWnBiWDBZcGx2SCtuQzloYUVqTXZGZkE1MDgvZUR5VS80MmtzMlYy?=
 =?utf-8?B?K0ZXSkRpLytWS1FCVTVzWFVFUDlLcnJacDVDbzYwYlNrRkNibk5UaTdzVmg4?=
 =?utf-8?B?RGRWeUZ0Q21oVHJzeWN0NjRkTnBYTk1TUTVMeStJMkNUcXdXS0pqbnBPaVBE?=
 =?utf-8?B?a2dtNjZBbVBqSWh1ZC9kcHVnZHNaekFoQi9EaUtRcm5tNHdXZEZOU0ZlbjM3?=
 =?utf-8?B?NmtDZTlBQXoyelByMERsNi9QdXJWTlZ5WWMzYUlGYzRyVlJFQWJpNnhpTXRT?=
 =?utf-8?B?dkM5SVdEb3VzSU55TENmUFJ4aXovSmE0bEx0aWE0V3J1VUJOZTVLQThQMTcr?=
 =?utf-8?B?OTVFTlBYVjBnMlNabVUzMUdOOXRCN2wyKyt2aDlmN0tRTG84cHBGRTM1WXhq?=
 =?utf-8?B?bEdpTlg4Q0s1TFNYZXR0THNLNGlaZURIYStsUFBqQVB3WGJncXRlbXhHV0t6?=
 =?utf-8?B?R3BBbWRhUmt1VlBFUGhaRTZVNEtKUmJ3L2xIc2ZGdHowbDc4UUlXRndrTmVt?=
 =?utf-8?B?c3BMQWozTVVCYm9DSlVGaXhXSXpBNWNwZ3lwQnAzL2ZkUnZzNTZ3eGRzNExt?=
 =?utf-8?B?OUZMazhEdHFUOWV1QjNzVWxlZFhOREwveXVkVGlqNGplcHlFaFBZVWpGODdu?=
 =?utf-8?B?R3NXZFNMU1pnWURGRSs5ZEsyNzBWUjJrU21nZUVnWFJrQWU2WHlmUzd5eGZV?=
 =?utf-8?B?VEY4YmZDVHZwN1M5bDJzZWduekNoRktTeThsSkFRSzdSajlEWUFlcnM0MnZG?=
 =?utf-8?B?ZzgzaEJyK1VrV3F2dG1xNVBtWUE5UHRnbi83Y0p3ZWh3Nm5mUlFiclBJWmRy?=
 =?utf-8?B?Vm1wTG5DU3ZxUjFhc2VBL2lMeEpBY3ZuekdnSFFCVkdOczBUZ3N2WUl1MW1v?=
 =?utf-8?B?TVY0QjhOZHFCT2JpY3paVHdtWlduUzNweDU2aXhsZ1N3TkVKTnpMREJrZDNS?=
 =?utf-8?B?cjVvMjBCMUZHTW5BcnZtdE1lSXZOdWtCQ0lUWXk5TUVsTmdHRDc0YmY4OFpS?=
 =?utf-8?B?b1hMK0ZkMFBWSVZKZ1Bmc1ZDbzY0YkVkZlZyNlNUbk1nTVM1YlB0TE1vZ2Z2?=
 =?utf-8?Q?lzTg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04343fea-8ec2-4890-1923-08dd73ab25e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:01:46.9835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbZ0wKN9H1wKZIyYTb+KfICYc2LFJc2LbAA/2HmqlNDMAuFAfGQ4RaDGccGBZYJPInsXD71d/boxrI1rNNAQGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
irq_domain_is_msi_immutable() to check if the MSI controller retains an
immutable address/data pair during irq_set_affinity().

Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged after setup. Use this
function to verify if the MSI controller is immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

change from v13 to v14
- Roll back to v12 version because Marc Zyngier have concern about add
DOMAIN_BUS_DEVICE_PCI_EP_MSI.
https://lore.kernel.org/imx/861pxfq315.wl-maz@kernel.org/

Change from v11 to v12
- change to IRQ_DOMAIN_FLAG_MSI_IMMUTABLE to minimized the code change.
---
 include/linux/irqdomain.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 33ff41eef8f73..86222602744e9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -231,6 +231,9 @@ enum {
 	/* Irq domain must destroy generic chips when removed */
 	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
 
+	/* Address and data pair is mutable when irq_set_affinity() */
+	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -691,6 +694,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
+static inline bool irq_domain_is_msi_immutable(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
+}
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)

-- 
2.34.1


