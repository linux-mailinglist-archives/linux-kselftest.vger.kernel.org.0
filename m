Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A637C6914
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 11:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbjJLJL7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 05:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbjJLJL6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 05:11:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1E39D;
        Thu, 12 Oct 2023 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697101916; x=1728637916;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=siac2ujWDoy51hllBW+PfOCbZJ9AXjqArk6dQO8U/5M=;
  b=PgLGJJHJ/kf9f5ZQ7uGuwPbeLiGYa9NMelZ487ZeSj1I7wVUKm/XbbZz
   cFAPVOCikdBnuuIV3p3DWxrOAywt1ZxzcKv2R5juYSNEAkrHXKMQX2u8D
   GzyQPTu5lE6/ovWLpZcrYMsEC17diSE3PYO7rpzMf/GE3r9+1tSw0gWtm
   fzwbVjEQOZENB/rCN4VCDGVjW0xjjm3hsL4CP/syxlDbqB4l63Qe1bu/O
   Pt8edCi8EpbpMKqWlh8ptXKeXISTKKRjXdmycA9MIrDBGuua3sy1ZlSUn
   vOVGuMKwucK/3AkqtW9DEuSJHpR5t2km9qlckORlJd4wTbk+bm66JMPdm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369937487"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="369937487"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 02:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="898011103"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898011103"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 02:10:06 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 02:11:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 02:11:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 02:11:53 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 02:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoXKx9aN+nS3t12pe/c+1bTOmoFvR9OOm0/D+mmJ2tgrCQznWk/PiujyA3RC6X9UzRphYbY4KlMwit17g6vCmRRSOt1co2xj5/U/czzD96TLidGuA1P6JqhTq1cwNZaTRA17EqP5VHE361U3asF2NNXeKhWVQNtO4D9p7cQsrUQjv9DITvxkbb8dTocpuqxp3xpI7oIJI2H/drMsHJbbbEOYCERJbopUCwMOMO6lSlT+x01kjI1qU/EtPvmdke6vXtlM8oMOo9kB7aeTdlujI2NRmtlJZlJg4zsLDZA9TP2s9aFtwLoq1hk5tXEGzonhp1T3t/a945+x6wPrPuLJ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IACqkslfXBuyexdnQtjNSKycBEaYInzd/r6WZMKmtFw=;
 b=DRPfz/FQqXr88b8iBmj9xjeRFvvMiF64eqnpq6aBqA15Fure/GYCbBJ46bJRj/8REBqBXkh/wjGKguWhfcfMkoV7KHDbVQlOUctSi0ojVoLTBfEN3oCn4RO562fOsHYrkmUl9IPx9tCdYh24tmlYMLatUoHiBejZFeJ9JRWi5NQrczQWMzDzBFj4BVaKNyAUVATSHsx93ciziOCP2f5mQBM3I/2CY9ePo9zlmF0DWPqGXggWty5xkFL5QNNYMfLSBgQ7QeakCBYieHu0T1uQgUJROMdzLusDXVH56wRq2iKHLek95AD0VxGyqYP6l70hWpU3EYEQGS6NDg8N9VMscg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8745.namprd11.prod.outlook.com (2603:10b6:408:204::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 09:11:49 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 09:11:49 +0000
Message-ID: <9f311322-8340-c0ae-a500-ad9926ceea58@intel.com>
Date:   Thu, 12 Oct 2023 17:13:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 02/17] iommu: Add nested domain support
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>,
        <baolu.lu@linux.intel.com>, <cohuck@redhat.com>,
        <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
        <kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
        <chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
        <peterx@redhat.com>, <jasowang@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
        <suravee.suthikulpanit@amd.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <zhenzhong.duan@intel.com>, <joao.m.martins@oracle.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-3-yi.l.liu@intel.com>
 <20231010172139.GR3952@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231010172139.GR3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 697b70e9-d32e-49a7-ec2c-08dbcb03439d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XCSsuI3lseG0V1ShRTkSrCU4Ffo4ZYqCLqQJH6s7ii/zD8699ExslTTHau9ZMfox9mBn4Tfl5qU4HkLGqtZe24Ge+dqIUWRH+yAIS0Abs2k6D2obKem6UoiGyVKaKZ0XfVtFuXOY/t3lkaJenYj+0XOLPfq9d3MFh8fwayIAoJRLeqcYcAAvQJZEnJu71Iv3JSRkhhDNiKlcl/D2zHzR033oFhx2LgfiRonz4wAgUjCiywXp/FyqYr4PcKRFUXOcvPSb6tN9+1dI9WWY4N4PJrVfPfCYMZ4y8HRHSYNRpO6zNWDFKfsAOEEFTipRAsHgqdpoQbxSNEwHiB4K5XYmEYTPYhsouQoJFYPPJisse7y9aHrmVUsHKE018Ls+eV19Nrq9huYGsPQXxVyJPxmdoZl8QBuMzvZklsy1TzEHEN7kZZaUQYR5CCuhID3gaEsiNxsPE7xTSbPMCaHARUT0DoDltT2415fAh/rxYITtgYN07tiskZTb1WLixdRtbXAKbzuM0bUGVCJA/4rLqwGsORVBN0g7kFuCQBmk8kmhzwuHuShN5E1I0gcVlaKwGFdtRARdbpZbHXC5tw1LM+Udy08zbPLuLFejzf2FiGxsfK1rvncnIEuXjtEK3rD4buQUFIs1ZxI/ADmJGLfqFHm0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(82960400001)(7416002)(4326008)(8676002)(8936002)(2906002)(6486002)(31686004)(5660300002)(6666004)(478600001)(31696002)(86362001)(53546011)(6506007)(6512007)(41300700001)(36756003)(38100700002)(316002)(66946007)(26005)(66476007)(66556008)(2616005)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDlBUktjbGx1R1FhbXY1NFI3YWttOFlqQ29FcXFRNlNXdmViSjJDRE1zcWtz?=
 =?utf-8?B?VE5yeGNQSzJJcU5qNHVlc0hFcVM1Wm1tOHJqclNKZlV6N0FGSGdhOEEvUWVJ?=
 =?utf-8?B?VUJqNUNMdHdVQXhMRTBjM0ptNXVIYUxoU0lydkQ0TERQdCs5d2dqRDVsMCtk?=
 =?utf-8?B?cjdUQlFlYklFSGZ0M3RmcnRVSW9jUGcwWjg1VGVzNkZ6SW1IU2hYM3JjeXg0?=
 =?utf-8?B?amhOai8zUkN2V3llTmg5U0FSLy9WdXc3bFluNnViOE9vbzhlWVBSR1ZOeHpO?=
 =?utf-8?B?cy9naitubTRGdHFNNDd3eVF0eTJiRGJ5WUY0cGlZNU5GbkVWQWhmcUtFczhY?=
 =?utf-8?B?MWl5UTY3U2RDa09LYTlQRmtvb3ZnUHFCem1Dc2YzdmZ2dG5wWUhBakFNUWty?=
 =?utf-8?B?ejh1QjFsNWFHTnJVbzNjY3VjSGF6a2Eydnhqa2hRYXVieWlGYmJ2d0l4YjVI?=
 =?utf-8?B?eW5xWUNrQ0ZycUtWWkIxNU5kOWlTU2VyNDQ1ODVBM2tVMVNmbjYrWWkyYzRr?=
 =?utf-8?B?ajNUSEFIRzMvUVd4Mm1aNG9jTWZZWjBYQnpKdnNxamQ3a29zTjMzbG1FWCs1?=
 =?utf-8?B?dzF0eWlGZHMzYm8vMlAydWN4azNOSmlkeHFJSjdFVE8vb0hFcWE1UjEzWVBQ?=
 =?utf-8?B?Q1dFU2NoV1hvakxTOXZXUXlod1NhQitmeE8wcWZYQUQ3ZzZDQ1dsanovQmtq?=
 =?utf-8?B?SnI2bmhkU0lkUjI3Z0FtUkV4a3Jac29MRG5iZ2QrV2NqekhCUnNSS1pCNmU4?=
 =?utf-8?B?cCt4Qm5BMzk3cnNHaDdBRWNiOTNNWGFHRHZQQ3pIa2E4U0gzdVh3cE1YYmMv?=
 =?utf-8?B?ZzFFS2Yyc1kxTlBGQWc1MEMyZnN4cnk5MWFwUmVvbExNazZxcEk3dGljZHRi?=
 =?utf-8?B?eHpNL3FMRHdQWFdpN2lLanluLytHNklSSWIvQm0renlUTkIwTzBlT3JTeDY4?=
 =?utf-8?B?VWNQTDRwTFpKUUdiYnJKTmx1dTd4MUppMWM1RHV5RGJiSUhwdlZXb21qTnBz?=
 =?utf-8?B?aXNnRWJSb2FZWEZRRWMvTXExc056ejFYNVF3UkxWY2ZnZmFVL084RDRtMzlS?=
 =?utf-8?B?Y1J6YTZ4MDZrREs4ZUJaalhucU5VdEFuZ1FjM0tOL1JJa2RCZTRQb1Z6SWRz?=
 =?utf-8?B?SHdvMTZmR21MN2E5RmZuQTNIT0swcDJzQTFYQVNnTUkzV3NhbHhLUU03c1FD?=
 =?utf-8?B?Q3VUOG5YdjMweHcwK1dqZWJDNWVhNmJEUzRtNHpJcXY3aDJiU1VNdEc1Zndn?=
 =?utf-8?B?Q2pXMVBnWk5iTzhpTnZmdE5qTytGUElSeGNKR3ZJQzVYMkJrUHZFblpGWTdt?=
 =?utf-8?B?cGNFTzIwVjFkdkxLQTV2bWdvSkZydm4wVm1OUUZSaHdYdzd3WWtZNVJkY2Fj?=
 =?utf-8?B?blRwSEIwVHVMOHdsWnZsWngvNGw2TWVuSUtwRmpvLzIyNUVEM3ZxTTk2Q1FY?=
 =?utf-8?B?NnBsS2dxMHRDYm85MGcxMUQweVpCMVI2U2hpc2pXZUd3aW5zZHljUzZNaEJZ?=
 =?utf-8?B?RWE4cVgyWklPTnRvYkNpczF3SnBtY0VCYjVnZjhlT1RQcUtIWTBWMEhPbnlQ?=
 =?utf-8?B?SUs3NzBsNEhybUpFaUxwVHZQZUlmU0lmcFRhNmlzRW9EOXRLSm9lVXZ3OGRN?=
 =?utf-8?B?dHk4N0JjQVNsbmNUbXRoRVpidDFNL0s4aFYrWWhNTUg5Y0l5TEdkRExURnJV?=
 =?utf-8?B?OHBTUUpYK0RqY0xxR3FibXBIRjlpU3MrVm50MmdSM3BQVUM3MzJ6MDVNLzMx?=
 =?utf-8?B?Zzl5WWp1MFpPWlNralpva3VZTVdBNldYOWVOMEg5MW9CQk90T2NxQVlMNFdS?=
 =?utf-8?B?bm5wR0FnU1B5eTg4QlJEdTV4YXVCajQ0Um1adHdoZ24zdTZ6QTFtTUI3ZzRX?=
 =?utf-8?B?eTlqTDM2ZUhVclpUclRCY2tkTGdRU3BQa0ZVZENiVUhxUWtHNzVOWUhFRG1V?=
 =?utf-8?B?YS96MnE0K2NNWStXbVVRUU1zSHNQNmlBSk4zeC9GNy9BNnFVTzc4Z2REN2JW?=
 =?utf-8?B?UTI4M1RrVzFxY1Flcjk1Zkl3RGR1ZitEV2h4NHNzdGN3OGhKekVOV3F5bDJO?=
 =?utf-8?B?RFFhZGp0V1ltamtROFVJWjZJUzZ1dzkxbTV4bG9nK3hjNFlvUHRnV0M4ZjdU?=
 =?utf-8?Q?ms1qiKDyxfs2O1ZQFUVuLozTB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 697b70e9-d32e-49a7-ec2c-08dbcb03439d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:11:48.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R0SCWWmxc7lzXIm4l0s53xjE9hgW9BHHvogLDNvOaBJgjYsWeHjgfGseC11B1D3n2D/fp4rFeBIqbsNnfhjxdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8745
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

On 2023/10/11 01:21, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:51:23AM -0700, Yi Liu wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> Introduce a new domain type for a user I/O page table, which is nested on
>> top of another user space address represented by a UNMANAGED
>> domain. The
> 
> Lets start using the world PAGING whenever you want to type
> UNMANAGED. I'm trying to get rid of UNMANAGED.

sure.

>> @@ -241,6 +245,21 @@ struct iommu_user_data {
>>   	size_t len;
>>   };
>>   
>> +/**
>> + * struct iommu_user_data_array - iommu driver specific user space data array
>> + * @uptr: Pointer to the user buffer array for copy_from_user()
>> + * @entry_len: The fixed-width length of a entry in the array, in bytes
>> + * @entry_num: The number of total entries in the array
>> + *
>> + * A array having a @entry_num number of @entry_len sized entries, each entry is
>> + * user space data, i.e. an uAPI that is defined in include/uapi/linux/iommufd.h
>> + */
>> +struct iommu_user_data_array {
>> +	void __user *uptr;
>> +	size_t entry_len;
>> +	int entry_num;
>> +};
> 
> Ditto about iommu-driver.h for most of this stuff

ack.

>> +
>>   /**
>>    * iommu_copy_user_data - Copy iommu driver specific user space data
>>    * @dst_data: Pointer to an iommu driver specific user data that is defined in
>> @@ -263,6 +282,34 @@ static inline int iommu_copy_user_data(void *dst_data,
>>   				     src_data->uptr, src_data->len);
>>   }
>>   
>> +/**
>> + * iommu_copy_user_data_from_array - Copy iommu driver specific user space data
>> + *                                   from an iommu_user_data_array input
>> + * @dst_data: Pointer to an iommu driver specific user data that is defined in
>> + *            include/uapi/linux/iommufd.h
>> + * @src_data: Pointer to a struct iommu_user_data_array for user space data array
>> + * @index: Index to offset the location in the array to copy user data from
>> + * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
>> + * @min_len: Initial length of user data structure for backward compatibility.
>> + *           This should be offsetofend using the last member in the user data
>> + *           struct that was initially added to include/uapi/linux/iommufd.h
>> + */
>> +static inline int
>> +iommu_copy_user_data_from_array(void *dst_data,
>> +				const struct iommu_user_data_array *src_array,
>> +				int index, size_t data_len, size_t min_len)
> 
> Index should be 'unsigned int'

yes.

-- 
Regards,
Yi Liu
