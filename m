Return-Path: <linux-kselftest+bounces-30747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F74AA88B33
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6297F17B84F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9928F51E;
	Mon, 14 Apr 2025 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QsL3ZzVw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE728BAB8;
	Mon, 14 Apr 2025 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655496; cv=fail; b=sOR6KWiTfgzHyTS/Qg7Q7wuHKT+LzbzD882WFRUWeIFiDHnSMcmY+C8Euutkyk3GidEgnG8elqCXkPnDeQ15ACGxq1e05ETxdoz6w+5CiC5issunP+q7n7LNnpuIWlcp+l6h6vRMZ+2tepimwYhHdqso34CjmsB6IBK6jG1K4w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655496; c=relaxed/simple;
	bh=nuOSilx0xFIrmQ7q/FNnVVZ6I8tKFEDBakFZ9GZOgfU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=kw94FQd2TDK4qpSpN/0g8t2c/N9AmZIGmC79c8A/Ow4/MuxgVQrf2bk+vZidI9US6no2mHhLfKnsYMVEkB97I1ZcRGkKrxI9VaYDe6iM5WoP4rYOlEaXJ0yni7fUc5B3MbNao6gut747pQ1pgZIVroew7tjb3hLU+WPZtm5x09s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QsL3ZzVw; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pA+ahjOy8tdzwoTpJL3SOoCBSzAky2qmTYXegezQNtZwpOK9vf4xCvvhYZHEPr6dMo4bJUQZ04r/ePncQXN1O4VvuPOXMNGfC332P8nYXn567j1FX1TpOTmP7yHr0Cr0OANJM/niAMt8f2RyJRw7qv3HyFdl7luUfIuoi2C4jyBb+6rE1PIYzTWjsPNUakUlA9AetYv10Plr32gKyIQFGAbr2VP/vTQxRt3+mM3O7lzjp4fI5kj7Yv8dqRcabIxSkOK5DEt+3VsAPv7zPvb89fKAz4aeaKgtMwoEuf1ekU3ATW3a9znev3Ec11E3P5fID3dB7YMCakBZZTujpjoPrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wvzvkawi1c4jyl+gIIApohWSfi73eTZ55zDdwaLFIxs=;
 b=Y4NvCpw3FcJE2JyhIkNqM8vRQIrYPN+/L5kiq+x5y6eV84fatwiWdqo3WZ0DVWfLrI+Oh2hZo04KAZbW3N+BR8QKecumziA4uoz+MzcpGpoj5jcJv96T/kKGPqu2BrzqbCmaZnu2Qoejx8afk8E7p8M/xDqTSPT21chJeKePWahg5+/tihStUZaFUElnnCQWsiLDY3X3ytd6g+J6sIwavNDaHQRzREvpc5TL3LKsiLxrfJR7kU2n6aCrNUSW6M1gsmKqlesj1Yxda0tPNrsPhL87OCiB9Imb9cMpr2+FbKJVNHPz7PPaoe2tr/JvKlLspB222ZM3G18eBMk6nQB4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wvzvkawi1c4jyl+gIIApohWSfi73eTZ55zDdwaLFIxs=;
 b=QsL3ZzVw7RmSlT+gSzqs8f44xrQ2Lbj5F1N5vJ58FwOkf3jOnynUIvVXdRhzKhwYzrsVYGxGNQnUS1QT5ZH34U/a9xuMXJ40V76TiUfGfWB61lcDlTqu9mOZ+GhtC24g6lXeHvDumw8gSsxdm2sYYcbREyFKebaXMuDt6Z6AFZqVhCohv/G0uDRdMP38SoE9HkpDhEYjIrSM+IrroQcVQ/tiXypr6alst1bpJVAqO+lqUQlcV7rL1C463wd4nOJ0XJx0ckrFAKGI7GBIU4NnOHFRVGzv3KUQEc92sORErNtO98AS5/NSp6Ei2BOdVMHxBqPv3BIMbGRB8559Qnbhvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:31:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:31:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:30:57 -0400
Subject: [PATCH v18 03/15] irqchip/gic-v3-its: Set
 IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-3-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
In-Reply-To: <20250414-ep-msi-v18-0-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1326;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=nuOSilx0xFIrmQ7q/FNnVVZ6I8tKFEDBakFZ9GZOgfU=;
 b=Sf3sB4dNtQXzD6YOQ/pD2JzOx9fmBiQs2IKGY+ml+bOjPCgQffdjprNSwFJm5w3h4IOo1oixG
 if00czfRb1xBDqZdF0OQzvT1EQ/Fx9VosA/N+o609bYhGNwNpHTByM7
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
X-MS-Office365-Filtering-Correlation-Id: b2fd5c6d-699c-4e01-f6bb-08dd7b82937b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjNDUWFodEd4Z1lCNWVnQkVid1hLTVJsVE5YVEdpOXNWVXc0dFlqclhGTTR0?=
 =?utf-8?B?R1FvMGNHeHJPTnZUK1NvekFLRGVSZTNZcTFWTVBJV0hicHRKa3NFdldXRHZl?=
 =?utf-8?B?SEVMRlRuV3BIWnYwUHEzSjZkMWF4elJVeG9Cb2o4TjAvY0NQNGd5TU1Ydmp2?=
 =?utf-8?B?YTdHRzJCM004TWJpQ2l3MndTRnpUd05iMmIzSTZWVmdSYzByMkZHL0oxT1c0?=
 =?utf-8?B?aFMyVldJNm9rcHlCZWRTcDlOZkl3RWE5bjJKaEdndmJkazVHWXo0NnVUU0pO?=
 =?utf-8?B?YWdUNjNZZGtucEJkZUFObllEdmZpUG1aMmE3U0tBczY4dEg0cGs1dVRmaXBK?=
 =?utf-8?B?dzR5NzlWYStWN1ZDN3ZpdjcrQXlwcitVdzZ5WWxYZVo1dnZpSDlLOTluS3Q2?=
 =?utf-8?B?ZTluUyt4ajdLV1daNWc1Z1dtWFRFYnprbStYaG4wa2xvekJrREgvMHNNTFZs?=
 =?utf-8?B?TXcxejF2NStTOW5Rck45UXBNNTNWMjljTGw4ZndWTTRwdjZRVWlzOHBJYjN6?=
 =?utf-8?B?Q2Y2bUpPbmlxOVlreXNaQnEwNVQ4SDNpZHBOaEJyZ1MwL0xWMGRZVGwreTc2?=
 =?utf-8?B?dmxsYlVqdWllK2ZCYlljdEgwdTlvMVcwcFpkZkxLWE1GdHNYS1FUdWo3Zm50?=
 =?utf-8?B?TnZsRnFmRHpMTVcrRzQvU00xeFJ4QUl1RWNxVXduM3R4TVpJR0MwcHdsZkhL?=
 =?utf-8?B?MHlnL3EzMGJXTkRpYTRUMnFrcW1iRkJJa29pVFVYOTI2d3JKbFRFaURpSVRn?=
 =?utf-8?B?Mi9GQURFaEt3N0VyTjh5SlpGRC9WMXA3bzI4VlFQVjJPZnVvNXRsdlZobTR4?=
 =?utf-8?B?RVp5TkRBRUtwRmFLVXdyQzZwcE9jQ3pUVWdTU3JmalIvdGwzV1V0aW4wTlRF?=
 =?utf-8?B?MmVjTldlRUtUcXFwVUx1UEF2VGwyaUdmSHVnYnE4RmlUWDE4UkdEK0NQcXdL?=
 =?utf-8?B?aThXUnRmREpJVWlWSmtiekdsMDBVSytGVHh2NHN5RDRrNlM5MlBCT0ZNSzNk?=
 =?utf-8?B?M2JIVjBkN2NxaVJGUTcwWkE2NVMxbHNZeTZ1ZEh4OHFQV3VRMEEycjdlOGVN?=
 =?utf-8?B?Y0tLUWtyRFVlR25jT0licTMwMzdNUUl0OEFsS08yRFVZZllGWXpGeHhncGIw?=
 =?utf-8?B?OE5uSkZadnFVa2FKZW5xbUFCSm1GeXl5V1RjaUJpWGhQcFdHaUhSMktOZTk0?=
 =?utf-8?B?MmxNcXNETUtFdDNrcWxwV3pzNG1DYUs1Q0VPeUgzNzFlMU5RTXVPR2FJeHhM?=
 =?utf-8?B?SXpZUVFxa1Y0NGtRQjlBcnQvMkc0Y0tSc2R5cXVBL1l6QzZoTFQydFZIQndy?=
 =?utf-8?B?Z2pJZytzZDExNFhQbWFhWW1mRUdtcVQ2VjV1RkhzUmZLbTJ1TTkzZndOb0dJ?=
 =?utf-8?B?cHBERFhSN054cGo5cUdMTnpmbmRjOTZ1TDdTejVsZkxQYnNVVU0yTHdBWE9R?=
 =?utf-8?B?QVpGOXE3ajZIYW11S0ZwNTdaMk5pSUd5dnFyakg4SGkwbWJaajJZZFFGZlVS?=
 =?utf-8?B?WjFMaDM3YzFsMnRXMDBQd0wrcjlybERwUkJFUGJCdHZhRDVGZnV0bzZRV2hH?=
 =?utf-8?B?YnJVV1RtR0ovejU5NTJOaTNiTXgvM2Z0eEM1TVc3VTJFT1NVa0dGK0xNa2dI?=
 =?utf-8?B?eDF1cjBtelprOXlzT3VlaVhCYmgrWmt4MS9VNWs3Q0hKcVFWS2s2bTNoam9I?=
 =?utf-8?B?eG9WQnM4eXZoRGpob2p6MjZNdStJK1FJNVJXYzJpUXFjQlRybXlVeTVvbkx2?=
 =?utf-8?B?WEVHZHRvVjBPajI4NHUzK3BRZTRzekEyKzMvWDFsbGxzeStYU1FVeWowZE9y?=
 =?utf-8?B?dk9ZRVZ6U2dzTkpPV1czWlBiM0VsRXZmUWc3ZE96eWpRZjU2U0czWFB6aG5L?=
 =?utf-8?B?RDQ0aVB3am9ObW5EK2lsYmY0S0RNNEtMZjhwK21oUjlJUzcrOXhoN04xeWdJ?=
 =?utf-8?B?ZXk1d2hOcDlmTE1OaWZEUlRlVXAzZU8zYUJXaW9CdGFOc3cyU3JVUzYvV2Rl?=
 =?utf-8?B?NERsK29HWVNIVFFtbTd4MnpBQW1MZTk1SHoraXRCdGNrMmNkN1pLT25YMyt6?=
 =?utf-8?Q?wElMbd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHZFQjZ1TStDakFab2N3d1hNbXUwdWtLSzZUOW1SOUJNQUR6ekN1ZDF6dWtt?=
 =?utf-8?B?Vlk1M0hqNVNablA0RHZIMERCUDJqYTlCUTN3UEtTMEUrVi9NTU9QTU1zeFAy?=
 =?utf-8?B?ejNHMTRVbVQ5L1F1dkVwQTdGWnNrSTJtRTRxbERtMEhwS0lkSm0yV0lHNTRw?=
 =?utf-8?B?cFhnMTRmYXMyd3ZsejYyN0FyYzdBQWxlQVo1bWlxRXFMc3RWSHl6RTlGM1Nu?=
 =?utf-8?B?b1NWdkVRSEJnTEZ1SnNkelJGcWtVdmk1aVhJY0tyUm9TcVA4TGdHbXQ2NGw0?=
 =?utf-8?B?RVY5dTNrenFRWWcwM2VaazBFMldPUkNRdWF3NHA4bm80bjIrSzdiM093UlZ5?=
 =?utf-8?B?TzIreHpDaG1ueklocCticXJzd2I1cC9TVmxPUGliVitkbC9idWdrS0Zua2FZ?=
 =?utf-8?B?eFRRR3dYQmJxdlJFazROeWZrVVhTbmo5MTJINExOOWVYVE50WnNkRHhaRVMw?=
 =?utf-8?B?UmtPYmVHUUhRUmVDTExISS81ZDV6YTJNWTFMc1RWN3lLdjljZWdsY1p3NTJD?=
 =?utf-8?B?NGNMZFVoR2pUbFMxREtqSTlkVEg2b2FsYU8zUnMwMitXK0tCWWtNRlZqRUM1?=
 =?utf-8?B?Rkw0bEFCM0ZNcEZrY2wyV2tMakxUbmtqSjdmRHJtSWpQRUxKa094akROWVJ3?=
 =?utf-8?B?R2Q5T2RZYkpqTU5tZFlzb2NKb1hnQXh0L0Z3S2w3YVlodmQ3dUVjcEtMOHpG?=
 =?utf-8?B?ZTUvRWpEem5kYVV4U3JHaTF1eWNBMmxRU1B4OHBma1ZELzlvRjc0Y1c2azVz?=
 =?utf-8?B?eVdJSURDYytpTlorZEk3L2dlaXZORjNhdldVS2VSNm8zbytlbk5ONUZrcnFO?=
 =?utf-8?B?dW5Pb3ZBLzR2cXpyeCt0ZzlmZjVlNGd3YWNURnp3RlFCTm50SFo3OUQ4dGR5?=
 =?utf-8?B?NDRNRDB6V3lCN3VKYjUxa3A2Ym8wc2E0SHVFS0FSRmx4ZGh3OWE3ZlZQZk5n?=
 =?utf-8?B?dmdldmpBTmllTnFTV2ZLMUdFYWdhTVpFc3Q5aGtndzVFU0xDSlczODhCekM0?=
 =?utf-8?B?WTNrenhuNDBZR3poMnNEdldQNW1FR0d4SXNUcVJWeTVBRDE4a0ljWWlmcEdZ?=
 =?utf-8?B?cjFlcEJtK25LVGdKWVVjRG5BNlBDQmNmN2cvWENCb21maDZBaDkyUHB2cEdx?=
 =?utf-8?B?NEJBODY4bjhNbzVheXV2UW5Tdi9jbEdadFNBRDlpVjg2VXoyOU1Lb2g5TTFR?=
 =?utf-8?B?Wkt1UmYyRWhxSnBHc2o2aHBTdnRwS3JUa0U0RjJlRmk1Rzg3VEhhSm9JQUN0?=
 =?utf-8?B?V2t1djhLZC9JOGlOaWwxNjFCV1k0eDYwcU9WWXhSY0dFQUlNd1RMV1VwbmxD?=
 =?utf-8?B?OTNBSE85KytrM2p1dncyeU5hSHVqM2dRdWtFVnF4eE01Q2svU1J2eFVheVQx?=
 =?utf-8?B?bUh4YXIzc1hsaWc4MXl1eUhRYnFzM1ZrKzJuNk9sd1RMZnR0eGNlcmdON3BJ?=
 =?utf-8?B?b0orbms2SitJZWZSOWVZT2YvQjZodmZzdmVja3JaVkdaaXA0K2lGQ252dkwx?=
 =?utf-8?B?VVBHYkVKMWNXUXdpOTNQOFZaTXNvS0hpbUZsdkdwelVKZ2ZiaXpIWG9PeWkw?=
 =?utf-8?B?ZkhCcGhYQlo0WFV2SURROXU3dUxiNmhNSVdWd2dwVU52YTY4WTlGdkV4Z1BG?=
 =?utf-8?B?R0tiVmhXZzVRajErMFJFWVZUdVljV1JDWHVudmZEMmtsK2N2Mi9nYnlPMjZr?=
 =?utf-8?B?cWQzZ0N3cEhmKzRXR0hvNTRpQ3pqU2R6cW40ZmYvamhQNWxtUVhLOE1Vb0NQ?=
 =?utf-8?B?RTBkOFVFYjJxYTdXRWdNVGh0eVlFSjhsT29yV3h3NnVaSmZMcjA0Wm8xUVly?=
 =?utf-8?B?Y0FMU3dZZDZZVkVRUkJEZjVtbEVLdklsR3VaT1NyMEtMUGRwLzdlY250WmZL?=
 =?utf-8?B?ZTFhZk9HOEtYSFFidExFL21PNWRRcXNoZEtrMk1xVFlVdjFKY0Q1eU4wRjU1?=
 =?utf-8?B?dk1rUG5GVk9jSHBuY3loZzVuTC8yckY0TzRyY2NRT3hvN3hVZnB6Ry85d2ox?=
 =?utf-8?B?VmlMZDNiTkNoWElhZWlid1UyNi9zWVdOYVhhZUZqdGtaSHQ0ZGlDUUhZMW4z?=
 =?utf-8?B?ZTk4KzN2NjJCRDZtMDlKSGhuT0ZNd0FlR0p3RFBmMHF1R0N6enA1bWF5amVS?=
 =?utf-8?Q?wh1I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fd5c6d-699c-4e01-f6bb-08dd7b82937b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:31:30.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6G8zmK8LlzYita6zHavyv46RY9CxFhM15povE8Ov0ZijMBrWHu/RQjtZ7LanX1HkPznPd3PsLo9o+1dqFajlCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

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


