Return-Path: <linux-kselftest+bounces-293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446587F10C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA8F281776
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 10:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2AC1860;
	Mon, 20 Nov 2023 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dr+ORlSV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5C5D2;
	Mon, 20 Nov 2023 02:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700477311; x=1732013311;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jJtM6hnWAIrGlxx3Dcd/7KqteeYzgINJiRSY4PIZWrk=;
  b=Dr+ORlSVMatCCW8qHaxzLrrMQsRpwcpsCRikUalwLUB4FKFpwNMHlVpZ
   8Kr4jGU0fe5XCpqOCT4NCB5c5+VlUYh5pocTDOsd4RF/h389jhJSSE2Wb
   8gEb7k5nmxdnEOcGhflbJTvywBwTNSlU5RlX661F/RLRME0alzY/VPv0Z
   /sY5vEmARbDPo7Epl47hyQFgjgmRwv12ZGoWUDTw2MyiGdi1fcf25tG0Y
   I/RkgMAwJHqPiYr+NWZSm/dnkqHSOhiU9ZPUyXQcSl/YMOWAz92hcDmjy
   HFk8bcB1XnngbkQjoq1rw9Utzvkw4QL/W2oQYYCBUYcaTFQrsC1mmUwo2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458092904"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="458092904"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 02:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="889885088"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="889885088"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Nov 2023 02:48:24 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:48:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:48:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 02:48:23 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 02:48:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4mlzWWsbe7ACI2fXBxEH7OkveK4X7+tFRF4XUuv8hU/swHAGs4Inb89NZqZm4rAfmGPuIcHtTMsolqkzFgdA9ufZWFtIwV2eO2FdjrnGoJ9wPFlYMZLRSmoXlq5lpaA0Hpe4HjAq7uCak/jsMzO5O0f6GpZTCpKsSLK2s79dCvsu5m2EtZ9sdLEqL+IKdcMWcjPO8CTOc+BGLCN5qMOnXFVaRtToOUyenU0rkzUi1LGj50FkT2eMOtVutSn7QhAxtQIZL+OtOv1dnfVyTh/fjxqKxwzarxDtUlLnMh4S9I7Ebos6trA0eZSFSdjysh7zVo9LjELUx+D0c/h3ZQc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rza4Ml80aVJ3B7xi0G88fYvk8/xC202DemvQBnkJ8hE=;
 b=KJMWiIWb3pkxx4HkVZxxATj7LoiW21+SuBqSOegPeIZSNzg6fhoRZNUGthJT6EgjRB4u1BKmEz0S6BtjM3AhBoom+piy3gQvkYUnxnIysv6BusPxq4Vwa7IL2NY5xIy1CFCcWMEyzi4jV0svD3FNyVYHFv+toBa3pBBB015x04V7ikTZm3qK9st/K7lOM8/vipPnH7T7zzXCws5a7ya1B7XBduWm/mS9xZKwsy2d4jGTiRFGSd+U/tDVE1u1p8rEiFy66D5paZ12YfOAr50NEjdxSCq2imXUTKMAMZu9soL1ztBq83BiXErrAZamjnV+MEwJIyPWIetcGBwyJx4xjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 10:48:12 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::f4b7:72ae:86f6:450a%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 10:48:11 +0000
Date: Mon, 20 Nov 2023 11:48:06 +0100
From: Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] selftests/resctrl: Add non-contiguous CBMs CAT test
Message-ID: <ilacrcz7o6wq2zdl3szb3cpkkboo43t3t2oyk4cmv3iwarstkj@kk34x5q4fpas>
References: <20231109112847.432687-1-maciej.wieczor-retman@intel.com>
 <879955f-d2d4-017-6694-5a031ec7f2@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <879955f-d2d4-017-6694-5a031ec7f2@linux.intel.com>
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|PH8PR11MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: d637f5a7-736e-424e-affd-08dbe9b6301a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LlnE++pEYG2Zwhhf9tpZTVWQQgWYrmocQc3Zv6UWILePiHcu+o2v+5EHK4+Lxb87SfuDcQLqFOmXATlcrveRkHlh1ePgp6e6zI+qWOHyI/H7TCW1qEfV8aAG1hXINnpGa4QU8HBme5eujwJmCuJnWAfB3Qux0zORJ4ARNAOkcw70mWXIvEOljQufLrmVzegO9f38B4DfKsZ8/+4eL19vRRLAxqRXRHGgXH/DBJPtswMmCBA+wLKcjm6qxQAwN+0oPeyq/uGIaapFH+Quz8LqjdCoW+LMT+TVkSsZR5u69MBHGF2Ta+bOx3oFCLlSTTp8cPeNH14C25Sov3dc43Eel53P1r4t0K+N3YreA9bGAVYDaHTxsbpx1zpXY3Bl+aoudItFmRSvUs6jYcMeLTpubtlZkh1s84LxGNcb8MKrKVV3DviLKi8O1ZUwpwAhKeR2CrryLzHfNvtH0Pm4CHZimRRACoqNdb7EMBtwKRnSb5SKgAMU6Je/l2yT+2/dqo01Eacpd6DjRBE9mj1Ln3psVcLzMdp4sSrmYFPV/2+RoetYwm1hjVUB9KkerquamWGn0f/ZkZJlIYQqCJiDCVflrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(136003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(9686003)(6512007)(53546011)(26005)(66574015)(33716001)(66946007)(66556008)(316002)(54906003)(6916009)(4326008)(8676002)(8936002)(66476007)(966005)(6486002)(82960400001)(478600001)(83380400001)(38100700002)(6666004)(5660300002)(2906002)(86362001)(4001150100001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?UbBoHcSNCANt8kPdgRcMX0GI10pNGS1pTEAdmnKq02mNi+R3gAbmZpxDvh?=
 =?iso-8859-1?Q?aEk7Jrz9lNtAnisdaxDYlm8/1cfvxRxq3cOJ9mzRmU0dOgM+xeIHv9BVqi?=
 =?iso-8859-1?Q?7rCYCX5n9ODrUOwpN3XXY8TrORhFfBotcQspQFh0i9qpsD+DsuhO0WfhDB?=
 =?iso-8859-1?Q?apBljolR/LtICwlBIRzp+Hl7pTOvzQcTXU0EusBjqlfKzIo5FA4/qvkjGs?=
 =?iso-8859-1?Q?1kj++OufKCRqhrXe7D8955MTPX0at+JSieKHCHgbCUvjINCJdMy5K+O9L4?=
 =?iso-8859-1?Q?NeGea/sB9NYjjhOrSxYAyTBXGVdHFibCGd42VeCI82z1oZiu3KVE9KSsSs?=
 =?iso-8859-1?Q?LhHl6bxU+IeW8mrvvHFD/FsKsyW9VG1YstnL6gWOmE+/tmA+sjPbDs75x8?=
 =?iso-8859-1?Q?/CyxlZA665GFSXwbjLDbWGMhgM0JfZ1h9GVLD0psDjRy/nHFuz1vBGkfpL?=
 =?iso-8859-1?Q?iqMgvD8Swqh2c7ldN6mN57dBWvzu/JEit7ZCt46eHE4l1oufjeXiqs/xEu?=
 =?iso-8859-1?Q?w1tSjYdqizChd7AIqcuzC5/+rDDRhSwhdBtSnchLGENP5gfe4OqYVBukVK?=
 =?iso-8859-1?Q?QyWUOCRg6uhFvhFnaCdj+7DJttbYzlqGgxntZCSdbCN5/ww4Uz+f2YYp7s?=
 =?iso-8859-1?Q?uemcrgnOlQsZ+kP95hh2+7MfJ0JvPBVzNKMGtA41p08FHwnR0yPvIklAFo?=
 =?iso-8859-1?Q?+F4oQpsweo0OEgL7pV8J9xzVwlqpyD+7xMbmU9jcEqNMbPT0zkkTRIJxxP?=
 =?iso-8859-1?Q?J137kZcX6CkdkAmphOdablz7bseFRFKhHjC3Au9fqRBcVUt/Th1Ldb1j0s?=
 =?iso-8859-1?Q?O9osqUEG9ujYn2OTgoaSeAQu10MwuwMDHCJ/yNLVeDSFNCUgqGEMdLbWU1?=
 =?iso-8859-1?Q?5Dlo1VW/9m2ZXxiX3fhQvtCl8j/4/vTJ5Ft/eUH55DTCHEZhq66djGGT7M?=
 =?iso-8859-1?Q?o4X9h1rK+Qtfp649ySceVwATDHsyy2+8F3r0APhL0eHIWQv1MqR83LPpRN?=
 =?iso-8859-1?Q?gSoPn96/ZgNSduCBcyMpcpgb64eVZmMqrrcPZD+tJ+OIhpcIBYv9tMjfVr?=
 =?iso-8859-1?Q?hNlPzXYsWeIOvYjCFBv2CH87Gvgv1L67zM2YRvjZk2GVaYOXKamIj2Gcb0?=
 =?iso-8859-1?Q?DyAwpmL4pRpdS8pKrKZCTjNPnGceEZQYZMloeB3ZjST3oyq/CocYBmp6d6?=
 =?iso-8859-1?Q?VO07vkn+PeXIYlxHT0akKm9BDEAZVZC6E0Z4VWj8/d8mkSVYh20N4RxwUJ?=
 =?iso-8859-1?Q?NHpNbgcXkaAzWBg4fXd924xEYBn1zGR4Kz2DNN8Y0Q/ANYVGZ7+9p72yy4?=
 =?iso-8859-1?Q?8cNBMdQZZ1tNEMPeCJMfP1CCb5ypsETAN/RfsQ6LXMaHGHZZXIB5CBElPw?=
 =?iso-8859-1?Q?qxkyvlRoVb6JfsnuS2Z9mvyKbInLDAiyziafdqOnbouUkP3UwC6zVNh2Tb?=
 =?iso-8859-1?Q?bjVvxd40wof3A8YdxWKMb8Q1yqwdA3oa3Eezc3GjND23dkZ20fXZHLEKf9?=
 =?iso-8859-1?Q?ABl171cknplNelxeEqvQbGeBbEtDh8SucRXu2961/3G3Y1sOazEEtrdLBW?=
 =?iso-8859-1?Q?1pLFEPd7jtOKp6107L0fZIpV3gPN7T5w36k1mFBeR3W7aiwECX39JCh/9A?=
 =?iso-8859-1?Q?V28Ro0Z4I/7APzcfZv75enxHNMJ1dOQOfM9lRocqAw1C5C0Dj5KqYhXYtD?=
 =?iso-8859-1?Q?V0kcas+fWg60zCxYnfo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d637f5a7-736e-424e-affd-08dbe9b6301a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 10:48:10.5201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyWZlEzT+v6D0mtammZbnV84DlNQG/exo6abhy7t2t13EQMkhwVTeElnwXx6jzS1PuzccOa0iB3iyaJbAVBA0feDn+dviaUL8fQCWj8KVJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com

Hi, thank you for reviewing my patch!

On 2023-11-17 at 14:55:54 +0200, Ilpo Järvinen wrote:
>On Thu, 9 Nov 2023, Maciej Wieczor-Retman wrote:
>
>> Non-contiguous CBM support for Intel CAT has been merged into the kernel
>> with Commit 0e3cd31f6e90 ("x86/resctrl: Enable non-contiguous CBMs in
>> Intel CAT") but there is no selftest that would validate if this feature
>> works correctly.
>> 
>> The selftest needs to verify if writing non-contiguous CBMs to the
>> schemata file behaves as expected in comparison to the information about
>> non-contiguous CBMs support.
>> 
>> Add tests for both L2 and L3 CAT to verify if the return values
>> generated by writing non-contiguous CBMs don't contradict the
>> reported non-contiguous support information.
>
>"if ... don't" sounds weird to me. Perhaps the "if" could just be dropped 
>from it.

Thanks, that does sound better.

>> Comparing the return value of write_schemata() with non-contiguous CBMs
>> support information can be simplified as a logical XOR operation. In
>> other words if non-contiguous CBMs are supported and if non-contiguous
>> write succeeds the test should succeed and if the write fails the test
>> should also fail. The opposite should happen if non-contiguous CBMs are
>> not supported.
>
>To me this sounds a bit verbose given how basic thing it talks about 
>(but maybe I'm too old already to have actually come across a few xor
>tricks in the past :-)). I'd simplify it to (or simply drop it):
>
>Use a logical XOR to confirm return value of write_schemata() and  
>non-contiguous CBMs support information match.

Your version seems sufficient indeed. I didn't want to leave that XOR in the
code without any explanation.

>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>> 
>> ---
>> 
>> This patch is based on a rework of resctrl selftests that's currently in
>> review [1]. The patch also implements a similiar functionality presented
>> in the bash script included in the cover letter to the original
>> non-contiguous CBMs in Intel CAT series [2].
>> 
>> [1] https://lore.kernel.org/all/20231024092634.7122-1-ilpo.jarvinen@linux.intel.com/
>> [2] https://lore.kernel.org/all/cover.1696934091.git.maciej.wieczor-retman@intel.com/
>> 
>>  tools/testing/selftests/resctrl/cat_test.c    | 97 +++++++++++++++++++
>>  tools/testing/selftests/resctrl/resctrl.h     |  2 +
>>  .../testing/selftests/resctrl/resctrl_tests.c |  2 +
>>  3 files changed, 101 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>> index bc88eb891f35..6a01a5da30b4 100644
>> --- a/tools/testing/selftests/resctrl/cat_test.c
>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>> @@ -342,6 +342,87 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>  	return ret;
>>  }
>>  
>> +static int noncont_cat_run_test(const struct resctrl_test *test,
>> +				const struct user_params *uparams)
>> +{
>> +	unsigned long full_cache_mask, cont_mask, noncont_mask;
>> +	unsigned int eax, ebx, ecx, edx, ret, sparse_masks;
>> +	char res_path[PATH_MAX];
>> +	char schemata[64];
>> +	int bit_center;
>> +	FILE *fp;
>> +
>> +	/* Check to compare sparse_masks content to cpuid output. */
>> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH,
>> +		 test->resource, "sparse_masks");
>> +
>> +	fp = fopen(res_path, "r");
>> +	if (!fp) {
>> +		perror("# Error in opening file\n");
>> +		return errno;
>> +	}
>> +
>> +	if (fscanf(fp, "%u", &sparse_masks) <= 0) {
>> +		perror("Could not get sparse_masks contents\n");
>> +		fclose(fp);
>> +		return -1;
>> +	}
>> +
>> +	fclose(fp);
>
>Add a function to do this conversion into resctrlfs.c.

By conversion do you mean the above calls to fopen, fscanf and fclose? Or did
you mean the below __cpuid_count? Since you mention making get_cache_level
non-static I assume the first is the case but just wanted to confirm.

>> +
>> +	if (!strcmp(test->resource, "L3"))
>> +		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>> +	else if (!strcmp(test->resource, "L2"))
>> +		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
>> +	else
>> +		return -EINVAL;
>
>This would be same as (you need to make the func non-static though):
>	level = get_cache_level(test->resource);
>	if (level < 0)
>		return -EINVAL;
>	__cpuid_count(0x10, 4 - level, eax, ebx, ecx, edx);

Thanks, that does look tidier.

>> +	if (sparse_masks != ((ecx >> 3) & 1))
>> +		return -1;
>> +
>> +	/* Write checks initialization. */
>> +	ret = get_cbm_mask(test->resource, &full_cache_mask);
>> +	if (ret < 0)
>> +		return ret;
>> +	bit_center = count_bits(full_cache_mask) / 2;
>> +	cont_mask = full_cache_mask >> bit_center;
>> +
>> +	/* Contiguous mask write check. */
>> +	snprintf(schemata, sizeof(schemata), "%lx", cont_mask);
>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * Non-contiguous mask write check. CBM has a 0xf hole approximately in the middle.
>> +	 * Output is compared with support information to catch any edge case errors.
>> +	 */
>> +	noncont_mask = ~(full_cache_mask & (0xf << bit_center)) & full_cache_mask;
>
>Why is the full_cache_mask & part needed here? It's not like the second 
>and can grow bits outside of full_cache_mask even if that would overflow 
>the full_cache_mask (it won't be testing hole then though but that 
>problem happens also at the boundary condition one bit prior to 
>overflowing the mask).

Okay, I see what you mean. Thanks, I'll remove the first operation. While
testing it also occurred to me that the the 0xf wide hole is offset by two bits
to the left so I'll adjust that in the next version.

>> +	snprintf(schemata, sizeof(schemata), "%lx", noncont_mask);
>> +	ret = write_schemata("", schemata, uparams->cpu, test->resource);
>> +	if (ret && sparse_masks)
>> +		ksft_print_msg("Non-contiguous CBMs supported but write failed\n");
>> +	else if (ret && !sparse_masks)
>> +		ksft_print_msg("Non-contiguous CBMs not supported and write failed as expected\n");
>> +	else if (!ret && !sparse_masks)
>> +		ksft_print_msg("Non-contiguous CBMs not supported but write succeeded\n");
>
>Newline.

Sure, will add.

>> +	return !ret == !sparse_masks;
>> +}
>> +
>> +static bool noncont_cat_feature_check(const struct resctrl_test *test)
>> +{
>> +	char res_path[PATH_MAX];
>> +	struct stat statbuf;
>> +
>> +	snprintf(res_path, sizeof(res_path), "%s/%s/%s", INFO_PATH,
>> +		 test->resource, "sparse_masks");
>> +
>> +	if (stat(res_path, &statbuf))
>> +		return false;
>
>This looks generic enough that validate_resctrl_feature_request() should 
>be somehow adapted to cover also these cases. Perhaps it would be best to 
>just split validate_resctrl_feature_request() into multiple functions.

As in conditionally call a function inside validate_resctrl_feature_request()
that would check for the existance of a particular file that would indicate if a
feature is supported or not?

Does implementing it as a new entry in resctrl_test struct that would hold the
desired filename seem reasonable? Or would it be better to pass it as a new
function argument (similiar to how "const char *feature" is used now)?

>> +	return test_resource_feature_check(test);
>> +}
>> +
>>  struct resctrl_test l3_cat_test = {
>>  	.name = "L3_CAT",
>>  	.group = "CAT",
>> @@ -357,3 +438,19 @@ struct resctrl_test l2_cat_test = {
>>  	.feature_check = test_resource_feature_check,
>>  	.run_test = cat_run_test,
>>  };
>> +
>> +struct resctrl_test l3_noncont_cat_test = {
>> +	.name = "L3_NONCONT_CAT",
>> +	.group = "NONCONT_CAT",
>
>> +struct resctrl_test l2_noncont_cat_test = {
>> +	.name = "L2_NONCONT_CAT",
>> +	.group = "NONCONT_CAT",
>
>I think these should be grouped among "CAT" group because it well, tests 
>CAT functionality. Why you think a separate group for them is needed?

It was convenient for my test purposes and I guess I didn't rethink that part
later. So you're right, it fits better grouped with CAT, I'll change it.

-- 
Kind regards
Maciej Wieczór-Retman

