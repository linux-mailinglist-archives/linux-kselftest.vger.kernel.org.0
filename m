Return-Path: <linux-kselftest+bounces-5278-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461EF85F62D
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4E71C240FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Feb 2024 10:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EC33FB19;
	Thu, 22 Feb 2024 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="crTW/QRp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577243FE47;
	Thu, 22 Feb 2024 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599104; cv=fail; b=aIrEeDJKhE4CXFJnhJ8mzBbVSfSgkcY59BmFYjLYI9a1RfBAJCFor4mxntx7aDjDnxtmPenObcGGFWBvur2JzAHivo5XlqCrUaMXd3tI8SA2i8tL6LKoks1PUYRuFDxMrCDr7zWA4hO6zwKw4Jx9tM5ZMaB4sP6/SqSn3PWC7Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599104; c=relaxed/simple;
	bh=J20MGcmVlEcxxXAnHiUcFI09efVN0DJP2eiTtEs5e/Q=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B2tyYszOcDFdEWGqb6EAlPRLBMD5OHFR6boqTIpSXPFBoxP9Bi4tB/vvH7JYA//5saF5u5tPcx5rO8bQwiRxJOyARpSoNFstCGL0mB4wGVlTE5R5doCEtIpIp9bak/VJ2Foq9HCX0zFtRBJWQkfsHMVl52lEntIUejxKrSS/vCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=crTW/QRp; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708599102; x=1740135102;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=J20MGcmVlEcxxXAnHiUcFI09efVN0DJP2eiTtEs5e/Q=;
  b=crTW/QRp5ITvp4HQcHG9rdVidB96J9diQVBqGYaqICp0mTS2LAX3btrj
   GiwnANlUT6QKKZdwggFexcxoIiz33iC3p1SgeakpOcHjvnEZXcJQQYyTd
   S2hqbCsHOLqWMQbuXd9+sXzsVrhw6Zdx6JW37g5W7fa2hRLClLh83HYQg
   /gXj39eKNgGhKjyz174828TszMkiuixx2X0PDBcF41Xizv//7IF0Hzru1
   mNFHbO7Fq2Nn45xabycZ/XcFUH7sW9u++yKH5B4dDHeE4OGHA118qdMvN
   /QqrUcIwtqDe8gWe1EZst/HtY98VKqAUeqqvUSsEs/uwpNP+K4iXihBQ2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13517439"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13517439"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 02:51:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5421409"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 02:51:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 02:51:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 02:51:40 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 02:51:40 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 02:51:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH22GUiAI39Bz5QOd09q3SlNfdAB6MPJUH3RUO4JynV6tZmIG90d22q60XnRWHF3qzcPtZm6ycdGi91dOxAHnEAu9dRuZkiTlvswiLjyD+6SUas5rxGdC4iY+CjZ6dI+lRp882lB0o9VrKZkj1vLQ1o5pk94JQI2GlJ9N3+THBMOv98T6qm3glNMBETCIHfbDSZFUncTdU39wbDRN1wrTVAYs72NITvBkqQqFtAcSMK0ovQdevfCTC1yIQJooOSJwDNUhFMjyLRdjozhPb2XFPku6gnwCfnlJD+v3/Jjhxxv1hOEsYWQSjEnFSHRDdjCRrt3VtHVMe7YDHQ3iOnLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0ODGZ40pI2h+hnuS/lYEUJOjm2wiHIr+CmdjIuJ/3g=;
 b=lSX2uy8DsmGlYCcvdlJMKxRtx529g+R5td9DRMvJKyt84Vr/kmy6m7AtHMmyNSDoXebgKz5bRND0HTEh4wMGUZF8QVaOu+NVC7DUpc2OEMN2DTPknoqGWJod3w04SgYqYoUPWhS/KIZlY8YXbVx+mlTbDmLwi/BfwoLbY508aAq0o9FevC4pU6St4O0jcgPvgZEFInXnedGR2Saer6wa1lID6peDj1Pk0FqGGcfi7oMz7DC5wIsk7pCqXgn5qbvIP/ICbxIXToO9SDxT0g5Qx3bv1UPnQfLrc3cQOPK8UwnnXaBeQp0xjtZz6aohPkNcYLDAwoD1yGQ+d95tBqsrXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by LV8PR11MB8605.namprd11.prod.outlook.com (2603:10b6:408:1e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 10:51:38 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::b2fa:6a11:bef7:179f%4]) with mapi id 15.20.7292.033; Thu, 22 Feb 2024
 10:51:38 +0000
Date: Thu, 22 Feb 2024 11:51:29 +0100
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] selftests/resctrl: Simplify cleanup in ctrl-c
 handler
Message-ID: <cl55dahbdccoikbqguqam3bbfyq2nwinuixpqwkn2fumeybhjj@gp5owhup6sgz>
References: <cover.1708596015.git.maciej.wieczor-retman@intel.com>
 <3a6639cd338a706bd2ed341aa6c717e1e79cc1f0.1708596015.git.maciej.wieczor-retman@intel.com>
 <c472e478-eaf1-0003-cf2d-c861e620fce2@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c472e478-eaf1-0003-cf2d-c861e620fce2@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::19) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|LV8PR11MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b279d88-7cb2-4276-049c-08dc33943eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfUOrpQq5DvVrWm3IJ1SoLOsUP9mJP4/wXFcp1dVaITxX3T53Z+jy1cXgY37sRL8hx53zUrGBsqXVZN57nSiVyOCeEJb04t86oxqOK7vwlTADDSqcac+XQO6FDBDsOaC2TXQNVxIYd04ZGklwvtQ7PYOS9ysrwAoZTW9kX7TUXyd8GhRDHLKewewp6kd53M2abv/xrX219nwIz2nWv9W5Fff3TqCZ8bVwB1rCVduIqsQb5E0ziCOWmwjgrnqIX1fZJMUSz4m2sXjepuQ4DAVI+df3c1YF4eCNIeipoaq2BJknUwpFpmuH6NySmHCHuwVy3MIchb9PI6QEq4dVjDj1J/8U33Slxgf/V2oqFoh20PVvf9uMEWzRX5lrx492yIjajpB243ll+XP7e6bXry4nZyqO9sBzc/nsIPuP6JHrVWWMLfpo9qdlrjNsX02AvTOdFwCmbdozEKCqcTmY6XieXxOBCYA+XacvgEuolGwR3wiPLABT3J11WuyzyHIAWc68i4+dm2lpufysrQzeeGlpNTq/HnKP5h7EEZJK9tWCVk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Rvw4bJmBPP0O89f5GifXiQPElPv1vW8EVtiGKMLtEtRtZSnsK/NnJwWhiG?=
 =?iso-8859-1?Q?UvmgCynRN1J+iaqLLn7FIdRGUmuMm8oGtSqi1zbHd/sGDyAG/RqV5lblF2?=
 =?iso-8859-1?Q?XNgXL/zshTxAfNX4bTK6k8mlaqYALAJjmhUlli0bTgSPleqz66pYTqTbMc?=
 =?iso-8859-1?Q?H90BNQtHvZ2m9yChza5MUn8goI5VDd8UScWUtCzGsjBuyTNigxZByyxd0L?=
 =?iso-8859-1?Q?X/qaiy5oINGdXzLLWscI+qDp+FpYitjZCfgekZW98yVuZmTQUk8C5aWx/w?=
 =?iso-8859-1?Q?YvEngZ64bYDe5j1Yu80mQaav4+POUkf0+KEgiZW+ds0QUwNfztvQuCPXva?=
 =?iso-8859-1?Q?U92tUhqtO4OaFzyFU1sSqYoQpfoSkHTzZxWA5Y9P+p4lTzmPZX/FJ1/IeZ?=
 =?iso-8859-1?Q?dUqhuGkj+0sKrTVRi38y+6ztLu0rPCRhT9pL+FS4CUu1woRxGo4J7wsk2M?=
 =?iso-8859-1?Q?BwXZuHCJWLRFKvEa/2hPn3u6/23X4SBwzclU9Oe6Aj+yVT37c503Db3V2P?=
 =?iso-8859-1?Q?GdqtTTbj3tcwwBxxgAtsHYZNXQ0RKkVyaVDrs8b4jW8UsmWbyRnJw1TLiE?=
 =?iso-8859-1?Q?CnM1jMdNlm1uZszxpafJA/cCx1FgdzNDFN4igXapIHyN9SXF/e6th7sj0g?=
 =?iso-8859-1?Q?vduHdV31+q8wwBLK2MIS+RiaON4+sc3Scy8KvhdWOuQ6xfbIm45DbaNK8/?=
 =?iso-8859-1?Q?JezCcYUAbBL2MztBwZPB5FvrEn2+2AGl9cuj/Uyi/WhN0PkydlSwKdwtYS?=
 =?iso-8859-1?Q?jYpf0+vL77lxJtH6m4Y/eZ3aOeBFpIbPu8cesi2WrNDXARmC+p5siLzt0y?=
 =?iso-8859-1?Q?oRSSVtlbgW9aseA8j+X/tD9uHK35GADVy0BYrA4pH3A6VYizkriHDJeRer?=
 =?iso-8859-1?Q?tIW2YOoA/vOd6elWrE+BMvy353/95f6/eDoJwL8bgrCnl0AruO80R2CRst?=
 =?iso-8859-1?Q?nZN5EK89WdQAbb9AOpCjuLVwofrHYeugX89aNbT97wX6Xknxzv1b+LxCkH?=
 =?iso-8859-1?Q?gcFICPJURdmxOHF3H8tjkobMvLeaGN4itf/WnKaIzmWqY0tWDYYArFctn6?=
 =?iso-8859-1?Q?nQKIfbv5LGvnZdltxvVOQFRbZgI77oVn9ko5kn5XTB230oRl2Znd/cc1mZ?=
 =?iso-8859-1?Q?luzndjn0UvxuCuhNm4pdcseYQ6AE38XQpiSDnaus0cYL+2cc1Gk0gAjCa+?=
 =?iso-8859-1?Q?ImcMN9QMJNBHhaO3EDq30elwP/Or7lMNz7LaunMl6SQ7aRno3NFAm7KOaR?=
 =?iso-8859-1?Q?SEiFrViojTEJyOMlPvtnrXLg/lP2NODb1J9N6lBMN1iSZxF4LBHYa/1Jzy?=
 =?iso-8859-1?Q?24J0maBz6wxit7OZP1Ujl4e1pWkfgVGeQwyApvs8RjITXWxyttKXgLaepr?=
 =?iso-8859-1?Q?tn1EphCTN3d8Q2CC2VkYr+JWkEpJ54/Uv6MSLvmJ4EOc0sAbu7gWQ2Ms3Q?=
 =?iso-8859-1?Q?LxisFBe/FbxXtyTY6UZss0vhmDWN1zjV03TBx76P86XPWe7FHEOUGPpIrJ?=
 =?iso-8859-1?Q?776Wm/k5hO2UH+/gnCPgzdQfb0IPVI00kW6plxERJXFKxuldo1HSyBSb9N?=
 =?iso-8859-1?Q?7Oo9+FD7LvLyljG0wgEHuL3ed/NvGNJ/VMxazZn4iU7OeWWUQFPZBra366?=
 =?iso-8859-1?Q?aGVQYPsFUOuFdk2BICV6iAd8Kki/OHoPfe2YV3xubcdIAE67KPqUXJGheu?=
 =?iso-8859-1?Q?XdOcpDM97SnmNqe8t9g=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b279d88-7cb2-4276-049c-08dc33943eb5
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 10:51:38.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x25aUuC6T2zGX5xZ6jt6pNmJxjA/swLE0bilmDN9sPm8Z6wHAPVWA/zmcdVUQ/pyyPsP6ljBR+/r1KXW6iUfZNogYM3Wwprt4NfcwJvm970=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8605
X-OriginatorOrg: intel.com

On 2024-02-22 at 12:12:44 +0200, Ilpo Järvinen wrote:
>On Thu, 22 Feb 2024, Maciej Wieczor-Retman wrote:
>
>> Ctrl-c handler isn't aware of what test is currently running. Because of
>> that it executes all cleanups even if they aren't necessary. Since the
>> ctrl-c handler uses the sa_sigaction system no parameters can be passed
>> to it as function arguments.
>> 
>> Add a global variable to make ctrl-c handler aware of the currently run
>> test and only execute the correct cleanup callback.
>> 
>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> ---
>> Changelog v2:
>> - Remove tests_cleanup() from resctrl.h.
>> - Make current_test a const pointer only inside resctrl_val.c. (Ilpo)
>> 
>>  tools/testing/selftests/resctrl/resctrl.h       |  3 +--
>>  tools/testing/selftests/resctrl/resctrl_tests.c | 14 +++-----------
>>  tools/testing/selftests/resctrl/resctrl_val.c   |  6 ++++--
>>  3 files changed, 8 insertions(+), 15 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
>> index 0f49df4961ea..826783b29c9d 100644
>> --- a/tools/testing/selftests/resctrl/resctrl.h
>> +++ b/tools/testing/selftests/resctrl/resctrl.h
>> @@ -153,7 +153,6 @@ int resctrl_val(const struct resctrl_test *test,
>>  		const struct user_params *uparams,
>>  		const char * const *benchmark_cmd,
>>  		struct resctrl_val_param *param);
>> -void tests_cleanup(void);
>>  void mbm_test_cleanup(void);
>>  void mba_test_cleanup(void);
>>  unsigned long create_bit_mask(unsigned int start, unsigned int len);
>> @@ -162,7 +161,7 @@ int get_full_cbm(const char *cache_type, unsigned long *mask);
>>  int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
>>  int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size);
>>  void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
>> -int signal_handler_register(void);
>> +int signal_handler_register(const struct resctrl_test *test);
>>  void signal_handler_unregister(void);
>>  void cat_test_cleanup(void);
>>  unsigned int count_bits(unsigned long n);
>> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
>> index 75fc49ba3efb..161f5365b4f0 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
>> @@ -75,19 +75,11 @@ static void cmd_help(void)
>>  	printf("\t-h: help\n");
>>  }
>>  
>> -void tests_cleanup(void)
>> -{
>> -	mbm_test_cleanup();
>> -	mba_test_cleanup();
>> -	cmt_test_cleanup();
>> -	cat_test_cleanup();
>> -}
>> -
>> -static int test_prepare(void)
>> +static int test_prepare(const struct resctrl_test *test)
>>  {
>>  	int res;
>>  
>> -	res = signal_handler_register();
>> +	res = signal_handler_register(test);
>>  	if (res) {
>>  		ksft_print_msg("Failed to register signal handler\n");
>>  		return res;
>> @@ -130,7 +122,7 @@ static void run_single_test(const struct resctrl_test *test, const struct user_p
>>  
>>  	ksft_print_msg("Starting %s test ...\n", test->name);
>>  
>> -	if (test_prepare()) {
>> +	if (test_prepare(test)) {
>>  		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
>>  		return;
>>  	}
>> diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
>> index 5a49f07a6c85..d572815436f3 100644
>> --- a/tools/testing/selftests/resctrl/resctrl_val.c
>> +++ b/tools/testing/selftests/resctrl/resctrl_val.c
>> @@ -62,6 +62,7 @@ struct imc_counter_config {
>>  static char mbm_total_path[1024];
>>  static int imcs;
>>  static struct imc_counter_config imc_counters_config[MAX_IMCS][2];
>> +const struct resctrl_test *current_test;
>
>static const struct

Okay, I'll add it.

>
>>  void membw_initialize_perf_event_attr(int i, int j)
>>  {
>> @@ -472,7 +473,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
>>  	if (bm_pid)
>>  		kill(bm_pid, SIGKILL);
>>  	umount_resctrlfs();
>> -	tests_cleanup();
>> +	current_test->cleanup();
>
>These calls should have if (current_test->cleanup()) guard. Isn't the 
>non-contiguous already test w/o the cleanup function?

Yes, I remembered to put the check in the main test function but I forgot to put
the check here too, thanks.

I'll just resend the corrected version today.

>
>Other than those two, this looked okay.
>
>-- 
> i.
>

-- 
Kind regards
Maciej Wieczór-Retman

