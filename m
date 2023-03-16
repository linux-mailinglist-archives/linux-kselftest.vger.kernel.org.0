Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F9D6BC217
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 01:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjCPAFr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 20:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjCPAFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 20:05:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFEB56518;
        Wed, 15 Mar 2023 17:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678925111; x=1710461111;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=FecXhaFkGaWj/ka1Ee0pBUXlB1O+iujVmWTpT4txHPs=;
  b=UEuvwxfnGBiUW4WrYFYmAUG5XBrUBHkD6cUYzazyodrm37txrQqGLckk
   5jDZe+bOGVUYRbOHgrWqLUu+iJaG4HDohzhmNW6fXDHl4zVKfbu+GO5vn
   Y3ISXOTkvTGB3o60PcysGYtWZxUzzs8q03pStnYNqg+Dn5m9022fj7ZH7
   RragtYrVb9nTVIM1YqNl5VPo5yMKEzmftu3qG9IcRQeaBRMVGnKbcrdcv
   ffHmoGBbcmulpRaEwvB3sbg/AGmuKrZklKIQvONt4pXmYpZvQIWDjRbbA
   J1da6oQW/1ab93eskYz+UGKcy90w7E/TC9rOGUgn/U9A/7xJDI9/T5OkC
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="340211293"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340211293"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 17:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="629642503"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="629642503"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 15 Mar 2023 17:04:15 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:04:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 17:04:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 17:04:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 17:04:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7xL0JfP0LsODc9MkkDfXEBkYSog0OKKEOGEKYaYByS9fg48ENyjVTeDfxp4HKkgMLGzS4l0YVPfx6FTHkVEmNQ2/tmBtfC6HLtDC3pfgKF+mPAHy9+pNrAII3rPzpQt5pXIUAi7vIDJHaTRsFl0wGD0T9+Tj/ALHoRnuw74uYPprJ+ryMp5guy/1z6vh9LfVjOvVndVx44MkdbW1Ex9yY2jyQUPtXKQo5ZO6co5tZvI3FOw9uJ1UWounl8qMR8c1X98RX/UENysWIbtsupFqoR6rq8X9oWR1XoFjHG+d8i/u+Hxs8nuQ3thnacXnIw4DFvEJDyMVFV3hCohotzX9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eML6h+KFBWi+6UDFCfDt/WmriUg2jy0xZptwg8IVGw=;
 b=XqI6u1GJEV6Iig9OZdelWJM7oEJR19YLEkTfDRqeHnnxK6erRUJ0MUynSTLHyiR8QjsvlvoaKUqI2YTTHmj2Gjd6Nm5P06eSBDkcdtrP7DUXhDFlCSXdHjnHV8uyJo9Knnp5XyCGNr70MIJdUq0cpxWd7vyI7okHeuceBaEn0jHepdzWosOifoGZRLY8x9/J0UtCoQ8t56dAge1zZtqVN/bgSEOKq1J40K35QbwCHTCqsHONrPaicZygx+xYNcn/YC5qJIvGs3Il9j5o9nSIdg6vFA0Syo3hFgTXAEKVNeZSyfYUGqvSZrPlNVcQgYnd1kXxS2jnFWsB6Ry7sWz9Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN9PR11MB5340.namprd11.prod.outlook.com (2603:10b6:408:119::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Thu, 16 Mar
 2023 00:04:13 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6178.029; Thu, 16 Mar
 2023 00:04:13 +0000
Message-ID: <50d0e974-478f-ea60-9b7b-50982697ef96@intel.com>
Date:   Wed, 15 Mar 2023 17:04:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v2 9/9] selftests/resctrl: Correct get_llc_perf() param in
 function comment
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230215130605.31583-1-ilpo.jarvinen@linux.intel.com>
 <20230215130605.31583-10-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230215130605.31583-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|BN9PR11MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: a901d44f-2c0d-49aa-80db-08db25b1f99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INDC3OXoUDiAcaeb9CTz4pLsYM0o2XZMBeiE6NTGLgnagzUTqksktnHoMfioCVwpYwjE+nRkTLSFVn20mnSA01BOh0C0od3kk8Uf9KBRJVbCtnIVoK3VGWGpNFdYfu4MFQCIm3wh0J/HF7OlEi2vD9UISHLNZafNCGmj2iFCWLgUoBkfd6/jzvFYc0WD1gutC1KlKJQALt5urDUB8yt7T0DwqBWJtghDDK9Wn/TQP4Aoct0CZS/HfHENwFRte+mMTmlJ9Ya7T8FxuElSn6333St3HyIG4JQp60QMvoSGAPF/FnF0ByL/YRENa9la7eCk33q5PQZDl2By8G1TQzS7MAIK9WWLXKu9k90t/A1bHF6jdOZzm+CTo/h3mIw/zlIsUOI62ZK4j3Z4LDbMvQEqoTwXco7Qkgaw7WLxF+kK7XsuLNGeS00HH1ks11X5qF8W1svpMVvXqm44TLw3r5TmpsAcKXrj522i1YIjChRD6MdrL1vjye2MkpwEBoiSBI4Hue5G/9RqJ5dFv/mYZi7c/SE+94aCwEQc6IF33KKydVNQEN1D079VX02rRcTYCRW+tVAOU3twITDxQPqFqqcNO8uDtuf9wQb4X7XxhFrMGK7vdx9R/VfWB+NJjfaHyPKcum6gIgb1B/6fe9ubde/NTYEnpG6S0o1mOGAiVXvsobMlkIkWITZwDzGXz10rRZLB1ALjJLNtXC56metjgjNFfsIy61K6zoC5MWDG4eTCBZk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199018)(82960400001)(31686004)(2906002)(5660300002)(4744005)(36756003)(44832011)(186003)(86362001)(110136005)(41300700001)(31696002)(66476007)(66556008)(66946007)(316002)(38100700002)(8676002)(8936002)(66574015)(2616005)(478600001)(53546011)(26005)(6512007)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzh2aXVaWmt6LzJtaVJtU2JQZVRaRERTdTdtYVRpUGlmcy9GOFlIQWViQThY?=
 =?utf-8?B?RkFrWHdEWXlvczNQYmk1d0c1My9NZmJDSWlWYU9tN09GdVlGWUNsVEk3N0Zw?=
 =?utf-8?B?bmxUZWIzendqais5TjI4RGlpMDhIcVZzdjNmS0JpYW95YzdPVDVZN2NYQnQx?=
 =?utf-8?B?SjFYbk9EaGo2Z1dvVm1Ca09xSVRXRUFCV0NJMXpLamVqMDN0Mm1aWjZlbG1s?=
 =?utf-8?B?cUMySmdrQ0VMYjZjc1RaRkttZi90RVlObGw5cUZGbXpQLzF5aG1UY2YybGd2?=
 =?utf-8?B?aUpUeVVLQ3ZrQ2VGRjY4Z0lzOTJDd1QzT3d1K09zVmhqdThwbjlKZGxBNTln?=
 =?utf-8?B?U3pEMjlBTUlDWWQ5TmNDZ0JCS2gyMzRnYy8wZ3k1Sno3Wm9GZ1d1ck03a1J4?=
 =?utf-8?B?Wm10ZTcvb0ZxdThPRWtFa3BDZUhOaE5FRDhFOXBvbEQwbWM5ZGlXQWhNQ3NX?=
 =?utf-8?B?bVNxZUhMa1pyOWhrK0xjY1cxa0NjN2l3enR3cGJ1d2xBMUNFZmszd21nU0Zx?=
 =?utf-8?B?NXoxMStOS095WnhrcUJ1NFNDbXNjNVBuWmxiN0tCdEsyV3liVkJiSmdXaHZu?=
 =?utf-8?B?aUlLZHBNWFM0bDVCUytXS2Z1UDliK0JpYmF4emJQcDkyWWRMSzNjU21zMG9W?=
 =?utf-8?B?UmxkR2lHWW1VZEp6QkU2WnQxMFc0eUppZ041ZFRKN3FubDJORDR1WlFhNkE2?=
 =?utf-8?B?SzJxeDFEdUVGeklIODkrVjY4K1kzWkE0VTNEZDRIaVlvN0NHTWNudTRQd3ly?=
 =?utf-8?B?TmU0TWFDUExQZHFkVjByMkNSS1RieitPQytuWTBaMlJtNlk0MmEyRzAwci9D?=
 =?utf-8?B?UGNGVEtOeC8wTUdqUTJ0K0RXNW5rVWhnTU44NWhpcHdWU3Q4YnVxdnVvSWVH?=
 =?utf-8?B?cWtZRFc1UE4raEtpN2tuektWc294dU1VUmo1TkxRMVFsTTlXblZPblZyalNH?=
 =?utf-8?B?cnozc1E5TGJPRmo5UjBKQ2UxNkdGbkE2MU5FM2dMenhaZHVQRVNHQm1Sd2kx?=
 =?utf-8?B?eTdaTUllZXJLZ1BWR1dzaithaWFyV3ZrMytIS1l4Ri80WjVibGpYNGRsR1RD?=
 =?utf-8?B?eUo3NDhOTFo5RTdhZDA3SUFYTk1NZnlhWmowTnllOTVEYTlBbFRITUxXVzBh?=
 =?utf-8?B?U2xJU0ZwK2pSWUZtblZMblkzOHFYamVxZExncnl4WEs5c2N4cU9qOUx2RzVy?=
 =?utf-8?B?M2UrbFZES3JCVlJqbVlTcWhGazAvZ25FWFN5L0xMY0FYSzFZVy9UWWZtdGtU?=
 =?utf-8?B?SXFSd2NkQjAvTU5Vc0dtMVhXcjhqcENFTnkzMmM2aXpTNVdYRFpTQUYrSTFx?=
 =?utf-8?B?RjQzS1NRNytPNGZpM0VsY3IzRmovVjd1U0k5bmc2Z0V5LzYzMDFFQUVDd2JB?=
 =?utf-8?B?Y251SjdoamlxYjdDTC9ITmV4aURGQ2FFOFI2VlV4M0RXSmV6d3FPT1lrcDZt?=
 =?utf-8?B?WEZtOHh4NVlreDVHY1NJZ1EveU9pMXhYMVJnOWo3WlNacHRvK0pFNWM4NldE?=
 =?utf-8?B?ZUZUK3RuQy9uaU1HcUYvMkh5N3djMmV3OUc2NEhZYVBIL0FPdWdxUVh1MDBr?=
 =?utf-8?B?RlVLWlc0ZjV4WUF2Z0hZWHhlMk12MmxFU1JIdlNsME55QndYanBJbVZNOVBu?=
 =?utf-8?B?eXd3bHdzOVJPdXpDOWlZWElCMFdXK2t3QlZlV1VuTUd6MTRLTkU2Y2NMekdp?=
 =?utf-8?B?WS8zN2tzdGRCVW1EY1Q0ZDRRQzNQc0xLejlXZmhnME4wRTRzTVBwdVkwTWVs?=
 =?utf-8?B?L0Vzc3FPdjhvM2VRSCtVVXU3YXJUZEpYVnBjaVFqMFBFUGxac2Mrc0FDUS9V?=
 =?utf-8?B?SU5hVDFZc0dpQ0RIWGdBbTEvV3UySktDd3QvMW1pVlZCMmtmYTVVcVRHMWNY?=
 =?utf-8?B?UGI5WkpZb29UK1ZUanpMc0hZRFM2TGdEblFNa3BHMkx6OVZ2THZkL1dnNWto?=
 =?utf-8?B?S1hYTDFINWpULzNEeFByNERFU05vbkluRDRlcFQ1T3UwU3hWVVdDRDNQSGl4?=
 =?utf-8?B?SmprOWZySnNuM3NPdlc2TmJqODgxNVBtK0k0WENvSDY5NkJsVEluQXVlVTJX?=
 =?utf-8?B?bzFETE9sRk9McUk1NXEreXE2Sm93Z2lvTmxOMDRxR0kwTTZaWWVWNXdGZWJm?=
 =?utf-8?B?TlBkd2xRYWVkMEkrSDRzKzFpcDNRWTNkNEhmSmJBcUQxZGpVdC9EV051Qi81?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a901d44f-2c0d-49aa-80db-08db25b1f99b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:04:13.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CF+y/f+N1IHxEQ2Hfduw0TbK6B52MghCxY6/CrTDa7lm+SqljVb7JBFW3+RjLuX1tcc23EmMTSwA3FPHgMulwoaPMFaMjskekV0BqmLSNI4=
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
> get_llc_perf() function comment refers to cpu_no parameter that does
> not exist.
> 
> Correct get_llc_perf() the comment to document llc_perf_miss instead.

"Correct the get_llc_perf() comment"? This is so minor and I do not think
a reason to resubmit whole series.

> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Thank you

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
