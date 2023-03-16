Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63B76BC215
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjCPAFf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbjCPAFb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:05:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BD26CEC;
        Wed, 15 Mar 2023 17:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925096; x=1710461096;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=VkVNZ0QVeSnMqHZHoOKFrFCSAMEBjLihxnLqqFth5yg=;
  b=g4VA4df4Z2QQrYutA8JJSVfPQ8QVp7rIVrERHGes9oA2vNVcozJ8ONS+
   Qe0IwBD10SGkWGQlXgnhsU7uVcLOLIGyOE2JIJzuqTw4Wsdm8nG6s/2/I
   AYkDK+HcYfbtBS+pMX8MpNjPXPzpwd9pENafi8Zay1SVUUit/SCmkhJ+z
   ypXLYA8wsXeMewSz+JcYoR46Jn/zYM/JP/OFfwismMU/UnBDjZucycw/l
   8H6e+ygPpE15W1pEL6Hmj9sElXr3P4jT9Cj1MrmNpp/rqymBNPZws+Zto
   P5Kca+hCC9Bg/nF6gAH/lk9uIS7Ygo7PeoaHSoi4UVanm1PCz6egBFr9A
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="424119771"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="424119771"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:03:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="743906754"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="743906754"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 15 Mar 2023 17:03:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:03:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:03:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxeYdYNIblJotZoYOlK8luUZQA4F0ObCL5+KVDDwC3QR4A/mGQjPbeBhhwLPWe6U2+6abSlxvZAh3qfGXkG9OZdt32qD6JgXFcqlcMp90zaw6pzeyT3DzDPPalTSjkaewvGGdOgw99VOCWg43kIM2/JMcOf3Kr3QNtIaVS+1nzJxmd659hN4SwXwvZup64mL4pK5dDs4SrJcqjJv2SzTn/f9scfKNmRVdOwMOLEEyhrMpWffj75BTrYoKbnSZ/ZW/2AbGZOvHBiq5JaxdRz9r9QoFsBBTg0M/Fi+Tx4/kJNCKpFSLT7Q9fBdaFjCbQC7kKutEy7FTahWj/Elqy66eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+UX6rtzeNpZeugFPrZimpNro+rrkaEP+q70nmllSTk=;
 b=Lb03sV3o9e5tNZDDBR3zOJyk55rohibcxmXCQlB/0mdUigvFluFB9TsPxaPdGk3oCVohJEBcgokp+Qc5aRKzDFnUSVDlDssxIs0y30+OXRHcHNb6+ORSB8peiAHhAeLk+9SEWOTUvoFjwxAD9/binNgytrkNdXwOtp4x9eU2j4Qf5ifeCN+Q9mRM4yDCbTHvZYhvdvDN26QK5VA3Dpqc2yWxNekibhFQORpFyHzvCdr/wIt6PxES/av/wTujBWB58aZOPakVr6XDTKNmT6KpPFg4EUQSdDPHYBRg1h9MLPX7BnxLAPoYOM2YzFR7FPITxfe/9PMXVaYKHy3a8wSfAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:02:59 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:02:58 +0000
Message-ID: <b322f7db-6b55-90d8-340b-1f9594e4494b@intel.com>
Date:   Wed, 15 Mar 2023 17:02:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 5/9] selftests/resctrl: Replace obsolete memalign()
 with posix_memalign()
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-6-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-6-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b8371e3-22c5-44d9-9a45-08db25b1cd40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBKgwf6afx643sX6g/e5WQGzcwCbAaf4d9WE91dIK4iPu/lYJxCVef3PQYsHnrjfWD0P68QsrOcgx78MLPccn9tTApbfBaNq30nO81dFmOGg02vinSlaBTxNi+yukfaNB24psFBa9OMvz8pB1IyoldpVCtNSoq8Rf7ojMmFKEvuiFdA1MrU4Lg27h/I2g2jcN460+QrJqq/jZCcmwJ1CGUkAL7UY+f0/F+Qw+aH5dnWXsWnFV9DwEX4UwDGh2dSwgCpqE6o/BEuY4uktWbIH8cC2yKJzAh+ELPTQS2hNh4LxFVS//I/vtzZk2Tx1I3DAZ3nQUdaecGeUPBHSwM/40wNEHotU5wwsRP5kDe21FaA2lMdyMgf2Z0Ry6JHeirmibdgzWGbplM1VzLPdpJ6CnPnY4K3K8/hQ0hYGnsV4tACy8pkiykg0Nnl9fXjOdIEFJEFi6FdhGSremTsH/Y05/eQqS70cGKa5NuLCOPCKhHqt7LKqi4XwPNhzueKdnOGp1WecSpcrcShNSRKB9rVu5BL2I6l4MBCza+vmHtkyD7u9EWtyx/Z8MMSNajIaNblPUN2/jfmvZ71SX/rku3rxsZT2OBbYqfXy6DGU40zcA2WGXtxEe2BSxHa71yPMDe97BAXAxs8s1kqbbkLAQWXZuVUMHsqEdTCX2slxFxIimRKNdJ+b94BAYK8XTZ0jzLMTsep59NEND+esgEDrAru0ehOpC8X6NMjDeRCTOvwhAGY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(82960400001)(31686004)(2906002)(5660300002)(4744005)(36756003)(44832011)(186003)(86362001)(110136005)(41300700001)(31696002)(66476007)(66556008)(66946007)(316002)(38100700002)(8676002)(8936002)(83380400001)(66574015)(2616005)(478600001)(53546011)(26005)(6512007)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OENzMjBoTlBLRlUyOU1QMTdSQ25Kbzc2NnJNeVFKc1ZoSE5iM1lSYkVlKzl0?=
 =?utf-8?B?a1pNcmhLMjZsYmV0cExQclp5bkJDTXVKSWFxckFUOENReGR1WTBnK281TVpj?=
 =?utf-8?B?ZXIramJEYnYyMmZWdUNjY0tCcUhmcWg5Vk1JL2lmWUtDbXJIdndXMDQ2TU9j?=
 =?utf-8?B?bklNcCtOazNNd2Q1WExHckNQT0hxRWZkVVJnd3MwWHUyNm5Dc3RrUmgwSGJN?=
 =?utf-8?B?Nm8vckEveS9ydjlvMm9PV01QSlJSR3NCNnhHcVFUYURqeitKZDdqVVlaTjZx?=
 =?utf-8?B?L2R6enBnbUlTU0Nway9vZmx1UThaWmR0VGJSMlFkSWhNQnZISFVuOTJpUndv?=
 =?utf-8?B?OVdiNUhEZ2pyU1dHZ2NlUTQ4S3JycVFYTE9lNVk5VEV6bHR1b2E2U1VoeTBw?=
 =?utf-8?B?VWpkODIwYUhLTGlmeTg0TWRYRFA0MkRMWjF5TGYxeU1WWkdYSnR1SmhYL3FQ?=
 =?utf-8?B?Z0Z1OFNLSVMvMG9VV1BGOUhHeUFZME8xMEEveklkNjA1YVVzZWRERXhNamZs?=
 =?utf-8?B?bkpxNDdqVzhKbVNUNnFGeXFmZjdoK1RuNVhObXF1cTg0TXFCQ3V4aCtNWTNY?=
 =?utf-8?B?UXNFaE1vZEE0a25teUlSM041UWhmZWdHNEZrY3VkdmJoV28zSDh6citKK2xV?=
 =?utf-8?B?c2lYTFk1dmtXdWZlbkdSR1JzeFZvcHB0UHl6WkIwazhXWEpKTTIrdzlKaU1M?=
 =?utf-8?B?cUVmYXJDdjZKOGdXUkVrQ1VldHlTK3FQM3VBTzkxOUV4OTcva2xsNTJpWkNY?=
 =?utf-8?B?TU0xdjgvTStqVFh5UXNaUlJ5TnA4RVNUQk1MdnNma2UxSk12dlBaWFJCLzVy?=
 =?utf-8?B?UUFqUXp5a1BXWjMzRXJmWmVPcm12a1Z0WHRqQUpwUXhnak83VFBqTXMzM0s3?=
 =?utf-8?B?OFZXdVM4UG1OeDBMb0pQcmpNM2ZWS3NUQklTbTA3NjlzSS9hOUFESUMySFpr?=
 =?utf-8?B?R1orb1dUTXhtN3FUSHVmcFVRR2Nmekh2TFZJQUtnMDNRYjhlMDJlWlhscWQ0?=
 =?utf-8?B?Ky9QR24yZjVKN3ZHaGdKaU1GREd5bml2NnZrZWlIUHBEeEN6K0JmdkVLS1ln?=
 =?utf-8?B?NzZOcFFSRGFjQlFBeXZ0S1ZrNmJrak5OMmhOWXVyOGlWVUZDUk13ai9JSE1x?=
 =?utf-8?B?d2I3ZWQvam1HazBrelp5U2ZVTjVkNUlPMjNrc3orc1dlaVgvdnJUdVRSelMy?=
 =?utf-8?B?MzF1WFJmdURKTnlqVkFJdnpFTGNwUUhzV1lxWDREZFcwNjhiMmZPN3RmZk9U?=
 =?utf-8?B?VFhuME1hSDJZM3R2cHdMaTF2TThXOGZ2NWJJR1gzLzM3OUZVVFgxcE96cjFW?=
 =?utf-8?B?VHh0VzBoMnFCY1RvQndLelJ2aDYrSDJDQkljOE1xcGtHRDQ0R0xKY1VTOEJa?=
 =?utf-8?B?Z3M2dXc4MjdCV1llVDRuWmg4dzdxTk10ZzBaeWRQYXRWTjBmajQvNUZzdGY5?=
 =?utf-8?B?eWVJSFRybjJISmJueVFlSXdFQ3g2N09iZ1E4SXZuSVlDbEh5ZVcwdlE1ZDB3?=
 =?utf-8?B?SSs5UW5IRWEwckNMM3ZDNnFLenk4ZnFjc0lOK0c4c2RlSWw4YUVYWWtUTXBt?=
 =?utf-8?B?Ym8vTjJGOTkxaDNFTFpDZlNONTNiMGxOcTA3WE5VWHMvdTcxbi9xcDVmako4?=
 =?utf-8?B?b3UrL3FFejFNdU9zQ3MrM2NhRXdpWHRSTWNLUFNVZnN3QThpTTlmOWNCN2ZC?=
 =?utf-8?B?cnNtNXhXWkFlL2o5NDMrcVl0OW1tWVhEcld6TDg3dW5tMDRMVHhlS05KSE1x?=
 =?utf-8?B?VVd3K2pTL0ttNndXWFpOc2RxNi9DaThMU1EyejI0aWk0U0dWVzlGWFNXUU1D?=
 =?utf-8?B?amQ1QURpUnM3azNXalR3T2p1RHVQZVVvVDRlckpjRUc4VXA0V3UxMHQwbzRM?=
 =?utf-8?B?c1lLVWc1Rmo5MVJtenpBOG9KRWJ4cmpac0JMWHl5aUgwbnhId1VTdUoyUitw?=
 =?utf-8?B?QXc5VHVLS3lpa2k1RVpQRlNWR1dhRzhLK0JyRzluUGpxL0QrQkVqMUJSRzhp?=
 =?utf-8?B?ZDZYSW1xbUNVdksvRmozYUFkaWpLWDZXSXRETk95TVZjL3I2Uk52N2xuTzRr?=
 =?utf-8?B?SjRMejVzMG53NWlaaGNJR05Ucjg2KzUyWk1mOSs3ZXA1WG1QcEdObFF4L3A3?=
 =?utf-8?B?Umsxc3NpczhFeTVXU0VacWxvUzl3c2NiUzdwUmxDT0h4cnN1OTUzSHBjaG02?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8371e3-22c5-44d9-9a45-08db25b1cd40
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:02:58.8559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rv94KfOSajSx5sb4TEgixabWO57gVJAbPJKUQ9Eay89l3aguuS9uNbtIO1ILiURuelcVtCRe8VVfvN+iEWUuFtGH81VaJ7IkeFNDkovaMpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5340
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 2/15/2023 5:06 AM, Ilpo Järvinen wrote:
> memalign() is obsolete according to its manpage.
> 
> Replace memalign() with posix_memalign() and remove malloc.h include
> that was there for memalign().
> 
> As a pointer is passed into posix_memalign(), initialize *p to NULL
> to silence a warning about the function's return value being used as
> uninitialized (which is not valid anyway because the error is properly
> checked before p is returned).
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
