Return-Path: <linux-kselftest+bounces-26416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1B3A31512
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F713165344
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021EA265CAA;
	Tue, 11 Feb 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CRDWaCdw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013006.outbound.protection.outlook.com [40.107.162.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97168265CBB;
	Tue, 11 Feb 2025 19:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301788; cv=fail; b=AH5f+AbhaR4Me/jXT7cia0BlNkYM4a6BUNJRQXOO9k9dcUigKJiKKvnz2a0DRQ8masBbk4zdyHAUuLZM8SGtkPjaM8H1KpjqIIjcce07uBYSEfwpP+niPrrBGeEWYHGlipQiS8ozUvMHJb6/sJt81OIWqaGbQ7E/VTI8tQBRrUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301788; c=relaxed/simple;
	bh=ztiJqj0qxyzJpOSS3oxdYchFipDrVfPoAvh060QZ2RU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hqjYiDfmF1/kzwpZOZ58SexcBIecGQQ7zrX/7cdaxFk8KAQwkqpieByj89oqE0/dwMFgPVTBtfhX0/SDMYEFqboUmcJ54yNKvZXdigN58BFHJT4W+OD9WBwAHuaHVIqQ32uoejXMUV8hZQvBHKYIL9P7DXwv849+n6SnsVUOsfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CRDWaCdw; arc=fail smtp.client-ip=40.107.162.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETf/jXdKt0I2tkpc/xr7DQ0nBeyrVc37QUCQNnfJGKtjkwMB8A6z6vrGlN60WfkzkxLsLr1Uuto892oA6zkSi/akSANqS9A9Fe0tatSMtYircMOFM72UfqZnEPrtUI1bQMXlsEkFc8iRfKsxguc7UMBQplLHHiKrxmo8ZxvkWtV0CBSHW4uYcj6DAH97ZFHVPcphrYeznA3eglDtsG7NvCCDcbb4cUqRh2r/IEjo6DdsQV9muItAa6jVtBKuf55ymkUKscotfaSmiMxeOEdkufAmCV1IQiqgcuK/ur14CnVA1A35RLVzfjRsDafwhIl+V5TSbT7D87ttKOcr9B5/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTr7vR6pGVzcmWm4cttCw5B6L+hYfl4G+Upa+wa6yY4=;
 b=iaaGVOv4S0Rq9HY9iKo+AqWPoo8IXNHz/P5qZ2EP6uE85Do1BholYiENr+pAimUjKucqmgaym3yQsMNaADBvebhtVgNE+gd7wSHelHBpthqB0YjOKLOH9KIQLTWvZLAU2aPWCDiEAJHpQsUv6UNRKKwzYaVaptChF4KNfOkKapze0xi1DaYQ82Om+cKn16mS9cME178FaiqAontlSwd+D/hVF6a9kfXVH+fCWdUcOAPzwFJlHpfklp2Ip76Jd6nSlLaLFHVevBM6ijQ1DwbyzBthHhLiQsnNelMGU7Dcu3M+BUF/2BLn5J8PcNfWXbjdeJfqKmqtiJT15L/IBCH+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTr7vR6pGVzcmWm4cttCw5B6L+hYfl4G+Upa+wa6yY4=;
 b=CRDWaCdwmz9nuxkIlUKbYBBA3RqGqxQM0pPJjdhTXWiCskXSriiwN4yE6mXfTQzBns+RWNjcYDLSVrE8sRedLQWwnqtgFGDe2WMBZjpDEdJL2lJ8dP46ran+/rVvXvnCJIjFYvn3tr2cEWFT+FwEc9YB+SR6/cWiv1AqRQlaHpHRAKnQVpQmYBlBLRJrIP7Q7uwjV6O00TzKmXPLn6nVjskzFnbcATyptkln9ujrpc41enSOs0mLxrBDhSX7NaBdkHi7KjCfoXh4wzq+1tGryWDKbDpwOFWmvfprXSgR5vDwWySi1+o0Y9+3Y11/6jd0ao/CJpbj1P8YbwlYEKN1AQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:23:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:23:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:22:00 -0500
Subject: [PATCH v15 07/15] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-7-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=1143;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ztiJqj0qxyzJpOSS3oxdYchFipDrVfPoAvh060QZ2RU=;
 b=3kXugNdr4wNUm7TojEXCear1j41fbsa464+U688R7RflMltRp7S+7lNb2HBIH/jhB+aokfVSM
 46SQp3DsVZTCPdj6CMc4yyS9/3pU3RlMsHYb41fDDKTxipVYwTSjIdI
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
X-MS-Office365-Filtering-Correlation-Id: c5101c4e-be4b-490d-96a1-08dd4ad181ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0piK3Avc21RS2pobkpWek5hejhCVlQwYWc4TkxrTlNJaWE2aXE5SjBKdG52?=
 =?utf-8?B?MHFiRFJVTlJDUVdITldlYmRZaW1IeE5udGRiYnltTDZ3VE1oaGhXSXFFQkFa?=
 =?utf-8?B?RFo3NlpCUHM2bTB3OUpEb2NjK2hzRFVRVFVaYXoyUGNiSmxaQUFjYWE3UHpj?=
 =?utf-8?B?RXhQZkUxaXlkVHJOVzJuU0tQU1NNOW5YL0dsVUFDeUV1S2tBczcwY1lLTy9C?=
 =?utf-8?B?Q3BrQlRZbDVIcE9oK1RTVDI1eUxEa0ZXTlZHc2xwcUxYMGZ4d2NQbllJK1A3?=
 =?utf-8?B?SGdTZlYrVlNzQjNhNDJFYXVZQTNvM1BhRVdKTmFwYlZkTld2NzBlRmpTRkY0?=
 =?utf-8?B?NHNEZEozTVpCdXpxdTMrdGxxYkQwUjgvcy9vOGxqWDhaSWV3eFVmSDZoNkIz?=
 =?utf-8?B?K2VWL05PK2VmeHREeTdpalR3WmtpcmZzN2x5eG4rTGowY0d6Q1Z5cHlleE8v?=
 =?utf-8?B?S1FuZmNnaVNmWDJtVGZCS0ZuQnhDcFFXS2R4YmYxWU9DVG8zYjY0SWtRVzEw?=
 =?utf-8?B?MzhQTkpRZmN2NHZUUm11MzlEeWhIRlVWZlRFNnNOMnNIZFhjaDhjVCtRZnBI?=
 =?utf-8?B?dWJVL2cwUHJjd0l0WmJGdXlmc0ZJRXdmNGY1a0J4ekZyeDFUL3lZUjF2anRH?=
 =?utf-8?B?dVVVUUlLZ1NFUnNCYVFLNm9jS2owbTdMRlBxRk1jb0RjakpQVGxkZTRpYmNQ?=
 =?utf-8?B?clRhNWxNcEdrUFVSVHIyTllLTFpTa0xpeXBZanhnbXNRQUxMdXE0NGtBVFFH?=
 =?utf-8?B?dXowVFhMaTlwc282Q0V5L0VFVDJNdnhXdFB3R0ZiWURDZHkwL2pyenNacXFp?=
 =?utf-8?B?WWEzamFLZHRYb3R6YmlnMXJXV2RENm8veEtXWEJXRUgrOTQyd1hkTW5ZRVk1?=
 =?utf-8?B?UUFVdVlNMzRyNVpRaDcxQ2o0L1V4VTF4SUtTdUZqTFBzdWhGcGoyUmN0d3Zh?=
 =?utf-8?B?cE96QWpVZldIM094c1ZFWm10V0hqYWRBeTczK0VjUitweERVaFpDT3dsNm5F?=
 =?utf-8?B?QW1SMW9zWlREMnpCL3lRWFZrN0lnb2FYaTJ1VW1HZU9yTEdmMjNDb08rU3Bv?=
 =?utf-8?B?L2puZS9wcHZZUCsyeUFzS0Qzd1B5cmdnRjRSS1NQWDNLQXVSM1lLNEN3NnZu?=
 =?utf-8?B?b1A5NWpxeUwxRitwbVdIR0JoZ0VlWXBCZWhGQXo5MVdOTWRJVFlaSCswRkV2?=
 =?utf-8?B?b3MrdVcwcTNTVkgvaE12K2hIWTI1WmNwUWFvUi8vWGlvenRKNG1ReDUrdDc5?=
 =?utf-8?B?OFN3elo5bGJyUjFFZW5rSlNpdnY0elIrZWJVMnllTGg5N0F4VGFiNExqR08y?=
 =?utf-8?B?YXVrOXF5WlptZlhCWHdvZ2g5a045eGM0bUVFRlIwa0JrMDh5RVVNaGdZVElY?=
 =?utf-8?B?RllnbVFzT1R2U25mbGFnR0dQblZtWUx1TUNUd01ocFpOeVRIUXptSWVRcVpL?=
 =?utf-8?B?RTRXa2pjUm9mVEZUYUUyUTZ0dzBaQ3Z6V01jQkNHbXRBWDk5UGJ4dVB4SUta?=
 =?utf-8?B?Y3luZ1VlWFNmWXo4TVY1WnVWOGJvenZ2SzV1ZThibGNkNDN6cnV0MWl1VlV2?=
 =?utf-8?B?anpzRFU2Tnp3NGhDUWkzTENibnpSeHJUU3pHRlJUUmdzL1YrRE1OWDFVQWFk?=
 =?utf-8?B?RWdhWEhlT1hub09ZUGtaUVlOZldZS3JqMjNRbjU0ZUZPT2VvQmRIM2xnNlRO?=
 =?utf-8?B?aEJWQmJnL3kyQ0daenlhalNJRXNWcUpTTm9NSXNGd2JSZVZrcWhOTW1qN2J0?=
 =?utf-8?B?ZnBRMVYweCtqQllrcWFEaHRCWHJGRzhaRStpK2JvZjB3OUU1QlNRcFpCaGt4?=
 =?utf-8?B?Q2NvaExoeVNldFRVUXg2ZjZKTkUrNE9TUHBrQk5FekIvZEJKbWxBMWpUQUdY?=
 =?utf-8?B?SWZhYkVHZnk4ZFpBaE5SSDd4VXVoWXFOeHhLZjFMUkF4NmFXR1Zra3VGdUhv?=
 =?utf-8?B?MXhpTU93Y1pMY3U3ZE55a0xTd1Z6QnV6bWNQTXB6TXllUEczWUdUZ2Rhd3dU?=
 =?utf-8?B?L0hFc2ZZOFhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFZBeW1mbHF4YWJQenMwQmphNEpNQUlVNWV5TE83TEpRUzc0RmVrSXFpcUV0?=
 =?utf-8?B?ZXlLeEhoMVZ5aW1nUFVWampPekFtYVhvZEpuWlhvVm5vOU9hZFpCbW5JUGtr?=
 =?utf-8?B?L2YzRUZKTDhqaWlmdjlKMWJRcHc0T1pLSTZtUW8wRTRoUktmaTl3OFhyMlVp?=
 =?utf-8?B?REc2dHZnZ2pyM1JCdEZDdDlNZGdiWlUrV21pVXFTOWlQU0laeTliR3JhTVVV?=
 =?utf-8?B?SU9PUHlEc0ozUGJ2ZXFDclkxRk53bDhseEp5U1ZVWGRFV0VFZ2lxeHdxbE5p?=
 =?utf-8?B?c3RYTjhNZGhKSlA1MGRzdjRtbTMzZk9HaUkwQjZDdmFZeUFPL0c2VkVlVTE3?=
 =?utf-8?B?cDVFYVhlYklKQi92N0hoL0VhWWF1ME15VXBuMmlXYmN2Qnp3eE1DekFXbklz?=
 =?utf-8?B?Sm4vN1kybGE0UVAyYkoxdWhWOEg3VXNCOVlHejV2Y2wzL0JyL1R1TkdHSXBE?=
 =?utf-8?B?U1ZCWVlJUlFTbjljUHR2S1p2MmMzalg4QzhlWEhLTTRNTWtPZXFwaTZjRXox?=
 =?utf-8?B?VWVoK2RjaytYcWUrQ2RLbHZRRU5BTjJtRWFFVStRRWJZbkR2aXlkN3ltUXdp?=
 =?utf-8?B?NjVXUXNDZW8zZDkrNW9iT0tsWFE5WEFlWDNoNzRPcUxKNTlmQmlnV1VVbVNL?=
 =?utf-8?B?cXM1bmVzdXpsVWRtTU9xV3lFaWVBczljWk5HWDFrT2s0eFhDN2Fmc0tSVENs?=
 =?utf-8?B?dERFVmsydHZPLzhyNzdjZlphc3RqYXF2dzl4b0J2SytIUUVUVGdJQTF0SHF2?=
 =?utf-8?B?S0lJZnd2bEp5WUhJTUxnaGU0dVBpSFlpVTRJaU56aXFPaVprY2R2WDZtdUsr?=
 =?utf-8?B?OEJxZlRzTUo5ZE9YQVdnc0NsRmhVT08waU1SbkEyYTZoc3VXR3BnYW93V0JC?=
 =?utf-8?B?UkZndG8rN25OWjArQXNqRTVidkU0bGI5UGlxYUhpeG1VamY4LzRCYU9WV3BZ?=
 =?utf-8?B?b0ZhMkhuR200UWpKL25JV05iUWdsblBZT1NpOERMajh0Mm9UU2FBMDhDZUNE?=
 =?utf-8?B?bWRVZVJQYis4STVLN2k3N2tqOTFHYXJOOG03TUF2MlduM2xHK1NCSUJmNnEw?=
 =?utf-8?B?b3V0Y2lzdWJSKzhRNVdmeFhWYm1ZTnVXcTNzSm1xUkVMK2l6c2h6aGIwSjZo?=
 =?utf-8?B?N1llR2E2d3Y2dTZOeVdjU0tUcWdMdU84T2dRajlsMDJJTG5jSGtOWElHSUdL?=
 =?utf-8?B?SkgzYXkwSCtNd0lQQ09RWTh2RngvTXl3MjZ1ZmwrZDlKVk9LQ0ZrVUhyOFE5?=
 =?utf-8?B?U3RjU2E3cHhUNFZERWcyMkdWcVRhZlNyNFY3NTNoMjBrbmR0N0NORkhCaVhD?=
 =?utf-8?B?bUFuQTduMnlUVVRJb1g1N3FWekw0SDYxcmlmMEk4MTduM2pjOFB1Tk8vYW9u?=
 =?utf-8?B?c3Y0ZlIzamJ4RnFwVUdSZEQrcnE5bFFONVFzZzE2UldCU29HMHJQR3ErVUIr?=
 =?utf-8?B?TkJ4blFCbGRFUEtIdW5jbXdVbEg1Q2JuS1FIbG5HM2dPS0k2VTFDZzBJL2Q3?=
 =?utf-8?B?LzJzR2ZiYitac0ozcllhZ1VHTXJrVjNnMEhTUHF4Vjh3Q1ZMN3F6VDBPNG9o?=
 =?utf-8?B?TVhrRVVGczQ1cnZKZWRxQ0xqWGVBTE8zcVhKOVo3K3JMVmhNTHYxOHhPNkJi?=
 =?utf-8?B?RG5HSnlhVnJXaTdqZUowRCtQSW1CaXNsUG5BbmVTT0ljbzB3M1dWVlFDZXA3?=
 =?utf-8?B?bUVycjAxZFQrcHdmUGpRSFNkMXBmMDJmWkN1Z2NNeTA4UmNjY1ZFT1ZWbFI0?=
 =?utf-8?B?YXlJT2VnTldNUUY2dVVEaEJjUDBySFZqemkrZGtIWWxTQWZrTG9HUlNFeUhF?=
 =?utf-8?B?eEZpUWRuL1k3STZLcWsxbUlDbVFWTUR3VmNibjM3OFhOalVveGo5LzlQVWw0?=
 =?utf-8?B?aTRmc2x0N0dDbEEwQUlyb0gyT1FJN1pld3FjOTI3NDh0NWd1OU15S1ZPK0FV?=
 =?utf-8?B?VG42VnJkeHlVaTE5aU1jVXhTOE1UbWNLR2lhZXJJSWVNTzNaWHlyRUNsT0lG?=
 =?utf-8?B?RkovclU1SjU3SlE0WTZxNGJIVmpmOWRCdHZPM1YvbWp0d1hvNFM1VS83Q1RC?=
 =?utf-8?B?QU91NThqdy9rRHhZdklIRXRNMTNxZnR6NlVESGF0c0x6cWFWTEh0NUgxMlhi?=
 =?utf-8?Q?5SDixbFgo3XC2YI/SzgaaSD/5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5101c4e-be4b-490d-96a1-08dd4ad181ab
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:23:04.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPYL7NQFet1Pous9E4I6+LRpUk0RG0Y7LrfZOjYy5WiPah5VTHGSpVZJfvgk84OQvsRKW07030MnLbvDynyHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. So add flag
MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
doorbell.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v15
- none

change from  v13 to v14
- bring v10 back

Change from v9 to v10
- new patch
---
 drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 549b55b864d0e..c0e2d806ee658 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -44,6 +44,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 
 	dev_set_msi_domain(dev, dom);
 
+	if (!irq_domain_is_msi_parent(dom))
+		return -EINVAL;
+
+	if (!irq_domain_is_msi_immutable(dom)) {
+		dev_err(dev, "Can't support mutable address/data pair MSI controller\n");
+		return -EINVAL;
+	}
+
 	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
 	if (!msg)
 		return -ENOMEM;

-- 
2.34.1


