Return-Path: <linux-kselftest+bounces-26043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED208A2CCE4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8647F16D3DA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE0C1A2389;
	Fri,  7 Feb 2025 19:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQm7UxJt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD6D19DFA7;
	Fri,  7 Feb 2025 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957308; cv=fail; b=bfv5N58FhlKKkeAkYwROH+loRxl17RTaHO8uD6vLH8DIYvh/DdBGZOBl/tpURPT7FYFHJzLb3NWAkFOYdm0Fj/b80y2130DLbpg/zoMhwwW903ejpTwiwEQa9P5Ni/iOV8dOV2PV44CadFiCHMuvMUFQuumKsOjPTwbm+ZCGsyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957308; c=relaxed/simple;
	bh=fQfEhc3od3s1DS8iGeKcZ/W7CnZbFa1etYu2d2O7S6U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F4CYXLE9C6BOLmm0CpuIBgzW/aT0wlyLxXHHVwAI5LwuiCCj4PpAV0jws06IQLOnF8OJaQv6Dxt8P5oKvkNGxfJlkisfCxwKJFrAsWofbJ7axqS9CtZOnQK/aO/NKEIOOInWBVGDuPr0repQSoAdraMf22hs2rLjxvtHdRct0gA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YQm7UxJt; arc=fail smtp.client-ip=40.107.249.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkZychytbShmTGD3PLIsW9drT36SmHaMuJ3C+fLKYAcPPEqehU0ErPqeyvTpDIltlNBYYKEKZQxWRjV3nFG+lkiSoUDeK+dGIcBds3HaeDjv34g6nURRmNo1qgJiLW5QLN4qpBzfKycL1E+gBloVR8O+XfG1K/dPXlxjUj0vb0OVn64KGuH+Iw01lP9UwJQc6z5KP/WYtF5w/WR3wQr5x5msrxL882yxwmYAdIFKN4JtjJHXECpdPJyZ1GbYvKuoReom0SB+2+b4Z9ru1MwMAST/q34Nso9qhW4E+rxx2juaRly93JQKPtrwrt2gqlH4Km8rhrQ63kZwtMesNYYc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5dkQiSesL/Y1YGVOrewVZ9YJrteh7NfPNnlTEHhrOQ=;
 b=wvvgB7R2yuDxFcWcbL/2d31Jcr+8/VaxaDTZ9dl/urEEuj8CEzB39eNvGCiKf3j36x8GI9ofa3r4HJAjQUWGm1geJf8PIZL53bxBC62p4vupJCyVo66YyFTq0e1nfbaOF8bNwFr5+/OdGEi3KRlAybYciqZhqsJqt0vdk0u26LDwUPYx1Z451DF0ghX2yBgMwEVNm244ZsR0Q+WRRfYfEDtxWkCn2EkZrEaxiJy+OOS1mBiA/gID0BkY6NNyfPOQs/XKYzIzmprqj/8dEMD+KBPnFzye+jFr1YA96QkUEeIl+0WGkVVre8DOmOsjMvzeBXjf+E/KGAm6If10rJgD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5dkQiSesL/Y1YGVOrewVZ9YJrteh7NfPNnlTEHhrOQ=;
 b=YQm7UxJtmJxGWVSae+XWhI5DQPb2BHOr9g68rYK5syEZdLGs2CktvLvdIW7T+eMGGg8pGW2ygtcnN5+uzmVV7FqTu/Nrdj8fNqNGeQXJTYqFvX9x6R/sQtz9AlhuOuFv3CscCmN81A8WT+/h1KxA4wUIW/KCjPRVumfIDLXMq+GDyCvyE2OLwEe9B340ATBos8ydMPJm78Y/XllcOVFl1nKGo1xVGXB2n7MBmpqnXQp4AkzGgQZjoG6DpUJOtFPAKQ+bCqsqEqOyvNMB61/zaiKL9VrnhlVwynzCEM3YhSqlXAi2wnpHWK97ktNqmujyT9FhyNeI9eZX3mIYq8pJsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:54 -0500
Subject: [PATCH v14 12/15] pci: imx6: Add helper function
 imx_pcie_add_lut_by_rid()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-12-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1782;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fQfEhc3od3s1DS8iGeKcZ/W7CnZbFa1etYu2d2O7S6U=;
 b=0uNZyf4XVgDB84yV3zUBzZBwt8RhLEM6qhQdzjNZjDo0rEkqDfaYupWiD+0eUvOZYcRkA8vnU
 c0+GSI5iKVZAnPk03JgIaM/HOBwSV1wTPlM/DW3vEpo6YhGjOV8+UI5
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
X-MS-Office365-Filtering-Correlation-Id: fccd1016-47ee-454e-72d3-08dd47af7217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NUVMbGtjaS9EU09ob2RmUkRLWHV3NGJTTjY1SzJ3NFpvUTBQY1oraERreFI3?=
 =?utf-8?B?RkU2a0JaWnpwcnR1Um9tc1BHZHRiVUlid3ZhZ0F5L3pTbzdzTDVNWENYZEpZ?=
 =?utf-8?B?YjhyeitLMDZwZnlPRHlib3dMQzBBc24wbUx5ekZMNytDbE9xSDRvbzVHazBI?=
 =?utf-8?B?SjFQQ1ExckMyNXJDTTV4K1pTTTU0WHFidE5ENzdyKzVIL0dERENReEJBUVov?=
 =?utf-8?B?UThKOCtzWXVVRnFZNE52TWd6UkR6MkIrcU1ySEwxNG9NOERzS3A5THJkRWFQ?=
 =?utf-8?B?U1NhMmhKU25Mcm56akdEcjBjcVBScXBJY2NDM1RqTTZVQ0ZrTHR5Vm5PaEV4?=
 =?utf-8?B?ZW5VME8yckZpSFVVUjVSdGYvUVZqc1dwMkhwRDEzVzNWc1R2akY5a0FzL0ly?=
 =?utf-8?B?M0VpUkVwaFgwaWgwcVROenBpcnRsMVZqOU1tdzA0c2JjSVpuL3BmVVVnRGk2?=
 =?utf-8?B?aWJRd3l1VEFrMlYweUhSeG8vWkJuYkFiYUZ1NFRzcEs2TkFlUlpyWVh5YUZP?=
 =?utf-8?B?R1dMdkhZUmFLMVpRWEJja28wVXZmU0lmaXVSSjA1ZHNoWDgvT1JCd3R3Z3dN?=
 =?utf-8?B?R3RQTjFwWDVoZWx4RmhpQkhYc0dFbUpHc2ZGYnJqRVZ1NnFod01uRjdqZHox?=
 =?utf-8?B?b3lXRXYybDVOSEhSek92dGdyMDZIa0pIbndBOFlQKzk2b1g1U3FGcVpGc1Ev?=
 =?utf-8?B?MG51M3R4Y3BrUkY5dFpabllqZVZnTnB3WGxLK0FoT085STJsWXo3STRFYUlt?=
 =?utf-8?B?ZnBZVzRCTTEySUhJdk41OU9uYWh5QTRnOE5EMDNiSDV6QkxMUzVUYi8xak9h?=
 =?utf-8?B?S3hUaGVqQmNacWpzdVRzSWlNaW9Od21VdXJTd0czWndCdXkwNnJCTnorWEJx?=
 =?utf-8?B?MmtEYWxFdkluV25ucEE2c1JXU0l6S0EvUUNreHlRbU5xb0lZWHVncDlFQ2g2?=
 =?utf-8?B?alAxRmlJbHVHWGlmMVVhS2V3elQrOTN6MnJOTDdML1Y4NER6cHl5S09QVkxy?=
 =?utf-8?B?T3NtTU1ZT2cxWEFOMFJoWHI5Z0VyYmtYbU8wUTZoYXNvSnhtSnJqUERvcmNG?=
 =?utf-8?B?eFJyWHlUbzRQdFJXYVhGN0JQTC9MWTVVNU0zNDZmTlgzM0xIT2NjR1FNSHcz?=
 =?utf-8?B?S29McjE2Vnp3QWN1SGFkS2VieW9hcEE2aW8vZGJ3ZXBuMGVDYzVzQjJOT25M?=
 =?utf-8?B?NVNET3FQSVFJUnErT0plaFkxTytmYkg2TTVsY2hTWDZHSElqNVN6QWpxaEQ0?=
 =?utf-8?B?LzNyUTFobGV2MTRNc3NGbXNnNUx6MEZRNEhVWS9oeU9FS2dJT1hPcmw2ck1P?=
 =?utf-8?B?bWxDU290OGsrUm1RTTBnYXZjdm1Yd2hLdGhBZjhsbHRaLzdDL1NjZXdEU25K?=
 =?utf-8?B?OXhUZitna3FXaVd3cTk5VGMyUEhHcHNxS09yaHpKM1k3bW1Uc3NGWUFlZmpU?=
 =?utf-8?B?UkJIM0MvTC9XTTlvczNpeitMQWFneVhVY1BwcVA0VUlHaFZaK3NEVlVqS1dG?=
 =?utf-8?B?T3dISnR0OG83RlU2dVU4RHp3dEpBZU5Cc01KNU5EWE5sNlhPNTZlLzFrbDQz?=
 =?utf-8?B?NDg5aFQyRjFMb05RaFRURFQzRmhvTzVMeTZsRXF5bFg0Nm84UTdXWXZFM2do?=
 =?utf-8?B?UnlteE1pTTJDRUFVd1JBUDZHa3BMb21VQ1I0MU1kdFJQbHU3OUhUa1pOZndL?=
 =?utf-8?B?Q0xhKzlYMEE3TXVqbUZ0WWtkdFI4ZkMvNkUxZHphallDQitiRjROckJLOHcz?=
 =?utf-8?B?K3ZIeTR1QllJd09VZ1JuVU4wTUVVandUMlR0aGwwMUVDbzNleG1Qb1VraVdh?=
 =?utf-8?B?N3d0RHA2WmlVNUViL2xqUnlZZDJUbTdxTDRnNi8rTGVSOHF4blduL2EvS1p1?=
 =?utf-8?B?aG8xQnNIZVRsU2VGQ3Q4UjBXMEJNUlY1V2g5UjhyYzZ0bGtDMnFkKzVsdDFa?=
 =?utf-8?B?aHllZmxyYmRpZlFzZDRRZHMvSloxaXBlYnN1TFk1eW1tOW5CVVUyaTc3SklL?=
 =?utf-8?B?czR6eUMxN0dRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGtIZ1RxUnEzd3p2UWNiSFM1aTEyNU12Y1UxY2VSU1RTcjJqd1RvOW5aclVu?=
 =?utf-8?B?K0xxcnlGSzVVMzFTQ1N0N25uNCtzK0hnd2x3MGJDZHVVWWNTcGVjb2tlNEhF?=
 =?utf-8?B?d3BadHhoakxqM1U3RXRzZ05oUmlMb0p1TmJ1ZWlITExGMG1MQU85Y3REbmo3?=
 =?utf-8?B?MVNQY1lVOGdzUjg2WWp3VHcwSGIxWlR1R0x2b1JQYVVTYTF0OCsvWTdGcXlE?=
 =?utf-8?B?c3ozRHIrZmk0UTNYTzRVL28rR2xOdlNNem0zWnZEM2JxNzdIR0VGZWlCYlp4?=
 =?utf-8?B?ZnNKUU9QZkVLMVA0dmZqZmh1U2x4WFk4RndHMm5JL0N6ek53ZWt2bitRa3NG?=
 =?utf-8?B?bjFRSk1UbER4SkJxTktNc1IrenZCTm1nMmIyc3dxU2RlbDdnYTQzc3J1VVpy?=
 =?utf-8?B?RUlRZ3Q0cWlxanJ6SmtmT2piWjVPTkN6eC9IZGFJNlV3cTVTQis4bzdFOWZQ?=
 =?utf-8?B?dGVqaE8vMVJmc0RWUE9kTjB4Y0o1V2U2Tk04dGNQTUdsN2hIR3ZvUEFvaTZi?=
 =?utf-8?B?cUFZTlB2YkpEVUQ1cVFzcG16UUNoWDRLcCtVSTBjeHFrTjdZSnlRODVLSWpD?=
 =?utf-8?B?aG54VlJ0cXdOVEVLMDlOY0Q1TVdKV054QWFqRjZoajVVSnNoRUFUdUI3VXRW?=
 =?utf-8?B?NXBwZDJ2dXFsaStRSjhBaVoxWC9VZEN6YjRYTTlyUnFDYzNIVU1WSG1YVkQv?=
 =?utf-8?B?NjRsdk1vRnJwbXRLakFRMmRIRm9mcjZFcXBXVVdmdHZudFF1QStMcGRFV1pU?=
 =?utf-8?B?OHVucUNsRkErZEZEcFhQR292LzhDa3VVTk90ckNaRHc4Qkk5MzZtQTNZMVY2?=
 =?utf-8?B?SEFMQnRUcURnMmx5RHkzTjNQRmdCS2lrRVljMUljV3UzZ21zMjdteXFsbUth?=
 =?utf-8?B?dWpHK2lYYnllQjFmcWRNYlhxU2Z5MWtSaTI5ZlJEWUE5L2RUNXJVZEpDWTdO?=
 =?utf-8?B?MVlLa1dkNHhvNnEyRmNUNXFjN2xTZ3NOYjNreEN2NFVvT3pUeGFNVDlYcDdh?=
 =?utf-8?B?clNCaWNueW9lTHE4b21ML2JRMEhaM2pJcXI3SytsTkRjYmpmUk5UNUFGYjg2?=
 =?utf-8?B?NUdBWUYwZDdiQnBVTlhkVCs5MFZPSlV2Q1lLSUxZSVFBOHE3MmNKRUdmVFZn?=
 =?utf-8?B?b3lFVHdZUTk1THMzUUVBdWpEOEFOQTllRTJ3UXdsQTZROW9QNmphZjI1d01q?=
 =?utf-8?B?azVyWStZY2xhQkU1enJ5Z2ZQTUpoelJ4cTRNVzdDRUw5ZWVjakhSUnorQis4?=
 =?utf-8?B?aFh2YlIrZVdRZmM1V3YrTmhvYW43cUVJbXh2dkp6cWl2dW9zOEF3dDRTQXhr?=
 =?utf-8?B?aXNqRkswdEs5dThGUDNVNVZDQVQ3YzFFQ3hjbmNTL0xINjBCZ21NN1JOdHhJ?=
 =?utf-8?B?V0h6bkZMMFphQWZ2WjdWY0JQZkRqYWJxUWZBQjdNd3ZnSS8xek1hUlA5dWVR?=
 =?utf-8?B?TzB6UGhRWDJyM1Q1ZHZNVTdHdThZd2o1Q1dja0N2SVVCbkJrVU1HOEg4UHlT?=
 =?utf-8?B?MlNsQ0pqM3NFVGhyT084WlZvK2F6dkNXN25vYUxGWS9Sbm1HMmFLZjNQSlpU?=
 =?utf-8?B?OGcrZ3ljMTIzZmpPYUEzTitCaUJPYS9JQXlHOENZZThaVUtNUlpHT0ljME5I?=
 =?utf-8?B?bHJxckh1RmFaTFE3MkFHanpWMHRzSitSaUsrRHRFNDVSMVRNdlJxQzJNVFdG?=
 =?utf-8?B?M0pqL09CUjZFMHE5MHZER3U1KzdMQzBicmtiQWFLbGgvRjYxdCtKUFBnbk5X?=
 =?utf-8?B?WnNHUklDaDZHWVg0MnQwWTJTQmJUNWpnWk9iOXlwMHB3MkU4V2VyWlRhdzdp?=
 =?utf-8?B?WHhUZ3N0MjYrdDRqdmJid2p1cmEyZEswbEpmN2xrdVFTazlqVE10S0wwUTQy?=
 =?utf-8?B?d1ZYTGZxbGJMbVZHcElFTWtoWmdJblkvaTc2Ym15NmhRWEJLSFNQRVFBODdZ?=
 =?utf-8?B?SktqWjhlWmJKTFpjcVJrYm1JbnVYenc0UDdjZnNOcnVJZEV4d1RSOU02SVQ2?=
 =?utf-8?B?Y0pUelpnYmNleWVaa3J0eFFIMWdHcTF4Zkw4UEl3aUxsUG5DclU4dXZOYzJH?=
 =?utf-8?B?aGhwNXVaNEFWbmFiRURWeEg4M0h3QStzbmhxVkF6Y2RoZkJBNThwN1FjallT?=
 =?utf-8?Q?+xSCOaiMyfTzcphFZM91gVogY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fccd1016-47ee-454e-72d3-08dd47af7217
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:41.6607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI2txluGhMB81EcZriqHOULQwMxi6goClhshbkGmhIWqiUSzKGKs+wXxqileKXpZetJ1cINm3rp1X6IZfB8HRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add helper function imx_pcie_add_lut_by_rid(), which will be used for
Endpoint mode in the future. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v14
- new patch
---
 drivers/pci/controller/dwc/pci-imx6.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f9..e20d91988c718 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1028,18 +1028,14 @@ static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
 	}
 }
 
-static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
-				  struct pci_dev *pdev)
+static int imx_pcie_add_lut_by_rid(struct imx_pcie *imx_pcie, u32 rid)
 {
-	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
-	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
+	struct device *dev = imx_pcie->pci->dev;
 	struct device_node *target;
-	struct device *dev;
+	u32 sid_i, sid_m;
 	int err_i, err_m;
 	u32 sid = 0;
 
-	dev = imx_pcie->pci->dev;
-
 	target = NULL;
 	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask",
 			  &target, &sid_i);
@@ -1114,6 +1110,13 @@ static int imx_pcie_enable_device(struct pci_host_bridge *bridge,
 	return imx_pcie_add_lut(imx_pcie, rid, sid);
 }
 
+static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
+{
+	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
+
+	return imx_pcie_add_lut_by_rid(imx_pcie, pci_dev_id(pdev));
+}
+
 static void imx_pcie_disable_device(struct pci_host_bridge *bridge,
 				    struct pci_dev *pdev)
 {

-- 
2.34.1


