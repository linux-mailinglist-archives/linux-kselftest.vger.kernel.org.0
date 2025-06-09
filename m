Return-Path: <linux-kselftest+bounces-34501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD90AD2414
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E56416E8B0
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5E21B9CF;
	Mon,  9 Jun 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A1L8ai3l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B7C2192F3;
	Mon,  9 Jun 2025 16:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486900; cv=fail; b=qfdbCgVLvX7zUhumwSkekZBpYSjcWKiqo1H6x4MpB1L1Dx/c8vMpbfFMMjlAXHMIkvDJMcP9RHFGe9xiCSYqEfnHkUjJapml6okxGvMBU7pNoPwSTQGoC5PILC34DovK/oubfqIimSDhC6sn0zZvfXSE/xFQ4k2rxGo0qVUAeRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486900; c=relaxed/simple;
	bh=yS8wGRsfaZIPE8hHwsy6DOLALXuvQXueoDwKqDv1b8I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i1PdMBwKo+Lphn66FDcx8eUYAmu4iNlDpzP/UeKu4tcivAft/KWktW6HWvq97BmzGEMmz3g4/JlxwdMOQ/r+x7lXCXX7Hma9lLegh4vKQh+7VALz09JTGzAH/H3ceGmKsElxdMLiSqY1zwxhaul0BWlICdVOJgnLZu2YTu2Osqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A1L8ai3l; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWz1I3naJvvttbI0zE2ZQEapAr+aJDLJGKnM2yxmnRUU2tOr3w46lX023yCIu6IoVR7SoIXGmElI6lp1Ugx5GkooRfsorrTatb423O50MCBo4laNNhBrwtuOWdxsRbZnsiPbUCX+7C215pxJwjXIsGBFWnZyuK5ME4QQCeT+rXMJOApxgaaDQemqduO6dKb1hzrbYDq3dixTZRdm055uGl63GSfsMnLbCTjVetWj+YMUAFTZnY4UJf6AuG5cr4Bgw+2n+CfK2kW2i67yhLHokh3yCvvf+LgGa6RiNluzFquT8uYRoZyOfGRpf1V0ay5cA0VVzLP5hJ89yFWgTUu/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxUk1mUqFQrJCfXHqPjtMa4uriAiIvWDijQR5qPwB6Q=;
 b=vt4xYAmlCPkiewg1sS11QHrhzuTKktFWSs8ioJwM+d1nwN4gBr9pce5WeNa9YJA7w3SmEFuCnpB0NMt1RvxFjQtlyag1hjTDcGKNgvE1xyyk85j+dVu/aogpN0sm1osuIB9E9Lbqf/fWh4GXPlmpVVGLhwJhIfmjaDm2/7L6fC3nZUPDutRQG/2WJ2bbS0d9HYYWaBxENY0+cg7mX5OKdHafy8AqGgJq63bwVcMbgVHjYzn9LibNHCYvFgB/876cjrsIIxuzlU/GYssGHl1KnyZX48IAnB6GaQf7JYtQBrt1xj0UFKgcASCFEThB0v9LEFIW/d7p2Ccw70kQ+FQ3Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxUk1mUqFQrJCfXHqPjtMa4uriAiIvWDijQR5qPwB6Q=;
 b=A1L8ai3lOo/yRs7CYvev3N6BQmYFgQzOfvMETZljKtWAG0OHQyrFp4cG/nWyVUEchkQ2X0Tc4majPG8P04ISKuVlU49G2lXuErhgpLo1ePPfqmvivQXyB++Q4eNwA8vx13aSBg2L3QzdE/yxPc6FRmSFyp1m6ppYoc/KvfTaTRYZeQJY0SON8HVuuEXPxp1XlYfjIXHdnockUkSe/ac6B2lDG4Qn04JW7N5RIzNVpfcfKRpn+v6mh/ue8kZgRRZhmDercq7KxgUF+8/J5eTl4Q3qpS3arJtWtm/SDtjzROPeW2d7WoeCAqlHIWqfn5oOnogD5/mSSKKduFr0VMTgFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:34:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:34:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:16 -0400
Subject: [PATCH v19 04/10] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-4-77362eaa48fa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=4364;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=yS8wGRsfaZIPE8hHwsy6DOLALXuvQXueoDwKqDv1b8I=;
 b=KwyxGiXs3EoIT61NLgE6vthzLFV+j/xarg6qjS+OqelOb68l8q9wvRuw/r9KAKgKpfDuro4h4
 +U8l/TiOmBWBG+AcJcUNNKEixvPGyF+0OVh/t4T7dq/+Y4mCJKf5Xqr
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: 23890037-c3e8-4ca6-dcf5-08dda7738f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTlsRzRzMS9rT1RBc2R6em0rSEx3eE45TXgyZTlHZklLTVhMNExRRzZFY1Va?=
 =?utf-8?B?ZjNsbEsyTncrY0orMkNZbkVMc3Z4akRmd0taZXdXV2pPY1ZCSjhiZElIOE9i?=
 =?utf-8?B?dm5kN25TbGFwSnp6VEFtcFRsNWRnSkREM1RSTmRCblRPa0Z6dVZSL3AyMGNj?=
 =?utf-8?B?TEhGU2NWWGF4cTRDLzZmM3lUeEJLUFJJMGsvNlFQcVpvRE9FbFF2SHhDZGgw?=
 =?utf-8?B?anNBV0pUNXhRRjQrcU9RU0NDZDh4Wlg0QmNhaGo3VksrdjFmekw3cTY4SGEx?=
 =?utf-8?B?WUFBcVhTdmsvRHJMZHFnSE80aFM4blJqb3J1M3VIYzNXUm5ML2EwSDc2dlZN?=
 =?utf-8?B?bzBtdnJsSE05R3dPZnVseGVUc1drSURDUzRCS3hyVlBUZUVEN1k4d1RJdWNR?=
 =?utf-8?B?MGZ1S3pJS1Q1MHE3QVpaL0FyQ2c1ZUdYcENtWGxhMUJSbkZGd0Q3TTVqK1M2?=
 =?utf-8?B?ZXZ3clYzN1VjZjJVUTRlYzRVbUFGemRWd2Z6OUJvbk4rR2ZpMzRSNjhOdEo2?=
 =?utf-8?B?VFdRWm9XVXdrNHd1eHp2QkE3NkhUc3NSZktpcFBsWFpJVzdCUng5QmJCcVhU?=
 =?utf-8?B?aUJueklQMkxIRnhCQnVDQzhsUCtKQm13b0VEdHdYNHIxOFBuSWN6NFVoT1cz?=
 =?utf-8?B?aGV3RWpGeU5YVWVOS0JMMHdrNGoxWXdiTmNJcnlqU1NGV1hZS0FvR3JnZ0RW?=
 =?utf-8?B?WldUbXBwd1NXeVc5bnkrc0pRbmtSbEI2dmYvVW9LdTdlSXg4L0lsc01CNzZt?=
 =?utf-8?B?WHRQclE1RDhMSjZnNW1CMHZ5TTBiOUVsVE4vUHpSOVFsK09Yelk4aG5ZSDk5?=
 =?utf-8?B?VUQrVGtadTJaeGxMM1BXdG5wdTBHRzdwZ1V4MDlVR2VabHlTV2NyV1daZjBj?=
 =?utf-8?B?WFRENTdGZi9uZEQ2SnZmSHNoUSt1S2NzcUlicm1rMm9ENFhkeGJWYjlvNzg3?=
 =?utf-8?B?L2p5eXUxOWFYS21WbTdtMGVJazl1aXRYbUl6VmtJbXpDS01ZVXh1cHRnWnNC?=
 =?utf-8?B?TFVvVC9MK1Z2akNJU2ZJSjhrZm1CZFE3c0pFbnlHZncwaWJNVng5OGYxWUVY?=
 =?utf-8?B?NUFPbDNDUXpvcWdYL0hDdlNUVEJlcGdPcElTRkcxcnZsVEw4bTJDZE00S3lm?=
 =?utf-8?B?eklRdkFSQjJkb05mTXFhSExKNTNJOGdWTzVyYXFSNWwra2tsVkgxdEFLNjBv?=
 =?utf-8?B?NDQzM1RFSDRTN01rNW5nakV1RUZYbHFWS3VOeFdUL2t5b1hsNFcwUGJUUHM3?=
 =?utf-8?B?RVJtS2JmNmpsREJRNW5rNC9MV1pnSnViZnZFUDhta0R2eSs2dkhYUHVPZWEy?=
 =?utf-8?B?azU2eUtzSnNBdlQrNWJNc3BNUWFPOUtqRnpQbm1FejZEYVl3eERHRXEwKy95?=
 =?utf-8?B?U3VQVW9XNDB4dlRFRXc1UVAxcG02V002NkxUNGt3ZThaTllBSkFibnRoV3RY?=
 =?utf-8?B?T3NYWUVCbjBjWkxQaFVqZGo2bW1uU1gxZDU5c0cwbGovVEdGSmUrQVF6Zy9N?=
 =?utf-8?B?YS8vQ2FLYUQ4MjBVRmR0NXJoUGhkQlBEamZtRFh4Q2hJVGdoRzBaeVlrRXZi?=
 =?utf-8?B?bGh2OTVvVXpMUjZXTHFFZU55SUsvUllWdjdPdjh5YWl2Ynk2WlhmRVRydFRN?=
 =?utf-8?B?RVVIT3NlYnlocjhqd3o5WGhZaEhwd2FqZHlWNFViQ3VTdi9Na01LZ3hzMnZl?=
 =?utf-8?B?SjRobmNjZTNSSGN1S1o3L0MyWWRmeHlGYVNRbVZqMG5rWUdYOC93Nmt0a1Zi?=
 =?utf-8?B?RTJLTGpoY1JtV1F1aU4zMmFVTU5FS2FNUFVLUGM3enE0ZGRyQ2hXSzljeVJy?=
 =?utf-8?B?MEtWTUJFYkwvWHJFSDI3cHRNbHBuOTJFS2J3ekt2a2ZxMDZpdWxLWTBQSXI3?=
 =?utf-8?B?MFRjYVRzT3hud3l0RHBqQjFkTWhaSkJnVUt2SlZXanJ4bkRBQVY4QWRxN3dx?=
 =?utf-8?B?M2tmSTVOalFKL3NVU2E5ZGY5TVltR0tlVzVtMTMwUmZXL3FNSlRwK0tHMWdx?=
 =?utf-8?B?ckxmUTl4SUdkSWJSZnBPUDF5K2s2ZUdlbFErWHlwUVlVOE82dkY1TWdlYWxh?=
 =?utf-8?Q?K13aRB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTNIS1JoN0JPSy8wUkc1dk9SSTZQWFozdld5bDd3Q0NuNERlVzhjbE5ldHRi?=
 =?utf-8?B?TFo1YWNIdXluVHBxSTA2bjlyalZVcHFlYXdvRE9STm0vTjQvck40TlI0Rllo?=
 =?utf-8?B?VEltdWhweWJKdW55MWMyekQzTG5jMG1DWDRSbklpVTNiN0NjR2Z5dDZDWkhV?=
 =?utf-8?B?UUFNSlpaN1dnMW1tU0N0S3hkRkU4bkFoTVBiZlcrWWFtaUhoOC9jUnBndWdF?=
 =?utf-8?B?bUdHbzZRYTZPTjlHK3dabnZtRkFzMys1dFh3d2QwSGxXVi9oWTFla1BrRUxv?=
 =?utf-8?B?SE5IUkZCeFdxQWFTcituQnliUjJYQWZFMGo2QStXcUNLbDJ5c1ViSWxtcTZV?=
 =?utf-8?B?ZldHNDg0ZXk5V2FTQWhCbFNTSlFjRzBwenBjWGxIbUM5dUlnYWl0cDF3WjFm?=
 =?utf-8?B?VzdYQlErNitPK3NVVWVZWENTTWRybkdBbDkwbjhvMEpaNlpQd3BVNDlFQkkz?=
 =?utf-8?B?dzI4R1dUSE40NXNHRDR4OFRJYkFWaTMwMDNRWVd6N2V4alFMa1YvOW53RFFo?=
 =?utf-8?B?S0FxTDBaNnZSajhyL3VLUXFmcWZzaE5rTkdqK2twNEhlQlUrYzhhVGdYSkpG?=
 =?utf-8?B?T25GeWhxOUJ4V0tKWkFSU2lMQmFsWFJNcDNEVm5IbXZIbE93VXR2SHhzaWc3?=
 =?utf-8?B?N21uMk1OOXNHOHNNeHIrVmFOclphTnJob2VvWkFsNEMwTDc3VC9GNDFBQ01Q?=
 =?utf-8?B?bGpyMkQrVlJMcmpMUzg1SWdRSXBnZkMzOEo2a1FhUU1GWS95eEZrZ2RQWG9a?=
 =?utf-8?B?N0pWMmhNVitVNUlpNGYyd2JldHFBcklkczFQblBOT0FmREVrOXNwRGtRUlpx?=
 =?utf-8?B?NTduK3dsRUdXSUZMc3FzejZtNGRoZzVOMEphMHBxbG5ST3dETDZ3QSsxYUc5?=
 =?utf-8?B?cGZBbFJLUmNNSzJRWmZncnFVZitYVVVkdEpsa20xQmZSOW5UVmhrRnpzNDlu?=
 =?utf-8?B?em11VDBzR1Y1aW9Oa2hpUUthNGVkWVkreHhSM3YrWFh0bmM0V3BoeTBwNjN6?=
 =?utf-8?B?N002UU8xem9hS0ZEZ3RuZkhJalBKRFhyM2labU04U3lTK1gyVHhrelBaM0Ri?=
 =?utf-8?B?SVdKaUszN0Z1NkRYS29QVlRvWHdPbTJNUit3MWZxekowb05zczRYaVI5OWFP?=
 =?utf-8?B?R0dkM1MveHZXS2tPUXBLUlhueU9OMmFmVmNVYXVyWlRpZXJoM3QyR2EvR0da?=
 =?utf-8?B?akNBWjNncTNtS3JaL0pCRER5YWhOZlhBL0Y4MHlrZlJZZ1gxZU1HYmFVbEN1?=
 =?utf-8?B?RStsT0JUR0Y0RzUwYnVtYnVJMHlKcXRDZ202MlhGZUdadTl6K0ZBVG1xTmNC?=
 =?utf-8?B?aEljcEdVSnhjWm5wUTY5U1YvSmVsMDBVQnVhaFdmb3Jnc2Y0a3UzWlRMLzdm?=
 =?utf-8?B?WUdrK2Y0Vy9zZ3VtQWNpTlJjVlVFTUJhdmFGVzBBdDdydmpsQXFEU3hlYXBk?=
 =?utf-8?B?TDQzaDVNZUk0OWREZEk0UTk2SXRMMmwrcUFZeFBvc1Y5aml3SnlLankzM2Z5?=
 =?utf-8?B?YlZzRkxXM0ZLQVcrU0hKK0ZJSExSeXg4SENrUjFOV1NXZ3Z5T1J0Z2p2eXU0?=
 =?utf-8?B?N3V0MStjNmxIUWRnRktvM2NtYTl5anF4bXNVaGJKZ0Q1MVp4VmhFNENXaWN5?=
 =?utf-8?B?RmJ3bUN6di9vREVCenlJOVFOTUJlUVVSNTFzajBHSEJLQkltM1MrT21rNjFR?=
 =?utf-8?B?OW9xaHBPSGw2Y21lbkh6Q0JsckRvaFRRUHh2alNBendFSCtHRnE0NFRsZUhP?=
 =?utf-8?B?NGhjWHJHdkVZMEJuZzlHK3dxNzI0TytqYmF6bjZOR3ZGSjEyK3VkYVRPZFlr?=
 =?utf-8?B?bkpmS1JHdmRHd1Rhcm10dFRSWVZmUWxBNTNIRndwZmZ6OWowR1dZR09QZzZK?=
 =?utf-8?B?dFdxWk5QdGoydHNVWnhvOHhyaHdWQkJpM0Zna0gxbzBleWdQbzRrSFkxOGVk?=
 =?utf-8?B?ZWFtb2tKVHVRNzFIUVRSL05NSnhXOUdmMGNMaWQrbFZicGRhbzdTV3VnSUty?=
 =?utf-8?B?RU9qVUlyL3RQTExhLzg1QTVDT1E3K3BwWHNoL2l0QTlrMXM1ZUQ4MFpMbjJF?=
 =?utf-8?B?RGdDSVh4TlQ5cmJQd3dSeUloR1hVMkxKcjViRThCdDZMK0VjTjBkQ2cxU0JL?=
 =?utf-8?Q?E+7ZweTDnLq3rMNBncw/8hRX7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23890037-c3e8-4ca6-dcf5-08dda7738f9b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:53.0503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JT89I5yCiUWSutB3zCwVCO8KQhO2KUzC5LTTzhCoOxcgSWW3ON5N6rJThOoyEz3+Jib+SUlHQF/b2sOaaMsNGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v15 to v16
- none

Change from v14 to v15
- change out address type to dma_addr_t to fix below build issue

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502082311.G1hWGggF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/endpoint/functions/pci-epf-test.c: In function 'pci_epf_test_enable_doorbell':
>> drivers/pci/endpoint/functions/pci-epf-test.c:726:42: error: passing argument 4 of 'pci_epf_align_inbound_addr' from incompatible pointer type [-Werror=incompatible-pointer-types]
     726 |                                          &epf_test->db_bar.phys_addr, &offset);
         |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                          |
         |                                          dma_addr_t * {aka unsigned int *}
   In file included from include/linux/pci-epc.h:12,

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
index 95fb3d7c1d45e..33e14a6b1549a 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -481,6 +481,50 @@ struct pci_epf *pci_epf_create(const char *name)
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
+			       u64 addr, dma_addr_t *base, size_t *off)
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
index 9634bf2c1ac06..91791480f0488 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -244,6 +244,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, dma_addr_t *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


