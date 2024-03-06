Return-Path: <linux-kselftest+bounces-6004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB0873D8B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 18:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59EDEB21153
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 17:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58B13BAD7;
	Wed,  6 Mar 2024 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBWfqzKJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA4132C0C;
	Wed,  6 Mar 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709746183; cv=fail; b=KZoyzr1FWpeMh2y8bAfCSmHbQhCcW8MigccJ00005TWPPFwAqGlKV5KYlNXDjzsjVFVOkpZs953o/jWwMOCB8Zc0OBUMT5jUHayeK5+JuoShwMMiYWpnDvII2ZhIYR/iUiW1ekrr4ldnFU4Pa/Sc4KQ2t6rhkynl9+QXdzRxhEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709746183; c=relaxed/simple;
	bh=Vii56cW3IP4qpInpPq+IlX21/zOej6Jb2HCYDXe5kl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UuCNOYmefRWeexCAZn6LLf9/eyBdLRVPquBmJWJy4kz3Degs3xW23FT/gQ/CEzyE3y5G0aCsOvBiSl/IcRQhREwaf03UyU0Bc+cS+is/UPUKKPNrK/MXEzS18gvSMDC+P/iMGArU0Z6imndwVX38PlLl1FWben/vAXx73wU/vyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBWfqzKJ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709746181; x=1741282181;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Vii56cW3IP4qpInpPq+IlX21/zOej6Jb2HCYDXe5kl8=;
  b=QBWfqzKJ4fUKbQ8HFgI29M5jlepuJBBhi7s4Y/bD+RKnqHbXVxb2+Fa8
   K+wqjA9txHJco06WxNsXd/30w5AAEyG8AyQJhrvAtpiZD2lM9eOkRR9a6
   64j+xj1m3qiSO+2NxrHnQbh/RXfOByp10Hr7I5/nIcXuV8Ypq9d/8gdb2
   ZDc6fP3sgAD5130B6dXN5AxpRGpdT/9BCfFXoRslK2IR8nRWxI5KlzCPs
   H1A6K41DngvYEXvK9LXGSWuboGbov658U07WXCTAqn5fm0Mhx2ib4z023
   h+muMDnw7w/uUH4aiO3fP8ins0E9nLH83XJMhNmfyqkM1uTGJH550kM+a
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4221793"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4221793"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 09:29:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="9805296"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 09:29:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 09:29:39 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 09:29:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 09:29:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 09:29:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biXFimdZxdCkuqGLM3Z/R5zVRHjqIGBVy0/NXjxKGDcPT3VLI6EORLjHUAxUSGJzJOGgav8WCVsIsrb0kKZzZZwdjAzL+AUa42HtynUzidmLELtdDahh0SFL8JY2g3p7fuxq7kKsVA98Gz5qcmetQlTYCIoqExGGpa1jDZB663fkYOfkRXMY349PMx4XdL/89Rd5FQKi/6ZZGEYZyzXOCFX1UHWCjKozSCqgQoHkuWzQylxxaxyzF8c2jLAqkl5uasrXqJx9DrbY1F/bPA/IENGEnGFlFzBYD7wXqumZ8NapCTwqDawCT5qS9Vslsh1nOjEFuRN9na1jZ5NkIbNqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InqkGmRkAkIJnJ6Dnd1BhpqeFjR3vW1eJppWFvZMkz0=;
 b=YTGstMxCvmyXEGVM9h1iITX+st3sica4Vxp3nXKa7OLjId5BpgCyf6ltrJAS0jcSU91oiOImd2x/iozM0AytBmnBPWmu/FKj94o0qJMzSnqIrfXdl4lTLiFgSse3T0GE0izmLwG2LukDZBx/+AJGVdfOZjudGB17LjlsTcOwMNHg93hSYzbfTZthJE+XoSqjO6fVjRQBvoGDi53+j30tsfY4TFjH2ECp0I9vtpiY1bUepfqp00VmLZBytoLWAFfVC2gIDU2a95tBiDFJhlooC6wqvZYQy3kd/q7UX1W6pnH94XVRTXNk/Fm32u/mA0Mvg6rFgZgsVMamMHrdsIClJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 17:29:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 17:29:35 +0000
Date: Wed, 6 Mar 2024 18:29:21 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>, "Vinicius Costa Gomes"
	<vinicius.gomes@intel.com>, Florian Bezdeka <florian.bezdeka@siemens.com>,
	Andrii Nakryiko <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next, v3 2/2] igc: Add Tx hardware
 timestamp request for AF_XDP zero-copy packet
Message-ID: <Zein8XvWkqj8VrHs@boxer>
References: <20240303083225.1184165-1-yoong.siang.song@intel.com>
 <20240303083225.1184165-3-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240303083225.1184165-3-yoong.siang.song@intel.com>
X-ClientProxiedBy: FR4P281CA0327.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::11) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b5162b-8ba0-4bbc-6414-08dc3e02fdc8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrZG16H1f6G/N9I5ZgQe4pAAH6P1m8fOPAmFnBZSg31oc6AaBpnUAFKualzb3wvmnmLy8nWViNMINkm0+pUtGdHdPf6tDsDuDKPq4bWnMX07bwhwD2BdFataCc/RFVM0l29c1KHtlPw3xbHTT3wARb8VC1bM7csDCyJueTGwz2AeCxDTJmp5tRzYxM0bNpfvGM4dEfESel3cv+kAHKWOgHGtS2uZciCTh5SsfohKldddjhSFm9314bRgPBpuo4LrVYMjPlegbyq+/TjdykqvMkqrDOcQABa2v+i6dsBDWKjwIFauoGmExpfWbUGNUmDGRZg6O99i6BLAfqNCQbe046wjXIXsTrKX2L787Nja5pVw0hoXIbAcnXWJZLMew+QBNq5t2HpQsBf1dHirxigIKazKmozSjhOiApx0pKzgXreehvmoEZxJN2RrLdrDzbOKPRCvn3ZpcnI1R9NFmeshg51V+ByU04C/8mN/frhArEMdBKJ7P4g2o8tcO0QQGnRIORkGXCj85wnN1HVlY701qsYX6crrsnbLP/aNvwvYSUQkLSMQfqU/5eUqqnOH4Sr5AzsHdqsi1UteotWWL2v91dUEmtxzq4jvi6nh4NNdt/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nguIRHasCOD8nsIrPCTrkNPRYHyuDW5tReKQh86JeOeH6VSLJAa5VpL01yC2?=
 =?us-ascii?Q?grJly7Jvlo1r21wArwQuS3lIJzHtj28aQ9lxlhkfKs9YnZtLgptLNgFseZdg?=
 =?us-ascii?Q?Cy8eo/ppEAYSXt3261p86u32Ybm+yMIFhd21gA2k4Mu2R83C+iMrI8TP5N17?=
 =?us-ascii?Q?YznX0WoaL60IAx+ysMNTeYAvk439TLT81uUrzD97s287RFemz6Jm7dCXoLmd?=
 =?us-ascii?Q?POfJFL4Hh6bnrLCRIkw6HFsqfW/9xq2QUty8FpCXdr79digRQ81eRC8MxPqo?=
 =?us-ascii?Q?ds84x4QFEm8Pc7BzZXihgBB1b6EQO8Wv7CF4x2EKoRIMqBXwrkY3CurvbN6t?=
 =?us-ascii?Q?MrcwiaVWwmflVmWBtwGFK4fuEHaHdt21Jz/rcV9E3ojJ7wVTZdPdo9Lx/Xum?=
 =?us-ascii?Q?9twfu7BYMvlYsyf0/ERCTdvldqZoOqU8sflAgXmPnLvzE82VMuKgoVecQ9g0?=
 =?us-ascii?Q?q+noPKusJPWixwCHSbB5NlB+6RP37/C/Ji6CMjwoQhvi2njy0IG+cEdxTPgX?=
 =?us-ascii?Q?+eSaViY787s0dn7XSmhRAl0DJ2w16RkI9ejz1KdY/pKPm+kPTaoO2MLP4XOa?=
 =?us-ascii?Q?zHxySw/zlGFkweI22slqBMBBuX3WJ6AQAGvxXs1eNJX4teb5FWA5bMWH5mW4?=
 =?us-ascii?Q?LQjhZ/qHPoN9eZ4jl+BGsANftTA8spJqgK/xlKiSiP2zgot7QGDoPA3LIUs4?=
 =?us-ascii?Q?Jjs1Loh013NXuA1QrHqFtkNYVSyRLt1y6o041fnPzMqkbENTnOgbNUgioC1+?=
 =?us-ascii?Q?HNB4FBrq9Iu0HzHConcTNctpYWR9h+FLwKljJLGdA+FWD9r3ZzMET5TW3a9e?=
 =?us-ascii?Q?4s+kKDdEZeYHqvhMMSQtcZa2eg65Rx8yWdneE59fD7QxWIDOTLVL9oAUbc8n?=
 =?us-ascii?Q?bVxtOarWL0QGq2yJ58bQboFte5ECBmWQlraL2Z3krFwf5spDGrMl/xDmI4DO?=
 =?us-ascii?Q?DG8JqJ7lvvczLQvdzC58G41y/tRRI17ci0qRKbHDKaw8uA+XsKZTaV1fp38u?=
 =?us-ascii?Q?5dMWBFu2LmJKNdsCWBs/urWkJvWlU4QrDv4IxPJOeB9vIfc4nHeru/RDPmjb?=
 =?us-ascii?Q?pi9rUVnnIhNdWAjJW0UcFjXn55Sa4fphJYw0zagCQqQHYzNBkrlEV8FvSL5N?=
 =?us-ascii?Q?76wrbTEIQDqXCXUccSFr+umrYZ76cfWtw+FSiINYrx3ZsJjxCtAaxbnlreFI?=
 =?us-ascii?Q?EfJrfntOxqEW2Grh/dRxJQZy5Jn0QhbSJkceEkY7Pg9CDdRtUlUv9xcPB2us?=
 =?us-ascii?Q?9U4TAn1jOY7kCc+kqbR4Wtq4Odc7xNG8qkBBauGhfytXgJVKfB23v4vHMig4?=
 =?us-ascii?Q?aKyl0j0FUdfz5cNaXkKNedXBszJcuMw7wmMWptUY3TgfpOYvWNN/rh1SH2Xe?=
 =?us-ascii?Q?KNU1rulw/sVA4IRB/eg7ocmhH3wttFwEGxkeEg335tss1gBmZWBCI8lEE9T/?=
 =?us-ascii?Q?qH+ecV8gYuv0h1v0HjdlNEMxnh9dL4ae+KhJJtZzeYFXDWsb/3JvoSd231yV?=
 =?us-ascii?Q?XYu3SiYLG6fmo0lwtpcVnfDPUB/R8jM/U8DMqRDHtkTwrBHugj8yQreAGAQy?=
 =?us-ascii?Q?K4+xyTrSwqXb5cpdOO7qXcobLBX+uoiAI2FoAltZvoNea9bnjVbYXtegxEX2?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b5162b-8ba0-4bbc-6414-08dc3e02fdc8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 17:29:35.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iCNquLhZvhLIP9B0VndhUQWbVt6DLPLxJNPdKIpm4psQVsjyGme1bg1tR90CHp0P6AlhyBpO3ARJrWFgnyHwHnPQG2/rZAWWoN7dpvxl4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-OriginatorOrg: intel.com

On Sun, Mar 03, 2024 at 04:32:25PM +0800, Song Yoong Siang wrote:
> This patch adds support to per-packet Tx hardware timestamp request to
> AF_XDP zero-copy packet via XDP Tx metadata framework. Please note that
> user needs to enable Tx HW timestamp capability via igc_ioctl() with
> SIOCSHWTSTAMP cmd before sending xsk Tx hardware timestamp request.
> 
> Same as implementation in RX timestamp XDP hints kfunc metadata, Timer 0
> (adjustable clock) is used in xsk Tx hardware timestamp. i225/i226 have
> four sets of timestamping registers. Both *skb and *xsk_tx_buffer pointers
> are used to indicate whether the timestamping register is already occupied.
> 
> Furthermore, a boolean variable named xsk_pending_ts is used to hold the
> transmit completion until the tx hardware timestamp is ready. This is
> because, for i225/i226, the timestamp notification event comes some time
> after the transmit completion event. The driver will retrigger hardware irq
> to clean the packet after retrieve the tx hardware timestamp.
> 
> Besides, xsk_meta is added into struct igc_tx_timestamp_request as a hook
> to the metadata location of the transmit packet. When the Tx timestamp
> interrupt is fired, the interrupt handler will copy the value of Tx hwts
> into metadata location via xsk_tx_metadata_complete().
> 
> Co-developed-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  71 ++++++++------
>  drivers/net/ethernet/intel/igc/igc_main.c | 113 ++++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_ptp.c  |  45 +++++++--
>  3 files changed, 189 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index cfa6baccec55..22bb4f245240 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -72,13 +72,46 @@ struct igc_rx_packet_stats {
>  	u64 other_packets;
>  };
>  
> +enum igc_tx_buffer_type {
> +	IGC_TX_BUFFER_TYPE_SKB,
> +	IGC_TX_BUFFER_TYPE_XDP,
> +	IGC_TX_BUFFER_TYPE_XSK,
> +};
> +
> +/* wrapper around a pointer to a socket buffer,
> + * so a DMA handle can be stored along with the buffer
> + */
> +struct igc_tx_buffer {
> +	union igc_adv_tx_desc *next_to_watch;
> +	unsigned long time_stamp;
> +	enum igc_tx_buffer_type type;
> +	union {
> +		struct sk_buff *skb;
> +		struct xdp_frame *xdpf;
> +	};
> +	unsigned int bytecount;
> +	u16 gso_segs;
> +	__be16 protocol;
> +
> +	DEFINE_DMA_UNMAP_ADDR(dma);
> +	DEFINE_DMA_UNMAP_LEN(len);
> +	u32 tx_flags;
> +	bool xsk_pending_ts;
> +};
> +
>  struct igc_tx_timestamp_request {
> -	struct sk_buff *skb;   /* reference to the packet being timestamped */
> +	union {                /* reference to the packet being timestamped */
> +		struct sk_buff *skb;
> +		struct igc_tx_buffer *xsk_tx_buffer;
> +	};
> +	enum igc_tx_buffer_type buffer_type;
>  	unsigned long start;   /* when the tstamp request started (jiffies) */
>  	u32 mask;              /* _TSYNCTXCTL_TXTT_{X} bit for this request */
>  	u32 regl;              /* which TXSTMPL_{X} register should be used */
>  	u32 regh;              /* which TXSTMPH_{X} register should be used */
>  	u32 flags;             /* flags that should be added to the tx_buffer */
> +	u8 xsk_queue_index;    /* Tx queue which requesting timestamp */
> +	struct xsk_tx_metadata_compl xsk_meta;	/* ref to xsk Tx metadata */
>  };
>  
>  struct igc_inline_rx_tstamps {
> @@ -322,6 +355,9 @@ void igc_disable_tx_ring(struct igc_ring *ring);
>  void igc_enable_tx_ring(struct igc_ring *ring);
>  int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags);
>  
> +/* AF_XDP TX metadata operations */
> +extern const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops;
> +
>  /* igc_dump declarations */
>  void igc_rings_dump(struct igc_adapter *adapter);
>  void igc_regs_dump(struct igc_adapter *adapter);
> @@ -507,32 +543,6 @@ enum igc_boards {
>  #define TXD_USE_COUNT(S)	DIV_ROUND_UP((S), IGC_MAX_DATA_PER_TXD)
>  #define DESC_NEEDED	(MAX_SKB_FRAGS + 4)
>  
> -enum igc_tx_buffer_type {
> -	IGC_TX_BUFFER_TYPE_SKB,
> -	IGC_TX_BUFFER_TYPE_XDP,
> -	IGC_TX_BUFFER_TYPE_XSK,
> -};
> -
> -/* wrapper around a pointer to a socket buffer,
> - * so a DMA handle can be stored along with the buffer
> - */
> -struct igc_tx_buffer {
> -	union igc_adv_tx_desc *next_to_watch;
> -	unsigned long time_stamp;
> -	enum igc_tx_buffer_type type;
> -	union {
> -		struct sk_buff *skb;
> -		struct xdp_frame *xdpf;
> -	};
> -	unsigned int bytecount;
> -	u16 gso_segs;
> -	__be16 protocol;
> -
> -	DEFINE_DMA_UNMAP_ADDR(dma);
> -	DEFINE_DMA_UNMAP_LEN(len);
> -	u32 tx_flags;
> -};
> -
>  struct igc_rx_buffer {
>  	union {
>  		struct {
> @@ -556,6 +566,13 @@ struct igc_xdp_buff {
>  	struct igc_inline_rx_tstamps *rx_ts; /* data indication bit IGC_RXDADV_STAT_TSIP */
>  };
>  
> +struct igc_metadata_request {
> +	struct igc_tx_buffer *tx_buffer;
> +	struct xsk_tx_metadata *meta;
> +	struct igc_ring *tx_ring;
> +	u32 cmd_type;
> +};
> +
>  struct igc_q_vector {
>  	struct igc_adapter *adapter;    /* backlink */
>  	void __iomem *itr_register;
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 3af52d238f3b..bfa51ecdf8ec 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2878,6 +2878,89 @@ static void igc_update_tx_stats(struct igc_q_vector *q_vector,
>  	q_vector->tx.total_packets += packets;
>  }
>  
> +static void igc_xsk_request_timestamp(void *_priv)
> +{
> +	struct igc_metadata_request *meta_req = _priv;
> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> +	struct igc_tx_timestamp_request *tstamp;
> +	u32 tx_flags = IGC_TX_FLAGS_TSTAMP;
> +	struct igc_adapter *adapter;
> +	unsigned long lock_flags;
> +	bool found = false;
> +	int i;
> +
> +	if (test_bit(IGC_RING_FLAG_TX_HWTSTAMP, &tx_ring->flags)) {
> +		adapter = netdev_priv(tx_ring->netdev);
> +
> +		spin_lock_irqsave(&adapter->ptp_tx_lock, lock_flags);
> +
> +		/* Search for available tstamp regs */
> +		for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
> +			tstamp = &adapter->tx_tstamp[i];
> +
> +			/* tstamp->skb and tstamp->xsk_tx_buffer are in union.
> +			 * When tstamp->skb is equal to NULL,
> +			 * tstamp->xsk_tx_buffer is equal to NULL as well.
> +			 * This condition means that the particular tstamp reg
> +			 * is not occupied by other packet.
> +			 */
> +			if (!tstamp->skb) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		/* Return if no available tstamp regs */
> +		if (!found) {
> +			adapter->tx_hwtstamp_skipped++;
> +			spin_unlock_irqrestore(&adapter->ptp_tx_lock,
> +					       lock_flags);
> +			return;
> +		}
> +
> +		tstamp->start = jiffies;
> +		tstamp->xsk_queue_index = tx_ring->queue_index;
> +		tstamp->xsk_tx_buffer = meta_req->tx_buffer;
> +		tstamp->buffer_type = IGC_TX_BUFFER_TYPE_XSK;
> +
> +		/* Hold the transmit completion until timestamp is ready */
> +		meta_req->tx_buffer->xsk_pending_ts = true;
> +
> +		/* Keep the pointer to tx_timestamp, which is located in XDP
> +		 * metadata area. It is the location to store the value of
> +		 * tx hardware timestamp.
> +		 */
> +		xsk_tx_metadata_to_compl(meta_req->meta, &tstamp->xsk_meta);
> +
> +		/* Set timestamp bit based on the _TSTAMP(_X) bit. */
> +		tx_flags |= tstamp->flags;
> +		meta_req->cmd_type |= IGC_SET_FLAG(tx_flags,
> +						   IGC_TX_FLAGS_TSTAMP,
> +						   (IGC_ADVTXD_MAC_TSTAMP));
> +		meta_req->cmd_type |= IGC_SET_FLAG(tx_flags,
> +						   IGC_TX_FLAGS_TSTAMP_1,
> +						   (IGC_ADVTXD_TSTAMP_REG_1));
> +		meta_req->cmd_type |= IGC_SET_FLAG(tx_flags,
> +						   IGC_TX_FLAGS_TSTAMP_2,
> +						   (IGC_ADVTXD_TSTAMP_REG_2));
> +		meta_req->cmd_type |= IGC_SET_FLAG(tx_flags,
> +						   IGC_TX_FLAGS_TSTAMP_3,
> +						   (IGC_ADVTXD_TSTAMP_REG_3));
> +
> +		spin_unlock_irqrestore(&adapter->ptp_tx_lock, lock_flags);
> +	}
> +}
> +
> +static u64 igc_xsk_fill_timestamp(void *_priv)
> +{
> +	return *(u64 *)_priv;
> +}
> +
> +const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
> +	.tmo_request_timestamp		= igc_xsk_request_timestamp,
> +	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
> +};
> +
>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  {
>  	struct xsk_buff_pool *pool = ring->xsk_pool;
> @@ -2899,24 +2982,34 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  	budget = igc_desc_unused(ring);
>  
>  	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> -		u32 cmd_type, olinfo_status;
> +		struct igc_metadata_request meta_req;
> +		struct xsk_tx_metadata *meta = NULL;
>  		struct igc_tx_buffer *bi;
> +		u32 olinfo_status;
>  		dma_addr_t dma;
>  
> -		cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
> -			   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> -			   xdp_desc.len;
> +		meta_req.cmd_type = IGC_ADVTXD_DTYP_DATA |
> +				    IGC_ADVTXD_DCMD_DEXT |
> +				    IGC_ADVTXD_DCMD_IFCS |
> +				    IGC_TXD_DCMD | xdp_desc.len;
>  		olinfo_status = xdp_desc.len << IGC_ADVTXD_PAYLEN_SHIFT;
>  
>  		dma = xsk_buff_raw_get_dma(pool, xdp_desc.addr);
> +		meta = xsk_buff_get_metadata(pool, xdp_desc.addr);
>  		xsk_buff_raw_dma_sync_for_device(pool, dma, xdp_desc.len);
> +		bi = &ring->tx_buffer_info[ntu];
> +
> +		meta_req.tx_ring = ring;
> +		meta_req.tx_buffer = bi;
> +		meta_req.meta = meta;
> +		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
> +					&meta_req);
>  
>  		tx_desc = IGC_TX_DESC(ring, ntu);
> -		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
>  		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
>  		tx_desc->read.buffer_addr = cpu_to_le64(dma);
>  
> -		bi = &ring->tx_buffer_info[ntu];
>  		bi->type = IGC_TX_BUFFER_TYPE_XSK;
>  		bi->protocol = 0;
>  		bi->bytecount = xdp_desc.len;
> @@ -2979,6 +3072,13 @@ static bool igc_clean_tx_irq(struct igc_q_vector *q_vector, int napi_budget)
>  		if (!(eop_desc->wb.status & cpu_to_le32(IGC_TXD_STAT_DD)))
>  			break;
>  
> +		/* Hold the completions while there's a pending tx hardware
> +		 * timestamp request from XDP Tx metadata.
> +		 */
> +		if (tx_buffer->type == IGC_TX_BUFFER_TYPE_XSK &&
> +		    tx_buffer->xsk_pending_ts)
> +			break;
> +
>  		/* clear next_to_watch to prevent false hangs */
>  		tx_buffer->next_to_watch = NULL;
>  
> @@ -6818,6 +6918,7 @@ static int igc_probe(struct pci_dev *pdev,
>  
>  	netdev->netdev_ops = &igc_netdev_ops;
>  	netdev->xdp_metadata_ops = &igc_xdp_metadata_ops;
> +	netdev->xsk_tx_metadata_ops = &igc_xsk_tx_metadata_ops;
>  	igc_ethtool_set_ops(netdev);
>  	netdev->watchdog_timeo = 5 * HZ;
>  
> diff --git a/drivers/net/ethernet/intel/igc/igc_ptp.c b/drivers/net/ethernet/intel/igc/igc_ptp.c
> index 885faaa7b9de..e81b850c035e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ptp.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ptp.c
> @@ -11,6 +11,7 @@
>  #include <linux/ktime.h>
>  #include <linux/delay.h>
>  #include <linux/iopoll.h>
> +#include <net/xdp_sock.h>
>  
>  #define INCVALUE_MASK		0x7fffffff
>  #define ISGN			0x80000000
> @@ -545,6 +546,30 @@ static void igc_ptp_enable_rx_timestamp(struct igc_adapter *adapter)
>  	wr32(IGC_TSYNCRXCTL, val);
>  }
>  
> +static void igc_ptp_free_tx_buffer(struct igc_adapter *adapter,
> +				   struct igc_tx_timestamp_request *tstamp)
> +{
> +	if (tstamp->buffer_type == IGC_TX_BUFFER_TYPE_XSK) {
> +		/* Release the transmit completion */
> +		tstamp->xsk_tx_buffer->xsk_pending_ts = false;
> +
> +		/* Note: tstamp->skb and tstamp->xsk_tx_buffer are in union.
> +		 * By setting tstamp->xsk_tx_buffer to NULL, tstamp->skb will
> +		 * become NULL as well.
> +		 */
> +		tstamp->xsk_tx_buffer = NULL;
> +		tstamp->buffer_type = 0;
> +
> +		/* Trigger txrx interrupt for transmit completion */
> +		igc_xsk_wakeup(adapter->netdev, tstamp->xsk_queue_index, 0);
> +
> +		return;
> +	}
> +
> +	dev_kfree_skb_any(tstamp->skb);
> +	tstamp->skb = NULL;
> +}
> +
>  static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
>  {
>  	unsigned long flags;
> @@ -555,8 +580,8 @@ static void igc_ptp_clear_tx_tstamp(struct igc_adapter *adapter)
>  	for (i = 0; i < IGC_MAX_TX_TSTAMP_REGS; i++) {
>  		struct igc_tx_timestamp_request *tstamp = &adapter->tx_tstamp[i];
>  
> -		dev_kfree_skb_any(tstamp->skb);
> -		tstamp->skb = NULL;
> +		if (tstamp->skb)
> +			igc_ptp_free_tx_buffer(adapter, tstamp);
>  	}
>  
>  	spin_unlock_irqrestore(&adapter->ptp_tx_lock, flags);
> @@ -657,8 +682,9 @@ static int igc_ptp_set_timestamp_mode(struct igc_adapter *adapter,
>  static void igc_ptp_tx_timeout(struct igc_adapter *adapter,
>  			       struct igc_tx_timestamp_request *tstamp)
>  {
> -	dev_kfree_skb_any(tstamp->skb);
> -	tstamp->skb = NULL;
> +	if (tstamp->skb)
> +		igc_ptp_free_tx_buffer(adapter, tstamp);
> +
>  	adapter->tx_hwtstamp_timeouts++;
>  
>  	netdev_warn(adapter->netdev, "Tx timestamp timeout\n");
> @@ -729,10 +755,15 @@ static void igc_ptp_tx_reg_to_stamp(struct igc_adapter *adapter,
>  	shhwtstamps.hwtstamp =
>  		ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>  
> -	tstamp->skb = NULL;
> +	/* Copy the tx hardware timestamp into xdp metadata or skb */
> +	if (tstamp->buffer_type == IGC_TX_BUFFER_TYPE_XSK)

I believe this should also be protected with xp_tx_metadata_enabled()
check. We recently had following bugfix, PTAL:

https://lore.kernel.org/bpf/20240222-stmmac_xdp-v2-1-4beee3a037e4@linutronix.de/

I'll take a deeper look at patch tomorrow, might be the case that you've
addressed that or you were aware of this issue but anyways wanted to bring
it up. Just check that you don't break standard XDP/AF_XDP traffic :)

> +		xsk_tx_metadata_complete(&tstamp->xsk_meta,
> +					 &igc_xsk_tx_metadata_ops,
> +					 &shhwtstamps.hwtstamp);
> +	else
> +		skb_tstamp_tx(skb, &shhwtstamps);
>  
> -	skb_tstamp_tx(skb, &shhwtstamps);
> -	dev_kfree_skb_any(skb);
> +	igc_ptp_free_tx_buffer(adapter, tstamp);
>  }
>  
>  /**
> -- 
> 2.34.1
> 

