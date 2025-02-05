Return-Path: <linux-kselftest+bounces-25855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5976A295D4
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 17:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 054B77A2096
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95661DC9AC;
	Wed,  5 Feb 2025 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/+eU/FR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5194E17B505;
	Wed,  5 Feb 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771751; cv=fail; b=eK+sJVAyZsjvNuDoPCnjEuGHwlZ4xuHm/ysINC4C+IDTWkppWCUcw7xAJstlZosUqIEKcXNLF4qKcG4d4KU9KpRCuAsFLWVLQlXYDv1ibNkY1MFRuFSlNlhaxs1NnPywKRe92FyLVfgXTWVuwTyn29dx422HIZcDlErzn9Ka02E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771751; c=relaxed/simple;
	bh=x5RF1de6jRW+6zAB622ELJaJPWeiRcE4FGnzkny/eCg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=krO31C5Sihf8RqsrdWm6kD2tEbpKhd0Tep1Fe44kDLpVxTgz8DyTzorpl2x8sO73RqPA1v/BVJWvsKHKIYaLNZ07qu72BC3jOE4nA1mjcapSDiIkAfN5avV99M6QZOlpkKT8Y6vgeKwg0bTrqSF98vBN6QOlQ8vEQDgBlngvRMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/+eU/FR; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738771749; x=1770307749;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x5RF1de6jRW+6zAB622ELJaJPWeiRcE4FGnzkny/eCg=;
  b=G/+eU/FR5mILHhaEqh3R/GwKfFOt7mm0V3TpNAHIx6ovp95tgbokOEyU
   SEuBQVj35d/p/qFrNasuhdVX11Oowp9G3JveU/oq6WwnrtWzGuFiZdLN3
   Rp0VTD+FdkBsQOD060oPTJzPA3Bo3aaowWONnf8TDzcG+gjQw6uPAf7lr
   pUZ1W3qS2/2lilUKnBcncLA6MYCcA/QCc7Zg9H0HWyEFQs5eOAfke4VSo
   Zg5VFrdK/kr73KEgT/kZ8NvNNLLhdiXeMj6ea3IFziuZwBg7lopwV0ES1
   cMpGxiCR+DmwDhxOjo7K49g2nYaEDwCvWbQ1D5SxaiqM5p6sqhyzFMvGU
   A==;
X-CSE-ConnectionGUID: r/ZOg+ttQKCy6uGyaLgLxw==
X-CSE-MsgGUID: QGIYip6VQnyPPM3dhopvIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56883679"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="56883679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 08:09:03 -0800
X-CSE-ConnectionGUID: wgmEQ8BeQUCpeK80Mb5yjA==
X-CSE-MsgGUID: 3K4XYxlwR7+mNFjfmODYHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="141837976"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 08:09:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 08:08:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 08:08:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 08:08:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTWUJY69W564oC/pVqt3yqYqQlvLAFHs+ZNMFcrnX5/5+QTzypl4fTX3eXV2mHlFAV7KOUXn4WUtO9Abnw70y967LS2rPWm3lW377ho3dI+OCzAjG9zHiBbYxHIjOmLmittr99XZXcaO9BfTA3aHEZGdv/Foudv0VgmD+wHFXQqHyu3lSlpqewu8OestVj7ahaDkf0LIE1qBcqKzzFh0XMjVvw6v0PNqJwmaSz/KlfWhMSq6fy2H8gLo9H4TKf9gIsUK3uMNJnGVODzioHCzNU78RILK7AnQImP10bWQN1e4YlCy88cRj/GUnqNsH74Xe+QyWIgOBQD75EtZxDtNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjddUUr1sM32n28kD5S/VF4yjA1GeplAemN3rX8Tc38=;
 b=kj9mE3M2muUnyn0mH7dZnXIhrn8m4aXha9CuCDiLXtURxqMdw/NIznz7DKe6rzw0GcDMbZ/sGKgUAh+J2RaWHYxQok2W9jxUFG8YOWiJdXJBvECKI1vDG7w6jlk9oBL1KmhgeqyLp/ppWsHVSRDlt4Ho8VkXcHR/9wqsjyQ2CMEmm8/Dkfwwd31+TsryMU5QzQuVMH5R2iFSfKPd2wGUJOB+jqGuT3yWcEDGj8Ix6i1jas8Hc/DFDM0BnkOZC2k/wSu+BLJvxmOVfXApAKjnt8w9rP5t/KtEdGyupQwYvKqznRD3RMlPwOI86/b6Ro53qwhZ2pwuJqGtMxpfsi3bvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV1PR11MB8820.namprd11.prod.outlook.com (2603:10b6:408:2b2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.25; Wed, 5 Feb 2025 16:07:48 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 16:07:48 +0000
Date: Wed, 5 Feb 2025 17:07:30 +0100
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
Subject: Re: [PATCH bpf-next v8 4/5] igc: Refactor empty packet insertion
 into a reusable function
Message-ID: <Z6OMwvk9zANCD8jI@boxer>
References: <20250205024116.798862-1-yoong.siang.song@intel.com>
 <20250205024116.798862-5-yoong.siang.song@intel.com>
 <Z6NaFkPBZA18oILE@boxer>
 <PH0PR11MB58305176708A48DD8EA60B96D8F72@PH0PR11MB5830.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH0PR11MB58305176708A48DD8EA60B96D8F72@PH0PR11MB5830.namprd11.prod.outlook.com>
X-ClientProxiedBy: VE1PR03CA0013.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::25) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV1PR11MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 697ea41f-6724-44d0-de81-08dd45ff3bed
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tu9WSdTqLNskbaV+q1383HTsbCXUaFESt9Kdp7OLe9NrSzAxmzGy1P+pmK1L?=
 =?us-ascii?Q?1ll+TgjA5vmSFOfaCy6z15S5NGR7VBvEu00MswockoSvFDhGfW6lOEC+E9Ui?=
 =?us-ascii?Q?asOPQud6zFRMiFzyhxjaLwnLBkHKkQoi2yj5rRRrlDcpIJKwclq4SyZXIn6Q?=
 =?us-ascii?Q?1RWWhkWGZ8OUF9R7iB0E0Yx9yDCoOjh9kUHKN2Q1grYHhgflaJuLonsuCWga?=
 =?us-ascii?Q?jWYzoe+IrLaKlm4pDhVbRTl2SHsiYOpbh8U3uSZsUM+ksVWz/8Fsc70nBmR1?=
 =?us-ascii?Q?x6MqGP+hNNAY+y87j6b3qTZ0qcXAmxqv3OXIUdNQigZLTsqbff28H4F2d/+m?=
 =?us-ascii?Q?KAof9XQBXNhgjw6N9BImTusvKyfWyyXyVpRnhlYsLb1Iifs9NrJSLV87/9WF?=
 =?us-ascii?Q?e0LgkP8HGD3+nIF7VvDpLFxiT/J9SYmRMdLgRJS2jbKETVOLbE/Vza/ayJE/?=
 =?us-ascii?Q?QiDPTpmn2aT0nqYDqFuoFtQ2SZBWi9DOlNzWR0FMF48+3N4kul/bFmOsOHFy?=
 =?us-ascii?Q?by9CFaOFQmD7KodQWW7xT1u82KdpJPwJbcJglnRpaD7bqQ0OQf6DgdzrzYty?=
 =?us-ascii?Q?FXlMw1de7Pm9ClMDylKFV9MQOKf526uulmet4asDpo+WVflnvKqVFpw9QdTI?=
 =?us-ascii?Q?rYm0Q7nBjwZUgzXaKD0RC0e6LhT1tQcJ8IBwtpvK+e477oOavVwRcecVM/zQ?=
 =?us-ascii?Q?fuLM0f0nxQs5HILodbVZX64fTjryS0uAeW/4eWIeIz9mZJkPOZGy+OjS0lQK?=
 =?us-ascii?Q?WyMtaI1FqSG+GIHDoRPq5CMW2DpJLsETniMS9amiObUP2R6LHVh02WLKJSAN?=
 =?us-ascii?Q?6v1/ffoltQza/HKE9CCJvZbbdbNRJcwqYYkeuFuEG7G/y8Tlcv0eaYPHFrb3?=
 =?us-ascii?Q?hl/j9yVgweLjoC+BRM+NGgFHmLpHJwyzXsk2Js8Ll0aQ1EM+ZhnuqiQ0riRN?=
 =?us-ascii?Q?NCoN7OZrB9cXs7kbo2cN/SNAMuOAB1c6FSOhO8spGVl8qvIHuz32ic8S2OvT?=
 =?us-ascii?Q?Q7ZHHUQjC4cwc3o9iG4h63t9rtFv7FG0kgy/aLnja/9zggAL9OYma0rRrHdy?=
 =?us-ascii?Q?0jmtbY6SIvi60UG+WWeFV8wRNivweSSgTrUMXYijSiLYEvVL0BilhAUdQWCm?=
 =?us-ascii?Q?tz/M0tou99Y/sq/2GfdMiB2fl88iESHExYU55Hm6fe8bapWRzC80/qIq+tXX?=
 =?us-ascii?Q?KsU7izkljJ1/SRQNJxr3CtzyIUFqS8hy5RCGdF0uuf5amEqBuMuvNdkt8rkI?=
 =?us-ascii?Q?cYGSZk3hhJ+PrmFbqKv3eOzgJojjH5c8FRfNt79TcE7d2wsNnb9VVOtpKDR/?=
 =?us-ascii?Q?WNhCKwygxq8OWfxKE/g9kJprDJOROmdwVNo1KoW2pdNQ3GcexEveCzccjW6D?=
 =?us-ascii?Q?+E3Y4Yig9cshzQPyPxmBIz03Jvlw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C4Jj6eRYhVylN4l/vxlg5S2f33s34uCaZK2dLEs5+tgZDmVlVjoBtG9t9koE?=
 =?us-ascii?Q?E9aQCTvYsf2hUd5Wr7dPf1pm23A95wYLlRucTKQSDHE8EmH3FVAUhO7D3kPz?=
 =?us-ascii?Q?Sx3TdXl3DVuxFakySFlqD/jSCUQHZKb24y0gmlm5C2kFRZo5xeOYNDrwJPXS?=
 =?us-ascii?Q?0dofQCYbzcPnJg6AfvofDifPCmz/o720FrE4ZEhQlXaOhqIVQCPx4P8tXc38?=
 =?us-ascii?Q?iZIzUlmPivKssF+3tmmZEvXuBiitPQwczHj9wFht+kTXkyLUJBqDBiAFNzIm?=
 =?us-ascii?Q?pM1Eb4dPaoC4imEHJWO5muPkcJ74fSz4J+0R1OJL/G8Tz/xjaX5Ne87UkSQj?=
 =?us-ascii?Q?VCdsEGEPCQHXxumnAXttL8xz3cYkdrQTkeMpzJ9ek1AtYDk4nGjEuzVwxSgH?=
 =?us-ascii?Q?qE1vPNWEwnhymaAWtg1FYwClc5YZZmWr78fXJY6iyr/bhtAHZ4fKa3B9uvwD?=
 =?us-ascii?Q?lUnA/rc1bM/0UxklhHloK/q3yzlXRwjnkc/4W8ces9Li1yTMziYwa2RR5DXn?=
 =?us-ascii?Q?STHpSurXx2Nnb1LPr++rbax9/WydUGBkj3rwDB0tswCyelz5tZ//b/t1WLN/?=
 =?us-ascii?Q?7EtvRXrhV2rJ0C0nsHAOVqVZG9s0ozV9JpidyYhlVydVhjoz/vVRhOjcbMfo?=
 =?us-ascii?Q?WJvlBwC+AiNj7dsMxP+7wfO89VOPlfIjQ0ijgvHuCTXs8ablsxESjnG6WJdM?=
 =?us-ascii?Q?2wKREF/YQCXTq24cjJ+niCoRbQWImeWAGD/V/es6fXj+l2wXH55MLoiDl99V?=
 =?us-ascii?Q?Djh8fHTrB1oKBruKeIukLYSWe1m/yj23ypQNDzPtWLKTbdtelbbGQvdRGyXz?=
 =?us-ascii?Q?mQP3n75KQIJHEhRMqxCSh/4/t90ghoL0qq03B65B6D7GxCV4oV2BVbRpyy/h?=
 =?us-ascii?Q?DZk4RWW35pw7YG2bp/tf+K4DJAyDkk5mKWtIfRwHYatsDAgj9lq5KrPxL5FO?=
 =?us-ascii?Q?cwZTGgesxUlsRsjprbwbHZEI/r1Tpz1yJipXGKU9sf7lwca7vnsk5hMXi8f6?=
 =?us-ascii?Q?NvDKHfxj2FwUlqABCZb9YoEVRVwypvh95RpXYYyWw3+ibqPj93BXycM+AjlY?=
 =?us-ascii?Q?1yjD26CjE+3ycs+jVjORwF2Yevvv1EtRxgpCymEcpi5CHgnr4UZTjhgf4Ppr?=
 =?us-ascii?Q?QwtX49P+/goWk0EfH2LG6ZOQ5jiiF3/4ZqKxqlLQy6HVH4dj2YebutWXbmzD?=
 =?us-ascii?Q?COmyxw8XZR085jd0hKGoEgtU3FftXeX+trgU2XiAc32hVzWoCMxoZ7MxyqI9?=
 =?us-ascii?Q?EyUQV24u+ZmX1kEf9E5yAI0pVb43+Hjg2rWMwn8iPoq63htwW9LkbJEAKWKg?=
 =?us-ascii?Q?c+UlAolIMZgM/arr+76cQzjbytDPt+sZErVtfua9hqDIUeBJJ3dGsL/46srB?=
 =?us-ascii?Q?ZdS7ls5cfa0DS8LiV8Ee2sQBDdFzqNzlFAXpIlfAsgKp2ZsfXmsA3KM86Kl1?=
 =?us-ascii?Q?hhtdj3vzlm5MM6Hcb+LAqnuX3FikP6nchuNTudz0orC04R6/NxiGObsEPMYP?=
 =?us-ascii?Q?8Zk6DdEg3O5GPGNfIiyS0OjtrBn3CpkwdI4MJoNrlpTOsUmP/CbhHlJ4sh2c?=
 =?us-ascii?Q?dwykp0HVcVIv1WnJ+TMQOs9QYitEdS3CvPzogX86h4qLUnjOsCi6dYvAtf92?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 697ea41f-6724-44d0-de81-08dd45ff3bed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 16:07:48.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQveMCUxTAzVPPORmRn/F8izEC4V01yRKBBHzHkWNRWayuW2vSuz+i+NQ/Jm+ib9isQAY8S3GIcyOaug/m5zRVx5WWnKckw/AFww3R6Wm5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8820
X-OriginatorOrg: intel.com

On Wed, Feb 05, 2025 at 03:43:19PM +0100, Song, Yoong Siang wrote:
> On Wednesday, February 5, 2025 8:31 PM, Fijalkowski, Maciej <maciej.fijalkowski@intel.com> wrote:
> >On Wed, Feb 05, 2025 at 10:41:15AM +0800, Song Yoong Siang wrote:
> >> Refactor the code for inserting an empty packet into a new function
> >> igc_insert_empty_packet(). This change extracts the logic for inserting
> >> an empty packet from igc_xmit_frame_ring() into a separate function,
> >> allowing it to be reused in future implementations, such as the XDP
> >> zero copy transmit function.
> >>
> >> This patch introduces no functional changes.
> >>
> >> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> >
> >Your SoB should be last in the set of tags.
> >
> 
> Noted. Thanks for the tips.
> 
> >> Reviewed-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> >> ---
> >>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
> >>  1 file changed, 22 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> >b/drivers/net/ethernet/intel/igc/igc_main.c
> >> index 21f318f12a8d..553d6d82af0d 100644
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
> >
> >I still don't like the fact igc_insert_empty_packet() doesn't communicate
> >to caller whether it successfully produced descriptors or not.
> >
> >Look at this from igc_xmit_frame_ring() POV:
> >- at the beginning you peek at Tx ring whether there is required amount of
> >  descriptors free to be used
> >- but then here's your additional routine which might consume two more
> >  descs and you are not aware of the status
> >- then you continue to further produce descriptors assuming there is
> >  enough space in Tx ring
> >
> >Right now igc_init_tx_empty_descriptor() returns -EBUSY when ring is full.
> >How can that happen in the first place + what if it would *really* happen
> >though? You just continue with your Tx flow.
> >
> >What I'm trying to say here is, at least from correctness POV, you should
> >take into the account two potential descriptors for launchtime feature
> >when calling igc_maybe_stop_tx(). And igc_init_tx_empty_descriptor()
> >should not really care about space in ring, it should be a caller's job to
> >call it only when it will be sure it's safe to do so.
> >
> 
> Agree with you.
> 
> In db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit"),
> the 2 descriptors needed by empty packet is already taken into
> consideration by changing igc_maybe_stop_tx(tx_ring, count + 3) to
> igc_maybe_stop_tx(tx_ring, count + 5), so not enough ring space issue will not
> happened. However, the comment session is not updated, maybe i can update
> it in next version of this patch as below:
> 
> @@ -1586,6 +1608,7 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>          *      + 1 desc for skb_headlen/IGC_MAX_DATA_PER_TXD,
>          *      + 2 desc gap to keep tail from touching head,
>          *      + 1 desc for context descriptor,
> +        *      + 2 desc for inserting an empty packet for launch time,
>          * otherwise try next time
>          */
>         for (f = 0; f < skb_shinfo(skb)->nr_frags; f++)

Ahh good then, I didn't pay enough attention to comment. So it meant that
first two entries from comment were covered by @count and 2 desc gap + 1
ctxt desc were behind '3', previously.

> 
> Since number of descriptor needed is guaranteed. I will take out the
> igc_desc_unused() checking in igc_init_tx_empty_descriptor().

Yes

> However, empty packet insertion might fail due to skb allocation failure
> and DMA mapping error. How about i make sure skb allocation and DMA
> mapping working, before proceed to fill in igc_tx_buffer, context desc,
> and data desc?
> IMHO, because these two errors are unlikely to happen, print a kernel
> warning msg should be enough.
> 
> @@ -1108,20 +1108,12 @@ static int igc_init_empty_frame(struct igc_ring *ring,
>         return 0;
>  }
> 
> -static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
> +static void igc_init_tx_empty_descriptor(struct igc_ring *ring,
>                                         struct sk_buff *skb,
>                                         struct igc_tx_buffer *first)
>  {
>         union igc_adv_tx_desc *desc;
>         u32 cmd_type, olinfo_status;
> -       int err;
> -
> -       if (!igc_desc_unused(ring))
> -               return -EBUSY;
> -
> -       err = igc_init_empty_frame(ring, first, skb);
> -       if (err)
> -               return err;
> 
>         cmd_type = IGC_ADVTXD_DTYP_DATA | IGC_ADVTXD_DCMD_DEXT |
>                    IGC_ADVTXD_DCMD_IFCS | IGC_TXD_DCMD |
> @@ -1140,8 +1132,6 @@ static int igc_init_tx_empty_descriptor(struct igc_ring *ring,
>         ring->next_to_use++;
>         if (ring->next_to_use == ring->count)
>                 ring->next_to_use = 0;
> -
> -       return 0;
>  }
> 
>  #define IGC_EMPTY_FRAME_SIZE 60
> @@ -1567,6 +1557,38 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
>         return false;
>  }
> 
> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
> +{
> +       struct igc_tx_buffer *empty_info;
> +       struct sk_buff *empty;
> +       void *data;
> +
> +       empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +       empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> +       if (unlikely(!empty)) {
> +               netdev_warn(tx_ring->netdev,
> +                           "Fail to alloc skb for empty packet\n");

That should be at least ratelimited I think, but what really is the
problem to make these routines return status and check them on caller
side?

> +               return;
> +       }
> +
> +       data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> +       memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> +
> +       /* Prepare DMA mapping and Tx buffer information */
> +       if (unlikely(igc_init_empty_frame(tx_ring, empty_info, empty))) {
> +               dev_kfree_skb_any(empty);
> +               netdev_warn(tx_ring->netdev,
> +                           "Fail to map DMA for empty packet\n");
> +               return;
> +       }
> +
> +       /* Prepare context descriptor for empty packet */
> +       igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> +
> +       /* Prepare data descriptor for empty packet */
> +       igc_init_tx_empty_descriptor(tx_ring, empty, empty_info);
> +}
> +
>  static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>                                        struct igc_ring *tx_ring)
>  {
> 
> Are above codes resolve your concern? If yes, i can test and add
> them into this patch in next version submission.
> 
> Thanks & Regards
> Siang

