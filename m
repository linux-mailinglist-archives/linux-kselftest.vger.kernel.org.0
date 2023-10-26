Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1466E7D7BE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjJZEta (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 00:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjJZEt3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 00:49:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161B93;
        Wed, 25 Oct 2023 21:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698295767; x=1729831767;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=e/l/UTuwaDmpXCORgy0cza0/iyyj/m64ieDG52iM+is=;
  b=exQAH9a635KPbMIKQozU7ShEKS1I2glRIt2hIpsZ+wEMPGImXMhqWzal
   MBfppv+nQV6rNW4cBvbq3xzmUD5NlP2e02UapSj4VbZSlgRZM4KEMHp7b
   fzqIHOuX2udk7WSLYuCjhKt+xru/LqQpJ6On4w3G0Rz3G73lS44jZQzPl
   j5v9ltTxj+lYD5NO0exFfKVGtcyG8DtOawoYCMeVnCvXB39zOEEJ447PV
   E3V8qcP50Wfyt08ydIaO0/fXhK4nJxCoUD95VbK8pnM8WGbLSS3cE/j9f
   2OtlbZ8ycUyvy2zHif/2UuTl3KJqigXQTsiQY5sp/0rS38r79VW8Ov6pd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390317326"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="390317326"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 21:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752588181"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="752588181"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 21:48:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 21:48:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 21:48:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 21:48:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxZaXNWUvQ6SX4OzqCp4+kHim+miv9eanlwA+DLTw0NN18tADzz+uUEk7zsEY2T06rtk7WnLFwVO7viUY3IOuG7MnprwvhWcA7yrxfAuqZQJmbYBzF+GVUZBs9+YY+D3SdQpjMzsQ3pfA+NMs2ntMPVm1yaOpvMamB1NX1wwPXMqvsILh6XBWZlg1qylP+LIdvTFijhXvmZftEQ+tBPTbpe0z/62x6vfieR0nXiKh7pwdDJSKj9yPEKUt3K7qBtvu38PeJWxaMSfTzB95u5zq5R9YBu9HlFRX6Z+8cmggPyGVu8nfRUdOxjuCMAZ1Mn/kfGlgjb2DKuR3whG5+HtuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veDGki2EueZmOU0bmuGwG9C88nhsK87dKwQdVvHibHM=;
 b=I5+oAFdGI7lneggSXZQiGdVEk/Lpj5HZ7dAO0OaOwNYxKlXgS1WFNfEwHVsNbjgIuREaATHiMqdschIc6KjtXYNO/DcQyRhYOulftVggO9VVBN2eOMfK8oVnB5NysT6EFkfPMCpc9BasBgTz89F8i/VD3BXBXX6K302P+4GwfkKduN9bjvx5u0DwjewTs/+YZN34LkLGlrYM/tmAPm3DG3sHoah74cjE8SpAZLBJ4YnL0/Lx7vN07gfY8RC9E3lkqF/mcKQaIOQN2g3Wzc4hRsOvqINptn6LhsiLwMM1GWvcFM3Rzg3/mI7AdcwD8r6yAZryPG8unKQQh4PgY4VAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6031.namprd11.prod.outlook.com (2603:10b6:510:1d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 26 Oct
 2023 04:48:15 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Thu, 26 Oct 2023
 04:48:14 +0000
Message-ID: <629a1a42-92cf-4eb3-bc07-e664a6f36395@intel.com>
Date:   Thu, 26 Oct 2023 12:50:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/8] Add Intel VT-d nested translation (part 1/2)
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
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231025120746.GZ3952@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231025120746.GZ3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6031:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a4c72b5-895f-434e-638a-08dbd5dec337
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQbgK/r5PEYpLgCmfcFu0EXFHmnlUQFQmdfMLKJbWbeQ2TQlVp0AO0ZDWCnJ3gEug1lyCijRuzPXOtsiDpZcswVr/XnOFtpCWPfAHwBDIJoQReZgidcD7MvH/STLoi1GA4o6je9CDgR00m8LWH9npLBe01Zf5cA/OcdO+Uy9OmpEFGdaQMTmgICrIdZT6gtbGm0AnmesvX9Sp+wneAldvj56zF2xiIa3bKMBIEZXoMZZn8jCB4asaohonzsD53DFYdg28syeyX2N9xqiE1dfi7CzwYXntzEW5wyBDMMnb0KOhfu7g8BKKDhc6mhGiY0WQP5v6Zmg4RHoZB9yfOp49xxNEH/XSZPG7Qt1TJX/6P7dnrcln6Jz4ukIdMTQkdPbNzf4r7gRmf1sGYVXAgryl3Lp/d491A6UENFZJnKaBwTDICkl11s8/UXiw0e9m1Uh9H8SlCw+z9mmeky5OvGdNdjDEaDle0LDsZCx2gItXLnewXwAIQvF+u7Bt6uUv/MkoHOzdDPKNq/znMVFDpW3yiWocVy/lCXlR6x+S3aKQRmox3esUdfqSpSdUKQ9XZ/HqhTr/SIEbjyfnXhfV+91B/3T9/HGUBH4rbLBNHfN3bk0jv78wLfAx1qm5wbYvaAA8o+u+yC/kf5WsP5Ga3NS0Sd7telsEqwZB2cl1tI27iUNCZNwqAgxPUDT9BLG4mfu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(36756003)(6512007)(316002)(66556008)(66476007)(31696002)(6916009)(2616005)(86362001)(38100700002)(66946007)(82960400001)(53546011)(2906002)(26005)(6506007)(6666004)(966005)(4744005)(478600001)(6486002)(7416002)(41300700001)(5660300002)(4326008)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czJmTy9YemJGR2RWdFdoR290WWpXS2lQM2plSU9lcXpsOUZIQ0tyd21WSzJy?=
 =?utf-8?B?K2I1Tm1GUXB1MGpYYmhMZHpIZTNNMmlMZllhR1I1cVZVSm9YMklFenJLN2kx?=
 =?utf-8?B?eE9oTm1yVkhTMTJWVEQ1WTY0QnRoUi95WnpZOXVnU29JSFBLV05aL0F2ZFBw?=
 =?utf-8?B?QlI3NFVoVXJCWEQ4OE9zQUxCL0tmeDBWRUxHZEJwY21xKzR0akgzMkhGR0Zk?=
 =?utf-8?B?ZjJ6Rk9paElyYS9GQmVjTHJobmFXZlJWQXdQRWt2SEloM2dEMzc1Nm9jOFlR?=
 =?utf-8?B?NGUyMVloYjkvQlpZQ2RwRWhrNFBrN3VMdlRuMWg5WU9WSnFIcDdBK3l5dTJB?=
 =?utf-8?B?VEx0bkdJYUFpYTBuM2lNd0sya1BNSlNvOFY3M2F6Y2VlT3gvNzZjY2o5VkVp?=
 =?utf-8?B?Q1NleTRYZmlvUU5iTVArVytQTWZIMUtHeWwrcUM5cXJRUlJXbTdXeW9BZlVI?=
 =?utf-8?B?Z1RRTzQ5OGJCSjhFYW5uL1lsUVJOQmVEbW12NjYzQmo3VCtsV0IwL2toL0JL?=
 =?utf-8?B?anRrbWIyN1F6cGkrK01CbjI5dlY0dndPeHhtb0tNWWplRittbWhTd3N3eDlU?=
 =?utf-8?B?ejRGSTJhZGNtcFM2bU5HbENpM0NvWm93bEpXY3dBSTU3NCtKekxIQ29DRjMw?=
 =?utf-8?B?ZmNsVFVPYUM3MWVVOEhtRmN0VW1QN2Q1NjI3Mk1wUExkU2YrNXMxY0hzV0Ri?=
 =?utf-8?B?YUNCaFkrR2FmUDBMS1NCZDd6eU50QURIN0s5cjBuQWlLTzhsY0pVL3FodWlS?=
 =?utf-8?B?bGN1UmF3a0F4Y2xsWjNCYlJFcUhPak0rMFk3eUcwU3dIbFFYZ3ltZHJaUzVF?=
 =?utf-8?B?enR1TWJuYXl2L0FiOVRyMTFuTE9HamZWUWVrcCt4UlVCWTR3SlZERmdtR1g3?=
 =?utf-8?B?Ti9qM0tOZ1RTaXpKaC9hRFZpWDZ4L05ySUw1eTNBZE9RNUVEb1NSajdNY2d3?=
 =?utf-8?B?NVllN1NHZFI0aE4raG1kNTBlUmVoeFlyN2pRWjNGRlBRVCtMZStGM3VJU3g2?=
 =?utf-8?B?bXhlR2M2VXBOcUlTcjVhL04vNmppYjRKdlpJdnJGa3k3UjVHRVNlVmVZT3pj?=
 =?utf-8?B?aitVc1pFVzQvQ3RLVDl6ckhmMGlBbVRTUDRxeWtJQWx1ZVlJSjZua0ZmRzlj?=
 =?utf-8?B?SUlOSSttWTcwRjNjbnhSLzJRcDhMUGFFRWpEMEdvaEVSZWxVUVhpdlFsM2J2?=
 =?utf-8?B?QXM4d2lnTkV0Q1I1bjBMSFB4Rk9lMjlPc2FVaFY2aWVMbmxqODAzWnQ0NUMv?=
 =?utf-8?B?UlBjNDROYW9xcEV2TExZQi9NaDRMMUpMcXU3L3RsbEk2QmI3ODNENnduMG1J?=
 =?utf-8?B?UnpwbjhVNFo3aWxYMno3S2M5R0ZFSmwzSHgxQTROaHkyMFV3cGpVaUF4U1VM?=
 =?utf-8?B?ZzRJQnQvSDQ5OVVJTVp4MFMza0pPakdLWnp5bVZVVHFyc3ZrcjZ0ZGxjelYz?=
 =?utf-8?B?QU45ek93dUJaa29XL0htbi9JNUZlQndrQ2lLQkVRdVcvTkdOVi8vL0dLSHlr?=
 =?utf-8?B?c3IzZ2oyamRHbEdCNzUxK0Z0T1FPd01tb0xpUDJaZnQrVEV5NWZFRjlVMFk5?=
 =?utf-8?B?c1V5Z1JuVVdxdlRCRkpGRjYwZFQrdStpNGNTM2hXdzlobzN0Y0pocmlzaE5z?=
 =?utf-8?B?d0U2c2l5MHFNZnp2RG9malFJK0FxbEVyU2I5TDJqS0liZFZCVnFZK0MySGhE?=
 =?utf-8?B?S1hzaFBGd3IyY0RqYWZPUEt2R2U3MW9ybVcrL2sveXNLdFJTaEM0WEFKTnYr?=
 =?utf-8?B?aXFwZWpKbFRiU00vWnhydzM1cDA1Z3ozWnZDdmJ2RUpobFY2RXVwazNBbUNB?=
 =?utf-8?B?TExhZUhGcHVhdnk1TUY0K2IrLy9vL21LNVBVR3RUL0p3MUdQTHVtSEZ6aXo1?=
 =?utf-8?B?dDJMUXBoTEhxck8rOUdJSisvWUNaS0RGbGV6QVhHY3Fab21aVGE2TTlPM1p5?=
 =?utf-8?B?RTdPYk5HREpRbVk5RzNaUVhuZEdwWE5aODczU3JDOHZiRlhianlwT2dZZmFl?=
 =?utf-8?B?bVQ5OG9LQ2dJTWJOM3ZNbXVqbG9TTDZxVmZCME5iTzBva2ttQ2VOVTFvdjdY?=
 =?utf-8?B?bXdPTmxLMGRVeXUvMGllaVdJR29aYit4SEdRTmNWdzBNbTRIMzJaK1d1L2Z5?=
 =?utf-8?Q?pWe9Upxm1DwdcxiopGlRdK37u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4c72b5-895f-434e-638a-08dbd5dec337
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 04:48:14.0830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MXXsZcoaEj1kcyAmmu2TVQF+xeSfmbcYL0q6tmQ3JHNW+fx8jfzQp08wTs0vJvLqBB0M86gPZetdUbUfRz7MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6031
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/25 20:07, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 08:14:04AM -0700, Yi Liu wrote:
> 
>> Lu Baolu (5):
>>    iommu/vt-d: Extend dmar_domain to support nested domain
>>    iommu/vt-d: Add helper for nested domain allocation
>>    iommu/vt-d: Add helper to setup pasid nested translation
>>    iommu/vt-d: Add nested domain allocation
>>    iommu/vt-d: Disallow read-only mappings to nest parent domain
>>
>> Yi Liu (3):
>>    iommufd: Add data structure for Intel VT-d stage-1 domain allocation
>>    iommu/vt-d: Make domain attach helpers to be extern
>>    iommu/vt-d: Set the nested domain to a device
> 
> I put this in linux-next too
> 
> I think we will need a v8 on the list

yes, v8 is posted: 
https://lore.kernel.org/linux-iommu/20231026044216.64964-1-yi.l.liu@intel.com/

along with a v7 of the iommufd nesting: 
https://lore.kernel.org/linux-iommu/20231026043938.63898-1-yi.l.liu@intel.com/

-- 
Regards,
Yi Liu
