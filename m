Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E887CBE10
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjJQItz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQIty (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 04:49:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F7BB0;
        Tue, 17 Oct 2023 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697532593; x=1729068593;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=H4OcJHGJ7Jv7R1WLvr4fX2JQSpH/4kTd9KfkKHBL3rQ=;
  b=Cz7551+CZ0CCISd7vo362s+lHhMlkwmUfeB/8nGcBPkMn67fe1Tucpfb
   f6Z40FIVN4n+w6oeine4phFiZvoIRLpA7plwgGQXlZ7EfTlS5wFUa9XSG
   eEJzlss0Vr5AriQeojJYpb8lFPOrK+6OD/llB7544MZnfgmlk2b5hpuQl
   dKP0UHz7DZP2P1hB7LmcM4sIFegsE5SbhX3NA5iFQ+qaOijVXtcPumPi8
   S1b7put5Ch0A/kFXhtNY3Hyb25jgUDSIz1VFAU4iu8z/R6AM8b/tYg4ub
   4D26JNRcR/NUHmQqMP1UWw4rOj+ijTDLzderFTU2WjNsbj8geYkFbWzCG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="385571933"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="385571933"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 01:49:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="791168170"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="791168170"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 01:49:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:49:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 01:49:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 01:49:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 01:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv4b57B/SK633xCJVuAudRfpAiqwN8AH5FKBDJ5CrSBxyWXDOgr/EyR+F2gSRgU2jNaA5L4y0BJICdWODXzoKVkwqTVSLcNibKLcMsz0P9tlqL2QgUwRPRvcY2YIYt34qj4oV0KxLIx26Dk8GZtK7/wmSsA0W/7djbBqMAcHa4X826F4WJ9itFOPGsi5x2cMm+Sg03cLqwcsccqSbtie+DCcrJk7W1yelAH64Gp3AyjNjpwWrXIgLSolJ+guxkTfdxWlm4+QLPLToEU6aiI4V6QriOK0V1R46gdFTRGR4gI34oRy6TXnp7Igl3hm6/jLY8o73kYax4r0fpmvsb+dsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zU4Ql0Ggf3UQoMmqpLpoxhTFD53+e7nSMI02AlgUDxE=;
 b=ZyR3VuaKhBpEWM7D0hnHedMZ+JmGUYU+rQYterwi3x6jvsZUnvgdvxRddoRJpVuEQ8L87kI6kxkGZJdPc2UAPeJfqphz9U28ZdFGijB5yLAwipzqhVwZqBefgVD+KNf86EQ7V4fRISAEPH7Gk8eLNfazm5/vnCxTVXw4MnHIgMZsi2V9Xrf28vIOJhhXDsAVZLG6GRatdlunV3959BTlCxEthHMBRKIiaiM5Yp1f4pyMYGF/91wRrwJ8p4gpNE+OR4JzQSSha5inQP1kOXY1B8qJMKvttX2pRmuvwdfu2EuLgOiY+3ueCcKeYeU6kVCeHGoJbuNK8fc6i7TpMXCocA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA3PR11MB7584.namprd11.prod.outlook.com (2603:10b6:806:305::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 08:49:22 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:49:22 +0000
Message-ID: <2a86074f-94a9-667d-6e94-c582d49b7588@intel.com>
Date:   Tue, 17 Oct 2023 16:51:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com> <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
 <20231016115407.GO3952@nvidia.com> <ZS1+VMEo+0bCecui@Asurada-Nvidia>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZS1+VMEo+0bCecui@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU1PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:802:19::25) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA3PR11MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 73420bc4-5803-46ea-4dd2-08dbceedf483
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzZXjCAt/ZZ1FrRrca7045yPYPS7k5kkK+5XFhWQLynXdoNsuFg3sebxOWo0BxANYQ8HvPM6Tby+6fKOamgQldC+NqjvMII7JI86q97IrwVvC4JdcUJniNoB36YqobAMkJ3/S/LGET7hmVH67/mmtFrs2QczE4W8ostVcMutfdQ8JJ4xyKdSo1KyR8UtOgwPdS/IKnEJijKMUBd5pTQ6P49dKGfMwpaqJAFP201g3A5ygQeo7CjsATtMrCVKYqMnTwewhvI8BquIbOFXR1im6YlljckN2+6bcQ1ZA9mbu0Oq+OjOLU7ZFPv4+I0fKJjOdvvmkYhy0s4CRtOAaN9rYOLVoAVqy3HH+LtgDBQx29XWfgM+ehXBdmw37adwzrOwMQXvl/ID5LA43tX+nzsVUFsGykl+8aWqcgDhB+Q8eIs3slcHQUyJAtvTFE6qSFnUDRYMuGvT4eAviE9rQOahDY9SwKHQ31ue2kCYgHH/xwESPF9TkIlCnaH3Dmz86avG6N27xNgg+h885gCgMQEmA3+KixTPv+SwanjOE0iy3UUyLszdQ1EEDihlFWU3BT1b7rPK5z2XVkGLZCN0MWvPV3QaT5rtwMO8YriL8TRBaW7hB2PZ1R4p8ioYkjP0UrPieh/UBZvh9T29UrL04sVHJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(66556008)(66476007)(66946007)(316002)(26005)(110136005)(6666004)(478600001)(6506007)(82960400001)(6486002)(6512007)(53546011)(5660300002)(41300700001)(86362001)(7416002)(31696002)(2906002)(83380400001)(4326008)(8676002)(8936002)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1pNUFdkN2N4dThnYmRqVW5HbUV2Vk1CT1IwT2xQWHQ1cngzQy95Q1pQSXZR?=
 =?utf-8?B?RWV4UDQ0eUFNRis1NnB1OG9iMHNwRUFlRmtPTHd4QkNsbU56czhIVlRlVkRV?=
 =?utf-8?B?SUlyams2eDFKZ0cwaWZtaGVwN3VHdTdUNUV6azNqVno5VmRsenV1Z1hzUDhE?=
 =?utf-8?B?RkRpbE4yR3J3dmpvbmI5dThLYUlVYlRXOWU2U3ZyMXRRbzNpTXVIaVo4d01u?=
 =?utf-8?B?alJtMUZUaWQ5K2N5VlN2VkY4MGZpaUR0VDZ3ekZMbHh4R3NlclRNcHkrTnBT?=
 =?utf-8?B?SmxLZkdrSENiMi9SY3NJT2NLa1NHMnpZTDlvMWEwaGZjbmd5VW9GQy9OYVJK?=
 =?utf-8?B?dmRkLzdxUW52V1MwUFp6bEFlRjd4MTdaamhYSTV4VUxUV0RFcll1WWtlQVJx?=
 =?utf-8?B?SjV4WXMvSU1xSTFtVzFYNHQzdjNWMkpyNEYzSHVrRjZyMEVEamw3Z3QwQi9w?=
 =?utf-8?B?NjdQS2tMeEx6dUlDam5va2RjUjk4L0FvQXlCTmFzSlFDTFVYWC9saDIvRlVw?=
 =?utf-8?B?dEhObHk2cU5lOWIveTgzUWUyNnBGd1pyQ2lxVjg2RXFQUVlERVhGZzVMNlo3?=
 =?utf-8?B?MEo3UDFNR0hvU3lkZ3puUG8vNlpkMDEvbVlwbU9jbm9CS0tSUnhtd2piNXBD?=
 =?utf-8?B?T2htUzgvbVZxK2Z6RStQRGxCTytmUVVkY1RxaGkwRWQxRmRCTk9jSWw2K3VZ?=
 =?utf-8?B?bnZOSFBHUytqY0x1d0RwSEZ3cWFHMnBFcjRQdUt2aFo2TlpkU2hFUXRIcXJh?=
 =?utf-8?B?T2s0Sm5iL1YwZWF2TmoxQW5EUzBVUWFNZlZsMjhxWXMzaG1MamVGREp2Wi94?=
 =?utf-8?B?WndBTE8yQWJpMUFiM1hhRWU5N01EaExJUDFheWJMTThMVTg2ang2dzExVUxS?=
 =?utf-8?B?Mm5HYUZSa3dXUTJmVkp3eTZYUTR6cGRZaEVPeC9YSVJKcEJuZUFONDdqYXFt?=
 =?utf-8?B?KzNSK3JkWHR3dC9uTDFYMTlnc2pWL0lvVXUrNUVyRzUrY0ZtTk1Udm9FT3FD?=
 =?utf-8?B?cldQdmpTY2JZcmlhbU5WY2J5YlBPNUxWK3NiQ2xqb2dhRU4wOVVXVSs0eG9a?=
 =?utf-8?B?MzdVWlMwV1dvbktPQTFuVmZsZnNBemw3OHptRmp0elBGNmVwWlhrcUNDS25k?=
 =?utf-8?B?ZkpoZk5IMTJjdTZvTUVob0lQU2J2OXVXT3hmbkEzTnExZk9kQ25WUmJRYVNI?=
 =?utf-8?B?MlVLWlAzbDdVMDh1VXpHTUt2aGY5TnlxeXoxL3JlZHdGYVROeW15Z0V1MXpi?=
 =?utf-8?B?d3FpV3dmc0tuby9PbHRIb3NENCtzTlNZYy9Lbkh4bUU0R2sySTRIVVJyZjl2?=
 =?utf-8?B?MG1Zck1aKzZVa05CdWlIN2E4MzZsSERibW9NbjZLQzBGcFVhRnpGbFlTMjVj?=
 =?utf-8?B?NFJ0d0hFNUZsR1RVemV5cS9Pc0ZCbmYvYWhpOVJwOEFqL1pJb1dZKy83dG5X?=
 =?utf-8?B?Ylg3U0tOeWV6bGlYRlFlYlB6dUV5cU96OTJlbUxQQ2hocW81Z2RLZnJ2MjRZ?=
 =?utf-8?B?eFhONUhqTkZZaUpZNFVrQkZiTGswOHFhdGp5UUgzSjJVM0VtM0VhVG50ck9L?=
 =?utf-8?B?aW8wZm9sM3MzNFUveVFFaHZNM3JyaENHVnZRZlQ1SmtERjFCOFdqWDk0N0pM?=
 =?utf-8?B?N003MXBnYmxhbER1aWNWS2RuSGtrb0lhc0VxUy9aRWx5NXhmZ2F0UWNrUzRz?=
 =?utf-8?B?UW1ZRzkzWjIxQTFmbkRtem0yRVgwVzl2bEhQM2dsOUZJMEgwa1M2Vk9pSUE2?=
 =?utf-8?B?MFZTSXBxcnNDN2lsdS84VlJBYStsTmNQYVZja1ZBL2lyQzI3UzhyWlhqOUF2?=
 =?utf-8?B?R1Q2emNaRWNwczZacjZhem05V1B4TnQ4RDY5YlNBZHB0MWl0cG1TaUU5WkFO?=
 =?utf-8?B?OVFJMncrRDA4L1UvMGs1UUh2OFFISjJZTDVqYVNaNWR0SjdZTVdkMGlMRlAr?=
 =?utf-8?B?V25zWUkwVjZQWTdETjB2MFQzTm1hWnJZWHZkZjY3TGIyblcvVU5KMFVob2My?=
 =?utf-8?B?S0xGSFJrZ1JRMmMrMGZaeXNQTUZqcHRlNkRBbFJmaTdHWHpONWVwQkNINUJU?=
 =?utf-8?B?eGxLL2JsQWd1bUVsL1dTUFRzZEI5VFMrOWszNWxmU01wbWNCZHc3R29teTZj?=
 =?utf-8?Q?iRYo2u/JD+xym0FTitTzWhWjk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73420bc4-5803-46ea-4dd2-08dbceedf483
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:49:21.1306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J54qmPKuIBMf8ujge1juevUKNisUDc14OJ6B8VI3NVatun539Wn5Hl2112T9OaN2zDbNZNV99tO+pF0HT9Piug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7584
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/17 02:17, Nicolin Chen wrote:
> On Mon, Oct 16, 2023 at 08:54:07AM -0300, Jason Gunthorpe wrote:
>> On Mon, Oct 16, 2023 at 11:28:15AM +0800, Yi Liu wrote:
>>> On 2023/10/14 01:56, Nicolin Chen wrote:
>>>> On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
>>>>> On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
>>>>>
>>>>>> not really. Below the users of the struct iommu_user_data in my current
>>>>>> iommufd_nesting branch. Only the domain_alloc_user op has type as there
>>>>>> can be multiple vendor specific alloc data types. Basically, I'm ok to
>>>>>> make the change you suggested, just not sure if it is good to add type
>>>>>> as it is only needed by one path.
>>>>>
>>>>> I don't think we should ever have an opaque data blob without a type
>>>>> tag..
>>>>
>>>> I can add those "missing" data types, and then a driver will be
>>>> responsible for sanitizing the type along with the data_len.
>>>>
>>>> I notice that the enum iommu_hwpt_data_type in the posted patch
>>>> is confined to the alloc_user uAPI. Perhaps we should share it
>>>> with invalidate too:
>>>
>>> invalidation path does not need a type field today as the data
>>> type is vendor specific, vendor driver should know the data type
>>> when calls in.
>>
>> I'm not keen on that, what if a driver needs another type in the
>> future?  You'd want to make the invalidation data format part of the
>> domain allocation?
> 
> The invalidation data has hwpt_id so it's tied to a hwpt and its
> hwpt->domain. Would it be reasonable to have a different type of
> invalidation data for the same type of hwpt?

this seems like what Jason asks. A type of hwpt can have two kinds
of invalidation data types. Is it really possible?

> With this being asked, I added it for our next version. At this
> moment, it only does a sanity job:
> 
> // API
> __iommu_copy_struct_from_user(void *dst_data,
> 			      const struct iommu_user_data *src_data,
> 			      unsigned int data_type, size_t data_len,
> 			      size_t min_len)
> {
> 	if (src_data->type != data_type)
> 		return -EINVAL;
> 
> // Caller
> 	rc = iommu_copy_struct_from_user(&user_cfg, user_data,
> 					 IOMMU_HWPT_DATA_SELFTEST, iotlb);
> 	if (rc)
> 		return ERR_PTR(rc);
> 
> Thanks
> Nic

-- 
Regards,
Yi Liu
