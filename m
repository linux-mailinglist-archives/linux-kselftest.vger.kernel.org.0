Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA9705DB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 05:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjEQDIi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 23:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbjEQDIg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 23:08:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F3D171F;
        Tue, 16 May 2023 20:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684292914; x=1715828914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J7lxeLbJhP+Nbq8dObGHLLHqSCGEiPGBfRx5vEGlC9E=;
  b=TbGrV+odPozPO4+DDUy0UgfOtR9ROZr8vejDga/apicuDyP2ylpjZzVA
   Bbr3so2SkM9VKBuuXLu/DWXMy2Ts7osOn6A6Hj0OYee1ZFgPsIm+MN9UE
   CJjXk+2SdeNkKHI9FxCi8ZSe3eKeVnuauI1B+GBfBnslWSzc1Ekv6mhvr
   X5c10W3kHSdx2RYjHqXJHZEg60JEwLNxd7EL7ep3xL61cM8B1IeBMgpSK
   tJpoAmo2m5IxCX8xAL3c1d91CMV+LYLEI3LkZDjmemAwiXk7hlNvKpyPz
   v2d5Gw1ZXXO/oCoiSVfGmcw0yL10btTT9ePbV1w4pKPLzQqO5YO3ZdCdG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="437995516"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="437995516"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 20:08:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="813693451"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="813693451"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 16 May 2023 20:08:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:08:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 20:08:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 20:08:33 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 20:08:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3yKilqe0PgipLg59ImKi129rEPNURjtDqbAFmh/2zbqAlIzD8EfWmOr8elhcz1TX+3CP95OFBrVtJWwlfgd0koL3zVrZ/Ro8HzJ4yVRaZw3q/pvb1E2erq5c/i5kwdamz6qQZfW5N8FoAcFZN/E85zlzdNnNS7TArf+qtuhpIk52MU9nRI5WDRDEtf4ssYHy29GQSHLpjzCjXgAgQ9GtQlmP0UEYBq7FY+NEnkOPTVspZIrY7g2v3pGkK1Td0oHSdaIic/SuWhGKi25czIiCIyadZtdYtn34cNJkKPmx8MiBzJBdkKB0VQ0kzFoxXUvX4zxnAUY/M7pdjkD8Ge1bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEhCwNGmWBZD+6CRjUfokS717TnHmbjHh325QwRIXfk=;
 b=IkGsi8/m66TApYo4hzxZHZsT9PjDrI4fx5OCzrj8WvFmfES1GE//3NPmEtnj/USVck/7T4ACQvl0g8ikhNzR1XJjwu2c+ymDdVrXB0cOcnHc1mM08IypFJWDv55bngvKdKNGMT3LmscHlmdjPAEKt6skiBVeQUfERoklKnrf9N+I14VYdPN811QtVFPZp2lOmNzbuPesuXTcuaGMiA70EXUtdLd8itA25KF9dCwj/1TjMLKwgXcCRc5Xi/HFNu+GM/H/pk92uiR4nDwrlxpZDUKdu8z3RkZEuKnHedds028k39aQoyJ473YmBao6+mdU3ZltvKkw2IbCrtbBmQjm7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by SA0PR11MB4765.namprd11.prod.outlook.com (2603:10b6:806:9b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 03:08:29 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::e825:c2b5:8df5:e17b]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::e825:c2b5:8df5:e17b%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 03:08:29 +0000
Message-ID: <4bb0b861-2b01-746c-88a8-c3d675a3d4f5@intel.com>
Date:   Wed, 17 May 2023 11:08:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/11] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
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
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>
References: <20230511143844.22693-1-yi.l.liu@intel.com>
 <20230511143844.22693-7-yi.l.liu@intel.com>
From:   "Liu, Jingqi" <jingqi.liu@intel.com>
In-Reply-To: <20230511143844.22693-7-yi.l.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB5469:EE_|SA0PR11MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 93c555de-79e1-4005-af25-08db5683fce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9RJKQ2HL5ZFoPSMEt+iVf7PIJubEtgKWHRgq4PcV0YoRfEJtKHx9qHfgd5MGeUhtO2MpeNpXLRXQIvBXw2hvdSF/qnGkJl2Gmr8EjL/oo8DEAXpQybJZUr2spM5/41jNHm5aK/OSpuiTG0qzlIc+aFoLpb4GC0RQ5DMeyJXDCL5NtRnPhBMeAt2HQ/fHsHf7Hw4qv/2UbkfvAu5frVHqR1xpRqre0VTSuG+sN20EQ/t+ZLajomd/InfgMnNdQ98UlBDwneVW5njndM0JRz8g+WgcFCRsTdOtRMJ6koPGjCynn4GOpiR7mSujbim3LI4rdbBuWopasmXVXuKve6fE/LKl4kcTGpOlgPFD1ljZrlwBOkiV296SP3DUfJtBtFySrqxOlLFMb/oOS3BeHrcdQpDbdPKcaodxI9IoMBdv2FsvXbayBxkVftLMJlp87TjzlwAOKiR89qdwkHEIU92ROcaHyjHEH32eWFqVYGTZQoaI4Tj1EwMcsm0XExoL9BFwfZ8JMQbAQ+PWGqhT7XTFwSEImyjPgQqnvqbmdr0BKNZv3N3VxWZGgaFzAwV8n1ZDSyKEbQG9Si1kGbBINrcjfhV4kAHtVECKlPn5AXKR4HXUVFzzaSH9XVg24ANhMajsHRp1f+KU0av2536segamuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(36756003)(31696002)(86362001)(316002)(4326008)(66946007)(66556008)(66476007)(478600001)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(2906002)(7416002)(38100700002)(82960400001)(2616005)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVuSVQva0p6eTQ4Q1BUUWtHVGVsTjJVdUdxOTJVUTVIaDczR2hMWFJheC9w?=
 =?utf-8?B?aUpBRVRTY014QXJtb1ZObmdvQlpLVDhTQzRldnJmUGxaYm9OWlE4TWNFQ3J4?=
 =?utf-8?B?cGRpa2N3eXYzenJDS0pRYTN3SnE2Qm1JZnczZEpvdXVjRmI4K29Id1VGc1ZH?=
 =?utf-8?B?anUvY0dLM1p4NFR1N1hwQ0Q4Q1RhNjZnRGNlU2ZjQ0xhZWExc3YrL01ZZDgz?=
 =?utf-8?B?bi9FTWp2cU5BNzBZNDZKSlExWVEyaWdiaTZaS0wvZTl5b2NiRnovVCtqSGNQ?=
 =?utf-8?B?bjVZZnhNUlVUOStrRGc4d2pBWU9RaDllNERRVUdvQ3hCM3Bhd21XWlBJWUdv?=
 =?utf-8?B?Zm90aHNZbXpVU1JuVTBSRDB0NE81TlVRMnB4cVVUem5aR1ptdEhBSkoyRndX?=
 =?utf-8?B?QitKZUo5M3k5VnhvUEdTTG4wU2tWbUtudE1JTG83cGRXVkh6OXkyQ2RIRGVH?=
 =?utf-8?B?ZmQyZ2o2TVI5akl2THd4YmxBZ0o3eEorcWh4TW1ZWnZkUG1JbVhWZEVlZHZk?=
 =?utf-8?B?M0xpeDJBeHRPVjBMZGNKS1RacXV5aDdnZ0dIUUhqTkFkY2Uzb0FQRWtvdlR6?=
 =?utf-8?B?WUxEdkszS3BCN0hETW5QbTU1eDhTcUU3VmtvWlJKYkx0NW93RVowRDQxSGdZ?=
 =?utf-8?B?aytTYUp4Mk94VkZ3OHd1a3hrQkRoblUrbTMwdEIrNGpscUxCZytVbnFQRU1R?=
 =?utf-8?B?bzl6MnljYlNDUWFpYmhTUnFKU3BNQ0NlRjNSc3c2b1JkSVZUdC9vQzk2V3E1?=
 =?utf-8?B?eGh1OXVoKzhsTDgyaWk3OGloczBqUHF0UWJSMmZtRFl3NFkrUXpiL2srYWdr?=
 =?utf-8?B?akJPVGl0c01PNzA5OHowN2dkRXRsQkthMFl4VEk3VUhmUGY1WHpxNUFIK1ln?=
 =?utf-8?B?eHVZU2NSbDlBdzU5cEhVU1MxenViZnI0cW16L3JoTmoxdVAyRExyL055eGx0?=
 =?utf-8?B?MUlCNnNYb3pvZ2dJdkNsQ2NTejhRQnhDY0ZacDVINHVSd01DRlI2M29sRTEx?=
 =?utf-8?B?aGMzSFhTbmRFMTN4U2g0SlJUeGJLci9jenB4bGYzUytRMmtKVXEzTVNvUGdy?=
 =?utf-8?B?UUE0d1NKck9jZHFPWVQ2cTRCWWx2OENzZ2k0K0VUd000MFVLeTRWeFlSMmNy?=
 =?utf-8?B?QmhiMXdrUEk2eGtGQlpHQXFGNFNBVWRCMk5jMzhGOGtzcE9kemtZTm40SEtY?=
 =?utf-8?B?UDNxaCtaTUJmNXhsa0lwejhqamJCbnZHWitNMWFUVFU0bHF5SHZPVy9tR1BD?=
 =?utf-8?B?bWVSL2t4MS8wNWIxbHlxSENXS0ZtL0FoMktYQS91U3p5ejkxNGRlMWlPOHdC?=
 =?utf-8?B?RFRRVTE5Ry9Ka0JhZ1poTTJSbTFJMFZScjRLRTBoNHVPejJyUHRmVUJ3NmZY?=
 =?utf-8?B?N21jcFh6ckxqanVxdEVHNzJzYjQ0YkFReHpHY2NyK0FJT0hTK0pTTWtKdERo?=
 =?utf-8?B?dTA4RW9BSXJFbUEzRGROS09GQ2tZbnVPOVdrODVZbmcyWks3Um5DSUJJeCtM?=
 =?utf-8?B?VDhzSnl5SFJ1Z0tqM3pSZEw2YS9YakpCT21YMzM3TjVkZkUwMzZkWG1ySUgx?=
 =?utf-8?B?YkEyU2h1SVpuQ0xydit5OXZTa1ZHaUd3NnFURjI4QmhzdElsNjh1N01oN2J6?=
 =?utf-8?B?eGJMMHdXMFFVTWFZZUhEYWN2Mkp4ZjNWbUVXOGRJQ080WS9ZLzJBazlpNy9x?=
 =?utf-8?B?RUpIWWYwNWRqektieDBhOFhvdDVNbzEwLzJ3RXpVdEx6Rm5wVVRhakhUeSs1?=
 =?utf-8?B?WGtNUzIvV0c3NnlMYVZnTUd3TzREazNrNUpsdHNCUlJkYmZ4TDZjZVFoNXBG?=
 =?utf-8?B?V05QWTFkbjU5cUVCakVyRlFnWXZjNjB5a2Y2cm12N2poUXZPVXUzSTBNNHB0?=
 =?utf-8?B?L1k2TTlTY2hWOHlFUGNQNk9BRGsyQW9vLzRXcVVNNHZCUXhKWHRhT09pb05N?=
 =?utf-8?B?NjN6QjhrSjRueUdGSnMvV3RnTTljYVhqeGdGOEhzaitCajFJL2daeHRDTTZB?=
 =?utf-8?B?dHkyVG5CUmx4MnNYTzR3amExR3hNNUN0cGRHMnZPUTNIb09lL2N6WDUxQk5D?=
 =?utf-8?B?bWxHVzZKZWlhQnprc1NzaXZsMjRzaVZYYXpMMkRjYVFvOWwyYm5lTTdGdDJL?=
 =?utf-8?Q?UcDO7NQ/J/F+Lf6iXJgQ5djVH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 93c555de-79e1-4005-af25-08db5683fce0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 03:08:29.0691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqpz9gpxbvisMVcbpFgHTVVuSvZQMSVGelCYo1hjgPhyRkmUOGMuhrLiCt2QfkVmYQbvV7kr1AxqhhbVTu+aVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4765
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/11/2023 10:38 PM, Yi Liu wrote:
> IOMMU_HWPT_ALLOC already supports iommu_domain allocation for usersapce.
> But it can only allocate hw_pagetables linked with IOAS. There are needs
> to support hw_pagetable allocation with parameters specified by user. For
> example, in nested translation, user needs to allocate hw_pagetable for
> the stage-1 translation (e.g. a single I/O page table or a set of I/O page
> tables) with user data. It also needs provide a stage-2 hw_pagetable which
s/provide/to provide
> is linked to the GPA IOAS.
>
> This extends IOMMU_HWPT_ALLOC to accept user specified parameter and hwpt
> ID in @pt_id field. Such as the user-managed stage-1 hwpt, which requires
> a parent hwpt to point to stage-2 translation.
>
> enum iommu_hwpt_type is defined to differentiate the user parameters use
> by different usages. For the allocations that don't require user parameter,
s/parameter/parameters
> IOMMU_HWPT_TYPE_DEFAULT is defined for backward compatibility. Other types
> would be added by future iommu vendor driver extensions.
>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c | 87 +++++++++++++++++++++++++---
>   drivers/iommu/iommufd/main.c         |  2 +-
>   include/uapi/linux/iommufd.h         | 32 +++++++++-
>   3 files changed, 112 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 73d7d9d07726..e84270eb6e49 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -184,11 +184,15 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   
>   int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   {
> +	struct iommufd_hw_pagetable *hwpt, *parent = NULL;
> +	union iommu_domain_user_data *data = NULL;
>   	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
> -	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_object *pt_obj;
> +	const struct iommu_ops *ops;
>   	struct iommufd_device *idev;
>   	struct iommufd_ioas *ioas;
> -	int rc;
> +	int klen = 0;
> +	int rc = 0;
>   
>   	if (cmd->flags || cmd->__reserved)
>   		return -EOPNOTSUPP;
> @@ -197,15 +201,81 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   	if (IS_ERR(idev))
>   		return PTR_ERR(idev);
>   
> -	ioas = iommufd_get_ioas(ucmd->ictx, cmd->pt_id);
> -	if (IS_ERR(ioas)) {
> -		rc = PTR_ERR(ioas);
> +	ops = dev_iommu_ops(idev->dev);
> +
> +	/*
> +	 * All drivers support IOMMU_HWPT_TYPE_DEFAULT, so pass it through.
> +	 * For any other hwpt_type, check the ops->domain_alloc_user_data_len
> +	 * presence and its result.
> +	 */
> +	if (cmd->hwpt_type != IOMMU_HWPT_TYPE_DEFAULT) {
> +		if (!ops->domain_alloc_user_data_len) {
> +			rc = -EOPNOTSUPP;
> +			goto out_put_idev;
> +		}
> +		klen = ops->domain_alloc_user_data_len(cmd->hwpt_type);
> +		if (WARN_ON(klen < 0)) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
Would it be better if the later check "klen" is moved here ?
     if (klen) {
                 [...]
     }
If this check fails here, there's no need to execute the code after it.
If this path is not executed, "klen" is 0, and there's no need to check it.
Do I understand it right ?

Thanks,
Jingqi
> +	}
> +
> +	pt_obj = iommufd_get_object(ucmd->ictx, cmd->pt_id, IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(pt_obj)) {
> +		rc = -EINVAL;
>   		goto out_put_idev;
>   	}
>   
> +	switch (pt_obj->type) {
> +	case IOMMUFD_OBJ_IOAS:
> +		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> +		break;
> +	case IOMMUFD_OBJ_HW_PAGETABLE:
> +		/* pt_id points HWPT only when hwpt_type is !IOMMU_HWPT_TYPE_DEFAULT */
> +		if (cmd->hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
> +
> +		parent = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> +		/*
> +		 * Cannot allocate user-managed hwpt linking to auto_created
> +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> +		 * don't allocate another user-managed hwpt linking to it.
> +		 */
> +		if (parent->auto_domain || parent->parent) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
> +		ioas = parent->ioas;
> +		break;
> +	default:
> +		rc = -EINVAL;
> +		goto out_put_pt;
> +	}
> +
> +	if (klen) {
> +		if (!cmd->data_len) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
> +
> +		data = kzalloc(sizeof(*data), GFP_KERNEL);
> +		if (!data) {
> +			rc = -ENOMEM;
> +			goto out_put_pt;
> +		}
> +
> +		rc = copy_struct_from_user(data, sizeof(*data),
> +					   u64_to_user_ptr(cmd->data_uptr),
> +					   cmd->data_len);
> +		if (rc)
> +			goto out_free_data;
> +	}
> +
>   	mutex_lock(&ioas->mutex);
>   	hwpt = iommufd_hw_pagetable_alloc(ucmd->ictx, ioas, idev,
> -					  NULL, NULL, false);
> +					  parent, data, false);
>   	if (IS_ERR(hwpt)) {
>   		rc = PTR_ERR(hwpt);
>   		goto out_unlock;
> @@ -222,7 +292,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   	iommufd_object_abort_and_destroy(ucmd->ictx, &hwpt->obj);
>   out_unlock:
>   	mutex_unlock(&ioas->mutex);
> -	iommufd_put_object(&ioas->obj);
> +out_free_data:
> +	kfree(data);
> +out_put_pt:
> +	iommufd_put_object(pt_obj);
>   out_put_idev:
>   	iommufd_put_object(&idev->obj);
>   	return rc;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 5c24e8971f09..ac81403ba78e 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -302,7 +302,7 @@ struct iommufd_ioctl_op {
>   static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
>   	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
> -		 __reserved),
> +		 data_uptr),
>   	IOCTL_OP(IOMMU_DEVICE_GET_HW_INFO, iommufd_device_get_hw_info,
>   		 struct iommu_hw_info, __reserved),
>   	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index e9d42838dcbd..699e735828db 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -347,6 +347,14 @@ struct iommu_vfio_ioas {
>   };
>   #define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
>   
> +/**
> + * enum iommu_hwpt_type - IOMMU HWPT Type
> + * @IOMMU_HWPT_TYPE_DEFAULT: default
> + */
> +enum iommu_hwpt_type {
> +	IOMMU_HWPT_TYPE_DEFAULT,
> +};
> +
>   /**
>    * struct iommu_hwpt_alloc - ioctl(IOMMU_HWPT_ALLOC)
>    * @size: sizeof(struct iommu_hwpt_alloc)
> @@ -355,12 +363,31 @@ struct iommu_vfio_ioas {
>    * @pt_id: The IOAS to connect this HWPT to
>    * @out_hwpt_id: The ID of the new HWPT
>    * @__reserved: Must be 0
> + * @hwpt_type: One of enum iommu_hwpt_type
> + * @data_len: Length of the type specific data
> + * @data_uptr: User pointer to the type specific data
>    *
>    * Explicitly allocate a hardware page table object. This is the same object
>    * type that is returned by iommufd_device_attach() and represents the
>    * underlying iommu driver's iommu_domain kernel object.
>    *
> - * A HWPT will be created with the IOVA mappings from the given IOAS.
> + * A kernel-managed HWPT will be created with the mappings from the given IOAS.
> + * The @hwpt_type for its allocation can be set to IOMMU_HWPT_TYPE_DEFAULT, or
> + * another type (being listed below) to specialize a kernel-managed HWPT.
> + *
> + * A user-managed HWPT will be created from a given parent HWPT via @pt_id, in
> + * which the parent HWPT must be allocated previously via the same ioctl from a
> + * given IOAS. The @hwpt_type must not be set to IOMMU_HWPT_TYPE_DEFAULT but a
> + * pre-defined type corresponding to the underlying IOMMU hardware.
> + *
> + * If the @hwpt_type is set to IOMMU_HWPT_TYPE_DEFAULT, both the @data_len and
> + * the @data_uptr will be ignored. Otherwise, both of them must be given.
> + *
> + * +==============================+=====================================+===========+
> + * | @hwpt_type                   |    Data structure in @data_uptr     |   @pt_id  |
> + * +------------------------------+-------------------------------------+-----------+
> + * | IOMMU_HWPT_TYPE_DEFAULT      |               N/A                   |    IOAS   |
> + * +------------------------------+-------------------------------------+-----------+
>    */
>   struct iommu_hwpt_alloc {
>   	__u32 size;
> @@ -369,6 +396,9 @@ struct iommu_hwpt_alloc {
>   	__u32 pt_id;
>   	__u32 out_hwpt_id;
>   	__u32 __reserved;
> +	__u32 hwpt_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;
>   };
>   #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
>   

