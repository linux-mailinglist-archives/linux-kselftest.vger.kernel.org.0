Return-Path: <linux-kselftest+bounces-25676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5AAA271F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 13:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B25233A17F2
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5F220DD7A;
	Tue,  4 Feb 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PPQeBm1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEB25A620;
	Tue,  4 Feb 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672609; cv=fail; b=pInFESTrNRSJfvazJdZW36vZgfbujt2VZKhAa6pLx898txbErm/5wKcBNwK2ISoF+KPhPu3TO0/8WjfqLXIk7byXsFgcrKOAI4wx3eNTAOGsRSwbWO765CcLGdvTStkfTgNFg3oaCPSxlIvSdGFNf2ubdWKB+Zwo/QG9mk/akmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672609; c=relaxed/simple;
	bh=iDCQdpBiiCn8mqOsf+Br4X6kx0WzbjCtCfKdqKBSIaA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y0n0Vklch5hsKP6dNv1vjxY1aasPzsqylrtoNOA1Ww0A2py76QyPfSQ6f5qlSpE2BdWEGn53rpU/+bPvU9qjmwOdcWicCO6oX9sAMhH+Wh5c1N+e5//4igbqj9p0mRiOJHm0QrdXiJQJbOBFD/qg/F4rKBNeMHnEcJBwtsM8J8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PPQeBm1p; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738672607; x=1770208607;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iDCQdpBiiCn8mqOsf+Br4X6kx0WzbjCtCfKdqKBSIaA=;
  b=PPQeBm1pV4/wU4Xd4NhD3kwlWEyoE9ZEZ5jOqCx/GQRRN5OTMnRwlp9X
   ydICfC89VhZUhUWzilACzoxGPAdBlIVlKIUfzHs+IVglJ9/zM2Xf5oLDK
   wRTvau/txeMC1YLX6tPMo3EZScV1GwCDzWi2dhkW3lUCKJ0TNosl5F9Zs
   DWS8Iuhtj0Bl7xFTZxMAjHBoyW0R43F/5Mdyw7F4n9LaFsEPU7ncKEa+q
   ygVwnrj9YUUGsBm9/wByl68qdLGvF2XgwFZ7N013JxZRdLX3MA8qpsuQj
   YXYgZoyiQBu+BF+SQCoYnm5SCOhXDRg6ZJl0/ZMwkt0FckBQKuIisqjv6
   w==;
X-CSE-ConnectionGUID: EBdLhY2hTuGlZpmi6+q/KA==
X-CSE-MsgGUID: O9ZcyopRTlCcm+JQDeChvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42944733"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="42944733"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 04:36:46 -0800
X-CSE-ConnectionGUID: 8fXdphAERX2bmMsvNKwj/A==
X-CSE-MsgGUID: 13xTsSTyTEm9+m3PrSJGVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114640679"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 04:36:45 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 04:36:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 04:36:43 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 04:36:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffK+yJHkoDfGGHVE+u6/XAOysPKRQBfnBLzsiaHvblrS4sIKsm0NDe+UCbs4G1kinjsIaUl4QSnN8dYalG7kUUXI+Jdx2VBZz64jhopApipNlIlu0rd4ci6v4BIG6lzaIenJbUnkapvt15f+AsuciMBk7l8PjfBNU1C0kEidPFswvNjfZHdyG2Gls/GqNkQI3lMur9z/eY1D9FGprU+5y5RYMmzINhykyKmZCRMlJ/5pVo9PAxyWVlz7CsS3Oyg5Amc49UZRYozMYsJ6bEeF9FYCCxkD0HLked+p9rp6uls7swoCc+0cijJHZYqCgbhMc93crhNjBG1QI39bzaTRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNlS5M3fzPl3P0X6NvEZsY0b7VVDvEC6HeaAYe6z1Fw=;
 b=p50MD4DCKvcB4UetJE3Ww9RFkDahE6Ty53fLTUPSaNX1p/1YwFYsyTPq0G/XoF9dmaw7SaXDgN1dhv1V+HyTLtcjYCCCWYjzAf0wosuOXNaidErX3SW+iq2DYNRNmnby0cLrggqypYBBRFtXL98cbJMxO4tHDD3NkkCa09a6SGiQ3iqg4xb74Kr7ilWUiJ9X3ewrZ1el9q/ggssYEovDeNqpLMXFuhBPEAHDXNI3q1q1a84+W30nGBjwjSZX4YiFBPUYdytZGlqlbyUIUuHBsyDtTO2zskJ26IeiATiPFU6qEMYURFUhST3kjRc875itQKnyiFgkHhMFWrpH/J2k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN0PR11MB6278.namprd11.prod.outlook.com (2603:10b6:208:3c2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 12:36:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:36:01 +0000
Date: Tue, 4 Feb 2025 13:35:50 +0100
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
Subject: Re: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion
 into a reusable function
Message-ID: <Z6IJppEFhSzMbmi9@boxer>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-5-yoong.siang.song@intel.com>
 <Z6Hi5G0ngTnb7lb/@boxer>
 <PH0PR11MB58306CEAFF46FD493030943BD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58306CEAFF46FD493030943BD8F42@PH0PR11MB5830.namprd11.prod.outlook.com>
X-ClientProxiedBy: DUZP191CA0035.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN0PR11MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: c10a7034-2bdd-4db4-be1e-08dd45187b64
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?igZwTfs0vLtZkKP217Iwc8wLWa1oS7Qb0IpuEwdzbOqL/cKEGT3uxil7QhdZ?=
 =?us-ascii?Q?PEIOaxOydWePSe4va92hQnyJRWM2FWw05iRL3seDsGVfGVjIeoTgRSULMwBF?=
 =?us-ascii?Q?epTEP3iEXSfd7Wjoh46ftQcb3iyuaaGpPQKzISa9LvVTI/DqdsppQEDJBgvK?=
 =?us-ascii?Q?RJUokTfETJSAFI3GOkhvgSTXDvmta6I/4siw7t0M8nP15mTLgGdAwJ/awgAl?=
 =?us-ascii?Q?7chEfXNeyBaLuIXeSJM39RY7VYGWg4aBE7ZshTiVx7zpOEdkdmhqrGLIerBX?=
 =?us-ascii?Q?S+XMor5hmdseoQoxn4ZfzSR5fOmu3n1jYkVso2NLU+q+yxHUzQtMJf3cTdDe?=
 =?us-ascii?Q?c8jsIF3Jcg/YYBG7kA0o/QXeZ0bDEVFktO4nGWtENSA3BRUsZcC/N0cX2T/m?=
 =?us-ascii?Q?ShxnWXJ0Z+XzyqdmMoT+QUWO3yFXFeyJfhNVWajoIe8t9Wtc2LUHXtsTl+wB?=
 =?us-ascii?Q?i9tMLSbI0CqSn6GFrM1GcaRwn+N1mwJpX88R2mAcMl6a82n4H5iHnyn3VlV6?=
 =?us-ascii?Q?UsAwmYnECA/UAuis7hV1V02Ro1/0/F+Nw2a/lQkr9+DwrEjI4dMMkUQ3PQnh?=
 =?us-ascii?Q?fEP5ULw13gUnsvI++XYa/xI1/UbYdc3sQtqWaRSACEyBIVraAmpfWilVeLfN?=
 =?us-ascii?Q?fb7y4Ri4Fp5O91X5wAUtM2i1aIbGz4RQ3/k830fmgIr6pLW5udqiP2AEZjfJ?=
 =?us-ascii?Q?fwOj5xupfp7zFl4JdjG3AAf792ONhM+OQxc5yZ1KIhY/YxHj8eSPRcXCAaPP?=
 =?us-ascii?Q?/5+jp4cufEN+PP36+3FVlEmjmGd111DsJYSDmXuEOMSTSc9HP2D8w7Q7HxAT?=
 =?us-ascii?Q?eB4lYLU823x7w3Aw3lfj3GUj7EkNgXJ/8S0OpWHMoKTxTGYWUteW6GHo7Y2u?=
 =?us-ascii?Q?V24rq5RW9NNfqtbHjuWl2AU4MeKsLNbgV7UKafZAxkvT2HB1eb/AflX0kcAo?=
 =?us-ascii?Q?918zOXpw9fAjeepDX2RtxHORKGJJ9p5EO7Rd4elEvyvnKcOFpdpG1/9+s+pP?=
 =?us-ascii?Q?a3RiBGoHpwiVBhwFLgnQhaoY7bSxn+v3BBcM3IoLcPwPd6SadI8QFltDKcmD?=
 =?us-ascii?Q?O3x9Knex2jMLwsdsAS0OrpI5NPGvTcd5GYlGpvBnDbKADJJw7etD0Sssfn2d?=
 =?us-ascii?Q?O5lWegSarV9zpN2VOofqByBSGG7rW6JuDugTnsTWU89mVfIX2Cv0BiH+289c?=
 =?us-ascii?Q?4eYCYunVJS/sBKVxykHioAS+HQKxHVNmeyM1yIt7qXdeY+A05Qw7pfIb/4KW?=
 =?us-ascii?Q?+9mTt/oB6/o2Kina8gwuWugd/1Il9BpVZaOn6QbR16fzOYp22xIcF4PAlwyP?=
 =?us-ascii?Q?cVmqKxNSlZ3tbPQwVChVAgeeV8sFA6fBpPSYdkwn7mZo7zT1X9o+Z90ORvk6?=
 =?us-ascii?Q?SK4G0J7uODOJFsxL6G9pZR9GZkW3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LuJ1qH4Ze9FMAZkr3pIniT0ySlGSPFbJKzAoDyg5esotrh0hNcPrHZDfmGDK?=
 =?us-ascii?Q?v3utsjtU/SWKyZYlZZrfm5unot7nTMoK/il39GLTAKqn0efIl+GWqBDWt1mk?=
 =?us-ascii?Q?BLARNsHPGkurm8AItl+aGIWTuCuB80o2KIpmbeVgOh7lgmK+ldnr3mmbMg5/?=
 =?us-ascii?Q?Ds17aBFWfQFcfRzgFpiPtCtvsQKugHWR3soCjk0ybxwBkFjamxkJUO6RQCdH?=
 =?us-ascii?Q?5ur9R9fu8EDmKiYnnrsw8hPts3zeNT+mvb/PRP5KECy8Zrxs4b0YWOW3Gw38?=
 =?us-ascii?Q?QNUmlRue7oi0fi4jpBjIcb8y86OOGBhTq77MzXXX0XwCN+kbcb9uxGYnj29h?=
 =?us-ascii?Q?W/6dNdjserylo4HdPP2yPn0vWdy495dFyWCMCWp+W/wN59quUfUo2l6sbhVn?=
 =?us-ascii?Q?AzHOcDlRLgP19Sqo/qbokPQyUtTeczERFIoPezCRpkMTi4TawyctUQx+tFTx?=
 =?us-ascii?Q?aCoc/30EaLguA7IM/3qo5DjdpGAS5E7Uw+waJBWjZXTKvr7WTU4zvl7lg18u?=
 =?us-ascii?Q?pRcD+A5DuDLOdOuXiYpq0d0ZU2USA+n2eEc3FSls3TQp0EyJAXfKqINReCzp?=
 =?us-ascii?Q?tIUwEaar+8U2/3V8YNBoHrTzi+pD/OQoVH8Z4/o9+nFKMxdwunDcusTsEkDs?=
 =?us-ascii?Q?hGca+PIckhfk0x1Juy4j0067O6QaeqHFhdoEYPjiZVjnBqyy+K8Jp9gXLQ9A?=
 =?us-ascii?Q?cm3eR7RM+QNoE7gwEVU8IRAjYp4dRoHdMC/Dm+gM4qsYN//5Cy8XOj3JAEEQ?=
 =?us-ascii?Q?RMit+iY1UWkfcVAFzSll25x3ZPacXGVQMqP4prx9pEhpIBivv9yiV6YVdqK/?=
 =?us-ascii?Q?BQFqWbrZVF9fXdjk4mcz9lOOnTpJ1zv6gC0auBAHEtTO91EK9G3KgH8q4p0x?=
 =?us-ascii?Q?MvAAj1GEQT0ie6V+zqlgqyhPAdiUTlWq3v3drhRS6xRE4hD/G5g/REU5qB3k?=
 =?us-ascii?Q?S39Y4XDNnMXmUyhX5tsgwk1ftM8hKoZBhb4FqicfPrMkaq0n2k9QJy/UKTU2?=
 =?us-ascii?Q?71MCyh0E4ENdyYPrZfpffvMvZbq8+yXra8ur9V/e35yFe7r/mA0nq997THPr?=
 =?us-ascii?Q?4JlzdrbbkibcyZEnheYZQzS7Np5xUjiekLr1ZOhvEbj+KZNoawKVVkAikD8e?=
 =?us-ascii?Q?w3kxJHcJd7f2jiZfidNzWn7yjh9LG1mM0wR5JcjIuwWuJYF6IbivvUDuxsH9?=
 =?us-ascii?Q?65SS6GTZBvP0VoU1soFfXQcrMuYFP3vZwNa+ziajLyl1ul9Aa0yLB6wHnUVQ?=
 =?us-ascii?Q?2xCBteLvORShNVAmLzENk3pVpDzoK4YtaIRD+mX7SlaA6dNr1MQjOygtUz+K?=
 =?us-ascii?Q?DVIPWTd4cQGKHKvMN/ERpzIVN8XlkggfqjtUBM8niccBXYsaOl9+98iOsv1U?=
 =?us-ascii?Q?vd8FpXeAgpgN91d6Irz4fc8jNlIpT9ewxC6Z2uZC5l92LQ2Uj7PcZRjYnhwo?=
 =?us-ascii?Q?AH6qcaDmgETdrzPVQioPTXjhLJBmtcX6bu1byJrQP5aF1WM0XbdRZX9FRDzO?=
 =?us-ascii?Q?7paTOpdDhWIJhBcvyytzkRMRyuuDoTRmWwel96Ms+T5eok4hJT2LxO7gQY6U?=
 =?us-ascii?Q?k6GlrvRxI05z9BgwtHqm4E2cpXD3TyUAVg5+C2ihygbYyEr4K0pvRGwGvXvt?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c10a7034-2bdd-4db4-be1e-08dd45187b64
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:36:00.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PSBdPB9+MU3pploiVaeSrZXgfT7cu1IZZjSAldxMp8SoSQHoamAAb6IDNRyf3nMmpDk3NAefq4q0iPnetfY7UnfBd/2FH3ydJbNdqub6obU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6278
X-OriginatorOrg: intel.com

On Tue, Feb 04, 2025 at 12:07:21PM +0100, Song, Yoong Siang wrote:
> On Tuesday, February 4, 2025 5:50 PM, Fijalkowski, Maciej <maciej.fijalkowski@intel.com> wrote:
> >On Tue, Feb 04, 2025 at 08:49:06AM +0800, Song Yoong Siang wrote:
> >> Refactor the code for inserting an empty packet into a new function
> >> igc_insert_empty_packet(). This change extracts the logic for inserting
> >> an empty packet from igc_xmit_frame_ring() into a separate function,
> >> allowing it to be reused in future implementations, such as the XDP
> >> zero copy transmit function.
> >>
> >> This patch introduces no functional changes.
> >>
> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
> >>  1 file changed, 22 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> >b/drivers/net/ethernet/intel/igc/igc_main.c
> >> index 56a35d58e7a6..c3edd8bcf633 100644
> >> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> >> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> >> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adapter
> >*adapter, struct sk_buff *s
> >>  	return false;
> >>  }
> >>
> >> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
> >> +{
> >> +	struct igc_tx_buffer *empty_info;
> >> +	struct sk_buff *empty;
> >> +	void *data;
> >> +
> >> +	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> >> +	empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> >> +	if (!empty)
> >> +		return;
> >> +
> >> +	data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> >> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> >> +
> >> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> >> +
> >> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
> >> +		dev_kfree_skb_any(empty);
> >> +}
> >> +
> >>  static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
> >>  				       struct igc_ring *tx_ring)
> >>  {
> >> @@ -1603,26 +1623,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct
> >sk_buff *skb,
> >>  	skb->tstamp = ktime_set(0, 0);
> >>  	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag,
> >&insert_empty);
> >>
> >> -	if (insert_empty) {
> >> -		struct igc_tx_buffer *empty_info;
> >> -		struct sk_buff *empty;
> >> -		void *data;
> >> -
> >> -		empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> >> -		empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> >> -		if (!empty)
> >> -			goto done;
> >
> >shouldn't this be 'goto drop' from day 1? pretty weird to silently ignore
> >allocation error.
> >
> 
> Hi Fijalkowski Maciej,
> 
> Thanks for your comments.
> 
> "insert an empty packet" is a launch time trick to send a packet in
> next Qbv cycle. The design is, the driver will still sending the
> packet, even the empty packet insertion trick is fail (unable to
> allocate). The intention of this patch set is to enable launch time
> on XDP zero-copy data path, so I try not to change the original
> behavior of launch time.
> 
> btw, do you think driver should drop the packet if something went
> wrong with the launch time, like launch time offload not enabled,
> launch time over horizon, empty packet insertion fail, etc?
> If yes, then maybe i can submit another patch to change the behavior
> of launch time and we can continue to discuss there.

That's rather a question to you since I am no TSN expert here :P
the alloc skbs failures would rather be a minor thing but anyways it
didn't look correct from a first glance to silently ignore this behavior
if rest of the logic relies on this. I won't be insisting on any changes
here but it's something you could consider to change maybe.

The real question is in 5/5, regarding the cleaning of these empty descs
from ZC path.

> 
> >> -
> >> -		data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> >> -		memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> >> -
> >> -		igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> >> -
> >> -		if (igc_init_tx_empty_descriptor(tx_ring,
> >> -						 empty,
> >> -						 empty_info) < 0)
> >> -			dev_kfree_skb_any(empty);
> >
> >ditto
> >
> 
> ditto
> 
> >> -	}
> >> +	if (insert_empty)
> >> +		igc_insert_empty_packet(tx_ring);
> >>
> >>  done:
> >>  	/* record the location of the first descriptor for this packet */
> >> --
> >> 2.34.1
> >>
> 
> Thanks & Regards
> Siang

