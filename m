Return-Path: <linux-kselftest+bounces-37017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1FB00813
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 18:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 717DA3ACFDA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B18D27A916;
	Thu, 10 Jul 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GQsgERL8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A1274FDE;
	Thu, 10 Jul 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163625; cv=fail; b=XqgV2wzeHj8O8el19nJuQkdfBHs+GqBA/A/ofSIxCSIvwcNq0Kb3YT4hocmKpsQMYJCdJGsiEUIwnclxlvndE956h9faUEILolXEd1S4Fa9wdMXYQ66IUNHZ9GA3u+8nfO4kleoxiQh47Ui7f9Hp57VQneXQK0by5aBE0DYOgOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163625; c=relaxed/simple;
	bh=u16O43YT0cKvq99wqmTKPaEBSRCFqTZHDIymud3Zu/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j/LJ7sq9bfPsLmIVW0/gE2VqeTV9F8MZah61E9SJ5s8vKFwXtQndgk8cKS6Mkav/eEFS6AmktHP3Qjd5Rg2xAeSHwhoZyFf99vE0pbGX9ZalFDtAk1SQW0xPzQmssMPApLX/mmfjx2+BX/CH0Yfzw2Mjm2fC7sY61jJ/PksGpJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GQsgERL8; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBKIw/of3lsVdqDg9ij8o8lVLZNtiyGiPKzrqb/ST5wRnNQIa1aNCropyEQLtWcIpdCIP2VJSTPDKl4t4WIydU20YQx6CL+T2Z/ip8e+3IaB/HUhixo0Ni/GBHPw0rsPaWBVRPvRkfQgqRsdxcGw4wV0GDxS554HbOrufUTHXPnlHE7kbTBOm4n+AuLRGPsSW+UsuDI6udtfD4wrwIFqw5DS9M0I4KFJidsMS8HMOSpAao475lbgxOEIVYOSMs7x7pW8NIljnBdYkr/Tg/BBZ1PGJIEdeyiu5x2R6XxgIJTop+OpMDND+1eahvtP61DZra4wdjyO4wqbUpfALOmkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kt05uIgwetaXwYDwJG3akXamgFNRAZiiBy+CrKT9hqs=;
 b=mHigO5Ciw1rG+jai73ksdBZ82s8ahhRyV9VKkq1ZTIePtNLWYEnw+ctVDI58wlLU6wuw/hqPkq/00pJZ0o09fBP9JavbSlB0aYXrryhUiXWprzxnNFdSrHQ5baXNv7v6LWz3haDoDZfGkcUfaLaYCGoWPhign7881Hzixh8iaV8zjZKZxdSaLoPYxxejD0Hjp6O9HqMqWpzFSWZZ1VzHQUxq2DyfxTO/aAX/X9qfbUwR1dp/nCsnYMagU8fX1Lf8M6yAgztAky2b4qhC4GbY1H2nBWdgzaMqj/hBohcxCa3e4Fb6+GKraFhcevO4Q2YQMw2XP3oC15HHMoOIigShug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kt05uIgwetaXwYDwJG3akXamgFNRAZiiBy+CrKT9hqs=;
 b=GQsgERL8jzrjYleIbFvzTMAYZakiAP6W5mS+/JcOD74f8DId4CnfftaNlYG3nOJnayvQJNE9DzcYYQ5jb2yXzZ7Bqa3I/B+fJkWAJgmM4bJhcC+IHk1eGg7gjqco4RjusSshiJAwluFjclyCvbl+Zc7ZqANYNKVl3fUyfGIVkIErRptf59GwzdtJoLw3esN+pEzjtzMa9vqx+jqVldHjF8AnnJR/EjoKwnHU4qKOtJOw8BL3L8xLkgsxdTmfiumwFpTAvKLcaeWfjBrNTD84lZ9c214niuYayqa4+N88VGfLruMrlWDxVaZxjdSTwp7bql5Iqv5igCP0cW9PNujvHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by OSKPR04MB11317.eurprd04.prod.outlook.com (2603:10a6:e10:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 10 Jul
 2025 16:06:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8901.023; Thu, 10 Jul 2025
 16:06:59 +0000
Date: Thu, 10 Jul 2025 12:06:51 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
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
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	dlemoal@kernel.org, jdmason@kudzu.us, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kselftest@vger.kernel.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v20 0/9] PCI: EP: Add RC-to-EP doorbell with platform MSI
 controller
Message-ID: <aG/lG2r4U4rPrEeB@lizhi-Precision-Tower-5810>
References: <20250709-ep-msi-v20-0-43d56f9bd54a@nxp.com>
 <aG-mqWtUu9-CD43U@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG-mqWtUu9-CD43U@ryzen>
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|OSKPR04MB11317:EE_
X-MS-Office365-Filtering-Correlation-Id: a9465d7e-a754-46de-99f1-08ddbfcbcc88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VXe82JHdmzsDp11m9odwHG/tnQo7jhkjCq7eDDvUg9vMT3L8GXsu2Z15NdbI?=
 =?us-ascii?Q?nQ2NZyIaqqT3v724vSqvYWJf/xtReF4ARoQpcT1qCy1clnPzgu9CLNiDKdt1?=
 =?us-ascii?Q?lygnfNGom+VvkpIKDR4FLmNYUx9zSH9enyEw/KYJEiqhxvo6o8E6PO5RlTwA?=
 =?us-ascii?Q?dljtEfJCSSfe8Gu02a6pvCGneJn9R/DakGxp0GfOh2BxKlzdFCxMLHXUw5iC?=
 =?us-ascii?Q?DZtFKqd7c7hto9u/DEZPvyY28VYdxnD/CSp+XvJ/CChBn8bVD1nBuIUZYgJZ?=
 =?us-ascii?Q?BVmY58rf2PUxNqix8BXBxKeErmip7o+gxWST5wOhyjx5JY5PXtTmHcCbeprl?=
 =?us-ascii?Q?YxcbOr8/1nnlC80NPCBzy0PHJ2XieGf7SbjoYjpX9f/M2lTqvpvkJ8N4j+gE?=
 =?us-ascii?Q?Bejqd60aV158YrOGb7byX5oqzEStBhoDw7kXF+JjKqF304flnNooFKoxyeti?=
 =?us-ascii?Q?bJHVxMd+nH3krcCwQWtvx2kvebgEZ+GJAsAopdA4IGhNKNLkEeezzP2m2I0g?=
 =?us-ascii?Q?12Hv6VOJ/b5vClLZBYKcgmOegCFZlEJI5KRtMbdJ14YldsOinpysx3Pttxn7?=
 =?us-ascii?Q?yVLbV5Ykhl1/f0Q5UMJ22dztUVE6Ztqgesc4Hz+75qbr6L/wNxZMzKMU2XKn?=
 =?us-ascii?Q?67Mhr9iLH/tOwDgchfolbdW0jTSIED6jsVgtVV4LXGDy3gJfg0YSiiNuy6a1?=
 =?us-ascii?Q?pmEv7O2rOBb3gxAi7AX//rN8TNQ0CPwmRtJgZJqGmYvj/foWOVxR2B5VEXvR?=
 =?us-ascii?Q?ZhFtWLZY9zr6YlzE4h7fbgCQ+VjfyDOT/WVJuHG8T/lgjhIyDlqMDuGgX11j?=
 =?us-ascii?Q?JqBelTVa92ZYSUPAmX7LmsrgBRYRwWtLcEx2yEvb4XTXzBT5ZsXNj/fdU/BI?=
 =?us-ascii?Q?SZX7haU3+aYJNg8bD8iwYG/JmdbfetybluKq4ydRRg48KGfDyR5Mdr5+L8dn?=
 =?us-ascii?Q?jUx4vp4UZjyKGVbpq+JJBpxUc4IwWvtjxD11ijg5UOKZ9N55nFrVXDQ1MAQL?=
 =?us-ascii?Q?kwYqDaunEzsDCXPomdWAogZMY/9x28bxL91rzA74zbnkvErwkwvMjv/H/DP4?=
 =?us-ascii?Q?tQogEnzxzST+bOaMyTWKSpEDxQXdp2PBHwT6kNqEMRePcbjpD0ieojwL+3G0?=
 =?us-ascii?Q?xgEmgULhqcd1BRZy88lk/FSxyMGEHoSIm3Lwhh/Y0JJRXW2ho+AqJKFjBN4j?=
 =?us-ascii?Q?WF2XMNnv3UJ3p3q8/vF3Rf2G0ypi1TtcYIO4gynYD+CRl5vcxIpvAe3V0Y9K?=
 =?us-ascii?Q?18nm94haeqd1KiwzK9cRXqiQ4/m13Q2v8B5r9m6uujCkD0rScJwHo/p4KATK?=
 =?us-ascii?Q?xJU7SwHgBROPVlCEtRQyWN6Rwm9VZqdXlNNfxwY0wV/Suq9TcryzP9jG4kMj?=
 =?us-ascii?Q?psBBGD+96Umw8mqDTx25Q/6g5G6Myz4V5fEOX6Fo5ePdfEK38Zlzdd1WwfSN?=
 =?us-ascii?Q?xVZPyYleW2hJfZeQdXdW2txXgrT5XyHa8LcAEECM403IZsdTIrEEFK4qcP/q?=
 =?us-ascii?Q?vNNA4MI2gIzfhD8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aaZ+OSq4tU27s+wwx4yU2sGJ9rpnIlV+rdkUiOhztruIaldjimzy7TF7rQAY?=
 =?us-ascii?Q?Tug3YPVTe77vuZITN8xAIKYD0YEFkVwWu49jHuDBsxIISz+FJbyTQH99koAb?=
 =?us-ascii?Q?mhj5wNzOpFz7BSm7mFWq6UaZswwvX7SToB+D8pFdY8aT8kEu0j5t0w+phY54?=
 =?us-ascii?Q?NhcQyUvVLMAluq4VkfaRmdHWeg/ztVy8iBXGgITt66PExEnt9DG9XDlFSmIQ?=
 =?us-ascii?Q?I2F1VdyRaNZgYsPuuTqZedn8V6xU709rc0mNoUWQW8ZFJR+TcGFHWQvUADuv?=
 =?us-ascii?Q?KpqYmoH1vnUaCQKnE1n7Q2y3CQW6SAAET/z4QmCN2AhBttoBASyG7q+ZgPqD?=
 =?us-ascii?Q?ovb4/V0sB24m/nGeoFRTYrb0La18FJyNTNlySTzPu5wXge1VpJpwckvm/XSx?=
 =?us-ascii?Q?NNWaCOW8UsDl4G+gqrU29ux0+/Ct+rYSd3vmJlYvcfZgqhx9L1ingfIZgYAy?=
 =?us-ascii?Q?Mtnn7ukmamYtP0NH+8HUPh2kfvIAnJfUt6olUCZYIfLPRMYgozM5IVIpDpa1?=
 =?us-ascii?Q?OwEiFjJDWsDI/siKEZplVvt7Nx0Atd4To2sg3LgghZf0tZOMLYULcTiia9mB?=
 =?us-ascii?Q?ymcrdG3y61Njy3WDGGYBuw/Z4WwDQ5qnbso0kMt9pn9ZaMuQqi91kABqaidN?=
 =?us-ascii?Q?U8BzMlXq3Z5o3cuCAmgfSQI2MkQrIen6GGOsl+T3RBZIe3hCLKThW2VgbXfn?=
 =?us-ascii?Q?qUEk79WskkTB0dhG4dkJsO2HDMBYc5srdJHK/XrQoPEjuDh4j7h5Xz7jpWdD?=
 =?us-ascii?Q?SfAks5eOaXsfLJ7Y3480d78ds05fHg4BnK2D7xGexwYMVFhtQ3JxPjlPBUnH?=
 =?us-ascii?Q?0pcF+7cp9PVLMy3P63jdZkCY+1xRqvj9lGjg2A4YvwqMAzYGnBh/RYxLUr4Y?=
 =?us-ascii?Q?8eT+tXCtdMjqEKyf9MWllhrqdtI2V/wGB/4FleJgcCQ4jC/nvm22uqIiY8/L?=
 =?us-ascii?Q?kF/tJZzrGzaQB8Ok1rxHJSGd7jhgHZ7ZIiEBNOLyHcDkE645c2H1cJv7C3Zp?=
 =?us-ascii?Q?CnKDCH4KXp+RGgurIrC4veTMKkjHmFZa5obDd+g2lyAxUXHShCOXxDJpvYb0?=
 =?us-ascii?Q?qTEkEICX8LRFw8T4gbndNzOwh0SBZXY+5Z2JgpEf6ZDP8dAsUle6Hot+Zame?=
 =?us-ascii?Q?REaRGKqUtZynfkMUq0UxY/8GyhYwtxMhlePU6ahH73TcNDNdVP6zMQrixRro?=
 =?us-ascii?Q?rpZZ+8DqMt3HPE3a7Uv+yb9ZUw431g1PRmg32LwqRErX+LaCsn6czeN98iN2?=
 =?us-ascii?Q?aDB9V+ysmZbdl88wkm/QptMdDBX6bYqDBOKDlxP5xEqg7ytT+J0d/ijdqbFd?=
 =?us-ascii?Q?dnepvCssagqSEdo4xv3GOEs9mEPCSYATK/v2j2JPSmqrHKnNxmsD68lbwqjx?=
 =?us-ascii?Q?mc1AJTWgWNFUA/OhuL36dCJN3KYfcfI4oi1cAK9DqBcVQT7E1uiPdOfaW1HV?=
 =?us-ascii?Q?PmOX11ZJEUiqwcnxGrgqH229rOx/PxnvV5xIp6t9vMPvh+Oewg9/JpoqfY0s?=
 =?us-ascii?Q?ndnlY1R5wJhr9fBDmeOpnzBbwimheDH4pAD8dvEb7VL42TdC+k+uEMVxOVuA?=
 =?us-ascii?Q?IuzWClD8w5U3ic03z8p09QA3gppgiywd5+Gfi6xm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9465d7e-a754-46de-99f1-08ddbfcbcc88
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 16:06:59.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FC7HlmIiK5TXG82U82KNXyY9lew3MefCZJfTtEQfN0uO/Mn4Xsjb9mRKK7mj8b89KLwNvgCGxUN8IOrUhWuYig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11317

On Thu, Jul 10, 2025 at 01:40:25PM +0200, Niklas Cassel wrote:
> Hello Frank,
>
> I tested v20 of your series, but unfortunately, it still doesn't work.
>
> When enabling the doorbell, the programming of the inbound iATU fails:
>
> ## pci_epf_test_enable_doorbell()
> ## keeps the BAR size, and BAR type of a BAR that has already been configured,
> ## but changes the address translation for this BAR to redirect to the GIC ITS
> ## rather than to the memory allocated by pci_epf_alloc_space()
> ## (does not free the memory allocated by pci_epf_alloc_space())
>
> [   39.347502] pci_epf_test_enable_doorbell: msg hi: 0x0 msg low: 0xfe670040
> [   39.348103] pci_epf_test_enable_doorbell: base: 0xfe670000 off: 0x40
> [   39.348658] dw_pcie_ep_inbound_atu index: 1 parent_bus_addr: 0xfe670000 bar: 1 size: 0x100000
> [   39.349403] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xfe670000 pci->region_align: 0x10000 IS_ALIGNED: 1
> [   39.350260] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xfe670000 size: 0x100000 IS_ALIGNED: 0
> [   39.351028] rockchip-dw-pcie a40000000.pcie-ep: Failed to program IB window
>
> ## pci_epf_test_disable_doorbell()
> ## changes the address translation for this BAR to redirect to the memory
> ## allocated by pci_epf_alloc_space() (which was never freed when enabling the
> ## doorbell)
>
> [   39.351656] dw_pcie_ep_inbound_atu index: 1 parent_bus_addr: 0xa2e00000 bar: 1 size: 0x100000
> [   39.352401] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xa2e00000 pci->region_align: 0x10000 IS_ALIGNED: 1
> [   39.353257] dw_pcie_prog_ep_inbound_atu parent_bus_addr: 0xa2e00000 size: 0x100000 IS_ALIGNED: 1
>
>
> The reason why pci_epf_test_enable_doorbell() fails is because of this check:
> https://github.com/torvalds/linux/blob/v6.16-rc5/drivers/pci/controller/dwc/pcie-designware.c#L663
>
> If you want to understand why this very important check is there, it is
> because the DWC controller requires that the physical address programmed in
> the iATU is aligned to the size of the BAR (BAR_MASK+1), see this commit:
> https://github.com/torvalds/linux/commit/129f6af747b2
>
>
> Applying the following patch on top of your v20 series makes things work as
> intended and makes the pcie_ep_doorbell.DOORBELL_TEST selftest pass for me:
>
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index dfdd25cfc003..7d356b0201ae 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -738,9 +738,9 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	reg->doorbell_bar = cpu_to_le32(bar);
>
>  	msg = &epf->db_msg[0].msg;
> -	ret = pci_epf_align_inbound_addr(epf, bar, ((u64)msg->address_hi << 32) | msg->address_lo,
> +	ret = pci_epf_align_inbound_addr(epf, epf->bar[bar].size,
> +					((u64)msg->address_hi << 32) | msg->address_lo,
>  					&epf_test->db_bar.phys_addr, &offset);
> -
>  	if (ret)
>  		goto err_doorbell;
>
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index c21d8e786eb3..b3d4117182e2 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -478,44 +478,36 @@ struct pci_epf *pci_epf_create(const char *name)
>  EXPORT_SYMBOL_GPL(pci_epf_create);
>
>  /**
> - * pci_epf_align_inbound_addr() - Align the given address based on the BAR
> - *				 alignment requirement
> + * pci_epf_align_inbound_addr() - Align the given address based on the BAR size
> + *
>   * @epf: the EPF device
> + * @bar_size: the current BAR size
>   * @addr: inbound address to be aligned
> - * @bar: the BAR number corresponding to the given addr
> - * @base: base address matching the @bar alignment requirement.
> + * @base: base address matching the @bar_size alignment requirement.
>   * @off: offset to be added to the @base address.
>   *
> - * Helper function to align input 'addr' to base and offset, which match
> - * BAR's alignment requirement.
> + * Helper function to align input 'addr' to base and offset, when dynamically
> + * changing a BAR.
>   *
>   * The pci_epf_alloc_space() function already accounts for alignment. This is
>   * primarily intended for use with other memory regions not allocated by
>   * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
>   * address for a platform MSI controller.
> + *
> + * Since this function is only used when dynamically changing a BAR (i.e. when
> + * calling set_bar() twice, without ever calling clear_bar(), as calling
> + * clear_bar() would clear the BAR's PCI address assigned by the host), this
> + * function must align to the current BAR size, since we are not clearing the
> + * BAR configuration.
>   */
> -int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> -			      u64 addr, dma_addr_t *base, size_t *off)
> +int pci_epf_align_inbound_addr(struct pci_epf *epf, size_t bar_size, u64 addr,
> +			      dma_addr_t *base, size_t *off)
>  {
> -	const struct pci_epc_features *epc_features;
> -	u64 align;
> -
> -	if (!base || !off)
> +	if (!base || !off || !bar_size)
>  		return -EINVAL;
>
> -	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
> -	if (!epc_features) {
> -		dev_err(&epf->dev, "epc_features not implemented\n");
> -		return -EOPNOTSUPP;
> -	}
> -
> -	align = epc_features->align;
> -	align = align ? align : 128;
> -	if (epc_features->bar[bar].type == BAR_FIXED)
> -		align = max(epc_features->bar[bar].fixed_size, align);
> -
> -	*base = round_down(addr, align);
> -	*off = addr & (align - 1);
> +	*base = round_down(addr, bar_size);
> +	*off = addr & (bar_size - 1);
>
>  	return 0;
>  }
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 0ca08f0d05d7..bcc8184325d2 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -242,8 +242,8 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>  void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>  			enum pci_epc_interface_type type);
>
> -int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
> -			      u64 addr, dma_addr_t *base, size_t *off);
> +int pci_epf_align_inbound_addr(struct pci_epf *epf, size_t bar_size, u64 addr,
> +			      dma_addr_t *base, size_t *off);
>  int pci_epf_bind(struct pci_epf *epf);
>  void pci_epf_unbind(struct pci_epf *epf);
>  int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);
>
>
>
>
> However, the more I think about it, considering that this alignment requirement
> is inherent to the DWC controller (other controllers might not have this
> requirement), perhaps pci_epf_align_inbound_addr() should not be a function in
> pci-epf-core.c, perhaps this function would be better suited to live in
> drivers/pci/controller/dwc/pcie-designware-ep.c ?

I think align to bar size is quite make sense now. Even other controllers
have not such requirement, align to bar size still work.

Anyways, it need be align. We still pass down bar number, get bar size
in pci_epf_align_inbound_addr(). So we can fine tune algorithm in future,
such as add field in epc_features.

Frank
>
>
> Kind regards,
> Niklas

