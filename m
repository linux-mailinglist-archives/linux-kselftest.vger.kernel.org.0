Return-Path: <linux-kselftest+bounces-25694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD10A27598
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 16:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED593A6200
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790342144CD;
	Tue,  4 Feb 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frNT1Crs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442792144C7;
	Tue,  4 Feb 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738682289; cv=fail; b=efjk4klYqXFsUGYZoLNf2Jf0ZLFjTfeyJVjciBhRAIUfS43to+lLm8Rr+lo+sobqiqxPEPujHVqqyvF5wQSmRB7z/qrNonDv3b55ajdaLnTbY30mpGOSS0GUWIBiW/CVjLwGWlcSEeogziLIOhEg4zcFtaZzV8jt5SnvaCD/8Nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738682289; c=relaxed/simple;
	bh=+8hiVop+aK5xBEGOhgg3WfnvWBzeQb8KUQ9uWzAuasE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GWa9QU7rqoh9RHYiNgxpji+3954CudyndK3uO5LKJfVJRUtLfrpOdmJ73MPUcPc0nnzjl7diquuURWwUgb2E6zw2JlInxyr2oxLM/Ysv4yNvyRgveYHRaC+uu17NnshN7UM457xA/Uge7MuSJYnsGXaKV0AlrscAqY+Eru/GdzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frNT1Crs; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738682288; x=1770218288;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+8hiVop+aK5xBEGOhgg3WfnvWBzeQb8KUQ9uWzAuasE=;
  b=frNT1CrsVBte2/WrFFm2ECMokn72u2b11EgnJuM2lfy1yyDUsPU2/eB9
   vmBazVERfQxihxJzNpaE+16T0bzMRjdq821Y9bfYJkJ10JkhVBIRG1KfD
   nVRRyt/YOdWsOV5GthAhuieADbeJSpLiPeBCVEgX+aUHM99qBC8E5YsaP
   Oj7d6ZJrQWbLAygmaMBR+PLChGIEsrqQHAaiJ0j0vr5D8Tibb8JFklytV
   PFB0+I3D+uZNR4CVSrfiVVqyQYxpyVy7xogQ//l/Zi+ww+kEAxwnvGALs
   sw0jpsuPei7ZvwaYcRAsCdDr9rrTdwTmAoDKZeP8MdjLw6oZ9A1hlZMJa
   Q==;
X-CSE-ConnectionGUID: l4WQ3QB5Qfq2OVg9C84LBg==
X-CSE-MsgGUID: rknsOporTsmS2Px+mHC4lA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39098557"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39098557"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 07:18:07 -0800
X-CSE-ConnectionGUID: rU/Fm7j/QpOVTIjrzvj9KA==
X-CSE-MsgGUID: a7hJm1K9ShOU3DprXHggLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="110793793"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 07:18:04 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 07:18:03 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 07:18:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 07:18:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hu4hb9e7hTs9Wj2vVECIXktF9GmGnohrbAU+IYdi4EP4V6OHPurnLKyLK0RPpkCGeQmg0vVzAROle77+RoDWfXbWUS/c2KzX3ouVGh8PgiF67+7B/gGW20XBzIMTSES0424rJ38dH+2KrELUSR7PcIU0jXWXYmqQRpgDUuUrHWuGfb3S+6EpHmyhPnBZqis4XiKUEZEImbT01NO4xBcqwg1aiG0mRqxZ6rKj9RORBHngHFxaqxjty8eIytxOzDF0tkxFx7KCI4d99hCtWxYi8bVKgV7yalJcZD0BWnbR+BuDXqg8SoKPoLNbcmsErAlGJg0lzOcpF7PolGNkBkm4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Kk10XfuXCTrj3uLHAVBJpiCc9zLp1sSHNKOlXbZd1o=;
 b=TVXSRAzzGvl4KG8BAJYp7Df7ytIvOJi3mJ00vCJtGNXfhVmAfSUhgyF57IYR3a/PJL2i4i08p90+mB2Kj+8Fdyg6IBla1v8djU0r1jb7n339fFqD8+PShSbqiT8OVP7x1u+GRcx5Lw9Zbi6Im4kBSY0MujHT7lEK78MZsCe7KzBj0dCkcL+8wC2zSiUaMUL5NonvddgDcjC2LXOD3seBEzX3wmLQqAzNySkxf2AQLi5WER4ZurD4F45ob1mPXvIqc+EoEcN8E+n0rCDUXM4c19/2hBaEUs9dnMdNR46h7gOgTPSdHqpzPa9p92yd8W+vvN8iNvkXDQrw3Jl1f7DCsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4889.namprd11.prod.outlook.com (2603:10b6:806:110::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 15:17:46 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:17:46 +0000
Date: Tue, 4 Feb 2025 16:17:34 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Song, Yoong Siang" <yoong.siang.song@intel.com>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>,
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Bjorn Topel <bjorn@kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
	<hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Damato, Joe"
	<jdamato@fastly.com>, Stanislav Fomichev <sdf@fomichev.me>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, Mina Almasry <almasrymina@google.com>, "Daniel
 Jurgens" <danielj@nvidia.com>, Andrii Nakryiko <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
	<shuah@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>, "Jose
 Abreu" <joabreu@synopsys.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Faizal Rahim
	<faizal.abdul.rahim@linux.intel.com>, Choong Yong Liang
	<yong.liang.choong@linux.intel.com>, "Bouska, Zdenek"
	<zdenek.bouska@siemens.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>
Subject: Re: [xdp-hints] [PATCH bpf-next v7 5/5] igc: Add launch time support
 to XDP ZC
Message-ID: <Z6IvjrnVX2xSFHlh@boxer>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-6-yoong.siang.song@intel.com>
 <Z6HnaMQvgW+indqm@boxer>
 <PH0PR11MB5830422207B7D3BCB27DA04FD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
 <Z6IeNumqP1aNAphU@boxer>
 <PH0PR11MB58308B675B0B9B95AEEBF192D8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58308B675B0B9B95AEEBF192D8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
X-ClientProxiedBy: DU2PR04CA0312.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4889:EE_
X-MS-Office365-Filtering-Correlation-Id: 6846995a-1978-4563-f1d3-08dd452f13ed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8bm+Znmf0tAKNwWmgFsa3ltb8SUZk9UmrO0HdJYhsRJF8i0Y6oSZXH7IdsEN?=
 =?us-ascii?Q?SDbYC3BxY0HrKB763suj3xuvSGd8dVai+0dCIy1fDBtYs63Wf37tzvP+49y5?=
 =?us-ascii?Q?Z226+91G02PlT99tlze4jJQQ7gMVD5tIaFOEZGl0KKxY7Kl5F3nDTXkq47Ul?=
 =?us-ascii?Q?H4NnBRULt++65wjpkYGgzB9vWdqsPaDESbSjCrIxV9m7FKb3o0+Smn2H4EQ6?=
 =?us-ascii?Q?27cN7WZ2ylEz9Z7S5zvAAOxvMhrl1IOLfd7gP9OaYNBYE1OQ49m4VmQ7a4YK?=
 =?us-ascii?Q?IB0edNFu3fAeMd57nleppcxbE5f2N1BI46fKDrtFGGYRvg6VcuBUQQgvX+Eo?=
 =?us-ascii?Q?k1hWIOboUjvy2Oh/3nf1NAWMEJoec6bXSu64x0lfaJSahapg6bZj4HPcgMkd?=
 =?us-ascii?Q?SgPy+wr8MZSRlp1qgCrhQ0WZoQBP4SXJxVXfmeyMdoX189/NWzt+C133oVSi?=
 =?us-ascii?Q?aU07r5L80JzcM/2MI1WzUuS8iPt1IAGi+oyc3ncjo1coui3sjIJoRnBIeESY?=
 =?us-ascii?Q?kIrvDqQ8q4DGX4FICGNVKpOBSvDced66eKqDbzncnYF5gSUG7PNefJlqqSCa?=
 =?us-ascii?Q?0gNKP0c3bFkyMAtiPDTL1dIXvOVZ1hCQoyLxD/WchmAUcORE7hlsMUJeiv2x?=
 =?us-ascii?Q?bwIe1ZAfJUYkSndX7GgLRvEnaCOqe7m/gGPr4uE9NLmAIStfMBmGNAEJkUX8?=
 =?us-ascii?Q?Bgfh+e1Ck9BEu9O0E5jKud9YiHUtTcYmArYcONPN+18RWc8JmX7aQZoWFKq6?=
 =?us-ascii?Q?8HH4ZP5zKdyTj2GgAIFw9lzv4JVo/0BHxj/0+KlmOHtXnWF8mTSy/gXlFfMG?=
 =?us-ascii?Q?gIOHSHzrqtVr8Z7C9XeCVlSGm3W060U4xpjtOToO3nF/plA3y3U9u6c2PAIM?=
 =?us-ascii?Q?lDfrhaa5dc/jze4dTeAlIwu/0m3pJd16PhUa4zIotf4ZICZJ17t/vRVkKKlR?=
 =?us-ascii?Q?b6Intyk5/8eFnxeEIXx0y6F8P1YWcE5jb/EWRwj/FaNIjq0vg61O2SN+sGkI?=
 =?us-ascii?Q?+CfgnVLVbN41ssJkNe/nKg3ZKHHa50QiiBbAM9rv6V3ZR2XqfZFW/fjtxA+V?=
 =?us-ascii?Q?t1XqtKTzK+i5BmEban0xGLCcpyBudL5qjxehrq99B4vzV1MbwiCiZZgiUtDt?=
 =?us-ascii?Q?+eSJOCMS4bsHN8iJbgKbdx8uqyizahDUEQiDb3YMfuNbKlJd/LdDk6e9tVX7?=
 =?us-ascii?Q?/R3/xyYjBdetckYg8KS/0MO/ln0GzWyayMAlhDDUMtIbuu3BrLNcL39KGTH8?=
 =?us-ascii?Q?lHPeCVcH1ekUoKZrMVckihLox1cmhfF5EVbjSkmQ58efjfl/kEFBHi153ks3?=
 =?us-ascii?Q?z1PSR61uhoEt4a8vfIPu/Dr8qqaPQsfczF8PgVaRrOH4BW7akjdjz55Bef3K?=
 =?us-ascii?Q?V4X4XuFlo07qLc8qBZuNltUD98Af?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5odHOVo+EnBKmMaQKUulTzhp5QOctk/MRP0lr3pcOC5DwmrOvzs3GD7clR87?=
 =?us-ascii?Q?LpENAXHCa57cSJMNejAWSaCQdbwTGg5g7bDBkIEtWUY5X2yMravLkwmPz2Mu?=
 =?us-ascii?Q?f9AIOf+J/DLputLApVJlG4ZkrQPr3e6pJYIa0IgCbShbZn0l1x4gLU2HTe93?=
 =?us-ascii?Q?bQ3Ma5AEtbKLnh+iSuFDhOmS33F9nSK9KZvuyvjCgMGajfa9LdlVaYyxCR5l?=
 =?us-ascii?Q?4M9F8mWV0Hogw8yjeEmSoBN6zU6noZ958QiZAn3/EReKqBsypxqPSqJVDfNS?=
 =?us-ascii?Q?pLEjlbm34wg9ltcqF6EwP6mwZr9yzNnjIWRNqjCsDPCjz1HPZjmCA5gtDXYr?=
 =?us-ascii?Q?CrLrVJlMu2+Ajm1MO2+Ql6CjCtrMFLSUEJ2xY9ECO60N61iNWka76gIk6Ora?=
 =?us-ascii?Q?kZYF58rMRDeS9UvrZ4XR8sAIToPsfcwL6jLj/RWr0V4FiS32Hm6DL8hApUoY?=
 =?us-ascii?Q?CbGNm1xXmBlyJEJJjQV3Kv5CXzJH0Liop1liDVirYHbDgEpw1P+Z4x2K0PpL?=
 =?us-ascii?Q?QOhE2AekBiGnI7gAAQKGIWCR81dBiuUevsH0yGNnUeiVWgfg7QxkStcEoYUM?=
 =?us-ascii?Q?QI6IOIisoRVnKMx6/UB43eZf6cPCPO7MoJUBw0XZ6q9gfKiSHivMAhK3c9Dp?=
 =?us-ascii?Q?naTJULeKd4wrgUP72i7077wtaAexu4NXmuBz0NfFc1ilkzDygsNsFDPY2AMU?=
 =?us-ascii?Q?goeIBtyYMo7BydhrJHspfzmP2cD0hribJqeszZHUJFkRzyh7MkbMufEZZSlD?=
 =?us-ascii?Q?ERXNndaUrm+IeNKYqGyOqk3npa7d57FgK8Z+t/WEDUKkdCwmHUz5MsrxXVB9?=
 =?us-ascii?Q?WxXleMUM9Ue36izDwvLupNoEUfldkYaAzgddsraMhLYOEqoXU6mYI7BxzjBP?=
 =?us-ascii?Q?v/jQ2z2RnddVFtc1pFQvYn0mmQcJryPXtfUIGOq7RYrhECckFYZy1UWRHDRa?=
 =?us-ascii?Q?uKE4hVfBl+bQ0ORx05Pw7zXMXEAEuD+54QIZnc0eCBW7acDOqoZaXZBfnmzK?=
 =?us-ascii?Q?8Q3W2BUrFiFgCZQeOu9RWtvXganV/uafp/ixm3eUPVCDNO9EJBNkFDLK2Sn1?=
 =?us-ascii?Q?TG80vk8lRQovs0JGS92LKX+iKLBOKOfeQnTdlntUExXtzRivpdj0D1P26BH9?=
 =?us-ascii?Q?ZDJ/50qWxUZctepfNsnQBF1Le+Q7HZrnkkOJ2Ml6Vxt+XXlHJbe8FR+q+Eo7?=
 =?us-ascii?Q?yVylFcQmSWqmMA73Szcw5eo2ud3Bpn5WaxykBdNc7w2V09qtL2p/5nUfg4JN?=
 =?us-ascii?Q?RXrEDh0feyNBLZzy8Z5/XSYXAot1WucrX+AHfW3NQpROXf5AwlUBf12LsbRm?=
 =?us-ascii?Q?anBnL62Ii01hDquQX4R6IKO52Plkw2PlAg9DYHU45udhz7CHzSQ+1UfjIx3l?=
 =?us-ascii?Q?xShdyT3/d5WB+D/wX8JoMhVdpzMpT8tDEK4anxbVAMvjnGuB5wFjjFPUqV4c?=
 =?us-ascii?Q?CwcYujEmMe9DMCHw66yIXcr9wNA8bJHaV0RsmACcZeBgaDtwzxzOx2jK6c4K?=
 =?us-ascii?Q?YiTzDWGX+BZw/ACEbgEfivBYysCOsW6CNdxDgKCSG3WE44DfAOcMdxwY7j2n?=
 =?us-ascii?Q?oa1DFiU+gi915NlcdTVRjXStxiLDNILQl91tslG/gnFgmIJ8CqqHxy213Ecu?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6846995a-1978-4563-f1d3-08dd452f13ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 15:17:45.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62y1oxQgQqYT48uZYXod2L8B6zV1P0Z+PtjFLn9lBQ3xmWNLJIky/oExDgS5Jxtad4MUVjxm17SkmoFQWwEgtKt9bmx0gn8qiu3vwxbrhu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4889
X-OriginatorOrg: intel.com

On Tue, Feb 04, 2025 at 03:49:32PM +0100, Song, Yoong Siang wrote:
> On Tuesday, February 4, 2025 10:04 PM, Fijalkowski, Maciej <maciej.fijalkowski@intel.com> wrote:
> >On Tue, Feb 04, 2025 at 02:14:00PM +0100, Song, Yoong Siang wrote:
> >> On Tuesday, February 4, 2025 6:10 PM, Fijalkowski, Maciej<maciej.fijalkowski@intel.com> wrote:
> >> >On Tue, Feb 04, 2025 at 08:49:07AM +0800, Song Yoong Siang wrote:
> >> >
> >> >> Enable Launch Time Control (LTC) support for XDP zero copy via XDP Tx
> >> >> metadata framework.
> >> >>
> >> >> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
> >> >> on Intel I225-LM Ethernet controller. Below are the test steps and result.
> >> >>
> >> >> Test 1: Send a single packet with the launch time set to 1 s in the future.
> >> >>
> >> >> Test steps:
> >> >> 1. On the DUT, start the xdp_hw_metadata selftest application:
> >> >>    $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1
> >> >>
> >> >> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
> >> >>    of the DUT.
> >> >>
> >> >> Result:
> >> >> When the launch time is set to 1 s in the future, the delta between the
> >> >> launch time and the transmit hardware timestamp is 0.016 us, as shown in
> >> >> printout of the xdp_hw_metadata application below.
> >> >>   0x562ff5dc8880: rx_desc[4]->addr=84110 addr=84110 comp_addr=84110 EoP
> >> >>   rx_hash: 0xE343384 with RSS type:0x1
> >> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
> >> >>                 delta to User RX-time sec:0.0002 (183.103 usec)
> >> >>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
> >> >>                  delta to User RX-time sec:0.0001 (80.309 usec)
> >> >>   No rx_vlan_tci or rx_vlan_proto, err=-95
> >> >>   0x562ff5dc8880: ping-pong with csum=561c (want c7dd)
> >> >>                   csum_start=34 csum_offset=6
> >> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
> >> >>                 delta to HW Launch-time sec:1.0000 (1000000.000 usec)
> >> >>   0x562ff5dc8880: complete tx idx=4 addr=4018
> >> >>   HW Launch-time:   1734578016467548904 (sec:1734578016.4675)
> >> >>                     delta to HW TX-complete-time sec:0.0000 (0.016 usec)
> >> >>   HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675)
> >> >>                          delta to User TX-complete-time sec:0.0000
> >> >>                          (32.546 usec)
> >> >>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
> >> >>                  delta to User TX-complete-time sec:0.9999
> >> >>                  (999929.768 usec)
> >> >>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
> >> >>                 delta to HW TX-complete-time sec:1.0000 (1000000.016 usec)
> >> >>   0x562ff5dc8880: complete rx idx=132 addr=84110
> >> >>
> >> >> Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
> >> >>         500 us in the future.
> >> >>
> >> >> Test steps:
> >> >> 1. On the DUT, start the xdp_hw_metadata selftest application:
> >> >>    $ sudo chrt -f 99 ./xdp_hw_metadata enp2s0 -l 500000 -L 1 > \
> >> >>      /dev/shm/result.log
> >> >>
> >> >> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
> >> >>    VLAN priority 1 to port 9091 of the DUT.
> >> >>
> >> >> Result:
> >> >> When the launch time is set to 500 us in the future, the average delta
> >> >> between the launch time and the transmit hardware timestamp is 0.016 us,
> >> >> as shown in the analysis of /dev/shm/result.log below. The XDP launch time
> >> >> works correctly in sending 1000 packets continuously.
> >> >>   Min delta: 0.005 us
> >> >>   Avr delta: 0.016 us
> >> >>   Max delta: 0.031 us
> >> >>   Total packets forwarded: 1000
> >> >>
> >> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> >> ---
> >> >>  drivers/net/ethernet/intel/igc/igc_main.c | 42 +++++++++++++++++++++--
> >> >>  1 file changed, 40 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> >> >b/drivers/net/ethernet/intel/igc/igc_main.c
> >> >> index c3edd8bcf633..535d340c71c9 100644
> >> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >> >> @@ -2951,9 +2951,33 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
> >> >>  	return *(u64 *)_priv;
> >> >>  }
> >> >>
> >> >> +static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
> >> >> +{
> >> >> +	struct igc_metadata_request *meta_req = _priv;
> >> >> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> >> >> +	__le32 launch_time_offset;
> >> >> +	bool insert_empty = false;
> >> >> +	bool first_flag = false;
> >> >> +
> >> >> +	if (!tx_ring->launchtime_enable)
> >> >> +		return;
> >> >> +
> >> >> +	launch_time_offset = igc_tx_launchtime(tx_ring,
> >> >> +					       ns_to_ktime(launch_time),
> >> >> +					       &first_flag, &insert_empty);
> >> >> +	if (insert_empty) {
> >> >> +		igc_insert_empty_packet(tx_ring);
> >> >> +		meta_req->tx_buffer =
> >> >> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
> >> >
> >> >in this case I think you currently are leaking the skbs and dma mappings
> >> >that igc_init_empty_frame() did. you're going to mix
> >> >IGC_TX_BUFFER_TYPE_XSK with IGC_TX_BUFFER_TYPE_SKB and the latter is not
> >> >explicitly initialized. Even though IGC_TX_BUFFER_TYPE_SKB happens to be
> >> >equal to 0, igc_tx_buffer::type is never cleared in the tx clean desc
> >> >routine.
> >> >
> >>
> >> Hi Fijalkowski Maciej,
> >>
> >> Thanks for your inputs.
> >>
> >> Yes, you are right, IGC_TX_BUFFER_TYPE_SKB is mixed together with
> >> IGC_TX_BUFFER_TYPE_XSK. Regarding the skb and dma map,
> >> following code in igc_clean_tx_irq() will free the skb and unmap the dma,
> >> Do these answer your concern on leaking?
> >>
> >> igc_main.c:3133:                case IGC_TX_BUFFER_TYPE_SKB:
> >> igc_main.c-3134-                        napi_consume_skb(tx_buffer->skb, napi_budget);
> >> igc_main.c-3135-                        igc_unmap_tx_buffer(tx_ring->dev, tx_buffer);
> >> igc_main.c-3136-                        break;
> >>
> >> Regarding the igc_tx_buffer::type never cleared, I think the
> >> important thing is making the igc_tx_buffer::next_to_watch NULL
> >> to indicate no remaining packet. Since transmit function will
> >> always set the igc_tx_buffer::type to a proper type,
> >
> >igc_init_tx_empty_descriptor() does not set ::type, that was my point. So
> >these empty descs might be treated as IGC_TX_BUFFER_TYPE_XSK, which is
> >wrong and your qouted code above will never get called. You will then leak
> >skb and dma map plus you will confuse XSK code due to xsk_frames miscount.
> >
> 
> Now I understand what you mean. Thanks for the explanation. I will add the
> missing IGC_TX_BUFFER_TYPE_SKB initialization in igc_init_empty_frame(),
> as below.
> 
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1096,6 +1096,7 @@ static int igc_init_empty_frame(struct igc_ring *ring,
>                 return -ENOMEM;
>         }
> 
> +       buffer->type = IGC_TX_BUFFER_TYPE_SKB;
>         buffer->skb = skb;
>         buffer->protocol = 0;
>         buffer->bytecount = skb->len;
> 
> With above, IMHO, we no need to clear igc_tx_buffer::type,
> Are you agree?

Yes, the contract should be that every routine that produces descriptors
should be setting the ::type explicitly. Sorry for not being clear from
beginning but I'm glad we're on the same page now.

I'm afraid this single line should be send as a fix, though :< even
without your patch set empty descs could be mixed IGC_TX_BUFFER_TYPE_XDP
type.

> 
> >> I think it is optional for us to clear it.
> >> Is that make sense to you?
> >>
> >> >> +	}
> >> >> +
> >> >> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
> >> >> +}
> >> >> +
> >> >>  const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
> >> >>  	.tmo_request_timestamp		= igc_xsk_request_timestamp,
> >> >>  	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
> >> >> +	.tmo_request_launch_time	= igc_xsk_request_launch_time,
> >> >>  };
> >> >>
> >> >>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >> >> @@ -2976,7 +3000,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >> >>  	ntu = ring->next_to_use;
> >> >>  	budget = igc_desc_unused(ring);
> >> >>
> >> >> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> >> >> +	/* Packets with launch time require one data descriptor and one context
> >> >> +	 * descriptor. When the launch time falls into the next Qbv cycle, we
> >> >> +	 * may need to insert an empty packet, which requires two more
> >> >> +	 * descriptors. Therefore, to be safe, we always ensure we have at least
> >> >> +	 * 4 descriptors available.
> >> >> +	 */
> >> >> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
> >> >>  		struct igc_metadata_request meta_req;
> >> >>  		struct xsk_tx_metadata *meta = NULL;
> >> >>  		struct igc_tx_buffer *bi;
> >> >> @@ -3000,6 +3030,12 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >> >>  		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
> >> >>  					&meta_req);
> >> >>
> >> >> +		/* xsk_tx_metadata_request() may have updated next_to_use */
> >> >> +		ntu = ring->next_to_use;
> >> >> +
> >> >> +		/* xsk_tx_metadata_request() may have updated Tx buffer info */
> >> >> +		bi = meta_req.tx_buffer;
> >> >> +
> >> >>  		tx_desc = IGC_TX_DESC(ring, ntu);
> >> >>  		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
> >> >>  		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> >> >> @@ -3017,9 +3053,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
> >> >>  		ntu++;
> >> >>  		if (ntu == ring->count)
> >> >>  			ntu = 0;
> >> >> +
> >> >> +		ring->next_to_use = ntu;
> >> >> +		budget = igc_desc_unused(ring);
> >> >
> >> >why count the remaining space in loop? couldn't you decrement it
> >> >accordingly to the count of descriptors you have produced? writing ntu
> >> >back and forth between local var and ring struct performance-wise does not
> >> >look fine.
> >> >
> >>
> >> Yes, I can check the number of used descriptor in xsk_tx_metadata_request()
> >> by introducing a new field named used_desc in struct igc_metadata_request,
> >> and then decreases the budget with it.
> >>
> >> Do this way looked good to you?
> >
> >Yes this makes sense to me, thanks!
> >
> 
> Thanks, I will rework and submit next version.
> 
> >>
> >> Thanks & Regards
> >> Siang
> >>
> >> >>  	}
> >> >>
> >> >> -	ring->next_to_use = ntu;
> >> >>  	if (tx_desc) {
> >> >>  		igc_flush_tx_descriptors(ring);
> >> >>  		xsk_tx_release(pool);
> >> >> --
> >> >> 2.34.1
> >> >>
> 
> Thanks & Regards
> Siang
> 

