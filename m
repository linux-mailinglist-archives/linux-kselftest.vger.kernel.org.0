Return-Path: <linux-kselftest+bounces-30313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE97A7EE25
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB991895325
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E937255240;
	Mon,  7 Apr 2025 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cHQ+Kjx5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289852561A2;
	Mon,  7 Apr 2025 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055526; cv=fail; b=QvMzVqmh4tF/SGW5/Tb5wf0SOsw3zs8u5fcvusvsPrvVTzVUcyvYqZLBPfWumlVF740NwciPzid7ozpdHpNZaKrhTCXroXCm6emgohiQzdG8K//cl+wWSET5O8DY9C8cp5LnqPcNng0JSvMggIf2wj3r8QH4a/vDw7cBgIqW+io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055526; c=relaxed/simple;
	bh=Mp2cXn9FsMWsG/hvucQeIBBPPQdjWFLzH+Ukbq7aPzU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rLA2R85qtatc9Yeba0WZcK0CPUmGbLu2tYdTtyFy9YlJ+Bj6TWS0MCoqt4EUScMO2sEmJKbuBw1wBlwcpFYn5ePWg1IABvQDGNSX4TInlW0gu4l6llbzqP6RjJvqlztnTlU7quTfDmJkx+u2WexeLsNSLkXNQahM54tCis2lZOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cHQ+Kjx5; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=advJ3Yt4aIL43uXKbCX7tf9efx+fMZdo9UJ0KEVNDqZwUl7g9lmWfen3yTqFHHlWBlE1AvcS5d4Xa0NNz2fUGaGnmbeiazLAcjJZdU4Jbq9XcjDdhvU0ZrhwQf0bK5zTHxXte48jVTPde82L7bDn/nmPiie64YmItkrBZU61eO2v4xNEhvprVROwpQKGHG/Iz7F11QjDBZe1FX+B6sDAOiH7iQJfTk1tGlEajzqdBC3YTluXwfsOp6PckyvmN4BebGh2P4StC3tdSH1vCGuA8gx9cxepaRdK9XOey7ksPEBeW/eRls24Pi8zfdFq8X9IP621iqVFl6wUm868bt0qAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+qwraQmG61cZxMtmXO5VrRkCys/e7X2Bx0RuL0d/hk=;
 b=cDTzUP7CwAnCIPv/7OsFKYWt29fFa+mMTP79GX6j5uqctvx5+Bc6kwzAJxs9T0PC6tqigJgOaLPQHfj4Ov1uG2CsYVllTnwTqvSKnD/RAaRzecManOaRe2v53lcPhUdUZcPOmLS0vPrsnXqIPv4ukTiRdUoiJ++WhbG9HlS957nFOma9PASM43jF+6rX8COqhfkkzw3wRPUrFINVs0Cx0ZQl+bdlTWDNIwWEViLtY5TVxhDsWvt3rZ9APRrQUCrB6UYuOwMTDlO1bdjmSYav6y4kV6ce4vHGSMQGq1jR9KbAJ5raJV16SkDk30CkpvKUPUsKA7cCqch5AE5ZBeWqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+qwraQmG61cZxMtmXO5VrRkCys/e7X2Bx0RuL0d/hk=;
 b=cHQ+Kjx5xgcsntn83ZBrKhVchIaok/IcdZmqb8BsL26uDtc5tz8PYhcHTLqXssd/2eLBxCMUuOs4E6/5x7YyKv4Iqv+2fOmwM/sBedjG69yHP8Z4s6Rc+7tmIL1WBxJeMQYUMsRXQpA4Eqcj1X2AFnQkQR2vlYaiYZxYpFRSCbpz0cOseyfhW6Vt83Z4ERqE4QEgY3FugyLnD5golgAII4HgWspRasbOfmLgAs8cT9MmWbsW/r9VPCNZL556U084/874d4XD/qJM+gFXjtVLoqDPOaXEq7pMOBqNHZS5PAI2v7LrPnVrsCGPXtPnmBd5sii2mHqBNFl4Pu/M/3pHvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:52:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:52:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:59 -0400
Subject: [PATCH v17 09/15] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-9-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=4364;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Mp2cXn9FsMWsG/hvucQeIBBPPQdjWFLzH+Ukbq7aPzU=;
 b=bu7W0Gd7iqvfen6lNHjsKxdp4mp6yDtX2bwdge7ROfaPPW3yvQyRvV0mGPIi04ZeV+9fRgK0Q
 eSIsYrSQT8vDiX6Mgvl4YU3pnHhzoGuo8obByiuVlODe8X8CtMmjymt
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
X-MS-Office365-Filtering-Correlation-Id: 078c17ba-dc83-469d-6514-08dd760da9e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWdwazQrU05GUElMeDAybEZoQlJFTEhLNUlwOTh2ZDR1WEo4RHFSVHJ3VVpB?=
 =?utf-8?B?RUJCMlFFYmZzenUwNExPdjY5OXVVZ1RRWmszdkRmaFJQZFFXTkY2MTRaL283?=
 =?utf-8?B?T25qQ3IvOUV5WjhmbDRrUkdRV3J1a3htMXdvc0ExS1BLYjlhVys2RXVuVksy?=
 =?utf-8?B?VUQ2bTlnMk1VR3B3WW9rSjZybVVvOTUreGw0bmcxL01JbjBxaFZBNUJSaFBN?=
 =?utf-8?B?WnEvdXR1ajFGSTBwNC9MWmJaWjRRVlRtb3dVRWl6cmlhcVI2QzRqTWk1RVVN?=
 =?utf-8?B?NTVCdkt6dnFXWElGZ3o0aVpsb1hxR201YmVzaWNCNGFJclBmanZhTHltUmQy?=
 =?utf-8?B?UUovSC9CNmxocWdtNzNibFJVcEZCaEV2OVczdDN1ZURlM0tHcHJvVllycDdr?=
 =?utf-8?B?c0ZwU2d4NUY2aWErT0dhNVZ1UnhNQVF0Z25DOStkMEZpVCsrVmNPNHk3eEhi?=
 =?utf-8?B?MVFVWHFBN3VLZTRXWlV0RnFHRjNPTDFYOEtDSHVNRk9LUnhWaVFYRExuN2R6?=
 =?utf-8?B?TlpDMnprdW93YWdXcEdVZzE2Z2k3TG5ScUVBOGsxckg2MzRHZVVFNk5VcHcv?=
 =?utf-8?B?bW5aUEI3Skt5S2hSQzdSaE1sUjhrTTAxREw2c0hkcGdwcHArdVd6M2tTbGho?=
 =?utf-8?B?UmpQczl1UEdma052ZlphZVZlUmMvZDBzMlAwUGYzZERDOFIyMnJMbk9SQVdH?=
 =?utf-8?B?S1ByN2lMZmJJRVdwakYzdmc3Q1pOd1lDSGdsa0FlaHBlWXVKS2F1RmZHeHdz?=
 =?utf-8?B?T3crR2JPb1lKQVhCb3NHTDF0bU93cmNFcUNEVlB4RFJObDhkdHlxSG9WdC90?=
 =?utf-8?B?akh1WnAyRi8vYmhTVU1PWVU4cXJ4MFBibTdsa1FuVVYxZXBTVTdWc1BmcjlP?=
 =?utf-8?B?S3JhdmRtOURSazYxMnJTQ0l0UmtUbGZydXFTdTZqSVArTTZBbUlzWmdtaGsy?=
 =?utf-8?B?VmpxS0ZodkhUNm54YVdldUhsUTA1azJDTXgvYU5rUXZxUmZtK3BjemhDYXdw?=
 =?utf-8?B?VTlHTFE3ZmZ6LzZYSnVnUldKRUxjc1F0cHo5VUoxR2pBNTRRNEp4NGhOVUlE?=
 =?utf-8?B?NEgxenpaWDFiM0pxOWloTWNBQ3BCdW53VjYvbzNvZUg0dDczanM2MTBqQU9k?=
 =?utf-8?B?WHowM016WmVOaEJsbUt5TkdPWEEvUXluT2FSc3U5ckhPN25WNlJ2VjB4ajFu?=
 =?utf-8?B?ZGZ4dk1LR3A0V05SUlMzWHdRY2NDcTIrV1UwWWNUZEwrR3JZMjRVWExIQW15?=
 =?utf-8?B?Q2hjUVBhVmtRbDNXNHNlTE9PTGJDNUxXOUVzKzRkSnRhNjZqWmcvdGVRZ25h?=
 =?utf-8?B?N2J5eE44T0NyN3JjTFFLbitXRmpSRnBWZWJGSVV1a3YzN1RBZ0dOaDQ3UCtk?=
 =?utf-8?B?OWdaYnhOWmdxdVlKTEh6TnlZM0hkVituS0F6VnE4Z1hMeXBsU1FTcUI1ek84?=
 =?utf-8?B?eVByZmo1TXZtaXlLbm9NRXhCd1cyd3lFeXZ0S2ZyREU5MXdmVWVEdzlYTGs2?=
 =?utf-8?B?ZTNhWVFkbTM1bFZFbXJGT2FIQTF5TXRoSmxjVDY0R3hVSlp3MEh2YTBHMkdt?=
 =?utf-8?B?MlM3S2RUWmEzM3Z5MWxrQnV6ZnUwVnZ4b3VBQk9IRDl6ZWVSbUxZb0dQcGJ6?=
 =?utf-8?B?U0RaSTIrYmpXa0haWW84d3J3dnJMU0pXa2FsVzNKcUtRZkFQTkcwY01JeWxM?=
 =?utf-8?B?VDdRcmFMeWxZbTIzQ29EY01UbXFtZENsazgwWWhlQ1QvV3dnK0h0NE5zdVdv?=
 =?utf-8?B?OGxDTkJLWm5lVHVHQjQ5SzE3UlF0ajZmTmJ1K29XMldad3lGWGdsM1pPU3h0?=
 =?utf-8?B?Z2VSMHArbUZhQ1ZIQkp4Sm02T2Z0d2FiMlNUVnJnL0pmR1NTczNNampTNVNQ?=
 =?utf-8?B?S1JwNHprQlpsV1IyUWVzNGdVQzBWa3ZxYlVnci95WFozd3FZUEljSTh0MjlR?=
 =?utf-8?B?SDRlc01mdTNMTVZ0YTVLcmRNZlZLL0R5RTZmU3BVRUU1aVozMjhRYjJ3R2ky?=
 =?utf-8?B?TlUzeXdPSE9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnE1VFNQMVpQbmo1d0xiWTd5NzVkWUtURGJzZnBERXI1UlZ6N3VMcDNMTjlZ?=
 =?utf-8?B?WjZMTXp5MVVBUW1VSlUyQW8xNll6cFlZNEQyQ2VoMVNZL0p1cElCVlRvNHFz?=
 =?utf-8?B?N3piRC9YUTlYR0hZdmUwOG1HbGF0eTU0RDBWLzRTbllyVWluMkpvTE9hNGtZ?=
 =?utf-8?B?N1Jnc2VrUEYwajh0Nm9nMmtSZkhTczFYeEw2T2pKYjg3MC9KcSt2OWtyS256?=
 =?utf-8?B?eEE2enpNRUxveTMzUWg1c1o5S1dMOXM0MndnMHN0cXNKUWlmdTRLMGR6bDFC?=
 =?utf-8?B?SmNsWVhzVlIxSDFFZTlycUlBbGhCdS8wM1pGNEJVcCtiMTgyMEYxSE9mbjJt?=
 =?utf-8?B?cVJpcUNZbUtlcEdCYURUSDdFdWQyMFdUeHBjTXFIZFQ1c3U5Z3dTWklGSXY2?=
 =?utf-8?B?SGVEUEdFa0I0R2ZKbk5rZDlBVFNPcTRVRGloQlVGNkZuUFlqVEhpckhwQ0VB?=
 =?utf-8?B?dFR1elRWZExBZUNiL0RPUWhTUW1Cbk5IQkhvRmZ3ZlFUYXVNSUh1VlpTcU1p?=
 =?utf-8?B?TlR5WWJhbklHd2lnbGNTUkxOZlRPMUdTRzVMb3U2U0pKRzhrdHViYTZTeW9Z?=
 =?utf-8?B?WGNJalVFMGdHeVdJWmlJTlZCeVpmalhnRFY3TkJJNXJRd2x0VWMyRXFFUkFz?=
 =?utf-8?B?Q3FwTUxEZ1dFdFUzeUxqQnYzM0tjVnY1OGJKRzd6Uk02Sy8yZGFtUzdzcTBt?=
 =?utf-8?B?Ym1WV3hORExrTGErNm0yUjdWMmpnaE0zd2lMbGt1OGZQcjMzenhSMVpWQlNj?=
 =?utf-8?B?dnc0bnRLOEdJQ3gzSGw0Nm9oR25oT3JUTjR4Y21xWGRqd1ZLSGZjdUREMEMx?=
 =?utf-8?B?VlEyelBpWEExbTl3MWx5V2MwSXZVTyt3aFptaEEvOUt6dnhIcTVObnFxSEt6?=
 =?utf-8?B?RHNqZWl2SnhrYlhzZ05NajdCNCsza0RkT25DK0F5L2lRdDhlTzJYS0JOYXdy?=
 =?utf-8?B?d2JNSUdQMFhKczhwSjlPR2ZvcXpVSFZrR1lUekh4eTV4YVZwRkRvYXVoTHpT?=
 =?utf-8?B?eDNld2t5SVFJTG1MUjRRenBsZkNhdHMraVo5K2RyT1dmZjhtVUxXbFdOOU9K?=
 =?utf-8?B?WGRnMnJpVjJsZHczN0FGbzBFY3RNekdLUjdIMmJVZzdNZ0tzUmpSaElERnVq?=
 =?utf-8?B?Nk5zODhuNTRlT2tyd3dQQ3VvLzZHbW9ZQVk0bnVYaWNMVFZhMDI4RFU2YjJt?=
 =?utf-8?B?L0huR0dDTGJocGNHYVVIL21jTURFRlRQWTNPbTVWeHlzZWNYMU5mQzZwcFg2?=
 =?utf-8?B?Y0hQRkhyejh5b1NONENtZ3JEbFJpTndkMHpGaWUxNHZMa1VUQm5ERlBZN0Y0?=
 =?utf-8?B?UnA3cEpWQzZ4MktDZEtWNExHUkdZZG91REcrVUlOdmd6TWZhbHJxMlZQNklQ?=
 =?utf-8?B?YXg1d29IZmtiOGo4U2ZwNGtGd3lvQ0xmRFM0aWJPeEcyczBCRFNVOUYwb3RS?=
 =?utf-8?B?RDUyRHAzNm4rbzFtNTlOd1paSDg2NGpsaUEvMzF5K084UzB4QkU4WHJuM0J1?=
 =?utf-8?B?cnZiMlQ5OU1ITzFsU1EreGtCMndTb2VsMzNuMnAwTmV1VDJLeHBieUNtQklz?=
 =?utf-8?B?Q2o4VlRYVWdUdHRJK2h2Nk9KOXJNY1hVR0pIaXA4Nk1MSG9mRFIyeEF4OHg1?=
 =?utf-8?B?WUJyK3dpRE9mQjh0aUQ5L3RuRFZESXkvcmxtZ3N6a2VkQ3NIQ1NNRVNQWGdu?=
 =?utf-8?B?dm9KNFZjRWJIdXN0UkRlemdlNHFpRjRjUi9mMVptTDdiZnBFcWk3RUNHMVhY?=
 =?utf-8?B?VVhrUlRZMXNraFJBYTUyZW9CUnc2WFM3V0dMSUxueFFueW5SQklsRUwwMlBQ?=
 =?utf-8?B?WVp6Z0ZzQjUzKzBJR3hXaFR1VjRyUmtnN0I5L2wrZ2djcCtHMFRpWWJlWWhp?=
 =?utf-8?B?QlpsU2oxYU5sUVRIQ3VWTXhRUzhUUG9tbE1jazYxNy9VNlQwbkVGL0pMTHgv?=
 =?utf-8?B?WHF6TTlKNWRNeEd6L0svdzZzWHlPblZWMjFQMVlWVzJ4OXpWZGRFcGM3MjZR?=
 =?utf-8?B?RXo2NndhKzVyUHB5cksreXRnbk8zSHZyRFJjMkZXVWViSFNUM3ZoNitPWUZU?=
 =?utf-8?B?Sjc4Z0Rwc2YxbEVwUCtreTh6bjRiVS8zdVgvcFpXcEo1ZEYwR1lra0RlTXdN?=
 =?utf-8?Q?vUMCbliyLnTLZNnAPNkTGR3o2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078c17ba-dc83-469d-6514-08dd760da9e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:52:01.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TgXSQ8t8/IAczhTv+Iwzk4f8MJvh3wAiL3Q7bWDhP9jFXE+iYJE7g+jh5WJ69yDQIouZoDwS3gvc3DjetwLy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v15 to v16
- none

Change from v14 to v15
- change out address type to dma_addr_t to fix below build issue

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
>> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     726 |                                          &epf_test->db_bar.phys_addr, &offset);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          dma_addr_t * {aka unsigned int *}
   In file included from include/linux/pci-epc.h:12,

Change form v9 to v14
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index d04224b8e1631..529dbaaf76750 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -473,6 +473,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index dcc6e2a2c6b3c..299ce1f1e2d80 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -241,6 +241,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


