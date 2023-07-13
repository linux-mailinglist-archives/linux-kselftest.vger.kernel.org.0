Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FC0752DC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 01:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbjGMXHw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 19:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjGMXHt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 19:07:49 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2869AA;
        Thu, 13 Jul 2023 16:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689289664; x=1720825664;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FE0hbvvhogoszLT0mXeqOCXf0B9GAGaTNgkcVrfeHwI=;
  b=ZAINrMuqXvNDrA2AovD7UUKjWQwB43c5MwG13YGarh024mephrqS4Vea
   a4wGRKz8Hj+NzZQA91IZQ+3ZT9IzPUXmJxYh14DV5riV9paW2idMvWs+t
   QPs1ZsAtKOArVzz1m+bLscxASRtPaTzo+WbwlOl3a3sET8fj3IFWQk+rT
   6VJ8X5upHJOUUbCBAWwQ1VzLWYTyqQHAHqTaK78eGBRsNL/EWl+BQR8yF
   sZE0Nlp5AZe0x2+9S2gMbID7iaNN3iGplaPVWdVg9CcNROc5qQsodRKu9
   RyK9v2iEcu7zUC5OXDfShYBjxpBX+pkhhf7PvKl9N41hzves5rqJJsOXL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="365372703"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="365372703"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 16:06:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="792237203"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="792237203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 13 Jul 2023 16:06:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:06:19 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 16:06:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 16:06:18 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 16:06:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJkBpbMVmGM4liaceLi/XU0mb683Fp7LwMF4YuCCza++o/LCsJCs6fKJtp72I5I27bX2tdDQln53XAd92KpoqunS2Dm5aYfzOMqsy4LvyfPKg7yu0IOeM3PO0/CfC8c/9GEiT2geY1rVDCw+AUd8egR8FzeLryI2jCKEfmrsdX/qVh2h1alxIFu5rSVjG2glhOEaxVEh7RV5S7gq1lsvZHWhhVEAn9GSz3rki30Uxuc9zKlkkdow/cl4iXzN1D+GDJZk4rzgETTFIt/czW9sz+7w3NfJ2Jz6ykKZUHIL/idg/yXsMmycj37jRu2xUAydhy5YzpcHI4vt4LV+nfXhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBQ14bkoD9xcVOBWSfFRDg93wlVW/YbgbSiegSrdRtE=;
 b=deanRVlkeQcgrOq0pQfqqYEoJuzD9XmiKpFc9wNoIyGXLRe1eqiRyoaYAtDlVBSG72OGjMUcUsUudq0qPTV7DM1R6n8RlOy7D6+hr4ReJb3beBvDibMPIlaXAOTspMiCsrQsAL+Ci0OycJ90mc3uo0EW4h7viSjxNZa1k4WuG2iLzAM0lWMv/yzWtD1hn30vJs5Efh3TIURh5Rt5Eq9xwcCxxsWaXeLsY4DygFp7No2mfMslDxeA8OgFnXiWSpxGc3sJ0ecXvy23GCgFRbpwR10NFtB/155qM9eAEiaex44UQAhUsRmhlSl+IYFmOnLkypVe1/YhDZ1Y5TKynurhMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB6474.namprd11.prod.outlook.com (2603:10b6:510:1f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 23:06:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 23:06:16 +0000
Message-ID: <edea8758-78eb-6684-084a-063543f487ad@intel.com>
Date:   Thu, 13 Jul 2023 16:06:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 13/19] selftests/resctrl: Remove unnecessary startptr
 global from fill_buf
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Shaopeng Tan" <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        <linux-kernel@vger.kernel.org>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
 <20230713131932.133258-14-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713131932.133258-14-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB6474:EE_
X-MS-Office365-Filtering-Correlation-Id: b9007645-630f-46ae-d7e3-08db83f5c2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Med7wp5WrVI9c3rc/S0bEWipNH+yB6r3ej4a7pl20knIY043VwaAu3A/7T6aw84LleqNe5LalhEr9+MvSEB4hbHO+MIJTU2xbBEJM0eupAHtLBvSvO/AkHFLVx1cGXDhgqe0vCsZ1POB9VvquHH4ZmK2VuGQZbYVQDhGZKu2hUrRkcW5rtyyar1zxUKdTEerydqBPLsP1JFLw1DLFXEiXETEREpkV2wtkh0Qa0s6ErCKKRZBsFsOncuDFT+Wijn/SS7Xso/FvynN4fnZVS61TMZZs/Jw4lySRKxdKWCOpS1dVw/ZV8PnsNeUKue+gqi8Zb1uCnoI3t1aAD9e4foe35NokzuFCb5hsJuoCfuYOaPsOyyXS5aKNRZdP3r04PERePhmCOox7fZml3PZYBhTuhn6XlUwETRodH1xJ9nsBqh+fQ6U6XuwmWnHFy/oczmy3e+8UtjmfaCmmzemv9GB9/i+l4+mQioZbCyIKbvK0VjopUGTLCgBOXrS5pEQ5CTHJhljuuvYrIpioO+vZi0ukeUseIn0YtrkG+YQK5Yt7doNNaI3aYWD9eW1UK1PizjeuXe8pZsWxunoFjJHMubGlXvD15ulPdugL28mGTgNcNjRMnQiSxwr6as7E6HOG+2B7K6JHjkSijQM8tNd/7RRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199021)(38100700002)(478600001)(82960400001)(31696002)(86362001)(6666004)(6486002)(110136005)(66556008)(66946007)(66476007)(316002)(31686004)(6512007)(41300700001)(186003)(2616005)(2906002)(4744005)(36756003)(8936002)(8676002)(44832011)(26005)(53546011)(5660300002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnNUNDNab0FlRnZPUm1QRGp5TlFYRnJYaDQ4MHpNUENKVy81QTJHY3BXbFJV?=
 =?utf-8?B?VDN0b0RsREZKZ0haOEhyWThHR0FDR051WmxHMm01dVlMVEdJSm1JSFdEN1Bj?=
 =?utf-8?B?RHdCZk9BQkpsTCtuQmtPOWFMRFFxaGh6R3hUL1lBVTFrMXJOVkdpRHgxMTYz?=
 =?utf-8?B?cm5OVkMwcVJOc2pjcFE1aEMvYzFnRytIeHlMQjRJNHU4OTQrK3ZaTzYreGNh?=
 =?utf-8?B?TDJPeDlSVDVFcWtKUHFnNll4WSsyVFJ6ZW5zdjVlR2wzV1pFZnF6VWFhUE9E?=
 =?utf-8?B?dTZMQWF4cm9JQys3eDBzU0YwcFN6TEpxakZhcEt6RkFGWGJwV3ZRd3JYS09p?=
 =?utf-8?B?WDl2Z0d6YldoR0tBRWxrdTFvWkdLT09XZW5ZS3lEcEMzQzllTEtrYjBIVGY0?=
 =?utf-8?B?b1lNbnBTUitQSXh0dDd4WThqQkkzQTFXVmhPMnl6dDFicFg1RDJUYVFBZTBz?=
 =?utf-8?B?QmtDZXJrRlQ2SnlOeTJ4a0dUL2UyL2FqUytlSnIyWVNEa3M0cUFrTk9EenF4?=
 =?utf-8?B?aHZjV2xtS1RFZGtmN2p2VUVpeTE4QmhsOWN1T2NvOHh1QzVHNXB3bFhEZll1?=
 =?utf-8?B?TjNWNmVhRDFLU0xnYk1GQ3BvaWJRQXlxWHFCaUtWUnkySHVCT0FzVEVncDdo?=
 =?utf-8?B?bGZ3MGdGbi83K0JEbmJONlNFdWRKL3VONWpua0xyTEd4NXQyL0pCT0tUeTUw?=
 =?utf-8?B?L2lJQWlCaEtDbDIxS0RMMWRzOXYwYWtlaFRZbTVrOHBmbXlhUGpFY1E2dEl2?=
 =?utf-8?B?VHBYblBaNTZCT1Bpd0hFZXZQd0tjQmVhbGxWUEFZcnp5d3dseG80cUVFN0dG?=
 =?utf-8?B?bVI2TjFoKzIzZlpUalc4Qm1HWjlVTG9paGhrRXdSV2dQM0tiTk55czlNN0NW?=
 =?utf-8?B?VEI0cW5kbmswN1NNamFmeFZHMS9qM05EWFd1OHR6NmJ6MWJodG5nNC9zaHVw?=
 =?utf-8?B?eGFQMUZyMGs3R1NkUjExOWx4eFNscXRsTGMrVlNpY1B6aW1oMTRvRkxLY3Vn?=
 =?utf-8?B?ZDhoT2RHNi9sRUU0cy9PbHJpQ2dxUUtvWjJXTnJueUtZR05NK0JSMmd6QVly?=
 =?utf-8?B?bGNLNGFLaFo5QlhObEFJQUpOYm0vL3QvVEVuRVlIMElDYklKR2lnY2pVSVdv?=
 =?utf-8?B?cXRMZHJXMzhhakJFV24wT1gvcFhLakpDSVJEUWUyYURoUVEyb2t4SDhDa01u?=
 =?utf-8?B?eXVOY3lyZytmUVJxcjZxUFRvaUFReEE3Tm0vbXNCT2ErZlJNQmxjZTY1Y2Y1?=
 =?utf-8?B?aEV3Slp4K1pHVW82czlLRnZZM3hCR1YrV2E0enp6UXF6YVg5SE9TWjZXK1My?=
 =?utf-8?B?L0MwYSszWFg0a0NIcXlqWmlFMFljQWZnNEI4OVk0STZJL21qdFdKbStoVnJE?=
 =?utf-8?B?T2dnSjRSc0VhSkRmNHhlUGpTMjdHUnJ3RGxRWWIxUUdhU3c5T3JZQmowbDht?=
 =?utf-8?B?WXFVbmIvOFZweFFWMWRSaXNQbXk0djIrdDEweFV4TWlubnhzK1ErRUNUdHJS?=
 =?utf-8?B?TnNVUmNyZzVkbzBldEdWYWxRUjNQaDFQbUczdlpzN0xLb09kL0h0VThMNk9C?=
 =?utf-8?B?aVV4U2c1K0RoOHkxeXRVSVFNNGpOOVBpWGVybmpzcXV5VmgxbnBOZFhpeUJM?=
 =?utf-8?B?a2VPYklFbTVMVjVvc0NQZnVFOGh5dUZVYWUrdWEvVC9ZRi8zakl6Y0NlWm9P?=
 =?utf-8?B?TklvdWhibzBiSG95d3BRVlUyMWZrL2lNRHV4NDhNZ2dCaWRyNjI5bmZhOThR?=
 =?utf-8?B?WjNsaGwzNjFMU2dNekF3MFp1WmRYUDdFeWtPT1JEMmlsM3ZEL2RQdVE2Z0s3?=
 =?utf-8?B?RlNWT1JUUlpYODh5T3hBOHpsQjhXRE5WNGhXbTcrOVVSM00vbStQUGtCZjNZ?=
 =?utf-8?B?Z3RXbU1GM29yQzI0Y3ZvMm52YlBLSElyMDJZaWNpTzEycDVjUFI1SUgzcDAv?=
 =?utf-8?B?Q2UwaEhzR25BbVVUU2JlVFdPWVczcVdNWWdWT1o1WnhSTHZ3eUNRckVjeUxO?=
 =?utf-8?B?RS9TRlM1VndzMjZpaVFhV21PbUtwSFJFTWhHVFovZEI3Qkt5RmtPYm9vdDdI?=
 =?utf-8?B?Y3NjbFVLZ0FJWkwzRCtCVmswUVBqNm5JMERzdVRldEREWkVjemRUa2xibzkw?=
 =?utf-8?B?b3VuMGZtVHRneTM4UC9uVU01bnI4UU9kUW5HOEs4UWV0ZTdhUm9kNUtidmsy?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9007645-630f-46ae-d7e3-08db83f5c2bc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 23:06:16.2168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZ77qllsMMaqUODe9NeOUAM42f6E/eYSXBEqbYfQXBMFdbOxm+rF35FkY9L9X8ryzVAF/QuAMylHyY5Dvj9jhQ2p1flbF+Q9R5n9x2vEjUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6474
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 7/13/2023 6:19 AM, Ilpo Järvinen wrote:
> fill_buf stores buffer pointer into global variable startptr that is
> only used in fill_cache().
> 
> Remove startptr as global variable, the local variable in fill_cache()
> is enough to keep the pointer.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
