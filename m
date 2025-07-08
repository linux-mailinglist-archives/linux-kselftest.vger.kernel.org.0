Return-Path: <linux-kselftest+bounces-36769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F710AFD6D4
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 21:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C583B67AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485F12DCBF1;
	Tue,  8 Jul 2025 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MnQe6MWS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011069.outbound.protection.outlook.com [52.101.70.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503117C21E;
	Tue,  8 Jul 2025 19:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001578; cv=fail; b=BfGv+L4l+Ra0aqb8UmdxP4CPmPCzcpvZQaiiUaa00qp0g/makJLOUMdtmHqZvjtB8vocjlg29Nhc498fl06FzfixB/+mWNhtzWO99EiBZtvyfsTq9J8RVtD2STf4ccvz4my0Um59mC6AQt+3iboNDHAOE9QHFujLDliXfUISI/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001578; c=relaxed/simple;
	bh=Odcy306onFPJd7/BIeg43CXJv+JhGlCL+RLYmBCCWBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNSrkpXmuygDqWuGWkctwmFdTAQDP/E0yFazCQSXa4rOTTPucnjdvh7gBXuyEAH5Q6wyE5yKNbG/UxTF68H3++/BStTckHEjhN+/MJiDENGhw7+RFrlHpg+tcS/0OQenrZU5gPZTyHRodeIsS5g+aI56RlQTy2nmp34+csmuRho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MnQe6MWS; arc=fail smtp.client-ip=52.101.70.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlPBns7lYjtYqfUFB5yNss9qWpvJvDjqJDSciUM0mnZ8KddH6JWaYkgxPXPV375EGFq3VBCzV/D2xvtwLS6QEHUTwEjueiY6o+0EV8/ok/6F1Kn9c0i50SnUQ2h9x7oMIgPffffhEWFClEjcNFG4+YQpCzQv5+dYfSfVNIHJ2+2R58lz1LpMpVYxC6qlhHBPu6+9+e+IJP5rck0EcjjN6mehctQlWEk4iJnfIat1ycHS7VYpACPtMkZDA7SSPAiyG41vWyUeGz9povhi4H5xEa/RxORVuqUTN2+dw8p8i9B78YYxLtI4ef4UNd7UXOTqF+pkXXSfFjZAVX45Vw7oQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rs5r1jqBSDdsbb7hg45NRnbScRr15dRDUs28ZmHshE=;
 b=MT2WXHzXEuCRJo1lcH/S+s72L44xEVVLvYYpc4JptU0aRP57cdMyblydX83gn0Aven/C4m3pddPl04YyUQLxUPtq112ZetRyKQSh4B/gpSKACCw3GN4FNWjSi9OlLrRxVuEVlNNhZ6FM0Ahb/muZaQmB69OzMVkjmDCLAZPBK51ciZNUcnWnbLlSH28g2SpPQgf+N7DWL6+/ZtD9pRnXhIqLMZ3khcAHbnq3uKiVSkX4hYpoBTHtgdKueQTf3NVXJIBFwYEN/8XmbQbeW0ogrM9cJjmPyyXt1A9WDC/RepT21dsSuS3fShf1jhZTtpLYjkZlOk+2+3V8iPXEfpK5IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Rs5r1jqBSDdsbb7hg45NRnbScRr15dRDUs28ZmHshE=;
 b=MnQe6MWSQ7kh1TdR2qy4JIhIlQo2y9brN5NLZpPJ3jeXOx+UCd73z2HjRZHJGS6gaA27ykd4zXRLmO4ivgmOVwpFsAw+1sw+0jG6s9kMOc1bHG50j7kSWt7iF6B17QdP0lBGH02XLvzrYHdk78+vuZwAbaYYY9fLJaWbU25fflsS/8rldC7RwoVN+NX5PWKLTWiS4c8k90V87l8L2FTzpehJAG4LnofR382+5AsESBykvOhcX7GXRbnQhrPS6hz7xfiytOQwk6qF+BhD4WgOjr1MOf4Vdj/XrjKCmgdJXyJ97B9Ir7YEcBiXXBHUIt3WHwvhHS9E2ntXqKZ82NB4ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7977.eurprd04.prod.outlook.com (2603:10a6:10:1ed::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 19:06:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Tue, 8 Jul 2025
 19:06:11 +0000
Date: Tue, 8 Jul 2025 15:06:02 -0400
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
Message-ID: <aG1sGgQ4EYC2D8Wc@lizhi-Precision-Tower-5810>
References: <20250609-ep-msi-v19-0-77362eaa48fa@nxp.com>
 <20250609-ep-msi-v19-1-77362eaa48fa@nxp.com>
 <ne5yrjtdevmndqds4uwo2ppq6gay2wuwjouyf33lqr5g3nfkwr@lkwqlwqjqbmx>
 <aGVE6veZm3bL0mVJ@lizhi-Precision-Tower-5810>
 <75opnvi46fbmsnmykjwn3gmir7r3uqhzp7tfoua42cado6aopu@dmos2v2qd3jn>
 <aGVN/5yoLumfmlDv@lizhi-Precision-Tower-5810>
 <aGv4slE8/kmxHvlU@lizhi-Precision-Tower-5810>
 <jx3nhhyj3dh5ivga6i3va35rz7n4disz33dtbwvbs4raqb4iww@q6m73lnwkjsf>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jx3nhhyj3dh5ivga6i3va35rz7n4disz33dtbwvbs4raqb4iww@q6m73lnwkjsf>
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a25769c-618f-4656-ce0c-08ddbe52809d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDlSOXZIMy9ZbENjQzR3VUxiYy9QYmtlRXg5c0VZOExVRTlFM1NxZkxSdDh3?=
 =?utf-8?B?YUFaK00vNkZ5bGpEMWhHK0w0bXQxZ1pFb3RHTzVrRGNPM1Z3M1NmSjBPQzBW?=
 =?utf-8?B?bTZJL0Rna0pzeUxKa05pTnVWTzlWN0hGL2s1MVh2NHpQazk1K0lvWE1Qc05T?=
 =?utf-8?B?MVM1NzViMlp2MUFkdElkNC9tZEF3S3hpY25USlJXaFlINWkzcUVKMEduYXNQ?=
 =?utf-8?B?SGhmNStHTXdCY2wwMEl1Tk41Rnk4RDZybGhBSUU2cy9zNjBISStCbHVkRVJm?=
 =?utf-8?B?THFFd0ZLTlc4eHhOOGlZc0c4ZjNKWGlncHJJemJGNm85clk0TFQ3TzlIWVFH?=
 =?utf-8?B?aWNRWVY1d3lqZ0tBZDV6aTJBV0s5U0xqamdNS2tsR1puZkhJS1A1UkNEdmVK?=
 =?utf-8?B?SzB2L2k5aXdtbG5lci9ETEJsU3RKdm1IaUJ2MzZ3WDhBMkJ3ZzBRVE5yQ0FK?=
 =?utf-8?B?VElwMFEvZTRrMkxTUHcrVU0wYlh5dUxpOVdLZHRWaEQvM0xhc2l3Qk5BMXha?=
 =?utf-8?B?NjFGRzcyQmNPYkVRZCtIZ2liTFI5a29ENVRoOXk5VWtQUVZmV0V5OTB1bzha?=
 =?utf-8?B?QTNmN3AyeGNrTUpCa2NFa1Jxc3dPbGJCOE5DeTZKZ2NUcEZmdVJGL25oNkxr?=
 =?utf-8?B?TGZvOThTcHJWQktTazZCNklCaGZoVFFrMFdVWVBtVWtKUWdjeVcxdGFrdFdV?=
 =?utf-8?B?MUp2YUt4ZHFremZtU2dxajlUbGE3ZXlMK0d5VGZ0T2N1Z2JvNDFyRnVibHFp?=
 =?utf-8?B?OGlpYzdmWFVSbm1URUZ0akZHTTdTSjkwd3R1NVBjMzNJYVBsbXVZeFdITXox?=
 =?utf-8?B?SXN0M0ZFT1diaHBPcGN2QTh0dFdTMjhGM0dJdW12Y0xwSCtGWldIRFAvbHpQ?=
 =?utf-8?B?a1FUS05YTWJ5aXFQN0l1c1RVY3BTemlIaXBHZUh2cGd1bzBwTitiYm9IM0Yx?=
 =?utf-8?B?UThRWkNRR2VDeEpRcDNMZlhGUnc0czFvblVmczZNcWxRN2REQ2YzSE1UZ3M1?=
 =?utf-8?B?ZmtWcU9EOGRBQ01tUlJwbG0rMm9uem1QR0MwanNRMWRLamNwTkZtZE1XQ2c1?=
 =?utf-8?B?OTNXNFlHSXF3aDQzc3BKY1RsMUxZNEp3NXpHME9jNmo4SWI2SzhpdWIxNEx4?=
 =?utf-8?B?aDFTUE9ETVl5cnBBZGd6eTFvbU1zOGNkU2w5cm1FWlFUdHliWDQ0cGx0YzBr?=
 =?utf-8?B?b0Z6U2Y5UUtxaTdLTU56Q0tyVGxacGMzOXNvUXJCbU5ZQTNvWVpkK1IxOUVz?=
 =?utf-8?B?VzNFQ3AxcHdvcDB1c2U2azNQN3BhRzI0Q0ZHWWpZSmpFMU1ydE9VUU9pZ1ZK?=
 =?utf-8?B?RU1CczZKNFQ5SUQ1Q0ZScEdKQ0hyejc1d0QrWXlMQ0ZiZ0NVWGRqdm14cSsz?=
 =?utf-8?B?MmNOZlpmNUx0TXJaUkdlb0p2N08yekJ5RFVoN0E2MDRIdUVZRFhHUktXamhS?=
 =?utf-8?B?UzErQlFXWU14ZDllN3hHWENQN0U0SWxvcW5LOXpKSGhwWS82ZWIrUG1Bc2Y1?=
 =?utf-8?B?REI3eXE4d2xnWE1jWGNZQXJVMVpHdmZNbXE3cWxpV1RjRGhHUmMrK2Z6OU1l?=
 =?utf-8?B?bmxrRVF4Z1lZbFZUQXZDTlRXRk12UkpGWGdlVWsxK0tqRUJjZ1VwRmNBVVhG?=
 =?utf-8?B?TEx2cDU5TEc3SUVodkFDQlhyNGMzbnJUV21sSk42c0R6dUxzam9WOXFuK25C?=
 =?utf-8?B?RmJwSkkwSmhHNnN5K29UNGV2Z0NuaGx1VDhTa3N0NUdnMDJpeTNGeVRaZ0lw?=
 =?utf-8?B?YjlhMkVYMlYxWlkvOFZWaVpTb0puL2lYOTJDZmFVQXVOenVXZ2x4cGlMS2c4?=
 =?utf-8?B?NzBrWXpkTUJKc0pqazhWWjJkSGI0NGZmc0gwaXBzdG1EYjcyVUE3TXRaaEoy?=
 =?utf-8?B?SkVuSXJ1TGszQXE3c0hvTEpCMERPdFQxclhhNXhhYjhoLzZqMGJhQUpNaXFJ?=
 =?utf-8?B?cko0SVRhRG4wUlJqd2ZpeHZPcUxScVc3SWJ3UFZwczlGbzhyc242cmZtbkd0?=
 =?utf-8?B?bHY5K0YwUmJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1QvWkhSbjZSK1lHZUt3WWZUOUlBN1BLeDBtbVFkQ29CVUN4YkNaNG9zVmh5?=
 =?utf-8?B?UEVuYXhMWkpXbFZDQk43dk5VTitLWkpId0pYSXd2eWhYUGd2d3dYV0JqaWJz?=
 =?utf-8?B?ZjVCc2tyNysrZlJpVkFudHFYVTVpTFJYOUlVMUVXTXkzdlNzU3RkMllVT0Q1?=
 =?utf-8?B?TEhoRVJ6MHJtN3ZKZW1pbEl6Wnk1SVdwVlJtc3NMR2hLNGRFYzNQV1l4ak9p?=
 =?utf-8?B?cU9GK3BUM0RlWUtLY1dmK1ZURktaK1plZHZSU2lsVHE4d3RtSFZEQ0FGZ3VU?=
 =?utf-8?B?TUJCMHdZQmJ6UGt6citxL2ZCTnhUTytqNXZpTEg5SDdhZWZTWVFEYmluZitL?=
 =?utf-8?B?VFJMMG53dmF3MndwbHVRK0srZ1l1NXE5N2U3U3FzRjZFOUtNSnNCU0pPam1x?=
 =?utf-8?B?Q2sySWFNclBtSHh2ZnhISHpXNlpOZm5ZNjhpWHFYSk93MWc1T3dZWk5TSEZ6?=
 =?utf-8?B?TVBsZERNWENOcjJEUENqZ0dCOWlZeGdaRDk1eWZDaDYyTXdZVFd3WmpIRlU0?=
 =?utf-8?B?RkMwUVE2QmE2NU9vQTRVM1dzc2Vmdkh3UW9NNlppWGkwcUhSZWE3ejNMM2Fq?=
 =?utf-8?B?U3lHUy9UbWFnanI3RGJOSEczaUdhWE5RMjNwOWVmMXRQVDFUZmJsQUVZK3JV?=
 =?utf-8?B?ZXFZL2FYb1h6Q3FHaTErY3hHRjloZ05zbjQreVNSZ3NqMWZ1aWVKYVYrMTZG?=
 =?utf-8?B?V25YWHVMc1IrL3dLMVQ1eFFMcm4rdk9LZWovRmhIMWJCVUU1eEN1NG1POE5a?=
 =?utf-8?B?WnVRVXk2WnRMb1AyYzBLTERQdGQ2OVo1NXk4UytUaFBiSXRPYjU3bzhCaStC?=
 =?utf-8?B?c2liSDlzRXZ1a2J0UGg2RWVQM1g1VFErQW0yYmF1RGM4S3lVYVJ1UUJQZ2lj?=
 =?utf-8?B?dGhMaXZOZkluaGduc0p6eXVYYWQwOEY5akxBWjcwR0ZjZ1hUQjFnNUhXOU1l?=
 =?utf-8?B?N2ZiWHJ4ZVhsQm5rRzRpUndMT2JhME9zODFPQ0RLWDVScWxVUSs3SmJIY0lj?=
 =?utf-8?B?eUJXcnJLbENCeWprR042M3dMM2ZZOFVGRDhURSs1VG5aS05SZ3FjYXBsTERK?=
 =?utf-8?B?bnQ3bVl3WTM2VnpFWnh2R1NPdjgzRndTK1hlYjZHQ1NVYjExVjhxc25JdlFn?=
 =?utf-8?B?czdYYUwrSG5RdEZreVRlZG1TWUZQZCtiR2JCQjMvb2xlVkE2L3FwMWVEei9l?=
 =?utf-8?B?MHloYmRmQTd1dzJNd3drc21FRys2eTk4K3cxcXRiSEZUdGNHcHY1RFpXU2R2?=
 =?utf-8?B?MUFycnkxTDBSdFdDclp3cU1yMEFOYzNnMFl4L1RoR014TTJ0eGtFOW9JNWln?=
 =?utf-8?B?aDU4Y1hqZG11ZW9TUFdCTTBURnZBNUp2N2N3cWxqbVBObnpzRm54aFF0ZXdo?=
 =?utf-8?B?Nnp2NGgzOGpXRnBiRHRhRFM4L0pEZVY0YkcrWFlGOHRmS1ROQkdyRW5Uak5V?=
 =?utf-8?B?Sng5KzRBNFVrc1crN00wWVdoQ0EwVEgzRU1Bd2F3NVpDWDNmK3dNRVBpbGFo?=
 =?utf-8?B?dEliaVlYMmRPYnJSRHFYdW1Iak1sZDhwMWQyRGxTWHJBeFc3MzZlVjJWTFo4?=
 =?utf-8?B?VEdWWStuQVVsaUJRdDJRdVZoaERmLzBDQW5va2g0T2hnMkZXeGJjcnVDNEZn?=
 =?utf-8?B?dmxzMHJ5VFJMeVFWUHp3b3owUGo0a0tqQWo0U2xQbFJ0K1VUN2xEbEJCL2VM?=
 =?utf-8?B?Zm8xZHE5Nk03SHVPMnRYWmFKUy9EaDBySHhQTXZOeGp1ZXJ4dTk4S2JJUWZM?=
 =?utf-8?B?NFlsQ3h4T3A4VXBrM0tpQ0FCWWFIMTVEQWJjekYyT1F6Wk9NRG1waUFQeWFv?=
 =?utf-8?B?d0NCOVhSQzVybzNkZEszYVZWN1E1ajRBSEtmdFVCYUVRdHA1UlpKMUJZeFg0?=
 =?utf-8?B?b0VocUREb212Y2d6d2hWajlwRjhXNXhYVUlLeHhVVzlZWHQvK3dWMklDc2V3?=
 =?utf-8?B?UmpTL3FTY0VYNlRjZ0JNMUlLdzFmRFllQWtaRGlqU1pOZjZ5a2hmcW4zTDZT?=
 =?utf-8?B?NjFSdFBNemkyRHFQRzJGSytXUWYwUnFESk9YZ0h3cC90eWhXbjNQRGRSVEJj?=
 =?utf-8?B?MFlPOGozb05aM2xVdFVIVXlBOTVXSkFLcDRmUWhEUzR1QU5heHkyNHlBODR2?=
 =?utf-8?Q?JqH4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a25769c-618f-4656-ce0c-08ddbe52809d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 19:06:11.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3XHIglfa7R7+RfyqdNXyKzfWVw+EgDj73MKDNg+s3p3HuQDrwZwI0AG6Xex9vnkRrSm8RID9t1hDWzjiiWd7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7977

On Tue, Jul 08, 2025 at 04:51:55PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 07, 2025 at 12:41:22PM GMT, Frank Li wrote:
> > On Wed, Jul 02, 2025 at 11:19:36AM -0400, Frank Li wrote:
> > > On Wed, Jul 02, 2025 at 08:25:17PM +0530, Manivannan Sadhasivam wrote:
> > > > On Wed, Jul 02, 2025 at 10:40:53AM GMT, Frank Li wrote:
> > > > > On Wed, Jul 02, 2025 at 04:30:48PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Mon, Jun 09, 2025 at 12:34:13PM GMT, Frank Li wrote:
> > > > > > > Set device ID as 'vfunc_no << 3 | func_no' and use
> > > > > > > 'device_set_of_node_from_dev()' to set 'of_node' the same as the EPC parent
> > > > > > > device.
> > > > > > >
> > > > > > > Currently, EPF 'of_node' is NULL, but many functions depend on 'of_node'
> > > > > > > settings, such as DMA, IOMMU, and MSI. At present, all DMA allocation
> > > > > > > functions use the EPC's device node, but they should use the EPF one.
> > > > > > > For multiple function drivers, IOMMU/MSI should be different for each
> > > > > > > function driver.
> > > > > > >
> > > > > >
> > > > > > We don't define OF node for any function, so device_set_of_node_from_dev() also
> > > > > > ends up reusing the EPC node. So how can you make use of it in multi EPF setup?
> > > > >
> > > > > In mfd devices, children devices reuse parent's of_node
> > > > > drivers/gpio/gpio-adp5585.c
> > > > > drivers/input/keyboard/adp5589-keys.c
> > > > > drivers/pwm/pwm-adp5585.c
> > > > >
> > > > > multi EPF should be similar to create multi children devices of mfd.
> > > > >
> > > >
> > > > No, they are not similar. MFD are real physical devices, but EPFs are (so far)
> > > > software based entities.
> > > >
> > > > > > I don't understand.
> > > > >
> > > > > >
> > > > > > > If multiple function devices share the same EPC device, there will be
> > > > > > > no isolation between them. Setting the ID and 'of_node' prepares for
> > > > > > > proper support.
> > > > >
> > > > > Only share the same of_node.
> > > > >
> > > > > Actually pci host bridge have similar situation, all pci ep devices reuse
> > > > > bridge's of node. framework use rid to distringuish it. EPF can use device::id
> > > > > to do similar things.
> > > > >
> > > > > Actually iommu face the similar problem. So far, there are not EP device enable
> > > > > iommu yet, because it needs special mapping.
> > > > >
> > > > > Prevously, I consider create dymatic of_node for each EPF and copy iommu/msi
> > > > > information to each children. But when I see adp5585 case, I think direct
> > > > > use parent's of_node should be simple and good enough.
> > > > >
> > > > > In future, I suggest add children dt binding for it. For example: EPF provide
> > > > > a mailbox interface. how other dts node to refer to this mailbox's phandle?
> > > > >
> > > >
> > > > As I said above, EPFs are not real devices. There is currently only one
> > > > exception, MHI, which is backed by a hardware entity. So we cannot add
> > > > devicetree nodes for EPF, unless each EPF is a hardware entity.
> > >
> > > But how resolve this problem, if a DT device need phandle to a EPF? anyway
> > > this is off topic. let go back this doorbell.
> > >
> > > It needs an of_node for EPF device, I tried many method before.
> > >
> > > Create dymatic of_node for it? MSI framework still go through to parent
> > > of_node to get such information. not big differnece as my view.
> >
> > Actually, DMA have simular issues, just 'workaround' it now.
> >
> > pci_epf_test_read() {
> > 	...
> > 	struct device *dma_dev = epf->epc->dev.parent;
> > 	...
> > 	dst_phys_addr = dma_map_single(dma_dev, buf, map_size,
> >                                                        DMA_FROM_DEVICE);
> > 					^^^ [1]
> > 	...
> > }
> >
> > [1] here direct use epc->dev.parent's of node implicy. If IOMMU enable,
> > two EPF will share one IOMMU space without isolation. If add of_node(may
> > dyamatic create one). we should resolve this problem by use epf device
> > here. Difference EPF will use difference IOMMU space like MSI.
> >
>
> Unless your platform comes up with a hardware based EPF, we are not going to
> have DT node for any EPF. So all EPFs have to share the same DT node of the EPC.
> So right now, it doesn't make a difference if you use a dynamic of_node or copy
> the EPC node.
>
> Just reuse the EPC node for now.

It is show-stop issue. The closest version like
https://lore.kernel.org/all/20241204-ep-msi-v10-2-87c378dbcd6d@nxp.com/

Or we just support one EPF. There are not good way to pass down epf ID to MSI
controller.

[1]: Add DOMAIN_BUS_DEVICE_PCI_EP_MSI (like PCI RC bus),
https://lore.kernel.org/all/20250211-ep-msi-v15-0-bcacc1f2b1a9@nxp.com/
rejected by irq mantainer, they think it is too similar with platform msi.

The key problem is MSI controller need known both EPF's ID and EPC's MSI
domain information.

If use EPC, there are no way to pass down EPF's ID. as above dma example,
use EPC devices, dma_map_single() can't distringiush difference EPF. It is
not big issue all EPF share a IO space. but can't do that for MSI. the
different devices can't share the MSI space.

software managed dt property already used in many devices.

Frank

>
> - Mani
>
> --
> மணிவண்ணன் சதாசிவம்

