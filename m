Return-Path: <linux-kselftest+bounces-30135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9051A7C379
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 21:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B57D17C82C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 19:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FB621D5BA;
	Fri,  4 Apr 2025 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BPSeb+3U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FA7221728;
	Fri,  4 Apr 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793343; cv=fail; b=FVwYPIactnjHaXakGnh+yR2YqpKve32ZvvX7kxGsfoEVjn16fqai2RmHd1WvXrOjVawan/+vpWaO0G6kK/IfuLP+OqahFAdrqJVyJMAnwgYzijsr6mWTbXsxQU1KjFfNKgQDEt/RWpyVSxuvds4yRCy+5eiFTbXeY9pN6tTfoxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793343; c=relaxed/simple;
	bh=zWJgc1SPoeJ2QBwxQHqDEE5KTaCTR3/w/iApYH7Ymro=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fzl9cmNR0u79bIxVTp1T7hX9BN7xLBNW8Dkm4f+ObGjMJ5Z4APn25nmsttIQ0KKUvGjvRuNCwGjGZGONxypMdLcvEZBgffVeP+zJLDGickvVBO2zrqL6KaX54xvPRmdfHZO1+XaxULI4/4NBCR4hRv6M1mkijwebyzHWVPYikkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BPSeb+3U; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=glctiwTbAN9xZxHC2GcNRgyr+WmmwEOq1Y6p6jOSsKFyCeb950DdZ6zsmEtGwCwjEgELiUdNDpHFx4ZbmJRva+adeT7f3cdnuqyogs6OUj4LKf3+cGSFVDZdW4B5ogJm2ZMiK20MPtTDn+mUeB8L/XS/npuN+FuLoCNdl+mubGsQlWFbReOnvI7fVwX5PNkAnMHE0S1mFqCiZAJqCpr6xDykjZJ53Sybtb1YXsexLNXDYDqDxbvVm3zDksvdjCHQIkj8Ul4IJLG4rwSTl5/0p5xsBlz2hPUahCxn6Wm1j5l282sj3uCg4/MqZ0Xj3m7MnzFW3InSrPwG6qf0vr9Sdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xqxkgKvm1gj3A6xt5BIY8xtOtyrPDV5+Mm8vHnWShk=;
 b=t3fPpMVLsk0spUrL/h8bwcsEj7cBHjz2n0C73WcV+UtzVFfirZbrHccnQISBnQZB6DQUeEjdVblkLkvv+mPqwJOvKZ1/qNcN79g0MM75fM+Qu9Wn54wtWeIDwXuzYiafVi47zwtVe/We5q8Ch+MoZAeR3UicY30txkegVJiJsmAeJFpk69Nehm7YMh8ahW6ff/xKxDUev4qo+TIdqHICNHf+IUTA5M6/E1nxEtYfJJ/wtrx2S09fIrspD6/3SYtoEZsblmmf80lPaPPaRqTIBeU1jOAPkLk9LW3lJn6lAcv+461Oo/J8DccbqQP3+B5yFhRm2WB/kaSBZ0sWt3PuSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xqxkgKvm1gj3A6xt5BIY8xtOtyrPDV5+Mm8vHnWShk=;
 b=BPSeb+3U5Vl/PNzkZO3te8MgSzxCb0Q6Tfnf9NSwHGtNkCD/gdyPGgozeQnbuTdqQHtdnXrN3zcTI1QUauJeEqdASnN/64HEpCE24UvAhpy5GO9GNgqJNLs8knTuMpafT1fqJ3ysBAeQbmUceg7QMI3uLGVajo/HJx1Pxfc5OqSwA3Lm5vW/8o+qMNPV3Bqq8Haq+qng5jp2+ROvk0kd9QRBol9K/V7DRjIWY1IbEW7QNUhIbwiCaR3nrdVgO2C4bxW/5scYIpHgAdXsdEeqF0+d9f6SaaEi7ltVFog/pejZ4daodq3wMR+aWaNwhWiXNFFcuzInacB1yj0SuXusHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6957.eurprd04.prod.outlook.com (2603:10a6:803:135::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Fri, 4 Apr
 2025 19:02:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8534.048; Fri, 4 Apr 2025
 19:02:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 04 Apr 2025 15:01:08 -0400
Subject: [PATCH v16 07/15] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-ep-msi-v16-7-d4919d68c0d0@nxp.com>
References: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
In-Reply-To: <20250404-ep-msi-v16-0-d4919d68c0d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743793288; l=8330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zWJgc1SPoeJ2QBwxQHqDEE5KTaCTR3/w/iApYH7Ymro=;
 b=Q4Ke96+tqrdrEBUAyBGS3UIntJVgPnREy5uoo+JxIuzpz/deXV386D0pBzaIMWL5ml499sPCu
 y7OvkW36t4eCDEzLDyBOSkwwcb4jRoKbKqppcb1qNk2Cxi2VS0lUlEi
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
X-MS-Office365-Filtering-Correlation-Id: decdc9bb-57e7-445e-5a89-08dd73ab3880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|7416014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3dmc0I2SWV0SzlDWFIrZXQ2L2graU5BczV4NzdCMWVNVzJDeElpV1JSK3J0?=
 =?utf-8?B?WUNhc1E4RjdZYThEbEFMMnpQUndEd2VPalZqMTJwdG9sNHNHaDVxYU1MMENJ?=
 =?utf-8?B?Tkw5MHk4NG5nNEFRdmdtSjZiYUMzemdJSlJFektuSFBUU1IxakUxTVVlMkdW?=
 =?utf-8?B?THdtWEduWU9iempVcFI4RmYwUVRYUGN2TllQTkVYazkxdzh1WXBpdHJkdHp4?=
 =?utf-8?B?NDVma3JsQUFFWi8rWGJFejdUejhaMjNuK3ArKzZCamRpNDg0Tm84Y1F5R3lZ?=
 =?utf-8?B?Qy9mbGtGbTJoUldlcXBOaUE0RnBVVjhVcXljd0tsN2JWSGFtaUV0V2dYNUFH?=
 =?utf-8?B?TmlDQXNsZ1BWMDQyOTFqN3h5VFRkZmVtK3dsdmtid210V0wrckJ6azVMbUlr?=
 =?utf-8?B?SitnR1R1bTQ1MGRGLytlelNzNU8wVEdqWlBrSHlHMnQ1Y2RnTGlWSzVWQjVW?=
 =?utf-8?B?Vmk0MFB1SmtmczJXRG4zNVRWdWdKMmZheFB5Y25JQ1dtTUljMHRQOHhTUlBr?=
 =?utf-8?B?OHRWcVZsYWo5cG1xQWlyb0RCZU1tUysvblNLTWM1bW1hcTYzZ2VwTEppMnJS?=
 =?utf-8?B?M1hINTlOSVY0Zjc1Y1gvTzBJdGpiMGdNN2VEbExvVUN5MDlQb0RYcXM1RnBn?=
 =?utf-8?B?ZXZTc0lzS0llS0JqbXVWZ1ZOWUE5a0dGdmlZdmF6VWJ3SElOM1dDNWQ3UU83?=
 =?utf-8?B?aEdPTVcvdC9VcE9yUmNsY3gyWnhuQWlZSXh1NUc4SkZFYUhEc2JYYWNabmky?=
 =?utf-8?B?L3NLcXdQUENhRk5yRkd0NXdzSWVyNHM0bzFuejBpMm1oOGxKZk9qSmtUWk81?=
 =?utf-8?B?bzM0cy8vaGRjZE1jOFErOG5zWXBXbFNuMC92RFVtNGcvT001VXVrM2tsZnNL?=
 =?utf-8?B?UVJDWDZYQlZiNG9wcFZXZm1xVE81SVRLNHZ3cWFxbFJaYS9tWjVOQUtWblM4?=
 =?utf-8?B?SXYyZkFtS2RUbkMrSlFHRE8wYmdTeE9wcG5LMEJCNkpIUUVCRDRkcXBWZStB?=
 =?utf-8?B?bmxIR21yUnF4Nk9WZCtxWjdBL1VhcjAzaUN6eEtoOFRRU2JTYWFPTTNDYUlo?=
 =?utf-8?B?bmtvSGQvUzJMcTR1d01BWkc3dFYzRmpTb2YrT2F3N0VEd3drWUtHTG9GVmQ1?=
 =?utf-8?B?dDVndVFCVUcrSnpMYmFIZ2NqRmdkOUlKRnppSmVYR2M2bXIxR2ptaDdBYnRq?=
 =?utf-8?B?WjhxNlhUNnlqL2RFdDhtVklYUXdsNFZ3SmpWR1BOY1BrVTVDcEtaUFVidnFn?=
 =?utf-8?B?UUYyZmtNcUVmc285b3JhaXZiazczTGxkS0o2eW5SdkRId0tWdmoyaEZySmRh?=
 =?utf-8?B?RTNTZnFiWGFQd1VJUElOVTFJeDFTaGZ2cVRrbnpDZ1BFODlkVEZsYXNYMDVy?=
 =?utf-8?B?SHEwWStkUUp6Tm5VSmRVRjBmZzg4cGhyWGg4cnNqNUEybUNWR2hUNGtacHQx?=
 =?utf-8?B?RlI3QW5MazQ4WGl1dGVVa2JxeWRwQTFwK1hRM21oTW5RSFBBY1pOUWs0S3I5?=
 =?utf-8?B?aGE2L1hwV3NFWS9pbTlLVTZtQXd1dlNjc0pBSVBKaUxYSktMSnJqKzZ6MVJ3?=
 =?utf-8?B?aWN5NHJNUUt4ay9SeGZpb3FkNlZVb1JvaHlBT0JqN1k1eDhWY3BURSs5cHV0?=
 =?utf-8?B?TlREa25qTEY0dFowTE5rMGlMYlVNQ2xkV0FreXlsaTlheHUzR3NiSExwZ1lO?=
 =?utf-8?B?QSs1T2FKdnhxUVRuVHJhS2dYMEwvNVgrNWhLWGdjNW9DTngvcnVYOFZGM1Jq?=
 =?utf-8?B?bmk5VWdzSUo5U1dPQlk3ZTVYd3p6Rzd4Y1dkTzJpY2R3Y2ZsWWVSZzF1VHla?=
 =?utf-8?B?TE5EOWNnelZkVUM3VTJoSjJwTUZ6VWt0d0xWbHFpT3hEeHMzMWJSRmgrVkxo?=
 =?utf-8?B?Tzh1dzIxSVhnYWZoSjBtcWl4SHp5ZVVMQjNjNUU5M2lkV21YYTdBMUFobVhH?=
 =?utf-8?B?Tlk0UDNqUDY5aGMzNW0xdGJ5NU14eE1WWU1jN1ExYUhqVUFOZUtjNmVFdllm?=
 =?utf-8?B?RGc2SXM2TnVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzFES1BwWkZHRzFReFB2Z1IvNFN1a3pDb0FsMVM0ZmV2VTc5RWsvcGxJMEpH?=
 =?utf-8?B?czliVzRlTXJhUUl6TWQ5Q2JZVWRjbUdiNW9YbnBhTXFpejM5UUhlbENQVUNU?=
 =?utf-8?B?dVlid1FDSGZBZSt0UzdZbE9IQlF0S29JTWs5TUlwVDA4MkhVT0NoNHBqdGNu?=
 =?utf-8?B?MXVqeTVBM2xmVVdKV1Flb09mZTFCL2dYdEN4SXlSd2w5VmloSWd4eWZueU16?=
 =?utf-8?B?clU0Nk82SXZKWXQwVnJ2c0ZPT3IzclYxUE5ZYURsQzVaUG5LVnRNWFVxeE1n?=
 =?utf-8?B?SU9CNUp5QjJvZmFZdXVaYnZ1Uzc5QUdSQ0hXbnJUMnB4R3lQOG5lbHMwc0pY?=
 =?utf-8?B?R2E0VzZhSmxCVXY2UFJsbWlZSU9SZXVNTlFyVGxnUWVSMFJSVyszTUxrNXlV?=
 =?utf-8?B?UmxDSERpTjczNVFsWmpnSHQxWmdkZFRYTjNwcExBMm9wYm1pNnNGaHJXZ0dG?=
 =?utf-8?B?QWVnMzE4Y0djSHdBTmV3RWJlMGlLYXRPRFdUc3ZxMkdua1JHbzYvMk0ybjM2?=
 =?utf-8?B?R1RrMGwvMVYvYWVrWkYzWkxKUE9CWHdJSzVMQUVUSU5rY0dYaVNxMzd0Z3lt?=
 =?utf-8?B?MkNWMjAwaitWcEZ3N2tsWDFaMTY1cVJ0ZE84NUpnYTg0YUdUem44OFNLaUZp?=
 =?utf-8?B?VG9vcWJjYnpwZGpOeGh6d2NSaFE3SUg0UHdtS0d2bnhHckhSVC9UTEU3TExr?=
 =?utf-8?B?RWgzNmZJcFd5THdNYTEzVGUvVVY2V2sxVGo4bzJzSU9PVDJncW1VUk1lSzhk?=
 =?utf-8?B?NVVyVjJhVkd5R25sdlpQTXhaRjRpSEdITUpaUlZWNlorS0RBNzNOYmJQTkJI?=
 =?utf-8?B?L2ttTjBSc1JaVUIzMnEvNFBvdFhrOWNRcEZrRU9UdnVZdjgwKzY4Q1o3akFK?=
 =?utf-8?B?Z3pTTFFQanZUV0dvYld6a1dSSTFaeWV0WjMydlJ1VnpncWt0QWRvRGdwc2d4?=
 =?utf-8?B?WG5meXc4YUJ4QUd0L2ZvWGVxV3Z6WHRMVFpzMGRLd21KT2NWOHM2aS8rejhK?=
 =?utf-8?B?Rkpxay9qSEx3N1BOYVM5TFBYM0dOaFBDWHk5czBENi9remp5Ny84M29vVzhM?=
 =?utf-8?B?V3hITlZFTUJrb1pHZXJrSi9wdkc2bDZ6OWJCZTlmSVhIT3RBRWN4NmphL3RR?=
 =?utf-8?B?L1M4LzdjMFpGaTE4ODhhdnBVaHp2SDdMVGNIbFB1U1RPQ0pWTHBTQmUrN0xz?=
 =?utf-8?B?MzF6ZlFGZVhlbHAveENzN255Rzl2QldaOExJVXU0RFZ2Q3JQUGN5UnRnYzI3?=
 =?utf-8?B?TmlnUmpscTN3Umd0MDNIK1dIRTlQYjF1c0lOWldkeTNLM0czMzFLTmxVcnpl?=
 =?utf-8?B?ZTFCUzRqYmpoZ2d1V2RPeFNXbDR2VlowQnFGb3BLZjBmNEpUNktFeXJUWjAx?=
 =?utf-8?B?ZUZ5NEExbnlNc0lacWJHcURnL1cxSGlYbEpxTmYxTmsxTis0MW0rdk9UL1I4?=
 =?utf-8?B?VHpKRVpyeVlucWVwY2M0YW45ZHluaXFvb0JXV1VXSTF6WW1VbW9Pd0czRzhw?=
 =?utf-8?B?VXNVb0pVUW10Y096KzdCVG5GNjRtVTF5dWYvbkxKSk40UDErSCtabjBYNkdn?=
 =?utf-8?B?Sk5OZDNrTzhoaXdVbEhEUTViUEd5ZFJiVjlpRmk3LytuYVhlMUtxdXJEazk2?=
 =?utf-8?B?Q1I2c3E5bURsbU9kWkJjelRRdTVqZGxCWktQcjJNNDBEN0Q3US9pMWFBYU84?=
 =?utf-8?B?T2lDRXFtc1dRbi9xRkhDOWt2aHJZMjFxQ0hXS3FNL29ZMGhnV0o3R3JSeVhi?=
 =?utf-8?B?RGhTMlh3SVp5RHRsa2gwS2tZeEdlSWp0MTFDY0NZYkpXV08weGJnZmlwajA1?=
 =?utf-8?B?WDNhMEFsSmhPM3pGVGhGUlFtUzVlWVByTDNxMk02eEcrTUgyYlNKWU5Penhk?=
 =?utf-8?B?RG5oRUo3bEptVzlPMUVvNWI0MUI2eEtMbFIySUFJV0NwTnNSVi9ub2twMlFz?=
 =?utf-8?B?TVVCUW94L2krMGxadTJPUXBmRW1TdFQ1eVFQbFQvRVJxQnBzTnMwMTBNVDEr?=
 =?utf-8?B?TXl1Vklpa0s5ZjBoYjNtb2xIOFRYdVloS2pxVUJVbk43ZXhlcHBVV2tvalBV?=
 =?utf-8?B?cjAxcWYxUUVkMlI3S0hQNjl3Y05kZENWVlROQ01jWm50R1h4MHdyYndDMlFP?=
 =?utf-8?Q?MVpc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decdc9bb-57e7-445e-5a89-08dd73ab3880
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 19:02:18.1992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgZC+rUr0lbnCUNjKESl3A2DBqKAtWVWxCqMg6/nBh8Q3q9hSIyDbem3Sp4xJ6QmtcFOpOfgF8B/vXsIYR2e1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6957

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
index 1040d83740f9a..dcc6e2a2c6b3c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -12,6 +12,7 @@
 #include <linux/configfs.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
+#include <linux/msi.h>
 #include <linux/pci.h>
 
 struct pci_epf;
@@ -125,6 +126,17 @@ struct pci_epf_bar {
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
@@ -152,6 +164,8 @@ struct pci_epf_bar {
  * @vfunction_num_map: bitmap to manage virtual function number
  * @pci_vepf: list of virtual endpoint functions associated with this function
  * @event_ops: callbacks for capturing the EPC events
+ * @db_msg: data for MSI from RC side
+ * @num_db: number of doorbells
  */
 struct pci_epf {
 	struct device		dev;
@@ -182,6 +196,8 @@ struct pci_epf {
 	unsigned long		vfunction_num_map;
 	struct list_head	pci_vepf;
 	const struct pci_epc_event_ops *event_ops;
+	struct pci_epf_doorbell_msg *db_msg;
+	u16 num_db;
 };
 
 /**

-- 
2.34.1


