Return-Path: <linux-kselftest+bounces-26039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C21A2CCDC
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 20:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E573AC2E0
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 19:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DC11AC448;
	Fri,  7 Feb 2025 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZHhwSug"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F86019EEBF;
	Fri,  7 Feb 2025 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957276; cv=fail; b=mvP7Rm712EYpHH+H/vr0yrHh/srwY8w71O0vKChYzzNEZDU75T+Babju70MllkIM/a0EFAl6TUahTLBuc0rjZFH8yZ/4hpFSh5HuKcN1LEWLs0qnekImshYbDTeciZ6eueec6C/xQXnO9aZ3BSrca8UZcah5P51/2KQ1MZttffU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957276; c=relaxed/simple;
	bh=YbUj9P3D0sAyJp8B54JaH2JpUQIaScRA/2vrLLIycnI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UOzqPixz/uRmxq3DNO3svFEdUJXLsd9oSfDNNqK6pJzySnHjL/j18S2HNEGmJS+Kqqf20GBzpqIWWoN/Hd+97PeZjsJWc6U9TrIug8hZCCSkzz5T5vKHkiYmw9mYh20alxsLiJlLZImg5+qNP7nCIgoBVNVpEgHxAxS9i8fryFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hZHhwSug; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/QHEJ+cM3dks2SsRjjVFxZvpv4mKM2yuAZ5Aq/8MiW6FPbSDB121/HCGLq2tH++AHtWtATyTlH+ggVfEUPYMqh0kvknXixOGrIk7JoshwhOdF4irGexkywwCTINP4GkZIKyHIBKFHoZutDJzE5hnzl9Arbn7yYbYAcXjKXfYq4hBFUDSal69sDOphOMjowyZr6ESZpr9iQQgmMnys3SOtDygLYt2FhjWiZeAm/D8OEAFjIUkt1ucjvYpUzqYe+y4usC6f4azstE0ntxGL3IODT3myG+xfKWRnF0GZ7oe8tb1vJz1qXZNJ53jw2cUBZhoRtzWj6qStAqKXm3YxJA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQRV15xEuqYShptV6LXNYxXUwjjQavO9It5cPdfJkJg=;
 b=D6zUFhsEPN/pd0h8LN9Kz3slSwojWZXY1MUqj4nyYeoP0FxVnxU2yyR4MWql4vNTfg8fckVJpsmrCcesPDOIOTVwymE1rWUUuKqhotuiTPAlU3M+nYU42CvomXC19tgBYIkMnXAu1ywy/NtfcfQvLk08XPh5zPZ1UspgTqpCpcmhn3hJgpI9jhQdAVdAbHm5XtcoSAZn3hQHIcuKhknZqVFP+SCl5fndWqy2nzSDa8xa2xtArBU7BJYEtGYyepXc654OalznjW5lc0xXo59odLLuBU7Ynx2RKd3+JPRFr+jWTHg5wUUSHwW0/EG/eau+QWPbpL/vQrbjXKEl9CTVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQRV15xEuqYShptV6LXNYxXUwjjQavO9It5cPdfJkJg=;
 b=hZHhwSugrpN9I+LSyt9Fe+iu/ix5lDfeEfcpH5yvWstG6lBvcLfOdK4avrO+/I0Llt0Lf1Ap7cWeUKk9Kb/82wabOepI2fPs//tt/rjglbDNYuxnybb53q5SnLdgOe3c0oRLvRGNB/XcQELQZvkWZD6o7Y7bzAOyEhCFhMVR33pyyPpWVspLflnJEp6hkUALlAf/y4j6hBko9mjB7F3tLOxZcoOddGdlp7rVSOHG8bm/YiSHmRON9jch4GtiN9s3GlBbYOI2uHTMALyxRaZATl38gniKg5l++5RQViwzfkJO3HuNiN+FxWs4UtRyXEd50nNF6Cl5C0R9sHp+8jjVrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9787.eurprd04.prod.outlook.com (2603:10a6:800:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 19:41:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 19:41:11 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Feb 2025 14:39:50 -0500
Subject: [PATCH v14 08/15] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-ep-msi-v14-8-9671b136f2b8@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738957203; l=3395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=YbUj9P3D0sAyJp8B54JaH2JpUQIaScRA/2vrLLIycnI=;
 b=1i1jg5yYbJ9cvcOl6Sn612hw16rd5K/YoEF58TNDQZqjSziM2SDrz/gjkJSf3xGwJAzIC8Ypj
 S5VFPdv5gTlB2SXJXcUXheIPcpZdUPWdnj4HieAFsxOXjy6UHby5GF9
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
X-MS-Office365-Filtering-Correlation-Id: eea3202d-59dd-4441-bcf9-08dd47af6021
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1ZrdW9BeWcrdHpBYmNQMUZGYUdhSzRZTGkzMjhVVFZkNmI4UWhHb1VtMVcx?=
 =?utf-8?B?OHpHblA5Uk1Ta0l2MDVGbytuZDJEcmxaZVZDaFJJMFBpR0JmSzE5bWpuQ21W?=
 =?utf-8?B?YnZxYkl6QUtpTnhBaTl4OGlaZGk1STV0cHJPemRzMmxFR0hPVHQ5aUFIeXdu?=
 =?utf-8?B?cFNJVjJUM1c0akZ5QlVaMWVlOVdDNDFhMmc3RmFyNGdDNkRIeGNUUTlYbkNy?=
 =?utf-8?B?ek83dm5HRlNzZGhnRytNSkhOc0lDZCsrdTN3ZDk2T29NTVQzNG9RY3BsWHAy?=
 =?utf-8?B?cDZaN3htQ1M1UW8yTzRwMzc5SnB5M1FCOVQ3eks3a2tUSVhzNHFmcStxVzly?=
 =?utf-8?B?SXVmTXpVOTcrMXFzZW9tMUVaVzBQbUxUWFZMNlZXRlpndWFRZkhhV2hJWlM5?=
 =?utf-8?B?SHZGemJyYjV1elBBZEdJYWFRRG1mM3FEcFYwTXNwV0Y5UVhsTkZxdEVuVC9s?=
 =?utf-8?B?SWlqNG1XRnpMdFh1UE9reHpKemkvWE9MejFrTVN4SGNqWFRJT0Jud05PVTRR?=
 =?utf-8?B?UExUOXdXaXU2MmVNUU1oMGJEMDlzc3JST0RCSVZQMWZHZU5TT1dkS1gzR3Bz?=
 =?utf-8?B?OUJTd0lIMFlwNENhQ0huTW5UREZkYzVuNlkrR1FlU3c2djd4NldJU0s3SmhJ?=
 =?utf-8?B?c1QrcHNxL0NrWHpkQjF1ejNUR3htRFZFbm03UFVNc2NwRVc2bHBYdVJFWkhS?=
 =?utf-8?B?akQxWm5vRFZ0b2kzSVFnYVJqb1ZJczJKSjRlYW94NWR4VUY3ZHo1eDRZMjB2?=
 =?utf-8?B?Q2dlcnVKRVM4QUZQUzFQUUZpOTRXZTIvcGc3cW5OSmxHZWRCd1VvMkV0OW8r?=
 =?utf-8?B?ZFFXZkpITmRBV3dTeklnc2MxUkd3OE5mZEgyTUVRMWZOSTRmYk5vQTRFdWtN?=
 =?utf-8?B?NDJJSEVmMDU2T20xUmNkQVJYOTYzblo5WUxCWHJacmx3b3pHMzN4bEdVd1Js?=
 =?utf-8?B?bGtKb2dmd2FDRFV2QVI4MnFkd3VlQkpFOFpNUFlUMkdIcy8ySjlYWUJqNW9m?=
 =?utf-8?B?VjgvMUpLRWp6S3EwQzR0Y2RGRGpVZTE2clZHNU1VL0xyaDFRM0cwS1gyc015?=
 =?utf-8?B?cGFFRWl2VjloNmtFQ1k2dzAvRFV0cTN6dmxmYTlzaVNaOXFVZzZMZ3VIQ0Nr?=
 =?utf-8?B?MGU2Mk1jVi9ZRFh6UmtpTnJESmNTQ21Tc1pwM3ZDNFhzSllHaUs4N25iRnBz?=
 =?utf-8?B?Y1pqcHowUjdzOTAzQk9MM3c3NkErM2MxckVHRE5VU1RwaUYvWER6MVphZWlr?=
 =?utf-8?B?eFZYM1lJY1AvNkFHY20vZ3NFYmdCV2wrQkFDdXdhdE1vOFVIc2xvRlN4N3d1?=
 =?utf-8?B?MUpRcWZZcXVhcEUwam9JdEU4OXdGd2Vxd21HM2pCdkswM0dIbGhlaUxINDVJ?=
 =?utf-8?B?TytWYVdLNE5mUzBPV0E5Z1c2eDlEcUswb0w5Zkt1OGYwd1pqUzZjUEZHbDN2?=
 =?utf-8?B?Z2RtYTc2bkJHZTdmMlVFNTBHUzd4TWNqZ0NGa0VSRlJzUExjeHFtWE5XbUZq?=
 =?utf-8?B?b3dRa2NuelRKUS9Na2R0ZmpFK2Z6UmNQMktVN3FzZUNiRzlZU2tmRGl5RS9p?=
 =?utf-8?B?MENSbVo2REMzaWdGeVlIQkFGdlpRSmw2TUpDNnQveUp4RFEraVZqT2lqNzB0?=
 =?utf-8?B?amdWM21TRmFpTDZnN0FYN3F4eW5hZzBGVkcvcDVJSFJzS3JKQW1wV0xDWVFP?=
 =?utf-8?B?Y0lmQVZRK3AvRFhoNlUwU1lsR21LSXBvblpFQzBDanFLcC91MGE4ZGdVY3RD?=
 =?utf-8?B?djRFaWw0bWRuSk9TWVduYVQveVZqSm9Pd2ZWa1JYRmQ5TW5DQXRKRWM5L2ZS?=
 =?utf-8?B?dVMzeUpDdFlaaFNIV284T25sdVhwblliOE5YMlZQTzFJYUZWSjVJK0JyeFZn?=
 =?utf-8?B?bS9EczcydzlyMXFBVnpqSW1naURQbXNXamd1ajlxNjVMRUgyZi9MalJjZ1dy?=
 =?utf-8?B?NVNxdW43RXlTcEpuRGxCSDRiQ0dkZytmSG9LOGlzK203SktZblU2c0h2WTRo?=
 =?utf-8?B?ZktxQWkyZkpBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RU55NExzSVZ6Z2VWNGFnbC9vaXJjMWNiUElVM0NOeGw4emdzUnBSL3d6SjY5?=
 =?utf-8?B?SEpBZDJyNjRmeXJnd1AvMTFLMG1VTmZwUlcwMGhUMUk1c0J0WkdONkNJUmdl?=
 =?utf-8?B?L2NXenYxZUtoSFRCU2lRdzVLZEdPWWFYZW1BVSt6S1FNNUE0bUEyTjUycGFj?=
 =?utf-8?B?c3l2dVAwVTZWWjFnVUEzUHczUDhNUXk1TGlQaVpaNFJoSVU0TW1YR0JqTXU3?=
 =?utf-8?B?WTRGclRnL1RrcEdnd2RvUmNWa213SjhZZHZmNmlUVXUvVDFYVDIyVGpiUFI1?=
 =?utf-8?B?SkgxYlpQbk1XZVk5YndEWk5YQ1RBdHFIWFhsMGNZNGNNei83RFZaY2F3a3Mz?=
 =?utf-8?B?V1RlQzdQV2RuRXhYR2dUUWp6QWZSdE9TMTdnamF3NFBsSlgwVFkwNlhpNVM1?=
 =?utf-8?B?LzFkekZOUzBhcUF4aVl1bHZpdWdtUW5lZXNRMEQ3ZWNLSmJWdGtwZjlLSkRw?=
 =?utf-8?B?d284dzIyU2dpYkxoWmRFY3F2QTdMYjF1eGRlRitkaFc0Z1hkVnovWTV6dzVv?=
 =?utf-8?B?NzVickFCaHZUUmNyYXM1cWFHU2ZSU3lSNWNzQlRYK1UwSUNxYWVKMm1GbjBC?=
 =?utf-8?B?b3o1emIwdmxuZFg0UDFSdjZGemorSGJISW9RditnNWtjRUdkZzVqdzNRenhT?=
 =?utf-8?B?WVh1dWUvU0x3cnFiVHZFdVdxYmhEUXd3SERSRmNDUDN6NjBRNFBqREg1NUY3?=
 =?utf-8?B?RnB1dENITi8vZXp6Zm5hME0xelpGT3V4WDFXa0hmTWEvaU1WNjBYVnlFUVF4?=
 =?utf-8?B?dDR2dHQ5blJWRVVaaEllTUpNT2FwL1IzMDRIR0ZxMXVycWlIdHJPZDNCZXJU?=
 =?utf-8?B?eXNNbXIzMGtVQnNVRGNLMjVHZGgwY2hKNkY5VURpdHZVVWpHSDV6ZVhObGFO?=
 =?utf-8?B?ZVdsZnEyc1hIdlB1UUdVQ1hKWlZoV3pZS2YwTTF3bzc5SlBVZW4rMHF1dEVn?=
 =?utf-8?B?dnNZc3RQMkczVVFBV2VMcU5FbnNtNWI0N0w2aXhoWDFaV2UxY3hLWHFHczJT?=
 =?utf-8?B?U1ArQ0czQjhNaUF0RmFWNVh6Vm5VeWtoMjZEdnlRVEpGTCs4b2NCenIrVy9F?=
 =?utf-8?B?RGc3Uk1EQ0VRb0NoUDhLQzJWWXlkWTdlRUkycTNDcmt1T29vMTRtdllEZG9k?=
 =?utf-8?B?WDhuL0tOaGp1dTdWY1R0N2VRWmpmZzRNQkw4VlJ0U2FSSjZYUWVVc3NKRHRM?=
 =?utf-8?B?SDlmd2xyajUzZTZxK2QxdmFKTGdXTHlaUDRyekFOMDFaKzdSNUlINmExSjVV?=
 =?utf-8?B?cXpGL2pDb1ZCU1hmU3RjMzUzNXFhZUNtR2NSYy8yajE5L3VkNFRZS1lOVzN3?=
 =?utf-8?B?SlFhZmJaNXBOR0JlMjgwd2kvd0xiaytON2hTMHpaU3JEb2oyMmlkRHZ6Q29q?=
 =?utf-8?B?WlVock1IUlkyZUZ3YjNTdFJjeERDTDVwbDR3K3BsTzlqNDczUC9ZU0poMWZW?=
 =?utf-8?B?VFVsbVFVdjhDVnIrdUowUTNsd3R5WmdJSmh5MEpERnMzUStiQVJncmY2SC9i?=
 =?utf-8?B?a1dYWW5ldEh1bWpOc1daUCtud0x0S1NSSEhtNE03S1dUblI0bUFpTnBXKzBB?=
 =?utf-8?B?dkZsK1pDdnFOa2Y0eElTbWx3emRmQkhxVnM0dnBZcldZL2NhcXZOY1BCY1Bw?=
 =?utf-8?B?WnhMVm42aFN4ZGJ3YWZ1Z0hhUU9xcjgycm15Y0xuT0NIMmtnazdpdW9YSDZF?=
 =?utf-8?B?cld4T01PL3JiRk85WVZjYWk2andib0thelJyaFVnSVhaNlhTTWxHUy9QQ2Zt?=
 =?utf-8?B?azNWdUNVVUxqbkQrSTlBdDdUU3FzM1VJU0FTVzFPOGl0VFJlcmZ2VjdaRHhp?=
 =?utf-8?B?T0FJL1RiWWxaNDFmYmZyMTQxTHVrYjlaMEQwK2YyRzJmUkRYL2k5ZVEzR1Ns?=
 =?utf-8?B?Vlhwd0RqcFM1bW9GOUJ5TmVnZUZMcjlRU056Q1pUbnlFL01EN3lsVjcvWmIw?=
 =?utf-8?B?VEIwN3kvczBZdzkzcTZwNFRTc3NTME9zcnBNRExkSGdUQXBQamE5UWVUQUxZ?=
 =?utf-8?B?Sm8rUGY1bzc5VnlLai8vOU9XMW5ERll6NHdWcUFtSEkxVkxocXJieGErRTA4?=
 =?utf-8?B?TE93S2FWczVCdzdEWG80dWVaTEJmbTIwelN2ajhkK1E4bUtRbUVmclkyVjdy?=
 =?utf-8?Q?TBtgL8xKAMhRyRhBa32WScd6D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea3202d-59dd-4441-bcf9-08dd47af6021
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 19:41:11.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Qt0HAwldIuKnZyyvnRLhnwk1TFBSJ22zHFy1ksxfL51sjWGvfIGrHUzK8kmewCFOWZqRYwa4dKMFz5w4s9Y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9787

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v9 to v14
- none

change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index f728ee2660a4e..04facefc70423 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -469,6 +469,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 518bc4171285e..1a5cc4d4ae362 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -240,6 +240,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


