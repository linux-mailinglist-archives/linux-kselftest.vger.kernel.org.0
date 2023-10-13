Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9F7C85E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJMMiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 08:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjJMMiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 08:38:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABD1BE;
        Fri, 13 Oct 2023 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697200699; x=1728736699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7yx/zJZtq0BRCTd3oY7NxCcqISBp5hA7oMNod+LCqj4=;
  b=RuhW9mZR0/3ow13D4179v7jG2LMfe8I/BYgyyzuDXL4cdNNp7a99nDUU
   T36Rp4kCgFAW57Vr8SDIh8cUIjXUv0gpX3MAjbEJ5RFqOJn2U8Bz2Ke4t
   X8clXD8sCOFiKLXJanxMxQW5KFpWhn4FlOUSLwha0m+e2xJKylfllBuHa
   yyeSTJlQx/tuN8kL3HsnTD1m5KYDpZf5KDnRAg6QEuoREYDgvEjfYfy12
   cf7ohyO+DyeaTIrAdZQq8fS4uaF00OCdwmL6UKnd9OolrgfbYraq38IQL
   QPelwwDofQH+zU1HpRjQjXeYRy3FHbbXJspT5EOBgt4EaaAVWfXnu+vVj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="382403499"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="382403499"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="704640513"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="704640513"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 05:38:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 05:38:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 05:38:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 05:38:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3pixpg8prUg4XoLxzbvPnFZ4+hT5EprV/70LolC20wrQ7xYH/YHMDyChTpvJj9bUGs5I0flPyD9qceQH4zUryDEgscyqtCOA/Dj7jDjYDuHbZmugQiCoe+kHkhoW6fQfwYdjb73ZVEdNhCsYJavbmKJsDpxH/Lwt9ywq1pvXjFmcuzxdqCOeSo8cjx9HzhhqjMiLxuCbMtXDRlr2Cytcj374eRx4M5J2uUSBBmS8yDSwyJU6uHqTBB5LTpG3tzEimp9x2JN41Y7tydtZbmWW/goBY8h+qJ6uwaSV9EtTJZLPNjuq8pI/APeIQoaCurM5rJfITVj6Xu1Rzcp1p27Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL5vg2ED8afw62Abhep8s6tifPPdAjGu8cKq/pPPA68=;
 b=XVsoteOJeGdle5v6QakxM5w3MPnt7sLOEAvoRCuPjI+9vDb/ScRVMm5kNK4InYzQ0FhpWFqnQwN+T+nGFqaervcG0QjC/dtCs9jaGzNEulopGq5zogVIWsE/262AU216Bc23t1Ml8jupvqs5zFUIyzejK6iNLpJTJYJDEZbUMmHX2v+R15TPM1r17qd9O4gtrLCv+3auHLlVQ9C5UL0+Duf5zwqtihbPBZ9KfiPqnJpWBrX76xZQFA3ka3tip584/64mGDYFhses+OdOWKcG/ew0znYqulCcIwVELktsPVsq/078eMu1P7zcXcO8h0CDALcDy7/Ds9oZ8uWafg+OLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 12:38:08 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 12:38:07 +0000
Message-ID: <8974035d-9f9c-e209-79d6-8e3c6402e516@intel.com>
Date:   Fri, 13 Oct 2023 20:40:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 04/11] iommu/vt-d: Add helper to setup pasid nested
 translation
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
        "Martins, Joao" <joao.m.martins@oracle.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-5-yi.l.liu@intel.com>
 <BN9PR11MB5276DD2D6E5690F8FC7B18378CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276DD2D6E5690F8FC7B18378CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0152.apcprd04.prod.outlook.com (2603:1096:4::14)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN2PR11MB4757:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca3d637-d0fd-49d6-e292-08dbcbe94030
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxzYp+GqxLWBjJeUQH6h1+81EwLLJseodNHgJPH0ySy0MgVsMIpzVVHzl/WxjNhvORIreamhsCX+Oh2NS+tSEVLY+FC/RyX1H82NRm4YXSMLkWeCW1sE4phRtWXjOrymu047knugrb5TgwX2Y+V3YFlH7Ni1Ft32rIj2aNruAIQzN7dyx+gMyz2WDpY3ylIMfz0Y1ni4rRlGoVV09aoBH5UmgqrWRHGcmZNt/PXu9MpVaN2tAPZXxLAzZwHwokeZieGy/wzj1CJSxQrSkzrWiTjCa9w8FZYlw8dyfRGTmJ5S4Vps2gd6kNnsHFi9mQLqdb+vTv7fny8aJqBi+grUzxYmTAL2SRPKUoW+CQYQKCPNHuAIrnjvzUybXgp3wOyhjqCWkcflJWyGR1nphNUhR2uT8IPQ5KWg83mWc9T/fBo66IQO52UtM44YDC3oNEx524jjyFUy7yblIvxfantqSS/eXqC7fve+xWwMayzpYm9ymPzi2BciCythA3RTgR3fzjvO9x5WAuo8vNOYNrpGkwgtbYa/H75Jf6C8SauxX05CUaqFWhyXvBwP1bNBbicKB1ZxQtrfS/86WP+LZtQgXzGJAqK9/1Gy20Z8dzcvfVFQRSQe1ybhJGQdcLPWLcCyLsIuxsH/nn5bR5nsuhvZoPVJ2zmT+4l7zO1o2iFW0R8L+Di0Sz72vLiNW1fpyzwp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82960400001)(26005)(6506007)(36756003)(83380400001)(54906003)(66556008)(66946007)(66476007)(316002)(110136005)(86362001)(6512007)(53546011)(38100700002)(2616005)(31686004)(6486002)(478600001)(31696002)(6666004)(2906002)(7416002)(5660300002)(66899024)(8936002)(8676002)(4326008)(41300700001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtYcW40WDhpNHVvbUt3NnpuWEIzQk5KcER4RXB5V21OdTQ1a2dhVDFmRUI0?=
 =?utf-8?B?S0FwVi9CdlltMUxPeFpYUkF5Y2dNK3VzRmRLYjhrQjFIcGk2RnZNMzhPb2VE?=
 =?utf-8?B?VXJNMVk2dEZCV1lHdlUxdWg5eWp6TGlpS3dQNDlOMWp3MkswZTRkRno5c2dB?=
 =?utf-8?B?RTRmdVREWWpCQWsveFdQNHdiSHRMTE82QjJWMTNHSm1kN0xaQ3MzRi9JZTNE?=
 =?utf-8?B?TGluQ090M2h0c1UxRHZwTitCa0doNHF4dzhKNTdmT2JlL3dWcTZyOEgzUU9y?=
 =?utf-8?B?VnFMSTRubXl5dWxUcW5NTDZ2RHI0WHFhRzZQY3hmUVRESURmemNYajFZOFMv?=
 =?utf-8?B?eXNZQktYS3lQYlVrSU4xT3RlN2cxdWtEeVVSRzA2SFdNdExCVTIxZmxFOU53?=
 =?utf-8?B?eTQvK25qSlNzYzB5OVFycFQ3cUJRdHBjVGszb3lrdXI4UWtvMUlLRUh4WkV4?=
 =?utf-8?B?Z1FZSXhoN1VjZnE0NENWY2c3MHJnWFpvKzBveHBvaWNaQ3M2a1JVOUhxZjFB?=
 =?utf-8?B?UVc0Q0xiRGt0VnEzZGYrNTlQR0VONisyZG9EKzBNeE51TzI1VkF4QjBRYlhp?=
 =?utf-8?B?TTN0VE44TUFaaG9Bd292NUhuZnZPdmxwOUJERHNpWWdFWERDank0ZFZFdmNm?=
 =?utf-8?B?M2tTaTJuemh6T2ZFNkYxOXVrZ2pYTVZBVDE0Y3F4SklqTVVJcUcwWTY2WitG?=
 =?utf-8?B?YisxZUFXTXJGSldwSjlVcGVWYzU1Z0ZMSGhpT3FrRzZUcDBNSUFLT0s0RlQv?=
 =?utf-8?B?TEh0L255eUhXcitERVNZaFltaTJxeHR2cXpGbFBNUHlDU1E4WFVUTXdlUi9O?=
 =?utf-8?B?Y0tIUTlsZVpZRGtteGp5ZEI5MjdlTUZIb0xNSGRMQmI4bzg5a2g0ZElweW1G?=
 =?utf-8?B?SXpPQ1BZZkhlTTdXVjRyZ1dBSWpEQzBzOWtlMEdlSnNjRmJEeDRZNTNYWExl?=
 =?utf-8?B?dFBlYWZyYVNFeHNaWkwyOTVxNVZISHI5bkhIaHpmSE1CRndLUTM2bURDNmpM?=
 =?utf-8?B?WHFIQnNiWTRBYmNrbURNN241NTA2b2tna095UWl5MEtSa0pxVTl1TUxpZFpH?=
 =?utf-8?B?ckIzUXdraVlpaG1aemlyZVRaV1JuZTVnTVNkS3ozOTBNYm9hZlcrdVliY010?=
 =?utf-8?B?ekFEVVdZdklmVkFYVGVDNCtzUzJoNkd5K0dYTU5veVZZNUpxTWluVmVKU0do?=
 =?utf-8?B?eXBJQnF5T3N1SlBMN3RWMnlUancyT2FLQkVtL2dMSjVzb05la2xBZlYzTnNV?=
 =?utf-8?B?ZGtGcnFQMWdhUlRnK2hGNTljaDBhcjhKblhkNDZESjlOckhUM1BLVGlweTRw?=
 =?utf-8?B?N1ovdWVVbm5tb2tGNFo4OHdGTGoxeFNJdW04TGpZdUNpaXVKbU9xQVJBYytt?=
 =?utf-8?B?T04vb004SlI1c2ZQdG1Tb2lLK2xOQnFwVWU1R3RTcitmcVN3UHREVC9OV241?=
 =?utf-8?B?S3FvaUdYVkUxdEVMOFo2ZnBZNVRNT2pMMlVBU2R0VXQrd2tzQWtNZllZRU92?=
 =?utf-8?B?dXFXTnZiVjZIRmtHajMyV0d5WGp3QU1vNTgwRHJ3bEhvdTFaczBUalNUNVdk?=
 =?utf-8?B?Q0F3U0VSU1d6MHgvUjlGR0NCN244WncxVDR2NjFzeHQ2OWdJWVhabU4wOGd6?=
 =?utf-8?B?c2U3MmUySEFCZ3dEcnVSaEh3UE9SdFNjMC91N2hUQndlZnREMURydmtuYXdP?=
 =?utf-8?B?SkhmT1ZRU05uNTBvejR4Q2IvSVRxcExwTXF2ZFdyRWd6UzVLK2Njb3htS1NY?=
 =?utf-8?B?RnBiOFJKNDlwVW1ReVY1QTFZUGQ0eUQyK1R5ZnFtNTZYTXhGcW8ra0dDY2VV?=
 =?utf-8?B?TlM2aHZ4TWlSbC9OaGhLRTF0MEZnalgxRldlZU50cjByM2Y2MEhqOGwwTVRp?=
 =?utf-8?B?RkdNWWtmdzhHYXlCQ0JyLzIzdUcyOEZYMFphdzl4NFZQaGJ3T3RrdTI2ajVN?=
 =?utf-8?B?Y0Z6am80WWh4dGxJMlI4R0cwSnFNOHJnZzVyQnJIY3NHSUJERFVvS01LdjZ5?=
 =?utf-8?B?dC8zdXJwM3R4bkZHMEpsYndnL2orc1lRaTdDRTd5dWppZkpyNHdMdDNoUlRt?=
 =?utf-8?B?Z1h4azF0QjRyQkZtaVB0dUNEWVVXd016cGsxcERreklqanNuZm01eHhyUEVY?=
 =?utf-8?Q?U8nE7JF8LtFTu03JQ1AWd3iQt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca3d637-d0fd-49d6-e292-08dbcbe94030
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:38:06.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJEC7l8F50FuAT4ODCBntRDmarWow0zluhGXfdnujWmHa8ItXIgLmZixuBWpykC3q0kTOdI6eEqZbHraapCbYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
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

On 2023/9/27 14:37, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, September 21, 2023 3:54 PM
>> +
>> +/**
>> + * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
>> + * @iommu:      IOMMU which the device belong to
>> + * @dev:        Device to be set up for translation
>> + * @pasid:      PASID to be programmed in the device PASID table
>> + * @domain:     User first-level domain nested on a s2 domain
> 
> let's use stage-1/stage-2 consistently

ok

>> + *
>> + * This is used for nested translation based vIOMMU. e.g. guest IOVA and
>> + * guest shared virtual address. In this case, the first-level page tables
>> + * are used for GVA/GIOVA-GPA translation in the guest, the second-level
>> + * page tables are used for GPA-HPA translation.
> 
> No need to mention guest or vIOMMU. Just stick to the fact of
> nested configuration.

how about below?

* This is used for nested translation. The input domain should be
* nested type and nested on a parent with 'is_nested_parent' flag
* set.

>> + */
>> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
>> *dev,
>> +			     u32 pasid, struct dmar_domain *domain)
>> +{
>> +	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
>> +	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
>> +	struct dmar_domain *s2_domain = domain->s2_domain;
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	struct dma_pte *pgd = s2_domain->pgd;
>> +	struct pasid_entry *pte;
>> +
>> +	if (!ecap_nest(iommu->ecap)) {
>> +		pr_err_ratelimited("%s: No nested translation support\n",
>> +				   iommu->name);
>> +		return -ENODEV;
>> +	}
> 
> this check has been done when creating the nest_parent s2 and iommufd
> shouldn't request a nested setup when the specified s2 is not nest_parent.

yes, it has been checked when allocating nest_parent s2. Current iommufd
nesting series does not check nested setup specifically. All the attach
logic is common across the domain types. So it seems no need for iommufd
to check it.

> If you still want to keep this check then a WARN_ON.

may just remove it.

>> +
>> +	/*
>> +	 * Address width should match in two dimensions: CPU vs. IOMMU,
>> +	 * guest vs. host.
>> +	 */
> 
> No 'guest'. Just that the user requested addr width must be supported by
> the hardware.

sure.

> 
>> +	switch (s1_cfg->addr_width) {
>> +	case ADDR_WIDTH_4LEVEL:
>> +		break;
>> +#ifdef CONFIG_X86
>> +	case ADDR_WIDTH_5LEVEL:
>> +		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
>> +		    !cap_fl5lp_support(iommu->cap)) {
>> +			dev_err_ratelimited(dev,
>> +					    "5-level paging not supported\n");
>> +			return -EINVAL;
>> +		}
>> +		break;
> 
> I wonder whether this check is too strict. a nested configuration doesn't
> mandate vSVM. e.g. for guest IOVA the s1 page table is not walked by
> the CPU. Adding a CPU capability check here doesn't make much sense.
> 
> Of course doing so may not cause a problem reality as very likely all
> Intel platforms have same 5level support in both CPU/IOMMU. But
> code-wise it's still better to do it right.
> 
> Ideally the guest will be notified with 5level support only when the CPU
> supports it then it's the guest's business to choose the right format to
> match the CPU capability. Misconfiguration will be caught by the CPU
> virtualization path?

yes, it may make more sense that CPU and IOMMU side take its own check to
avoid misuage of 5lvl. For vSVM, it's guest's bussiness to ensure its vCPU
and vIOMMU both have 5lvl. will relax the check here.

>> +#endif
>> +	default:
>> +		dev_err_ratelimited(dev, "Invalid guest address width %d\n",
>> +				    s1_cfg->addr_width);
> 
> ditto. use 'stage-1 address width' instead of 'guest'.

sure.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu-
>>> ecap)) {
>> +		pr_err_ratelimited("No supervisor request support on %s\n",
>> +				   iommu->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu-
>>> ecap)) {
>> +		pr_err_ratelimited("No extended access flag support
>> on %s\n",
>> +				   iommu->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	spin_lock(&iommu->lock);
>> +	pte = intel_pasid_get_entry(dev, pasid);
>> +	if (!pte) {
>> +		spin_unlock(&iommu->lock);
>> +		return -ENODEV;
>> +	}
>> +	if (pasid_pte_is_present(pte)) {
>> +		spin_unlock(&iommu->lock);
>> +		return -EBUSY;
>> +	}
>> +
>> +	pasid_clear_entry(pte);
>> +
>> +	if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
>> +		pasid_set_flpm(pte, 1);
>> +
>> +	pasid_set_flptr(pte, (uintptr_t)s1_gpgd);
>> +
>> +	if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
>> +		pasid_set_sre(pte);
>> +		if (s1_cfg->flags & IOMMU_VTD_S1_WPE)
>> +			pasid_set_wpe(pte);
>> +	}
>> +
>> +	if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
>> +		pasid_set_eafe(pte);
>> +
>> +	if (s2_domain->force_snooping)
>> +		pasid_set_pgsnp(pte);
>> +
>> +	pasid_set_slptr(pte, virt_to_phys(pgd));
>> +	pasid_set_fault_enable(pte);
>> +	pasid_set_domain_id(pte, did);
>> +	pasid_set_address_width(pte, s2_domain->agaw);
>> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>> +	pasid_set_present(pte);
>> +	spin_unlock(&iommu->lock);
> 
> All changes within iommu->lock are specific to the device specific
> PASID entry. Probably this is one potential cleanup TODO to
> use a per-device lock instead.

yeah, a separate cleanup. is it, @Baolu?

>> +
>> +	pasid_flush_caches(iommu, pte, pasid, did);
>> +
>> +	return 0;
>> +}
>> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
>> index 4e9e68c3c388..7906d73f4ded 100644
>> --- a/drivers/iommu/intel/pasid.h
>> +++ b/drivers/iommu/intel/pasid.h
>> @@ -109,6 +109,8 @@ int intel_pasid_setup_second_level(struct
>> intel_iommu *iommu,
>>   int intel_pasid_setup_pass_through(struct intel_iommu *iommu,
>>   				   struct dmar_domain *domain,
>>   				   struct device *dev, u32 pasid);
>> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
>> *dev,
>> +			     u32 pasid, struct dmar_domain *domain);
>>   void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>>   				 struct device *dev, u32 pasid,
>>   				 bool fault_ignore);
>> --
>> 2.34.1
> 

-- 
Regards,
Yi Liu
