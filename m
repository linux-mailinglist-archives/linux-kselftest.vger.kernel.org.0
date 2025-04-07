Return-Path: <linux-kselftest+bounces-30316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA9DA7EE31
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994921895634
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB461258CCA;
	Mon,  7 Apr 2025 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fpw1u9BC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169312566FA;
	Mon,  7 Apr 2025 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055542; cv=fail; b=Z4mKFx31IM9O8LwlzkMOQGise2S9oBD0xKIftLgbtj/oBOJU9Qq7GA2gdlMmgD9G2nZPUxoM+TVYEYOHvbn8LeimmLTOcA11bwMSrtSNIm4pOqkGf/gvl0YQ9ffkmjRJMNqisnMaI8DgJoAnbtgzDgXaoJ5B8q4ZIr+qlSfioqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055542; c=relaxed/simple;
	bh=+SgZEl+0x0mkZbAhvLt5Evhno7zgilVYjrIje6KjXVc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AsIskYyeC69Pe+lsE6QgQDJMuQWmHcPwlLyhCcCUtBKvA92EURE/nzz2by3dBKNrCn6CoZHmRQvwakzIj1Ps6YMjr7bRmsd1RC27KcT22CQ/xduCzx6f6S/XEuJw2xYPwjH4oTuNFML7eflm3ouqKoDhWdJ5/DqPW1xB9HUoKfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fpw1u9BC; arc=fail smtp.client-ip=40.107.21.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rq72KNCU/a6+zSCxxJwgI9AE2ltFQL1g2Iuy88b5g37tTRsUNjinAR7Za4czRo/RJyXm+lTiNgu2+AjRUqSisznYXw08k/GtiGhbfufmPLmUxqoTvJoYGPSucaSmcAGFZNhUjXOWuacdaIchy9MQz+/r8CR1nyIDGEJRmRC9IB43ouHo4B2j0OTXXR0c6mYX9J4BYRH1L6v5GLDV4+Vcf77eTZASLU8pK26ouQpsJeLQr5P2vBvpMGYTFbcPb4Hb37DtOeE5IlDiqcnBBpbfEpGN5WX9HV1OYtjfuFjdhMKU3ZW4Ii3SDWRFxVp7iK3nBZaTPl3RI3EEopbfgVDGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mO0i/b34tXG//kvU4HGnKVOSOCmwct33MArJWNqY/sY=;
 b=QG9+i4vhSz9jeOhQ6AiUSNMA8cl3GJjkyY0o6jrXF4Cuqvg2xQaoBLcrKua3TzbDXGMIJiWuwDvygLVSsxEvcLHEin+9RhyPUcN3BKbOQCjH07Dw43Pqz4aSTT/h3prnWH1HJkwHRdsSBLgEKUXqGxYyYbsANuclPOkilV1qKMkwfuO4KNOBcIor3vxtkRc4eu/bbXsEAWC+FCKUVssuxGyVrHJ22AyxCgaKK3ALFaeYX7BOQ8zExKBZRghHDwTCsVhxjUDxsjTJwHxU8/oDQlsGolM9z0z9vR/kDKz7tTbWhuEE94HuPAMG/9NirAwF4CqltLUDUKvqKaM4ZO97oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mO0i/b34tXG//kvU4HGnKVOSOCmwct33MArJWNqY/sY=;
 b=Fpw1u9BCSwy8xFz++T01AS1+R79wzb+/DVYAMQYt5KO1AtSfpJJuY07lRUvCax/S5qLePL7QaqTFHzFUADTU9GZ1b+O5UpNpCJreOXQ4jmCJtMOqfp9ynpCsmmQpcf/XMp4TbbAT+Yy38xL0itN0nAY/DxR7a7xaHcJpLy4xa/Skxm6GVaCPhSjYtk6QJImsE7PyJIDPQuH3IL7i9jVD4MZKLqPAQxFMWsJucJ51BTiQSIAaZhWBtiKMzna+855vv76gSxVtserdYJQQhJdR4SOhxcVNqsOSHxC6266NcYbTSAqC26pOKNxv8WGsX5ovOlQgTluiwnBfXi+2Xji8vQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:52:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:52:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:51:02 -0400
Subject: [PATCH v17 12/15] selftests: pci_endpoint: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-12-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=1300;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=+SgZEl+0x0mkZbAhvLt5Evhno7zgilVYjrIje6KjXVc=;
 b=lFDtqU4A0MnBXndoG2ULwuCm04/pUNkF6jinLSs4lMRAKb4hoKHqnUMogC3vSqH3VMk98CYdx
 MxUZQc2M8QkDczSlw2jT/S8fPotVRc7z/Cev4jH8bk9Qw46CxHv4We3
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
X-MS-Office365-Filtering-Correlation-Id: 2b89c8dd-a8f0-495d-7848-08dd760db352
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmZzZlJWMDFVZUthMkwvckxqTUxISnpHcGJ2YmI4WEFhMEczaEYzTld6MEN5?=
 =?utf-8?B?My9BamRJY3BGWXIvT0hEajQ1MDJpOXhwc3ppSEdzQm5NeTRueWlZQ3F3WGw0?=
 =?utf-8?B?OUxZYjl6MVVDQ1hzbWNQdlZNTXEvT3FpdmdXWjlXeC96MGxsbDdGSEdCRlJj?=
 =?utf-8?B?Tk93Rmh1dnpyMGZyYUkzUGtEVkpUY1ZQUlpvMnB4M21DRG1SaGFGTlFJT09B?=
 =?utf-8?B?Q09LM2ZFUGVsNHllVm1uald5SVd6NWROcXQ5bkxWamV5RFY3UVExaEdNbGpD?=
 =?utf-8?B?ZE9jcUpxZ3Uwa1BHUm9DbDU5MXpyQkZwZk41VWIyS3ZST0RCZTJYcTE3SW5t?=
 =?utf-8?B?ZFVIU2dNZWNXR083VW1wUGcySFhxcFBBaWFPYnE3c1UxL252TERrSE5KeCsx?=
 =?utf-8?B?am9ocVltOGJkWTdjMjFhWDViUXBST3Zza0Q3cm9uT3JuKzc3N0lrQ2ZXTDJX?=
 =?utf-8?B?WGJjS3g4aW1jK1YrQzRhRmVjUVB2TWhqMWJpaEw1dlBhem5qM0JScTdnc2tn?=
 =?utf-8?B?NStjeCtZczk1NW9aOTV3MlRJWGFuSUgwa2ZpU1A1Q2p6QnlEUExFcVpaTEJh?=
 =?utf-8?B?U0ljUGtKVjhWVVVKWllVdlp2UEZZUUs3a2xOYThBczJOamQ1V3BuQUV5c2h0?=
 =?utf-8?B?S1MzT1ZUQ3VMR2RkaDV1Nldyb1FmdmZENUhFcGtpaWJHcmZhbmkzRVBER0Rn?=
 =?utf-8?B?NW1zTzBFMlByQjlrRGlCaVAzclIrOXJkSmY2a2EzZGhreVFlRmdPQXRIRVFr?=
 =?utf-8?B?NzlJTkNXbmRDdjhFbnFkVmFZSU1VeC83bWIwS1NhNGJ0RUJ3T1JGL0tQUWsw?=
 =?utf-8?B?Mkl5ZVBYQ054eDR6aHd0U2MveFF2dFg2ZmZ1YlpJLzhRTUFXbUZ1VWNVRVhE?=
 =?utf-8?B?MG04MXcrczROeHZsKzI4cjZLSUtzMDgyeHQzS2h5elhidHJ1SDlsY0ZFSWsz?=
 =?utf-8?B?bXNKeVpta3MyK1VlOUltTEVYMHZkejZjNkNvNlZvekMyWVpKQTJodG0zblJR?=
 =?utf-8?B?VFpWVU83dUpiV3p1TEIvZkZic3daWTQ1ZXE5SU95c20yTUw4NkJidElMMnAx?=
 =?utf-8?B?cHFERGpWWjlTN0FQQ1JUeWNtSVJiUnRBNlg2Nk1BU2FnOTZONUNGRHJERGw0?=
 =?utf-8?B?TnVJeHlYYlgrT001WmtsNk5laEkvcGM5aHptT2lwbk5URjFGUDRBQUFIL1J0?=
 =?utf-8?B?MWlCa3h4Q0tNYmlNT3paUmtRcGtqQVoxVFhrc043WENodjlIOFZmTVo0MThu?=
 =?utf-8?B?N0dCc01WVDZEbS9DQTROY3FnYTRVWG1aNmcraWJoMkNUS1BvM3FJcnYrV0M5?=
 =?utf-8?B?bXpHUWVob3A5TFRkU295bGdsVUlsWFVsa1ErTW5PdzNjaHVyaDl1RHJuU3cx?=
 =?utf-8?B?WHdnWFNrVVNpNWlQSXFyTzRzdTNQME8rMFhTdERJdUJldjJ4bmRzUm9yWkpr?=
 =?utf-8?B?QTJLbVIwZGpmN2plQVNpUUhNTzU2MXN5SXp6QnovaEVVT2FldEFwTmZtc0Ey?=
 =?utf-8?B?TU0wZVBkTjVPMHJBbU43ZEE4MHFWQy9sQUh2eGdsYXZHZEVrRjZITDU3OGJU?=
 =?utf-8?B?ZXFiSUV2d2RBaDVyMUkzMVJKbk55Mnh0ckRoOEZOa1JBU2RxZU0wckdqaXc1?=
 =?utf-8?B?QkNIdmVrZWdBMDlVcTlVQzAvMlYxYlpXZi93SGRrWDlYakhtSUY3MWk2aWpy?=
 =?utf-8?B?c3Fobks0U3lBOE4xL1dzeXltWDNpeEZSYnlNMHB6SGJxY2psMDBKcHowMzU0?=
 =?utf-8?B?d2UrQjN6bmMydWVBdGdFRzFhdjhYYnVRTWJFNTNHZWE4VXdMbytHQ2xMbFZ5?=
 =?utf-8?B?RGdSaUhLMUx1U3htc1c2eEVvV2dxeGpNK1RUd0lBb2NrYkgzQkhWNUFBNUNi?=
 =?utf-8?B?VDFOaXRjTStZenlMVE00UENwMzRzY29KUmU5S0Zibjd3QXV5bXhQRmVKdk9B?=
 =?utf-8?B?QmI1UjFhWmhjRCtqV2xUcUdVZmdxbGo2SkUxS0lWWDNwSmRVeXZmd1VuQ2ZV?=
 =?utf-8?B?NGJKN0NlajBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlM3dkJsdFJTekRMWXEyZHpaMm9qeXdDUVRLM3BsbE9RNVR3RmFWSjE4dUlH?=
 =?utf-8?B?aDdVZk9IN3lHdnNUbi93SWRZV2FCdFYxMDIwSGZZOUY3SHpya3N0T1d3UEc5?=
 =?utf-8?B?YUxsV1R3SnlDbHFNbmIrdFEwckkwMXNyT1dBOVduZU5XWEZGSTVEQkJhcnVI?=
 =?utf-8?B?TThOdEYvN0lIVlJaRElYTW56elNudXBkbU12NlZrVUdlaGJxeHBlWVpjN3BX?=
 =?utf-8?B?WUR2NDJzcHZDbWFKRFpLYks5OXJ0M0IwUW1aUmx1dXpBUmsxbTNIZTdFc0Ro?=
 =?utf-8?B?WndacmMwcVJKb0Q2YTVocFZoTUcwUmxpYkRNVHhHSkVkY08xV0hTY0t4SUth?=
 =?utf-8?B?Y1FacGVTNW9jZlNPb0hrelJCb3QwbDY3U1hPWDJ1OThwU2ZOM3JKM1BRdmxL?=
 =?utf-8?B?UzNLNVpGMzlPMzVNWlRqZ0VIVTF1OHRJbDJYaG9Wam4wcWgxb1RpM0YxTjJS?=
 =?utf-8?B?UEdLRGkvekJMWTJ2em5lQXJpcktkNDFoQnUxajI3aFFTeFRKNmNyeWJWTkFY?=
 =?utf-8?B?NzYyWUZUVEUwZk9xeTdRVkZZeko1K3RzNW9iNUlvdE95Tnk5Z1hDa2d0b2NY?=
 =?utf-8?B?MVNZY2d5dkFMaU14Wm9XSXh4bnRzcGxhZElFSWtsdkJNN1lvWHdkWGpNMHFV?=
 =?utf-8?B?YzlFdWtrSjl1NE4xMnBxRGI2blhTL0V3a3BXbkpRRW9iOXpTQnAwdDF2ODVC?=
 =?utf-8?B?UUV4K3RHT1Z5OVN0RHdrZUZ5elB1VG1pV1RFZkJJT3h5Q1F6UFA4b25ZRDBr?=
 =?utf-8?B?STFuc2FNNW10cVlBMzNpRFpMVG9hUWpEWGxVekxSZ01jWlRQSXdqT0lFanBs?=
 =?utf-8?B?cTZPSWtFOVBiNXVob2ZqeDl4bmVGMVE4TVFuUXpubG03eVBORnliSEpCUExs?=
 =?utf-8?B?MldocndjVFRQUE1wVHZQa1ZhMFQyWUN3ZVdHam12K0NURUM3S0g4QVNvWm50?=
 =?utf-8?B?U0IzRnNUQ0U4a3ZvWmpTbjFjMElHUWRydDJiSm9SUUEzMzZmZVpoUVB3N1NU?=
 =?utf-8?B?bDgzaWJtcDdxY1NxUW42YTVHTmt6QWFwUmNJMkkyUmREY01makZNUTMwcnBp?=
 =?utf-8?B?a3dLclVpeWdkOVZpc1BVNFV6b2hNNEJTZ0gxMG1JWHBqeXVEcWhuQStsQjNm?=
 =?utf-8?B?dCtoRGMvZjhJbUtOdEZaMTU1NzJFTjR0bzJzNE5GNVlKQU83VURDUFRQZ2o2?=
 =?utf-8?B?UU5MQjNkTzNNM1JhUloxYmtxditUYUVObVI2cWMvYzFnTjc0QzIrT3pLZEl3?=
 =?utf-8?B?NGNsU2pvdFVzTWRoSm5ISUx5b25hRDdCTUlDUG5sNWw0MWcwNnA2Vm1McVVZ?=
 =?utf-8?B?WkZkZElMOHFCcDU4SVVUOXREOHZBR2Q5aW4zeFpUZkM3YS9YbUhLRUJKM0p2?=
 =?utf-8?B?bmNRQjlYN0ttVmRWSlkxaHhwaXBDS2pHRmpyY2V5R3Y2OWJiUTVkV3hFbWxW?=
 =?utf-8?B?anZHQXlDV2h0RUZ4Q2VBYmFkSEorajR5R080Ym10S2tDeHV1V2dZSU9ob3VJ?=
 =?utf-8?B?MWU5amdteXZaNkE5K1B0NlhWdEpkZ1hCYzR6RldDRkttOFZBei9yMGp0a21V?=
 =?utf-8?B?WkRHOFB5TXF4QXNUb1prN3o4b0FpUlNaNUtiTW1ScDNRbndKejhjN2JnRnJK?=
 =?utf-8?B?R0t4eUNia1dLMXJaZ0d4YTVYYS9tNWU2UUw3UmplOE5pc2czdC82RmlPSlJF?=
 =?utf-8?B?VmJpQTlhbEUrWVl4aXlzVHA5UEZkQXVYWEFRS0tOQ1hRK0hnR0o2WWpJdmdR?=
 =?utf-8?B?dTh6K2p3WVdTNUladDhxNGd3cUcweWNVR0RTMXAyTzdEYUk0MTArZldNMDVF?=
 =?utf-8?B?NG5oclh5akZBMVBtSjlqRUkxYVlVZTFBSW5VTXd3WG1yQUFQeEJ1YWZLRXpE?=
 =?utf-8?B?UlZFUmN4VTc1SitaZjZEQmtKMU55WTU0Y093SGFoSUJheVBNdThXaUlsZzBk?=
 =?utf-8?B?RnZ6WWs5VE9DN1A1VHZMdDVaT1l2R0g2cFZhdGkzekdLRklKc2wwQ0tqUEds?=
 =?utf-8?B?bThrTUVjSlFlbERubXFCQVQydjI5OXpGN01FaEtsVUZNTXNtRjhsL0E3K1BG?=
 =?utf-8?B?b0RtdXdYWmZXQzVRRWIxL1lmNGtlL1RVajlmay9tV21QOHNKNTZsQzlvbGxM?=
 =?utf-8?Q?Ri8oAcjZ/JIqd8HLToGIGBhzl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b89c8dd-a8f0-495d-7848-08dd760db352
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:52:17.3387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvYJ4S7Foyr6pE0syC+TMjLM2UKDE7ja0+/lGyDKfEK8PsQN3/dXAWuPuWoe2lCKbRenpi7zozJLaLsf/Khryg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

Add doorbell test case.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v14 to v16
- Add set IRQ type

change from v13 to v14
- merge to selftests framework
---
 .../selftests/pci_endpoint/pci_endpoint_test.c     | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index ac26481d29d9d..da0db0e7c9693 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -229,4 +229,32 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
 					 test_size[i]);
 	}
 }
+
+FIXTURE(pcie_ep_doorbell)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(pcie_ep_doorbell)
+{
+	self->fd = open(test_device, O_RDWR);
+
+	ASSERT_NE(-1, self->fd) TH_LOG("Can't open PCI Endpoint Test device");
+};
+
+FIXTURE_TEARDOWN(pcie_ep_doorbell)
+{
+	close(self->fd);
+};
+
+TEST_F(pcie_ep_doorbell, DOORBELL_TEST)
+{
+	int ret;
+
+	pci_ep_ioctl(PCITEST_SET_IRQTYPE, PCITEST_IRQ_TYPE_AUTO);
+	ASSERT_EQ(0, ret) TH_LOG("Can't set AUTO IRQ type");
+
+	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
+}
 TEST_HARNESS_MAIN

-- 
2.34.1


