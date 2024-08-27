Return-Path: <linux-kselftest+bounces-16402-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF61960C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24481F21B0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200041BB6B7;
	Tue, 27 Aug 2024 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy1YYrfh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643619DF5F
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724766316; cv=fail; b=hOZH+8waNm47sw4xeEPzSzyAB6SgLmnT3exOKbHbaTnuQW7DHEZdbPU+2I+L6nYWEdBZLl/cb4VJ+YR7+bAQuqjpjWazNnuRWK5FLOumkSkCjozOdzBnH0W4LxXE01D8HsWVfJpjxVtiOSAA9KIKhYOmVLvyVJMfYKVwXtGGVwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724766316; c=relaxed/simple;
	bh=Rd5l7JCFmYKC9/YCO5Ahn2rr3gCKqasxZI7OGYV9DPg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OMUnLLfac4WlsCa83x/mVDYZLe6jMA0eJ1ApdNFZ/HFWMWi6Gtr7D1DeHRyxKdkWzHVkVNxRad1ZGKYZ4XjT63OyVEa3jDm0rxeFkaA7wB8QAiuC+3K+6fdt3smDOwB/j958klVdpZ2avLdWb30UYKrFYq6FjIzIvF/tASn80tE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy1YYrfh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724766314; x=1756302314;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Rd5l7JCFmYKC9/YCO5Ahn2rr3gCKqasxZI7OGYV9DPg=;
  b=Vy1YYrfhlpymuoiWZwwNqb3NEFu2aMjpFKAM8R8bkDvNSeXYag/c+Q5o
   OQ137fBWt7IMIU87leetTGZRnqIg1q80wlsq7neuPYwyjDHe7ccump8Eu
   +DoygPpEktEKcob6whzXlPWUIhe/Z8u4aM7kJRhaN29ncBXVxyCubdWfQ
   +VzMVuz/jjA2+nPWSz50lLUZ2UHDdca+STYweyJnfLiiECq7BIGf1Kmow
   CyRYul61GHOqbbehrrX1Qe7eoqzt++8pbG1Xj4nU3E2a4nozHtH5VBIIJ
   l83BVyOiQYlIbBHW//UgLjoWrmjODRz+PhcPUuCFG0n+fqpb10Tqwfg68
   Q==;
X-CSE-ConnectionGUID: IgGLu03/SYO5LhYffp/v+Q==
X-CSE-MsgGUID: HaLNww2DTBeVJ+uCVkiW8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="23046167"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23046167"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:45:13 -0700
X-CSE-ConnectionGUID: GlxjpfH0Snq+l6Do02BZsQ==
X-CSE-MsgGUID: 3LULm9C3Qpi6D4CdZh6aNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="63371833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 06:45:13 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 06:45:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 06:45:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 06:45:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 06:45:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0+wKrxf1/4nMtxJvqScLkd6/m3378eJiXLspETmk45e/lb9/YrfLfPQ4PZxhhLabTI+5xpPdPeT/OJMVUdJdviQIsJ4PwfEccgQsjZMHMf9PkT2YSJYmXda2NguWug3i/v654eAloelHhRSvVN5D8CbmqG8Gf+gdtpM+4a7HdacfFXqDiJNg7daXjnbSMDrSmXmmY8cFkSrU9iJZi9uYq0KwCJ5EeqNHf9N10oFMhhOePqII6AAPvtbO3Upl2atyAKOkSZb6db4lbgGlnKuCDOHX1QlBdUmZsEfKwSNqkaI0JmmJrAe3Wmf7RNQSgmH01tKGA3XpbwEGqoe9/uTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTobfjpAgnuZ5MwWSMDBUGC0k0fwXBAd1izybAgfdZo=;
 b=OWpR0yZE7v1HXvrTGvtEHyk36ln7BbZMneo0EqpUX7yfSIcVS00qQyxlhqF1ZTjrFu2qtnCMiEQn6jfF+Y9w/utcXPlTbo3kLiTDL4EQyZGcJhfWz+RO/tDZMPlhqyqsDSr3PDl0CYW3hQs0OfhA/80sIB/bofH0EQOp7THcK+PBtm1OsIRuUxPF0ACLrxIT0BMMp5BRT7SFcWMtg6I/PiT9RNT7RNZ6KidK7ACqID8p2ncCdCcD5kETvRDvLqT/Gk6A1OzdPnt/nqx2snAErKkCC46m5YffIiQKecEFOlH8Phd02Px+VQV3geRVhgw3+eh81b6nDqKt1h0wRKbBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SJ2PR11MB8423.namprd11.prod.outlook.com (2603:10b6:a03:53b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 13:45:09 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:45:09 +0000
Date: Tue, 27 Aug 2024 08:45:06 -0500
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
CC: <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>, Rae Moar
	<rmoar@google.com>, David Gow <davidgow@google.com>
Subject: Re: [PATCH v2 2/6] kunit: Add macro to conditionally expose
 declarations to tests
Message-ID: <unqbtufg2lgqdwaazti2jb6f7wkaggcc6kmcpkwxv2ylt4mgnl@bov4zj3uj66w>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-3-michal.wajdeczko@intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240826222015.1484-3-michal.wajdeczko@intel.com>
X-ClientProxiedBy: MW4PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:303:b7::29) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SJ2PR11MB8423:EE_
X-MS-Office365-Filtering-Correlation-Id: 660cc590-b9ef-4606-a3f0-08dcc69e772d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AdXr6fAAdvvtE7ij6b+SfN6xmd/C/KLLxmfr7SpeaNUg3GqRSPPDo/qIpmrF?=
 =?us-ascii?Q?wTnLDURgubliS4isLNA2PvqkPDGYZXSSpPBCDJ9AFgk2IiqzHD8koxY5ErO7?=
 =?us-ascii?Q?Jxrzbmky/FEq+NIcgmnlecCjNt9PnrZMsFH8IKALYs7TvwjngW9CXqVseKXq?=
 =?us-ascii?Q?ZzYYXqGH0PMlun+AWeAdyI+lFxfI1Q58XCvRBErb+QrN1warwb7IzDiDGX9B?=
 =?us-ascii?Q?dxDqAO+3DPd4Pc1G5dGopaPq1GrRr0DymYFomNdSoNuck9YdP8mrKsom2+x9?=
 =?us-ascii?Q?W9TxL/PPTMziiNszS2H1SNH5fJTIMpgJqA8Iceir75xVIqpeutAzU3FWPIUL?=
 =?us-ascii?Q?8rhD8of0lZ90fkQfQA8ycqMGBcommT/g0KI4exYrq6qRvPCUQrLURUbJ4ODW?=
 =?us-ascii?Q?s8TLDp/ws1R6ABoKDOWpp63w5WfE/muy46XNTHGVmKg5ialZaXpXW+P5RGsE?=
 =?us-ascii?Q?ZH+I54bov4U4aMk+FO/rr0hXS/tETL3vLZ0RTjsNkMBx5UW2aQLB8LfrLTOL?=
 =?us-ascii?Q?qzIkjdMLEZ7HUysuR4dYf/His7QQEZ7QbKKhkaydHpV0UYi/yg1qYtBcbule?=
 =?us-ascii?Q?XDaotEhIWVedXdN/YjiGwXMQOeBC2W64YI6TW/3uNi1apvJIeypluvloiF0o?=
 =?us-ascii?Q?wJJ+RMi5j6JUg+Z2YP6iqidS24lQGSCnM9IALEBFcQNY5LOzX9xesBjGIYWy?=
 =?us-ascii?Q?mEGHhBBkF9unFjtgLSjFKpq0yyXvTalSWzgxgl5tSugoYJiFjfrKkhVcuj1o?=
 =?us-ascii?Q?cd5SKDa0UamOjqSzrTJXAsIj/wq1DhTnqru9m8oO9FMzB0kHGW33laDZYZKl?=
 =?us-ascii?Q?ESJ6WtaXXUXnzxuMd8PdZXAfUOfW9VRw3NYqBVj4s4gOYWw/LGL0lzNl+2Nr?=
 =?us-ascii?Q?SpKZAant4eSr4DJ2AUxnksFTBy8gKttdBXXXytCBvjNIJuKTpCOs0WqjLLgw?=
 =?us-ascii?Q?8pjHIPSf+4OBsGLBQ21b2/NTcXLqAtTlyrLyVQ1fBc0e6twTxVhyrGaG67Li?=
 =?us-ascii?Q?fEc1sCw7N/NhcD0OKMc/tU/589n4fvYetsuf/bPRzVrmXTU0vnTl2eRCbc90?=
 =?us-ascii?Q?mKuvrw2deUT4F5wUMDtoR8RwldjAtWPy9zlwhPeIH88HI+Xk+lLVyuLMqJ22?=
 =?us-ascii?Q?AH4bwGLW0KGBQxOOYt0QN0wB4tgKB+7YIfhLt4GBXSdDndDFdGs9SGm06/tZ?=
 =?us-ascii?Q?UZiY0j9X161tU9a4lkRxVBkNtPP1DHFVPNOvDWqTzF6bfo+tp86tYBcOfFvJ?=
 =?us-ascii?Q?W3MyC/373fDEVW3eFfTyrSwCJVlV7pHEiUFh29ukT4Ey4JuiwIWqV9KHXYK5?=
 =?us-ascii?Q?eKPemA+8NyrLp9bI4PTfR33lre/dqPyS/EkF4lkAQHLCbA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtSGjLmNIy477/BowTX1khO2C4kAdmjL1VO5w59o1ou85kd3zvvBCzDOssjQ?=
 =?us-ascii?Q?X4q8+V8xRkzedotaTdQ3eAa28UO+H+8y/YVdktqVamSzrlthlN+r0kgnHsIw?=
 =?us-ascii?Q?lHYQ7KmAe4KDgN73nUxHFs9iKP6RPjuDwnOeZXiyUFAc1nDnaLCbo0v+gV2X?=
 =?us-ascii?Q?L0hxuFimGTki8FnX71TdBK3lHbV6M++MerAmYvtt6apwi9iLv5LQ9Icn0a4g?=
 =?us-ascii?Q?kzeC6u6O+NBXBHiu1rBRaDM9/ZQXu2uzJcNm0snhio0moGO7u1EQzNUXp/vd?=
 =?us-ascii?Q?wbZ/6vPD2B6Z6UJnFLdALV55wEI61+rP4jclx33xV43XrSAkzOBXvtcJ1qf1?=
 =?us-ascii?Q?GEA7JA2soiHyKdD5he/c4m5W5TA7+IUwN70zuKZjooL4mjvbh1CA9X8JHk1M?=
 =?us-ascii?Q?BRmStswhr4sVroQUQQK8j+BoFJpAcNBI24QjgoKqg59Zgteb0y0Z2Lfw5Fn8?=
 =?us-ascii?Q?8+xdO7RHJ+D1cSjAer+uZsK8WGN/pb9Xj8qXcBhwmhnZvucZjxWsw3Bxi4Vc?=
 =?us-ascii?Q?SBiN1bKVCVdDVpNd8erHh3sCCAplVIFifUJ4vdCBF+g4/xx7/aMv7l/NEUSL?=
 =?us-ascii?Q?vu0CLnDMULX6n0OpubrsAqxlxAq8kB8mYPYEtJ4YQkbj9z4XjgheYLjGPPCS?=
 =?us-ascii?Q?Ub5Ad24Ztg8DR3UaMFYGYWdXhaR7GtiDcwTrUkO/0P4yDJ4lCQFP4FOUugNY?=
 =?us-ascii?Q?aSO0NDReuj6mzIrYk3VnzywCaC3AjqHV3cm5ABttMFc68YTk3AYI41YqVM+h?=
 =?us-ascii?Q?LsrwyxU5iAX9n03HyPXgCkUY/27ADrLYEd2szlZ3nsX0ABcGDvzC66+V8wS1?=
 =?us-ascii?Q?CmtiOAoAi77c06GpM1BfV/A2uWLaau8jxcnGfhvIvgm7kr0DKNfZycr0uXPM?=
 =?us-ascii?Q?/V3XI0X3EE7QpVW8br5O6uo2Tkrz5rOMs+JiXXYshvaEnW/H+8XY5cdxocee?=
 =?us-ascii?Q?FGAYL4uSeRggZ7HLiCv5soNyT+/rf3X0yrNVbjVH5VxRixFU8ltgCegEtruu?=
 =?us-ascii?Q?VmnJ9O2TDf9TsSeuk/xmaJtpm3e2dwVWwZLqdQ1+JUDZW6MrEwb967ZwA2fV?=
 =?us-ascii?Q?3uksjK/jVpslVB61JNwZmaa7xTaRpusoIP/r/2dL90EdLJPWVKgrtyprXpaR?=
 =?us-ascii?Q?jKxkuAgmqe1De+IQQqaLfAFaRUXAOUM5K09SldS+FujO6Qgxdt3EXawFBOgo?=
 =?us-ascii?Q?DcGMj4JjYcPghLyJEInjoEbK5wYeHCj/vqazGqqhQib9T4BApu35ovbLiEG9?=
 =?us-ascii?Q?rBHGmIYtBYyTO3uAAgcKQIihUhsaDdMFkcRkfECoF5wPYWYQayhdcqmQKre0?=
 =?us-ascii?Q?4pzVbCycQnDRIplMM6JG6TA+x0Fuv3xxP8vbNEi/Gk2b8GBDmCc5P7BEQDF3?=
 =?us-ascii?Q?Amabg+NSYGN16tGyYX2X0ISsF6lpZ04bzIe/2GetCOcnb4RSkXW07BsTDsNr?=
 =?us-ascii?Q?jzCXD6O/kwNUUmWlVAFyhORPmnBv2EnXBFQNHltd+lMV2b6YbyJiLkoSMOyX?=
 =?us-ascii?Q?mXre59jBhpW1YZjTEWRckHC2d6iJB3f9IekJJVPmR71VEEmXXbF8/i1QeB0f?=
 =?us-ascii?Q?Sq7Wwlz1LN5zo26+KoY0C/9hfJuK+J4dghxynIJBfoFEmpv/ednXV7/iVWeH?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 660cc590-b9ef-4606-a3f0-08dcc69e772d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:45:08.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KxdBJFkLMKQoX43zgEyflTGZ1MDH+YZ52QbigsLffKVdjTVGe2fwiEUblSfbo4sNRJoD/b7AMjAWCfmnj0wgWtoMBnpmUFQ5ZlDhjrEPdYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8423
X-OriginatorOrg: intel.com

On Tue, Aug 27, 2024 at 12:20:11AM GMT, Michal Wajdeczko wrote:
>The DECLARE_IF_KUNIT macro will introduces identifiers only if
>CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
>no identifiers from the param list will be defined.
>
>Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>Reviewed-by: Rae Moar <rmoar@google.com>
>Reviewed-by: David Gow <davidgow@google.com>
>---
>Cc: Lucas De Marchi <lucas.demarchi@intel.com>

up to kunit maintainers, but it doesn't seem the word "DECLARE" is
entirely correct. What it's doing is expanding arg, and it doesn't
matter if it's an expression, definition, declaration.

Looking at patch 3, I think it would be more obvious to the caller if we
have:

IF_KUNIT_ELSE_EMPTY()
IF_KUNIT_ELSE_ZERO()

>---
> include/kunit/visibility.h | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
>index 0dfe35feeec6..1c23773f826c 100644
>--- a/include/kunit/visibility.h
>+++ b/include/kunit/visibility.h
>@@ -11,6 +11,13 @@
> #define _KUNIT_VISIBILITY_H
>
> #if IS_ENABLED(CONFIG_KUNIT)
>+    /**
>+     * DECLARE_IF_KUNIT - A macro that introduces identifiers only if
>+     * CONFIG_KUNIT is enabled. Otherwise if CONFIG_KUNIT is not enabled
>+     * no identifiers will be defined.
>+     * @body: identifiers to be introduced conditionally

missing an example here with fields inside a struct

Lucas De Marchi

>+     */
>+    #define DECLARE_IF_KUNIT(body...)	body
>     /**
>      * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
>      * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
>@@ -26,6 +33,7 @@
>     #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
> 	    EXPORTED_FOR_KUNIT_TESTING)
> #else
>+    #define DECLARE_IF_KUNIT(body...)
>     #define VISIBLE_IF_KUNIT static
>     #define EXPORT_SYMBOL_IF_KUNIT(symbol)
> #endif
>-- 
>2.43.0
>

