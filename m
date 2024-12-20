Return-Path: <linux-kselftest+bounces-23664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA109F9610
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 17:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80254163A01
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 16:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1D9218EA3;
	Fri, 20 Dec 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="guIuft11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C99535948;
	Fri, 20 Dec 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711057; cv=fail; b=qoXGMAZdXEM4ysYU3VmeY4hfSQhthl+0Y7oKrF4qwn1Rl3RoDLug7UhELa7GreoAVlXYrf+kK4/7DJMekVVFdCyOywhWkjYmOz38S75zXS8al1b6gvxdBU4+Pa/ElHG0URmUAJyk3cVHADlaiotF+Q4m4yvD5k/jEZSr+I1uWQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711057; c=relaxed/simple;
	bh=BOJih3F8uPT91ecAU12Y8EbP8wYCKhiWEYZVTqBgtVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DyALDGAW9a9jI/hr5XXR/fIsZxNIMHhGL29Z/hFUOqHFDB5vGrv5wda6ZY0u+GrovusVsmuYSmNWEOv5wU1vIhhLqFckdB5z9EE0oM8TNri0cK79a7iLYU6s91qGbGplSlSToVoMFY2n3QFxoWtU2ZWhAZIAWdlH+8t3hdPaqoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=guIuft11; arc=fail smtp.client-ip=40.107.104.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVxHZfuOpw9ppVsK5Xl1EvOD63oti5+YpqmXIbZBiZx292/DdTfcc6s8iHYCSgTsIAQ3I5vq1Ds1sMgEFKgwjL64JYSXnXoki2+zEgCBglGaSWReO24tJ+lSqm21grqr4L8iB1I8vPpJ1rtSanLoIOQzIoU+2cDo3QzUALXJmm4r8vDG6/gY551a9XNuMKq1eC/MLAinHTxvbm0P0egHzV4XWQYf9ab5AYXVr8PcDMoFDtItIwSkkGz+dRH8aF0dxOfIhxUSSvsgEHMqNwM7caUUfbvvRMOX4gTG3UtvzeO9f8iOE6BL/vkaQFWqTOenGtFruIdCk4jiYC1cD68nhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylwpVgdScllkrXYAHIOLo2Orv+NwXgSy+r0EDXfFIMA=;
 b=d09IgEDWgq2m+7WLrER3cmx9MsDNX1xExjdL4+jTe+yRDjMkodTGncXmwwQu0MlZ+mzVn4H1KPSeGMbFX6x5nmMN3S7rWBRqvlOLy3iChX8uhpxXi3JTyIZtkD3b0HRPlXuXAaIfb2U7dYVUQWlH/Lb3EJhxQ3ZbbyViUryfAFIXXVvHfu6e4LlSpOKti+sdfsZTDJyVGfjdbq8g3USv1XoD8o1uzal8O7HTuaLVQ+PzyJDAPDZyBV0r1aCA9hhPleo9XVdsOVoHIiELD6P6+ytEHO6AKOyOgd8CQBlbcpzG+ekpE6HbLeynG1SpV9PIO5B18D7QZBj8XE7iQHHF9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylwpVgdScllkrXYAHIOLo2Orv+NwXgSy+r0EDXfFIMA=;
 b=guIuft11JrpjshXAv7PWrSJBA7msYrLStV87jMW+E8wWeTu60ay0jg0nqJBITOJtYkn4aRNPMGOpGPH2RdxqDup9rfXuk6L84QaBX2IsQAXraPzX5w6Lsk7o3U9tOo4+sVMlVZDl1uB8prQrXhfb968trrVaedvsAlXYduOKYejmmswwvvexL4Jyj6DTvpS+Z0+pYoFdkHVfFJ6DxDPbk8Bx2JTFMrqGuJ+/7LIwohsQbaPQobT8F292VVPgnpA7QT6r1H5NS2uxacwgSYl+TFZqSPUM1AJD5KlZqsgDKILjeWHyLMWppRhuH+gyjjCi1jUL+NlvdJ7mwA2lSJLCiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7468.eurprd04.prod.outlook.com (2603:10a6:102:8d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 16:10:53 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 16:10:52 +0000
Date: Fri, 20 Dec 2024 11:10:42 -0500
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
	andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to
 umem_config
Message-ID: <Z2WXAqNY4s+OKZbB@lizhi-Precision-Tower-5810>
References: <20241220091806.1856223-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220091806.1856223-1-wei.fang@nxp.com>
X-ClientProxiedBy: BYAPR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9d337c-dcc6-4f7d-639c-08dd2110e05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PH+jXpnGWd0+k46rDf7nszmStpmgNDGWjVPfyUtYrIRjZV+45gG+r7qWbttH?=
 =?us-ascii?Q?hzPkHH+gQRxp6dsjsmig2MsVNaB+A0wGom1r11CwfQvWjOTaAbJ4n8i7UWRm?=
 =?us-ascii?Q?kR+Z3hzNdajEYJWGWbWyzJCwrdhZwdipXBN3y1/qq7THlv6x9BI3/3ea+ddw?=
 =?us-ascii?Q?nbCJmCbaYkkZQUN9bXWwmaY2v/XxtrJKet1ZyA9gnBtWCRtOjMo6F4kBCnij?=
 =?us-ascii?Q?cEui+QfZdxZymx1S7I5U9jnDFH1Dy1xBECZr/xB8deJtzC94DWKyQLLtfxuQ?=
 =?us-ascii?Q?vkyvDZvu9oYsB8MSbdS+y1z57S8YfdULbitsGaheUvODrqQdtG/ZcGi2ME0b?=
 =?us-ascii?Q?4Etp59qg288A5brIDCXoYyKFEZWJGEE3NRGsfJ5ekABd5RNqQ4EswU2jS77E?=
 =?us-ascii?Q?Xm6UneIuq8XU6yfA4l90j/tjROEOD1wfK2nJGi7eeDhhcLx12/VY08pmH/6G?=
 =?us-ascii?Q?IRBSW/9WbQLRezcDSpnxxqRIGcG5dKD/Vp6R4gqdWTsAyrDA0Ux2nSVDCmhs?=
 =?us-ascii?Q?Bpc/5pW/lLdXiZ9dAlt3DW/tOS25Wm1ttwma62i3RhKeJFVZvi/VojYfD46B?=
 =?us-ascii?Q?2A7wuSThy4ypozj9FJFlA9dDThj+/eMiwLKSAjSkWZf3X73KdwrL15LNjFlr?=
 =?us-ascii?Q?j6uvLViz/GOo2BTTjLH9VX7ODdPqOxhFScprF6qj7D3UAb9b5sT4zd10MzT9?=
 =?us-ascii?Q?Frn2C6bu8nzv/obtDWDSsCXLgHXJZ4hJUbjWRjUlbyaV04/y6rMR37ojvN6U?=
 =?us-ascii?Q?r2LrW2EHavLh8zy8sx7o3cIy9Cpa+l1occ4P9AsvZ4JbD8/m+ag6cEwmjjYC?=
 =?us-ascii?Q?o+VfJZyKCMbWh06TIIQz79w416xfI0SkNVzND38RUlTFyoocOf+FGF+ok6cS?=
 =?us-ascii?Q?g2k25yIYL+nl5LsoaVOo+Gty0R7ZHmqxDq5BF5Rv77v4n4SRhqy8QoQPa2/X?=
 =?us-ascii?Q?GrBzBVke/7nuP25G3Rdd/9VRSTBtiK0jJCrZv/cCKWxjwZC3etEAbj+d3rBv?=
 =?us-ascii?Q?pU9R94zqlENFt1hNJAyJAJ5R0JThbqfTAOM5OrKiy5OFyZTHGP2ECNFcKo8R?=
 =?us-ascii?Q?NembXjxlZ9bcwnKkUlkJ4po1Qe9Yl4OzJ4jgSRoW2exBRoF8nNDgKn06s2j/?=
 =?us-ascii?Q?86/AjI/QQ8oXnXflqzmmbNqwORlPMf112CCFvZmG62shVz5PTHMZKtDMVP+l?=
 =?us-ascii?Q?9t0QE1/BBN9igzT0IWIWHrdRtyJcOpDimqLeZtlSIYp8KWvL6xDdoyQhMu55?=
 =?us-ascii?Q?E+Xh1zh5iubtJEIHIaKOgOE0qbWV6KloZP4LmtgYZc83Ivy1p5hpLdSF6waa?=
 =?us-ascii?Q?CNNjzptxqYJM7BnD3h70kjjxKWCr26qSJaGeipz39kZxDTIJXIEoq25xuFwz?=
 =?us-ascii?Q?EDD49UPP+t06HkLOMiiT9qVrc8vAwiOxC5hSeKjj/O6lbi63a29dBDPOG7NL?=
 =?us-ascii?Q?JE1AWw7m6SxrKFq/RVeT6VhUddnmedA/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+KEyOtop3MR6HsWJPQFniSjqJnJML5gYJ1VTpBLko8yQJCwdPUfaY1jcbTbv?=
 =?us-ascii?Q?nKLv4bshl1H8/2Z14omgvcNLSHPoEy1CMk+lA0WgRCT9rE/j1LGpNXRtE0+M?=
 =?us-ascii?Q?GVh0/mNLBtznC+H6fFiqMoSEaLGcvQ4dNavQkC8eGoPi5+mpdjGfnJUH7wJq?=
 =?us-ascii?Q?+Od2GSxxgsaNLwz33Pi0kiZt1CNHXC8jslO4qd3+5CVrQecOEvScP+GP4i4X?=
 =?us-ascii?Q?TQtcxh2dT1VagE2QeBUjHRlNdXEoy1OU7U6vzQGmWmFQsPJJppPDSFU6sUzy?=
 =?us-ascii?Q?ppAX2frLc9OrK1IILetztsvjoyivyd/2uyZLlOHHKltRdR7L4gzf380b+Y5G?=
 =?us-ascii?Q?CKtYKd4OWj12g1yjwrges8PTfFOVmZY1zsDbAtLBZzcH3vtFqwySI/jmuLGk?=
 =?us-ascii?Q?GN/Vf2fHzbjUHo0e3w2YANUZIzbMTjSKy76jCuEulN8qUVM2pq21VQDP+RCZ?=
 =?us-ascii?Q?FKxMG0oZ2wQ+MVFQABC2qJwTJ7j7/rC+AeHKiS036x3r+7gjv8bACOhfn6Eh?=
 =?us-ascii?Q?GBE0ORFK7mtBWndUh6OrbIQZCUF5P3ZhzLKp5rxZZpbY4rrX/3O0Jh70qa7Z?=
 =?us-ascii?Q?CiOzs2OdueKmyevn9+mXXQJWhnbwBwq9kis4yBGmhzteOwDgVUBWASseYssh?=
 =?us-ascii?Q?XEQqVb2wer37UqAz0obZL7074k7fvV1M9bITnKur0/vPXlkq9OqpFmvac+1E?=
 =?us-ascii?Q?FdRdPe3xfxxf+1OowPKRqC1QwLZA9JkEQ78vbwkg6upLkrAH54haFeY6P0zh?=
 =?us-ascii?Q?Ed1zsMSeIBON/JD3mMp/1c1IEW3ogk9X12lhkywzk6znI1di8GYGJQLOBU1T?=
 =?us-ascii?Q?otLbPv0OT8wNge4Z2s0Jh9r69vCGeh1DR7NuHmTvSmeQfhKSLYdBx9G4AmD9?=
 =?us-ascii?Q?Kt7ySsfW5QtaWmG4+Q6GvL4rwYwGbn4dIHFHgfzTRDM2H+O9yLs+EVRO3ESg?=
 =?us-ascii?Q?/s5UCzmlIENbeZX8i8606N/jtZuR1gwBkVMSO8eMwMqB47XE6K9/bWJo0Ju9?=
 =?us-ascii?Q?fth3bKKK2pkSyuP5L6AY2vT56Tj8f00VYfLHtD2JHkhZU0bENFEbsA4ddkWp?=
 =?us-ascii?Q?6645UC3ZqBMWScwLbv1s8qYfmKj8tgivZ71980w7GF9QrKS5w3Hewhw/hpqF?=
 =?us-ascii?Q?Jr9pKFHG0LhFRJwc/b7RwmdyWA2fG7U9QiyQfEw2Y885FjCm0I59abiApWE8?=
 =?us-ascii?Q?JdCehub6BF5c3hhKZNhl3pET/KSWaxLMmPS3wJGjp/S/IBdC9wilAMs1Zmc3?=
 =?us-ascii?Q?nsfTGs+H9KRyjb1DcoOFKdCqaxEF4OXQWroapmsuzycwi3YFeZ0pnCSXe8Xz?=
 =?us-ascii?Q?NRF2FXg5nwAI3DSwNi382LnzMw4+Agck+jK8Dpr3//FCM4zqSwDn6L8/kjWv?=
 =?us-ascii?Q?CxDfqVxubttF6feqWI2mWiAci70aYBWxBlEmlOu+H3RhKrKLmhk03DtRG0eN?=
 =?us-ascii?Q?WTKJuExif4Tpr6I0KkxGQkXzPlyo31frywvnbIAciypChLv503vf4p3/qm7N?=
 =?us-ascii?Q?tFAQf0WBCjbzuzzPP2DNrNfg8+aAaEiqaF7NPWnl3+hLBqlsWibNqK6FodIv?=
 =?us-ascii?Q?7C2pgc0xkYDYbVS+lItjHGTMTL9HyyQMBfaj/Xgq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9d337c-dcc6-4f7d-639c-08dd2110e05f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 16:10:52.5720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cK1vRBeIUI1rt2+UMOJyxNwR7Eg77N2y26gS9HahdVPnR+b0Jn5QSRMMnr+Rg7I2ocORwz7OF5Ln+oyB4O6zpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7468

On Fri, Dec 20, 2024 at 05:18:06PM +0800, Wei Fang wrote:
> The Tx metadata test has been broken since the commit d5e726d9143c ("xsk:
> Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len").

Nit:

Fixes tag already include this information.

The Tx metadata test has been broken becasue XDP_UMEM_TX_METADATA_LEN flag
is not set ....

> Because
> this change requires XDP_UMEM_TX_METADATA_LEN flag to be set, otherwise
> xsk_buff_pool::tx_metadata_len will be initialized to 0, which means that
> the driver cannot get Tx metadata and cannot execute AF_XDP Tx metadata
> hooks.
>
> Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> index 6f9956eed797..ad6c08dfd6c8 100644
> --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> @@ -79,7 +79,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
>  		.fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
>  		.comp_size = XSK_RING_CONS__DEFAULT_NUM_DESCS,
>  		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
> -		.flags = XSK_UMEM__DEFAULT_FLAGS,
> +		.flags = XDP_UMEM_TX_METADATA_LEN,

look like "XSK_UMEM__DEFAULT_FLAGS | XDP_UMEM_TX_METADATA_LEN"

You clean other flags, does it what you what?

Frank

>  		.tx_metadata_len = sizeof(struct xsk_tx_metadata),
>  	};
>  	__u32 idx = 0;
> --
> 2.34.1
>

