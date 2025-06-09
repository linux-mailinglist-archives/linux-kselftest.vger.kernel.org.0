Return-Path: <linux-kselftest+bounces-34499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E456BAD2409
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D216C188CE60
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F2321CA14;
	Mon,  9 Jun 2025 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kOYtoP+s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D089212B3A;
	Mon,  9 Jun 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486888; cv=fail; b=vD1YZMQmAOnNAaRB8DRXp53sra2gbhUc/8GhJ03KQC/RIZBAOJH0BuKG9Kgm2xEh4rp7kJbhPiDeD0TQSJVMGPlZWyRY9Svy/f48u3VcO/FYuNY6CfLiVbyC2K/icmO+qldORFFmnhf/2wN9DHO2r8E/5D91jVlnKssjJIJ/MLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486888; c=relaxed/simple;
	bh=OfZj8TVzwMk+EMxlxee/g/pMSJOdBxKez4PIiIvwM/o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CdkbnODdXt/VqxruUDCG//kJSB24oW+9rwUoBH7c+wNbojqqO57KtoWLLIBwFV2WFnIhJzpDuIqMB2Y/B1KjzSiQqJDT2w67MFVRBferrrJUKYUgnqvS2nrXzLfIOg4T2bxppsVB59grmYwjS2taS9nVQ8ntRq63Q7PdLjJve7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kOYtoP+s; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKCVV69VmVXdhqfy9M523Ss10GVVLnZeR7B6394pZr/U0WK2hIFmRq1FNUnsZkpoDgE29uKZdQAv3ClyNOPDbetQn4NGgwPjDFQH0yqo+3WnaMJoSjFKyMnhmwNIMamrSdwSIZxI1XYZfMfMJWyXjAk+hn4VpCrcIWNuM+eAYJfRL16xhIKCMdQ+vEmPebmHWe3f4PZ1d7k4hLgdcSvWJAqx6g7LFO2DKbvuLVLnsznEcHiWTHbHgQiZEP+HFbuEJO+p3X/ruco9a2BhjpfXFiVrWhzb1Oav4H0y8OtS5mC6QjmkXAGxx1jMLeXlKJgGZfPXtvG/hBt3HqYEnxWrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mt0GVScPwPfbe5/LUXeGHads+xwYodBVdsL6ubwwKzk=;
 b=pvPSRX3DYuy12yKWU6idnDgTWXBK+sLwEQcOvySO2Em/4vUpX+5xu2FAEy1s9xGq+PWheflGZGj4a963U22wpg4mr3iqCzi1MQbVfvC3f5sZ82py8HjpHxiE8tUadRYRPq2FwXeXKp03/PavLU99WyYFWO4nf/zrCMUCKEUmn8e7SdwlG9hoCZxqkRXfuLzD1VCXsC8Jwu2hHMwTwHtRGo+1RqrEOfMrzPEo5oYkWIsYk/1vzoukoKmoQLuzd/tAKvtQUJTbaPhJJfs6pJHM1UN2slGPG37QsyCcoSoOqth6SCcAFkf5c4oxINi86BWkFYjmKgmiUz3ekpn3GKpGog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mt0GVScPwPfbe5/LUXeGHads+xwYodBVdsL6ubwwKzk=;
 b=kOYtoP+sRilP9L7MtUM0Yw2226gp/TankPfLzK4335T8HP54g9ykIGcMoNpFhFcvwx98+3F54Cs/Utnsfkrz9SewoHs9355UooHVdrdpPOUe9NXKmTTW4dt89ovSXIApXzcCp7/HVOq/1FjmwYK8YweWzmRL1MYw9st6aOC8An5VhBHVZF5RGM8Hah9wd3+8G0OHg893t41cv8vE6/DvEuODRebix8RLrs7P+/aRmHkGfHQtogfpHW9SLADT1jVniWUCxhFIPw94D5HHWO8LE5HKy/PyFIh+69PjBUdyFGEe+Dj950clanf6y9oDDO5kBgnmBDtSn6EVhwTUSCQIcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9062.eurprd04.prod.outlook.com (2603:10a6:20b:445::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 16:34:43 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:34:43 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:14 -0400
Subject: [PATCH v19 02/10] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-2-77362eaa48fa@nxp.com>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
In-Reply-To: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, jdmason@kudzu.us, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=8330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=OfZj8TVzwMk+EMxlxee/g/pMSJOdBxKez4PIiIvwM/o=;
 b=E/+v9JGzQVsPgh2Gl3XEfvr3A35zDNYVx5ORLO87gO0KBhRhboZQSxvHKvA47bccXGuebCA2h
 2ZPpFl/QHzGDpF8AetKKSMHh4P/Yep+0anD0N37YB5mp0NxvlJd0hv8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AS4P192CA0010.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d0a11b-cd64-41aa-8f0b-08dda7738992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjcxVEdmNUkvUGd2c0hScUlnRFZFQzViUXlRZEQyUXk1MVJyc2ZoYnVEdDlm?=
 =?utf-8?B?TTBKVS81dFFFSk1nekJVNzMzTXluRmdOL3hBQ0V3RGg0dG9QZDRCZ0VWSmxM?=
 =?utf-8?B?c3BrU1Fnd1N4WTA0ZXNYbFZtaCsyWkk0alhNaDQ0Mkl1WlkySzJPN0JNdnRI?=
 =?utf-8?B?czB3Q1QyVmZ2bnBnU3pXVGRzS1NtdkdBZkIyS3lYTFphcUNCNWliRW92N3lE?=
 =?utf-8?B?bVl1bEk1MjhmaUg4REIxL1pnQ2Fpa2lVUUY3RGJRYTErWGRTZzJUQ0RnODYy?=
 =?utf-8?B?RDlzV1RidDVZN1dqdERtV2sxYytYWERpb0NkenlvTHBvaFZjRHVkdEN5RXdD?=
 =?utf-8?B?TXNBWUNwRG9NVUUzTGVuNjFPKzFsRU5sLzZ4amRZL04vN0w2YXJJL1pOVFpo?=
 =?utf-8?B?ZmtBMm4yeWtOQUdvU3VYMnRFRjFGMUFaMlVNMUd6Sk5nMW1BRmJ0QStVMXdF?=
 =?utf-8?B?RGlLME9wT0VoRWNEZlU1MmcrczNlYmN1bjRHMDFyby84ODI4TjJkcFhxWnJy?=
 =?utf-8?B?OHREMjN4RVRxclljUW1jVDg4REVyd2ZycEtCTlRVZkJBVG9hd2Q1N1RvY1lk?=
 =?utf-8?B?R2lwdlRjbzhpYy9CNXk2T1hGRkVWd3FOR3lKN0NrYlAraW5wVC9SREpqN1pF?=
 =?utf-8?B?TWFhSGNVTjQ1RStwOFRNTzZnUDgxTjZLckhDLzNhZnNsNXVLOEw0NXhOMG9F?=
 =?utf-8?B?d3JMUU9xZE5nbkJENXlETnBWdzlQSituL2lucWxLOFk2d3pLNENQMFpPY3FP?=
 =?utf-8?B?UUgzbGFTeFVDZDZYMHZJTFBvcUlJZG1IeU8yelZQSmZIRm0xdXZMRkphT1Zj?=
 =?utf-8?B?U2VabStsejBQN2dmMTA1U00vVG1ydUlrSkwwTVR0ZWRka0pzQXhGdzJWODlE?=
 =?utf-8?B?TzFjRjdybGdPbTh6eFpUSHRzNjVxb1V0U0h3bXpGRkNZQytmMTZRNXJZREpF?=
 =?utf-8?B?ZDVXQVhSeGsrRWZQV2RFeFVPcS80Q2kzc2JFRHhHNVZtTE90QUhKNTg5MVU2?=
 =?utf-8?B?U3ZCSjRZNnFleU9zQWpUQ3hlTWpGWFUraktGd0syaitQRlVBaEdtc1RqOXJN?=
 =?utf-8?B?THVQZVVCU3FHeTNybzFSdk5ZNXc2Q241bEdaNEw3U0RaMExiemVEMjVpYWxS?=
 =?utf-8?B?NTk3bDhONDJ1dXhHNjhGMzBWVE1NYTBML1R4TDZ6dms5MUpxUGVMSDdiMTNB?=
 =?utf-8?B?ZGprUUt6RzZxOFpURndOdmJaMG5ZZGlUNnB2akdjMDlmWUFGQkdRMmRSbmZU?=
 =?utf-8?B?WVZhbWRRblFuYjNVejRrWk1uemRBRStLM1BkYzE0N05tTUZUa1h1d2Jta2tP?=
 =?utf-8?B?SXUzUEVNWUdwcU9qaXNPNnR1c1owNWdFZ1AybndWaGo5R2tnUFdVeFRISTZK?=
 =?utf-8?B?aExvVDBQN0JzcFlJNUdhY0dyTEppbWFybjZOZDZQK2ZqbSsrSjNpWFVPNEY4?=
 =?utf-8?B?ZWxaVkVFK25mTmRaN2p0ZFRsZWJ3VTRUTkppeXJNTDV2UlNEcmhOdDFWeUtt?=
 =?utf-8?B?Zk1kZHljREJ0Mytoa0gxaEN4aW8yandURVlaVUhzSzcyUWowZ1pyMXNUakJJ?=
 =?utf-8?B?bzc5bk1IRllqazAwRnFxR1NXZlhieHlBVXRWbXFmbldDdTRneG5wVFV6dEpO?=
 =?utf-8?B?Q3VSVW9YczEzWi9YcFMvanI0ZlF5YTFmcEFiTGpGWWJaUVFMNFdsbXpxM0Zq?=
 =?utf-8?B?VGRBeU9nVW9DQ3MxS1RPejdzbnhPeFN2dm1wSUV1UUVjUmtLb1FQd1N0L1J5?=
 =?utf-8?B?RHhrNEhkQ28zRjcvZUtBR0oybkphdWl5dlhZQnQ1NkZDeTZrZmZHY3U0b1lW?=
 =?utf-8?B?QWs5U0ZQQlZtcCtramdhRkw4ZFJpWCtDanpPU0h6eFdpMWt0QUpEalRodjhW?=
 =?utf-8?B?ak5jMm94WEozR3R2d3ZHNXdJZjUyWmtTZ1JrekRkOFlmZ3pYOVAvSmRNazk2?=
 =?utf-8?B?YVNWcnNrNVdUWjRsdnlHY29MeDhoeVJvWGVHbjRPUjd4TnFRekl4cEhNRE1h?=
 =?utf-8?B?cW4yRmNsK3BCbDFGc2hWRTkwbEdwRytkWU9JQ1BTUWhid1B1ZE44c3RtOXBs?=
 =?utf-8?Q?QeqFqu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhsMDVjOXJLQ0VEcjhJR0Rtd0pPeklETnZBRkQwaHJVelhTUyt5cXdkdkE2?=
 =?utf-8?B?Z2k4M24vdWVkOUt0TjRQa2dCWFJzOC9FVC81T0h2OFpMbGxLUlNEU2NNcWc4?=
 =?utf-8?B?QTBmRi9uRUFORFdrOGpxd2MrME40VmpEcXNzb3I2MlJOdzNPRG5ZckQrRWNX?=
 =?utf-8?B?a05DRkZWUExQMXFpNGEvd0owbWJhWlZ1NXQ2RUpyOVcrMkNWQ2JWUmVvRStv?=
 =?utf-8?B?Qy90RnVaTHJmTElPTE5WSC9pajdSL1ZNdGpBeGxtRkJQOG4xTEFsc0trMnZO?=
 =?utf-8?B?UzZxZmJFb2d5UEx1RUNveTVBdkVKcEVyRzZHVHh1b3VwZEJTYmV4Ry9vYUFF?=
 =?utf-8?B?Z1ZsYzVVdXVRbVI3SjV2T1JnYWlab1cwaXEyTzhhVDIwWXRRS2Z3NXRYdVFZ?=
 =?utf-8?B?UVVWM01MQXY2N3dDNFZkdEszSEwvdHpFOTg0cDJqNXFtVUhiOCtBdWlscGJy?=
 =?utf-8?B?cUhnanluNWdPUzc0alBZdHBpR0paeG80QVdFbW4rMVBhWVY5WWNrK0dYYVh0?=
 =?utf-8?B?bmpEenI1UXFzV29kNzErYWNoVE4yekRKMy9weHhWVjByYVJMVldSaE8wcEwy?=
 =?utf-8?B?cENjMktrQlZBMmk5MldFcGNvMG0wRFVHMmhyYmh5eWErbjd6N0pXRTlDUk1v?=
 =?utf-8?B?cjBMZXBHRndDdnlWKzJrOUhDRDMvV3cxWHRrcGpyeW1CUmhGUU1TV0U0R1Mw?=
 =?utf-8?B?R0Q0aHM1OTJmbEdBcExYRXFQYzNJdzhadzRzakFwQzd5R1ZYL1YzUUhqY0hl?=
 =?utf-8?B?cnZXN00zUU04cEZ2V3NjVkRpaWxpNDNtWmZ1RDNpMkhlRWM0SFpPTS9CTEg5?=
 =?utf-8?B?NENhSDVKRmVUUk9Ba0hrTThiZ1dFZkNMMk92Z1FycUl2eHZDQ3ZTcWdPT0da?=
 =?utf-8?B?OCszWHR3U3Y3RkZPVVViMDRnQ3d0TENDUjg5UWtQcW0xN05ubVNaZGtVVWNq?=
 =?utf-8?B?Y0VXbmQ2aE96SW1ZNy9PU2Zac2NMMExUanEreExzdnJiVkp4aUQ5TEFUUzdh?=
 =?utf-8?B?Z1lyblVqbE9EZDMxN1NJL1RJbVdyajhSRExVNTJQYjJPMTJNZkgrZEtBb3Rs?=
 =?utf-8?B?K3ZIUFB4bDBrWDl4L3FCYzU5YnRlelFlVmVaVXovNEpCWVFZbmRpZEcxYnEz?=
 =?utf-8?B?YVZNZDV2WHdQRjdTTERwZGk2aS9tbVI2eFFrMnpvZFg1RjFkdkx4T2tKL0Fk?=
 =?utf-8?B?VXpyUi92dWlhRjQzTW90cjVWRUlZeHU4Q1JyVU9Qek9CZ3RxZEZCcEs2Uytm?=
 =?utf-8?B?UWpvSFAycmdzN2xIZnpUa2p1bUd4ekdhSWNCVTF3RFNkSThaaTZhWDFqVk42?=
 =?utf-8?B?OXh6U3dQODdERUkvVm01NlJZSW1QRkxrM0NJV0l0WXdzYUMybnRvOWw4SSt6?=
 =?utf-8?B?WWtFNnFJQno4L1hGR2pYTG4yL3J1aG85WTNCYlg0Mm1kTURYdy92UmNQN1dT?=
 =?utf-8?B?K3dZRit3Q1JBTEtSbFRkTW9nTkJ4RnJ4Qk1pM0RLcmpYWktJQ2JYMkRSUHJM?=
 =?utf-8?B?ZW1GSmZqODB0cndFNHF3UXdIOWtoTkExUERva3NlSWgvNGxZVXlGaFZqNFpV?=
 =?utf-8?B?aWZRRDdWMnE2UEwyMmw4SWNBQ3FnbW1QdnpGa0VSUWRPd1hSRncybjNvL2c0?=
 =?utf-8?B?SVZUUnFGbGlXeldqOGhpRXViN0NDbVNXSFVDVVpwQmZnU3Y5RW9PbUp2d1Jh?=
 =?utf-8?B?dkFTVG5wN3RVK0NnRUYvYmxSc254ajBEWmRhQlpkMnF3U2k0c2lIM1I2Z2pv?=
 =?utf-8?B?SkZQSFNPQldxVUJySlhHWWI4VjdXbWllZkZJYmowdWJwRCtnQUwrTlRrcjN2?=
 =?utf-8?B?ZTNLOGtSSnFkcjE4K3BLUThsSjVFNkJaL1pVeFE2eXFFQnJXUER6QVhtRHV4?=
 =?utf-8?B?U3gwRnRDdFdCZTJxeHhuWjVUYjd6SldNTG5GRUNGakpVa1hzeFVRd1VrVCtm?=
 =?utf-8?B?QU05d0JkUHY5TnpnUVVIQUQ1TnUwcFp5TGptbks5ZGVpUVZEbGsxd0ZPcWFU?=
 =?utf-8?B?MkI4ZHJxbi9lOWdZVFVoaXRRUWQ0QzJ3SWFDOEF0UnNQTEJ2Vm11UWdrU2Mr?=
 =?utf-8?B?R2RubWQ1WGd6N2UzdTJVTmxveitROXZXVjlPOHJlbml0bGZsRytFc2Y0ajkx?=
 =?utf-8?Q?R89u6UDlqS5ZmhWhl1JC9a4TG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d0a11b-cd64-41aa-8f0b-08dda7738992
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:42.9400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jE9LEXRnuEBEm1Ky8Q901MGvy4VHaSvCGtDx9/9/Kw2tW7dWOblBHa5fVhkC23akO2UKANiEmaYRDZq2mwFu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9062

Doorbell feature is implemented by mapping the EP's MSI interrupt
controller message address to a dedicated BAR in the EPC core. It is the
responsibility of the EPF driver to pass the actual message data to be
written by the host to the doorbell BAR region through its own logic.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v15 to v16
- fix rebase conflict

Change from v14 to v15
- check CONFIG_GENERIC_MSI

Fix below build error
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082204.6PRR3cfG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:53:15: error: implicit declaration of function 'platform_device_msi_init_and_alloc_irqs' [-Werror=implicit-function-declaration]
      53 |         ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082242.pOq1hB1d-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/pci-ep-msi.c: In function 'pci_epf_alloc_doorbell':
>> drivers/pci/endpoint/pci-ep-msi.c:49:14: error: implicit declaration of function 'irq_domain_is_msi_immutable'; did you mean 'irq_domain_is_msi_device'? [-Werror=implicit-function-declaration]
      49 |         if (!irq_domain_is_msi_immutable(dom)) {

Change from v13 to v14
- basic roll back to v9
- use device:id as msi-map input, its will handle it
- use existed platform_device_msi_init_and_alloc_irqs()
- pass down epf->dev point, because epf->dev of-node will be the same as
epc's parent.

Change from v12 to v13
- Use DOMAIN_BUS_DEVICE_PCI_EP_MSI

Change from v10 to v12
- none

Change from v9 to v10
- Create msi domain for each function device.
- Remove only function support limiation. My hardware only support one
function, so not test more than one case.
- use "msi-map" descript msi information

  msi-map = <func_no << 8  | vfunc_no, &its, start_stream_id,  size>;

Chagne from v8 to v9
- sort header file
- use pci_epc_get(dev_name(msi_desc_to_dev(desc)));
- check epf number at pci_epf_alloc_doorbell
- Add comments for miss msi-parent case

change from v5 to v8
-none

Change from v4 to v5
- Remove request_irq() in pci_epc_alloc_doorbell() and leave to EP function
driver, so ep function driver can register differece call back function for
difference doorbell events and set irq affinity to differece CPU core.
- Improve error message when MSI allocate failure.

Change from v3 to v4
- msi change to use msi_get_virq() avoid use msi_for_each_desc().
- add new struct for pci_epf_doorbell_msg to msi msg,virq and irq name.
- move mutex lock to epc function
- initialize variable at declear place.
- passdown epf to epc*() function to simplify code.
---
 drivers/pci/endpoint/Makefile     |  1 +
 drivers/pci/endpoint/pci-ep-msi.c | 82 +++++++++++++++++++++++++++++++++++++++
 include/linux/pci-ep-msi.h        | 28 +++++++++++++
 include/linux/pci-epf.h           | 16 ++++++++
 4 files changed, 127 insertions(+)

diff --git a/drivers/pci/endpoint/Makefile b/drivers/pci/endpoint/Makefile
index 95b2fe47e3b06..c502ea7ef367c 100644
--- a/drivers/pci/endpoint/Makefile
+++ b/drivers/pci/endpoint/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_PCI_ENDPOINT_CONFIGFS)	+= pci-ep-cfs.o
 obj-$(CONFIG_PCI_ENDPOINT)		+= pci-epc-core.o pci-epf-core.o\
 					   pci-epc-mem.o functions/
+obj-$(CONFIG_GENERIC_MSI_IRQ)		+= pci-ep-msi.o
diff --git a/drivers/pci/endpoint/pci-ep-msi.c b/drivers/pci/endpoint/pci-ep-msi.c
new file mode 100644
index 0000000000000..549b55b864d0e
--- /dev/null
+++ b/drivers/pci/endpoint/pci-ep-msi.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Endpoint *Controller* (EPC) MSI library
+ *
+ * Copyright (C) 2025 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/msi.h>
+#include <linux/of_irq.h>
+#include <linux/pci-epc.h>
+#include <linux/pci-epf.h>
+#include <linux/pci-ep-cfs.h>
+#include <linux/pci-ep-msi.h>
+#include <linux/slab.h>
+
+static void pci_epf_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
+{
+	struct pci_epf *epf = to_pci_epf(desc->dev);
+
+	if (epf && epf->db_msg && desc->msi_index < epf->num_db)
+		memcpy(&epf->db_msg[desc->msi_index].msg, msg, sizeof(*msg));
+}
+
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 num_db)
+{
+	struct pci_epc *epc = epf->epc;
+	struct device *dev = &epf->dev;
+	struct irq_domain *dom;
+	void *msg;
+	u32 rid;
+	int ret;
+	int i;
+
+	rid = PCI_EPF_DEVID(epf->func_no, epf->vfunc_no);
+	dom = of_msi_map_get_device_domain(epc->dev.parent, rid, DOMAIN_BUS_PLATFORM_MSI);
+	if (!dom) {
+		dev_err(dev, "Can't find msi domain\n");
+		return -EINVAL;
+	}
+
+	dev_set_msi_domain(dev, dom);
+
+	msg = kcalloc(num_db, sizeof(struct pci_epf_doorbell_msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	epf->num_db = num_db;
+	epf->db_msg = msg;
+
+	ret = platform_device_msi_init_and_alloc_irqs(&epf->dev, num_db, pci_epf_write_msi_msg);
+	if (ret) {
+		/*
+		 * The pcie_ep DT node has to specify 'msi-parent' for EP
+		 * doorbell support to work. Right now only GIC ITS is
+		 * supported. If you have GIC ITS and reached this print,
+		 * perhaps you are missing 'msi-map' in DT.
+		 */
+		dev_err(dev, "Failed to allocate MSI\n");
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_db; i++)
+		epf->db_msg[i].virq = msi_get_virq(dev, i);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_epf_alloc_doorbell);
+
+void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+	platform_device_msi_free_irqs_all(&epf->dev);
+
+	kfree(epf->db_msg);
+	epf->db_msg = NULL;
+	epf->num_db = 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_free_doorbell);
diff --git a/include/linux/pci-ep-msi.h b/include/linux/pci-ep-msi.h
new file mode 100644
index 0000000000000..6dfbe9353f0d8
--- /dev/null
+++ b/include/linux/pci-ep-msi.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCI Endpoint *Function* side MSI header file
+ *
+ * Copyright (C) 2024 NXP
+ * Author: Frank Li <Frank.Li@nxp.com>
+ */
+
+#ifndef __PCI_EP_MSI__
+#define __PCI_EP_MSI__
+
+struct pci_epf;
+
+#ifdef CONFIG_GENERIC_MSI_IRQ
+int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums);
+void pci_epf_free_doorbell(struct pci_epf *epf);
+#else
+static inline int pci_epf_alloc_doorbell(struct pci_epf *epf, u16 nums)
+{
+	return -EINVAL;
+}
+
+static inline void pci_epf_free_doorbell(struct pci_epf *epf)
+{
+}
+#endif /* CONFIG_GENERIC_MSI_IRQ */
+
+#endif /* __PCI_EP_MSI__ */
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index c0864935c6864..9634bf2c1ac06 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -128,6 +129,17 @@ struct pci_epf_bar {
 	int		flags;
 };
 
+/**
+ * struct pci_epf_doorbell_msg - represents doorbell message
+ * @msi_msg: MSI message
+ * @virq: irq number of this doorbell MSI message
+ * @name: irq name for doorbell interrupt
+ */
+struct pci_epf_doorbell_msg {
+	struct msi_msg msg;
+	int virq;
+};
+
 /**
  * struct pci_epf - represents the PCI EPF device
  * @dev: the PCI EPF device
@@ -155,6 +167,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -185,6 +199,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


