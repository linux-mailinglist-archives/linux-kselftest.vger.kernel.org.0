Return-Path: <linux-kselftest+bounces-30744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F88CA88B22
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859ED3B3E08
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4FB27FD79;
	Mon, 14 Apr 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O75S+/f0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012020.outbound.protection.outlook.com [52.101.71.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE7A28BA89;
	Mon, 14 Apr 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655480; cv=fail; b=kWBLFQR9tnViGTgjMurHPP9Reg+VyD6f4rzW+pAOZmqtzLdxS7HogrzcByuqjrk/0ow1mEkoR0mCVW5aqZbjzida+uwxvFvcFhN9yJZ5pzSjr9o93XhgnLJ0OcMtVudkBp1IF15kw/fOrFd20eAHbu5W2UcRoNTs8fYt4IGUCF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655480; c=relaxed/simple;
	bh=Av9yZfOwyGUlBQYUwHWZ3g7LTvu0X5NtolUPmJ1XA00=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=btb7tRUvI0Fyf70AfzWlwvbkibhtSMrVHzx+kcAGXkHg34FiFeFVN1qwOTVzvvtBT5gI/T6Ls7Birqt+vGvU8sUnmiilq/uZbsBOXmKwgtJ2uuirFr4yxcIXieblFkYSPtAvumshDcJChXwp+AgJgL2uNkCcTPN02BdSx5zfCBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O75S+/f0; arc=fail smtp.client-ip=52.101.71.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+nigTbiNY6P9u8u5yGCMoI1k8qgqbqSIEMdOVZdLj+bWoAYb3UokSAJPeX6+Kf/oAJroYuk5mNAS11pAGOkjpzhUXspIrTLYAci+ls4BgjxbRVav7ep2R7Zs0qUsKqUxvIx+WNQ+RyyQFPuLuVYzm1DPef1BrowCVhIgQZaL44lkhGsELZIgGwiH14fecxNAGt97Tyrpl6ofw/DnRg0thq9QK+MoIye8un7Kl1IrAhpkG2Ze4lR4sMpzZ017z/h7fnyXFVzC1V/URQOLkFnW5f1sCGYehjzpBG7dzrz0tHLmjZeh3oHCLVD41EHzmcxvmuvN0KIJBtWreESR6fHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0jKAcp6itwMTP+d+tIYiRZZdzJ9N8MKjOefvkN0QWk=;
 b=CUvnAbfOWCuPkseiXS6Lr5Or2tIWZuQof4KX6R8/gZQJ0UkbT7rJnmUy95J8g1bGE4rkC4a+LXOLR6lSfDi5Yt6GV2GUdhbUyOL9pC8GtVz9BQUJAhQ1Zst7WC9iXOAvevjlJyyH49DZRT6xdleqix8RDMRgsZA+Auk/IpTjiDtxb9NbWm+N6trTM2nvLvtWJGBexCyea67Y4mShDxT6vXyuI7LZr0DswA4en+x5k8FMSKAonrW1XWOtgygSzSgKHoTpNdlLCAJp8rtEVKC1SkN8D/68kYcKdwnvVUsHFAvxC/dJroY/o16njlsl7TWalEMSUhApINZ+/EZ3akk28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0jKAcp6itwMTP+d+tIYiRZZdzJ9N8MKjOefvkN0QWk=;
 b=O75S+/f0Aatwb8xvnkGmEub/FSZBLGJ7HdPrJz15VQeIqhZmYG2XzH2DJ+EvsQXZdJKLtwYszBeQIa6CQgjXbVb/v5/G407yu9mLPpn0Dhs5627qF6Evb4j/agf57H52oncUVdu0pXvbt0xs75snSs0KzN2gILYfRk3redF3gnI7zh/MxL99FQe8JuOkTvgyOzacdJoJ7T9Nc7/ytG9555HC6CyZVeS6736Y2nIX17GNTxxJLxogcO6nemPq9OY9N1E7ZBJSz4qA7yj5DZHaSjPZXP50TgOwFk/r3eQBJtIDzhb8GJDcuoVaEPvImbuYG2hN0zIP+kdGwfFsykb4+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v18 00/15] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Mon, 14 Apr 2025 14:30:54 -0400
Message-Id: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF5U/WcC/13SSW7DMAwF0KsEXleFSGrsqvcoutDYeJEBdmGkC
 HL3SgFiyV5K0CMo8t+HOU1jmoePw32Y0jLO4+VcDmDeDkM4uvNPYmMsFwNyFMCBs3Rlp3lkxov
 gPJEHn4by+DqlPN6elb6+y/k4zr+X6e9ZeKF6+yohXyUWYpyFFIOxDlQA93m+Xd/D5TTUAovoE
 MGKREEadHQYrfVotkg2BNysSBbkQFgJgUfO9RapDgGuSBUkZLYaMVHAXXu6R2JFuqAoXNDOZR8
 xbJHpkVqRKUhlyMrkHMH7LbINIacV2fonxaMPlEHGuEXAe9X6KxvkzOhA2hQZ1Z5Bz2xjUMcuS
 GRnyGq/Z9gxaMsq0+SMKApJmJ1EvmPUs7YuqMlQQiUEizGg2LE1GpIj143VbFilwQOpjH6XDZA
 d65us6fDBhQAFgbM7phoT/STVc9UWbFSmxmrHdM+6JmtCFJHzQjqCnj0ej3+TnZVnkQMAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=12471;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Av9yZfOwyGUlBQYUwHWZ3g7LTvu0X5NtolUPmJ1XA00=;
 b=h6T4YFJFy3J5bIV9N3pC7jVw5sGA4M2DvA9uDOJ113lte9EPCu7XuRvfgsAPJhzpYrRiaGlCf
 /CKxjVVBiORC2XlMzXjkCfV5vNRapFJGeNU2MgxMsyX0xloUpkUYfCO
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:510:324::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d4c156-3ad3-4621-22b4-08dd7b8287fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnpGSGdSdzdHSHhMakFFQmx1dUFHUUhzK05mMU9JNGtIdzdaZ1ZLeXZaUUFC?=
 =?utf-8?B?M285TnlBbmFEQ2hXdE4rZXlOcWIzM0hVa1lzSUFvemVJYWFES1RabUVyTnhY?=
 =?utf-8?B?Z0hmSjdrNDNpdjhzTVBpTlNTMUNTbVJiMWJFMlpKam14Nlc2K01aMjFZdWV6?=
 =?utf-8?B?d0p2VEtZZnNJeTdaMkwrVmFzN2QrRlVkSkwzcWNWa1duL3BNT3BIdUUzc2lO?=
 =?utf-8?B?ajAzSTRGcjlYNmM4K0I0MVlHRithRHJzVjd1WFBhRGo0bExJUWcxY3FGYkFz?=
 =?utf-8?B?MEE1NXI4SVZyWERKTjdSdjUwblNoZ3hRSUpJZTJKemd0R3BKQVcwRzlFcFVs?=
 =?utf-8?B?ZStJbzFLNXdVa2huZityak5uWGE0ZXhjdkowMDJ3dXY5aCtpUGVOeHhtMlA2?=
 =?utf-8?B?OFUwUEpDOHFxTmlCeDNPdDkzVDhJV1ljUVpteFpJVHlTUklGVFVzM0g0d2gy?=
 =?utf-8?B?eUtqMXEwYmloV2R3endPdVJlSUY3c3hESFZUUWdySC9GY3RzWU5mQk1wVkJ1?=
 =?utf-8?B?QlhlODUzU0NPdlk0V2FmdWZ2dkR4d25pSDdpSkkrYVh5Y2plN0cxMDQwZ2hG?=
 =?utf-8?B?bmN4VVplSWw3QlNDVlc5YjlxeUhORmtnajdiTVRrL0l5ckRrck9sVTByMHdC?=
 =?utf-8?B?TXF0eG1kRENQSVNQd1NFMXQ5L1BFeHpWdDhFTDUxTDAxUjBsaHhNWS9iTFFo?=
 =?utf-8?B?cTQwcmlndWlPeVVxbjJYbUh4dmNYcjE0RU4vcEtlMmVldXJDK3UrK0hKeGVI?=
 =?utf-8?B?a2JpZ0RKMHdFdXVOcDlHaDE4bEhGczlONW5Yd3VOQ2VTUWovdHlOUHZIUGZk?=
 =?utf-8?B?RzhYZ3UxZFNXRWVOOCtmRVZmY0hxeDI0b3hCNE0vaCtqZkF2ZG1TSlVtZVNw?=
 =?utf-8?B?S2l6UUlkMC8rQzBTZm9IVXViQTlSL2lNeVkwVTZaYlRNdWt1T2xpMG5ZejBM?=
 =?utf-8?B?bnZwaDBzcHZXRStPa25RcFVMOWg3ZmhUeTRXZnpSS3UyZ0V5VkI1TVdBZFhG?=
 =?utf-8?B?QmJacE11TVBpMW1wVjJaMnJicnJ1TitxYTZMUC8rV0VkeWZpZ1RQRTZSUS9K?=
 =?utf-8?B?QjlodVQyekg4UktDTTNDbEZzYVFNZUM0UXZDRCtPLzF3K2Y2azExaEZ6Ymgy?=
 =?utf-8?B?dzRyZysrZUd2Y3JIVEJTNVpYd0pRRHQwTzFQN2g2OWRzMmdjZ2xvTE1XNFh6?=
 =?utf-8?B?TElUMml3UFJ0TW9ROVZ3Y0tUMnhIZVBMQWkwMXFxQzlQeGw0c1NzUDFvRnhv?=
 =?utf-8?B?a3JxYUpEZUNyUFA5aUhnSlgreUx4eGRqN2Q3WVljdjZFMURBZEEwTjBOcmZt?=
 =?utf-8?B?Q0l0K1FJTTVOb3JtMDdncFBidk1LYmhmZmh2QmdtZFR2bVRqbkp3a3pnYTVL?=
 =?utf-8?B?TWc2TUx2WVBDaWZ1ZXBZUEFoTkZOa2pkbDRuQk03Ump1YjNuZmFVUlhpeU56?=
 =?utf-8?B?Rk9QZlJFMGNDbjg0VnpHS1YySlh0RHpnMEpjYlJiNm9DdnVBYkJxUWpQY3ZB?=
 =?utf-8?B?QkZnb3hHeTlRTXlMNnlrY3M3eW1IK3FjTW1tMGFNZVpZK3JtZEtMNGw4S1ZF?=
 =?utf-8?B?NlQxSUw3QmlWWVZNMXlQdDM1Z016UUlYL1liSnFYZ2tZSWdwOU9VSzM3dnB0?=
 =?utf-8?B?SHJ0K2NKeVllU2loSnNxRCs1UVNqcWFBQWRWaHdtR0JteG0zU09ubTREMjZH?=
 =?utf-8?B?WDVtWVlMWllteU9RdnNGRTBZQmE3N0hqV0hIeWtlTUlOTVp1cmsvYjhCbGhU?=
 =?utf-8?B?SlpHZ0UycHl3eVN0MnNKQUhmSzM2NGhTdHQ0bE8zdmUvZkxwTnZmWTB0SFdQ?=
 =?utf-8?B?YkRHOUZpV0pCSk1JUGsrdXBaWnROQkxtVWVpaEcwNFdCUDZLb2t1YnVkZXlF?=
 =?utf-8?B?dm9MNEtRekt5TE10QXNUaTZRMzR5ZmdVTm1uZE5aL2tKSXBVQ3hnNHJPQ01u?=
 =?utf-8?B?dkloQVJ0OVVJMWhFMEd6MUplZ245QmxOZzU1Z204VzZGS0xKVUM3ZnQ2QnEz?=
 =?utf-8?B?UGpFOUVPR0xmYkdGeVZDTkFLSFhRQ0h2YTNvSDE5VnU2Z1B1THczVEYzNkhS?=
 =?utf-8?Q?1ZOYBJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alBmUzIxNXdCRXBQNEd2aFB1MjJjWWN2MUhQbmtlTnVXSlF4QmdoVG5LekNk?=
 =?utf-8?B?UHEwSjBJSS94L1dqWjVyQXd6S3FOaUZSTjBrOTJFWVRMb25CeDBZdGZRZ2k5?=
 =?utf-8?B?MXkray9rQmtLSCtjLzhyL2srek1sM21BcTQwZVNvVzdkVGlPaXpiOE1TaUdp?=
 =?utf-8?B?aEE0R01EM3UvY2VobTRjQjliU0xuRmhrTzFyMW53Rnp1TkpaZzBWUTV3WFhj?=
 =?utf-8?B?SXFoRW01blB3Z1RQVnVBTzNlOWVyUjVCSEtXS1BGQi9Pcy9rb0dsVDBLL2hP?=
 =?utf-8?B?c3h4cHJpeWhNR0hVNnFvV3hqdnNTaDQveCsvc1lLR2xNMlozZTMvTGtaTHhw?=
 =?utf-8?B?YXJub2djcDlzMjFyalJValpUWCtPMHJGNENBN1A3WjJmcldMWCsxU0NLSVVv?=
 =?utf-8?B?aE1pWE5qZWxEQVMzczQ0UzY1L1UyU001RldlRENRQWZPNkFVN1YrcE1ZSUt4?=
 =?utf-8?B?RGxxNkYxTmdTcHk4WVdLSUswY0NJVlAyRFFPNnp1U1FseWR5UE9iaGFqV1NT?=
 =?utf-8?B?L085Q291TG85M3FIOVZkSzRnNEZZc2J4NDk5MUtWUWFmNFVyRFQwMnNteW1t?=
 =?utf-8?B?YkxrUk5UQjA5VzE2eXo0NmZVLzZ3VXdRUTlJS0V2Nko1d0xsYS9IR2QxZkk3?=
 =?utf-8?B?eTU3b3lWUW45NUVxZnZ2dFJTcGk5Z2pXYUdzR25aeFVORjBKUjhmZlF0dzJH?=
 =?utf-8?B?bGo5djUwdVkwYkZydlpmMTlOd0h0cTFORmVaY3UrajZXWFRRWTFWVkljRkpl?=
 =?utf-8?B?ZUpDd3BLWjRwVHVnTElVVU9YbUFUNXVZS295UjlEa1pFb2NtRmNvcS8wUFN0?=
 =?utf-8?B?MHZJQXoyQ0ZwbGtiZWR4UVVBUHA3Y3Q0WHE3djZ0dnRqeThmeEFxSkp6ZHk4?=
 =?utf-8?B?WnprN3F2Yk5WT0xtdU9zMllHRm82eXpua2RsSW9LZ29HUzZia3FQeU1sZ0N5?=
 =?utf-8?B?WUdqemNNV1ZhZjVMMHdoenErR2EyRkFJQmdjdmVwdEo1azNsSVJFODQyU04z?=
 =?utf-8?B?UnFNOGxFR1ZWdkpmWFRNZWNLdGM4T2ZhS3JYWm15QWIzbERhTTlvemlGZTBC?=
 =?utf-8?B?eXphRzlLbFZ5NEk3WXNwbUh4d0VvTHh1OFpNdUYvVGVLRFErdGRCRU14RFA4?=
 =?utf-8?B?Q0ZHR3RuZ2FJbHRYVGdtL3pTLzZvci8wWFlCUHgrSlpTaG12bVlpQ3IybmtZ?=
 =?utf-8?B?OUUwNzZuWnNrV0tZVC9JbGk0aU1TTmp1ZVI2dUFMNjJuRmsvWjJwVDVjOVQ0?=
 =?utf-8?B?SWErMEVjTGhRMFh6Y2tBWmxZckR3c2tGMnlhTzRKS29YdTA0TE80bVNBcWtm?=
 =?utf-8?B?TDE3TEg4ZXF0bjl3RUdpYko5dktZeGg5WmJzYng3SkJ1VUJCU0w3dlA4ZlFN?=
 =?utf-8?B?anNFZzk3dVBma0ZldGNTc0JVQXBrcWZsd2IveC9URnVwbXNRclBqelRTTWI0?=
 =?utf-8?B?enFFTWttRVE3ODlncmVVeHdEemFnQUVITTFkdDFiNU44QzNDUUtBMm0rOGpG?=
 =?utf-8?B?QVd1bk1JMjNDWHA5aDlMZU9BSkJ4T2FaUkFlMHVlL3VQSnVjdlNkWWVKN0Fh?=
 =?utf-8?B?K1lhK0laMldXRXUxS3Bzbmd5cnBGWU9YMUxjTlJMck4rdlV1cVZubHRkUDgz?=
 =?utf-8?B?cDhVSmZQTmR1MGNpL3JxbGFTWkJRREZZTkh1cUlyRUM1UEFmYmtYNm5LdTh1?=
 =?utf-8?B?MWkyOFVJRkpLeXB6cmdsZFVHOHVWUnNlQWhHbTFhZENNYlVwUFVlOVcvZThn?=
 =?utf-8?B?cGM5TWpxTlZOMVpjN1d4ZWlXelRUczN5UjcvMGx5WHZDUzlNMk1jU3NrWndB?=
 =?utf-8?B?WnRFalVRWWkzbjNQVCszTTBGYWM2YzQrUm9TU0pRUkk4Y3RSb2NvZFkrdjhv?=
 =?utf-8?B?emkwWG0xaExZZTU5eEpncy9YRGxmUzNsK3FBVVdjb1RzMnExZVdEd0xkeTA0?=
 =?utf-8?B?alZrY1RHQmhtM21wbnBhU0ZZMThrZC8zWjd5Tzg1emN1QVRoQml0aDY3dmQr?=
 =?utf-8?B?NEpTR253UXlUTnlxY2hYbWdCcGozRGE3VGpLZTMxSnFYUWJvRTc3Z0J4d01L?=
 =?utf-8?B?NjBHaGtTNnJoajFZL1VTYVZhbytVYnRVUS8vWmtsSnVjQlYvZFBoT2FZZWpW?=
 =?utf-8?Q?XduE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d4c156-3ad3-4621-22b4-08dd7b8287fb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:11.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51DobA2FcvidIFhkyHdiqKyAHx5O6u1KT+rsyyMs2UQn/5eRH85/VwfWjE/V82ai2JjYhDP30KjS/DaUv37JdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

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
Frank Li (15):
      platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
      irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
      irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
      dt-bindings: PCI: pci-ep: Add support for iommu-map and msi-map
      irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
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

 Documentation/devicetree/bindings/pci/pci-ep.yaml  |  68 ++++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  82 ++++++++++++
 drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c                  |  90 +++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  48 +++++++
 include/linux/irqdomain.h                          |   7 +
 include/linux/pci-ep-msi.h                         |  28 ++++
 include/linux/pci-epf.h                            |  21 +++
 include/uapi/linux/pcitest.h                       |   1 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++++
 16 files changed, 544 insertions(+), 9 deletions(-)
---
base-commit: a4949bd40778aa9beac77c89e4c6a1da52875c8b
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


