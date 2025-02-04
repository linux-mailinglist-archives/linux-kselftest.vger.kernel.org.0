Return-Path: <linux-kselftest+bounces-25652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E42E9A26F15
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A79164571
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CA62080DB;
	Tue,  4 Feb 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aOjXgHeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D212080C1;
	Tue,  4 Feb 2025 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663827; cv=fail; b=fBjSunVO9JBg8DFLfj3u6cblekBPJbllVqzA6CfUemdHNXseE11DGiUT7kNCFl4UMONuS9lqkNlwzIitHCgvs09Dmh+knXJeEszesmG78HJ7bJ6TGQTbX8dNwBYboYZ57Cw//X23GlnDL02+5VUcCv9iU0qAkJAi8/6JKyUfcII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663827; c=relaxed/simple;
	bh=nBnKqNl3lt/iiw4jLQeKH2pji+BhxYgrfw1aTqjYq0w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JrNE1CIP63DMZqY1T1z6NF9eeW7bYmXhePYFI+g3PIGVuAWLzo2nwX+HPySoSWf1bsIDQwQ8bhHebmBkmXuDJ7A2659elZ7C8dTG0j6v93T24iHa7uMc23yDPsBWkFsTSxHyOPRGzlN8z3A5Xp38opqkX9osYLQaSUzrAQ5kwqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aOjXgHeN; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738663826; x=1770199826;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nBnKqNl3lt/iiw4jLQeKH2pji+BhxYgrfw1aTqjYq0w=;
  b=aOjXgHeNFQ28xkq7C9+9vAMYlb/ijr6qzbEUQBAxLtYUgjHeMEHwtpRu
   1KduEZgknXmFL9s9BNhdcretXmZF0LaojKiTKs6OZhO/heu6RKod/cA9/
   gsHBkMuCuogEUlrTRtKcMJ/fIF7U0C+SAFlee163R9rlJ7ueejXyftziZ
   6gFOO6eJhoHLcScejRP87kakRHm4ktT+fZhdZAnM1Xu7AMUBG9Zwfo3YN
   OOc2zw6S3tDMMqmxEKEWRc+dI3goL+k12o7gLY4jmo17fmouEPEI2vVAl
   r0bS1VmbmHqkG2rMSue7EalQrwcC/sX/sLLJ6QE7+mO2jKgyIbBCApJvn
   Q==;
X-CSE-ConnectionGUID: Gddb8OSPR6Gj6uBTOb6ihA==
X-CSE-MsgGUID: /xmR0HJ6Q4e3wWvB/wh1aQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="39215511"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="39215511"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 02:10:24 -0800
X-CSE-ConnectionGUID: 3ZEaXA+xR3Gz9nN0prfz0g==
X-CSE-MsgGUID: nVVWprw+Rra6J8LqW9jr+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111006434"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 02:10:22 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 02:10:21 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 02:10:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 02:10:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJdFmM/lYrFA+zGpeZz6eUMTEkub2RR83mBtX0bMcODHXsuV36BLVvoeGR5QJuiu1l2wNgcovKw6doD8dwc10zWFwO8cGyscDO5FVNuDO2RpRDEMeE3gQLNrbP6pAtGBoI3eIaQ7brVviV5Hn2Ede0HCCpIuBpw6+h6OtHv0DnTf2TKFVtOtwSn+ol/QY6ntzzAY6z779R6fC/Nrs/P0ts8hzrTTVzuIb5AzIpC5AZ0ZJM6yfnCjXggxhFTMYu1VK/K1zwZbFfCMvHraJW1wMRCGeKv0PNg0jy+0dwZ+5L2x18DqCl1qm9xxCb8rgBPhzLtxZ9IdjGiA1JG6NuSt9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCSOGazSxnrt7ZVL9iz9UME+wKfjTUnbLsE1/eyXlIM=;
 b=xE9pK415hIih4P1lPFzltl26Abd9CGIAiLZzpaP7nAk8wpTfa/WwubmdWBDHmVr2kw+ELvQDEO+g90h2OAgfJR4BExEiJ5DLSvziN/jqIaeo1Pxmp5mOow4lNSffXy87bjU4F3RRsAe6bm9qdZ4+4I451uaNGBglJ29okRrGpcUuL6qWOXMJchbJn3f3p7g8SEi5j9Rc31lVsAZ7BLvwUWgksYM5lp53J4VvSNk+x6igQG4+9fFfhW8xH1oJzinrBnTX+4RqZoapN1AxnQJpY+9XfCaYv4eUq6kpC4otk9kGgd90Cwt81rfbb/l1jSB5gYxibLBAxvxBkrPbpbomQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB6191.namprd11.prod.outlook.com (2603:10b6:8:ac::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.24; Tue, 4 Feb 2025 10:10:03 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 10:10:03 +0000
Date: Tue, 4 Feb 2025 11:09:44 +0100
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
Subject: Re: [xdp-hints] [PATCH bpf-next v7 5/5] igc: Add launch time support
 to XDP ZC
Message-ID: <Z6HnaMQvgW+indqm@boxer>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-6-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204004907.789330-6-yoong.siang.song@intel.com>
X-ClientProxiedBy: DUZPR01CA0047.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: cda8d342-1844-4704-087a-08dd4504176a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LwJDGFpkioTlX5J8d7IhN8VhT0itw6Dn1DJr6SevYw2izYya4ZabUPB8ciK0?=
 =?us-ascii?Q?gq32y7dAl3tzE66CVA8H3uvcV7sJIKtI4BKRKB7PpW0pgl5/4ZOtTEa1DZEb?=
 =?us-ascii?Q?gNRgsZzWEOu6QdCNzVDGytdWeutYGssuNRvcnOqpM7zIi10CWr0bY0t/FP+8?=
 =?us-ascii?Q?VdKFCVvJYMh5PD+pRcBEzavJ/RRRG+al+K12ePUry5MaHz+fPhgc/CC5FVb4?=
 =?us-ascii?Q?/ZqfVPQRfDIsk454ttAok//DKJEDzH6wcvkDIf1QqOu8BQTt0SrGCMs/8RJ1?=
 =?us-ascii?Q?Lg9SxZFas/mLULQPR8radWZ+SZq62nMfvQM60Vx/f2ZDo2OtX6hAC57Wkj1I?=
 =?us-ascii?Q?9PXe5gr0+rOMt2EoERsXF5G0o79upt2lU1odB6YeGzn+Rx/4joLGQ+gP2i9b?=
 =?us-ascii?Q?ivT+BP1IP0KlhFrjOf5v5ZcSkHVLfbEIgJQcXc1CBkOtCnFM+F4kU0PQU/kL?=
 =?us-ascii?Q?J49ZvIXKj81xQBz/6Cep7l+02vqGvtNVVs3FyGdV+7+97yHxMVzjuP5Y0Dig?=
 =?us-ascii?Q?Hs3+TtmAuSr1hH5v1al4JHLc5cjFkvtZ2VH4k9xLCqS+vFWL4Cq0EogsP6Kf?=
 =?us-ascii?Q?pnkUxyC+dtrOTbcGZD68adMDPu5IbRRP/jmCGxJOP6KGyDUkRfpCgQetbhuZ?=
 =?us-ascii?Q?a4aId7d4rcLqubZ+CkAfYL6zAyobgmZEetOfSem8YUgzWys5F3y3bg1fJYT6?=
 =?us-ascii?Q?NNIGIkhCmz9dqggnSfpaWRsU1eUKqdqwX8PlscUdM75Hme3FBjI14a6sigaF?=
 =?us-ascii?Q?Dmlzudys3cZfa7TZoCLAsi/H+XDBmiylsQxzMPiIcdZGJgtGvxALRXxrVjvn?=
 =?us-ascii?Q?Et3kTa+cfzsevrMgpOp5G7OQhrQ9LICUt1NewF9fJrv5rB9jDM9JNVcbLb8a?=
 =?us-ascii?Q?TTSiZHCxYiu54YUESQwP7JbPuSVnzYECkZGy8NPAf2bvYtjuDLOo1bU3AGPp?=
 =?us-ascii?Q?HhAzKRDFYO8Z2y+blWeOSbGeL6fg7C+eDTFnWIROSdSoP+PZOnqVzkfpw953?=
 =?us-ascii?Q?g1VSikRqJuCZB47hP9wiL1Nr2PN9ugkT/KenHLrELYZp5r270BS3D+QjO4i9?=
 =?us-ascii?Q?+Zn3JRN0o573UOK2E0vU1HDOq1heekjVWd1DqAN9+wuO1Bho+mUj3DU5JAJ/?=
 =?us-ascii?Q?zLAOG0qI//PM190SNbiCJiMFdZlXy5jT05VP9be8dilBkdwtk/DIwMi7DsOc?=
 =?us-ascii?Q?1N9GOygyRivObPy235bLxwKsc3P8Y2Nyq8kfAfowu+61/aqn2aIfAsMukFNL?=
 =?us-ascii?Q?2cz7NzOkDn0urc1ZzjJmzaCVoC6mVG/Rlc+YErzACG4iLAh/Oerid+XGI6aN?=
 =?us-ascii?Q?Ggrk2sBCe6/0HGLu/S66PYfLJrZ1F0z/Mwuoua0b1emHuQKG++lTVEUJzNBR?=
 =?us-ascii?Q?tkr31RIOvx2ianMJ6vMiiJXGovT+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVnxnGQh5ZzC9qX9cj3XUeU/NuFojPEtZU73ulzgyY11prdg8uslMmScer0s?=
 =?us-ascii?Q?qenoQiiC9fRvr5xB8cq1fPjrSey/SRhFttvK7oKoVBu8S4Ukqc8resUH9HvG?=
 =?us-ascii?Q?s9ZxVH1EWYJERXJWZgqKtUy/SDs0WHIszaF9mbO89HJWxkIUnipylQhF0DTG?=
 =?us-ascii?Q?RoqDHg1GqhtYJ74eRL9yPUG8SHzfglIxnNCMaSlOgYJ0g/Ugif+4dF7qHt7D?=
 =?us-ascii?Q?c6gsDJCA0KsLj53+63TNugdo0LKEx3isFK6ZkQboSIu9fQmLdi0VU/Ou4akj?=
 =?us-ascii?Q?TqZgCaHCkurskFsgfWnG1tFaKvFzmivZvUjMj8trpCdXFuqSBfIiOvvXD+oI?=
 =?us-ascii?Q?H2EUG4BPp6c9YlUMqlgC3FrRJtHp3ZvVFQ2so2jzU5qDtDOXcaJ12WCylP8I?=
 =?us-ascii?Q?5Yaay2NuxZSW8AvNPSawAPN7EaF9EbDSQRD5hA2400ROMDOoegsS7g5d0m27?=
 =?us-ascii?Q?2Fat+Xc5K+fKns1bd+/trRi6mYL6o4ee0iXj7CVSwoQQe6EdsZop52EJ246r?=
 =?us-ascii?Q?onitg88mnPDm1ZSwQVD6AObKIiKinhF97hmsD8xNQvy7x+IzuMg/By2gx8i8?=
 =?us-ascii?Q?ayHLclrG02c0zmvxqSTwo9jNc9dF2XhIzPy8I63Dd5OqnEGGUHJjVMoH5mLr?=
 =?us-ascii?Q?n+2+3FMod2gjkD/ZLlVpqSPxZpyMEpHywXKBI41ykKD/aYVOInDYFQQpuSo4?=
 =?us-ascii?Q?soMshCrD+Sh6s5O3xzhSalGWLUcAcUWiBO1EYTaUZMb2yefMvQ3kawXBYsho?=
 =?us-ascii?Q?T2E7u4KUSvgLeY5AAGQuTphOuSdDEglo7aXpLZPCSLUslO6W2675RsoCjVY1?=
 =?us-ascii?Q?ScR0NdjgiAVzOKgq8o1i+BFStjU5tL7VlMmfSS0WJR4aGvqzxtTxBW+2+4s+?=
 =?us-ascii?Q?nF/2fsbXJquux+uqyRivZBvjdHrSOrXOl1ZS2vReZLLGtHTxxE3lO6xLMW/Y?=
 =?us-ascii?Q?MKs198yY+skuOySEFevabhgcf67zvOEZBVDlMZ0v4u1tMjkDBZ4NN+EGMUXO?=
 =?us-ascii?Q?waWVG13O0v8/ucFEolb+Q+LB1STs1rE+j4wXy+KYpQWh0M6u9OMzYVf2XpZx?=
 =?us-ascii?Q?LKD7cnHCEceBtXEjeR+j3iLm9/7EbRmDmcoeCiLAMvMZARI/qmg1mkI5Ej1f?=
 =?us-ascii?Q?rH5hOtEOI37CVlljrR0DWnnvoBRMR8d6SJzqDvPpPGUASW9VqGHcCdpliL6V?=
 =?us-ascii?Q?LJCzaLNgtIdawe37xEx0JGA1EGCpATnVGCfX7cHvgul/UqaLEJTfIB6ActGM?=
 =?us-ascii?Q?DdqVG+aQFn5SxS+MZuqfZmPcRTBeQpmKihWWPUuDTwQiUqqSd3O45tacjnZ0?=
 =?us-ascii?Q?PRBmseXQHGeuLFZ1RCtuGjE1aT90kanyU3ApLFzHF+smKQB+DKGhL1srMRUP?=
 =?us-ascii?Q?brcxp4i8dARBbh7AusI1nKaJ0/HPycNg6mXrnTq0G9wuzvBwSIKvl/JqJu28?=
 =?us-ascii?Q?e53VhAAS8HxyctHk7rQ+kfHb31r/cZ4vFf/UjecyuWSJ4YI1r/xkY/RTMa5v?=
 =?us-ascii?Q?9GBRci/FXLEkdWy58sB3//ho7Q2EbDh1va4AOmFAliGAsG3DUEWWsTDOAsGC?=
 =?us-ascii?Q?QN9iySZDjrsA2otDuOQTKcf8Pc8nxZO+rbnz410FMW6194CBpFYtGZUxulCY?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cda8d342-1844-4704-087a-08dd4504176a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:10:03.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b33aMkQs2kxtG0gKzCFrBZG7A7ET9OK6fEzTWSW/RM6wO3MgaNxIcbwk/3YJprhGnB/I0hUNyJtQVrLGvG1AEtAAXIU8urTlrs3fQU13fjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6191
X-OriginatorOrg: intel.com

On Tue, Feb 04, 2025 at 08:49:07AM +0800, Song Yoong Siang wrote:

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
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 42 +++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index c3edd8bcf633..535d340c71c9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -2951,9 +2951,33 @@ static u64 igc_xsk_fill_timestamp(void *_priv)
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
> +		igc_insert_empty_packet(tx_ring);
> +		meta_req->tx_buffer =
> +			&tx_ring->tx_buffer_info[tx_ring->next_to_use];

in this case I think you currently are leaking the skbs and dma mappings
that igc_init_empty_frame() did. you're going to mix
IGC_TX_BUFFER_TYPE_XSK with IGC_TX_BUFFER_TYPE_SKB and the latter is not
explicitly initialized. Even though IGC_TX_BUFFER_TYPE_SKB happens to be
equal to 0, igc_tx_buffer::type is never cleared in the tx clean desc
routine.

> +	}
> +
> +	igc_tx_ctxtdesc(tx_ring, launch_time_offset, first_flag, 0, 0, 0);
> +}
> +
>  const struct xsk_tx_metadata_ops igc_xsk_tx_metadata_ops = {
>  	.tmo_request_timestamp		= igc_xsk_request_timestamp,
>  	.tmo_fill_timestamp		= igc_xsk_fill_timestamp,
> +	.tmo_request_launch_time	= igc_xsk_request_launch_time,
>  };
>  
>  static void igc_xdp_xmit_zc(struct igc_ring *ring)
> @@ -2976,7 +3000,13 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
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
> @@ -3000,6 +3030,12 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		xsk_tx_metadata_request(meta, &igc_xsk_tx_metadata_ops,
>  					&meta_req);
>  
> +		/* xsk_tx_metadata_request() may have updated next_to_use */
> +		ntu = ring->next_to_use;
> +
> +		/* xsk_tx_metadata_request() may have updated Tx buffer info */
> +		bi = meta_req.tx_buffer;
> +
>  		tx_desc = IGC_TX_DESC(ring, ntu);
>  		tx_desc->read.cmd_type_len = cpu_to_le32(meta_req.cmd_type);
>  		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> @@ -3017,9 +3053,11 @@ static void igc_xdp_xmit_zc(struct igc_ring *ring)
>  		ntu++;
>  		if (ntu == ring->count)
>  			ntu = 0;
> +
> +		ring->next_to_use = ntu;
> +		budget = igc_desc_unused(ring);

why count the remaining space in loop? couldn't you decrement it
accordingly to the count of descriptors you have produced? writing ntu
back and forth between local var and ring struct performance-wise does not
look fine.

>  	}
>  
> -	ring->next_to_use = ntu;
>  	if (tx_desc) {
>  		igc_flush_tx_descriptors(ring);
>  		xsk_tx_release(pool);
> -- 
> 2.34.1
> 

