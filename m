Return-Path: <linux-kselftest+bounces-30310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90867A7EE4C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AD54432BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63662550AC;
	Mon,  7 Apr 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lgd+DL1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E78254B09;
	Mon,  7 Apr 2025 19:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055510; cv=fail; b=tJZAiZof0w8kWK2zws1rW7pBjEECZHxw5KytAXlqb4VTsKE2R1TIZpR8M3s181ADd3cUOKiSTa+A6sQA/VyCvqmGlbTvpfuAXmqm3xBxl5ZdrOhH7+qnsr7EQxGIiq7vnLA21iGvkvvxdt5ClbPU58UG/1PxQDW7bNUmOYB27c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055510; c=relaxed/simple;
	bh=1rniyVcGag0eNeLrwWvT+jPUnbYZckhT5xHhMRAAH+k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MRvT6mfKo03HFI7RjqHV2ETL89X99+/eZ2tYFZQ+37bYUJa5kEjyReCyXQqV5iMaVsybdcbtyZp2PLdAqeU4JmtV1gVFkqqaUGXDrQioFXnMf8qGCSuJcEnGquY//iyBfqiWRQXgoT8t7CZPGfb5MU3bQKqfETcDOASsfcuE3Oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lgd+DL1I; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wu4Nu5YIArSDixcJzNK77ajacM9iKsF/0xJdXaFTlWojHuyn7H+b3iAWG0YVMxNrVRhoymdw9Ac0MD/8bRn0mZBF1/U8Q9zYGdNI+s3Nbd/XMueiYsP8w6ZVR2jvLGUw9jkXP/ShwasRIvcoQKI8o8EYxAifF21pAwcvYpbtHz3h2FaAK2yro3/2/bq6b/Js+VI62uRYKPbA94xZnanx+fq6jtn1JV3T/KeAjbI9/nWMvSV25EXfftdiErTB5fjyPoUmlCNWTcK8fttrJaj162FPL1xAZl44xzi54yHJH+aHfeFGboPIMjzBsCAa9XfwKwlaGnQa2iVW7bnyXKBJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CV43Lv9xcy4k1Ss3c5nbEs7m6Hdf2yF4V9lxFdIqHso=;
 b=KkN32I93RiEQqzyFzyMqXgi6N5PNkOCiIec3xE+XZ6tM4LB+i3FhstnpueRr3ya8/f7fGfgVVheEd25UIKU+yKHDYMfyu6xteDmfmTf+RaHxURLvRCIhKsrDHwG9nQBmpkqk2ibdA6lF+AChTfx9aQM+K8nYmfrGvtdA/ZNu5EPrUlefspNamIfUaaOdeUCr0l316eeXFmmmKBMRHYGLkepjtLNj9ROKXnFhED4tO6iIiyLRCSwTB1KfZ6VOF6+qPD2rJh+oS9wk1ZiQ8z99NyGMMX5jcfPdR26h8KcBuiqJuZT61yA1vAAnYFuwRfVtySmYmx9jw8q4DIegmR24Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CV43Lv9xcy4k1Ss3c5nbEs7m6Hdf2yF4V9lxFdIqHso=;
 b=lgd+DL1I3cmTAal+0GMwGW8WvSOM6d+yiMEGEjhtj7qbPv8xKllnGTK3O8pr8UX4GlK3epw9szU3MHqY7wN+RUYyLkqqmqiqp5DF/rMn8iLYpPBhR7WwH9aSSGOP6Jj+zSIjxBdVZYih5CQalk5tqL7lHveBwBzuH7don7wIccyZUKRInKsA9XPUmiXQYHvoAQs9ZpVr7Y3VXZUJXNzdzOZn1T4ruKfreGecpqTAHrM6JrGxWXD4zNlvtXPtaj9v2d029HpsgvWdqU7/CJbn8hG6i79J5HzswyDIP4Csm3NP74z6/r5ROs72mCzSAm/P7U1037U+WcJh22t0/oZVoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:56 -0400
Subject: [PATCH v17 06/15] PCI: endpoint: Set ID and of_node for function
 driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-6-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=2203;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1rniyVcGag0eNeLrwWvT+jPUnbYZckhT5xHhMRAAH+k=;
 b=0wbGcuTZJV1FBhS/OROYoVZ/OFMxs94KHXJjBaeh9UE+WAlsijRXB6h7zVmvDOcbitJ+zIiT+
 3B0wZaq8YHiAl2SbduxHs040S9lAWwMRYkGu/Wu5/kEkb1KAL5FTnvj
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
X-MS-Office365-Filtering-Correlation-Id: 6c4de032-8c27-4160-fc33-08dd760da066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWlUTlU4YU9nVTdIcjYwRWVRZ3pNbCt2czNjSmxXTFlOVyt0cENTV0IwcUpF?=
 =?utf-8?B?aHp4TWdBY3YxU3drVXF1WS9TY21aN2ZJV1RHczFSZ2E1VjZqb3FpMXdEakN0?=
 =?utf-8?B?QmZEbHAxdk03VDJVeUFsNEdVZllUWG96RXhqMk5UTkN5K1l1Wm5ZV1YzNkFq?=
 =?utf-8?B?eTVOam1jTmVHOHh1d2d4YzMwWjd0UHRlWnpReUdUdTBqZmpIdzV0ejVhMzZs?=
 =?utf-8?B?U1cyamg0d2xMWkR6bGhKcDcvNnRodFNVMnU3cUN4alBHZGNkdjQ0TTJwa1Z1?=
 =?utf-8?B?K1hGWHdPekdlRUpaTzNwR3B0aEVWdjdVTFMzNUJjSjcvcmp6SnFYaThNOWVw?=
 =?utf-8?B?dXZoQ1BlbHQ4R0lwc1E2M25kRTRpZkw0c1RBc1JHZ0FXM1JXNGhyWVl3Y2ZQ?=
 =?utf-8?B?RlkrWHd1ZENqWGlYWnQyV1FlUUZLeFJEL0ZJZUR5aDRxenRpbjExT1ExT2M0?=
 =?utf-8?B?bWJNK1lOM2p3U0tSSityM2tJWGNNbzBpbzUxL1Q3b0pQWmg5WnFWNk9aSUts?=
 =?utf-8?B?cDg4OFZ1ZEF3ckdCNWYrakdzVUVQZVpFZWRoT091QUttUVlpYVlhTU80OHNN?=
 =?utf-8?B?SHBEeXRvaXJJdUVIdFFTU2Z4WEppU3ZrUm50SXQvc0NRcTNFdWR4Yi9QWnVR?=
 =?utf-8?B?MHlZWlEwZE5hK3djcEh2QllzM2JWbFUvd2E4R3Q3QnN2MW1WVWNHYUVkUDBQ?=
 =?utf-8?B?Vzh2YXJEV3hZRWFocFRuUERKQWxiVWJwMERRYm9vRHk1dEhXbFlwM1BtQlZU?=
 =?utf-8?B?dnZ2cnA3ZnJzV2Q0blB3WHc0N0dGRFRReVI3elp1ZnhpUERNeDBKRFRzVE55?=
 =?utf-8?B?UkhLOXdJalE3SlBDTnVpZkpiMmI5WUdvNWNTTkh1bHM1OC9Bc1NsVWtwNklH?=
 =?utf-8?B?bllWNzZJdXl2aWhvZGEvUWhVVVJLanlrUVpuYXZGTXd1Zis2MWErdUswRi9N?=
 =?utf-8?B?TmgwNDBpeHVNLytUT3FRQkpwaUFUSXJYN2QwWXYyODJSL1J1ZmlUQUJ5dTVW?=
 =?utf-8?B?WWxaZXA4dngrU2lUMllGY0pEMGlQOTNpeFBUbnNaTXZhZG02NjRKRVp5MDJ2?=
 =?utf-8?B?R1dzSTBSQlBjR2xwL2pnRGtWM2h0ZmNLRys4MGx2eG8wSWJhMVVPT1JTRlE4?=
 =?utf-8?B?OHk2QmI0Y0NPYXNvVkxoUUMvTnZqVkNjYUMwSlR1NDZGWjFCTTZZQ3liZ2Jp?=
 =?utf-8?B?NXVBVEp2QUVlQyt5TnRLMGJwTnpyZlRDdGVvdzBuTm9yTFM0YlRFdTFsQzVP?=
 =?utf-8?B?ejFGblVLNnlqdTBUTE5BdkJhL0Q0VEpaU2Z2V0w1ZElUSUVEVHJUbWwzcm9p?=
 =?utf-8?B?L0tieng3czk0UGFkL1ZyNUFQWnJtSHM1N2lrMEFVRVFmRWNvMWNvMUtrVlZ2?=
 =?utf-8?B?dzF6V1ZzbVZZcnUweXdlOTlCOSt0Y0QwdlRVMjlqUzhZU3MrNXJqb2lzeHhn?=
 =?utf-8?B?L2tDRWFPYlJYVmwyWXlMQ1hoSjhBNXJQUkxpMmRJSFc5TDRrWjJ5MEg1b2Z5?=
 =?utf-8?B?YlFBYU9oaFcrTFhTNTBVYytkb3JJV3MweXVDUUMwdEcxUGhPNkdjVXJJTmhB?=
 =?utf-8?B?emhJejdUdHR2bjE1K052dG5BUUFpL2ZYclM2MjUxRXNsZmNUMC9tb3dQWjRT?=
 =?utf-8?B?WVMvV2ViSjJaM28zTFZBem9zVHhydXZxTUY5aW5IaWNRL2hLUEZYN1N2Nitm?=
 =?utf-8?B?aHRNRUtZZy9FNHF1WnIxaGE4eGhQWTN0OStwcTE3Qk5WOGMyQzRmTWM3eW44?=
 =?utf-8?B?TGVlbzRzWUFTa1pHZjRDVk9ic1Q0dGNDdGQ0dTJaT21PSjlScGI4ajE3dmdu?=
 =?utf-8?B?a04yMUd4QnAxN1k1aTRnQUEvL3IyTW4yYjlBbkhYQm00VVNFUWFIVlc3M3FS?=
 =?utf-8?B?aXVVY0Zvd3hwNnBBa1A1MFZPVmdiNmJRL3BRaXFqUDBVcHVsekV1TVZQQW41?=
 =?utf-8?B?VVkvdVI5TGx6V0Zlb2Z5L01leUJhSi9BQXRSc0JWbXZzQkVEaDR2RlRia0Zx?=
 =?utf-8?B?Y3NUZjdncmZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0ZsL3lJeURtRmdJZm5SeGlJSkIxb2RIVWltTm4yWTRLekpMK2JmL3g3QUY2?=
 =?utf-8?B?OEZLVmlXdXdCR0ZuZEVEbDlMa1g4UTBzamNLQjRWSVJ0bmtKdkJhNXJnNzFM?=
 =?utf-8?B?RmZiaklZekNOSjBvY2ZDOGtZUmtNZklxZkZreU9ITlBnVmpQM0ZhOXg3NW93?=
 =?utf-8?B?RkxvNzZhOWpSZ0FGOG13d3VVdjBFMVp2bTY2dWhZTGhoQ2l6eTdNRHZmejVE?=
 =?utf-8?B?eGpocm9WbHRGanV4SVFyK3duekw4bmJNaktzVVFETnNhWDJtVkY1bDdLc1do?=
 =?utf-8?B?VlVFb2x6UjVvZnpDb25KNHFIdk4zZWdsNERqbFUwNGFwRnVyMzRDN200aXdU?=
 =?utf-8?B?Y28wMEYrTmxqeGVQODVqSWhURGdkYjFBY21LK0o0WWNYYzc5TVpMZ0pZd3Uz?=
 =?utf-8?B?Lzk4bHNCQko4ZEIyVjhycU43ZHFVeVM1RUNIeTRlMTB2ejZOcEVEcEVvZTJh?=
 =?utf-8?B?TFNqY1l4QWlrdXdzejBWdkVjSzRyU241Wk1seVFWSVZmMlNmd014Y3NEVmNu?=
 =?utf-8?B?NTJxVjFrWHFTalV4OXZOb2lEd0hpeXBZRXNyNlN0WkpYWFFSSkFqbWJDYVJy?=
 =?utf-8?B?bGFRR3RiU291cVpFc0FiS29xSHdJeWVZdGtGdExnMkRjVW44ZzVGVHlWcVI0?=
 =?utf-8?B?TitVNVRDVTMyNFJoWnlJYmg3THp2U1lsenVDNE03WFMva1JIM3F3bGJOWkxE?=
 =?utf-8?B?OG8zd2h6VTRJbWpObFBva3dORW05cERCUHIwUU56bC9sblhJK2lCWDZnKytM?=
 =?utf-8?B?WHhMWk4rVlRXSkhER014c2U4Wm15bGJvTm9pZGFPbmNjZjRNdDBPV0h5dHp5?=
 =?utf-8?B?TU9xbVM0RVhjRHUvVkt6QU5VeHgzMVpCUGd6OU04QWloNUVvbDJXc2dPZVQr?=
 =?utf-8?B?U1Fma2cvOUJBK2NLbkJvVFN0YzYzWGhBU09RS1c5ZlZ1Ym85cGl4SjlKZVND?=
 =?utf-8?B?eGowdjFmTml1SXNFOU02TUo2SDlTMWgzaU1VNVJVdzR4V2x5SktObnEzUlRG?=
 =?utf-8?B?ZytKOEdFVStxWVYxdHZwKzNCTUZYemZldk5kYXBpUUdMSEk5bGh6Y292bGwy?=
 =?utf-8?B?cjkzYlRvQmpDblhlS0N0TnNabmx1U2dpdDJjNWZTeXRLNFJCeHJTcmdQaWdF?=
 =?utf-8?B?QjVremlUV0U1WjZmMmFTUytrSUoyY0ltV3Z6L0w0UXhLZHpWWGdNdmFoN1NT?=
 =?utf-8?B?WlUvT0VURnd0NXVmeitrcEJ0NitCSm5ZSDRmb3pBR0FrbFpiaElCZ3greTl4?=
 =?utf-8?B?ZnBQbjhQMG5oeE5Za3BqZGxodzBOQXlTZHRDOVBWY0xSaUdwL0NRM3JUc2Jx?=
 =?utf-8?B?aDdwVnNmVzNGWjF6ZElSTGhHTElEa2hpNUpWaWRVcmZEVmw5NCtCOGluK1Z4?=
 =?utf-8?B?bTBqcEFpVGFZYXVjdXF2eHRzNGcvWVMzcDNtZktlVmhHWm9WUGlHOVBrenlB?=
 =?utf-8?B?UFFRWWVVWERUYnBUejlMTGF5RlJUcVAxeDlTaVJmWDQxMU1mZiswV2ZNdG53?=
 =?utf-8?B?QVNaVE9WTERlZXBBTEhRclNOOURZcS9NZGJhcUJYR3FRY3JSQzlpaTVtdm8w?=
 =?utf-8?B?RElvS2hRNHpMWmo3UnRLdVBqRWhQVGVJRmlaMElBMmkzc3lHWTBPMWEzMG9T?=
 =?utf-8?B?Y0dSUWJNL3JyT3FnT3FnRUMzRVdkOWFRVHBUUjNlQnoyNTNqM2s0UzdCZ1h4?=
 =?utf-8?B?L0N5OXlVRU1yVlJnRHp5ME84TTF2OUZNTlM4dnM2MTRQUnFFbyt2dFRzdGhU?=
 =?utf-8?B?Um1ZaVBTVEh1SVR1M3VRbkt1dXN3VFcyV3J3eW9XeVhCQWp0cEcrMlhaajFw?=
 =?utf-8?B?ZjJxU056djJTVitrOTFrTkt2U2IxRHd3V3RyZk14T2NNUWxoTlY0L3hjWTZq?=
 =?utf-8?B?RVBkZXlIbkh4Sy84R0N3T25SNUZiRU5tdE1odUwySTQvM21XblAzM3Yrb01t?=
 =?utf-8?B?WFN2U1ozSitwajFHazdjbWRoVENqeUVSeDlDdEpKazBhMlBNY3Q2QzRiM09Z?=
 =?utf-8?B?ZTAzbUlHanFGZU1LS2JDK1ZSMkJscHAyVmxydUdOWXphenFrRENFT1AxZkZr?=
 =?utf-8?B?L25KZFA4Uzc2L2hTM2l2ZWVUblJBWDFFNzRuWndXMXpjSDdDTldtZElxUjhr?=
 =?utf-8?Q?NxkMe3CsjQEnulxhCja4TeZBG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4de032-8c27-4160-fc33-08dd760da066
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:45.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 09xSdF4sLvfT5EcIPKi2pbkxXXYW/wWvM3meFhBkP5BaRMe2yF2+Pkpd5vNpfvBBp+sx78MMknIGM5GvOTHG+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

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
change from v14 to v16
- none

change from v13 to v14
new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 4 ++++
 include/linux/pci-epf.h             | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8dec..d04224b8e1631 100644
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
index 879d19cebd4fc..1040d83740f9a 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -213,6 +213,8 @@ static inline void *epf_get_drvdata(struct pci_epf *epf)
 	return dev_get_drvdata(&epf->dev);
 }
 
+#define PCI_EPF_DEVID(func_no, vfunc_no) ((vfunc_no) << 3 | (func_no))
+
 struct pci_epf *pci_epf_create(const char *name);
 void pci_epf_destroy(struct pci_epf *epf);
 int __pci_epf_register_driver(struct pci_epf_driver *driver,

-- 
2.34.1


