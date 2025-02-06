Return-Path: <linux-kselftest+bounces-25943-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A70A2B234
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 20:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C713E18866E7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 19:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD9C1A5B95;
	Thu,  6 Feb 2025 19:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eif1weWK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAAA1990C1;
	Thu,  6 Feb 2025 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738869821; cv=fail; b=udHgtgPn/gbjZ3bLiDXjTRSbpxIWMCUeh9VwnceIj89aNMVAzfBUbPwg6N86m+bB77nX6CLcYd6QkSjDOikA46YDW0RmNrlHnBKfm/Fw5ob7Phy6kXP1xB+sJKwNGjAJR0SEFDrGAcMqtk3FeBn3RY1MoUXlx86HI+PT56qHIrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738869821; c=relaxed/simple;
	bh=wJGI2bLXyHmfSwJy/rb+BsVOcR9LZItNYcLw9ytE4cM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4Cyq/umwmFQowPuNcOnbSgJ977tnPir6HlE/gE9B7VAsAS8pRE+B17H3QVZJonEi2eAcxwFkXtTSsIh9r8QS/WsuomtgeJUzTO/nrKHiI6S2Z2LVChtbMf+plLWjryaRBNNChExSwCVXSQh2lxpz9ZSLlRYhZebvFhRsvVAGPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eif1weWK; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738869820; x=1770405820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wJGI2bLXyHmfSwJy/rb+BsVOcR9LZItNYcLw9ytE4cM=;
  b=Eif1weWK3XCRZOOymtuYZvvOD1phCfSontIXHO8xKK8IMAp3ekLv41ha
   FjBnF0jJafg4BHJXPvMmJP+UJPcoMB9SIU5LFiYc3APgmdd9MubJej+NK
   lPVkMbqzR6wlWOGMw3+wYMfVmQVOou/tnoM9ejrHEupzTGnWMRlIZdaT9
   NCZO3WsoUiCR4gOUjia6Ae72e8aX6V6qc4YdCWDKo0kBBKC6Gp4EYqao2
   I29/7AnRiM8vVijZ8uzGGHk61JfgxqD7PHJNbQucLrdthzF5PpwD3r3Li
   yzFvVMWTHhikFx7PyL5uPoIBAR7x9nQsRIVPJYvH8phmI46QOljsFkbNr
   A==;
X-CSE-ConnectionGUID: 13mv77xZQLqrSNB8TQmSGg==
X-CSE-MsgGUID: AfHy6kOqTrupza3fH32dPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="27100961"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="27100961"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:23:38 -0800
X-CSE-ConnectionGUID: tsCISfg9QIiO4rrWuF0NcQ==
X-CSE-MsgGUID: BG2SBAMPSnu6yvO0K+BNhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116244381"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 11:23:37 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 11:23:37 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 11:23:37 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 11:23:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A1oFq3H5oILOI+HhxqBPuIxrG5aeIuqjt5jCas4BsIh6+lz/ffbeXE81qoBDHh3uy2OMuJOdM4Fx6711zFIdL5C18UqHm1r31cgy0yckV/peT5BuldKEEXSmoyA8f9pySz9iIZPKBE2N1zIXDADHCC5mRlEByaA71wSjLpJHMAvpy+tZEkZNS3jbgQ53D7dlb5uFD8IFHTaCnSAD50+GL8TCV/YQrIgtV0DpInO+5XNHW1j2UXSn4tYmSZkoKKhFUX63fa4jdjHeJaxslKcnGfmNShC5LM797yoV/U6lP5RIHMqZe+ZdFJvtixxChTOFKJBpTeOKQ19X4BFYjxEf4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGocix4Dy3akd96wfOPbWvVNDRO0QUOOkAtI2xPbqC4=;
 b=WzJYk+RKt0T4L2CX5wd2FujPip9Xuj3QEpo5ajQCJRGNXhBaEuvr0L1NdVoivc0U/WsSXbCQ+I3B9qBVFfgGpHfZ1Axmwl/Cy+kgqI+/Bc/5xBxvvYMDZgLw3jcKI2DoxZFws3w7pOkF4A4pbOmmWo5Iv/U/BNIen91YiQ+bA1G00fBPvTtKE/Q81390YPOi5UhZSnn/c9aFRCFM/3xVm22R1iWMUL9Dx8UU2bMficfUrv4wFZXNSf9HDwtnko7R9oiHyZelu0oGy7N4o0ANcgZMmNgsCpKmfdrKAJpEIdTrtLi+vH+t2AMokfp5SMxRxGhZDyOz97lo17j53OS+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by CY8PR11MB7081.namprd11.prod.outlook.com (2603:10b6:930:53::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Thu, 6 Feb
 2025 19:23:29 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 19:23:28 +0000
Date: Thu, 6 Feb 2025 20:23:11 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Song Yoong Siang <yoong.siang.song@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, Florian Bezdeka <florian.bezdeka@siemens.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Bjorn
 Topel" <bjorn@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Mina Almasry <almasrymina@google.com>, Daniel Jurgens <danielj@nvidia.com>,
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>, Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
	<kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, Bouska Zdenek
	<zdenek.bouska@siemens.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <intel-wired-lan@lists.osuosl.org>,
	<xdp-hints@xdp-project.net>
Subject: Re: [PATCH bpf-next v9 4/5] igc: Refactor empty frame insertion for
 launch time support
Message-ID: <Z6UMHy++k9+x68Tr@boxer>
References: <20250206060408.808325-1-yoong.siang.song@intel.com>
 <20250206060408.808325-5-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206060408.808325-5-yoong.siang.song@intel.com>
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|CY8PR11MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: f44d95cd-ea1b-4ace-0049-08dd46e3bc3d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?67lYSvcVo/LcU4J50QMQzOEOnpLscll2Kn9O376775jhs0pJvvoq97wI1TXC?=
 =?us-ascii?Q?Nmc9nu7z9McWP95dUV9Yzs5pzUC3rC90aDuJEr4rZRt9MqdlBEXnr4PFZIH5?=
 =?us-ascii?Q?WIUunn3cMEciQ4wvqb4NDce6vr21z1mKQh+U+rYKJ50+9aMWXo0l3szgkdXh?=
 =?us-ascii?Q?JCaXLROCfXGOQNE1Zz7huo9Rq/CCqRrhTuLRuta1bhS71IxSgW1d099NkXVV?=
 =?us-ascii?Q?ld/0B+RAoQhCLuF60EyOtZVylbfivyB9FPOOhTF9/0bzDYrt7jNhqo2mIKGV?=
 =?us-ascii?Q?8MXZabQDhUZt9+98nRIZzdFZ05Fufc3V7KnkOgF96ZMNBX2tpmh/0YQ1LFoU?=
 =?us-ascii?Q?f1VFCD9r/4+7WogxL6GDIdj3R0UlKZwryDtmHlIIxBq9fMIRm6XDxQbJpMwi?=
 =?us-ascii?Q?LC6nD209ZFFWzDDaebujRjbBmif4gRNlDQAVns/yieedmBTbn1Y/3lZv/m3q?=
 =?us-ascii?Q?G/N9Lzhf8OeZb9VBvV/lkdl38D686LJ7meGUmM84wv8+1SlZmLLq3BPKy2fn?=
 =?us-ascii?Q?x87ZiZttbZTN1n9m1O8DHbimGOsD2yUz3l9Ib4pG8IyJktt75ldpXh2QyQcV?=
 =?us-ascii?Q?T8wrVsEv9VxhBBxX2tlfTbbQ6iLtDyNBFjbErLThlVKn3ZwDV26t2SH/Xz9t?=
 =?us-ascii?Q?VkqIh8aXyQWQ99g3eyFj393O/HXNv9AU5eMA3ODbooleVG6fDloBo3CyHtrf?=
 =?us-ascii?Q?eyj86w71ymie2hZiCOusxD4ooBs6w3luZo6rdT0qkDGV9o65jUdGODY+zqy3?=
 =?us-ascii?Q?6EuFPvy/1qzXGyQYcpoDGjALr60NiMPutDLEDSau4fHg9zDAWUvJO2z2vvkF?=
 =?us-ascii?Q?k1AAVYXVEygeC5lUBRfmWUt4pFnSvP0rMWTSf/pVNU7PxO78j4lsK6/WAQOF?=
 =?us-ascii?Q?u9tfqY7OHssPlWh9GC45WZ16yUk+jiUsWy65JDgxjnJ/sqGX2UD2t5g5TI1u?=
 =?us-ascii?Q?REHMoGJsf+SvKa6EbA0tiMzQxGV7MErF8QmY7SfK8jkM5o2aAmq2GGwDwtCX?=
 =?us-ascii?Q?odK82J50Pj2noyLAGhaZzlz98JRSpOQfc9WTBQB/yjE+rRxpkVylT7axWo3c?=
 =?us-ascii?Q?P3/3XLQUbllne2MwmPifRKszbNDdpR1YzaDFqH1xIq9UdOz9FE6szC6NkLcI?=
 =?us-ascii?Q?vFhKuSsEliZkbgfs9MyRT4ZTJJDp+Pb6PotxOCQiTkEIQDSOl3rbhwoFOnOn?=
 =?us-ascii?Q?DxJOz4L8YWcleNAycgywdY5Uz+miBIKDkNvGdnQLu13dWHq0VjMkRYxfJiWo?=
 =?us-ascii?Q?3CXlHoA/Z/yhrWSiid1OjLN0iAi97o7gfbGM48Fddkt8pyevH+JybEiTidHf?=
 =?us-ascii?Q?26Dmshn2SVBSnj8m0pKDH/Z6KXpcffai6pdezR3OL28zxfiA1gQ/w3h7k5gn?=
 =?us-ascii?Q?+CJoKjDqXpsVRXESghM5q5g4OZT/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0/eUakziOMjt4rUAk7d7qTa576LjHVPrX2ECZikm9NYAS1XFI4yAzmzEZue/?=
 =?us-ascii?Q?0AZwguJP3/+8gAi0vUf+bNKnnRCoLlLrRyUbv1dmr+7Ek2UtYJ2zzwwvNygM?=
 =?us-ascii?Q?oLd4gpyzlC0d1AUmib7WLuIB3J+Sm3HLnsuQ/XMAJbJMmQRsD3cCZoWyfrtI?=
 =?us-ascii?Q?BLF1Kyrqn2xDPiQKPykNt9k6pOGO9P+T09bVrmXLO+cQh/RCvgfHBdLTDRRE?=
 =?us-ascii?Q?jXqRJLr5HO9Xk/4i9BVcQ/jVPTrmlFq7BsVVEIZ0FMtS8L2DDEWmViNpRjFG?=
 =?us-ascii?Q?Lzvo9wqBR5fmlbkHkYfJuE+2uWA1oc3OcaigeH4/hm+EJj4xtSJfOBBdDnvr?=
 =?us-ascii?Q?r9qZyEHigUVVv22juXVUFuMERGJPiCIWzsFNqFamUdzGegC0GF6SpvG2H3bh?=
 =?us-ascii?Q?angFOBhw2B/VX74l07Ps0jm8U3A0aQsB3c6RPR9Q2lYt02i9CTaT1v9dIZp+?=
 =?us-ascii?Q?CpHSB6kgoLMqFWq5PWe/+Cj1w8tv+FmNH0B7BRnrXBjzVLr77kdFZB6G9ugV?=
 =?us-ascii?Q?JNeetj191yy3vr70sVX9fFM7PLtNbZ2smF8ohbb/a66s35B8l52bYzcS54tK?=
 =?us-ascii?Q?VSANdNdkclS6JXb/9DekBDzxwW+OmJqC8dDF2H0kjCpF2cTFzZM6B6DSR6Vl?=
 =?us-ascii?Q?nWrqZsnhasHo+UZVfSvQBowGIUhm+ft7Qsak7gZKJidTO8U0u1xRDujnoWNS?=
 =?us-ascii?Q?4m3avqRZpWepwt0jx4W+Eh7owvrtMVOJw76JKm+pIR85LrEmx4Nr7dJFmrBJ?=
 =?us-ascii?Q?fnGOu39ka8s044KY94SoNtcsM7gy8q/Q6MeAWrJ8JcOG3o2xuRi3yxRcGGFZ?=
 =?us-ascii?Q?+nn+iAqGFE211jIBBQAKS6k0S1m2YyGpG5d0ZoPq97qzDaXf5UAQd0GAApFF?=
 =?us-ascii?Q?oHPEd3uc3kAi+XK+fkkt761wrAn1SAO6aTKTzD4MqAnmQB57LBV1HhBxcvDk?=
 =?us-ascii?Q?+65hN4hlztdGMlrqJrLWqMUOqdaO5FHRjIozTrmCara/jDjG3KvLLFooB3ta?=
 =?us-ascii?Q?78T+OkL1jXri1bnDC3C6CRMQxL+m1XXZU3w8jE9OthvWXzVXzUdjyIUNIMNb?=
 =?us-ascii?Q?hol8AHmtYPtcnY7ZSvRe25biy2/ORV61EIstpWsQe+syiCeHs6j1q0sJHA8T?=
 =?us-ascii?Q?HguBIp1KnE7PB5XZRm/PokC3WM9p5vuj9Dd7IOBHqTpeNm7uq/cXmlU3wBzS?=
 =?us-ascii?Q?fz28jIlQxUmydbk1yCum02yQY9R/ePs3dlW7HiyqmR29H0GArmNZIzqxP5e6?=
 =?us-ascii?Q?QY4NdZTbSM/P4pwXJOXlf2bCE6fzelUkWlyYHsZ22LG+3u0tj7R31PvvYQs8?=
 =?us-ascii?Q?Q8Tyzu/EBOO6MLP+A+QG39gOAB3PS2eTAlh9vSvUWx9C9VKpYu36nKW/BHfZ?=
 =?us-ascii?Q?xls/s6dTB+gJFbzH91ibPFM63YGjWVBcfWJEi4WAMEpNxnqHZaxLGUTeoKiP?=
 =?us-ascii?Q?62Q94Qk+TySheMXV5lybtf6xmJZexwRSHHGDbLhqRSAuQuiIqXF0VYCgJvPX?=
 =?us-ascii?Q?5I/cK3BKaAIsbjIM3g8TxWvNwzgCWq8mJOQB9o7C6X1eUjJJLEILqlFT1cCd?=
 =?us-ascii?Q?OaZ6LpJZGR2ci/ZqdHeaIZpVg3i9nil3MUJ/9tIomGizszQpWVgnj90PoeKs?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f44d95cd-ea1b-4ace-0049-08dd46e3bc3d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:23:28.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o/U56XOn53Mf28yb5L+v3REzx+lbcCIlkRVXfZk54ANpTbmHfHa3vDtGwizmvWbmbMVO1nMXAs6B64NWhqIqtM07PMWLycMeHSqyfQc+SpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7081
X-OriginatorOrg: intel.com

On Thu, Feb 06, 2025 at 02:04:07PM +0800, Song Yoong Siang wrote:
> Refactor the code for inserting an empty frame into a new function
> igc_insert_empty_frame(). This change extracts the logic for inserting
> an empty packet from igc_xmit_frame_ring() into a separate function,
> allowing it to be reused in future implementations, such as the XDP
> zero copy transmit function.
> 
> Remove the igc_desc_unused() checking in igc_init_tx_empty_descriptor()
> because the number of descriptors needed is guaranteed.
> 
> Ensure that skb allocation and DMA mapping work for the empty frame,
> before proceeding to fill in igc_tx_buffer info, context descriptor,
> and data descriptor.
> 
> Rate limit the error messages for skb allocation and DMA mapping failures.
> 
> Update the comment to indicate that the 2 descriptors needed by the empty
> frame are already taken into consideration in igc_xmit_frame_ring().
> 
> Handle the case where the insertion of an empty frame fails and explain
> the reason behind this handling.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

with one nit below.

> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 84 ++++++++++++++---------
>  1 file changed, 52 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 84307bb7313e..3df608601a4b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1092,7 +1092,9 @@ static int igc_init_empty_frame(struct igc_ring *ring,
>  
>  	dma = dma_map_single(ring->dev, skb->data, size, DMA_TO_DEVICE);
>  	if (dma_mapping_error(ring->dev, dma)) {
> -		netdev_err_once(ring->netdev, "Failed to map DMA for TX\n");
> +		if (net_ratelimit())
> +			netdev_err(ring->netdev,
> +				   "DMA mapping error for empty frame\n");

This is open-coded net_err_ratelimited(), no?

>  		return -ENOMEM;
>  	}
>  
> @@ -1108,20 +1110,12 @@ static int igc_init_empty_frame(struct igc_ring *ring,
>  	return 0;
>  }
>  
> -static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
> -					struct sk_buff *skb,
> -					struct igc_tx_buffer *first)
> +static void igc_init_tx_empty_descriptor(struct igc_ring *ring,
> +					 struct sk_buff *skb,
> +					 struct igc_tx_buffer *first)
>  {
>  	union igc_adv_tx_desc *desc;
>  	u32 cmd_type, olinfo_status;
> -	int err;
> -
> -	if (!igc_desc_unused(ring))
> -		return -EBUSY;
> -
> -	err = igc_init_empty_frame(ring, first, skb);
> -	if (err)
> -		return err;
>  
>  	cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
>  		   IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> @@ -1140,8 +1134,6 @@ static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
>  	ring->next_to_use++;
>  	if (ring->next_to_use == ring->count)
>  		ring->next_to_use = 0;
> -
> -	return 0;
>  }
>  
>  #define IGC_EMPTY_FRAME_SIZE 60
> @@ -1567,6 +1559,41 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
>  	return false;
>  }
>  
> +static int igc_insert_empty_frame(struct igc_ring *tx_ring)
> +{
> +	struct igc_tx_buffer *empty_info;
> +	struct sk_buff *empty_skb;
> +	void *data;
> +	int ret;
> +
> +	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +	empty_skb = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> +	if (unlikely(!empty_skb)) {
> +		if (net_ratelimit())
> +			netdev_err(tx_ring->netdev,
> +				   "skb alloc error for empty frame\n");

ditto

> +		return -ENOMEM;
> +	}
> +
> +	data = skb_put(empty_skb, IGC_EMPTY_FRAME_SIZE);
> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> +
> +	/* Prepare DMA mapping and Tx buffer information */
> +	ret = igc_init_empty_frame(tx_ring, empty_info, empty_skb);
> +	if (unlikely(ret)) {
> +		dev_kfree_skb_any(empty_skb);
> +		return ret;
> +	}
> +
> +	/* Prepare advanced context descriptor for empty packet */
> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> +
> +	/* Prepare advanced data descriptor for empty packet */
> +	igc_init_tx_empty_descriptor(tx_ring, empty_skb, empty_info);
> +
> +	return 0;
> +}
> +
>  static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  				       struct igc_ring *tx_ring)
>  {
> @@ -1586,6 +1613,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  	 *	+ 1 desc for skb_headlen/IGC_MAX_DATA_PER_TXD,
>  	 *	+ 2 desc gap to keep tail from touching head,
>  	 *	+ 1 desc for context descriptor,
> +	 *	+ 2 desc for inserting an empty packet for launch time,
>  	 * otherwise try next time
>  	 */
>  	for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)
> @@ -1605,24 +1633,16 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag, &insert_empty);
>  
>  	if (insert_empty) {
> -		struct igc_tx_buffer *empty_info;
> -		struct sk_buff *empty;
> -		void *data;
> -
> -		empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> -		empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> -		if (!empty)
> -			goto done;
> -
> -		data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> -		memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> -
> -		igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> -
> -		if (igc_init_tx_empty_descriptor(tx_ring,
> -						 empty,
> -						 empty_info) < 0)
> -			dev_kfree_skb_any(empty);
> +		/* Reset the launch time if the required empty frame fails to
> +		 * be inserted. However, this packet is not dropped, so it
> +		 * "dirties" the current Qbv cycle. This ensures that the
> +		 * upcoming packet, which is scheduled in the next Qbv cycle,
> +		 * does not require an empty frame. This way, the launch time
> +		 * continues to function correctly despite the current failure
> +		 * to insert the empty frame.
> +		 */
> +		if (igc_insert_empty_frame(tx_ring))
> +			launch_time = 0;
>  	}
>  
>  done:
> -- 
> 2.34.1
> 

