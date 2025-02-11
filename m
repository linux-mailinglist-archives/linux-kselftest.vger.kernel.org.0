Return-Path: <linux-kselftest+bounces-26412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A492A314FD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113C3162E9D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840E269D04;
	Tue, 11 Feb 2025 19:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jLknckYx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3D72638AC;
	Tue, 11 Feb 2025 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301758; cv=fail; b=qP/UTn8M6tc50LolkIFl+fhp9Yt4+TU41ZI6bnHAZMrtUQM9fnPm8udF75VxIQ7eh7yrha1SnDvTtvhZK/fjx56IdpX6DI0YuvDrY3IQIEbOUFpd7JH0+xbWFTtZIW50yiNnG9GX6VsFHA/zSgAeV96V4Dx523lwaAkpwlHgcVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301758; c=relaxed/simple;
	bh=SF/noxgqXgeBTEmaQqYOkkjCwFFGXdPwBl2L+oWVhko=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JDNYwiFw6+ETgfqfBlRJ6oxF+eFz8TVaTUI8mR2aDZKCeb01FTJh6sslPyecktpv8X9JbzrkonDX0PZ/PcuBKVjHamSkZWlOklMIbRf9Xah9NaPSTCsa+M+YfjMyrk/cUFDSR3ezoH+Uc1xp/NeH11k/9gmxmd3gHX5juyV1gf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jLknckYx; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT3YfPn1Ax8ekCVAFpRFmYTBsmBSpRtVpdrgEHNgTySc5oPE29tBeU6ElTDi0kBrUw2cLpJPq/OvsPWpjevfZgfgXHEYOuJ+5i69WDj1/Dc9cBIT1VpgTVFnwX0YGv9j8XhBdwrejoVRQnS3MGIJ+WLhwR/27fFjJSMaxdoVrOvsIhFLhKMh67y+i3yIki8BuDULpUV4cU2bbo4R6b0ot8Jg5Be3FWIMXXx5oqLTdHH6eqid9hCDxnBuRMfk/FuH55wZxCF2wMT5k5SF9lyksta2JMRGW7xB5v2f6BWPrCIm1V9HqHBQf60IXTd8Y0wo4u2gakcGPN5jWZP4pfM7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/b3mmu3JTiyQSWVF7nT9iskg5YOD3nSysAPrIkrZuw=;
 b=Y/fuJtb7nsqXmOJYMvQZdijEMmF6zcbXgW5sHHzqTQIp1Iokd/muQWI5tqjNOImtAbKknA2oIU9RI/yhPLnIXaaaw49zz+U5JV1C1UG9kBjG542KYkpz3ZEsq6H3NzcSU7jHKdE5FuCqSZ8AE3xW9TT3y1uA890S5psah1hpNswBZOHb1PD6mNNBmGRgtRt6TeTXpG4ADl6DsQmDFcnDxBlTZbShuHMSb7j6vpER+4LMm7ogpIbqOb8AQy/YCTqQpKFDj6RpxaMzajjWs+vVjltp0ZgaKEl6GEzSZ7RKea8ln0Y+0tTG2hhhVDolx+I7xaXjiuHSI69qXPCASdC4Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/b3mmu3JTiyQSWVF7nT9iskg5YOD3nSysAPrIkrZuw=;
 b=jLknckYxsam192logZ/Fkenn0vRfdNc5Nyo7DWZMamQOeWMr5t7BulZPGbfVGDZPbREEW62wiaxgMsdYW5AePbcg0yy9qV73jRTeQatf1xRWL4wQBwpwTr05wrRbH4pu8TnKGByOA25V6sQVka2x+Ye+WzxizOeRGKqB2nAM1lcUzmpihWsxa+KUONq5A9X/ia4FdCpyzRRxnCUrE9CouDmTEE9QInKH8czsDaJNfhfQO0M1hXVGzQv/+sW4lGpfmQ9NbFXMay6FGexhcjdD6B4/zxrqsUJmwakXd12bOiXPW+2zZLysqHhRtVuapdm++BDI7MJwwHO/kMCrZmq8VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:21:56 -0500
Subject: [PATCH v15 03/15] irqchip/gic-v3-its: Set
 IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-3-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1326;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SF/noxgqXgeBTEmaQqYOkkjCwFFGXdPwBl2L+oWVhko=;
 b=1AnVt2dDTZn3cQG5fH2XaTki9C9J8AiHJaTCIQYqgUhEhpwd5Lzpwv4/rX0NKfiK36XL9DOUx
 TV1Di6uJr7dAH0SPqmL8C81aVy5qQzljTpAXCQi3DF6xqfe2CHx04Ju
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
X-MS-Office365-Filtering-Correlation-Id: 40b5a704-8bd9-43ac-abec-08dd4ad16fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGlDdVU4bHF4ZlRhR2lVNlY1WEV4L2FaUTFDVjd6VFpUZ2xlWk9kbDM4TjJC?=
 =?utf-8?B?bitNU3NzZHdXM1RBVXVpTnllSGRYcElZQkRxR3VZaU82Z0FOM05kRXFHck5y?=
 =?utf-8?B?c2lOcFNueXR4cnl3VkZLZzFNMElLMXU0SEpjdWxzQWJQWENvcUp6M0V5N0dL?=
 =?utf-8?B?R01xT1JWZCtqV0hFNSttR2hBSDk2dmwyTGNYYzd2K3QrcjhXRFA4bkdHenVp?=
 =?utf-8?B?dlZBYjlYZHVhSDVJK0syQWhKSzRvNy8walo4cWUydE1MRzdNb3RQdDZLd2Yy?=
 =?utf-8?B?TloyOTNkdHNLeGR0MU5qVkpZRUhsL3hmRXpja1ZXSU5rUXJZbnY3dCt1Nkkx?=
 =?utf-8?B?NzAwb0N3K3kxbmRSMHVCd1g0TjhFaWJscGRXdlRhY3p1R1NmOHgrSFdNQW9T?=
 =?utf-8?B?b2tFQ1kvZzJDSHE2TE5ONUMvY2xrVkNvdWViTEdyeGh2ek1VWFpiQTdpdEsz?=
 =?utf-8?B?U1o4eFduVmlhZTJGQUQvSXlNc2IvRGhKL1M2QUJNM0cyR3ZrZnk2MU8vNzVw?=
 =?utf-8?B?S0pVZytVc3ZuSllmNFhrUVg5SlgvL0U5ZkpyeXVjd0Njc05wQnI5UE91cmdE?=
 =?utf-8?B?MlJjaU1FU3dZZy9pdzNqbERlV0R2UzY3eUw0U2kwRXcrZ3hnT0FsRHlxbDds?=
 =?utf-8?B?d2UveEl3TER3NThqNSt5T25DRHdwaGhrWHhwMVYvblptTXNzelc5RTRnQTUw?=
 =?utf-8?B?Z2IveG8vMURyaVhKamZubFg1aEI3SlFsYlNLWTdacGRJWmpZbUdOQ0h4M3BR?=
 =?utf-8?B?TnBldFAyZU5oanRBTjdiM2NHRzE5QWFYK2JRbTg0clhjbkxOSUdYVHQrblpT?=
 =?utf-8?B?eXl2ekZmT013a2tseHZwQklQc1dnRDdNZDUvcTJwK3hkUVg5R1hYbDYwQ0dT?=
 =?utf-8?B?T09RRVRZMU1wblFrcGZ2SHIxei8xMW9uaHVXNWtraHNpU2duQXllOHd6MXha?=
 =?utf-8?B?V2xWbnY0d2J1YnpvTy9CaFFLTlVNVElTblI5WHNYS2hYbUgzY2lBSlVuSUJ6?=
 =?utf-8?B?QmppQVkwb0NDeUJoY0tZdlVZQUFJcFdqYisrR3Q3N2hTbHBkTmVSTmQxU1E2?=
 =?utf-8?B?SjR0RVkwUElxOUZkWTRsKzlDYTNUd0pGVzQ5ZFZ2T2c5WTBKakdONk05Y1Nu?=
 =?utf-8?B?aUVyUjJDR3pPNC9qSVN4YXVZSG9QeVZ1eEFONVg0OWRESllQY2hLaUdUVlN6?=
 =?utf-8?B?bVFqc1BkNm0zK3ZOTWVEU3dJRkJQd0ZWeDVMOFpwalV1SGdlT1ZzZkdPajl2?=
 =?utf-8?B?TDl2Sy9nYUNtQnh1MzQwZVIrNVIxcTl4cTg3blV1Ky9Nd3VybitnT1NWTnJP?=
 =?utf-8?B?K1JYRmNnWnVQWkVKVDA1MFNQeGF1eGx5WkFaUVBXSEZzc1R0RFpxNE15QXVN?=
 =?utf-8?B?RnJsVGduWE11TXJoMlJLNktSRGFhdUNuMmk0TUpZZWdOVy9KckEyL0FCWnNK?=
 =?utf-8?B?cTFSTnVnQU5ybmJnZFJTSHNka3lobXpVWUZsOXpROTZsbENDb0tjVTRleSta?=
 =?utf-8?B?a1Vpamt6WU8zdnNZNzJCN0ZHUHd1WXNuaWM0ZmoxRUZiN3dkOW9ZWHk0N0J1?=
 =?utf-8?B?eDVCU2JoRXF1UmNLTU9YRjlvbU5ITUFWcTZSNHBreWJVbVFIVmJqRE1BdzBO?=
 =?utf-8?B?MEYrTm1qRmZUMDJia05xSmF5Vi9jdFBvZ3JjMHlaeFV0d0t4MTNQa0hjbDdw?=
 =?utf-8?B?YkdHMmp6R3dXcUQ4N0ZSQWJiT3Q5UlMwRUsrK3ZGeEQ1T29oeHRMY3dlRXQ5?=
 =?utf-8?B?Zm4ySmtaVzA5dHU0ZzZnT3NEamVia3k5MmxGbDFLUjBSdHYzazZ1dm9RV1VQ?=
 =?utf-8?B?Z2JyRzQ5bkdzR2xqOEdlTDRjNHRjTTg5RG15L1IyNUdZSFEzWEY4b0Izby9H?=
 =?utf-8?B?ZDJURkhzWVE2eExZQm1UMWg3d00wRm5sR3ZibG80UFBLaXVhSUk3ajZ6bVZm?=
 =?utf-8?B?bmtVejlKd3ZFN05yR2daU0M3TXRCRGF1VWlFSFdKc0NWOUVKS1ZWREd2UkZp?=
 =?utf-8?B?Y0Q4bkRxaVJRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEQrWjRwSzFleG9UYnI0YVlYTFZjYVVxaFhUTHZQNzBCbWhjS29LVHM5UkZo?=
 =?utf-8?B?VURvMEpqRzY1dWFOTTVCeUR0SE9zWGp2ZWx3N1ZETWRhcS9HaHRUZHNDVTNR?=
 =?utf-8?B?Q0hxSVphQng2UTNNeks4RUkySEpKcFZwdzJSY1FteTdoWEZHdlNkM0FMSis5?=
 =?utf-8?B?ekhKRWZvNTk5ejlOTE9aUFNGdm9jYVlyL1BGaWJoWVdmbUNLOFVaVlF6eldX?=
 =?utf-8?B?WWszblQvVWxrMGkyMk9aRnVNYllnMU5UUTJUMmlyRW1OMU5JQkVkUC9FVHJQ?=
 =?utf-8?B?aFJZaXU3VGtGZFdFK1M3ZDU0M2JZV3dIbkxYQjRFdlFCNU5PTjVWZU9qdHlt?=
 =?utf-8?B?eXIrekZkamswZWhuTDEwbi9zdEI0QnAxZWRKTzdzU0s3ZG5tMDJHQUFJczl3?=
 =?utf-8?B?azJac2lrUlorbnMxbkIxS0FaeEFlb1JtTUgvQ09OQ2cyUEdtOEVZbWRXViti?=
 =?utf-8?B?d21NZjlnUFlNU1FJR3ZHV3NVODRpMkNicUw3c2ZJKzlaNldQbEhmQzErMFVi?=
 =?utf-8?B?dktLVENIZUYxeWt1RFpEQjFpbncrMTRJbEJCdzBRUEZzRld1SEEvOHU0NVI4?=
 =?utf-8?B?RHRvdlp3a3VRR3pIREFNNml0QVZscEpFU1E0cVFYbnRiby9RVDBnUnRISzlT?=
 =?utf-8?B?WXhGZFVJVEFQUkZMd1lVa3BCVTNuajFsWWl3R2sxMlJYVjBwOXR1YlduQ0do?=
 =?utf-8?B?SFlmTEdVYXFSdE5OTlY1L29GRklDcFFnb25TYnN0SVhMN1VZbGZ6RHh6clV6?=
 =?utf-8?B?TktjV1BZSG93UTJtM2J6KzB2VlRXdXZUVjFFc2szbzFlVTh1NTZIQUxQNXZW?=
 =?utf-8?B?cmkrTnhOdzVUQ0xBMEh6aDN4blROSFZqMTlGaVdlRnZrQ0IrTlJPNnVlc25D?=
 =?utf-8?B?eE1oZGc1aVdVQzhENFhTOUg3OW9PS3gwM3JESmpLSEM2d3hqVkZwOFBldldS?=
 =?utf-8?B?ZHVLUW1vL2s2SUhNUWZQWUdNdGl5aDlzZTByd0Nham5kNk1MUUdxb1N2SEJ6?=
 =?utf-8?B?Wm41RTltd1NKT2I2dkJRWEo5UEQ4aE1NUmFwYUhYZm5LVzZjekNRWTJoeHAw?=
 =?utf-8?B?OEd6U1p6eUVWSXNMUTZ4eURjS2VIcnh3eWJGN0ZlcTZYYktHVFJ2cGdCWlZi?=
 =?utf-8?B?UjFyZVErb3g2WFdxSFNoeERiSUNsd0pZUVgvejVackVtTEZtWnlCNmIvaWJR?=
 =?utf-8?B?RFZvVG5GYytRK245aUJqZWZGMFBQeDRnZGRhM1FRc3RDMER4eXhqY281U3lk?=
 =?utf-8?B?YjYwemx0LzlsckM1QXhWWkw3Ry9HK3VPRUJxNWx1cTlCUDMxaWtTRVdxcU00?=
 =?utf-8?B?R29CMTFYckJEOEFaWjB0eHNWZUo4TW00bjNFZnRxOXNTNWFWTUlCNGhPNVpN?=
 =?utf-8?B?THlvZ1hrV0dIaGZHSStFKzV2TnZHdzBhT2xwS1RZSnVKMm1ZNkZnenhPOG9i?=
 =?utf-8?B?VThNcHlKQzVHOUFkTW9wL1hrSXlOUVhabUM1VDA3VTZaQ3hPaFRRRGZaYVlN?=
 =?utf-8?B?V211UWlDSGFXMk5TcngzZStYNUxWMloxY2lmVXRaQUx3TVppS3RqTk42UU14?=
 =?utf-8?B?UmJidmFrZzNVMlZyVjlOSW9DOGcyUHdsK0dPNWU2bDNnMnJreE5lYU5nQzh5?=
 =?utf-8?B?NTZ4ZGlDV1RCSXVHYnBSMVVxZkhkOEhWZWZ4Z3hScHFpRDJocGNyNXpjSHBm?=
 =?utf-8?B?NVN5WW5RU0VjTlB3ZFZqUHRKc0hqN0Nab0g5dmRiWXMxYWJBZHZRWVBXU2tv?=
 =?utf-8?B?aEh2cHZOYUJzb3kwZlNuRmo3R3BTd21xK1dtM3NYcU8vcEZrblp3L0xvQ2hV?=
 =?utf-8?B?VWZac0pDYWdzMHhzVGl4L1kxZmdhZHpRcEZUekRVVXRHRXBPN04rRVprZEgv?=
 =?utf-8?B?ZGdHeVBTekF3OFN2NGFlTE9SajJOV2JGVG9rUVNkaTY5OGYrVDJQM2phOHlG?=
 =?utf-8?B?V2dGeGNiYmpnMEV6WCtZUStsamdyUjJISDVOWlJlLzZDNU9wOVgwNmFWOWtQ?=
 =?utf-8?B?ejFLYmJLcnlWU0l0cEpNeEFIa01BOG9YTVBpZFhCYURHV05US1EzcE5KWm9k?=
 =?utf-8?B?RkpyaHU0b1hQMkFheXZLd3RCK2M3RmF4WitBeWw3dEx5cFRSTm5rWlZuWERr?=
 =?utf-8?Q?GpcsX0wwN15c3qeK159updfJB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b5a704-8bd9-43ac-abec-08dd4ad16fc5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:34.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hPJeAoB1LP+jTLbj3eHb7zvh0183J0xXBGrnbYi7Athf77BviyEKZGAOph9hMFBLga/kK2BS7zOe8WatkHxKrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

Set the IRQ_DOMAIN_FLAG_MSI_IMMUTABLE flag for ITS, as it does not change
the address/data pair after setup.

Ensure compatibility with MSI users, such as PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged. Enable PCIe endpoints to
use ITS for triggering doorbells from the PCIe Root Complex (RC) side.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

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


