Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FF87BF161
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 05:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441984AbjJJDY1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Oct 2023 23:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441995AbjJJDYZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Oct 2023 23:24:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A8CF;
        Mon,  9 Oct 2023 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696908262; x=1728444262;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ZyTRtEBcZL9Y+8+G6h3FpsBxdhtGk9ASAEH1AMNBOU=;
  b=m7D5/lAtqc8zLi28ZpHd7TThVS/18tTd9Ol1wazjGDsNNyFFWwKFSQ14
   DqibzJfnjPenIJ5uqq8s2/mjFgiML+bJdHtXJRdNXOT0nm4o7gmD7g9bC
   nURXDB/+Mu1YOCNkVDAtbOvMQMAVWJ/BZlFk2m7MVMzrsDmtO+buvhuKk
   8fsumgGZ5PoD2V+bifjqzcNMBAqXxkCrJEQ3daJmrdGtITEjm01GuvPcC
   cd7Axm/IpHjQZ2snOxrTmrTT7OttR2/91M7pTGLxvKKse+fCBd7NnSD5j
   K62iC3zOdbzm33mPdu0w/Yte6oXzEC9CnG5ARg4Mkja3Z7Y2aDQAzXsa3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="5856967"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="5856967"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 20:24:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="877060380"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="877060380"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 20:24:21 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 20:24:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 20:24:20 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 20:24:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSaglG9AO/dVzUAOJkWaXkQV1aw3k5hx0OW0Uq2LOzb1XlCyam2jZh4+NlxvLHwgLVnbiM63/n/CE5Pp08xnG3ixiXAYsJk/k9a+MIjZJzlY1DPzr3nJgNTICDSh444SZr9OfGfW16patnFvT/F4hyLSaKOGwrJwTbhxMNSrLamFbcjyhYF0cDaUZrPRO6yq4bUAWAQqDYgQX/p5Znv7VY8EL1ll1yr4il7kq7VzNImg5behzOQfZpvXXrsdgVHqmFxOURZ7GOLmL1dR95FiQtBiJ39YBHnbh5lCRF+/IGMwQZFAH93OKuWkbLOh58Cu2niCKmLFys7dLNSB4QqOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/dUtY7Y6mbppVawRZE362CC3xz3pq5J8VoUG2iYOns=;
 b=XCE+nt7lmf4Tu02bgo+/zSWlPVLQQnUOIj3ekPQOvMsDoLuk2CTG1ucYJ6T26cz33fhu4wu7/CxPgjcnPerB42en9G4CarRVmg4Urr4SdNjn+ywHsEjcbYqw4+b58vp42Peck4tUePzhe8D/1ieNz6wtM/7bs7VRHc0UqFiAr1YgUFxuVqZHN5khhose9VBiEXaoK3hV2rDOCrWxsgzVUVajUofQ8vVjJdLnaLlpXIElbE4j6J5oUp1DJvMfxpd4s9XuvM5ZBtTuwmRMtIWkI6Tk5vFRJolcYPFwc2UseAVJrgK6mtGO1r5BZEtVIHAcEgLEbw+l57RsTxprWDgjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6236.namprd11.prod.outlook.com (2603:10b6:930:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 03:24:18 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 03:24:18 +0000
Message-ID: <1b27b31a-3eaa-0acc-b9ae-756605170220@intel.com>
Date:   Tue, 10 Oct 2023 11:26:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 03/17] iommufd: Unite all kernel-managed members into a
 struct
Content-Language: en-US
To:     Yan Zhao <yan.y.zhao@intel.com>
CC:     <joro@8bytes.org>, <alex.williamson@redhat.com>, <jgg@nvidia.com>,
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
 <20230921075138.124099-4-yi.l.liu@intel.com>
 <ZSEuBcLaSq4NjoC8@yzhao56-desk.sh.intel.com>
 <c299567a-5be8-f65f-d8ec-ffd3fa183b03@intel.com>
 <ZSOMCXBzUMRujp89@yzhao56-desk.sh.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ZSOMCXBzUMRujp89@yzhao56-desk.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0115.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::31) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6236:EE_
X-MS-Office365-Filtering-Correlation-Id: 7695727c-eb2b-4158-1f14-08dbc940634c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZYEM5s1ZGhy2bMVYofB3oHGbjPyfs2cz74wcDFKNUJRXidLGQ4ePDLeBUFq59IL/NjxUadBLhBjc6VVQDPB+PRJ1/yPyNMhlVvsgdtEkkj/oHoEpLyiU6AzyEXZONGsNV3cGO0Z9SHrVOR0je706NZBhR1esDoS/ekj1/DAj+5arFfhdZHc2aVrsJ9lUcpYW5ttmTwnJ/bIiRCfiEXuWcaqogF25PMFKY5ABIcaz+0hUnA1oAXX1OH7gk/xXYYYd96hbCnT6oPCLYDDwUlO/dz2vmsYDEZNfcN4UnI09NwGhB/KbYU17ErULN6QIidbSRVRrTiNt5wnHPOVTDSMq06jcoJxFa1pPqcOUNVUfahlIqCIB32RaadL/pQ3NvRGRSguDLNAruoUD5ELJz3HJNmOFg0BOl2t728nmNQC0oF6paHRhRcv6Decfu4L0zT/5hkVlk1IFo5kGAQy2T5aKB+JyLVQCZFzoDGVK/EWlG3cEUMx2QxuQE8MYqxzcuYj2UF/kpL8IehCrYOEllegQBCNB0IUGYZBr37jgADNDkQzcS7hm07WW8zvhdHBStU/2zPVOVWlEfkGshYmwG4Trb52zHqLD4m5z3P3kV314pDvZY645a96rkTOL/MDwpqcUcJSDU7R2TbNB3A3xJ2VnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(2616005)(53546011)(6666004)(8676002)(6512007)(83380400001)(6862004)(7416002)(2906002)(6506007)(478600001)(4326008)(66946007)(66556008)(66476007)(6486002)(5660300002)(8936002)(316002)(37006003)(41300700001)(6636002)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVZJUXNQOS8vVnRDMG1WTkp3OS9oYml2a3dCSDdXeG1rM2dNaU8wcFZJTWYz?=
 =?utf-8?B?QUx4VXNWYk43Nk13QmRaei93ekpSSVFwZzdYeGZpTURqQmJvc24xRmdZV0lU?=
 =?utf-8?B?NmdBUnRHSmVUaGJoaTZRSzZzVHNqaE96OFdyZlBPOCtreC9QWEF6K3RzZmha?=
 =?utf-8?B?cmVjdjNxaHdEVVVMUXpLK0lOcHRuL0RWdThwZHNLMjE1SFBweWFOdGQ5UnRp?=
 =?utf-8?B?QVVlVm9kcHJ3UzRxV2MzMDlKKy9zOGFYRUxYOHBRbTNLR1ZMOURqVnU2dDZy?=
 =?utf-8?B?NVczeEo3TXViUjN3UWQxL3lIWitzcTFvVEVkZkZ4SUk1V1pXNWQrWmVIRUxz?=
 =?utf-8?B?aHBzbm04L0dFQ1F6bnlrZk9WK29iTkcwR1Y4d1pKbHVUb3lVR3VuS1Azekc1?=
 =?utf-8?B?TnZrenc2V0xwVHNjNllhOGtsRlpuekRnQnZ3aEFNOGlRNDJUVFBkWGRyV09h?=
 =?utf-8?B?d3pPSnFsK3RCOHprVmhRVWNWenZocjhVL1pZdnE4eEdheVFVNnZoSGw2MTla?=
 =?utf-8?B?MTBUWVVxTTJObm1YeDZCcnhVbFRCejd5cW9FN0ZKYnRZWDBVNVAzOHl1UnIx?=
 =?utf-8?B?TEVjV0EwUTRYUGczZUdwTzRkeVp0bWF2SmxNWGp4Z09xMHQyTzc0TWdZR0VH?=
 =?utf-8?B?dEVHbmxrK1FYL3Vzdnc3TWdvL0QvK2FvMitSUHJVWGdIa1VOSmg3MHhPbW9J?=
 =?utf-8?B?QXZaMDZOYU9XNDllcWtqclRFaUp3RG44U3l2NzloOExTNDBnNlJYOWFOZjhj?=
 =?utf-8?B?ZGdJTHR1d3V2cEVLekxqR0lhYllrbCtXeXhLMEdRSmF5aEgxeDhiaDZFRmVZ?=
 =?utf-8?B?WnJ3TzlJaWtWWS9DbmN4WWRpdlRRd0NnWHhuSUh2YStPYW9BbjlVaHFZZHNY?=
 =?utf-8?B?emlJL1UyQm1EaUtGQThHeW5zUVhrL0U0bXNsUm9Qa2FFVHN6aVpmTTBaMWtR?=
 =?utf-8?B?MDROVXNtUmU3czQwbDRnRGo2eHl2WVlQMTdHWHFJSFlWRkdLMkhNNVQ5cjQv?=
 =?utf-8?B?M1hkdmpwUktVODJBQVZ6alBlZUh0NitJMllsSHltanJZeWJ1K3l5SGJvMlUz?=
 =?utf-8?B?TDI0VEN4WEFLTStVRnViNnR3dm0wYjdHUlI0UWFWRlVPZ3Fxc0U2OStWdWh3?=
 =?utf-8?B?a3hINDdQRGlYS0tBY3p4YnYycWU0OTJOZFZOYXJWcVZjTFA4bXozNngweHJU?=
 =?utf-8?B?WmYrUjN1RGI2bS80c3U2RDFLVXFlbUZPYmxGaitoOWFxNXlUeTdSbGdvU3Fp?=
 =?utf-8?B?YXJ1ZVp0bWdUMmdWamluOVFWQmxlVGpxeGdDMFVGWUVzWTUxaTVsRlNMOE1p?=
 =?utf-8?B?cFhBSlJrdXNHV0ZKeVY4VHhoUHVMZGVWbDYyZ3JWOGVuS0YvcEQ0ODlYeHVQ?=
 =?utf-8?B?WWs0R0pnUlROb2ZvQWJPL0JtdFd4UndwRmUzYTYyWVdVd0VHQWg4dDh6VzRr?=
 =?utf-8?B?R3hFbUVLVG5FWTliMnF1NkwwZlNRZzBlSmJoNlcwTHVSN1dRUGM4ME05ckU4?=
 =?utf-8?B?eG1pcFBTdGRselFDN2c0UWJiNVlwTUpPQzFqOFNXbVBQVW82VVJKSUtCZmpy?=
 =?utf-8?B?NGxlb3hqNVNFSk9URFNEVitiL0V0WFNjRXI3UkszRWdKbCswWlE3ZGM0UWRL?=
 =?utf-8?B?SUx1TjNsaE1qazBTU0gyemlVVjJkVkk5WXlTU1RZRVFqbTU4cUJ3TEVlUUtP?=
 =?utf-8?B?cStUY2pzai9TdlZmak1pelp3MnFpVmNuWlBDUFVsRnl1eFQyTkpUUGlRRlhT?=
 =?utf-8?B?U2RsMDZNTGMyTTRnNE9tQnJNOTl1enQ1MjArZml4enlTR3Q5UGcrbktmTGxi?=
 =?utf-8?B?dyttM1JTSUtMdjdVUk0rZHdGck5DT0tyQUM4TldxTmlrUjc0eVZyQmJpSTE4?=
 =?utf-8?B?OXRMTHFHT2x2NHRKU1VUVnN5SmNGbHhycGhsK2tNVVhiTmVaUzVXNHgzRlg1?=
 =?utf-8?B?dFQ5YVl6NzVyQTd4Y2ZCMDlKcWtmTmpVTVUvZ05Bc0p0S0ZUd1VIQ2dBb0pa?=
 =?utf-8?B?SWlBcGsxbllobU9tUEhPRUErSndIVFpIeU80SVVNSldkU1FkbGdCVDBPdmVa?=
 =?utf-8?B?UFFUU2NITnY2M0tOZGRUTkdUM0pDR2k0SFBJallBdmVKeEpLNi9rRnBQMHpM?=
 =?utf-8?Q?NSnDEYJhAzIsLJRHMxaS+S4XZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695727c-eb2b-4158-1f14-08dbc940634c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 03:24:18.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uq50BBWCLhpS/PsIAASEOY+8fcYxfdBBo+lFYOPINjYXwYGS2AOTbzNYvZk4xQwelt+RZAHdV4V1nKWAF3kGaQ==
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

On 2023/10/9 13:13, Yan Zhao wrote:
> On Mon, Oct 09, 2023 at 12:13:52PM +0800, Yi Liu wrote:
>> On 2023/10/7 18:08, Yan Zhao wrote:
>>> On Thu, Sep 21, 2023 at 12:51:24AM -0700, Yi Liu wrote:
>>>> From: Nicolin Chen <nicolinc@nvidia.com>
>>>>
>>>> The struct iommufd_hw_pagetable has been representing a kernel-managed
>>>> HWPT, yet soon will be reused to represent a user-managed HWPT. These
>>>> two types of HWPTs has the same IOMMUFD object type and an iommu_domain
>>>> object, but have quite different attributes/members.
>>>>
>>>> Add a union in struct iommufd_hw_pagetable and group all the existing
>>>> kernel-managed members. One of the following patches will add another
>>>> struct for user-managed members.
>>>>
>>>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>> ---
>>>>    drivers/iommu/iommufd/iommufd_private.h | 17 +++++++++++------
>>>>    1 file changed, 11 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
>>>> index 3064997a0181..947a797536e3 100644
>>>> --- a/drivers/iommu/iommufd/iommufd_private.h
>>>> +++ b/drivers/iommu/iommufd/iommufd_private.h
>>>> @@ -231,13 +231,18 @@ int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
>>>>     */
>>>>    struct iommufd_hw_pagetable {
>>>>    	struct iommufd_object obj;
>>>> -	struct iommufd_ioas *ioas;
>>>>    	struct iommu_domain *domain;
>>>> -	bool auto_domain : 1;
>>>> -	bool enforce_cache_coherency : 1;
>>>> -	bool msi_cookie : 1;
>>>> -	/* Head at iommufd_ioas::hwpt_list */
>>>> -	struct list_head hwpt_item;
>>>> +
>>>> +	union {
>>>> +		struct { /* kernel-managed */
>>>> +			struct iommufd_ioas *ioas;
>>>> +			bool auto_domain : 1;
>>> Will iommufd_hw_pagetable_put() also be called on non-kernel-managed domain?
>>
>> yes.
>>
>>> If yes, hwpt->user_managed needs to be checked in iommufd_hw_pagetable_put(),
>>> (e.g. as below).
>>> Otherwise, this union will lead to hwpt->ioas and hwpt->auto_domain still being
>>> accessible though invalid.
>>
>> not quite get this sentence.
> I mean with this union, hwpt->auto_domain or hwpt->ioas should only be accessed if and
> only if hwpt type is kernel-managed.

ok, I get this part. just not sure about the missing words in your prior 
comment.

> So, any unconditional access, as in iommufd_hw_pagetable_put() pasted below, is buggy.
> 
> Therefore, do you think it's better to add a filed like "bool kernel_managed : 1",
> and access the union fields under  /* kernel-managed */ only when hwpt->kernel_managed
> is true.
> 
> 
>>
>>>
>>>    static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>>>                                               struct iommufd_hw_pagetable *hwpt)
>>>    {
>>> -       lockdep_assert_not_held(&hwpt->ioas->mutex);
>>> -       if (hwpt->auto_domain)
>>> +       if (!hwpt->user_managed)
>>> +               lockdep_assert_not_held(&hwpt->ioas->mutex);
>>
>> this is true. this assert is not needed when hwpt is not kernel managed domain.
>>
>>> +
>>> +       if (!hwpt->user_managed && hwpt->auto_domain)
>>
>> actually, checking auto_domain is more precise. There is hwpt which is
>> neither user managed nor auto.
> 
> auto_domain is under union fields marked with kernel-managed only.
> Access it without type checking is invalid.

I see. yes, should check user_managed as well. :)

> struct iommufd_hw_pagetable {
>          struct iommufd_object obj;
>          struct iommu_domain *domain;
> 
>          void (*abort)(struct iommufd_object *obj);
>          void (*destroy)(struct iommufd_object *obj);
> 
>          bool user_managed : 1;
>          union {
>                  struct { /* user-managed */
>                          struct iommufd_hw_pagetable *parent;
>                  };
>                  struct { /* kernel-managed */
>                          struct iommufd_ioas *ioas;
>                          struct mutex mutex;
>                          bool auto_domain : 1;
>                          bool enforce_cache_coherency : 1;
>                          bool msi_cookie : 1;
>                          bool nest_parent : 1;
>                          /* Head at iommufd_ioas::hwpt_list */
>                          struct list_head hwpt_item;
>                  };
>          };
> };
> 
>>
>>>                   iommufd_object_deref_user(ictx, &hwpt->obj);
>>>           else
>>>                   refcount_dec(&hwpt->obj.users);
>>> }
>>>
>>>> +			bool enforce_cache_coherency : 1;
>>>> +			bool msi_cookie : 1;
>>>> +			/* Head at iommufd_ioas::hwpt_list */
>>>> +			struct list_head hwpt_item;
>>>> +		};
>>>> +	};
>>>>    };
>>>>    struct iommufd_hw_pagetable *
>>>> -- 
>>>> 2.34.1
>>>>
>>
>> -- 
>> Regards,
>> Yi Liu

-- 
Regards,
Yi Liu
