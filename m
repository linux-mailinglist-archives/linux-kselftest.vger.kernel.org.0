Return-Path: <linux-kselftest+bounces-41261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF772B53AD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8B117ECBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A015F362097;
	Thu, 11 Sep 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sjw3pkda"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF135FC3C;
	Thu, 11 Sep 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757613406; cv=fail; b=qSO2fF2HFYAo7BC/HAFcR8uBPBhej/o5HOaV1KZPXRcEeAionDTC6qs1r22igWyl86RwHJlYWX03MXKT9ldX/9is0APsg7WN38HsSHGjaxaB+xA0TdwE1WsFl0hmm7hCiw+wFOIv4FJGxPWj2tdJGRDTo+4xO9PBYs/sWLaSffw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757613406; c=relaxed/simple;
	bh=Uc24lRV32xubNTYYlcpkNt2sqC83HiJ0fVUNtxch68g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U9TVQqpKmcI7JYYNiXoicETdOMpAVRdZVBNMomX5R9i+KqFSNGnmVm6yHFEyKNnfO0372gxatkULuyDDj3a7H5ObC4YJB1YLYgi6IQ8bNdKPGOmI89LKiiWQADg7lDV9m99SsoU1+TDfuwXTzK4O0kK78TCDL1MhQp9FXRLDrUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sjw3pkda; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757613405; x=1789149405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Uc24lRV32xubNTYYlcpkNt2sqC83HiJ0fVUNtxch68g=;
  b=Sjw3pkdackWgCQujVHcj6izLXkNGqiYHVE2nR9P6rQGyyPnMsKcsJWzA
   R13Sm3LXELtgY7gRHrOhecIbnGN+08NQPvFMMnKseuvFlVtOZ8PB7WSlZ
   KkmpyytsgRJ5857g+aBGEzmFA/d3vcmKBeO1oAsxCrMt8IuXwfNsgHYq/
   3QvxPjtmK0aFW8QrIBLhqr0dEPtj4twFXkX2/VgZaF8wnR7KTssN00m6G
   4uG3lBwqPxplXTXpsAdSJTq0XpiT2J/S7QHrEkhevGNEikCX9a3fIQtZe
   sNl8n5K/a0BHJ3v56EB/qj8uQW4EfEdruSDRfjLxhQXJQAK1ee6BGHFpL
   Q==;
X-CSE-ConnectionGUID: sdw83EeGS2yEOm4mhs3pWw==
X-CSE-MsgGUID: 6h0zjE58SGmbRISOF1E89w==
X-IronPort-AV: E=McAfee;i="6800,10657,11549"; a="63780377"
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="63780377"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:56:44 -0700
X-CSE-ConnectionGUID: 9tycMnT5S0eM8+ZngyE7Gg==
X-CSE-MsgGUID: QJxOMmNsSlmvJzmwChoFzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,257,1751266800"; 
   d="scan'208";a="174136548"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 10:56:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 10:56:42 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 11 Sep 2025 10:56:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (40.107.101.49)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Sep 2025 10:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6nt2sh2blTQty2OTR6EJV7HMHj6uHD9yMYqGNgPBorx0N+XSisAdLabYClFB2aXl7iJBo6nZ0Sl3TbU6EyLSRZbkeq9vfTZK+2SRiE2xc6nOPdwFKqBJ6BT5OAUbet7mGdfqEgKXAZafOErZTrFTJCx7NHCGuuciwhUXtYUy3KDEDZ7qH7zvQyI1tJvKYgu2DLMz/1+XNX197jQlhYxuknQon6Vlv/1N/u3XdQkScrHFIjSa4rrfqRyepMkl+QyHSTm0xbPfvsOyo0cp4pWvNemguUEe07uuUGPuh9yfyX2CNtJhRctKr4nMqEdsMyylRWiQNz4Lm7dHScbljOEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6DBJNuN0y7gNahI+WK//UHlgh+Z3UoqKsshDDTydUE=;
 b=o++2LJXOk82w+NYkvTgeI+APl924bVwCkr0ru24lY2YyppljZ1lfzrqj+Yv3qKvwfAcDZK8fq1U+whf9RrEg6ct6n4dzElnK90YBGu1QrDIAL2om3mTbJAdZIm/arlWhitgxxFmkqLp/NWrZjR+o6N9A8rOzZALZvt0oQimfxEOjPuEDiBlSys+VOGerPD9ozDsnDm8W2AVHpkwgFdoDnx9ricc9IR1T5/2ZlcuoyE8EJsHi3wi5GL2xn4KAls4YjVH4YOcOweIwU8Prg3zlhqueEwbLra7sNKL0cMszx3hVa0FHHHWjxLpC4IHB4CE9vatXdv/hvttoVuXVWvXBtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by IA0PR11MB7356.namprd11.prod.outlook.com (2603:10b6:208:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:56:39 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:56:38 +0000
Date: Thu, 11 Sep 2025 10:56:36 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: David Hildenbrand <david@redhat.com>
CC: Kyle Meyer <kyle.meyer@hpe.com>, <akpm@linux-foundation.org>,
	<corbet@lwn.net>, <linmiaohe@huawei.com>, <shuah@kernel.org>,
	<Liam.Howlett@oracle.com>, <bp@alien8.de>, <hannes@cmpxchg.org>,
	<jack@suse.cz>, <jane.chu@oracle.com>, <jiaqiyan@google.com>,
	<joel.granados@kernel.org>, <laoar.shao@gmail.com>,
	<lorenzo.stoakes@oracle.com>, <mclapinski@google.com>, <mhocko@suse.com>,
	<nao.horiguchi@gmail.com>, <osalvador@suse.de>, <rafael.j.wysocki@intel.com>,
	<rppt@kernel.org>, <russ.anderson@hpe.com>, <shawn.fan@intel.com>,
	<surenb@google.com>, <vbabka@suse.cz>, <linux-acpi@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/memory-failure: Disable soft offline for HugeTLB
 pages by default
Message-ID: <aMMNVA9EXXHYvmKH@agluck-desk3>
References: <aMGkAI3zKlVsO0S2@hpe.com>
 <749511a8-7c57-4f97-9e49-8ebe8befe9aa@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <749511a8-7c57-4f97-9e49-8ebe8befe9aa@redhat.com>
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To SJ1PR11MB6083.namprd11.prod.outlook.com
 (2603:10b6:a03:48a::9)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR11MB6083:EE_|IA0PR11MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cb49a0-edb7-4ba6-d60b-08ddf15c8e7e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Vz2LzDw7V76RxZMQIIgxHXg3zX5MHIIec7z+GhTghHz8yCQcSEZ4uva+5iDp?=
 =?us-ascii?Q?UJksfQsyQckT7e6+LBHnq5nDutqL39fSlU9zbuPB7CkizQvYVNOE7oZJOuT+?=
 =?us-ascii?Q?JbHRDnx/6/bUrkso6O99xBG+mLr2VebAQo219dtXLinTHjU4lRz08DX5Os7q?=
 =?us-ascii?Q?EOHMSKFp8WcFmWX3gwf5t+cyWxYPKKYJI0Ht89LF0RnT14hy2/PfCjgiTPjj?=
 =?us-ascii?Q?hvMElxsgN+m24hLl21+/MmNqAcmzJ2rEnqYCsoojWfDvCj7zXnuLcu/b6TXg?=
 =?us-ascii?Q?m78oULM26DzpfYvf9puhjTXWqjv8tab7+A6lSIKb1QUucNu9Co9/NptT6qW+?=
 =?us-ascii?Q?KADf5gXoZXo5yRRajR8xENyQz4mWRuavSb5QC+CxaSl3MF2F8Adb/u/czKIS?=
 =?us-ascii?Q?eEukOSX10nGbcPgP4vzfccpU9pakuk41A0fMLhLVRWzj4yTfHtqZ9V/LjlCU?=
 =?us-ascii?Q?U0pnJnkIpuTTUK0/GLIZDMM1hOAWieZvmEwJJeARnHptOPlOxyB+pmZ3dXC1?=
 =?us-ascii?Q?jH7U6VUmX7AU0QMRQwkByELFEXtz+EMZguyRVJA9H0H09O1bUaXhdnRR3Yuo?=
 =?us-ascii?Q?T0FVOg+OdEfy3OR6ayVqIQ8dfR2PXpblVgMxHMd0kHMuy0UNdiSacK6jcU/o?=
 =?us-ascii?Q?EC1pUmGJIxVkFWMsXkXbv9pBtB3aWeFPH0VbDBVr1pxz6TdzgzsLE2qy7drn?=
 =?us-ascii?Q?w+kXCpktmUSELaNybYBexK+BN7l5cPIhM4zajtGxf4PLsGwtEJ+wnjp4DyW8?=
 =?us-ascii?Q?gbsYJ9AL0BJxmhSo+zbs5kweaP9MWc+FfefwD/JP9CNSGxdpX3ESGwPheINt?=
 =?us-ascii?Q?QhptlScn0lcmJuRwrW7wM6s+OuQyklz2bOZ4pwyYFwy9x4r3pYYKCPwlhSlX?=
 =?us-ascii?Q?oWeXieXPvQlTTyST/AZTTZ8WwFVFuLRbOsERZQaWCXUzuux42FEHqbiDtKKM?=
 =?us-ascii?Q?3Al0XFmkbw0VfQmHGyrjQDsT0aHAcIX0+g5R4Y0fDHHfdjIhgSgMKSJafSsW?=
 =?us-ascii?Q?Qj9Vp1D0wTskVQVtOxT0WoMT+x0wnA2zGu0eUaGA94OvDLw5lYJr8kh9pYfG?=
 =?us-ascii?Q?NYh+crs7YYILFztM3SSTAX5Nqld3zUfZPNpml38jfAEgCy2y7/CD3ma5aTeN?=
 =?us-ascii?Q?QiqiaD/y6vlfWz7gBMsU+0G+PI07U5Ll+13SFv6lqN6I9zPbeDKqfUrQ+KUP?=
 =?us-ascii?Q?EQrqH28dTtINEC1qysC0dWAuW3b/nqIKiueVLuRJB5CgrOI62MMLbLXryogd?=
 =?us-ascii?Q?7ieQz9j8WOHsAcbU5x9gwupB9GaXBfaul0dcVuSnHnAQi8OnVXlTVkyk24El?=
 =?us-ascii?Q?w5KNf7Y1hbEowSzgipuufTzAiA4GxxbewuzrDWb+l/o/ezwKDedgepbelpOy?=
 =?us-ascii?Q?IWCYBNw3mTfWPELkkoYXVQWY0waNJEc1UBQVXyK/SusIoqNRBaPOteY2Q6yT?=
 =?us-ascii?Q?82FCvaz8HvM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTLSWhV6IHv1H7zD+W5KrJy3jiD9gUyxktZmA/0PAVWpNjc/6tmY/TMB2BwB?=
 =?us-ascii?Q?KqbZs/bKDFp88y0NJsdCLmENV5rTx9lHfh6/zEdNqFD0RILbaZ0YOEP8uHA0?=
 =?us-ascii?Q?BFCB8IlbjJ+KdKJ7wSeIM69VfI8y9E5UmN/Mkd+bRlmO035XusGFNJE/HGTu?=
 =?us-ascii?Q?Y6Bz3DlGzPIUn+qfE0fWwfsGZNZjOxfzQs32kbWp6pN1JXwwTE3QJNe5BAsD?=
 =?us-ascii?Q?Srg1nOI9qXbTS3LI1t4Ojlu75ArQQQJjYa3qI/ZDFhuS3QIWARyJ2DdlKPba?=
 =?us-ascii?Q?zGA10jp74lCUykCmWROCnr8/1lVM+VevnK9C1LewubUTRKH+GIDejXW6Bt4h?=
 =?us-ascii?Q?96H70OCaPSkWDyH84BQLJYsUdigO34z637Pb1wNJAuAX5POyBg8Fj//0dbRm?=
 =?us-ascii?Q?aYV0s9Kb7uqvUdiUD6KWYta7YioVz+OyCQHRs1wAb2jDh4D5+0eAEWCJ2dYK?=
 =?us-ascii?Q?2+/Z9pTfLxu0qjnEuOIzLQWZCAWeycaHJTyArEFxVW8Crn0SVabV2yiLk6Q9?=
 =?us-ascii?Q?vU6s6zh/2+pj3Nf/WcTQxr8dw/Pqj7rccG6qM1uaf2R8wTrll1jNbJC+CDNu?=
 =?us-ascii?Q?21DsO6VgiCDZmn8nBDjKjBmgb9nqp+XVUMZ7HJs2uF/pxIn/LQGIPUH+fXhx?=
 =?us-ascii?Q?sGW7BVQOhKVpm7B/GPvs36r4SqfcX9e7Gek+0XEprUO+3Uq6hncg2n153ZSo?=
 =?us-ascii?Q?Q9HP0E7I4Q8qQ5HPsHbp7mN7kMp3PTCvFuxJXFV2nG/C6C5nieZAYFhZHDv3?=
 =?us-ascii?Q?Eqn2rSAY2YMML4sKxGg0EsjG4urVB9PrpuHSz/dCE/f+OlJEfr+kmgaqjMY9?=
 =?us-ascii?Q?QZLblPItz9qgiiWn03WUJ/oaa3CmQ7f+j7iJxWm1rF48lO0nnwPddXST0rWe?=
 =?us-ascii?Q?7Em5zumcVZ/sTMbE9k8JOQSOzyIcYsPCuEyP+F76/1j6BDrUq1E9aN2M9H5T?=
 =?us-ascii?Q?zJoL2/NLUJYpJ7fMQM/bRtqwXe1liI3UEgR61ZR+uWWALK5RUB6h2D1rTAnS?=
 =?us-ascii?Q?cXE2UwX89LJnJI8k7En9sgE9tek7s0CvXTljFPDNFRzdhghTBaNzOOdeBj3e?=
 =?us-ascii?Q?AvqCQRC4wAm51iOL+Nf/hCrOirjbU7i+AJZXqgG4o+9c2weOC1pvc1PqKom4?=
 =?us-ascii?Q?ippDB3ayFeJync3f/0QlyHN0Yj9Bfyb0qOFJI8wZVTEEmfpqL97W+Q/nzNU1?=
 =?us-ascii?Q?sdcFFahhSdpRCKVrrz3oPlMP95f7W7BYYKU3BI3UjXir4dmtX69xtzTzvvgE?=
 =?us-ascii?Q?pYTTHXiqOcVHWGH2Wqt7TnSi3EKrRFPZIcaQREUH2M85qwC7ichViYmyf8h4?=
 =?us-ascii?Q?GYoYlvoGmgKmITiTj0lsrLvIW4K/IcUauYi0d+P8e12YUkpgRnZI7QieNzR4?=
 =?us-ascii?Q?oN3DaeEJS5LJWDcXpEBhoV09MMB4h79vNGwC8+S84XKOQWim2+2DQsazKGKy?=
 =?us-ascii?Q?HI+KcIi6VLG2GiimT7MZ+nip6YdTG3f9fVESINXY2OVk6qAXAWQKh49+dTfn?=
 =?us-ascii?Q?7JYuZxHU2hlWRr3C+VwzUoVmHeTd1LNiMejjngssLGae5ZkdNW418gNn0Okl?=
 =?us-ascii?Q?to0PW2OiG6GB6qJb1SFv+tSOH65UPUoppcUUyimw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cb49a0-edb7-4ba6-d60b-08ddf15c8e7e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:56:38.7832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnhC/g9gngKIyNckmX7yBVzm2wuWTr9TewJHSnLH9itgHecBxiV9Ap4uTT1VL2Lq5W9YsjZji74sz6LwKg/u/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7356
X-OriginatorOrg: intel.com

On Thu, Sep 11, 2025 at 10:46:10AM +0200, David Hildenbrand wrote:
> On 10.09.25 18:15, Kyle Meyer wrote:
> > Soft offlining a HugeTLB page reduces the available HugeTLB page pool.
> > Since HugeTLB pages are preallocated, reducing the available HugeTLB
> > page pool can cause allocation failures.
> > 
> > /proc/sys/vm/enable_soft_offline provides a sysctl interface to
> > disable/enable soft offline:
> > 
> > 0 - Soft offline is disabled.
> > 1 - Soft offline is enabled.
> > 
> > The current sysctl interface does not distinguish between HugeTLB pages
> > and other page types.
> > 
> > Disable soft offline for HugeTLB pages by default (1) and extend the
> > sysctl interface to preserve existing behavior (2):
> > 
> > 0 - Soft offline is disabled.
> > 1 - Soft offline is enabled (excluding HugeTLB pages).
> > 2 - Soft offline is enabled (including HugeTLB pages).
> > 
> > Update documentation for the sysctl interface, reference the sysctl
> > interface in the sysfs ABI documentation, and update HugeTLB soft
> > offline selftests.
> 
> I'm sure you spotted that the documentation for
> "/sys/devices/system/memory/soft_offline_pag" resides under "testing".

But that is only one of several places in the kernel that
feed into the page offline code.

This patch was motivated by the GHES path where BIOS indicates
a corrected error threshold was exceeded. There's also the
drivers/ras/cec.c path where Linux does it's own threshold
counting.
> 
> If your read about MADV_SOFT_OFFLINE in the man page it clearly says:
> 
> "This feature is intended for testing of memory error-handling code; it is
> available  only if the kernel was configured with CONFIG_MEMORY_FAILURE."

Agreed that this all depends on CONFIG_MEMORY_FAILURE ... so if any
part of the flow is compiled in when that is "=n" then some
changes are needed to fix that.

> 
> So I'm sorry to say: I miss why we should add all this complexity to make a
> feature used for testing soft-offlining work differently for hugetlb folios
> -- with a testing interface.
> 
> -- 
> Cheers
> 
> David / dhildenb

-Tony

