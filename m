Return-Path: <linux-kselftest+bounces-31483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96BA9A013
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 06:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D98C2194365E
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 04:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C7B1AC43A;
	Thu, 24 Apr 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5f7TnGJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F939FCE;
	Thu, 24 Apr 2025 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745468859; cv=fail; b=AjlqHQoXD3Lo/lyFi3LQz06drC2hiLTInXJ6GX0Au0XwqOF5K/4gdPsRpxoIn6LbbXEbXiPQoeyD3b/oY4alQg15g5/29+77zCFuptaTQnwqvSASSlC0xLJNHUEeCnDljg4A0K4wLAQ5OTMPitvONMKTZhopbhNlZ1byaNEMKb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745468859; c=relaxed/simple;
	bh=AxwkQnBnbXzr5v+OE2MvhZbRFyFdf3EIsmdvE/jpR+E=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PS8nAI545mKqPCTtWX4xWflz4ih81no8pf4XULubHq260MI0TyZImfpMmYgzdIlrBAK8ImGRxhllu5FVy99ZPB1Wm4V5q1Zc6mGr5Ot4P3I9mF8nfp+bZtSenhIKB5Z66BiS2TIpuKTPWJSiLAkbXIjZHNs48YjqH4grF0rHr08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5f7TnGJ; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745468856; x=1777004856;
  h=date:from:to:subject:message-id:reply-to:references:
   in-reply-to:mime-version;
  bh=AxwkQnBnbXzr5v+OE2MvhZbRFyFdf3EIsmdvE/jpR+E=;
  b=A5f7TnGJ0KQA6n3g5NuW/DpSV0XF2NBIgubPuAjsUSVxj1L/OPj4cfhN
   /EhwNLuhuHrNGkxb6J1Y/3elz49KKBLIyz65K9IjUTHDpRybJnnygXTQ3
   tTwrHIxDaMJsDhPm4dHwk0eUpf+uFLBHdEDeXvovZDj/zmbC3FBltuE6N
   Hh1cC4w5IlOD6GM7TydpUphtIV1gtp/4bEkSDnmVc8IaRuUqYHwSHeF1I
   qfBlB7VlQGxbZzn/PeJtHFqGx1IG2FEaY4iWy7ATu5ZJwR3Y/h6USoJrz
   mvFZntKWIMpZ5ORMU8+4d9QYvos9v1m+4CUgBEtyhy4T8PiaadXQj0Pbd
   Q==;
X-CSE-ConnectionGUID: oy8Tfx1NRUOiwcWObWBlHg==
X-CSE-MsgGUID: h4wjW0CZRHe7i7qTJAoVOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50884016"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50884016"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:27:35 -0700
X-CSE-ConnectionGUID: zXb7uM0CTwi3YRJ/4PLNbw==
X-CSE-MsgGUID: nyX0EjMlS6e0XvFS0mY7ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="169713839"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 21:27:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 23 Apr 2025 21:27:36 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 23 Apr 2025 21:27:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 23 Apr 2025 21:27:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqP0LRRg4al//vpCtal0KUbFo5qdLs91Xp/4BRBX2teKQMkTVHtlLpWCwPgYTHka7RAI3cWUdc1pUG9poVUmS7FL7f3/edq72w5olXAoLKkpIf1LSGvhSylCEyokExwsm7KACy1QVEjDYSm27vWkXbguVKjvUA9Jd8+5d9b/ffDHTCDEOUVGv6mdlLraedqS9o53Kwv8i06A/I+UFmg/wufCW8AEnxWBQfWJndwyyqMhNAcBiar4KcRLFntjMkuIPfQOgwnlxasb1wojGdw3IpYXLBvDz6KbMAbnifUSln5+tRV6HIGdL5X1CVRn5STZA17/PJyvvRBQ09O4buDdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0sOouCA2QQWK9JzpwLRNING53q6dzD23ZVjhdmntDk=;
 b=sA7HDn1SauUQVXaRWNugef6bs79B/JxzTT0c1YrxAw7ByrJE1JE5YW4yZYuBWAGqd0mBLcpSjgAu1s694h8zF18CykO1dqjTkEHAgyv3QQjLowGnLfENDYJUA/vjrasoU2pbymvfHGwuuYsvFKtYl/Y3S7R1WdTMeN3VBM7IWmYNkkWsGI+GyqY1HMdxmG7J8G5KkzEGq7xMbF2uv4OgefkknujlRpFLAjDgjIlwjqieKAK3K0u1dKNLb9ilbWOxvWmqyTzQrebe29qqJHeXuXJhqs97s0tzq9Okf2NipQSuB3tSXXdVN1K3rp+AHCwxYlvWYsSdnS1eZjL/KjOpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5966.namprd11.prod.outlook.com (2603:10b6:8:71::6) by
 DS0PR11MB8070.namprd11.prod.outlook.com (2603:10b6:8:12d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Thu, 24 Apr 2025 04:27:28 +0000
Received: from DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca]) by DS7PR11MB5966.namprd11.prod.outlook.com
 ([fe80::e971:d8f4:66c4:12ca%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 04:27:28 +0000
Date: Thu, 24 Apr 2025 12:25:28 +0800
From: Yan Zhao <yan.y.zhao@intel.com>
To: Ackerley Tng <ackerleytng@google.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <roypat@amazon.co.uk>, <jgg@nvidia.com>,
	<peterx@redhat.com>, <david@redhat.com>, <rientjes@google.com>,
	<fvdl@google.com>, <jthoughton@google.com>, <seanjc@google.com>,
	<pbonzini@redhat.com>, <zhiquan1.li@intel.com>, <fan.du@intel.com>,
	<jun.miao@intel.com>, <isaku.yamahata@intel.com>, <muchun.song@linux.dev>,
	<erdemaktas@google.com>, <vannapurve@google.com>, <qperret@google.com>,
	<jhubbard@nvidia.com>, <willy@infradead.org>, <shuah@kernel.org>,
	<brauner@kernel.org>, <bfoster@redhat.com>, <kent.overstreet@linux.dev>,
	<pvorel@suse.cz>, <rppt@kernel.org>, <richard.weiyang@gmail.com>,
	<anup@brainfault.org>, <haibo1.xu@intel.com>, <ajones@ventanamicro.com>,
	<vkuznets@redhat.com>, <maciej.wieczor-retman@intel.com>,
	<pgonda@google.com>, <oliver.upton@linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [RFC PATCH 39/39] KVM: guest_memfd: Dynamically
 split/reconstruct HugeTLB page
Message-ID: <aAm9OHGt6Ag7ztqs@yzhao56-desk.sh.intel.com>
Reply-To: Yan Zhao <yan.y.zhao@intel.com>
References: <cover.1726009989.git.ackerleytng@google.com>
 <38723c5d5e9b530e52f28b9f9f4a6d862ed69bcd.1726009989.git.ackerleytng@google.com>
 <Z+6AGxEvBRFkN5mN@yzhao56-desk.sh.intel.com>
 <diqzh62ezgdh.fsf@ackerleytng-ctop.c.googlers.com>
 <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aAmPQssuN9Zba//b@yzhao56-desk.sh.intel.com>
X-ClientProxiedBy: SG2PR01CA0182.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::20) To DS7PR11MB5966.namprd11.prod.outlook.com
 (2603:10b6:8:71::6)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5966:EE_|DS0PR11MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: b2d98dbb-fafe-498b-061b-08dd82e85283
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J8WbDRG8buwhC3qhiei47lLE5d4rbxIRXUoVHbqp94zdAgpypar9FiBwidPR?=
 =?us-ascii?Q?nHDSDznIOX/CBeEaphrJj/N7ocsEHP7i5WUCND1n36aoaL0phSiyn07cWItm?=
 =?us-ascii?Q?tKghGdasi23aA6f8OeFG15XK1RIxRzI98bCBR2bsF9CC5EofWG+yDhpsJRXZ?=
 =?us-ascii?Q?kxqZVokoostxCuYWo6g0qj39Um+RtQkIWwsWfrvdxyU+h05mY8mDbO1rntVN?=
 =?us-ascii?Q?Gss+xeiZrEuCcwm9MzCRkm4WbH4r6RtZYrgI3zdOwkLwkeMcWnUVZHtqs8WL?=
 =?us-ascii?Q?3/lvtAMW8rxWBYKfzziOA5pEujsJTYjXGFRQ1s3ZgHjfKxLu4h/uUKaz6VSt?=
 =?us-ascii?Q?rfYud401mJXChD24s1o2igwb4pbm7GVAbITQIHMSCTIduTDMdL7W3uXhPToB?=
 =?us-ascii?Q?2LC51Bz34uDcZkZmtIAQezBR56JV8rGpMCeuZ05SK0VAaaVTz67IW88Shx4N?=
 =?us-ascii?Q?e3hcswxlMxdsJBD5A7IyjuTBsurD9MqpZGUh/+9l68/m+CZlOMYFRhPblamc?=
 =?us-ascii?Q?GiE0dct8CHxgbPIYbcppxCSBDpon3BICZ+/oKUEIjwWgbZUoirrLYIq3n8F6?=
 =?us-ascii?Q?oAWYf1KD0eZu0wK2Yms7JKvAYfgMJrKhNA0CQ+2uKJs2/bz3mo8rFN7Gyo9v?=
 =?us-ascii?Q?rVrE49l4V7U+waCm/JycyJi2v/jPCc+F7o+JgLy4HPo00aaS6L5Jd8GJZJG1?=
 =?us-ascii?Q?18IEoG4UiThob3OvYXqLYLYUmfZu1bIQXDgfHjcfNqqS+339emB9mLtlMqH8?=
 =?us-ascii?Q?082YO+w+YRnwrHj2qfwunu7VacFV7pQ931CgfYFV+JLFdJczUjzxSPX0Irp2?=
 =?us-ascii?Q?PLOUw7bKIpFq+LpmvV0ZMU7frbfVJgEIG6MbqjHgsM3SQ38veEw+sDcwAqsd?=
 =?us-ascii?Q?h2o7EtCTzAQlW/DC7SicH0ZEDsLFZgEAJZimuhj1WD3XBUH2c6TFMYDZWeB0?=
 =?us-ascii?Q?iGkLH+nptSobU6BwRk6T7LVTrL49EROSVCxleucYONGqJc46F6I7tARllF2K?=
 =?us-ascii?Q?VvgLxZnMWbrgpwQ5AUACXptbR6skctUFhx5dEZSkrBlMvDVRNO4I7XFAhuvk?=
 =?us-ascii?Q?LeFCMs4VkCgmjRfKDiCSKRgywS0qw/C4ZGbq7bpRGVttb/p9RjPOscATI8e9?=
 =?us-ascii?Q?i3LLVA/MVBn48MymURTVgXkAuiPHh9iJ7a4/785tgtusm8tfxmsUfX7pB+8R?=
 =?us-ascii?Q?kHD3KxF92BJ67xogenVW09JDjunFFJeGDEhcl6yGfPyVeXvRCuFSJzlmVGuv?=
 =?us-ascii?Q?gA17x6uKjEelNznBHbcIfBC6SvOVhy4L2+2/KjzaV0Nbqc7Qo54wo42cupGr?=
 =?us-ascii?Q?XyWCTZ7bTApMvgBt91q40JAAv3rRDRFX4DAr5AMmg/tW53DaPjNf+40PGwS3?=
 =?us-ascii?Q?6TCMxmlWx0euEjaHizet1d3RxxQNtjxsQojeopGDwcQR5HI/lJvi7UeKvmBR?=
 =?us-ascii?Q?yF1e9Q7hDkpQD7p7o6BR/SMNLU9KKC6kIM803xLdRAiA4afYyXUxyA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB5966.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X0guJKnnUDNNrNg86JuOUeY7GQIk99rExSXwVthClr5wxsqBLFQkWQYA3RnR?=
 =?us-ascii?Q?vFtJh4FvFPjG+QEQFZLPvTRtU/7axQd4nwmQThjRjNNtN4Xnn+3gZxIPNsOh?=
 =?us-ascii?Q?xnqnjFqa9yBlDNMWefthfEjKoVvxJxGVMXhpZL47ihPgmB/4WPecDs5SQffY?=
 =?us-ascii?Q?F8fTDF38GDIJftXrfp75DcsDL7vKCng+V68VTo2v9xS5TeLUGMuUCjjP3a6k?=
 =?us-ascii?Q?W70v9zQB9qYqt/9BKvJy9JP3Iq5ZlbNisDi4yHIlficYBOEXrwa/Ruv4zCn7?=
 =?us-ascii?Q?MaYOaSuqTL8JplirwKU8MbgSu/uk0AWnqWjnXWrahbT2BKte7qpSsUVKx2VB?=
 =?us-ascii?Q?1NFS7OhGhe1FjDe8bXCGq1W6TPLlshXWmqEnOJNgjxaL2OgMm7IbASQjUHL2?=
 =?us-ascii?Q?+rlUbn9TUL4DD7UlGv4YXT/BVVhUiHrf6QAfWAF4YINzBFoYK70HG4I5dc//?=
 =?us-ascii?Q?Fxoqh2g7rEvrrGtZQpYPeERTK2nQ5UNRp06WWojHbYiPBM5jjbQsYYK9TebX?=
 =?us-ascii?Q?/MW1F7Zz/Yf7AN9tWEunF7M06CKvwBTAvu6k/LkRLyLULdupsqkDhWn2XEMh?=
 =?us-ascii?Q?W5g4yMmajSifJ2TjWRAAYMXsonOjtE9ZMts5wxeZNmNI9UDsKlhYtW/tXMlz?=
 =?us-ascii?Q?x18p/kuRVAsxbDe/BTgpIsjdJA1LwEcP+n4glipcp2LeWtaU0dzY0T15FVF7?=
 =?us-ascii?Q?YzZR1RxxgC0/xkRZWu7GqY++7v+98WOT6rLsVkBaFABaPreLwO6gGvqDx/bu?=
 =?us-ascii?Q?KkdOpoCfhvGRq7krDsheJ+XhgXs2umAWlO3JstAfjLCC+4e/iHJxVQ9XUOFW?=
 =?us-ascii?Q?EmomcnyfSxASe6OKZzYaMhPOaF0Dmer31W2S62rRnFJGV7cYLtUFDV9sSBAD?=
 =?us-ascii?Q?Wn+jawf2lD3wVDUXWP37syzGVjv1R0/C8kIlVGfBaJAUoC0vAasOTPmEkZj3?=
 =?us-ascii?Q?FNsOx3h3gs8jE3j9ZqROC8KvOQiSEdQ5mIWzvM0+GXq3CaKwXGHcMtrdjPTe?=
 =?us-ascii?Q?9uNMv/hkeDKc5coX7u0v1RKuRT6+vM+sEIXBIPewOh+YEQ560CqxhWD/Wk2p?=
 =?us-ascii?Q?mkKp7VGWZf4tkANHFcZHxcH9AMLUx3IfzVSwodTlk4LvjHiPva8y0LbIdqth?=
 =?us-ascii?Q?RRExxt8XZowgiCkV05WNBbmsOnde01duO0CmLYAAh/J0wthJJ5Ww7Rv9wwtm?=
 =?us-ascii?Q?IAhO9X9ZLM8mSg+xMzSZO1pv4bj3lmx4ZTwjL2XgygR8T+Z63USD/wFYWZYW?=
 =?us-ascii?Q?j6cwDcWJOgUezc5ZpsYs2FyceWqkFK2xIj0d2zx41R5VrnQbwwD74PXEY08J?=
 =?us-ascii?Q?2MTKV1jdV1Sa7Yps5mdg5hItM9pbQ9npzy35wHX/7DKhfI4r89kwEA+4cAsg?=
 =?us-ascii?Q?PI5HG9MBAz6jOKXDREORqwATjw972JA0koKp5SRFnNyd3Y9fVa9x3F4VxcNh?=
 =?us-ascii?Q?QrEMCEHaYk9pi3HZeMMkDIwef+QnhWP55sW4QYq2x811Xoim7Yr4HcHsEBoe?=
 =?us-ascii?Q?1w8kKE0vofQ81LZVsAmNs04tHqV87TpfYVW1XnpxKk5ZdLWo7+i4Objape8U?=
 =?us-ascii?Q?+O/W3KBSUo38e8TCvnMOiP27Scje/l+K8CHFt4T2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d98dbb-fafe-498b-061b-08dd82e85283
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5966.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 04:27:28.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNa3g2ONnLudm9oxZOv5Mksa2DCIgbF5rC9+QiSMoRPb0WBG1pe88CuH+oUHVd6iO55NOubEfL6Bp+qqs9chTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8070
X-OriginatorOrg: intel.com

On Thu, Apr 24, 2025 at 09:09:22AM +0800, Yan Zhao wrote:
> On Wed, Apr 23, 2025 at 03:02:02PM -0700, Ackerley Tng wrote:
> > Yan Zhao <yan.y.zhao@intel.com> writes:
> > 
> > > On Tue, Sep 10, 2024 at 11:44:10PM +0000, Ackerley Tng wrote:
> > >> +/*
> > >> + * Allocates and then caches a folio in the filemap. Returns a folio with
> > >> + * refcount of 2: 1 after allocation, and 1 taken by the filemap.
> > >> + */
> > >> +static struct folio *kvm_gmem_hugetlb_alloc_and_cache_folio(struct inode *inode,
> > >> +							    pgoff_t index)
> > >> +{
> > >> +	struct kvm_gmem_hugetlb *hgmem;
> > >> +	pgoff_t aligned_index;
> > >> +	struct folio *folio;
> > >> +	int nr_pages;
> > >> +	int ret;
> > >> +
> > >> +	hgmem = kvm_gmem_hgmem(inode);
> > >> +	folio = kvm_gmem_hugetlb_alloc_folio(hgmem->h, hgmem->spool);
> > >> +	if (IS_ERR(folio))
> > >> +		return folio;
> > >> +
> > >> +	nr_pages = 1UL << huge_page_order(hgmem->h);
> > >> +	aligned_index = round_down(index, nr_pages);
> > > Maybe a gap here.
> > >
> > > When a guest_memfd is bound to a slot where slot->base_gfn is not aligned to
> > > 2M/1G and slot->gmem.pgoff is 0, even if an index is 2M/1G aligned, the
> > > corresponding GFN is not 2M/1G aligned.
> > 
> > Thanks for looking into this.
> > 
> > In 1G page support for guest_memfd, the offset and size are always
> > hugepage aligned to the hugepage size requested at guest_memfd creation
> > time, and it is true that when binding to a memslot, slot->base_gfn and
> > slot->npages may not be hugepage aligned.
> > 
> > >
> > > However, TDX requires that private huge pages be 2M aligned in GFN.
> > >
> > 
> > IIUC other factors also contribute to determining the mapping level in
> > the guest page tables, like lpage_info and .private_max_mapping_level()
> > in kvm_x86_ops.
> >
> > If slot->base_gfn and slot->npages are not hugepage aligned, lpage_info
> > will track that and not allow faulting into guest page tables at higher
> > granularity.
>  
> lpage_info only checks the alignments of slot->base_gfn and
> slot->base_gfn + npages. e.g.,
> 
> if slot->base_gfn is 8K, npages is 8M, then for this slot,
> lpage_info[2M][0].disallow_lpage = 1, which is for GFN [4K, 2M+8K);
> lpage_info[2M][1].disallow_lpage = 0, which is for GFN [2M+8K, 4M+8K);
> lpage_info[2M][2].disallow_lpage = 0, which is for GFN [4M+8K, 6M+8K);
> lpage_info[2M][3].disallow_lpage = 1, which is for GFN [6M+8K, 8M+8K);
> 
>   ---------------------------------------------------------
>   |          |  |          |  |          |  |          |  |
>   8K        2M 2M+8K      4M  4M+8K     6M  6M+8K     8M  8M+8K
> 
> For GFN 6M and GFN 6M+4K, as they both belong to lpage_info[2M][2], huge
> page is allowed. Also, they have the same aligned_index 2 in guest_memfd.
> So, guest_memfd allocates the same huge folio of 2M order for them.
Sorry, sent too fast this morning. The example is not right. The correct
one is:

For GFN 4M and GFN 4M+16K, lpage_info indicates that 2M is allowed. So,
KVM will create a 2M mapping for them.

However, in guest_memfd, GFN 4M and GFN 4M+16K do not correspond to the
same 2M folio and physical addresses may not be contiguous.


> However, for TDX, GFN 6M and GFN 6M+4K should not belong to the same folio.
> It's also weird for a 2M mapping in KVM to stride across 2 huge folios.
> 
> > Hence I think it is okay to leave it to KVM to fault pages into the
> > guest correctly. For guest_memfd will just maintain the invariant that
> > offset and size are hugepage aligned, but not require that
> > slot->base_gfn and slot->npages are hugepage aligned. This behavior will
> > be consistent with other backing memory for guests like regular shmem or
> > HugeTLB.
> > 
> > >> +	ret = kvm_gmem_hugetlb_filemap_add_folio(inode->i_mapping, folio,
> > >> +						 aligned_index,
> > >> +						 htlb_alloc_mask(hgmem->h));
> > >> +	WARN_ON(ret);
> > >> +
> > >>  	spin_lock(&inode->i_lock);
> > >>  	inode->i_blocks += blocks_per_huge_page(hgmem->h);
> > >>  	spin_unlock(&inode->i_lock);
> > >>  
> > >> -	return page_folio(requested_page);
> > >> +	return folio;
> > >> +}

