Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99EF78B153
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 15:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjH1NIC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjH1NH4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 09:07:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615429D;
        Mon, 28 Aug 2023 06:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693228074; x=1724764074;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Ad8inIc7Z5PPPT8xyk9of+FqFudkHGl8b+VoHed6CiM=;
  b=H9QqIUw2sFKx3Tw+NTX7iloG6lrBcbAmxFM+I50nedYlpvdHC0YDeKAs
   E3MBEBE0Wfd4vrvnDBiV5e/rjbcgoJMc9KQgooU90eKJCdeuSJsxFWMxf
   U7BYfV2skafWeIJcyAFm0YLqD9kmula8aCMdq1E6A55zsRiO1WMW3Bvjm
   mCHG7C/4+WYCmEuxALS3UflJqIcDMByuIyO8EePHYbCfn/e0hUgGIAHAy
   1GlM2nPbEWUfdCRnqcSHDsy9ld+COlE2vlTepwOTEOunpQFIcs4kjAF4Q
   1WNyHzdbkbaQypfuFMpjS7BuaK8kKf5PWb4aaeFZUivywYAzs+/MNacO+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="375065434"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="375065434"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 06:07:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="852842118"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="852842118"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2023 06:07:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 06:07:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 06:07:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 06:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krmwoQ61hooMAdC1MQxSKj/JKoS2qyohuRsLgpw9wG4NeJk4wuJkzKIXmXtqNCLOcaZdyEHk8BZk3U5I5ILTXygaVkIUs6g92Vxa7A8AovEYnzjDM07NgJQFXYH+RCzX78do5psGlZ1QE34UtyeS3OGw9s09OZ1vdC1AdWeAjeDpFcKCJGG5UaSbltX2u58I3gu7Px86STJscAUvlynlGUSfESCZhoZcNbZitBAH4x2Jnup8Nn2yQzzlRE8axbjV3gPOp4pZjH4kQ3tEbxC3vBXpeX3dgsZ8D7DP2J2EFEgAvnj+8DhDOtEr5Jz5YCY0slhtpOdfC2tyXaFD7zJ49g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6YD7oCvFmfiAK6/tCC+qMeYXO2/9bMiO6QRR5IZ7xU=;
 b=iQNNoYRTqx0DzjnC0QrPTWnkLP7km4+iO9Ei6C1CQ6Xq4Dsst6QaD+1jEXa9hMoAlz859002YfEu2ioG3BGg9AV5bAtIwLCHjKPnk6MmA84EZkb+YZfW9iX2a9mCl+q3pJSFjYOSf7nxFda54fQiCWxxonYxS0GQeV9BSoxK+S+VfIHg1vomhM7bKW8nwfuZpG2EjQwQ0O+3Vg2LHDeM023uFauROpIr+1CoYNml4MLfc3JGC2k0Cm4VTed62CNTJOh55oel3Adu/jUwYVq39oneerkrpJJ3Mrn3qy+zFTKC09TV8ghwedGGr6eIC4NpE02PX5qjLbo8uuedupvQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 13:07:34 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::8824:ea30:b0ab:f107%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 13:07:33 +0000
Date:   Mon, 28 Aug 2023 15:07:23 +0200
From:   Maciej =?utf-8?Q?Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
CC:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 4/6] selftests/pidfd: Fix ksft print formats
Message-ID: <bis4cb4nawx32ys4aqjytksw4oyhzhocfvarintru4ow2oqsjv@ph73qvhn77gg>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com>
 <ac9c6c136a9e249453f866f56eab175c27f48061.1693216959.git.maciej.wieczor-retman@intel.com>
 <c920ad68-45a7-23dd-9d4c-fac99e1a53c0@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c920ad68-45a7-23dd-9d4c-fac99e1a53c0@linux.intel.com>
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To MN0PR11MB6231.namprd11.prod.outlook.com
 (2603:10b6:208:3c4::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6231:EE_|LV3PR11MB8674:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc08ae9-3ed5-4bd2-b59a-08dba7c7be3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c2E90yPY/ataeJUO/ZayWSaoO9WZwwK6/l/6dJDuIgl/cshC2d2Uia/vLt5YtJfuQc9lYinXj/BNJ/0sEP3F/mwpFtaxka1mA1YphaFQOLeEVSewxBvthtkMDXG0790wmXBGHl/sHu2DevFvogU/ym7hFF83SecKs/Srn6zcai+R027ZGgwix5LVWazM1/lwK6UyfHDWCCjkHA+bYH7rbsa60gLNr3XDQtMOwqRYDd4FGwdAgdbYMniCVn2VawzNfc3RAw4fAnUYL8yl1AVpV4K36N1TnaMGPO+DvH8QhwLfyt/Sk/ruFXFGYM1LZK0q9iGhP8dDcR/Wv838NmGoSm2mAp2en5DVPU/92XxRBN09KO3tKgqALyGNNT1uXMxcnXdCSav5/JzW+5xfnhF2njNnPu1DmNdDr6amfEvaFLopN0RRd+fg3znMH/EgxN25yL+DNEND6IpisXiEK7XvCFbxP+mwXuKqM9dNgk9VeFbW0aoAmjVwUF3bHR87xtBvAJJw8tGRQMgMcomJ83ZeRRVGNAOjFcGw0H4Rvgs/xmss+KYb7GtktPOvJxPHixBE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(186009)(1800799009)(451199024)(6666004)(53546011)(6512007)(6506007)(6486002)(9686003)(2906002)(33716001)(5660300002)(86362001)(38100700002)(4326008)(82960400001)(8676002)(8936002)(66946007)(41300700001)(66556008)(54906003)(66476007)(316002)(6916009)(478600001)(83380400001)(66574015)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akNRNFVvV0dwREduUjkvcWhkMjZoOGJwUTducElNQWhMY3lYbU5WalJiMHJD?=
 =?utf-8?B?NVV6eC9rU29nL1R4b3ErM3ZjOWRxekt4bis4akQ1WnM4dkxGZncxSDJPcU8r?=
 =?utf-8?B?MHc1MHZuQ2xpVG5kekNrc3lydFJlTzhYZ1A1d01CLzZFWmJGdjNLaHhTaFJI?=
 =?utf-8?B?eFlSaWtweEVxb2Y0T0RwWlUxZXJnR3c1MHBUbEx3eTRVNW05Z2pjRFd4bzhW?=
 =?utf-8?B?d2dkQm4xMlJhd2ZHbmtBUER6RDBzVHNGS05XT0orMFhkbC9neXFudWdpeGh4?=
 =?utf-8?B?b2V2V2ppL0FZYStLcUdkWUlIdTMvTTVKUG5HYnFVZkFCazlZTjAxVmM3eW5l?=
 =?utf-8?B?SzQ0T000SFlYTVcyODlVbmxxbzVkaGxLbEV0K2I4a3lPZWNoQkE0T0RaSVN5?=
 =?utf-8?B?ZnpUN3lhZnp4SkRXYSs4UWkzN3NYWWRnYXBTSHZVcUZmWkNQNzhTRURXQjNR?=
 =?utf-8?B?VWNJbjZXU3RYREhKT3VOYi83NzhKQmlNWXhPcE5ucklJNk5oeGFFTXNCdzlx?=
 =?utf-8?B?bEV4d25kVW5wNFV0RCtQbFZ2WW91bkphMVQ1dE5iL01FbEdEV1VaT2pNRkVw?=
 =?utf-8?B?aXJ6a3lMUXVreWhMNVRuZ0V4aHdLbGtCUWIvbUtzWUMwdllJNjVFQ3ZpYnJ5?=
 =?utf-8?B?ZmlNRkJFZVMxU0s2Z0dkNjB1Y1lNWVdMcDFxdDhRMEZLUHBMWnpGb2dpZHRx?=
 =?utf-8?B?ZkNHdkFqSksvMiszUkdvcjhnK2pNUks5ZXBzVnp4b0dqdVJNdnhHVlRCblhH?=
 =?utf-8?B?TW01TmdiNDRHenhGN0MveG1SUFZweFpmbndKN3RUdGNsaU1XcnlPQWZsVlJ4?=
 =?utf-8?B?OE01QWcyS2xoeGJVUGtmMXltR1I0dUhacWFGZFArQmtRakg2Yyt0YzI3RmZn?=
 =?utf-8?B?bWxLVUp5Nm5FM2NmUWZ5WHZXaExoSFhMdWtySTd4ZFVmVWxHK2VXckNWK2xN?=
 =?utf-8?B?N2E0QmJDb01xMUVpZ3RuazJaNEJFUDVUaTcxT2Fja2VmeTEySlB2Z1pCK0ha?=
 =?utf-8?B?K1k3VGdxeG0xOXdxeWZ0ODdLaFRDVmFxc0d3NXMwMkV1eDJ6T2Y0SDlIRHFj?=
 =?utf-8?B?Rmh2RnhvSE50Vk5kWVA3eE9GZ1ZJUXF2ZGRKbC9xOHM1ditWb0F2OWhlTEtW?=
 =?utf-8?B?YTB4QmZESW5QOFZLVTJWeHN1SkRVVU91ZXpNWGt5N1NvOG14M3hTQ3hiT0xp?=
 =?utf-8?B?QzFuR21Nc0RGUGtIUU5xSFMzQ2dETktSdnRVVTBrc1dZZUpFQklBTzVLeFVl?=
 =?utf-8?B?U0F6c3ZEcktYdDhHV01GTmlXanEyVjFQZEo4NFVNbVZuUTNLS3hCRjRWRWNU?=
 =?utf-8?B?ak5LaDRWVytrQStBSGM2N2lteXl1bWdiV1ZFVEF1NERtNlBEODJrbTBPd3Y4?=
 =?utf-8?B?b2dYcUlSeVQ3SERzZFp0a3FlS2h1bytKaGFzT0NZbkRvck9zY0U5MjBaRTg0?=
 =?utf-8?B?ejJxMzdjc2VWdC9oQ1BhazVDN2c4blhEaVNQc1UzTWNLRmQwVWlRd2x0TmR4?=
 =?utf-8?B?WTJjdVNsNUhaV1ZQNG9qZ2lnWTVNcTFMVDN5WGxYVFplQ0dSMzFwc3VFOStX?=
 =?utf-8?B?QVBuQ0lqTzNNZWVrNnBvcFFWM1JuRGQvK3BDRXpnTTQ5d21rS0tNeVBUWmZi?=
 =?utf-8?B?Y3ZuUDErL2xTdFJtdmpydkJmYXUzN1JhbWpXdXlKdEcwNkQ5WGR5N1d5MjBF?=
 =?utf-8?B?bzJqa3NtY2czaDQ0WTZmY0tpQktjeHorUlZTL1VWL3QrRWt3Z21hY1BsTUdV?=
 =?utf-8?B?ODArb2V5VDZKUExKRkgyZCtWMDZYUFFXVFRYZjcvdm53bjRNV2lUc2RMc05V?=
 =?utf-8?B?UWF1cklsOVBvaWlwWStPZ1pSTFhUVm1hdkJtRnBNNk56M2ZuTER4R2JCcHRu?=
 =?utf-8?B?V2ZwV3k3K3FPUVlSRHpzRDlJNzg5VWRWQjAwQ1d5aFpGTk1BY0ZoZjNrOG5o?=
 =?utf-8?B?UnkwYzZDUGVlMDFQQ0VqR1Z5YWJyQlF2ZVB2d0dtVnF2cTVnUU5LWU5hSlVs?=
 =?utf-8?B?WlFqcFlXMnQ3aFFRT1BGaTIwMExaWWFXMVhUdisyazNKRHYrbHRuZUFzcDlw?=
 =?utf-8?B?anpLVGxyajNIZE5SdzM0SUlxakdDZ3puYTAyMDlXQXZ5T1NvVkZpdXN5RnRO?=
 =?utf-8?B?eHlSYmJqblZiZkhERUNUMnlMNHIvMlpBWGtycWZ4VTBkTDlUTTZSQlBBTVlk?=
 =?utf-8?Q?CHCIPyZdpdUCq5Nt/GM3bu0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc08ae9-3ed5-4bd2-b59a-08dba7c7be3e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 13:07:33.7312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFBrXiOK1SbtjaGfDuoHz8QyWRAr24H2MW1EqdkE9gjDMhDOLLsJCNCYRxwaqLGb1iv/DRfg1ZI9HJpCI0U2j8j4SlTM3IKZx1BhEaHMndA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023-08-28 at 14:01:18 +0300, Ilpo Järvinen wrote:
>On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:
>> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
>> ---
>>  tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |  2 +-
>>  tools/testing/selftests/pidfd/pidfd_test.c        | 12 ++++++------
>>  2 files changed, 7 insertions(+), 7 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
>> index 4e86f927880c..01cc37bf611c 100644
>> --- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
>> +++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
>> @@ -62,7 +62,7 @@ static void error_report(struct error *err, const char *test_name)
>>  		break;
>>  
>>  	case PIDFD_PASS:
>> -		ksft_test_result_pass("%s test: Passed\n");
>> +		ksft_test_result_pass("%s test: Passed\n", test_name);
>
>Missing test_name leads to crash so this looks a Fixes: class thing for
>me but you didn't provide one.

Thanks, I'll add this tag.

In my case it just gives a warning but compiles anyway:

pidfd_fdinfo_test.c: In function ‘error_report’:
pidfd_fdinfo_test.c:65:41: warning: format ‘%s’ expects a matching ‘char *’ argument [-Wformat=]
   65 |                 ksft_test_result_pass("%s test: Passed\n");
      |                                        ~^
      |                                         |
      |                                         char *

Could I be missing some strict config?

-- 
Kind regards
Maciej Wieczór-Retman
