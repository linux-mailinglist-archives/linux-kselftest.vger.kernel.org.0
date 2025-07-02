Return-Path: <linux-kselftest+bounces-36340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A986AF5CB2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 17:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CCD03A4455
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 15:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60242DCF71;
	Wed,  2 Jul 2025 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b85MJChZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A622D948D;
	Wed,  2 Jul 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469592; cv=fail; b=GVlJXr3bExpFr2MIXZd2jLee82JHNdK9jKO9B/kXd/PiU2vewTZ8swea1OxAYgtC1BjPzGH7CJgkedHCBVpoghjx/zO1NYs8BEzZ2sLa4098ccAP9Vy8d2x3MaECj/3KUOtcFX41N0pnRyMZpiZZ8fidh0akrcB30QaL8FO0MoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469592; c=relaxed/simple;
	bh=BSsW7T1WqeWLdNmhIguGR+rdMS9nQTvkjhlbkXpuToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JoU9lM5mL8O3tBkDAH0BWYNjzV6y+A0FUZABchTS6vS0iVi6l4OsSqEVSU2RfQsdFrHQcTwhuzQ5AlSuN2LSSNJ7RvQT53atGYpJwKnjN0oOjP51NxsSUch2bNe3xkTWWjqXOTBphj1/CBSMZ0s8ezmi4ZmiZy3/dlK47hsGSEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b85MJChZ; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsBb5ErXFVcBVYX9Fgz3k3W7q/R7Bb+qCW74ULd9V+lz7irrNpIc+RER/EcWolS6ycoVoJtQSVLHJL9+EJP7WuZk+004GLeqPtdHXfh+7ZC3BCpU/Mu6iAyyzS7yfrEiIk+Xb0wk9W3CYXSyQ5B6jgbwVFNjzOhLyLJDvU7t2b3MacnUux3d6P2/tsVQHVZVp2IWr36ncUVCFbVApOwTPEvjQtXnZALE/8Ttpm2EyfWM9zVLG8mMo/37ybEW7vaCiUzYGcMGzray2UvVidbM8gp5jCUjjqogscV4h0TrEqUDpieYTQbMVaIT+6TEjdmgZafy9nihUYZsksUZSuPh7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSsW7T1WqeWLdNmhIguGR+rdMS9nQTvkjhlbkXpuToI=;
 b=DlPOFJpRmCq+dfEIaU+v6sUlfbm9grI49bzRtwdQWGe19IMB0dd0nY2G5lySboh72mkUnpDWBHlkSh3kAjwQ0NFDaHDE+ZIicrVpP6N7/iVM1WYT3YzHErKulomz6brG4NcZ5DDVsnLcpPe78KIjAKtWu2NVOGrYCDmap5bno+LkYDTIL8AXytPxU4Z2guY1WeD8yFP0n39DRkEoRy15Qbe7o/Kp7iNqnaPTIOYC3y0fGGTN7RF3RKXUZHkakJYSMB0gTETEIdqjTd1WjowiuRbLlBNIsnhEWD2JedKoh030fcD2raYepzn6IRvvISi2cxwXWMfHoKoWxQPLjq6H+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSsW7T1WqeWLdNmhIguGR+rdMS9nQTvkjhlbkXpuToI=;
 b=b85MJChZ1mHem5ZcT8Cemh/YR+zBRrqcU7QgHrUUDVDYaoSOvDKjiz6KJvg8f0jVHRnhmZihIxrB/WV9pWUiohKB/E6JfjbJqwomaznDIDghgsedTQrYzNd3HkG77HMtXCZZm7pVlbXIA/6tmDdcl7B0WTtgCOmZMhiMIuKJuSDQ9+LyhgrwYgQ465A/Rnk/Q7KGywHVijD3eX58P6PtvwwN1MYqtOvdk3s7S8KZaGFbwLAnKqeE+g+hIV84BJPeyF6Y9jBbcTYQtMXJmPxkH+C9lf/TeZ+xg+s9IxL9dxCfLN27nctwEXtZPJYpbNo4sGnjj39/NpPr2r0/nloLvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI2PR04MB11100.eurprd04.prod.outlook.com (2603:10a6:800:298::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Wed, 2 Jul
 2025 15:19:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 15:19:43 +0000
Date: Wed, 2 Jul 2025 11:19:36 -0400
From: Frank Li <Frank.li@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anup Patel <apatel@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Shuah Khan <shuah@kernel.org>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org,
	jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v19 01/10] PCI: endpoint: Set ID and of_node for function
 driver
Message-ID: <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
 <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
 <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
X-ClientProxiedBy: AS4P251CA0027.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI2PR04MB11100:EE_
X-MS-Office365-Filtering-Correlation-Id: b75d71fa-7190-4f05-c01c-08ddb97bdf55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWZQQ3A4dS84RzlMUDdVTjUrYlgxa0t3VUh4Uk52elliK3Q5UXZvcTVXbG9Y?=
 =?utf-8?B?L2dNWlBCZ3lNbG1XV0MwcGF1VC9uUitZVnc4d3d6c0FLYnVMSDcvVXZEMVZO?=
 =?utf-8?B?eEFiaEIvYlYySjhoNEN3SkVQRHNkVEQrbVpCYTkvZkdhUW5Xb3ZxNGRUc1VK?=
 =?utf-8?B?cmQxUUFHdndwR3l6MitZREVkZlNXUDlTZUg4MjROVk1iVUpRanYvbGV0WSt4?=
 =?utf-8?B?Y05MQitjTDRqSjhDZ2NjN09EbVNXemcxRGZRbHh2MFJhRUNFREo4emFickZq?=
 =?utf-8?B?clpmWUZFRk9lMUpIWXhQMzhvZkY2V3NhNHRWNW9XbVRLcEQ2b3F3QzVxcTFl?=
 =?utf-8?B?bS93RkY5N2REVzdhVUw0SXZDRFNGeE55UHVwUzl3eW56bUs4aWZzME9TTTlX?=
 =?utf-8?B?YTFWcmJZWnJBQjUzODVsWXpjQkgyR0o2Q3Vycno2SkpPR0I1YTlURzI1Z3do?=
 =?utf-8?B?R0kzMk5CSWJNdllrRzMvdFcvK2pvQXRoV3ZkYUsxVVppUVpjSnNWNXh3Nkht?=
 =?utf-8?B?dnNLWmlkdGZqYmZNMzBFSkFsT0cvY2J0Y2U1VWZNUjhRSmZjQW5BUVh3L0lG?=
 =?utf-8?B?emxybHN5OFFmMWpkd2VuazJlU3psbG1lYjQ3SExUeFNEZXFwazU0dm9BdC9C?=
 =?utf-8?B?bHNhbjlUQ1owdDVVSm9LaFFDUTEzWTBNaXd5cUZOTnBjcldiNFVBeVJhUlJH?=
 =?utf-8?B?L0FOVWxaeUVXUmNxTm5zOTJYS0xxMytQVlFsdDZsZHFJa3ovMkd4aWdxWVMr?=
 =?utf-8?B?T1FCQUNHY0xJVGEvNkNmTHhZRGVIVFd3TmMwVkhIcFhIOXhYRmtKVU5NYURJ?=
 =?utf-8?B?NEQwem1JZWVqSndPeUlheU9Za3A2SlRPNGlKcWZTOFMwbExNakNBc0J4dVZZ?=
 =?utf-8?B?S3RZQ24zalpiUFk0bnhxRDlvcnJmcjlUZFFxWlhDV2FBMm5ZVy9PSERBdmR3?=
 =?utf-8?B?VmNkdjMxSG0xS2NaVGNCYit1TWlkUU10WVFrOFFlZEFCWkI3YkhKN0JmWGY3?=
 =?utf-8?B?QnVJYlMxd1doYUY1ckNGSTBTZm1nR05QTlMxSCtWUC9PMEhTdWZmSU5jUVhY?=
 =?utf-8?B?RzZEREN4RVlUNElpeW1KYzUyUG9zT3RZV0RON0ZER2NjN21PZmJiVE0xVisv?=
 =?utf-8?B?dmlMN05CWmhMeGErdmxaZXBkUEZvTWdjTnFwREJHdlpxVTczUjlYUHlCTWhQ?=
 =?utf-8?B?Y3FTN25RVURqMUdDemVMMzNGNHhMRHQrWTEvbmtHZS91SlV0L25Na0pGZTZa?=
 =?utf-8?B?Z3ZST3NKUzUzYUdrU1ZQaXlkN29VSXFQMnJTcUYvdkR1QWdBZUh3TmxESUlp?=
 =?utf-8?B?V1NqR3RtMUxBRVk0WG9hRnl5R3E2TUVFYUFvcTFqUm0wODN6N28wbWZUcDlu?=
 =?utf-8?B?Ym5wZkZTTTZnSjFkQlJQYU43cWF1OVo1VGo3M3pMN1NucldMVEphbys4cytx?=
 =?utf-8?B?R1hNYjJQc2VRU1Q1WFRaUmJzMUNlS1NTZm1DZFJuLzVjY3JHYWw2Z1hUVzRV?=
 =?utf-8?B?bjMvZFNFOTk3S0NvZFBWTUF2UTFrUFBvcEtObzhGcWJoNFl4V3VYNXZLR0Yv?=
 =?utf-8?B?eFd4UE52WUxnYW5OUlhyRFMwNVV2UlIzR2QyR3BzYXRPeUlWSWR4d3JOK2Er?=
 =?utf-8?B?bm5sWDRQeERoWnM3NHdHaGx4Y29wdXRFbmNETkJxNFkyd3FkbExaMGY4TlR5?=
 =?utf-8?B?LzhGdkJEcDRWQm5CZGljcnFEWFdpMU1MZkRmVTJ1eHAvMno0RmY0L2J6Nkcx?=
 =?utf-8?B?Umdnd1lpaUdmUWJ4elR6VEFjVFI5a1BFVVNmZUtjcjNObDBsVUpoaEx5VEJI?=
 =?utf-8?B?VGIyMXFlVU9CRmhrZzVSdWltampOV0JJc2F0ZklaRUFnS2tBajdhUmE0YmZ1?=
 =?utf-8?B?UzFjdm13WFRURzJsVkszencyV3QyOGFoU2tCMEZ2Zjd4dlg5TDF0YmQ2NkE3?=
 =?utf-8?B?OVBnUEoyVU1JbFc1TTR4RW14VFRteGJNeGdYQVRkK05xcGd4dmRxMDJlL0t3?=
 =?utf-8?B?SU9halc3N0JBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eENTV2VXWmI1d1M4d0Q4N3RsOTR5T3VvUFdvaDBtQ1BGby90L2ZucUJSTGVu?=
 =?utf-8?B?YmRlU1NEemk0Ty9zOUxqeTVTdmYvdGd4eGhyQ0Fha2RIZUUvTlpzbi9xa0JM?=
 =?utf-8?B?L3dISXpzMUpMSGRqVnpQU29odW1DaktwUXQzb2doT0x6TDdyTzV3SGFKNkYr?=
 =?utf-8?B?NFphYkJ3MFQ3Zngya2R0TTYrbmpBQXcyZDFacUhwWW9nUExCT2piVmlaVWhS?=
 =?utf-8?B?d0RoNS9YekdZMkt3aHNZWkp2VDBya0dpM3BFbjQvV0dVcFZFay9jeXp2SXVv?=
 =?utf-8?B?MkVqRE5nY2s0c0hkWkRuc2hXdFRTSVg0L2cwd3hSQTlFbXdkMld1Ky9Vem1z?=
 =?utf-8?B?dWpvTlo3VFdlNjZQQ0JQQlNhbXhZeVE5UGI4MHBEUWR4elBMd1RGVGk3NUhm?=
 =?utf-8?B?NWFmMmRJN0ZFNVUyTTh6OHRlZUxpTlJFdW1xZThFQ0pFY1oyUU1EdUhwdFFs?=
 =?utf-8?B?UmRlOVB0TUhRckdoNnRLRFhKbTJIVmdPemN4VmQrc0JqQkpSdm9YRlllOTI0?=
 =?utf-8?B?R1Y2NlFvOFRjUGE5SlpGbUd3TlBPa05ZOENGSVdWUHFvalhlMzllMFZKWVVi?=
 =?utf-8?B?MFNId2Z4SkRhNExSNGdGMXpUclBKNTZ5MUljMm9mMmxKb2c5UVNWeVE4YUtK?=
 =?utf-8?B?MGpja1ZnMXVIWW5yRDlueFBtNExlZHVCVFFQM0NCa1Y5V0pYNE4ydDAyaDk5?=
 =?utf-8?B?Q1VUZ2UyRXA4Vy9vUnBUOW50MDB3ZzljdFI5TUllc0RZZUZZNWNLbWRtdnJh?=
 =?utf-8?B?cEFSK2FQMXZxbXlqb0UxMC9hWXUrQ1ZjcCtFeHI0a3ord0Q4MzNidHFtYUVL?=
 =?utf-8?B?ejRaOXF0OExvZldPWjhrbndBQ0VjajNobndVQUJJbW5SUmdUZ21Vb1dBWWtS?=
 =?utf-8?B?L09sRkdTcWE1TEdGNjhCTGlwNmE5UFR4YjRYWWthcFBpN2V2dWxySmJEVSs2?=
 =?utf-8?B?ZlA5VGJLeHA2dE80MFVWVHpGT3RyMXBDOE5KVGRUZjZXTWVCa2dDU3pMTUxH?=
 =?utf-8?B?R2J0cml0aTRSdEJSUkxEcWpkd2h0M1JOdFdQaXRwSW9uamdrUEllY3Qyd0ZH?=
 =?utf-8?B?eGUrYnFpRFIyUysvMEx1QnVTMkoxV3JTZHpLRnVSRFdzNU1YSWdia0RYU1pL?=
 =?utf-8?B?NFBJUXdLN2R4YmVPdlZvMUl0d3hTY3Q0YzhBenBLWUxnTXFYWVBuc0VMbkh4?=
 =?utf-8?B?UHVEN0FVNEk1RmVheC8zYXVUbm5idVErMkNiM2dZTEJZWkxtNENsSC8yZytp?=
 =?utf-8?B?ZDdWTm5zRmVGQ3BvV3ZaNWdwcVM3cEFXb0tZYXNiaXYzMi9GWFhTWmdZUHkv?=
 =?utf-8?B?UC9GWG5FV3hHMk1xcGsyb2tRZGo1aTk2SmxKQXNHQ2l0SmVxT1F0R0wwK3Fq?=
 =?utf-8?B?aGlOZ3l3clhzbU8zOWZYVi9FTlVsL2FSZ0FxaGhVQ3Q5WlI1UjhLR3liOE5U?=
 =?utf-8?B?MXVueE5LZkg0a0VDT3BkWmRGZmFod1UySy9xR1ZhVitacmhETHZFU1dNNWg3?=
 =?utf-8?B?N3BJdnNzS1VxZkNzb0pFY0VTYkFmS2d4V0FhdWdneEJLYVc4TTBiaDVSZ2ll?=
 =?utf-8?B?QzNudGtFZ3d1UkpXdVJPSjB0cjdMeFJxR0szd3ljVEJBRHJPQVNoSEdsdWZX?=
 =?utf-8?B?NmxhS21MMkFnUlVETjRHRTNieVJmVUVlS3RraVlEYVpwd2F3RWxOQm8zUHFI?=
 =?utf-8?B?R0dBOEVZRHAvQ0IwZmtCSGZLekVCeEZVMER5d1dyeGFIU0ZBZUdhNWs4cVo3?=
 =?utf-8?B?Tk0vVjhPbDhLNHpUT3lEREtxMkdpQlo3M2k0THNJcElsSFFTMjVTTmNPRkFF?=
 =?utf-8?B?Q2tORmNNWDRzYTE4OS9aSW95V2trN2d3SUs3K1VmRTBrMHRHbzNwYUU2ajRv?=
 =?utf-8?B?YkZ2MGZ1eDVIRzd6RjlpVnZGVmJvSE4rdjVpRURURWZFTmNqenlCQ1cwVGpl?=
 =?utf-8?B?UHRHeUJxTysrclQ4NVVtck1Yejk5OXNOWUF1Ti9objFRK3ZwQmp2RUlUWm5D?=
 =?utf-8?B?b2U0YlV0NkZIa2hJM1NVQm43NFN5ejJ4VksvZUJNUmpTbHdob3EvZFFIWDlM?=
 =?utf-8?B?bnFoMGM5aDl2Y2xKNG0vQ0l1Vmpzakp5S1VCS2ZiSFBqK3RWZUVTMFNvZWY0?=
 =?utf-8?Q?Dj/mLPWqRgTx0ndsNV8EgYxd9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75d71fa-7190-4f05-c01c-08ddb97bdf55
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 15:19:43.8566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fZEabf5bHjxl3ipxzzID4tmhSCkSDjEQgSK051RsIh06qcKM93qjiD1IgBseIsoPsvEZhG584AI/AEw0u5DwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11100

On Wed, Jul 02, 2025 at 08:25:17PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 10:40:53AM GMT, Frank Li wrote:
> > On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > > > Set device ID as 'vfunc_no << 3 | func_no' and use
> > > > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > > > device.
> > > >
> > > > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > > > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > > > functions use the EPC's device node, but they should use the EPF one.
> > > > For multiple function drivers, IOMMU/MSI should be different for each
> > > > function driver.
> > > >
> > >
> > > We don't define OF node for any function, so device_set_of_node_from_dev() also
> > > ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
> >
> > In mfd devices, children devices reuse parent's of_node
> > drivers/gpio/gpio-adp5585.c
> > drivers/input/keyboard/adp5589-keys.c
> > drivers/pwm/pwm-adp5585.c
> >
> > multi EPF should be similar to create multi children devices of mfd.
> >
>
> No, they are not similar. MFD are real physical devices, but EPFs are (so far)
> software based entities.
>
> > > I don't understand.
> >
> > >
> > > > If multiple function devices share the same EPC device, there will be
> > > > no isolation between them. Setting the ID and 'of_node' prepares for
> > > > proper support.
> >
> > Only share the same of_node.
> >
> > Actually pci host bridge have similar situation, all pci ep devices reuse
> > bridge's of node. framework use rid to distringuish it. EPF can use device::id
> > to do similar things.
> >
> > Actually iommu face the similar problem. So far, there are not EP device enable
> > iommu yet, because it needs special mapping.
> >
> > Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
> > information to each children. But when I see adp5585 case, I think direct
> > use parent's of_node should be simple and good enough.
> >
> > In future, I suggest add children dt binding for it. For example: EPF provide
> > a mailbox interface. how other dts node to refer to this mailbox's phandle?
> >
>
> As I said above, EPFs are not real devices. There is currently only one
> exception, MHI, which is backed by a hardware entity. So we cannot add
> devicetree nodes for EPF, unless each EPF is a hardware entity.

But how resolve this problem, if a DT device need phandle to a EPF? anyway
this is off topic. let go back this doorbell.

It needs an of_node for EPF device, I tried many method before.

Create dymatic of_node for it? MSI framework still go through to parent
of_node to get such information. not big differnece as my view.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

