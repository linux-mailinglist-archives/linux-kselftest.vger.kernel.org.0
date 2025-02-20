Return-Path: <linux-kselftest+bounces-27109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAB1A3E587
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907ED7A4BD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D302116F6;
	Thu, 20 Feb 2025 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YrL3a7f4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929BC264F85;
	Thu, 20 Feb 2025 20:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081706; cv=fail; b=k8HpraaYggqO0O5zHmSomgDQeYF9keZGhdB/GESSIUQ8+lsX7j5kaHTbcHGslTmFxEYtGiuMVw8XSZlwftoINLHFnQ1Qsx/LbNvhRUPtzVwQoqz65oZGw1E0cGtsCxC0d4E/XP5+MQsUWnvoNXqhK+AdjXbsrYBADjT5BhqJAZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081706; c=relaxed/simple;
	bh=T8Kgf5PJUbsGyS0RTu6Q8X2S0g5inOHxt7RDduXNSBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4kC1CfU9kd5GjVUbZCdcZ/W91CxjK1FpGaQ2eaeyh6s5PIelVaT+nfDvAEFeVBoA2UPORVKzz6kCdjfDhg7bDCs5lO5Dh/ugJba/xq6cCUqmFdy5Jbog5RCGFoxUOn9PSYX7Iu0TEGJ4vFmbnhlFV9JFIR/lxqmABbJtZiFzec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YrL3a7f4; arc=fail smtp.client-ip=40.107.105.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oi0kNcAxgT9coOGxBPa6sDCThVzNc6ZqbJgTD+B0hHWcERvozPbtj4tj7/XH3DAvb5sWfugLVBv6rF1v2EnKoX/kFEe8mq70MBh5s29XYVk9P71jXfaKLmlvAvWre6qiEXqA+QudKGSCOPkLrdmD6+/kE92EV7R0NzG9Ypg4nPk7j2JL+Whwh6chgzgY5Iz6+yMOw3OWUR0CCxEzgPIM1KcY9QeIKthVlqOwAfAWbwCxq6VS1Q0+mVF+N/ZnCXn9wUEjUKFmSLXevJiIYyaTMX8KQCsp6XWFR7zhuteFDI/ch5bXaTrxaXGudNGNC7YVEdyEVLyhs7+Wty0cHBQjsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+lIbTSbIDpfC50YKMquZV4u1BLWaBEX1pFbxjijc6c=;
 b=SnD2kaEN9I+Y3LozCSRItrz7d1obL2pHGbhLuw+uEP37OylnF22d+ZYfRxzbMOjIYqG4iyvgSNbufznIAuKK/N9n3HQJa1K1LuXCu9n3QToeXv2HSdEyLboV33/jucRX2siwr0u4/D1U+M9nGIURtLA/q8jfRli0QiR1u0yC1GfCl46vb2yc8sLeJ3LzfuvXvO39mM+gP+7C3AM6Qv6UJD6HkOtojFZGPkLo3b/1h0nge8m9j2ov9DxvxkKF1HtHgxxNDUbPeZmhnjmBgbscjLwF4Uc3x23vDMJczfOwADPNroEsobTIknFgrQHI8+4F9+xKF731yxCdzTiiikwAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+lIbTSbIDpfC50YKMquZV4u1BLWaBEX1pFbxjijc6c=;
 b=YrL3a7f4SopdHjBnMhqMHUCHoeL0x9lUqnpNmdy5YfMt4fag7seUQ2wFwYWk9n6PM5/j/6kxj+XqEBmAfNtLjYQqUQAkytoscnTIOXnz8AokuMsvfmz1KuFRHpwDCiX4kTyDGFksNZiHyd5eyoXbCCQVxDLqcbiXkmzwKVn62pafllp+YW0dy0ofeglOtX9pGse5zxLxC1Fxc/nDJhKf3ZAKUAjtyHuDIU0uAIMUbuER/+wsSqagkvKuXk63meOU68R15v4DWZzjTWN91ep98O8GGNGvALsN2H3kU/muCGJioa0psvh3UxNH6OrjEHQbtwiRMn3FOVvsZyEsYihfkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB8062.eurprd04.prod.outlook.com (2603:10a6:102:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 20:01:39 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 20:01:39 +0000
Date: Thu, 20 Feb 2025 15:01:10 -0500
From: Frank Li <Frank.li@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH v15 00/15] PCI: EP: Add RC-to-EP doorbell with platform
 MSI controller
Message-ID: <Z7eKBsxrmthtElpz@lizhi-Precision-Tower-5810>
References: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ad40b-51bf-4a19-e74b-08dd51e95a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em96SDkxeFRhWGszdXJwSklWMDd3aExIWDJVamhqeEsxc3V0VlBXOHhHRDhV?=
 =?utf-8?B?MC84d0tmaG5rWUY1UjRkVGlwdUQybHREazRKRklTd2pGbFJkQUpWdWVheER6?=
 =?utf-8?B?VjZZazFNcXZIdGN2TGllVmFHbUhQbmg2UHlCVFVkQTFYa1RhS0NlbGIzZk9S?=
 =?utf-8?B?cStJVFhDbjdsZGFYMmJKTEJZQ01NbE0xbGRVR0FTTGZFNjF5aktrQU5zUFlt?=
 =?utf-8?B?SklKZDdaT0FYVHBDNUZDZS9tanR3ejlLMVlUaWZuNllxUjI1OGF3SkFVSUtm?=
 =?utf-8?B?bjhBZjQwS3U5aG5BRVlJWEJjTUsrZ0I3YlZQQUIzdDRSTW5RWjRYZXRJdzYw?=
 =?utf-8?B?M2QyZWJLV0NkeStEamlYbjEycFVKa2VOMUllUXFNZ09adWNqbkVDMkFPaHBD?=
 =?utf-8?B?dS85TkQ3SDI3cXVYRHJ4Z1RRQmRoUVJzUHQzZTJYRGN6YWorNTI5b2txTW4v?=
 =?utf-8?B?Z0dwZE9aTHp2WXAzb05NNEVGV0Vpb2MwcUk4ZmlHVDc1cEo0QzRUZFlYcml2?=
 =?utf-8?B?aUJTY0FOMzZqVlZiQ24vdGl3UjBzcExaNm56NHhORWdJTDh1b0ZFazlEMHZU?=
 =?utf-8?B?cGFNVHd6VDF5SDl2alFhcmFBWDRQa210UExybnA1RDBtblFEekxSUW1KNGpv?=
 =?utf-8?B?NWpoVUhrWWk5Tzg1L05IUjFjUGFlb0VlVUdTSVEvbzFmeG9Sd3lqaVp3VnZP?=
 =?utf-8?B?WXZKc1ZsOWRiblQzOVJMeG0yYmxLTDlZWjlJeHhoUTYvMW1LQnhuWXA0UTBF?=
 =?utf-8?B?WVkyOE1ZV3U5TXNiYThaUjRzSjFRWng1bXNyQVoreCs0Q0V0SERucStzRkN5?=
 =?utf-8?B?R2FLejRqKzZaQlN2UEsrdmpwTDFZS0paUkNTeU02U0sxVE1yU0dKMStJMGk1?=
 =?utf-8?B?S205TWI5V3drZ0VSV3U2dStNWmhrem1ib284U3J0cjRJb1ZGb0IvVEcrUmZM?=
 =?utf-8?B?WHhnQkY5bllNVGJhTmRRV01EUEkxRVRuenh3WXpZMWxPaUlvcG14aS9qaEgv?=
 =?utf-8?B?OThZU0FJK2MxSk9PSGZKM0c0YklHZHlES3ppR0lHYVFWRUdteXI0OC8xWUVu?=
 =?utf-8?B?azBCWUM1cE5rdm5GanR0ZUVwTUs5R3NYUTFiWnhHUnl1OHg1UyttN0hqTHEx?=
 =?utf-8?B?VFl4Ykt5Z1J1MlRRczlsTklmb2hCSW0wMnFUTEpHdTduYTJVM2JQM3JtbmZh?=
 =?utf-8?B?bmgyVTM4djRETXppOTJtYk5CMUgxTzFNdzlhVmdhZ3FWNHp0dEpLbEwrRDVy?=
 =?utf-8?B?a3EzQzNnYkh3bm80MWZlZm05ZTEzWXNOR0RoT1p3dFpZaExKSys3eWthUks0?=
 =?utf-8?B?d2V3ZzRUcUtCdDlNWnhXcUJDZHdBSmp6cmorSE1zaWkrSUR4TFJLdkREQksw?=
 =?utf-8?B?V1hUU1BFT3BIQVJjcSs3RnQzLzdKRmd6RVFnWll3UjI5VGZndGVlSzc1V2hx?=
 =?utf-8?B?SUg1K1oralFxNWtVT0xzWUFNckxjSWNTYmkzMVNaUWZ1SE94UTY4OGZTeGhL?=
 =?utf-8?B?cGlldUdjeWRabEhjVjVlYnpXNHFDUlJvWjFFTWk5ZVI1TE1nVWMzeE1hRzVX?=
 =?utf-8?B?RjIwQVcvY1VFM2p3c2hmY2xucGhWeWYydWRIRUpHRE03ZXJjYncwY1NBci9K?=
 =?utf-8?B?TDBzSkRVMWluMG14dVAvU2E1dFBWdWZCb2JNUTRUakU2UUM1YTJVeHBORVZI?=
 =?utf-8?B?b0FPWDJrQVNnVWZCN1BwRGlFUzBwZXlMMWV0SEkyQ1F6RWo5U3VWVGozYVAz?=
 =?utf-8?B?U1QrZUVlVEs0YThlTitVR0NjZUFpcUQ1cER2R25XdGJEdHVqWi8zeXBZR3Fp?=
 =?utf-8?B?S0s2VnVQK0ZMay9QOENjMUpqVkxyd1Z1ZHVvTFFWSi9LcnlvQStKNERLcUNL?=
 =?utf-8?B?MVVLbmRHNEtRWU85WjRrREVQSlFlY3ozamI2RW1XSmpQQmNQUkRhMDgzbnhF?=
 =?utf-8?B?ZHNJMk4wZ25qWnZWNWh3cERWZ21TdlVuYW9nQkZ2NUU0eFhyZ3A2RmFwaDdE?=
 =?utf-8?B?SmdlanhsMVlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUtKYjN0QXNQVG9hTzFQSkU4MThVYUVMT2NITmdicm5XbmFZa2JWVVdwTUtT?=
 =?utf-8?B?OExQTTY5eXFCM1hwakd5NzFuQ0lnaXUzY2hxajFwT0ZVbGptVzh0Ykl6YTQ1?=
 =?utf-8?B?eE8xM1plWGNVNFlQS2dUeUJPVS8rVjcwYWVUbG4yYWc2ZEpBYzhVMWFwaDFL?=
 =?utf-8?B?b3pyTHNpVEhFaVJEWStxWHBPS1RlbnZFTGpCU2Q0aHVzZmxYWVpKS2x3cnpN?=
 =?utf-8?B?Y3FtcmUzVFJtWkM1K3cvQXQ3VTdOY2RrcGEzR21xRnZCbTF3SzY3QkZmeHhq?=
 =?utf-8?B?WGZ1RVoycHg3dDZVQ2I2a29QT0plZERMNU5vdk11Uys4UWYwaWw5c0QyTGxH?=
 =?utf-8?B?aVVCTWJVU21NNUFJaHRIYlVkanc2cEZNZWdic1RmR3RCRGt2Rm9JUjEvYkIr?=
 =?utf-8?B?N3FVSkZOZDNBaEpSZlFlOE0rVTN5RDlOcEF0Rlp2MzZuSGNNbENDVGszcUph?=
 =?utf-8?B?L0h0VWdyQWk1OS9qK1dHMFdmbzlEV0V4dXdPT1ZBbXZGRjlkVDZiL1NBS09v?=
 =?utf-8?B?dUUwUGt2cVdVT1FUNjNuL0JoTGRjbCtMOEErNzJ1RkIwRHprMjg1M3FKYTZm?=
 =?utf-8?B?WXlNUldLRTYvLzVVZGprdmtMcUZDanBDYnNObHQ1aSswbUJ5MVVPeWY4MHFQ?=
 =?utf-8?B?S1RyWFlnTmdieVJJTm1LQ1ZJUlIvVGxMUlp5UEVEZ2J2ZXkrLy9WYVRhcFJ5?=
 =?utf-8?B?S3U1YksrMmcwTVZUdmhqNk9Delorcm1rbFhkL09rRStIY3M5bU14bGJuZXR0?=
 =?utf-8?B?WWo1SDlvQ25xeWx5YVoraHdkWGs5R012UzFHa21iMmlRRXh0YzVWajh4dWxD?=
 =?utf-8?B?VjM1d1hWMk1pZ2Y1clJhWDJmV1FFWDBWTnpxME1hUFV2NzU5LyswbHJYdm9C?=
 =?utf-8?B?eXUzb3dlR3hMVWlYbHprQy9PNW9LV0JPZFV5dVR2OWlGbVRrYzBNekt1MFFT?=
 =?utf-8?B?RGVpclNlWlA5WUg4RXVZRHJERFc0ZDdWY3VTcTlsakpRV2JUVzdycHBDaFBh?=
 =?utf-8?B?eFVlQWRiZDNRQlptZmE1TXJacFU5TjMrODdRbnZBQlNtcncwc0YxcWZUcWtq?=
 =?utf-8?B?WXRFeHE2RVVLOEI3ZmVUVTM2dXVpRVNVRERMc2RxNDlKeXJ3dEREdHNmaThr?=
 =?utf-8?B?TEZpQ295V1QzMmtoeVF1K1JiWE1ENno4Q01mcHBtMFR3Z3owbFJxWWxENnc3?=
 =?utf-8?B?ZlFGN2xIQVpmMTNMWlZhNjNjTlhEQnREK1ZFZUU4dkZYRjI5dndiNjAzM0lG?=
 =?utf-8?B?V2x2SG0rUzA4dE9xTHpiajhmQk0vUy9NZlZITkowOStrdGt0VUZpa1lGcWtK?=
 =?utf-8?B?cEZabmRST2FxaGpiWWtiUmkvT3JMNWM0ZXRTY0NLTk4wV1YyeWJkVC8rL3hO?=
 =?utf-8?B?ZlBBQjh1UTZPMzVNKzNWVTVXMDczT3dnOXJoU0JaUG85bk4yTHErcEFKeitt?=
 =?utf-8?B?TDZEQWtkWjZLQjdCc0pjMndUeU1qVnVYekdKc0sxL2YzRGUvUkdpM3hqdmNT?=
 =?utf-8?B?cHBMcnJFMzNFL09oZ3VDUHIxNjEva01uczlEK0dFRGIvRmNJaXdqYXN0L1o3?=
 =?utf-8?B?Y3BvQlZackhMUWZNKzF5ZDBWUmc1K0cvcVU4TlB0NDlPV1RLZTdjbktDVWU0?=
 =?utf-8?B?ZmQwWFdJQ0VwOXNRNGl2bEgrSUxpcDgvVEVXbXB0RTlYZEF3aU1FK2VhcmRE?=
 =?utf-8?B?U2EvZnlzajBySVhFUnhtOU8xSm83SlFCREZLeGdiVTRYVU12QTYvbmtzZVlu?=
 =?utf-8?B?anlNNk1MVm1RcWJYNGFyQm1teWpucFluWlAxaHlBUy84OUptQWVDeFB1T2p2?=
 =?utf-8?B?ckQ2QlV6d2tIRXVGYlhJN0lWVThjcWdxYUl5M2IyMmhweUxDR253WUtJY3ZK?=
 =?utf-8?B?anEwby9MbGU1ZlRsMHFraElmVzk3Ti9DREtjbFljem9DKzRHT3Y3dEZUczRP?=
 =?utf-8?B?dFovWnMrOTVQWjNqS2ZqdkZkQXR2MmxKV3gxMUdHL1FQaFRTNkR5dldKQ2pv?=
 =?utf-8?B?QzloT1QvUURTbU8xbkJKakcyZTlhWGJ1VUloS3Fac3ZuVzg3VUtvS0VyR0lC?=
 =?utf-8?B?eTJzbXlwZEdybWlMQXlsNU5lbElVK0l0UDBzekdaY3QzRDlCQXlhWGhPekxi?=
 =?utf-8?Q?Z/dAf2+No/paEg2usQ04fkZMY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ad40b-51bf-4a19-e74b-08dd51e95a5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:01:39.7703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdRVtxAX0WEiTwJtauTG5eWum9wiFbhnOw5mpkx0M1kbK7c8eZKMSKWlDGyBdF1jbRHAtwnRK0xrld15q4QmHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8062

On Tue, Feb 11, 2025 at 02:21:53PM -0500, Frank Li wrote:

Thomas Gleixner and Marc Zyngier:

	Do you have any comments about irq/msi part?

Frank

> ┌────────────┐   ┌───────────────────────────────────┐   ┌────────────────┐
> │            │   │                                   │   │                │
> │            │   │ PCI Endpoint                      │   │ PCI Host       │
> │            │   │                                   │   │                │
> │            │◄──┤ 1.platform_msi_domain_alloc_irqs()│   │                │
> │            │   │                                   │   │                │
> │ MSI        ├──►│ 2.write_msi_msg()                 ├──►├─BAR<n>         │
> │ Controller │   │   update doorbell register address│   │                │
> │            │   │   for BAR                         │   │                │
> │            │   │                                   │   │ 3. Write BAR<n>│
> │            │◄──┼───────────────────────────────────┼───┤                │
> │            │   │                                   │   │                │
> │            ├──►│ 4.Irq Handle                      │   │                │
> │            │   │                                   │   │                │
> │            │   │                                   │   │                │
> └────────────┘   └───────────────────────────────────┘   └────────────────┘
>
> This patches based on old https://lore.kernel.org/imx/20221124055036.1630573-1-Frank.Li@nxp.com/
>
> Original patch only target to vntb driver. But actually it is common
> method.
>
> This patches add new API to pci-epf-core, so any EP driver can use it.
>
> Previous v2 discussion here.
> https://lore.kernel.org/imx/20230911220920.1817033-1-Frank.Li@nxp.com/
>
> Changes in v15:
> - rebase to v6.14-rc1
> - fix build issue find by kernel test robot
> - Link to v14: https://lore.kernel.org/r/20250207-ep-msi-v14-0-9671b136f2b8@nxp.com
>
> Changes in v14:
> Marc Zyngier raised concerns about adding DOMAIN_BUS_DEVICE_PCI_EP_MSI. As
> a result, the approach has been reverted to the v9 method. However, there
> are several improvements:
>
> MSI now supports msi-map in addition to msi-parent.
>   - The struct device: id is used as the endpoint function (EPF) device
> identity to map to the stream ID (sideband information).
>   - The EPC device tree source (DTS) utilizes msi-map to provide such
> information.
>   - The EPF device's of_node is set to the EPC controller’s node. This
> approach is commonly used for multi-function device (MFD) platform child
> devices, allowing them to inherit properties from the MFD device’s DTS,
> such as reset-cells and gpio-cells. This method is well-suited for the
> current case, as the EPF is inherently created/binded to the EPC and
> should inherit the EPC’s DTS node properties.
>
> Additionally:
>
> Since the basic IMX95 LUT support has already been merged into the
> mainline, a DTS and driver increment patch is added to complete the
> solution. The patch is rebased onto the latest linux-next tree and
> aligned with the new pcitest framework.
>
> - Link to v13: https://lore.kernel.org/r/20241218-ep-msi-v13-0-646e2192dc24@nxp.com
>
> Changes in v13:
> - Change to use DOMAIN_BUS_PCI_DEVICE_EP_MSI
> - Change request id as  func | vfunc << 3
> - Remove IRQ_DOMAIN_MSI_IMMUTABLE
>
> Thomas Gleixner:
>
> I hope capture all your points in review comments. If missed, let me know.
>
> - Link to v12: https://lore.kernel.org/r/20241211-ep-msi-v12-0-33d4532fa520@nxp.com
>
> Changes in v12:
> - Change to use IRQ_DOMAIN_MSI_IMMUTABLE and add help function
> irq_domain_msi_is_immuatble().
> - split PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check to 3 patches
> - Link to v11: https://lore.kernel.org/r/20241209-ep-msi-v11-0-7434fa8397bd@nxp.com
>
> Changes in v11:
> - Change to use MSI_FLAG_MSG_IMMUTABLE
> - Link to v10: https://lore.kernel.org/r/20241204-ep-msi-v10-0-87c378dbcd6d@nxp.com
>
> Changes in v10:
>
> Thomas Gleixner:
> 	There are big change in pci-ep-msi.c. I am sure if go on the
> corrent path. The key improvement is remove only 1 function devices's
> limitation.
>
> 	I use new patch for imutable check, which relative additional
> feature compared to base enablement patch.
>
> - Remove patch Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> - Add new patch irqchip/gic-v3-its: Avoid overwriting msi_prepare callback if provided by msi_domain_info
> - Remove only support 1 endpoint function limiation.
> - Create one MSI domain for each endpoint function devices.
> - Use "msi-map" in pci ep controler node, instead of of msi-parent. first
> argument is
> 	(func_no << 8 | vfunc_no)
>
> - Link to v9: https://lore.kernel.org/r/20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com
>
> Changes in v9
> - Add patch platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
> - Remove patch PCI: endpoint: Add pci_epc_get_fn() API for customizable filtering
> - Remove API pci_epf_align_inbound_addr_lo_hi
> - Move doorbell_alloc in to doorbell_enable function.
> - Link to v8: https://lore.kernel.org/r/20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com
>
> Changes in v8:
> - update helper function name to pci_epf_align_inbound_addr()
> - Link to v7: https://lore.kernel.org/r/20241114-ep-msi-v7-0-d4ac7aafbd2c@nxp.com
>
> Changes in v7:
> - Add helper function pci_epf_align_addr();
> - Link to v6: https://lore.kernel.org/r/20241112-ep-msi-v6-0-45f9722e3c2a@nxp.com
>
> Changes in v6:
> - change doorbell_addr to doorbell_offset
> - use round_down()
> - add Niklas's test by tag
> - rebase to pci/endpoint
> - Link to v5: https://lore.kernel.org/r/20241108-ep-msi-v5-0-a14951c0d007@nxp.com
>
> Changes in v5:
> - Move request_irq to epf test function driver for more flexiable user case
> - Add fixed size bar handler
> - Some minor improvememtn to see each patches's changelog.
> - Link to v4: https://lore.kernel.org/r/20241031-ep-msi-v4-0-717da2d99b28@nxp.com
>
> Changes in v4:
> - Remove patch genirq/msi: Add cleanup guard define for msi_lock_descs()/msi_unlock_descs()
> - Use new method to avoid compatible problem.
>   Add new command DOORBELL_ENABLE and DOORBELL_DISABLE.
>   pcitest -B send DOORBELL_ENABLE first, EP test function driver try to
> remap one of BAR_N (except test register bar) to ITS MSI MMIO space. Old
> driver don't support new command, so failure return, not side effect.
>   After test, DOORBELL_DISABLE command send out to recover original map, so
> pcitest bar test can pass as normal.
> - Other detail change see each patches's change log
> - Link to v3: https://lore.kernel.org/r/20241015-ep-msi-v3-0-cedc89a16c1a@nxp.com
>
> Change from v2 to v3
> - Fixed manivannan's comments
> - Move common part to pci-ep-msi.c and pci-ep-msi.h
> - rebase to 6.12-rc1
> - use RevID to distingiush old version
>
> mkdir /sys/kernel/config/pci_ep/functions/pci_epf_test/func1
> echo 16 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/msi_interrupts
> echo 0x080c > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/deviceid
> echo 0x1957 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/vendorid
> echo 1 > /sys/kernel/config/pci_ep/functions/pci_epf_test/func1/revid
> ^^^^^^ to enable platform msi support.
> ln -s /sys/kernel/config/pci_ep/functions/pci_epf_test/func1 /sys/kernel/config/pci_ep/controllers/4c380000.pcie-ep
>
> - use new device ID, which identify support doorbell to avoid broken
> compatility.
>
>     Enable doorbell support only for PCI_DEVICE_ID_IMX8_DB, while other devices
>     keep the same behavior as before.
>
>            EP side             RC with old driver      RC with new driver
>     PCI_DEVICE_ID_IMX8_DB          no probe              doorbell enabled
>     Other device ID             doorbell disabled*       doorbell disabled*
>
>     * Behavior remains unchanged.
>
> Change from v1 to v2
> - Add missed patch for endpont/pci-epf-test.c
> - Move alloc and free to epc driver from epf.
> - Provide general help function for EPC driver to alloc platform msi irq.
> - Fixed manivannan's comments.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (15):
>       platform-msi: Add msi_remove_device_irq_domain() in platform_device_msi_free_irqs_all()
>       irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and irq_domain_is_msi_immutable()
>       irqchip/gic-v3-its: Set IRQ_DOMAIN_FLAG_MSI_IMMUTABLE for ITS
>       irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask
>       PCI: endpoint: Set ID and of_node for function driver
>       PCI: endpoint: Add RC-to-EP doorbell support using platform MSI controller
>       PCI: endpoint: pci-ep-msi: Add MSI address/data pair mutable check
>       PCI: endpoint: Add pci_epf_align_inbound_addr() helper for address alignment
>       PCI: endpoint: pci-epf-test: Add doorbell test support
>       misc: pci_endpoint_test: Add doorbell test case
>       selftests: pci_endpoint: Add doorbell test case
>       pci: imx6: Add helper function imx_pcie_add_lut_by_rid()
>       pci: imx6: Add LUT setting for MSI/IOMMU in Endpoint mode
>       arm64: dts: imx95: Add msi-map for pci-ep device
>       arm64: dts: imx95-19x19-evk: Add PCIe1 endpoint function overlay file
>
>  arch/arm64/boot/dts/freescale/Makefile             |   3 +
>  .../dts/freescale/imx95-19x19-evk-pcie1-ep.dtso    |  21 ++++
>  arch/arm64/boot/dts/freescale/imx95.dtsi           |   1 +
>  drivers/base/platform-msi.c                        |   1 +
>  drivers/irqchip/irq-gic-v3-its-msi-parent.c        |   8 ++
>  drivers/irqchip/irq-gic-v3-its.c                   |   2 +-
>  drivers/misc/pci_endpoint_test.c                   |  81 +++++++++++++
>  drivers/pci/controller/dwc/pci-imx6.c              |  25 ++--
>  drivers/pci/endpoint/Makefile                      |   1 +
>  drivers/pci/endpoint/functions/pci-epf-test.c      | 132 +++++++++++++++++++++
>  drivers/pci/endpoint/pci-ep-msi.c                  |  90 ++++++++++++++
>  drivers/pci/endpoint/pci-epf-core.c                |  48 ++++++++
>  include/linux/irqdomain.h                          |   7 ++
>  include/linux/pci-ep-msi.h                         |  28 +++++
>  include/linux/pci-epf.h                            |  21 ++++
>  include/uapi/linux/pcitest.h                       |   1 +
>  .../selftests/pci_endpoint/pci_endpoint_test.c     |  25 ++++
>  17 files changed, 486 insertions(+), 9 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20241010-ep-msi-8b4cab33b1be
>
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
>

