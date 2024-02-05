Return-Path: <linux-kselftest+bounces-4123-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8D849278
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 03:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690C41C22070
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B3B79CF;
	Mon,  5 Feb 2024 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpDvlG6g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4178F47;
	Mon,  5 Feb 2024 02:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707100922; cv=fail; b=fzBoIx5DhGnMeDbCKY05bjNfqPFdLrmGKQGdHEJQtIwXSpiZ69d7bdksBezwIFYGVKns8XZPzg4DDuTGWWoEr5vdWw0is6GYG3amBBjLU6D7qDawMZ7kWyiI9ToAo20OvUFK2Le2RjagZ37FqzmGqKcRjXX6tyz0gkDwp/sNyuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707100922; c=relaxed/simple;
	bh=ycY4hKpYeIZO91CgqNGoNcOUuG0qrRtnbwisMn0Gric=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mS2sv+Hg7ZxLFfHstgik3Er5rxUEzFnAzS6bRtOUxkkxiMRyc37QPn/HkmuLeoy26cias8V24BVKWzrUUQ1BYRYKfPA5VmRpOYHZzHX9bY5C4PW7LI1/KpMlITA+TaSExqSPdAjITTFSr9Wkeize5MiitRXP93PIcpelVRuVfbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpDvlG6g; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707100920; x=1738636920;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ycY4hKpYeIZO91CgqNGoNcOUuG0qrRtnbwisMn0Gric=;
  b=WpDvlG6gweLxv9bN2oM7zEs9zN3yPFlq36++zWz8GWJKDZEFkvIPByGt
   xQFQKTe8GJdFgxL3xyPKKSgDdSEPxdHHPG7dQgFKBwexefOGe37UGixy9
   wzfP3u9E9Panncqws38kxSbVq3/qPYcFUJXiE35H12lOH+DZ+/iETVH/Q
   W46swLqRe5X6mchc/pL6nOlZ8yc9xhHP8PiRQsMjzpmLBwpf4CzAiL55Q
   dERu3emVHjeqCjrBd+MlW4h/3i7jTtyOmB1t9ymOW52Z8Fc2u5RAHmcjj
   dTOqQgQDhEUN1FZa8cTOPZH43P5Tc9vmLAbDmFeYXWD7yztG/fQB/Y7mC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11177031"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="11177031"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2024 18:41:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="889155"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2024 18:41:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 18:41:57 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 4 Feb 2024 18:41:56 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 4 Feb 2024 18:41:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 4 Feb 2024 18:41:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzPHhnR6JE5bB6IphjSn1E+7H1kcwsSsNCNBIVnJBHJk614oCsgYxfcuxo8/Tb6htEKBTp7Lp8IxkfL/FkFf0+H8VZP01/va6kNkrzJVeoV/TdtP8XaniYwj9lp4/54GlWgqV//aD3eWQZzoikqN3cHlivK7IXL1GgPsuumUIP0GZeaTMMYCQ5Hm/bt3GNUJdIsVP4beFWssop2iKHKCs/t085lrHeZI8bTwwlyeEj7L8toj1ZxLxzBRdgHHlt4+XU/4hmZm1LbxSCERxiCGeGNaDVnMuh3esbDl9YRZV4N8/Ifj7rCUpJxPVNwcWEuBDcwZT/YgIAkgcMFW2epP3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYcUoBy50ypOiAy6g2auz49a2CAnZaCrr5sccIfAU+Q=;
 b=c/TlGMI+YBZZ5UB8KEdqt79RBgvwe5LVgVEYiW7ONXPVAjBm3+9yQUpDo+UX0EerDj6JpJkw3sGqlCGWNCQ1qESa4uXvHrsrYPbR9fKKQiVG3KM/DJyiaemMahdPAvEctzu2JTPN5ATl1aLbv4ebDo8/bh0hF0snoG/UzmrFvCxJbit9APv4GRFJP23xm6532d5XznGoJTOZtmV5xSzDjwd0kS1opLD+n/VbaCtHBqlcrXW+THQ1M4GcWLF3XbHj8UkImaqalaLCieAtYXgw4EoMzpjSiKWTt/wuw+qUtPr2BhltCaTzdgblMwtwuckBaGuMvVwe9rDVjmOvCTKOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM8PR11MB5591.namprd11.prod.outlook.com (2603:10b6:8:38::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 02:41:54 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 02:41:54 +0000
Date: Mon, 5 Feb 2024 10:41:30 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daniel Xu <dxu@dxuuu.xyz>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <bpf@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <fsverity@lists.linux.dev>,
	<cgroups@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<mhiramat@kernel.org>, <daniel@iogearbox.net>, <edumazet@google.com>,
	<fw@strlen.de>, <hannes@cmpxchg.org>, <tytso@mit.edu>, <ast@kernel.org>,
	<eddyz87@gmail.com>, <kuba@kernel.org>, <tj@kernel.org>,
	<steffen.klassert@secunet.com>, <yonghong.song@linux.dev>, <hawk@kernel.org>,
	<rostedt@goodmis.org>, <john.fastabend@gmail.com>, <pablo@netfilter.org>,
	<pabeni@redhat.com>, <jikos@kernel.org>, <davem@davemloft.net>,
	<alexandre.torgue@foss.st.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<song@kernel.org>, <dsahern@kernel.org>, <mcoquelin.stm32@gmail.com>,
	<corbet@lwn.net>, <lizefan.x@bytedance.com>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <benjamin.tissoires@redhat.com>,
	<ebiggers@kernel.org>, <kadlec@netfilter.org>, <shuah@kernel.org>,
	<alexei.starovoitov@gmail.com>, <olsajiri@gmail.com>,
	<quentin@isovalent.com>, <alan.maguire@oracle.com>, <memxor@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, <mathieu.desnoyers@efficios.com>, <mykolal@fb.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH bpf-next v4 3/3] bpf: treewide: Annotate BPF kfuncs in BTF
Message-ID: <202402041610.775e7f75-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e55150ceecbf0a5d961e608941165c0bee7bc943.1706491398.git.dxu@dxuuu.xyz>
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM8PR11MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 5175dfda-ce58-40ad-aac6-08dc25f40388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njr9lqjXR/1kwT6DrvgfWhtUOv4jGh9g/cLQ32lEgEpi2+sRJn5/U90oF/Rrb/iAUZ7SLOhiS9BQ5m83rkfscp7zY/qicAkNm0KGl2C6hjzOTHrdmVuzPMxfRyIX/kkzV7ekEkxO1Ylma//kBZGvMBvv/a8fJPUTT/YGZI90699JeKBaAhEC4hRoNzrL+kNRr4Ciz5VEaDwE5zWU3WgR09EPNTA8XApi7RXeiKMqzYUoYK9PkWjVGsuE033zfPHiEdXzOo0zWHt5HS0l+urN2NmJwCnY5nI7ZSMjg0OAoqzjI522R4PZUY9n6oSPc9U0z7xV3JZJDDo0zHdLWc7Q4KatOn09XbpJL2WNwG1Y6yKFs9YqH6jRKFUzhUff8CT51x0IBd5n2YbseBphOPhwmQYowifBTXjzLBPN/gjX4hf7IosJWBbyYOOAqRJt2dbreuPrMyXlgDc45ePFXhdYDYPiW1D/kHE6/grPV3009LivkiJc1vGJK0vADD4/L5xkMTxt+C3AXgfSy50DRpd/TVJLiIchtt7rToMuVbQT62g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230273577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7366002)(7416002)(7406005)(5660300002)(2906002)(41300700001)(8936002)(8676002)(4326008)(66556008)(316002)(66476007)(6916009)(66946007)(36756003)(478600001)(82960400001)(86362001)(45080400002)(6512007)(2616005)(83380400001)(107886003)(6666004)(6506007)(1076003)(26005)(6486002)(966005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?auJoDDvMgJS1SHHNAWfTwPTw5LwYfskwHc1K/dcymG+3hDWEQ7XWAqGoPES5?=
 =?us-ascii?Q?z3TQ40vi6qa8i86vxeEnjp6mqaBm+U/Nel+WYjTEat4mro5y2JuO7v/tDyma?=
 =?us-ascii?Q?3otA5W1ZAt4sJkFX3OycC7UVwk5NrzJbLQn19/OC06ztH+spt17cAvqNwIhS?=
 =?us-ascii?Q?gNIRVV28kwf8K9eqcPTRHNCIKq/qd99MuDDUpB//WUDb1Qbq+NBMSFBOnZZa?=
 =?us-ascii?Q?frUOdxgMtLp54w+RUmXcaQ75SHNcmHJGA8X4xaa3/gxH6Lor616RjgT0T58e?=
 =?us-ascii?Q?NXy499Y57ZsJXLb1a0gH6kXuXwtHXUk+G/a5KmHJ0QtSaCYLw8OrN8gdCPOJ?=
 =?us-ascii?Q?+ACSr2T7Hc2g69ugzY1NqXrmVY2WdOEuTqKedJB2sbTir89dQsH1G4iePqpC?=
 =?us-ascii?Q?lMlzMlEw6wy/ETGz9Tm88JYKmegciyFAJmra4W6BTh7KfCbRkPYuj3m2NaT7?=
 =?us-ascii?Q?Ov5tSf5wl2sliA5Xz5/iszb+nrAsl9bP0msIBdR0tiWOTXq/0iOAkQe4q5PF?=
 =?us-ascii?Q?nSu2YQfiP5dfHwlivLiY6xFXb4Bu2z/hiEhMXWkkVygL/dwRumLo4jDruCul?=
 =?us-ascii?Q?ZmGTII+6Jc5wTQb/a2eswyPTEUDG3UdjSApTTN78I8VlhSTMu5qgpcy/Ri2G?=
 =?us-ascii?Q?IpM+h4+JDVZY/4VDuVfI0jjgk44TVlEXdY5btGNw88wH/3l2lyU+ZALojTsb?=
 =?us-ascii?Q?Kx5BT9f9sO59NXOFy993afc41n0kVuZ5b5W0wySlUQNhkra5TeIfTVdmFTjb?=
 =?us-ascii?Q?i4xlHf/BbixpnfI5kWLIkCXt25fwDVrJMkIya0V60l3YuMih8qLTZFk9SEGd?=
 =?us-ascii?Q?vXw7jPalRtJWky5bw7+z7KSRechIRpsyFrgdq/lLP0Ce/CbPGZ4t3mjMNZF3?=
 =?us-ascii?Q?7ArAny5EoKkgOuQOlwj/EYKIlQu0FkZsa6MMLl/rhr+uJyuiH4evfT+dlDDi?=
 =?us-ascii?Q?VCCBzjkgZhXT5qOoB6kv0cmBidw0RZnMwce3OZjR2aR4BxAVWnm3jsVrx1vM?=
 =?us-ascii?Q?xp0pTVciwiykQaE54SNvz1gurEq7ghdCfzyFT0919tvtxqlnSZXmgvhlCILs?=
 =?us-ascii?Q?OjMm73Kxioa9HYl0+OIGGNjkgiBwwWJg9uX1Vo/l9GVO3igMM4SOVCiOtKTC?=
 =?us-ascii?Q?sGozuULs+pXoE9kMJfftEr9bkx4YOXGej9bromtG1RnEmUMT+mk6DtsJqepE?=
 =?us-ascii?Q?gv5cmkHufzt8GqbsCOaUEVHdDjykKjzBmZiyyPPBGe03acanNwp9+fMMnF1n?=
 =?us-ascii?Q?CjyNUR0+/qMwFku+67zv9jf4jwkrsWRONXcxsxpQHdFx+Bs+akP0wGOr0R5r?=
 =?us-ascii?Q?ETxY6CNAzCP2KAluMfscODK5ayBaGpF4OHcRm/gqsUQZNYryXJggPxt6iqcX?=
 =?us-ascii?Q?egRo1Dek8VrfW2TrvE+gdnkDcVCfTbY4u58X3kXNxQIub3CdqTIdQifSJ9GR?=
 =?us-ascii?Q?hjSXdNBjQjwsIEQ4p0BbuNDYpvNJF9YUsehKZi+EjMR/NPyeCastPY2/PF78?=
 =?us-ascii?Q?ZPCD24jycl1zF+FYnUoJn0+DY+tquk017pwG9a8oF/YHg9D08wPItgLknbVl?=
 =?us-ascii?Q?6r6Yn8poJGAyQ+ymCxrr5pooAAdubhLpLxRVVSkwDZLtXh+2nJEgQAtNQZ4P?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5175dfda-ce58-40ad-aac6-08dc25f40388
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 02:41:54.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WSjhYORdrMxziW80Rys8IUXvPbEXg5W2F3vnd4NC3CfsPymIsJcrOKTCvnXeZq0jPmOrM8ymkNWtvruKwaB/Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5591
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_kernel/bpf/btf.c:#register_btf_kfunc_id_set" on:

commit: 918c4c7dda155568c619b4082fa83ca90ab578a6 ("[PATCH bpf-next v4 3/3] bpf: treewide: Annotate BPF kfuncs in BTF")
url: https://github.com/intel-lab-lkp/linux/commits/Daniel-Xu/bpf-btf-Support-flags-for-BTF_SET8-sets/20240129-092732
base: https://git.kernel.org/cgit/linux/kernel/git/bpf/bpf-next.git master
patch link: https://lore.kernel.org/all/e55150ceecbf0a5d961e608941165c0bee7bc943.1706491398.git.dxu@dxuuu.xyz/
patch subject: [PATCH bpf-next v4 3/3] bpf: treewide: Annotate BPF kfuncs in BTF

in testcase: boot

compiler: clang-17
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+-----------------------------------------------------------------+------------+------------+
|                                                                 | 05221438c4 | 918c4c7dda |
+-----------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/bpf/btf.c:#register_btf_kfunc_id_set          | 0          | 7          |
| EIP:register_btf_kfunc_id_set                                   | 0          | 7          |
| calltrace:do_softirq_own_stack                                  | 0          | 7          |
+-----------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202402041610.775e7f75-lkp@intel.com


[   49.044594][    T1] ------------[ cut here ]------------
[ 49.045857][ T1] WARNING: CPU: 1 PID: 1 at kernel/bpf/btf.c:8048 register_btf_kfunc_id_set (??:?) 
[   49.048024][    T1] Modules linked in:
[   49.048925][    T1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W          6.8.0-rc1-00457-g918c4c7dda15 #6
[   49.051230][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 49.053616][ T1] EIP: register_btf_kfunc_id_set (??:?) 
[ 49.054969][ T1] Code: 04 01 75 0b b8 ea ff ff ff 83 3a 00 74 1c c3 b9 0d 00 00 00 83 f8 20 77 07 8b 0c 85 28 a2 71 d7 55 89 e5 e8 13 00 00 00 5d c3 <0f> 0b c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 89 e5 53 57
All code
========
   0:	04 01                	add    $0x1,%al
   2:	75 0b                	jne    0xf
   4:	b8 ea ff ff ff       	mov    $0xffffffea,%eax
   9:	83 3a 00             	cmpl   $0x0,(%rdx)
   c:	74 1c                	je     0x2a
   e:	c3                   	retq   
   f:	b9 0d 00 00 00       	mov    $0xd,%ecx
  14:	83 f8 20             	cmp    $0x20,%eax
  17:	77 07                	ja     0x20
  19:	8b 0c 85 28 a2 71 d7 	mov    -0x288e5dd8(,%rax,4),%ecx
  20:	55                   	push   %rbp
  21:	89 e5                	mov    %esp,%ebp
  23:	e8 13 00 00 00       	callq  0x3b
  28:	5d                   	pop    %rbp
  29:	c3                   	retq   
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	c3                   	retq   
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	90                   	nop
  33:	90                   	nop
  34:	90                   	nop
  35:	90                   	nop
  36:	90                   	nop
  37:	90                   	nop
  38:	90                   	nop
  39:	90                   	nop
  3a:	90                   	nop
  3b:	55                   	push   %rbp
  3c:	89 e5                	mov    %esp,%ebp
  3e:	53                   	push   %rbx
  3f:	57                   	push   %rdi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	c3                   	retq   
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	55                   	push   %rbp
  12:	89 e5                	mov    %esp,%ebp
  14:	53                   	push   %rbx
  15:	57                   	push   %rdi
[   49.059550][    T1] EAX: ffffffea EBX: 00000000 ECX: d9356fb0 EDX: d7c2b154
[   49.061229][    T1] ESI: 00000000 EDI: 0000019a EBP: c028dc48 ESP: c028dc38
[   49.062886][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[   49.064685][    T1] CR0: 80050033 CR2: 00000000 CR3: 189ab000 CR4: 000406f0
[   49.066358][    T1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[   49.068020][    T1] DR6: fffe0ff0 DR7: 00000400
[   49.069132][    T1] Call Trace:
[ 49.069902][ T1] ? show_regs (??:?) 
[ 49.070890][ T1] ? register_btf_kfunc_id_set (??:?) 
[ 49.072187][ T1] ? __warn (??:?) 
[ 49.073151][ T1] ? register_btf_kfunc_id_set (??:?) 
[ 49.074480][ T1] ? register_btf_kfunc_id_set (??:?) 
[ 49.075751][ T1] ? report_bug (??:?) 
[ 49.076858][ T1] ? exc_overflow (??:?) 
[ 49.077925][ T1] ? handle_bug (traps.c:?) 
[ 49.078947][ T1] ? exc_invalid_op (??:?) 
[ 49.080030][ T1] ? handle_exception (init_task.c:?) 
[ 49.081174][ T1] ? get_seg_base_limit (insn-eval.c:?) 
[ 49.082393][ T1] ? mutex_lock_killable_nested (??:?) 
[ 49.083707][ T1] ? exc_overflow (??:?) 
[ 49.084782][ T1] ? register_btf_kfunc_id_set (??:?) 
[ 49.086126][ T1] ? mutex_lock_killable_nested (??:?) 
[ 49.087468][ T1] ? exc_overflow (??:?) 
[ 49.088520][ T1] ? register_btf_kfunc_id_set (??:?) 
[ 49.089864][ T1] ? cubictcp_register (tcp_cubic.c:?) 
[ 49.090991][ T1] do_one_initcall (??:?) 
[ 49.092136][ T1] ? pvclock_clocksource_read_nowd (??:?) 
[ 49.093607][ T1] ? __lock_acquire (lockdep.c:?) 
[ 49.094756][ T1] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 49.095985][ T1] ? sched_clock_noinstr (??:?) 
[ 49.097144][ T1] ? local_clock_noinstr (??:?) 
[ 49.098393][ T1] ? __lock_acquire (lockdep.c:?) 
[ 49.099575][ T1] ? sched_clock_noinstr (??:?) 
[ 49.100746][ T1] ? local_clock_noinstr (??:?) 
[ 49.101997][ T1] ? pvclock_clocksource_read_nowd (??:?) 
[ 49.103439][ T1] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 49.104673][ T1] ? pvclock_clocksource_read_nowd (??:?) 
[ 49.106095][ T1] ? kvm_sched_clock_read (kvmclock.c:?) 
[ 49.107310][ T1] ? sched_clock_noinstr (??:?) 
[ 49.109773][ T1] ? local_clock_noinstr (??:?) 
[ 49.111018][ T1] ? __this_cpu_preempt_check (??:?) 
[ 49.112289][ T1] ? irqtime_account_irq (??:?) 
[ 49.113534][ T1] ? irqtime_account_delta (build_policy.c:?) 
[ 49.114812][ T1] ? irqentry_exit (??:?) 
[ 49.115860][ T1] ? __this_cpu_preempt_check (??:?) 
[ 49.117126][ T1] ? lockdep_hardirqs_on (??:?) 
[ 49.118370][ T1] ? sysvec_reboot (??:?) 
[ 49.119450][ T1] ? trace_hardirqs_on (??:?) 
[ 49.120623][ T1] ? irqentry_exit (??:?) 
[ 49.121703][ T1] ? sysvec_reschedule_ipi (??:?) 
[ 49.122962][ T1] ? handle_exception (init_task.c:?) 
[ 49.124130][ T1] ? strlen (??:?) 
[ 49.125054][ T1] ? next_arg (??:?) 
[ 49.126086][ T1] ? parse_args (??:?) 
[ 49.127134][ T1] ? tcp_diag_init (tcp_cubic.c:?) 
[ 49.128257][ T1] do_initcall_level (main.c:?) 
[ 49.129398][ T1] ? kernel_init (main.c:?) 
[ 49.130474][ T1] do_initcalls (main.c:?) 
[ 49.131494][ T1] do_basic_setup (main.c:?) 
[ 49.132558][ T1] kernel_init_freeable (main.c:?) 
[ 49.133781][ T1] ? rest_init (main.c:?) 
[ 49.134848][ T1] ? rest_init (main.c:?) 
[ 49.135885][ T1] kernel_init (main.c:?) 
[ 49.136958][ T1] ret_from_fork (??:?) 
[ 49.137979][ T1] ret_from_fork_asm (??:?) 
[ 49.139078][ T1] entry_INT80_32 (init_task.c:?) 
[   49.140171][    T1] irq event stamp: 16737757
[ 49.141202][ T1] hardirqs last enabled at (16737765): console_unlock (??:?) 
[ 49.143298][ T1] hardirqs last disabled at (16737774): console_unlock (??:?) 
[ 49.145355][ T1] softirqs last enabled at (16737610): do_softirq_own_stack (??:?) 
[ 49.147553][ T1] softirqs last disabled at (16737605): do_softirq_own_stack (??:?) 
[   49.149757][    T1] ---[ end trace 0000000000000000 ]---
[   49.151671][    T1] NET: Registered PF_INET6 protocol family
[   49.156896][    T1] Segment Routing with IPv6
[   49.158068][    T1] In-situ OAM (IOAM) with IPv6
[   49.159300][    T1] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[   49.162798][    T1] NET: Registered PF_PACKET protocol family
[   49.164686][    T1] 9pnet: Installing 9P2000 support
[   49.166257][    T1] start plist test
[   49.168281][    T1] end plist test
[   49.173855][    T1] IPI shorthand broadcast: enabled
[   49.175165][    C0] ... APIC ID:      00000000 (0)
[   49.176383][    C0] ... APIC VERSION: 00050014
[   49.177486][    C0] 0000000000000000000000000000000000000000000000000000000000000000
[   49.177486][    C0] 0000000000000000000000000000000000000000000000000000000008001000


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240204/202402041610.775e7f75-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


