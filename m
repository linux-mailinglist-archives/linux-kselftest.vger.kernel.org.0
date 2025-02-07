Return-Path: <linux-kselftest+bounces-26033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9847A2CCBB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A116C659
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA919CD13;
	Fri,  7 Feb 2025 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AZmmFaj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2072.outbound.protection.outlook.com [40.107.241.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71471198823;
	Fri,  7 Feb 2025 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957231; cv=fail; b=jbwEe3KysAD+9y/7haTxwNfcNbd8JllZg17gGoHhDVOs1MM0LwA5bIR1XODzB2DhFrw0it6olr0L6sHzSKyGw1V40Ri/bcmWzUZAoFeAHq1F25g4A+/M7kEJ8s7t/E8cg+FqZ2OEG2/NmAdYNZPF95f4je0EG1MRf9YPWxZtaDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957231; c=relaxed/simple;
	bh=BBPZu3vM3DS4Et+u/pFNZeWalbpZcMbz4adBAMaEmPc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=akEMddjxBMoLZHtY5mWJA9/XwJ4xf1Z9cqxRAxtKZ1iTZ9np7rEDZ95MvFeTSX4iVf7x7MrYUVCOzYLZOy47dpzEA7nNhjqerZ/qoFL/OesUmUHghHzNmvWEBj8aMhkbG7ytcEEz5hPyXZYe66D6RQknu7eLgfy36GSyH48YbLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AZmmFaj8; arc=fail smtp.client-ip=40.107.241.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL3f5DFWwo0yWl2QYjdcjQC5qCsJq4N/gSgfLtnOOgiJJwSRI3dJ5bVH/nfJzq0N1G8V/UsblgaX8KhH1v9CF/+btroZ9/brj9Mq7zmbrNTaIe1O9eJG/VovgUrBz5ZHbUXDBZRkwM1SvMbBEH3J6fyNcKyDvXH1g3Jw7w100lS0RBU71ExEfPNkM0wzQEsi4dRBzEMYPiYT5QC8vzGNwHMrNxOV55XyxxngJizecLOFKuv8f5JM/6pWB1ZQFkQNxrbv6rxGZO7zOL7iVJFFw/Msh6u/A8z6XOx5l+kIvoytfKmOa0+wzl6cuJ/6ZpN3WEhXvT4op+rpGMPTrQwAWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQoMAC92f7OP+cMsgkFVAJZa8Gnf9lnYzg3ZbfrGcQc=;
 b=hnJ5tEoXkVzl6dTlj/k+wVe+A062kSGndMnA0My0jFx84S6N2AqSGfE0MqiYO5FJFJfSPTQFBEIhEzETbB06UlrDsujeYFU/mu6KrnHY7uxe/5Ou0TL1WnRduahBSSQcS6ZS8sUoAqnlE03WTP0gKaZmZYBE+j46D19jDRV6OGDeEtflOMA6mnbIaFq8jsAV5ioexj19fsRpNiBsjxjS+gUpMGcwGAHyzW2lMInPAqgj6CyUfo5O4+iYSFa0BM12njq8SiFZqtU7CfPALISwAfR0irjEtkOfm9hd3pgmi/U3vCX+VlOSxKmW/HEFPPdyhbpA5I/xPhrNt+DW17VAfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQoMAC92f7OP+cMsgkFVAJZa8Gnf9lnYzg3ZbfrGcQc=;
 b=AZmmFaj8ukfEpJ5CXO6xUI1VbHbzDjVI+2n6132uVlB07yqMpjJuPWod33gfepCugyCmqLBFzsqs5/h1K3TwQEzcv8dSrDqbwmat5A1h4/bZxmyBePRvSeJAUwlUiBo0k/Aw4iyGIc6fDue9OKNBLgnJcOSGP5wGlEYDoaOMviNrz166eW5qkBksGR/73QtGXsw/Bh4u9hjgqNZTheXSm/4QrZgsCHgPLR3TxYbCSyuBS+YTw8cakQmySvOJhVQXYikSOul6B5CWG9nHTdKt3+HZapBVQ5SPIWDnAkeN/NokggCRpIVqPgyqusS/y52FPVmfFAyExgnV6y92BhA4qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:40:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:40:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:44 -0500
Subject: [PATCH v14 02/15] irqdomain: Add IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and
 irq_domain_is_msi_immutable()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-2-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=1840;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BBPZu3vM3DS4Et+u/pFNZeWalbpZcMbz4adBAMaEmPc=;
 b=IUL3FPHhfjFlN1NPgxI2rsrL0VkYbNy3xeeswoRNyi4gaAy2x7mUaqXDepvlDl9ESFZo6CsJr
 B3SoDzBSCGiAmC/oskogqr1AHDVQFGM+y5aevGKPYoSY5ktSRP3RNCn
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
X-MS-Office365-Filtering-Correlation-Id: b9fb78ec-0b47-432d-f1ae-08dd47af453e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enl4bGp5OG9wRFFjd0VMUGhCTXo4R3JiYnc2b2Mya0Z0SmtXNW0yckdxYkE5?=
 =?utf-8?B?Z1NVZWpQeCs0YzFUR1hTa2NlWHl3cEY5d1pLVTBaZWhmZnFORlNaNGdHY2ZS?=
 =?utf-8?B?RkhuMW42WUJndWRWSnN6OUl2dlhLN3dyM0IwTytOWXRsQlE2Z2hoTE00ejE4?=
 =?utf-8?B?Smh3WWlPbmpqdHY1OURVY3JoR0tnMXNXNU5oSWN3WndETkE5cUIwRWs4bDBW?=
 =?utf-8?B?UDlLNEc0OVptQ3hzQ0UxMUVJbFhzRzZwMEx2dlRBTktLa3dsVHJRVDgyeFZD?=
 =?utf-8?B?YTU4bDFqclpPL0FLdXdRSmtHUWY4NExRSGNDcWJtWVRFN3hnbFJxRTg4OGdl?=
 =?utf-8?B?TkhwcnlGNnhDcFlieTNTN1cxcW5RVFVocWNualhibzBraXJKSkg5N3Y5V0k4?=
 =?utf-8?B?Rm1qSUNCVTRIbFg5MXF5a2hEODA0M3poY25DWWplUFlOVjdNRnhGNDc2TTJw?=
 =?utf-8?B?Q1ZqbUtMekRZMjBKR28zS0NiRzBmakppTms3OFVLRHA1WmN0akVaUzNSMk1j?=
 =?utf-8?B?WXdlbS9RWCtjYnRQemE0TmRLQkZOQ3JUY1JPZjhydVJwcnVvUWhrYnhLVnEz?=
 =?utf-8?B?RzJDRmcwZWRyNGttN0VXdUNES3VjRlZrVlgyTkQxcWVQZC9weG1jWUVyZGxE?=
 =?utf-8?B?V3ZVZDY4Z2FqRWpoa3djMzE4bXozNUQ0QXZ0OEkwNXF1YkpLY2lrdys0cEYr?=
 =?utf-8?B?OGgzVThFTFB3ME5yODQxNlh0YjlJdnlNQ1NaZHE2dE5SQjIvUTVYVytKdm1G?=
 =?utf-8?B?bDkrRVdWOE9FT0xZRWhaYzRGSlJTWVVHZmtDNy9DNDVZZ21ncytWcnVaQzE2?=
 =?utf-8?B?cWxZajNGTUtQcmZSNC9WWmhxbzFlc0k2YUxHZWNKQVNMSFFVN0VRUC92QnNm?=
 =?utf-8?B?ekJFVnF2UmlGVnF3UUZwZkVFVWp6M1VHd1cxQ2VTT1ZiZWdKdWkzRTZzak5h?=
 =?utf-8?B?aVFIZ3UxU1dZN1RtemFYay9QRzVxMWJ6UGJCQmVHYUowNG9LQXQrcUhsZ0Zl?=
 =?utf-8?B?OW9OMy9qSWwra1BaNEdicUFJQ3ZXeWQxTGZzTTd3L1dyS0tCMG5OaTY5ME5x?=
 =?utf-8?B?UkJObllMd2FTS3FwWVI1SDNFSVhtQjhaSmNVd0NOM1RROG8yRndpWC9OcmFL?=
 =?utf-8?B?MXBmK3ZmN0ZJQ3dYY08rc2lKSk44ekR3emFhOFBNYUxmYzRoSWZXcC8zNXgz?=
 =?utf-8?B?SEVzN2t3V2ViMVNZWEIzc0VXUVFZNmw3MmxOdzdpOFRKdENxQlRMSXE0bWdm?=
 =?utf-8?B?UEJPc1JsbXBzSWRicUd1b1NrZHZvc1hlOEZET1ZUQWRpWkFEeXRnemNwanJX?=
 =?utf-8?B?QTVYVVVxMFVjZkI1ekVWL1pSSFpZVlRnV2FGSWFjRHNPbVNmbFBpdEpWMHlC?=
 =?utf-8?B?b0NUdkhVaFluSzhZVjBqVUxrYkR1Z3FGazNadGZqeVNNUVRwSXY2NVF3SVM2?=
 =?utf-8?B?bFRWT2NkSnl5UUtwV0Y0bHpCSmxsajRqWE1QVEtHdGh3N0xQVEp2eDRUbjdH?=
 =?utf-8?B?a0hPZWZMMmQ0VXVnbWpNUHVCV2ZZRHFLaFA4aVZDNDFTMmRicENVa1NWeTln?=
 =?utf-8?B?UHpWSWhYSHh3azJWUTdDOFVJWTkxaHNHQ0xZMUJMZVlkZEdmZmpvZXRRSFIx?=
 =?utf-8?B?ZWFpbFhydXhlVHBERFdDV3dFSTZRQlRNZ0lvSTUvYm9RUDFvZ09xdjVQbjVU?=
 =?utf-8?B?OTNzRnJLQTVzWGVJNm9Ga3B6Z3JEMFhjVysrMjdmbzdKQVROSlZaazNwQzR6?=
 =?utf-8?B?WUl4MzRQbHQ2MHBxcUo4SU5FcGEvWFZFRXNEbWhSZXNzMlFaQng2eitjRndJ?=
 =?utf-8?B?ZTkvOWdIQ2tidGRmaUk4eDUrNUgzeWc4RDM1czRNaGxOTm9XVmJKNTBuZlVW?=
 =?utf-8?B?aG9FZkQxaGRROGk5eGI0SlBOWlViL3VkbDNlNERPZjNlR05WcVpldndlbVIr?=
 =?utf-8?B?V0lodysyKzNPb2lUNjJGNzd5bStZVUxUMHo2VE8zeXdVdGh2cklNUlhxbkFK?=
 =?utf-8?B?aVpDU1Qya293PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0g3UFRoOHF6S3hybGVmTFBlTE1XTXp0Rm1VeDJzcTZkWkx4S2dtWWw1azk4?=
 =?utf-8?B?UjVFUmlCa3V4ZVpoQjNtYmRadTJmaFJldVAvT3NuTitWbmdGbkk3U21pcGdq?=
 =?utf-8?B?T0RmSUp2WUJpWVZVUDdyaXFTcUZtZUlVSElwc2YxcXNxYTZ6aVkyZUQzYnBX?=
 =?utf-8?B?ZlN0TGZsZnZvbHhXMmZrRTBWZ216Q3o5WlNiYVBiUnFlRUVCRWZ1SVl4QVpS?=
 =?utf-8?B?N0hJNFVBM043akVkbDNFcU9vcEFhalptbWsvbjJrWFRha3dBSERvZE5FQnBH?=
 =?utf-8?B?NlErZ3B0WW1Fck5MVTBsVE91eWtjN3RaMlNLS0ovdEFTV08zK2lBYzNhajNZ?=
 =?utf-8?B?Y3RBd1VlZU13c0thdTI2SmtCZkdQbDdtc2ZXVGtkNTQ0blNBV0E0V1FBaXJF?=
 =?utf-8?B?QndQRDQ2N3grTjEwaGpubTZpZlhyVWxEU1p1cTNtNzBKaDVpazVkUkNoU0t0?=
 =?utf-8?B?aVlGNW5PSHBNVmlRcFkrU1VTSHBGZUdQTWMyWWhTdFF3RHl6WHBBV1d2WVJt?=
 =?utf-8?B?RWRsVkhaRmFvTGlIbGVWOXVQN09ubjZOakFOSzExR0VrUXE1WkJJeWY0RUJS?=
 =?utf-8?B?bXFDTmR0ZnZobkQrVHpXTm5mVEtRcW9Ha1hxMWtYcTlKUG1MdlI5YU9IU3Ns?=
 =?utf-8?B?V3o2NVNhWWtOaEd4YWVhbmFIS1pSa0NsKzRlOUNwdUNrb0p3dUVuenNhNHd4?=
 =?utf-8?B?Zk1JekF6dmZSNlRjSXErWVA1T2JhM05vVTkzQUVOc0VVdmJhbFB1UHR1SmhO?=
 =?utf-8?B?TjJ5ZDRQb1VwZVcrWWkwYVNLZTdtZXE3NTNkN1lLbkdtMjJTYWwrdnpQMmFG?=
 =?utf-8?B?SWpOR1VWc1ArN1R1Wjkrc1QzYWFVYlZwSDV5N0JOQ2xPR0pMYTNRQWlabjVz?=
 =?utf-8?B?QjU0OXFJZkpuanNWVzRLVVorZDNQZFUyVHlNRHRIaW0rSTRzaFh0a3hsajVX?=
 =?utf-8?B?SVFNNHdsVjFmZTFEbVlObUx6ZmVDZElBR0I0aFlzUUJHUXpEanZRVFhKamtw?=
 =?utf-8?B?UmVlUFA2QU82N2FLbU5tVDgrQnBuZW1YU2xGTHIyUU9PZ3N2YWVQR0tvVjlx?=
 =?utf-8?B?NW93T1FZelNJOWM5bk9Eb2gxVmRRaENkR05SdG5ZN0RnU1pLUkhQQWl0S3lU?=
 =?utf-8?B?NEw1Y1g1QzAyRGRJSWNGOVhLRk1kQ1dBQ1dXSUF1RTQ3Q1czcXNMMGxTTzRF?=
 =?utf-8?B?Z1pFVlBDZkp3b2d2T04rdjRiRTIrQVU5eS92dFA1ZS9IVWdTRXE4ZTB1RjYr?=
 =?utf-8?B?UG9rdVNseDI3ZmxMUmwwSHg5SW5zaVkwRks1TVdVYUZtcXMzTnh2Qmpsb0tU?=
 =?utf-8?B?azd2Mml5OE5IekFpK2tOaXladE1MUWlYYVRnUFhOT3ZySllPZ0tRZDAxVGI3?=
 =?utf-8?B?enJMaGpIemVRbm92akJGOGMrNVZqN0thVHQ2MWUrQ2h0MXNROVRPYXI0bllx?=
 =?utf-8?B?aW1XOEdsbnFOV2hxWFNhRk5UNWoveEVMcG9hKzluQjM3Rm85cjRwdWVIR1NB?=
 =?utf-8?B?MUQxODVCeFhFSURlY3MwZi9pOHpoTnlYOHdha1JsZ2pSZlJaSGxVWjlNWllu?=
 =?utf-8?B?OTh3K3pSeHAzQzZUZVhXOU5HTzEraEFwNzN1VmRNeUhQYitSSHJhOXA1ZHgw?=
 =?utf-8?B?MENrYnNkWkR2bTlHZkRteFZZckYwVThvZXQzeGkxNHB3VkFYUmc2SmtnUCtN?=
 =?utf-8?B?MGw0dkh5RWVjK0hNcmErKzNFYnlTZXBmRys1VGxUT2tlK0VQQXBydnFLMjB4?=
 =?utf-8?B?TzY4blN5cWFOQVQ0dkhLV21GdGtjaG4vVzlQOFcrdEZxcHhuMmMrbGpVM3l3?=
 =?utf-8?B?eTlnajlYbjM1Sis1T2l3Yk9xMmZsdFZTTkZIbHRaZVZJVVVZMTVrdkd2bDUr?=
 =?utf-8?B?ZVkzZGpCcGF0NCtydjlhblZrUlUxNklxTWxGaGhpZ2VCSEtLSmxDbDBIa092?=
 =?utf-8?B?VW8rM0RiZVJ4eDJwcEVuVnI0NW5OTVZMUktldTN4RHNCL3padmo5RXlzT3Rp?=
 =?utf-8?B?cnoxNk95TzdzWm5pNXN2K0lreEhsZDIvdmxoQy80K2ZFSjJvc01MOU54TGpw?=
 =?utf-8?B?Zi83SkxBM2I5eENQWmdPZU1VenhndGExRlVXOEVBeHVSODUzZ1dmZExKcUsw?=
 =?utf-8?Q?hEdYTFrO/TH0T8RE2WF4JNHP/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9fb78ec-0b47-432d-f1ae-08dd47af453e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:40:26.4244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cBQ+LAgri4KcMcOZkiglGbWoo+GqYAQzQly2CCZJGjiB/apq6aEeAwVK/l5hRUb0ZN+iqLFYcNmc+jzZWy5Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Add the flag IRQ_DOMAIN_FLAG_MSI_IMMUTABLE and the API function
irq_domain_is_msi_immutable() to check if the MSI controller retains an
immutable address/data pair during irq_set_affinity().

Ensure compatibility with MSI users like PCIe Endpoint Doorbell, which
require the address/data pair to remain unchanged after setup. Use this
function to verify if the MSI controller is immutable.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v13 to v14
- Roll back to v12 version because Marc Zyngier have concern about add
DOMAIN_BUS_DEVICE_PCI_EP_MSI.
https://lore.kernel.org/imx/861pxfq315.wl-maz@kernel.org/

Change from v11 to v12
- change to IRQ_DOMAIN_FLAG_MSI_IMMUTABLE to minimized the code change.
---
 include/linux/irqdomain.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e432b6a12a32f..3dbe05d8740e6 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -231,6 +231,9 @@ enum {
 	/* Irq domain must destroy generic chips when removed */
 	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
 
+	/* Address and data pair is mutable when irq_set_affinity() */
+	IRQ_DOMAIN_FLAG_MSI_IMMUTABLE	= (1 << 11),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -692,6 +695,10 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
+static inline bool irq_domain_is_msi_immutable(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
+}
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)

-- 
2.34.1


