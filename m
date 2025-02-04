Return-Path: <linux-kselftest+bounces-25650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE5A26EC9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E464E166A8A
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 09:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC04207E15;
	Tue,  4 Feb 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kucSdgZi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6C13A258;
	Tue,  4 Feb 2025 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738662732; cv=fail; b=BOl+oVkZgz5GVY53ZaCjDywAn2acdTtIEju9XfSgehGsEzDuurp75cyu6/bgrBhKHPkAPfhXWzJkrnmjkea+bE797c1h4RLBZeE+xUH7yqXc/ppz251UdpuKL/ncrCyx16QfefGJNXcr7rgFCCU/1xMrdPPxIssdj9hFFtb3Rx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738662732; c=relaxed/simple;
	bh=7S5bgptkC/beVOLGFaiLMakvAQYdtNX3OA51ryHwvss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XEm0yN9K/G5oMQXKLk2tEGjbbxtCQMN/fBIxjdp2g7+eV1L0yzGhC0fPaHm6avGRzpC2tevRi4r/73mnJIlkz8SLm4irGWL8IsU5GH2bM8lI+z1vkCPgX5aPOLvmfEwjR0IP9mK8iiP0BR/KYNCuenvg9uL+Gd6aYAhEaCn0N9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kucSdgZi; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738662730; x=1770198730;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7S5bgptkC/beVOLGFaiLMakvAQYdtNX3OA51ryHwvss=;
  b=kucSdgZiqaXPBX/ozIqW0+N4cwPMg1LSd1UDAFpQmS9i10TYldLRZP85
   wzPdUxaOSaehB6NBID1loK17gX5xNHhVzJhyEvJ3eCbng3ii+DKLJcopH
   BYdiHijLJqTJjOBV8ReN4+WrngCcZb1Az4H0d8vsjD0c++QRq2AOB6ni6
   +NRKdtpQT22yYz/V2T0SLrCSDuMVLCC+rhpaRy0rvImyuIoYb2i2fOtMn
   noytvsAA9LNb3vBKNlh3x48uJQruQ5KYyU2kZoAYwofdSNpNsYupPR/C1
   stzjTow5lpGvrGqMrUANVZpbt8CVWcGA2QvkUhCvzOg3JIfTjl96tJbp4
   A==;
X-CSE-ConnectionGUID: H5qKXGSATwmZbWqN/W3vrA==
X-CSE-MsgGUID: 3h/OkmV+T0G5nP7sB8aMzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="38393691"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="38393691"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 01:52:09 -0800
X-CSE-ConnectionGUID: 8XrVZ8OFSnuuorLITmxxPw==
X-CSE-MsgGUID: EM/PiBSbRqC578/Z80VkyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133800179"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 01:52:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 01:52:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 01:52:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 01:52:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nMsI6IDENYF4lz09jJkYTPv6RbbocIzQbGIZE2RsLYM5VpQVUoMCwiUiKMHUff4AX/9w3X0rIAAdv/GwW/zFrn+oa3XF00Fx9Engqg1HldPqVYWFUrp+qsLvz5H5hS9dt4AguPBFl+6hDJDsPgToelepdLzt+gG8MWD4r0ZWw0KXD4nEWlN0HJyQJEClU4yG61/+6RvHIkpkjvLbLchA3Z6sZ89lvN6HFCZ0FvyhwBOTGllMaxkth5Ycj2egjEcfryFjDdNqSA23r6UN0yK2DAHKn4SMoGIxNK4lj5IP0Nw4QOQbZx5GKi/I+DvFT+9hvWBRQq+quMSCIUg667r5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nTXGqDmpgze6NmNsn/gec9n2Qm8qc1H8/X1p6znW24=;
 b=jWknmxYGKOChf4olJ5RNSs8rl+USz4mk5pmYMN+lCEbrwPC/MF4RkH6JhJy04yJm1vMM/V1EWKPTxRRpWWBPRbTO1VO9Lbk/EChi2FoMWYJ23R8A7jfiK/cGqu4/GrcKx6kN3LS0gXFX/unpZe3EoE/17q54qvIyh3prFp7j/5e7eu+tD1K51QJOs2RZOxAf62Js6lq6rZqxVNuQm4kma1mHn3+VHrTE1MoH3YePXW7qNuhl+TSSBCKjgUc0Gv+KQ/KTqE6auu75LTX/jCAsltbH6p0+UsWphqcaAMu/N6nGtaLTMLU41nKXY0cFVDw6T6tRmNC/Opxj4slA2ZTm2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB4782.namprd11.prod.outlook.com (2603:10b6:a03:2df::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Tue, 4 Feb
 2025 09:50:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 09:50:45 +0000
Date: Tue, 4 Feb 2025 10:50:28 +0100
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
Subject: Re: [PATCH bpf-next v7 4/5] igc: Refactor empty packet insertion
 into a reusable function
Message-ID: <Z6Hi5G0ngTnb7lb/@boxer>
References: <20250204004907.789330-1-yoong.siang.song@intel.com>
 <20250204004907.789330-5-yoong.siang.song@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204004907.789330-5-yoong.siang.song@intel.com>
X-ClientProxiedBy: DB3PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:8:1::38)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e69b387-94b5-455a-70d3-08dd4501650a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JjtgKOJq4eIBgZcWGc8p1b7Xgy01Xf6jFt32r0UcEvhwSV0zdcmYRKUDTL0M?=
 =?us-ascii?Q?X+M83pppk3UzbYiuRA6bwSmevfljtcceu12kVGMBEs/jUwsrO9VsSwijQQru?=
 =?us-ascii?Q?xaBNoIDRy2gSNIQR9FyaK7C5nibQXqzhIWXaD7TseuYP+F5kptI35OogFibv?=
 =?us-ascii?Q?1thSwBX16UNC1/nHV62eYgmqyrz8LaDR5TSwdoxFstHeUCAj/EFIB7yVSCh0?=
 =?us-ascii?Q?9NuaoV9cHwnsYFKruuh0g6w/TrK9OfEwBQKyhArNbKvGRPWH2VKoeTXIsk1z?=
 =?us-ascii?Q?yy9awZzkaljRtahZkV+RMOUXB73S79MRiEhpJrYisP8V+TG1no9xc3a7HlGd?=
 =?us-ascii?Q?QKUj7HX5cSc+xXBRHkaF1cUiVHDxDQFGP6ZjjvaBszvO88nfAnkXqYqrS1xf?=
 =?us-ascii?Q?lZ1FPMeMAZu7aglbPaVuy93TaiBHIlew2W9i3JJ43GTZt8BuJkiJIpobmb1v?=
 =?us-ascii?Q?9vsJ/NIgWSW4QWe5eMmxd+2D/EcCOkOM2xBdHcfHgwLNj11cYCA2NwQdpaZ0?=
 =?us-ascii?Q?tGfO7taV0NkFToUFqx3UUxYysSeclpLL7M0nVavXDipHEq6AWnF9nLV+sCt+?=
 =?us-ascii?Q?Yt8SkYHNROuxlf73D5LZ4wHPBFAvZlJsmpvyH8GoPctaWXV+OMjbsh/+SPBc?=
 =?us-ascii?Q?UJqOwx6U1lN2+hk0Vl6PVHHA4AXBcFMDXzMNd9VciSTdcMbTUY8oC5BZlpXj?=
 =?us-ascii?Q?Ilc9H7IIKYB4CwEfsQ2ZP+0s0ImMSG51r8jRANL70JutwJtwRZGg9KWIq9RR?=
 =?us-ascii?Q?kI9GEOBEeEE0wiBmFfMtao3qj/ZiorHjEZvgVjDz033wcSLz6h9C5k3WGxwC?=
 =?us-ascii?Q?I//YsA1OsR62Y368BGFNtsJy4Id2t3nI7yFsqMoHjvT0sNxcvnZSvdFqRMOa?=
 =?us-ascii?Q?cLoj+0u+/DQDRW5UeWv1hkL92+YtD1aH27fcRbFld9reNtxTDAoUjOP7hd39?=
 =?us-ascii?Q?reLwqSeomlQwrKqm/vV7eW9N7w8Ey7A6+iR/N+GBISj3nliyuUUGNwCuY2nf?=
 =?us-ascii?Q?9zxJq7kKU/5I/9pEhFMKPEQiIVK4bDBZr+iLfjJqVDMc0G0Up5qcU6qCULO+?=
 =?us-ascii?Q?/OrwmS+rvvH/Yh5yMe3QjS+FWLmyfl5WliHQR5Xs+KKM/kPMetoZR/nRys/G?=
 =?us-ascii?Q?701dDfks37vo8jw+VuZZjYxuY9XJOE+HEb3a/or4qD/AlrqHIynG3w1STEi/?=
 =?us-ascii?Q?moLksXzdsPnLkhRzj6JlxcXijVGE8ZU7Ej+7m+BU5Djckc2MXftzTs5FXdDT?=
 =?us-ascii?Q?kreVOh9D2UdJQWB+mfKRvQYBGm5FHNgdTNIz9GtwFTFaU8hR3WtuKO/n1F3Z?=
 =?us-ascii?Q?gqXKXkI3H/6qeyZYgFovKb8LAZBbczQEoo13D75/5gtJmJ24PKNYuGmNykor?=
 =?us-ascii?Q?JNM2UBp9FFwKT5nzJTRkMEKDaFiL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DfCqL+OC0OAr51H3DlmmN2PqGwVScZxZfIgBDT8R+mzMTv3n4mStD2pWIY4p?=
 =?us-ascii?Q?pGYiEDLqbmqi3xzWtB5E4JizGvt++CaECPD9VeW4OQ5XydB5Xuil3i4L+eVV?=
 =?us-ascii?Q?G7hVx1dxThPJG059Jr8xISym6LAelH4A4qhzyvC8JEL9tyi2PsX69RCZytSt?=
 =?us-ascii?Q?6zbHz4TaC5boDxBtZy/J/DZrp8hBPt56lCZyivS7PxmVP6OMSlxLSYZOayh4?=
 =?us-ascii?Q?+uf/wCnHSquITQj3V+RrspPsRmgMDKZ1LAIqH4JQEBxdqC6mQvcuECltZ4TN?=
 =?us-ascii?Q?/QqgfmE3VNduGlQDVYNuKYzOu0o4E06u27Aa/rqZKGEEhQk6YUmMKUR/zOVK?=
 =?us-ascii?Q?mnYji/v5OyzlmBaODcZL7DyCYBefD2UL0bTtES2hAe4hCIa1aGc62BmKUkxt?=
 =?us-ascii?Q?mQTPxCbrtu41pK8sC7ti/93lNNBdXWzt2nixJ+9dg/XxTEKw0pZkTvFQXY9K?=
 =?us-ascii?Q?HJUbD2U1mPVOM30JRK2LuqtkVZbmGf2ssIDCTjixNYDrzRdLBhYLkmkrJUak?=
 =?us-ascii?Q?FWFBxVwJhgC8qxW4BEsYnxo5XE597TXBZ0nIPkcuuG37cMHlb99LWzEmjhfU?=
 =?us-ascii?Q?nzWTauH8ZVZpI9KZSmtEb0Av58MIYy0EsgoCfNixGhuUFRZdQZP6T5MkZV6d?=
 =?us-ascii?Q?B8IWYGKKzsU4eFyMCl2teUDDHOFfKCL2J/4YYyoaTekmz/FocXbIeoV6DAoa?=
 =?us-ascii?Q?ear3J0yssOmDVGOhdTbeYaHlq8L2Jxk25czusux9PyfSYnl2L5L7XxJAo+7H?=
 =?us-ascii?Q?jXybJAZRar+7MjSfSd/JnW2awclNCjj9fp6zbyVgPsc0e4cqC0a8n8LTxBUZ?=
 =?us-ascii?Q?/OwHResu7GDqUlzxk1YNrcgaRcC/Cx9HlkNx56EB7MGPMrJSPBkbnYeNUd9o?=
 =?us-ascii?Q?M9ewwG1rbiwu94PGNx3XmOFk/bHQlsqO/7m5NqOpUM1Yb6YRnqTdjiTeLfZv?=
 =?us-ascii?Q?dz5jY2YlUvTAspFHoIKRX5eWyd3/tFMGTqrXPw0bi1lF97f8eZotm7Jf7pPO?=
 =?us-ascii?Q?4VR8Z2Yjhnx8BZv9h13iqlyzzYOxbkFDc/N+Yh5L7yhnM9Ge2zgnqA8ydYot?=
 =?us-ascii?Q?CN0/VHfHdzNQkVyfsTzi3AxRFLIPeiQu6PErCofYxDltgipD2ejYLQAr13j3?=
 =?us-ascii?Q?BlyMlKxRpAum4zy1gTasGyNKXxkP5c0YKokWlof3tGW1tJPH89LS532ym2yT?=
 =?us-ascii?Q?0HEAs7LP3YIxlE1i+ePOCokmHLUUcCCU5XYfJQKkxvEr02ei79nRpnfJYrUX?=
 =?us-ascii?Q?UMBbDHQx6/qDhUGbAGQ9croSvxOSqa/otRyElXzeb/lvRpNU6SCBhZhKZ3Cu?=
 =?us-ascii?Q?0TATF6Ib4ZdJaCfyyR26wd+nwURY36rlKzRjweGrBy00HTCtCZcNy6kDVldC?=
 =?us-ascii?Q?WW8Wt4lYaunWZ8IfvJXs6g2pgCN1imUgr6rsn6mqpPcnTujDo5KmMNqABD1m?=
 =?us-ascii?Q?FM+XW+fZXWQp96BReIjDorCxmnJCwpcq1UmrKiLpFe6cawTFaTLiu2E8G6Vw?=
 =?us-ascii?Q?vby+klPcS7w1nqwWpH32cBfs3AEbI0hWmSDjfhVJL61pQ3R25RA1YliEt8Nq?=
 =?us-ascii?Q?yi3rK9bIduW4v2gnJDQJJdS7Xt6RiUy8w26Iz8oLliN8QUcsAPKQU60pKrxo?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e69b387-94b5-455a-70d3-08dd4501650a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 09:50:45.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drM0IXRxpRbmmIQUN9ZYXQB+ozzUzWq0yCG4nHpjSUML4XvyI6etwTU2nFjFnDQa/VDzRpxMv3RUHrdF1dHdbpfCn9GJWL3XiY93DQVLYZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4782
X-OriginatorOrg: intel.com

On Tue, Feb 04, 2025 at 08:49:06AM +0800, Song Yoong Siang wrote:
> Refactor the code for inserting an empty packet into a new function
> igc_insert_empty_packet(). This change extracts the logic for inserting
> an empty packet from igc_xmit_frame_ring() into a separate function,
> allowing it to be reused in future implementations, such as the XDP
> zero copy transmit function.
> 
> This patch introduces no functional changes.
> 
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 42 ++++++++++++-----------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 56a35d58e7a6..c3edd8bcf633 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1566,6 +1566,26 @@ static bool igc_request_tx_tstamp(struct igc_adapter *adapter, struct sk_buff *s
>  	return false;
>  }
>  
> +static void igc_insert_empty_packet(struct igc_ring *tx_ring)
> +{
> +	struct igc_tx_buffer *empty_info;
> +	struct sk_buff *empty;
> +	void *data;
> +
> +	empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +	empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> +	if (!empty)
> +		return;
> +
> +	data = skb_put(empty, IGC_EMPTY_FRAME_SIZE);
> +	memset(data, 0, IGC_EMPTY_FRAME_SIZE);
> +
> +	igc_tx_ctxtdesc(tx_ring, 0, false, 0, 0, 0);
> +
> +	if (igc_init_tx_empty_descriptor(tx_ring, empty, empty_info) < 0)
> +		dev_kfree_skb_any(empty);
> +}
> +
>  static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  				       struct igc_ring *tx_ring)
>  {
> @@ -1603,26 +1623,8 @@ static netdev_tx_t igc_xmit_frame_ring(struct sk_buff *skb,
>  	skb->tstamp = ktime_set(0, 0);
>  	launch_time = igc_tx_launchtime(tx_ring, txtime, &first_flag, &insert_empty);
>  
> -	if (insert_empty) {
> -		struct igc_tx_buffer *empty_info;
> -		struct sk_buff *empty;
> -		void *data;
> -
> -		empty_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> -		empty = alloc_skb(IGC_EMPTY_FRAME_SIZE, GFP_ATOMIC);
> -		if (!empty)
> -			goto done;

shouldn't this be 'goto drop' from day 1? pretty weird to silently ignore
allocation error.

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

ditto

> -	}
> +	if (insert_empty)
> +		igc_insert_empty_packet(tx_ring);
>  
>  done:
>  	/* record the location of the first descriptor for this packet */
> -- 
> 2.34.1
> 

