Return-Path: <linux-kselftest+bounces-30139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C6AA7C391
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B0C217D71F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98352222AB;
	Fri,  4 Apr 2025 19:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dh5KooKH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4AD2222A7;
	Fri,  4 Apr 2025 19:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793367; cv=fail; b=TiQJ1nwi21DTgNsB6jBsJ6K20P7WSO96Cq3z0+1G5bokEpyIIwAIclrmRMtH+FjaYgJJ2yAsbMhoWKyzHod89abwbJyJO4wAaGu8RCIHQibWsDIpPfhbjmABxwjeVS3bKUbUalu/QMfotpBnWTipyGO5rs/BLERO0ami2JJU0SE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793367; c=relaxed/simple;
	bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VTX/IfCDmepP8CQlXIxdS2FKDNHlRyoyqQE9nNzqjaTyaySBxRkmyFLTVHFAunFoi6iQUV2DALXEw/cixmWUe9jKf2diaFGig+WPJuYsqvrTKFx+EbKOfZzwdJ1b9SYuJya5OZ8tnDLlpj2YUq/BJpgZxnkOnHy921Kj534cgL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dh5KooKH; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXGSHWr9dap1Blbb13VIoKe+qj6nTiNKx4jReMPFedfukZSM0gIsp3g76RxkxnCQdhBWwckFkTqR4Odpoth2LcXVszHgsAns40tnKWSWxel/pH1ptZHdcsjb9XSLwWTc65f4pn1Mw5LVFQylXHwBOxejxwjf3bfAELToT9xoJUrGO5eRDXz6NnCWJDBVEMnqxCtxFGPyys3KhAY5eirdK6nWxsomxnGHXO/yVtba4A45a4Ilx0N3+IQe99XY3rGVmBlyvsEFbhpuY/NBUeyUpMfD/WV4Abuoy4gINtybdyeorVZpl1g5+qLIs3DP5lCLwbYn+/DTNQ/ZhqD/gxeMUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=VxEHIuqDi8VVQxh0fy/qifMmDfn8vpSczgCu9Ivzs2GQhE8ihVCRqwPZ/P2/QfPiEtbzYuGut2h5PdebUxP3/nhZ+OsLnliyjoniVbLvkOCA+zjWCnINk9p7DGDCF8PdQ9sgmGjRmTd4gu694GTMdv5VLlcjza9Z1+XMOJ2DTEEFns6XxAgqWoh9Tv2V3fJ9U51crp+UReEPGFndMCpo8vmgF2+HX02nX5zUjb+LbJeCviaKfAjUQQUtvHEEhcGrudCfupt8F1IXYw+lsbD4VtnbJw4PXZKIYeLySbkh/EMoLpkgBOwPcLspw6sa/81XhT3t7P/tMGpxOXg+F0n6sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8Qp5FfqRuQHFYCFtVEMJWoCYl4K1g4dfDwvdzdP/uM=;
 b=dh5KooKHMLZVXBloBmvHAEcaHLNZLMFg+8wSVX+40YSsK1xkJUgNgNy/Dl1fGJe7sYbN8+SZf74BFWtPTPc4SGwCv+7MJts0KvEmZ/Wb+UOSpEn+pOe+7VH8+Or/TY2Envk9+2QYqupuRCodGpMCQepQxl3CrlDUA5Tbb9J1IdJqV2FEcVeCv8PVK8I5oLN31Fggu0QJK7D5+ZThJ4v36MHomHZNjvO/4d8GBd0l9n/p6PmzHu1qJxl6JrlvR2ZvZGFFp4LJ/c3VfCyYYEEfWJDlrL73RnBUa+RwG2XD0oVb8FaqLtA5v18MvBNdxSQTWWXqtPwJdDRovQGhjh69dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:42 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:12 -0400
Subject: [PATCH v16 11/15] misc: pci_endpoint_test: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-11-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=6407;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Q75HpsG7AQZeyq/78WIzVSdGpQ6JBJuHxf6b6uNsmfE=;
 b=WRu+IoMWoqtu3189fKogov2fWi5tGK4z5IYCSWXQ5FJbDPnf7uMmz1cXChrqGnA76x3T9eQN8
 uT275y8hRePAeA/BQbFSbTOOJWqHGwnkVoKBDHtSBpY2c4/7S+xykZ+
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
X-MS-Office365-Filtering-Correlation-Id: 59b3342b-4f2e-41d3-69ba-08dd73ab4731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2RRMEgrQzhxclprakI2aS9FN1YyNEY4ZDM1OGNoOWE4bkdJeDRyREtvd1c1?=
 =?utf-8?B?aUY4UWtVMlF4ei9yUEJNeFZYWkhvdzc4Y1gyVFpGZXlBbnNrRnJhdVY2UWt5?=
 =?utf-8?B?NmNwTlZxQ1BXMDFkMmdsdW9peVlJLzM1VHp3cTY2Q3dkQWRGYjJZSnBDcmlk?=
 =?utf-8?B?L3N1dnRlZEJFemQzRjRXZ3BIL0F3M2dGcjRWNmk3R1lUYUdBUnVsbWdLYnhP?=
 =?utf-8?B?eC8wQWZ6c1U3SWlzOU16UmNSM0xKdlBvaU5JMURrMXFGY1JWRDB2TlJGK2Jh?=
 =?utf-8?B?Mzc3SG5mTlZja1VETGN0UmQreW43a3E0N1A5VUYrL0RJMnhtSUZMdmY1WDRQ?=
 =?utf-8?B?NWwwUDl5V3A4S1QwQTl4MVI3QTRlUWpWUFJPRlIxeUp2ZlFjcVU1SHJKcXN3?=
 =?utf-8?B?UTVhNU00RzBWdTVDdy9qN1BsWDZJWW5FbDFMNERLNHJ4YWlXVXpVYjRMK2ZU?=
 =?utf-8?B?S2RTcW9FcktVZG80aGdWZlVuTkY4YnlqOHdtLzFPM0RRK0ZpbWdOS3h4bzYw?=
 =?utf-8?B?RGx2SlEzQ2JQOFd1MkNOQmhuRGJBVFFJOWZFSTFPV2NpeFU5d2NmdkpjblZu?=
 =?utf-8?B?YXluYmVUdUZ0OHJlVzViKzJYSkp5eVM3cnB6QXFFcDd6eWlNano2ZWhzcEVl?=
 =?utf-8?B?cVRYVWMwWHNIYkF1ZEMxak9JT3Q3bWI3dUpFVk9ZWUxrYUgwbTgxZGdFL2ZV?=
 =?utf-8?B?clE0SHg0QVVVUS9rRnJIdE91TXVPMXJTWXB5citqUkZxbUdwZU1XTFRHUlRN?=
 =?utf-8?B?MUNHNS9KSGJyUVkweG1xNTRVNmFWTEJYY2tNRzdQVlFrSVJnc29yVWZmUU5M?=
 =?utf-8?B?TUY2bFZVaENxZnlRWERXMUVoaDVtRENTaGduWHpLaWxHelBzWGp6cEMyVWo3?=
 =?utf-8?B?TTVJU2VlaTBEMGczN1hwOE90NEZJOFZ3UVFKOGFJK2JzSlhDelJta29XczVu?=
 =?utf-8?B?Y3VaZnpOeHlmR3c0c2Z2MDJWV0pSeEdqR1lqa2sybG1BdXNzY0Zmb0VIRk1z?=
 =?utf-8?B?blZLejkzUVB3dndNdVhab0xpL3ozUmo1TzhPNERBZTQyT1VxOE8yci8wbnBN?=
 =?utf-8?B?czJRY0RUS2Q4U3lJRUVaM0NBZG5EVlk5RnBWaHZOQ0VzdGNhejNGSDk2MFpS?=
 =?utf-8?B?M2dHWENFc2xtT3VXakFLajBsRnN5N2N0R3hUWFVVV09qbnEvQzk1dnFOakdp?=
 =?utf-8?B?WEZ5WXpXdXpqZFRrVkFYNlhmRXJabWpnWFRNbjYyOEhvV1FVYjQ3bzJBRVN5?=
 =?utf-8?B?NWFNQWtGVHNkenBJelpsVFdPaDVoeWxMUGxZa3BFVUN6YUxleUtmak1nQVVY?=
 =?utf-8?B?MHdmMzFJZUF5dTYxS3AyaEtpeGhtVDVRM0wyRkdhcUtIcGp3WFBickJUaWo2?=
 =?utf-8?B?YXJ5eFZaOUxJV1RIWW94N2J3TG12NExoTHRuQ3BQMUp3bDBCd25RT0tzYmQ1?=
 =?utf-8?B?Vlo2amFXRU9mcDdiZWJxNDFFOWNBNXQ3Sld3em9OdDhMRlg5cDh5UjQyWCtY?=
 =?utf-8?B?SEFleW80OUoxeEwwcWdZYzBaT09qaGVMREpja0JlT0VIN2tGZ0xRWC9Rd2Rk?=
 =?utf-8?B?UkNnVnBXSHdOM2tuSFlDLzV1NXd5SG9BYkRidS9scWhSOXNNbnJhNGJOMFN4?=
 =?utf-8?B?enFSYmNQRzJEOE0xYVJvejFUMm1CNWJVcGorbUJHK1g0R3UxeVFSZnE1NmFz?=
 =?utf-8?B?dlpmdm9XTUVDUzRsdTA0aFlEZjgrMXN3Qzc4ZHV6MlVGNFVNZG5wY0ZTRi9p?=
 =?utf-8?B?VGhwbXJLQThSYzFBZzliMzFtTklPd2dVcHFSY3hJMDhjU1pxeUJSMW9hU3FJ?=
 =?utf-8?B?REpnajlPY29RWnlOWjRGVEFKS25BcnFzVlBHUTRUR1k3UzlhbWZvdEZjSm5z?=
 =?utf-8?B?SURRN25uRnI0SmwyWTBHeG91REx1RkJhOHNjT0pOVUZVU1JXdUYxSy9ibmQ4?=
 =?utf-8?B?b3ROVE1pY0RvazR0RFBtbGdvTUxJcnhjdEpXZU9RYU9wN3BuQWtjRTVja2dh?=
 =?utf-8?B?VVBGdnFPcEZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW1GcllhUW1pUWtVNjFkcW1EUk43VzhFTC95TytUc1E1dW8yTnhyU29FblMw?=
 =?utf-8?B?MEIwcEtQcVkzQ0dzUHhMWmtoeDZ6Z3ZwT2t6bE9pdHQxdURJcklvZ0V0d0p3?=
 =?utf-8?B?aFRMVFU4aFBJcGRsWFlmTG5rVzRoejd0MFhLNzBGbWY4QXBYREQ4aFFzak93?=
 =?utf-8?B?R0VwZnJJdDNUUWhuOFB5K3VnbVp1b3pmRzZWeHI5MFVCdUdRVW9NeGlnN2pH?=
 =?utf-8?B?UDdlQWplV0FWQ0hUZElnZFV5Z1h3YWlIb1lDclJLVEp1aVJndzhKUDJoUFZt?=
 =?utf-8?B?VjhicnBzUHhyc0FWT1N2dUlaQVBCMkZDUWpXTHBZYTM2anJJeHpjYkpkS3NQ?=
 =?utf-8?B?SjB3ang4NTU2RG5IZFY2a2k0YkM3OFJQMSt4L2JQS2libVlkQmpZMzJBUjdX?=
 =?utf-8?B?S2l2UzNwbmNPNEhDNGk1cWFtZGNzVE01akFscG9zeG1Td0RxRXA2Y1ZnZi9C?=
 =?utf-8?B?cjBrUWhpOWlxSlg2Ym5tVyt5STRWbTVGTU8zQ0JmajlKbEpCbUVuSks5QXNa?=
 =?utf-8?B?RUpnZXlCNW5WazZobWlMaVRNVUlOL3RZUHpGTGI2VUxiRU9qTjRhNnVzRDV2?=
 =?utf-8?B?TFJrTnFiSHAxanRXNFowbTdQa3ZWeTB4WGl1ZVhwYi85dVEvZHlBRGx5WVBa?=
 =?utf-8?B?ZkczbnF0TmFTNDdtK0pvTjlrUnJ6Qis4UzF6UmRJRUtkSis1NWNKajJXRGRv?=
 =?utf-8?B?eFg1Z0ZZTUNYeXg0aFBoMFZnNlp0MUxFa2xtNVdqaDJab3ExTEpVM2FLZ1B3?=
 =?utf-8?B?Rk1sQThOV0c3dXpGb2MwWVh1ZWNTMGtVUzg5TWVjaDc0RmV1R3ZrUG1md0Iz?=
 =?utf-8?B?eExUcUR1RUEybTIvV0FKQUM4ejByVzArRW1jd2xwSFRyN0NrZFNmRUFCSXhZ?=
 =?utf-8?B?MVZqUTZYeTJLTnpxK3NGaDBuNHJTdVhaL1dGNjNqZVlxNGxJNUpORlFmUkF4?=
 =?utf-8?B?VC8rWnVjYVNBbVhzbWwzN2R6QUQraDVpM2NNTmJHaFdoSzFrd3JqSDROcnFO?=
 =?utf-8?B?RnVwRHBFSFBWZXpsTXNSbXBBckpETGVtNW9JcXplL0ZwUUluVkM0VkdFWVBL?=
 =?utf-8?B?NmdhZVc3aU45ZFhUNEwvWDZiemRiaysyL1pwamtYZkFZY2RKUTY4clc1dmZP?=
 =?utf-8?B?Y1NjdmI5K3I3Ym1hWTcxL3ZUWlNlZlN6Y0pBK2U3VUtoUiszTU9RNnBzTEVm?=
 =?utf-8?B?MUdFcmZPcEVhdUU4Um5WMitpMkJSZXBZb1J4UmQ0QzdERDNsdW45NjRRM3FN?=
 =?utf-8?B?aktiOE5maWhPY3VHRjk4V29MNW9DSXdyejZKMEhpYzA0M3hzSUxDVWZKNjVz?=
 =?utf-8?B?dWtiUFhoODgvdnR2d0g2TlpFc2ZTc0tzSEVoOVBFcjVycFRMRUlnWnFaS1pJ?=
 =?utf-8?B?ZUIxSUlFQ2ZuV3huOHR2ZGY0SFpJamd3bUlpRGRQWjY2OGE2OFAxK0xGRm1q?=
 =?utf-8?B?ajU2cnhPS24xNk0yaEw2eUovQ2I5SzJLeDg1MXZqS2lvc21IYytuUmVXZGdQ?=
 =?utf-8?B?UXZmaFdaRmZzSTh0U0ZYQ0hQSzZmZzFkV3NkazViNk93ODZLVlQ1UG9xSlV1?=
 =?utf-8?B?cDc1a0pqZ0o2SG1GVW9tejVaRjB1NXhsMy9GeGtPY2dZWFJhczBndEtkRkJJ?=
 =?utf-8?B?WDRTVHdTR2gzUm01a0VHYjI4eGpKWnowMFJIL09BNEJNRnhGVFBpM1poOXZi?=
 =?utf-8?B?WURUVHJBSm9BcXdrcGNydDZCM2VJejNNL05TcFNYMzBaT1FBL0xXUDZ6cm1y?=
 =?utf-8?B?b3VmZER5UjZMazRlWkpaRDJ1UmhNdXdrWE1NclhQN2czYnNOTGIvWlRUcXdw?=
 =?utf-8?B?aWl2aDJ3WE1Hb0NyNzJ2VU5IUmM0WGdrV054SXVzU2hySjQvZ2QwbkJrZW1l?=
 =?utf-8?B?ZnhVenlVWTdqTjJUUUZ3bzRkalJwbnNoVWM0UW55ZkdDY04wTnNQTGN5UzQv?=
 =?utf-8?B?Ti9kR2Z2bnQyUWVRNllWYThwNThuNWFhV201bHk5WlplOVArNHB0ckI5WnQ1?=
 =?utf-8?B?ZDd0czJUTEUxYmV5RGZoQm80bTlod3Q3SEtnU3VnZmZVak1EaHlqdFhxL3o5?=
 =?utf-8?B?SlZGK1VMTFNnOUlhNVNrQlJTTnVUOUlGRVkvcmxaeGtqZWpoQXhNUEZ2NTdF?=
 =?utf-8?Q?JuNY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b3342b-4f2e-41d3-69ba-08dd73ab4731
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:42.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mcV7vY9bP5MX1PD1CCnSmdfY2uJ6y7GpZ3EjqTVvjgqPjEQSx/i4GmAfA06GeXOsKXFbcnG60PW/yiNrw6Ojw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

Add three registers: PCIE_ENDPOINT_TEST_DB_BAR, PCIE_ENDPOINT_TEST_DB_ADDR,
and PCIE_ENDPOINT_TEST_DB_DATA.

Trigger the doorbell by writing data from PCI_ENDPOINT_TEST_DB_DATA to the
address provided by PCI_ENDPOINT_TEST_DB_OFFSET and wait for endpoint
feedback.

Add two command to COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL
to enable EP side's doorbell support and avoid compatible problem, which
host side driver miss-match with endpoint side function driver. See below
table:

		Host side new driver	Host side old driver
EP: new driver		S			F
EP: old driver		F			F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- none

Change from v13 to v14
- update to use pci_endpoint_test -f pcie_ep_doorbell
- change ioctrl id to fix conflict

Change from v9 to v13
- none

Change from v8 to v9
- change PCITEST_DOORBELL to 0xa

Change form v6 to v8
- none

Change from v5 to v6
- %s/PCI_ENDPOINT_TEST_DB_ADDR/PCI_ENDPOINT_TEST_DB_OFFSET/g

Change from v4 to v5
- remove unused varible
- add irq_type at pci_endpoint_test_doorbell();

change from v3 to v4
- Add COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- Remove new DID requirement.
---
 drivers/misc/pci_endpoint_test.c | 82 ++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/pcitest.h     |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index c4e5e2c977be2..0f3af7adea107 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -37,6 +37,8 @@
 #define COMMAND_READ				BIT(3)
 #define COMMAND_WRITE				BIT(4)
 #define COMMAND_COPY				BIT(5)
+#define COMMAND_ENABLE_DOORBELL			BIT(6)
+#define COMMAND_DISABLE_DOORBELL		BIT(7)
 
 #define PCI_ENDPOINT_TEST_STATUS		0x8
 #define STATUS_READ_SUCCESS			BIT(0)
@@ -48,6 +50,11 @@
 #define STATUS_IRQ_RAISED			BIT(6)
 #define STATUS_SRC_ADDR_INVALID			BIT(7)
 #define STATUS_DST_ADDR_INVALID			BIT(8)
+#define STATUS_DOORBELL_SUCCESS			BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS		BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL		BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS		BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL		BIT(13)
 
 #define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0x0c
 #define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
@@ -62,6 +69,7 @@
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
 #define PCI_ENDPOINT_TEST_FLAGS			0x2c
+
 #define FLAG_USE_DMA				BIT(0)
 
 #define PCI_ENDPOINT_TEST_CAPS			0x30
@@ -70,6 +78,10 @@
 #define CAP_MSIX				BIT(2)
 #define CAP_INTX				BIT(3)
 
+#define PCI_ENDPOINT_TEST_DB_BAR		0x34
+#define PCI_ENDPOINT_TEST_DB_OFFSET		0x38
+#define PCI_ENDPOINT_TEST_DB_DATA		0x3c
+
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
 #define PCI_DEVICE_ID_TI_J7200			0xb00f
 #define PCI_DEVICE_ID_TI_AM64			0xb010
@@ -100,6 +112,7 @@ enum pci_barno {
 	BAR_3,
 	BAR_4,
 	BAR_5,
+	NO_BAR = -1,
 };
 
 struct pci_endpoint_test {
@@ -841,6 +854,72 @@ static int pci_endpoint_test_set_irq(struct pci_endpoint_test *test,
 	return 0;
 }
 
+static int pci_endpoint_test_doorbell(struct pci_endpoint_test *test)
+{
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	int irq_type = test->irq_type;
+	enum pci_barno bar;
+	u32 data, status;
+	u32 addr;
+
+	if (irq_type < PCITEST_IRQ_TYPE_INTX ||
+	    irq_type > PCITEST_IRQ_TYPE_MSIX) {
+		dev_err(dev, "Invalid IRQ type option\n");
+		return -EINVAL;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_ENABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (status & STATUS_DOORBELL_ENABLE_FAIL) {
+		dev_err(dev, "Failed to enable doorbell\n");
+		return -EINVAL;
+	}
+
+	data = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_DATA);
+	addr = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_OFFSET);
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_TYPE, irq_type);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_IRQ_NUMBER, 1);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS, 0);
+
+	bar = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_DB_BAR);
+
+	writel(data, test->bar[bar] + addr);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		dev_err(dev, "Endpoint have not received Doorbell\n");
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_DISABLE_DOORBELL);
+
+	wait_for_completion_timeout(&test->irq_raised, msecs_to_jiffies(1000));
+
+	status |= pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+
+	if (status & STATUS_DOORBELL_DISABLE_FAIL) {
+		dev_err(dev, "Failed to disable doorbell\n");
+		return -EINVAL;
+	}
+
+	if (!(status & STATUS_DOORBELL_SUCCESS))
+		return -EINVAL;
+
+	return 0;
+}
+
 static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 				    unsigned long arg)
 {
@@ -891,6 +970,9 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	case PCITEST_CLEAR_IRQ:
 		ret = pci_endpoint_test_clear_irq(test);
 		break;
+	case PCITEST_DOORBELL:
+		ret = pci_endpoint_test_doorbell(test);
+		break;
 	}
 
 ret:
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
index d3aa8715a525e..d6023a45a9d03 100644
--- a/include/uapi/linux/pcitest.h
+++ b/include/uapi/linux/pcitest.h
@@ -21,6 +21,7 @@
 #define PCITEST_SET_IRQTYPE	_IOW('P', 0x8, int)
 #define PCITEST_GET_IRQTYPE	_IO('P', 0x9)
 #define PCITEST_BARS		_IO('P', 0xa)
+#define PCITEST_DOORBELL	_IO('P', 0xb)
 #define PCITEST_CLEAR_IRQ	_IO('P', 0x10)
 
 #define PCITEST_IRQ_TYPE_UNDEFINED	-1

-- 
2.34.1


