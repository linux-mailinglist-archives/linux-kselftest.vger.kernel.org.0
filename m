Return-Path: <linux-kselftest+bounces-25944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F5A2B247
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 20:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA837A2523
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 19:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ADD1A7044;
	Thu,  6 Feb 2025 19:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dOs2YSRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C114B080;
	Thu,  6 Feb 2025 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870221; cv=fail; b=auo/yo/b00lP/8Zm2mBkIQfripDytuK3hEJPOQH5IqzW0YcfyJZtQRcvKIE5kl72z4mu8xu8CBVcZnCG5ny/4swyFmnOTmnWUrIfhvYQtA/rCA1nkTlMWJpEgISKEWR6WNVuKeNoYuaU8cW/Dnx/uA408Oy/90rWsLqYHEE+RFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870221; c=relaxed/simple;
	bh=x8EQ6FREqmm8xHLQvSitZD70TXkRcpo7fUPiLSnGFGs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZ6TdisXumk9E7NHIzoa4yc/MCCHhdu7jL61n/2Sc9k2f9tU3p09HBp2cAX9BSaOLf+UP8xVttnQPuqV5AZL5/TrHH1GEZEE6d0++/dWWBCxvOCDIo7FbbkNyUYo+2zM5YDYc1OyG511dPkdojttWYgCknpKvOVOAi+dUHV4oNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dOs2YSRQ; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738870220; x=1770406220;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x8EQ6FREqmm8xHLQvSitZD70TXkRcpo7fUPiLSnGFGs=;
  b=dOs2YSRQP3vTeQ2Zb1rec85CZhuKIPrj91FQsWi1nrn03zaa/G+cz2Dx
   v7QHZMby1Q1IHtycn8F74PfUwUubFECzXLqS5HRBnymH45Irk/4w4jR5V
   tN/U+ftnofb+xtpgvGiYRdRq9KuzWVlTn+Q04Vo1lX2G6ZrqmA4bCMn5c
   I12GxkUhGsPAsGnDvzzpLbtyWhDUE/aAcFvwj/2IwjzngBkCTYlzSfH0x
   nA4FQ83rqmyjHXXL+tMAXCqrKrrqz+VHDGz11rWgw0HaplxyfMq2jjpUi
   nAWNWKnSWXlcEjA1WK+KeSh61Bml5tlXTYHQMSMNvdaDCXYLgSoOmELas
   A==;
X-CSE-ConnectionGUID: kGjYcoknSqe+ZvAET8Lk1A==
X-CSE-MsgGUID: PnmpbRkNTP+P1xCUWL95OQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="38727210"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="38727210"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:30:18 -0800
X-CSE-ConnectionGUID: C8VqGzRvTkCUUUGWC1RtQw==
X-CSE-MsgGUID: XV2GVLxeS2uwQ8fVuf1zAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142180934"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2025 11:30:15 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 6 Feb 2025 11:30:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Feb 2025 11:30:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Feb 2025 11:30:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHGVvrf0krtoNWmEOE13JMCfrLhmTDgWOKCmL+spzY1Y98CZx0qp8JeIzKxL7OAR/kUl/8nSzkkcs5A9L0+xsedVJz5yInUiw4Q9Dv+wxz8kpjLJRh2SZoQGL6SASRjckrXMgVKi8KqpB9p6Y2BjxhJb1ki0XpyCyynKoEwJZ8+kRoXoe502Qo1DxrJ9Arpihr39RqHpve6wuTYbfK8ra8LSJUE8fgKOaBiOZe10mDbg+eDu2p2ePbDlWe6ixht/DM0zNOeqAtZwSiqcWizd+prcxQia7o0f13UBuaw3HUiNVgiJS+aCOLFGszg3R3J6O1gdt8TikLdL7ediI0Ae0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WCn3VOZD2jPCrlSb9Ra6xtXbzK2u1is7aRuobREnAk=;
 b=PZC1PR/sF37y0ZMC1NHdtk6bJu7gjCMon8ylNAfVqN8pwCJJiFTMIzpQYs9dCG6m7BZMCw6HyaoWyys7HKum4MTwmUSc8M9h9jYAMq0j2D4/zW3Y1PLL2+OFOADUgj9+l/P1XNJgNzsiF7hhQSz/dIPzFS/UNvncfL95rlk+PkQPezn9BWL1/TC1b73bSM9h+e7RoAcAYHuxTbNT+thNa3fIGU+OJIiiihLoZCVr5/FIOEDZM+VCM+FtUSj3LBceygFAWbiCPpHzQYIQMHj8p5j+T6oFbBsYuc6lmji//DaYLqA0NX9Gxx0dygu6QcNxHOAmJFPICt/7ksegUcChrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Thu, 6 Feb
 2025 19:30:10 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 19:30:09 +0000
Date: Thu, 6 Feb 2025 20:29:59 +0100
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
Subject: Re: [PATCH bpf-next v9 5/5] igc: Add launch time support to XDP ZC
Message-ID: <Z6UNt2GatiYYdZIW@boxer>
References: <20250206060408.808325-1-yoong.siang.song@intel.com>
 <20250206060408.808325-6-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206060408.808325-6-yoong.siang.song@intel.com>
X-ClientProxiedBy: MI0P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::19) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|DM4PR11MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5a15a0-6fb4-470d-c4c5-08dd46e4ab50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CLfeb1LG0az28WISm+ZStfMkdQFtPmAYauXkRrJ4qiI+hCao7/IhdGuL3Jp0?=
 =?us-ascii?Q?RiDx442vsVL1ZFO1cbpBSaLzy75PEKvAXLJgOY1D/08XJgb5MQGF2Uya24vI?=
 =?us-ascii?Q?wkwGg/g7NFfUCVxkQD1d9aJGj+HilDKy4UgE1wcRqdjRzWvMblwD8NZqLIgd?=
 =?us-ascii?Q?GLeS2WAhkOoeW68ZjxozsPTaVQgu9yTVLeyBJtuuDKsA4aXSpCrA/BAZn9X7?=
 =?us-ascii?Q?17JxRuofrDvCTQurQI2XG+9XK5I9v3Ps7zAFtSMWF09X4EgMC9p98XQcQAC8?=
 =?us-ascii?Q?QUQzC/sJ1tRWlnlwm1zxfAPcoDxJYmUM+TH+KGCKwg8wB/17FGZD4S8gZTN3?=
 =?us-ascii?Q?qZs818C0tp+bWgaa7KderVI+V5XIbRfPjnpna8/H5YIAdEr67hRapHNzc1sW?=
 =?us-ascii?Q?tJBiKzvyFuB/EO1S5MXSAHz3E2tr0rS8NVyM0q30mH4De43pWB0XjwxH7Mvi?=
 =?us-ascii?Q?b9BiuxytRbY1kxvp18nNilV+k2fh5SOOChTnPrbuUwqaUi3AvAqx9B82/9md?=
 =?us-ascii?Q?Beo2rkBUoHD2Kc2iKvV5i3iOeXYPUajL8GchNaP3wQlBH7OYQfoRi1Ylw0fQ?=
 =?us-ascii?Q?yUR7f9zptwJblhzReYyZiVNn9lQcjst4EUGbDPpfBlR9zouSC8b7uQT4B7nN?=
 =?us-ascii?Q?fapElXqCDIrJI4pK1JUGwNjmsFdJunVaD+rV1JRAC60RB73z+DBjfJfqErvm?=
 =?us-ascii?Q?GTr1qjoxZl50e0YXF3LGr9KdcxZ7LZ3/c+C3FxwQocuPvrMQkT7VuqwjrbYg?=
 =?us-ascii?Q?HDrXQz2aP/E1qff7nfhfnfb2OCJjSeVEnXVAXGXghfadkbglt6OOXJ4M2W0b?=
 =?us-ascii?Q?Z3zvSX64y7JRhw4HjgvabtX5njUXly63DOqpfsRW40HuvfdFsLvYC0QtXRUO?=
 =?us-ascii?Q?ILxWmomPa0Qqfi4fUspqPyU7SghwsHxUxWI7jJGg+qqaQmMamYI3x0Ci4Ski?=
 =?us-ascii?Q?JdSzLJbVK8E9p0DLUFTGVXEptbv1Es2gM/Zw04kWBLeUc1y1uUxStJLM0o4v?=
 =?us-ascii?Q?Mhv/Pdjll194DD39Hzff2oakDtyfSXBLovzr3eNcfGaXTALU2qYckIvRr5RD?=
 =?us-ascii?Q?04Y5m/GSwAhU6k6Rul4t1ODFfkXEzo2R1z/8/m8EVYb2zHavP0xTAwvom5VC?=
 =?us-ascii?Q?Yp2J0rLsRfi7BzBso7n/L1X3eraMYSRpa7tH0kqJmwczuQQNkzboEb48LXqE?=
 =?us-ascii?Q?UYHZqHABOUj42MCZTLRLLKfmUJNCIiYxxzob9a/1wt7oXH4hSMe+vRlF1EXp?=
 =?us-ascii?Q?sTvlHIWGdaeMIgqyq0d+BnZuUQqhWVcTt8RZJRlUzK27FzhqN3En+dToMZkk?=
 =?us-ascii?Q?G+HlgXoXJxNPofoascR24UawvUqJVtETrKmiQdL9Z9hEbb2uxdn+BUMe8HGE?=
 =?us-ascii?Q?32Co04rZXzXAX+dlO8PBp9S4xs/J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?33/mPiTMAL+9iZSHapgnPiLYlGsGlrRX8y5AgLRNzbhwrk+v+AoFBPQUlUJM?=
 =?us-ascii?Q?/EJMZG6+Kk3JFcQs4kSW3JMuWtQuJDA7xISFQeaiSzEEAvzqPNpUSrIECFDy?=
 =?us-ascii?Q?cX/XKSUqZVCNHS8mXGeE/RSih8csDlTL2FeE5+egzHsBtWib+y7fIX31OEzG?=
 =?us-ascii?Q?0mEtO0g358m/y6QmMhcUWxBTY540RixK6LFvGgDlfi8k2XXJSn8J6stkjUTF?=
 =?us-ascii?Q?1qlcuc39aUaCm+OVV93L8T2EB8dq4KTw3MDKWBDWRrBJJQF2Ptpbcht9+m3H?=
 =?us-ascii?Q?pxNuvO5pqFobmYhk3MYaYrI6MlAnW6Ma7NFflcMEwcqhA0h/dSfYMdPy1bX7?=
 =?us-ascii?Q?yv8hwhou7OuyXevvyWxbptqeDHOnnen95TI+mqJUUXNG98dnFP9BzoP+7g3l?=
 =?us-ascii?Q?NVoYuQZUxAK7OrfUTIZxJ6LWHSjhYwuM7swdqTVNFEYamxYBJXLxuBasM2g/?=
 =?us-ascii?Q?IdkXWa5JTmn86G0aNWjlye99F54yHMWzpv1DxoXd/qhNRXbjOoWWTpCeMypK?=
 =?us-ascii?Q?rvk1deTLivFmM+XAKYJjOcXhKraUuuI3gkVD5fDJP/YBR9i3z/ffs1eH0bxi?=
 =?us-ascii?Q?F+xg+UvJIFCv4AC5+81dFa9OOwFNLoKz83VSmQ27fgGpv7wq7VYXfOoYhC05?=
 =?us-ascii?Q?PXwq+/vRAaI6J3Ir0DzgB82r6bI7QaiLUtoOj+FCW2AjieitRngWgLE+ugSy?=
 =?us-ascii?Q?rd81ej2TIySuM9E3UExtT4GHdClq8kQ9UjxOc0h2LDRrKTg88UOAY+q0Jj8q?=
 =?us-ascii?Q?0L2STFfa0Gl8gJ4ot4dDQpuGwLEevSUhhXd9FppAz/M0oO10TAFBoEelsn+b?=
 =?us-ascii?Q?KEvwSYQsWIdBg2oa3BWYEA6nsIH/kOjQWOT0QsJTs+bnrqUoTCRjtv3bFInY?=
 =?us-ascii?Q?zSDcvorMZz4rHZ8E18fp3rVxsl0VWDOfT8ERDyKMWUYJ1LhyuSmdzMf+5ndq?=
 =?us-ascii?Q?HAdSl4d785YFBE43EODo7aUQP3gm0vspqGwx//5z/+mdCUHaolZw11j1Gv3E?=
 =?us-ascii?Q?kvLskRH/Hs8FBMM6oAWkRkpBm6BjetQREbx37aboWDcLSofRdyNodZEIhwpz?=
 =?us-ascii?Q?kJJ7Flj/9evNdagx8mSx2jREVFRTxbPtT1szEnSTC+swsW1R0YEWu62u82jH?=
 =?us-ascii?Q?mrzi2+BeubjIAHVKeu7TAA1TgJbir3C3Sz3G+vQoYiCWKjLGwaikjnn0GV23?=
 =?us-ascii?Q?LH7D0k8aoCxE63Ab/6XqXzOig66f9g2v7Vvw8vzOSN1D6msEItRo9zcGP0HZ?=
 =?us-ascii?Q?vHbL+utPfmUOrYnFpV5xbP5wwkdbMNopxavVIltmbqtgxXwTUYZPU3ywG2Cl?=
 =?us-ascii?Q?LBqwdyxpAQEHGu8AO0kDoy5wCuYCFE6K1Kp/oU8It4b3MktQPU+yiW8SULoz?=
 =?us-ascii?Q?9vIZ+RPvJR6Rt4CPCGQs2as0rcHwbvata/pdzCjpJv1s52Jx1PqMZcC7669y?=
 =?us-ascii?Q?OGE7qSrVcmDUUTHJbFD/tmkAVXMJoVe8okjKc9evYC2KbSjRQpkLzUinkGcd?=
 =?us-ascii?Q?GhzcTfCR+51S542z7K5koen1JNsQJP11QflIOJN/u3Iypcj7kqh7O3SdiKyv?=
 =?us-ascii?Q?Zay/o48finw6MPC8hI4LZF1XU6tuSDbkeHDLuurcrpu9ze1tpQZ3Lq8o3IFg?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5a15a0-6fb4-470d-c4c5-08dd46e4ab50
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 19:30:09.8545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upA/9QYYkylxdvL10NXhw6FsxLFBInI6q1mhIARbBeDT+Ar44NcKEvtIDgko7dR7vKr6BPJV+heHqKKTkXnPXtnDcFvAH4sB40MvKWAuIxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8179
X-OriginatorOrg: intel.com

On Thu, Feb 06, 2025 at 02:04:08PM +0800, Song Yoong Siang wrote:
> Enable Launch Time Control (LTC) support for XDP zero copy via XDP Tx
> metadata framework.
> 
> This patch has been tested with tools/testing/selftests/bpf/xdp_hw_metadata
> on Intel I225-LM Ethernet controller. Below are the test steps and result.
> 
> Test 1: Send a single packet with the launch time set to 1 s in the future.
> 
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>    $ sudo ./xdp_hw_metadata enp2s0 -l 1000000000 -L 1
> 
> 2. On the Link Partner, send a UDP packet with VLAN priority 1 to port 9091
>    of the DUT.
> 
> Result:
> When the launch time is set to 1 s in the future, the delta between the
> launch time and the transmit hardware timestamp is 0.016 us, as shown in
> printout of the xdp_hw_metadata application below.
>   0x562ff5dc8880: rx_desc[4]->addr=84110 addr=84110 comp_addr=84110 EoP
>   rx_hash: 0xE343384 with RSS type:0x1
>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>                 delta to User RX-time sec:0.0002 (183.103 usec)
>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
>                  delta to User RX-time sec:0.0001 (80.309 usec)
>   No rx_vlan_tci or rx_vlan_proto, err=-95
>   0x562ff5dc8880: ping-pong with csum=561c (want c7dd)
>                   csum_start=34 csum_offset=6
>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>                 delta to HW Launch-time sec:1.0000 (1000000.000 usec)
>   0x562ff5dc8880: complete tx idx=4 addr=4018
>   HW Launch-time:   1734578016467548904 (sec:1734578016.4675)
>                     delta to HW TX-complete-time sec:0.0000 (0.016 usec)
>   HW TX-complete-time:   1734578016467548920 (sec:1734578016.4675)
>                          delta to User TX-complete-time sec:0.0000
>                          (32.546 usec)
>   XDP RX-time:   1734578015467651698 (sec:1734578015.4677)
>                  delta to User TX-complete-time sec:0.9999
>                  (999929.768 usec)
>   HW RX-time:   1734578015467548904 (sec:1734578015.4675)
>                 delta to HW TX-complete-time sec:1.0000 (1000000.016 usec)
>   0x562ff5dc8880: complete rx idx=132 addr=84110
> 
> Test 2: Send 1000 packets with a 10 ms interval and the launch time set to
>         500 us in the future.
> 
> Test steps:
> 1. On the DUT, start the xdp_hw_metadata selftest application:
>    $ sudo chrt -f 99 ./xdp_hw_metadata enp2s0 -l 500000 -L 1 > \
>      /dev/shm/result.log
> 
> 2. On the Link Partner, send 1000 UDP packets with a 10 ms interval and
>    VLAN priority 1 to port 9091 of the DUT.
> 
> Result:
> When the launch time is set to 500 us in the future, the average delta
> between the launch time and the transmit hardware timestamp is 0.016 us,
> as shown in the analysis of /dev/shm/result.log below. The XDP launch time
> works correctly in sending 1000 packets continuously.
>   Min delta: 0.005 us
>   Avr delta: 0.016 us
>   Max delta: 0.031 us
>   Total packets forwarded: 1000
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

also with one nit. Thanks!

> ---
>  drivers/net/ethernet/intel/igc/igc.h      |  1 +
>  drivers/net/ethernet/intel/igc/igc_main.c | 57 ++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index b8111ad9a9a8..cd1d7b6c1782 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -579,6 +579,7 @@ struct igc_metadata_request {
>  	struct xsk_tx_metadata *meta;
>  	struct igc_ring *tx_ring;
>  	u32 cmd_type;
> +	u16 used_desc;
>  };
>  
>  struct igc_q_vector {
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 3df608601a4b..f239f744247d 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2973,9 +2973,44 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
>  	return *(u64 *)_priv;
>  }
>  
> +static void igc_xsk_request_launch_time(u64 launch_time, void *_priv)
> +{
> +	struct igc_metadata_request *meta_req = _priv;
> +	struct igc_ring *tx_ring = meta_req->tx_ring;
> +	__le32 launch_time_offset;
> +	bool insert_empty = false;
> +	bool first_flag = false;
> +
> +	if (!tx_ring->launchtime_enable)
> +		return;
> +
> +	launch_time_offset = igc_tx_launchtime(tx_ring,
> +					       ns_to_ktime(launch_time),
> +					       &first_flag, &insert_empty);
> +	if (insert_empty) {
> +		/* Disregard the launch time request if the required empty frame
> +		 * fails to be inserted.
> +		 */
> +		if (igc_insert_empty_frame(tx_ring))
> +			return;
> +
> +		meta_req->tx_buffer =
> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +		/* Inserting an empty packet requires two descriptors:
> +		 * one data descriptor and one context descriptor.
> +		 */
> +		meta_req->used_desc += 2;

tiny nit: you could accumulate the amount of used descs in local variable
and update the igc_metadata_request::used_desc once.

> +	}
> +
> +	/* Use one context descriptor to specify launch time and first flag. */
> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
> +	meta_req->used_desc += 1;
> +}
> +
>  const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
>  	.tmo_request_timestamp		= igc_xsk_request_timestamp,
>  	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
> +	.tmo_request_launch_time	= igc_xsk_request_launch_time,
>  };
>  
>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
> @@ -2998,7 +3033,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  	ntu = ring->next_to_use;
>  	budget = igc_desc_unused(ring);
>  
> -	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget--) {
> +	/* Packets with launch time require one data descriptor and one context
> +	 * descriptor. When the launch time falls into the next Qbv cycle, we
> +	 * may need to insert an empty packet, which requires two more
> +	 * descriptors. Therefore, to be safe, we always ensure we have at least
> +	 * 4 descriptors available.
> +	 */
> +	while (xsk_tx_peek_desc(pool, &xdp_desc) && budget >= 4) {
>  		struct igc_metadata_request meta_req;
>  		struct xsk_tx_metadata *meta = NULL;
>  		struct igc_tx_buffer *bi;
> @@ -3019,9 +3060,19 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		meta_req.tx_ring = ring;
>  		meta_req.tx_buffer = bi;
>  		meta_req.meta = meta;
> +		meta_req.used_desc = 0;
>  		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
>  					&meta_req);
>  
> +		/* xsk_tx_metadata_request() may have updated next_to_use */
> +		ntu = ring->next_to_use;
> +
> +		/* xsk_tx_metadata_request() may have updated Tx buffer info */
> +		bi = meta_req.tx_buffer;
> +
> +		/* xsk_tx_metadata_request() may use a few descriptors */
> +		budget -= meta_req.used_desc;
> +
>  		tx_desc = IGC_TX_DESC(ring, ntu);
>  		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
>  		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> @@ -3039,9 +3090,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		ntu++;
>  		if (ntu == ring->count)
>  			ntu = 0;
> +
> +		ring->next_to_use = ntu;
> +		budget--;
>  	}
>  
> -	ring->next_to_use = ntu;
>  	if (tx_desc) {
>  		igc_flush_tx_descriptors(ring);
>  		xsk_tx_release(pool);
> -- 
> 2.34.1
> 

