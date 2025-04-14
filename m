Return-Path: <linux-kselftest+bounces-30754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C557A88B52
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 20:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB5117D18E
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 18:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C6028E61B;
	Mon, 14 Apr 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVNfE0U3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013042.outbound.protection.outlook.com [52.101.67.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3884929292F;
	Mon, 14 Apr 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655541; cv=fail; b=uLhQykht8ah/dd7do/NPRFFxjqSil+znRP4vKZ37heDJYegsQorHB9bg74w6Be0ZPGbI3Mt5RJ9STjnh9EA7VW0QbyhpOIorxUf4r6uEYZifqUO11dy/iZGx7cVIt+l+qKHxrOwwy4AKrFGciusv3SV6TjciltDPi7SXAaWsZ+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655541; c=relaxed/simple;
	bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=L5ayKbhEic8H1s1qpQZd3krQT1IwFP/4ZrA7xokXG+GIqO/Mc4TL9SwRbcocpNAHPPG5N7ut481nUOGVgP9T4Eno8PRLKHg5I/8C2125xQMhWYxdRgmTiv7NYnKMZb7ejqDNXd8uJDFsKQVxm510tsffwxo1FxrbrMvqoDv61Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVNfE0U3; arc=fail smtp.client-ip=52.101.67.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g1D098SAsDarngZrX0kAesxNpjvD/SzSryfGaJOEa5cmydUXoF+6P9idkNFG0Y7mAc4B+kd5iMF0MNe1Ioqwe21zqR5I4h7NKgvmZfmxl2UGnZcm1MG9/qgdxjqXtoH3bKASKtpQE30wNSasjwgEEOnr3cWYOzuWa3zTEMKGXm+Z1Iq3fJCsKw3dXtQuRODQbHrWOhJ81DyoSxKfsVzzRRJIUZInwUF/6LFwpeQjEfIwjyLt4c3ZzD9ulVULs6+XcqzrQGkmwoZHtkvH1ZlHC2aqDWqVRUqN1H+CjWaagSNQqwDJVzLfc7smTogHPeVp771u7dY+lijfZWX6THOs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=zWXbyBBQkwPT97d2WWIX46Cdak1+EJqBb1KaiLLYqPrfTd+AgnaPUMjKUTQWhU+ncY1d63K1p1CMkIogRDtYpXraaH4TgsQwierRBxmm6A9fUOLGXoBLWuXwfXp/fzwe44wcOGAxIanawaJfPgx1ohlB4p4FTrKRmm6hexucbseG86J2Air/phJWt4GG+oQenXsF5syhzdjZz2zOJOckcFGYNX2ogAF1j1CDD4UDynT8aqYqQC+WkUANK9qvZGiSfLAmtySAYhfHZRBhggdAR5mspDEbNwyEjFYNz2Y+hahDmnbbkNPjvOWxxx5DzCgiw5VnkddLwCKCEvMiYrHDKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=ZVNfE0U3wDpNdHaXTFvaCw6qpa0tZtH+8IcXkaftBrKKdf7CMjRVauaHD3pj6CU0VTaXK36AqYi+zfYTnSbEajg+umGqMiF3Kvfm1QN8/SpTNqQn6jRpNo2orB4TPEO7WOI7O6vRlGFTH+VecJR0SZde0MCqIc1pbkPYysLm8BAWnMUs5j3475yA2JNApwOLbRk7w07daQRTh2QnVZgSva82F75eDJr+8Fo/uZVMUeg5X1DzwIH45B3yoHgF8sUpodiETGc1CelRHmDNWIct1Pdhwly4hFmnslxv7Gglv4APTDJRf4g1cRZfX87GSdtAMStveXTb/csaq4H6FDYHCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10245.eurprd04.prod.outlook.com (2603:10a6:150:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Mon, 14 Apr
 2025 18:32:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 18:32:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 14 Apr 2025 14:31:04 -0400
Subject: [PATCH v18 10/15] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250414-ep-msi-v18-10-f69b49917464@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744655465; l=8739;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
 b=WA1OAWYCnqei22MVeDwGjCnpnVfO0FJuK6HZFsm7mP++4OGJXz23fcWBa++hGzQhZ0W6pbP3R
 XOmQzKwC39ZA+n5pSREs/MFVL+aFofhBMp7eAtXNgDDssjK0p+EbL8M
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
X-MS-Office365-Filtering-Correlation-Id: 49cc0544-fdfe-4f0d-55db-08dd7b82ae98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGlTOWhQU1BPcjMra2pVaXdRWXNTeklqVmdVaXN0cUYrUVkzaE9lTmhid1lw?=
 =?utf-8?B?SDBBZllVcHRlTVR3ZmpqT25QNUxkVzhVcDJsUHQ5SFNRQVFVcS9UeStYejVz?=
 =?utf-8?B?Y0ZKcU9HUnFtaml0ajRqNVpZREQvTDUxVEM4azkyUVowakRPbEpUbC9RL0s2?=
 =?utf-8?B?bFZCbTlPc0dGY1Mwd0JrSGZZcmY3VmNqZ0s3TUdYWktNcldZL3lqaDQ2Nzlw?=
 =?utf-8?B?czF1S25nMkl3bGlVK2o4U0xLMjFQVHB1bWY0M2NXTzY5OU4zVUpOeVI2dGZ0?=
 =?utf-8?B?RHlEUFdUR3FQczRnTlZEUDZLUHhTbGFqVWw3WXhXTkk3M2FXL0lMdm5WUjZD?=
 =?utf-8?B?MXQ1RXRCOE1uK2pla3h6TkFEVlFPNEJUd0s0dEsydU1vcW8yY0FBRkQ3Zitx?=
 =?utf-8?B?MUh5aW5GWEUxZm5DTkdoV1ZFWVJzd2xVWHgyQVpYaGcxRW9lbjlJUGxrdUFi?=
 =?utf-8?B?emxmYmx3RGtvOHhyZXFmTnFzNWhlS0MrTlJ3RWtrS1E1ZC9PcEJ5ejFWMWk3?=
 =?utf-8?B?enpUYlZqTVlVdmpZS296dXk3Mm5LQlBSNUlvOGV1OThVOFpmVExHaWZ1ZHQ1?=
 =?utf-8?B?YzJPZUpHSjZmSE0wT01sTksvb20reXIwRVRNUDBhLzVVeDIvSGh3bWVOaVM3?=
 =?utf-8?B?RGpOb1dKcTZGbFlhMndZQXBWd1RzN2hIUG5uYTdybnQxejRlalE2bHlJck1Q?=
 =?utf-8?B?endWSTB6YXh0NlZheFVRRXJENEtMT1BWUURRc0Q4Qlg3a05Jb1BjWFg1d21F?=
 =?utf-8?B?Sk8yOHJwU2p1VkkwT0c5Vk9xaGlVNjNuemFMZnUzSHowS3NHSHFKd1dobFFU?=
 =?utf-8?B?ZGt0OTRmbzQ4azFKQ1pCUkZ1N2l5d3BQU2ZXTTQvRGtpc0VxVWVmcGhpcjJW?=
 =?utf-8?B?VFNlR0NMQ2plaWJiRDFiMUFsSUYvNWRJTDNLTXVLSnl0NHBiT2JPNHhaT3lo?=
 =?utf-8?B?RGIrNk1JZzhvQkdEcFFBK0dKQitSWWsycjhVcnJZWlFHZDJaWWh2MGxjVDJB?=
 =?utf-8?B?RHFFOVhxK2Z4OVRnb3lzOHNxRUZEU0VsT1h6QWdScXdTQnFPengrNVJLbFpQ?=
 =?utf-8?B?WGNhY3BlN3hCR3FMaDBjUVJwOEFBY1VIdkFRY2RhWnloNlpPQjQ4MGZKTmU2?=
 =?utf-8?B?emxJbXJqMVhmZi9Pclp1dDVLWE1WbG5rcWxaT3VadmE1aStDZjMxOGNnRFlH?=
 =?utf-8?B?TUpzdzVFYW1Ja3V3NmxQTEp0UWU4SGxTbGtDQkgrVncwWm1VQVFXVFlRM2xL?=
 =?utf-8?B?OEVhSlhhbVRmNUF5dkRGZlR4dUJwUUx6bnZDUzkyaFM4ZUdKQkIvdmRuaW1M?=
 =?utf-8?B?TUN0aWE5RXdMeUtsd1V6Q2Zlc1hnQ2lBbXFhNmdJQXFWVEYzc3lGNGlsaEo5?=
 =?utf-8?B?UVY5alpzdGh4ODNPSGp6Tkc0SEtWTUNtdHBZSHR1YU9RWStybDg1b21keTJn?=
 =?utf-8?B?RzBXempWeE10dmV6U2JuUitLaHhSTEZEZGV6ZzVlQjRxUG9iV0hKV0tyZnd2?=
 =?utf-8?B?clZJb1ZydUJmd2F3aDBxYmFBWWZUSkx3blgvOFFOc0xjSVR0dkIwUzJzaFRz?=
 =?utf-8?B?QkFnaDkyWTVvQmpPMC9pNWZDa1hNME5pOEZmSWdRK2NxU045K092bWxOajJ4?=
 =?utf-8?B?UXNRRWIyamxLR1V2TTVqSXpMQVFZcTh0aWZIWFJORlZpang1ZVBEYXh6NzdK?=
 =?utf-8?B?aWVwMjNab1hiamxSTVJEOTJMb0M4SVNmNXdlUXpYVXFkbmVZcS9LMU1pWFpu?=
 =?utf-8?B?U2Y2UjFCMnJRVTB3d1ExMTFsMGdtTnczZjBieG9Dc0F4WElvWHBCYWJFK1Zy?=
 =?utf-8?B?WUoveFN2Z2NSeldJVW5relJ1eXhyZ2tSc2pHSHVPbWoxdUNWVEN6M21URW5N?=
 =?utf-8?B?c3dqdVJBSkVyMytyWkE2WlU3N3p4ZHZteEtaMTBxM1pMeFk1RXh5Vk5hZDg4?=
 =?utf-8?B?VGlVeHM5WUI2RGdSb1I5MVVTU25XSnFEODNaU29ZMTBhOHFqeXAzZVpEN2RQ?=
 =?utf-8?Q?GwZS/qEiaX4+9g+qdkSyR2OrHgPCvw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjJWM0U4a0FVYUxHdWZ0NkJrOEM2T1VpWTcwVVVHbTZobUthZGdjays5TFlr?=
 =?utf-8?B?OWFPOXB0amtKU2hJRFp5YkFvUXdIc0w0QkNpQUhsNC9VZFVyRzRReVpjNU9k?=
 =?utf-8?B?ZmV5ZFYyZjBXYWxVTEpjTmRDcTFENzJoSVJhMUU5ek9aNllNMG1QaFZSWGV4?=
 =?utf-8?B?VjRFY0ZxcTNyK3ExMEtVOEo1T29kV2VYSnpZdENmU0JRaW1NRU9odGNOVkcv?=
 =?utf-8?B?NTBGRFBLTVVpRHFnSVFNSk5RSEtVS3ZGZUlpNDhlMjFzZzNiSW5wVVVFZ3ds?=
 =?utf-8?B?Qlh2alZqbjZvRUJCd01ZaTdCZzNJV001aEIxcUhrTDJEYTFKd3JFUktZalJE?=
 =?utf-8?B?M2VwUEFwckhiRC9EazdWY2ZUM2VPUGVhK3BYNHNtbUpGZEdab25WZXRyU3Bz?=
 =?utf-8?B?d0RlYkY2QVlaeUZQNzMxaEhvWmdHSDhYNHRUcXduNk5ZY2g0TVRMR2Q3SVZD?=
 =?utf-8?B?bTBpa2VpWERlblB0UnZaTUNjaDNtaDNjQUFLd0czQ3F1WjRncjZxK0ZkSDRQ?=
 =?utf-8?B?UXVRVEJ5cHMzVndUN1hERW1uT1lpb3hrb2s5UGNNck5xL0Q0VnZRVE1TQjN5?=
 =?utf-8?B?MVZkelhtd1psTU5YL1FWeVV3QjVZRzkzQ0FZU1RZc1BNaTFzRGFKMysrVW4z?=
 =?utf-8?B?b25UcFNrY0pKMmFlTExCVkhvYzhMaTQ2bFZJUWkxdmNzckcrZm9rZkxuTnZX?=
 =?utf-8?B?cC9hVTZoajJvelJWVnRVb2llNjF2U3ZHRnRBU2ZjSFZBOTRlV2NXeWZDcFJM?=
 =?utf-8?B?dURURWUzdmRlYmowZmIwbi9ZZnBNOTdDNHNzSkxBeXZLcHlNVkhsU3BXU0dH?=
 =?utf-8?B?ZEpCN0Fham5MWC95TFg0VUM0dHlvR0w0RkdaS0lDbW5CK1dQeGVyc0Y1eWxv?=
 =?utf-8?B?R2c0RmVsM1FGRVRFNGFmT2gzNDZBVVdpRGdVTGNIT2ZYdUxzNXk1MThzVVJW?=
 =?utf-8?B?ekI3UE1iT0NqbnlYeG13TzVmeTBlU09VRWJia2Q3SU5lcktBOGNldkhLOFNv?=
 =?utf-8?B?SjljWExJL1FGeFo2MFBvaTNxTXdRZW55ZHFLTGQybzc3eU1rME1SNVBuUEpK?=
 =?utf-8?B?MEpXbmc0bXh6L1NvOE8rdUZZV1ZUSWZ6YlFYZGNrbmMwTmcvZHdVQXB6RVNj?=
 =?utf-8?B?T01DV3lvTkUwbW5VeGR3QlZIdnNPVGpsbTVHaTBWdVBBYnpNNXdKTlczTGN3?=
 =?utf-8?B?OEhqRnBkSCt4Q0s3Vlo3U3k5aU4ybUZ4RWZaa0s1dDBKUlRBQXJxemZKcUVt?=
 =?utf-8?B?SDFIS3Q2Z2lHb1B0WkgyS0NIMWpvbStIdm41ei9kaS92OG5JOFk0eWF2ejUx?=
 =?utf-8?B?TDNXZmFkTUlYUkR3bHJ5ZzNIRE5CbzI5MkgxeG53TFc0VTM5aTNMYS9iWVA1?=
 =?utf-8?B?YzRkQng2dERkbTE2NFZGWmI1eS9BOG13UzZEa1NFS3YxUEtmZEEzZzN5Vmth?=
 =?utf-8?B?OGVWTVdDYjM4elJXcktRbDhDQldjRnZpSUFpWThkSi9zaFdHWE9PS0dpMVBj?=
 =?utf-8?B?TkpUWUEyNTRReGxIWlpCOWdCbWVSZGVpTEVXV2FmWUJwWlEwTGZ2Y2pmMWRw?=
 =?utf-8?B?QTJydUE3akFDdS80WEJZekh6ZWpXNEVKbExCTC9tRnhna2pJWHZjWU4yeWZP?=
 =?utf-8?B?Q1NjODJ3UHliMHlQOCtDRU1scFMwOVpKdVcreFFrYnV1UWg1KzdJNVBoMWhk?=
 =?utf-8?B?R0QxblV6Ry9pclpaUmxGbE9ZaUdxS1BLODVVUW02aHY2NGtuN01uRC83MDgr?=
 =?utf-8?B?WjN1cHJyZGpDU1RUNUJtcGxiOWVuMXlpR0QwV0dYczFXWmw2Y3hYeG9hdWc5?=
 =?utf-8?B?ZlpyK1N5aXZ3ekhTMlg1WGhoNGZYeTB0djI2MmVGMXk1SzZmZUcrekpGVUpi?=
 =?utf-8?B?TjZmMUJhWjZoSTdyeDl5N1ZZd1pFWFowc01kZlJwNEV4T0RPcjl6NGhaQ3Z4?=
 =?utf-8?B?V3pKWVNZZnRleHF5T3MrbEZGZFBJOHB5QXV0eDFCOVd3V3oyTi9RVURJaUhq?=
 =?utf-8?B?eHJUbUp4WnBFdUpSblh6d1RoNzNTTlhLNGVYN2xDc05JQURxTEMrQWp0SzRN?=
 =?utf-8?B?Tmh1d05VY3RTOEkyMVpGRzl2Q0VRdlZLS3dkVW5mM0I3VVVBa1FveVdtVThO?=
 =?utf-8?Q?5xI0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cc0544-fdfe-4f0d-55db-08dd7b82ae98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:32:16.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNZ7N21q5MYd5sLtvbWtrB0yo9qX9R8JWDxOf3F34Uqah41A8iwDEWVF4fx8dUNT+Qa2+run7XiuskpVhY0k/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10245

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
change from v15 to v16
- use le32 for doorbell_* register and use cpu_to_le32() and le32_to_cpu()
when use it.

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
 drivers/pci/endpoint/functions/pci-epf-test.c | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f4..b9cb1ab218f2b 100644
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
 
@@ -66,6 +75,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -80,6 +90,9 @@ struct pci_epf_test_reg {
 	__le32 irq_number;
 	__le32 flags;
 	__le32 caps;
+	__le32 doorbell_bar;
+	__le32 doorbell_offset;
+	__le32 doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -667,6 +680,126 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 status = le32_to_cpu(reg->status);
+
+	status |= STATUS_DOORBELL_SUCCESS;
+	reg->status = cpu_to_le32(status);
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
+	if (le32_to_cpu(reg->doorbell_bar) > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_data = cpu_to_le32(msg->data);
+	reg->doorbell_bar = cpu_to_le32(bar);
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_offset = cpu_to_le32(offset);
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = le32_to_cpu(reg->doorbell_bar);
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -714,6 +847,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
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
@@ -987,6 +1128,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


