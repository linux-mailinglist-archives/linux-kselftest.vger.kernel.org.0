Return-Path: <linux-kselftest+bounces-26038-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7911AA2CCD2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 357CD3AC6A3
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D31A3170;
	Fri,  7 Feb 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l3U9V+Vj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95919DF52;
	Fri,  7 Feb 2025 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957268; cv=fail; b=gF4W0QT0F/0/CxNVdTshlXNVeBKCbqigU1yvP+usR6WjJVFuWwekEGdNl+FqXtQI+JqlRMhFz9IIQtoofSH9HixCqU/q75QqU+maLphs4J39gvms26p3QHeqT/aDKdKbZ6FiJKRkrchqF2rdfDijHunY8p75YorP3fL7oaFl1vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957268; c=relaxed/simple;
	bh=M7n70bouEoS1T1/Gs8LCJQRFd41+b1yWDUiL7eHBQOg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ej4RLbRJJy5LVfrqS0rTeXHR+heXTNx0YGnVydKffA94TGjPM6sxlPPRwq4ziQUcp90vzRT824duz7dEadLJDpN3B2l8fGT2+LdRBKkuqkpxhpeAKRwwF0cQt9CReTabCZj2lQskDqISKROhKKTnTKXjTZXnjrZ0diM+ptNd4Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l3U9V+Vj; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBE6rf/h8yDZDEbmIofg0Wn7Uo5L+SxBzdzLy3zh8B4iIq4r40/j6st9YfUM0cvjFgUgu9ge+1EYo4CYufJt6nymUpt0sH25IeNu00lNFgR5wAceZR1yJmJCG0b76lfH/lNaJQZ9nk3A0hhulCO4QvmxcyQ/IzevT3e1EVHMHCucrSCu7+/LPGHsOhmeAU1RrKdYI9Ve3Gr0Y+Crnn6JD0skriSgwKN/2e56AOfxIUuHPqkhbX4ccJ9hCTPYxH8h8jOeVFkZdyukvH8w3ALQKYyimOYiHu2sRrNKXSe2ZNi/lJZdwsXyTVDdFHFPm0CR9sfhYSjWifqhKQdjz6BaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/1CvVkM5/1/ogrGjrzpwZwzGFJd+3SVY5HszuejZoE=;
 b=H3RPT3BfbvSkRY2MZITjhNUk6uMhEZkRWXQaBnWk7swz8qrVsoCOpsUlUo0UMDFNyNvfdpjaw3kfhmryjBWdNWyEK+cvx1t0JIOHv7gt6yW3n4MYjKLpJzh/EFbx27ge6EDGrJ+/QmLlBYROEsIdenDoitbVElpBgHK9/u85j8OqIVonAV4JGHRwHn26+uarJ4MlzMKpE+ySe9sIFal+Ugpi8kCQb2h7s14LS2krKDF0y12kTcjsuiZPT4vd6iKgJ2yN6KjrfdvqjBExQVWKcn+isqmV5dUSsllJgJEZQxBCq4nPxXitgn9HSJyt3t61TWakQKNe39rb2Mm2FDyu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/1CvVkM5/1/ogrGjrzpwZwzGFJd+3SVY5HszuejZoE=;
 b=l3U9V+Vj4NaX3ziOoTG3FleYPlcicCkgVhFfKxrXqdos1LxsWSfJj7o6gqtRfKfHEHjQLbCkHi0l/r0DiEBKgyBArsDtr6sJgKo7cQm1nsKtndkqieyVChjS8jTXBjnP32o/o4R/LZCxF+rUZqxx9y3YLN44TggBeS8tw+/AH4O+mWIXZt7RLV2iJnew31lz+MEZyzS1A+B8jKkQlBhT66yJRmbdiJDH1eEJwwwLjxEzsuLPrOSTriQk92tlv8WwyW/WYjnrtcBlkBGZyRp5HkXCh/K/76qjE6QqVmp7Hqq5rHnM76qcS9xysI6yvILrZ3Di6vf+opDJl4l3cE07/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:49 -0500
Subject: [PATCH v14 07/15] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-7-9671b136f2b8@nxp.com>
References: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
In-Reply-To: <20250207-ep-msi-v14-0-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1108;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=M7n70bouEoS1T1/Gs8LCJQRFd41+b1yWDUiL7eHBQOg=;
 b=MCTp5iSVfBueSlqpKDGMhAoB0AuTmW7GeriZuLo2a2Chx8FzSXDrNwWimQFQqRYSqi5eXyURZ
 k4ClEUwZcE8AtVcu61YbeKgsCq7/nxWV5MoMjRrgOjFsnC1sqmYi0Vt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a37d072-599e-4395-4bbe-08dd47af5b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2hmZHZrNm81dW0wS04wcjFXNENHVkNKRmE5Y25MeEF3ekZBUzVMRzVlTmFr?=
 =?utf-8?B?RnpwM2p5VjdjS3FnWGJ1YnlUMXlCZUJTUjl2MnZLWUpNNGxEMXlLRGZ4WFda?=
 =?utf-8?B?TUdQbENrN0V0emxQWEtBamtyZUxPQVN3MWxoOGJmS2gwS1hkdTE0eVNkS3dD?=
 =?utf-8?B?UEJjazA5eWJzZUxPZ1kyTDVCUVlhOEd2b1VzNjF1RXpUU0I5MU43Zjhjd3Z2?=
 =?utf-8?B?dWlDMjJuU0drMnI4VE9XT1p5c25RbUFBSGhYVVFMUDhPWTRhRzd0eU1rRzcy?=
 =?utf-8?B?WTQvSWJ2cU5LSTIwKzRRNmhSSW9Hd0dJNDgzTlBXTHRHVkVQQmFxTmZsdWs2?=
 =?utf-8?B?SndWby9HeWw2SE9yTVhEZXFodmNqQkFDZkdxSEs2WjlZaVl1QWpJS0YxSmMx?=
 =?utf-8?B?ZUcvWGplSUErdVRxRCtmcm5mcHlXTDBNdktSaHh5LzhEclI4SDArOVlLZGp5?=
 =?utf-8?B?cExqYmd0b0w5QTlIZVlMc0JTUXlqeDRMS0xkZkVsaTRyYTJnOFFIMzlRb0pS?=
 =?utf-8?B?RTBWeU1iV1hUOE1wb29BNVc5T3p0U0pKa3VWVWNYbzhiQlIrcXljZkVVRll3?=
 =?utf-8?B?Q2J6MHhnTGgwS01udnJwZVYzMW5jMUtVSnV5Y3BJVjZKbGlxRzRxeW44YXdv?=
 =?utf-8?B?OHk2N1RTcEJSK09nTVluWmRKeUhTdEl0Vzd0eE5EeWRWbU9mdU5FNTY2L2ZE?=
 =?utf-8?B?SDZkTWtLRGtadVltakw0dXR4aWQ5Sk54Yzhkd015TllvNEc4ZHI4QWpkYU80?=
 =?utf-8?B?bm8zUUJFK3JsYnQrRlFldi9rbUNERndZdDdvdGJnN3FDWTFiT3ZTSVZrYTAy?=
 =?utf-8?B?YTIxY09INk4xZXZIaHN4SDNxZnA5WTYzYlRhakFUWUdOZ0JYREtPLzBWd2Zu?=
 =?utf-8?B?VkRQQkdYUk5BcW5HWGtKaXg0MmFCMlE3K09KTXpTRTluZXFlSE9RdjNLbVA2?=
 =?utf-8?B?MkU3enJEOEZlUGcvYzlXWkxCZ2lWeVVSbEdnQTA4SnJlWlhxaUdQL3Y5aUto?=
 =?utf-8?B?NW1neXh5R1hFeWRwaHVZTlNEMWhhZzBUTnVSMHYwdm9DbHZBdzFSck5Od0Va?=
 =?utf-8?B?Z0lKZWxueFZSVjQ2TW9ybjBqZDd6RHowazVQOXZoN0cweUVqbVNKZHJsNzh6?=
 =?utf-8?B?TURaMC9lMFU4bkx6YytnUFQ1b0lXa2NOdCtsVTJSaVcyemZ0Z1lBKzhTd2ti?=
 =?utf-8?B?eUUrY2U0dzJMczFXMFJGd1FSUVBnekVWcUhZMXNSSXFFTG5IVkdjT21pbVhC?=
 =?utf-8?B?ZkZwVWVjdkhpYnlLclpyZSsza0RBTVJPNkt4OXIzeURKQVNIQTdSeldkVDNs?=
 =?utf-8?B?blE4N3l1N1ptNDhCVVJlUW5tZndOYUY1cTBnWktRaEsrUmU4b1dMQ0phTEtE?=
 =?utf-8?B?SkR1RjloSXRqcnV4SDVqMWhzQ2VnK2pSYk82MGFsWHhlMTVKMDZ4NVc4RG0y?=
 =?utf-8?B?Y0EvYVFrQjhxVlVuaHFsUmJHUmZ1RkNZVDduL1FhMFplODhqcEs4czlqUWI2?=
 =?utf-8?B?NDRmTHZDMm43c2FXUWdKWURWWnFTaTNFYTZ1K0N2cXRKdmkrak9zRSt6Y04r?=
 =?utf-8?B?Nk1NeWJzbExWdGFidjhvSlFOWi9ReXJEYWNjbG8zTWlBMnhOQVdOaVpRUkV4?=
 =?utf-8?B?ZkEwaWtTcVNLTUl3L0FXcWE3bDdGdjlmUmVGRzZwenBjNzFVanRkK3B5eTVE?=
 =?utf-8?B?R1Q3YjhBUGp5RjFEWmFRSXp1RFVONnZsNEgvblVuR0IvdDVhd2ltdTEraEhZ?=
 =?utf-8?B?SFNXUTNQUmttQlBsRG9EZWtiVDF3MTIyVmlZWE5SaVF5NUZEZ0ZzRVI1dC9i?=
 =?utf-8?B?RzlMZnJqMERwdFFzR3JLemtjRVg2U1d5eDR6cThWa0w3dEQrK2FuQVlRRXMv?=
 =?utf-8?B?L29kb3ZjcEFhMVk4WDlSblNJenJ3WVcySXkwcm15MTBkQW1QcXdYdkJpWEx0?=
 =?utf-8?B?dlR2YmNURVMxZjRMaWdUd05rdXRLcEhQY0xyQ1pkZlltOVVteXZIR0VDR1pp?=
 =?utf-8?B?dXJlMUhtQ1J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU5QYzg3SC9jQlR0UHhKaTRGY0VDWjBQRlJFNE0veHhzTThQUm9XaXBnUkZF?=
 =?utf-8?B?U05INXhhZmh2SW5UbFFIMythcXJzTVF4QmNVTGFpdHdzRE4yVkljRWRHcGhX?=
 =?utf-8?B?UDZlZUFGYUhQb0JwSzFOc01PYjlzdTJXVDhSVXRSWW95K1dWTVFuYlZJemhP?=
 =?utf-8?B?eDhHWVdXYmZjejVubWFJeVV2OTZZdzFMakc3SnRuV1FJaTduRkVkaVVzNFVI?=
 =?utf-8?B?VE9Ydm1ZNlFSNjJmVThMQUNZcWgzbW1Gd2cxNXpLV2hvcUgyNVR2R0FxdDZo?=
 =?utf-8?B?cSt6akk5bWlnRHgwcGdicXF3T2NGWEF0NEx3T1A4VnhZV2lkelhWczV4NUZV?=
 =?utf-8?B?aWlsWGxvRlJNTkFzaTZwOWd4cTZROUszZWJGM0t0T2pDS2JDbHlIdUJiSzhJ?=
 =?utf-8?B?UlA1V2ZxUHZSU3dlVUJXdFRMNUpacjVkQ3ppQ0xyVUZ2d3ZFWkF1bXVjRk9T?=
 =?utf-8?B?UGdnSENJQ09kd3JJaXhLZVRtNXZoaENFYUFxZVRraTE2NlBVcDV5NkppWUN6?=
 =?utf-8?B?ZEgzY1BPWXpPYXgwYUN2dTQxTHFTT1A2UEJCdUJiN2JNR1FYbHdiRGJweWdL?=
 =?utf-8?B?c3FNeFEvODNSaSsxcmpEelRRVnI5UnhEL1hOWFRiQWduSDN3S2k5NUsvakFR?=
 =?utf-8?B?SG5OdkpXQ2ZXMnFFcU5kZnhUZ3YydCs0RzFUNGhWalkyUjE0eFBUcHoxM1Y1?=
 =?utf-8?B?S3FaTWY1RXdCQjJodGRndGRSR01oZ0ZIa3M0SnhCMTh3MHAwVGZFZjFCU3ZE?=
 =?utf-8?B?NERKcGRxdVp0Sk10c2hIa29nN1Y2L1lXSjVvUTNCdlFWdXYyVGRabHM4YTJt?=
 =?utf-8?B?NXFwNndsRHlDUC9rQitZa3VSbUpCc2ZMUEhNR2twbkZEVTR4dFZhZlMvZDV5?=
 =?utf-8?B?MUFDallMWitwMWRNd2NUeXc4Q1FqQnh0S0lybWJhSm8vVDJlZE5uSUxXVVBS?=
 =?utf-8?B?LzVsV0NSbTJaT00wL2dTaVZuV3dkbHNoM3JZQ2dXaHBOcS9iOXlLTzF1Rmo3?=
 =?utf-8?B?ZU4zbnUwbE8wWCtsTnJTOE8yS1RUL3JqTzlKdXl1Ly9SS0piSlpMSTVyQXdx?=
 =?utf-8?B?eVJ5UEJSUzVydTErSG1nZi9wUzlBOHlwODlwNThidlovSCt0Nkl6Nkl0VC81?=
 =?utf-8?B?aUVQa3Z2WlpvSG5mWldaOS9IT0M1ZnpVQ3IzN1RmUllBSnV0S0Z5UmRoSkUw?=
 =?utf-8?B?c0VqbnY1M21uekdack9uSGI4RlZjV2d3eHhIMy9xRm1jWUhvZEd5b3BseStw?=
 =?utf-8?B?M1FtbXhIMFZiQUNTdEhKY1czVE5laHhIdDNybHFsK3AvV0owcThvaXhCeWd5?=
 =?utf-8?B?TWt3ZEZvWGRBaWpmYnQ0V3hYT1ZxQXB2bmxiSWQweXJXejFCRkdWc2ZPUEFB?=
 =?utf-8?B?eDU0VzUwaEFVOGVBR3N2L3YzSjdyTUhHTFVaVnBUTXM4RXk4Y1U1Z2xPWGFE?=
 =?utf-8?B?b1dCbHR2VU42R2tmNmF6UXN4U2I4ZEM1YS9GMVJvSWRsRlN4eFd0ekxmVklN?=
 =?utf-8?B?d0kwcUFzeE5RZmpRWTYwNnNFTFpVUGV1MTNkVkZPUEZOeDVpQzVBUVhwV1hq?=
 =?utf-8?B?R2hWK1ZCaTRLZGhvc25mVFhacTBXREpsZnEweEN4R3prMmp4U0ZjRHhMQmtJ?=
 =?utf-8?B?MFZPYnAyWUNaZndQdmhzVHZOdmRVaWd3N0FrVzVqZWV0TlExdW00ZmR0MjUw?=
 =?utf-8?B?UytlZlcxSUYwZUMwT0JLYzhveXZLZjlXVWsyUTkxRjdTWTBtbk40blRMTWw3?=
 =?utf-8?B?dXhJV3hsNmFZUk1Tam04R2k2QUJYMTZkdENlbDdHUHZVUWNXVEVsT0l5WEs5?=
 =?utf-8?B?OUdzOUpiQS9hMlh2V1lmRUNuZEJ5OGdkZTZLY1YwUHhnUGxIVlhSWVEwSlVD?=
 =?utf-8?B?bnZtdnBmZlFBS1M2M0p6Ulo2bElkMXM2aUc3Unh2TDVYcW96S2N6Q1Q0L0NF?=
 =?utf-8?B?T3ZrUms3SVJaVXVGYmZpbVZlNGVZWWJURXFMWkdOZlVtVjFBVWtFb2pJdExW?=
 =?utf-8?B?ZENicEdGZG12a1hiT1dxWHpwZ0JLQlFBSVgyYVdQdC9qOFFlVzI4Y01ORUla?=
 =?utf-8?B?ZHBlYnlvSmNiRDlQZ21iNGNIQnpZMDh2M0J5eUlzKzZYbEZ4Tms0RXFiSmZt?=
 =?utf-8?Q?3+YRS6eBlkAxqxIMYpD6lVY8V?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a37d072-599e-4395-4bbe-08dd47af5b89
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:03.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zYizIzREQvFdg+874LdSEdLo1D0DEQ6XGn9MH1PY+OoB5JjjFyf4VbzQAAeq19C33Dhhs+4jOb5OLQ4qz5NBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. So add flag
MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
doorbell.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change fomr v13 to v14
- bring v10 back

Change from v9 to v10
- new patch
---
 drivers/pci/endpoint/pci-ep-msi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
index 53820744ce502..e3ec53c2fefbe 100644
--- a/drivers/pci/endpoint/pci-ep-msi.c
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -43,6 +43,14 @@ int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
 
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


