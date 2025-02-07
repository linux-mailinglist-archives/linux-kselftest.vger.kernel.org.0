Return-Path: <linux-kselftest+bounces-26042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B013EA2CCE0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E447916D4F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614F81B0F32;
	Fri,  7 Feb 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qs+BzqCh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2054.outbound.protection.outlook.com [40.107.21.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBCD1B040D;
	Fri,  7 Feb 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957299; cv=fail; b=qbe1TbsTu4gNlbY5ThNkmggPvOFKSZkkDcBHLnG7DQaFG71b2Edsge58FwAebP5LEaplZuvQnxxZWRkQUi8P4vlGR6JLd/mlBm2ij47sQVMPIBSpFduPmHsSUXfu0kEdPuEyTSAZnCqIOMt1Xl63kIMPpvvGUbqqzUxIsLooYaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957299; c=relaxed/simple;
	bh=oC2y0AsOzIr7IXIArHNOcokO702P3FGp0Kg9Pf/GQOs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CHghTdFk5V7sOTSrcFewT6JTTZH02rEQ252PGhS0we37nTcVLNcU0hhRWn+Q3kA7lvhPm2SlrHPsVELLVwb07Yj9ozzuiC4U8V9we6S06QXMx0Mriu/pGLXixhlvq5LfSAdcKsZivXfKg5Ay9dLdWDX0xyd7E+kxpICNH2uismw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qs+BzqCh; arc=fail smtp.client-ip=40.107.21.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxsrm0IWf+Hz/x/k83UTeD1vN/gkZe7GvHPnjwug8wXP4T4a6qaHOKbeVoNPRfDJWwCAqI7JlTEslqHK3OgJSJhhQ/t1DqHKFN5/E3CVkF4UfE+T16zefVJhBssTIiBJllFXGwN/ISrxRE3uxtFEnC5ZmqLFMkD47tNFfOW5AGVU/nAXK+iBuOhaEGluOdEIUCTvo1rKzk4SaANTI22EJ6s++EAlyUXpJfQxm7GaZq09C1uaNv8L8SjLDMltatECJbwcB0ac7hjC0P72RVrUtL3ZY5OisrwL5iJn6x+7rXagP4yZroSU2Kb8gcy8eRFhZj0EEioTOk28TS30IdjlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDCJzhZbSuy8NTlJI4Zjh2bPRLtwM/XSi2ak38JsQwo=;
 b=j2CugEF495iBoyKt2DG9aBdGXiTr41QVd3papHoQo0LCZjhYTgc5DqEGPHji8i4l6utAmnFXJ5ixliAfiyFv8Ex8V+d2W1mLv3sHv7clbBBY1kIpFuD2VyMZjZ8X+NbHSQ7AungTCt01K0001r5pVlqxe1XLOCjIELuZU1nvr5a6q5DcoyMlq8/TiIaZxfZQetLD99xBYefBoQIvaxkNeZFX+TaYQNfT3y7XqGOyfLA9472VcfV7fA3+DnURb/9gxQI1Ab9VyG+7EOjW8VgFeYm1OT10QOh2MZjft0+feW8pxxeD3amFynir9rWn94iD1eAvKOMfkAAGRZ9VgHAr2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDCJzhZbSuy8NTlJI4Zjh2bPRLtwM/XSi2ak38JsQwo=;
 b=Qs+BzqChi5w+aNLU2qCZUfcPuzN9x34w4LJhW0VhEW3TRu9lU+T2lm/DZIE7nP+e9Z1mX7wWvh1bT7vvmsONW45NB2ffAolz8bGCdxYCVK4U4ty5D/M05RyuzLN2DGpEj4LI771/W2fts7yhc70bmeUh7wRiluiabrEOky1ee0ymADfKBhuXURIeUUQpKAlfTWRP4OQVtTnNzF0aMpg6q/xAc8C0voiUnKiHCGydoYcNoDlA/XGZI15OlWZm9zPK99CVjN1QIWUfu0NKcOORr6KtjoIGHIFozYPCfExAR9hYoiOAVSggUWk/n9dFKCiYbnmGAOFaMZvsPZcU9pRR2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:53 -0500
Subject: [PATCH v14 11/15] selftests: pci_endpoint: Add doorbell test case
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-11-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1134;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=oC2y0AsOzIr7IXIArHNOcokO702P3FGp0Kg9Pf/GQOs=;
 b=yMsw89C5J18z3ZzDP36BTXILK2uXn+cl+fAqTsZ5kdR+GZC7ROOpB/4CTDfHw2gQpCUVFoGqb
 JUZCysj3x0zBCv0bt6iGKmukUTtstULv5KZlwotPF+djQE7vqb6CYV+
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
X-MS-Office365-Filtering-Correlation-Id: 1600c381-2a07-4ea0-a1b2-08dd47af6da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZndERExwek42TlJMQ1MvMzZLSDZGL3dsLzlMS1RTK0FlZ1dpa1A1QmJlem9Z?=
 =?utf-8?B?WkZIZFZuMVRLeG5NR2lSRTlYV255bkZUK3JlUDBZZWVxVUNCOWwxdGZzOVhy?=
 =?utf-8?B?ZWdSbitrd3NWcmtidFh4TmpPV2VzSjFkSVFVdkxGTHpKOFNwN2YyVkU0ZXpD?=
 =?utf-8?B?NE1FenRiZllQdUxncUdQM0VMSlNhZ2EwRjlHSXlFbkg3RVJmU0s0dUdKZ3Qy?=
 =?utf-8?B?SE1CMDdtQVZUb1AyZTdJRXcxOVVQZnoyUXFMRTdXTk5pNVJYUnA1NFVNWXlG?=
 =?utf-8?B?U0lvL0NkaXBEZzFUYkMyUUlMOGN2dWpCd3E0cWxPbFc4NDhKalpXM1pKbWFr?=
 =?utf-8?B?Z0IrTFBMS1lTc2E3Nmd4WjgxQnI0bVZoSmgxK1FhK2VMbTdQUU0wclAwOWNR?=
 =?utf-8?B?V2d6WXkzTFFFcFh0UEFRWmpDNGJaMlg4aUJNM0hFZlAyU25qVGcrS3VaQktG?=
 =?utf-8?B?MklhcnFROWFYTUxPN0lIajhNelo3VjZ2aDUyYURRR2M5dHZUeXNSU2kyQkNs?=
 =?utf-8?B?ZnMvYlFOV1g1S1BNZUtNOFo2LzF1WlpnSVFkR1ozTThET2Y3RlZIUkh6UHFt?=
 =?utf-8?B?emIwakwvRzBnNVhLU1BnOXR4aGZBN2pJUUEwREFCczdzbllYM0ZZcDZOd1Aw?=
 =?utf-8?B?cVNTZUJTcG9pdEtmV3RsVzJVVFRRdit4RTBaNUhaSWZ2MkxOL3ZSU3ZUMlRE?=
 =?utf-8?B?OURKZExCakdwZXYyM25GSHJIeXA5aG9VQm1xUXo0eE9PaXNPakp4Z1J4bUow?=
 =?utf-8?B?ZlBXd2lIcFJTZFE5bldTL1hDRkRKTlBMczl5QmtJa25DTkhETVhRY2ppWFRo?=
 =?utf-8?B?M2ZHenZLa1Q5VFN0VHkzTEZYbWxSbjlOTUNjYTlLa3dmTXJJa3lSL0UvSDcw?=
 =?utf-8?B?Z3ZEdlluRmZ5bG1YRExQdTA2YVp3Wm54ZVgzdmhuYzZYamg3cW5UZnBaMVBW?=
 =?utf-8?B?ZHUvRnpkRDdjZTQzNDBQTEh2R1FvQU94UHN1S1MzODdSRmx2dlRFc3B1bUh3?=
 =?utf-8?B?SkpCVjBjQ2U3bU1NMkY1SVI4L05LVExHN2RQZUE5bXppa28vL3lWRTMycWxu?=
 =?utf-8?B?N1prNGlUYXZUajB4c2IwNXIxRE5IRkY3SDJnb0JJUnU4b2U0alJqMHRmTTlY?=
 =?utf-8?B?OWNUQjBsdWhCVS9MMS8wU1lST3IwODVBdERnL2lsRW1tQXBhdENPUlhKdTZx?=
 =?utf-8?B?b0JCbW11d2FVdnFLLzV5L1UrWEt5U1krV1ZjUlNkai9XSjFtb1labVN3NFcy?=
 =?utf-8?B?cTQ4YXpRQ2Y2Wld1blFiWHNmczBtbEU2WVppTnN0OEFtTzRORjVZZ1NyMEZn?=
 =?utf-8?B?SlNCQllFTHNVdnZ2TTZQc1BtZmJWMU9acnZySnlURXkxV0QyUTVDbVpGRzZi?=
 =?utf-8?B?alg1bkNOZzhEZ2dlWEUrczk0T0NHcUxoQXZuTlo2cWpoSFNCWXVoZkx3dXM0?=
 =?utf-8?B?a2RxWHFLZUZ2b01xZjZOWHBXQUprMjhlaXF5eWJSbnBvREt3OGpEVm1ib1ZK?=
 =?utf-8?B?cTBkam1VNFZuS3ZHUjhXVzZ4TkFqbFhWejNvTTU0RDBlUTBjT0d3U29vK0sw?=
 =?utf-8?B?bEJQSkhKMVh0c0tTRkpYWk5XUFM3anYvdGZKOXlJVG1CSENTaUs5K0hoUjJW?=
 =?utf-8?B?MmZQTTk4d1dmOHp3L213YUExYnhWRlorR2RsUHQvNi95V0ZZeVUwcnFnVE85?=
 =?utf-8?B?VlFtYlZxanNOSk1ZeHYvL1B1anJPSjVCVXY2NjJGS2hEZlhzUitkNmVaNUFr?=
 =?utf-8?B?cktWUnUrNmRieU80RVRhcjVpbTY3MlF3Sm1JT0NlcmZqNXQwY3paL1BqbDhj?=
 =?utf-8?B?WExROHg1SDIyRUxlclhCUDVRTklpR1VMWUtyU2dnaUE3V2FHbVRhbEJsWHl0?=
 =?utf-8?B?WEcrYy9vclR2cDRFSWxzbjVKNE13RXl4eGU0dllDeS8yY2pmSFJrdzJsbDhQ?=
 =?utf-8?B?WTF5dlFYWVdOd2FrWGxaY1BtOE9YOGxTWlVGQ2pBOU5FZTQ4Ni9xa3pNNGE4?=
 =?utf-8?B?YVNOVW82Z0dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkN0MUdxdnUydEc4UDJnS3BhZzVZdTV5MjljbVJrcDNvTGlzKzEvaVJLb0xQ?=
 =?utf-8?B?anptYXl2V1M2VmtiUGJORVJXdm9NVi9BSW1mUUh2WWNLZVNXSHJLNUUvWTUr?=
 =?utf-8?B?aTREanMwcUxpVkYrSEV4VTFnajFMN0dlQTRvNHZGbVBYdXBKNENNZjEyN1pS?=
 =?utf-8?B?djVaTlA5cEZaSVZpTnRld2t3K0hLNytyK0hmOEIvYmlsOU1tU3VNLzVvRjlG?=
 =?utf-8?B?ZkxmbzgyaWt3cGl1bTNkdHlMQml1NTFPaFkrbEpNalVFMUhYNVVmc1lFUTk1?=
 =?utf-8?B?VFRaRWI4dFRyY1hVMDNuaXo2OEZIelptYWZSNkZnMlZ2WXhRdHpWdDNYR282?=
 =?utf-8?B?czdxZDJCNnFteGEwWWtoTUU2cFBwcXlQRm5EbVVzZDRydzFNN0tZT0lvTXU5?=
 =?utf-8?B?UVNnZWRKazV1bnMrR0NUcllyOHhDMzNRYXFxZndjdUJOZWV6Ty9Sd1RzNXcy?=
 =?utf-8?B?MXFTdzZ5Vmc0S1VVeVZHbWxobm9NTGduSzhWVHVBeER4NEZmWVdLZ1JIdSsx?=
 =?utf-8?B?REJRSkxET0w4eEVjTFo5cWxTQjV5MnhVNWVkZkpJZlE2aWpYb25rdFZNZS9Q?=
 =?utf-8?B?V0FJblNFZzBpcWRYTDJRR0d4MXBiTHZXWkRkbUhoMFp4bktJOWhic2ZZOFN5?=
 =?utf-8?B?QTRvbXlodGNNd1RKanBxbGJCaHpzd3VPRVYza0ozRFQyNHBFZVFabjVWZ0Fo?=
 =?utf-8?B?M2h5Qk9tSkhtUTMxNkRhTks3NVhvRFZDU1ppQmlvWU5OamQxL0NjbmMwT0ww?=
 =?utf-8?B?ajRERExsYjZGTzNMK01CMkFaYWJFODB3dlc2ZXI3Ulhqam0zTEdEYnVZcG81?=
 =?utf-8?B?YmdKMGpnY2ZkTVo1K040N0FZQnVBSTBqaG43d0JXK0pqNGlRdkUxcTBKWGZL?=
 =?utf-8?B?RVdmLytQcWl3TUFrMElMZThjbUs4dEM2cEU5dSs3WWhoUzdmd3dPaG5DdUY2?=
 =?utf-8?B?b0NrcklpaXV6bnhkL2ZtdFpYN3l3NEFUbGwwend0Vy95VS9aQTQ0Zlk2ZU9M?=
 =?utf-8?B?R3QyT1M5ZTc4T0VLOHlNaGQ1dXZFTUR1RXFieXBSMHZNOFlMb0syRFJCY09y?=
 =?utf-8?B?ZmxUU0MvbmhJWWVxK0J6UjZObkMweEhaN1lXOTg3MFYxUGl1ZUxQVVZDVGl5?=
 =?utf-8?B?WkxEUGtnN2tGVEpDcnVRRVVtMTFiRVJuUTJyVlZhNHQ4eHZGdk15bnhLbU80?=
 =?utf-8?B?Mm1IV0NRYjZQd2xoVndRRnpWdC8xZlZDS3Q3OVhXUHp3Yms1RGFWMXltMnd4?=
 =?utf-8?B?R1NKN3hkTGdlYXpFVVdDazFwdG5vV2Nuak1kUmdPZDNXR2QvRksxOEdGY2Qw?=
 =?utf-8?B?eEt3RjhGTU1QV3hhcG1RZlMzWFptZDNlV3czQWdhSTRTWTNLbkhxcjVmOVgr?=
 =?utf-8?B?dnhRVTVSRis1aFRZQS9pUlN0cysybjA5bnpmbGdvMXA5ZjZRaUYxRXhybEhy?=
 =?utf-8?B?NjhMNGpmUnNtWHY1RUlCWDdpbnBaaGlQQnU5QU1NbkF1SHVpcDA4dGdwdkVh?=
 =?utf-8?B?R2V6Z2RkdHgzc0FQVkE1aGoyUEloRXZOUDRWaUllbit0WCtzN1ZmZDEzN1Ir?=
 =?utf-8?B?eFNvRmVyRUlwMnZ2eE40dXJ6ZFBwejJ3a0FNaFRZNTBLRENEaHUwTDdvWVpY?=
 =?utf-8?B?L0FLVktuNm5BNDBRRCtDaXZkRmZLOFRTcm1EOUs5elRYQWN3aWVKSmZ5WHQ4?=
 =?utf-8?B?MDRvTW9HY2hxNHRLOUhVb2Q0SjV3NGRxVFBZb2lGWS9TckZGSUFsNG1QYTZQ?=
 =?utf-8?B?VGk5dDFHQVBCMlhnUVFTeG1vVTBEc2t1V0ZwWkVFQ3pmOGs0dGtkMHFQSjJr?=
 =?utf-8?B?bUNpRUV2QTdCaUtoTDFHTDBieEJSeDNCa0IrWjNVa2tXWHp1NlJZNnJrd3Vm?=
 =?utf-8?B?VUYvSktFOGlqNUdPMG1rajRhbjFuTVNMeXVNcDlTQXdWbll1QnhibTRpa3lE?=
 =?utf-8?B?RnIwZWdhS0xEQ2Y1TGs5RThzZ0lvZWtHVnYwUWg2Y3c0bzB0NmpDaUhUVklJ?=
 =?utf-8?B?bVNvY3Q2YlpPNXdvYXZNcnQrejRSMGhzWmxFalpweHJtd1NZTjJzRFl0a2Ux?=
 =?utf-8?B?dEtIZG51cHJYekdRTFYxb3lrem9aRGIxKzRDV2RFVjVreWwzOEwvM1o1MWVK?=
 =?utf-8?Q?WXQSR3HPDJGcgzDTwzAy9dolE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1600c381-2a07-4ea0-a1b2-08dd47af6da9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:34.2701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXamv4wGqJVd9PrCwaMj7ak/Db1j+3zJGUP6KXEDxX9ito40HMjWEaMlqZoZ9c2OJ1ZF6OHCJ2pXW8a5Ydkdsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add doorbell test case.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v14
- merge to selftests framework
---
 .../selftests/pci_endpoint/pci_endpoint_test.c     | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
index c267b822c1081..ed14c9fa073f9 100644
--- a/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
+++ b/tools/testing/selftests/pci_endpoint/pci_endpoint_test.c
@@ -218,4 +218,29 @@ TEST_F(pci_ep_data_transfer, COPY_TEST)
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
+	pci_ep_ioctl(PCITEST_DOORBELL, 0);
+	EXPECT_FALSE(ret) TH_LOG("Test failed for Doorbell\n");
+}
 TEST_HARNESS_MAIN

-- 
2.34.1


