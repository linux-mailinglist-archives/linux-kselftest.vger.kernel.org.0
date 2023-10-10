Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078937BF18F
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 05:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442068AbjJJDck (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 23:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442064AbjJJDci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 23:32:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5908AF;
        Mon,  9 Oct 2023 20:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696908757; x=1728444757;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SQvhEoJCLLDkIPDzGdH7qnCsT860DApMSOR2FSkhQtM=;
  b=RjsHEf5wZrdvnaXpEqCYkUyEG4ixDaCmGn/6GOAvH3hG6s4LO10Hb1Nj
   YLzosMQTHmyaTZDoOqEarQrl5K/GzoFHTA9HdvbLnj15LAcmeghg9Q88i
   E3bP31bwjWlVTEp47KPwWyjtbqmPhWUOwx1hwRtlqMNfJl+zBSkckJ+5B
   nGOC8ZRSrCX5xFi731+sHlGsHG87cI1QiZRhZdCGzcr3ZRYpS4kVcX/A1
   TcF1/BURKqDQmih7aZBySiJfopifUDBdnme9D9qawDK4xQpVIZaYMp6A3
   3EfrzdW5dEsi0RDLlCX3gffGvZyfbQtObW0K2eyVvnIb3Wc17AYrCpjb+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="5858540"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="5858540"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:31:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084596445"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="1084596445"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 20:31:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 20:31:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 20:31:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 20:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY+j+8WVnwssjqI9BowGbO7brHWDsDyj12lKB47d8W7dC4y/iIMibEUcH51kZNT2Diyu950Xz9AYMzPvOPlX71cj6GAToMQB+1J59IAHwmdT42h+kWgebaAX48jfDCkJ4QzGzUnntqQT/qSM9FpaOPS4HxrMZ7+hyUx0y73zM1KkVW7feLZ8DdM05o86ubaOK8mzg38s6oPFSjP1IdRFdUHvGJjV1jOuc4v2CNj4Mrarmu3iAwMzOVsGo4UPGUb2BPLWVVTGZ7hrcRfaN5lO6FmgIjjKgPujuYU8y0DqnYcm8ds+7TXu4qnsmodkt3AnM1xOrgeSeclSQ0Y8PZgsvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Iq5kKOz4fDWLu1Hqg9iLyj3mvBTHPxw2wpxNbOfwOs=;
 b=E/S0hJG+pTehJbRH1u91NtTe5uPSCgyPmVgqqUxCynWn+ymW/V4V5WPgmWa2hsyYREbMJYEUys36nHwffcai9AjV63Dk+ZXOmXIYsN8YJWO2aw8E9CJk62hNgn1ou3Mc/7tKNYgUKPQpjnRSqEQDOuQdYjiuJH0M/cr5D86cmJag2jH2sF3oDNlITCd/F9eOWLaxLqNeaSHkPU7c7fZvxU8NZJDq9x79vuDUrPBFmuGYPamPrAK/bvZgfF4G3pBunAkYzVP7oEgI/bgozuVIcC/Wdrnczl/s+51jyU1qrvXAUeNxai0vCczelSmDdQVoDZFRFZZH6Lqp9Jtohhi+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 03:31:10 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 03:31:10 +0000
Message-ID: <522d8a3a-3db5-bc20-198a-c4b142e982d9@intel.com>
Date:   Tue, 10 Oct 2023 11:33:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [RFC 8/8] iommu/vt-d: Add set_dev_pasid callback for nested
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
CC:     "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-9-yi.l.liu@intel.com>
 <BN9PR11MB52766E649727842C98B7396B8CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <04af40a3-1675-4b1c-27de-39d261dcb1cf@linux.intel.com>
 <BN9PR11MB5276CD4C47B3833BAC8B30588CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276CD4C47B3833BAC8B30588CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::33) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ffadf6-be7a-4132-3ebd-08dbc9415890
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lgcw4t9L3fPsOu/NcFPYG3e+gM1FOlUcW33iqK1cIKlru+iH3pngPqaT0+KB7i1Tmn86JQFnZJ1AiiaM6o0y4EL79XRPy7sYGJr7i4zAhNxJPxrLvHgcd+QXPj8pcdXL7d2yprU+uHCZysqr+UuDnAZMgFvLUoIHtE6CmoalH690kAQ5iEHecn+MT6nG9mzakolRGCnBeqT4vhxD7wF96qqwwKm39ScldJATDLRSXerB2MoJnV0S34dQWuwtvtMFsOLxwv+x6JIZnU4U0D9XZg1yQ0LdwZ+XHtyzpCM49VcrC4swwTZgmgdpw+gHIoNgsiowPQ+OnAiAsUpwtEc3YWCO/kguYW5cVPVqIQB8GZ1SwGfOZYA2jw482zTf1YK1p88BO17lI/lttKjGj6vyqT11e/Vl1wMlFEkTYMB4Jt+NRb4HuQss7WdvaGC63H/QubyRsEuJLFe4RuUkYv3w2GEbC3gO9f/jrAT0IGTRYK0/xjhK+TUiZtBPmr8LSxeUJI/XsYJaQiMulfm9hqPkHdkJci1/UNInEBnlz2BWg4DtZ3mJ6x6IOSM4DEgdtSKMZVvL2H+eEYvjFQolNs/wCf9zfvLKFH7sTskGCt6YV8L25Iv0R+Du7r1PffXCSYNw7dZJVPUlLUX0iGidm2YueQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(2616005)(53546011)(6666004)(8676002)(6512007)(83380400001)(7416002)(2906002)(6506007)(478600001)(4326008)(54906003)(110136005)(66946007)(66556008)(66476007)(6486002)(5660300002)(8936002)(316002)(41300700001)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1B3WHM0QStidTl5bE1Qa2FmeUFZd0RjQUtJK0o4eGNTajQwSEYrZUJCcXZU?=
 =?utf-8?B?cm9pZTF6ZkFKVjFScVo3Zm9OenM4blRHZjNYQm9IM2xVL0NVY2V5UWt3MWl2?=
 =?utf-8?B?cDZVekRaejRkemFIdS9xUTRjdHJYeVlROEo2VlFmMmFla0pSTFRybUs3YWNO?=
 =?utf-8?B?S0JjVlRkNmt2a05hc09OQkNGdlVPcmx5bzI4VkJudXF3RmdsMkpHUkFJWFRH?=
 =?utf-8?B?eThaWmhvV2JQY2djdHJsRWhDclZzQTM5SnNIMXpsaFlNWUJ5WVllWFUzZzRa?=
 =?utf-8?B?Q1dJZmVtU29GcUpIT1hDWGdVMlBnOWR0NVU3NmhVNEJtcjg3SE9BV1BMSnE3?=
 =?utf-8?B?dWZTb0ZmSVR6cURGUzZ6dEh1VmtVL3FRbUQvbzFBRHloektVUndJMzVOdnZz?=
 =?utf-8?B?ZUNBOXhScVN3cnNta01sdDlPNCtSNVQ0N3FYUFFydjZzWTN2VXVtYjhVTmhD?=
 =?utf-8?B?MWFNRFEwNjBtZEVON01IeUU0K1VDeVRBcG9LVWRnMGhzcjJ4UFYzUi9DYmVS?=
 =?utf-8?B?UTliVHJyN1cwcnJvbnMvVWhBYlRLUGdldFZkOUV5NVZ5MmFndUxUM1RSZ2FX?=
 =?utf-8?B?QU15bUNwaU8wSnVKQS9ZY1dHMmwrNmp2U2dxUHQ0TUVlakdLWTlXYXJ1YTBQ?=
 =?utf-8?B?L3l0cjdHM1FWQ3JzN2JyVktDOGo3UWlSVk9VWTBTSlBjamQ2c2lQZnN0ZmFq?=
 =?utf-8?B?Ti9FUE9qZWVESE9iYlRHUXNsbklJekRqcVBBQmRDMjgzclJsQldNRXZRTVlk?=
 =?utf-8?B?RUNncFBpa2pNSzkyajErK2NQNGNHNWxTQTBYbTBGeXVEemJsTS9lUldFMGp3?=
 =?utf-8?B?SDBjWElEZ29ldUJHbThsOHVIbDQzR0Nla0ZsY2w4OWhnSXN6VURDZEpHZkFE?=
 =?utf-8?B?ZEFkOWlvZHlPQnA3L2UxQTdwRzA3MVo2Z1FiRk0wTE9QQ3VvanhXZStkd2tu?=
 =?utf-8?B?RVYxUWdRSENBNWhqancwNHNSVE43b3VoSnU1ZGVTMG4yY1U0dklKMGRJR0ZD?=
 =?utf-8?B?UG54WDRaSGUrMmtuQXkzTzF0and4cUZ6NGNqbkR2dXZoa2JieUdHV21BVGJZ?=
 =?utf-8?B?NmNGNUtvalA2cnc0S1kvMy9hckp0dEZtZlBEUklGa2VpM2pZaWlJaGc4TTVn?=
 =?utf-8?B?ZFpKa3dOZ0VuNllKUFovZUl1Z01vVnBQRWJuWUNPSjNabGY5NUhxMS9Ba05B?=
 =?utf-8?B?N0t0emNLSXdrN0pTTHhyKzJJc0NxQzk3a29pbW1EL2kyS0lIb1hZV3RRdXcx?=
 =?utf-8?B?RjRlWVprdnlvN0QxZ0ZRcU9hbXN0cjhWSHVJRXY1UEVZRWlzQVBvR0VjUnVZ?=
 =?utf-8?B?UFduL21JZjE5YjlSQWdldjhSODJ6dWpJZmE2N2t5WEE2SFlyOHUwaUNLZ0NM?=
 =?utf-8?B?YzAwcW9HakROd3puemNOcjIyZVFQbkJ4NjZPUG90eUtzUmhOaEI3Y3VNMHFR?=
 =?utf-8?B?RXFvSXZUeWQ2U09kUFZIOFhJTm5sUUs4aXZ1T0xkTU5oZDNTWENlMXZDTXRS?=
 =?utf-8?B?Ry9sNjM5NWtPek1wZXJuRXNlZkxrYmprSGtZMkIyVEFJVDg1QVd1MTIxM0No?=
 =?utf-8?B?QmdXZ1VabjJIeTFwZ2tQd0pRbElIZHFCdEFkNkdpUmY2dUdHTVJIY2F3RmV4?=
 =?utf-8?B?SjZmcHhOb1pGelY5eXkvU3pyK1JObXhkTlpnM2Z6NTJIVmZ6YmczVnN4M2lL?=
 =?utf-8?B?bllNekhFZlhzQmZvWG9YR21SQlRyRzJYTTQ1M3VBVEI2bjJjdDE3OUVFV0xS?=
 =?utf-8?B?NXVGaWd1RXoxc3hxV3M5aG96ZlYyd2w4SXlzMGVvUGlHdFgwd0t0OEdONnBi?=
 =?utf-8?B?eTgxUVE0Z1lQY3U2eHUrSDRJT0FXbkhRaHExV295MStyME4zZUpjQmkveTQ1?=
 =?utf-8?B?UW9VR0lHa1FiaVFvRDhEYkYvMFhBWkIwMjFzSm5oOFhEN2dSd1RpNVNEV1Jh?=
 =?utf-8?B?cy9yUWd2aWtmdVJ3TURIdnFlMW1kYmoyQzMyWTRmLzg4Y21SM1lIRWlvaWJ2?=
 =?utf-8?B?UXZVWTZmTFdLbTRxVU9vWGxKWXdQSUhBbW1uTFYrcVRZb3BQU0xNV1pqUkJH?=
 =?utf-8?B?UTNkVFIzWFFEdkxQbG1BLysxWHJCTkRwQ2pwNHFRb3dxclNmT0xXU2VPQk5t?=
 =?utf-8?Q?1dMrqRqfXia2NtMTLtIedRIPa?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ffadf6-be7a-4132-3ebd-08dbc9415890
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 03:31:10.2269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mmI5lIsCFt0gp0eKfhpUEXEpL7lQrE/zxIhR6ZMLkpUUbaEjAZ3UYjqdwne05lw/QciYEGto3u8cIy3/oewJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6236
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/27 16:09, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, September 27, 2023 3:58 PM
>>
>> On 2023/9/27 15:52, Tian, Kevin wrote:
>>>> From: Liu, Yi L<yi.l.liu@intel.com>
>>>> Sent: Tuesday, September 26, 2023 5:27 PM
>>>>
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>>
>>>> This allows the upper layers to set a nested type domain to a PASID of a
>>>> device if the PASID feature is supported by the IOMMU hardware.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>>>> ---
>>>>    drivers/iommu/intel/nested.c | 47
>>>> ++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 47 insertions(+)
>>> pasid can be attached to either user hwpt or kernel hwpt.
>>>
>>> We should also introduce a set_dev_pasid callback for non-nest domain
>> ops.
>>
>> We already have the code in Linus' tree. The idxd driver uses it for
>> kernel DMA with pasid.
>>
> 
> ah, I forgot. 😊 probably can mention it in the commit message.

sure.

-- 
Regards,
Yi Liu
