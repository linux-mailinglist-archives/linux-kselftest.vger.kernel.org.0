Return-Path: <linux-kselftest+bounces-36330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD58AF5B67
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 16:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44FFF520378
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB304307AFD;
	Wed,  2 Jul 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N0DZcXIK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4F30748C;
	Wed,  2 Jul 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467375; cv=fail; b=RF3Dflh3Ry5re2C7KFXljk+Cuwy9Favb2NM8V4w36gaIp4V//mdwGemohclnsS0xrzaKGOhFuGDFBQe2Fj9tcpZnnKsDUNdmYTZizMH1vDqlZXxCkk+LSWTgL+OBZxWnRJkfS2Pl6F5uoFBofFbRT1EqGvILjB/WojVbpfeFuAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467375; c=relaxed/simple;
	bh=1lVVljcBIMDqoZivX/oIFT9Lel5Yx+OHWCONhk4vQho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rr1B9igmpTfFlz73iCXv+bLoKgSFgkrlryBbSyjHV2kWJYhBnUH5p9xw0zLE45NMM010g9mNNmP3MN6o7nZDJmyAhnYEOdsh8RA8XBobvgs41RXl0/T4T3/YlrjPv4srL9sZwkxACB2qUqeg8nVybVlNlNcLckGah1plaMDvgiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N0DZcXIK; arc=fail smtp.client-ip=52.101.70.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vwEiwisqWu9mvj6SioJIZmd2wkRcaBMlHO4s1tSzzgcJ7FXInGawBzQBNVOV9Vs8MYC8I5hPkEmwwg63OniJVHhuDefKZAATwlbi0BSvLxJ4RyHfQhALOeAF4jyOrv6XX5CxCDet5V65UXd5W3jDa2ea01hohYsDav0ysPIYyZix+z6XZwheat4MPgmTK3lnwGhckIev3HTh5dIkRhD68po6weYNn35udrl7+UTxvCmv8AY9ikGrqqhaTpMjXpYzlR76YIQ8n27HzokYzdQWHCgSBvfw/L4toyhBS05OXkHcNuZ981VFtO8qc5L+4UfQG/BapTuDuY4i2RcloAFKtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFj3hSnn6df9XrineTz5n3WwsjmdG1b/Lqjc55bTafc=;
 b=wAPBw9CjphnCyUa+GXrRq3hOciwuYcX1pz8vCUR4VwNUQjAwx+SBXXP/amIvntZjGZIeGWTxHxJy/HZjVX7r0pgUGrwcXWgGmIa1SjXxhjl43Y78MNO4IzUDEzBWqtxGYJ8NzyxL4do4Tc7sEUs0H6WnY/dEJFLqOUuRNJhr0NxqXla3K/vMm2pWK8ayhpOErsND/JwpM5Pg9FPRHliI9NLDVxafk1usiZoP5Z7KJQSed4xymblobStTyk2mOzGgwL6oNQzi0/dex4peVARc27UoxsvWS6IvP0Xgt+Gdc+hrc4UdMEciRxzndTf1BON7Wc9vLp7jvk19nIad9QhAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFj3hSnn6df9XrineTz5n3WwsjmdG1b/Lqjc55bTafc=;
 b=N0DZcXIKw17p+ZyqLNU/ba/MsSSdLxX+Jgs75gT+9cJCmHVM10sr0VArAzqIfm6J+KlYBn8tYQEXf2gQ2kDMICIW1HYaUsvHpXigacXFdhUhDhp2GbQnJO6TEQUZLecBdzCZm82Ru4XWUX32zBj2IXJIJmtVTJrKa2a8VMib6Oke9Pxfc2ZvCp45T/Y6HLlGxnlOGSvXpfTdv3ebC76F5P0Q0Xes675f4r8NzC72Buggybx5lGtP4AbXHg1eYt7mvJnvBwRkfKuqptpyD/Jay4Os6F3l2mLxAx2qwmX+WzeC0xBiU0JhkCgs035hWgu3CgtnP5JTsBQ4tUFAfMWQjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB11262.eurprd04.prod.outlook.com (2603:10a6:102:4eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 14:42:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 14:42:50 +0000
Date: Wed, 2 Jul 2025 10:42:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v19 03/10] PCI: endpoint: pci-ep-msi: Add MSI
 address/data pair mutable check
Message-ID: <aGVFWgnAIwWOnLjK@lizhi-Precision-Tower-5810>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-3-77362eaa48fa@nxp.com>
 <5axgxbtyqbwwncimjiiedvkm3ap7at553vgj72bht4kynke5cd@xfghwfmp6cy7>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5axgxbtyqbwwncimjiiedvkm3ap7at553vgj72bht4kynke5cd@xfghwfmp6cy7>
X-ClientProxiedBy: AM9P250CA0021.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB11262:EE_
X-MS-Office365-Filtering-Correlation-Id: 33205d06-35ae-48c3-ad58-08ddb976b830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnhrTEhiNXFPbWZwTWVSOFpKaVA2bWRXdkxKQm94TjBBK0pnaTNGRTRsb2VB?=
 =?utf-8?B?V1UxV3g4SUFaMGF1Y0ZIM3pqL2VpSzBXS2NLc3J4aExRZDEyVVJMalovSzF4?=
 =?utf-8?B?b0l3SUVQSUhqenFRaFhzSUtHRzgrSHFGWDh4Q3ErUytzeEk2MTMvSzJaV0ts?=
 =?utf-8?B?T0piREQwRW45cE9UQjJQelFKZ1IrR3JTSGlNcnNhSHNhMVdRQzB2Tm5RUlpw?=
 =?utf-8?B?cmxXMWx2UisreWVvUy9qdGZJblJwNVRNZmUyMDhXVGZMdFhSaGtXSERLSzBP?=
 =?utf-8?B?VmJKMmEzRXUzTG5hNnRuMVpJK2pzRWhMRjhYN1RiRjM5QWQ0WmUwWEhrOHNS?=
 =?utf-8?B?Z0xZeDRsS1g3VUd0cTQ3Vmx1NHU4blRYTWNCdERqaUNGekt1VmVkbzVHNkh2?=
 =?utf-8?B?eWZHMlV6ZDdVd0w2SExmcnU0aFkxaDVuSUVQSGFlNmxCT2krWjFxMk8xYmJW?=
 =?utf-8?B?cnE0bGhWT3hJUGpBT0FNbVpzZWhMSEgzL2FRM3RoL0V0cUF0SGpqZHB5eWRh?=
 =?utf-8?B?ZG1VREpTL1ZVUTJxS2VGOFhxZU5lbkZPOGo4MVhIOHBLeFB3b1hCeWdlOVJP?=
 =?utf-8?B?ZVdXRWpRZHFpMHJNdDA1c2JEWEVkUDBiTjlQU2hpdURSdzBrai9OY1E4QXkx?=
 =?utf-8?B?Q2JpQjd4cTlzOGlZalkxbVhad084M0RlNm5uVUFLdlE1OGovRmRLbmgzQzh1?=
 =?utf-8?B?aTRRRFh0WDQ5eWdkcFdDVjFYU3duR0tBclFmQnhsTVVqOG91ekV5MURhR21K?=
 =?utf-8?B?NTZyeGxKSnpnN3RxM3BEMnBFaEhUSk42NS9YSVdIb0RwYUxJUXhqRkoyUUtj?=
 =?utf-8?B?aDRXVUNPK2YyRVgrTnByZlJqeEExZUNISFp6QWZsb0RuejNPTVBaREJOQjh4?=
 =?utf-8?B?UlVzOUYxWWNNa3F5M0tXbVhXWVFDdUlnNW1uZ083cytjWmR4L1FPNHdTM3I1?=
 =?utf-8?B?RHRPY1JiQVlnTWhnamFBYTdzOWFieUVRK3h2SzFBclh2cE94U0VUbWNBb3JW?=
 =?utf-8?B?dVowSVRNWVA5T3hYV3BUdzlZT1dtcmU3aStBSlRaa0RkaW1xMTQrSGNlQnlB?=
 =?utf-8?B?aTY4RFZWWWRVRmMzbGlSRmRLT052UnF0OTB2WGgwRk1oSFFidkdZSzY5bFky?=
 =?utf-8?B?R2RCM3NOdnA3azRoOE44TEptL1UwU3dZK3dETkkvU1drSzFHV0VtejgxVTFv?=
 =?utf-8?B?OHcrQ01WeXRCSVVmcjJpQjJvdmQwNmdpWkJFUGFCaXRNMmJjOGtGdWVKZUE0?=
 =?utf-8?B?MDJLTTA1ZHk1WlAvcm9wRVlKL3RhTEVqdG9ON1JLY3lpVnlpVWRDSDNDL1ho?=
 =?utf-8?B?QitPdUtPRjJKMWs2RWFsUE9hOXErOGFTSlJUYWUwb0ZBbTNaVlpiYXN1dlhO?=
 =?utf-8?B?VDhNSVRHUFdMM1g2Zm5BbnEza0tvbXlpb1ZLTEljUUJrVlZ0aW5XOEJpS0c3?=
 =?utf-8?B?TjM1NzZ6eUN3SFU4UW04NkE1RVFoMVVycHN5T0J6V3VxNERIMU9FQk5VK3I4?=
 =?utf-8?B?b1N5Qnc2VHhscVBzeEJvNklpUGV2S3B0U1FGcGZWbXJvamZ3a1hLVm1kdU5V?=
 =?utf-8?B?TWttSDVaUU5xc1doSWdwRTdKck8zVGsyazhlUzQ5QVhqZCtpSnNSYXNXdGhM?=
 =?utf-8?B?NzNDNXpvd2YxWXVyTDZ6SkxsT0gyUzdhbWFHQ1g0WTk5clJMOGQvRUs1NCtz?=
 =?utf-8?B?WjQ1WGxaVGV5N3BrRkJmZkhjR292WmRHMDM2M2s0YVpPRHdxcUcyeHJpMTlI?=
 =?utf-8?B?Tzh5NHR2dzBHTmZ4WFAzYnV4MExJbmN4VE4vK2gyWUdzYXRNUHdaTkw2NHFC?=
 =?utf-8?B?cDZ5MkhZYllTTytxYzVGZXFJZk1qR1U4MzZ6VUJadHBzOWtqakVJc2JKdVFi?=
 =?utf-8?B?K3NIb2t3UHZwUE1ZOFIyZGJOUjVhWG9YZzE1VksvaGl1UGFOQ0hZcUFwVmxi?=
 =?utf-8?B?eGZYTEszSSsveFdpUkpuUDNNN2gzQ2pFSEFvWWNlZkpObGZYMmszc3psRWxn?=
 =?utf-8?B?Y3c5Rkk3emZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlQ2NDN0M2lXZnMxTU5IRW5md2IzNUpadml1N0VWOTBKM3ZCVEJnak0xbncz?=
 =?utf-8?B?QUhPRmVkekZ5ZmtHNjZtSDFFQ0VkOWhnRGVIZi9mSUlFYW1IVlJzdTdpanBO?=
 =?utf-8?B?TTdRTFpsSzA4NWM3STU2V21KQU1wcVN3RTBuc2xlcmZBUklUV0FsaDU1S0ZT?=
 =?utf-8?B?cEltMlJWZTFYWUpRR0J2TFY5bTdseWZ2dzJFY3RnZU4ySms5c2V3R0g4eXI1?=
 =?utf-8?B?U3F5eEtCMVhYZFRjTi80ak9QR2VlOG5POENLa053c0NjTXArTk1wRitXeEJx?=
 =?utf-8?B?YlA3RmZWNnR3U2tzeldtOVZHL2cvS1V5OWtoaDh5WHJicE9vZWpudklkNGg5?=
 =?utf-8?B?azhEQnZiUExvRVpZUEY2N0g4Tkg1ak5Nc09oa0JieHQvTkZ0RDZxNmNSL0ls?=
 =?utf-8?B?di9TM21lWmR4Mk9zY1cwUm5DL2VuNkJjTU5CNm5FUGFKYTJKR1FOQkRzS0xa?=
 =?utf-8?B?MHFsTFBZWFlPM3NnVndnWnJlQndPQTZXenFyb2xNckdST2VENGhHUjdvOHBv?=
 =?utf-8?B?Qmo4ZDMxMUJ2UDcrL2FZSGl5NDliQmpXdEk0WFpCb2lPR3RuNlFpMHBKZkhP?=
 =?utf-8?B?MGl6d0NFTG1wcmVTSktDVWlqVlZDODFsMTJhYkNLTkt0S1U3bm5UNW1VYjdt?=
 =?utf-8?B?ZXJkTGVRZWZ1OWdBVDFEcFllNWxRV1dyTndLYXQrUGRQd09OeUlhbDcxQlNO?=
 =?utf-8?B?b1BVZFB1V0Z1UjJYZGtlZG1oSE41SE9mMVV0Z1MzRHRNb0JUK0Q5VU4xU2t0?=
 =?utf-8?B?VWNsUWJjU0toL3l4eDcrTWRqaWpaaGtVVDU0TUlhK0x4RVdib1JFUWI3K3Mr?=
 =?utf-8?B?V0hlVk5WTmN5ZDVGU0VSWStXMW9IUE9jRnZiZlQ0YnZMdHZyK0ovcndiS2d0?=
 =?utf-8?B?bm5tWWhvTWYzS3dDL1RKaUxiZXd1alE4Y0hEbXQ1RkZjM1ZwS0RGaDBNc1JQ?=
 =?utf-8?B?b09KRGdib2VVNVRqOFJKRE5HZ3JpUTJCZ2kyOUZZajlLUU1zOHJFbWxyZ3Nx?=
 =?utf-8?B?b08rMFdIUmxPWUwvME5qU0RyeE5JcldEczdrTDYvV2gxd3RHOW5EcStnQnJG?=
 =?utf-8?B?UE1jVVNtVUw4c0k5clNGM0lWSHlZU1M2Q2RDYXVqK1pEMDA5a3p1UDdQbkRl?=
 =?utf-8?B?U1VlMWpJZC9qcXVuM0hsS0RkdEFoM1lmL3M3Sk80TnlkdlpwUnc4cTVJeWFa?=
 =?utf-8?B?WUpHSlMyYzhjMjhaTkFvN3hkREsybGVFaEova1k4NXNKMk5JQmwxeGZkdTVK?=
 =?utf-8?B?RTRKTkVqWE5wM1g4cGZPc3VBSWFZTWJlR1cyOVJqVE04bkpsb2FYTHdrVnlU?=
 =?utf-8?B?SkVQMHZ4V2xqQ3BsZWZNTnQzbTdUQ2NURGhQY2NnZmlvOWswU0x6SmV5YW5I?=
 =?utf-8?B?Z2dYR0w2MDdoZjFUcDBXWVI2OUx1R21hdTVUMmtKZEI2RTJKOWQ1aU9vSzhI?=
 =?utf-8?B?c0NMYXFjVG1HdlFTZ040aURQaTM2L1l3b3o4UTN2djN0cGxFK1RJYllSZFVt?=
 =?utf-8?B?RHlJck12NmZuQjc4QlY2empyemhSRW1nbUxJYnVDMjNNVWVGaElFOU8zZkl1?=
 =?utf-8?B?VjViM2VjWWN3d2lHbGNxZ3FzeHVKNExodmtrcG11Ylo5YXdvdURMNlNsTk03?=
 =?utf-8?B?OEEvY25raEtLWkh6YlRvdFlTODlsQlVDdG5ZaEt2eGtpbnQyRlhvcElTN25I?=
 =?utf-8?B?Zk9uOHZ3MGVIM3V1Z3Y0WUdwWTd1MXMyTXhEbDlOTis4ck1Va1NQcmlzdno3?=
 =?utf-8?B?cDFZVllmM2Yra1ptSjh5dVltY2JIY1NJRFJtWXpBMkV1REU3TUUvNDlKRnI1?=
 =?utf-8?B?dUlmamVlNGtvWkhMMFFtcllkUTZNc3hEMzVHVFd3QXA3RkxNL2l5c3pQTDdx?=
 =?utf-8?B?TFNLVEVPblRZd1pIMVU3ZGhBWGlicm0reFFXNm56SWpxKzJLaEtEMEJMaE1H?=
 =?utf-8?B?bk50R213SHJSaHVNUmk3NEFER1I4M0NUV2drRnM2dFVrOW50SHdCZVUwZ3N6?=
 =?utf-8?B?YXRxRmRlQTV1dksxaldMWWkyUTl5bHVwQkpyelJxSEFQR1pMQzJPakNqMDg2?=
 =?utf-8?B?TW9vU3IxQTQ0NC9LMUlDN0NKWkozQjBBZzAvc24vbEQwMmR4dUhtclZZYndN?=
 =?utf-8?Q?lUYqpiIXywQyO4UGoawyd8gX3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33205d06-35ae-48c3-ad58-08ddb976b830
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 14:42:50.5582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xu8NaRlw8bTn5tTR8QFGoZXYQNMmUMjJKjPXQV88XyagWPmauHOMLUR2ONOFv5SamR7VSila25DTzrH3/ZKeaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11262

On Wed, Jul 02, 2025 at 05:00:23PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jun 09, 2025 at 12:34:15PM GMT, Frank Li wrote:
> > Some MSI controller change address/data pair when irq_set_affinity().
> > Current PCI endpoint can't support this type MSI controller. Call
> > irq_domain_is_msi_immutable() check if address/data pair immutable.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > change in v18
> > - update commit message. remove 'include/linux/msi.h' part.
> >
> > change from v14 to v17
> > - none
> >
> > change from  v13 to v14
> > - bring v10 back
> >
> > Change from v9 to v10
> > - new patch
> > ---
> >  drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
> > index 549b55b864d0e..c0e2d806ee658 100644
> > --- a/drivers/pci/endpoint/pci-ep-msi.c
> > +++ b/drivers/pci/endpoint/pci-ep-msi.c
> > @@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
> >
> >  	dev_set_msi_domain(dev, dom);
> >
> > +	if (!irq_domain_is_msi_parent(dom))
> > +		return -EINVAL;
>
> This check is not justified in commit message.
>
> > +
> > +	if (!irq_domain_is_msi_immutable(dom)) {
> > +		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
> > +		return -EINVAL;
>
> GICv3 ITS is an immutable MSI controller. From the earlier patches, I could see
> that you have tested this series with ITS. How did that happen if it errors out
> here?

I removed IMMUTASBLE flags in ITS driver to check if go to this error branch.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

