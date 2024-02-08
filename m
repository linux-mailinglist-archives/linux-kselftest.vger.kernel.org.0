Return-Path: <linux-kselftest+bounces-4361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308A084E965
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 21:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6542886A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 20:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAD136B0A;
	Thu,  8 Feb 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyEKoQJL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10895383A1
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707423065; cv=fail; b=SGJ1lPooDZEUKGdclTcSsKvJNWZwn/cr8Z/Otku1k8Eo1BQv3QXoWIXm4ygeygKjAjTjE3wApK4qrdYmsJHuFKRXR92QJJa3+1um5LXyZh2iC3tz4HKDf2FB+U/kiA75GXRlXyZUnSCKLaqWGW466yqmskloUr59MC/BpMAU3T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707423065; c=relaxed/simple;
	bh=BkdKusS6Y5diKnaMwmpHHg52QEW8mLzbzwp6v+/bmXI=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eM74IHyfl99l8gnQt4Ku1dBgnuHiB/eMWv3fjqPhcTuCffJOD6uf6jSbHn9NhHsabw/ZuK5ohgI83LxN5z1t1gK3V9kUvSPZLv30pZAWlpyi03jHy2XrzIf22O4MwCJDMT5KBj5qifAhdjA4LvmHL4WWAIwJv/nbblBCxwad8Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyEKoQJL; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707423064; x=1738959064;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BkdKusS6Y5diKnaMwmpHHg52QEW8mLzbzwp6v+/bmXI=;
  b=AyEKoQJLib5YNJup6jvX0Z6BoUXZsmupoohQ2kIf8qJBQAO2md+ezT1z
   1EbfY4w3PL6eLaZLt/Sj7DXdVcKozF5ljUhS4Rq7dFZqYQP0TfldSOmqF
   HDsHQpy6Mhp58fVsNGBYCnsNjGGYNWTpwATO0t0mBknnyrlZ9qCRww2J3
   5DDuovv7dA3cSiVeyv+BUPTwXVJlAXXvs1AF9uubq2BXzwlkJqmBB8ro6
   9KQRXlqg2UWbHcKIPdlvSwmH4+EZz+0gqMx8IB+bZyG/X4HQ2Jgxv0TZ7
   II2/EReWTobD81n5zV1BsJyrMLAc2oNmx1EnHXBYZXi3eUEzjUVBFnxqF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="23785690"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="23785690"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 12:10:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6526363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 12:10:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 12:10:18 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 12:10:18 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 12:10:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok16RqCvpsrtoix9b1wkYhu+yixRxXJozZuJdaY5LQzBWydVLwCeTcgSdaw9DAlIakPi0zNMTxMcZb4QCTffrtVlT2NPe2S7Mv0YO32DI0l3uWGcS5dAQuMz205qdUV/o+My/5Clbf4k8fvNRCE679/rQmNIsvKtdreMaDtYzT+r210aYvTCT+wLvSRhEC1RtOVV3V2m8mxl9hXCn8NIhk2JymiHFS1AaLcULv5AzSUG5rgDaiy67uOBQeXl91uTkNZzzyaOaL1a/n3yS7neai4wDxe3zDu9x+nlPcrfsTWS8ygDHjrJFqRAgn5+3mJ4cjOUzvozmNrKV9jlCoA0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkdKusS6Y5diKnaMwmpHHg52QEW8mLzbzwp6v+/bmXI=;
 b=P0tEx4/0AovLNBFkumpj1qEGvmm1tKB1w/906611EqLg2KuytBb3u1EVsHecEj3hxO7RMYYzBeOuv5tJa3+dBLP1AWXFyZZzf+jnGVAL8GxszWxqWr0ufPReJfgonHNsWX14VHWUVmI2JbcTZ81LQtk2RK1LhT0QkniSOHJgLCiJBSD6W7DlCpoyQDCkKPeB+S6MfFMQrZsO8tBnu/pmqQNUtJ3b3sTLcsmjU4PVmjTFJ/v/EZDBbozfaAKuRBtE7T5e5b97oU4z8RYSXbJTGpWgt8DDytZCcVpy8xfRMIjOgQGIgHGyic+OF8Gn93f0YmBpWmHyB0DHa7YMV4pQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH0PR11MB5330.namprd11.prod.outlook.com (2603:10b6:610:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 20:10:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.035; Thu, 8 Feb 2024
 20:10:16 +0000
Message-ID: <c1c08466-2eba-4f54-a557-ffa6a0c3b4cd@intel.com>
Date: Thu, 8 Feb 2024 12:10:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl selftests ready for inclusion
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
In-Reply-To: <39f71a7a-9a3c-4b0e-aa11-7b94f1003cc4@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:303:2b::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH0PR11MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a360dfb-70d5-48ec-3536-08dc28e1f740
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBPCG4R1/4YIPadrA3JPq9eXK/RMrtlXMJQHC0WAFivEiezfpj3ZfRFFTxQIa7ZglW1J2cFg3lmIO+KWMySpNlOAkYDohxTjL7xAKFeL5/uhkWgm6jKhmsfa5rrr5D6+Ychdm+8i7xmrtVTy0Dqa9FjYA17+h+ZNNQKDdYDhPgb/OhSmO8ZimvEPtsRpLbZMWHeMsd2lW0ig8OW6KQKrtBISCOIvcA59ND8Q8NPRTInk0Tr4U5f+vhnw60W2U9mEPG8HPONpNlHQHe70SmxP7Qb369aHQ3pqk/7ZdYjT/adhdQ8eWw/4E63IPz2DS83R3APedxDb3YiFxwTRvEZgNg40N6EBaII2SHgdv0B1SOVxTD3vm729GipqdycIgjWkCwzEFE2DLp34UFOtinTu0XJUabaAXeAun2Qxa+PRIEQgCOeONfOjhGlwp1S9orIUFyC2IKsG6p662kwS14/odkn2lFa4dMdVkrQO/ZU2Fg+SozSNnSlZlC0PJZHRAlHmcwrIUOX4l9MUCinXjZhE6oLh6O9w+1DEymX5ekEvnk4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38100700002)(82960400001)(6506007)(86362001)(31696002)(66946007)(54906003)(316002)(110136005)(53546011)(478600001)(6486002)(4744005)(966005)(5660300002)(2906002)(44832011)(66476007)(66556008)(6512007)(4326008)(8936002)(8676002)(26005)(2616005)(83380400001)(41300700001)(36756003)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NU5ieXlTS2Q4QVFLdFRlUmtkbDdEaEYyNXZTazlMemNtZ3I1VU9OYjVoeSs5?=
 =?utf-8?B?aGJCWHpRaDNzZ1FtaFhJNXpGZmNyUWtnOWxFWmlPeGVRZVhKK2dJSVphZnpM?=
 =?utf-8?B?WkNrRlpvdU5nUitqaCthNEh1YTF6a25iWUJENjlRRU9JYkJzYzZYQWFLaGJn?=
 =?utf-8?B?WW1VZ3QvcFNZL25RTHJtTDk0MmpwMkhmeGVJc1FPK2QxZ3NabVBxajdzVXRN?=
 =?utf-8?B?U3lUY2hhRFlPeVNPcEwzbkl0Wlc3VklzRy9xRUV1bENsTVdnYTF0QUh6cVhO?=
 =?utf-8?B?dWdkTHRHTmtpM0tYQmhZZ0ErdWsvbStCRXRFSnNKRlN0YlB1SWtsRjVCTTU2?=
 =?utf-8?B?WFc4MWF1MUMxZ1ovcGRzSFpIOFA0Z2pSWGd4d1hKQ1Y2eUpzR2o4RjAyZ0N5?=
 =?utf-8?B?cUxleEtXdDMvbXVtWDE5eG0rMTdZc0s3cEhZNTN1eEtwSDAwTkNscm5FRnFN?=
 =?utf-8?B?eWsycGxiV0JNcEdtZ0lEa2oyQ2k3ZmVra001eWQwTlp6UFpBZ1RRSTlXSDVl?=
 =?utf-8?B?RHArYkZLMlcwRVQ4TUhKN2MrRDlvS3EraEdXcVl5UlRHbm9FNkd1ZEViT0M4?=
 =?utf-8?B?bGdqdDVlZHN3eTg4dTFwY2I3L21KQmJnT0RjMlhKQ01xenF6eHN3YjBQYTlo?=
 =?utf-8?B?MUdTNi9ia0h4MXFWWDR3dHRxYzh1N3BBT0JsYUpzaTJWejJvT083aStoWkRp?=
 =?utf-8?B?d1NKRE5yK05YcnVHczNBVHl2Q1JvaXhwWG1MS2dEMzkvc0JpZm1ROFNaU2tM?=
 =?utf-8?B?SFEwVUsyYWhZcVFrU3MzQWtnYXRNUE9UbUhzYlpneUNaTUNLYk9HSjlGa2hX?=
 =?utf-8?B?dy9MR05wK01lckRlN3FDVVhkdWczSmxZSTQvakEySnZvd0tmbjFVVVo1UnNH?=
 =?utf-8?B?Q0pjV2w5ZnpZTXBMQS9kYWhObWVscXNSL2FCL0pvbzFsa2pkMWN1bWlOM3RH?=
 =?utf-8?B?QzF1ZmZsMWVzbE91YkZjNmZZOWVxQVhSR09Yd3g5ODNxb0NlWm1tWUVRNkZm?=
 =?utf-8?B?cXI2ZU8rNnlLWDIxeDVrS25lQ1gxcWtyYmltbU9VZitER2VrUmdya01udDFB?=
 =?utf-8?B?R01XTHlWcFAyM2ZqTW9vTUhCeGNmTWxoU25lL3pXOGJMN3FmeDBNZ25KZWZC?=
 =?utf-8?B?MWdCOFFDa3U0bWlKdDZuR3JzNVlxbTdIcFBrNzlOM0R2bERWT092NUNwMmJB?=
 =?utf-8?B?SU1YZVRiekdDOUN1R0pQeWhCZU55U2c4LzE3NkdxejZydkZ3YjdOUkJuVmt2?=
 =?utf-8?B?OEVmM3Rsdnh0aTQ2eFpaZlp6cVdaV1l0eGF4MEM1UGRsK3h5M1h4Z3hSM3l5?=
 =?utf-8?B?Q205UjFlMDErVm9BRXh0bm9vdHMxVjRKU3hWZVR5bHl1VDhiZld6UzZYYllp?=
 =?utf-8?B?TG5QVFR4N2JKZTRIcERVc2RMQTVBS1FlMzZUTzVpeHBBVUVUK2pYMVhuYUdx?=
 =?utf-8?B?UGZwN0VFQTIyeE85dy9ZdThTSTJFOUM2OUVsNFdDUVluTFBNUTB0QlR5SU1x?=
 =?utf-8?B?eWZtS25WQVRka1pEa2lQMXltUllrWW5uZU83WGNBcitmejN1b3huSTNIdzgv?=
 =?utf-8?B?Q1pOK0JpMDhuRTk3VEhlNW1EYTZrRTY3RU9pRkN0U2RDMFZJOXdxMG9QTGhU?=
 =?utf-8?B?aGJST3lOK3pvcTB0bnlMWk1heUhwY21wb2pBQXc4R2R5UEZxd1kvYVNQTHNI?=
 =?utf-8?B?cXFueTNIQ0VRTHJ4bEk4MElrUzBXRHk4TXN0TWxMNE5QeS9VVVpDR00vQUtr?=
 =?utf-8?B?T0RwazdZV2xDR3hVMHpIU0xJYXJwWlhaeHVMV0JCYnRHTUIwUUhtQnEveVlp?=
 =?utf-8?B?WVU3RU4xbmpEY01EVDdjKzlSeWorQXdERGxlenFOT1VuRVdyWXd5U2JtWEtl?=
 =?utf-8?B?YUMyS1VuckM5amxZRjZ4RlQydGxQWW5aV3Nwbk9zaFVmV2dxU1M3ZnQ4ditZ?=
 =?utf-8?B?ZXhVbTA2Q2RPUENvVjZOZ0d0MlEraVZvZnV3RGMwMDBEVGRVRk16S3NTTHhs?=
 =?utf-8?B?WXR4UVdzSGk4ZXhCd2QrSVpheUVjK1Nrc2RYZ0I2N3VydVBrZys1MXB6WDdv?=
 =?utf-8?B?UzFFSS9tSHZQN0xWbUNjc0NIZWZUdTJPYlFTM2k2UjZ5NnZFTkNDc2R2MytG?=
 =?utf-8?B?cHpaQlcxOGRXdjlPT0VQUWlwaWt4RGp4YnBuYjA4YjBROHpZd05xdlJPbTFO?=
 =?utf-8?B?a3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a360dfb-70d5-48ec-3536-08dc28e1f740
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 20:10:16.2019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgedEtoUkfjcuOGzcz8FmrjAi4gRvztgvDkLYxx0aLM38EYdlMliDWnHG6z4cP1LO15z9lK+A++xK0ZE6NnDRP97FaoG9zjSj1BzRlC3Xhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5330
X-OriginatorOrg: intel.com

Hi Shuah,

On 1/22/2024 10:06 AM, Reinette Chatre wrote:
> Could you please consider Ilpo's resctrl selftest enhancements [1]
> for inclusion into kselftest's "next" branch in preparation for the
> next merge window?

I just confirmed that, even though [1] is almost two months old, it does
apply cleanly to kselftest's next branch (tested with HEAD of commit
6a71770442b5 ("selftests: livepatch: Test livepatching a heavily called
syscall")).

Could you please consider [1] for inclusion into kselftest's "next"
branch in preparation for the next merge window? It has reviews
from the resctrl side.

Thank you very much.

Reinette

[1] https://lore.kernel.org/lkml/20231215150515.36983-1-ilpo.jarvinen@linux.intel.com/

