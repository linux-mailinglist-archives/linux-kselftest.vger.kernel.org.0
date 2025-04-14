Return-Path: <linux-kselftest+bounces-30752-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED98A88B44
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F16189A6D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DDA292905;
	Mon, 14 Apr 2025 18:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KzL+6Xd1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D31428E5EA;
	Mon, 14 Apr 2025 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655528; cv=fail; b=qiB2M/cXEzz8CWGkkyhUEZN2DZqjZNMUkF0qtYqV4i7jZ90uA6qBlaU2+af1il5Bj89lhtLW8fMJW/iW8B7z34wZQm7eNsVgYG2jAtXBQdfJLL7mZoaxINmypI2+h2h2dYUcDoHQDEotn2jlhMKAW6XQyXQs3DU2biybvjNDbFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655528; c=relaxed/simple;
	bh=N/Rcdz4WASrCVzB40i3dK6NDhujmvhnmUfU9wknM7Kw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fg+b7GnjkGHdTdyT5J5ku2+elORS+Yz+PGIyzbdRY+9yAmNv1bJzveuN8yP1Yk+HWhuiQVz2TA5opQEBC9LIlo3SU8f1CLIb3pgrNLWIU/rAF0wWva4Qmxdoq4ct6LTfQiSjMl+q2e7vGgpTSdoDvMp1/JJg+J9Xq5lZDoZau34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KzL+6Xd1; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D032PPl3x3ridpf9RgCfg1fjS5dQFkGKeoBKu94jfyHYIqFAYUOgH4REPfZh7INIaFkvRlVCZREszU2Df8oOvFRECR1EyB3Rz7o4cvv83f/YBtcq+Vb6Zk+BJrbspuLRTnD1l6VQWaDcM9v2sWRrTpDYfq6Q2dQ8xvWAHcVl5qlUIpbnBqLvaSJ9i6mOVGPwp7ayx8Z98N2M7ZpWheFEA25jnmZWtBcLlDOyoJkP5UZ1cxyhCDhdKImoS/XZw8K9OAbMxSFFsf9LOHyvOZ6XZbs0JIuFK6K0ccMmVUVvg0gS7QysmJARV4zEvOLZMQiCAcvD+vcPZsq3UM2SgU8gaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IZAfUVaAOa7chBgO8REmAJsb14Zp8lXTUd7dS+omz0=;
 b=RifgdC0Q0asZ8G68BCWdIxzUH9DKXIBRAB+8qUzFDLzTMVAgrIPWxDZs4Y3mYbcrfn83mT6k7lJEv8xoffE1O8zdHWP1yWfeI0MJPaDJy2nluyetZEzXRXYODjKl4x2iU1zBra8/u9OY4DTknhSSMZeS37+0YO6WFYvvBfYmpWm2VnHDlVpecVOZMciqUxyIsFf2qS8hxf2Kdyv0jpHfapwSITXGHwHw275/H5StVwLAJt3WFFG/0yFA33hr6pUHoosw91KqLwV4hC7MdlKX1VVSjBA7AybNnjuYr+VN95mzLPpEiA0YqRBljPIWhudGl2n7pOx6PU2Xmpmu0LwKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IZAfUVaAOa7chBgO8REmAJsb14Zp8lXTUd7dS+omz0=;
 b=KzL+6Xd1ewP2xF0GxyZhzGvPqAOXKvPrDoovJDprp4lUQSNal12krE0kSA3QAe1D/l/eUW4BphEGnYcCYKGBd+nXayy6mVzkl+u3rfRM8YucXK/8DL7DqZb/ivewm7xREFd8fl3dgfk5uZlin6hfOLjH1wVCOQyf7siAimOJNDxoLoJm50U9wzO1GEr9EkY2t8D9juwsudC1z/DoUBiwA3t166VB0ZK+FNELPpK/D/lTzy83WoY7pBqHC3lFcmisHLLREFRHSNSOMJu7TKXmT5flKnMO59z5O+fkdUbNegnPefS8yXz3pAy2tqLFouBZCcwrJUqFk5xVlt3QukWEsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:03 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:03 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:02 -0400
Subject: [PATCH v18 08/15] PCI: endpoint: pci-ep-msi: Add MSI address/data
 pair mutable check
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-8-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=1143;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=N/Rcdz4WASrCVzB40i3dK6NDhujmvhnmUfU9wknM7Kw=;
 b=lHyGx6dxwWJki8Nz8Y7RAQKXFWnbq2mTSjz+me8Iad2NRB2fNQU5ZSS5KBajxLkqNLiOXGHO5
 HjCf4nPhw/BCsttd3yEqRTdesJi3woT9ywpTJUFV7RZMy+tjURhs+X7
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
X-MS-Office365-Filtering-Correlation-Id: b7e42046-ee22-4ea1-af50-08dd7b82a6bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RURQZk9yOGN6QlVPcjc1MGluQUZxczRHdkJ3TXM2bUZ6K1VXZ2F0ZllrNEVS?=
 =?utf-8?B?Wlk3Y0tkMFV4TElCVkVsZjVYZmEwem13QjVsenNYNFNvdTV0cDRUVTdKSG00?=
 =?utf-8?B?RXQyN1lXZGVmUXl3ampyYlJBTTUyYjQ4S0lSSWFvYU9ua3hoeW1qWmczNkRa?=
 =?utf-8?B?TmVFbW9jQlhZZHUzRzdpVUZ1VWJZWUhxZFpCK2pEZFZ1L3pFQ2JyY01QckVz?=
 =?utf-8?B?bG93OWtZa0VYd1dTSEtKZ1RzcU5IaHYxNXlXMnVOOE54Qm1jUjBKTWVQK0JW?=
 =?utf-8?B?dCtBQW5DQmtEM0dlTWtVMDgramZEWTIrSnJxZG0vUFkrYnFyR1YrSU4wTXRm?=
 =?utf-8?B?bWNLUjhHZGlpaklGVHM1WGIvOWJod1gzOGkyaWFkY2thUytzcThHZEVXM3dH?=
 =?utf-8?B?V2dxUlQ2UW43VlhsazR0Y0xlSmNLanVZTlN6TENKTFhkZDdreTlNQzNyd241?=
 =?utf-8?B?N1dpOU0rYzhZeWg1bXJnbVhKQUFCUzBQRXA3OUlXL21oWGRBdjJsNWJYck9V?=
 =?utf-8?B?bzFyWTE5UHg3UW1NUE10RWd1a2htMGd2QWs2QlNPNGx4a1k2V2c5OXdaRHVs?=
 =?utf-8?B?dEZOMkFmMlFkNG9HOEpvWnVTcnZFZ3ZNNHFkQm5ZTVBHZXlQaHNNWjV6QndQ?=
 =?utf-8?B?ek1jL2FPTFB4S2RMenZvM2JMQmxHMEt4VVhUdHdScTl5Y1pDMEFoTXBVZmhy?=
 =?utf-8?B?anM5M214N284Z3dadHpkQldlRnJGNUNkL0lRMENOajJNaGNIM3l5bUg3K055?=
 =?utf-8?B?TlovM2x1cW9QNWRrRTgzQWpzT3VnOWl1N25tcElkUlFyUkVrdzU0SGZHdlZi?=
 =?utf-8?B?OTJjb1pmMnZ5cTYvOUpNWlh4ZlFtTERtNExsUUMvVFRKYjZ5aWpucjAzb2VT?=
 =?utf-8?B?ODhFUUE2blJTYUgzLzJBY0RPOXlENUtBdm8zNXdZdGZKWXlPeGdqOC9BRDNt?=
 =?utf-8?B?NUExN2hGR3lwVmEwQWE4eml4VEllOXAxam80VzJSQlNWV3dlQTVnSWRaVnpm?=
 =?utf-8?B?cXYrdGVBZC8zOWFzeStieUFQNk5XVFBST2kzeEtGU3JiM3VSMEZSRHMzNjFl?=
 =?utf-8?B?amlEcDl1SythMEpnOCtPTFZ2b01kWHMxVXVLeS93WGg4N09oa05RUnFYVy9o?=
 =?utf-8?B?MDE4VDdXS3dldnNSNU5uVU1HdGpUblE5SVk3Zi9CV1dZalBYaTdoakFlSUw1?=
 =?utf-8?B?V3dRRklMUVhxQjVvWVdLcGdqOU1ZOEdLR1Q2aTdtc2pnZ2N1OXFJbWRKTDFU?=
 =?utf-8?B?Y204ampNdXVub0FQQWFkL2I2RjY5R0ZuQm5xL3lrNU1DcTRVZytSblZEOVli?=
 =?utf-8?B?Qk1HV2dsSmIrTTBDSXpDZmxXakFHcDlJekVoOGIvREk2M1p6dWVCSmRaVG1I?=
 =?utf-8?B?dXBTNFFUeW1xazlzd0tYeGtKWEhqSmpIazZZRzBGRzl5RGZWL0V2dXZMem9t?=
 =?utf-8?B?RTJFSHd2a2doYWFYTE53Tks1bmpQYmdMRHR6bGlFaC9zS1Q0VUd4Z0FpaFRV?=
 =?utf-8?B?elU4Qms3VzdHZkxyOXRBKzRERUQ3YTRBVkxPU0xjejVJS1orY3ZIN0xNelgw?=
 =?utf-8?B?WFlwV0luQXBJUktLdnJabktuT1dmYUhJRGFnSkpLcVNWMTlpa056dVJWSDNP?=
 =?utf-8?B?dkZDNkIxZFR4cExxdVh0NWNLbVdqZCtCNHlnQ2ZaSVN5L0lDcjdmVWh1YTBi?=
 =?utf-8?B?Z3ROcE5Eenovd1F4WUFlWHhPdkpYdUVMaTE2TG5mM2dRaXRMcmZZbXZnNGxB?=
 =?utf-8?B?V3FGNkxSaDNjcm5VSVdUWHIyS1l6Q0p2cGtuZ2lKRExjclpmclpjQXZQdUM3?=
 =?utf-8?B?QlNSUU5XNFo2cFlra0d3bnJYRmJxMG9YckFxTkMrcVovRGVjZjFkTExudWxO?=
 =?utf-8?B?bUZ3SnJGLzdVZ0Z3d2MrL3NUeWVFRzErVnJsTmlZdU5PZThoLzR4UkpDTlFk?=
 =?utf-8?B?Z2M0UGV2MjhOR1FUWEU4Wm13NllYdFlWY3ZwT0gzbFBKalZPUHJra3gwdm43?=
 =?utf-8?Q?8xiYpI9JRSNd9QW3DQxcGoqXbbcQWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGQ0TWgzcjR6RGJCVUxjcE5kWC9NVFB1c3RvRnVBZG9NUzVkZVpEMjkwMWJt?=
 =?utf-8?B?RXZFZnZIZ2xsdGh3N256a3F1ajl5VWhuTjZ2NkJYR1hDdGs0MmQxUlNMODFq?=
 =?utf-8?B?bXlodHNkdHc5TWJpZTVvcDZaOGZBSzlGQmxjNHhBUUk3RFZGbXVZbHc2Smxv?=
 =?utf-8?B?R1RBeWFtM2dsRC9uQkJpc1RIM1B6SEZyZnR4MWQyTHRWQzBlK0lyblRhK3hY?=
 =?utf-8?B?eHdWUkJ4dG1DZTlpeEg3WUE1Z3VDR29ERElMNWM4WXlEZjNqR1ZseVZKMlkv?=
 =?utf-8?B?N1VQZVhJMmlwdlh4b3F0c1BJMTNpeUtzM1UzZ0R3Qzk1K1FRcngwL0hvVWlj?=
 =?utf-8?B?VDhOQ1Juczl3MW5qcElhQ2N2TGt2Q1RMYTJzdVJ3Nmhla0RHQ1pBYkk0dzk1?=
 =?utf-8?B?dDAxeTVBMG54OUUwaGQra3R5V0taQ3lpb0w1Zy9CNXZMeGNkamtlZVJXU3ps?=
 =?utf-8?B?a3Z5eFNFMlFremFvdi82ek4weG9xOGFDWm1HSjIvN1VXcHRpL3Y4eXVKelBJ?=
 =?utf-8?B?ZHZYekN1TTFjZE5KMExKaG9oRHBEOFpaVExyRUlvRnNJOUs1cWVPRjFTcnpk?=
 =?utf-8?B?Z2JUYUpxRGhnUFBwMFF5QWx6bEY5dEE5VXdrdFI1dE9uRVBKREhZa1lvOXZN?=
 =?utf-8?B?WThtMXp4b0p2bTdOeEw5QU12Njhkcjd3NEZKeVlFcTNDc2ord0pnbFd3RzFQ?=
 =?utf-8?B?a0FuUXQxRmFxbG1Ca3kxZTliRU80UzhrQjhyVUFmNEJLeXk0LzgrVUJ1dmJw?=
 =?utf-8?B?RzUxUEFocVRxcDVhYVltN2JGcXlVaEZHVzRvaTRsQW4wOG9Zb2MxNml6SXl3?=
 =?utf-8?B?dERlMHBoajdMWnc1RjBNYnluLzljVDRBVjBkSU80K2xBL0JuSXZzMiswODd0?=
 =?utf-8?B?NUlaaEpZWElwTUN1TW8zbFJkRFppb2hHZkxrTXF0V24vSFpIY1VFYlRzSGgz?=
 =?utf-8?B?QjZkT3B2MW9RT1dpci8xVCt2cHd2OEE4T3RRV2FZaWhkL0R0bjNTN1V6VzZE?=
 =?utf-8?B?Sk9ob2ZjaHZSa1JYZ3k5STd1Vm1iZHNoSUo5S1lGRlBmaDllWWM5dkVnTTZ3?=
 =?utf-8?B?ejZPN2ZuQWJQZXpwd3piWGFJL1kyNDhVNzNmWDhaeENTTFErOEVMeWNIbjVr?=
 =?utf-8?B?VnlpcWQxcDRERzlTRVp0THVFZ0JXZ0RFUWVDaWNJWVZ3OXRzSmVWcTJ2aUpX?=
 =?utf-8?B?alNMbFhyWWNZQUx2T3RURVJFZmYvWUVWeGNIbERBbjRsaDZVWWhCWUNrdzRn?=
 =?utf-8?B?Z21qNFRmNGZ2NDZVWlBUUi9NRngzaGJMN1NZSEdoWlpBbHB2QjhYbG5XWTBL?=
 =?utf-8?B?MEVJZFQ3VjZlVDVpRHR4aGRoOUVaMkZkYTdFWWVjU1plYmFscUF4WXZXRHFP?=
 =?utf-8?B?NDJLS3ZKbjJRdmg0MUxjVC9wRU9yY3dUeHdGaDBvem5VRFNTTDFMSml6WDNU?=
 =?utf-8?B?SDVTeEJ2aUorak8vOEFKK05taEVNcExYZDBlY3ZPRURFT2tNTnE0bGs4Q1Vx?=
 =?utf-8?B?VEZodmJMWndPWWp3clpSd1JnU2N5ZUVQcVpmaHhhc0d1MjRkTVMrcGdWVFJD?=
 =?utf-8?B?MURKVUxFdEVlQmY5TDBUL29lOGsra3Bod0dGZHBzSDk0Nm5zWUV5bEJFbjds?=
 =?utf-8?B?OGxRUFNBS29IWkMxRUQ4ZU03c3o3RE51V24zR2xReGI1OGpKRWlaREdpaEFJ?=
 =?utf-8?B?ZWF2Y2QvNWp2d3ZpcVZYOEVLdmp2a2dvSWZiT082S3cvZk1weExYakkrajRV?=
 =?utf-8?B?SGMzVG1IUmtKVG4wYTBna1RuUk5adjFWOHA5SEVaYzJBaytRenFodW4za2tp?=
 =?utf-8?B?bGRVU2ZGUndMV2U3ODc0K0xXRUhncThja1lHK05yeURTbFhVbkJHRytjRjVT?=
 =?utf-8?B?UkxWZ3k5T1hLWGlmUVhBN0VFMUF2SnR2SHI0WEZsSmpOdTNPU00xR201L0xn?=
 =?utf-8?B?blE3SVdyQXZTb05FazlHOG1mWVRMTHY1d2JwbGZ6UmUvUFh6QTdzKytOS2Fu?=
 =?utf-8?B?Q0Y1cUtuYkNxK2VQYXMwNEF4U3hUendQa3pZVlNMOStLR1NsbHFqcUZ3Y1dM?=
 =?utf-8?B?RjY5MVpFdTE0QitqOWk0REVCWFJqSW5ZaitZSXlEMXo4ZiswZUlVeFV6eU1q?=
 =?utf-8?Q?7J00=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e42046-ee22-4ea1-af50-08dd7b82a6bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:03.1578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEocsnhmrSknPLYIa35D1iufXtPXtq48GOKJiIydHPnuX+R32cyoakXp1l2YIS8fGmpuQgums9E2DCqcT5byeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

Some MSI controller change address/data pair when irq_set_affinity().
Current PCI endpoint can't support this type MSI controller. So add flag
MSI_FLAG_MUTABLE in include/linux/msi.h and check it when allocate
doorbell.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
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


