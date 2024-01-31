Return-Path: <linux-kselftest+bounces-3825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1400843EE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D409C1C228E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 11:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E371762E0;
	Wed, 31 Jan 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QhZnbot6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92B768FF;
	Wed, 31 Jan 2024 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702238; cv=fail; b=tFmgA4FfUEcEEx+GcVCM/OZ+xbQ7E3y2Pw8rBCjPapTe2ABKrWfQMopvHpw6/MmIqmv0TnluFBJ0zCTtcD4CREkIeQBYXeDyPuSJ75P96QwaSEftMcaDcSLy+PtBeGxtVxbbmGqyLe3q44Z9FYwwykV7RWiBdepOSzu5/s1nURs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702238; c=relaxed/simple;
	bh=WAnye2Q6WzarbopdF8H1xqKinRq+W7f0XboTrTrR/LU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kf5aQAxpyYYtXr/6PuIR8Jt3bGqJnC5hvVpzd7V+YtiJS3ZzzCac4a6eHR4yO1NNXQDNiPdxyaY3mZMo8/oNSHClY/yIExBKJ36E4QxFtUCfD2mI42WrSvFq7ph0p9ulC7fxUb/QEnNVc/PM85V4rWkTROj0rkZv3BbrXOl/tNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QhZnbot6; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706702236; x=1738238236;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=WAnye2Q6WzarbopdF8H1xqKinRq+W7f0XboTrTrR/LU=;
  b=QhZnbot63i1saQusSuJ4DOr13hWx5zDgZmACNjYFK0yihKaNsYDA0qq0
   P+ipk/nl/mITo0DPP7hROPHtAQdkSMPirC0pzTDr7cUd5M8G8xUFl1/bE
   QXoVe7CSl/EEtSWyQW2jUqfo+3W6fCDvujnPNGv/xvMvOEXorzYVSMJB1
   7rNRfBOAE/mPQPU4HJESTAq359sowvEDJJ5b34QuGbOfH5pKB9vfRq0YD
   NQj7D8Oa2xYlQB+MloQ7sJQTbEGlNMB/h0k+uWEiEvF3osMDuyQ5jXTij
   kJFURi3iJLLn/X9c6tjQr9o/+zW23koBMogVTENDEtHZZ9iminA3glvX0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3418823"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3418823"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878767793"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878767793"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 03:57:11 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 03:57:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 03:57:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 03:57:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPOixBbM3ukWprPQe6XCZWzprGMPZHJalW5RNYTR5FAqWHq/+AQUE6VOvRPNX1w7hBtXHeekgCLxR7mv33AxK7vzEzlkQpAkjgrsxzj6i965S4O0k/cGiByO6HI7I9h8It8VMse/VteMnq4ifXPsl6rvGt3403n0m4DrxYj09trz+A97QZG3B8BjYaBhtTSGuh1xcldEOJxJTcmynqHU8LtIHkPPTv8FN61yJvXhp52WGgwbU5rscKhd9wP78GG/kXrNxYGmemPeocZ8YdvvozS3j3LLYxU/lsL3GIV5HhbbYcyiKbctluap7dCUNikxIJOhV2A9xpPZk3enWC4hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xejaViJR+CZgNCNB6mW/tykocaaghPo6iSPSVMLnRQg=;
 b=OO4bBsA4M4Q4wDWfJBlH5nZ+zmNdu0tGLuZd0BnIKRHUB9irJGjJtY4rH/gTHokuJ9pXfYxTgYk9bXYrCowidxl3cVpInYqLRAt87Xuo1TCqHJ7sRdVB/xBE93nQXGhs/0NIoO/aW55U8SI6DFvoNwkxw8Bf0+BTdlAs47G+Se8gGRMa6JMzpsvqxpUYfrNp3rqL6BWwwa+KRIw7OjT/pjsqRLmu+a3nnUk02AZyLeQ+qjFYmtOSUFQz7i/xXON0Uuci/gQ0BZGFq8v0mjpOtfU0kGVTHU1ktlDgzGa0Ygr5WBbBCVjF1zE97C5Q9+tZmiPMeuHL7YbpbFAFhVZGng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SA1PR11MB7064.namprd11.prod.outlook.com (2603:10b6:806:2b7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Wed, 31 Jan
 2024 11:57:08 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::c554:bc40:8b5c:9530%4]) with mapi id 15.20.7249.024; Wed, 31 Jan 2024
 11:57:08 +0000
Date: Wed, 31 Jan 2024 12:57:00 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
CC: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	<fenghua.yu@intel.com>, <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Add helpers for the
 non-contiguous test
Message-ID: <tck7kcpjdch3a3qkkwusft5zwptlhtmicx53zjcqk3x42w5p55@pf6vrmnh7deo>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com>
 <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com>
 <ea9b0e06-c07e-eb4b-9e7d-ed20419b677d@linux.intel.com>
 <611fd2b6-d9ec-42f0-9711-b1398fc02842@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <611fd2b6-d9ec-42f0-9711-b1398fc02842@intel.com>
X-ClientProxiedBy: FR3P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::20) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SA1PR11MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ea813e-1acd-4e16-bc58-08dc2253bfef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TaPuiALZ4UwQP6esW8fRXfU7gYZA629K2hayJl/hqwP0uHOnhx25/ZKV+YRMG84dQGyJZSxGSkVKRAy7OSIExKoiPS7VTflmiHn8bscGQIeihyjXf+egWG9gXTVdtJmi3rI8gyu/+AbDp9qlEWabVASz/7RLBNt/RaQwUu42JusHfqhX9wlveY2c5bGQIW44qRgsO8UIgU4ksZJ6zL2WB39eELCTOCkKp3hjkBxiZl6onNpaW5MVvzbm0LYKdtHJKt2dFsLlLBKJIBHF8khbzT2OsUMKvDKXFkdgmve9DV64YhOsz5xwTtROZXOL5sDDJ77xzeD8b+rAvpTL4XB5gWHlA1eZXNzkdELCY0wG8KqBF7AZPwrHc93HWbnWMu4SlSbzSae/hOH7BwaFTg3sbxtrLbN3/Lg/w/h8Gga0hURV15S5shL+Kc6pyh6SI25kQvSOQFlDE/ZyMcivywUGGTva2ITFTM5GN3Gys8MRbl6r9yl2pqaYnxiM8nDo0tEWWzHe1ZGklColcjqgMEu82Eybci4aXVevn9638dgzM4J0eShZ8UQfp5Ph5Jop/e3V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6486002)(6666004)(86362001)(33716001)(82960400001)(478600001)(66946007)(6636002)(54906003)(66556008)(66476007)(316002)(26005)(6506007)(53546011)(38100700002)(41300700001)(6512007)(9686003)(4326008)(6862004)(8936002)(8676002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ISKLn27WmsjGBaGHRWhqs2nFLRTGy/mFrV9QCedOaL6Yh/k7Qv/hsbIlqD?=
 =?iso-8859-1?Q?ean/55oGhh3MYN89wpiU6RO8cGNCWfd5W/bSaWIrYfkPNDLIFGHPMdwXV/?=
 =?iso-8859-1?Q?13rwEs/UNIftNhkxWuJ40M913vOtF7neyCwJyrTktGBVIp+UoW/ZtbFWCi?=
 =?iso-8859-1?Q?n2aGy1LzdLKf/OLAxJz0zJ226Oxy+ltBVao43p7RJHiEs8OIYIoga4PFMP?=
 =?iso-8859-1?Q?QlAYanmGKUmJRtxKCXdz0ZPEyW0vIn4eTmzSVST/HnuhcFyV/r96B5AcgK?=
 =?iso-8859-1?Q?HR1lHsll/M+kOdq2B0yJ30b/OzXkWlsesPsYRGltoC22Vds6XUdT2tpIfY?=
 =?iso-8859-1?Q?hODow4R/Qbf51ub7TWAV465NwI5w9Q/xq20K7lMu0rZP71VOSyMWRnffS9?=
 =?iso-8859-1?Q?8USlhqfQrCvPj+KtOsXUbxK8t6IsI6ffc6X7zS2vDz0qpHcvtLftxU6b60?=
 =?iso-8859-1?Q?5SgE7297Nng/pSH5d7eJNoc0XU1SH5Im7OrHzNC8VvJtFU5VsxMCLRgCsV?=
 =?iso-8859-1?Q?ftpFly7LPbc+z6ZebfSJJEBI1oD7/BgO04piHuUqckKUOj/KJjRklnuQZv?=
 =?iso-8859-1?Q?ivOmdQmH/i6WOB0c6Js7BAOIMbVZ5S4Mejd1u/9ZCeXIlvY6Y++AAAZSNJ?=
 =?iso-8859-1?Q?+NFNuSeDSugqgLiBtbYyJvQeZ7l2C+jeU8Cgwr0I4iVkpgoxCbM9NMkzEm?=
 =?iso-8859-1?Q?f2wlLEC9snlNgb15ayXBzIpDXlgbsoAkeItHo48fBlQdgPCbCiMSrR4PAS?=
 =?iso-8859-1?Q?L76Om6mlSuZyCHjrAqoz3fFv6eqtX/Ey5NY+KljsudmqDb+oF9lhPlIDoc?=
 =?iso-8859-1?Q?dnf2Aecl7yrcykBQL9L2ldSQoPZYlicPpWG015pZNoC8Ix9dbl5lB4A4DI?=
 =?iso-8859-1?Q?KooTY7Q7PG7yHOQrw/rnZI2QKI7+hIuMWw8UYgYOxV6I3DZx3wLbTsPqsg?=
 =?iso-8859-1?Q?cuMEbFSg//tjDagkH2/juUQxF5BN1ZxroKL8sv88edPPhhHNvNPYEn/kCD?=
 =?iso-8859-1?Q?p8B+yS4WKo3648uFw10WMYuITlgucLJlTQh+FBHSADFQkaf/dBDvFbB7Zy?=
 =?iso-8859-1?Q?GoXtIU/eFxGMoprRJQYDbbm7MTCgzlqu1QC1Zm7m4yjMNbZqRsY/cvFaAF?=
 =?iso-8859-1?Q?zezUc3Oj+a28M/uBYFXemKfPWxdUOzhRMfJv7/sNREl/bdYWw2Orsz1G0O?=
 =?iso-8859-1?Q?wQRB8F4V43w8Zoe4/jNf5MObEQ3B4fKwLvW43FK2OYSjxF9EGYeRfrIQ4F?=
 =?iso-8859-1?Q?ojp/d6+XDBUaoqwWUUKcUW7XC7BxE47Kgyrw6Pg53ASwtk+eJRW3nlorEl?=
 =?iso-8859-1?Q?OvIpkkDcOEhwXaPTnknWxiTTKjO8CH9BHyizFYDbtdp5bybDiW6AsnyymV?=
 =?iso-8859-1?Q?BfR6VoqIf5XotgScfJF+S21UlxEx7Ut1v3pp54We3huS/VozHbbQgf2kuy?=
 =?iso-8859-1?Q?Ot8AGZ5jtsS8wt7fY1ttUoDFDVUexzu5igABGiPQkSSn9STK07IHNTO+iS?=
 =?iso-8859-1?Q?8kSbYelKX+TQ7f5S9zO8vsqnC8qcgkzWN1MbqLx8SpTa1AB916lAWDflB+?=
 =?iso-8859-1?Q?IVI6YlsTwpj/FxpKJ4mKU9ODQh1einsusRiOqEVY7GeJR0qfnCkbFSkElM?=
 =?iso-8859-1?Q?kmA5vGIEWhFekYcc4r7FIvwMoPu9KEsA0dm8fh7dNclMmRWdzuS0luyM1V?=
 =?iso-8859-1?Q?40NdK46c1ztKVSb9Jt8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ea813e-1acd-4e16-bc58-08dc2253bfef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 11:57:07.9339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EeVcjwDbTOEZ/l11vreeyHufrTrFe8cPvepyYC22mTqp09ggCqgsstQwQ2UX+T8Y1PcdX0CkTw6kWPUthtz1iOJpHhxnUxRT2yYdjx5ELj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7064
X-OriginatorOrg: intel.com

Hi,

On 2024-01-26 at 10:58:04 -0800, Reinette Chatre wrote:
>
>
>On 1/25/2024 4:14 AM, Ilpo Järvinen wrote:
>> On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:
>
>
>>> +	fp = fopen(file_path, "r");
>>> +	if (!fp) {
>>> +		snprintf(reason, sizeof(reason), "Error in opening %s file\n", filename);
>>> +		ksft_perror(reason);
>> 
>> Was this the conclusion of the kstf_perror() discussion with Reinette? I 
>> expected a bit different outcome when I stopped following it...
>> 
>> In any case, it would be nice though if ksft_perror() (or some kselftest.h 
>> function yet to be added with a different name) would accept full printf 
>> interface and just add the errno string into the end of the string so one 
>> would not need to build constructs like this at all.
>> 
>> It will require a bit of macro trickery into kselftest.h. I don't know how 
>> it should handle the case where somebody just passes a char pointer to it, 
>> not a string literal, but I guess it would just throw an error while 
>> compiling if somebody tries to do that as the macro string literal 
>> concatenation could not build useful/compilable token.
>> 
>> It would make these prints informative enough to become actually useful 
>> without needed to resort to preparing the string in advance which seems
>> to be required almost every single case with the current interface.
>
>I think this can be accomplished with a new:
>	void  ksft_vprint_msg(const char *msg, va_list args)
>
>... but ksft_perror() does conform to perror() and I expect that having one
>support variable number of arguments while the other does to cause confusion.
>
>To support variable number of arguments with errno I'd propose just to use
>ksft_print_msg() with strerror(errno), errno as the arguments (or even %m
>that that errno handling within ksft_print_msg() aims to support). This does
>indeed seem to be the custom in other tests.

Does something like this look okay?

	fp = fopen(file_path, "r");
	if (!fp) {
		ksft_print_msg("Error in opening %s\n: %m\n", file_path);
		return -1;
	}

The '%m' seems to work fine but doesn't print errno's number code. Do you want
me to add errno after '%m' so it is the same as ksft_perror()? I looked through
some other tests where '%m' is used, and only few ones add errno with '%d'.

>Reinette

-- 
Kind regards
Maciej Wieczór-Retman

