Return-Path: <linux-kselftest+bounces-26414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD2DA31508
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83EBC1885FD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4927E264F9E;
	Tue, 11 Feb 2025 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EtfYKaMO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013021.outbound.protection.outlook.com [40.107.162.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5B264F97;
	Tue, 11 Feb 2025 19:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301774; cv=fail; b=SUNtO7wvDNTNx3ftwO/Zsc8jzR79XkYKwnAqQDzFIvnRnlEhb7XGTMA9YW5lnZDucOCf0nc3hPa0ttrdrdqTpBAP1qxHMPCwhMESCU2XI+NqyMvDtR00Tl6nU5HZYDNIfYdD2CO6WjXn8AD4pz72GiXd69DPXgPV3qkdBjQEyCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301774; c=relaxed/simple;
	bh=nXEVXpKm/UtXR3PlIyGCCyMh8UM9jn5MZjClSKJzPXs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=elPh1yMLWTkU5lRMuZEzdT8KLewiFbxhq5pi8f6OBcSv8bPhMA731gd0yIR6ugkQhiTp3JIeOR+pdNPW9zDTCQfPi2xv9ciLY1tZl0dzmgasJNEn1mWOXLNwFCApcbnk8UA+kHs7Ivo4QvRU//MsLvk/u1LFesn5/zXlgDKKfgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EtfYKaMO; arc=fail smtp.client-ip=40.107.162.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYsFUhvq7+BxoDWqRjUnisBDz9/NaE8Dhc3Oqe45yLh0jJaQtlIOK//TRGsXsxb2TWW7xowHFK2xp8QwfXXiiKKN1XOQebZBCEqizSZcH9E33ry0SCmvTfKZOZCzX7ngP06rFxyVwwZWOf3cKM9SGIXg8tbHFKAIzWNsJk91WaDFaG+G2va555TNBV3eVD6ghfoUlDjhnnSf9EZI0mA1dw7pR3YJEaYd8kskgWEoJoT4OGJgANxdoGBdKiAp72XySreUYiLezv2DHdC0FG5dQ1b4gfNXgzQjnCHPWJVml0LgeLgVu7aHFDs172cYRl4SwQWiRQ3rlNPF0kTxi5tOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Szpkwi+1NkUsIBUzS/7PTjj2SX0Pc7GZs1W3yj7O5Y4=;
 b=NPG++iP5OHkYnLwL3tjFyIuUnkas1Dd5uAbO049me+24lEiZYS+FXtpB7bmgQgo41vzye8TCu+3qDlHFOu4ULviKFwJ77mQKPLWxyomvUlu0TT0Lkz8V+iMPGn7S6JajAERt0+bNr8a2v3tIbxlkqDwH3V9rn2HHfBMBxDcYC5aKnZiGeHFDzyHVPLqvJ7445p06w2swQM6C26wD8vEd8n4L6owMRux83Vg0Ve7++fdFWgSSYX7ZSSvK35liAgrsmEgQpmomk/UfkQl7j9Zq+3XnPsLwjwr7sS7VvPGLJlT62VJXt8fbCQU5oVroukKj4ZF6d6jFGJllGGl2fqQ74Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Szpkwi+1NkUsIBUzS/7PTjj2SX0Pc7GZs1W3yj7O5Y4=;
 b=EtfYKaMOpIuEjdcCDsy7pki0UgApjwluWkZ5QUpgkRjJXgdve//66ccbpPuv4eDG6cWJiu2eJSafiGfqUnroEmaNvS94wMxlIndISy+5aAVmir5g6wFHl3zrqc1HyHUqn/viSpiBOV5aD6vkOpIyEZI8N4xHyw0bbxs1UrO6hjCW4wWkYLhGLYsVXcDYDGfk2LUAXixkZO4G6ub6s/jxIW19cC+PTKFn4ilkFpFrz0VlEFoVyFmWYiQBGjHMT4WrJuay3oSWX9CIjo+CUkqGNFBpfjReg/ffIww9HVO6rUkzieGHq7AdL3jQdWLOwsi0u+jGqxIVvvG375NEeQqvEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:21:58 -0500
Subject: [PATCH v15 05/15] PCI: endpoint: Set ID and of_node for function
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-5-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=2203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nXEVXpKm/UtXR3PlIyGCCyMh8UM9jn5MZjClSKJzPXs=;
 b=SnFt1scKIbnBl+H/CwLJG31sCwiN9f/+l6v+fR3lEyH8sIN98jYNzIvmEGEfe6SrMU35VEZ1F
 47tGCAvVXfdChny45z35YX209GwpwJGe8t0P1DPY9I80qP9hRnsDcnp
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10291:EE_
X-MS-Office365-Filtering-Correlation-Id: f8eef724-d99a-4d3e-0864-08dd4ad1788a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGp0dkFqNDZDTUF6cXRzRUlrWG1yYW4vdkhFYnd1bmt0NmdRcGVjUmx6YkhK?=
 =?utf-8?B?clVZZDNSeDNvV3RoK1F3ekIvUG13TGpWWC8xdG1jZVNGUjBJRVVseDJDelAv?=
 =?utf-8?B?bm9qZFVFS2M5VGZwOGtQQ1VabTVsc3Q2L0pzR1JXdEJlbEFDeVRhWTZwYnR2?=
 =?utf-8?B?NmxFeUR3dFpzSEpabDNqTG9iYlBzV1RhWmxmYXZnL0tsSytUTXl2VStLcG9D?=
 =?utf-8?B?QVljMFJvZzhvTVJiNTdVbExsVGVtQ3ZzV0NNYjJ5VHN3TG5EcVJLcHpzVzkz?=
 =?utf-8?B?K0JrVDF1amZHMExweU1UNVFwMFRmaGZIUnE0VmpLOTh3aHh4ODNqZHgzZUhF?=
 =?utf-8?B?T1ZOd0kxRnI1M0tOU1Fna1R4dU5XcVZMRDdrR0hGdXRYanBXMHZUbHRCVzhL?=
 =?utf-8?B?aGE2Q3VpWEZ5ZzJleENGQmZKZFZWRWx0WGpTMyt0ZW9MZTY1K2JUdHhoWmk1?=
 =?utf-8?B?UFcxNkg5ZkQxaEFVV3hSWmVvZHJIbEZaRXhQcjNVa3NWT0ZVTHIwb0dvZzdj?=
 =?utf-8?B?TEZtbUdielRvOHhQamNGMVBSQXY3WXZDZzlYU2U5Rk9iSXdkWS9yN2ZqZGU4?=
 =?utf-8?B?ZTNhUjlUc25RTHh3SU5IQVhhMTNEczJHM0R5NTErS1RPTERiaGJ0QkwzWHBZ?=
 =?utf-8?B?UVpaQ2p4MEN2OFFmU3V4cEN0MzgzMjExQm9lV0g4aHlTRlVvZWlLTzdMNmg3?=
 =?utf-8?B?OGg0V1o3ZWFySHlRS0tXZmd3aWVhQk5XTVNSM1BBRVhvaHgxRjBwaEdTQ2pq?=
 =?utf-8?B?c1RHWU1XbkVRL0tjSzdkTnZZWlB0bm5KQWREdmsxeGlPQU83OWowWk5lbmYz?=
 =?utf-8?B?N1FWTm9KWXBDczE4ZkZRMW9LZHJPQ2M2ZDZKWG1OU3pTYmkzdWswdjlrS0cz?=
 =?utf-8?B?QUtIRnMrUFdNL1pjald2RDJaa3NJSjM1d2ZOeEU1TTVZaUprRE0xNWFIODkw?=
 =?utf-8?B?M3dBZyt1YWdjTFdtNldyK3FIRi9KcVMxMTI0VHRkaUFNV0tQTnRINTErT3Ny?=
 =?utf-8?B?RkhXMnVLWjRpYXJiWjF5ZkxudWRlQ1NUYTh6V2YvLzdZZVRLcVdhK2JCYVg2?=
 =?utf-8?B?Q3VxaldXVk9VMEN6VjIwMjBNVlpnM1lqbVZXVTA5S3Yxb1FUTkdJT3NvV0Fq?=
 =?utf-8?B?Z0pjM3B0eWZ6VVhkS0hUSHgvWGF1bktzZjE2L2s0dU14MlduMEdVNW9pa0E1?=
 =?utf-8?B?NWVxWlhheEZEeFRiblpxcDROd3pndmc2ZUl4eUNWdW1WcERvUVprcFoxZld1?=
 =?utf-8?B?TEdTbjJiQkYwWWRTYWtITnVBM2lYTmFuV1VyK0xxb3h5WW80V05RT242VGhP?=
 =?utf-8?B?VTczOGRXU0YzSmx4L0FPejFJUzM1dUZqOUQ1OGdWN1NhT3I5RGpqdmdPSVd2?=
 =?utf-8?B?dHZJV3RHZ1B5dVFnRGE3bXpSMTFOdzNBdTZ3MU9uNUNlcjJHb0NxNmRVR1Z5?=
 =?utf-8?B?Q09aQkpXSFAxR2FQL2ZZblBwTG5WYUZ2TFgxR1htMTZHcFowTk9xcXpFQ1Jr?=
 =?utf-8?B?Q2g5QVRJQ2lDOEFvSy9WWlNHMGYyVFNpRmRwKzFlZWdzWmFIZGF2UnlHaWg0?=
 =?utf-8?B?RGZka2pkbFYyQTZjYjZhazJtMllVcmRXMXNkRHZ6ZDd5Zkd2MlVjaVRpaWJH?=
 =?utf-8?B?NmtIV1RwZlZIaXJFbE9BTzZRVnNwQXhGN2hBdlNjZlFnK1hNaURCMVhRcWpk?=
 =?utf-8?B?ZUNBd1JvY2NJV290Z0ZqSjRjMSt6RnRNUUUxRms4cDVLaTdCa3VCQXM4d0ZT?=
 =?utf-8?B?STlJUlgydStqcTYvdm80SStBRmJhTktSSk1mblJpMHFrbi9ieDdtWFFPR0ht?=
 =?utf-8?B?aEJjTXBtV0Y3Q290RGt2VGJiMUljQzBWeTdLeFpLZmNaR01sK2tZK21WaGR1?=
 =?utf-8?B?czJUdS8wblkySlhPTFh1QXdJOHFIN2ZyeGN2by9WQWRYN1RjS25WTnlHYldm?=
 =?utf-8?B?TzFWUzlhNmhNRTFxaUlYdWNnVC84amZZZmZwcjZRWEVWSHRpSEFxNmZyOTlM?=
 =?utf-8?B?T3ozRXpzWnNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTc4WFduNGdwUlZURVRVNE9YbDRqU2U1dVJJcnJSV2ZNZDA0MDFlbGRiTDBu?=
 =?utf-8?B?QmEvQVNJejk5L3RpckYwV0YzMWJQV2VXbnN3aC9xOWxsZ2VXVGplb2RBZmRM?=
 =?utf-8?B?NXg3N0hTRkdzRnZlcjN2UWJTeGNlNWU2RnRjS2lBYmxDVjRRb0xkTDVwcHBX?=
 =?utf-8?B?czZlQ1NBZFVLTnlHZTdYRFVnNDBNbFMrUXZQcmwrWXd4eXUvREMwWkdpN2M0?=
 =?utf-8?B?R3VTb1N2NlltUnV4VGRacDg3Y1M2UWVWZVM4VitKZ29uSVdVdFRJYjBHSjJn?=
 =?utf-8?B?YmpwOXdmL1F0aFFlVXNIVWpGK2pIN0J3N3AxczJJUWZ4aGdrbVF1V09VZHBO?=
 =?utf-8?B?NENnWE5TSHRlL0FHS0dDcUtJczhtejY2RnJjK1lqcFZrSDhNS3NqSFZxNzFR?=
 =?utf-8?B?VVZpQ1Q4aE53Ykp0TFYyaDA4STlQQmZ3eHJZNW1iOGR5OW1uTWR2ZTFSODBU?=
 =?utf-8?B?b2ZMTGk5b04rNVJMdkIzeHUwWlZtdjFGTUNGQ1dYdnZNZkJ3YWc1RTdyUGFz?=
 =?utf-8?B?VXFBcnVyS2t2ZVBOb2ZQcDlVVTdaWXUrSEoyVWw5YTdHRDRDOHF5blY1Mlh4?=
 =?utf-8?B?Q2lybEJJd2VMQWs0Y2xWdGxELzEwWEhndElDNWIwWm1XTGtWL3RmbEFKbjBi?=
 =?utf-8?B?TXNFOTdYSUh0MndzVFFpTzRTOU9LTzZqdWN4dDVDbnZIQ2ZERVhkSXgvaTdN?=
 =?utf-8?B?MDdWajZFQ2JvUDZyUmhoZWpzbGtHSW8zbVdacTNEUVMzNzZCdkJla1ptYm9S?=
 =?utf-8?B?dHFqWThibUdxNFVRa1diMmRQWmZTeDZ2b1dRMW9wVjA4emFza1NxZ1YreURI?=
 =?utf-8?B?NWMwSG51ODA1NHJJSVBuZTJ1RGdIMWZsV1dTaWovOU9SckIyZS82cmNYelpu?=
 =?utf-8?B?YUdnaFBxZkFJckRYcFF1TDFreHRhdGI5R1BCTVN4TGVTWUtFaG9remo0cTMw?=
 =?utf-8?B?M0s0UXRleWkyUHgwZWZlUndkcVZXUk9oU01XNHFDSEVqZXFVZFQ3MWFKVmxm?=
 =?utf-8?B?bHltWEZOTktheG9qUU9ncXlSNzN1TFhvMnh5UklISkFtK0NrSFpJT1hRVmNs?=
 =?utf-8?B?VVo5TUlRNjRiZXpmMnAxeldQemcxQUc1QXRkRDJ6b2s2QWZKa0l6SC8xK01G?=
 =?utf-8?B?MGlDNUpmbE12eFYrZjFnenJqaWVGdjc4eDBoWnA0Z2tUM0t1ejBUblJYMERE?=
 =?utf-8?B?cHk3ZWJzY0V3eG1XaHViRFNYSlZtNlREOTJDek9sYUhUTElMNGtMQ1Y1dG1E?=
 =?utf-8?B?TG41dXhFN2V5aTRzdDdxNGJtMHFqTUgxWWM5RFlyZVBmdi9iR2M3eGV2L3ZG?=
 =?utf-8?B?dlJsc3pQQTFmZTJORUczYUN0elNVbkt1WTRqemlzQndMU1prb3pmNHpqdVEx?=
 =?utf-8?B?ZWFTSVhPc0JZQzFDQnp3REErb3A1LzBjR0ozaGRqVGpjc1c5SXhoRmRuZXZn?=
 =?utf-8?B?bGNLRDdlSms0VlN6am94MTRIVUFoRkgvdW1RaStlUkk4ODJsaTd4RkdnVCtH?=
 =?utf-8?B?TkNzREZVSkVzR0lqTFBPRlRodVdwYm4xMXAyb09qRkIrT2lOcjIzc3Q2ck4y?=
 =?utf-8?B?dWU1YXVXblVtZVlPMlhvRzFXOUo3SWp0KzIvY3lPMmdkeGYwMEpsdWJ1K203?=
 =?utf-8?B?TnNFTEVab1FNRWNjWmtlUHhBQVN3YzR2cTdxUkRXa3FpZmRsclhwY1BmMUtW?=
 =?utf-8?B?ZDNWOTBpY0lYR1VMby92ejZzTHU5M0VOQjd0TGZoMDVSSStCeWZRSThCM3dB?=
 =?utf-8?B?bExZSzgveWRTMjZhRUFvSC9sbC8zaTlkN0ZYdkdPRGFsc1B5d0xDTEpyOVN0?=
 =?utf-8?B?b29DbzV4bU9LakEyU24wZU1qTXJWVnZJRnBOWUtHMDFKTGdtLzNqUWprbWh3?=
 =?utf-8?B?aHF6RFpMV2dhNlJMWjc5TUlmTlRPR3hYQWovVjVVKzVocjY5NHp5QTdCcnhy?=
 =?utf-8?B?RThSU0Q3NmE0WlFWU3lEcDV4VzBudUlocmx3UWtPazZKdXcvaEExWGMxek4r?=
 =?utf-8?B?TGp2ZSttRXlNVHRwQm1SUHI5UHc3QWNYOVJPYnRwdW9PMkdxaHZnM010ak0y?=
 =?utf-8?B?eFA0OGhlc241b0NLdG9ZZkdwdFlnNUtVZHg5L3FpbXI1MU95Y2tWWm5HTWhC?=
 =?utf-8?Q?4enFq+jubxWpR2XtwsTgb75pK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eef724-d99a-4d3e-0864-08dd4ad1788a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:48.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FSoje42kklJWcHIOIcMWgFmeGb/F4JiGWSpMzOncVh0MaCWwcp7IbbHzxcRP24o+50UA7BF9pjGE8bFlUSBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

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
change from v14 to v15
- none

change from v13 to v14
new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epf.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 50bc2892a36c5..f728ee2660a4e 100644
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
index ee6156bcbbd05..d2790b8b29394 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -212,6 +212,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
+#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
+
 struct pci_epf *pci_epf_create(const char *name);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,

-- 
2.34.1


