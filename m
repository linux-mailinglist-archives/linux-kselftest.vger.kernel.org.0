Return-Path: <linux-kselftest+bounces-16920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAD967D81
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 03:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC731C2032B
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 01:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0B721105;
	Mon,  2 Sep 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNCe1hGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCFC18C3E;
	Mon,  2 Sep 2024 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725241844; cv=fail; b=f2WJdmFvu/Ta8G3+sN4x48+hkQOvuuJwRWtB/FyRBVqY10f3PpXKHNLzi1cIVs7E6Wo8HOhvtI3pvLMCvZ05lfWFqFlKbCCUGvawTX3ZAU3er4zQjY07wQTZyh1xBAeXK9cHhknwBcvYT+ZTs8C4DwCerLmnH2PjB7579X9jal4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725241844; c=relaxed/simple;
	bh=4Qo75yQF+XlVOLgutfmrEGdShqX+kjxVraOonJ9sI7s=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SZwmNlwf6liQEXsZNMdNYW+g++zHPQGiD94n37N7PlBhMHpobDhysUde8YubZql407fFFmIMC7JW4PL6Z+lQH94nqZnLSkuWMGdO1zLbgOOM5mtTAp55xqduHFakUY0sxnhQ3XGtId6ryVIih3yal+AiNt/TGIckB6U8tFQTZms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNCe1hGo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725241843; x=1756777843;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=4Qo75yQF+XlVOLgutfmrEGdShqX+kjxVraOonJ9sI7s=;
  b=TNCe1hGojxGGtaO/XUjfH0oP5sRg2atduHMnAAASt5BBki7nOrfsahe+
   4R87HhlSwkdDATgmDH9W0fNfI4MOPan8pqDFGJsivAJMem4iWiOOHzZCQ
   gvvE9DtDENWEDRc2SUiy1toYHoiRJFe/weISiYewNuJMHKKEBphnaSDgM
   5UyLoJtTt7QTjtXzCATWIlgPePelTgrSmJOh3kDf/zd2DezymmR9Rv7zX
   8EKF2h8rV14WPxV3mupZbXXNE1F/xzYBtEQ9yseSuQ7JwApy4s8mZWjB4
   MvP37y1PdeISNvr9wZucol4VoPrqojEtv9pWSInq1TEcjN1u1kNT8Ds+8
   g==;
X-CSE-ConnectionGUID: dAwc4Qn3R1m1GH5Yya9O2A==
X-CSE-MsgGUID: y4QmDIZNStKOWFOHVBLc4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11182"; a="23943721"
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="23943721"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2024 18:50:42 -0700
X-CSE-ConnectionGUID: DxbnlAw9SZebQENND1jKYw==
X-CSE-MsgGUID: ssF0pR8eSpWSf9QUzfydyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,194,1719903600"; 
   d="scan'208";a="69263746"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Sep 2024 18:50:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 18:50:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 1 Sep 2024 18:50:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 1 Sep 2024 18:50:40 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 1 Sep 2024 18:50:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thwOGiSQduw243mGzrq9QlMB7obBNWZER2N9eqNajuEFKCLA49FgxUxaPZJDH5IE1BAlAnilxk1qyVrZaVuFkOkd7Nw9MVutHrtbX8unBh8DvUELCpLeIW+lCJFksz3KEZwi2eKSdlEU0+bGeDQ2Q/kdkpmq3oPVDab/YSn7knj0MYi+HenHzSvRlGW/BsyVU0GB4EnQLxlwdzPr+XXD8AsBhPamZVCaPbpj+kc8X6AT/iUKmFtpt/P7oWOBWjy+c5zOiWbP4AniGwNlLkfafBeQYCmF3OkXtdlnqPAcVUKAsezLDH/MNkwyOy163Ecom5y4LKbA4aITu5GmZhsvuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xihZJpaVD1CjqJENiFqJAn7VROoPkpoqICoJVtMWfhY=;
 b=JOe7RjTW43V+XoVCKVbI2cImI8B8oZDZWNwsFqSwVn9lSo1Vu2aWc23t1+LOG0CB6rnRkaxEr7j3+YrzC8Rd9ZNkWftwkCN7cR50EDsxSHyy7Xa18/U9G77BkTxVCeGd5+/DGFj+b+uK+/H00cCiDN+wRFkL0Z+Tx4D18Ci+kx1SyQeR07lc7bwiFByQotgzvziKf/UppFlpuLjsl1SKetZs9nDfpQvuRdHrMw74lW3tA4YW+NJela4rxBLTSlXIKeDySxA7uWEZFky2eQvvIo4Yy2+xvPCMAVyvkY0ONB04BgcTSoEUD6L2W7XfAwcw7u1OcPxFIEx0TPtmLdHVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
 by PH7PR11MB6651.namprd11.prod.outlook.com (2603:10b6:510:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 01:50:38 +0000
Received: from DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e]) by DM4PR11MB5423.namprd11.prod.outlook.com
 ([fe80::dffa:e0c8:dbf1:c82e%5]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 01:50:38 +0000
Date: Mon, 2 Sep 2024 09:50:28 +0800
From: kernel test robot <lkp@intel.com>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
	<peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Shuah Khan <skhan@linuxfoundation.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kernel-dev@igalia.com>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH] selftests/futex: Create test for robust list
Message-ID: <ZtUZ5Ppq/xDC0/v5@rli9-mobl>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240829183509.446934-1-andrealmeid@igalia.com>
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5423:EE_|PH7PR11MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: b0b5949b-ebde-4a5c-2e8d-08dccaf1a4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?hkxkzfxhVdJAdu8UWt1OvVUA7IVI2cPDbRjYgEixppweZPqhKF0PEubU7w?=
 =?iso-8859-1?Q?SrKGR5ASTACM3vNouTKTLJVJza4/mWUeKn6hl57fUb4OjXRFcjLNqoIKhm?=
 =?iso-8859-1?Q?C97sJC38kHDPWte25W3jlKNPLKsKRTYcJUylg1B/BwzT5wnDjHA9cDS+k6?=
 =?iso-8859-1?Q?+OrmI7ns4q9SRSFfJIXisUamDFJKZyti/xdCy5iGEg8i/L7VJJDRylDQQ6?=
 =?iso-8859-1?Q?QxGN8PXf9qU32c8HSCom0plmRZz2BHY5Ilr25FD0dIS+aXv1ZH0U/Ewxdy?=
 =?iso-8859-1?Q?Qg8+wa/HTPE2tpxy6w09iNmXiBN++9JiRNXtNDo+n/GCg5sJAyFunjoq/L?=
 =?iso-8859-1?Q?SiFBVH7QZTdRzDF2isazn0pwhMPk1Qvr3BQ1aSm/Yk4EG0es4FZHeD6NXK?=
 =?iso-8859-1?Q?KDwtz0/HZOlypw25Bzm86YoX5XB93NQ3xqdpIxoF/0Sk58CaYl98ORjVTN?=
 =?iso-8859-1?Q?0q8DkxxnUptpOGKBBz0XngJ/khTkeosayMSvpVuz189FYaGqMxzbGfq/l7?=
 =?iso-8859-1?Q?IOUI5C1hooavhMlE3GFp5yMzrf7KxwzyJU+i0HgHlSInAWIFIDjdzyYaOt?=
 =?iso-8859-1?Q?EXIp9mqwTU5pVKwi060SwxZcd0lW1aOJgIJQueGD3obDu0csQWc9JLiuk9?=
 =?iso-8859-1?Q?okRB3fZKBhnmTHD7d/WP/uJqBniCwZsKiu5oQyBIxJpgQq4fg4G0QzcICJ?=
 =?iso-8859-1?Q?dsGgA+9FOedzBXuvE4vslhytW0xEH+DgryDbWrmG8We7MP4lU3av2Qkr21?=
 =?iso-8859-1?Q?NUAEjDRxFoJD8HIJ9Rn1XB7/pEx/Xr4s1f9mbBnplzMaSEqIlAetoEW/0t?=
 =?iso-8859-1?Q?U21ue89fwsaSPSIYMKoAJvJsEfyK9a6OuhuC54VhS2Iy/HulUjBEBHWbUQ?=
 =?iso-8859-1?Q?7WVx6xv5uonRYj6w/m75dgKcBn+X8rs4w7gBFz0rN/xjYdGZvRb3TeirX3?=
 =?iso-8859-1?Q?tQw+baKAU/IACVhLRAbmza6NfjXCGEy6RxYLHiCpuvJ70oItYSrVnvAZdd?=
 =?iso-8859-1?Q?RowhMg5ZSeuH63pIjrFVHX2bs7L7MtE4cAviSZb/IiV7ft46rwrSC3HW1/?=
 =?iso-8859-1?Q?j/Nutj/KIIXQzwuRGwJ/OQDig+yMIJ9MzAAmFvBNVRhVl+WaHFcn1zy6Lu?=
 =?iso-8859-1?Q?c2rifTpqS02aIe25ioPrSbHMPQ//I5FhWWfIh+phwPB9fglUb+WAcoctOu?=
 =?iso-8859-1?Q?q4TeL7JqfQ0bVWulohf3fFOu967W47yaBVCAlOZq+opkAu1QpdmnzntnWK?=
 =?iso-8859-1?Q?a7IKcaSB9HaAPavnODvgYJ4Rz80vRnnkP2AxljGh8W2xfGNkyR+5EYWwF4?=
 =?iso-8859-1?Q?DofP2kr1A93LfRj5rXIxzOZyn/Gl1payV1IRp6UQX9B4FDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?chWhaoC7oKs5WRWiNS5KV9B+sAPvQZSPZYYXC79pXC/MzIiWbt+A+bhb4b?=
 =?iso-8859-1?Q?iWdSyQuiCSxwgROUbguhPIPLu0sw7hgr2RallWhlI7Y6qYcDTR8oceHBl1?=
 =?iso-8859-1?Q?BV/Rw8iRU0XVRocyvvYLg+ygklxNRy4ApyqILQ4R6sqooIGBIwm9qsDWM2?=
 =?iso-8859-1?Q?92ChBjYMxWhZbwZx/RTMLftR4kZAUdQwBmLhczYI/W5iFu1J1BI5BFvnCB?=
 =?iso-8859-1?Q?m1QC+pAF7fOm96qmnFjePiBPNScEn6hoicqeqZ/PqWYBBUBKivnZ9lq3t2?=
 =?iso-8859-1?Q?wq6qo7DqCoYYGjd/ipPwOs/2rHLPigiqL/HPUJh21W1QNabN+y8HQ0B2kY?=
 =?iso-8859-1?Q?K95rlc/yC00mIyncqTBSZj3WtIrYJfvZbc9L3tbzcF8AbwA/HJaYiutKEX?=
 =?iso-8859-1?Q?VO12J2f+hF3vfw2QuDDeSHZMO9AruCJ6zsqnZuWr3u2iUN/JtIypZI5M/+?=
 =?iso-8859-1?Q?gVJppMKkvApH0m0yMyMISRVWp1/pDcgRAJfjNDqqYZCCPglrF/NTny3wOc?=
 =?iso-8859-1?Q?5XO2/VnP/kUCFnmPw9LbqzTAODl0tYC6MXBnPD6tRj6yma/NHt2tcjYExy?=
 =?iso-8859-1?Q?nfdnrPaL67Ofc1WFIea/WKus6aj1qhPmzjbviZLkEWDZiOD7AEJGj61RN2?=
 =?iso-8859-1?Q?jewwIXq4/OwsWgDt3ewfq1P7bscd6IaN3dmkjiw6w65Cd+bDfJS1lHk457?=
 =?iso-8859-1?Q?foaCKn3Fa8Ye9mKHiy5/XDc3XZDL33tJ1V/WWsijIHmO4jSwuiH3Z1Dy36?=
 =?iso-8859-1?Q?HmF4h2mJmaGJm5C3gDx2O4pJxLy/+aDDSC5gnI3Oki+NsgbteVveweaZKv?=
 =?iso-8859-1?Q?Y6Sxn9Wdr8IkkMApsAZ9gdXiSEq5i1Jg3AJS/4snGpcW25C1d/t20S6gvy?=
 =?iso-8859-1?Q?Pv6VwxpzYWWg+2oYCAxIiesGKURNEd480Xgg/PR6500Vz4WwZ2V4u5DCs/?=
 =?iso-8859-1?Q?4yKMpVagO471Spp6UlVHHTVrAzenu1kdKOlFj/yH3b6DVG7QVTLwkDvPiX?=
 =?iso-8859-1?Q?KQ7C18cnL2f0X4/4MNj2YNs/J2F67+InmXrbfVGZ+CNAudiOkG816HzFd5?=
 =?iso-8859-1?Q?ke6TK4LbxcRBL7LIICI0WTmeef2g8lGziW+KermVqdlDE53hx6vAF4xsNB?=
 =?iso-8859-1?Q?dnS2ALdcWRIutqKKil0X4fTj5vtOwljZP/DWNlnVJBqs+ek1xiHOhuvasg?=
 =?iso-8859-1?Q?2gIWB3T6RsPUQTQW9t4PVrOuadtuepM+oC9jKd5E4IzE4Q2ZBkPasB+zsK?=
 =?iso-8859-1?Q?c20m47xG2Uv6hcLDAldbU93GO99w8I+AnAzM5mSgA2kVE514LvjvxN1M9a?=
 =?iso-8859-1?Q?aVhsHU3K3bVUv6nARSy17h8aJS/OMmTuYeV5mXAO/GYrOWrPNvV47Z84JR?=
 =?iso-8859-1?Q?Xb+jTTCq0rlabRNxo4Z3tFHtT5BDuPkHcJPD15rrAxwoI4FOzxPLmlKnPW?=
 =?iso-8859-1?Q?MaicvFImAExZoBMMLGPcbQidYrjA2V0hWQNs1hMyzx7VPaCIK4Vk3m/VZS?=
 =?iso-8859-1?Q?YfdajxleeycJ7MenOutjSV0nIi0KknafO/l7IEeyKbVq8TETiBhPPwq2qc?=
 =?iso-8859-1?Q?v1/r372fqm1RRw6fTxQSd6sWbMBXxinyfA30R5ZTlRzi5ZJv4OCWiWuETZ?=
 =?iso-8859-1?Q?NsNWAQdRuRcoHIZeZ5mnKdf6YGKwQx7Jr8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b5949b-ebde-4a5c-2e8d-08dccaf1a4c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5423.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 01:50:38.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6yc2dGgbODmf9I1BnVd+L3FpcZRrhUdJJbLmcs9wgExy1SEUoz+jEgC5CL/O13mpUrE83ydRuofkolH7QA9aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6651
X-OriginatorOrg: intel.com

Hi André,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/locking/core]
[also build test ERROR on linus/master v6.11-rc6 next-20240830]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andr-Almeida/selftests-futex-Create-test-for-robust-list/20240830-023631
base:   tip/locking/core
patch link:    https://lore.kernel.org/r/20240829183509.446934-1-andrealmeid%40igalia.com
patch subject: [PATCH] selftests/futex: Create test for robust list
:::::: branch date: 3 days ago
:::::: commit date: 3 days ago
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240901/202409012132.wVaYZ660-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202409012132.wVaYZ660-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   robust_list.c: In function 'futex2_wait':
>> robust_list.c:53:24: error: 'SYS_futex_wait' undeclared (first use in this function); did you mean 'SYS_futex_waitv'?
      53 |         return syscall(SYS_futex_wait, futex, val, ~0U, FUTEX2_SIZE_U32, timo, CLOCK_MONOTONIC);
         |                        ^~~~~~~~~~~~~~
         |                        SYS_futex_waitv
   robust_list.c:53:24: note: each undeclared identifier is reported only once for each function it appears in
>> robust_list.c:54:1: warning: control reaches end of non-void function [-Wreturn-type]
      54 | }
         | ^


vim +53 tools/testing/selftests/futex/functional/robust_list.c

3306ef10715f1b André Almeida 2024-08-29  50  
3306ef10715f1b André Almeida 2024-08-29  51  int futex2_wait(void *futex, int val, struct timespec *timo)
3306ef10715f1b André Almeida 2024-08-29  52  {
3306ef10715f1b André Almeida 2024-08-29 @53  	return syscall(SYS_futex_wait, futex, val, ~0U, FUTEX2_SIZE_U32, timo, CLOCK_MONOTONIC);
3306ef10715f1b André Almeida 2024-08-29  54  }
3306ef10715f1b André Almeida 2024-08-29  55  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


