Return-Path: <linux-kselftest+bounces-49413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A4BD3B80E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 21:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A93F307E7D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5D92EC559;
	Mon, 19 Jan 2026 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SenV1dFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14F1F4C8E;
	Mon, 19 Jan 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768853374; cv=fail; b=g3fjRRmp375BbfCL+6j30TFFNXb+fT1ngZT2IPx1m1tUCVfup0Cu/8azfLf98yy6ZRrmb11v0uDn5voAkVwSB5yrBAwQUhiC5/FH4mQUYol+EU+XNM5X2gKPvdeR/Iqcws9yPVELoA8Wjhe4TKsDa5v3kR9Qwx/odNAVR3H1FdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768853374; c=relaxed/simple;
	bh=o8OIMf3O7Gu0rltn+1tdNcyDEaUnzfDBOhulK0sq5mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D72j2lHmvZgneHLZzUkMGoKqsmT3FrmuZJ7yHXdQf0hIxBdnEs6WcWtwx4IwJeioGNDc9+5WdGrD10pO/oWSgpLVsAx6nU0mkIKNBdBgP45KNBrf9IZUu+wr/W3S63VZV29rSPssQj3pyDfEM7xyok6DmhnqpCId7pvr3MwMugM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SenV1dFc; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B55ksdAzBozWhG4yfUt6WnMZea0O8IctJYfgDuh0rvh/9Lg0a4SMA4S0yV2XQe3Yre0DXxeLop4crQXJVUHtB8oMe8cPAg1bGkFlKcjaFZpMTKulxMoWBCkdTOsuKz7ySixFI8vp9UO6nwIcKpsosB6gmuiKUWawHSQ+L+Hy4l9O1vFE85ZMynCgjWllCmoORrmfAiy5uSrG1o3fk4PhsBKH5/Ffg3zzuukYDaP+nZYCw+XuMa9/EwZgSo9Od1g4WKfpIeFC8ohT2d4uv1dtedNmG5yWJzxyxlD8vHGDyFLz9UK42o0zGqxEjGj/P4MuNkoaVwXzYRoe9XZlp9hryw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0AuOnnJfEzDGuFgqdgKLOfVyzq67PZslr8FOjKGvtg=;
 b=bQ7oBEmhP7QnQQloRUQxPxxSuV8l3GDQZFJXP6ZAXb8g3nnOf4x5vtyL5+OvlR14C9XxB5WvOXtuZTke67+f/p2zg7/jKgR2om3A/njPKCfaW7MUumqScVnphz0XgGWd7/x+JCBt+c1hApsw3OUxBqO9wMBErGuqwfBPLqY4L7BNn0RdsQotrPJ4vDnNKuhdmj+yBEOeTmQQsY6SGPEe1gC7qu6BFo3pMkukTxVAHDM6+2x2SesT7Mmmv8b4yJZwYwiHgWW3UEacayBSNW5djmozSyc3gtPMWYKhjZDI3ukFlGmfF4MrnTysEI7Kr/S8g5iB7zvDGRnTdKs1D6zX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0AuOnnJfEzDGuFgqdgKLOfVyzq67PZslr8FOjKGvtg=;
 b=SenV1dFc9OrGyGlzfS9yvIMP+3GA31XA3u4Muy+56/XZ6PB0CT4xO+mllVe9CYHUG3mSsShXk6h4jttfatkUbOYEafRCM8o0CPDKtiWTuDAACLCa1w9zGSL+RFjkoTXaQrSBdfd0UXCm61SRSh7TqOWCA2bp0ijf7DSuHr+On7JceFraPI1k/oX/oSVaRUHabyqKQYQli3uxlxgPOlLsSXTDlDmB/1yQO2jsUhtct7ER1IEnaf+dUlaL4P3tfdqKoHoWhki/b55D93cr/r5B9cMIF8F79waZsk60kCy7ex0XLc/BQ59LtXDlqMDUADa9L2EBhbFjGJhh7Cbodz0tsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PRASPRMB0004.eurprd04.prod.outlook.com (2603:10a6:102:29b::6)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 20:09:28 +0000
Received: from PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd]) by PRASPRMB0004.eurprd04.prod.outlook.com
 ([fe80::6ab3:f427:606a:1ecd%4]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 20:09:28 +0000
Date: Mon, 19 Jan 2026 15:09:18 -0500
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
Subject: Re: [RFC PATCH v4 11/38] NTB: core: Add .get_dma_dev() to ntb_dev_ops
Message-ID: <aW6PbmKpYVxHrnJE@lizhi-Precision-Tower-5810>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-12-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260118135440.1958279-12-den@valinux.co.jp>
X-ClientProxiedBy: SN7P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::32) To PRASPRMB0004.eurprd04.prod.outlook.com
 (2603:10a6:102:29b::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PRASPRMB0004:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cfc24d-4a19-4139-cd16-08de5796a643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pp6LRJxr4HGs8CXs1ZhHCmrJHi7Vk1At0Y5D5XUbjImPsLtVhTz1oO8HaEus?=
 =?us-ascii?Q?W3EOJclJjWQOXThS7JJQoxhKMupCzcHG3kCMoilk0BBE4P7IFqCrD5lmjqmJ?=
 =?us-ascii?Q?05wYUX43yyCpW84cKYRqdGLyaDn46bm+OxBTgEhg2YV08G/pWp+ZSYrgqjdP?=
 =?us-ascii?Q?WDtY0/K5jGxlog+iBWq4EdCJgvp5Km74skfcF/4vs83hLnFzc/w65pZIPmbq?=
 =?us-ascii?Q?OQL4BJ52lMZj70YK6pMFX4+PNxv2AYdyxoWHGObIzVlAaFg5gAJcW0AMXVD3?=
 =?us-ascii?Q?ShqGSqWjSBC2I//wGfafJVtyhwHvdR/PhkQpJNhO1/v3qRuTKVGmqUvAxj2S?=
 =?us-ascii?Q?SZ+ydXEmaTWTm5UlSdXtIh9PdwRYr301+McKQgWSxy6JkjvxGF9cGQFvkPq/?=
 =?us-ascii?Q?rUIoMNV2n9xhJHee0R1bFxjDE0obdD8aIGBrKT0lPTZVvPhFTKzvFKRa78ug?=
 =?us-ascii?Q?NyfQAeGQzxL1B7JnpbDFBQXo27fxrjgf+KwHM83wE1xpbVtp4EoOnSQL/lIM?=
 =?us-ascii?Q?1FTC4WJkb093AL6kKq5EBWTNXQRlA7XOKAJjjh3p/Sk3C6JYLqYn2WNl2nZ6?=
 =?us-ascii?Q?yv5UZxMbwweQ4XjewsvxZMB1Q6m7X1LaeKz01XB5SrLTyy3OD0E0CwyjkpLI?=
 =?us-ascii?Q?QN9XF0xGl37sD9S1h7BgLHJxWPyIHADKZ76PHAN9wt/PjQsbcFKYbHiQnwLv?=
 =?us-ascii?Q?k8cRYdohmQQaj0UiKLPZT/nrp51TQaRv+qjCEVCX6P69Kz9x1I2BmeVMPGhz?=
 =?us-ascii?Q?KfXs4HRh9jMLMlcS/M6ihnLJlTc+6qFV5kU5cIL/6loxCQPlsFZOoa7ShRHQ?=
 =?us-ascii?Q?yboq+XuJCFyrMnfRXdbMYUuadGLDejYRr1RslO9fNwD0WPdNmQc9IYMhNFZl?=
 =?us-ascii?Q?ZhE47O1IDWr7Ui0wQZrDV1+BTaDtJtfVmfxzLTlcGMeu0p8b6Vj32WtObah6?=
 =?us-ascii?Q?5+GenzPXWVIrCWkM1CzgBjUFYPoV/g0xRXS9Agt42ccg4CDrcwwAPR0SgHC7?=
 =?us-ascii?Q?TVK4zZLGoSUSBTalI5aaJ8A1nLzmEp5iWfvKedAn5QGY2Y/AOHfyVY9pDE1r?=
 =?us-ascii?Q?QzgRnb3IRFtVBdw4GMl0DmiOU1e6DyDKWDRcYmrdNw+O2XdYCbTtDdoPPWOc?=
 =?us-ascii?Q?yqrgsehPZCjWty8zDFD/C3QfXWSG7ZLnNMgfqrOEwYNhVrGsDtNP5hzLannI?=
 =?us-ascii?Q?HPEpvfl3J5eQICJYYmyN2UVX9AOV6OuZ61po+pTXsNu6HnziGO2ihY6ILNxr?=
 =?us-ascii?Q?yFxmqN7JnD/fJ48pEitQglkZa+nisJwy0pD8rXCZjJPIV1Sb+xAKZiF/GHmX?=
 =?us-ascii?Q?YsgWwgwku4MrKkxVomAJGh7ePWl1AdP24ec5niQw2esaRy/23pe3FNV5H8nC?=
 =?us-ascii?Q?pk9TTL2Q2TNNT+L8ytciECwz9tmThPYIGuqL1keV0icQpIyJjTyt56rbf9un?=
 =?us-ascii?Q?RYajxoLI7C0fi+1MTgfAmIq6wDHEg08DPZJC50HWw5D6m6rVWb8iHR2Ujz1C?=
 =?us-ascii?Q?BkoSn5uXpm4oFZRlLV75aeIQfI2xAIFocmNloBu+yqOOVSWofjsB/AVtqZWX?=
 =?us-ascii?Q?LJ9ic7/0an0ATFV3vIEQhs5V45OAgaVEK/G6yFeltudzgE22qn6yU/67JWLU?=
 =?us-ascii?Q?Z1cCjh8nk5eMX6FNS64o1uE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRASPRMB0004.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bnKiijvtVMdNeDaaaEHQLW9nwfEe5+Uw9RxgkKBV832EKBVVeko1+w1dLGYh?=
 =?us-ascii?Q?lIOo1v3e+0YwTGFlalyZ+j2SSFoKsIrr2+Am3L0SIrLr2K7PIej6y/U2XduV?=
 =?us-ascii?Q?z/EZSSlra4wERqe4yesmOgo8dqQEPPQ7FNgi3ve96tUebbB27Gyo23ymRfqp?=
 =?us-ascii?Q?0PLKilaS4uOMbaODMk6SewOtp2LqacHnJfUWLXLyqqBP9MxBNi6TQTz5ogqR?=
 =?us-ascii?Q?pMf7MNUulMOid9LA4ZMfHlWwB/R3e+GBjpKytmGskZXbSfbspsmetFZDmh9W?=
 =?us-ascii?Q?eB5wRE9Y+1g9CCQRa3MYipm+c1Kh0O/uAunn1w2ZSJQSDIuXIv/QQDB3oPP/?=
 =?us-ascii?Q?CaWNvOAnMUzg8BZlgtNzol5WHvfDvHVTjIXki22VXJUAEjKSUVUPAUKGMt24?=
 =?us-ascii?Q?+JErWugqkE5NVBp9EhF2bCITp1K+qd1c5PWGY5vE7W0TPBQfLLQstCKmglfa?=
 =?us-ascii?Q?YJ7BI8olV8PGC1nZGXENR0Q0IiyVZUUzHyzUs1Hb17o8u7OIG5dSAbXSP6oP?=
 =?us-ascii?Q?nv6da5GdsltIw14f3+3trKHh4B5orqcpIWN7V4vAorhfIZCNUOju4BDz6i/A?=
 =?us-ascii?Q?DYrZ0UnWsKnPWMEaDjuzoVO5+XK18LJ2UQZyCIZNOYE9bBBuCYp0LqbAsUAq?=
 =?us-ascii?Q?TpbP62ari+EHoD6dZouU96TbLWKgY7icX32+jDGqTK2gKWaWLKUI9Br3hWis?=
 =?us-ascii?Q?5hNxlZMASHheYWmd7kQLIhABxpKPDfDb2Yr8N1Cp1JzDiz2WrGT8QLtugm0Q?=
 =?us-ascii?Q?8JH33LE92/b/WalEyiTMuol2M8FmCP+XN11u1KqyGN2spXGzPaEVjBg5S8Ek?=
 =?us-ascii?Q?Ok9H21SsRmnrD44lizWe2+A6mrJJ75NoRilmBj9uzV/z9RkvAUqTZ8yz1iG1?=
 =?us-ascii?Q?28rbTuDvhOJUgWHsSWCWKUTvexbsj97DNdZXQ3rqbCVKCNe3GR8U8gzvPfME?=
 =?us-ascii?Q?4sEGqsqVOWSUy7KZlOrOuL0SWI1fCcllcRtEOUDJsA5DVfA0NxUFMlPtD5m+?=
 =?us-ascii?Q?J1yeOYGCQQQzYLAxLRNRC3n94LbRDBCufe+QjQVnl/LkJyJOEiP4MwxM2NsM?=
 =?us-ascii?Q?xHlZId+vwgpA4DxG6DBDsYCSRC+I6tu7V4vEWsfw9in4y0W0Xg3mGmox/wiY?=
 =?us-ascii?Q?gNX9niALaljHsGdU8gL1LNLtyXWPOD8iVt3q1j4VzTxLlldptCCmzV56w2y7?=
 =?us-ascii?Q?X+wJ4zvhEtEzORBbOHfLeaFe5WLDaVZJQ6Y62uW5sKI9MCDO6DesSjZNeiM1?=
 =?us-ascii?Q?zdMvaiARBd8jQSG3EbrzY8B8/YZwpA/bBUXDtHe6tZjWKirqDTu8GzXev/Ab?=
 =?us-ascii?Q?8UqkTfu8iclmShj/GwcrWhYXN762rWQRAC8pFffm4JbrsuNXe9A7nqM2y0Ls?=
 =?us-ascii?Q?I4JkrzscX7oNNz4CG+LzYPJDUnDUfHMqWgYPy7q0R8Br7EQEeCjf/NdKnMOT?=
 =?us-ascii?Q?rovzSTuooxJWGoUCR61zy+bBlr7Q3Pbf3U8lS+w9O807BAQ0nq8oynHE1IfC?=
 =?us-ascii?Q?D4t4Hf+3zseLn+BdHwfQc4pNsy0bdf7qWlm8GdPa2oR5MHHR3MBDgEGDqmBa?=
 =?us-ascii?Q?zXPN9GcBBGd63qlmN17Ja7rOW2a+ZawuMUFtqgnKwcmjyg/ou8sQ+0AzRqrn?=
 =?us-ascii?Q?olPGhPRxbaLlepS2WlmF2NCZK3YNsnzYyHRAYMJW8GMB5lQplD1chUqOb2+n?=
 =?us-ascii?Q?vhWLjsTseGdUbs7ClEjr3ZlGFi4xGqRl7GPtj4jyBxKYG4CU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cfc24d-4a19-4139-cd16-08de5796a643
X-MS-Exchange-CrossTenant-AuthSource: PRASPRMB0004.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 20:09:28.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fV7vpciDV/igIivPu7AVOvhvRmN8PXAXZnK+7RMtw2mnnqIA34SrfeTcU8FXKf4ILUea6hpYM0OqgKS7n3vhUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234

On Sun, Jan 18, 2026 at 10:54:13PM +0900, Koichiro Den wrote:
> Not all NTB implementations are able to naturally do DMA mapping through
> the NTB PCI device itself (e.g. due to IOMMU topology or non-PCI backing
> devices).
>
> Add an optional .get_dma_dev() callback and helper so clients can use
> the appropriate struct device for DMA API allocations and mappings.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  include/linux/ntb.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index aa888219732a..7ac8cb13e90d 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -262,6 +262,7 @@ struct ntb_mw_subrange {
>   * @msg_clear_mask:	See ntb_msg_clear_mask().
>   * @msg_read:		See ntb_msg_read().
>   * @peer_msg_write:	See ntb_peer_msg_write().
> + * @get_dma_dev:	See ntb_get_dma_dev().
>   * @get_private_data:	See ntb_get_private_data().
>   */
>  struct ntb_dev_ops {
> @@ -339,6 +340,7 @@ struct ntb_dev_ops {
>  	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
>  	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
>  	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
> +	struct device *(*get_dma_dev)(struct ntb_dev *ntb);
>  	void *(*get_private_data)(struct ntb_dev *ntb);
>  };
>
> @@ -405,6 +407,7 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
>  		!ops->peer_msg_write == !ops->msg_count		&&
>
>  		/* Miscellaneous optional callbacks */
> +		/* ops->get_dma_dev				&& */
>  		/* ops->get_private_data			&& */
>  		1;
>  }
> @@ -1614,6 +1617,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
>  	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
>  }
>
> +/**
> + * ntb_get_dma_dev() - get the device suitable for DMA mapping
> + * @ntb:	NTB device context.
> + *
> + * Retrieve a struct device which is suitable for DMA mapping.
> + *
> + * Return: Pointer to struct device.
> + */
> +static inline struct device __maybe_unused *ntb_get_dma_dev(struct ntb_dev *ntb)

I remember if there are inline,  needn't __maybe_unused.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> +{
> +	if (!ntb->ops->get_dma_dev)
> +		return ntb->dev.parent;
> +	return ntb->ops->get_dma_dev(ntb);
> +}
> +
>  /**
>   * ntb_get_private_data() - get private data specific to the hardware driver
>   * @ntb:	NTB device context.
> --
> 2.51.0
>

