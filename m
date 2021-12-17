Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9B478ED0
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhLQPBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 10:01:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:44729 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234775AbhLQPBS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 10:01:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639753278; x=1671289278;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2gTRCkd8LS2mnPwjKlPWX5d0sJh6GtFM7gO//mZuNiE=;
  b=FyUX+5NroCSDioVGn/U9shLHYO0ecpQOBk5WLy9nr1L2wOnFeUzM6O7s
   9UuWjZ4eXBT97TaeuNb63Ce7Sw3/EvhTikrL2TXg9NtCwoANqQq2xnZ+g
   CcEg8jADSqqTkOkUM18083MbgRT6H1npApxNruMrQgyUNeGNLN/OIgXqG
   lgCb7i+rEc/xAHDwx2VZ/xD63cIKghjeaTr3dYEg061UTbCvi3d/GJR5/
   rRL87oFAC8wnr1lSUMB6RA8YvUolQyEb2YRWzLWqUrKohd0prbv2La1XE
   KRlkRl12bMnwnvYuow3bC8ziCz06A1nGlpR5A+ca6UPvV5q/Lv9xbJHJF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="219782374"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="219782374"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 07:01:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="466532522"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2021 07:01:15 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 07:01:14 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 07:01:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 17 Dec 2021 07:01:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 17 Dec 2021 07:01:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f9QN8zxb5Rc1AsA3lvPYPAJiBDFR/Y13uYumgXcT22+iSJkX/jLNIFYr8oi8m7EDYP/QUf980P+G7/i8O1IfmYxrSTy96GYj1tgCokyv1NPAUaJe98BLc/EriMgw07BkFtFQ6zJP3B9ZF38Mi7hAjFqoHCmxz/rvL9WK09zDXgMctHqY61+G2cT+j5jcV5nb2tl8H49qwbpEL23W0g+Qcv5NLqpKEkaagdHBtVcHfGX90NZY3kGlaaZb7BXLQbN/7CvkphQxBS/hXzT3lx1ui55MDQy1v0mh0vt2o50zM9iKiLmsAToQ2RT7wNeYqxh5p32zlItjhKZog12Ut3+IOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j38Z0sXVa/57sai9Zgo6Sk1CtAzXC6KxmPu4zHzfKiQ=;
 b=bAalVZJa4iCIyfnQ9OxyNDdrxMnAbP3vVfFXYVbSYWQrsLTkRyD2lNEHvS0e9sI92SC5E5elA40mhCNfLQ0Aon176HtvYXub3XauPx7UCcCffblagJm2PuKD8QV8XNDN6+gG/rdODZNHnUmWCxtKbedkFS6R4KNJun5NTfwiKbg342eceDS6v7ib0pDo4mKqHGfTGeG/U0Ud0nLC8rczKtZEVtFcFHo85BCpy+uGktXO8HfEG+UNduCMLFIoVlU8/+xDomKH9gcpXHgn7U/I/jTEpZGL8DEMR0rdLeIU0DX0bhyeplMXGxQX08OtqLzxlDXWavqJb8TLvobimv45rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB4049.namprd11.prod.outlook.com (2603:10b6:405:7f::12)
 by BN0PR11MB5726.namprd11.prod.outlook.com (2603:10b6:408:161::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 15:01:13 +0000
Received: from BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26]) by BN6PR11MB4049.namprd11.prod.outlook.com
 ([fe80::cce3:53d5:6124:be26%4]) with mapi id 15.20.4778.018; Fri, 17 Dec 2021
 15:01:13 +0000
Message-ID: <b3a299ba-622b-98b3-41fc-a252396bc553@intel.com>
Date:   Fri, 17 Dec 2021 16:01:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.3.0
Subject: Re: [PATCH v1 0/2] kselftest: alsa: Small enhancements to mixer-test
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        "Jaroslav Kysela" <perex@perex.cz>, Shuah Khan <shuah@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kselftest@vger.kernel.org>
References: <20211217130213.3893415-1-broonie@kernel.org>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20211217130213.3893415-1-broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To BN6PR11MB4049.namprd11.prod.outlook.com
 (2603:10b6:405:7f::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa2bd8ee-ba85-47f1-f5bc-08d9c16e1132
X-MS-TrafficTypeDiagnostic: BN0PR11MB5726:EE_
X-Microsoft-Antispam-PRVS: <BN0PR11MB57268BED306F45F4F7A8CFBBE3789@BN0PR11MB5726.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwggotrxk8AvA8nn4y26TK+5/uYMtsVyS8Bd60ixDj8qQOsCfRakEScQPeYbrdwgMZE3CGwjrTs5VnbN0GgnHnDNzO+oqYEJQAQnEZlk3fdGTq2YHSjCCK6mSH4EiVoQ/ISpSrAfNoui3lOM7O0BIKqVoFz0qREgqSjXUQKe942x2nyWcATL6ZgpSO4fBbSh37WLQGRJzOENgUeVjwUluEq682gfAvPrtLJXMhanSoFc7eATH4v2PSbGGFu2PFLJlxnkwOTehe8XZYJllZIErhdw3MKoElQWCoJAkvkbvC+eO17vxhGeHy+ioevpdLbEnhouJYaMQbJHASRlCNKhAEgrgQNzUe2Jjv8XQRMrogsrsNUvM2B8KicTOyLj8FQiqce0y+x2XthuUdiz66X+UuOXLOUmj6JXXe9CPZdDWB8cKA+FgwqjrkCoKE8NsGGkJATeBBK2dIyea2czzat9P4Z2Wt7StzVy0ncIcXqenf4a7B0Ipk3eEc6Jxtn8TRwQb7aL1Rt+qmPaI0DW6KsGF42PZ3HT2cqC1RxU+Tq8QAf+qtXIdz0jG6vE6HKLW7PppA1xsxnObwgd6XQYgSiQb1lRU4Nt2BVcAqZyo0YKjx7bhEQp5WabOxLFOHVFgdZ/PVIp3mISl+yQQy0CEROluaODPkommRZ+knuYGHwM5ADU0/Sgm31AgHY7jNP3LrfZFgzMG8OtnI08jY1GoBfht+GG0ZO06OqQy+SG77vMOis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB4049.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(86362001)(38100700002)(66556008)(31686004)(66476007)(2906002)(4326008)(31696002)(316002)(4001150100001)(82960400001)(6666004)(36756003)(6506007)(110136005)(44832011)(8936002)(53546011)(8676002)(2616005)(6486002)(83380400001)(186003)(26005)(6512007)(5660300002)(4744005)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWtFU21RdUdhbWZNMzBGOFlXTXFNQTFVSmZOay96bEdoZ0NXNGJmUTNGRTNl?=
 =?utf-8?B?bGgyOERIbDVDWDVlaEUxY3I4N2tyTjN0VUdnUGVhSEU3dzF0SXRucUM1MVhp?=
 =?utf-8?B?YmI5djhZZDlITW9abkpYNGFQRThXZm0rbmU4aUE1OS9yS0gveEttT1RoTlFr?=
 =?utf-8?B?SUtnVnBhblZtQ0dNV2xDWFlZQ0x1bytJaERqVytlSWpUdStMVS92aHVhWWdN?=
 =?utf-8?B?aEE3YzljNWU3M0xrN2E1MkhKOE84WTkzTGluVC9TZS9hT0NScGU4bGIvbWoy?=
 =?utf-8?B?VVFkRzMzSUJ3UEtQV0JIYkJpVXpjeHBEbkN5ZkxOeFFTbllNekEvWDJCNEhp?=
 =?utf-8?B?amFqN05Va1RYNWF4M1haMXExVm5DOUVZZGVIME9xNDBFOWtxSHZxY3BhWWZz?=
 =?utf-8?B?dk8wS2hOMzFtS2ovK2lmeHJmSDgrei9UVHpSaGlNcVlyN3BDU2prUnY4NmJH?=
 =?utf-8?B?Ui9ZVm4vQzhacDE2ZTJLT3ZiL2hpTmZhTDBhUWkybktEeS9tTjdYZ0UrUVNY?=
 =?utf-8?B?SVBLV3Q4WHRqcEZaSmNIbktPRjJWbE8vcU5OanpCWG5OblBVZXZGWG8wOFJw?=
 =?utf-8?B?aU1jMDFrZEVPdmppQS8yM0JMdEtZZUQ5QnBDNE9ZYW4wMTlFc2ZnbkJmTHJN?=
 =?utf-8?B?Q1Ivbmk0ZjlJd2g0cUtxYUMvaVZZR3dSdS9JZ1JPenJocU5WRURnTzAvQ2Uy?=
 =?utf-8?B?bHllQ0YyNjVxdTVFd0l5YXlBc2dKVnFFUjZaQi9UdTRRbGV6YWpqUHNsWFJP?=
 =?utf-8?B?ODFnNHpFQ0pGTHpualYzdnN1enRsdUhaM2N1akloNUgxQS90Q0p3SVdUMXNz?=
 =?utf-8?B?S1JyOUhHUk92dHF6NWt3Q3pBbjUrZUlNanh0Z3h1VjlXdHljY1llTVlaYTIx?=
 =?utf-8?B?d1huSHowZ0dBdGF3VHhyNUpXNld0azdPWUFFcUJjcG93V3FPdFZkQTFFbTMw?=
 =?utf-8?B?ZDc3VmpRUC9zZVNFUG9PY0F3WFkwZGdMdVA3cEk2Q3I4SzBzdXFJTVdqNjVs?=
 =?utf-8?B?cWJmeGhWZFk5TGdaQ005UDRGb2pGZXZvU0ZwK2x5OFdPSGpQeFBybXFzY25j?=
 =?utf-8?B?M2ZYTkxVb21BaWUvUHFzaUtOSWM5VDJVZElXeVhkTnIvczhKR2l3VWZqUDlF?=
 =?utf-8?B?UE5HOFZwQjFYREp1cE03VmNvNWtld1doeEFGbUd4UHlCc212RDNLblJOWDVX?=
 =?utf-8?B?ZEkwUWxEbGFQN2dsTzZ5cGs2bTB5cXdvc1YxQ0krdFZvWE4zaEpxd3g5RjNH?=
 =?utf-8?B?SDVFVmtiSkZ3SUxwdlA3RTBiQ3dFYTlxS0RWRE9xK25VU2xNOGtWcXpPbnV5?=
 =?utf-8?B?UGNZQTRlUTZoSFVyYzJVVW56a1lOOVh0d1dGK2l3Q25Tb21CckhWMHBmb00v?=
 =?utf-8?B?ekRSbWZqZU53Tzd3bG1zNys0UW1INGdyMzNIbDJwVFhHak40azVieDRTWng1?=
 =?utf-8?B?SUI4Y1FCMnNGd1hSWDlJSWNteEZuZkpnSGcyU3BWbEMxa01yTEpubG5xSkxL?=
 =?utf-8?B?S1h0TjJMYnJDbk1zb2xvMUl1Rm5tU1ZrZVRWb2EzU1R2OEw0aWlodk84bEhp?=
 =?utf-8?B?OVFXM2ZlOUlmaG1HK0d5bUUxbk1JaGU0b2srSFEzcG9uZ0NpZ1JiQUttRTZj?=
 =?utf-8?B?THdsaCtlV3phVnoyNUZKNERnVG1DalhYa0JFYWVxb3cyMmJmYTMzODJ2UXZa?=
 =?utf-8?B?a2RVK1RPZWZJYVNxTTdweDJVZGp4UkdyRVNGQjEwNzFwUzd6dGQ3L1Q5bzNn?=
 =?utf-8?B?emE4d2ZCcnBlSXJEbGxLSFJ2bDNpS1FvZ0lCWk9tSlZmSUNyaGZSWlRheFhT?=
 =?utf-8?B?MWlMUUpaL1lUZWVrVzA2SFJJSmM0MkFsdlh5NzErTzU3Tk01VUxvTWtPU2RL?=
 =?utf-8?B?MGMrRnRab2hDSVZvTXAwa3Z0MHEybTMwOEtmZDloZVE1dEkwVVZWTnFEZVpS?=
 =?utf-8?B?VmhKM1dDalUwYTU3UHp1dnhmVXFVNTZ1MXJxaGNvd1U2aFlBa2R4U3VnNnlv?=
 =?utf-8?B?Ym1aNFd1ZC9IK3dyemNKMXN4RVBxay91VW1hZGJVQ0ZyRUZWSnY3QnRMeTll?=
 =?utf-8?B?dDJBazhvdGc1SEd0VGRhT2tZUEhKVUZkeDM3UkIyK2ZOdmNLOENwVXBhcnNi?=
 =?utf-8?B?YUFyQi80N0xYN2g5TVdsZU1hb0VOS2g2aHJBeGVBaDZxMTBtaTdia0VOdmsv?=
 =?utf-8?B?V1pkemJqcEpLUXBqSzF3eWZGWDJ4TThrUDF1K3lFMWN3VnppalBpYkNEZ1FQ?=
 =?utf-8?Q?GVBa8Z5puiycLXIHriZtwSHPojuPqks3eowXMpbbr8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2bd8ee-ba85-47f1-f5bc-08d9c16e1132
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB4049.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:01:13.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dyg0RZEpN2p4x4nmk9+CaPwmNnuHnsrn91oUKSKmiaGLmb4qm2AQWP9uZg5pasBmOm9irXCvoEuyU1jJlQIxB+u0Q8NEpRRumqCkm6t6YVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5726
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-12-17 2:02 PM, Mark Brown wrote:
> These two patches improve the mixer test, checking that the default
> values for enums are valid and extending them to cover all the values
> for multi-value controls, not just the first one.  It also factors out
> the validation that values are OK for controls for future reuse.
> 
> Mark Brown (2):
>    kselftest: alsa: Factor out check that values meet constraints
>    kselftest: alsa: Validate values read from enumerations
> 
>   tools/testing/selftests/alsa/mixer-test.c | 158 ++++++++++++++--------
>   1 file changed, 99 insertions(+), 59 deletions(-)
> 
> 
> base-commit: b73dad806533cad55df41a9c0349969b56d4ff7f
> 

Apart from my previous question regarding patch 1/2 (which has been 
already answered), I have not found any issues with the series.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>


Regards,
Czarek
