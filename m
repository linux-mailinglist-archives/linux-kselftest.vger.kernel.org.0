Return-Path: <linux-kselftest+bounces-26032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0124A2CCB9
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686C33ABE3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27E199FD0;
	Fri,  7 Feb 2025 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hbV+Wnua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2073.outbound.protection.outlook.com [40.107.249.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C15198823;
	Fri,  7 Feb 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957223; cv=fail; b=bcP4P5SwxsrEb0PJB+eRiIZrAB+Sgu4UiKps+HeYBFQlmeWxcODYcwPEYgpfynVEF7OkZN0YW8R0akpvG5i2Zj7lQQQOFFrQHExfoXTGPSyK6PSF3mZOgmjaJ+QXABXak19i+/a9UHg99mNdf4v2WsqBOXJY2eN+lLPRKRaugik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957223; c=relaxed/simple;
	bh=YyEHXUJXHVsiH03h91l1lvF6MgGI6/qQJ11yYFYKbeU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Fv4qKvW01soA5oqSlAkKT/JYtF0o7sx27nat2xui5g0qX4AHmzqYIGMBP0+4Z7VY2upAb0UHms4hVz3HWMPqchBV5HAKYLOQRUl3NefeW0FjqniD083Y5UlGF9ya9cp1YnmAj4HXYznRPlG6jxrz/CENAfrrL1UiM/Mwc03lbM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hbV+Wnua; arc=fail smtp.client-ip=40.107.249.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiKJyorXvuF4jF6d+jV4GYfvmGGCjqF2CgimKsC4+v/5Je7DsBZO5/CXvse5kmDsrAcatggVycOR1wXBSNh//IwYTDyONlnIVUtbHihLgjGxqRXcCXHmPg7fee9u4OnwqZk48ouSYskGsieI7dubQXOIUEwCPNgn7MvJ5TJJrRzlRbjkStNndhsCAVCibuOFsp9v5/sEOXfOvZVa/8oDBgLx2CpOQUyin+sduwpEcqLhNQkpALKJREv/7OpvJSmhNIj4IXAmgwXu/4lGWNFzAjBK09/EFfZDxRBrj8dBROiqtzBUWBaUMCrSTCnMbv2Mq27vEehbQGoMAhMRf4O4lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjx76H7znGqHjQfHDCt6bwEzmo5yhMnASsFnMnBmFbc=;
 b=XHYwrLXilhrVvJWEqZ7l36nkrDL0SJXKQoBoN7X5BtCFouCfSTXpt8b2DARPrFyjNsJ7t+vBdAkzL9tz+lV2tlB26LTMcZz966JxZZZ9dNl8gRkokg5rxgLHoBS7DO5EYNDdsXHHzy1d73Le0nMY/4DpERMKl+3DykJiEEOiS169/6VxM33EjM75XfTVEcElBacIpJv6F4l6cqEuo76/THAr58kM5RTbklbNfRVk8rT6Ip9dqVfYVryfyKlCl0srmop3WFiSlJR4DumOsDPt6UPPTw63L5+CM+Gcjdbj9rfmomnPJOKIfTv2ue/yQY3IK/AI2ncjmEMQzEtViYQFJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjx76H7znGqHjQfHDCt6bwEzmo5yhMnASsFnMnBmFbc=;
 b=hbV+WnuaD4MIiOXgVx2FaQREFWwL+/y9+6oyLWSs7kNq0/bOq9Bx5hECISVqkq84IxyWq3+9LTVF8iOeehp+5TZGdVpc8gNGyftfCx7zcDGwOK2cU05AkrVxCeVMAoYL2G46RvsrWjQ3dgtPXOsJ4tOC7gu1xbaEFNxZwXRVspckkMCihf4s0KnvW9YWNVCXj5HuFuOkOwTeqgzehy5cAxw4bEthwpR7dn7JIkEDpUdtrEu5AElySkagwZTp5ThCd2rTE/UCautAWiWZlSjeuL7KfjMN67PsTHgIACULnhURPtqd2jS2HMmgetY+jhPyK04ref1cUvVysx34OVo/iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:18 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:43 -0500
Subject: [PATCH v14 01/15] platform-msi: Add msi_remove_device_irq_domain()
 in platform_device_msi_free_irqs_all()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-1-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=3009;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YyEHXUJXHVsiH03h91l1lvF6MgGI6/qQJ11yYFYKbeU=;
 b=ELJWgmjA2jLwuwy80/Tq02K0tMSMPQ9ButZ+z2QWkhtOGDEcUYziwBbp3k4H4C4ZfA3k91Muv
 9XNx5860x9hClgh3BvR0IUWRCn6ftb8TH/YYS7Zt7AamrdAaMnor9JS
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
X-MS-Office365-Filtering-Correlation-Id: c47a4be1-9c12-4c24-d315-08dd47af409f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0h2M0RBc0Mrdi9XQnNsVjEyZHpreVArRXZSYjExOEdwNTdiVCsyWU1KYzcv?=
 =?utf-8?B?MlpmZWdDcnRUdTZlM0JTNkczQXRWbnhiVFVFWmdveHkreDdMK1AxU1FIM2R1?=
 =?utf-8?B?UWVzZjllbXdNTkFqNXFJQkV4TytXZjIxSE1TY1RYOGE4UlVIbkVUWG9aNGVo?=
 =?utf-8?B?NXFScUJVREJ6cmNHRWNzUHRKZ2hoV3VWbDJEbUJPZjVqZ1ZXZnRERkh4OE1q?=
 =?utf-8?B?UVZSQ0dDd2xjdnQ2RTdKQXBXM2tGWkJlekJVckd5c3lvZTFlRS9RL1owUzE3?=
 =?utf-8?B?UmRLeWRxSGduOTJySE5vaHdVQ0hJc1drU1RVd2VmckZRVjJqa3FRbmR1eGZC?=
 =?utf-8?B?akFaS0xkamlUQWYwTmxxZW5lMG1FdDE2R3BjbFhKYzgyaXZNeGJ3M1FlZTli?=
 =?utf-8?B?NmcyTFVRWUdFT3JHNm5jT0dROUlLckpQS0Qvc0QvODljeFBxblIwemZ0dFli?=
 =?utf-8?B?ZThBbVA3OGx0SVM2c2JQTU5KKzVPOE1qUUsycHhZaDZNbFQvSzdpVWNET2M5?=
 =?utf-8?B?SW9PTkhWc2VKTXBCbExwR1c2QXQzZDdmQmNBMmlISEd2aXEwUzJOdGJVVFRI?=
 =?utf-8?B?OXl5eWFxL3pDY0FPa0ZMRGxYM2Vuck5VRkxqU20yd3VXT01Ja1EzTVJTRktO?=
 =?utf-8?B?SVFFcS83SCtpQmJaRTRKVGN6aFU0QXgyVkYxeFBtVThJazQ2WXByWjNSZXVV?=
 =?utf-8?B?VG5kaDFHYi95WEtMVUZnTmIwSXNYb0crZXdQOWEvckJOM2I4alprakFkbWQx?=
 =?utf-8?B?eFZRa0ZHSTc4ZURIMkJISmt2QWE2OHFPNm1tYlZlS2hUL25uM1J6VG1yb1o0?=
 =?utf-8?B?NGJTYlAvMHUyVklhK01xYmFRZjhTZEx0YW5VaURGQnlrQUczcFlYdXBNWTcv?=
 =?utf-8?B?b1FaNVQxbENLT0xtZ1BsYTJqNExOYkhEc3FML0tjRS9PZWZ2ZnY1QUxJRUw5?=
 =?utf-8?B?c0gzN3VIc1pid01EaVlBNm1EQ2FkaTRldXFLTm9xRkVKR2d0T1JTcmRGSkl5?=
 =?utf-8?B?Z3h0OUYwb2IraEQwTmE4RGhNWm9iK01PNnZLVmhWdWdmNnBxQUw0b0UzSlF1?=
 =?utf-8?B?SWluQWhRTG5UUmlZbjlrRHF5NlllOU1RYmlzWUJ1L3AyeW5HbFYrc0ZXQ3kr?=
 =?utf-8?B?NFAvVWFSODRUMEM4Zk9xbnltZmRBZmdNd2REN3pWaXdTWnpTV0djNEZvcEpO?=
 =?utf-8?B?c3U3cUcvWVkwdCtrMDhBUXJNWjNMRlVDV25GNW50Q3R3RVRaSUhyZG0xdHdH?=
 =?utf-8?B?Wmw1eGJ1djZjV2pHUWxPSUZmeDFXZjhtTk83UitvREVIbS9KMUsrYWoxNDRj?=
 =?utf-8?B?TkVEc2kyaFgzK1BGdDFRMm9Ha25KSVhQOUdZeldFeXkxNEZlbUF6Z2p1OHBG?=
 =?utf-8?B?dzZSOXcrMjhpMEhYbE4wOEVvenBjbDBqR21hMXg0VmE0b2F6TVl6ZTN4Skhn?=
 =?utf-8?B?NEp6RWQ5MjV0WEFWUDhvV0dSTFlTTURrbU9OTVYza3RSOGIxV3Q5WjVJQzBT?=
 =?utf-8?B?cUF4M0w1RitrTDRUR1ZzWlp4bWttRExBZ0lFOE5tQk40TW1oS201RHFRWUFr?=
 =?utf-8?B?WFJQdXZxbDNFQUNGaGJuNUZPVTUwS0hXSTU5bHF2OHB0TG42TXgzTkJvcWVE?=
 =?utf-8?B?QnRlOTFPcWZ2K2dUcjQ2Uzl0WSsvRFEwZm5kQnFTMU1mNXE3RGtaSVZNa2dy?=
 =?utf-8?B?SHBPbS9udnhGSWdHam1aZ1lpRUQxdnROc3FzaTBIZGExUDhKRGsxSVBaQnRu?=
 =?utf-8?B?eUdvL3hveE9RYmhBbG5iL2xhdXNoaWRyT1htbUE2blZaTVE0SHB6VmFJbHdy?=
 =?utf-8?B?dW4yTklpYjlOWEJEWVNGMEFPb1dwZjl6OXJsMmhxbElIT3dHcDlRZ285ZllQ?=
 =?utf-8?B?ZzNwOUF5N0kwREdPUzA5dHN0TDVlMzZnVU5HcXU0SkxJQnZiaHhaR25PK0JU?=
 =?utf-8?B?TXZKUlVpRTZFSmJxRm84VEFJN0RzckZwRWdJNkFsdVI3dFlKNnFGV0NhaFg2?=
 =?utf-8?B?L0wvQUZCY1B3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHY2dDJKanlBNlpXdE5wcVR1RFJhSE9nd3hOVWJRM3VYbVd6L1U0RDVjZHZE?=
 =?utf-8?B?azQ5ZDJLVXBBK1A5Wms3V2JBZE4yMlQ5TVd6bjJLRHlCYldvZlphTmtFU0ZE?=
 =?utf-8?B?Mk5lT212dFpmNWN0Nk9QcFRYeW9NYkU1SHRPdjRIaFJlT3NvTVlWZG5yRFlv?=
 =?utf-8?B?dUh2ckh1MDhLSkllU1NrbkhFNVUyQ0s5QTVoN0FmdDNqR2liMlo1eEoyMSta?=
 =?utf-8?B?WmplUndWNXpxZDRUd0pWakY2aEY1MVBuSDdmQlpmVmRiNWRKYmJwaTJrZHY0?=
 =?utf-8?B?dHA1M2JoVVJQb0hkbEVhajU4OXl5YUpVZ285N21MaEdPcVJoTkl0L0RtWlE5?=
 =?utf-8?B?QkNyOFltbEV1QXZDcThCREx2cXVYQlVUV1FBUm9QQS9HWWx5NlI1NmdtaXhs?=
 =?utf-8?B?KzA2NDRtNldyZTNIQzFLbUE2TnJoTEZOeEhBUU1pVzRTSWZuSGpMTWNGVkJQ?=
 =?utf-8?B?ZUJqM3dveUQzWUdnbnBNOERLQ3A0b1dTaUt4KzZ6N0ZtZlg3TzJjQ0NmN0Vn?=
 =?utf-8?B?Z1FsLzdzaVFMVWt3NHFqeUlxYTZtRlo4QjdFMXpnU3hqcVE0RElIQndMV25N?=
 =?utf-8?B?bXk0ak80TU52VGFmeFJVT2lJRmtmSlZLVFZqb21SNm92QTVkTWN1d2lVMFg1?=
 =?utf-8?B?RlBKUURndWpzMHVVRDYxdmt2d2Ywa1I1b1RiVVlRVTVYNnFKM2RsR3FNbm8z?=
 =?utf-8?B?bWZYUkVWT3QvQVJlamt5YWpzSzF6bk1oMTFTUU5xeTllbGlNODQvZE02SXJT?=
 =?utf-8?B?YXAxOWEvVk1RdnJTeWxFVEI4cFpVZ21wWUEwT1ZUcFdTVlorS014T0lqVCtV?=
 =?utf-8?B?ZzFjREE4bnUwVU9xa09oVWVwVktVekdvR3BFUWVBS2RaRlpVT2REanF4UG1V?=
 =?utf-8?B?VnlaT0w1L1hnQ2NUWGtGUmJ2dkd4ckhHcnBsT213c0J5U2NUY1ZoTFREVDE0?=
 =?utf-8?B?emd2MUVLRTFzQmhKeE8zeHNjRlVtdXJTQ0RMR3dqY2VOenFOSmEzbk44MkUx?=
 =?utf-8?B?VDhPa0RBeXhzRDRVWkFaU2JjNGxXNDRJRmgyUjN1N1FOeXZlc1Zzb1NnM2lz?=
 =?utf-8?B?dU1UVnNwbG85RFpxVDRGSlczblpSYndjV2tPSFNTZlpBM0VyQ0Erb0lIMVVX?=
 =?utf-8?B?RkdNZlhCUmhDTkxETEpkcUE0ZnBkdGw0S2JDRjJiWktVdjVqV29YSUF1UTN1?=
 =?utf-8?B?emlNdGJ3MWhmUW9hS3dsWlg0QTVreHdaWEFsY1g4Nnl2OHFGMHE5STNWMjM2?=
 =?utf-8?B?K0wvVk42eWYxclhjMjg0eGkwWEljRjZuZzQ2Y29IMGplZGZRd0NvaE52NWRo?=
 =?utf-8?B?c3dnMnpMUTJ5RkV4VktBREJYMjVya01hamJaRzdKTzUzOTJhaWxSdEJxNGg1?=
 =?utf-8?B?QlpiRkFINmFFMXdUU2NtMHJqK0FWUVFNTTltclRHTk9odlpicUh2V1RwZitt?=
 =?utf-8?B?Q0NMOFMzSDdlU2FFbUk3bTdtUURKNTd4UVVNK2NzZVk2Qy9ha2lCRXNUNGxv?=
 =?utf-8?B?VUgvYzR5UGwxM0VuSW1mZ3ZuUW1ReHRDbFIycXJHNlZuczI3Zzh3VFB4alZT?=
 =?utf-8?B?V3FOMWVuRnVmbzAySFQydU9ad1U0UzFnWHJMTVUzUjFOMlVrd1JBczBrNG5O?=
 =?utf-8?B?K25zZFFieW94WEVYalM3SW0wbHdjeVhlQkV6MGdLNmtsT1VVVVFqMXNuZzNP?=
 =?utf-8?B?NitmcFFBT0kvdk5rblRpK1JhTVcwK2RWWlRhZ2Q4L0hNaGdzZ09QZ0x3K2RZ?=
 =?utf-8?B?OHhqaVM4dzBZVkhmVC9sMFVWeHJUWHZpYW9Qd2RjUlllUStYY1ROTEZERGNE?=
 =?utf-8?B?bEw5alR4L29PSStpUVVJemM4UFFzc2NtMXBZK2d5ekdWZ08yVms2WTRRdzlY?=
 =?utf-8?B?all2YnYySUhycHAwSzczM0ZZbFU5a0swY1hZUGxXZUh5YUUyTG9jeGZkUkQ4?=
 =?utf-8?B?U1hQcFVzVDAxY011UTl1THhvV0lmN3lHZTYzck85aW5zbzVFVzM2ZmJvaDEr?=
 =?utf-8?B?NnFMSWw5ZExOZ3hHVjJYUGd5ZUZIRnd4V2tJWElTbDU4Tjk4d0VwT1hscjh3?=
 =?utf-8?B?WnREVG5qL0g0ZFprMUtwd29kMjdQVHFKQ09oZVJHZWF5RWgrQXMwcXBwSzNp?=
 =?utf-8?Q?bQrBB4FBk7qlCNbhFDgPadtiZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47a4be1-9c12-4c24-d315-08dd47af409f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:18.7253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/WFmz0I7TPA64j6ruXj/e5kAtu9ESYn4vPKdWOlbuiDEYS0Uq1ouoVL0bNM1LqeFKZpvoelGNcKmU2Gvl4TuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

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


