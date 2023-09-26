Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B97AE53D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 07:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjIZFu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Sep 2023 01:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjIZFut (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Sep 2023 01:50:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470A3F3;
        Mon, 25 Sep 2023 22:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695707438; x=1727243438;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/f/baeBZnpWHFvf3SVlGYtunEgrXyNYeWpFEQgMheM8=;
  b=lFgmE3H657ixEn0gtsbNNwBwUOIWNaLO8tLTlwRGn6wV9s6zi+3v1NlB
   LRtJJfmAwOfAJ7MEePNmr3vfCGpkBdcnqphnRbATQJKcP1sAXVNdVspv5
   pIIstTd0ZOwnF8ibnDPERvU/xbZahnB0+1T/4jS+Ta8zVywDSQg83q+LJ
   5svAIZmHM9WCyMEA68ZLMVN7WG9NO6q+jQbxQlsdltoxoVYAna9f4y71V
   1dvKp3wYFPgSNlVEuNbvqdPgzxlPvjw+fgODg3rGBkG6ThZoMHIZKvg47
   h1myG4pGEuhibFaKnF/tHPAGvCFu2XTVXqKkG9vQB6a25hLIgyLo7juCY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="360869635"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="360869635"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698339547"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="698339547"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 22:50:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:50:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 22:50:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 22:50:36 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 22:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7/UViNJlx92Af+5k8my0M/eCJhdGoZ7vcGvqjPBVpWE0JATi55pboSHvTf4heHZqk4gv7vxFa7xY/wWEqFNLKeL00FuTRCD6xM4ktQk9zkquteExLFavod9q4GWgYYJcJdYZquIFfFEyo/aM2IP9ke0wz82i0UKYjmR6LjJ5boSym9lsg1vkx+jlHzpwmqH0sLcgXSSdPVgtuvPxRIlhNheWQKu8i3ZGSi21DsVRx4FMnC8PNhf9BPKqlmMtg4hKAFlbZ4vXXM85YPKsiaANnkhk/nCxH8cMfsrzxfHS3qEI2pd0cNj/zGe6/paJGvix2+mIrPcKWeoD6nNOGbGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIDOFn5YY4b//CgBlP/8L4Tn2vgaotRNl0pGzAdRa5w=;
 b=P1BqhZkXtlgb2prwq/J9EY3SRyrmMbx3tjRpE/WexR2+7eB10Q/P10Hi9X6Z7A39ADTIhmqHb6WiCrAJVy036GHW9mDFrVpENkyWNMcJ2oPPFQVgQJeoB/9ihEk3Z6FqnB5rdAAgK6xzYXGwN0f7qssS+wd1U0K6BqP7hohZ4GQZmKEh8/fFtxO/rSSa8z9DGv3FHGe+OL4aZm7KmROEsKgbqpQQ4CKR8uVWrcODyRbGKlaYZdfObr8r9wndDTyF0M+8KA74INasmKgN5iMQdl2f1oTpxZEkRIXgvyYr+nDf0Te1h4eb4ewZMefoi2zQS47jag8QPsI1mUcjSj7+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB8012.namprd11.prod.outlook.com (2603:10b6:510:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:50:32 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:50:32 +0000
Message-ID: <72d6854a-719f-e941-8b56-eda4e3027c66@intel.com>
Date:   Tue, 26 Sep 2023 13:52:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] iommu: Add new iommu op to create domains owned by
 userspace
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
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
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-2-yi.l.liu@intel.com>
 <BN9PR11MB5276A8E4869C48A2419CBA5F8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A8E4869C48A2419CBA5F8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0212.apcprd04.prod.outlook.com
 (2603:1096:4:187::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9737a0-021c-4c44-f377-08dbbe547ee2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPIFL+nJGW27425gulNXyzPBFVZnBqZHr9QS1QgFbEjUF6G/kUmA2a7RIvG+iKwgxnfgwfxIabiuWmyeYUbIkB1UgN1RjCVomT8tfg9NZCkb6Y1iL4T9HpBDeJXL2war0e+s/D62zl7BUP6g1gr/iw7qXnJF9ZbxW3qk3vBC0SSarPbVl+78lfQXZEfwZKkrONd00fyVW/APsjekDd7yphh4mjvknkl4c1hF/E4n145pIMpwdVFM4mD7rp5RAemmlgaAOF50UyEfFyaNw6X7LFzmOI9A8YGFhWLV+UNh9CrGy+r4z9BVtjPUfv6Rj/YHt/fcKoNeYqd9OcfPo6yWw1TMJ+3xHEcgWKQVWpSlcF/EROO9bc/aIKLSudAlteo64cBT3xlYPcY6CemSFEsH9uq2Vz6g/rfUPIrB29i64DdWpr+aS/0+Qo+tsrT324piXgRC9cTgbvLg4nRWhAB2h01Ys3quEMHghm18fLcacRPbGbaaODFrwdXc6R7dxSkVhray+BmTRQncTZczOlXBM17wtMQcG2unanDZf5iVG+cklyI9vEwA+7/9EezaUSkdxwFmv8RB48a6mxbHm2eNsWyPErZydNmnvIOli59H0AE85S2I3w3IHh0MKOjZFdLcu7345kmZQYp2V+9JyJPh1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(83380400001)(26005)(2616005)(86362001)(82960400001)(31696002)(38100700002)(6486002)(36756003)(8936002)(4326008)(8676002)(2906002)(66946007)(54906003)(66476007)(66556008)(478600001)(316002)(7416002)(31686004)(41300700001)(5660300002)(6512007)(110136005)(6506007)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1pQdGJUTW1KMk1xc2JZWDI2V1VITFZ3SmdaQnBHZFpvWEtja2JmRFQ5RHc3?=
 =?utf-8?B?dmhqL0grY3MzTERDNHdtK0hLNmUzalVLazZKSXdhMjhqMzJTOXNGd2ZGYTU2?=
 =?utf-8?B?bzliWklUMUhEaUcxQ1ovMlZ5T2lodWNRcjhzVHNTQnZKbFBYbkNHS0RqNUdV?=
 =?utf-8?B?YWc5Rmk2d1ozZ25sckpNUEEyc3MweVdyYTdkcmNKbXFVbFh5MjdEdk1vUC8r?=
 =?utf-8?B?Y2owK0JoUGZROGtKMHZNb0ZQNzkySzB2aEdlc1pEbFlKR1djSS95QVh3NEpU?=
 =?utf-8?B?QThhZ1o3b2twYTZBVzI1ZGRQNnlNdFJTTE4rUkNKMk4yY0k5Y3lWREpuY1U4?=
 =?utf-8?B?dlJPSjdLemxjb1dDWFk4VFAzQVN6YXhjRFJraVJzU2UzbmEzLzhHQVJ2WTVx?=
 =?utf-8?B?d0pQSnZmek1PM0kxY3czWjBVdHlSa2FJWEhNR2tEK2ZUTTAxS2dhdkFWSnJ0?=
 =?utf-8?B?ZjhtWkYxbG94cWl6VFpWMkdTNzBKbXRLdGlsVkVNMHFOb3N5YTFpdExPbHZ0?=
 =?utf-8?B?UDdhZndlRHl1MTBjWHI0L2NzYlloUHdsdFg2MGdYTzN6cnRiNWpQdGl3S1lN?=
 =?utf-8?B?K3J1aytTamNLbVNQWjUxK3lMbHhVUVY0ZTQvUGo5OFprRW9keUhUZHorN3BM?=
 =?utf-8?B?dld4Y1FDT05ZUVB2OEtDSU11azMwTVVQK01vZno4NDdNS2hNcWgrNE52REVy?=
 =?utf-8?B?RzI4aHE2dkxXSXF4NGNtWE13ZExGekVOUWlhRVhhR2hzeHB2Tk8vV0pRWUF0?=
 =?utf-8?B?QXN5cHBUdXJUY0tpT1B0d1ltWUhnUW1JRnZIekZDM21jcXRMb3RYSTI3alky?=
 =?utf-8?B?SjFaUmRvbkk4TnN0Q2RlQ05FZWhkTWVYVW9QZCt4SzJvQS9UUm95amF4YmJN?=
 =?utf-8?B?NHJiNmJjNWRKVDJ1OHRXUjR5TmtWNk9jek1TSEd5dTFxT0pNdXVqVXpwQ1p6?=
 =?utf-8?B?Q0FuKzhDZUQzeFpIeTZxUDZSNzBwa2Q4YlZXY2l0RWROeUVYTjAyeElQQWhL?=
 =?utf-8?B?OWgrOUpsOSs1VjhuWUVSWlhGK1VwY002cWVBNmxabGdHTWFYY3pPbGwyUm0x?=
 =?utf-8?B?dFNVUHRmTGw5dkVscVVqckdQOHRLSmE0SjdBWFZuYUV6aUVHRGJrUDRpQkxT?=
 =?utf-8?B?WFdpK3NCRzhJTkNmTWpWM1hjVll0M2dlZUhOQVpBdEVaRXlzeGkzNmhJUUov?=
 =?utf-8?B?bEN3UjBTQXNYNWIweGtFSXpKdlBrOCtoS1QwRVE1TWZ5Z0Jscmk3VnFWdkFs?=
 =?utf-8?B?T3F2RlFMTkp2U0hEdlZ0a3ZEcjR3S0syT29OclhrNjZOSHpkaWhIbnJUaHFG?=
 =?utf-8?B?SCtseUhFU3RoM00xQWRoUUp0K1pPcTJHbzJvWktvTjZIZ1RXemwrS2JDUmxW?=
 =?utf-8?B?M0pVRkRRS25ZSDlIZC9WR3J1VXkxUDJ0dVpibG0za3U0Z1JEYlQ5NXJoSncw?=
 =?utf-8?B?Z2JsandHdUpyNGQ0cGZONUdBdVlEU2lDUVEzNERnOGpqOVJwYVhGeGxyWFNl?=
 =?utf-8?B?TWwzVmwzQmQ1dFBHbGJQQWdUbThZUm12YXRhRnVuYU1aT2gyNExVdzA2UWp4?=
 =?utf-8?B?am9Sb3VrU21kT0dleVhtaW40VHVVWlhXS0lqeDJJK3h2am5aSURma2dGZjZD?=
 =?utf-8?B?bTlVYmZ1MzNDT2Qva3p3UGRnNWRwRE5Ga0dtS0IybHB3Zk9tME1GYWtuOGRz?=
 =?utf-8?B?NStVT2w3cUpjMFREd3F0cHpBVFNpbitIQ2QwMW1NS2lEN1pudUU5M3ltbkUx?=
 =?utf-8?B?WnJjYjNtS21hcnJzc00wL0pVS2VYYUpFcjc0MEhtWGZtR2ZIaHMzNE5QM2FP?=
 =?utf-8?B?elIzWXM5d1lsZk5DRFJmVEVwYzd1V0MvYkY5Vkw5UDBEVG11MlZSeGEzUGJa?=
 =?utf-8?B?cGZJdHBPOVlua0NSMkptRUlVNi91NFRpR1BqcW5CUG1PalB2cWtxMzVPSnIx?=
 =?utf-8?B?N1duc0dKUVVDUE40eXlCZm1URGRubjV2NkdNT1ZBZWdSTEhYZlBmTENwdkJM?=
 =?utf-8?B?MGVtZy84N3gxaWoxQVZIak05eVVMemJaSnFtV05KYkFPM0FOOVMyazRPUjUw?=
 =?utf-8?B?TFptZkdRUThzL0RtN0Z1Y01TUElJbjRXbHM5MDlXRlU4aE40Z0RXbnR1TXdW?=
 =?utf-8?Q?oNPl7lZKjORUtU/eiPJ9uAwUf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9737a0-021c-4c44-f377-08dbbe547ee2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 05:50:32.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh/prv1h+gNMFbLr+neg+j04EQsEaFiMQ9wsRVn7WRR5pcd2wwEDYHkb1nlPzGs1qdRBgwy/Dn1NArtTcmE3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/26 13:28, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, September 19, 2023 5:25 PM
>>
>> @@ -235,6 +235,13 @@ struct iommu_iotlb_gather {
>>    *           use. The information type is one of enum iommu_hw_info_type
>> defined
>>    *           in include/uapi/linux/iommufd.h.
>>    * @domain_alloc: allocate iommu domain
> 
> Given now we have two @alloc ops it'd be clearer to also update the
> comment here so the explanation for @domain_alloc_user() is easier
> to be understood, e.g.:
> 
> @domain_alloc: allocate and return an iommu domain if success. Otherwise
>                 NULL is returned. The domain is not fully initialized until
>                 the caller iommu_domain_alloc() returns.
> 
>> + * @domain_alloc_user: Allocate an iommu domain corresponding to the
>> input
>> + *                     parameters like flags defined as enum
>> iommufd_ioas_map_flags
>> + *                     in include/uapi/linux/iommufd.h. Different from the
> 
> "to the input parameters as defined in include/uapi/linux/iommufd.h".
> 
>> + *                     domain_alloc op, it requires iommu driver to fully
>> + *                     initialize a new domain including the generic iommu_domain
> 
> "Unlike @domain_alloc, it is called only by iommufd and must fully initialize
> the new domain before return".
> 
> *domain* here already refers to the generic iommu_domain struct.
> 

above comment well received.

-- 
Regards,
Yi Liu
