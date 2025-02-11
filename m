Return-Path: <linux-kselftest+bounces-26410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D52A314F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 20:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8D13A6DA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 19:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E162638BB;
	Tue, 11 Feb 2025 19:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y/klokls"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013032.outbound.protection.outlook.com [52.101.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADC2638AC;
	Tue, 11 Feb 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301743; cv=fail; b=k97zgkP5uj7RVK3F1qH5E337/JYZdiYFsh+7NYQaYbcRIWzso0nTbSMGNufTHJX5F7YHbOuQiP1ftMyE7pkqbIvLay68ArfM7SqaZqp8ywG/G2WbcRDmM61qWXl+2ozvpRo5PtzV0TuJz/Kxlj0W3LP7f2zee2bVHkZ7YeP+AaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301743; c=relaxed/simple;
	bh=gL8hiycm2h2s+DeI0YbGrCnGWmOW9FS4xLW6MzCh37o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VFM0suAyUxyPcWlwE+AMr/BQxj30GyD0YoIwrYZ61Ner3EhjzsAaishnfPtkQFNJqn/3ykWniRpKPBmXQfAuqPNM1zlfjPFe6w+57e9VPniP6+DurkxkPlBqLHwyVfPVwoWgLBc0+zwtSyg1NBA5m8rBkvH4IX0iDhoanP/N89Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y/klokls; arc=fail smtp.client-ip=52.101.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwN97h66ZGwGnpjS8mk/DMfx5e9zL9nn/lGPaQh3WO6mNDFUS2YRoXq5Ym0Q68eQsV8hpsnq5+mA4JJKXXvkdgMHikSs3xnwDBjoBms/+fVxxfr9TWvdckUIKjU6Cj64a4+itVejYtkKYPGufPGx+FMl99A2cy1QDZah84nD1Hf06fMfWY/cjG9MDgyVws/HipMYvEcwIHL6dz1deTNAnTeDoUewlR04OM2NbCxBxS/VpIQFjSiLmRLjnNADx4JdxPCMPw9ZMPLVkERWH1UStlmhyNsFDxS1cjwiGKFKqRPUfdSHAtyZJeHdR/2hmPKwMYK83Sdhh6liyG/8WQ0v4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1asdCqkOW/4Zrb/mNGHEJYIluiRzKgOfQ58AvDkDSk=;
 b=yA9IUtIpGgzWIPcTNdlp+aVwjgAHuW1OkKRT1Xwi3H8j0rb6nrTG33Ra/adyI4oGOXnPDFhwyIqAcr0XZpzypvPqXfGzj6/24QxFo9sdoIlDKO1R64Glh6Uooa7vZE86hsERiMkkgKjXG5vWXqBCHl3flcgDTE86hWNNU5MCitl7R/OB6kAlshbKPRGMGWBIifMvxdFWMp9Uhd2qPTalj+peEZnIxFUZJBVcxTvXd4mbqX3LU39lxZ+ADGxc0aQlSHOLhjQXmvklds63EMa5oqnassjZSumCHae3+nJhYludlh7c0AsS+wE7DI5wUuOO5RRJCTbBFdPVUt16QsLhmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1asdCqkOW/4Zrb/mNGHEJYIluiRzKgOfQ58AvDkDSk=;
 b=Y/kloklsjTB3VYvGO3SvOdCMZvL/LpMNVRlZxXoQI+g7WLmnWLrj3X47KpStg44Ig17TY0WlXZ/K8dtq8+Z1Ig0sXmarz3U7/Fgg86sgxh2sJ8IRIn32nBK//sijdZaIPj/WOmaAf3b3OGjmYSnHtUp2GG0zzfJUQPrR6xiELQuUNi6EHbqHt3ihsZtAqFbX9vK5sH3URMiAawXniTV3A9L9KL7lkUlDBl7t4JH0l70+5FBTNQcv5qDguLgSlRAHV3wJNN8XxWH4jxo8+aMI0xw4hPvL+AZCPo6yps7el/JmcT4M75AtIccrgaDmG/1q+6Jx3ykb5DCfMNNYCfgk9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10291.eurprd04.prod.outlook.com (2603:10a6:800:245::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Tue, 11 Feb
 2025 19:22:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 19:22:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Feb 2025 14:21:54 -0500
Subject: [PATCH v15 01/15] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-ep-msi-v15-1-bcacc1f2b1a9@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739301723; l=3043;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=gL8hiycm2h2s+DeI0YbGrCnGWmOW9FS4xLW6MzCh37o=;
 b=FAo7K9hlAHBpQPTBV0xJQxt7P5QO0fPInNcBHP/i/b0VNrpUybCd80x4LWEsRAh8+jdSgV5Nt
 ASO2raLKObUAFJiyapiMNpfcmebZJ09KDCkeUqsl504fDbVHnWNIQOB
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
X-MS-Office365-Filtering-Correlation-Id: 0e88b120-1f54-419b-364c-08dd4ad166f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjRNOHptSHkxRzhUVkUzdUg4U2xaWm94OEVxVnFLcWw1d0paaG5sVGJQSDZn?=
 =?utf-8?B?T1ZuTEg0VjgvRXllbXFHeEJBQ1VRNU1laVNTeFZhUW5VYld3M3c0S0xpcnBt?=
 =?utf-8?B?Ky8vR2F0YmFLb1JOTFVmaVZiRFhtZ08wZWFiZnl1cUdLbmg0eU5KNzlhNEg4?=
 =?utf-8?B?cXNIV2d2cjJZMnAraE9GVHFpRzBQUSthd2ZVT2NuYXZpamxwN2p3RDlOWTg0?=
 =?utf-8?B?Ym9jUFJZSndpaGZwcnpESHdtYkg0N0wrRUpaQW5jcHFHMDVTejRlUjZuTG51?=
 =?utf-8?B?dmJuL3AxVWdkREFWb3duUVd1SkdiYXVJZVBqR01tSWhrU1Z2K1JtMGNDMTZI?=
 =?utf-8?B?b3JYN1VOWlBvbGloVTVpVFREamQ4MURLalo1a01wM1ZGTXAwSk9JWnBsdHpq?=
 =?utf-8?B?V3B2MEhoTVRidURpalRjL1dPNi9hMksxdDllZ0QrQVNZaktEaHdqdUR3Qnhs?=
 =?utf-8?B?NXZwWEovSFFzRkMvL3ZQaGd2cjRIaEtDalRmUnJhRllhbkFud0RBTmtEMUNU?=
 =?utf-8?B?SmN6NHNvMmtaRHdOOUJlc1Fxb0FwQWFBWDJpRnI4RGx3bDJ6cC85OVgwRGls?=
 =?utf-8?B?bURPaW5kN3BKQ0d1TUErd3B5d0VyaDQrWmhHYWdMcXk0S0FsQlhZMkxzdHdq?=
 =?utf-8?B?M2Q2aHIrWHBtMyt4a25adGFzb0t1Ym5uZU5ib0RYUzNRUEtoK0J3S0tUZ2Ry?=
 =?utf-8?B?TG9Kcm92VWxNQnZqMU43ZEVnQTZvVVc5TzJmb0VwY29qamJWU3JZM3lZTUh5?=
 =?utf-8?B?UUFmdUdKYXlicm1WTFBKWWd3dUFwWTY1NXJTVm9EZ1kwc2VNL0hWUjBUM1RY?=
 =?utf-8?B?NC9HMzBVcVJ4TTE4M1VvclVJZmp1b2ZQckh6byswdXFxNU9wTkZ5UzJnRDN1?=
 =?utf-8?B?bjdFZkJDaElFUG8wbXl5bGRmVDZhQVJMalBWSy9abHpURXowR1FoMUVuTnJ0?=
 =?utf-8?B?UEY4STRYL21mZjM1bi9ObEpYWXFaaVgrTlk1MXBhWkcvMWFORzJmUDFUN2dD?=
 =?utf-8?B?ZVUxRUVnaytrSm1mNmxRdzlVbVV3U3Q0Yi9nczJFTjNYSm4vcTBrbWdLNDV4?=
 =?utf-8?B?MjRJTmdyUWE4UE9XalNmR2NmU3JuNEtqT2x2NWhqMkQ2QUlPSVV6TVJidVNz?=
 =?utf-8?B?eWY5dnV1ODRPOS92QkQrYXc2a1R5aVh4cGhocnhCTDBxOTJHekduNFVPalpZ?=
 =?utf-8?B?ajN5R0lEZ0tjeXdnNithMm5Bcnh1aW56UkZhY3NUV0ovVVRPRTkzRzJJa1VJ?=
 =?utf-8?B?eWpZNi9aWjE3eEJidGFvVjhLWjlzMkxUL0JUWGFPNm1wOHpRa1Uzby9uK05Z?=
 =?utf-8?B?bExsY1NqYjVPemFhc0Z3N204VXo2UlVPaXVhVldMdHd3SVJObS8weXBPZXZ2?=
 =?utf-8?B?WjBEdnY5SVJzZTcxS0tkU1dpSGp0SFhRdUE5YjlQcFVoRGc2T0NEKzVNaWN5?=
 =?utf-8?B?WFBNNDkzWUlpMHhjSFUrYjdBaUpleUpXLzd6OHo4R2RzTTRva3owVERKcXo2?=
 =?utf-8?B?TWRXekkzem9xbG1GamR4T3lRc2tsWkZGQ1ltUkFhMk0wanhGRWNiYUZlZEpp?=
 =?utf-8?B?ZW9ONVQvUVVYOXBENTZzYTZnUFlHMDArcS93UnlOWG1ac2NKR1lFWU01OEYz?=
 =?utf-8?B?akRlZ1daQklVbmJ1VFFjblFnNEZMaGdyNUN4ayt2VWxyOFY5d3d3TjJjaTd0?=
 =?utf-8?B?bXk0ZHcza2prcDNBT1Q4NTRxU2NUUFU4U3R3L2tzSS96RlRQY0xnd0oweFg0?=
 =?utf-8?B?bCtzdHVDZ3lNb254M1h3cVpvWFNibWRaY0JZUWFXK1N2OC91cEo1NnJqTUJw?=
 =?utf-8?B?ZlQrMm9iU253dlgzZUNrcjFJRGRTRDlTaGx4UEJLcUpXV1hpOHZnWS9ydVJF?=
 =?utf-8?B?WklTL2NTNHFQS0NRanRRck03U1dpMkNwckxpYmJpSSswbWlhc3FUajB1RWpa?=
 =?utf-8?B?aTdOQUhWMUFxSzNldnZQdEtPc3RKWHR0SVo4eDUwdzAvOUVTTlQwL2orc0d4?=
 =?utf-8?B?emU4UjdrZm53PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3B0Sk9YcGFZTlRmRGEwMjN4M1g0eUk2Ykh3RGtnbEovRG5wNDdiQzRFVE9U?=
 =?utf-8?B?Y2V4UE9nbnFFdDNZMVpCTTdGK25SZ1dQWUlnOFJ5cXh3NjVnbEpvdFBZQjJx?=
 =?utf-8?B?cXRVYXdRQTRBR1FzYVJuOVF1ZUN4OVlXRlBMU0t0c0hWTUUyc21IcjFtYW4y?=
 =?utf-8?B?bWpsWmU4c2E3WGF2NVJGV2dEaTA4Zk0xaVVOWXo4enZpazgzTENNYVpPS3Ja?=
 =?utf-8?B?WFp0YzkwSUVqa1pqeGh1cjdiSkMyV1NOeDI3cEdPbWFkV2hQUnJ2OVhzbWs5?=
 =?utf-8?B?ckxNQWFuL3pMYzJqaXFqNW9nTGM1dklSaFZUOE9HeGc1ZGhNQkNLamdUME1U?=
 =?utf-8?B?WEU3RjkwU1h0VklsaFI2aHZESWNiN0YvOGk0cXNOSDliZDJSc2plMytuRllI?=
 =?utf-8?B?T3NMVXlwZGdyYWhPamF2K201UGcveXRHS1RJcUVQVll3L2I2SUN5b01QN011?=
 =?utf-8?B?cmgrWlFIYlE5UGZGYlNXT21nT2xkYmx3d3VBV0Q0MUxWRHJaUjVvWkhqckpE?=
 =?utf-8?B?Qmo4WXhNTmF5djFMdVZSYW1yVmkvRzJ1cEpRdTFrSFJzdEw0eEhmbDJVODhQ?=
 =?utf-8?B?ZEhVNmxUT2tOaWdQeHNwbmJyd2IzTnNjeTVicnRMUERnemNGd05kK29wSGhB?=
 =?utf-8?B?cGhQUEpsUmZpblJldGlVL2RqS1ptYUZxcHpqZjQrTHJ5U3I0UHYxY0t6UFRP?=
 =?utf-8?B?Z0tmd2pCSmoxL3lqSzFLTXZZcEs1UFBhK0x5QnpsdnJYekxsWUFMNDlvL1Bq?=
 =?utf-8?B?Ulhac3JmTGM5S1lKSmRsano3cHgzNEtkOGxHTS95MENic2tEZnNuZ3Jsc1RW?=
 =?utf-8?B?ZmJ5eHZkbVYyNEVKbHFMaCtkdkhXOEtldEtjSUoxaTBvK215dWpjbXlWdm1I?=
 =?utf-8?B?bEREQXJDcXRCZTZtYTR1d201YzFNa3V4YlFSMjZoL3pzUlA3S3ZXbW42OE0x?=
 =?utf-8?B?TUxsaDNKUHFLWkozaE42NDZqczc2M3Y4cldjR21oSlhvVEdnYmpsMFYxVTI0?=
 =?utf-8?B?K3ZhSGU2Ny9ZaU02SVdKcEd4VytJNHdUbWNPd1hYenppL1AzTDR3RThUSTA5?=
 =?utf-8?B?NDQwRDgxUGxqUm9mYnk2THh4bmIxQXc1OEt0ejFMS1JSUU5hMDhyQjI5d21a?=
 =?utf-8?B?Z2lXWms2dlNOSGZWd25uM05Ta21MdkNxN1lMdXBLUU9aei9wSFM0dlk4d2dr?=
 =?utf-8?B?cmxIbm9kS3lWNnNtbWcxeHU4YnVianlicm1yUUIrU3dlUEo5ZFU3em43TDVh?=
 =?utf-8?B?cmlEaG1zS1p5Sm9LeFo1QmtNTnlzTjBaZTFERnJSUXJUZURTVHNmZ0pGQXpz?=
 =?utf-8?B?N3lBVFFGcVFTSmhpTG16Q2pBdDIwREJud1VaSytHL2NSVTdUNzRES2o4MHFa?=
 =?utf-8?B?dStKd0pCWTFRV2drN25vdEYrVytsTmttNzZ0L1l0aXY5ZTYyUTZMUUVjRmJ0?=
 =?utf-8?B?SFZmSzlveVNXYk5CYS9EL2JzM1VUcFFEZ1ZDWnFWbEYyVHJ1SVFMbTJtOFp0?=
 =?utf-8?B?RDVWRW5PQjBzcXB4KzZ2ejVwcVZsUUE1TlhvMUZSK2UxVXpOaytPV2RlOUcz?=
 =?utf-8?B?RitXTmU0MjI1UllHOFJ6R1Rsbzk5TjAyL0pIVWNKZFdKWExMTmpNaFdNMFZD?=
 =?utf-8?B?ejVRcGxzeWgyQUZzWmVCaVpoL3h0Zk9kaTNPUGRmQTE2OXlMM0ltRDdwZWpp?=
 =?utf-8?B?OTJpNStob2xYRCtXejg2cEtCczcyVXR5c0JXWktteVNRSGwzd29iK1RGenZm?=
 =?utf-8?B?ODBpaXVlYjEvbk5PTTYrNlRsNmpwUWhPdHh6cUNkVnZOaTJhaVRqTGF5Q2xS?=
 =?utf-8?B?cEdocmptZS9kRFdSWllXMlh3ZTJTRWx4OGUzYTQ3VDJFaWJwUHZ6SXVHYjE3?=
 =?utf-8?B?ZXpuWmJCSGY3Q1pENnJ2YXVUQndmbjZMT3NXRTZQVjQ0eXk5WXF4TWxZZVE5?=
 =?utf-8?B?Q2h0ZDZiZ0JHbDdQUUZ4YzRldlpJS2JmRlFkTWlZcEZqa05qNFN0Risza0Fv?=
 =?utf-8?B?cXdzZHVXeloxTFBjL0dKcUs1S3BLZWtvcGkxODMvakZzK0VWNHUzeGNveW8w?=
 =?utf-8?B?OFljRzdZNkVDbUFuczN1TDBLalhqV2h4WGF1dHpxOVRSSytvcHNTWThjOWRm?=
 =?utf-8?Q?xTbllfoVLg/aOfkAeZFfplMZf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e88b120-1f54-419b-364c-08dd4ad166f2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 19:22:19.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRrWgXCKy9U82fdzm35RMR0jDzxY0HsH2qfLhm+nwMuanup+rcL0DXcfxKItegPqcqx64787PC3riR5QtXZkuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10291

The follow steps trigger kernel dump warning and
platform_device_msi_init_and_alloc_irqs() return false.

1: platform_device_msi_init_and_alloc_irqs();
2: platform_device_msi_free_irqs_all();
3: platform_device_msi_init_and_alloc_irqs();

[   76.713677] WARNING: CPU: 3 PID: 134 at kernel/irq/msi.c:1028 msi_create_device_irq_domain+0x1bc/0x22c
[   76.723010] Modules linked in:
[   76.726082] CPU: 3 UID: 0 PID: 134 Comm: kworker/3:1H Not tainted 6.13.0-rc1-00015-gd60b98003b43-dirty #57
[   76.735741] Hardware name: NXP i.MX95 19X19 board (DT)
[   76.740883] Workqueue: kpcitest pci_epf_test_cmd_handler
[   76.746212] pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   76.753172] pc : msi_create_device_irq_domain+0x1bc/0x22c
[   76.758586] lr : msi_create_device_irq_domain+0x104/0x22c
[   76.763988] sp : ffff800083f43be0
[   76.767313] x29: ffff800083f43be0 x28: 0000000000000000 x27: ffff8000827a7000
[   76.774466] x26: ffff00008085f400 x25: ffff00008000b180 x24: ffff000080fc6410
[   76.781624] x23: ffff000085704cc0 x22: ffff8000811c8828 x21: ffff000085704cc0
[   76.788774] x20: ffff000082814000 x19: 0000000000000000 x18: ffffffffffffffff
[   76.795933] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   76.803083] x14: 0000000000000000 x13: 0000000f00000000 x12: 0000000000000000
[   76.810233] x11: 0000000000000000 x10: 000000000000002d x9 : ffff800083f43ba0
[   76.817383] x8 : 00000000ffffffff x7 : 0000000000000019 x6 : ffff0000857e443a
[   76.824533] x5 : 0000000000000000 x4 : ffffffffffffffff x3 : ffff000085704ce8
[   76.831683] x2 : ffff000080835640 x1 : 0000000000000213 x0 : ffff0000877189c0
[   76.838840] Call trace:
[   76.841287]  msi_create_device_irq_domain+0x1bc/0x22c (P)
[   76.846701]  msi_create_device_irq_domain+0x104/0x22c (L)
[   76.852118]  platform_device_msi_init_and_alloc_irqs+0x6c/0xb8

Do below two things in platform_device_msi_init_and_alloc_irqs().
- msi_create_device_irq_domain()
- msi_domain_alloc_irqs_range()

But only call msi_domain_free_irqs_all() in
platform_device_msi_free_irqs_all(), which missed call
msi_remove_device_irq_domain(). This cause above kernel dump when call
platform_device_msi_init_and_alloc_irqs() again.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 5o v15
- none

change from v13 to v14
- bring back from v9 and remove fixup and cc stable before it is new use
case.
---
 drivers/base/platform-msi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0e60dd650b5e0..70db08f3ac6fa 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -95,5 +95,6 @@ EXPORT_SYMBOL_GPL(platform_device_msi_init_and_alloc_irqs);
 void platform_device_msi_free_irqs_all(struct device *dev)
 {
 	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+	msi_remove_device_irq_domain(dev, MSI_DEFAULT_DOMAIN);
 }
 EXPORT_SYMBOL_GPL(platform_device_msi_free_irqs_all);

-- 
2.34.1


