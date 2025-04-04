Return-Path: <linux-kselftest+bounces-30128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C0A7C368
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23DE188CCD8
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD16214230;
	Fri,  4 Apr 2025 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6onMtYo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF521531F0;
	Fri,  4 Apr 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793302; cv=fail; b=rDiROO1VsB1SAhUiGsSLRbi5/vzHx4U1MJTzol1poIqpIkHH+DnYbXWegw6wnJs2Lcqn+sYXMZELVaCnfgiyboGkWyDJDlPggm9Zhd721284xvmAjbOsRLJIUpRj4k71+TWkHFDiKXvM+1dW5oEcoB1jwCa+RktXXRf1M4TfZbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793302; c=relaxed/simple;
	bh=eNJfyotzDvdW+GxhJmn0oIbs6GUBdCfXtVFciRKR1U0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nPs8ex7UUkge9rT1HyOxmxCBfkA9wIMiopK/WLfbQOn/PxCm/SLMRE7uLjyqprdTjFIPj8r0oPy+j/xNofthwUKrNUIOErKM/LfjMoQNtctz7elsj054lpUyYwkpHsVok7cwyoHdmA4JgPOS0g0RsWW+KWkxT68r3bxVfpk5Dlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A6onMtYo; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhjHP4bnNQT3M17rhtkzZo1shksj1dyH2/YRjdcjqv1PDt9HF7rUYwDiumXVw93tqL+XhWEuE47Zbxs8vZs+1l6rCTUGBkdeMKw5db8TuXdRhx8P5dcAkd9py/Yf4wk4k5NDIa8JkN1JMGALCwbxNLIF+Lv7Kb/AldtpKWrHFQYn37hgsW2Qsi9UsQUu9cRZjhx1PLFgU/BAKUBbxKZuFi3as8JybIILzuuadfEOwTAbBzi0w16zjkgqL1hCmaWnUfAWlzz9cF2QB/GYiVbslBsrNSTlX4oTPl3t/hch1mCJOvnKaOSt3+id8oULOaRQ7xvpUEaOiWMOTamMs7EEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9rWME1fHcdRCa7nqHfamWv+Nn1xkbdNmVYnUkJi1Jw=;
 b=DQxSB49gi0CzqN48Nbfynui4rRyNLQr0tqWlkw42Py+dZeY/rvxKe8J9jKu/zIQYZfxiJPINJiOfoow949kZIFc6Ma6gLey6n8PGF0Lc+lXtt3YnjRye4Y7FHfGLZonwUV8NE1S6EY3C5DWSX/N6rOtZAc5ZxiVmhnhp7uA/qBu+6kDpbzKpRzmZrwVAaM7aT7mQDP6uI6RZeb3s4+mERDIvbAaWuAvBS2EqMOkIWslz64Br/IitgE6yPVdK424UB1TddolSwh3i1vsI40zwuxbBd9L0AbKcXeQitGrRFfIh4Mj4Gak64BHemC0ORORCkKvFzbZZBjprIZTgpzyEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9rWME1fHcdRCa7nqHfamWv+Nn1xkbdNmVYnUkJi1Jw=;
 b=A6onMtYoVkCIE6LHYXAlx9oky8Bx9QLs9OZfWBdLCKEFZDlOxZL1ZoVXIhWKahPR39dZJw+Phe3kx7qo/5uDm2pKCCxtzfJJL+7/rE2PI7O1n3LKlwKMrCIqNh9cl/fmW5GFx2zvirfTkKXQ0qBTUlTLGDb+Amz5zouiIR4E1n8vs69ctlPkdqlsp2MzB9y0iwb/JUuYawIVrRQu2nYSl6foTQKE9lp6dSth2ukjVVh1dypYO5AnFp+Qw7InuXcVzYss86N9CGdS8tuuwfja4VEQp1stTS1EA/XU+CXk5zUKBMPd9WSI5fzHV5B5B6rBi83+g7ARzA21vkjfwH5rrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:01:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:01:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v16 00/15] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Date: Fri, 04 Apr 2025 15:01:01 -0400
Message-Id: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG0s8GcC/13Sy27DIBAF0F+JvK4rZoZnV/2PqgsYoPEiD9mVl
 SrKvxdHisFegnyuxsy9d1MahzR1H4d7N6Z5mIbLuRxAvx06PvrzT+qHWC46FChBgOjTtT9NQ2+
 DZB+IAoTUlY+vY8rD7Zn09V3Ox2H6vYx/z+CZlttXhHpFzNSLnlNk6zxoBv95vl3f+XLqloBZN
 ohgRbIgAyZ6jM4FtFukKgJhV6QK8iCdAhZRCLNFukGAK9IFSZWdQUzEuBvPtEiuyBQUpWfjfQ4
 ReYtsi/SKbEE6Q9Y25wghbJGrCAWtyC3/pEUMTBlUjFsEolV1vrJB0VvDZGyRUe8ZtMxVBsuzS
 5LZW3Im7Bk2DOqyymuKnihKRZi9QrFj1LK6LliaoaVOCA4jo9yxtRpKoDCVLd1w2kAA0hnDrhu
 gGtYOubQjsGeGgsC7yh6Pxz+uqlXbIwMAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=12126;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eNJfyotzDvdW+GxhJmn0oIbs6GUBdCfXtVFciRKR1U0=;
 b=PVcn8ylqnd9JaE/y6Lpm66QPZPomTZ0Xx/BnwNku2zAfuvvaZtuB0Hi2uFdMur/B8KAcrKjdN
 NiSJY9tlv+hCCoOtASnZ6cgS9hNvrQA3BtK3WU0q9CpAiZ8P/F4AWFA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b2e0044-5272-4922-a135-08dd73ab1e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWZIUHVQbEhROEFSeXpkY3FSUTM3VlhuUEFGZU9QbW1FSVNXNVJKdXRPWURl?=
 =?utf-8?B?aWdVWEZKZW9TSGx3b0FkM1JSOTNCVWMwUDZtdTdReDhlZUg5NmNpbmxKY2lm?=
 =?utf-8?B?bmN3elFWbXp6T01YMVJLNVNNZzBTeEpLUkxFUHJvNVpUd3FIMExhbUdsQmJN?=
 =?utf-8?B?OEsyMVkyYWYrcVFSQnIybTMwVnVvcXBzOXM0RDBvdzRjUFR1Q2hGVGZTSlNR?=
 =?utf-8?B?cFhJTHlvTTNjYUQ4cjhRYXFLcTk1Y1Vpak1aNWJuMGcyMHN4M1NIYlN1Ri9t?=
 =?utf-8?B?ZHBUa3lvbDFWU1hGeEMwVWFTWkNaRjYrUzVReG5BcGhMUmJTTHVFMk5xbGlp?=
 =?utf-8?B?Uk5GT2VuRi9qQklINjFjWUh6L0gxdnMweVowTEE4Z1NHMzBFRFFuMzJmTUVx?=
 =?utf-8?B?bXFlWDlNNEhsMXlRYTZ5QzBNeXF4MmRQS2pXT1Bjay9ucFNLdVU4ODMyNDNj?=
 =?utf-8?B?N2dwWjBVYnAweExhSVViWTFwYWpLelN0SUIwZlYzenQrQVpUb3NrTXlxRUNY?=
 =?utf-8?B?SFpPM0pDOFVyVDdHTUh5d0lvanl0dTVaNzBTNjNsbExnT2QraXg5QmN0ckFH?=
 =?utf-8?B?Q2IrTXh4d0pFOWJLUWVCVlE5bjNCSXd3TUFZOFRLalE4NTA0dUR0WG92ejNF?=
 =?utf-8?B?Mjl6RDhxVTZKRy9EK1FFem9kWGZoVk5rcXRkeWJFQzUrS1k0NkpOS0JGYm92?=
 =?utf-8?B?RVFjc1diSmdUTzVkVzBRZlE3cWxKOGRHNXhPdDlOc0MxWFo0aGxWTzcvdGRj?=
 =?utf-8?B?eURPMkZvK1FlUmxkcnhFMnpDN2xtZXVFWHYwb2EyNFNja01LempuekJZZitt?=
 =?utf-8?B?WVFEOTBwSWJSM2d6YW9NY0V3S29aRFgydjRxR2YveTIrNEpvNzdyY0Q3SWJH?=
 =?utf-8?B?bXZmbktuU3Jya0g4QnA1b3JhVzlXL2w0aXZKV042b1ptTHhlN0hQMUVaZlA1?=
 =?utf-8?B?OVRpYU9WbENPTFNPc210bkFlNnFKNnJQdDd6blhpVUl6OWlmeWFEdEZQR3Nu?=
 =?utf-8?B?QWN3N3NFSEQzOXVjQ0pDUXFZTC9TK2p3MFVqcXFNbVhENFZ1SEVWdC9BelhJ?=
 =?utf-8?B?Y0w5NWlKV0V5NDk0dDJpYlhKRjV0V3lWeFpqdkpnUHNPTEVRMW5DVjFyQkFN?=
 =?utf-8?B?YjJkYmVTTjVlQ2VrSlFDZndvVkxLTWhBVEdSZ2N4Vm1NVXcwQVNWYnptcGIr?=
 =?utf-8?B?WXhqV0lOcXhmL0ZUSWtOZGpJNkNwZEZhaG9RelJ2em9QTDVMY0RxcitWWHg2?=
 =?utf-8?B?dm1QajduYy9ZTXN3UjFURi9Wa2xhQWx2OHVsVEFML2tkL1cxazM2Q2dGLzh1?=
 =?utf-8?B?Y0ZzT0ZYRlFlQUFWbElSSDgrUWUveFA5ek96cUY5bU9vc2JQODVyMThwemM1?=
 =?utf-8?B?MFBpY29vYmNYUVVmeUhsZzlXQzY0UDFYamJneGlTSGp1NnpOY3JTNU1uejAr?=
 =?utf-8?B?QytxTlorNzFpK25rY3prSGZjU0JCNVdxU2ZvZ050NFpCNkc2OE15R2V2VWVr?=
 =?utf-8?B?QUtvWXI2a2c0WUhhYzc5OWs5SWJQaHNFYW44SEtiSm1iTnNpYm1qOTl5YUN4?=
 =?utf-8?B?NzN0MHh4c0g0aXZrYnRLMWpZRytnai9JR2JscTZlM2xWZTNWY1NqNk5sT0pO?=
 =?utf-8?B?S2grQUo5UFFkZkRpV3pnNjBicWxkdjBwcHhuYnJCaEVPZ3BGdnpjOEhnaU1D?=
 =?utf-8?B?WElvRUNtc2N0Um9RdVVJVEx3enE0YlNhVENldTdqVUVvSUZ0RzQ4bC91MDdZ?=
 =?utf-8?B?YXA0N2hjWGxiUEhYSmpwQWxGUHdhZlJmT1ZsUGZneXdhSzg1M2hMR2x1OWkv?=
 =?utf-8?B?Ui9Gc0hqSENDWG9nRDkxT01WQ3gvRUdJd0dWa1ZhQkpRcVFpSHNMdzUwM1Ev?=
 =?utf-8?B?MnRoeGYrK1dFWGlsUGVSZGNqNStlY3RDcUZKRUQxM2FkdGpuRS9LS0dYMGo3?=
 =?utf-8?B?akovMjJzVGpLOW9JU1Z3VHVRblAyaGh5YTRaV2xpMnJFK1doNC9CRHhXQWpX?=
 =?utf-8?B?SERmK1E5S0J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlR2aVoyYlFIeVpWd0VubGErRENwVXFJd3Jia1o5SmFiTE9PNDF5K01TSjVq?=
 =?utf-8?B?dzJBTFVXandXcExXbktSeDlpaFBkQmhtYXVCTWNmemk0MjlxZkhFandQYmxy?=
 =?utf-8?B?dCtNNGlKYWxaazhaTW5hOHVlSkRGcE5tY3U1NlhTS2lrVDVCbVhPNEVqUlRC?=
 =?utf-8?B?UWFBSG1RMUk0VDNhYUV2NXBDLzVpNTMreU1HVTNyTVl0VWpoNXNlTjE2cita?=
 =?utf-8?B?c1p6TUFQQnhKUkxUaVlnWCtacWhmcm9wSUJvdjhRNDR4aDNjdGlSRHZDQUNq?=
 =?utf-8?B?czFyNUdiV2x2bG1OK2dqWCttODVrVFExajZFMU9tL1dTOXZvczFKYmREeWxz?=
 =?utf-8?B?dURwR1ZGT212SzFpeitUTVI0NUVKK052eW9CTy9LYnR0bGQ5ZXJrS3V2S0tI?=
 =?utf-8?B?MUxuUXkzYkZEOGQ0RWZJdHhqS2ZIWldibHJTRVUySDFRcThkeHo1c0NjTUFI?=
 =?utf-8?B?L2lkS0ZnYTFQQmxBdkNSeGxsTGwyRzF2eFdMam9sVStWQWtOanlKVU9tSXN6?=
 =?utf-8?B?aFhTSlEzYWlSUFdKVmYzREFCOFM5QXhzZFNpRm5oZEYzRS9ZNW1hUkdrQXFY?=
 =?utf-8?B?bnJsM3FKMFRXRURSczJRWitKd3JwbGlSTFpBbS9jK1RvNXFlRzBPMklpZ2tQ?=
 =?utf-8?B?VExnQTF1STlKSlE2ek5ON1BIOWtzdm5pS01NK2hNc1dzcWNlUWEvUjArWjQ4?=
 =?utf-8?B?WHN3YWVwUk1rdDVBajRlT1N4SWNEY0w0Zncvb240RzY5TjN4U0l4S25va0Rt?=
 =?utf-8?B?VC9TMGRBTEg2d0h4ZFdsYVMvYm5Jdlg4WmtwVG55RmFsRXNDT2FmejZZdjBH?=
 =?utf-8?B?L1JqamE4VGN1b1cxc2xTRExrcnpMZXZjMzVMVEtDb1lHL2tRcEk5WHRycFds?=
 =?utf-8?B?UDZpc2lGekNaNkQ0UTc2YjUwbXBnYVNBbE5TR2VBK0xFM3IyRTN3TzRPbmt5?=
 =?utf-8?B?RWJOT2pvSTVlN08wYWhBYW40UlkrblVmUmpuOS90YytEUmhFeURPc0RIUFhS?=
 =?utf-8?B?eFpEMS9KdUcwSFpUMmlzRFk1YTVuU0dRM2lKdUMveHVUVjZJZXk3clEvaTlL?=
 =?utf-8?B?VUZSbWpTM0VweW5rektTZVA5NmlqbkpDdUNTUU1yTU5YRlgrM3pzbzBPS09L?=
 =?utf-8?B?dnhURmg4N0tsZG5lbkxERDRaQ0xka1FwS0lWa3BFMEtGVUl0NytJQkQzd0RT?=
 =?utf-8?B?bjhNNkwxTmQyTDJhaXlXdTdTOHpQQWZtTkw3U09aRTBvV1daWWVqbWJKRXNx?=
 =?utf-8?B?ekN4U2U5TndPaXBVc3ZxUC9HQVBmb3FINW1kcGhTQitDczFTdmEwWGZUK1Qy?=
 =?utf-8?B?eEZUY0R1U0VYYksxWmt2WUNiZENGWWtHSHpydU1tdHRDdkZRSFNTWXNRYVEr?=
 =?utf-8?B?ajJYRGhzdWhPLzFJdUIxZmU0S3hia0l5a0xKbVlUbEM4MXk4VHU1Qk04N2Nx?=
 =?utf-8?B?TG1aUXV1bldGbUhRMkRlc0lxSUI1Y3JnNk9oSFpUM0dHWUltMWdDcUV1OEhm?=
 =?utf-8?B?N3hqQ3paYXRxT2hvVzFyVlFockI0Tkk2TitRRmtmQmZBVEI4NXNNUXlTS1Zu?=
 =?utf-8?B?RFRYYm9LWlFyMW1pVzlPODFZK1JueFQ1YkV4OXltQWM2QUtLVlRlSUpsZnha?=
 =?utf-8?B?L1hpbWg2RFRrZmkxRTUvb01mMGxyMFYzOXpPd3R0dW9xSzVHbERiU29kT3dz?=
 =?utf-8?B?c1pveDRyMS9FSU5FOHNOVDh6cVErcXp0M0dBRFhnSmRoMFJ2RGFPQ2tWU1BC?=
 =?utf-8?B?OHo0RmJHV0RzVXlWMUc0Y3NqVGd0bndNUEhZQ0hocHozQVhHOFEvaHcxVXJw?=
 =?utf-8?B?UWtEc3VFOStHMVFJSk1yTFllQythdXJOS0sxQUZUUlIxc0h3SHRxUm92Y0FN?=
 =?utf-8?B?b3JiT3lrRGIzMUE1cVBKOWZkSVJmUHlWejNYMzhSZXdQenRIUFFZS0Nhcjdl?=
 =?utf-8?B?V21DdHo2K1lqekhwTzJvN3J2Sm5vdzAxbEJOcXlQUzlVK29WdmoyNzJKb0JG?=
 =?utf-8?B?MHU2NUlyYVRpVHlIdEVjOW5aR1Y1RFJTb2JyUFFobnZnVGVEVkZhVXhTUDZk?=
 =?utf-8?B?cjNScldVVTlMYW1WVWc2emFRWUlSWk0xVkNYVTZoNzV5TThUMnhHVWVabEZW?=
 =?utf-8?Q?9n+8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2e0044-5272-4922-a135-08dd73ab1e73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:01:34.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoJ/rauNIYZk1FlIfD3xAVdWWEbyvzvuvC2VKrCennG1AIJznQunfqi1QK+CFfZVz8+OKmB0Zb8M38tP8uCu0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
│            │   │                                   │   │                │
│            │   │ PCI Endpoint                      │   │ PCI Host       │
│            │   │                                   │   │                │
│            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
│            │   │                                   │   │                │
│ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
│ Controller │   │   update doorbell register address│   │                │
│            │   │   for BAR                         │   │                │
│            │   │                                   │   │ 3. Write BAR<n>│
│            │◄──┼───────────────────────────────────┼───┤                │
│            │   │                                   │   │                │
│            ├──►│ 4.Irq Handle                      │   │                │
│            │   │                                   │   │                │
│            │   │                                   │   │                │
└────────────┘   └───────────────────────────────────┘   └────────────────┘

This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/

Original patch only target to vntb driver. But actually it is common
method.

This patches add new API to pci-epf-core, so any EP driver can use it.

Previous v2 discussion here.
https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/

Changes in v16:
- remove arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file
because there are better patches, which under review.
- Add document for pcie-ep msi-map usage
- other change to see each patch's change log
About IMMUTABLE (No change for this part, tglx provide feedback)
> - This IMMUTABLE thing serves no purpose, because you don't randomly
>   plug this end-point block on any MSI controller. They come as part
>   of an SoC.

"Yes and no. The problem is that the EP implementation is meant to be a
generic library and while GIC-ITS guarantees immutability of the
address/data pair after setup, there are architectures (x86, loongson,
riscv) where the base MSI controller does not and immutability is only
achieved when interrupt remapping is enabled. The latter can be disabled
at boot-time and then the EP implementation becomes a lottery across
affinity changes.

That was my concern about this library implementation and that's why I
asked for a mechanism to ensure that the underlying irqdomain provides a
immutable address/data pair.

So it does not matter for GIC-ITS, but in the larger picture it matters.

Thanks,

        tglx
"

So it does not matter for GIC-ITS, but in the larger picture it matters.

- Link to v15: https://lore.kernel.org/r/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com

Changes in v15:
- rebase to v6.14-rc1
- fix build issue find by kernel test robot
- Link to v14: https://lore.kernel.org/r/20250207-ep-msi-v14-0-9671b136f2b8@nxp.com

Changes in v14:
Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
a result, the approach has been reverted to the v9 method. However, there
are several improvements:

MSI now supports msi-map in addition to msi-parent.
  - The struct device: id is used as the endpoint function (EPF) device
identity to map to the stream ID (sideband information).
  - The EPC device tree source (DTS) utilizes msi-map to provide such
information.
  - The EPF device's of_node is set to the EPC controller’s node. This
approach is commonly used for multi-function device (MFD) platform child
devices, allowing them to inherit properties from the MFD device’s DTS,
such as reset-cells and gpio-cells. This method is well-suited for the
current case, as the EPF is inherently created/binded to the EPC and
should inherit the EPC’s DTS node properties.

Additionally:

Since the basic IMX95 LUT support has already been merged into the
mainline, a DTS and driver increment patch is added to complete the
solution. The patch is rebased onto the latest linux-next tree and
aligned with the new pcitest framework.

- Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com

Changes in v13:
- Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
- Change request id as  func | vfunc << 3
- Remove IRQ_DOMAIN_MSI_IMMUTABLE

Thomas Gleixner:

I hope capture all your points in review comments. If missed, let me know.

- Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com

Changes in v12:
- Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
irq_domain_msi_is_immuatble().
- split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
- Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com

Changes in v11:
- Change to use MSI_FLAG_MSG_IMMUTABLE
- Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com

Changes in v10:

Thomas Gleixner:
	There are big change in pci-ep-msi.c. I am sure if go on the
corrent path. The key improvement is remove only 1 function devices's
limitation.

	I use new patch for imutable check, which relative additional
feature compared to base enablement patch.

- Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
- Remove only support 1 endpoint function limiation.
- Create one MSI domain for each endpoint function devices.
- Use "msi-map" in pci ep controler node, instead of of msi-parent. first
argument is
	(func_no << 8 | vfunc_no)

- Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com

Changes in v9
- Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
- Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
- Remove API pci_epf_align_inbound_addr_lo_hi
- Move doorbell_alloc in to doorbell_enable function.
- Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com

Changes in v8:
- update helper function name to pci_epf_align_inbound_addr()
- Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com

Changes in v7:
- Add helper function pci_epf_align_addr();
- Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com

Changes in v6:
- change doorbell_addr to doorbell_offset
- use round_down()
- add Niklas's test by tag
- rebase to pci/endpoint
- Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com

Changes in v5:
- Move request_irq to epf test function driver for more flexiable user case
- Add fixed size bar handler
- Some minor improvememtn to see each patches's changelog.
- Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com

Changes in v4:
- Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
- Use new method to avoid compatible problem.
  Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
  pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
driver don't support new command, so failure return, not side effect.
  After test, DOORBELL_DISABLE command send out to recover original map, so
pcitest bar test can pass as normal.
- Other detail change see each patches's change log
- Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com

Change from v2 to v3
- Fixed manivannan's comments
- Move common part to pci-ep-msi.c and pci-ep-msi.h
- rebase to 6.12-rc1
- use RevID to distingiush old version

mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
^^^^^^ to enable platform msi support.
ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep

- use new device ID, which identify support doorbell to avoid broken
compatility.

    Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
    keep the same behavior as before.

           EP side             RC with old driver      RC with new driver
    PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
    Other device ID             doorbell disabled*       doorbell disabled*

    * Behavior remains unchanged.

Change from v1 to v2
- Add missed patch for endpont/pci-epf-test.c
- Move alloc and free to epc driver from epf.
- Provide general help function for EPC driver to alloc platform msi irq.
- Fixed manivannan's comments.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (15):
      platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
      irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
      irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
      dt-bindings: pci: pci-msi: Add support for PCI Endpoint msi-map
      irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
      PCI: endpoint: Set ID and of_node for function driver
      PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
      PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
      PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
      PCI: endpoint: pci-epf-test: Add doorbell test support
      misc: pci_endpoint_test: Add doorbell test case
      selftests: pci_endpoint: Add doorbell test case
      pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
      pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
      arm64: dts: imx95: Add msi-map for pci-ep device

 Documentation/devicetree/bindings/pci/pci-msi.txt  |  51 ++++++++
 arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
 drivers/base/platform-msi.c                        |   1 +
 drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
 drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
 drivers/misc/pci_endpoint_test.c                   |  82 ++++++++++++
 drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
 drivers/pci/endpoint/Makefile                      |   1 +
 drivers/pci/endpoint/functions/pci-epf-test.c      | 142 +++++++++++++++++++++
 drivers/pci/endpoint/pci-ep-msi.c                  |  90 +++++++++++++
 drivers/pci/endpoint/pci-epf-core.c                |  48 +++++++
 include/linux/irqdomain.h                          |   7 +
 include/linux/pci-ep-msi.h                         |  28 ++++
 include/linux/pci-epf.h                            |  21 +++
 include/uapi/linux/pcitest.h                       |   1 +
 .../selftests/pci_endpoint/pci_endpoint_test.c     |  28 ++++
 16 files changed, 527 insertions(+), 9 deletions(-)
---
base-commit: a4949bd40778aa9beac77c89e4c6a1da52875c8b
change-id: 20241010-ep-msi-8b4cab33b1be

Best regards,
---
Frank Li <Frank.Li@nxp.com>


