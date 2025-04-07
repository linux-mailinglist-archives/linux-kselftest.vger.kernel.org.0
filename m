Return-Path: <linux-kselftest+bounces-30311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92844A7EE53
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 22:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 074F7162BC0
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Apr 2025 19:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B17254B09;
	Mon,  7 Apr 2025 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EPPJ5Zt8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0707C2550CB;
	Mon,  7 Apr 2025 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744055516; cv=fail; b=lui/j8p0thegRVHTuQpwHa4xCJ+nl+2JQ9L5/NUOlD9ikPJbec7obt0X81Lmuygu9YDlRkbj7+DXKMoQWnlD3CPTfpxiMdndxt0INTu019JR4ESbwty90FqQpZZC5pQzOmVNGQ4i+hWvS11gUPCNfcb7CaH6pVnnrk8nz/b+5G0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744055516; c=relaxed/simple;
	bh=zWJgc1SPoeJ2QBwxQHqDEE5KTaCTR3/w/iApYH7Ymro=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=EaJJoNA2KKH9+p+KeMwVKxVu6dg9urUaXRDLEQRAXrU2RZ5y97GM1UOPUmIZ/bUs5jlfLfgBEI3jM22ZsYfS7eAKzW/R7DVhxxIXS7LAjs5/BvTpBA1tMp6dI/gygr+ffvZq0cnNFgM7sMqT9nXMAumZC62OGZzTPHs1PFGLn34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EPPJ5Zt8; arc=fail smtp.client-ip=40.107.21.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pplpb5pvxn0F6o8pzx0bfRBbO8N2a9rMQgKLFvFAtucg/QE9MFT1nXbtMuynrgBEECU9rbPmSou4eo3ZchzyvLVFWKmzEU6HoianwRRecNk7jaiNNuWXm+I+CHsNvR8N+I7v2C9x7y1FALL9J3g97cWW8IeU3OOhUKp+RHvEOLX+C3qVKWXd66Hv4qAIz/jv6UZW5NyKIzXqwsH/KfCQGNVwX7ueeT7dqzKdnoDhoC3l6Wv4fE07prYhWdvNWxryq4uk3hAAKYuOVfv+Auwkeeorho0xThUnN//D+ijtL804gwtcKYmrgh4UnWQhXzdL6FgKKAkGJiECyCJs6cDWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xqxkgKvm1gj3A6xt5BIY8xtOtyrPDV5+Mm8vHnWShk=;
 b=BNPUIF+Zv3zoaB8qcXZuG9jSUHV07jklHDpmQ1QtIZdP5eJ4Qv3YxLEzluH6TfIbMQZ7jzaawtDifCc2DgJ3xV6gEnuKqyiPe0+jqBxuMSFGfm/DMEO5n8QN5AqvGelFVk4i8sThgu3wSrUEgmwcsKc6ZU8E358FxuBxxTD7IW1Q7cUU28wrNcUKzKph83sNCS+z7KEwHvx3eI+gORK96j3zewf+PN7jvOy4+gNmkHm1WqxbxTvBETXfvrgy9TbtLZuZWatqkXsSec8H75XFJuS0VnLLS+pKF7IwkXGcc2AaWKk8a9VHRlWlM2BsieqxV4DX5+sX8Aq9Hzts6Qr1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xqxkgKvm1gj3A6xt5BIY8xtOtyrPDV5+Mm8vHnWShk=;
 b=EPPJ5Zt8j4mFsnZmULvylHXYejpGFiwYwzC4EudWNI6zGTuzvptfxec8R6AA30csU1hwZzwB+06Nb6AvudKQfnkPXZRdSGnfhYGPJkqgN0KaVLoymazasDTgW+6TDHEd7joMCjOy3cg9Euxf4ZUai/DxLdu74LPKGokbzAWGlSCCG+bIaZKdDRwOyXgydz1ErvQi31SL4jiJZd22y1vGt/Xot3iz454sKaLIYkmdY6FuUgWOTesv5VVu1dYSJqcXurd8wAkIi0DG+LHfYAg/zAfhlGeZOIzuCPWhuODQbgJ8mdoen8aOS3zT+fMMmT6NAtMXqQxurf7o+6RdACMj9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 19:51:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 19:51:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 07 Apr 2025 15:50:57 -0400
Subject: [PATCH v17 07/15] PCI: endpoint: Add RC-to-EP doorbell support
 using platform MSI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-ep-msi-v17-7-633ab45a31d0@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744055468; l=8330;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=zWJgc1SPoeJ2QBwxQHqDEE5KTaCTR3/w/iApYH7Ymro=;
 b=nyiPRymdCierydURI7G85DVyUcFwDYVhdXO19FuXKamDTweoqe/VNTOrbd5hce1x8SB2o070n
 1U57YAJTyh+AtIsKns62s+iUTPPVLoKPBadcGpX+TGjCoqXKNajljmQ
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
X-MS-Office365-Filtering-Correlation-Id: 63b14766-e444-4fcc-54b6-08dd760da385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlhjS01mTFlhTFFBYXR0cUp3YjhXOE90MkZqSmdqQmliQ1RwWXFha0pwYVBi?=
 =?utf-8?B?MGMvSy80NzArQkNSbHF0SDc2NktySWJyT0UvQnpHNWdZbVpBQ2pyVmdML2pw?=
 =?utf-8?B?TWZsY0hRRXVsVmNkbHZrM2NiYjVOOWkxb2hQdndyZ1JKN0poN0V4aHZueU5u?=
 =?utf-8?B?S3g2WVpBVGEveDk4Sm9oK25yNkd4YWVScGh5VVdxUFNXekpkeTQ5VEJiZ05S?=
 =?utf-8?B?dzNTQXI3R05ET25PUmdJQjB2dU0rZlBldTZQNEdmcUFNOUJEeGppSmtKcnpX?=
 =?utf-8?B?V2Zuam81a3pJMGJHZ3pjZzc1SXdvdlJWamZCU3dFcTNVRXE2MnJBRjVRbGkw?=
 =?utf-8?B?QWNudUltMEI0OU1zK2FuemJyMVZVcE9yT1kzcnZVaXIxK1cxUmI3L25IWlI2?=
 =?utf-8?B?VEtlWUw0QTZkNG41S3NyditycXpZQnhDbkp5bXFWWURNbWFHVHlOS2VRekk4?=
 =?utf-8?B?WWRTaUJuSlpnYUhCcHg1di9LSGhkYzl5Y1hZdUhvY21uU0F4MGgxYUF0eW5F?=
 =?utf-8?B?azJLeWlvdjBKMVJ3K2dRNGxXenlHejdGWVMzRU0zTmE0VlFTMWdXL2hta3A2?=
 =?utf-8?B?MjJ2Z3JvODhyUE15bCtxcVV3RzkvOURtUmM1QzN4Y0ZEVXlFeTFsOGwzczFq?=
 =?utf-8?B?TjRQa3lpNDgvRk9xbGNaTnBvYmM5R2xyRmdOY0x5Vm1xajBSMkFTZUgrbzlu?=
 =?utf-8?B?dEovSEQrZEpmYTFleklBOGRJenczeGxXY3QzTmZvck5VTHFNU2U2amZBZkZS?=
 =?utf-8?B?OGFJYjAxSkZEOEJtMTE4QzhPN0FUcGVIQ2Fvc2Y1c1kwQmhYMmQ4c2hMVVBL?=
 =?utf-8?B?czk5L2hOWEdNYXZwMUF0TDUyVklZRDNieXp0a1MvdTljK2lVcXFjQ2twMGEx?=
 =?utf-8?B?ZnVnYjRMdFJVQm5VeEtuUDgxZFdraVlSK0prVldaYmhOY0kySUgzcVpSSEFW?=
 =?utf-8?B?UXRBdUJoSjVvWGV1eThEVzdNbHJBU05PSDU0TDhrMkNnQmJNWGdyVi9KYXN6?=
 =?utf-8?B?SjlvQS9ML3FjOXdLRGVzZk1MS2d5a01BV2xWQStvZFBWVFBjZ2drcFBzbVNi?=
 =?utf-8?B?cWpqVXBrQzZUbkdYQ3d6VlI1ZHFVd0ZRK1gwMUtSNU1PUWJpbWdBRDlMc2hH?=
 =?utf-8?B?TjlUVEtEYmphQ3FteGlzL1BlU3RCS0ROZ1NtVXBubzJLbTlUTE5BMTBkVC9T?=
 =?utf-8?B?ZmNHRzF6TlRlNjNPR1RnME5nL0V5R2JMaWZ6WTRkU2RqU1FzRjJJc21TcmFY?=
 =?utf-8?B?M3J2NWMwRWFjanJKRGo4N0w0WHYxR2lpdW80UWZ1c1JNZGkrL29vb3VzZm5p?=
 =?utf-8?B?Z1g4TVJGV25vK0FWUnA1RzNIRWxFcmFqc0RPOFNnOUNDQWpWOFF5QXdCblNX?=
 =?utf-8?B?eVh0SEhTckdNd3p1SVVRYUErZWZGSkVhNFRCNGpFVFVBY0lJMzBGb1VxRHJn?=
 =?utf-8?B?S0RZVWpGUlZUbVBCb1ZzQTYvc1pEUWIwVTdEVkF2anUyZC9HTUV2YzdwaXJn?=
 =?utf-8?B?TnhlMzdKVXJVVWtzR0lXS1VQbFI4Ymw5b0xlOHQxY2V1QkxmU3dCaVkrSHQ1?=
 =?utf-8?B?aitwaWlQYzVPSklITEhGR05tMnNHNTZsMEtkT3VIV01WOHhYSnQyMGpxdU5B?=
 =?utf-8?B?Rlh2U2t6aGV4VGpDL2NGdCtyYTlzL3pCSmc5UTFJK0ZmZDNXd1E0VzRJMkdI?=
 =?utf-8?B?YXdCb3p2TkorQytycTM3VXA4dmwzKzVVYkVrQWdWR3lPMlFyV0NNSXgwUWhS?=
 =?utf-8?B?VmVZOGNhTGhhWEU4U015R1JraWNIT09WNnFOZnhEelRMaGFRVHgrK3RpV3VP?=
 =?utf-8?B?ZW9BVnpJazhCa1p5eXJKVjVpeHFGak5laU1xZnU4Vi9Hc1BWRDlNSkwraklG?=
 =?utf-8?B?SGwvd3JDODRTV3R1K2doUy8rQ29WVURlVXR5WGxXenFKTFBrN3hReXRrVnlH?=
 =?utf-8?B?T2JLdENlTmVqTmx6dGZocFpobllRQi9laVVMVXUyeVFXN2VHeEh5STVseE12?=
 =?utf-8?B?NUU3ak8xSmNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzMzVDFacFBtOXpWZHhFcmQ5c245ekF4RlVpV2VXOTd2L2Ixa0NkZ1BIcmVj?=
 =?utf-8?B?UzZxQ1pKb2k0LzN4ZFFkZ0lPeDhxa0sxTHk2eVFQYk9wbGN1U1EzZFRQWEVJ?=
 =?utf-8?B?bnI5Z2xNM2pZRDRzRk95WVltREloZGZ6YVA0bGl6ZW9LdlMvc1ZhS0h6Z25T?=
 =?utf-8?B?VmNhNUIzWDVhZkV3aERFVWowUDhGZ3ZuaG84eHp4M25sOXV3TXJncEtVZnFQ?=
 =?utf-8?B?VTlPRHFlQzJaMWJrSUhDU3p1aVNnZk1NSlFCV09QRTlFSFFmQzVyWlZTeW9q?=
 =?utf-8?B?QTZNZERZMW94SSs2OTRoWnVuR3VxQVBwZnRjeUlTT2wxNzk0THhTUG40ZUQ0?=
 =?utf-8?B?c0p4V0QyUTBLNkJYeWdWdVN2Mk8ycjk5YW45NDc0NlBFY0FmVlhUU2VEVlRZ?=
 =?utf-8?B?b2EyZ2RTWW5CUGQxSGowSmU4eTZiUzMwYmNQdnEzMDlmOW5QRWVWU05VVHYr?=
 =?utf-8?B?TFZKRk40T3lxZkVwK0Z2eEpoSkRHaG1sQmx1VFBFNXc5RzhveXVsSmdwOUZu?=
 =?utf-8?B?ajlUZmxJcGdsZXgwQlVYODFSTy9UMWNFb3dGczRIR0Y1VldzVDhYVjc2MFlL?=
 =?utf-8?B?NEkvU2FHSDNDcHJWWVhCTlhGM2FRYUdLcDVkV1dvNU9DbmpzSFlIS3dFSUh1?=
 =?utf-8?B?akNEdXN4N0x5TG82MzYrR1VDYURvY2J2WWx0S2JGWXJFK2tkNkVzYnVZNktj?=
 =?utf-8?B?M2ttSncwSDVZR3RSUzRJWWx0dHZha2krYnovWkloUEp4MmttSFRFK1Y4bEwy?=
 =?utf-8?B?VU9jTnNFZ1pUcWttNmNLYnRrNmprMXhxN2FoWU1uTG0xWThmMkFCNFNPQ2dw?=
 =?utf-8?B?OWtCTjRMUWlCcWQ0TlBRSFNFRytnUHBVRkoyczBkNlJJOGNvTGRIWHc3NjVH?=
 =?utf-8?B?ZVRHVU1IWTZNQlM0ekE0aWpIdXVDM2cxaDRFM21sWkZLM05LZEJlTFR1UUoz?=
 =?utf-8?B?QU1HYVhUN2ttMFh4ZFpSSVE3K0hsd2JHM0YwYzhlVFhRSU1XeHU2OU9UMGo2?=
 =?utf-8?B?T09CNS9yTGVDNHdVVUtOb1lzUW1UZGpzeko2SFdHMWc2OVFPS0NnZ0lOWkNY?=
 =?utf-8?B?RmpiWWo2emUwSG1OeFFPR2NURTZad2lrK3dNY08vOGhoVnRpN0cyV2NscWQv?=
 =?utf-8?B?eFNuMTZ5ZUZhZmxmQVBQTGI3TWNZVXhIV2l4U3FOUkl4Mk5EaDZETnlCMldY?=
 =?utf-8?B?blcwbDZsa2hLaEZwVFp1RmhobGI4N2M5emdmbzlHQ1JaaHFHT2xjRHhOQjRQ?=
 =?utf-8?B?K1NuQjlmZkpaSkJZdzFIMzA5V2NjNUN1RGYvWXVPSSttTWhKVXpvVlB3V21R?=
 =?utf-8?B?bzk0aVdwY0JJNlRpaTVZdkxQY1RETVpJZVFzTW1xWDJabUZDdUtqSDJaNmlG?=
 =?utf-8?B?WE9QT3hJT3U3ZkJXejhpN0VYT0lNY3paSjBEQmp0d2JPNjZKTXVCUkpYeEZT?=
 =?utf-8?B?QmFGTlArTU5wYXhZREpqcHo1VGVMbnpJaVZNcnBhNC9rUzR3c3NiWW9QR29B?=
 =?utf-8?B?N1NGc0NqMWVWejJHUTRSdkozTWxhYVpJb3MrelhhczlQdy8vbWljdHF5NFFG?=
 =?utf-8?B?QzNJSFpmOGdCKzNBQXQyU2xLVndLVkl4b0ozYWl0eFJWd2I3TnkrZHo4WkZQ?=
 =?utf-8?B?WkFON0pZYVMyNHNobEhsOVg0Mml6S1A4TWQ1c25sazRpbkFaWmRPOGhCTXZ5?=
 =?utf-8?B?UG9PUW1TeGxIYnhDR2VWdkVHV0xadGxJMnQvZG5haXU3d2VrbnVHT0VoL0Qw?=
 =?utf-8?B?NTY5eXFCdFNzdmZ3TUc3MnA5c0p0ZGw5R044TGxZSUw4VWYzbWh5eGY2OXdO?=
 =?utf-8?B?S3RVMkJpMDZzdzdXVEhTamxLYlhXeE4wTlQrMndJOU5VQ0MxN0dxVmpvTUxL?=
 =?utf-8?B?bDV1Y3ZSeVhFS29TVWpDU1lpSmpzYzl4S0tHNWJBcktMTXFDYW1GaHVjdkVS?=
 =?utf-8?B?d1BNeE1mdkRLNktTbEg5NGg3WEh5Tk56WUI2UU5jM25vTVRVb3NKYjFnOUIr?=
 =?utf-8?B?VFQ0cWMyaE9aTW15MTJFd1JUbzRxT09xeUJFaHNHQ3I1V1h1NUl6SnMxR0k1?=
 =?utf-8?B?Qktpd0U3eENTUUlMOTU2WE5rUG40UjRuZElHSFRxWW0rOGpacFRneDVEcTBZ?=
 =?utf-8?Q?n7XbuvT/2dHZ7YCEsPwO540+Z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b14766-e444-4fcc-54b6-08dd760da385
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 19:51:50.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qx4hLbfvhkT23KyI3KwBT2GETc6hkEZH0Gx3iQY+pLB26zQHtAvFB7D/l9s/hGm3fJwmuapKzb+dUoR5EikMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

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


