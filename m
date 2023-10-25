Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1857D67C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjJYKCA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 06:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJYKB6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 06:01:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6AEDE;
        Wed, 25 Oct 2023 03:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698228114; x=1729764114;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bH0Jo5x+aJy7hh2pN8FWYw1LSq495S6OTQTfQvLaU5o=;
  b=AbTaKMmo/LRAdQIO5/iMx9EU4meL6wFdSHUJvglNxOkA7e+JWjDq3ku2
   v6GnDISzXi5v6UmijUjg62WenmU9MsQ2G5yeEnS+Pa7X20cpxIDK8AZ2I
   KFOtK4fNGTfHbK9EB5vgVW5z7pmXBE8I1Ito1uQ1cSG5nMwF+jNax3Pbr
   TJIbq6yn20/46f9pM4OrxK2g6XynsoGcTpnnfFDVUpX60Q3AUaQtQLd7y
   DQk7g0xH6Q8rAdZLJymKE7p/iRuohC+fl/9xX1KFjflrXjPv5nE+5aVLg
   qxhJFe/UvQzLkbmtVznBrqoAt0laRCG3V9uGCisRV4AGAJs7u4/lrJhs5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="390129515"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390129515"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 03:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="1090159319"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="1090159319"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 03:01:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 03:01:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 03:01:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 03:01:49 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 03:01:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkBuSvFHCWu9q/7kSUth8Xojf9SqSTv5xCZfXkfcHKeUaL/A3t9R5HnEpierP7Q3PN0Dh3hdC/0oKG+dlwoQA1tiq3LMNLLslonP6Y88Y1N8vha42MV5yM4VtFP5FUYD1ba7eF3jwcsOam0OUH+3XNfVy9nnZ8nh1/lFPwAqTJcntiLPRk2dCrjwX71zxCDQuPVWvy3cCgDEOUjBigsLXGqJeX/Y1GeC8ieFwefpVSq+5GNy2LtHUpSEAgY4b0tDmh/ZWzgEeC9JuXlOR9oAVCZQbcu/Eqj+4loOAjfFgSXalEwPCGuypp5lbwdiuACgLTKY5LESJK/TiA6WTnyA3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U+TYZpY1XMPyV3JnAfWI12+pWXV1UAGnblJxJ1K0aA=;
 b=W8oOLm5dFk93KW6qlwRwBDlUSM09MWy9bUO34M4saz7/GBfiil2qOIEqA1YOz52HJCRZsl51lRfl5gXwUK9XG/V3k6tT4nbf7udNNuXhSTMsfaPyrTGr8FPmFoEbkFvjoB2O3Z63bhEvDk/gz2mmUVAjdmimbpNR60/LrInfr0gBR2GfQvAjkCXWBvKo8thUrUy7sjUSbEhFKBMLLFGPPAp3I2DIdNJU5YDQaxYlWwuThrJAGejRGSyuRrBwHsR7HGeqjAcjhwe6vkDHq/gcvJlwPh+ypwJfHzT/0LMBfFVpq5aNinTNUrFcHI3n0RdzoPgy1T73X5g0bVNCNRTwPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5182.namprd11.prod.outlook.com (2603:10b6:a03:2ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 10:01:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 10:01:44 +0000
Message-ID: <e7ec64a8-7980-444e-9e04-89aa87bebb93@intel.com>
Date:   Wed, 25 Oct 2023 18:04:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/10] iommufd/device: Wrap
 IOMMUFD_OBJ_HWPT_PAGING-only configurations
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
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-5-yi.l.liu@intel.com>
 <BN9PR11MB5276E2B6AFB5617395E9A5768CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276E2B6AFB5617395E9A5768CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:820:e::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f2d47c-6eb1-4136-bcc9-08dbd54164ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYDIF75vxVqKI1tkUkBRkMkMKSN3tz1r7Z/UwfUu2+bnEysosObCtqEy1jswjn0DkeSI+TKjtJUIglwBI2EeM43z0HEtd9/Cf8Rfw1F8M80lmko2zJomANikTTnhaUnkAZzLH6PQqRgGWAkzt4Yix2EOQgXeIHaEWvY+gR6C7v2S3tUpUJ0zDsur3dRXGLINsC1eYPUZWOCM6SARH+F2A/e8Tml6zvcXwLrD0D7trO9h0czJiPkM/9vJjWQehWEngfMQ4tOkDQVDlPOoShScNHWoVsUSIBpR67Gp06iiSdutEMa7aCx17y7eC+zecsRwP5jbVkvsN2C9A5jFQaYbY+rIVxtIKvoVFNCFiXtczvaClwtSLF5f1D99wOEDEOUhXg04O5rreEFazcnvs6WN8L0NPJ6lWRgg4Ev9jL6/CZspXYu7sDrWoe7u/Vpnkv+SwCEJl5XuFcjbBaEdZdG6/xpXwOEUXrmx3GwpluymfFsOfUY1f+HluLz/20JDEWdnSm+T+c6+t6Hg79kU881SZ4Tjw0Nk0LPnYYTs6lcfpvuej/vbiaQp0ilxj+AWTGx9GDRn65QWKBSwbGYtjQlnKcCDspZlvy3GqlT9VkZQaW2ZYzLKwUbKFTR/8XMaT4pxiglSWCYatNhBCRtpXJn2Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(31696002)(4744005)(6486002)(8676002)(8936002)(31686004)(6666004)(66476007)(7416002)(54906003)(66946007)(66556008)(110136005)(86362001)(478600001)(5660300002)(41300700001)(316002)(4326008)(2906002)(6512007)(6506007)(53546011)(36756003)(38100700002)(2616005)(26005)(82960400001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0J1UEdzWEtBRXJHSVp4WE9lY25NWDZVOUtIWVVCa1NDT2JQOTBRZXZwbktn?=
 =?utf-8?B?dHVzMWh2ZXR5czZha1VHdHV2U09VSGRXendDcE56NXlKL0F1bDFrZE1oOG9y?=
 =?utf-8?B?b1M4TXJIbVI3anZ3d1BLRXFRNDduTVlkQXhWTUZQdFpGRlg5VVdvMmxVbDFT?=
 =?utf-8?B?cDh6SlZKeTNtUi82UGhFTEJEa1FZczVkTnhFSCtvbHFuaHNJNnlnODB6WEpW?=
 =?utf-8?B?RE4zQ2I1Q3pCbXRxampsKytveGJ2UFpMV3VqVTdYbkdjWHJ4SnVFSUVLYXBu?=
 =?utf-8?B?UjlBRmJGbFlueDJEV2FBMDhINjBxSGFVNVhnLzhnUXhpVnlkMmZ1SEhjdXow?=
 =?utf-8?B?VjdRemthWTBUUFJvakdLS2o1UGZvVlBkaURyVU0xTnNUM3FLN2E2WEpHSUpp?=
 =?utf-8?B?cUpTNDZwOHlPMWRQek1BY0hUMHVzL3JObEd2cjFNQ2MzSGgyVjEybll6eTR5?=
 =?utf-8?B?dXA1TVhlaTM4Y21pdVVlbVpDYjBrT0tPdjBKMTV0RHIxaEd4Znp1SWpmWlp6?=
 =?utf-8?B?YnJaMmtZMmFoY0l3S1FYOEd4dGlDU2ZEOGdrZTdxN1BDYlYxbkFRdDBqNEhp?=
 =?utf-8?B?YWtMcWcyODdpdkE3cGZraHNBbW1yMWZZK1UrWkhLa054bUVJREwxeTNOVWJU?=
 =?utf-8?B?aEZFcldLOHhCT0F6bWlVeTNsa2FUcEtwOHF5NUt3TzdxZ2NHWVlTcGZBemRn?=
 =?utf-8?B?cklvRG1zUkZ6Y25XL1U1eDNCOGdCVmlCb04xM010aytWOHN3aDVBbHFNNUw3?=
 =?utf-8?B?QlFhMHJ2YUI0VDRIakhBdHYvMURKVlhBT3NxM0ppZ1ZIL1hncGRVTWxuUmty?=
 =?utf-8?B?cWkvaHVzMDZmQnllYzBETjRWYWNsZFlqTXB0ZlJINmp4aGY3eWcvWmF4Nmtp?=
 =?utf-8?B?MWpQbzdRb3dQZmhSeU1WWmxFMytvbmRhWll4dzB5cm1WbW1pOXdsOEZqUmlS?=
 =?utf-8?B?Vkh6ZjQ3TkNQZ2ptcHZ3WER5MWNjSG5jMTByMTY0VFZvTGVpVzNyMUJvcUhj?=
 =?utf-8?B?a2Zsc3BIMmVuSFdlZFg2eGxuWEppbGNyYlVMTUZJQzJ2Wm9qTzl6MDFGOTND?=
 =?utf-8?B?Mkk3aTFFcjM5RC9UcmFzdyt3NXE2amlRREp1VGx3ZjZwQ09PZ2pwUzQ3amoy?=
 =?utf-8?B?VUxDdFJiUVF0SUM3YWN3UEFoTnJlME4rZms3amRYbjg5eE1RYnFqRzROTVA4?=
 =?utf-8?B?MGpxeWx4Rnk5eURxanRyN2xzT1N0Ym5DdE5MMkhjcm9KYncwSG1nNU5UK3BR?=
 =?utf-8?B?bFNmZnY1NUFtN2tDeHhyTHlQWHdiVVRYeENHb0VFT3E3TlBCREdIQi9YZUl6?=
 =?utf-8?B?bU8zOGcxN0QvSFg2Y3dKSjZ1NXI2RG96K1RjRWFsdHo3QlhDcWVYVUVNMFZt?=
 =?utf-8?B?dGhRRWNKK2VNckFoZGp2Y21nTGVmQlFvOExPY0lOc09ZeFJSQnBubkl4ZDJV?=
 =?utf-8?B?T0hjOFE3akJ5d01mK1E0eDBqVGhCampkZXRzQzlvcmJGVDF1MjE0bi9FSkR0?=
 =?utf-8?B?ZTlBTzEwZ1hTOGtUakRCNStSSGJhcC9RUEhGRDNRcTVlanRBVUZSTkVFNGwr?=
 =?utf-8?B?bjlYNmQveHJiV1g2ckZueHZ2ZS9pV3IzS0IrUEo4UkQ0M2lWTm1JVUNUdWsr?=
 =?utf-8?B?RHBOckxRenhQYjBMV3l6ZVZsMHVKbkp3dUNlbDFRbFRVdFF4SzcwZlliNE0v?=
 =?utf-8?B?NXBKTkFXWjFmNFpNODJMR2d6SjU2U1dncEZsc2RvamxvV3BXNEY0MW1uR2dV?=
 =?utf-8?B?K3FJb3ZYMzVjVlBZKzBIWURSQmlYMnVHYkpZMlkyYmFDTFdBa2RlU1hRYksv?=
 =?utf-8?B?RE1DTmpqcnpHcmF0bVF5OWlGdUNkMTBUUTduQXc3SmxFMlFycS8zODJZQ1JC?=
 =?utf-8?B?QldKWHpuYUZ6WWhMNnJIZGI1R25Td2dXc2FOSHQxNUFUUGxXb3h2TXBOUGJC?=
 =?utf-8?B?MnJCWlk2UzlQVlNMRmNHalhzWkZPMWhldVlNMHA5VmE1YVcvK2hUbHJYRFNy?=
 =?utf-8?B?eWpxdE5UUzY0cDdPQnlIYUN6Yll1dGRhRHBCQmx0dkozTVFXQWg5ZlBXQkxI?=
 =?utf-8?B?U2NsQTkvNGlBNTJ3dEQ2c2ozdTQwOVdRNmdZSWlxNDh6N2duZm1tWFEybEs3?=
 =?utf-8?Q?ikl6YOc4csQRg9p/asm0RS0YI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f2d47c-6eb1-4136-bcc9-08dbd54164ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:01:44.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MWD1ckOhPrf4UcoTtDlPFVDctvZF+j/wVjIIgKoDJg1x9dlGzLpC00pBAxg3BjbbWOp0i9uVlq+LKxBHlJ/1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5182
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/25 14:46, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, October 24, 2023 11:06 PM
>> +
>> +static int iommufd_group_do_replace_paging(struct iommufd_group
>> *igroup,
>> +					   struct iommufd_hw_pagetable
>> *hwpt)
>> +{
>> +	struct iommufd_hw_pagetable *old_hwpt = igroup->hwpt;
>> +	struct iommufd_device *cur;
>> +	int rc;
>> +
>> +	lockdep_assert_held(&igroup->lock);
>> +
>> +	if (hwpt_is_paging(old_hwpt) && hwpt->ioas != old_hwpt->ioas) {
>> +		list_for_each_entry(cur, &igroup->device_list, group_item) {
>> +			rc = iopt_table_enforce_dev_resv_regions(
>> +				&hwpt->ioas->iopt, cur->dev, NULL);
>> +			if (rc)
>> +				goto err_unresv;
>> +		}
> 
> should be:
> 
> 	if (!hwpt_is_paging(old_hwpt) || hwpt->ioas != old_hwpt->ioas) {
> 		...

oh, yes. The original logic is to add resv region when the ioas are
different between new and old hwpts. But now, if the old hwpt is not
paging, then it's already needed to add resv regions in the ioas.

Regards,
Yi Liu
