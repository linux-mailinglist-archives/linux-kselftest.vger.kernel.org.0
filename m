Return-Path: <linux-kselftest+bounces-49417-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE87D3B85C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26B0F300B005
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E114D275B05;
	Mon, 19 Jan 2026 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WzKkk1Tj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011042.outbound.protection.outlook.com [40.107.130.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAA221264;
	Mon, 19 Jan 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854635; cv=fail; b=rez6kk6fKkQl1VQhiYbwiAgNbZWEL16d2+2M7Na8rhC2RfKe+RKeuCXHYj2b7HwefxxINDxtue2NkTucL9Gj5do4F/8buArfEh4ifuyoHKwYS/Gls0ZsQux+fQ5sUVhynvJVUfD9azVxfgHGfW35ho4ph2x80yeNwthAIsoFQ/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854635; c=relaxed/simple;
	bh=G/L8kfDHj9UMbZy+vOMGtaLLRws6E4gLKs3kgFZc2eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NXgh0oTwm/ZrjXPAlZucJ0XMXDx8I9MmgC8/rXjfIG6m7LSlrtNKNQunyxfdT3VQPZHgDuW/p7X7hQu6hbmJg3LRNol/h6QE9b7sc42Dl8wCzc8fhI+scu0cG9oyouKVZFvAS3SC+i+Xq+Ulh/ksTl1GvezDxT4W5A7JLy9mImo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WzKkk1Tj; arc=fail smtp.client-ip=40.107.130.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tRKzsPfdFJFMPauAngZVfpSLkGGhcAZ+opWUpTTSscSgJEMMW5NsvwadK1oUO1df7Ypvy6GwJZZq7Xm49KS9eesffOH6lPMXF9mBw8ZNIbGJUiwRDnx9wiSMt3FVzjVEkucUuu4r74Cr+og0S6YP6lfS8KZ3l9EegbskhN4qeaKUsYCfUBmnHlHgR4Rq/RUhbN16798h1SIsZpPk6nY7SStzoXHTtxXeFhLmDD/x2MckdrYC8KRKw+4ySS1JRfTnpa8N0p+f1qc+a8hZJuAl2IaWuOzZCeplxc0/MCqByDP0Sjj9cx/l1PZRKGSM7hJcMquIIfJjpiwCf2d90VAaAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u93HnZ135FjcbtAgdmToPSxHYK58fzmbqWDqbwifG8Y=;
 b=MTGQPDuMRXfljsuykSbF6x6UgI9NsZVyee9TowW9JI+vd0cF3S3j6xkB4xCNTVFgFuTst/YmKubaWouHvfzB2BFzoYE5ig6I60nmpQ2CzRzfQCBX+gyhJmqYD16+99+wE0Fafg3FhXl2FGjya4fdofZ21z2f+BuHe/QaKSWAjivco0sre3ByG8NxWou6DmjVnAGxO8bJrNWuZlJgwkQtXUQpNDkblYek488d8zCtdr1KZd443+h+aTIzGhj527eHUpYWT4h7zCfE4Cb3uAgcYyNiKA0FydOM/JIJn+kkLwELHzhKYjANZMdTRQviE/DqOC5VdLfiIZWtnh9EjnHQWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u93HnZ135FjcbtAgdmToPSxHYK58fzmbqWDqbwifG8Y=;
 b=WzKkk1Tj0MhSJzLdQTyqa2+fM/NJ8/7EpM+YEBE9waMqkAB9zWLvzeotIsbdI5l6pvbbtnW+VL/YOWJIg+mtMhuJDj91l/gmgP3GiQ6ep0BI7J6H3OxpfJnXgd8pj4cjz78YS359afa+TaeVn1oJkr6gaJ1LFJZnpiA7ZIAGAtphfMSJ79uHwIa1OWDaZfjwRfG8d6DZF243T2iprrwFrkTz6BEGNgYCTt4YG8kN0D7Enqc6m//bVJIiSmWf5iAST50qmpJKKarbVsesC9NMkuG++O2dRZd3GewH/i7yJDE7Utt+7NPTN52MkQoi3VCFzciR/s+INsYAXlbd9NBcIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:30:30 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:30:30 +0000
Date: Mon, 19 Jan 2026 15:30:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	geert+renesas@glider.be, robh@kernel.org, vkoul@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, jingoohan1@gmail.com,
	lpieralisi@kernel.org, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org, iommu@lists.linux.dev,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com, jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 15/38] PCI: endpoint: pci-epf-vntb: Implement
 .get_dma_dev()
Message-ID: <aW6UWJ6HLltjwhT/@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-16-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-16-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR05CA0192.namprd05.prod.outlook.com
 (2603:10b6:a03:330::17) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2ec9c1-e651-4062-4fe4-08de57999684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hEdpLLTaoIn2JyfuvsFL+gVxDVxQBQbA53c51o/OKZaXe7rltsQoL6CYHqBB?=
 =?us-ascii?Q?GyYnLlfH2gqNAJafV4y5EktQPxDRzcm2+u6erOmYXe8pl7YLIBrkL3QIJ3N7?=
 =?us-ascii?Q?IsNBbnoJ3a8z76PTj/jmPsQZV2ckWXRP4FMxFmRn2or50PilFLPA1hhUq6sL?=
 =?us-ascii?Q?dLB0Ly0FwNSVzCVT8wLVtNvcE0QZuyD3FB9LD+nnwIGfvvS2KhPHwbYN0DMO?=
 =?us-ascii?Q?w4+ywQhwIKoC358bgPtMTiykXoAce+FUu3BxzurV3ntd7ahaqBxbchK88zLL?=
 =?us-ascii?Q?Qy/3HVIxiHxHs8kHezK91eYFiSPt0xEs+l+dpVEF5ai/jVezBV5sKMJsulyM?=
 =?us-ascii?Q?OUuFLfAT4TZDp6cW94BxFqAwmBF/838I5sq3GOiEuZpr/MuJctANd/vKJgBI?=
 =?us-ascii?Q?qRXcys5hsGomh2bwwCEj/MMDyRxyw0O25r9v8i9iJkxGLkBS3B5slvg+TyhT?=
 =?us-ascii?Q?5j4uxAu8wWvaDLJwRhQ05hcA3WMrclhwmspCq2pLJ6ocklaOMKlOvdzt1Iq2?=
 =?us-ascii?Q?wc6WddUQY4+cG2ZI6vMy9uHqfPnqY+WFRa1B3bGjCIlTV8Q8IAMWBKQDHnv4?=
 =?us-ascii?Q?b5WvgAOwbEdA6A7JWiuyuQqBxMJvNDgxfmgE7K31tN0jjJ5HIkNCZHtSHJ3I?=
 =?us-ascii?Q?Nvyw8F5yIUntopSudv9QvSkW2oXCWqvSkInux3r+Cy9HCONaAAVZ1A9sOhIS?=
 =?us-ascii?Q?oNiHoHGBJoCRx4g82RUEX5/A36qG5eUIMthc1DOEvtSobwYyj++G38c7A0eJ?=
 =?us-ascii?Q?8JEKt9Xlid2R9A8cNoLSDdRKaRQ1rxKpMNPwreFPgPv0arBaKh98OxGBWayy?=
 =?us-ascii?Q?UwXIos28Uqp/yGFXsGcHHD9nrsYAEmhUFGt6ujEFvNgdr+H5mh5J3qGT9dkC?=
 =?us-ascii?Q?47tH5ijufC7BfRvck8HZU12CIM+NG+P8zakeQZoHOKUOGDPkz4nA6fqgFHwB?=
 =?us-ascii?Q?dyk3Voj2/wOCgByW7Yj5OFpqc7NPWhRBc8zdAbVBXm7cB3NPd6SbwKYf7Ttw?=
 =?us-ascii?Q?2xrXqabdxMfrkRl7B/FuWd8QOLkdet4IWHa2AGV1Zl5ts4QKqZnbIdHfqFbs?=
 =?us-ascii?Q?wEItfXVhs4t2g6bFXo7HafBPKbpck3cVWNd/yy1m8q8K96Gso5tLlfIlS3EP?=
 =?us-ascii?Q?7l6URofFQA/xO9/zPEOjjA6ohXJbMAPXhgjOh/jJFal/sCv1cyRcETGMw7jh?=
 =?us-ascii?Q?7FlBh3aafleORBTpf+KCLn7Vo5+NGXRow0Ai10AKsMa7wLtjBBeO+IWFva+T?=
 =?us-ascii?Q?RqUCXyK4RR+rUKFLFV5c4AAWLOr1KBanq+mqhBFsC7xv24CgSglwwUTBAqCN?=
 =?us-ascii?Q?k+t0eacRNC4bOK6OwWfjDC2Ua1FV+RigPrUhPmLvwajP4rLwmeWLa+Dxytzy?=
 =?us-ascii?Q?X2BErkZFlxDcykvZlI4i2wjnX5PldRyQarxt8tvttwA3QLbsWNDPUM0YnjmZ?=
 =?us-ascii?Q?QZzgUKOE8RhFje66z7wGmvO2K85r794G1nE/eVGd7eEeu4gpvsj/FiTjkHlu?=
 =?us-ascii?Q?tLZTn+pOsBxxH5uMI4/2KKhXIYntOcAe0V9IEe1YkSG7llcn9iboHfxIaHuC?=
 =?us-ascii?Q?CAiuThIcVKuxTr0AWRvN5TcIFoAqgrMe2yqqGKYJfh+azchjxAMnny4PJEkH?=
 =?us-ascii?Q?kVBJdi69BJbvYSlJxtGSqBU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?drWBG6BdGKyin3yYXDBIBlSKQ6gv6uYhxQu8Fj2kaNI2s800Kj2+0FxAsN+7?=
 =?us-ascii?Q?t+7UcBrlOYFKf/FpXYBQb24X39L4+YXkI0m62qAwxbsCuz9W9ya18w+4HLtj?=
 =?us-ascii?Q?JDjLdaxB3XyVyHFfYZ0NdSajHXXjI48idBaODWLTNoHcNlgGveciIKD75vVY?=
 =?us-ascii?Q?e5cy0hg+bQafhOKDZEurKmptggXlfO9zDO5/SuffQmMfPO39d0pcQ9GY1/Zh?=
 =?us-ascii?Q?v3a0nBOw8+QGesuiW8FaWB92SzawIFVXmKOnxDzjA7XtOH0I4bV5v/YV4/hF?=
 =?us-ascii?Q?sp/kTf01RH4D8vV1IiVojOMQf0qxb/6TFj35RfT3QzirnW6dLb9uX8sP1UUy?=
 =?us-ascii?Q?Em6t8+kZOYKrKuCYnaHO4uyGYh07SUGs6JOq3DdSzNn4dJEGp93v51/xAByV?=
 =?us-ascii?Q?DDSKpgnu9wZmXDzOD7dBqtoXKxd5v151/kvWZCsReM18t4Tv8bCwvr7d5ewd?=
 =?us-ascii?Q?N464+W3KmQTP02YcLbRa2rdbKXZvjCGrS1gnSaCxhHxUg0MqCTardL2ZdfyO?=
 =?us-ascii?Q?cJ4Er5weJAQTjJ96cMa2RKOcaODOCgwSKXmUvEyYUhLEfnQHLqrQUPFip1fA?=
 =?us-ascii?Q?GPDEnZOcv80/A8LUl8f6XJsKWZJNjcsynZHcEofALeJPOVR1UeId6c9tV0bY?=
 =?us-ascii?Q?Jk17a5eUm0bOZocHbkLAQSpdcHqy2vQks35+V3rjMGFqHWCqNyOitsmDliQA?=
 =?us-ascii?Q?ZG6GsPMO/zeimlP0t15CHmt1A4lNwTb+3JOH5cgAc3x5VIdDPKue2XBh4/v4?=
 =?us-ascii?Q?ZpieU0m1K1GWjpCOew3XxtZSmfWJPX8c4OlPrQjzgJ0i/XTUU2OFtzHLuK1h?=
 =?us-ascii?Q?aFMHXK7A+85HGALw/vFH9A30BHH1MTTG4thHk0wjMJm2hIKEvolbW/MH3Tuf?=
 =?us-ascii?Q?SeKLnJ3GuV7vushRaL3DuQNBMFluXcuHrHzTCMlRegc1FeJtyHbFbWj5o9xT?=
 =?us-ascii?Q?NfBcQrZMYtz+JHKNm4qyGAMr4PiQBi8QmO09w+34lbljqP700y5xesyGCir5?=
 =?us-ascii?Q?DiJZ/dfYu61kcVgyo4foOELh5d46o7EJc6NGhtP6C36LtjwBapa1NrXq10Mq?=
 =?us-ascii?Q?J0fRXl+xj0U7lkvDodukd3rGP47Noix5AADlgZWmmcRavUiaGEctgtvZLkRd?=
 =?us-ascii?Q?b931QE6/miKioru428Y80E7OCRoJ2P1hVc+7RS6a0ZsUfoWCgDK5HKAt6JrL?=
 =?us-ascii?Q?oLcYe/MAHpYthoUPJrNkP4nFD/W4aiIDJZozlD86XLy48bsFdrsldVjXap2F?=
 =?us-ascii?Q?DhzPxzTekTuyO+Gc1a8TgEJpi8I86ii1YWbDPUOpvO/0LeAwkaM2K3s5lNkT?=
 =?us-ascii?Q?xWfiC5ZSANXR8LhqGbSWRdt7XKHst2E2/R8C4mFWJ/16M1j8NUHuRRqOdSMC?=
 =?us-ascii?Q?TAChnCx0qxZI2ZtKqX2aAuBVCVmh9uc+aAptLb/pbmEVlrVZmRxF1wYwobUD?=
 =?us-ascii?Q?xp4TwgpcBt8oOwkCeLEkt/NwSGGdBtWi+XjzB/9vFYfrIABzesoL1g3rV3s6?=
 =?us-ascii?Q?QomFaGojQF5ojCgZmLb38TGngxcAPPbNl/3Ivai5izHQN4pdgLAg06zgucJv?=
 =?us-ascii?Q?wh6TZ4BvZ82pE2LrpLTKEym4mdnY6myKfi+Ux9JU5BiWXf4heZX6ro/DfWoG?=
 =?us-ascii?Q?EBpxoav1xo3lP0o9lfWIdhxan6XcejO1/F0DZdpZ6rpRZpx59EDpUg/wy+Ib?=
 =?us-ascii?Q?ZW8aJ9FiRW8up6Tj7/ji2GBA/UnfKkdUmy6JNfmruAbR14jJEx+h2ovjsyUb?=
 =?us-ascii?Q?7pT6UJx6qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2ec9c1-e651-4062-4fe4-08de57999684
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:30:30.1074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z/84zSbJMgW8QkDPdAngio4EO8jtyDjWRmV2iCTMyL6g3n9xU8Vps5bb1V3IxJZW4O0p+g4ZZRf5INA9j35NcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

On Sun, Jan 18, 2026 at 10:54:17PM +0900, Koichiro Den wrote:
> For DMA API allocations and mappings, pci-epf-vntb should provide an
> appropriate struct device for the NTB core/clients.
>
> Implement .get_dma_dev() and return the EPC parent device.

Simple said:

Implement .get_dma_dev() and return the EPC parent device for NTB
core/client's DMA allocations and mappings API.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 9fbc27000f77..7cd976757d15 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1747,6 +1747,15 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
>  	return 0;
>  }
>
> +static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> +{
> +	struct epf_ntb *ntb = ntb_ndev(ndev);
> +
> +	if (!ntb || !ntb->epf)
> +		return NULL;
> +	return ntb->epf->epc->dev.parent;
> +}
> +
>  static void *vntb_epf_get_private_data(struct ntb_dev *ndev)
>  {
>  	struct epf_ntb *ntb = ntb_ndev(ndev);
> @@ -1780,6 +1789,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.db_clear_mask		= vntb_epf_db_clear_mask,
>  	.db_clear		= vntb_epf_db_clear,
>  	.link_disable		= vntb_epf_link_disable,
> +	.get_dma_dev		= vntb_epf_get_dma_dev,
>  	.get_private_data	= vntb_epf_get_private_data,
>  };
>
> --
> 2.51.0
>

