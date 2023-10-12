Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E097C6909
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 11:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjJLJKR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 05:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjJLJKP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 05:10:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8C49D;
        Thu, 12 Oct 2023 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697101814; x=1728637814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OQoh7MDOynTljKBLbKE/Ubw/uK6lLwFKWJ1gjWjGzGs=;
  b=EDhaKt8/ncRF9bXPKK81L+gpWNE5dnp2sXc8RbBKND8h2ItfQokqEx5D
   XjkzYGjL9lkhiYC6IPyvD/dn5D6D8QLmkbx48ZlAgO8MMgwoYi7XoRGtC
   3J0r68eNr4Qor7Tt+veyrQ2xT4KeDyyhMcZGu/McAYZx4UbChT2wa2tLW
   BJFJxyYh7EWIc4QNBsIp22YmdQRDAYehsYB50LDAmH0nitQ5BHrA39nvs
   hOAG5Tm1ayFjjo8/RdK449jyVl0PZh4aER3HmMPpNqczS/YBAuiKYWLOJ
   0BU1XeUSPY9+hgd0N9HEh8K3anjhoV4Q5UPAiQbEsrtTE3e2NBeIk9Dad
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369936941"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="369936941"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 02:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="898009894"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="898009894"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 02:08:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 02:10:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 02:10:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 02:10:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG1lwSTibVm2VmRd4160joN/xxBn0FfFsedV4se0RVpx68OFzI/M8Bq1s7R+nT9hZGZ+YqHHGIn7ltw2yb64atxy2OjJ6FG+bi0n4dhrgn1rhCn4VE2QcsgDIGXWd1pIAPLXSu6cwVACWvXtWU2TzPyFJVCDfrnVQNuCCSOrgxWoSkIBMK/h1dBEDAdY7+t7vWtRkoYCuefxKGIep3bywLPkDGfxOfX/m4wkch5rQgKZkOT4cGf1cXPtoU40B1NBPFHhih10uybybQnJewZ8QQ0La3ZwR/JBDrl+b7NkikZleY2OtdZn/Es28+n0uYaz5OW8SKSJKVkVuU98bdA/hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yORFdGeEudA9IVU/ZSSxcty2EVowaVi0UL0IhXEgLY8=;
 b=U6O+lY6e5IAlT88WDsnczzXWJ+aIOKYIe2F2RP7b7dr3npYcpkHTl7+plr4QOGJrf66Pc29CeBZT1dfehbREESpWtxMox/00Iamh9kMcvhnod0O2QuFzhVJ/VnnRWyvUzNa/B7iVDLPTc4Ew+kixrAk3IkMfBLQE0m9nbfgHMSAg65TX2L/nHE7AyIomDY5acBiAmUfxZcQfmzJYG15A4IWzjKZgrLgz/PakzafxAbZqOPTDRcUhZ5RAq4Yno44Tjt7h0UXhyvOm0P7J644z0C1IudRl9VvsW+gDvSe0zeUhimfIArt8lgC8L6iAAaJ8He5zmLByjwrnGmr1yUerfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 09:10:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 09:10:06 +0000
Message-ID: <43b3d605-fe3b-bcd6-a328-81d1448b7104@intel.com>
Date:   Thu, 12 Oct 2023 17:12:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
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
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <BN9PR11MB52767E1B944C0B2F0667D5DE8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52767E1B944C0B2F0667D5DE8CC3A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:820::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fe001f-c30f-477f-9598-08dbcb0306a7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZUfhqtguUfxyiIQ884e6e18ieo7AiINrl3R6VMwB2yT+r9YcGuo1j7KE4dkyp6eUGz1XGj+H+qrQjF80nrV8b08mD+6ESCa9Bt3dEcs41ggqRaR5/spMNYxASZwOzBaipKrl/hDT12i95YSP//G6cbTf+VT7QJRD7Qa+UkskY9VP4/TWErHk1n5pK9XZsL3cc1eSHDU+1Ln6vS+0PLRMGPQ9EbAc8ex8atsVAhuBAvZ4VlEtdL+MgItl0DPqapEo2bS95PE9+8bM8C+HY24RG1sOftnfFLw/NruSmziJfZjaKsmqkjxGECCn30b+/l6V1M8NHHxl6eTNLUSNQ4rQhJYICaXY4SI9xrQLi99CJbArw9e7j4/RsPEzUZFQ7q1iDEsXv9oXH9og71EQtUZXES6EbDC+RjSshRDeaO2AA7Bnj9xudHB5++fkb1oLzNDwkL+xo6g2VqVOlXqwM02r9NowJrYJkuIYBM2oBoxQkLP2X1lM0GxrduOzBHQ1sHy8tKiU9asG7tJggyyoHkKd++6dWxwvowqLjiTcfgpPfawkGXc/BMWOa6SjXaWe+RePeykRzvuOlI2o5Pne8y6gOQ9Qzi7/ju7oMFfZ7OhxwQCjF3SKPj6bjWSqtCiKjMCtirmdfkocHTfyEO+KN5epg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6506007)(53546011)(31686004)(26005)(38100700002)(6512007)(7416002)(86362001)(2906002)(31696002)(5660300002)(6486002)(4326008)(8676002)(8936002)(6666004)(316002)(110136005)(66556008)(66946007)(54906003)(36756003)(66476007)(41300700001)(2616005)(82960400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWQwcEpyTFFYb0RVUkpCY2pMbmVRWkRCNVE1endLSGhTRWpCZjlxTHdnVVR6?=
 =?utf-8?B?dU9aT3huWXc1Z2cvWDM2M1VuWFF0OFY1dm0vVjB5Wk9oUUpNakpzNnYrb2dK?=
 =?utf-8?B?QTlxaXlXaUNyWkRXcWpld25UbGZmY1NKMWloUnRVTzJpKzNjYmxGbCtuOUZW?=
 =?utf-8?B?eTI1eGdhdm1DQUgzUm5yNkwrZ0VXSHA0MWo4QkEvYW9kL1RHMnhIUlNTU1VC?=
 =?utf-8?B?R20rOVlJTjI0dmIwZVpwOWxoa2hUMEhZR0xhTWd2N1QvWDFWenBSTlY0Z1FU?=
 =?utf-8?B?NzkzR0tVLzFZNDdUekw2SlFEL1lpeVhUSVNKSFZ5eWlqT0UveXdaNEh4WVEw?=
 =?utf-8?B?dy91YVMxYzJFTzgyVjNHMjQxTThEOStiR1A1WXBPSHBLVkxUNHJHR3ozdy9t?=
 =?utf-8?B?dGZtOGdPVEIyeC9sYW02cnlYYkxJQ3hXQUFCUWJoaytrajZ4MFJ6a25wbzU0?=
 =?utf-8?B?dDZWeXJ4dTNTSDcybFhGK0JXSytGKzlpaDRhR3M4b01Bdit6RENCWlA1VExQ?=
 =?utf-8?B?ZEU1TXNhUytlVE1adHAyZHFuUjcyekZsVjlDaHVTODBPMWRNLzY1NGZCWkZa?=
 =?utf-8?B?SlU0bnR2ajh3RUk3WEtSaTZ2R3ZFZVFiZEJvaFJMcFcxUnJHOTNMRXVORng3?=
 =?utf-8?B?SnI0Y1ZjT3FPUEJFVGszaWVOZlBVc3gxcVJQemVBbDZ3T0tncXdGVXFzOUEz?=
 =?utf-8?B?UTZSb2RxVmZXaWRybFRqWmFvai9hVC84ZlYxaWUzUEVyUmRMOU0zWDdtejNi?=
 =?utf-8?B?SktaTmx4alB5TDNFZGpIbzlSSkxudHhIMjlSd0VucVVBZXdMNEdVSnN4d2wx?=
 =?utf-8?B?Uk5jZGpXaktYbDJHY0oyb3hvREdFdmVyUVplUVptTDZ0ZkVhcmo4NVNCcmM4?=
 =?utf-8?B?QVA1TUdxdnpMaVd5NitER0NIckRxcWxQTUxzdWJvWmdpbjhuSVJMNVQ2V0l6?=
 =?utf-8?B?UjZpRTA5anQ4RGRZOEo2dTNoTUNLS09xQ3lsWm1ENTdGLzRsVTBlYU10dGNn?=
 =?utf-8?B?ZEJxUXY2bUZadVROYXRaMWVnUVVWODZUeDRnbGovWGoyMUpJWlZ6WllCOXFp?=
 =?utf-8?B?cDdlbVQxQ0h2L0gwbHk1cFh4QjRCWkNSb2NiM0Q0KzVnMFNxckV2NFd4ZW9h?=
 =?utf-8?B?YWFraTVKQjhWT05IUzFabVIxWVoya0Fsb3hqNnUyR05tS0hVNXZOdW4rZndm?=
 =?utf-8?B?ZWljUHBWcnhFN0h3K3AvZEVZazRQVHlJTkZ4WXNJUnNqRjF0c0gzUVpUZnRC?=
 =?utf-8?B?QUlNOFhXbG5ueEY1OU9CSkVDTDJyRFN5VmJJWTRlZmc1c054bENyRnRyZm80?=
 =?utf-8?B?UEQyNG9CWnN6SkcyMC9tTXhDZlB5QUR6dkxwMTRHVWkyelFDQk1TcGl6T2dy?=
 =?utf-8?B?ZUZ1L3cydnhiSXFDMVRzak4rUzhoOXZPMlU4eTA2c1VVMy9hU3RUMDNDdk1J?=
 =?utf-8?B?dlZRYmN1bWlrOVZ1WmlQN1JVTUs2R1NCUHBWUDJXUnZMZm9GWVdoUGVxZFE2?=
 =?utf-8?B?WGRNbnQvQmljekFYbHUzTXVTbWdXTUZiR1FkaE42dHd6UE80UWp5TDBML0xK?=
 =?utf-8?B?clJ5NFJVWllrYllOOTBBOFFncHI1dEhhMmZYUFpVeVRLWVVpaEhHMXNkQVJS?=
 =?utf-8?B?WEJGTmdTYVJVdzZDRXlVdzBqaU1rQWY3d0RIeDczcWZIOGZSYVdUalJDNjc2?=
 =?utf-8?B?SHgvcnlZWit0NkNkNkpObmZWUFVSYkVCZklWSG5URXZ3OGNMZVVpWDBmMG43?=
 =?utf-8?B?VU5DN0J2VzVKN053d3BmN1kzdEVyWGlmRC9FZktwamhVUTMxbzZ3cUwyK0Qx?=
 =?utf-8?B?Rld5MEZ5VVcvT2l1N1FmdGErTGNlMTgvRnhtYy9ndnRWUVIwUnB0eTkvcUpX?=
 =?utf-8?B?UStDK1hXSFA0clFkcXI0eG5JdHNZWnVtbTFzWDczODlvaStmU2ZoaXR3ZUlj?=
 =?utf-8?B?dGFyUHNJMTVTVVM0ZXlOVnY5L0RpbkN5V3VEVWZvUWdoSXlBcVRCVW1Td2Rn?=
 =?utf-8?B?bUkzVE9xVWROeTBhVFhLYytrUytNYjZNZ3RNS283UjgycW9aRUo0bGVTanlw?=
 =?utf-8?B?OVNlNStSMDduaUFoSlBKQVJuL3lEbzk0S2FIMFpyRFlrcXVIR3hBNlhYaVpN?=
 =?utf-8?Q?KkUJ+kEdPjJdZvi61WD4qyAyb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fe001f-c30f-477f-9598-08dbcb0306a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 09:10:06.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGLce9vQAbjRVVruW0YlStPIw7g7DK/e00AtjrOWVPHTaxsdlZHhp/5gLMC/bTBy5djQxm32DWEk+s//Efutrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
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

On 2023/9/26 14:56, Tian, Kevin wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>> Sent: Thursday, September 21, 2023 3:51 PM
>> +
>> +/**
>> + * iommu_copy_user_data - Copy iommu driver specific user space data
>> + * @dst_data: Pointer to an iommu driver specific user data that is defined
>> in
>> + *            include/uapi/linux/iommufd.h
>> + * @src_data: Pointer to a struct iommu_user_data for user space data info
>> + * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
>> + * @min_len: Initial length of user data structure for backward compatibility.
>> + *           This should be offsetofend using the last member in the user data
>> + *           struct that was initially added to include/uapi/linux/iommufd.h
>> + */
>> +static inline int iommu_copy_user_data(void *dst_data,
>> +				       const struct iommu_user_data *src_data,
>> +				       size_t data_len, size_t min_len)
> 
> iommu_copy_struct_from_user()?
> 
> btw given the confusion raised on how this would be used is it clearer
> to move it to the patch together with the 1st user?

sure. How about your opinion? @Nic.

-- 
Regards,
Yi Liu
