Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B487D57B1
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 18:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbjJXQNN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344142AbjJXQM6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 12:12:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B54910E7;
        Tue, 24 Oct 2023 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698163956; x=1729699956;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T0njysdnyaiSs5fyCCTrTG065kDQ5ZkRXTih9tYoXME=;
  b=enRe/fpaVujOKFvo39H2P4oPgy3/lfA0WTeMLr306QTmhlLlvgyXTUpX
   hnpOhwdEPgfR8iOEeP//oCE2zWbg86p6+I/SZ55nhJYaaCQVczxS2VgHm
   Ul3AFFC0UmsXrTesZTwyUnM21zobDpY19kxRWMo2jguXb2c+pyNluEEsx
   R1oHwdBda53A/a7tRb2WkxnTUTmFFZuCZyhkNsD3kR6XMOTAI01DaWRMM
   8q4Gcdu+7KQ5eO1Dzs/BqCmTPaMiBSMvrEy8scSNH69iHd+c9Ojaz4BG4
   2AGeL6VWPwu83zyAn1uvYKwSRNQMnS8fwnKtSID2tSE5Tj4DlaUoGE3rU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="390976108"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="390976108"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:12:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="6222077"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 09:11:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 09:12:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 09:12:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 09:12:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 09:12:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sp8nRcEcb+pfS5AKTbAkoGoNXD0d50GbcgLevEhxWpy8Sk6G+seZpdaptNeh3MRxDgyzwb/61jPAsED2KiUdlSyzEJj2wh8IOY2Wvm7sknfeXLSKNYu+QCwDbvDCnao6mf+5pAg/UnRJQkjJ56rhHG5tvNRHS/KxuiuxOfo3T3skZIV7BboZniok0qpf/NO0C7EBYhdw0R6Rw7xTR1N42ozuXeP4RAQgKGUDjvivzlzmB3DZmqs1r2uMSyjQ2oCUqFrNB4siMOEvs6y6IE8D8Gpzf9Csf5UnjcC6RFPhPk0lTQR5BWudR2UJ61n2iWoa3aT1UQgPf9F9LsprUVJCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TyGaygEp/4nfY7fzrzXo+u3SxyYDLDbTxc+V50RXzM=;
 b=A+wADbX6yRJin5I+Rlw8Ffz9dCmzHwNQTuJum8+uyoyPyv+6t3fER+R1HPt3c3C+grEQIdXx+f0KPNr8RkTbJzXi0ED5FigsYzwWggW6b5BF8bVbA09hsv6SScWp5pXD+GYfJolxeLTdTIMY6fCZhXtHNPB71v539LNXgd/rvLIwm3k9YqMdYMo+uI8XgTxaGaYMs/i3deDd7qbBWqB5hrrPzOKwS/D3HUXu2zI6CvB1NMrlEAwJEiG+EdOZRM1xCYfKBdO1YwWJA9Tmr6o7OatEoLQRGgIPkUVTLnn4G2Jypyl7OByiXF56xZGZafHvFL3hmdIcKdrmj1+20QnJOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5632.namprd11.prod.outlook.com (2603:10b6:a03:3bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Tue, 24 Oct
 2023 16:12:26 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 16:12:25 +0000
Message-ID: <15e5ce3d-bdf0-4114-9df6-50105b0e3c73@intel.com>
Date:   Wed, 25 Oct 2023 00:14:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/10] iommu: Pass in parent domain with user_data to
 domain_alloc_user op
Content-Language: en-US
To:     Joao Martins <joao.m.martins@oracle.com>
CC:     <cohuck@redhat.com>, <eric.auger@redhat.com>,
        <nicolinc@nvidia.com>, <kvm@vger.kernel.org>,
        <mjrosato@linux.ibm.com>, <chao.p.peng@linux.intel.com>,
        <yi.y.sun@linux.intel.com>, <peterx@redhat.com>,
        <jasowang@redhat.com>, <shameerali.kolothum.thodi@huawei.com>,
        <lulu@redhat.com>, <suravee.suthikulpanit@amd.com>,
        <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
        <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
        <alex.williamson@redhat.com>, <kevin.tian@intel.com>,
        <jgg@nvidia.com>, <robin.murphy@arm.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-3-yi.l.liu@intel.com>
 <b6b3bfca-f140-4ff1-86c5-69a302e5bfa0@oracle.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <b6b3bfca-f140-4ff1-86c5-69a302e5bfa0@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:820:d::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: b839724a-fe5e-4f97-26e0-08dbd4ac031d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LBaq0eb/CFbi1ptT512sLwxU5xxkqCAGxO/J1L5VrHV8zCozURyiLvXU/7DYDMytSH5Izuipvab4KM7QFp/HzxBsWh11/dD7yLma/2IuWfVbywOEp5XnRWlpo/mYvTd9dvHAI1MIx0fNu+2oOBkkj9PTD59ZpylvxZNWmnjdJFum9iY82rnXEgMTy2JMztqrTxuy/MWpX1aV9TdD7qxk2buUHLE96iwRo90ns2Ex6/o0tBKxKajoPNgk+rUgCp10B4a4+bgo/3xdP9MqWXXzauFdCH5k1RfdhdquoHI6KZ4yH+HC+Bkz1Q9dD+uPz0czjlXCqBFgExA8TcbYJu/2IZG0BmK49suJ+M8CrB/BTYnze6kk33M4Mr3cxj2EtQYr0oR7AS02MX8GlcVC82yhHDPHyp09TOwKpNzSQE5Dv7+QDBpg9rB39v8N5737Or4iJbM5cP6z/uhGyAC2/wEgF9ZgnI6WdfdjKniJx75G0/p7eURsXdBzTutjphAacn9HUDkFOpGvlxXMFfwbsZklO29NyIT/LDa4Sr35meo4fsJMKluyASNuKAuaQKSICng3waw/+LtifiGgMh16VtNOtDe5mqkwuJjkBGk1OoH3QsbdWm24WukXdw9FLf85UK9SRv0MVaXZkm5/4isGKy3gPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(7416002)(2906002)(8676002)(8936002)(4326008)(6486002)(53546011)(31696002)(31686004)(82960400001)(41300700001)(5660300002)(6512007)(6666004)(6506007)(86362001)(6916009)(316002)(26005)(478600001)(2616005)(36756003)(38100700002)(66946007)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXFsN0NOeGg0aWFPQyt3MnFiN3JLcStkZTZWZDZVc0lRYXNpYXVESmQwQlBI?=
 =?utf-8?B?K0tqR3RnVTlqTWtwTndLSFV3d3BEcC9OQTJIOEthK1dKa3Z2UnQrY2VrZW5H?=
 =?utf-8?B?WkQybERTR2pkalFOaXhsY0x4cjhBUm00M3d0L0FTMmFrWVRMTGJueXFJOTk5?=
 =?utf-8?B?M21iZCszL21sL1dwM3dlOFJQYXd6NTlHUzBRcG8zZ1JRT1V6NGthMEc0Mit2?=
 =?utf-8?B?cXBGMHNRdDZ0VGtLRTNQUnNRZDdkaWtoblBwNkxlUTlBbzBERnVzSmo4UFFF?=
 =?utf-8?B?eVlpVXd1RlZEdmlkZXJ2RWpIMTYwdUxyZThrZ216SXd3c3BqNjFzcGhucVVy?=
 =?utf-8?B?c3JMTS9zd0ZNbk1BME1EbU9RODdCSmo4dDFTWUI1U3IzbERwc2F1OEJWMTdq?=
 =?utf-8?B?VEdnK0lwUGcxY3IzWnpXamFMOXFqdTFFZWNIcjZNZkk0VmhDVzhZYTFEblhE?=
 =?utf-8?B?eXFCZ2duZDVDODBsYU9ISEMwWm5QbmlUVGt2d2wycm16VkZkZmtKd1dFTXNx?=
 =?utf-8?B?YUZMV1Q0K0JQUDV3OGdRTmdkOUZtYTZjWGI5WlFycGV0Ly9nNDFEcnZhRHh3?=
 =?utf-8?B?azUvc2pYMUQ2TnJWZllEeWF2WHk5eWVLRzZxdlpiWEhRODlCTVUzWjZkV1J4?=
 =?utf-8?B?NnJRS2NDbU1MbmNPUitZd3crSEhiL242VEZEUnFtVkx6QWtITEJsRnptdzcw?=
 =?utf-8?B?c25FZUhUNjlIczVwU2prQStjc1A5ZGdoSWxzbzduY0lpRkNDSkJUV2lVMmcz?=
 =?utf-8?B?TUdvZXBUT2FKRGdVbmdpV2g2Q3lIWW1DZVhzbUk1ZU5sK2VkUEwvTFgxTFRS?=
 =?utf-8?B?UmtESHhYTUdmUFNqcGNFUjJ4bUVTSVpicGhkSjN0VklUVCtrb0hKakd3U3ds?=
 =?utf-8?B?WGNRUEJBVzQ4eEpHd2JCTmVib1AyREFoNDAzRmhyRGNocncxMittMS9hQ1h6?=
 =?utf-8?B?c0ROQUIrTFdiSUFXZzY0SXRrMGFaY05XREtvQnpVSGtIMVN5eFZoZnFCaW5T?=
 =?utf-8?B?MllpVVBjSC93VDR6R21weUs0Y1pIM0dkbGhCanF3QnQyQkRzZHpjZkc0QlZ1?=
 =?utf-8?B?TmlYZ1c0MzB4Um9ueHF4d2JuZGVoaFpRaHdvYnZvdHczL1BiVGJ2c2xYdTlO?=
 =?utf-8?B?TjdEazc0MThJUFF6UkZEbFkyRjhRMVF6T3ZKMDZ5SWl0TmpMTmtxam83NFk4?=
 =?utf-8?B?STR0QllFaCtzQzhzc25TV0FFZnplZHNRTjh5RlZ0Y0J6VlZXMUFYWmhiejU3?=
 =?utf-8?B?UHFQWWFlV2J5WWhudVFpRTkrZnowekRkaHhJb3BlS3VoZEtUY3pqNnJ2bjRi?=
 =?utf-8?B?WSt4TG9jYkZzTXBxaVM3R1JzOUxNSXJYM1IwRU5FNXdqVmJ0eEJObytWM0do?=
 =?utf-8?B?Ymh4Q2pUb3NiRFV6QWpNaitPdmovTm81ZHdwbXlIaUJzLzkvdkVHTVMxczlr?=
 =?utf-8?B?MElUcjBraEk5eXUwWnJCVksydVlqMVVOQXFBMVFBT0ZUTWxHMXN6SEFlVEVz?=
 =?utf-8?B?SE82WFlTR0UzVWRPYW1aeTB2cmc2Tm8wSStBektBdE1sOWNmaUpoVlBneVZn?=
 =?utf-8?B?dTN2Z3RJK0hMemVvZnl3bWE3Y0dPK2ZTMUZLTGM1VzhqVnFUVlEyVzZITzFU?=
 =?utf-8?B?ZWVDNzlyTlFzbDFEVm1vaXRmREZXd3lpbG9pMVJ3L1pzSXQwR3haQTZQWnVF?=
 =?utf-8?B?cU03U3RkRld6QXp3UEx4YklCa2ZDcFVxNHV6UHM5cDlvT1JRbmNWdHFzMVR1?=
 =?utf-8?B?R2FINk1USUlHVFUxWTliN2FYblJic1lFRkFWTElWamJ1WDR2SjhQdCsreElu?=
 =?utf-8?B?VFVjWmF1cTFiTTJBd09oZGdNbXVvTms3dGJ1MURqL1g3a3FSK3NWcy9WcVk3?=
 =?utf-8?B?L3Uvb0llWFRQWUM5aGpLNUprN21BdVRsRVFJR2JGRHRUT0RpUHdMZ3V5aG5u?=
 =?utf-8?B?SXRYcUZWYXowYUZMOGR1Wm9kM0hZTk1GeDB5ZE9vL1h2U3pxMWROSDJYZXdD?=
 =?utf-8?B?cWlWK091Q2FnZDMveGdSbGtHNWllTDc0ZVdFWHFmbVVMNEFlZk1ZQUs2cGJi?=
 =?utf-8?B?bjd5ZGNQV0txaWJxU1dpbjBsa1FQbWNyelFlVklIWjdsM2Njb0RuYmpNME45?=
 =?utf-8?Q?bkWaV9pgA/5Ps7AB9r6R3V+Xd?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b839724a-fe5e-4f97-26e0-08dbd4ac031d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 16:12:25.7971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tAzk99LC4T003CaNG8lCZe9LXBBI3z9y6sJqBtQdC8YhXdybXQssn2DTDv8pJAThOG1VCNsvC0kgQI+og1CrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5632
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/24 23:56, Joao Martins wrote:
> On 24/10/2023 16:06, Yi Liu wrote:
>> domain_alloc_user op already accepts user flags for domain allocation, add
>> a parent domain pointer and a driver specific user data support as well.
>>
>> Add a struct iommu_user_data as a bundle of data_ptr/data_len/type from an
>> iommufd core uAPI structure. Make the user data opaque to the core, since
>> a userspace driver must match the kernel driver. In the future, if drivers
>> share some common parameter, there would be a generic parameter as well.
>>
>> Define an enum iommu_hwpt_data_type (with IOMMU_HWPT_DATA_NONE type) for
>> iommu drivers to add their own driver specific user data per hw_pagetable.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c          |  7 ++++++-
> 
> You are sadly missing AMD IOMMU

good catch.

> 
> This would fix the build and nack the op should parent or user_data be passed:
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index caad10f9cee3..bc747513afcb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2220,13 +2220,17 @@ static struct iommu_domain
> *amd_iommu_domain_alloc(unsigned int type)
>   }
> 
>   static struct iommu_domain *amd_iommu_domain_alloc_user(struct device *dev,
> -                                                       u32 flags)
> +                                       u32 flags, struct iommu_domain *parent,
> +                                       const struct iommu_user_data *user_data)
>   {
>          unsigned int type = IOMMU_DOMAIN_UNMANAGED;
> 
>          if (flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
>                  return ERR_PTR(-EOPNOTSUPP);
> 
> +       if (parent || user_data)
> +               return ERR_PTR(-EOPNOTSUPP);
> +
>          return do_iommu_domain_alloc(type, dev, flags);
>   }

yes, this should work. @Jason, one more version or just this one with the
above diff from Joao?

-- 
Regards,
Yi Liu
