Return-Path: <linux-kselftest+bounces-49290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DCBD396CB
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 15:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484BB3052ABF
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 14:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4710F33F38B;
	Sun, 18 Jan 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tK6y16Ll"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE20322C77;
	Sun, 18 Jan 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744548; cv=fail; b=kK4QHS5eAAIwENJXHNnEjmPF+LiPaVJXhIAfQba5+w4mUQAKyFjgcrKyTVDyBNWrqRutQQvATIjO2OjZy0peRgr7on2DU+settFNtuNnIKVR6a8JRw45nVYX6ho48NxmNS07Ii1XW3rS3m67nZJCYGp57Dqcu6Spm8iqq9WFYHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744548; c=relaxed/simple;
	bh=1Vp0N5ivt9k/MhsXnF9KztQDaveYzVVNm4C3ZVUQHH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ivm39IDZsT3zkCp4ZOUfyAZJzuK/Ume77qnbUtSMGkGumrgbAaFz5XEx/P3hM6V/ATS6AVj5Ob1kQpu4Y0XKqkKGE82Akpj1STmANxUDmhKWRgyw0yD9Oxo0BTqiRA/8P0yrvoc6lLbSlHh6wxfx+PVUT09JKeonQ0Vd/2G5B3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tK6y16Ll; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExLfzlcHeHzk7ISf41ac6w7JUzft7GsqoauPtX9TZnn5D3vsD5NyE9AsvTx5qXVNdMpYqBiNNERN/wIXKuxcyrPHaPVON8ZPjbhQ9+EIz5cOsZJFB4ufrQbhVjUnrEJXkIIaUZXRZTsVBn0UDcULYaVmTLoabr86sUmpZsK1Ihd30W/izZOnLI9Jl7sRwZ+bpdf2FvHiN+Cadph24e/OdzurRdVAiSWBnWlY4WVSGBR3HXn9ZGRJVtSAFE+Gw9q8NMa7EYzBhuWLYeII71J6gCqUWjihf+bz0bA2XESymZooiU06tB7Ci7Ff4ZtZNuMa1FKKyOQHG9sy+RmDALOKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqTQGjo05Vsd5AtsyjnzeWcBPuQBXHiCkBn3+2pMBRs=;
 b=vRvRBORTt4wctP6UWHBs484wsD3BrnllY2sEArTjKhL51azPDgY7qqKDQ10nMWYZBW4SAoFX7wR1fVqYYH1wDhwN7MtJ+F5Br70Okg29iit2vvmlW0L57a297StRAVt06q6vLfEm/jFPg08a5Lt9u5ug66f13afODI9Tu7+kak7MEy0wroxd0rLFrhWbL2O5V8oRcKgKZEZ6AdF1hPJQJTn0detFYf/tNmwVGiqGokzgYIE0Zys3gMXXiFFakS1R47FbV4JnVqmbpZVs1WbaTkUSsH4xiXvUM1W1NIv395kvkvOaQhf/2z6nKZ1gqt+iDhtsqeyfUIC4b14uekoOBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqTQGjo05Vsd5AtsyjnzeWcBPuQBXHiCkBn3+2pMBRs=;
 b=tK6y16LlyrpuY6/WYOD5FpRnBT74O/Ne3qio2wq4XTfyQXy1iPZrP9d7cO7ncCzEgINthp/JqOLnDoytPLAIYSXOG+70ut4r89vhwV4J+8lFWxAoKHtL6gceUA111hXozJhwkCfkhaIySndx1FUWXaeCR+/2qdCffFkgbCkrE4w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSZP286MB2093.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.10; Sun, 18 Jan
 2026 13:55:13 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Sun, 18 Jan 2026
 13:55:13 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	cassel@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	geert+renesas@glider.be,
	robh@kernel.org,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	iommu@lists.linux.dev,
	ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	magnus.damm@gmail.com,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andriy.shevchenko@linux.intel.com,
	jbrunet@baylibre.com,
	utkarsh02t@gmail.com
Subject: [RFC PATCH v4 26/38] NTB: ntb_transport: Add remote embedded-DMA transport client
Date: Sun, 18 Jan 2026 22:54:28 +0900
Message-ID: <20260118135440.1958279-27-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118135440.1958279-1-den@valinux.co.jp>
References: <20260118135440.1958279-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSZP286MB2093:EE_
X-MS-Office365-Filtering-Correlation-Id: 7afd347e-ecfe-4436-8e09-08de5699341a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I5g63nyN6o8iVXNBcxZQus4UjkYXSjMGoX54y1yueMKOo1y6stuFDOjmxw3P?=
 =?us-ascii?Q?zx9pRCjlGhlDAP1JiVFkrmaEO6CwCgF3j+7sjXpRjC7EWrSVd6UZSA+gig9n?=
 =?us-ascii?Q?7XTnH9jL5cZ+uXC7aMuwXzikMcQa7syc38uyV+Ny9i5q3LWXDatts+pYE10d?=
 =?us-ascii?Q?sAhBXGv/S5m97S0ZTv4L8FS8dCu6XB7U+IAwzaqMhtN6dTQxj+axJc1QCmah?=
 =?us-ascii?Q?zo8ARacK7IGk8YUGl6CfaFUzmDMozmsogfl9+/ttmN24q8qsg4iRrgyMBSof?=
 =?us-ascii?Q?b07mVdh/7rB8GFnoCyDzOIFF1Ax5UF1/xQ4PfIdPH61scIpm4HMzkEU/qsfj?=
 =?us-ascii?Q?5XAMAjubBVhbKrX1zLpNhw9S4IRPxz3LcUHgANMn6ubEWZ7+VQLlpdcs18Kw?=
 =?us-ascii?Q?l6pIeUWkWYBkW2J959cAJCKxtQnjfNn3mTrT9fzSz8D+yVDiKean0yQCBh6m?=
 =?us-ascii?Q?HjOQUBHHfGg5PH6EVC3kBe3jX2dbjdPCJt/E0oEikoQXimnqMp+Uyxd7Yxnn?=
 =?us-ascii?Q?7e7l7GRsYojji6baxNFFVVYEM6OqepjkSmL+ROu/vgafEcqFOAxpOIFtveKS?=
 =?us-ascii?Q?dFfFVRREEai+8BvKyLgNbivX6wpQPkxdOe0cTNlUtPMgC73GupHZWV/h50gz?=
 =?us-ascii?Q?T+mzHPIniPrJuS4w98qDk771k+nnykgAZiVpVRT6lABBJcLRZl7+p2a5HkgA?=
 =?us-ascii?Q?0afkTyPQvTMQmJTkmbU/N0qd5vykAovcmwJtd9mNBGottTzEZvPsEX8R0p5n?=
 =?us-ascii?Q?iy8h/mivGhI4OgzvgfgrmMNUMz0WO/nwzjJKiu0G6R8zamlbyKtcvMJ7yTiM?=
 =?us-ascii?Q?1wC3wkqgmmRPXOlT9JOTyLEh39+FdflO/EgWDoOTr2a8LpkUlzgCNEyl6AmP?=
 =?us-ascii?Q?a9Wb3ItSeitSQz/ST5FzJ0vWNd+cQ6iSW2NpVXEayoyO0jhXrb4jkK+zwJ2z?=
 =?us-ascii?Q?9yyEZ+6XBqk0FXyscr9pNmSxTmJMeu2q3XBjcTwYE6iioR+WCYBkJpmSkVxs?=
 =?us-ascii?Q?zv4wNeJiTR+xHSTROx0kwx4lBCDuaatQfrfw6bxTchoESvks/UGG5xa146xp?=
 =?us-ascii?Q?Z5Iz0mM57spuNoREs4P/1QxUQMgklO/gJdi0ktEguVWCxG3XmmT+425cujNs?=
 =?us-ascii?Q?ktw1JjOwDz8wjeWiX4ViVB9pjf12PIhUW0q9jvaofYhSqNfFxyu/WSJ4qp3f?=
 =?us-ascii?Q?KvCKHX7RYjX913LqIS1+OooQjW1ntD+06GD99wJ0i9SjkDObGctpiiv70Unf?=
 =?us-ascii?Q?iQQsb86UjyDZPMT4JhvxOKIQOeTihK3u+naJoHTOb2ip3HbtWxXYNuvrVmNj?=
 =?us-ascii?Q?NXNNXHpjBK3PFjddspDAVN2zsO8bc2+LlI+ku6lMSne5ueUfSh1XyDkEqnyJ?=
 =?us-ascii?Q?xiYbrvggKkoDIZ4fvtB6S9nQo0pd2bZRdfJOuKr5BRl1yRhxS1ZohTe0urtU?=
 =?us-ascii?Q?tWhn6+nrBxGF/VwoIZdX8oLQzjItjOsRzNBCo9xR1KrWdutER2nZIVigLH7J?=
 =?us-ascii?Q?vXcet4nhh9TesM3PeHs5b/crNDVUQQLsHP2HxPFMSZSXzv8rW01U4sgLIhwo?=
 =?us-ascii?Q?U+JhztvVpespJBCJ4XyB3BRJeigf97Q03Cfv+0M2h1VEeYTHE6Q+gD4RIqDU?=
 =?us-ascii?Q?lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MbNpHV8jbM+2VCQQxI8aWcP+WtEbjaPG79awV/Q/t2F/cVkv0FKoOhM8LTTk?=
 =?us-ascii?Q?jMPAVYNH3bocQwpBMMe+/LR4MihXpy/4XEy+cAXzH+NiUGjFtQBgDBGsJEIJ?=
 =?us-ascii?Q?sq10rpDMbdRqhf33u+5O74rFQZez6R2AsC8fn/IewKg8cxayzf2UVkcCden6?=
 =?us-ascii?Q?2HYP+Wz4xzcHIFb/8WaRwN93B55q8DjP4EohHa4qBKUEDknV4Tz716HCyNSu?=
 =?us-ascii?Q?RH/pRkCGnctmk1SOUPSNjwXYju9e3J25Ak1fAVJ16SjhBNuvu6kVZMFYmVre?=
 =?us-ascii?Q?9tmdp/Pv70a5KEzWMKsKtAoG2/oTnjTxyUlY0HYitzMvWRoEYmIsF0/NfVhd?=
 =?us-ascii?Q?WOQcX9fLU/CQAww0Hv6KyKSTHIbm6aJe1zwI3bqxsWfLNEQge07Avd59zvVu?=
 =?us-ascii?Q?vPtSKHtAlxmStCnxt523dNuREAshUPEHCSsK2pFRxq21GqDF/Dl+2MxyIkrW?=
 =?us-ascii?Q?fA4AkWr6B8SjFL8AWaXwLz8FdnssZK8TxUZRCr1mBnBDL0THOFUMP1VwoFKI?=
 =?us-ascii?Q?DnHJSbKBlc+fRM8O9FtbvMMSWSCBt6wKVUsXdyI7yZadZ+9Z7GsZRC61csl0?=
 =?us-ascii?Q?W7sbSCCUDi7U+p39BL0O0xWL1QO8v7hLXRtkfOzfllyf+ZSVwOhrCZEVgFUU?=
 =?us-ascii?Q?r2MNVF2jCbPOxcjRyPHhnHEFtyVKLjhXEbwRV61XCm9kaLFU3VzusH0hynYL?=
 =?us-ascii?Q?Uftrw2odAN8pyHEWvoudzDlDavht8FxjUsCDSCumIiHKcpEHU6zoPUZj6tO1?=
 =?us-ascii?Q?bzj0IFExGGUSstsW3zjZU2mSpVLz3etTZVYwKqcZPU8dbdbj63Co0HK/HE0W?=
 =?us-ascii?Q?EtaCHXnTaPZp9pmVatQVtL+r32MFGaC0398L5u+n+heR0GhqvlsBS5Lf1Tne?=
 =?us-ascii?Q?2Yf/QhgUroia8Zloso71gHD9uPwuLvNxYIhltYucfKXSEbwAyhKkjOgYOk/s?=
 =?us-ascii?Q?K2kdd5mDG0UcQGz7j3DOVT6DVFxRqBs0pJLUv8zzpFWHoK2RazMMeh5yB+dR?=
 =?us-ascii?Q?G+eRRS85pkSmdjmkXkpIUliM7BK9cNE6fK1NOm9AoVrge6ZwWs7GranXjgXi?=
 =?us-ascii?Q?VBW3Zwi/wLdv00br0owRBnR+kmG07K3pc277cF1/XffmNsBqsdPggWe1LEKo?=
 =?us-ascii?Q?4z/EuBUMG9SkE433iA4ljEfHxClpdhOeruFuI8zsC1MfDR8roGuPShESRg/X?=
 =?us-ascii?Q?t9UCDq1NJGYwzbaymzpWni+WS4mclY2e8uKdTzIR9VPAg2/k0Jq4N87Xb2dX?=
 =?us-ascii?Q?+xqcrnCqYspLPDBuaUcCwStXSml9e5b6BWdmmWO+1iV8n0Chk/Yqd2sE4Z4Z?=
 =?us-ascii?Q?kmyT+ly8jyHez+Qh8uRMYdQj790XaADte6UaXABOCMPr+hNLaCDz99IIJplx?=
 =?us-ascii?Q?6oEnuPEtBC8PYaaSsMK9urOuc+55xAVaOoJLXQ5qBG4xstsWLtKu56pf9GfP?=
 =?us-ascii?Q?lIiA9G7MZaCGN9N2jfitBsqGbo7rqmponiNf41DZGZuDqmrVN/zrH7cc+FMt?=
 =?us-ascii?Q?8KvZv0B/RYCq8h4JhOo1wb5oKlWsmn8tMxGAzMTxXZyR/XnUwgUisczHtCdD?=
 =?us-ascii?Q?GDksiCeNENnoYZxD2qMU7liwrnsV+Y3Zh0ufr//Glr+rMBI+TL+M4aMOCaXB?=
 =?us-ascii?Q?s1LZiDgCC7sCOLXmdB97yp2YLs0QooH6N5qwNmfVmya0OUvFHuMq5T8WVIzm?=
 =?us-ascii?Q?E6TCmUZs4DfSH/YPUVYhXNlST7AMJXfx46+r64EgKu3om6Klnl/d4alrbVTP?=
 =?us-ascii?Q?sZyPBEv9Ocuog/RYHpiUmzyWc3tQIMpfUM05t21zQEm9ySIjGPUL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7afd347e-ecfe-4436-8e09-08de5699341a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2026 13:55:13.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /7eGmEeU8CTivyocAfw3NrIKbopnKEj3p8lrkQCwBGOR8Oz9y8ZYHY1VHC37eGsnr1mYQncdYrs+CEc5eP+v9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2093

Introduce a new NTB transport client (ntb_client) that uses a PCI
endpoint embedded DMA engine to move data between the endpoint and the
host.

Unlike the existing cpu/dma memcpy-based transport, this transport
offloads the data plane to an embedded DMA engine located on the
endpoint and driven by the remote host. Control and queue management
remain on the peer-exposed memory window, while bulk data movement is
performed by the remote embedded DMA engine.

This transport requires a different memory window layout from the
traditional NTB transport. A key benefit of this client implementation
is that the memory window no longer needs to carry data buffers.  This
makes the design less sensitive to limited memory window space and
allows scaling to multiple queue pairs.

The transport itself is generic and does not assume a specific vendor's
DMA implementation. Support for concrete embedded DMA engines is
provided via the ntb_edma backend registry. The initial backend
implementation is ntb_dw_edma, which integrates with the DesignWare eDMA
driver.

This separation allows additional embedded DMA backends to be added in
the future without changing the NTB transport core or client logic.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/Kconfig              |   13 +
 drivers/ntb/Makefile             |    1 +
 drivers/ntb/ntb_transport_edma.c | 1110 ++++++++++++++++++++++++++++++
 3 files changed, 1124 insertions(+)
 create mode 100644 drivers/ntb/ntb_transport_edma.c

diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
index df16c755b4da..0dfb89ec290c 100644
--- a/drivers/ntb/Kconfig
+++ b/drivers/ntb/Kconfig
@@ -37,4 +37,17 @@ config NTB_TRANSPORT
 
 	 If unsure, say N.
 
+config NTB_TRANSPORT_EDMA
+	tristate "NTB Transport Client on PCI EP embedded DMA"
+	depends on NTB_TRANSPORT
+	select NTB_EDMA
+	help
+	 Enable a transport backend that uses a peer-exposed PCI embedded DMA
+	 engine through a dedicated NTB memory window.
+
+	 NOTE: You also need at least one eDMA backend driver enabled/loaded
+	 (e.g. NTB_DW_EDMA) so the transport can find a matching backend.
+
+	 If unsure, say N.
+
 endif # NTB
diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
index 47e6b95ef7ce..7bb952a1cf8f 100644
--- a/drivers/ntb/Makefile
+++ b/drivers/ntb/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_NTB) += ntb.o hw/ test/
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport.o
 obj-$(CONFIG_NTB_TRANSPORT) += ntb_transport_core.o
+obj-$(CONFIG_NTB_TRANSPORT_EDMA) += ntb_transport_edma.o
 
 ntb-y			:= core.o
 ntb-$(CONFIG_NTB_MSI)	+= msi.o
diff --git a/drivers/ntb/ntb_transport_edma.c b/drivers/ntb/ntb_transport_edma.c
new file mode 100644
index 000000000000..778143a15930
--- /dev/null
+++ b/drivers/ntb/ntb_transport_edma.c
@@ -0,0 +1,1110 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * NTB transport backend for remote embedded DMA (eDMA).
+ *
+ * The backend uses an endpoint-exposed embedded DMA engine via an NTB
+ * memory window. Hardware-specific details are provided by an ntb_edma
+ * backend driver.
+ */
+
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/debugfs.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/ntb.h>
+#include <linux/ntb_transport.h>
+#include <linux/pci.h>
+#include <linux/pci-epc.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+
+#include "ntb_transport_internal.h"
+#include "hw/edma/backend.h"
+
+static unsigned long max_mw_size;
+module_param(max_mw_size, ulong, 0644);
+MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
+
+static unsigned char max_num_clients;
+module_param(max_num_clients, byte, 0644);
+MODULE_PARM_DESC(max_num_clients, "Maximum number of NTB transport clients");
+
+#define NTB_EDMA_RING_ORDER	7
+#define NTB_EDMA_RING_ENTRIES	BIT(NTB_EDMA_RING_ORDER)
+#define NTB_EDMA_RING_MASK	(NTB_EDMA_RING_ENTRIES - 1)
+
+#define NTB_EDMA_MAX_POLL	32
+
+/*
+ * Remote eDMA mode implementation
+ */
+struct ntb_queue_entry_edma {
+	dma_addr_t addr;
+	struct scatterlist sgl;
+};
+
+struct ntb_transport_ctx_edma {
+	remote_edma_mode_t remote_edma_mode;
+	struct device *dma_dev;
+	struct workqueue_struct *wq;
+	struct ntb_edma_chans chans;
+
+	const struct ntb_edma_backend *be;
+	void *be_priv;
+};
+
+struct ntb_transport_qp_edma {
+	struct ntb_transport_qp *qp;
+
+	/*
+	 * Schedule peer notification from a sleepable context.
+	 * ntb_peer_db_set() may sleep.
+	 */
+	struct work_struct db_work;
+
+	u32 rx_prod;
+	u32 rx_cons;
+	u32 tx_cons;
+	u32 tx_issue;
+
+	spinlock_t rx_lock;
+	spinlock_t tx_lock;
+
+	struct work_struct rx_work;
+	struct work_struct tx_work;
+};
+
+struct ntb_edma_desc {
+	u32 len;
+	u32 flags;
+	u64 addr; /* DMA address */
+	u64 data;
+};
+
+struct ntb_edma_ring {
+	struct ntb_edma_desc desc[NTB_EDMA_RING_ENTRIES];
+	u32 head;
+	u32 tail;
+};
+
+static inline bool ntb_qp_edma_is_rc(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
+
+	return ctx->remote_edma_mode == REMOTE_EDMA_RC;
+}
+
+static inline bool ntb_qp_edma_is_ep(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
+
+	return ctx->remote_edma_mode == REMOTE_EDMA_EP;
+}
+
+static inline bool ntb_qp_edma_enabled(struct ntb_transport_qp *qp)
+{
+	return ntb_qp_edma_is_rc(qp) || ntb_qp_edma_is_ep(qp);
+}
+
+static inline unsigned int ntb_edma_ring_sel(struct ntb_transport_qp *qp,
+					     unsigned int n)
+{
+	return n ^ !!ntb_qp_edma_is_ep(qp);
+}
+
+static inline struct ntb_edma_ring *
+ntb_edma_ring_local(struct ntb_transport_qp *qp, unsigned int n)
+{
+	unsigned int r = ntb_edma_ring_sel(qp, n);
+
+	return &((struct ntb_edma_ring *)qp->rx_buff)[r];
+}
+
+static inline struct ntb_edma_ring __iomem *
+ntb_edma_ring_remote(struct ntb_transport_qp *qp, unsigned int n)
+{
+	unsigned int r = ntb_edma_ring_sel(qp, n);
+
+	return &((struct ntb_edma_ring __iomem *)qp->tx_mw)[r];
+}
+
+static inline struct ntb_edma_desc *
+ntb_edma_desc_local(struct ntb_transport_qp *qp, unsigned int n, unsigned int i)
+{
+	return &ntb_edma_ring_local(qp, n)->desc[i];
+}
+
+static inline struct ntb_edma_desc __iomem *
+ntb_edma_desc_remote(struct ntb_transport_qp *qp, unsigned int n,
+		     unsigned int i)
+{
+	return &ntb_edma_ring_remote(qp, n)->desc[i];
+}
+
+static inline u32 *ntb_edma_head_local(struct ntb_transport_qp *qp,
+				       unsigned int n)
+{
+	return &ntb_edma_ring_local(qp, n)->head;
+}
+
+static inline u32 __iomem *ntb_edma_head_remote(struct ntb_transport_qp *qp,
+						unsigned int n)
+{
+	return &ntb_edma_ring_remote(qp, n)->head;
+}
+
+static inline u32 *ntb_edma_tail_local(struct ntb_transport_qp *qp,
+				       unsigned int n)
+{
+	return &ntb_edma_ring_local(qp, n)->tail;
+}
+
+static inline u32 __iomem *ntb_edma_tail_remote(struct ntb_transport_qp *qp,
+						unsigned int n)
+{
+	return &ntb_edma_ring_remote(qp, n)->tail;
+}
+
+/* The 'i' must be generated by ntb_edma_ring_idx() */
+#define NTB_DESC_TX_O(qp, i)	ntb_edma_desc_remote(qp, 0, i)
+#define NTB_DESC_TX_I(qp, i)	ntb_edma_desc_local(qp, 0, i)
+#define NTB_DESC_RX_O(qp, i)	ntb_edma_desc_remote(qp, 1, i)
+#define NTB_DESC_RX_I(qp, i)	ntb_edma_desc_local(qp, 1, i)
+
+#define NTB_HEAD_TX_I(qp)	ntb_edma_head_local(qp, 0)
+#define NTB_HEAD_RX_O(qp)	ntb_edma_head_remote(qp, 1)
+
+#define NTB_TAIL_TX_O(qp)	ntb_edma_tail_remote(qp, 0)
+#define NTB_TAIL_RX_I(qp)	ntb_edma_tail_local(qp, 1)
+
+/* ntb_edma_ring helpers */
+static __always_inline u32 ntb_edma_ring_idx(u32 v)
+{
+	return v & NTB_EDMA_RING_MASK;
+}
+
+static __always_inline u32 ntb_edma_ring_used_entry(u32 head, u32 tail)
+{
+	if (head >= tail) {
+		WARN_ON_ONCE((head - tail) > (NTB_EDMA_RING_ENTRIES - 1));
+		return head - tail;
+	}
+
+	WARN_ON_ONCE((U32_MAX - tail + head + 1) > (NTB_EDMA_RING_ENTRIES - 1));
+	return U32_MAX - tail + head + 1;
+}
+
+static __always_inline u32 ntb_edma_ring_free_entry(u32 head, u32 tail)
+{
+	return NTB_EDMA_RING_ENTRIES - ntb_edma_ring_used_entry(head, tail) - 1;
+}
+
+static __always_inline bool ntb_edma_ring_full(u32 head, u32 tail)
+{
+	return ntb_edma_ring_free_entry(head, tail) == 0;
+}
+
+static void *ntb_transport_edma_entry_priv_alloc(void)
+{
+	return kzalloc(sizeof(struct ntb_queue_entry_edma), GFP_KERNEL);
+}
+
+static void ntb_transport_edma_entry_priv_free(void *priv)
+{
+	kfree(priv);
+}
+
+static unsigned int ntb_transport_edma_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_qp_edma *edma = qp->priv;
+	unsigned int head, tail;
+
+	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
+		/* In this scope, only 'head' might proceed */
+		tail = READ_ONCE(edma->tx_issue);
+		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
+	}
+	/*
+	 * 'used' amount indicates how much the other end has refilled,
+	 * which are available for us to use for TX.
+	 */
+	return ntb_edma_ring_used_entry(head, tail);
+}
+
+static void ntb_transport_edma_debugfs_stats_show(struct seq_file *s,
+						  struct ntb_transport_qp *qp)
+{
+	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
+	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
+	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
+	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
+	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
+	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
+
+	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
+	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
+	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
+	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
+	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
+	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
+	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
+	seq_putc(s, '\n');
+
+	seq_puts(s, "Using Remote eDMA - Yes\n");
+	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
+}
+
+static void ntb_transport_edma_db_work(struct work_struct *work)
+{
+	struct ntb_transport_qp_edma *edma =
+		container_of(work, struct ntb_transport_qp_edma, db_work);
+	struct ntb_transport_qp *qp = edma->qp;
+
+	ntb_peer_db_set(qp->ndev, qp->qp_bit);
+}
+
+static void ntb_transport_edma_notify_peer(struct ntb_transport_qp_edma *edma)
+{
+	struct ntb_transport_qp *qp = edma->qp;
+	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
+
+	if (!ctx->be->ops->notify_peer(&ctx->chans, ctx->be_priv, qp->qp_num))
+		return;
+
+	/*
+	 * Called from contexts that may be atomic. Since ntb_peer_db_set()
+	 * may sleep, delegate the actual doorbell write to a workqueue.
+	 */
+	queue_work(system_highpri_wq, &edma->db_work);
+}
+
+static void ntb_transport_edma_isr(void *data, int qp_num)
+{
+	struct ntb_transport_ctx *nt = data;
+	struct ntb_transport_qp_edma *edma;
+	struct ntb_transport_ctx_edma *ctx;
+	struct ntb_transport_qp *qp;
+
+	if (qp_num < 0 || qp_num >= nt->qp_count)
+		return;
+
+	qp = &nt->qp_vec[qp_num];
+	if (WARN_ON(!qp))
+		return;
+
+	ctx = (struct ntb_transport_ctx_edma *)qp->transport->priv;
+	edma = qp->priv;
+	if (!edma || !ctx)
+		return;
+
+	queue_work(ctx->wq, &edma->rx_work);
+	queue_work(ctx->wq, &edma->tx_work);
+}
+
+static int ntb_transport_edma_rc_init(struct ntb_transport_ctx *nt)
+{
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_dev *ndev = nt->ndev;
+	struct pci_dev *pdev = ndev->pdev;
+	int peer_mw;
+	int rc;
+
+	if (ctx->remote_edma_mode != REMOTE_EDMA_UNKNOWN)
+		return 0;
+
+	peer_mw = ntb_peer_mw_count(ndev);
+	if (peer_mw <= 0)
+		return -ENODEV;
+
+	rc = ctx->be->ops->rc_connect(ndev, ctx->be_priv, peer_mw - 1, nt->qp_count);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to enable remote eDMA: %d\n", rc);
+		return rc;
+	}
+
+	rc = ctx->be->ops->tx_chans_init(ndev, ctx->be_priv, &ctx->chans, true);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
+		goto err_rc_disconnect;
+	}
+
+	ctx->remote_edma_mode = REMOTE_EDMA_RC;
+	return 0;
+
+err_rc_disconnect:
+	ctx->be->ops->rc_disconnect(ndev, ctx->be_priv);
+	return rc;
+}
+
+static void ntb_transport_edma_rc_deinit(struct ntb_transport_ctx *nt)
+{
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_dev *ndev = nt->ndev;
+
+	if (ctx->remote_edma_mode != REMOTE_EDMA_RC)
+		return;
+
+	ctx->be->ops->tx_chans_deinit(&ctx->chans);
+	ctx->be->ops->rc_disconnect(ndev, ctx->be_priv);
+
+	ctx->remote_edma_mode = REMOTE_EDMA_UNKNOWN;
+}
+
+static int ntb_transport_edma_ep_init(struct ntb_transport_ctx *nt)
+{
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_dev *ndev = nt->ndev;
+	struct pci_dev *pdev = ndev->pdev;
+	int peer_mw;
+	int rc;
+
+	if (ctx->remote_edma_mode != REMOTE_EDMA_UNKNOWN)
+		return 0;
+
+	/*
+	 * This check assumes that the endpoint (pci-epf-vntb.c)
+	 * ntb_dev_ops implements .get_private_data() while the host side
+	 * (ntb_hw_epf.c) does not.
+	 */
+	if (!ntb_get_private_data(ndev))
+		return 0;
+
+	peer_mw = ntb_peer_mw_count(ndev);
+	if (peer_mw <= 0)
+		return -ENODEV;
+
+	rc = ctx->be->ops->ep_publish(ndev, ctx->be_priv, peer_mw - 1, nt->qp_count,
+				      ntb_transport_edma_isr, nt);
+	if (rc) {
+		dev_err(&pdev->dev,
+			"Failed to set up memory window for eDMA: %d\n", rc);
+		return rc;
+	}
+
+	rc = ctx->be->ops->tx_chans_init(ndev, ctx->be_priv, &ctx->chans, false);
+	if (rc) {
+		dev_err(&pdev->dev, "Failed to setup eDMA channels: %d\n", rc);
+		ctx->be->ops->ep_unpublish(ndev, ctx->be_priv);
+		return rc;
+	}
+
+	ctx->remote_edma_mode = REMOTE_EDMA_EP;
+	return 0;
+}
+
+static void ntb_transport_edma_ep_deinit(struct ntb_transport_ctx *nt)
+{
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_dev *ndev = nt->ndev;
+
+	if (ctx->remote_edma_mode != REMOTE_EDMA_EP)
+		return;
+
+	ctx->be->ops->tx_chans_deinit(&ctx->chans);
+	ctx->be->ops->ep_unpublish(ndev, ctx->be_priv);
+
+	ctx->remote_edma_mode = REMOTE_EDMA_UNKNOWN;
+}
+
+static int ntb_transport_edma_setup_qp_mw(struct ntb_transport_ctx *nt,
+					  unsigned int qp_num)
+{
+	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
+	struct ntb_dev *ndev = nt->ndev;
+	struct ntb_queue_entry *entry;
+	struct ntb_transport_mw *mw;
+	unsigned int mw_num, mw_count, qp_count;
+	unsigned int qp_offset, rx_info_offset;
+	unsigned int mw_size, mw_size_per_qp;
+	unsigned int num_qps_mw;
+	size_t edma_total;
+	unsigned int i;
+	int node;
+
+	mw_count = nt->mw_count;
+	qp_count = nt->qp_count;
+
+	mw_num = QP_TO_MW(nt, qp_num);
+	mw = &nt->mw_vec[mw_num];
+
+	if (!mw->virt_addr)
+		return -ENOMEM;
+
+	if (mw_num < qp_count % mw_count)
+		num_qps_mw = qp_count / mw_count + 1;
+	else
+		num_qps_mw = qp_count / mw_count;
+
+	mw_size = min(nt->mw_vec[mw_num].phys_size, mw->xlat_size);
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
+
+	mw_size_per_qp = round_down((unsigned int)mw_size / num_qps_mw, SZ_64);
+	qp_offset = mw_size_per_qp * (qp_num / mw_count);
+	rx_info_offset = mw_size_per_qp - sizeof(struct ntb_rx_info);
+
+	qp->tx_mw_size = mw_size_per_qp;
+	qp->tx_mw = nt->mw_vec[mw_num].vbase + qp_offset;
+	if (!qp->tx_mw)
+		return -EINVAL;
+	qp->tx_mw_phys = nt->mw_vec[mw_num].phys_addr + qp_offset;
+	if (!qp->tx_mw_phys)
+		return -EINVAL;
+	qp->rx_info = qp->tx_mw + rx_info_offset;
+	qp->rx_buff = mw->virt_addr + qp_offset;
+	qp->remote_rx_info = qp->rx_buff + rx_info_offset;
+
+	/* Due to housekeeping, there must be at least 2 buffs */
+	qp->tx_max_frame = min(nt->transport_mtu, mw_size_per_qp / 2);
+	qp->rx_max_frame = min(nt->transport_mtu, mw_size_per_qp / 2);
+
+	/* In eDMA mode, decouple from MW sizing and force ring-sized entries */
+	edma_total = 2 * sizeof(struct ntb_edma_ring);
+	if (rx_info_offset < edma_total) {
+		dev_err(&ndev->dev, "Ring space requires %zuB (>=%uB)\n",
+			edma_total, rx_info_offset);
+		return -EINVAL;
+	}
+	qp->tx_max_entry = NTB_EDMA_RING_ENTRIES;
+	qp->rx_max_entry = NTB_EDMA_RING_ENTRIES;
+
+	/*
+	 * Checking to see if we have more entries than the default.
+	 * We should add additional entries if that is the case so we
+	 * can be in sync with the transport frames.
+	 */
+	node = dev_to_node(&ndev->dev);
+	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
+		entry = ntb_queue_entry_alloc(nt, qp, node);
+		if (!entry)
+			return -ENOMEM;
+
+		entry->qp = qp;
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
+			     &qp->rx_free_q);
+		qp->rx_alloc_entry++;
+	}
+
+	memset(qp->rx_buff, 0, edma_total);
+
+	qp->rx_pkts = 0;
+	qp->tx_pkts = 0;
+
+	return 0;
+}
+
+static int ntb_transport_edma_rx_complete(struct ntb_transport_qp *qp)
+{
+	struct device *dma_dev = ntb_get_dma_dev(qp->ndev);
+	struct ntb_transport_qp_edma *edma = qp->priv;
+	struct ntb_queue_entry_edma *e;
+	struct ntb_queue_entry *entry;
+	struct ntb_edma_desc *in;
+	unsigned int len;
+	bool link_down;
+	u32 idx;
+
+	if (ntb_edma_ring_used_entry(READ_ONCE(*NTB_TAIL_RX_I(qp)),
+				     edma->rx_cons) == 0)
+		return 0;
+
+	idx = ntb_edma_ring_idx(edma->rx_cons);
+	in = NTB_DESC_RX_I(qp, idx);
+	if (!(in->flags & DESC_DONE_FLAG))
+		return 0;
+
+	link_down = in->flags & LINK_DOWN_FLAG;
+	in->flags = 0;
+	len = in->len; /* might be smaller than entry->len */
+
+	entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
+	if (WARN_ON(!entry))
+		return 0;
+
+	e = entry->priv;
+	dma_unmap_single(dma_dev, e->addr, entry->len, DMA_FROM_DEVICE);
+
+	if (link_down) {
+		ntb_qp_link_down(qp);
+		edma->rx_cons++;
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
+		return 1;
+	}
+
+	qp->rx_bytes += len;
+	qp->rx_pkts++;
+	edma->rx_cons++;
+
+	if (qp->rx_handler && qp->client_ready)
+		qp->rx_handler(qp, qp->cb_data, entry->cb_data, len);
+
+	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_free_q);
+	return 1;
+}
+
+static void ntb_transport_edma_rx_work(struct work_struct *work)
+{
+	struct ntb_transport_qp_edma *edma =
+		container_of(work, struct ntb_transport_qp_edma, rx_work);
+	struct ntb_transport_qp *qp = edma->qp;
+	struct ntb_transport_ctx_edma *ctx = qp->transport->priv;
+	unsigned int i;
+
+	for (i = 0; i < NTB_EDMA_MAX_POLL; i++) {
+		if (!ntb_transport_edma_rx_complete(qp))
+			break;
+	}
+
+	if (ntb_transport_edma_rx_complete(qp))
+		queue_work(ctx->wq, &edma->rx_work);
+}
+
+static void ntb_transport_edma_tx_work(struct work_struct *work)
+{
+	struct ntb_transport_qp_edma *edma =
+		container_of(work, struct ntb_transport_qp_edma, tx_work);
+	struct ntb_transport_qp *qp = edma->qp;
+	struct ntb_edma_desc *in, __iomem *out;
+	struct ntb_queue_entry *entry;
+	void *cb_data;
+	int len;
+	u32 idx;
+
+	while (ntb_edma_ring_used_entry(READ_ONCE(edma->tx_issue),
+					edma->tx_cons) != 0) {
+		/* Paired with smp_wmb() in ntb_transport_edma_tx_enqueue_inner() */
+		smp_rmb();
+
+		idx = ntb_edma_ring_idx(edma->tx_cons);
+		in = NTB_DESC_TX_I(qp, idx);
+		entry = (struct ntb_queue_entry *)(uintptr_t)in->data;
+		if (!entry || !(entry->flags & DESC_DONE_FLAG))
+			break;
+
+		in->data = 0;
+
+		cb_data = entry->cb_data;
+		len = entry->len;
+
+		out = NTB_DESC_TX_O(qp, idx);
+
+		WRITE_ONCE(edma->tx_cons, edma->tx_cons + 1);
+
+		iowrite32(entry->flags, &out->flags);
+		iowrite32(edma->tx_cons, NTB_TAIL_TX_O(qp));
+
+		ntb_transport_edma_notify_peer(edma);
+
+		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
+			     &qp->tx_free_q);
+
+		if (qp->tx_handler)
+			qp->tx_handler(qp, qp->cb_data, cb_data, len);
+
+		if (len < 0)
+			continue;
+
+		/* stat updates */
+		qp->tx_bytes += len;
+		qp->tx_pkts++;
+	}
+}
+
+static void ntb_transport_edma_tx_cb(void *data,
+				     const struct dmaengine_result *res)
+{
+	struct ntb_queue_entry *entry = data;
+	struct ntb_transport_qp *qp = entry->qp;
+	struct ntb_queue_entry_edma *e = entry->priv;
+	struct ntb_transport_ctx *nt = qp->transport;
+	struct device *dma_dev = ntb_get_dma_dev(qp->ndev);
+	enum dmaengine_tx_result dma_err = res->result;
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_transport_qp_edma *edma = qp->priv;
+
+	switch (dma_err) {
+	case DMA_TRANS_READ_FAILED:
+	case DMA_TRANS_WRITE_FAILED:
+	case DMA_TRANS_ABORTED:
+		entry->errors++;
+		entry->len = -EIO;
+		break;
+	case DMA_TRANS_NOERROR:
+	default:
+		break;
+	}
+	dma_unmap_sg(dma_dev, &e->sgl, 1, DMA_TO_DEVICE);
+	sg_dma_address(&e->sgl) = 0;
+
+	entry->flags |= DESC_DONE_FLAG;
+
+	queue_work(ctx->wq, &edma->tx_work);
+}
+
+static int ntb_transport_edma_submit(struct device *d, struct dma_chan *chan,
+				     size_t len, void *rc_src, dma_addr_t dst,
+				     struct ntb_queue_entry *entry)
+{
+	struct ntb_queue_entry_edma *e = entry->priv;
+	struct dma_async_tx_descriptor *txd;
+	struct scatterlist *sgl = &e->sgl;
+	struct dma_slave_config cfg;
+	dma_cookie_t cookie;
+	int nents, rc;
+
+	if (!d)
+		return -ENODEV;
+
+	if (!chan)
+		return -ENXIO;
+
+	if (WARN_ON(!rc_src || !dst))
+		return -EINVAL;
+
+	if (WARN_ON(sg_dma_address(sgl)))
+		return -EINVAL;
+
+	sg_init_one(sgl, rc_src, len);
+	nents = dma_map_sg(d, sgl, 1, DMA_TO_DEVICE);
+	if (nents <= 0)
+		return -EIO;
+
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.dst_addr       = dst;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.direction      = DMA_MEM_TO_DEV;
+
+	txd = dmaengine_prep_config_sg(chan, sgl, 1, DMA_MEM_TO_DEV,
+				       DMA_CTRL_ACK | DMA_PREP_INTERRUPT, &cfg);
+	if (!txd) {
+		rc = -EIO;
+		goto out_unmap;
+	}
+
+	txd->callback_result = ntb_transport_edma_tx_cb;
+	txd->callback_param = entry;
+
+	cookie = dmaengine_submit(txd);
+	if (dma_submit_error(cookie)) {
+		rc = -EIO;
+		goto out_unmap;
+	}
+	dma_async_issue_pending(chan);
+	return 0;
+out_unmap:
+	dma_unmap_sg(d, sgl, 1, DMA_TO_DEVICE);
+	return rc;
+}
+
+static struct dma_chan *ntb_transport_edma_pick_chan(struct ntb_edma_chans *chans,
+						     unsigned int idx)
+{
+	return chans->chan[idx % chans->num_chans];
+}
+
+static int ntb_transport_edma_tx_enqueue_inner(struct ntb_transport_qp *qp,
+					       struct ntb_queue_entry *entry)
+{
+	struct device *dma_dev = ntb_get_dma_dev(qp->ndev);
+	struct ntb_transport_qp_edma *edma = qp->priv;
+	struct ntb_transport_ctx *nt = qp->transport;
+	struct ntb_edma_desc *in, __iomem *out;
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	unsigned int len = entry->len;
+	struct dma_chan *chan;
+	u32 issue, idx, head;
+	dma_addr_t dst;
+	int rc;
+
+	WARN_ON_ONCE(entry->flags & DESC_DONE_FLAG);
+
+	scoped_guard(spinlock_irqsave, &edma->tx_lock) {
+		head = READ_ONCE(*NTB_HEAD_TX_I(qp));
+		issue = edma->tx_issue;
+		if (ntb_edma_ring_used_entry(head, issue) == 0) {
+			qp->tx_ring_full++;
+			return -ENOSPC;
+		}
+
+		/*
+		 * ntb_transport_edma_tx_work() checks entry->flags
+		 * so it needs to be set before tx_issue++.
+		 */
+		idx = ntb_edma_ring_idx(issue);
+		in = NTB_DESC_TX_I(qp, idx);
+		in->data = (uintptr_t)entry;
+
+		/* Make in->data visible before tx_issue++ */
+		smp_wmb();
+
+		WRITE_ONCE(edma->tx_issue, edma->tx_issue + 1);
+	}
+
+	/* Publish the final transfer length to the other end */
+	out = NTB_DESC_TX_O(qp, idx);
+	iowrite32(len, &out->len);
+	ioread32(&out->len);
+
+	if (unlikely(!len)) {
+		entry->flags |= DESC_DONE_FLAG;
+		queue_work(ctx->wq, &edma->tx_work);
+		return 0;
+	}
+
+	/* Paired with dma_wmb() in ntb_transport_edma_rx_enqueue_inner() */
+	dma_rmb();
+
+	/* kick remote eDMA read transfer */
+	dst = (dma_addr_t)in->addr;
+	chan = ntb_transport_edma_pick_chan(&ctx->chans, qp->qp_num);
+	rc = ntb_transport_edma_submit(dma_dev, chan, len, entry->buf, dst,
+				       entry);
+	if (rc) {
+		entry->errors++;
+		entry->len = -EIO;
+		entry->flags |= DESC_DONE_FLAG;
+		queue_work(ctx->wq, &edma->tx_work);
+	}
+	return 0;
+}
+
+static int ntb_transport_edma_tx_enqueue(struct ntb_transport_qp *qp,
+					 struct ntb_queue_entry *entry,
+					 void *cb, void *data, unsigned int len,
+					 unsigned int flags)
+{
+	struct ntb_queue_entry_edma *e = entry->priv;
+	struct device *dma_dev;
+
+	if (e->addr) {
+		/* Deferred unmap */
+		dma_dev = ntb_get_dma_dev(qp->ndev);
+		dma_unmap_single(dma_dev, e->addr, entry->len,
+				 DMA_TO_DEVICE);
+	}
+
+	entry->cb_data = cb;
+	entry->buf = data;
+	entry->len = len;
+	entry->flags = flags;
+	entry->errors = 0;
+
+	e->addr = 0;
+
+	WARN_ON_ONCE(!ntb_qp_edma_enabled(qp));
+
+	return ntb_transport_edma_tx_enqueue_inner(qp, entry);
+}
+
+static int ntb_transport_edma_rx_enqueue_inner(struct ntb_transport_qp *qp,
+					       struct ntb_queue_entry *entry)
+{
+	struct device *dma_dev = ntb_get_dma_dev(qp->ndev);
+	struct ntb_transport_qp_edma *edma = qp->priv;
+	struct ntb_queue_entry_edma *e = entry->priv;
+	struct ntb_edma_desc *in, __iomem *out;
+	unsigned int len = entry->len;
+	void *data = entry->buf;
+	dma_addr_t dst;
+	u32 idx;
+	int rc;
+
+	dst = dma_map_single(dma_dev, data, len, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dma_dev, dst);
+	if (rc)
+		return rc;
+
+	guard(spinlock_bh)(&edma->rx_lock);
+
+	if (ntb_edma_ring_full(READ_ONCE(edma->rx_prod),
+			       READ_ONCE(edma->rx_cons))) {
+		rc = -ENOSPC;
+		goto out_unmap;
+	}
+
+	idx = ntb_edma_ring_idx(edma->rx_prod);
+	in = NTB_DESC_RX_I(qp, idx);
+	out = NTB_DESC_RX_O(qp, idx);
+
+	iowrite32(len, &out->len);
+	iowrite64(dst, &out->addr);
+
+	WARN_ON(in->flags & DESC_DONE_FLAG);
+	in->data = (uintptr_t)entry;
+	e->addr = dst;
+
+	/* Ensure len/addr are visible before the head update */
+	dma_wmb();
+
+	WRITE_ONCE(edma->rx_prod, edma->rx_prod + 1);
+	iowrite32(edma->rx_prod, NTB_HEAD_RX_O(qp));
+
+	return 0;
+out_unmap:
+	dma_unmap_single(dma_dev, dst, len, DMA_FROM_DEVICE);
+	return rc;
+}
+
+static int ntb_transport_edma_rx_enqueue(struct ntb_transport_qp *qp,
+					 struct ntb_queue_entry *entry)
+{
+	int rc;
+
+	rc = ntb_transport_edma_rx_enqueue_inner(qp, entry);
+	if (rc) {
+		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
+			     &qp->rx_free_q);
+		return rc;
+	}
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+
+	return 0;
+}
+
+static void ntb_transport_edma_rx_poll(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_transport_qp_edma *edma = qp->priv;
+
+	queue_work(ctx->wq, &edma->rx_work);
+	queue_work(ctx->wq, &edma->tx_work);
+}
+
+static int ntb_transport_edma_qp_init(struct ntb_transport_ctx *nt,
+				      unsigned int qp_num)
+{
+	struct ntb_transport_qp *qp = &nt->qp_vec[qp_num];
+	struct ntb_transport_qp_edma *edma;
+	struct ntb_dev *ndev = nt->ndev;
+	int node;
+
+	node = dev_to_node(&ndev->dev);
+
+	qp->priv = kzalloc_node(sizeof(*edma), GFP_KERNEL, node);
+	if (!qp->priv)
+		return -ENOMEM;
+
+	edma = (struct ntb_transport_qp_edma *)qp->priv;
+	edma->qp = qp;
+	edma->rx_prod = 0;
+	edma->rx_cons = 0;
+	edma->tx_cons = 0;
+	edma->tx_issue = 0;
+
+	spin_lock_init(&edma->rx_lock);
+	spin_lock_init(&edma->tx_lock);
+
+	INIT_WORK(&edma->db_work, ntb_transport_edma_db_work);
+	INIT_WORK(&edma->rx_work, ntb_transport_edma_rx_work);
+	INIT_WORK(&edma->tx_work, ntb_transport_edma_tx_work);
+
+	return 0;
+}
+
+static void ntb_transport_edma_qp_free(struct ntb_transport_qp *qp)
+{
+	struct ntb_transport_qp_edma *edma = qp->priv;
+
+	disable_work_sync(&edma->db_work);
+	disable_work_sync(&edma->rx_work);
+	disable_work_sync(&edma->tx_work);
+
+	kfree(qp->priv);
+	qp->priv = NULL;
+}
+
+static int ntb_transport_edma_link_up_pre(struct ntb_transport_ctx *nt)
+{
+	struct ntb_dev *ndev = nt->ndev;
+	struct pci_dev *pdev = ndev->pdev;
+	int rc;
+
+	rc = ntb_transport_edma_ep_init(nt);
+	if (rc)
+		dev_err(&pdev->dev, "Failed to init EP: %d\n", rc);
+
+	return rc;
+}
+
+static int ntb_transport_edma_link_up_post(struct ntb_transport_ctx *nt)
+{
+	struct ntb_dev *ndev = nt->ndev;
+	struct pci_dev *pdev = ndev->pdev;
+	int rc;
+
+	rc = ntb_transport_edma_rc_init(nt);
+	if (rc)
+		dev_err(&pdev->dev, "Failed to init RC: %d\n", rc);
+
+	return rc;
+}
+
+static void ntb_transport_edma_link_down(struct ntb_transport_ctx *nt)
+{
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+
+	WARN_ON_ONCE(!ctx);
+	switch (ctx->remote_edma_mode) {
+	case REMOTE_EDMA_EP:
+		ntb_transport_edma_ep_deinit(nt);
+		break;
+	case REMOTE_EDMA_RC:
+		ntb_transport_edma_rc_deinit(nt);
+		break;
+	default:
+	}
+}
+
+static void ntb_transport_edma_disable(struct ntb_transport_ctx *nt)
+{
+	struct ntb_transport_ctx_edma *ctx = nt->priv;
+	struct ntb_dev *ndev = nt->ndev;
+
+	if (!ctx)
+		return;
+
+	if (ctx->wq)
+		destroy_workqueue(ctx->wq);
+	if (ctx->be_priv)
+		ctx->be->ops->free(ndev, &ctx->be_priv);
+	if (ctx->be)
+		ntb_edma_backend_put(ctx->be);
+
+	kfree(ctx);
+	nt->priv = NULL;
+}
+
+static int ntb_transport_edma_enable(struct ntb_transport_ctx *nt,
+				     unsigned int *mw_count)
+{
+	struct ntb_transport_ctx_edma *ctx;
+	struct ntb_dev *ndev = nt->ndev;
+	int node;
+	int ret;
+
+	node = dev_to_node(&ndev->dev);
+	ctx = kzalloc_node(sizeof(*ctx), GFP_KERNEL, node);
+	if (!ctx)
+		return -ENOMEM;
+
+	nt->priv = ctx;
+	ctx->be = ntb_edma_backend_get(ndev);
+	if (!ctx->be) {
+		dev_err(&ndev->dev, "No suitable eDMA backend found\n");
+		ret = -ENODEV;
+		goto err;
+	}
+	dev_info(&ndev->dev, "Selected eDMA backend: %s\n", ctx->be->name);
+
+	ret = ctx->be->ops->alloc(ndev, &ctx->be_priv);
+	if (ret)
+		goto err;
+
+	/*
+	 * We need at least one MW for the transport plus one MW reserved
+	 * for the remote eDMA window (see ntb_edma_setup_mws/peer).
+	 */
+	if (*mw_count <= 1) {
+		dev_err(&ndev->dev,
+			"remote eDMA requires at least two MWS (have %u)\n",
+			*mw_count);
+		kfree(ctx->be_priv);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	ctx->wq = alloc_workqueue("ntb-edma-wq", WQ_UNBOUND | WQ_SYSFS, 0);
+	if (!ctx->wq) {
+		kfree(ctx->be_priv);
+		ntb_transport_edma_disable(nt);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* Reserve the last peer MW exclusively for the eDMA window. */
+	*mw_count -= 1;
+
+	return 0;
+err:
+	ntb_transport_edma_disable(nt);
+	return ret;
+}
+
+static const struct ntb_transport_backend_ops edma_transport_ops = {
+	.enable = ntb_transport_edma_enable,
+	.disable = ntb_transport_edma_disable,
+	.qp_init = ntb_transport_edma_qp_init,
+	.qp_free = ntb_transport_edma_qp_free,
+	.link_up_pre = ntb_transport_edma_link_up_pre,
+	.link_up_post = ntb_transport_edma_link_up_post,
+	.link_down = ntb_transport_edma_link_down,
+	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
+	.entry_priv_alloc = ntb_transport_edma_entry_priv_alloc,
+	.entry_priv_free  = ntb_transport_edma_entry_priv_free,
+	.tx_free_entry = ntb_transport_edma_tx_free_entry,
+	.tx_enqueue = ntb_transport_edma_tx_enqueue,
+	.rx_enqueue = ntb_transport_edma_rx_enqueue,
+	.rx_poll = ntb_transport_edma_rx_poll,
+	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
+};
+
+static struct ntb_transport_backend ntb_edma_transport_backend = {
+	.name = "edma",
+	.ops = &edma_transport_ops,
+	.owner = THIS_MODULE,
+};
+
+static int ntb_transport_edma_client_probe(struct ntb_client *self,
+					   struct ntb_dev *ndev)
+{
+	return ntb_transport_attach(ndev, "edma", false, max_mw_size, 0xffff,
+				    max_num_clients, 0, false,
+				    NTB_EDMA_RING_ENTRIES);
+}
+
+static void ntb_transport_edma_client_remove(struct ntb_client *self,
+					     struct ntb_dev *ndev)
+{
+	ntb_transport_detach(ndev);
+}
+
+static struct ntb_client ntb_transport_edma_client = {
+	.ops = {
+		.probe = ntb_transport_edma_client_probe,
+		.remove = ntb_transport_edma_client_remove,
+	},
+};
+
+static int __init ntb_transport_edma_init(void)
+{
+	int rc;
+
+	rc = ntb_transport_backend_register(&ntb_edma_transport_backend);
+	if (rc)
+		return rc;
+
+	rc = ntb_register_client(&ntb_transport_edma_client);
+	if (rc)
+		ntb_transport_backend_unregister(&ntb_edma_transport_backend);
+
+	return rc;
+}
+module_init(ntb_transport_edma_init);
+
+static void ntb_transport_edma_exit(void)
+{
+	ntb_unregister_client(&ntb_transport_edma_client);
+	ntb_transport_backend_unregister(&ntb_edma_transport_backend);
+}
+module_exit(ntb_transport_edma_exit);
+
+MODULE_DESCRIPTION("NTB transport backend for remote PCI embedded DMA");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.51.0


