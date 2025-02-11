Return-Path: <linux-kselftest+bounces-26422-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73903A3152B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D2D167CCE
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EF82641F4;
	Tue, 11 Feb 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXZxEF0y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2066.outbound.protection.outlook.com [40.107.103.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA50269CE4;
	Tue, 11 Feb 2025 19:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301834; cv=fail; b=irJFebC/7KwaJ7SMg2otfD9HS2rvUjXG8zAcjRpUZsLEVhRVyFHf8vgv5CqyOuZq2N5/3cDIt3sMd2LeZ0HiWbWetVcWsTdj40z6HOp8SNBAhQH03cwo8bJ4hF1gCD4iqWM4nIr2zXlz0WgAGT2bb/Wmjt0Sd3OIRIuyGK8NMZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301834; c=relaxed/simple;
	bh=/Am32Cb4LR9m5sdE8hZXjCLAvZmQBoGFz0xYkefhaso=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kiz3avjhmRmWmSnjuCSdLUNKFaCl0W4khiVvwibH5gJEQxgH8plWAVrKFpuqrkLrhzidPf3tNzA3myvRpfGRbuK9mq1ktV2v0oB4LtKF4Z/D2VPfUnsV11bRg+4lr0u2LOjIbRdSj15UTOcWVQu+ovIcFgN5RAtkMT2wHd+nEIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mXZxEF0y; arc=fail smtp.client-ip=40.107.103.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQ6Wnb7piScLcVrf2Gewd2BThrXjZVcAHyUmhV2QyZTfAP6jQtd/PnBj/w9D5nY1pv2yzgrWU6j2fqVyrqCXO1TwIDOvZWIAdZy2d1X7a8HyReespqx4G/cu8Zlylyml5uShXws1vGYfatFPOT70gimaTphueZQB0QpcvrRtU6mqmTl8uJu8YPeTj/bQuDpKX4e9Zz6dL0iKQCp0P8vc8AMbMajCVgY/zyRF8LCpCWZemsnSMw+2cRyRxGNGy5egPatIuykhnboAVYmMOeDncwdtyHoa3EG0X/5xEaCkKpFGmNdHHJmmCxEjMDJ3FoNSeCiccj/XmY0GMz72LwVZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IaqiL723p30GuEXndHKFCNUemmHlnG1W3Hy1qscAf4Q=;
 b=DGmFTQPkfN/5prgoH6anjn5t+RaKwiDvzG9Q9H76wMBqwRGo7Y1KgV3bC5mi/ZYJYgTvyQCqCWO6tR9oQAF4bTtvyhyWisccjfXNwjzrKpiSetihZp6++yoW+xbc02yYShoWZDjGRskFg/1Ywcjx/6aZtFffFynefskMtn8OKQYUHVeq6Vn1AoVGZ5EN/7iqiOdhfdSGcwvcqjDsvC4REF7AWpg/C4DEy6ZX9beNL+O2C6t7b43VBbOhbIpPpzpbesGm9xbw/ViSXlo0jWVF9Daa6qafkl7gLNioR+1gro6IeDihYOlPQRijCw8a8ht8EQn64/dpU+iUXeo7LtNsmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IaqiL723p30GuEXndHKFCNUemmHlnG1W3Hy1qscAf4Q=;
 b=mXZxEF0yt+dhN8SmB+Vk6ETKFbYu8zOkBEVuerXTbeVF6RuWlbnVWbMXsh2cb8l+gxAPdhKjUc8hDxJIa+Lkg7xZykFnVkwM+Z0CRWGuCvOw/vO79WTC70ZIjFf2Wd/VxW6eenazZUDmxzdxRq9y7yDn0gb4/PA2xw+hx8jKOGcRfoyU0GfIe2pGoCtKv7P3qGQuOmWwR87WBxEmd7t3zaV32hGFF66buWewodcL8RnbSBX6GwfeUeuU0Vh/AzaR4fiIb915T+Yw9+RN+uYQ/M8hKsL38+By2s7IBpXDjjp+U88VpkAEwtA+5Zi2C5jvTx5q5Q4sb+1dJZqH4BHUoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8553.eurprd04.prod.outlook.com (2603:10a6:20b:434::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 19:23:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:06 -0500
Subject: [PATCH v15 13/15] pci: imx6: Add LUT setting for MSI/IOMMU in
 Endpoint mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-13-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1486;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/Am32Cb4LR9m5sdE8hZXjCLAvZmQBoGFz0xYkefhaso=;
 b=IExdP3F/6T0Ilshr1UkOkXPzMpUBcPI4JkzpmE+pZFJrbNjO/SSXTyMmHIckuhYRaygKXjPRQ
 4rjVJ3L/lmUAi9BYmWtYbirREplfxGK/bGufeHXedJAoBoNvk2yKei4
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: fbe69a3e-c4e1-45b9-202c-08dd4ad19cbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXAvcWhiNVpmbWRBSG5OT2lKb0MwZUp4NTc2dXc2b05ZQldOMHNLRmZzRXhW?=
 =?utf-8?B?WUFHNWJmakpRMWdZdUN5QWtVZVVsbVVQOGZXYVJpdVlSbWRnakhkMng0MEtk?=
 =?utf-8?B?N09SbjZFb0lMVlNWQ3FMTC9LU242OFQ1VjZ3dHUyK25VbWw3K09CU3FyRUNT?=
 =?utf-8?B?ck8xbXducDRXanprN2h4ZXB1Nk55TVVQa0tUMEQ5QnphU0o1Z0VpakpIeDhX?=
 =?utf-8?B?cDNwNmdzU0VlY3BLU0E4dDJYM0EveDFhczU5bFZaT015bTBWMkNmTUQ1MDB2?=
 =?utf-8?B?Z2QyeVhKS0JTTVBBVllxN1h2cUY2QTFlOXVYOEpmNk1WM3M1VVgwWkVIS0Vo?=
 =?utf-8?B?YVRwaThPeTk0Q09aM0t5Q0xSdjdZdnNhYkdzM3lXQXJHaEJJdmpmWXdFK3Zy?=
 =?utf-8?B?YmZldGlVT3I0V3lyb2UvSkpkL2ZkOUpnWEFOajFLeEVud1hqZElvbFVWYndX?=
 =?utf-8?B?Y0FVSVVOaHVhdksyYUhNUytrRkhuSXdZcHBjZzh2eWMvTlFWTFpnTDlsY29i?=
 =?utf-8?B?TjhHTkx5S0xFKzlwNi9qQmRZZHE2YW9KamRWbXY5TFZZb0tqLzVoaTNROFBp?=
 =?utf-8?B?RWRJbVFoSnBCc0NPempNd3hLUHRPN3lvNStyNERBck4zc2lzQk00N2pqUUUy?=
 =?utf-8?B?SjJSY3NsTkk2cDUwRXhTVjdxSTFPbDVzcTdXaHA5bmZxeEJGSVNsSHA1Wi9J?=
 =?utf-8?B?a1RiWHFFSzl4ZGxHT0RBZW5hS2d5dXJPdWZsY1BWRXd3L3N5L3F1dzdGaHlL?=
 =?utf-8?B?VVpDeklVMjFWUDZlL2pMR2R0UVRCQk9IVGtUR0E0bHllQVJLdEI1TGxvYXNF?=
 =?utf-8?B?NE5FTTlWUXVJZ1BHNTF6dkYwVHpUZG4waDF4MkxkV3NGaEdWMUNHNG5oaDZY?=
 =?utf-8?B?TnIrc2xMSllrazUvRXk0Z0lrQ0lwSUtjUWVFTjRhMW5GdElYMWV4ZVJxWXVW?=
 =?utf-8?B?S1Q1eDgrR3J5cmZDZUtHeFpWWlAvMXdueGxOeTVXejMvcVVNQ3BXclI2enBu?=
 =?utf-8?B?TElxSUY2S3g1c0ZIb2owM1IrSWN1Mk04ZFlKVDRzWTFOMXZCUnBtbHRmL3dx?=
 =?utf-8?B?bSsyV2ZXdWpVUkF6ejJwQXNGNnpDaEJRTkhHTzR0RnF4cmdUMkJDbjcvbWx5?=
 =?utf-8?B?MjZibkhGV0QvL2RhNXovdUlDUXJTT3dqd1ZDc1piWWVndE5lYmxaUUdCaTBz?=
 =?utf-8?B?K3MwaTQ5Vm9CdTZ4Zmdnczk0ZWtoMktBVmFXVU9wUXArQ1FKWnNOWndzZmFJ?=
 =?utf-8?B?RkxQNXBtMWIxR1RDNkYwL1RhWkFkdnZRTXVCZmswdUNNQ3lJTHU0c3VVdzJJ?=
 =?utf-8?B?NVZhdGdGbG5BNVlXQXVUdm5xNHdHNWpBOENhRVZ6ZEE5Z1EvWEMrWUdQMHI3?=
 =?utf-8?B?UDZ1Qm53Z1FpR0RPR3pkaHN2QmE1amYvYjJYanN6dW1iNnhUVnBUTjRtY2Jr?=
 =?utf-8?B?SW5aa1pUYXRSdkRIUmYrYW1RaXNXQ2NUd2NrdG1ERTBKOHRRUVM0MWFaTnEv?=
 =?utf-8?B?eEMwdHNhZmsrbnRUd0trMklmbHRNWlp2ZXlJM1NJb3pZMFNTQzVrWE9KMHcv?=
 =?utf-8?B?VUhGS0twRktibzRhZUZ4Y0ZnWGJEVVdlK05zTkhuMTBRZW5EUno3VWhQTUJL?=
 =?utf-8?B?bXBIQ2JHb2VuZVd1b2M0ZmN1WndQZ0lhODRka2p1T2tmN08yaExVQnpDVVVM?=
 =?utf-8?B?cThiajBqWk15R0x4R2dpYjZKcmxxV1NyWnRPeXQydmdXZ2t1bTNoRXBFd0Ez?=
 =?utf-8?B?U3lkbjRqcVd2aXlTcXNhdmNlQ1FSZ1lqeWg5SXhjdmFsOXczZ1ZrM09ObkZy?=
 =?utf-8?B?SjFaUDllc25lZlMza0RBcElzQzZhUVpJbi82enJJamNLZXlxRy95WmRjNk5D?=
 =?utf-8?B?L2ZaRmZSRk52dUgwZzk3eVhGTWNVc1RacncvS3hFTWZQYVlRdW83dFZIZnJh?=
 =?utf-8?B?dmlPbzM3RXRvR3NMYXl6TFY0NGhlMmpSSEhrOUtYMlUrazRvLzY1RlMzbFJX?=
 =?utf-8?B?L1JjVVkyQnZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXJ2ekQ4L0dhSDF3U1hXZDZuNjdydno5emlmN1RlYjQxSHd0ZkMwUlc4ME91?=
 =?utf-8?B?QTZOQXkzTG4rYTBHQWh4Z3h5Y1F2TFh2VjhrQU9QdFdWdTF0ZkE1Vmc4MXo4?=
 =?utf-8?B?VnQ3b28yemVZcEpqeFB0WmR3Q090S21NeU5MbHB2aVE3cVF2SGtnd1VJZUtz?=
 =?utf-8?B?SGFPRHY0aG90YzVIWHhkNU1RN3dOTTNaTWltZFMzY1ZDTWY3U0M3Z1pqNHFR?=
 =?utf-8?B?bXJxZFJtU0pPOHVIZzE4MEZZbTdIVTNDQjBpOTZ6UEtlQjg1dTdnRXR5VDBv?=
 =?utf-8?B?VFJYeStYL2tDUnBEQVBUM3NRVGpTUURjWDZIS1YwSysxTnJNNWdETTFhbVVy?=
 =?utf-8?B?TlNaZGRidGNuUGUwMzN5d0Y0bzBIa1BQbUFZYitmTnl1eE1kY3p2cnRNTDZJ?=
 =?utf-8?B?OEdjNnl2d2NySEhDdHpLNEp0S09IMXZNdGZNQlFwVXQ5a0paZU1oYjFlb1RV?=
 =?utf-8?B?eU9NUjkxS0JteEVUbXFFUS90dFhyTnhPclQ1bVEyK2FRVGxzVEwwN09xKzc1?=
 =?utf-8?B?RVhkMVIrQWZoVy9NcityYXE4Q2NRT256djE5UTBQdkdEaW9BTlpodHV1NnN1?=
 =?utf-8?B?a3hVWDd3aXM4QUY1QXNWNXIzZXAyRXZ6eGFFVDlHMy9BUDVoaW5XOEhEL3Nv?=
 =?utf-8?B?OVo5cThzcmhQb1FSY0tNWkM2aEFzdVM3bjZpTmNUb2NYVGYvRVdsU1dURVV4?=
 =?utf-8?B?TUR6elQ1MTRpQW41amsva1JncldsdGozdzhacWxaKy9HcnYrTkxubjV2TzNE?=
 =?utf-8?B?dFh6UE9CMXlzTVJoSEFpaGh1QkpEZGRIeURLYkxaUXB6SlR3ZGtWMm1GbXg0?=
 =?utf-8?B?cWNweEt0amFXbjViL0xQRUp3TmlXVkl1NkJDaHRVbWRjbjM0NlBPR1l3Z3Q0?=
 =?utf-8?B?ak0rTXNYMmdlbUI1QmJRZGczM1BmaHdTOGE0ZDQ2UHpRWVVEVnhUUlN0N0Zu?=
 =?utf-8?B?Nnlrc0RRL0t0aXpTaHdIZlJ5eVE2Zm4xbWFidk01RkFxK01INUh6ZExWVUhh?=
 =?utf-8?B?ZVozcVM2MkoyUjdCOWFCZWtpTlNhY2tITHIwMXhIMGhOb1RTUzJOcWtOSWRN?=
 =?utf-8?B?KzJIdEZNcEJFcEp5aEhrQ3ZTZnhzb3o5KzQ4djl3M3JRaHRnYm5PaHdaWkI4?=
 =?utf-8?B?dk1QOXBTT1NJeVY3T0Rvb0pubGdwL1NuNTl3N2ZwNlFlOWg5SFFPbFJ3MXBF?=
 =?utf-8?B?Uy8xR2dmcEJwWk9yaFgrVzhHdCtuQ2UraTljRU04UEdwOUJndU5qQVo0OEFu?=
 =?utf-8?B?VVR5QWwxa1g1MDFIRjllU0lSZTNXZVlKT2NaUE1NM1hNOFhKaG9sMzg2NHZB?=
 =?utf-8?B?MXIzVjlBaTEvWHF0N01uaHduWldzMmQzWUtVQlFWcmE3U1czMFAwUmdhV0lX?=
 =?utf-8?B?SjJtZFdyWGw2RXdoMlVkV1NHN0t3S1BpeWxhSkFjTXZQLzlON0NzamR3MTdR?=
 =?utf-8?B?d3h2TGdhR3Qwc1I1VVdFQ01ZT09yUHoyWTU3ZjFoczhueGNHQXFmNFBJUnh4?=
 =?utf-8?B?L0JMVldDTy9FRjAzQ1ozYjByWlhTV3pCc24xL0orMUtkeUExWFV1eDM5T08z?=
 =?utf-8?B?K01OWTZGelI4OVVkVjJtTW1UT1VONDJCRG40RWRzek1oQktaWnAzajlVY1pP?=
 =?utf-8?B?S1FHcFVGQXpBdUh2eXJPb1J0ZC9XMWE5R3JHREpubVdscXpGTURRcVplZUtP?=
 =?utf-8?B?MkRFWGJWLzkvMG1NTWlkL0I3MmUybjNQZWVrQUNSZ1dGZGU3RXBRN21lYUhs?=
 =?utf-8?B?SHNzT2E4UStrOERWNHJFS0x5VTV5V3BpcElrRzRFTWR2aStGTnVRdEJZODli?=
 =?utf-8?B?NThyNFArZEFOUUpzY0dUcHROYTdVMithY1ZJSUgrbUVUc3Npa3Z5TlVaVEho?=
 =?utf-8?B?VTZqNHpNODVmK1h3M21mWU1zY1h5VjlldHlIZExMekk1eDF1eXB2Y2lrNXRi?=
 =?utf-8?B?MlJCdUMyVzBGWUkzRVNHeGg4bUpWRDNVbEdaNnVyK1FqbERJVzl1S0NyZlJX?=
 =?utf-8?B?VGVxZmkvTVFwY05jcXJHTDBqaVBZaGpLTHV6c2tFSUtMNVkzZWt1OEJnS0dS?=
 =?utf-8?B?dzBGL3JKZFBWbjNkVTJwV2U1cVZlaVRTN05aOVdhYW1BbkN0YVBaYnM4N09T?=
 =?utf-8?Q?ftzuF+RBpJ9bUC5TBc90aGxsN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe69a3e-c4e1-45b9-202c-08dd4ad19cbd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:49.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xbtx8an5z92aBF1LUXUw7g6akgzJNEQGsNnGUAzdejGyCtRWFF1SrrmwftaoxiPndbkLvCkvcUlfDZTcCNrGNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8553

Support only one physical function, so call imx_pcie_add_lut_by_rid(0)
to add a single LUT entry when operating in EP mode.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e20d91988c718..adcca3e644332 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -995,7 +995,10 @@ static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
 	data1 |= IMX95_PE0_LUT_VLD;
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
 
-	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
+	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		data2 = 0x7; /* EP side's RID from RC, only 'D' is meansful */
+	else
+		data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
 	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
 	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
 
@@ -1652,6 +1655,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
 			return ret;
+
+		/* Only support one physical function */
+		imx_pcie_add_lut_by_rid(imx_pcie, 0);
 	} else {
 		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);

-- 
2.34.1


