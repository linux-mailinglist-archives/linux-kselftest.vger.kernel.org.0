Return-Path: <linux-kselftest+bounces-30305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7CAA7EE3C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C12C17681C
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80A22D796;
	Mon,  7 Apr 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U+3C8QAO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31822A1E9;
	Mon,  7 Apr 2025 19:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055481; cv=fail; b=trHywaVhCm6nzGHguSFdewEhZZ0PCjvP0A9BQ7joiNEkClOixBgihV1pUa4Fnwg6jiEIxQepfNP/TCEN0wpSirf1Nif/UcjOVxmooMYSvxTLKk6/QVNTcXMFOzy0SzIGSRBxDUEuB9OWhW1I863lNxI2MqiWL2t9oKVVK9QCEUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055481; c=relaxed/simple;
	bh=ThyZOhwaDsp4V1j223U0prTZIbMrn8Rf6YEorwRizOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o5i1o23kM+z9cIwGD2S03EEgRn3bRB0VHnADO4WLtQUB20UdkTfOCehUn/X9dlQXDUGMUAWkrqE1eiFnBUYY56WsAHi0oHRbTFNJ4KS+yFHIaHW66qZ5m5AKwyAXk38yqHr+Lz3JyOY48F8fct/05HjkjTLf2M3oSn5b7st8Z1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U+3C8QAO; arc=fail smtp.client-ip=40.107.20.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=suynrumez5XVDqD4MTEk4qTYwNZUr+tJa8sZG1WD2orJg/Ya9cHOn+/qN00jcUNHUKgbh1aEF9m8pugNTR4V6agHEr4farz2mF0mYEN2HZvOVCc1OrNMdWVJdjukzMF6D83wkljtlAOvPE+4BZTeXytjffGx3jZE36/Tw12jPRNWEDaBOE9KR9K9Wj2wA16+5Tz7IcGXkxiaiJoEJx1Kl61QhAyEjmvtE7E8eeW/yP0YJUpVaWjpQfWH7GxzZU7IMIFyHEMqfc3jb+Cj4VGzOpAksxlfSEgypBDQFXqANriUK20LskkOsoV5j2pgcW/3jucrSbB4iUKKOnRmRjwJcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBhEmQ+5keqgx7M1lTMSB3Zen5LLbLZOcXbwQxpRbuU=;
 b=gJMs0Tyfc5PuYpDbyI0hyuKyWPm97c4+CgQFwtELEBJdz9COzlFnLQtEXJtxqWvYwM0qiAvVTcnGuneD5CoBtitU1c2XqUi7oPiJ4PYgRqBeRNiF+VleLPuGri3DUJ8t2OIx/ydMf4h626f3FmCQAveRRSRg8F8i9R1RDfjJNnm8FvATWu3B0rKQADetAHuJ53JGquoE/q+cz718KCA3OSSRg6r/upOipYyaany6ruOhmwDWLyNdJyDLPVAGrr/7E7AWqKQNrbttcdz3kInwilY+HKA/UQWJkFqgT9PqiYmfzy+NAC0eYl8abUzb8m5ii6fykNrJx1xaK64QeKCDaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBhEmQ+5keqgx7M1lTMSB3Zen5LLbLZOcXbwQxpRbuU=;
 b=U+3C8QAOF9zkv0IUDe7h1pa5BPlZf3eTodVFeFCBZyyKoj0j4K8WlDn371kvQ0W7Sg0E92o5rXOcrk2gCVJf4usa1AoTJLXx7uYsOZpTbu/F1aCAoiFflQnoMlfrI16EXsfUmr1sJehNdwkcv66JPO3FsOi9CxZ8QyZED8yJYSgSqqHCIaL5aWEOHvrSwCR67eX1GUlU+DfZsJnwAca+5bkivSQOFEP9Z4jSGImDTrSCfudSTRs1+ezrs0djfancbm+fH/M0hC/b08/+LrPEloOg7pt1M7ZbJoCkunmrsLnz2VL3N+3oqzw8/KHI38Inq6w6mnaq2zoC1LInE2KhBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:51 -0400
Subject: [PATCH v17 01/15] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-1-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055467; l=1529;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ThyZOhwaDsp4V1j223U0prTZIbMrn8Rf6YEorwRizOA=;
 b=o1HYfMoY917YNLPLCMC0xmqaTJLB7tkp+9gfD4zitOgYHeNgY5jDb9S4aRR4yVfoZWdB7p04V
 jm05nDxbmuGBzq9qWDFiyr4WgDlK13UJF39OZnkUfzcBivybgc1Uja1
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
X-MS-Office365-Filtering-Correlation-Id: 389e9db2-7142-4a95-13e0-08dd760d9066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1RnN1Rqbmx6Q2I1Z25sUG9kYVJwdnExYko2OWtNNnFNQXFCdzlCNWgxQ2ZR?=
 =?utf-8?B?YXo5VkV6dTdtYzlickV4V016clE4enJ4MjVBVE10MWhkcEJGQ3F1NHNHMjQv?=
 =?utf-8?B?V2V4ZCtmYU9LUGR3OU9hRko0QmhRQm8yQ3R1ZGNpS3NlY2ZkdnVvem5QdTQ3?=
 =?utf-8?B?TUwwNlhaTTJNS2hicytLemZxSkhvZC90ZHFMMXRmWG9WcU9XYkU2amVIY1Y0?=
 =?utf-8?B?cjVmNVlYSnN5UmZiNkxFaXJvcFJib2kwcHNUQnhJWmU2bTNkLzRUZGNSd0V4?=
 =?utf-8?B?RkVvUXdWWFAzSzNDeXRlWkQ2VFFPdkRrNlpreTJCKzBkeXB3V2dwbWxDTHhY?=
 =?utf-8?B?cnRjMmxadHZpTUJFck9QV1NLN2V2RTVhb1EvdU4wb1I2SzJyVG5mSFRobEZP?=
 =?utf-8?B?ZUJqNGdZdkRqMG1uOGZrSTZUR09wclRWZGVPTEZ1eURYZ20wK2hEU3duVXRX?=
 =?utf-8?B?c3hwbnMyWE9TbERNQ28yQmpLTVp0dlcxT1ErOXorY0M0dTk3eDhyRU1CRmJj?=
 =?utf-8?B?elJuRTg5NEJUM2ZPMVF4MkU2K2xReXZZenJOVjdlUnl1U3hrWlllUi84NlVx?=
 =?utf-8?B?UjFWeFowNnl5Yk04VENhZHNBWHBMWEVBNCtJZXlJU0JMN3hLMUVMVGduSmJC?=
 =?utf-8?B?SkhCcnd2M3hPWWZST0NzdnE3bFQ2Wjk3TTlZU3dQMlY2RHhIeXFub2QzSmtU?=
 =?utf-8?B?a1huMkExbm9LT3dPT2VxVlFjNUlmem4rY1JFU1R0RlZDUTNsZTdZZXMxendn?=
 =?utf-8?B?UDBmeDBCT2xCUDdQci9EUlFqbGtrN0o5MlFyOHpaZ3c1YTU5aGc5VnZLcTRx?=
 =?utf-8?B?VnJYeWxFY0NNbmI3YTFESWQ0NWNpNTErQnBraUZPa29LR0ZyS2xPQ2Uxb3Ar?=
 =?utf-8?B?K01zSFBkRGs5SzhCWGtBRGZLRm5nODhhSDM5L1drVm1HSk1KZW5UVUU5NnBU?=
 =?utf-8?B?d2hUNE5HNExRbkx1WW5ET1hlVithd2t3NzYxSEh3VWl5R3hNbFA3UmdpdmZ0?=
 =?utf-8?B?c1k3QzdHNGpmeGEzSGRhR1pEYklrL2VTY0txYmgwdytoZ1J1ajFlWCswUGNZ?=
 =?utf-8?B?RG1RZE9MNk5MVUh6Uld3aFNQWWpRVGhsVm1vbHFvckNYMHpVcHJTSXpmdDh3?=
 =?utf-8?B?Q1RjbmRBZVdrcU4xd3k4bFg0MEc0UG1WTnRBYU9US2ppNytab0Z3UWxrOEFz?=
 =?utf-8?B?dWkxaDZ0N1FIcEtaU1FhWlN2QXlhWHQvNHlOZGc5Rm1vSTNwM2NtVVA4YmJa?=
 =?utf-8?B?UTZ2TnVxb3dUYTJSekhRZktOU1VTMTQ2TGp5VDN4Y3VtUXBSeFR6WU5VVTVH?=
 =?utf-8?B?NUZtemlJR1ZMb0srSXk3OG8zZWRvOHhoZGZ6UjhjejBWNUNKVC9vY0RSbWFE?=
 =?utf-8?B?TGdFNkdyTVI4YlRhNE1PVXJtZktsV0lFcU9tQkxTVzJWSHFnU3dEOFFWNWw4?=
 =?utf-8?B?L05XM2J6dm43Rmkyaklia1FzSnV4ejZmT1FBYUt2bUdrNzlCVTdNeVdwSWEz?=
 =?utf-8?B?RXp1c3NITDFkbHVqYVl3eW9hZDZjMndEVUtnOEIrbTFNZlR3d3lHN1dJcE8y?=
 =?utf-8?B?cW5QdmZTVDdzU0I0UlZYTC9BdHl3cldYV1dQVVNVdkJrcGpGTUN0M3ZCMm1C?=
 =?utf-8?B?Z1c1N0JOcWFGOTdFQk9uUGsweXdpS2tSQjVhVU9DY1M2dk9yTVdNNXNJSUZG?=
 =?utf-8?B?SEpjNzhFNk5XeVlnWVoxMnRURTVVZHZab0dDUVNmam5hdGdiWW00cjNRSzAv?=
 =?utf-8?B?SlU0cXNuL2s0WHdCL0paRUZ2dmVOWWVtS0J2NFZRWnpGU3ZWTXlBSlFMZVhO?=
 =?utf-8?B?VlVLOXAvd3BTUDZsa0FLaGU5eXZySEp1YTFFYXJVMmZHVWNQbkZCZFlzMjVR?=
 =?utf-8?B?UmJNRXh6SS9HZ1VKM05IUTVLMFlXME1HVUNEUUtqQnI0aUpKRndWZnF6U1V1?=
 =?utf-8?B?NEJVcHU0NUZraUpLSE1GNEw3d3ZsSGRsSWoyZ2pheXI1b2ZUbVljSiswSklR?=
 =?utf-8?B?VzU0ZXBaa1JBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU1RNWpPckpkaFFvRUdRc0F3RmdOdGlVLzhud1RabTM4ZU9Rdlc3N0NKb0pV?=
 =?utf-8?B?NVFlekNSeEpEWWpWM255THFpZDROMi9zZDdLT3h2QTg4aGlmQjU0TElRcEJK?=
 =?utf-8?B?Nkk0QVg0MDNkNmlzdk5xeXdnWXZnRWN6UVQ2VU13K1crNDNjV3BFR0xmR2V5?=
 =?utf-8?B?a3RJdk1WYllqVnB6NnE0MlRGdExBeVYrMm0rOHppVXdrQ0dZUzlTM3FEQTRG?=
 =?utf-8?B?NHBqK0RMZ2JJTjRtWHJZRTl4SVprYWNsVWI1QSsxN2pVdkNDZ0JRUS8rODRB?=
 =?utf-8?B?YThaRWk3SGFDMjU0NDZSK2lJYThic3VLTkV6MUZUWGVYMXNHUk1Ia2YyTHRZ?=
 =?utf-8?B?Q21WN054YzhMaFZWWXB4SjYyRFBYZkRQdVVNYWM3bjlVY0IvTjZEdW1WTzVS?=
 =?utf-8?B?Z2dLc0JqTTMvM09HeTJxZ1RmSnZ1cldjMTlMVGx6M0Y0c3d4M2RQTkJjSzRG?=
 =?utf-8?B?ZFE1SHZxOVRmSFBEdXpZRHY1eXEvU1ZNeEc5alZ2QmNiRVFLeEYwSFRpYVdt?=
 =?utf-8?B?NnFDeXhKdWJKRGZhWjZyS1pBVWlERERxRGdEZjl5RnI3M3FFSkgyVGZiUGlH?=
 =?utf-8?B?UStGUEFkTExsM0lJeDZwZXJUYVpGeGZBRS9WMHl5bXFpUWxNMS9sN1lZNGs0?=
 =?utf-8?B?MHphYWVhR3RzREEvMHorTnZ2WGlvZS92TmhyUXpOV3VkekVvU0dFV1RteXg5?=
 =?utf-8?B?Z2hCWDVsd1FhTTVnTlRpaDlKZllka0FJUnp2RUIxZkNJSUR6VjJHTkplLzJF?=
 =?utf-8?B?YWVxQytXK05NK2xXc0JwNjJzb2pvNEt5ZkxqbzBsaTdyNUNXYUk2eVdwMTlS?=
 =?utf-8?B?L0ZYYjNGdmxmZitWUTNLeEcwaWJKblF4SFBKMjNjUU1lTmRKb3k3Y1R6REZC?=
 =?utf-8?B?QWZ6b05NZzNDV3E4MzNrcWdlakNyME43bGlvRGwybkg5UFZJWFlhUWdTdHVZ?=
 =?utf-8?B?MGZIcWxQRjM5L3FJaUpXQ3ZydHEwbWxGRlhBOGNNNG9iM2dwNnlySTd0OC9q?=
 =?utf-8?B?QkZPR0lXaHZTUTlLbnBSTGc1RWNERmk0dzhiWHFhNkhuQU1HNlFLMCtzTEp3?=
 =?utf-8?B?YTBtQ0ovSU1wK1hKeUZIcGM2cW1QZjhqM2pvYVFVd1ZMdDMvUVJ4bmgxak9O?=
 =?utf-8?B?bFFrU1RlSmdieXhqekZNNWdMcGE4WHQzUW9pR0VUUE9zNUJLRGZiZGk3VUQ2?=
 =?utf-8?B?Mm9qbGZHMDlsdjR4OWN3L0JPKysxSXlMeWFvcGJTOFo5bVNsUDdJamhoZTFE?=
 =?utf-8?B?NElvNUQ2MXlyYzc0NmlqR2pYeWJsZHdoMWNxaURpMnVIOUhCOWNGQ0RGTWg4?=
 =?utf-8?B?MC9JKy80bk11cEVSYmtsYXZseHJybmg0SFpXeGVsSlFPRC9pRUdVNFpoUkpu?=
 =?utf-8?B?Zyt0SWxlL2FadVhURjJOVGkxT0YxMGVjQ0VvaTFVeXNnUVhNV095WmFXRnpW?=
 =?utf-8?B?bC9FcHFremxoVjRiMEowb2ttTnU1NHN6ZFBVeVBiUXlVRzk2U0hkM3hsZllm?=
 =?utf-8?B?bXZYN3U2NUtDRkJWMkZTR09WMGd5TGhlYVdLVU41YUh3cEV6dHBUWkErazlR?=
 =?utf-8?B?UGlPRWYzZG1RY3NseG9tMjB2R1RlUzlxb2dGS2Fldm9FcEp5MmNhZGZuVzF6?=
 =?utf-8?B?WjZCSnpoZjBuaGJXc2tUU1RtSkxNNFliRmpGU1FUS1JKY2M3M1NGVHJEejYv?=
 =?utf-8?B?UzYxcXcrd2t1ajBNWlNSZStMZ09UQlBJaVVOUkI5Wlo4cUJqTU50U1lHMEh2?=
 =?utf-8?B?UUQxbEZGV2w0SU5JNVBIYll1SENnM0s3a08xM3U0UHpFWkdUZnpMVDhadXVR?=
 =?utf-8?B?WTJhdTJwUHFucmwxZENuMlFxN1p0OHUyVFo1QjZLUkVQYWVEcnRqR1NRQUw5?=
 =?utf-8?B?T2R4K1NDdUxlKzE0bm9oTEpiNTNHcWI0SkllWmJJbS9ySkRaSUJKenY0VFFk?=
 =?utf-8?B?K1R0cklqVWRDUWE5bk50dGE3aWZUazB4RFY2S1U2ZGNrbG1ra3A5USt4cHVs?=
 =?utf-8?B?V090dEw4T1pjZzlMaWFsdlRQVEtmZDJkVjhBbXJNczJLUEVBaGNCMldVNkhi?=
 =?utf-8?B?VE5iS3h4SG5tKys4bytOOVluSEd4T2IzQjN4NTJCUk5Yd2R0NFV1WjJSVitp?=
 =?utf-8?Q?HNzkwl42JR0ojbDx5+Tb5vsIz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389e9db2-7142-4a95-13e0-08dd760d9066
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:18.7027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EIXUtUqKHbQOvvBoGjip4EgMQnizhjgZh7Lt3wd0QrxCtA+1NWHhWB3ZXgIE+4MQRLPQIszUb/MXw4Zi/K/apw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

platform_device_msi_init_and_alloc_irqs() performs two tasks: allocating
the MSI domain for a platform device, and allocate a number of MSIs in that
domain.

platform_device_msi_free_irqs_all() only frees the MSIs, and leaves the MSI
domain alive.

Given that platform_device_msi_init_and_alloc_irqs() is the sole tool a
platform device has to allocate platform MSIs, it would make sense for
platform_device_msi_free_irqs_all() to teardown the MSI domain at the same
time as the MSIs.

This also avoids warnings and unexpected behaviours when a driver
repeatedly allocates and frees MSIs.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v14 to v16
- use Marc Zyngier's suggested commit message
- Add Marc Zyngier's ack tag

change from v14 to v15
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


