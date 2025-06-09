Return-Path: <linux-kselftest+bounces-34502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62887AD2416
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 503FD16BC5B
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8961521D3FD;
	Mon,  9 Jun 2025 16:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RXxUYk/K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5399E21D3D9;
	Mon,  9 Jun 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486902; cv=fail; b=Z2pwF/ktlIgIqDGujdwyCqCTkFdaAE9tMd1031vs6Emf5u1WVXcTtjzaWrGYEsdjLAJPD9Re4exsLIJGX+KgMJ9g+TKENVVxn+7YJyT+B8SGhKhxkCxM5mwVaw4i05mlVjNacggkeAWivh3ME5Qy/zJTY1I2IIn8eDGSHzhm4JI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486902; c=relaxed/simple;
	bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=V/yeyKRJOQ2GRaI7W65K3EtG0gvtIn7mjb/UMbiSrAtCdDbcn13VmkY4wsGvCQ5uaD6KGaqIfAAwJCBGmr1uAGlKuOq/1kWziUkuzGxaBnU6+mMfJBZRnPztJJpLepw+NiczLz3D4Tmx2WQc84AfYQrXep5IEdm26cyptzCSKrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RXxUYk/K; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jl6NT3bVVkz2VMxNdYF8zKVgO+vZC2HQ2jJP7ni1P9hcnjoDKYXvbEAQ64VyChju+/VlUHv7URQgCdFiW22woha8lZNa4dqN0SkJ7ptksP4mGhw8nOWXwQ5SuVJXR6KeN7VPnRIQelDK5slIw7pmQPPIHwa+i9Xrlg/wAVixiDwnnC6gDA1D6u5mXeCpUIBNzqqVNikFRDYvSWVe8r88dtAt9RmC7kdTvaTbTzAHr8Oi0v29Sg3Mq7eudef4duLUDh30ND1LHw/9HX90tatgRgs/CSrXjosKrMkJ6OHU3PDNTO/+zSOhYm47XFNs4FWv425OnzOo1X6FwC3kxFTtlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=VXsWR+AAewlgVIwNEJ5V7kDTjPzKtBzSnRCTeuiOaCA14xBNY4cejc7NoWQFdTzpsGD39mz1qpbzELAmGE6Ba/FkFWA0ttmJ+CqYRDgWRVQ5VtJWIIhlQZSJIpkFD0l5mdwz8OIL7GYVOHU28EjVbs57u/5fI6x3Tmh3iP1nrd8FqBkRmn+d29rHZsev3bm7NquHEI+m8cg1clPcfH1Sz30ioU4Cymd53AysD7bRHK9YizRzRoKx7IKDRnro2F4IT6cS0JsiDOmfNAk5EyrevcWGZqEedPOiszP3FxOogQtTywmWCywCrx3Hdww19kdgRq4Z0V1o35PYrslQN7XBoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKlGqegoRweF1++Jqh2S5594pr64Kj2EekHsAJSq3y8=;
 b=RXxUYk/K2mKYcD3LqtGfToiSDtJdss71/qC30ecVbHEVdqtV5ru6jXZKcw3CaZnXphg5IWsIokl4vFeGOqwIVtDFtJsEP5mslqTnyXo93JfX2p8ci1VJa4bgVYdj/NMW2YHRklS7ADLxWCSrFh+K4UjtQTzwGixmtUP8aMmXDNQPpV1YChD9qwpfvAR+Z2QTed2buUwAzEej3MKpf/d92TikbDFQsmRL8DsWqZ8ZtSThK/s8xMPnKFPe3+cUxvUubC8hLHh+HZU53RBdyDpNmZ5CDIS2bUZHVMEcZuxyHdVdFGPA6sdI3f/3Idkx5huuwg7pdJv5utdwPr/aW4VrHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB9751.eurprd04.prod.outlook.com (2603:10a6:10:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 16:34:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 16:34:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 09 Jun 2025 12:34:17 -0400
Subject: [PATCH v19 05/10] PCI: endpoint: pci-epf-test: Add doorbell test
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-ep-msi-v19-5-77362eaa48fa@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749486867; l=8739;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GZxnLuC67KA9+f1ZFFupamn6BH671XQaImre37vE7/Q=;
 b=Jb6LEzik+KYNB19zeEljCPCu3Cp8Rfwhn+4+3+NA1ypVf1ik0/G1VhzTOcf5fXOR2FPO+YHHa
 pSEIwjtnpN8Aad8klEs+nQjMpRDwmAU3tl7s+zYdzkRqfUACSctquv+
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
X-MS-Office365-Filtering-Correlation-Id: 4d80a9f4-5fdf-4e19-c79b-08dda7739295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uk1POUZob1RXOGZRMFFvR2c0Y0ZoajZGWjRGa2Mzd2NJc1pVTUtpRmJmZkdo?=
 =?utf-8?B?RFVVQlRpMzBvdTVMNFQrcUtYRTIxd25xR0M3MlNNY2tqRzdSbHgwYWIycDky?=
 =?utf-8?B?T21BdlFNQjljWGxyT0h5cDlVTmpsOVRUNnhRdTFUbGhUcFUvSGpVNHFpNGRK?=
 =?utf-8?B?bkZnaW44L2t3QytndEN3Q2I4NnlrM1JxM3NGckRpK1IvSmNLNkx2QWljZ2tw?=
 =?utf-8?B?RGRvVU5SQVVPVmh3Sit5V095aExyZEJ5dktEOTlDNWZ6NzAzTkpUMkhsMXRp?=
 =?utf-8?B?WFhKd1JlTWo0N041YktuVEM5aUN5VDB5NGFkc3BRaVQ2NFlldzROZ3Rkd0xy?=
 =?utf-8?B?YWRBUEhFM0Zrdy9ZaFN1R3VkSHlVWXBQQUhQclV2U3VUWEF3OVg0ZWVpWmpT?=
 =?utf-8?B?L2pSUURoSGRFdWlIWEFIOEp2bzRITDBnK1ltSENyTHRKbXY0YytRY0ZxaGFs?=
 =?utf-8?B?QnhNVXA5T1RGQWc2N1ZNVTR0azhMekt0azg3alovUFBNTkF2UHZhTHlyU3N5?=
 =?utf-8?B?TlRYS2UzVGxQMitJTHdvcEdIOWdtZ3pucmFJekU4WWZxZ1MvS2J2WmYrTkVk?=
 =?utf-8?B?U3hZQXlLMVVrRVBXM1NzOTNJVUJiOC81ZUtyVk9ydW41VmlZa05PbTd1QVdC?=
 =?utf-8?B?OWlqTVdoV0tuR2M1T3NnQlF1dkpLb1JXeDZpV3UrVnEvUUdTY3djZDZwZXRX?=
 =?utf-8?B?YnBRK3Vmc1VDdFdTdkxueDIwczdnc2R0Q1JqbS9QbjE5cDRqVGlzVGI1VFND?=
 =?utf-8?B?SEV2WHN4T2pUMWh3Sm1KUTM4WjhOaXcvdDlLRW5HcHFTNTVnVjRJeDBpbHlk?=
 =?utf-8?B?STEvODFqdmJVRS9UbnZ0NFoxREZwRENnTCt1cWplSDlzcWU0VTEvRWgvM3R1?=
 =?utf-8?B?UFIrd2NnR2Nsd2ZNdmx4RHhSbHZuVjB3MWRhQ2NRU0RMVXpZTzU5dFRZV3Zo?=
 =?utf-8?B?d3ZaemNFM0lHMFNUa001aXpuOVVvZjdrdEovcUlZU1p1dVgrUzNvY3pqYS9h?=
 =?utf-8?B?UW9SaDdUUnlIMFRIRkdWRDhEWHNmbDlIbXlyenkvekYvalVZK2VCMDk5bTRS?=
 =?utf-8?B?VE1mSThZZVd6Qm16MWxXQktZQVNDVWg5cDRTcmxXcVpxZ2h6YXovbHhYMGxL?=
 =?utf-8?B?Z01kS0M1Wm9FTVNIcXp1UjhleWt1SW5qa2tXVVdESXJsZDNGbHhkRWVUYjRI?=
 =?utf-8?B?aGU3TjR0OS9LbUFWRUdXTkp1ZTMraUxhY1R1VFNzbmt2bjBlNWZJU2lhaWc4?=
 =?utf-8?B?YkRxR3h1U0JMMDNMdG1kdWpCTmsyZ3hwcFEvODU2OTZDYXdpL0ZndWU1TzVa?=
 =?utf-8?B?dGR6MVVHQzRLRjZrMnJ2Sm92dDBOUWVseWQwUkN6UE1xc0wxODhnVlpCOXUy?=
 =?utf-8?B?dElOS24yczdFZWxpUDZaNnBoc05mRWRXZHZNMDBzenZoS08rc0hkL0hjVzh6?=
 =?utf-8?B?bWpOcUoza0dpK29sVFJLTGhLQkVzeU5KNkFKTmdXR2UrRUFueHIvQnh0TmZJ?=
 =?utf-8?B?MW1XRGJWMlRDMlNMT1dvR1l2OWFiMm00RUhZall4Q1RyZVphOE9YMlZJckg3?=
 =?utf-8?B?Q2RGaG42WnNJUjBwYlYrOS9JYUZLYmE5MmYxNHUrYldOYVJFa3RaQjFENjlR?=
 =?utf-8?B?ZHFncTNDRmxSdkQwT0lHSGt1RXhUcG9SZWdETCtoMzh4blVVck9acm1DejhL?=
 =?utf-8?B?SCtVaUJhellGS0RKcllOamUxWEF1cmQ1MGUyemk2ekk3clNWNEt4eC9JS0Ur?=
 =?utf-8?B?SVl1L3RpSlZ0UlNZZy9VUDk1dmJWbXl4SURXL2NLSHdwTHNYamtuVDYwNFRo?=
 =?utf-8?B?SHQvS3d4SnBFYjNLRmtEdGFodUU3Z3lySkdhaDlZNHkrbVJ6czJ6WE1SZG5i?=
 =?utf-8?B?TXB1a1g5MWhXYy9YSXd1c2dqemtNdGJCN1JjaElUeGtEMTJDZHJ4emFNNWYz?=
 =?utf-8?B?MUN6Y0g4dVZJRW5KRDg1dHVnQmV1alh2QzI3SVNhKzA0dkh0L29WWjdMa2ND?=
 =?utf-8?Q?qAJHiSxK2Vb1BfPYey7teXeYU+/0aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bU1OYmY4THE0VXI5NkVnRzdaaFNBSzhqZ1NmTVIwaE0wTS85QmZ3amFiSEVO?=
 =?utf-8?B?ZmdOaXZLcDRWZFROZUVlNldNZmU4RG55eXFjQmdRZUNnRFczQzFwL3lTZ1g2?=
 =?utf-8?B?UlJJMzFMcmljaXIzMVBWTW9Fc0FpUXdUcFlkWGJmQTF6THZMdS9wdlNlYW8x?=
 =?utf-8?B?TGFZMVJrQVQrR1plNWR2Q3B2Tm8yVmlBWG1jTkhXZDJRYW1OdUxpd1YwOS9z?=
 =?utf-8?B?WkVmUFVtNUd2Q2FRR1hNSlBSWWpHT05teDZCdE1US1Z5dzRUNFJIK0VaeDcz?=
 =?utf-8?B?NUtvL0V1bldTVVVTaVp3MUJYMUVadVgrdWc5Nkt6UUg1UERxeEFkYi8wQlow?=
 =?utf-8?B?eG5QRzQ5WUxaUjZGcTVIdG1LR2pFMnUxTEh2TEFrUy9OeDNKTTBiRHBlbE4r?=
 =?utf-8?B?ZlUyYXdTRklFVDkyWGVZSzhDQ3pJRlp5Y2ZFTE51NnFjcDBMZ3VnZ2pIcDJm?=
 =?utf-8?B?Z1I5ZzhCdVltUjZmZkVGem9XZlBvbGlwdjRPWjU4UG51c09aOXlyeHQ1Mmtl?=
 =?utf-8?B?b1dJTUVESkZMTEFpd2ZXL0hTa0Zjd0xJdEZ2Z2lvSWkrVFdSN1lYY3MyZzZB?=
 =?utf-8?B?M0Z3eEZwZ2JTWnFjVmxVdThubXZDSzR0c0FhWE81cWR4a094SDlRN3hMK2E4?=
 =?utf-8?B?YTJaUEg4Uks5MTZiTkdINTlRSUNsbHY2NFd6eFpsTmQxRjR0SEdDNk02c21O?=
 =?utf-8?B?aFlGM0VidlN5QVpwVjE4anJCWDEyS3VZSmNYRGFKanBRM2RJcWJtUDlLM0sz?=
 =?utf-8?B?TzhBTnM5NDRGYXYvdTJqZDdiQVBGZWFmS1hOVTRENVV0dlhWTks3d1lTU0s2?=
 =?utf-8?B?TW1zY2VtNWFQYzRLYXRudG5sZFlQbWwvME1WMjFiQVhScjFmQmNRMzJQZFQ0?=
 =?utf-8?B?c1hKQXBFSHVHekIxV2prQlZKYkhxN3lRaW9EZzl2TTd6UjloK0c2dUdVVy8v?=
 =?utf-8?B?L05ZYmkyaitJUG54SmNNUVFEajFmd1hRandBT0ZlNWxRRmtHWjhVMEQvNzJy?=
 =?utf-8?B?c1NFMHZEYzZmK1dtcmNneVJmZDlSYWNnSEZBdjY5V0ZndnZBMWVnQWthTXZ1?=
 =?utf-8?B?VGYydjgxQ2dENUtnSUJoOFlrNkV1TE5VaDhhRjYzdEN0QnpObWxSQ0RST3B4?=
 =?utf-8?B?bVpUWmlzZWVPQ1o2MDg5dC8vRmNaVzVNWSt5cWxRenFkSWlwdDdqZEhud1po?=
 =?utf-8?B?QlUzR09rQTdtelM4M20rdTMzbjNZS2pQdVpEYzIrK0NYb3FXTTRYV3gySHBn?=
 =?utf-8?B?a2pwK0N6SnpkVGFneEpqVE9DTVY3UU1Ia2JrVytkUkdEZ2krWkNrbDRhM1h4?=
 =?utf-8?B?UTFEMjI4cWlocGpMdzFuYUFTNkVkZW5UWEI1VklnR2wzQVArakFxcDRHSWhL?=
 =?utf-8?B?VEVsTitQU1ZWdWFhVXNpWjNWeHFDRmlsRkJwTExzWFY3UDBUMUV0RGVTVzQx?=
 =?utf-8?B?ZXQ5Y25YSVowU2tEVWpzbnZwZ1c3R3RPNzlZcUswc0ZmdVJKVTBVbzRxL1VC?=
 =?utf-8?B?Kzdld3IyY20rdzlLdTY2bFdiRlNDSHhHYnpLcjBSN2hkblA3cXBnY0FlUGI2?=
 =?utf-8?B?a0JMT01UMzhQVDBUbkczQVI1b0N1OWFmYStnQlc4TTM4a25nY3VWNXdET2ZQ?=
 =?utf-8?B?eXlqdHJoUkNOR0Y2T1hKWEZuVzZtV1k2dktMakNkZHZRYnp0bTVIWTFXM2Jr?=
 =?utf-8?B?NVpiNFZFL21scExkVTJHdXJWQkdGS3M0YWJ1Q0RyZ3hRcFR6aDJNWjM0UVkx?=
 =?utf-8?B?b1psRldxUkZoMitDM1JqeHBWOUE5ZFZEdFprTjlYWEphbmRqdkNxR2YyTkVT?=
 =?utf-8?B?aHlxa3IrcGxlZ2MyVHpRVmZtWGhrNjVSRjdXVmM3WDdoSVpERFdwbTlNbTRG?=
 =?utf-8?B?aEc0T2dGZ2dnRUk4dlpvenJRSHdZTGRiT0NuMFovaEcrRkVYclVrYnRYWUJo?=
 =?utf-8?B?SzdITEUzQWVBRUhvOXZIaVlPVzJCQmxoeUdCSG5yQlBCMmVFbEpSNWFnbmlx?=
 =?utf-8?B?TWxTS0dBMUpyRHY0eFF6aVVSVU0yeUNjMVNILzFKbGhTREs0c2dmWllUbk03?=
 =?utf-8?B?cHZXaE1ieU9uWEpzbitXdVpqRVQzK3lWSVZvcHNjMlpBeXQrbC9LY2V4TDVD?=
 =?utf-8?Q?ABzVpPw9ITUu90Daz9859GqX1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d80a9f4-5fdf-4e19-c79b-08dda7739295
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 16:34:58.0436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woKXSKuLrRBZSuHjDun3y1i560OCL/96+pKyIvQT0Kj6LcH84Un0sY4dlvi5pFRJdd+YpMgdO+443FjDcoJEpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9751

Add three registers: doorbell_bar, doorbell_addr, and doorbell_data. Use
pci_epf_alloc_doorbell() to allocate a doorbell address space.

Enable the Root Complex (RC) side driver to trigger pci-epc-test's doorbell
callback handler by writing doorbell_data to the mapped doorbell_bar's
address space.

Set STATUS_DOORBELL_SUCCESS in the doorbell callback to indicate
completion.

Avoid breaking compatibility between host and endpoint, add new command
COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL. Host side need send
COMMAND_ENABLE_DOORBELL to map one bar's inbound address to MSI space.
the command COMMAND_DISABLE_DOORBELL to recovery original inbound address
mapping.

	 	Host side new driver	Host side old driver

EP: new driver      S				F
EP: old driver      F				F

S: If EP side support MSI, 'pci_endpoint_test -f pcie_ep_doorbell' return
success.
   If EP side doesn't support MSI, the same to 'F'.

F: 'pci_endpoint_test -f pcie_ep_doorbell' return failure, other case as
usual.

Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v15 to v16
- use le32 for doorbell_* register and use cpu_to_le32() and le32_to_cpu()
when use it.

change from v14 to v15
- none

Change from v9 to v14
- update commit message by use pci_endpoint_test -f pcie_ep_doorbell

Change from v8 to v9
- move pci_epf_alloc_doorbell() into pci_epf_{enable/disable}_doorbell().
- remove doorbell_done in commit message.
- rename pci_epf_{enable/disable}_doorbell() to
pci_epf_test_{enable/disable}_doorbell() to align corrent code style.

Change from v7 to v8
- rename to pci_epf_align_inbound_addr_lo_hi()

Change from v6 to v7
- use help function pci_epf_align_addr_lo_hi()

Change from v5 to v6
- rename doorbell_addr to doorbell_offset

Chagne from v4 to v5
- Add doorbell free at unbind function.
- Move msi irq handler to here to more complex user case, such as differece
doorbell can use difference handler function.
- Add Niklas's code to handle fixed bar's case. If need add your signed-off
tag or co-developer tag, please let me know.

change from v3 to v4
- remove revid requirement
- Add command COMMAND_ENABLE_DOORBELL and COMMAND_DISABLE_DOORBELL.
- call pci_epc_set_bar() to map inbound address to MSI space only at
COMMAND_ENABLE_DOORBELL.
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 142 ++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f4..b9cb1ab218f2b 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -11,12 +11,14 @@
 #include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/msi.h>
 #include <linux/slab.h>
 #include <linux/pci_ids.h>
 #include <linux/random.h>
 
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
+#include <linux/pci-ep-msi.h>
 #include <linux/pci_regs.h>
 
 #define IRQ_TYPE_INTX			0
@@ -29,6 +31,8 @@
 #define COMMAND_READ			BIT(3)
 #define COMMAND_WRITE			BIT(4)
 #define COMMAND_COPY			BIT(5)
+#define COMMAND_ENABLE_DOORBELL		BIT(6)
+#define COMMAND_DISABLE_DOORBELL	BIT(7)
 
 #define STATUS_READ_SUCCESS		BIT(0)
 #define STATUS_READ_FAIL		BIT(1)
@@ -39,6 +43,11 @@
 #define STATUS_IRQ_RAISED		BIT(6)
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
+#define STATUS_DOORBELL_SUCCESS		BIT(9)
+#define STATUS_DOORBELL_ENABLE_SUCCESS	BIT(10)
+#define STATUS_DOORBELL_ENABLE_FAIL	BIT(11)
+#define STATUS_DOORBELL_DISABLE_SUCCESS BIT(12)
+#define STATUS_DOORBELL_DISABLE_FAIL	BIT(13)
 
 #define FLAG_USE_DMA			BIT(0)
 
@@ -66,6 +75,7 @@ struct pci_epf_test {
 	bool			dma_supported;
 	bool			dma_private;
 	const struct pci_epc_features *epc_features;
+	struct pci_epf_bar	db_bar;
 };
 
 struct pci_epf_test_reg {
@@ -80,6 +90,9 @@ struct pci_epf_test_reg {
 	__le32 irq_number;
 	__le32 flags;
 	__le32 caps;
+	__le32 doorbell_bar;
+	__le32 doorbell_offset;
+	__le32 doorbell_data;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -667,6 +680,126 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
 	}
 }
 
+static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
+{
+	struct pci_epf_test *epf_test = data;
+	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
+	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	u32 status = le32_to_cpu(reg->status);
+
+	status |= STATUS_DOORBELL_SUCCESS;
+	reg->status = cpu_to_le32(status);
+	pci_epf_test_raise_irq(epf_test, reg);
+
+	return IRQ_HANDLED;
+}
+
+static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
+{
+	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
+	struct pci_epf *epf = epf_test->epf;
+
+	if (le32_to_cpu(reg->doorbell_bar) > 0) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	}
+
+	if (epf->db_msg)
+		pci_epf_free_doorbell(epf);
+}
+
+static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
+					 struct pci_epf_test_reg *reg)
+{
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	struct msi_msg *msg;
+	enum pci_barno bar;
+	size_t offset;
+	int ret;
+
+	ret = pci_epf_alloc_doorbell(epf, 1);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	msg = &epf->db_msg[0].msg;
+	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = request_irq(epf->db_msg[0].virq, pci_epf_test_doorbell_handler, 0,
+			  "pci-test-doorbell", epf_test);
+	if (ret) {
+		dev_err(&epf->dev,
+			"Failed to request irq %d, doorbell feature is not supported\n",
+			epf->db_msg[0].virq);
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_data = cpu_to_le32(msg->data);
+	reg->doorbell_bar = cpu_to_le32(bar);
+
+	msg = &epf->db_msg[0].msg;
+	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
+					 &epf_test->db_bar.phys_addr, &offset);
+
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+		goto set_status;
+	}
+
+	reg->doorbell_offset = cpu_to_le32(offset);
+
+	epf_test->db_bar.barno = bar;
+	epf_test->db_bar.size = epf->bar[bar].size;
+	epf_test->db_bar.flags = epf->bar[bar].flags;
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
+	if (ret) {
+		status |= STATUS_DOORBELL_ENABLE_FAIL;
+		pci_epf_test_doorbell_cleanup(epf_test);
+	} else {
+		status |= STATUS_DOORBELL_ENABLE_SUCCESS;
+	}
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
+static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
+					  struct pci_epf_test_reg *reg)
+{
+	enum pci_barno bar = le32_to_cpu(reg->doorbell_bar);
+	u32 status = le32_to_cpu(reg->status);
+	struct pci_epf *epf = epf_test->epf;
+	struct pci_epc *epc = epf->epc;
+	int ret;
+
+	if (bar < BAR_0 || bar == epf_test->test_reg_bar || !epf->db_msg) {
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+		goto set_status;
+	}
+
+	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf->bar[bar]);
+	if (ret)
+		status |= STATUS_DOORBELL_DISABLE_FAIL;
+	else
+		status |= STATUS_DOORBELL_DISABLE_SUCCESS;
+
+	pci_epf_test_doorbell_cleanup(epf_test);
+
+set_status:
+	reg->status = cpu_to_le32(status);
+}
+
 static void pci_epf_test_cmd_handler(struct work_struct *work)
 {
 	u32 command;
@@ -714,6 +847,14 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
 		pci_epf_test_copy(epf_test, reg);
 		pci_epf_test_raise_irq(epf_test, reg);
 		break;
+	case COMMAND_ENABLE_DOORBELL:
+		pci_epf_test_enable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
+	case COMMAND_DISABLE_DOORBELL:
+		pci_epf_test_disable_doorbell(epf_test, reg);
+		pci_epf_test_raise_irq(epf_test, reg);
+		break;
 	default:
 		dev_err(dev, "Invalid command 0x%x\n", command);
 		break;
@@ -987,6 +1128,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);
 	}
+	pci_epf_test_doorbell_cleanup(epf_test);
 	pci_epf_test_free_space(epf);
 }
 

-- 
2.34.1


