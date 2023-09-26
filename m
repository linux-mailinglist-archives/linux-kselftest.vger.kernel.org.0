Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F246C7AF6CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 01:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjIZXml (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 19:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbjIZXkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 19:40:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752318E85;
        Tue, 26 Sep 2023 15:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695768825; x=1727304825;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5das79kB8ij/u5uPH8au7ICDmsCPRXGWPqGo67owy0M=;
  b=c9PX01S4AvVNB5Fj1BLgycHwv1QdJrvdPZ3M9IhMFXSutYJjiUxS7IpZ
   GLXXQyhwe/lrjBfphQyhwWoIwpza7vvHQIznSQim4mS9ZTNRsH9U9NAYv
   2TG8zY2D3RXWAkaCBp/2dPYufj7iqqWw17hRLb1d+Tn8b8jMU6MfRxcun
   rBQe6WoTe2kPPPkZWAfwhcqAqG88LfKYXmGmzdpi30ym91LWVVPSDG9Fr
   p5J0elcqiHOJkBz+KLq5GoAbaU7i/vtQB+kQt9EFHnERNvXEwTGcW7Md2
   IDDbUvHmQNhIA3SpE9HIBCDnKI39Mf57db/7ySOp8qvIUbYRo7+fMMtQ3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="384454047"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="384454047"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 14:42:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="778295824"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="778295824"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 14:42:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:42:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 14:42:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 14:42:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 14:42:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaoEIBaTUXBEmGNGvFgR8pUz/JASlF+cGTRqn3QjCeYMXaqZpvdItxqIfsmVLC7rSP+qg5P45diUEFMPh2w+mj5sfo2GyphpAnqPvVF0vst1W6O2QntAMNzbNwI7xJgkpaxctA2dkv9kXHxBjPWni++Hkgvlj4yKGW83+RlvJwt4fjkwpr/yEFw5p/lxuoyXNsgRTWypQ2H+SDP/ELZ7XaW13JMJHmKKpH9URsp1d8SkRVLKwEnbOxBK1KDOVp1znsl1Y5kwg0RPt3u+YQtc28PpCPB/6JYwduZkUUQN51R+qoAJkQzXipnfdXWWicr6Dm4bl9nNMJ7FvsyVKCpBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NK6mpqYaK+sApn3UHB42yAwXbvmaRtrENeaJX+dL3xM=;
 b=gS5t4U9mwbu+BUyuJaD7arsb+TwmXT26JsHSWroVt6kgDLnVH3KJRxLU/cTbvEPnn3KmB/WfFYFE5uhsMRtEnKMvoNH/Q8w8WnGDw7+l+E2tk+OyH3s5gaR4uH5mditrXKE0LqgfCQBqZJvZ8M1MOd2lkVyqjie213eTuG9PkDtTGVpqMfkSQgIm3IcRmogqML7ahVy9eVkrhgGMiZOKFa9NhdJaaUXZYWr07G2tsn6OR7404PA4PGh2v9827tusHtrHqpJqWTNp65Eqljz0vk4gQy3n2UUu7p3Ow7obxG2qBmCNBNBoBvq6ggf6T/YMhS/xQg/lfEXtHWoV9/+EAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Tue, 26 Sep
 2023 21:42:21 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Tue, 26 Sep 2023
 21:42:21 +0000
Message-ID: <37888890-bfba-c3d9-558f-4c6e830669f0@intel.com>
Date:   Tue, 26 Sep 2023 14:41:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/6] selftests/resctrl: Reduce failures due to outliers
 in MBA/MBM tests
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        <linux-kselftest@vger.kernel.org>,
        =?UTF-8?Q?Maciej_Wiecz=c3=b3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        <stable@vger.kernel.org>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
 <20230915154438.82931-7-ilpo.jarvinen@linux.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230915154438.82931-7-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0172.namprd04.prod.outlook.com
 (2603:10b6:303:85::27) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ1PR11MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: fc10650f-455c-495b-bf9a-08dbbed96b83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhZnzCZ/4aGHd2/+IbMBgdR83xakYftceYFDJbr+f3jXk4DIZjhzxPh7r20HvskMfcfR+Xe08Au/TbzIlGjyxUOASmqKU0TcTSsThydoSmFAOfOPwil9hAKhjKksJiFxK0oW2UyLFY70jdwTUSkG/x4tqBRnFOOEnPsDo2/m1lr+cJZNgIONwoPsamC6iEr1pD+vjdNO0cfiFOIHtO4+AxLsATjixxceaRjiktVGPMS8kx1edbK/t5OpyAIj2baHqoECcuqZAUnI6a4YmMGl3e+sjQLboLdM2Wc4lyLHnnf2g0goLAAkZ+LbEvcnG4XSSCK9oJsROvilo5hzZ/tz/oMrWLaTsGfQWSopkQYKljNnvsgu1tOAK45NRLcJ9vxtq/d6N3jZzEH3WDE/ngJzRxGPXrPV8KiOO5nFBquCefVqpISpFTR8vwPhp/dOyGhjZuAM6jiAiaFja4JQtV1tbx5dwXHDFFmBuW1UMLSJe2ytIEjavQCbIH3f1M5k6Lic4IBEgXfU2MlVXTPVgiq53kw6g4h+wjr0FMVzXpnJ3WFOS6GNTdJI316BbTApJ0wOKJtcm5GmcDyQ+77UzUoakECalSnmQqeVCMQq31nK3Pf51hukMSks5zy3nxFd629D8nGKOqol2I+b62k72sZttQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(31686004)(82960400001)(6486002)(6506007)(86362001)(6512007)(53546011)(31696002)(36756003)(66946007)(110136005)(6666004)(8936002)(6636002)(26005)(83380400001)(44832011)(478600001)(66556008)(2616005)(38100700002)(4326008)(8676002)(2906002)(316002)(66476007)(5660300002)(41300700001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZktSQkdxblM1ZGNDNTR6UFBSR3BJbXNRYll3QkFSUnp4UDhWQ081Q0IrT0hN?=
 =?utf-8?B?alZTcDlmNVBVYmwyLzg3cnZpS2U0Y3dKZ2NoblEyZ2N1bmExNm50emFoWHh4?=
 =?utf-8?B?MlVVa1l3SWdUWmdkVkk2czU5aVJnSXhxZzhqQm9URFVpdFRCdmRVR0JEWUU5?=
 =?utf-8?B?akc0cDhickJiL0d3MFVVdGhVN2JwRXg0eHpzemFrbjl5UHFuQ0RvV1ZjYmlB?=
 =?utf-8?B?cG1xRDJmcXNkTmhyTWl3SkpwbFlhSFBxbVZOZG9wbFR5ZGVOcCt1L2hOOXFQ?=
 =?utf-8?B?aGcybnRwZHUvZFdIVkg3OHZYMHgxY1BTanUzUE5rSlp1UHdMZ2h2aXJiblJs?=
 =?utf-8?B?WFBXWGEwQkFtcTY3bXg0ZTh0RWtyK1NoZW4zb1gyNHRCdVJsQUdCZHJnWGgv?=
 =?utf-8?B?c1d1K1ZRVkJRcDZzWkVDN3FQY2djOExFbGtDbnNVUmQvbVRpYy9DUGVZQndJ?=
 =?utf-8?B?aTMwL0tCekNGNy9hVVR4d0o5S0l2MlFlQXFvUVVFTGo4SHZ0ZUFCQnFtZTlF?=
 =?utf-8?B?K0drYlhpQ1hoUjV2VnJES2FzODlEU1kvZlU0bWNDWmVWK3JBV1hpQTc1UlNH?=
 =?utf-8?B?bHJVUU1oMzJqOGtsNm4zQzVlZTllMEFhQW9hM2k1Z2lJaXVvTjFpd0tJelVy?=
 =?utf-8?B?R3QzSUYvcEJFVFhwbEE4a0M1MGJvcEd6RTFlSXpyaFBNVmNRK1ZrOUpkVDV6?=
 =?utf-8?B?eWlPbzBCRGhQNlJoSVNQd1d4Z1RTd0FEa1F1UXZKTE5JcXViTDhtVDNnOVBD?=
 =?utf-8?B?SmpHTWNHRkI3RlFMalQwSlZQaVhmRWZmUnJyT2VVcEJiUkV6TUtEcmFSYStJ?=
 =?utf-8?B?V1lKZVRnYmRSQ2lzWHo3SndyRVJlR2RQcklnbFVhV0doTlhjRWRUalRyM3hY?=
 =?utf-8?B?QWFtZWlGSUI3Z3g5dnRPYW9vdnNVSlhrT0xUVmpMbGpnMWRhTTZUTlhxNFpD?=
 =?utf-8?B?NmZINWluR3FjMEJZU0VTajliQXNiQUsyYVN5YStKMk1rS3B3aFFaYm9TektR?=
 =?utf-8?B?Qk9JUkNiSnZvYTRIZUFFMWZYUUdGOTdBZFArNnU5ZFBDRkg5Z1JTWlpIbTBF?=
 =?utf-8?B?RjdsZ01leHRUMlBKemdxYlpvV3dpejBucDlrVEY0TE1SU3BEV2VTZStucnQw?=
 =?utf-8?B?Z2RGR0JjWWo2NGhycWdrUlpnVzdrbExVc0JjOGFlZ0o2OFlMRnp4R3piWkpQ?=
 =?utf-8?B?T09Id0xLOFFUNW03aks4Wi9WQ21hNkc4WTVnZURGcmdxMDJVQzZqa3I2OUIr?=
 =?utf-8?B?RWJHYVQzZVJCbVQzTUJkdDJEUlRLWGlrOGFrRmJJd2RUMWRBeURKcDMrUmZT?=
 =?utf-8?B?YjRuT1dhNnpGV3RUenRUL1BOL2hjZHNiTHQ5SXdwVmY4c01pNkNDYVFSbVlj?=
 =?utf-8?B?dnNLVGlJRVF4dzJVRGhHSGg2R1JXR25MdEFrWGdWOS9pejgvbExxRERpZlIw?=
 =?utf-8?B?N3RBOXZuR1dwRGdSa0ZaQ1ozQTAvV0JmNjdRS1BwTzlpWWhtcW1KVnFaUS9J?=
 =?utf-8?B?bnBJREtxSzN5eFRvRHYvc080VnpaNWkrNmRHQlViS3BNSUU4VHpwZ0lkckFR?=
 =?utf-8?B?M1kvVWJMZDRlNHZaYnZ5ODdqTnRHcG1xV0tjNVdQRWJ4bmFWYWJrY2dYNE1N?=
 =?utf-8?B?amtYNGFQUWY4dndsNjkySzVkd2p1K1BlM1dNVDJ1V0hXSGVla1RmcTZkUnlZ?=
 =?utf-8?B?STRaNC9McGRjK3JrNXlXRTJ4SXBOdG1wSGF5dmd6VXk2UDhkMkdHY3IwUkc4?=
 =?utf-8?B?WGZmUG9RbVNBZ09QekFIRWkrV3NUZGMxNHJQM3pjbDVXOFY2cUhaTFB2TEZu?=
 =?utf-8?B?UnNNWEQvcE5RaW11bDN0R0svWVF5Z01FVGdOaWxzTHRsV0lXclRSS202UGxJ?=
 =?utf-8?B?VVAydnNRWDVBUmJic2M3RzQvUEw1NWlPcXZoalV5c2IzcFRDcEhzeVQ0aEZo?=
 =?utf-8?B?ZlNLL0Jpd0pMZDRwdkl1Q3FuQzdoSEVHdDVETld4M1lYOW1DWjlUZkN3VHFD?=
 =?utf-8?B?WFpDWmhrK2pBRjNEK3NHY0E1S21XS1loRUtweWhESEkrTVVFVDg5akJEREJX?=
 =?utf-8?B?Nnh0QUpESloyNm5aZUZSUFZkL3pmZ2VMR28zcVpmYjcxdmQxaW0wcjNadTB4?=
 =?utf-8?B?TFE4UFJXRFRPSnI0TnoyTEEvbXlXSzRUMFFNbkNnZmRzMFRiZXpDdGJJY2pz?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc10650f-455c-495b-bf9a-08dbbed96b83
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:42:02.5035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ck8lTLdwDjfdW8kfnM6VMtpdTwiHzSGH2kyxkKbKWA9hhdEEURs1Fx7uMcw2T3+6MIXubR/IVnnEncDx7C+ue6pLEn5a5rXtGQkd9fR2NXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Ilpo,

On 9/15/2023 8:44 AM, Ilpo Järvinen wrote:
> The initial value of 5% chosen for the maximum allowed percentage
> difference between resctrl mbm value and IMC mbm value in commit
> 06bd03a57f8c ("selftests/resctrl: Fix MBA/MBM results reporting
> format") was "randomly chosen value" (as admitted by the changelog).
> 
> When running tests in our lab across a large number platforms, 5%
> difference upper bound for success seems a bit on the low side for the
> MBA and MBM tests. Some platforms produce outliers that are slightly
> above that, typically 6-7%, which leads MBA/MBM test frequently
> failing.
> 
> Replace the "randomly chosen value" with a success bound that is based
> on those measurements across large number of platforms by relaxing the
> MBA/MBM success bound to 8%. The relaxed bound removes the failures due
> the frequent outliers.
> 
> Fixes: 06bd03a57f8c ("selftests/resctrl: Fix MBA/MBM results reporting format")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thank you.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
