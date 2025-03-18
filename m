Return-Path: <linux-kselftest+bounces-29353-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA7CA674C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 14:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1D9169D94
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 13:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430020CCF1;
	Tue, 18 Mar 2025 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXbM8OHD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74A3145355;
	Tue, 18 Mar 2025 13:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303807; cv=fail; b=jAraobf3xMEKsyuJG73Rz0NI9KjAMMhgc8D3fZ/ccn9qEKfxs+T33ff7yzkF0ovWmXAxwkxerrI7IKy6xqXtdlGRI1kHH8ZxOsYWO5lfZcgo+u0eKUhfF7YK4gazGcJmgXURO9BtVKCbW0LeAJ5jo0mEX4XVlxGv0aCw9dHfkJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303807; c=relaxed/simple;
	bh=k/vcPNpqs6zckzQUkzTjMj0h4+SoqdeJKuBeImYCiCc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d6RHbAXOnpG8zdeGljgUy7BcgjPpCa0v1B/NV4FM2fh0ckJandKpqA77SI7jwQPgHROMk6aAtSv0Lv1VUxfSYc384Fe6BY0hIFURiwdewwp2hRcvtia6S9GRiJPv7MHQi2g5Uvgxg5i1/Yvs9H0N7mxouLlwcuIuIJy1FcwcFBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXbM8OHD; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742303806; x=1773839806;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k/vcPNpqs6zckzQUkzTjMj0h4+SoqdeJKuBeImYCiCc=;
  b=fXbM8OHDMiUTtdXBCe6pGQJdTOl/b1i9M0mil97UaZ1HYjFZh70npNFz
   rsng3Y/4loZWxAOxIcNI3Cc7ZZggfyj/Nen6y1mV5cl+xpjtd9q42k8ge
   0HO6XLvhcdbSUlf103xfBQsOm3ejQmM/bK/LAOzsv+oFo98Pp5J9a9S/g
   p6GCTm0QvgCkqkGCaHk706jwMv2RR/6H6TfrXC1LvWRuIgmyujw6D1DiJ
   KUwfS/PzXveHtxVsJTv3dcHfBgj8sWWCvC/LsM+bTQN7x7RYq3b82U4PW
   TOdL1PtId9O4q5mr9R8T7UzlMb9mDmZQVa0TJLc649jGE5qz/PHQTfVmO
   Q==;
X-CSE-ConnectionGUID: fFg0/BtDRQC2QdeK9JUP6g==
X-CSE-MsgGUID: FrEntYQ3QgGNdbCpp3OL8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43311466"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="43311466"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:16:45 -0700
X-CSE-ConnectionGUID: uMYmSfL/RXe+/eZ8u0d1Cw==
X-CSE-MsgGUID: 0LZzOhrvRDqd5VfRVSLFlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="145440544"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 06:16:44 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Mar 2025 06:16:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 18 Mar 2025 06:16:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 06:16:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bPlnMFvIQs+1SuP2WYOH5wJ8GfrtQPrxVfBHEPZe+vKR6CVPb9pyObpubgAGPtuCLUWmLT3uvY5Xj6uSOuNWGPctfwKDmE1Keqer8wfryu40aHgRsfcz/LaRSqyrOpwVRDR79RtNfRsLGMwFqssO0nKDSx4X4B9FwXFGsl0L0LmZeoRqObl+cuVdzBdgtgcJhTy5x25e8b4S772uDzWReUF9LxyoxY58ZZ1mgt44x+XZQKntuTBZg6RRpZn8g4R1ao5rglOuBEaMVLhHU1d6mbZuKIqalkgkBsEWPvFuSlUFt1jf3IHKFpG6elqOy7q6gMjXh3P6tOacLakbVWlD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1y20dyFHVLYY88az+4Wz9lcgiInEETx8KVf+rvMPHs=;
 b=dqh3ZIg/DgFItlpIWgXK4Zq77eWsN5ZYS5TgnlkNQA599huhwjtN95YAeVknq3iMZc9ABlDNH7iZKkd5iJqynRCQvdoJ1WOk0FcFp6WAep5AxGW6anbVxujVO9uECYw48wP8Cin7ZTwsdUZkXn+y552GfXy3rO9uFEfKBHtzvWa2rBTWwNiVbSWfX8bnzqB9DaTudRyYbivfMdgooCtDY/m3KFPnAJioa2eIrJKxXvY7D76UE43/p4c8ucq7m1U9d6Pj2XndktfRnCCF0ECMZHfWj6dSLfFaIowoGhEKKiTkNPYwFuBKOSuayX9VC6f/r1fDq+VZhc9S+P10C4unkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8699.namprd11.prod.outlook.com (2603:10b6:408:1ff::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Tue, 18 Mar 2025 13:16:36 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 13:16:36 +0000
Date: Tue, 18 Mar 2025 14:16:27 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
CC: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>,
	"KP Singh" <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao
 Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko
	<mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/13] selftests/bpf: test_xsk: Split xskxceiver
Message-ID: <Z9lyK5pEi+FmcvYw@boxer>
References: <20250313-xsk-v1-0-7374729a93b9@bootlin.com>
 <20250313-xsk-v1-10-7374729a93b9@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250313-xsk-v1-10-7374729a93b9@bootlin.com>
X-ClientProxiedBy: MI2P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d22a26a-a341-49df-d337-08dd661f1c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1nhiLj9cpunIce49vYQaArJ0g6d9FYKrSp7z+55+rp6tu4RjLVfZbv40pHAP?=
 =?us-ascii?Q?8qjhGrxVDttT0uMmDaNvHFUPfU1XPA8hoU9O53M2MBrhF6+nLU6pq4d3qSt/?=
 =?us-ascii?Q?12mzqLHYVVeQTT0Rj5/fbRPXyXpVwx5IVD+lCNuvTkhtFeQo1P2NPJaEVV3l?=
 =?us-ascii?Q?OehFuzaUWwLvT6Gt+EdLbnR0zY71KcPuf4eGRvKc45Dwhtxz5QJsS27SLRPv?=
 =?us-ascii?Q?9oZwlxvUSNb959rqdxKUiLqvO+dkGSDGLYRPTvwYLSLievgXpZ6pYwY6T5b4?=
 =?us-ascii?Q?wvT/v4iryfROVk4qOxEQgdLZ7VZD473L3rgM8bXWixDBPuDxUHv2bx3CnDuN?=
 =?us-ascii?Q?kMhalVYSogr3b+fZ0+iODmAyCBQhVjm6JDksYGD0E95mXnKRVX8IUHRCc27m?=
 =?us-ascii?Q?R8bDmqTsRacUTfBNII/mSk5/KlQZRWoQ3ZSv7EG5/H7QO3pODTco0XFhrHGg?=
 =?us-ascii?Q?Uvi2Wh7to/7Cps1e6mHC+Wt7ZDcYFKmVq07yOuvjblDC4HT3DAJq2/W/4q03?=
 =?us-ascii?Q?mfDL2VSI59/WY0J+mqZ13FmcLUOkFVzISg74+B05wGljIyiGmsnehqnuOhcY?=
 =?us-ascii?Q?KzLZgxKvLinStPDembN/9Fy2zvJboh1/QBXDJRC0/ZTHz0F1I5n9DYlC0P6v?=
 =?us-ascii?Q?sT2wif9dEL7c4iy4mnJG5rAvzf1XCfkd4Myes9Soy75STbljf+pT6ngMzMfO?=
 =?us-ascii?Q?XRM8Ut3n5I0UyDhq/PpTnBIGNhsTn4CYJ3ktCtLTUPnucZuIkJGDcZRZD8jL?=
 =?us-ascii?Q?8c2HmcEfqgsZ71quMjo4wPnt+T9vSi7v7xRunG0ej5bmpl0BFi3MHpva6CoG?=
 =?us-ascii?Q?yJZGQjy7QvmphjPGOMhJImPRmnW28LrT3VU9Wq0xdakYidXR+UwpheC409il?=
 =?us-ascii?Q?+vYoly+gLdWS+9RxGpr7/4r0U4x8ovwjaG2sDVjdWas0atyupwJtYYi6RPF8?=
 =?us-ascii?Q?fj3vJcAxYG+ugNCF5iNAArinhLUfyV6npHubtdITsCTzXxeRquwvRnHwVQqF?=
 =?us-ascii?Q?KMCTHk8pz7/PaZxg+1r+v/OPJEqn6BB2Av6eJixaJcA2itfXSFn66cNjOOXU?=
 =?us-ascii?Q?LOAW4USUQydpa4546VgS6th9K4XAUCZXFi7We9SmMdbH2CWXtjYpdDmqn7JZ?=
 =?us-ascii?Q?p9bUf+IkXfzzlDmZnN9Bdn4hm4wEY+oXPkoXvXihKwgEdpbqNj7+b3ire0m3?=
 =?us-ascii?Q?xIMgC1SKVXskIr3GJtJfveX63E/Ye0rmoTuh/RNys7PyJo5v+t/lUlHrATzj?=
 =?us-ascii?Q?aAnRl2r/jtewdPL6U2EPhZtVdFQqo3DEbbK9IOzXqLpxerQSo/sjqhEMAGDm?=
 =?us-ascii?Q?KiX4lgzj+kDM6utGvaW+IX9Cp5mM6iV6oznoiGF6uVpPhwPGXG6XZxVYFTAq?=
 =?us-ascii?Q?52aVZnhVg+7iCzMRR2iAG636UiP8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycEso0wyLxo03YK2TJ123TudJs8FhiaxUCxxTGxmMPli+ZZo7cyM32CKNYRk?=
 =?us-ascii?Q?YRX9WVKzVZrIcFfNrQpXDsCjt5mz1qjCgnAMVzbTEyIdNGuw0ZKf0582DL7x?=
 =?us-ascii?Q?WoNEtUSuKtRLlaGh71faEN+MwJd2BvoaHSIQjJf7h+5+Qzmn8MN+/WH4cDns?=
 =?us-ascii?Q?E0YbOcI3zgA9fdH24dNAmcqCOmR3/cfjN8LQSjuZUO2093h7TiKrU9yNOSbO?=
 =?us-ascii?Q?lovnrjBPmssXB6wk5h4jb0q3KEIWiQAFHQge/GtVz2nId1rVl6MjXvBIGH54?=
 =?us-ascii?Q?PJsny2sIRr1UYdaZAVtsGKMG2+YN4rI/Al0mbA7EN9Vu7TLJLu0eqk8OXLz9?=
 =?us-ascii?Q?RYr/oqN8mztor4y+BylRIxh9zPdad6kFFCuwr14xBXMQobBWttylMm9LkrYj?=
 =?us-ascii?Q?1rRyEryF4BGnLrHTRe3YBtDExNOAKz0Eqqr/sJNKsEanvAz0xEpyMDA0FDlh?=
 =?us-ascii?Q?azR9TCyQ9pzVQgEbEkq+jZKc40z2AlLrj7f4e7yb0/ij/QO0DGvD1a2fgyeD?=
 =?us-ascii?Q?6XUCLU7zcy8UXSRb+phrCy4C/J5u7PZ0811UAai1p03/vkx25LKFUmZC4DbL?=
 =?us-ascii?Q?1FiYfg8fdi+l1UFpcrs8vZA3MgFM287TmewrkqW0ye9DBySzr7U7sci4UOS2?=
 =?us-ascii?Q?QJ/EzHqgskv0RwFkZuJ95rBIpS8UNiENfqrupos/5sO7gUJ2vpa/E1UlDM97?=
 =?us-ascii?Q?7x/SOcV6yyYouOrqgMcpWhs8qflFEC+/+boQngIIsvmgoWxrADUfZkCpLWkY?=
 =?us-ascii?Q?QWLP401CcdnlGtW2JR1mENQjBq9w2+FUSl+GYOMrfUTsi8MORk1xZH+JzIu3?=
 =?us-ascii?Q?cwWSs+YwF57RynAKVK+C4oRHV43/4mLWjeDEdhtOXALq13pAP+Q9XJfx+D6o?=
 =?us-ascii?Q?PHIxO1xjrlmow1CN32Q1WhUtBZzDHez+qhoh0ScRF4E5SwnpEFxhkv7gQZEz?=
 =?us-ascii?Q?x7e+4nP4lep0XuuTIriC5mZs6FTRezyWKuQq2HeMFEE9mI0nSWBLqUUiwnoH?=
 =?us-ascii?Q?7smYi21z3wNggkAbHvrj/bx/FFVMr84lWViMFD7LChgMdUVmYK3jQ8+7cZUO?=
 =?us-ascii?Q?2C6lOrvp5eWaFtr4n+4E+hfl6TqmYzLgogoATJpH+RUkcimvkwX1/TdZdj7d?=
 =?us-ascii?Q?SmmjQCmKe4wXtwoJHk2jGAc0DA5Rh0Z7fsIQPX5nhxOIyRBTQEKrwFMBePkH?=
 =?us-ascii?Q?8nEfuNbJJO7S9UBk7Uy19FK3I89kJpcr1ytUiB5dOyE21DLM3eqFoK6EB0sE?=
 =?us-ascii?Q?T9uWzamzjC2mn8g8JNpt3CcVvNLbLj1Iw9IUWgeLkwXgeRwbnlhRliCSn/jr?=
 =?us-ascii?Q?8Elljwc7XenfWJHuq8TY8ZbeOGmjN1nmOegqWPJuyIYi4dKYhzi2o/Ge5Mcm?=
 =?us-ascii?Q?KFEdOBTtybvDA8dtyL5SQy/EyMmDkGzagE7uIDIUDL6BtmrVBsK+dcplcTmr?=
 =?us-ascii?Q?eJsXb+krgh94uvturQ426Jfy+z0MsbH7U4D/T/WHQ+jXiZZktOPNLJA4kg+8?=
 =?us-ascii?Q?366y7bnvDJU75TWdGIssqQ8Ygr7bFxhWvmAa1GhMZqxKbM6YqKyt2I22iS4v?=
 =?us-ascii?Q?gb6ASiAnA9+t+8BJfMC7eTLL7+7FF2Gotuy147fqU1LTSYaMzfNNfzNWBQ8f?=
 =?us-ascii?Q?Lg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d22a26a-a341-49df-d337-08dd661f1c7d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 13:16:36.6450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhl44m4PhSFIh9cDlMQ5pLrbrXWPD+/d0n12hbJbL2xC+TdvO1ZZVXHpK7rEitPL13eHpPM0m/lae2lW9WE9B3IimIPJ2Q1Gb5orIHo9KLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8699
X-OriginatorOrg: intel.com

On Thu, Mar 13, 2025 at 11:48:08AM +0100, Bastien Curutchet (eBPF Foundation) wrote:
> AF_XDP features are tested by the test_xsk.sh script but not by the
> test_progs framework. The tests used by the script are defined in
> xksxceiver.c which can't be integrated in the test_progs framework as is.
> 
> Extract these test definitions from xskxceiver{.c/.h} to put them in new
> test_xsk{.c/.h} files.
> Keep the main() function and its unshared dependencies in xksxceiver to
> avoid impacting the test_xsk.sh script which is often used to test real
> hardware.
> 
> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> ---
>  tools/testing/selftests/bpf/Makefile     |    2 +-
>  tools/testing/selftests/bpf/test_xsk.c   | 2416 ++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/test_xsk.h   |  279 ++++
>  tools/testing/selftests/bpf/xskxceiver.c | 2503 +-----------------------------
>  tools/testing/selftests/bpf/xskxceiver.h |  156 --
>  5 files changed, 2727 insertions(+), 2629 deletions(-)
> +

(...)

> +int testapp_hw_sw_max_ring_size(struct test_spec *test)
> +{
> +	u32 max_descs = XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
> +	int ret;
> +
> +	test->set_ring = true;
> +	test->total_steps = 2;
> +	test->ifobj_tx->ring.tx_pending = test->ifobj_tx->ring.tx_max_pending;
> +	test->ifobj_tx->ring.rx_pending  = test->ifobj_tx->ring.rx_max_pending;
> +	test->ifobj_rx->umem->num_frames = max_descs;
> +	test->ifobj_rx->umem->fill_size = max_descs;
> +	test->ifobj_rx->umem->comp_size = max_descs;
> +	test->ifobj_tx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
> +	test->ifobj_rx->xsk->batch_size = XSK_RING_PROD__DEFAULT_NUM_DESCS;
> +
> +	ret = testapp_validate_traffic(test);
> +	if (ret)
> +		return ret;
> +
> +	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3 lowest bits when
> +	 * updating the Rx HW tail register.
> +	 */
> +	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> +	test->ifobj_rx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> +	if (!pkt_stream_replace(test, max_descs, MIN_PKT_SIZE))

Here's the victim of test failures that i reported last week. This
function succeds with 0 and you interpret it as failure:) One sign wrong
caused two days of debugging, but it was kinda fun.

What was happening was due to the failure here one of the sockets was not
deleted and later on whole test suite could not attach the socket for
every other test case which caused the ever going failures. Which makes me
think that since you changed the logic from exits to returning failures
probably we need to take care of state cleanup in a better way so case
like this one described here wouldn't take place.

This test is only executed for hw tests that's why you haven't seen this
problem as you were focused on veth case.

If you want to proceed with that then i would like to ask you to grab the
hw and check you're not introducing regressions. FWIW i have been working
with i40e and ice drivers.

One last note is that verbose mode seemed to be broken for me.

> +		return TEST_FAILURE;
> +	return testapp_validate_traffic(test);
> +}
> +

(...)

