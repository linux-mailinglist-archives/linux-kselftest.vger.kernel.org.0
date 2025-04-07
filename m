Return-Path: <linux-kselftest+bounces-30307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D9DA7EE0F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 21:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6F71892D1C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675EE253F11;
	Mon,  7 Apr 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ebPGrtVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59897253F03;
	Mon,  7 Apr 2025 19:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055495; cv=fail; b=P2NSva98C63rKGa7tER6p0Ae/kpzumEKFcHOy0l5W+kfN4lCYmodYDLyYwegzSzXNN8+o1uj3tQ4vq8hUXZoWCF1nB2z4tTKOWt9a0kilzuUEv0hLp/8gYhRO7+/v3UHr0rrItSwY9R1et/HSS+4ZjWlhmRrbxWCmDD/4T1cpxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055495; c=relaxed/simple;
	bh=nuOSilx0xFIrmQ7q/FNnVVZ6I8tKFEDBakFZ9GZOgfU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oYKTr8cClHw7R4YSfSJs1ay2UHlAkt9Inr86oOXycBPercIJ3+DD8pwCvHxanxP7HSLnss5mqvxFlESyfj8pIdB8TT1TKE8ntlnvS4v9iwTj34sdUUcqeC7v4m39ZDbBqaRl/tr0A9QG4Z7hLc50t3Ks2ZRQKID10ixM0ap3lmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ebPGrtVY; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDcW3vFV1jgt2nJNvOoJG8Kv5X9e4+YZFpGsMEUcEyQWg7WptAgHz+Zz+lO0J4kiguQ50Y1Fy6I6B05EJWXGUMUTBjyxQBitlJC7qDhspng/DEj0dwIOsfMxsYX91Dx8PINh7qHcPX5nlvfeFFk+tIAwqoPuUG8UYGUxu1cCwhDg+VpjtXTQmfSSlfa/64cc93OGWeMMwSJJGrik4HKXZdlmj6XMU9VaHarC7wHbtQNA1fvyT7toeL1QGK69/Z0ZCIUatQyEOE0kW50tqVtaxTuYi8qaB3ra2ntpRC9vbKFW6+zOmDnR2kr3Zgd6AYDG2Ljcgbcxk9tm0wx1SIjJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvzvkawi1c4jyl+gIIApohWSfi73eTZ55zDdwaLFIxs=;
 b=AjxsyHuGONiW6Z1Sg9NZhuMl7bVDlZ1QkTWt1vbPaYWzWJzKWxzDe/EYhpt0Le+Ycmg9xKNE24hsFItMAXnu+AIa+MDOhFnLDwYhqqEK4F4+bYVf7VgdaqwRMvaf+oJivU6zQ1Ea+EDLcEzYY4/iglI8VFibXIpYvSdn2wyyE49uoDySrR/4jQNq4orJpp1vYOzAtVIY3m2bGCY6j+/IcDyxeLVzmSICWCn8zFV6BCZIaZSAVqagEHWy0TwBNm0aEPZhjZ06ZoPAuxLa+lLrQKkUVDF+t6MCuL91HClG6ovB2ba4q1wp0zQHyLvWCxq1f7NA0bMcj9GacWpsZmQZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvzvkawi1c4jyl+gIIApohWSfi73eTZ55zDdwaLFIxs=;
 b=ebPGrtVYxCDBXzrw3gAax2sNztAlDDVxXqSU6rUmgrkn3zvO7LFAyq53zhL+PYs+qr+B8mpzE2MC0DrUA+T/TK9KooaucZgGBjGL20g02CP0c9uRhHVxOu9GhC7jGnARmXhZLrLRaA1J2XNMCjOHH+F/E+3f5hWxT9qAmROqgdSintAve9QoHmP6UEmSJO4S5PD9I4LuzGqbXb88HfYaiU1gmzxN1GBn6z323mV860gtgQqTWfP6TeT5otPTjzfT6DWLrYguwuJN3s4/KZ8oP2XaPekPuKXdxQi2Mbu7ZAcWn7NQZs2mQ0q/7SkN3O/2SjydbGZNSUBuTkYEWwLczg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:53 -0400
Subject: [PATCH v17 03/15] irqchip/gic-v3-its: Set
 IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-3-633ab45a31d0@nxp.com>
References: <20250407-ep-msi-v17-0-633ab45a31d0@nxp.com>
In-Reply-To: <20250407-ep-msi-v17-0-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055467; l=1326;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nuOSilx0xFIrmQ7q/FNnVVZ6I8tKFEDBakFZ9GZOgfU=;
 b=PcUhYKWS1SR4vgc58OsEydvBMUyrg5N1ER0xvmGfhYNVqZQ5S03z9S36ypATFHJtO0kN34kiI
 DMPoU3Q27ZoApOv4RZ/N/UYv4jnfQXOqX/wn/9txpdibq9fe9cptYo0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c3ff6f-92ca-41a2-d64e-08dd760d96ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUNaZXJZYlZCcDJiS0JCcXBwMmdXK1o2c1Jaa2FHQUZSTDhsT0JBb0FYSFg3?=
 =?utf-8?B?OXdwSU9VSDBMbGNDRDljc3luOFNBUGhKYmxCVTBSOEF5aUNnOE00TUs0bkU0?=
 =?utf-8?B?V3ZIclgraXR0SEdrNUpSUDIrakVUYityditEZGQyam1ubkNOOTRHRktHVlRY?=
 =?utf-8?B?RzV4cy9kQjZVMERVMkxXelkzRW1iTE5mK2x6QmxQL2RPWDlyWWNCUnFPbWdx?=
 =?utf-8?B?c3JCOUpITm1YOTlDOEFwYVMrbzc5dDFYMFBGTFk5Ykd1UXpyd0gyVXFXTFRP?=
 =?utf-8?B?cytJR05oQ0c5YjZKZlVOY1BFNWtNM1RrYVRDVVhaR3Y5dkhMVHREZ2FkeUg1?=
 =?utf-8?B?d08wYkw4MkF4MHkrOWduZE9mOVFrdGFwaThmWWg3Q2N5U2tCc0hpc21BVUdL?=
 =?utf-8?B?Qml0TmhwTW4wWnlTVC9HOFVCSlNjV05sdzAyTnFtRVF5NGNhN2ttanFnYkhm?=
 =?utf-8?B?MVdIQm1LK0hOSkhROTFuQlJjenBQSFVweVhVa1MrdEpNQkErNEVFeThJVjlY?=
 =?utf-8?B?OE9FbFNFb2MrTnBuc2p0dStpMFVld3Y3M25ISWVyQ0VnTmlIUDBVUDJmMmxh?=
 =?utf-8?B?R2t5YVdGQTZld1Y1RmVhQ1htcXE1NVRnT1p3dlFGUi9aYjlyRFlWSHRUQTBx?=
 =?utf-8?B?dGJuZzF6QzBrTllxTHVxdlVpWUFUNlJHcHduNTdqZUZGNDB4SnZJR3lJR1lS?=
 =?utf-8?B?WU1CYXBNODN6UDF3N21sM2NqeTg5T3cwZ3RjaEFsckxrWndkbWJCeGpLSk95?=
 =?utf-8?B?Ynd2bzFTMTQwSm9DQlFxeVNWNzhCdm56aDY2YkwzWGxVdmJrREw3N1FDN2dt?=
 =?utf-8?B?RXdxa2gvbHRub1ZZWjUwNlBaakNoYWxxMjBqWW9mM1Q0L2RaNzhNbm11bC9h?=
 =?utf-8?B?T3g4a3ZnMFlnczJVZ2VRR2FHOHEvZWRvRXdRSlBUTmo5b1dCMlE4U3lyZm82?=
 =?utf-8?B?QWVjWXdRL1pLbzlPelFlTFVGUGZmalVaSHBrVUlXNVdETW5TbGNSbHpYa045?=
 =?utf-8?B?TS9kQjgzTDYxMGdxSGttR1c4V1FYbElrU24vVkhOaTVubG9DSWlhTVJ6NUxL?=
 =?utf-8?B?S1ZwOG1VVVJsRkw5R0thMWJBTHdLOW41cXNpcnlIT3d3RnEyRnM4WW9PdWdr?=
 =?utf-8?B?OUthUUFyUTNOQjYrRFAyMTgwcWhlTVZObnlOWVJVM0FoV05scmVrYWNCeHRG?=
 =?utf-8?B?WHVUVnkyaU1Rem5kZHM1eDc4Mzc3OHJZODVtWVg2cFlyb0VjVnRVbDYzWkJH?=
 =?utf-8?B?dmFuN3UweFhLTE9zRE5yOGZJWWN6M3prdDkxbGhOWVZ5SlpoZmdhMUFHZTZP?=
 =?utf-8?B?K0w1Z1hSdjgvQjFWTDc4NENKM0wwYTRhSmV6SGRkYmErWWdsNloxOE9NOU5O?=
 =?utf-8?B?M0tzZGlOTENYWWt5Skpnb2RzYy9KQ0RYL3BGcHdNdjRsanVvTEZEM3RBTkEw?=
 =?utf-8?B?RFpKNjRHdzBGOXRIcllPa1BNckFodzVxdktkeXVVNUxnUS9ZSUFrZ3ZNenp1?=
 =?utf-8?B?MUFzZk93emlrdU5ZU0ZROFg5ZlZQRzBqckVhWXVvK3AzM1hNMTdnWlhzMkcv?=
 =?utf-8?B?UHVMNFZuQy9UcFdReFZkYnVIb1dQaERBZWNqb1JEZ2drQUFiVjY0YlhzWEVY?=
 =?utf-8?B?UExzdEFIZEZlemlSenFOVDBmSm15ekVaY2Q5NnZseTMvNW1WdE5acDBlelND?=
 =?utf-8?B?U2JsYnZkVWRYcnRsbHEvRmJhQlh0WElMclJha01XZXJNZmFnV1oybWFiNUFa?=
 =?utf-8?B?Uy9OSHA4cEs3NDBpNUp5NGx1bGxuWHF6ZU5TNFgrWjByWCt2dSsybTlVRDF0?=
 =?utf-8?B?ZkpWS1liaEw5VGJkeGprWGJkcURTdyt0dEpkV3laL3E5RFc3cTdnaUYzUzJ6?=
 =?utf-8?B?N0xKRWMwREd1TnFZdWdWYjNGL3FRUlNPQzhKZXE5SytYd3dURmdJQ2YzRzVs?=
 =?utf-8?B?VDYycGhkbCtKcjJyck9oK1lScUZoK1lCNEFROHhFdW92NTlmWXN3ZGNoQ0or?=
 =?utf-8?B?NmliSi9UdExRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTFuMy83REhpRHJWN3E5L3lNS3Z6cnpRbFZJUUhIRmRxdmlkQkYyanZiV0hy?=
 =?utf-8?B?ejREVkhlb25TTEM0WUVYQm02VXdhT0xIazNSWHpzWFlPcHJQTjduMmpId20w?=
 =?utf-8?B?MkRQckdxVm91UTBYeTFra2NXWkFxQjlLWFEyaU9uT1pBeHZiRVltNHh0NytE?=
 =?utf-8?B?VCt2YXd0eTFpaTBjQW5mZEtiK3dweFkvRExSZ2VwKzUwWWlEY0xTTmlrRFpy?=
 =?utf-8?B?Q0w2UDRJS1lnWXpKdXg2OTZBT3kyNG5GdDNHOXFqa0p0bkp0YU01YVB5M3pQ?=
 =?utf-8?B?Y3h5OWFaN2p1NUZrTmhlbWpEUGU0aFNQdXNSYmNvSkkwWm00SjArZVhwUTI1?=
 =?utf-8?B?eHJiOGwxNU9IQ3ZWaWJEZjlXYWswTFhaWXNIRHJJVU1XdDJXa2VhZUNQR1g2?=
 =?utf-8?B?UjB2Q0Qwb1FXZ3E1L3NMbVJLZmNyV3ZyazAvUUZHZzhodFh1cUY1bDRjWUFs?=
 =?utf-8?B?TlRNb1o1dzhwTmpIUHg5eERDZmIrbmdmVEtCaVQ4bXk3aGgyWUh6bHhkNE5H?=
 =?utf-8?B?elB5QllYUE9FNHBJclA1WlpoSVNIUFVDcVZPeFZ3UGFTOWZRanFuMk14ZWRv?=
 =?utf-8?B?Q2RHNkV1UDhMdVlGRzJqU01QcDIvZUhxSkZWbmZHNEJkU2hqaFpUVlp0N0ZE?=
 =?utf-8?B?YzRPL09wa3ErUCtmMStuTTFna0haeENxaWQrM0YzSGZNeFd0elRRQmUrRUxK?=
 =?utf-8?B?U0VhS0g5UTBMUTV2MGNqUWpjK1ZtK0JyMm45NERWMjgxVktJVWo3cVpNdHN3?=
 =?utf-8?B?ZDhBYUE0ZHlyQVE0NVZ4aXpVMHNHZDZNUFlIeVZsNlQxWVpzRXc4dXo2a1Zr?=
 =?utf-8?B?VGJGZVV6ME9IZzByNHpidDk4YmY2Q09IVzZZWWV1NEx3QmpRUUxuckRINEJw?=
 =?utf-8?B?K1BKUFNvVlNjZmtERW5uOGllMVlPVldtRUJhenVTQVlwVW82eXRMYXBJOHZ1?=
 =?utf-8?B?eE9rdzNJbm94MFhzRlFrVUs0MHBIWHpHUWorU1pjbmxnb3luRDdxbDdkTW8z?=
 =?utf-8?B?aytiUnBDZFBGcXJiWXJsTm1XZ0NyYVJYaUZUbHc1cURFRVBhc1VXMm9GSFQv?=
 =?utf-8?B?ZTVvZTRSYzkyNi9UaE1aemYrcGdtWUIybEcrUm5mdGFUbitRTTZ5bElKS2tB?=
 =?utf-8?B?eXdZNk1na1VydlllUHl2a2lTdzhiOGxGNkR5TnEvQXpBdXBqVXN4RTdMbVdZ?=
 =?utf-8?B?MGFqZThJZlhmaTEydnpyMGlJek1iQ1BVYkU3STlCbGErckJjMGIvYkRxWHNr?=
 =?utf-8?B?KzJjU2dPZTFkK1RlZklRKzdqWU9MTFpKcUR0NER1RHRaRFJFUEdFaWNIeVlP?=
 =?utf-8?B?c2sxWFJIK1llVmRNTEtUcG9NZHVVY2duRTFCc0xXa3VMUjJ2VGEweXdiaUpD?=
 =?utf-8?B?Yy96SzBpNFhvQkFWL3JyN0xvTXh2SDhWbThyQ3pFTkQ0UUZyM1lwYXpuV3Ex?=
 =?utf-8?B?N1AxVENMa3RnZURRZlVManZuRllib2hIUWswN1kvcitwalUxVXNoVnFTL3hY?=
 =?utf-8?B?UjdiVFNKZ3VoK2RMSmd3S3MyWEdET3BWdWw1V3ZjbVk0MjVOK0pPVHo1eVM3?=
 =?utf-8?B?RmJUVG9uRGM4b3RRTFBTV21sM2c3aHJUdXN6YTFlcnlBc29mTk5JeU44Y2VW?=
 =?utf-8?B?WnpBM25iYTdCQjJ3eGtlUWtZYW9JKzdOb3Ezb3hBWExKNWtTUzlveTNxRm5t?=
 =?utf-8?B?cEt2dndqN1IyOUVhaDBGaFM4aG5hak1FTVYrSmVLLzdXYVVzM0RiVnFUTGJV?=
 =?utf-8?B?dXNaNmJOSDhZbXVtWk5tTGRIYlo5TFI2NlB0TDhxZk13UVdlTlFnUitIYmx6?=
 =?utf-8?B?WHBpVnlXME1jZG4zSkJVNW1kQ09JaTMyaFlQWkJuQmRNcUZZd0pVS2FkRGUr?=
 =?utf-8?B?YkJoNDFtZFM2Wm54R1dPQzF3VjhqcE96WHFiTnExckdYNndETm1XWnppN0pV?=
 =?utf-8?B?NGdNSU1QM1JxQ3MxZ09YampESEw4eUp5OGdFUy9QazFHNmxVLy9Ia0wvNlhx?=
 =?utf-8?B?aCtQSkpkWURueGhuZzlNM21FWDczNUJvTTdZcnRZZGhSU3ZGVXVCQUVYKyt3?=
 =?utf-8?B?dmoydFhRK2w4VllKakNrZUtsTXBET05SWDh3aCtPZWxMZEFNa2JGcmdiaUNm?=
 =?utf-8?Q?FYlfoRZYaoEu4QGU7+8rfXuoY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c3ff6f-92ca-41a2-d64e-08dd760d96ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:29.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnBrHxR4niWqIMmdHJdj0R7p5bixHwZIK3aBWtR+myVER4fgGZiWo5NECyERF7lR6P8n1JavjdNUpUVpugitSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Set the IRQ_DOMAIN_FLAG_MSI_IMMUTABLE flag for ITS, as it does not change
the address/data pair after setup.

Ensure compatibility with MSI users, such as PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged. Enable PCIe endpoints to
use ITS for triggering doorbells from the PCIe Root Complex (RC) side.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
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
index 0115ad6c82593..fd6e7c170d37e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5140,7 +5140,7 @@ static int its_init_domain(struct its_node *its)
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
 	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	return 0;
 }

-- 
2.34.1


