Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7937AD0BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjIYGy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 02:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjIYGy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 02:54:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0174CE;
        Sun, 24 Sep 2023 23:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695624890; x=1727160890;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IeQqg9sNqm2luasZR0/uIMeMCOu5ZUYF61ssPkZDU0o=;
  b=i+yGR5/qvqy8ssq+oTN+BYLGY/pqiCm+z1wjAgLA9i9V+1KN38FOL30G
   cTMjBeccUI4/TbdFHNZofmaz4gphb5JHb1BrhrJzP6CH/sP7NwzZiOJeD
   LdTFDVNITFbJdFwotuT27VIaaiKaOYe9y44zugCw/P2J2Ogkneo6EgwGN
   GMCojKikfMG0c7eWXlHQ/YZrrXx0yUtBrBo2ciqXuhxOVS2bJWzypmKsZ
   ayKdjbvOMdiSN6NGeIlaB43uoALBD4wemNveV7csPEfIjKtpLR0Dw8D3w
   Qc7Lz0c3jxI/srGW5pi2WnQISBnhxa8gPb7J7lHF6xSQR/LXl8f3OwmPO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412113889"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="412113889"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777559637"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777559637"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 23:54:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:54:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:54:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:54:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:54:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeDHc/r+wURwDNsMcl6r7bJfeZsQI762XsjEeAlynycItoJkNjVGoyhwNeoq62vM/PFbRUbaTlvpGs8iXrtOOzdKi33+FTOkw/+mx+ouIUk/cREE9/Rvh5UxxxEv1f25WWvFEmwWKznsbVw5UAScxTzB0yWlzxexLTSTMR4o3iHrhJyZoNQmWukIHmwF5K1RcsQ/8g1SFQrJQPhsAmZkC2kQzMFsYVwcQyW+BwMM7g5ZQ+MlY3CnltjrXWZQnczTiujf8Mj+G4sRw1ySpa15gfArHgqWpTunvGN/Ms1dlC/MNWFCnxVcwuY45Z9m0xjdUCUr40nxM1Kibxxted3dRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbVnGVD2DVlH8VADHi0S3ZU0AzleeiA9ti8xQcXzMu0=;
 b=epR/O8zWsyBewnfjy33+e3l4FGYjS0wd2C2hj4omZP1WDCkOjbsyOi0nLgiArl62ZLUjWJCDneRaRAOj4WvTx83Nh/3HKoILGwqn/t9hauTyKszccmOI4MusmIkqOo4omxvRYHG///uH2cYfkvOEjNGxgMUN5jQGcmpZ6BoRIDN+D65pXVdE/ENwOgFjAufM2rdbd843GHgt2HMOK8qqco8cfZDZhIWM2sRL7Su3mocBHuqhVGWxTlh/+oaLfPg8t6jxsB89sfNjHI1P8VDI6P7BTdIMNG9yCa2jWqe+3hvGKVgtyDLNCET1sd9yIARJcgMthaIEAhCXV7OX8yc32w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 06:54:30 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:54:29 +0000
Message-ID: <49bd7209-27f0-4bac-59bb-5a59fb21f872@intel.com>
Date:   Mon, 25 Sep 2023 14:56:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 07/11] iommufd: Add data structure for Intel VT-d
 stage-1 cache invalidation
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <jgg@nvidia.com>,
        <kevin.tian@intel.com>, <robin.murphy@arm.com>
CC:     <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <joao.m.martins@oracle.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-8-yi.l.liu@intel.com>
 <e493c62d-8f10-17c8-f660-dbae19c481a4@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <e493c62d-8f10-17c8-f660-dbae19c481a4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL3PR11MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4b181d-4372-46bc-2916-08dbbd944399
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0DsxAc9e4h69KtTx8SRtFDwhNGrm6J91yho/6zKZq1JmYOFAnTSYG/89BCdp81v/oF5c69CnmGn+e7VwCh0XB6eC0A8o1kEee6GKuArwl7/SXz0g0l2vgXEfXarwUVwWWAjmXPkkX9tPXDsznIu+ZnjNaKgOCURbH9XtuSLCSAqgaOOzicr69b5Qq1FrY3ZlaH6SBLN9deKYqrOGgD944qlUgJtQnEiPf6mGyA25Rp5UBm32Om7o0LSllT8EZ9RE+mDFAck1hI5xoUFVhP+2qQV75et9SA9/zmGTm4cCFPHfblR8+pbEakXqcATYy57D8fn/3qWti1FSILDYHrZr5+ZQbas+Hjlotgp/LwtLM2XjIw7JEzQBoQY2zyIzqYLlGxuoZoQThGSIwOntfExf85XPPPyovZK1kjJ3cEgIuCwRPQZeuNq/sZ0xne75VPDWXRnpDsVpEZwzcHDEl1pNagsRoMIsVwyD2MjK/E/eHeWYoA01jCJO/K/gvkmmBGMkHVv9WuD3bToU6a4x5HLnk+m0MqOqewrT0P28gZWchjUtkrS03jotIXfqrFo1/Aoig6mfjB3+kc+8ACnVaoVayHvpFrIEzXy+ueYK4r7NsmfE1XCjZJYKjNwsFR9Qu3bpCknuzSMzwlOm510Dt0zweA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(6506007)(53546011)(82960400001)(6512007)(2616005)(66946007)(86362001)(38100700002)(26005)(6666004)(478600001)(6486002)(66556008)(66476007)(5660300002)(7416002)(2906002)(41300700001)(4326008)(8936002)(316002)(36756003)(8676002)(31696002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1lBL0gwNk9ua1ZSbm1EdTNrbUtGbkhhMGFMUWFEcGpYMkJkZXI4UURlZDds?=
 =?utf-8?B?eUxPekx3V1E1YmVhamY1SXh0d2JLYUxsditXTlJHaGxGNVExeXlTWS9wL3ND?=
 =?utf-8?B?djNKZ3N4ZlVlbXNjTVVZZWx2ckNoRGtHQXJTR3VWSzFvK1BuSDVERTNTeHZ6?=
 =?utf-8?B?c1N3RXpsdjJuQ3Q4Q29xZzNIRXlBZXkySXpLaXZkMllwR2xFNkxVdmRISXFl?=
 =?utf-8?B?dzdHcE1mbmRkVkRGclhCbFV0d0NWQytaZG54S3orVWo5UDRkNmd4M2I0RXZS?=
 =?utf-8?B?c3RqL2wvcmQxcXhHN2tXTS9pVFFYTEpIVnFVUkIyTlNEVGJTeHZDNHd3dldZ?=
 =?utf-8?B?b1dXaHNyV05YM0JOSlNncHYxZEVmNCtoSzlGRnhEN3p6OW0ycDQ5NUMwZy94?=
 =?utf-8?B?N2RaVkNRY0Q4Q0VKbGFTN0MxcmM2ZFc1VTgzSEtWNjdzQ1VqdmFGL0JKRDhH?=
 =?utf-8?B?V0gxb1JKdW1FaHFLMUU0WHg4Y0VpaUZaV2RPOHZ6eGUrL2FTTWZIN29iaVRy?=
 =?utf-8?B?TlI1RENtRm41YlVHYkEwZUo1UDE3M2hGMjhRWlRMUE96UDhWaXg4YUJTY3k3?=
 =?utf-8?B?WTFLRHNEOEdGSEhFcGpCRDZ3aDZhazFvR241WEs5V1NidlRXblliU29nTUJl?=
 =?utf-8?B?MENRZThDOTc3S0ZjZ3A3cHEzVWV2SmNqUDB3a0hlR3Q3QW1NTFBxUWF2ZGl4?=
 =?utf-8?B?bTZkWVBSQVNvc2lIeW55U2pBcUlvSkloSnhkNWNzR2RzYnBzclZQeVhHa0Ja?=
 =?utf-8?B?S0szY3lTV1EwSS9LMXlVSDdpQklqUXJhdUJKbEI2RnZtZVI5aUxIMDV3YjYw?=
 =?utf-8?B?RU9uZjYvWU40amp6NEw5VDlxbEV2djNFYlljcEt4Y2cwdGsxcUJKRWkwQ21k?=
 =?utf-8?B?cG5scDRtaWJxZ2U0dWFmZW9PVUV1WFY5WlNvdUtMdkxBaG9YcGZWc1BXbEda?=
 =?utf-8?B?Ymt0d1MrVzJxM1pxZnhyNVBhVjMwL0tPQ1dPR1RMbHpqRDRnU0F6NStFelho?=
 =?utf-8?B?K2xIUHhSRXpQOTFFOVdKODQySUF4M0NwWXczUzJTdGVCaGlqeFpQUXcrZ0V6?=
 =?utf-8?B?eExFV1NEcnh2RE9TS1dpcXBJZnBER3ZnenNXeDVxaU9HSGk4Z3QzNGtNUUtr?=
 =?utf-8?B?d2RFMno2WFpweVRpaTZwb1AxMmRCSm4yR1pwQnJiK1NSdjhsZTRGNzluWXhB?=
 =?utf-8?B?bE5GcDh3S1kzUWJrSXIyUGhqZTR3RTBuaXRLc1poU3daT3lmaXZueGJwcEly?=
 =?utf-8?B?OG8zZytPcHVHaWpOYndYTVdvQUVKcGt0R0hoMWlHYzgvQ0x6LzRCVFFPK3BD?=
 =?utf-8?B?Wm9vNDR5Q1BGOFZpMzVpWFRRU0JHNUpvN2dpUHdrWk4zcjkzajd6WUV6NEQ5?=
 =?utf-8?B?azBZWjBHTy8xaDh4QVBIb3B3anlPUUhvNkV1dDc0amlmSkFzakx2aXF2VFVa?=
 =?utf-8?B?VjBUTTFRZVBybEtLbWVIQmovZ2sxM1BtVlpsMlgwWlpqNkl3eFdNZWhib3Ba?=
 =?utf-8?B?ZnQxZDBISHJFVW9SQVJYK284bmZhOVJMcGVMMnF2VGVTVFkvVzNnQ1NOdWY5?=
 =?utf-8?B?bzUyQzl1QmMrTlJyNzNBN0VHTklXMUtacFJ1NFdSbk9lYTh3bVQrNWRCTnho?=
 =?utf-8?B?NTBWTTZ3Y0hVellnL1lsdVNOVytpaUsrNWtncUtFWjljYllETE5OeEsvL2pa?=
 =?utf-8?B?R3p0eTJOVVVHWTdES0MzQUM2MHplVm41M1VUc083cG9sOWE5ZVpscGJTZVNj?=
 =?utf-8?B?c3kzaEt2TXFHcHQyalduWGZ3dmJjT1A2RGl5ditHc1BpQTN6d0xyLzZ3R2Nw?=
 =?utf-8?B?RDdvUWRmSHFaRlpBRFVEaVJLUWVZZHdlUkFSY0Z2NmVtOHRnUmxVaVhCUTJO?=
 =?utf-8?B?YVBjeEQ5RDM3TGYzQmZxbUtFb05GdWJlaDBVWTVnWjFrM28zUk8yc1dwUUp2?=
 =?utf-8?B?eEJKN2pKYXR2S3lkUkVDak9RMnBnMnk1REYrVEVFdTJjSUJlbERQQ1duTGd1?=
 =?utf-8?B?dmphN1I5UWhKeUkxZkVncmt5V0VWcVJiejIvbHFzaEl4L0xUVzNwTmo2eFND?=
 =?utf-8?B?TnN6Q2psaFEwTzZ5UEppUDd4UmFIOTlqQy82RGk5RGhuSGtNWlB0Zlh6Y010?=
 =?utf-8?Q?26IbFB2BR306KcJxOCmClTlCW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4b181d-4372-46bc-2916-08dbbd944399
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:54:29.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGCcDaxxaos2zN+cI0mxrFnD56OgC0E9/zsonI4bST/rZY+juZVK/eBJHLh12CoSPhNK/qU2DZ2SlDbRHLYV9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
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

On 2023/9/21 21:33, Baolu Lu wrote:
> On 2023/9/21 15:54, Yi Liu wrote:
>> This adds the data structure for flushing iotlb for the nested domain
>> allocated with IOMMU_HWPT_TYPE_VTD_S1 type.
>>
>> This only supports invalidating IOTLB, but no for device-TLB as device-TLB
>> invalidation will be covered automatically in the IOTLB invalidation if the
>> underlying IOMMU driver has enabled ATS for the affected device.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   include/uapi/linux/iommufd.h | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index 18a502e206c3..3050efbceb57 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -510,6 +510,40 @@ struct iommu_hw_info {
>>   };
>>   #define IOMMU_GET_HW_INFO _IO(IOMMUFD_TYPE, IOMMUFD_CMD_GET_HW_INFO)
>> +/**
>> + * enum iommu_hwpt_vtd_s1_invalidate_flags - Flags for Intel VT-d
>> + *                                           stage-1 cache invalidation
>> + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
>> + *                           leaf PTE caching needs to be invalidated
>> + *                           and other paging structure caches can be
>> + *                           preserved.
>> + */
>> +enum iommu_hwpt_vtd_s1_invalidate_flags {
>> +    IOMMU_VTD_QI_FLAGS_LEAF = 1 << 0,
>> +};
>> +
>> +/**
>> + * struct iommu_hwpt_vtd_s1_invalidate - Intel VT-d cache invalidation
>> + *                                       (IOMMU_HWPT_TYPE_VTD_S1)
>> + * @addr: The start address of the addresses to be invalidated.
> 
> Is there an alignment requirement for @addr? If so, is 4K alignment
> sufficient? Perhaps we need to document it here so that user space can
> calculate the @addr correctly.

yes, it should be aligned. let's document it in the kdoc.

> 
>> + * @npages: Number of contiguous 4K pages to be invalidated.
>> + * @flags: Combination of enum iommu_hwpt_vtd_s1_invalidate_flags
>> + * @__reserved: Must be 0
>> + *
>> + * The Intel VT-d specific invalidation data for user-managed stage-1 cache
>> + * invalidation under nested translation. Userspace uses this structure to
>> + * tell host about the impacted caches after modifying the stage-1 page 
>> table.
>> + *
>> + * Invalidating all the caches related to the page table by setting @addr
>> + * to be 0 and @npages to be __aligned_u64(-1).
>> + */
>> +struct iommu_hwpt_vtd_s1_invalidate {
>> +    __aligned_u64 addr;
>> +    __aligned_u64 npages;
>> +    __u32 flags;
>> +    __u32 __reserved;
>> +};
>> +
>>   /**
>>    * struct iommu_hwpt_invalidate - ioctl(IOMMU_HWPT_INVALIDATE)
>>    * @size: sizeof(struct iommu_hwpt_invalidate)
> 
> Best regards,
> baolu

-- 
Regards,
Yi Liu
