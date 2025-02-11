Return-Path: <linux-kselftest+bounces-26418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7F7A3151B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BD67A07F1
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625EE267B91;
	Tue, 11 Feb 2025 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnAvQPfA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012029.outbound.protection.outlook.com [52.101.66.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0072638BA;
	Tue, 11 Feb 2025 19:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301804; cv=fail; b=gMUVq0FbqKbbYaFK+9EWA8r6UEy2vNNn6sogwWjn8+mw2gvxB4TEp+bs+e8wF6CieWmMkPCTa9UpG8ulbPSVrLNDTu14j+io95/9EtGmHrsw5R6c9BdH6Oi5XF9OyfWvtWymg2C6OiPTqBd72tD+Q6tjQKlo0WPJUP7QH9iG7mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301804; c=relaxed/simple;
	bh=bgNlybeoMFuURulRJUhsd9c06PZ8kncQBsW1pHAX+h4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i0oci/tOOUJ0O7oTawAI8TbufSW5djd4eQ1/b1IzW/2TID0JFnFALzH/s8o+LBAddGu/CCKwR1szgSCHIveyHHKutLFlVQ0iIH07D5uhocW4T8J1bZ8zQj3jVhSnl2iZaQvqLRSTJSQcwhMZ/cwH3rr4tq8at7N/CTJwbcwdUBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnAvQPfA; arc=fail smtp.client-ip=52.101.66.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TfvlUlWEW+adjkphl7LOxb+JV6tYB8vpIwhoLEXc8dFvgwzM+YbIawsYa76faYmCpQpf4weTGTn9YxLKTF5Nn3LFdoWHLj3zjIqVbcQbibjw03A4jcrQ3wSqruh+N9lRMaYG1ZnlDkhCC68GD9xq0BjXyDtBVlYkqLw26xMSjolKGu/YUyTtOv/iKUF+vP8xAmV/wm/kHGBlo1TlQ7WSTqQakeINxyColFQM/N+czugMV2hXFMlwsb35WCIvWP/tnsYUjoYzLsSlFqNrgJHZCriICczE6wd3b9Qr6zn4TawEyikC8SSfqPcf7Txiq9rK3DsqfY4sHEdjirHufRW2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9bg6MJ//Lho3Yr/1pvuCw3zXJKiAbbSTzIbMzly1KWQ=;
 b=beAd2aKuCsLuM/yZf+Aa6KcNMUU1CkaCqrivixkGfqt5RWQCM1J7dUHnUwaR4P1BQMzfRW1hq8dg/stQ1H8pTdHaZ/oSXycJ3KaIb0gQhpq8wCPYzaoNI6/l2nyc0zyXdh5/msrfbmW5pEAUlxAes3ybEfNlcP/4mG9eAA0RPLFMyvErzXZq4Hr12MRh3L0Apeo9g0kjg3UNurWg5xFzYSiq2ZEYldIzVu2yt4flR2I294jTQEfOsNfIB+TyPJs0s7nBH5gXF3e3ZJYohp361d7rwFfQEdBzUAGeVYkJ9yLkg52gQPYBYTdc9OHTYpcb0mXtpICPRE3h6dCFmGUzvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bg6MJ//Lho3Yr/1pvuCw3zXJKiAbbSTzIbMzly1KWQ=;
 b=NnAvQPfAtcOZFhKnGBuNGcFxm5CnFEhOUWWv2u05/ynq04ZOJjJwogQaH5DZysf41uilDKKOTyBgvpFLVkjVV/puefeDTS7Mz0MCtESZcHQqkTvELHXEbNGhsZPVjI/8nJ1OEGE/tfRn+m9G07vLd3/myaZR1tEFce637V4vIVgQTDcmqXQqXnggQaq3kUmj37cOaFWnLN2hL2EZH5QekvgrYxdFrDJFLPtpLsZEaxrcbauXDnnecxv2s4yQOo6fcB2eszIo9kfVaCBLffJ2hbTe5VMQyIKyP9Ea3Dm4JPyYzR0xZ5LulWf3mDgt3WuYAfmmqM3NNvIV9mKXesE54A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:23:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:02 -0500
Subject: [PATCH v15 09/15] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-9-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=8258;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=bgNlybeoMFuURulRJUhsd9c06PZ8kncQBsW1pHAX+h4=;
 b=EQMaHT/Fziby3MMkGzAqAS79NpcVcNFe8xDwwkz9LFzeKKQJ5mKCePU77uyjo1bgnZQi8CtIK
 YcFoXLXBXDFCi+iXvIFfm2cJUwl3vLkk91Z5baT0xfOmF//87wkVsAf
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
X-MS-Office365-Filtering-Correlation-Id: 05a3bf08-fdff-4bcd-af2f-08dd4ad18aeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmtPOExsZkNPZkZpUEN3ZnhNdCtDdmVIU0RwUTdRU0JBelF0U0hSTWRYRTAr?=
 =?utf-8?B?a3J1WDZwY09FbjQxdWhNa1dYU214Q2p3eHY3RWNkaEpIbDBMQU13L3FBVy9j?=
 =?utf-8?B?WHQ2WXkwdHNoSklSa2hwZE41NmtrSE5wM01YSjF3RlpabzIrUEFLbmJ6dGJZ?=
 =?utf-8?B?TVZsS01MeXljc205bmRndHNwRHROZFhSVjV1YXBVOWJPSURtYXcwaHFhWTNJ?=
 =?utf-8?B?VUVxL29XRjN4bmJOK05vN0E3TS8wQTFJN3NhOS8wZzFndzcxY3p6OXFlSGNw?=
 =?utf-8?B?Qkc2YUlZRGxQRjVzbWFURWlka0tINUIxMmR5N2pjdzF6b3l5UGdVLzhrWVZo?=
 =?utf-8?B?UkJTREtYS0NxTlBBbTdkSnZkZXg0ZExzSXZTeG1heUx3bGNOTElMTDNSUEFw?=
 =?utf-8?B?NExSUVJWbVpzWjZmSmtiaS9EOTU5cnUybDZpdU9hRGExMVhyeGFjTzFsdUFW?=
 =?utf-8?B?NXhLbWo3SFFXRUg3K1FsUXNYeHUrUWlIeXp6SWN1L3VKNkt5U05mWmNIb0pp?=
 =?utf-8?B?dXpzTWJaZ1Q0Z1ozOCtkVTFkMHdjZ1J4aXFUVjJRQlVBM0ZlQXFKcHF5cm1z?=
 =?utf-8?B?UkpoV0R5RHU2M01QTUNOeDJZeTdaOXhhVkd5UCtCTlozalVWc1IxMk5VSVVj?=
 =?utf-8?B?VjJwdkhrT3BZUnpkOHhwYStkRkFVK0lLK0I1OGRqd2JhQ1Bpbitld3F4WUZM?=
 =?utf-8?B?Mmt3YklUVjNNU3JwZHV3UXBpNkVKRVVKQ25xSXF1L0Vkb2VGRUJ6UDJFNEY1?=
 =?utf-8?B?QzZRd3A3eUxobHNKa2g5TVo0b3pOQUJpWTB4VVd3QkhzbFhueTdYdzZCcUJs?=
 =?utf-8?B?NWJzbmR6d1BHSUxuY0ppZU1HVW1oZDFub3NCbStSQTkrdE8wM0lJT2ZWUW0z?=
 =?utf-8?B?b1JLVXllNEdHdUpHTk1yV2p3NGJPMGExVmxoRFM5SWlrNjhGWmdVOWhDOXl5?=
 =?utf-8?B?ZlprNmVoVlJMUmZBa01XTWIwbXEzVlNjaGRQa1B3VTV0Vm1QWWpVdFg1d3Fu?=
 =?utf-8?B?TjJHVEJ2dkd1QzRsT0d5WXlRMXVsNG9tdldQb2xlK0J2MU8xb1RhTkYwejE5?=
 =?utf-8?B?Y2FwU2Z0dW02eHh2SmFacUFWZWszRDdtdnVHOXVNbkJJdTNSM1pWSmUrUnFl?=
 =?utf-8?B?V0RndmpYalVzUlZVU3NIV20xMVl2dWk2UWpPWWZncUJqYysvY2hKWDVrNUo4?=
 =?utf-8?B?RTJrV2s1V0ZJVkdkeHBaYk1HSU1OVndGQXhQbEUvbDhwRndDSjE3R0ZxZEhV?=
 =?utf-8?B?azFxOUFibERsL0lHbHJ2V1l1OXU0MEh2SEVkVjBKbXFxSHFWWWQzOGxOMDVK?=
 =?utf-8?B?Y2I5K1NLd2ViZlRUbWl0TzZkZWhLMDZGVG5CWDZ4MXNScDlaaDNhNCs0Sitl?=
 =?utf-8?B?OVZiTGxYRTRydWxGa1ZtSWVmdWo1MnlsV0JabEp4L0JKanpwcUplQTNxRjBK?=
 =?utf-8?B?ZUVNU3VhSzdtR3gvRXd1VnFwRWVydEptYVlvSGtEOXFKT0V0YjRwOVFsNkdS?=
 =?utf-8?B?MzVZV2ptMTdtVks2WklIc1ZRQVlWRXhoQTJwY3FmbkpjK29VelNFbHNuVG1U?=
 =?utf-8?B?blNEZU12c1Q2T0NBd284cTZlOG5FRnVZcEZra0Y3Y21JWDBKNXlLT29hVjk4?=
 =?utf-8?B?V1A5dy9meGZoci9uekZTYlZJV1FFWENDS0lmOC9va295Sk9SdHhRV3NCMkFF?=
 =?utf-8?B?TklFRFYyaVQ5UW0wK20vTWIwQVhHbERMdFVuKzVqcU9zcjBsMWcyRm1yb0V5?=
 =?utf-8?B?S29nZWJiWUZ3a1BKckNqTHU3dTVsc0xqbXVOMG1palFOdXN2aDJSQWFvZjJq?=
 =?utf-8?B?dGxiZU00dHFCTXUrVWl4bzJheWs3aTlnbE13NHVVUzVrSk9NVlkza3RhMjNs?=
 =?utf-8?B?UEMzaUFlWkt6bjhsQ3ZJZ1Q0MndNMGlQQUVHYnE5ZGdvN0h2Nll6eEtPL1NF?=
 =?utf-8?B?eUVIVi9jTWszV3RXalVuQ3pGODBCU1g3QUxWVVk3bUd5cFFlOWNaeDUyY0Vp?=
 =?utf-8?B?YWM3NlkxZm1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWJkZzdubjFpMWo0YjNER1pKVzJjc1BBNXN5TEpMSFptMHZKZXpENTJLUld3?=
 =?utf-8?B?QUFmSk9LMzBvTXUrcUhGWXFsM3FiK3NBVmJiYUI1ZmkrQkJvY0MvaDVDYjIx?=
 =?utf-8?B?NGtBYU1SMXpQaGZsUVJXU2NWaDNybmFjVXlIWFppN0pTKzgxTVdYZjFIN01l?=
 =?utf-8?B?T3NXL3dFWUtudGI4VHd6UnpQdllJcWlQZFR0blR0OGtaaTdsa0tBUW9xdHh5?=
 =?utf-8?B?eXAvdEtmWjRSY2U4SHBOUXVJenJKVDlTenNZKzMzcU8xakEvN1JFZzVrZzV2?=
 =?utf-8?B?RHFWK0tkckFTdjJkSnVPKzF2ZHkwMXhHMkorQzI2eWhJMUhKUDhPLzVMYXVH?=
 =?utf-8?B?V01KbW1nOUtyV3lvRndxUFBWSm1sWFNNamYydVBLQU1kNUUrUE80S1REbEh2?=
 =?utf-8?B?aXRDdUpnNzhsTUhhbDdCZHVvTkFydXlGOStrUG90QXprR2dWRlRHTlJCVDRv?=
 =?utf-8?B?a2VyQjkrSTl0YVMwRWppdXlFNnpRTks3N1VoL1FJaVQ5eVNJcWZsZHJpYi9K?=
 =?utf-8?B?TFpMTEV1ZHJWcmh4cjFXN0RGQjZKVHFXRENheG1TOTVMa2VrbGZERE5zc0I5?=
 =?utf-8?B?N1VydnZkbkdiTnAvd3dWTXhXK1dFMlgxZ0Z6UGtGWHlndUxJNW9FVWozb3pW?=
 =?utf-8?B?Q3E0ODZQOWZvQ01saTNkQkxCSmxGSlNNcXRUMmtKQ25hcC80TVlUVzU4b29Q?=
 =?utf-8?B?WmdEQ0g3QnV0V3BDVytJMTFvNUZGQkxBVXFPRlFEeVpYcnhFQlNnV1VhU2dV?=
 =?utf-8?B?dmtRZVZKS0E4VUFyWnVkWUFZSEh5VlhQZmpOMkVrcmFURzVTLzFwMGhXRFRw?=
 =?utf-8?B?Wm04OHVST2xaY3JrY3NJUDhnWnR6ZVltbHFKTHJqdGYvWVFJdTJYZ21NVmc0?=
 =?utf-8?B?NG9HOGQrRkMxVnUxMDhZaElldnpRVjlaZWtvVkFPcWNrVk9GMWJxMEs4Zmsv?=
 =?utf-8?B?S1doNkMrcExYWXpTNVUvMlc3NDQybVZ2UytQbW9JSkxGWXhYYjJhOGw5R0tH?=
 =?utf-8?B?UkQyTlAzUFptTnptbXRXM29hMzJsbjVmOTJvY3R3LzV5amhmRkNwNE9ManpS?=
 =?utf-8?B?MWVNSHN6eUphVExtMnZNRWpUemhQOXdOWStJclRIQmlPM3EyK2U3NFQ4MGpJ?=
 =?utf-8?B?d2FSbFBkQ2x5eVp1S2N5c3paRWQrWVlwekFzR2J3aEhob2FOOGZYTXVBcEV4?=
 =?utf-8?B?dExMUklPWUkrN1ZadE12MzJoeWYzZEUyaGM0V2luMHUweW9OYzVnMVk5ZlF4?=
 =?utf-8?B?elE0UWVnR1RLdjYwRTZTM0dIekd0L2RIMTFwdkR4V1Zra2NURVZPUGFwMjFT?=
 =?utf-8?B?VzVyNndHS2FTS1cwS0JBYWhaKzd4ZnlYblVhL214Mk9JSGlJc3BzN1RnODRZ?=
 =?utf-8?B?ZlJRMWJEenRqakEzcDJRSDFBK3V4K0ExeDVFTTMwWXBmakNoenBHeHdLWHVR?=
 =?utf-8?B?bjA2MTBXWE8wb2l6QUZhSDJnSXg5QThPSTFFYTBOYVlSSGxNMUJ5bWVXYTZZ?=
 =?utf-8?B?cmV6YTJ5aVJKQ1JDQTltNGNkTnlCQU9HK0xEUmxzTVRJOGRmQ2NHY01sb28z?=
 =?utf-8?B?YW9kdU5kejc5Y3lkenpjUmFkZEt6WE5qSER5bGRhZnJqaWtiSUJkRkprQUZx?=
 =?utf-8?B?L1JyK2M0ZEJZUmIvdzNHNGl1bXV6ODF3TlBJaStMOS9XYTZhemxyWnpjRSsw?=
 =?utf-8?B?V2dQWG9jQ01mYndPWXlld0ZPNHhXZXY4Yis3cjRKQ1B3aUtvWENwWEdIcmRK?=
 =?utf-8?B?dmttdWNQTEc2UEZMRmF0a0dCb1dVRUU4amVOZk1ISXg0SjRPQnpldm5rVTlL?=
 =?utf-8?B?NTlNclc4WVptVFh6YkJFV3BsVVZnRFJTQ3lMaUlrekliayt5VVd5OG8rek12?=
 =?utf-8?B?YXBGRjJvSkVwbE9wWFFvUStJRUhXaHRlMFY1WFFkTXRXY284QlpkZ2ZXU25q?=
 =?utf-8?B?c0tjdG5OcXc4NExQRXloUmljT200RmUya2J2Wjkrdi9hWVJsUVVXUy9ncmRN?=
 =?utf-8?B?QkpzQnpEcS9CajdVV1RpaEZyUU9jU1RETmtXbnRWQWcrRlhLUWRIVzRsQU1w?=
 =?utf-8?B?VG5uTS9xYVNtMDZVWFE1ZENjenlsN3lEL09teFBoRTFHbWVRcmgyR0dpZjVH?=
 =?utf-8?Q?30cyD0BqMX2gycSAqa+miecAE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a3bf08-fdff-4bcd-af2f-08dd4ad18aeb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:19.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLHexmMePDI5/0RudneOsrC4UDUwjQUh6qbJwFKW/Gmm9wYrxtBwwU+MCPeg/ESesHt3QFIl9fktIE1AJDWH/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

Change from v9 to v14
- update commit message by use pci_endpoint_test -f pcie_ep_doorbell

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 132 ++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index b94e205ae10b9..bba1229c46f14 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -63,6 +72,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -77,6 +87,9 @@ struct pci_epf_test_reg {
 	u32	irq_number;
 	u32	flags;
 	u32	caps;
+	u32	doorbell_bar;
+	u32	doorbell_offset;
+	u32	doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -645,6 +658,116 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+
+	reg->status |= STATUS_DOORBELL_SUCCESS;
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (reg->doorbell_bar > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = NO_BAR;
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		return;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_data = msg->data;
+	reg->doorbell_bar = bar;
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		return;
+	}
+
+	reg->doorbell_offset = offset;
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret) {
+		reg->status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		reg->status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = reg->doorbell_bar;
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+		return;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		reg->status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		reg->status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -691,6 +814,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -953,6 +1084,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


