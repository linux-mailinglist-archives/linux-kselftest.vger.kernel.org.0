Return-Path: <linux-kselftest+bounces-36286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9DCAF1070
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9184A5068
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 09:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD724A047;
	Wed,  2 Jul 2025 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RzozUyH/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07802376E0;
	Wed,  2 Jul 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449551; cv=fail; b=jJCbyqfp8EBkP9CP2BqXfXK5QERnEF5V3RGa6hBUh391Uim+jKfKFsMYTZMtxdBYpDINfmX8Ngiob+5Wwpzb03OgNVfzwVDLTw7oVxnf6qTs+kq+x9GM51+Vn7eOgN6wAiKS4s5t4cZTJMBJaGp8ENhBTz5j4khxHl+z/BP2MqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449551; c=relaxed/simple;
	bh=379qljmfeXpfhP91QuixTsPEoyJVn7YC7vl/Kh/rJRE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqYkhUwPczEntPSJJfzTyDPFlGIh623XkYQSN6jk20TcmNPQog2YCgo5X176xFnhhRnXurT/J+zBA4Qz7V+gjAjIGOcJKOU1I0Xn7hw0MKNszS+Rv2w5aYDfvJAud6aQq04Y7Za9BSRxFSEiTOlw+FHRMSTQzhsIMx35hq2PTo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RzozUyH/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751449550; x=1782985550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=379qljmfeXpfhP91QuixTsPEoyJVn7YC7vl/Kh/rJRE=;
  b=RzozUyH/Y/q2ZLbCbgZQhtGy252VpgDByU7p4O3/mJh+yCLvsFKMxUGy
   cJ0Zna9ewiOZejzl5odDgrABrXcLH2ovIk0Gs0jWis3kayhRWk2BNuPI0
   LR1XwmkQaj5BF6EuXbF1MAh4NtxIdPo5V25Vm6rWJuMnn2zt3lxDN16VH
   KDNHxsv5u+ojy4RM4Vm3OQl43QYU+C2CPU+Kipvmvt+11KHFiQBRf78O3
   TNduUSucZQFr+hpv9I2ZtzZ/kirfPcV9dKNkuY9OpTzvUn6o4TwuxZIko
   Nx1uYHLkGdQOt8nuBlwglMxYFgDd7fEGg9KvTmQF+3aYndvgw0Zvt5m/0
   A==;
X-CSE-ConnectionGUID: 8ep3BdHGSDKbk+djH0doGA==
X-CSE-MsgGUID: BuN4EJCAQlOr04nINwoPsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53603520"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="53603520"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:45:49 -0700
X-CSE-ConnectionGUID: T/V+wRpsQq6hQdabg8NgEQ==
X-CSE-MsgGUID: W+RK0LpJTG2x2XgPKXSqug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="191195975"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 02:45:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:45:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 2 Jul 2025 02:45:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.78)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 2 Jul 2025 02:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGx+JwKazKz2hu86gfcFR3CvMF4CAJ0AT+kR92WzqkDlTy2KU2KHEsiFU7PJMeL0BmTG58vdc0Ym37JHoykWcRWSPMA3WRMAyeZ1Fnr9lPHN97KkJa8Ag004c92MQPdMYlhvLjw2pm0D9q9QI0XWq0ytGNRUgYk/sBeyDNHrN8YnQFawCpvzhCI3lsiIKe0Dz1NFhEo9mfNSXrzjOkOOU/b955WfvWw9f9Ih5ALd7YZz8twxLJ+lcE5QgY2iu5BumfyVptAyighko8tDlXQNHHXeUCNf3txlo3HQlUjPmgHk5QKuIUYTmi3uPA2vmbxMoKwKsePiC5N6nwKx5Y57nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aIetPNo4kqYc0p30MW30fD5XktLc1dfuu+A6bj/SHU=;
 b=KOGUZJjS8BJJT71qXGmXC4jEMlctHTkdPTISj/VYkNd6jk7rSGUgJfSMF2vzmVT6C3HxndmLbW8rgwXef2Q7ieUL1/Ex+kJ5DL2Q8wovGa8Y5zv+izXZA+4xidqBLMyFNdg+0BbZHWd7/njxqkpR84ZOLl6FyCNclJmLGz6MdUlX+5UN3eIKJBxzgpwrPLtysFXjretfeMYaeGJSueh85kg/Heh2QnYKYGWE7+KQ0OAPsMy+lNnApqq6KXANe0/kfgsI/e+TEQYGaIQzRPlrMGcWPS25zHLnQEy7sPk5AQNXT38BahHlxXCeKLp2QgmexsK1uov1Djd+mSB1wK8LDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 2 Jul
 2025 09:45:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 09:45:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "will@kernel.org" <will@kernel.org>
CC: "bagasdotme@gmail.com" <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>, "vdumpa@nvidia.com"
	<vdumpa@nvidia.com>, "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "nathan@kernel.org" <nathan@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "mshavit@google.com" <mshavit@google.com>,
	"praan@google.com" <praan@google.com>, "zhangzekun11@huawei.com"
	<zhangzekun11@huawei.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>, "mochs@nvidia.com" <mochs@nvidia.com>,
	"alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v7 10/28] iommufd/access: Bypass access->ops->unmap for
 internal use
Thread-Topic: [PATCH v7 10/28] iommufd/access: Bypass access->ops->unmap for
 internal use
Thread-Index: AQHb5tGEgdXsGNB3/0a+rixMD5qoAbQenbIg
Date: Wed, 2 Jul 2025 09:45:26 +0000
Message-ID: <BN9PR11MB5276F03CF1E97173E711A5288C40A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1750966133.git.nicolinc@nvidia.com>
 <a2b2a9704d7efff717448cbb76695e83f2fe67c9.1750966133.git.nicolinc@nvidia.com>
In-Reply-To: <a2b2a9704d7efff717448cbb76695e83f2fe67c9.1750966133.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: e84cb246-9f44-47dd-9c00-08ddb94d2c63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RfNZkxu0fI9OyVCEgPYo0yCfXyWFORLIoH9fzMJTrjR0sNn5J28Q0aYq3GUb?=
 =?us-ascii?Q?ev/IaadiLB5387lkNk9EWi9CLBwDJQF73eJDNmArX//zPvEzy4v0CfOo2vKp?=
 =?us-ascii?Q?uAJoukuFiuETB0+itt0rS9uN9Wmnjvyt2XQe06FvUlmNg8v2lMHlFtRnX8k7?=
 =?us-ascii?Q?ZzTEPGEMnfnU3xbH2ttPZRhySDZG7NiPyaRPD1/VajFxS4UXq6gI1MJ06l32?=
 =?us-ascii?Q?uoG38NRMZ+pIN26Bm2IXd47A+Yc/u6c73/ZxJK0S72RpZIDCCja08UzwgT3C?=
 =?us-ascii?Q?rWQilky7omsyHuY63fkLInAD2yyM7fLYYCeadeXL+WGk2U2byRbs+uhxZCBu?=
 =?us-ascii?Q?r+uz0MEe5zSCAvsVNE1O52dyg3lZLz/LxWEu8rpSfaGDOZtnzfQrwwyU8Rk8?=
 =?us-ascii?Q?pxQNo8i9M+dRJDyCTgkG0kKUY3DKLHFwxBcNXvug0T/55h94ueP6jj8hmCVx?=
 =?us-ascii?Q?919YiMVVjdL+0FpZ/iNm/4J/pIMKj2suvGDTsINj2O/Pg7i9L+3TY179MNtB?=
 =?us-ascii?Q?4JFQalvZKydD1yaiO0qEnEa2/C8XuHhkHbkjsertJ+KSK5OPusTmpK5ETks7?=
 =?us-ascii?Q?JD7f3bXm9ZPxrP9PLcVanO9QFpxFHaTUJFy4FGZxdLTXIefk3ToB4/jZCg7j?=
 =?us-ascii?Q?dLtIDV31zpAlrKh8v9tlkEWzpi5vhoKCw4RjnP5l/u4sY5MxgvkJN2olg7ka?=
 =?us-ascii?Q?rg47Lzfqnjq953SdVq+9HEkGB/x01RQYf/xdn5GUxFh4smCqMy3x4sl/Bt4U?=
 =?us-ascii?Q?2TM5kluuFqo8QN8Xec5f3uZWJRWRwVUklSjip1wrYmj98w/f5/7uf0rL9Evl?=
 =?us-ascii?Q?zXp1iXVzAvjlnR/YkERSAdwubdgFgJStRZcZj3yJu3T18v1wtAYFt67glXCY?=
 =?us-ascii?Q?U1VbsFDd0fH5sdnj0JG2WjdLnxL+bR0FO0yXsCx5iQBYK+07Kn+zLm0hTdkv?=
 =?us-ascii?Q?EDK8Lm6VDu5N7s7hXvEiPd10sK02vk7S3DlTfzPq0tsGnzgGrIsNQqf8TkMf?=
 =?us-ascii?Q?hivZ1m4Ag2z4A4B3hBBtE/GXqcBAnTI5pj3VXyLWqcdwN1vy4+WYRU2DoZNz?=
 =?us-ascii?Q?FJwgu/2nMImF1053B1czKxQ385Jox8a99ADblA3/U8aNRr8g6WBmWAi8EeqU?=
 =?us-ascii?Q?dRLrxwQaypEBtH8nEloWL1nNVRT4dbuBIPCLc+QScALV9HZxLLlJR+ddBZlB?=
 =?us-ascii?Q?Aplz2or17Gvw0L3O3LPQ9EBMi/hwsQ8KCx55kX8J4Ci5ml/7twvqRm/Dj5WI?=
 =?us-ascii?Q?Ynh1cC3ODVFwf6IZ5IusnloMGG5g6ZlkgQFolPQ77ID9pVWqh7CxmFFXLxf3?=
 =?us-ascii?Q?vUvTEPLBVm/nfFPzg1VGLWlMUuRUDkaXTNqXxAxjGInKW2mtOmblZ7dcutcX?=
 =?us-ascii?Q?0J6pqdhOsgcYWfMBEs3eNHEn89fby8Vqn7PKIg1AtEXq+Cn8iDW92x6VFwx+?=
 =?us-ascii?Q?UNYjxvYUvhLWiw5vJdWy2HdscYapAuJqBu0NYjtZ4MjZsqTL2O40Svmo7AE5?=
 =?us-ascii?Q?JGQSHv6Lqb9U3jI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kHIFo6Ex8swT0V0UGwJTjVvtfRHp17Sh3t0n1xUP3Fp1yJ+YZs2PfVX/fZfB?=
 =?us-ascii?Q?X4ThbpiY6UAwflMJfBv1sYDU+mBhugY+G2DTt6WpxJttMdub0B3a0sMJCaVJ?=
 =?us-ascii?Q?LPIs8u4pSphq0ydWcbC6TEw/PJ7z96itJbIn68EVLH1vF4ie3+gs255RPuLE?=
 =?us-ascii?Q?JrcW3Awpx56qSqWlaYmSsXiX8iHtL0kOBQXLmM9TH0DbEYzYItXh/jfHuwu5?=
 =?us-ascii?Q?+cjElOwBlmblmalYYDIyuSLTaNwH4XQNyXi0kxn1BYMWrkIPHAwmplpRu3WF?=
 =?us-ascii?Q?1CK+Lk1UzutDwIyDfs5qOBEikigwqbS20WYhkTU3ISuZbLghAYIh4EOM6Lc6?=
 =?us-ascii?Q?Rgovm/cw4YH0315TQrRyNXxTRIDDEBBpW0aO7/kNquc36xNsX0osdW4SHdoC?=
 =?us-ascii?Q?8XYeJ086S2MrNhFey5C2jAqgpBBs/shNjSsYdgkAjtlaOFeXqzApbjeWTxjJ?=
 =?us-ascii?Q?x3yqK3YdssO1Fr5HpUvTcXcLP+a+9eAGVHawVuMuV+hoHQmoW3+kpq5LikMc?=
 =?us-ascii?Q?FCqZ3JVqYncY7G+KRRlhfoPScZOEypZHk4BGpYZ0ZrPPRURgeB0p1QJ5UtHQ?=
 =?us-ascii?Q?HtZyn3+JkxMnj+ZFg3NWkTbMEktYM3IF3TigzaGCQZUDXCyxGSHnmhbKtRZz?=
 =?us-ascii?Q?nBg2pgwXGa/qkMmqWox/Gl5Tk0ceCrOB8+ftdkYZOnAqDKErwbK/lGTGgjU9?=
 =?us-ascii?Q?wwckXIaSIzf99UtTt2AYoPHdm9oMNxzlKyzysWQXism4f2K8Q/TIGzdPP4ub?=
 =?us-ascii?Q?SQtKQprg6Ez0xjQOwMoXztJXY9tUR6dDiECNADagPeffuJmNyKoZ3iGKzmNV?=
 =?us-ascii?Q?/9F5yww8QrRVVNn8Mi20R2lLQS7Si/Fn/pX/aNRgTymkcaOEBOs2Z0et6vS6?=
 =?us-ascii?Q?bHjJI00hlGdHwE49vLM/7wePyZdpaa7ZK2SNSUBd1U+c+YSiCFmnC3yed2dw?=
 =?us-ascii?Q?dwyCToW1fdso9pFxoaGjOPOjQUL66mAThG9Ad5db1SgNcLzg/ejx6zl5QQyJ?=
 =?us-ascii?Q?2QL5VEElGnjgx3r01An712izmiMrGq2jNFmjpbMFY9+0S9iApSE6O580Rfna?=
 =?us-ascii?Q?/RvIHHRFur9ledn97ko3DgEoghoHFg1FIgdH4Vvfd2ra7IGZTojaC7bf9MK3?=
 =?us-ascii?Q?q0C94GJou4qiMusbIL8I79MSVFeZvPF00mWCRl5dMuVw/4eG5I0lPdoly2Bs?=
 =?us-ascii?Q?LX6D2G80EeEC86/4FosarKbDeNK8uLNY//01C6GYn/2wUO7/8z2jWx78PC1u?=
 =?us-ascii?Q?9/0qmCEg3pDNY/HxQlynNrs5iQfLqaw6NZjDo52Tci0hxyo9zRYMUoLU+QCn?=
 =?us-ascii?Q?z69lcRZgoZaFvhWBTtSoeXVQOLA5eptH2+ShX7oCp8muJ0eK2EalYkaJswXo?=
 =?us-ascii?Q?LehZIe2o5QLw9Cz2ypDWjXHtddMT7HJo1lQvGdD56xQ1ZPihheYMi/5AMt6v?=
 =?us-ascii?Q?1bzO57ZkVMq4+BOLsdp8Cz0WbcDOr+mE90ePot7OSgCmyPYQsj4J34FIdh0k?=
 =?us-ascii?Q?p0oeVM1O/uCgJWF4z1SnL3rqB9Earl7wee6up61D5grcbuBzRXfbOJJ+7cie?=
 =?us-ascii?Q?9Lzi2E8m0a6pkNu2uwN4PeUWuUAlcc3ZOzYAtCtf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e84cb246-9f44-47dd-9c00-08ddb94d2c63
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 09:45:26.4548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DvXQZfMT2HaGlPYdocj6gsr4Fcn5CuGyCb46vsb4Evm6ejzo+cMQMmSJtMEqbBBAqp8idawhtYycCwykevZNOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, June 27, 2025 3:35 AM
>=20
> +int iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long
> iova,
> +				unsigned long length)
>  {
>  	struct iommufd_ioas *ioas =3D
>  		container_of(iopt, struct iommufd_ioas, iopt);
>  	struct iommufd_access *access;
>  	unsigned long index;
> +	int ret =3D 0;
>=20
>  	xa_lock(&ioas->iopt.access_list);
> +	/* Bypass any unmap if there is an internal access */
> +	xa_for_each(&ioas->iopt.access_list, index, access) {
> +		if (iommufd_access_is_internal(access)) {
> +			ret =3D -EBUSY;
> +			goto unlock;
> +		}
> +	}
> +

hmm all those checks are per iopt. Could do one-off check in
iopt_unmap_iova_range() and store the result in a local flag.

Then use that flag to decide whether to return -EBUSY if
area->num_accesses is true in the loop.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

