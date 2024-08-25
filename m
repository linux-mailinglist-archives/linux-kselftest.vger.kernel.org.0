Return-Path: <linux-kselftest+bounces-16223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1C95E2E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 11:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA2332825E0
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Aug 2024 09:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD713D245;
	Sun, 25 Aug 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hup2GwL3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987B54AEE5;
	Sun, 25 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724578834; cv=fail; b=TP6wGkTyq9GeA18adiFPPHI9Icrpw5UsnobrwkM/CsGN/s7r0YouHAkYr+7l1IcNIS6XmisXaYcjjUy9j5LkzVivMBjZLpSFUD9WpPE9RLbWGzdtfL+ZekwC79LfkXEAWVqs9XoawJMTNoCK6GT+ZvV8FeuiOyWNl04y2gVBoRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724578834; c=relaxed/simple;
	bh=QhVg1bfE4hWPDzQfnWERkhQwOkm2+Djd+vnM9L4cwog=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aMvxuXTSSTIRLzoDyfMbE/2SKdg+nVcvidb259qgm7bQhOK+f9PpN3dgGw9TM6t2/Gof3UadcyJI+Wjk4A+dixuzBYsBx6PoQqeWo4GBwhhHAkN6TYUxzLtpY90x+SH1goMFRqTvouA82g+X23LpUFxpyP1J1qET8px1gJjKIvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hup2GwL3; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724578833; x=1756114833;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=QhVg1bfE4hWPDzQfnWERkhQwOkm2+Djd+vnM9L4cwog=;
  b=Hup2GwL3PiFzWL5Hz1I1TxRPVRQaBQ7Rvg6OBY1SpSMcY9hmGkABUTT1
   za89VCtfHQbxEysZrAW+k2kP4bQ3xK1Ux4rcT4eAFZEQ8o5520wkycCRd
   I9riAoRnpI08laJHfIvOnYhgN6PlnVvULrJ5j5gorbITXy23O+4tW6485
   uygy3F6kPSVrAbgav2t9IIr8MOwv5v2hsqEIM8q2J6IoXIwMO9sB6g/GB
   B+FgGVsfaeIcYfP2wVCKRGGe7ut+8ufaU9y2/tutebuzDsj2PXFM3Res0
   zEWqFA402sKBeJsxyNWEjd7yJMugvSX0OZhESfIxjvTzVLGsXJjKcoBby
   w==;
X-CSE-ConnectionGUID: 4cR9T3urS+SNEg04DhV5GQ==
X-CSE-MsgGUID: KeFv5UuBSWi0kngOEH0wJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="22817314"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22817314"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 02:40:32 -0700
X-CSE-ConnectionGUID: c5BGWI/8RlWYI+WwERKTOg==
X-CSE-MsgGUID: N3GR6Ct/RpCfUN+rr0h92Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62539179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Aug 2024 02:40:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 02:40:31 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 25 Aug 2024 02:40:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 25 Aug 2024 02:40:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 25 Aug 2024 02:40:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Perc0uOgisdNPQhqInBjI1hMgifuDwTn/P0VahKW2a8Ty2fMlGOoP+jzIqxtU6xjNO7MQr6W97ASGQ/Hc89vgTzieFZ2mlAMOzZMUTvXKN446aH2XOQBSbs4E4u98CpLuD1FNJcN+LioSOCGlyaKRuwz4xHdTVRO9WwJRlCod5GEI2EwUCkPrGghfboFKb1qLCa/ByxfwZXRECPvj0bfQU5faRurCAcukDq7X3QroAiD09ZwcZda4z+FIm5eyP9iTpbumiIzwM8Mo7b/UpIFEHjOxgrKCsxeWkCqmsZM99w68EpUWpQZAaCV4uSJjPv1rPp601oCwnQ7UkaW3UqFyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJYZ634eBSuFzBpQj7RCs+q8oveRgGzsRtPj1pOARxE=;
 b=Y1SWnbzAfPPZ//YHcoPpVbRepK2rDJI0ionD2G1zQd8e4928BhM95P1BKOcdVUaoh+a2WzMogdabxlKiXm1wFK2iYcd6JTaa5CEx3y48vsXZyl4u3ddzAGGWluA04XiUgYjHBFRI7asvY1gvKOb/cmfqyJbHeIEDoXDppahqj2lUc7cOVo6rML7mQZmLRO06f/GF8kHfqJsISPBWpl76yVElwdeySNXYyC+lfFERFWGks+e5B52vlW6LkiuwqiF4mXNBIcuEQSnGF1mFBCiMcDxHbDn/GafqqnNLNPLbMNRO8UidAhfoffhYJrs66VPFFYla38rJSTiIm0M+b0F96Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN6PR11MB8244.namprd11.prod.outlook.com (2603:10b6:208:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Sun, 25 Aug
 2024 09:40:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 09:40:27 +0000
Date: Sun, 25 Aug 2024 17:40:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Eugene Syromiatnikov <esyr@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-sound@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, "Takashi
 Iwai" <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] selftests: fix relative rpath usage
Message-ID: <202408251749.7e390194-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240812165650.GA5102@asgard.redhat.com>
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN6PR11MB8244:EE_
X-MS-Office365-Filtering-Correlation-Id: b67019a9-1507-495e-1dc5-08dcc4e9f359
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tHoY37raU4pJHZfnUTS6OaQVh/wm70V1+smXD5yY6swBfZOoGdbaSi3iV2uI?=
 =?us-ascii?Q?8OCR/XnyeP5/pUm8L0UyHZ+/jneZx2HEQ4tKwvmHjkobZDg9bwMGk/bciR9q?=
 =?us-ascii?Q?kYwHGLHgp5UQVuzVmwbnvgNxLqiruVeg8P6v+qQwihwgEVioppRWrStWPIW3?=
 =?us-ascii?Q?G2Xtm3NBPfjtkSYWYbjqnqi1NjjSIa8Rm9+Qq0z/hxKaMixgsSJCfZfd1mS2?=
 =?us-ascii?Q?jKNpIaRxNhHOtNMZh9dvsb0m3WoMXUADyjrgzITzBYpioAAEbhHByUHxG6xR?=
 =?us-ascii?Q?2H5abBcJ3AxQDPrqxaZn9F+W1MnX1fCSljfXXwfsEFnUpMecGCskC+KuLHuv?=
 =?us-ascii?Q?ItsAw3ltbDxWsNH6xZ1gFcMHFnvne9K8ZAaF/3rEpxG9cG0HFVdvPP7Lv0KO?=
 =?us-ascii?Q?MtM0KDoAj0y4Xg8EoTxkyrsDidiJR8EalSBFchUVWPOjjB90GV+oSqJZuj3/?=
 =?us-ascii?Q?g8A+PrHOPYQVOyrRniXvtOjC4koVNfwnbZIKx6c9df7a/FER3919Hcm1mEgP?=
 =?us-ascii?Q?UyPWci7jtYQO0N0U1bMIdmhMl3ODdJ9CDV5l4pjZY4UEaKS186F3JpAAd9kq?=
 =?us-ascii?Q?dfBiMFcL15NReOJMi8h1V23+mRCItTbQEjTElP45vnBoF7hbike5KWFbleEI?=
 =?us-ascii?Q?I2MWUyCHA9XXtHSHSSkFGLAmFZUzKdLt7wuC8gjPdys+DgsM7NAzHtzLaOhj?=
 =?us-ascii?Q?KpmgHbG+xOOc1gre9Iv+qVdh5T2+rPQBc4Q4dcjbqaQ61ek0QU4Nf2E2fgvl?=
 =?us-ascii?Q?S/jy0mb1gNZtAQK+mowFWRIAcKwIls6ZZFTSLCgHH6xhIQTYcREv/MSUQ08/?=
 =?us-ascii?Q?yJPlLF+tYgN3j4ZtUxsJfeMyarCBkD/jpAUgocrAw2lf6ZBqdQABMoNmxzRl?=
 =?us-ascii?Q?lDyOUTtklerhX5ZdC2aNNltUsBPsKJKoKxKb3v3UQn1WxoOp8Lu4VrIrPYGS?=
 =?us-ascii?Q?bHQ/lN59iSNdxkfCu2v1ZV1e2Kk2ewZ1bWYuyo4wQqHg5gBAlHyeBwu/mLTf?=
 =?us-ascii?Q?tUIMydt6Svb+5NmpowmFUwBAAog8QBktkaNj4GePyp08FA6a8b8qbRefrSTA?=
 =?us-ascii?Q?NBrsr+kzkWseD2el/tlZy2L2W2Rzfv2F87xa6Mg8hda4KQKlZ16oJaCPNeZ0?=
 =?us-ascii?Q?XsGH8gZrM6ZM3RpqdevbhZu+HGXyHk/oTwKHNQDN+j+gFWsfPPIvEkXiKW5V?=
 =?us-ascii?Q?4KKP7uzh/B/NU7s9n8HPX4MgmT9R7Kj3ZXgXh7WgymwxRrRivR1ZrTv/uq/9?=
 =?us-ascii?Q?WxU37dovDYqaOx2OSRddlpOJtuPObhuRspsCMNLoRwd1PvzCgc0lrMbHUq5T?=
 =?us-ascii?Q?gms=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SQVJVR+uu+9ooKhKUKlA8EJhw4WgeRpWBFMBbSqIGRgCZeFtM9d6i8eg9xwz?=
 =?us-ascii?Q?jsC/4wS+LDm8Ye5zbXkuqP9x65CsiBAsiSYy/S7eHRPEJR/UoXxUUCK6S3FH?=
 =?us-ascii?Q?F27AuZgUp2AWVjCWNh9gpO0Ly9RIas7j44c14k01Y7WdzS9jmCTp8gV5qg1G?=
 =?us-ascii?Q?rsN6PbRNMi8tCpvmYueTVoy8qwVxpabzP6JV2rMrOx3r6oZup45rrIiasDL9?=
 =?us-ascii?Q?9Lz3H2iVvoNZDuNYO4Tro1kQYaPrEy7/upmkX0UfgQ5HjGoW9bpaij0xjTQu?=
 =?us-ascii?Q?F2uyUV70/bGkRNRrKhTMS5qxpoHlvTgG/NQZGvFW3AX931eJIb9QFRvMWvrb?=
 =?us-ascii?Q?7cxh/6M4mfxB6PqzYmJ63+MY5QWxbQGREASiE/hMWljo1zrG95Sjh+cRJCX7?=
 =?us-ascii?Q?SMr+3pZ8UHjwyxll8CM/htE1fzwpYia/CS5xsKY+hResYbRmmPI2d+jMUd+u?=
 =?us-ascii?Q?Bs3EtewkbJD2U5xE10WRzzaKXYDihNAcpmQwpIcQsbe6UtzsGACjml/ekOKy?=
 =?us-ascii?Q?5EDwb4e/4rqALH31+TajsPuhfvObxQcEETYGkzauhU5at0vR3lns7uaqLwrZ?=
 =?us-ascii?Q?5tp7WezJqWeR5dwnKPsuPUhSBV5w1v2Syu/NI//602KbEw9m0WgQA7vlx9F8?=
 =?us-ascii?Q?H2tPtzDon7jqYp83j1bPZQRpmo/sOqaXQhZleDAV36zexbAvTkKbO4eXVRn3?=
 =?us-ascii?Q?9jfIb8T+Bxdg8a/lk+FMCDS3SqS8B7ki2xepxwXXyow2VUNe0KJkwO20RLz/?=
 =?us-ascii?Q?BdDk9oqYPCWeWW3LGdx7f1CQTsTyza1T6H3IRzuoklu9UeCaXD3by5h9OuW9?=
 =?us-ascii?Q?HhhMJPxJHNX3rSUqHqSikqK58/BUjctCc6R+ijzDyqp8I3mEx8jlZTtIYVK3?=
 =?us-ascii?Q?XrKCH1sEejfwy+vlye3hxj+yalQGJXOF6YdYordshqEvn5DTW3t1LWDLM2m4?=
 =?us-ascii?Q?DfsNv7dC3DKJCOLeIGub3FBAj+iw6WiO36ClU6Y3KGGns3ON4z/5pnU7IoK7?=
 =?us-ascii?Q?aE3fUpGP01rp4B4phpDYI3glZ9g97TidNpy1RtorGlWqfKd2rsepD1neDHps?=
 =?us-ascii?Q?RgUxXzFweFnzjZFb99Oh4UCSeqhm0f88WVGq2FdJmb0bdeVFRf1KBihIJcup?=
 =?us-ascii?Q?LrB9mctyaTAHuREwoF8xnYFG2Dlbx7K77LW5FPhu6aLHB/cNI/2RcoDgVDUj?=
 =?us-ascii?Q?aDvsUwNU/kxYyDMh0gcPqtJP1NH/YMV+YFhlt4g8PGOpdymdzEMhL63Iq1bY?=
 =?us-ascii?Q?g0WDrx+EXLKen4JvMCZMbrlGsmy/UpL93L5omd16N93DUdpNa0tCBvJe7/j5?=
 =?us-ascii?Q?GuGrRzXmsrHwMZQTPazvPsG2i8kY/10s5vJ3bLWPyuug5Web/Zh9xqyNNs/t?=
 =?us-ascii?Q?V0/TkIG4+KHvKOMyBPsJAKJm7Fi/8vkiITaX0EBdZbFsjaR0UwGOaUr4xjHN?=
 =?us-ascii?Q?WHf152edtaB5G0T65z5m7rCQ3x/zKN08Y3rR6lywu51tL7S1eWVBK1zytYJk?=
 =?us-ascii?Q?8LpSacE0QrY+ktqqvnj96GAf9pEDWYmraWO1SHjgrQdIIQzLkbCKJ9Zs7EKO?=
 =?us-ascii?Q?qK0wlJFMq7+I1OFdiBZJv6z5+N+OePo9H+r2JLtB/L5CceniSbIDQCmwQxH/?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b67019a9-1507-495e-1dc5-08dcc4e9f359
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2024 09:40:27.2320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYIYY3cHy1dn05VSaEwi017e5/P7sg0lbQcFCZWQP932/WnNy/wotDfZZhZkf9yA7NZfaJ10NqRd5lx1HJuH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8244
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "segfault_at_ip_sp_error" on:

commit: 782e28421b3410522d5b50feb30e8fa10da44492 ("[PATCH v2] selftests: fix relative rpath usage")
url: https://github.com/intel-lab-lkp/linux/commits/Eugene-Syromiatnikov/selftests-fix-relative-rpath-usage/20240814-091042
base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
patch link: https://lore.kernel.org/all/20240812165650.GA5102@asgard.redhat.com/
patch subject: [PATCH v2] selftests: fix relative rpath usage

in testcase: kernel-selftests
version: kernel-selftests-x86_64-977d51cf-1_20240508
with following parameters:

	group: group-01



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


besides, we also noticed some tests failed on this change:

8afc0816f5f6213c 782e28421b3410522d5b50feb30
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
           :4          100%           4:4     dmesg.segfault_at_ip_sp_error
           :4          100%           4:4     kernel-selftests.exec.load_address.static.0x1000.fail
           :4          100%           4:4     kernel-selftests.exec.load_address.static.0x1000000.fail
           :4          100%           4:4     kernel-selftests.exec.load_address.static.0x200000.fail



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408251749.7e390194-oliver.sang@intel.com



user  :notice: [  458.511077] 2024-08-23 12:25:42 make -j36 -C dt

user  :notice: [  458.527252] make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-782e28421b3410522d5b50feb30e8fa10da44492/tools/testing/selftests/dt'

kern  :info  : [  460.458153] load_address.st[7491]: segfault at 28 ip 00007f1137a2b5e6 sp 00007ffddc0fd6d0 error 4 in load_address.static.0x1000[d5e6,7f1137a27000+7a000] likely on CPU 2 (core 2, socket 0)
kern :info : [ 460.459808] Code: 53 48 81 ec d8 00 00 00 48 89 b5 68 ff ff ff 48 89 95 38 ff ff ff 89 8d 54 ff ff ff 4c 89 85 48 ff ff ff 44 89 8d 50 ff ff ff <64> 48 8b 04 25 28 00 00 00 48 89 45 c8 31 c0 48 c7 85 70 ff ff ff
All code
========
   0:	53                   	push   %rbx
   1:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
   8:	48 89 b5 68 ff ff ff 	mov    %rsi,-0x98(%rbp)
   f:	48 89 95 38 ff ff ff 	mov    %rdx,-0xc8(%rbp)
  16:	89 8d 54 ff ff ff    	mov    %ecx,-0xac(%rbp)
  1c:	4c 89 85 48 ff ff ff 	mov    %r8,-0xb8(%rbp)
  23:	44 89 8d 50 ff ff ff 	mov    %r9d,-0xb0(%rbp)
  2a:*	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax		<-- trapping instruction
  31:	00 00 
  33:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  37:	31 c0                	xor    %eax,%eax
  39:	48                   	rex.W
  3a:	c7                   	.byte 0xc7
  3b:	85 70 ff             	test   %esi,-0x1(%rax)
  3e:	ff                   	(bad)  
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
   7:	00 00 
   9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   d:	31 c0                	xor    %eax,%eax
   f:	48                   	rex.W
  10:	c7                   	.byte 0xc7
  11:	85 70 ff             	test   %esi,-0x1(%rax)
  14:	ff                   	(bad)  
  15:	ff                   	.byte 0xff
kern  :info  : [  460.571500] load_address.st[7510]: segfault at 28 ip 00007fa9ec0045e6 sp 00007ffd3ba861b0 error 4 in load_address.static.0x200000[2045e6,7fa9ec000000+7a000] likely on CPU 2 (core 2, socket 0)
kern :info : [ 460.573155] Code: 53 48 81 ec d8 00 00 00 48 89 b5 68 ff ff ff 48 89 95 38 ff ff ff 89 8d 54 ff ff ff 4c 89 85 48 ff ff ff 44 89 8d 50 ff ff ff <64> 48 8b 04 25 28 00 00 00 48 89 45 c8 31 c0 48 c7 85 70 ff ff ff
All code
========
   0:	53                   	push   %rbx
   1:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
   8:	48 89 b5 68 ff ff ff 	mov    %rsi,-0x98(%rbp)
   f:	48 89 95 38 ff ff ff 	mov    %rdx,-0xc8(%rbp)
  16:	89 8d 54 ff ff ff    	mov    %ecx,-0xac(%rbp)
  1c:	4c 89 85 48 ff ff ff 	mov    %r8,-0xb8(%rbp)
  23:	44 89 8d 50 ff ff ff 	mov    %r9d,-0xb0(%rbp)
  2a:*	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax		<-- trapping instruction
  31:	00 00 
  33:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  37:	31 c0                	xor    %eax,%eax
  39:	48                   	rex.W
  3a:	c7                   	.byte 0xc7
  3b:	85 70 ff             	test   %esi,-0x1(%rax)
  3e:	ff                   	(bad)  
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
   7:	00 00 
   9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   d:	31 c0                	xor    %eax,%eax
   f:	48                   	rex.W
  10:	c7                   	.byte 0xc7
  11:	85 70 ff             	test   %esi,-0x1(%rax)
  14:	ff                   	(bad)  
  15:	ff                   	.byte 0xff
kern  :info  : [  460.677410] load_address.st[7529]: segfault at 28 ip 00007f9a020045e6 sp 00007ffe4bb51e10 error 4 in load_address.static.0x1000000[10045e6,7f9a02000000+7a000] likely on CPU 2 (core 2, socket 0)
kern :info : [ 460.679071] Code: 53 48 81 ec d8 00 00 00 48 89 b5 68 ff ff ff 48 89 95 38 ff ff ff 89 8d 54 ff ff ff 4c 89 85 48 ff ff ff 44 89 8d 50 ff ff ff <64> 48 8b 04 25 28 00 00 00 48 89 45 c8 31 c0 48 c7 85 70 ff ff ff
All code
========
   0:	53                   	push   %rbx
   1:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
   8:	48 89 b5 68 ff ff ff 	mov    %rsi,-0x98(%rbp)
   f:	48 89 95 38 ff ff ff 	mov    %rdx,-0xc8(%rbp)
  16:	89 8d 54 ff ff ff    	mov    %ecx,-0xac(%rbp)
  1c:	4c 89 85 48 ff ff ff 	mov    %r8,-0xb8(%rbp)
  23:	44 89 8d 50 ff ff ff 	mov    %r9d,-0xb0(%rbp)
  2a:*	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax		<-- trapping instruction
  31:	00 00 
  33:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
  37:	31 c0                	xor    %eax,%eax
  39:	48                   	rex.W
  3a:	c7                   	.byte 0xc7
  3b:	85 70 ff             	test   %esi,-0x1(%rax)
  3e:	ff                   	(bad)  
  3f:	ff                   	.byte 0xff

Code starting with the faulting instruction
===========================================
   0:	64 48 8b 04 25 28 00 	mov    %fs:0x28,%rax
   7:	00 00 
   9:	48 89 45 c8          	mov    %rax,-0x38(%rbp)
   d:	31 c0                	xor    %eax,%eax
   f:	48                   	rex.W
  10:	c7                   	.byte 0xc7
  11:	85 70 ff             	test   %esi,-0x1(%rax)
  14:	ff                   	(bad)  
  15:	ff                   	.byte 0xff
kern  :warn  : [  460.793864] process 'recursion-depth' launched '/tmp/1' with NULL argv: empty string added
user  :err   : [  461.202285] fixup_efivarfs failed

user  :err   : [  462.541150]   /lkp/lkp/src/lib/debug.sh:12: die



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240825/202408251749.7e390194-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


