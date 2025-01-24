Return-Path: <linux-kselftest+bounces-25134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB82A1BD4C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 21:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F20188D26F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 20:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CBB225778;
	Fri, 24 Jan 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h+hANysU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F662253E9;
	Fri, 24 Jan 2025 20:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737750001; cv=fail; b=IRWmytsDT2QHm77ceeW5/DBoZ08/L5a4xYvFCBqYKNhXbo4quJ/6M+lsRRyjkWeeQ/C/iCYljFW8NZdC7ouwPYynmdUIZggmVRawFYVhP7iwBfloXPkeZo4QqZdEa+/c59Wnp+M6TleUbdCHhkFDvcHU8bkMK1acCPJLPmOUKf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737750001; c=relaxed/simple;
	bh=ttk81utVB3A+BXxOMe6h+rIkn0D8dDfoQ5WJMyFRCHM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HLWokuWyts+D5UvJdzkbOOIftwkPJQzrLuuJtWlJ0tp0TrJMbkdiUcPLWcgdQY+EuCuk0n/9lNgoIRRR4UTeHIjSuksLZJr4+nxSwYDF7sJJnLeq004xEyazLGNgLle9b51rp00h5BBCw1ZtJEh2MmE4mCovOUaV3kN/ld3RC/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h+hANysU; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737749999; x=1769285999;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ttk81utVB3A+BXxOMe6h+rIkn0D8dDfoQ5WJMyFRCHM=;
  b=h+hANysUP75PLUNnQz8xumZNKhCfIrbkqtR3XcMkoEduV/ySXic/5Iye
   7OLSNqxPcWlKsj3rBmyFWkgSmbRucfiiqyzTw9GqeXVT/3Wgh4xvVcNTT
   RaYs7mJPqeRqgRst9fVyavGuO4HIOL7FUA8rs7sg2m++kD8uTNVFna409
   ngL6rMdX1dcxWWzRzeGnU0XWkdVd/Vq/2bbj1x1ay0+6eg3eipDnzBSgU
   7kNpJsAbkxiEU531FWOVBMIAXEayW6+FOYN2zNG3rYXke6BjXWhNoF+gg
   zxOiuEfYoC0DTaPJJJYqw1cOERowiC4NuvzDBek9U2Jixx3ooTol2bUac
   g==;
X-CSE-ConnectionGUID: PDg6vmH/Q1W8qZURDkM29g==
X-CSE-MsgGUID: RziqEK5SSvuo4IdFIwLU/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48884065"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="48884065"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 12:19:54 -0800
X-CSE-ConnectionGUID: 1zLTTkdFTaaBQBSbtZwy3Q==
X-CSE-MsgGUID: S7hPX5oaTjWwZ2QQ02T30Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107723806"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2025 12:19:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 24 Jan 2025 12:19:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 24 Jan 2025 12:19:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 24 Jan 2025 12:19:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/W60e7qx7XqDDySyLOcYQm0YCOjDsbk3UmDdnPWO+8Jcn6P5c/qSQRfbpgNwPdN8tYIcvbquMHludTdriXDPOmPEZAI6amIfswOEPYVswGlUK6GY8U/+tI1Xrs7d2koRREGlZ7+fgy/fP6RokTLHviIHO+mOmiRGmDD8nMDbN7DFRnL7COWdZcGFKpc/49otxxQxoPojvG3kPymL+jjoVVfBcXczesUcUQa7N7ShzuFH5ra5dzTKIwPlc0UavuhJmK6F4eulRkr48BSxc/zYkc335+l9uTfvKbeF8rCFLfqss3cpus7qlfsqyEl0hCXDV3toxD8YK4rIr8fdPlsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vbMlfYriw6oDIfWjIqHp7Ohc/KSBe4GbTg1Nfu5WA8=;
 b=Rohs37psckyJrlGNtFfYX9ukhLNn4Te/s3o6I0YTJA/0XGRtv0Q5WXJcSzrMsXejz0ipdKVnsIvq99bPVTuljUawgSuAZBo1JJU38m4dFGFFjXdbXLhah9BV0x21fZKT4lNoQzgCXx+0JUux+KzScp4QbAgcRePRqQueoZTRzl4cANdS/irqEqnosSM2dpfea4y7DOdxMOxEq0dAJZ+qWlx6xndusOBknnRWiXko5zv+dC2t/cwrUP41MJ/I7kIgXYvTrRaJovNj73ZHey8cOu2BAeem4khrk15pgoeXjFFmoID/ctE4aDm8sxfMvjrKYR7e6hNo2tReGC8CBnlIeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by SJ0PR11MB4912.namprd11.prod.outlook.com (2603:10b6:a03:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Fri, 24 Jan
 2025 20:19:50 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%5]) with mapi id 15.20.8377.009; Fri, 24 Jan 2025
 20:19:49 +0000
Date: Fri, 24 Jan 2025 21:19:43 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: <shuah@kernel.org>, <hpa@zytor.com>, <x86@kernel.org>,
	<dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <kirill@shutemov.name>, "Kirill A.
 Shutemov" <kirill.shutemov@linux.intel.com>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 3/3] selftests/lam: Test get_user() LAM pointer
 handling
Message-ID: <big3a7ce3exdujixvnfxp4aovroqqrttbncu437nlgkexatj5q@slwamyheegki>
References: <cover.1732728879.git.maciej.wieczor-retman@intel.com>
 <df3790293723dff0b020deb4863828389eb41060.1732728879.git.maciej.wieczor-retman@intel.com>
 <44743729-02f8-4c73-b6c3-9a1ca7dd28cd@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44743729-02f8-4c73-b6c3-9a1ca7dd28cd@intel.com>
X-ClientProxiedBy: DUZPR01CA0225.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::22) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|SJ0PR11MB4912:EE_
X-MS-Office365-Filtering-Correlation-Id: 925925d7-ed40-4fd1-00c2-08dd3cb47430
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|27256017;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?c4fUJFG8Bn1TEGJ+O/IbsMkk5Fiv3CNTvSPYydnGpdgnUxgzdCmyGD5vzD?=
 =?iso-8859-1?Q?1Ki0/huKPwooCsVm+IHOvLZ7XC9Kk/5fnfF354G/YNel5BOtnNAoiOQtNU?=
 =?iso-8859-1?Q?CvpQP6FfZabMWmhVZ/v1SSHp8g19NPmSl8CKPWdpZOt3bPlmr2hiuILJAJ?=
 =?iso-8859-1?Q?aTj/2iUJB9Oti9C704yJiHKjAviyiyjqsmOLWi8dyctFWIwkVIQLxxrGfz?=
 =?iso-8859-1?Q?g9C0a0yki/fe6ujpNgblYvBLpSrL7DNOt2PUodth/wYrL+psC0nlRv7g9n?=
 =?iso-8859-1?Q?cevaa/+v9ZnD2uDNwcLWx5ZpeM+eIGKpI0bljQdOdxWJaPx7Rdvyz5soTP?=
 =?iso-8859-1?Q?gJXqAeazRaADNq7FPrq3O3duuE5LCaeU0mLPRT2m1FylWJDfPjTRWaHKvq?=
 =?iso-8859-1?Q?tzRcYCTOinuEkCrXAIJVsVc2tlyjKfiznhhhUPYt4N9kNUSENh1ROZNk/J?=
 =?iso-8859-1?Q?V91P0TTsC2iWhQUDGFKffPH6nRInVONTt3itjKwAs1Y3Omy3WvQx/4bvLh?=
 =?iso-8859-1?Q?zbZZ6Ll8x00uLc8tEpctRAfksMY+0v3OqdLt6iPb+iiciWHno9ztexT5as?=
 =?iso-8859-1?Q?JN4W2eG3Vk5HRKqo00o/sgTKKZJH8P7yZTYaELFXdYGTrBX5jEMiwtMzfI?=
 =?iso-8859-1?Q?aqtL7qrp+EiiqmIRTUoWqxBkiuWoBQkOV7bL/VkiClbxGjOWsVjlVzboZW?=
 =?iso-8859-1?Q?FLDqVYu26cj/NBBjH2Rh0fVd6MevpZMJyJncdj0E3z/mPfnOcWzrmZOFx2?=
 =?iso-8859-1?Q?j4jlEX4bYXItG87niUMY+Ob1cSWtkRlCWWfBvsvj0eobAdygMS4VkzqOOF?=
 =?iso-8859-1?Q?p6Jfr0tAWbTyYScinvykCZ/7Ad0gEJ8hIkcF1qmWfFOFlKy2CHuGhcFsgl?=
 =?iso-8859-1?Q?G+PUcA6CRLnCa35GASdATk6lgjnUrzLI5JFJqTY6b7qTnqbfqxozKiK0Q6?=
 =?iso-8859-1?Q?Bx4YL6RhGUL364ISmdd/N/y3ILrh2T3Zuzu/iOmfcACnS192MX8O7S9Jbm?=
 =?iso-8859-1?Q?EjsEikNl6QuvG6rEWeO5n7YEr+1dEvBnGtHhgHt4IzGX9OGNn/ZRKy75M1?=
 =?iso-8859-1?Q?tItHVKu5LKvA+I8OR4KNwJlisHecqqqxSb0PBaDTIynz6elGdZZLSsDSv+?=
 =?iso-8859-1?Q?QlxuYS28eJje8qzEXVVkgfyQv7wXFxxw6iyP+Vh6DiEDsIisPCEZBkQTIQ?=
 =?iso-8859-1?Q?j8KXgpBdA4FAjsxE9cSGb9Q6+/LWttRYcF/MgwxZNu5gorh4xsfuOgv/0P?=
 =?iso-8859-1?Q?DgHi+qGhfmS4hTwe9SOfoJ4M0K3JkU/829lr47qMOvOmeiH2XhTYUvpK5u?=
 =?iso-8859-1?Q?ecdxb0UqaaZlzFaD8GYJyFYpdzu2etvTli11XCBg/mot94VGQyYHWFL3lJ?=
 =?iso-8859-1?Q?xopO7yZ2knr2b0LqUFpB0Ke1NLbaK+Byg73bVDuzhXc1LwH+ghGx3+OL9S?=
 =?iso-8859-1?Q?JyWH1P68flrKDFRh7FjQ/6CKHsti8pTR3tKwivZXzEXCJyPkpg9sJEc7mj?=
 =?iso-8859-1?Q?Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9q4EX6+8CihPHuY0gyFybtWTfBz6/blKCc1dRjJey4pwjTV940r66m3Zc1?=
 =?iso-8859-1?Q?SBp7j+i1KUyh8RIW+lXyl31uFaLQwaQYhD01JAh4F6R+jLnHmF8/AMkIWM?=
 =?iso-8859-1?Q?e6PxmZb5UTnqm/2OM3kiKdlfpwx4DUUVyC0hU7agJ9QSSZdejm4UGsmkK0?=
 =?iso-8859-1?Q?Cdvslaa2XcbUXLi4RMFypmHgCgfZYSON+8MvUJl3AHA1HKQRsCVn+oqxCu?=
 =?iso-8859-1?Q?5MyqjxEP6337J5QKlpvy9721emNX4xS60U8RXtX14oPs0iC9YNl4wfFZAs?=
 =?iso-8859-1?Q?UTGa/5GWAumW9YZ9TuPMxPs+vTY7w/hpf0Gcjfh7CkcP73TX5Q4VQOP5VD?=
 =?iso-8859-1?Q?+DAJ/qFRn21+xWo6qIzh64QGlGcOPMy6ZpyKeAR9H8Ri0KAaReyf/XINee?=
 =?iso-8859-1?Q?kh85tULJFezA1EzsdkG/unRTpGIFUjhpVPtefV14JHR9tppmkoCZJ/Wdnn?=
 =?iso-8859-1?Q?i7vHVhKePv5F66GMSGmoox4n1B9/gJVs1+ImmxfBAryem5H1yqds4/IpJO?=
 =?iso-8859-1?Q?GjWWW52ql6iKtXmdYEbx6a7AIU+V6jzly4/mczE5ArQ2Gljfi5wczMa6/h?=
 =?iso-8859-1?Q?KMLzu6QuM4DoyT9krckP/Jd9PSzpfy75pAtpC75mPJaIUVuykc4Bso1dGs?=
 =?iso-8859-1?Q?zVb9WTvE2J4bf1Mc+rf5redfgGlc6uSbwStYT0s9zm8dZz59VU9+mKPx7H?=
 =?iso-8859-1?Q?dLi2wLiDNMYkpqktQWcrOUGRjWEFT9nojSKwawYy7MCPoT0hjpOamLi+i0?=
 =?iso-8859-1?Q?x5OT1acrfHt2JUFrVV8zOcyJBdWw+QjKdMURusxD4e/MLYr7fXqaKkxW0w?=
 =?iso-8859-1?Q?ag6cDg0DojxVFdO8oJOLiWjKkrDG1Mh94rhWIaItPE3lZLgongBn0f+v2o?=
 =?iso-8859-1?Q?2v1nS8RIMo//jvic5D0AuzHhO/r8B0J4opypCp8P8kJ+CLKwkfEe1FdVEA?=
 =?iso-8859-1?Q?STwUCAGabDhagILfbSYnIuFdKqg6uo77qPsGI1DvlKcwwSsdtkCmmcVETe?=
 =?iso-8859-1?Q?6c1zkiDrszvIxEomybkI1aufgXmMogK/YIng4yfzPzJUmq4K55zrjaXqC2?=
 =?iso-8859-1?Q?ZNGNDJbS3A/c3AxITTzGPqsaSbrZHMA7bWeVBzAExv/E0bXOaJdBhVMvTY?=
 =?iso-8859-1?Q?59RUglEfTI+VGMHFXBTPhYvKORd1kaKq0fDt/n38szis9qMAsYG4JPXlk9?=
 =?iso-8859-1?Q?EKMnylRp7YCaUcVfLQSTKPq5azoHxqYdobY3K6w0Ba7MTeOl1+qaJBtnQj?=
 =?iso-8859-1?Q?27CCuNFeMZBDWY+FZ3WwhCyNSFG5cV7fCE3WXf9xvUaGDYZ1BVCZrmii9w?=
 =?iso-8859-1?Q?fv90+IYHjgk9/XFgxxKAuib7gH/1KozmqU8neX0cLG0ujMyBK6cXsz3l8+?=
 =?iso-8859-1?Q?9FZEShWvw5iJrmFHElQUdZ6RYAs81KfyLmqZXjwjXGkY6Y9bGyneIi3p/C?=
 =?iso-8859-1?Q?ehnCUtPDFuOYIHOLQ9vEwd4EvFLVvXtnbg2sG/iKNbXWGvnAeWHCchg7QV?=
 =?iso-8859-1?Q?qgKIFnnva2bA9lRpAB0x7MO6Go7DEbavE5H0PPXoZlKg9duDDfxWIt+Idg?=
 =?iso-8859-1?Q?QuPq0gULJDcB3XjqvWUMXdZR7dCkWZOdinLLwq6nYNB9mosiqnO68gx2IQ?=
 =?iso-8859-1?Q?R6MzZJxXTrkEDvo00ipGRmWK8VkCjtiBVUH5UOrh5eYmALJ0DhbFLR11AC?=
 =?iso-8859-1?Q?UdDXV6RHH33i1l6OltA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 925925d7-ed40-4fd1-00c2-08dd3cb47430
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 20:19:49.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XA3CmR5mGLRm8mt6vmxDl7V0rRjKpR5yztZcL0vd5CymbXQyCUuMxyhZn/tUUvaw0kfOP1aDIXr7ScDGmCYHB10fnU277sTbrjJjIiO68ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4912
X-OriginatorOrg: intel.com

On 2025-01-24 at 08:32:18 -0800, Dave Hansen wrote:
>On 11/27/24 09:35, Maciej Wieczor-Retman wrote:
>...
>> +	switch (test->later) {
>> +	case GET_USER_USER:
>> +		/* Control group - properly tagger user pointer */
>> +		ptr = (void *)set_metadata((uint64_t)ptr, test->lam);
>> +		break;
>
>s/tagger/tagged/ ?

Thanks!

>
>> +	default:
>> +		printf("Invalid test case value passed!\n");
>> +		break;
>> +	}
>> +
>> +	if (ioctl(fd, FIOASYNC, ptr) != 0)
>> +		ret = 1;
>> +
>> +	close(fd);
>> +error:
>> +	munmap(ptr, PAGE_SIZE);
>> +	return ret;
>> +}
>
>I'd really prefer that the theory of operation be in a code comment and
>not just in the changelog.

Sure, I'll comment the ioctl() usage so it's more clear what's happening.

-- 
Kind regards
Maciej Wieczór-Retman

