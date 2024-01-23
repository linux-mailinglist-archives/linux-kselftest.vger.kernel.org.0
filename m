Return-Path: <linux-kselftest+bounces-3425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 779EA8394AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B4CB22EAA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A917A729;
	Tue, 23 Jan 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JD2NRHrC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6CE7A70B;
	Tue, 23 Jan 2024 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027491; cv=fail; b=q9y4cmOKrabWNq7gyV+7nPZJmE19P+xOgo0tKmBbKGlhLfmbblWRhZsAe12ScCxxO912fz5h9Ba+QKIFlyuP4+uqE6DEjcIS8XXYnpHwRn88lUf1jk/MVfdvpIpRe5LqkoM3x90uR8Kh8tQghGJvUzJS3yRC8uNHcw2SPR+DDM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027491; c=relaxed/simple;
	bh=wxwyIWhHGZZTqXUIFjRFJan1B9uBe7A52MjkDLqKVno=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jrm6IfWGdTwoAiNdsIsrV/0KaAkzBMwLV5OQUJjA0gsH4SfajqKdwel37MqHu2/CrPr+yuocy44ff8Hjm/JmUfvLqMfS1lI1I+DKPRH63y6CyDTmrSwtCkXjovHANgdYLh+XsAs+C5tOt1C4jOfg2129Uds+2PcfUnDwxBiAXT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JD2NRHrC; arc=fail smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706027488; x=1737563488;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wxwyIWhHGZZTqXUIFjRFJan1B9uBe7A52MjkDLqKVno=;
  b=JD2NRHrCqB3Iio8hLGU881S1VywrpT+mWdEqIPXoVeRb0zjAUgZ74MJL
   1WpW0XPpNKnsloUNQc+KhuAcIbm9zUjeALr5+uwp8yceRfGNADYmKiKPF
   rqrmekxpWAXOQADg7CKcTGjx1e/WWzf+EJLdG6YMs2h0w387demcB9zye
   zmlYz/qAhLPFeqT3ncHZiJlRcblFl7w1/kNDg4o6WeDb5JRkl+dG1Swa6
   IKZwsOX+V2/+/u1fHfKVYRC/vaCw4ODmGD6T7LzJu3ZdWpSJdyq+mNoWw
   6FFoSl8ys463OcmVcD6vOVQtedBx5ZFdDJlxs80FlL/rvBoUfemDRBQtK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="405329060"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="405329060"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 08:31:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="905300668"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="905300668"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 08:31:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 08:31:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 08:31:25 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 08:31:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LA0sLHafa5tBYXRQS2x/+2hVgq9H+2cFjA9NeQP/BdPovQ+k4GaOtthHFn6aDm+2HCXfaG7PzAFlWXc8Z9z7QuTvWw0Q27O4eIu+28hQ9HEmV9nX+GUcKsbOXZxG+ar/gdgIWkS1Bcp0odv2RE7A0LZe+a84Nr51/Z3fZTLwBxz2I6Z7rG1dVRozB5x+skFmolt3g5ijwWPIX5rjwhwkAIz4NDAur4C7ErfLAPRVYNwCgynlzytkxiYExCLKwdw9PfTfXDu8BchLICSZDtHvRMtvA+smJHuiSzFSPcjoAtbLzaEcqBICtmCCdWIhaFLEsTFriqExI2hr4vLLBQIb9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmSY+9sBXhk/4TRx0qz39z62XX4V/y5z4mpgB2fcEuI=;
 b=gAQiL0q68JmaWwsJtX98Nc02MLwcWy1beFoVsHaLIecyyQBIuFzgNrV2QAVeASrPMFcLCjmLPkY7Xe9pDRcbHKoZXajpFr5NH5Fo+bW80ttU7yEBdnQeNtznOtKSVvlS5ZCF1JKWNzHCYJKVbGKjCeK8o85wMDPIGJ7NMDm04rXjy89/RxTUZjG2UdeabrYXmrHAwF5dipl4HYz/fThRipbbdFEOivWvmOXMyuyPtOaKK4j9BqJaR0afEiLMOCIZ7qFCQ8eY5bVjsJK4ZE75Gx0m9J6ULIlEtn7BWtNabYM8EcdnGahgVsT3d7n/AWp0FTCQvJRYohPId2DzhWBZ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA3PR11MB8120.namprd11.prod.outlook.com (2603:10b6:806:2f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33; Tue, 23 Jan
 2024 16:31:08 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::9f32:ce50:1914:e954%7]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 16:31:08 +0000
Date: Tue, 23 Jan 2024 10:31:05 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: David Gow <davidgow@google.com>
CC: Rae Moar <rmoar@google.com>, <linux-kernel@vger.kernel.org>, "Brendan
 Higgins" <brendan.higgins@linux.dev>, <linux-kselftest@vger.kernel.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	<kunit-dev@googlegroups.com>
Subject: Re: Re: [PATCH v2] kunit: Mark filter* params as rw
Message-ID: <gi2oosfohy3jjjvuazlg76se6m4w76ys5gxtmj5ngquxwqzz46@s7vgxulxzhao>
References: <20240122171408.3328510-1-lucas.demarchi@intel.com>
 <CABVgOSmjyCf5DSh+LJtaLubHN3F_mrFo=ZRk23u2PEmmkLBUjA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <CABVgOSmjyCf5DSh+LJtaLubHN3F_mrFo=ZRk23u2PEmmkLBUjA@mail.gmail.com>
X-ClientProxiedBy: BY5PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::12) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA3PR11MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3e55e0-926c-4d13-ace4-08dc1c30b3c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msbAMXPf0UL/cPNR+V3jOWO364JAiu/+BJZ0eEcA95dOgHobCo7v8zCeYU+RPI71TH22cCVDPV7DaMuE52AFJfeVBayiyucuZPucUcy39XMKipMHw9CxSAq6D2KRL8CqCtZXG3aQ3Kx96g9bmewfrv8f+Sr6lrKqkBD686YDGj8/SzhqHXq6Gsa05dVUYE313fHOyXLyVgn8WsgIH3EZnIySwb5l/Ax/afrWiF0xcgE3m8pzFrSvqb0DHlnBfBHXyTbUwT9YuQ14JiFox7wsRyzBUyEEuUrbsaC+pk7qP928ZjeDZG996F6vdO6gdgfDX0121K4zAIxEFqFRSnl2FAbg8cVgIGF+jEPjKl5KOTIhq09s5i1loQDU/UK7HPsIgsVI4otSqCTjbpDOZlXR2Qeef5uu1VgXyU4AKhVhpqIK0hqR9D/9yI+yAlDb2PJOVVc4WNOWfopIGDuA/DVRvExtPm/tuRvKfdlfXHy+YERdonPJPZ4LrjUtU9Yp/o4dl6VrGj3jNb86m97pgJdeSYry08qpixRxJMf50Fs6/as=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82960400001)(38100700002)(86362001)(26005)(66946007)(33716001)(8676002)(478600001)(66556008)(6486002)(966005)(6666004)(8936002)(316002)(6512007)(9686003)(6506007)(66476007)(6916009)(54906003)(83380400001)(2906002)(4326008)(41300700001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?423i4K2mAkKemSk67baOUQXGJ1GtzDSTHyKF/IN/dQ9Rrd0Q7rkJOuM/wyyk?=
 =?us-ascii?Q?E4OwnDInYnfw3HXESSL0lu3W+Ko08Akz6H/OKu/DABC0gagNRSZk/9yx8O0p?=
 =?us-ascii?Q?BExUFg2tHsGL12nlTVqVUfbCBsbMMd/nxFXMCwqxhS6KocVurX8ypBthlYdM?=
 =?us-ascii?Q?Mj8o2g/p7W0EtxcfQKLQO3/sDlax9zjw7tm+V6ihvX2uY28KceBgV2XxrfLY?=
 =?us-ascii?Q?5+p2ZiJ/dWO4IafX4fP+nGKla9H8KmjYjWBGE72BkNLYfA3Ew3sqGTVYKB3L?=
 =?us-ascii?Q?FZj8HxWeZkfkdhVKBddbugg3tPDA0NZWDkqeF25L4lzPf7ECdmm+PT+C5Qv5?=
 =?us-ascii?Q?u0qtchpkvpsTjhx40ScO0NYovkhS+b7ok9D/C01CdsVmWf9tAxmVUbjEhhxe?=
 =?us-ascii?Q?Pda6fjgw2b1C5WPkmEgu473En/NDPzneVkkV6ZzeeThvsLz9sjFo0sqy1i7Y?=
 =?us-ascii?Q?flcE3izfnl86Gdg2zqpOd1FDq0D0UTZEg4iPTr9dKb9hy6a9Vhd7oXIpnqOn?=
 =?us-ascii?Q?P9DMhDCogtEp7idIVCkqWK5J/4gOTzVG+ZeojxY+oXQI6oBbmzC20a61GhAY?=
 =?us-ascii?Q?1MSIpmtWwcvJRoD92UNSs8rW+BvJTwd3Y6ebYrpZ0ZbbItRPy6W0qJZ8Gi0z?=
 =?us-ascii?Q?lCqef0SI6GWpL29QNY98uYDv+0cYCHSLzeW7dP51YkGzYgAsbcqiXjJTam0a?=
 =?us-ascii?Q?+9i0RhJfSkUHq1JpqgNfnYBE70duw+My0f/b6sprP9qX4VfCLNR/T1f5g4dA?=
 =?us-ascii?Q?7brwwDCTsKmHh0ro0KIoposZK88erOOs6esxmaREy7lgJMhS6dTqNQogWR6V?=
 =?us-ascii?Q?Bv/F4UCYa4aYsTO+JYxpDNXc5EiuH67YS497jdhXiWOOKvL7PwtqwROm3jdD?=
 =?us-ascii?Q?mOywYb+8ctjRxXAoHpgdeSyhnUaVUB7qsDdZ5r/TnWTwbidu5b9uNisp2Q7j?=
 =?us-ascii?Q?jNHkZeFMq/sDaBA5C2bNTayaKCB5vvZKBl0ASlFvMT7oIxU8sfehz2lGWRuj?=
 =?us-ascii?Q?DjELT8TlH/SWSePM+0o6Y0HgnklVl53bJYizE911AbRtWxkw1j4rXU3DagGf?=
 =?us-ascii?Q?FCd4twvVtS0f/UD4A0nYkUe+Z9lMf8bgPgG7GTkqLIbksDQ4Athgkyvj+5cB?=
 =?us-ascii?Q?hAPTZEsIXl/DG13OsBjjPrRTQWl3IKTmddyDuAtmatmUbto1fIh9KR7FNp/L?=
 =?us-ascii?Q?loFg1BoHOtEtpqc2G1VCYvYUZ4ei95loF6lIJB/p3G+eP/tngKweWUVi+4Wa?=
 =?us-ascii?Q?nm+4/8HaLL9GGzHGnjfjVzwExGNtOwY8Yv328lN+VzFu29b/hqD1wibaI2jC?=
 =?us-ascii?Q?Hz27/+go5OO9K3z2hf47puB33BC2jgUaFxERj3TqfCQtf2UdSqj1qNz51QHU?=
 =?us-ascii?Q?sM5WdDgJtW+oe4XIYX2Go3D4+ffCpVlhLDzWw/oXNKNew1GQeuw0vaZfoTFW?=
 =?us-ascii?Q?mcx9vJgaH/j57qh/tS4MnAwLP0Y2MqS7xRwhAJ81Ug7rIZWKIuOUGoJX0zDh?=
 =?us-ascii?Q?FOW8wsXhbqG6qJB0npfpS4BLEhhcpSd+IXr3dAtCUC4BVLC2hjqBMW3040z0?=
 =?us-ascii?Q?LPwWtgOVeKTxawjl+bmCRPqSgtmw7sotxVBG6H7hdcKUVXzzcCYanlsiTau3?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3e55e0-926c-4d13-ace4-08dc1c30b3c4
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 16:31:08.1398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQsbagcwYKfrMActeOOx9csV56PTy/wlvnmVZrS4F1RHrk7CuLuBtAcBcnQ3GUtQ7TGZ8AV+72wLFMMyqrXR7//UBBHNuNnWjreghqSvqzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8120
X-OriginatorOrg: intel.com

On Tue, Jan 23, 2024 at 04:01:49PM +0800, David Gow wrote:
>On Tue, 23 Jan 2024 at 01:14, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>>
>> By allowing the filter_glob parameter to be written to, it's possible to
>> tweak the testsuites that will be executed on new module loads. This
>> makes it easier to run specific tests without having to reload kunit and
>> provides a way to filter tests on real HW even if kunit is builtin.
>> Example for xe driver:
>>
>> 1) Run just 1 test
>>         # echo -n xe_bo > /sys/module/kunit/parameters/filter_glob
>>         # modprobe -r xe_live_test
>>         # modprobe xe_live_test
>>         # ls /sys/kernel/debug/kunit/
>>         xe_bo
>>
>> 2) Run all tests
>>         # echo \* > /sys/module/kunit/parameters/filter_glob
>>         # modprobe -r xe_live_test
>>         # modprobe xe_live_test
>>         # ls /sys/kernel/debug/kunit/
>>         xe_bo  xe_dma_buf  xe_migrate  xe_mocs
>>
>> For completeness and to cover other use cases, also change filter and
>> filter_action to rw.
>>
>> Link: https://lore.kernel.org/intel-xe/dzacvbdditbneiu3e3fmstjmttcbne44yspumpkd6sjn56jqpk@vxu7sksbqrp6/
>> Reviewed-by: Rae Moar <rmoar@google.com>
>> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>
>This looks good to me, and works here.
>
>Reviewed-by: David Gow <davidgow@google.com>

are you going to merge this through kunit tree or should I carry it in
drm ?

thanks
Lucas De Marchi

>
>Thanks,
>-- David
>
>>
>> Rae, I kept your r-b from v1 since the additions are just what we talked
>> about.
>>
>> v2: also change filter_action and filter to rw, testing with the xe
>>     module to see if filter=module=none filter_action=skip produces
>>     the result expected by igt
>>
>>  lib/kunit/executor.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
>> index 1236b3cd2fbb..371ddcee7fb5 100644
>> --- a/lib/kunit/executor.c
>> +++ b/lib/kunit/executor.c
>> @@ -31,13 +31,13 @@ static char *filter_glob_param;
>>  static char *filter_param;
>>  static char *filter_action_param;
>>
>> -module_param_named(filter_glob, filter_glob_param, charp, 0400);
>> +module_param_named(filter_glob, filter_glob_param, charp, 0600);
>>  MODULE_PARM_DESC(filter_glob,
>>                 "Filter which KUnit test suites/tests run at boot-time, e.g. list* or list*.*del_test");
>> -module_param_named(filter, filter_param, charp, 0400);
>> +module_param_named(filter, filter_param, charp, 0600);
>>  MODULE_PARM_DESC(filter,
>>                 "Filter which KUnit test suites/tests run at boot-time using attributes, e.g. speed>slow");
>> -module_param_named(filter_action, filter_action_param, charp, 0400);
>> +module_param_named(filter_action, filter_action_param, charp, 0600);
>>  MODULE_PARM_DESC(filter_action,
>>                 "Changes behavior of filtered tests using attributes, valid values are:\n"
>>                 "<none>: do not run filtered tests as normal\n"
>> --
>> 2.40.1
>>



