Return-Path: <linux-kselftest+bounces-41600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F41ACB599EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD14452362C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A3340DBF;
	Tue, 16 Sep 2025 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ra2ojWBX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179801C8632;
	Tue, 16 Sep 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032490; cv=fail; b=Y2U+z2R9jK61sKqfh4UFq8nOQoQFNhED5V4imfFE0sbNsQlH/ocMVr/3S1LZ6EWSa3fBThHwM4GMigGuF6pIFdgqh8f9WTr2hdB0xoY39UW0yhCuu4Xe/kvFt3/Ud0VZ82QclFqUpwGJwpnd5VYf33Rcmyjq9yuQ1w9aNAYzXXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032490; c=relaxed/simple;
	bh=Ga/Je+kmSZIgzLgiqcgsKh1g16D24jBJuy3oYf6t8sU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eDwyjF2GZpeQWXsfxnv1KnPVlTSK0plBU/DbeoSACnpUFRPJKRHgAxfBXnTJQAJN6iqMraXQBSn9rRmWl74ReGXO8z+BUAh8RucPApA3R7DESeQwTJNxSvZN2Wcroy1rgSvFzMYTj1TtU3LmDiZKVUqKIMH1IaD61hN7Xwy3sJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ra2ojWBX; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758032489; x=1789568489;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ga/Je+kmSZIgzLgiqcgsKh1g16D24jBJuy3oYf6t8sU=;
  b=Ra2ojWBXDyCv8rXzo4ld0Mf5RkqOaFsOU6J5H6VFfzJcwtIpbzD/L6B7
   bupw1WdU9TEnN9QqQWabPklWg3QSZZzq2hqnFE03sN44JghYxPSpsO3Gx
   1i9t10kuzHasgBLxKgZ2EfaJSbodWPn+rPJ3NSdsayBzUqPjbWFB4C3iw
   0cfW8NsfjDEi+uUU09jBorVvfFtHkXAPYgZILBFTVtsscJppjF/wGJDRU
   uzswr3YBoI9KyRTw/vHaTsWcz585o8F5wNwQUZZMfJszSjpq8hwSRMaVP
   +4M9rrtEg9TScPCBun4gXR73loJMVip6fbC/MZIJxwl7WUzhsoIL2vOpI
   w==;
X-CSE-ConnectionGUID: YXTLAeGGTkqRE/6jjiws9A==
X-CSE-MsgGUID: 8tznaeEDQfSk5+Sz+duZAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60261238"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60261238"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 07:21:28 -0700
X-CSE-ConnectionGUID: JmnrxyTfTmK9YCIURghFBg==
X-CSE-MsgGUID: c20gnH3PTF6NQUMpQwh86Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="198648108"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 07:21:27 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 07:21:26 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 16 Sep 2025 07:21:26 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 07:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQcvv50l9PF6IlZH2Hmunop+DOFo1LhmLRcoA84V4Z4TIJeVamqtJbcG3AQnJl4dA8u5Qy2KgzjLPOiWT3wS5gLO+3kD5hKnULzhCTijbSiitIDd0JB67uHOYVTuQCAxs26zoTwKrz41s385VbDC7jIyxJBjcqM2KZRhoHlzXqPPke3Un6UJ4fsG+1bfoN2CCSGj9rG/UZ7Tvhheq5sT7L7YxH2jQBQjZ5orBBiNe+uelaGH9Yn3Vj61PmnzkvM2n5qZgeVPlTEpzOnxHE0G3K9EyE2jxooboV5/4XihalAlTvylrxSHtWwgqVOO5c7+ZNLeqf9XvnnmKnex7psZDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca/giarmC26wWvenDUakOb1HS1FvgqWqd1Zjdoe8DKI=;
 b=mIFqSywvTxK/quBCsCC63ZvbI1SunudkNaxmMuqt6DG/Opy8YFbQtTTbKToiql3XL9GeaPzSWEl5o/L4JD6zn+GtdvgCpOdSbSEmij8T7t6oBwwkbm5KfOlMjUUfYKX3o7fmOJPZYKB58rj2L8kdR5JSAJgO19Jyw3Ll3zRu9IDsdL8gl8LAcsj7C+sbAGMNaYV+c10/FSF4vhnoYHIwhbZz1GQR35Xu8Ow33u+2wtpsLO2+Ggq462NYz5y/eh+InkNEHi5NKXTq1ebOek5+b0v/PtuhzYZ2j31LwDE75BGpjkvuv8cwIUVeGwZSH49HmKXrxviJrZDw5De9r8DEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB9499.namprd11.prod.outlook.com (2603:10b6:8:268::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Tue, 16 Sep 2025 14:21:25 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 14:21:24 +0000
Date: Tue, 16 Sep 2025 16:21:05 +0200
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
Subject: Re: [PATCH bpf-next v3 01/14] selftests/bpf: test_xsk: Split
 xskxceiver
Message-ID: <aMlyUX999WOmUNMP@boxer>
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-1-ce382e331485@bootlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250904-xsk-v3-1-ce382e331485@bootlin.com>
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 163b2cc7-3dce-4841-1172-08ddf52c50ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NIFgIugoCkMSos/jC3nOKT6+SdZ4fopkwTqbEMgkK9QocYpYY25hBJ4plkOV?=
 =?us-ascii?Q?r2KFkR+qrsUXCRZNeABhfLVFxI58kCRZDtKLo/2igv0l7MRjXi3NqS19MB9H?=
 =?us-ascii?Q?RlEsrv72dKercGkjfjY1ajVV+xW4nlOuPH+6qFm1YAo9zJPU51JvRbLo/PQc?=
 =?us-ascii?Q?Kyfa2Bb2E5qpsioNQEl28Uq3Xyft/kBnPBAxmukqnzxcnIEFwiyli40+cdfQ?=
 =?us-ascii?Q?fTf0OmuJALiZxOygu3tKWAyRSUd6tFHNSe/V1e3zynRYRSKjttEB8Je3Ielx?=
 =?us-ascii?Q?3oeGGyVGEHNUqR8j2LR4bobQOcbi5Gs/dYyyTa5m+V3upBfKrbm6hFoEAxfm?=
 =?us-ascii?Q?s1sqGUEqUL3Fpd5yrJhZaNKnh/8gKpC7lTSvxlTbgl6w4BAKcMWR3vthTgeW?=
 =?us-ascii?Q?o3zEvVoDuG4uywuPSNYWdsyaVeNBKvSB9agVRhf4qH6t4Jfi+ebUuJwGBXbE?=
 =?us-ascii?Q?64RDNwlTiQnecZXJgIWm8WP4ous2Tpw9w1YGp9bAnwnwRAs4PqJYfPHt2n36?=
 =?us-ascii?Q?gWSulFVxZVevp7AaCis2nN0FwQWV8PS6KfeBTuem6M8/zTD24dVuUw6PapA9?=
 =?us-ascii?Q?uCuCSTsr8Ws4mG9Zri51t064Hln+6F6sFlDn65NXpThrIF5NiAX2nofmW6gJ?=
 =?us-ascii?Q?faxAeYyxJyQXX2CL1BYTQ2Y3PPDidu5NX+/t2CJ0xQHO+25KdrlmOuEvkkJA?=
 =?us-ascii?Q?b+6eWtxYZgKlb9AFy1JZmJsdnZlxyZ8dSlFDf22TaHdlMg6P8yn3pwlB2FZf?=
 =?us-ascii?Q?cayRUXFIS8FM5vMhPdqWd+zZF2RADwQ0L+dJNOVnKKbc53Ui9ex8fjApihqo?=
 =?us-ascii?Q?SKLLhl3LwqGmQtUW8zhuyJ70+XqfXAEhvODbkQy03WzxUMnUYKCKn83+o9w1?=
 =?us-ascii?Q?ZpIZT4CH5izx130yvaVR1i/MxBTKiRImLTSwxZi58hgcYC5q2eioNz+UOztQ?=
 =?us-ascii?Q?QeaBpVIMc/pINAu/NJHCNYmlB8OucdTgZu1iqc45OI/ivp3lL6gJ2rRSBlDd?=
 =?us-ascii?Q?bIxCpewEvwAuo1kJMYTPvTOA4XiGLMbMLyBVO+vlRMsrc8S3iOHsLoQMrdPg?=
 =?us-ascii?Q?7w6zDj6DpPqywosAN5zAh56a0SYrmQxbnGmOsWJ/44rX56Vc4W/dIygRqoHV?=
 =?us-ascii?Q?ULjH9wy3S7CfzV5lP+RJ/i8hqakh2T0OGpRn9j+tqJ/bX1wxmFX58IGijCOL?=
 =?us-ascii?Q?GcXCulKb5kLRRsmk7R6aTeBIkeP4DyG+HQab6Dfg9orc0txfgastIQtC4jnt?=
 =?us-ascii?Q?sIf6vQynp31N6hoV5RDfWM0RE4VWRwhMvd9lFVoyvmvoZXKDpx24s0hqvRW9?=
 =?us-ascii?Q?reN92FE5rP+cRQVj4RM2EEZMqbcUkjk9uZQRl+WJaQzXF+GMsqNRselu2Ss3?=
 =?us-ascii?Q?26wU9MRao/F8LdTisYc1qpRW0VaH52KewX90glMeBIY/uSfJU38Yt5OLM3Mg?=
 =?us-ascii?Q?OGmHI7jlM1U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZQ3VOd2NGsMaqK7YN7QMx/FdIj1h1Kp5ZkDGb7PMMT0jfBsFU+luZ0vI7HhS?=
 =?us-ascii?Q?xpAAYKMwD4idbTRmLFj3gMEpSFk5VgJePNp3AeHLjken3DD9onTgTJ5Eobcz?=
 =?us-ascii?Q?sc9jn2frcbKK5rXwWSzgM8/NDnBp4Do4fI0CFDAIatHYiTur9Nzsgord9hNQ?=
 =?us-ascii?Q?C2bm3FZybB5aLsqL6cqk0KvOEJxIHmLFRiSJ4mjnEs5Y2dh+k8RsccUYx1Sw?=
 =?us-ascii?Q?QFq6w9/Rb7qeVHjfnwDrw7xWXWc1TcdvOd6ZjZPJNtmCYRdk4BHMFr4w3yyt?=
 =?us-ascii?Q?C2dMk61RSFf+65B1jpBt7F+wntfORvRz1l9ylKUojQ8Zq+qh2FQ7dI7yw2SX?=
 =?us-ascii?Q?D2wdIBKJgk11cpx35ynjvIBaFI67HAMHE43FhcEXLLOvJqN3FPKcLHipKCtr?=
 =?us-ascii?Q?GQ/ec+wlIwq8uvc2Pkd7oxRIfhTgUYpxM/2K/YRqsuWZtbIaPK83eQdMrKWr?=
 =?us-ascii?Q?dv7BQ0HAJqNXoZOU5OEEF1Y6TejVNWuJzh6oGtwfxU7uY0KoCok4TJvIXy/z?=
 =?us-ascii?Q?UHJIbC1okLDSeuntEjW9GEJ8SI4UpcxYPG2ugGoIC4f2I9YKnadEGgjSzOHy?=
 =?us-ascii?Q?lsp8xEcCMSguf35yoqYbMIYcOEivAv10UgzqoGWwXAGTeu/4cIzRI9VNw86L?=
 =?us-ascii?Q?UHb58606ttDEAOy55mKPepMFVaGeCN2F5whxceYDA7gtgx1UPMgehp7iwcWY?=
 =?us-ascii?Q?Dmtc8U00C51pvrXJ+uo5fgBiglUR2N80TdadU35FUgkIMFN6gHk2P5COwM2Y?=
 =?us-ascii?Q?gy82j7K/RFilqZzzpviFRDFbY2vcURn5ozq+5vEIoxOiVspiZJnBFw0yIAd0?=
 =?us-ascii?Q?qnvZ0+Ktd/MIXW6ZRBqzIbv5ONAxZjoi5v+qHSP8MrRFyRB7mUMlxWtbjUyK?=
 =?us-ascii?Q?DV5CMWAdziDkqCshh8QGbbZ5dZtamBh+DJ/FxXc/zGozoUEwkHTr4NPtIOKg?=
 =?us-ascii?Q?nDLgdX7J2P78CStQvTM6U4RVblyeOVMEslOAZEsulDfxPYma/4t0hkx1zLgM?=
 =?us-ascii?Q?gyhCnuGkFdz05ds4l6FDOC9MFVdY9x5Su+knBnjaCOBbLgSjT2giOy6iPlrr?=
 =?us-ascii?Q?FTX12HdZxgU+b3gtv2Q6AlurF680KidkoMxSJrve6RWtujLhXpGIsVqrGXyM?=
 =?us-ascii?Q?0XrrXknbQpWYZvVtKevbBDKiIQvWXcEvaOw1A4op36D0cayX+/QQe8NhpP1Q?=
 =?us-ascii?Q?rqg2LdbPaN7qktI0DSjtjeH70sVhbPBUQo/YA5LO00HV9NKW2HZSEkkYW6o5?=
 =?us-ascii?Q?bl8kcs9vEziCjhNUiXIKd6oObO3OlV0Cz+jDvcCNOjjRGZC2TuUuUisytKwA?=
 =?us-ascii?Q?fGpuPfu3W8GJMQX6PSoAipenZuOwTp5S2Rl4qc3fQhhO9KWmqEtIGUFNjCdB?=
 =?us-ascii?Q?0EaFoadYJMnNdoLkBOpiA/l51rWUUIwlfC8UNVwsUuqwZWSKpr9xzesfNjwA?=
 =?us-ascii?Q?VptsnMnkmK2QBR5OQHGn6H2lLM0gAM75CzLnFUgSISMCduDwsFQM5FxtZU+U?=
 =?us-ascii?Q?vv6wHBYP24ep+ZlM08QkjPxXtKDIKVgeAFOQCVuYI9sYQjOR+d5cb6yI4Lxs?=
 =?us-ascii?Q?ALnMzyG9fxOXJ5V2vErYSf3/Edan6p5xLR2EgSqisppdv1eJwb3Wf8Ntkp1Z?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 163b2cc7-3dce-4841-1172-08ddf52c50ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:21:24.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5IaDPUg4eXohy0Xfjc3EHR9DfZ3KqKe3yMFDZvYdgaR21+vdFY/HJrdUWaEMh8lGIBUjtigCf40GoqO3ft1VzG2EP6Y4EGZ8PR4jPgawJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB9499
X-OriginatorOrg: intel.com

On Thu, Sep 04, 2025 at 12:10:16PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
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

Hi Bastien,

after this patch the way summary is reported is different.

Before:
# 16 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:53 fail:3 xfail:0 xpass:0 skip:16 error:0

After:
# Planned tests != run tests (72 != 53)
# Totals: pass:53 fail:0 xfail:0 xpass:0 skip:0 error:0

We lose the count of failed tests. Could you take a look?

