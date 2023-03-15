Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906756BB527
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 14:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjCONvG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 09:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbjCONvE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 09:51:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392738037;
        Wed, 15 Mar 2023 06:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678888263; x=1710424263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nJBJ/aCMclCbw4ZFIVmJZs4MxFe8dUNc0h2Y0XdhNDU=;
  b=W0K3C8HFxKVsoL8H8xVX9dLINI7DsiHRaG/VQdXnkCyPiia8qNqHqzHG
   zzllFrsyLcZMFfiaWDT8jN6jW1ub0Qn3cNQOBgrjf+36IEzUPQPRQXFuv
   rCCjr5Fq2bs2BySzvDplqm1RrY4g4BMy+rApzb78GC99mJZAzze/u+GAW
   mCTaCKXGOLjfZ4XA4bMstr4e/uUJ1lP/droJu4E2MpCRpYbwuVGzn/EAQ
   IIjQ8KwC59yE02U1aRYENHxawiB0T3dzZ4bHUecXhiD+sqrrK8sCLf9oz
   f2zN22D+5QW1+Oakl2nRsuCo893wHpeUwdbe1M28b5mIGw4dybpWVlgyU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="365387831"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="365387831"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 06:51:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="709691481"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="709691481"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 15 Mar 2023 06:51:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 15 Mar 2023 06:51:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 15 Mar 2023 06:51:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 15 Mar 2023 06:50:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0hIhmHtaC0q8iqFG7ctpS8PHLQRwFDl7GGpainzWh580qgHRtqL44ofBnWYRF+eBNP7aQH6S5+C1BPb8IaY/Wb6NakShjyugFjUTws+R5Vx3oz7t0efvnHrex6SYyZEdtQ3alnJ2kF3afsGxthbMW71bhrcRt9wGNdoGlx2Y3HpCiRXmi8Pc1oNjt/VK/6fv4x/F425Ce2yGrq97te0EL5qcAiOjTEu9VaOWUVv24epoN3HVG/EKCfMLCcFsifZBUrUcBgePqKPqY8om84egPzd6SE//EDQM6VeLUevXWZOJyw/ynqdxv7X8I44Ps2CECVOWr6zFlXK5GjRVl01uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXW0M3sGtUcOAuux6KosBbyn0joH3gVbWzKqkZq02q0=;
 b=V8M1UJgWUrpUxpA4lGdFU+Hu5dk7cNawYKj9CfFumUd+YIPpvgiVnCNErySfrpLnO3gXNKOIMDUuKoMd64razUDbTJuZe7eCd6ZdEaUuPMJYLQDzs0Rs2w5kac5oWnOmi5yTpscDJ794zO5DLa5cYropTvcDHVDGXezzwjzLNSy2s4dmsnTa6DBPgn1AB/DtuDnDMlBjgBf2tV5S+u7YeD7ZOFYT1F6F8uBa+B+9DqyxfJ+SqQnePmHNuHNM5howtEQ2dZ1cy/oIDiGwJzMa2kAsmNUGEeoKvkjrUK231DZyqI2aGwkVKaz77kpCa12UCrHBSkuizBvJ3+0Y/6/PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by DS0PR11MB8017.namprd11.prod.outlook.com (2603:10b6:8:115::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 13:50:58 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::aa1a:2927:42ee:41c2]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::aa1a:2927:42ee:41c2%4]) with mapi id 15.20.6178.029; Wed, 15 Mar 2023
 13:50:58 +0000
Message-ID: <6c8e55e0-e699-d199-87b7-04c81e7e2493@intel.com>
Date:   Wed, 15 Mar 2023 21:50:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2 1/5] iommufd: Add nesting related data structures for
 Intel VT-d
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>
CC:     <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
References: <20230309082207.612346-1-yi.l.liu@intel.com>
 <20230309082207.612346-2-yi.l.liu@intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <20230309082207.612346-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|DS0PR11MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 25e1e0a6-0f59-4645-1e06-08db255c4dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jdr/qQ78+0jYgX+2NLhDNCz/TQ9PvwzxQxAjRY63ohbNE5f5OvBiV89ZRhkGrvBQQryqoiW2UfzbSw5Lc+uUFWT7oehtfEoqnKitaIZOWtmur59uWMmtmhZzH/wvzK1cUEgUJZz5t7fvf/o0N2pFp2ylnJ8vjhlDwoa8M9+DnDM4k5vZHLN+w6ktxp1fx5g/1btHicdCnzs9N9W4PddiNWbj+rUWCZolXk2d+MMO3B9JqnRjHfZDE+fSOShQfaZ5wM5kANeAaLR8tRNPeJXq3mAAPHACjIzN4rJKM1El3XiW5+yAJU+fLKa9OtUiFdubkq9mRfOY8z4VDIy1pDfeSzh6X+zkmrgGNRSjOJMci3F/vxizp89erO0zLburlJ3YhJCn93K5YNQRxbG8SecE8zUALmu1TMXptRsFtf/1nTE3qnJRc1iZN7RD8z+zxNrD24yRkJUYhis870ckgWWArUW5K6077+9V9qcaaZTcC4MiLzoJ3iOuFUpjFeA0KUC57AVXjk1dICxvfNLvFGeOVzkgx8FPr0ULD25p5O+LSsASrjmkSkhggbWRQCbbSldIDjMNaJWMIzKaK+Whtxkp1R/FRVEj/KGviR1NpXglBAvDH3rXN4UMwRcDj41RDxmIALj7AQPNzsTb5vOjlJPek2vO7eOcZAaKX8mBZu8dUt5Z+t6zBW529iCxi9BUUcnMurbPKWrBuVaFkVSk/1W4meMF2EEpz2vwShYqefv+Dc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199018)(36756003)(6486002)(82960400001)(2616005)(186003)(53546011)(6512007)(83380400001)(26005)(6506007)(6666004)(86362001)(8936002)(5660300002)(7416002)(31696002)(41300700001)(4326008)(2906002)(478600001)(38100700002)(8676002)(66476007)(66556008)(316002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0YzZW5QSnhPeS8yQnlBVkRTdkJsS3lsVyt0VER5VUEwMUpVUnF3V3BPYkUz?=
 =?utf-8?B?ZDJGVTMxcE5DTzNkTDlQV1lYN1ZvS2NDcDRQMmJNUFoxaUc2UDYvejJiaVZI?=
 =?utf-8?B?QVVpbjhHRlZsbklHeHR2YzY5djhjb2ZRK0JHUHBwb0VCNnhVOFZFQldtWm5M?=
 =?utf-8?B?WDNQRjh6cWJQR0dJdkovS2ZidlF4S295VHZIQ2RuZTNwV1hEYzBTMWpJVnFJ?=
 =?utf-8?B?aWRhSEpEdG5zSW5lb1ppZXRRd0ZrN29od1dYRTU5U3JRbExyV0pHc3U3dllJ?=
 =?utf-8?B?bUxxV1l6d1I5bjF3UnE4WGpXQ1dveko1TmVxSngvM1pkQ0FJem1oVmxWaXF5?=
 =?utf-8?B?bG1DYlVyZWxDZS9lYnI4YUxHdEt6RDI2b3orNHVZUnBzTXNmR01ybmwwN2Zi?=
 =?utf-8?B?WUJCUGpOZkh1S283Vi9uYnFoQlZGRDhSUUw2MnIrMURKTkI5S25aeHdpa1Z1?=
 =?utf-8?B?YjZOdVZRV05BR3ZKbVZteUhBUWIvRHRSK0ZhM05iTUZXZjFxNXZTT2FnWFlm?=
 =?utf-8?B?dWtuR3hkaGQreW9QRFJEbXRibjdDRXJqUjZKVUc2WXhhdW8xS1dFY04xK0hU?=
 =?utf-8?B?SHJwU1NWUHk2Smt0VENST2hiMGpVRS8vNW1PZ0h0MG44a3RhVTJ5c2dPcll2?=
 =?utf-8?B?VWhJYmxOSXFJc2lmS3J5WVZKTUhoZytlSEJPZ2pMYkV4T3QySWFOL1E0eUg3?=
 =?utf-8?B?bU9MTExNelVRMHZKSDhCSWsvZWtRZTcxK01MMFYvbUxsNVo2N3NPajRseVp4?=
 =?utf-8?B?aWd3SUZlYXdSYmJpODh5Znhudjg1NldETSt6amJsRWlCNXhhVFBQRlc3c05C?=
 =?utf-8?B?Vjg3MGNBc3FpV0xlK1R1alNTUUdqTEhXTkF2Z0NzcExKckM3aUgxN3dIOERE?=
 =?utf-8?B?cUhwc3M3dnNIUUVUMVpWUmxzbmhTMGtrQWY0UzhvU05RYzVBaHl5bWh0UVJS?=
 =?utf-8?B?V3FLVmUvNk8xTzNGZG9TU1QyaXVBaHMvTCtIRStxNS80aDJNSVBlSGZwbUhL?=
 =?utf-8?B?Z3VEYzVPZWRLQ3ZnRk80TEV6dlMxWVRzVHBRUk5vdE9JOTVSTDBWaXJSb1Ny?=
 =?utf-8?B?aGVjMDVSVFdlOEl6Y0lXQ2JRQjdQKzQxVTRkTDVHMUFVY3hPVXB0V1pyUjBa?=
 =?utf-8?B?MjByVlhGU1owTDJLNnVuQTV2Ykh3R0hlQWFBaEtEK1FNc3E5cDdERlhmcC9N?=
 =?utf-8?B?V3VDQmZqZjhBc2lJQjhONHk5QSttMUJ3czd4bDNaMlZXK1d1eXh1UEJVM3R6?=
 =?utf-8?B?NXRFYk4xVWR3Vmd4TmhZUFl6emF0bTRMVDFxcjZOS1h6Yjk1UVZGQ21obkFD?=
 =?utf-8?B?aDhjL3ZyanNjR0lQSW5mM3NSQWs2Qms0YnlvekhCa2ovV3NtL1JYWnNLemht?=
 =?utf-8?B?RWRJTjBDZitYOGhOMkNTRTkrZzZMVzNmTVhVWWFKeXM2R3F5RFZ1VUI3VTBq?=
 =?utf-8?B?eWRBeGZqZWMxSjYvYktUVUlmVGQzR1BpN0lHazU2ZDV4cUFrK1lQNjBDZWhE?=
 =?utf-8?B?OTFjOVU3VHc2NmxBZ2J6VmZMZWxITDFkQ1RWK3MzcGFCZGtNbUQySEVuUmVj?=
 =?utf-8?B?WmVzS1FHSzZ2Tmg4WEpMSi9GYk5ORU13QXU0TEdSZlcza25Ca29qSkNOVVdK?=
 =?utf-8?B?c0ZuazExT0VCUzdBcUUrUXlRY0J5VWViNE4zRmt6N2U3bEZhVWljZDlJTlRI?=
 =?utf-8?B?UFlJWElSL2p3R2VJYnB3QWpSSFArSUZMRUt3bnlnWXBaWmMyeDI3VDd3b3lI?=
 =?utf-8?B?UUc2ams0NGpmNGpOZDNoWSswVkJpSnRNVkp6QzFJMitDL2Uxb1pSUFJ1MVZH?=
 =?utf-8?B?YmRTdll4YlBCb3BVNVlFVFIyZ05CdXNCdk1MRlh6WjhaRkkyYkxyc0lpcGQr?=
 =?utf-8?B?b25vOUQySHZrOTdoSjJyQ1E0NDNzVktqbXpORFRJR2UyZ1l1ZmRpWlRuckVo?=
 =?utf-8?B?K0lNRXdVcTFKWllleHZFVGZmN3g1b1pEMDNNVDlyU3p0TkRhU1RhVnZmeXhD?=
 =?utf-8?B?cExlaXRLTnF6Tk9Ta2FsdUs4a0dHZzZwdVNtYUQveDUrOUc0MFZ3SmJQUmE0?=
 =?utf-8?B?ZVZSUEhZZURKUHR1Qk9BZnNnblVyVVhCZzNhdDhNRUd5TjEwd2NOSzcrN2JL?=
 =?utf-8?B?dU5sbk9wWHNUdE1ram1NNWJzMTZnbXloZUtkUlN1YTJ4SC91TUJuUnB5amRi?=
 =?utf-8?B?c2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25e1e0a6-0f59-4645-1e06-08db255c4dd8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 13:50:58.1440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJzbd+9lzgd64YXGBAKOnJ4QXU25Mg3WhQjGnd0DUca544N2Y2xoH/P2aVESRaObfg8UCTfbkF3PvIg2NTR2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8017
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/9/2023 4:22 PM, Yi Liu wrote:
> Add the following data structures for corresponding ioctls:
>                 iommu_hwpt_intel_vtd => IOMMU_HWPT_ALLOC
>                iommu_hw_info_vtd => IOMMU_DEVICE_GET_HW_INFO
>      iommu_hwpt_invalidate_intel_vtd => IOMMU_HWPT_INVALIDATE
>
> Also, add IOMMU_HW_INFO_TYPE_INTEL_VTD and IOMMU_HWPT_TYPE_VTD_S1 to the
> header and corresponding type/size arrays.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c |   7 +-
>   drivers/iommu/iommufd/main.c         |   5 +
>   include/uapi/linux/iommufd.h         | 136 +++++++++++++++++++++++++++
>   3 files changed, 147 insertions(+), 1 deletion(-)
>
[...]

> +
> +/**
> + * struct iommu_hwpt_intel_vtd - Intel VT-d specific user-managed
> + *                               stage-1 page table info
> + * @flags: Combination of enum iommu_hwpt_intel_vtd_flags
> + * @pgtbl_addr: The base address of the user-managed stage-1 page table.
> + * @pat: Page attribute table data to compute effective memory type
> + * @emt: Extended memory type
> + * @addr_width: The address width of the untranslated addresses that are
> + *              subjected to the user-managed stage-1 page table.
> + * @__reserved: Must be 0
> + *
> + * The Intel VT-d specific data for creating hw_pagetable to represent
> + * the user-managed stage-1 page table that is used in nested translation.
> + *
> + * In nested translation, the stage-1 page table locates in the address
> + * space that defined by the corresponding stage-2 page table. Hence the
> + * stage-1 page table base address value should not be higher than the
> + * maximum untranslated address of stage-2 page table.
> + *
> + * The paging level of the stage-1 page table should be compataible with

s/compataible/compatible

> + * the hardware iommu. Otherwise, the allocation would be failed.
> + */
> +struct iommu_hwpt_intel_vtd {
> +	__u64 flags;
> +	__u64 pgtbl_addr;
> +	__u32 pat;
> +	__u32 emt;
> +	__u32 addr_width;
> +	__u32 __reserved;
>   };
>   

[...]

> +
> +/**
> + * struct iommu_hwpt_invalidate_intel_vtd - Intel VT-d cache invalidation info
> + * @granularity: One of enum iommu_vtd_qi_granularity.
> + * @flags: Combination of enum iommu_hwpt_intel_vtd_invalidate_flags
> + * @__reserved: Must be 0
> + * @addr: The start address of the addresses to be invalidated.
> + * @granule_size: Page/block size of the mapping in bytes. It is used to
> + *                compute the invalidation range togehter with @nb_granules.

s/togehter/together

Thanks,
Jingqi

