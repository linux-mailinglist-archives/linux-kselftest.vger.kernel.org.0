Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E082D7ACFF8
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 08:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjIYGUP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 02:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjIYGUM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0D1A6;
        Sun, 24 Sep 2023 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622793; x=1727158793;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jmXZ8cEhQWu9XfaTP4/3UCstn2tqJ9y8evOO59e1NmY=;
  b=gQGJnYhRQhLpSG/DM03Od8ZnURnk81kTn6Tuz7Fb1v0ko6aNMv4IAPR9
   YBoY0gfWJcRaox6x4NPbFg8Bqj0qELv4U3EvuW8nE8aRNNrUFfnUaN92c
   QOyqz0NJm4O2hFBHSY7NYDS+MTj2wdymQRhObp8/O52YzgHfFwBh77oJG
   h4MgaM6/wMIEWg6OGLQP3Pjw0szrcivvirkv2bDyhSegxJ+6q5AFad/W0
   sxNVYUu5h8Qrd2dU/EOIgmibpNkNeTBkekGS0YN9BU5uBWw1A/j9PmhJr
   kF88m8qR8jScQlSH61CBNl1kDUoxbJIgqKjur3+4uNgbozxQ/ZDR1rhDU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378445202"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="378445202"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="697877815"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="697877815"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 23:19:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:19:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:19:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:19:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:19:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnGGk5EYACKuwPkGpMMKQf5ALwWyF/UWixT0e19Ag2trbb9vBDLGBaD1TBAevdBcDu1eyCpiaga6vFmNT/qhrzHpwUVgNgY+10VWOPfkUWjcNp1jvUEdmkPPKphfU+rDiKXI3+XvzaFVgNNVhZvVElPr+49D8+aAtVZDwQ5KGxtvHzMSQ14T5OjU2YqypQoK5ih2ZDIxzs8kpP6n5J7NkNzhm41wD/PJblKMV3PkjmByqLbeIAUWVw4sN2EY1yfdi6ntQpkIaI6PfI/AX2+JLPTgpyRyzoKdBi6SGQpcvr63u2KkqauXOJzYr/oQxJJSOaIr8MygbMitFwMzGaJgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++FgRckKEoF319P8W0nwT1i1vXa70p1LJ67Tuh90S/U=;
 b=agtDhmf9+Gm+BX0c1WlL44pW0roRJ8/A9tyMhjDEsc+i5FLoKmyVW5+HbCQUP8NPYPE3pqTeVT3gZZ6bCsJ00q4P95k0KJw7e42E19EV3S1ANClcb2fQ7QIJtjXed6LKwQFPQPRt28jqAwfmIofWcoTgZJOoBM2QZVmZMk36QE5KIS4cMuZcem7pVH0WdUH/GQebEfwDhqGGY5K9Aa5CdN38uGN7wGDiLDuYGKCd7/LdrKBYOoh2P6M6c9/v4JWXAhjCy/yDMBbtTiqOIQ6+CcPK8IpUjiV4KnmNcbbzMcQlCgsfUpNqR1SjqPbR8uVtXUfFB6hVGTXnsGD4j8BRiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8441.namprd11.prod.outlook.com (2603:10b6:610:1bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.23; Mon, 25 Sep
 2023 06:19:43 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:19:43 +0000
Message-ID: <15831871-cace-f954-6af1-328039ffda16@intel.com>
Date:   Mon, 25 Sep 2023 14:22:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
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
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <4b17d331-957b-44d3-8a19-0b2ccc59150b@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0034.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::21)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e3f0b6-b209-4f51-5d05-08dbbd8f67ca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vEIKAKwtLZuCZI4heRjkU3yDdl2IGtYzRZ9j/+E2Oapq316z3vefDGj37NgmNToQg0BCDHfvDBBQSrMbarYuUKbzrWLLvXUDd0hmLk4tSmyg1GmW80EeBbHeE/WxZz6S+Zq/nS5szJ0bu+Nla4TV7Xqyn0DTJtMzoFQM9DboiLzWBxlYZ2E34yrMvgiXDFncYXmAfYqcZ4w6LI79RzfKdZXUvHOZmXLe0FnmmaignScPmF0Z6ekqQmixlohkE1DtoUxMNX4PrKQ2R6nwo3MAQpSkEWXDxQ7jvdrAk/3Y7Qo1X/BzBzQyfxt+bd+4JJmiaYgfFEBxTIwlFUtxzKw6BcGxI42BUBqLyycKEgrPE3TNIYy4wN1Rav+thbvvswPDfVSX0Xz3fC0EnMuR6t5xuTyDwZWaa2cK8jEAtb4xsHPyyrbsn+22oheVcGM7Ie7Eg1wUvg2pYAOrWc7baCrUsx4JPWD1h3rFoaAPbtk34yBFOMlVS5a0OakUFbGFaOb4GxkXgL+UAtZPdfpvCacEropci5irAjHCDqhs8RMgTcNJrSIg9PMnJaHrnbGJiaskj3P0z1p86B9aG5BoqHJVx5PEYPhAo9o1gafFqAtFIFBVfyAL2+c1bvscwsV2t9kkAnJCkCxxarZq5+H+p62F8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(31686004)(6666004)(6486002)(53546011)(6506007)(4326008)(66556008)(7416002)(82960400001)(86362001)(38100700002)(2906002)(41300700001)(2616005)(31696002)(66476007)(6512007)(26005)(36756003)(316002)(5660300002)(478600001)(8936002)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVBobkJURjU0cWp5OHU0S2h4emxVaWl1cHlKZFpNN2J1UmdtSi9oYm44aTNx?=
 =?utf-8?B?RnZzaGU0SSswakN6RllndTRDWW5WRWNzQzkra0F4UkN2SnRmRGk1ZTVvb0po?=
 =?utf-8?B?SWJVVVFGQ2ZzVnhxN0prcFlrM0QvNFNjamwyMkUxNUVDR1FTYUJ3cndpcFhq?=
 =?utf-8?B?L2FKZE1wZDBzMy9EQzlCQmxMbVlwaVg0RkNxZkc1ZDA1eGx3SHRLeXYvdUdl?=
 =?utf-8?B?MC9NNlZOc1NqdVdZOE1vVGk1RGNhb0EyYmlIeG52Z0RKSHBPVXhvdzZwdzdz?=
 =?utf-8?B?Ukg3NmNKdXVYWjBUaFRBaDYyQTNLRlc1M09EaU9vV1paSXYrcWkrWW5ETit1?=
 =?utf-8?B?Y0NDT3BDL0ptNTJmUnZhdXpiQmxBZ3V1blptei9LY2hPZURuL0VTTWJHWFNY?=
 =?utf-8?B?aWtUblBxdDBERzJrRWZ4WG1VYXBqckFEUUsyUCtsVlFUSTZ4a1pjSzJ2cndt?=
 =?utf-8?B?b2hQUmVhVm8vOGUrRE1rV3p0dHJRUFZndnM4YjFUUEE0OUUwQW85UzNsWkVs?=
 =?utf-8?B?bGVMS2NiR0pJR0tnbGFuODZUS1lrRlA0VGdXYXZwQ0NQMVF6cGZjdk5Ra09S?=
 =?utf-8?B?ZnVqUmNwTHJyQzVjUVIvQWErTUNEbTlVVVNndkVLUHlpdjhCTFphTzAvTGkz?=
 =?utf-8?B?NlpyRittUXVpbmw2U0s0cEdQSnh3WDluQk5QRFdVY29RSkRWY1FTcUdNbWov?=
 =?utf-8?B?Mmd4dWJqNDhuWjVBaGVpTjlXZGtqcXVzTTBuemhSTlBSMmNScjg1VFRJaFpN?=
 =?utf-8?B?R2ZmeUQ0b1cyZVZDUnc5ZDlaalZsZ3laVXJlNXZ1V3EwQVFpeHpDZm5JMXV0?=
 =?utf-8?B?ZlRTc0wydCttOTloMXhEMVNxQUNpcXBtUFI3OWVBME9GKzlaUUNLbDg5QXMr?=
 =?utf-8?B?Z2VwMmYyTWpjalIwbXJWZGV3ZHZDLzBhNUtiaHljRHIyaXk3cHNkT1RqSDNF?=
 =?utf-8?B?emd4N1hCM2VQZ25qMEVVQS9lMDliRVgvV3hVQ2Y3UzFjK1JuQW1GV3BNSS9N?=
 =?utf-8?B?MlhHOUJTSmJhdThrZEkvTGVneGhmL0M0aFJncmt2b1YxMkk1Uk9VNVhHZFZF?=
 =?utf-8?B?Zmd3dFpyRE92TDd6WmRpVFlkSy9ZM29PQkdrdFYwZ08vYU9CamxDRFplbVE2?=
 =?utf-8?B?V3hwUHZQeFFYL0RwaGttNC80cHJabU9oaWRROGw3SisrZmdGTnRtenRJeVI4?=
 =?utf-8?B?c0JJREhVeWorcUpxdVdtQTZqcllNdGZPWUVzOXJnSVdDb09IOXl6V0ViYktM?=
 =?utf-8?B?eElpa01lckhWWlJ0UXc5UXN5dUZCNm5EQjlXeldUT3JGUytaZmNLN0k1aFFX?=
 =?utf-8?B?ZUlhTFpaN296NjRuQWFoUGxvUFU4V0UwdzBWZERHamJIUmdtQUc3Q2ZNM1gw?=
 =?utf-8?B?bm44eEJ5VmdrUndzK3BNblk1aEd1M1hMcGg4TGJjdGxSUEFOM045RGdCa3J1?=
 =?utf-8?B?Q0tOK004VUNIb04xNGpXV2N5Rm9YQzBUK0phZ3ZwMU8waTVEWHZWV0d2clZn?=
 =?utf-8?B?LzhlM1p5aVdyTFdSSjRiZ1pyRGtvUHdiR2FqNHBjd2dtenh3cjYweGhoc0R4?=
 =?utf-8?B?Uko0aFROVlZ4akJQUFMreExxdHFHaWtMczBLTGI3dzQ2S3I2NWkxdGVoQmtu?=
 =?utf-8?B?NStZY1JBSEJlTGYvUVJTU0VXdXFPZFlxMUIza1VRNGxFUUhjeGxCejFhMm1j?=
 =?utf-8?B?NWVyUUE3Qi9OYmE5YTd4WGhhTXd3KzlzeGNJdDA1MVNCQUwwdTI0Y2UxNDdM?=
 =?utf-8?B?QzhQZTlKbXppYVE2dUkveVY4OGdDREQwTXJVMnlaR0x5WktSd2NRTHkzMGxS?=
 =?utf-8?B?VzdEVVpGRGNSUWVqbm1pVHNVSWZpcTVKQ3pNMnljTVJzYXk0Tm5MeVVlTGxp?=
 =?utf-8?B?TUx0aTBuNDNwcEJIak0rY3MwQndVZ0NwMjRhZ0dYVG9tbEZhbVZBeDIrWTYx?=
 =?utf-8?B?RFAwcXBFbGJVV3lHNEV0U3ZPTFNWakFhSFpWR2ozY2NvYnUzVUJNdlBUdjhk?=
 =?utf-8?B?TlREMWJONXpJT2Z0MnZlbElQNy9meDZYMWJyZXhFSmdvenFsbXc3bktaK0Fn?=
 =?utf-8?B?S2hhR3FrOHJjVWNPK1lhcGZPTUhmNE5Tck1rR0g2U2d5YWNaMVFEcTV6S2dM?=
 =?utf-8?Q?Ix/1CHYjEvVmw8aimV8we8nof?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e3f0b6-b209-4f51-5d05-08dbbd8f67ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:19:43.0372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Gg3Vyiq5c+TD0s7J56C9PXcC3CXGsJOrsR+QbSKNUmMrVq+66bdrD1Dl7DFIZdQ/Z8BlIVr8Ypu+caEfC3APQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8441
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/21 20:10, Baolu Lu wrote:
> On 2023/9/21 15:51, Yi Liu wrote:
>> +/**
>> + * iommu_copy_user_data - Copy iommu driver specific user space data
>> + * @dst_data: Pointer to an iommu driver specific user data that is 
>> defined in
>> + *            include/uapi/linux/iommufd.h
>> + * @src_data: Pointer to a struct iommu_user_data for user space data info
>> + * @data_len: Length of current user data structure, i.e. sizeof(struct 
>> _dst)
>> + * @min_len: Initial length of user data structure for backward 
>> compatibility.
>> + *           This should be offsetofend using the last member in the 
>> user data
>> + *           struct that was initially added to 
>> include/uapi/linux/iommufd.h
>> + */
>> +static inline int iommu_copy_user_data(void *dst_data,
>> +                       const struct iommu_user_data *src_data,
>> +                       size_t data_len, size_t min_len)
>> +{
>> +    if (WARN_ON(!dst_data || !src_data))
>> +        return -EINVAL;
>> +    if (src_data->len < min_len || data_len < src_data->len)
>> +        return -EINVAL;
>> +    return copy_struct_from_user(dst_data, data_len,
>> +                     src_data->uptr, src_data->len);
>> +}
> 
> I am not sure that I understand the purpose of "min_len" correctly. It
> seems like it would always be equal to data_len?

no, it will not be equal to data_len once there is extension in the
uAPI structure.

> Or, it means the minimal data length that the iommu driver requires?

it is the minimal data length the uAPI requires. min_len is finalized
per the upstream of the first version of the uAPI.

-- 
Regards,
Yi Liu
