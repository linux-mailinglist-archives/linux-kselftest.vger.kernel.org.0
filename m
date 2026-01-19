Return-Path: <linux-kselftest+bounces-49371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 587E8D3AC08
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E76E300E402
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68758381706;
	Mon, 19 Jan 2026 14:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="g4c+qPr8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020086.outbound.protection.outlook.com [52.101.228.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3821D37F758;
	Mon, 19 Jan 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832774; cv=fail; b=NAN/RO0k4FsFaJuGQ7k5AJbA6DxSA8iXZ9hyaeDaZeIgrl8lZD+mDVDfGwbgcM9t6+uLZAy9nDYVMuT0yyp8zxtoOZAkV1gujGgiqlcRQxUwHTtxZ/9q/NyKE6/7BG6vE/54EK8MdZ+1/tdckhwlrhb2nelBwOWpWbj0DbaWu+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832774; c=relaxed/simple;
	bh=8V5CVy6zxPK7/6p705xwNUF0d1G0kZ8h44TMBUFctbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C4xGZjExOnHe7pcKdCFkl96nSDTcB9rXAMkR3YTgp7ahU3DlGSA1BRY3rLKDoRASZ7tYALY9xSIqy13OkHdECIFbDS/l35D8bH3pWu3xO9FQjdMGK+d1LyWuQ9ks/m1P/jaCbxxew6F3kAUK1/hBQcAYD1/eoSZRUnpws+RHaAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=g4c+qPr8; arc=fail smtp.client-ip=52.101.228.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGgB958awNyc9wj3aIgBeyWGJVmjfnC7M4NjECg0Dn/gdLKZESGnvAzLmkbCXfZ/QjMf8Dl4svj8ZKUr3grBhwVDmssbZPzBliyrLLzoq9W848tjMDe2JEGpMbemRVyHwi22ZsWyHItepXQMukUoI445ifC9t09wxIxQPCHgaLP82pswvk555CNPDRXY6e1H1bv32wiK0W1vIGFFm4sayk21fKUhF/6LzOlgNly1l12NQAsoquBg/OWSH0lqw8pSV/LP9l1HJWH4hIb2jopS4S8tisRgBl9V1dtdsfzPJokD8/N7pqgeupb57X5gudeRbNtG6OqzTrJ2RfLH+xgYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dmCVqVfrLMuyu/e7T7PlL2WRqQRL1y4+TORLRr1Cxc=;
 b=ahO8lfmjC1a5GvcbxbXmZVjqQNlSsWmXpgUIoJu91hY2DzLgAviImXePQRYbLLOw/KX+ga9m7tXQVr/XCAOk0YDnCD87du4JZaTVcbQRWMyyXjQfRDrjJvOVyGgQKKQG7Ozw2RTUNHtk9NO6UrLvOTNHHJCpTNWYG5fc7fsJU3+lMiHWlruBXe8DuEvWIPwelPnP79OmIbc0FvwN3zmT1JJsxeJDgzTg1Rf94PXmqVnU3kmvztFzRn8w+NAEoGeUNZZdUCIbSWryQd9pYpe0nkjyD/30mrPHL0iAXG4C3pFbYwQsUihXqSPdlzUqbl846ByRmwV/LED20CNzMNi+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dmCVqVfrLMuyu/e7T7PlL2WRqQRL1y4+TORLRr1Cxc=;
 b=g4c+qPr8YdEhIXf+zWNmKz8faS3LOFT+KB4Inf85gwNvio9RfeFMqE1gZkWFgsPoYkW7BygXLEUa9TdTl5BEm+OG7XaK4sq8WhbzuQY3yQcPxDOT7LhBFrLpnR5UnIjY7lFqVKxA5vkTGmdt7kINzoQmC6QqFdyYkhIXxfsWNXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSBP286MB5934.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 14:26:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 14:26:08 +0000
Date: Mon, 19 Jan 2026 23:26:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 02/38] dmaengine: dw-edma: Add per-channel
 interrupt routing control
Message-ID: <32egn4uhx3dll5es4nzpivg5rdv3hvvrceyznsnnnbbyze7qxu@5z6w45v3jwyf>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-3-den@valinux.co.jp>
 <aW0SVx11WCxfTHoY@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW0SVx11WCxfTHoY@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0112.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSBP286MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: d298c667-25d9-47a3-46e4-08de5766afc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWLlJ0dItonc4sKZ2ZdurQBK/LuXLbxbvfWTNjO6R2ApkXSzbKXWv9Ia5zk4?=
 =?us-ascii?Q?K+5Ma66UV5FCmi4nNCZNkVKOOPnDjlQYIqrJLjWQY9O9ZVNRD3j3+bVWSMKj?=
 =?us-ascii?Q?BAqsOu7f7irCYgeXlys92WrhdGDMXACONBwQElpmplgW2bXkACL88OwUgBvB?=
 =?us-ascii?Q?M3Yo2hEi1M2P4QHIT1ascn/FCvBBidcFQu2QGK5rVHIZVETKZ1/JHJV7jVNF?=
 =?us-ascii?Q?7aCzmtRChor1ESVD/fItXAfGLitcn+T6ocf7swAV6b2QmZNBJFrwZDz67ToT?=
 =?us-ascii?Q?oJnWjCCsH9SX0qWVA6iaiV5Em/e2nTOQqw5+yZaf/1zggszjPASInH+aR7Ag?=
 =?us-ascii?Q?HKVQ+rFb384x8lXeGSUqlFS6xBsSh+y51WRLp6me/MDm1k6cX4VTb0cGPE5q?=
 =?us-ascii?Q?BWedt+My7xAfsvvEt4CvfnA6nR8TXD0lg+drfyQlf/od5W3DIsVC65BkKAhT?=
 =?us-ascii?Q?UwMhsoi2zRuxO0/Zi5+irwWbEGccO1BJ3Ad0gDwIxA+Iqa079PwH26NNnoa6?=
 =?us-ascii?Q?I9V/nHSlEPT0J9coBJ7aUkGlz5pIm7fJe34ANxfzGTQ8u+WJ4lBJTdZRTpKj?=
 =?us-ascii?Q?Qt31iMU7LG/sIbmoiP1zjEhiREYc3rDcrtEG2xMZYBzYTiM3MA8IZtJD+mjn?=
 =?us-ascii?Q?GsipG0GDgT5hCj1Gb+vJjunQEqJ9v/9P9Xa9HNULFrmwBUSOaiC5iZQR4ZMM?=
 =?us-ascii?Q?9xTRU6s5CIipxQwQMKaHWBxmX56/K8XRK77lpnflRrn4YfGawrJPaAbmhT30?=
 =?us-ascii?Q?6cd7ETGbcyEA8yUNM68OIxuw3dWhYxFNQZByAnwSTBc40+VELe5DJmLdMDIR?=
 =?us-ascii?Q?ypDfaljHxriAEZLP5uTD1IsDd2DGuycHF15ktfj7Jx4ytcd6a1yahajg2fYj?=
 =?us-ascii?Q?nD/+0kw5dWf3ZglulHUGmwx/K4ouVg7ieq+F1gjrPM4e6/4rKbYMw2+QbaKY?=
 =?us-ascii?Q?jgWI3GDDmo5mC38brM0TPV+ft9bbAAHMqruaOUtRsM5OI84jDt+xv7VfGBLy?=
 =?us-ascii?Q?AIAdDvckJu3PxleVpHMPsXdod6AcyYXgwTRdU+xZ2Lol/FnVorozMnUenpoN?=
 =?us-ascii?Q?e2saN7JBX5lvogFJEAki11uqf7cEIruyFIVE5UkCbTSK4DNvMkku7XlDqnr1?=
 =?us-ascii?Q?z2ZKHZQmYdEKSPdk8+JIBhE0SVWbRmdGVL8JtxgegAdPOwBCdQsoofRYcgva?=
 =?us-ascii?Q?b7RRodQVjR9ItoVfuMsUGK3SaKIl2j4dAU5PCgwosmXJO+FPGNEVWpS80L2S?=
 =?us-ascii?Q?SRC0+qhhKSvCrCVUIo1gjlr+/U9QpteD6rnzReh+l64ZP6sqKFWObjHUBW8M?=
 =?us-ascii?Q?a0jDg47BgAj+gOaa2KtMu02JtQKwS5RtIeHR+3hL19ZmvyWX5X/nHK+l9Emu?=
 =?us-ascii?Q?KgPTorddaSYlU2Kp47LYs4sYxCs4RYv9Ume1LjJYrFBM3jmKOGTOEcIvN+vj?=
 =?us-ascii?Q?xLgMQ5B/PfYPeeJYCXdFcFejJi4oykGNCmP2zbqy4s5gEFQ/z9hLuOVTrDRt?=
 =?us-ascii?Q?3FbzvdTJeyx8WLF8HzhT7PZHk7bOwBK9UUPyp2BArA/njAaDtYFPO9u2RE5P?=
 =?us-ascii?Q?iLtqiesmR7+dK5HXFAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PekQhaW4cJP0sXmwwDUgIPsvmI+pfMbGnGuLkj/Yb6htpUIMsQLt8Jdrhvd?=
 =?us-ascii?Q?xGn4PmQwGuWKTaXudBs5FIlGzU6VAQJpUA/ZPIgvC5Y9sxVTx7jgU/oc1QuL?=
 =?us-ascii?Q?q7DCdWD0nTIcdRXmbmnq5J9An684QOU9tnPcr9UyXJuvvg1A5OeMViQdY7fV?=
 =?us-ascii?Q?nV3yIhxFh0KebHwXVPh1kfGdZpt+ElWQguaMnxFNOSBfkXNkkOul6NGc4MJF?=
 =?us-ascii?Q?VZDNQmnpxz79NBFfUoHpTfvh4knV9+mOla2DvD2O9F4CAzxp1N2v9jc5cJJk?=
 =?us-ascii?Q?ucFcki04Oj9sbBfSGoVvUjrkXVw26tapZ8GCT5ZDXIktajU743GWcfxuLmNO?=
 =?us-ascii?Q?BwgG/UYQpDdynSIjGYGD6mXO1VzYAqX6Sb8fB668lEA2ALo/93SS2CmooTTE?=
 =?us-ascii?Q?kfcQEf2bFgHN25LNWwAfN1xa/VDXH2t37BN1EvmEWSZmnUfSp/Ej/HI57zgr?=
 =?us-ascii?Q?tefq0nnCWf9trvGbJmrRlHDfe3Q4bFKRqLGM46Y++xdNLCI6JuJ1smC3N3Y5?=
 =?us-ascii?Q?WrljrXtUXp6Qr/0Sry4X1MgsMICSeGwybtvq9h6Zmpj7EaAEg/d1bah7ZDDx?=
 =?us-ascii?Q?R5Wb6PcOyl70BMkjhfHVh9rNZVXAB1T5RdwChiScw+NTtE9HEj6RBZhHdTqk?=
 =?us-ascii?Q?kiFOmZsrI6j1i8G0n3yZQA78RfYjCR4WdKdc9vZUpzl0x4mQEeByGLxOQQ3/?=
 =?us-ascii?Q?atNyh+gLwzIYwR8OHwxYGybEDQODq7IjNTpbglvqSfydBoyudluDyQ4aPH8L?=
 =?us-ascii?Q?WmwuOT+ov/XBpp1mmkUyk5K/RqyuOgnK5junV9rMNG43WyEof2dFqrTC6LE9?=
 =?us-ascii?Q?C7p4VVeN1ewUwZREqXJKhE16EQIGJxioYBfG/c0xmEu0FQ0LpcP4C91FvkGn?=
 =?us-ascii?Q?FxEsxvdei7u0g/ZbHGaeswbsMEk9dkX44JmnyP+e1OlffgQEMlyg9VtTumud?=
 =?us-ascii?Q?utm5SqahqgGm36WmqHFEUaOe04RzpDCZn4h6+o63rSCp76Y45zv3tj37He9Z?=
 =?us-ascii?Q?yJV1RB5uB5F/iib2KtwF/2SSwNLOGNVljinLMEpHqsnqUUoo95xljVvY+T+S?=
 =?us-ascii?Q?9bvyUJH659/zRBDo07rRqbqIkW7SAmvkLTQB5suW0E6bo1i8lXVFuqXXipEY?=
 =?us-ascii?Q?WPBqBqJCONh1nkr3L1nEFZFWZpOeG6IpxM38JfTqIaPksnljlM4+YYxtkc5i?=
 =?us-ascii?Q?5eIvaSynyO4CBtvI12YUJyyiVmhVC9Jg67fYKA5wqD3vP3POsaJFZz5OSlPs?=
 =?us-ascii?Q?rPVtWwJN110U0nERowDP5o+UlNjR5CN6oAJ3GXLCRPT2Xib6rXjVV0vMenmP?=
 =?us-ascii?Q?u+OeTVlgOJqC2q5uI7QAokz5s2tn8jAQh08kMP65nVSUQrA7pkw1qFpw/m2J?=
 =?us-ascii?Q?73tBC8Iw2doEB10zPNJ5X7WXRx16z+8LYhXBHBRnj+s4s+pNVWYsa1IvCDAM?=
 =?us-ascii?Q?hMz3fdIaZzyj42U1on7PU0NBGPnfB4iUhOSfoYvPNydG1m0rGBuW9IuniKlW?=
 =?us-ascii?Q?915s20/lLoQD/Y4XUdAMqz6cJb+aiEfRThrNOx1IMIEdcoQk+M2AgHyfXJe8?=
 =?us-ascii?Q?2m/SuMxoItpuqbGd5u/gFEIkXzwZ5WCumCRSeLLgLthoYXI3opmsDYpx+uOD?=
 =?us-ascii?Q?ZPEC1z6J95KgLs1n8JraEsqY8WlgR2Fv9MbX4lwGQahfVhFxd2yEDhQPqyeG?=
 =?us-ascii?Q?jwLg/4KFnwSeIMfbSPZK7X1/70JF7cmTvzX8y8X0WpYBQej/pkMSDR8laj0M?=
 =?us-ascii?Q?89j2PzuJmDFWMhgb894bbFZCH+p/1QEUBtQ6TwybluQTyn4VFqIj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d298c667-25d9-47a3-46e4-08de5766afc4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 14:26:08.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DNev5lo8xuo4/gycrAqq0F8s+zGh9wlwxcInzopckaWHJEzE9duEzygqo6kRnJythsJdsRygl8hyTiDYoiSbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBP286MB5934

On Sun, Jan 18, 2026 at 12:03:19PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:04PM +0900, Koichiro Den wrote:
> > DesignWare EP eDMA can generate interrupts both locally and remotely
> > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > completions should be handled locally, remotely, or both. Unless
> > carefully configured, the endpoint and host would race to ack the
> > interrupt.
> >
> > Introduce a per-channel interrupt routing mode and export small APIs to
> > configure and query it. Update v0 programming so that RIE and local
> > done/abort interrupt masking follow the selected mode. The default mode
> > keeps the original behavior, so unless the new APIs are explicitly used,
> > no functional changes.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 52 +++++++++++++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
> >  include/linux/dma/edma.h              | 44 +++++++++++++++++++++++
> >  4 files changed, 116 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index b9d59c3c0cb4..059b3996d383 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -768,6 +768,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		chan->configured = false;
> >  		chan->request = EDMA_REQ_NONE;
> >  		chan->status = EDMA_ST_IDLE;
> > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> >
> >  		if (chan->dir == EDMA_DIR_WRITE)
> >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > @@ -1062,6 +1063,57 @@ int dw_edma_remove(struct dw_edma_chip *chip)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_edma_remove);
> >
> > +int dw_edma_chan_irq_config(struct dma_chan *dchan,
> > +			    enum dw_edma_ch_irq_mode mode)
> > +{
> > +	struct dw_edma_chan *chan;
> > +
> > +	switch (mode) {
> > +	case DW_EDMA_CH_IRQ_DEFAULT:
> > +	case DW_EDMA_CH_IRQ_LOCAL:
> > +	case DW_EDMA_CH_IRQ_REMOTE:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!dchan || !dchan->device)
> > +		return -ENODEV;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (!chan)
> > +		return -ENODEV;
> > +
> > +	chan->irq_mode = mode;
> > +
> > +	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
> > +		 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > +		 chan->id, mode);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
> > +
> > +bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
> > +{
> > +	struct dw_edma_chan *chan;
> > +	struct dw_edma *dw;
> > +
> > +	if (!dchan || !dchan->device)
> > +		return false;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (!chan)
> > +		return false;
> > +
> > +	dw = chan->dw;
> > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> > +	else
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
> > +
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 71894b9e0b15..8458d676551a 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -81,6 +81,8 @@ struct dw_edma_chan {
> >
> >  	struct msi_msg			msi;
> >
> > +	enum dw_edma_ch_irq_mode	irq_mode;
> > +
> >  	enum dw_edma_request		request;
> >  	enum dw_edma_status		status;
> >  	u8				configured;
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 2850a9df80f5..80472148c335 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > -		dw_edma_v0_core_clear_done_int(chan);
> > -		done(chan);
> > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > +			dw_edma_v0_core_clear_done_int(chan);
> > +			done(chan);
> > +		}
> >
> >  		ret = IRQ_HANDLED;
> >  	}
> > @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > -		dw_edma_v0_core_clear_abort_int(chan);
> > -		abort(chan);
> > +		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
> > +			dw_edma_v0_core_clear_abort_int(chan);
> > +			abort(chan);
> > +		}
> >
> >  		ret = IRQ_HANDLED;
> >  	}
> > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  		j--;
> >  		if (!j) {
> >  			control |= DW_EDMA_V0_LIE;
> > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> >  				control |= DW_EDMA_V0_RIE;
> >  		}
> >
> > @@ -408,12 +413,17 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  				break;
> >  			}
> >  		}
> > -		/* Interrupt unmask - done, abort */
> > +		/* Interrupt mask/unmask - done, abort */
> >  		raw_spin_lock_irqsave(&dw->lock, flags);
> >
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		} else {
> > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		}
> >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> >  		/* Linked list error */
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index ffad10ff2cd6..6f50165ac084 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -60,6 +60,23 @@ enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> >  };
> >
> > +/*
> > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
> > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> > + *
> > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > + * Write Interrupt Generation".
> > + */
> > +enum dw_edma_ch_irq_mode {
> > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > +	DW_EDMA_CH_IRQ_LOCAL,
> > +	DW_EDMA_CH_IRQ_REMOTE,
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:		 struct device of the eDMA controller
> > @@ -105,6 +122,22 @@ struct dw_edma_chip {
> >  #if IS_REACHABLE(CONFIG_DW_EDMA)
> >  int dw_edma_probe(struct dw_edma_chip *chip);
> >  int dw_edma_remove(struct dw_edma_chip *chip);
> > +/**
> > + * dw_edma_chan_irq_config - configure per-channel interrupt routing
> > + * @chan: DMA channel obtained from dma_request_channel()
> > + * @mode: interrupt routing mode
> > + *
> > + * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
> > + * not belong to the DesignWare eDMA driver.
> > + */
> > +int dw_edma_chan_irq_config(struct dma_chan *chan,
> > +			    enum dw_edma_ch_irq_mode mode);
> > +
> > +/**
> > + * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
> > + * @chan: DMA channel obtained from dma_request_channel()
> > + */
> > +bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> >  #else
> >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> > @@ -115,6 +148,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
> > +					  enum dw_edma_ch_irq_mode mode)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
> > +{
> > +	return false;
> > +}
> 
> I think it'd better go thought
> 
> struct dma_slave_config {
> 	...
>         void *peripheral_config;
> 	size_t peripheral_size;
> 
> };
> 
> So DMA consumer can use standard DMAengine API, dmaengine_slave_config().

Using .peripheral_config wasn't something I had initially considered, but I
agree that this is preferable in the sense that it avoids introducing the
additional exported APIs. I'm not entirely sure whether it's clean to use
it for non-peripheral settings in the strict sense, but there seem to be
precedents such as stm32_mdma_dma_config, so I guess it seems acceptable.
If I'm missing something, please correct me.

I'll rework this part as you suggested. Thanks for the guidance.

Koichiro

> 
> Frank
> >  #endif /* CONFIG_DW_EDMA */
> >
> >  struct pci_epc;
> > --
> > 2.51.0
> >

