Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0027BEA32
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Oct 2023 20:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377155AbjJIS5W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377392AbjJIS5V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 14:57:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF3FAC;
        Mon,  9 Oct 2023 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696877838; x=1728413838;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2WNC5ljaXrH98IasGiOFo1FLINfqNsmxxx3yNgW616Y=;
  b=ho/CbgcLQpRPm7p4QTuZoSvgxlSZxovpfO969NH1xMzB5Iz3188aZcBt
   txUTliehgQ/MxkRxOJg6LT/BaavmKw2sYoPizLUfWFOgdOYRn8tE/94UL
   uzDhq4wm6kK93KUpXjZf8tI/zHG2VtfsDUXzFCfcxPuy+ZtKIT7MKFrW7
   t+9UP18Oia8Uz08cnCzx/vBxRfuFHQtv38wqtbr+2H4pzAfCiDu+IsvBY
   qLge/v3MqiN2auVP0rzcE8B55omHtYkOB27bMwF1hInxFVhNmQb423X7G
   OwWCf7mMKAGAfOYDjurKYidKDsqa9giS0p4dRKJ+csX91EoxVuSylfIlq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="448416836"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="448416836"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 11:57:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="876914452"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="876914452"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 11:55:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 11:55:26 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 11:55:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 11:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFtuFctr6+q7iI0Sx/qlPbVtio9EiYeKqjj0uAusFQ4ou4c+V3V5xetiUPq7AZhQN+DAR3kCYva1AmLjlO4/EJTZ0L/ysNcBGatwSCI8fQQRA8C0S9IAF8rVJEGty26BXpm+85tMBNu+GaIf7hXoqlq4ShG2lFH0w/HhRmzLLApmFzpgU+4fg/H8CRt5BU8a/9et+vc7CCTMN1VaePNjMjnef/iYFTp5l7nca20Ja76e9nTsDBIQ/v0zi45EC+M3+GyekYkgdPdsSIUHKPKxAnAO6e+qfaAlscm7XO3LB6jbhjrL6UGWyQrj+TrLgoOUivvOtQl69iHDfch3KczhXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2MI9us39JbEe9nbv6DuYRq7UHyFXZtOOtzJxtARxL8=;
 b=DQDDyvAjTRwgs8ehBr7VRMPHvjZH4FO3/xiPkGU0PlZAyO7x3O/UgbzH6bLpdTN6RezM6citK7WuxSu1f/CtgvHpWzOFyhmpAgc08rnbdrFDO0ofruwCXd5MWH3w3WnDN0ItEaaHJD6loTfFaLr6CnOsJjUO+ARw0NPY7eDHcBeBv9I8e1R3vKWr+mmUdfCMIQ6t9rvp73IVQc9ysjA+mLZA6MOHeFD5zsdP6WB7JPSu7/dRe3i9JeqxI52Khpw+hRibYNYgEic8FBrkLOqmOUttS32gxZL40rTafbgC/gtZNh1wv3qQdPhtsoLi3+SvpFudnYa2MOJoKExVvd3dyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 18:55:19 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 18:55:18 +0000
Message-ID: <822a4716-4079-44d5-81d9-83c7e9bef610@intel.com>
Date:   Mon, 9 Oct 2023 11:55:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests/resctrl: Fix schemata write error check
Content-Language: en-US
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
CC:     <ilpo.jarvinen@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <cover.1696848653.git.maciej.wieczor-retman@intel.com>
 <ef13c2395db0a688ed84f4b535b308bb6f7b71c7.1696848653.git.maciej.wieczor-retman@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ef13c2395db0a688ed84f4b535b308bb6f7b71c7.1696848653.git.maciej.wieczor-retman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:303:b8::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e0741a-5295-44ad-6ef4-08dbc8f947a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9oPNkopRzTW28MNm1HGGDrt37fiDAjMsuWZVUq9K80Al10WOkM2EmMZuS2ZF8YMsNZJAxDL0i2jgsG7FDy6ZSbV5Ol5UEWGwbH3zoow8/G3yIhvPIfc7m87C3xq7d5FQZg7/djx7fvgnlwNc2ULmMiXNBmF1x/LrT/7yuZuxjRxv/Rp7lZqATHXNwQiftq2rxBgWHkbiVTrjbNYWOxEFLd+FNfBbhxcbioAmneIvMHsU4AHHPQG78NLF7VfGY4TkGycOLNBBJ2IvLlyYN3f7E3HFsUy6KN1ZbSFYPtdatnb4wXQgeF148y326+T+1RNOqtg5krIG0JHPoQ6D/aScNUeEn9pHngjov/gDeKoiWoO+UGGzSyZa05BZXA1rA/G4IwZe1M4sDhmscVYDXvY+pC2ConUUC0q9zupM1H2CKD3jblmwnV/lGmBrYcYIaDP8GdBw6RhAzVuzh1NEEOMwfLd6JAmMaylJMXq3uiO9eRrkEJb9xbbpoGBERlewv/fnl96kaZCNMpZ2g4EzSTJr0Jdi/shPP7WLqQzb8tDrPfVkPd3eIXYol1gNoehZJQ2QnPlTFrPhCcHQ97dOstDD1IaoG0/f04jtrmlIUKTg1saCE8CLipSjiTOe7Hi1yr0f8XioFtfXuIQKFWEAoeWNKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(38100700002)(86362001)(82960400001)(36756003)(31686004)(6512007)(2906002)(44832011)(478600001)(6486002)(41300700001)(53546011)(8936002)(5660300002)(4326008)(6506007)(8676002)(83380400001)(2616005)(66946007)(66476007)(66556008)(110136005)(316002)(26005)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFVYZlE0QysxbTV6Q09TVk90U3ZxVVNGNnhIQzBOM2hSaXA1YXY0WEE2Z0pE?=
 =?utf-8?B?OEFNWlJVSlRPOERYbGdvMGRVVklMdWlsM1R6aVV0djRvMFBrRkRTbWd2Mjh1?=
 =?utf-8?B?a21ZRHJFRjdWK0tFU005b1ZtL1pCRWsxQjdBYjNaU1ZDeUJIZjNZTGFqakRr?=
 =?utf-8?B?SGJlZkVyTDBKc1ZRSGg5SG9kRkptUFF0N3U0aUlpTEdrdndiU1pwWGhjVG9q?=
 =?utf-8?B?NlF0aSt5OGY3WHoxdXlBL1B0UmU4VXNuTGdQRGVKZitQcVQycmsrdzhWNjRR?=
 =?utf-8?B?ODlTN3J3a1Uyam1JYnBFNDVMRnBwRjNXZFhTNE5XYXNXK2Z6NWw3Z0xUbGRU?=
 =?utf-8?B?d0VQckhKS24vZUJzcUZBZzlSNnlaaUUxbHptdjRrZnBHMFdSU3hQWlFiclNM?=
 =?utf-8?B?MDhiMU5kRkZqc3luTEQ5blQwWU1CVkZaQlhYVVRpS01tbWV3NnpVV1hlSDAw?=
 =?utf-8?B?SFBXSnYvaVN5eWQ4MExrYVJBNDBOdXNBOVVCeUN5Mnh5K2FTZE5DaXU1NE5D?=
 =?utf-8?B?aEJZN2NMTWxHYUdiQ0hRVFM2ZnFEYTdGNG1ud0h4bngraTUxSnA5Nlp6d0p4?=
 =?utf-8?B?bU1DankweElHNlhuYkxLcHZvOHVGM0NYa1VtRVhjcDlaYW9ZOTk2Q2E2Smg2?=
 =?utf-8?B?a0g5bzdJR05uU3doZzFKUE5xMjFZRC8raUxqZThyRGNxRkNsWmwzWVB5ZzhH?=
 =?utf-8?B?SlNXdDBBSDRiaTJHaHpBY0E2c2dPbjIvcTllQ3hjTTFJVUF2aS9MbnZwQjFN?=
 =?utf-8?B?NjI2bmVFaWRTd2hUYUlnc0xxOTZ2SCtYWjVtUGlwVGIzZXFEL1d5SGM4eFFj?=
 =?utf-8?B?MVhHbXFvRkhIYkxkRXBsUVY0YXo4THRUU2EwcDA4TEZwM2lYY0E1WnluZ0tp?=
 =?utf-8?B?N2FYYnZnczdqZFpVV016dVEyWC9PNkE3SG0xMUxSRTNiNUFENk9DcC9rd1dr?=
 =?utf-8?B?dW8reWRsbFI3UFA4amZieVRqamF4VUlrbXNjYUhwUWxqSEZUUU9jMmtJS1FS?=
 =?utf-8?B?Q3A5SHVmMCtKNjVaMURsZmE2R2dmNkhrTGNZMUpybTdRN1dKL0dQTXMvUjlQ?=
 =?utf-8?B?NnU2bjNqTjFhQU4zeitTdFJtRStycHp3bURzemJqMTIrMTEzRXdrWVQrWjlC?=
 =?utf-8?B?QzYvVTloRC92R3k4aDd6MkJEOElqNDZyN0xtL3Vqd2IxQVAvekZUMVNOanpw?=
 =?utf-8?B?YncyODNLcUlrS3p4Q0pVQTV0UHVwaDNQazJHWFM4dDBPU3NuUmQ1LzlxSlZW?=
 =?utf-8?B?aklTcysrcWMvd1NZajU1a1R5Vi9sRStXZUNhbHpJa3NGUGFnTDJ0eUtmNmlO?=
 =?utf-8?B?cEZWRER3SEl2dERMcktPUTltSGVJVVdMYVlOSTVGUFZveFgyS3hXbVdMR29M?=
 =?utf-8?B?WHJWSTdzbWd2UXU2U0RYT3U2L2NVdHRnRnFUU0dzbDhMQkpkbkgxc09MNmQ5?=
 =?utf-8?B?U3BERW00RlNGd2JOSDZYbkZkSEhyRkFqNWZBcjJaOWQwUWE1cmR1SHhFaElY?=
 =?utf-8?B?dm81RlpXSzhwNlNrT3E3aGdUQkVpOXhmQlZwY004Z1I3Ync0b2ZkTVVYQ0hK?=
 =?utf-8?B?WEpka0Q3NE9heEliQ1NEUWg2Q2MwSGExWlhGc2xQM1AzalN3OWV3aVcxN0N4?=
 =?utf-8?B?Z082OWN3NTZUMWMxeU0vOVdZdXZ1WEtZRnYyTEU2emlzRUpBK1pZanN1Q3BL?=
 =?utf-8?B?bTBweUo0U1FuM25rODA1SVMydE42dWtpUDJ5U1Avem11RlNvbm1vdXQ1MDBX?=
 =?utf-8?B?MlRSb0hqdzJEc3NlR2MyM1B0S0lsTFEwSWF0NDR0WkNoZXhJWUtNVFdkK1pn?=
 =?utf-8?B?d2RmdS9PQTRNdDlMSG52RzYwZU95Z1YzRU5MSmxsa2duMGRCTHV2WEhmSG0z?=
 =?utf-8?B?b3M1bkl2Vm1VQjZpelUyVjJvMFlSWjYxVC9ReEsvMStQcEFReG1QSFVyTUw5?=
 =?utf-8?B?NlFRUmtEWllncFB1RkM3a25XQ1ZnNUhsUFZ1YU5rb1phNGc0MmJOWHNDbVg1?=
 =?utf-8?B?QmdNZDY2QURtaHVlV0xBSnF5RFhEMkVyeDEyOGZFMCsxb1RCZGRMU3ZVM2ZN?=
 =?utf-8?B?WWJIWVlPQ1dubE9ML0YvTGtGeUlpdDJUSlNOYUppamhORXZ6RSt2UHl5am5L?=
 =?utf-8?B?VVdveHhTWFczSDRFZ2xqaHgvdnltaS9STy80L1M5TFc4bEx2bkFBYzZSZ3lh?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e0741a-5295-44ad-6ef4-08dbc8f947a8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:55:18.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYCjP/dbhpg2akfR0VPZwT5BCqrEMgznRL2TsJfkFPr27HIDwHVo7EfCUWmwbFfJO/TJny/MNUu19So1HHFJ/8hNJDvuyq+T6ALVolStL0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Maciej,

On 10/9/2023 3:57 AM, Maciej Wieczor-Retman wrote:
> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to constraints defined by what a particular CPU supports.
> Some example of constraints are max length or having contiguous bits.
> The driver should properly return errors when any rule concerning
> bitmask format is broken.
> 
> Resctrl FS returns error codes from fprintf() only when fclose() is
> called. Current error checking scheme allows invalid bitmasks to be
> written into schemata file and the selftest doesn't notice because the
> fclose() error code isn't checked.
> 
> Substitute fopen(), flose() and fprintf() with open(), close() and
> write() to avoid error code buffering between fprintf() and fclose().
> 
> Remove newline character from the schema string after writing it to
> the schemata file so it prints correctly before function return.
> 
> Pass the string generated with strerror() to the "reason" buffer so
> the error message is more verbose. Extend "reason" buffer so it can hold
> longer messages.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> Changelog v6:
> - Align schema_len error checking with typical snprintf format.
>   (Reinette)
> - Initialize schema string for early return eventuality. (Reinette)
> 
> Changelog v5:
> - Add Ilpo's reviewed-by tag.
> - Fix wrong open() error checking. (Reinette)
> - Add error checking to schema_len variable.
> 
> Changelog v4:
> - Unify error checking between open() and write(). (Reinette)
> - Add fcntl.h for glibc backward compatiblitiy. (Reinette)
> 
> Changelog v3:
> - Rename fp to fd. (Ilpo)
> - Remove strlen, strcspn and just use the snprintf value instead. (Ilpo)
> 
> Changelog v2:
> - Rewrite patch message.
> - Double "reason" buffer size to fit longer error explanation.
> - Redo file interactions with syscalls instead of stdio functions.
> 
>  tools/testing/selftests/resctrl/resctrlfs.c | 36 +++++++++++++--------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 3a8111362d26..648f9ec8b355 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -8,6 +8,7 @@
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>
>   */
> +#include <fcntl.h>
>  #include <limits.h>
>  
>  #include "resctrl.h"
> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   */
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  {
> -	char controlgroup[1024], schema[1024], reason[64];
> -	int resource_id, ret = 0;
> -	FILE *fp;
> +	char controlgroup[1024], reason[128], schema[1024] = {};
> +	int resource_id, fd, schema_len = -1, ret = 0;
>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
> @@ -520,27 +520,37 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "L3:", resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "MB:", resource_id, '=', schemata);
> +	if (schema_len < 0 || schema_len >= sizeof(schema)) {
> +		snprintf(reason, sizeof(reason),
> +			 "snprintf() failed with return value : %d", schema_len);
> +		ret = -1;
> +		goto out;
> +	}
>  
> -	fp = fopen(controlgroup, "w");
> -	if (!fp) {
> -		sprintf(reason, "Failed to open control group");
> +	fd = open(controlgroup, O_WRONLY);
> +	if (fd < 0) {
> +		snprintf(reason, sizeof(reason),
> +			 "open() failed : %s", strerror(errno));
>  		ret = -1;
>  
>  		goto out;
>  	}
> -
> -	if (fprintf(fp, "%s\n", schema) < 0) {
> -		sprintf(reason, "Failed to write schemata in control group");
> -		fclose(fp);
> +	if (write(fd, schema, schema_len) < 0) {
> +		snprintf(reason, sizeof(reason),
> +			 "write() failed : %s", strerror(errno));
> +		close(fd);
>  		ret = -1;
>  
>  		goto out;
>  	}
> -	fclose(fp);
> +	close(fd);
> +	schema[schema_len - 1] = 0;
>  
>  out:
>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",


As changelog states, the newline is removed from schema to
ensure it is printed correctly. Note that this is not done when an
error is encountered during open() or write() so when an error is
encountered in these places then the print does not look as intended.

I think a new goto label inserted just before the newline removal
should be sufficient, with the open() and write() error paths jumping
to it.

With that addressed:

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
