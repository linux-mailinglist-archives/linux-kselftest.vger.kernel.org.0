Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69B7D6607
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 11:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbjJYJBK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 05:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbjJYJBF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 05:01:05 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 02:01:03 PDT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1B184;
        Wed, 25 Oct 2023 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698224464; x=1729760464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F7KVYOoBR6aI9qN4BYFVxYwZwhTmIL/qtUgg4TNgHcQ=;
  b=edas2FQsdh2FK87ki/tKBW87TEBaNKT2KmnIK0YciC45tmS75aafN1jA
   cV1oCq6iCfiKZBJiUe8+8FT3alFqCZ4pjNme+laWepI0oFCyUiqcJdbcO
   wj0nFIx1RgrCWBbAZyqubYo7BnFrB4NPIO+Zii+nBHFyt4WJAcSgnNVZh
   uoUZgY4ZONEa2TXV3iYbvNqCwM49vv9j7jbQ+JCqU2WqmEJX7wVbzZ5Gj
   +ASXqM3uDcZ19qS3l9TQye/rYNbo7Ih1TyePN8KOFQFoN6tVym/smS4wa
   96YxWeWHB7BeIPl0HiIOavWETzZ8yYrV9u7L+VnLuzXOziDb9eCyTGrX4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="33493"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="33493"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:00:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="6463693"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 01:58:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:59:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 01:59:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 01:59:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 01:59:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWY5S0SAeF5tAMhgPyoH5D0nTKIkRQe1ea/Ndi2Yk/IbsVkM2nuARhPUzY2brTgCXy/x/t8GGqLs0sWX4V73nKuVE89bUiQ+BKN1KCsa4+gZ+ZOHg4rBh4D6T2WboqdqoRaW1Dd3ZGAYbWLMjUQwb6rqWsWuxdWNKv4s1/Q8U45n0/QCA9iH8/mGZ4FVMwi76oyX8BTRUTpsIa1Ypb/t6dFXCCMuzNedIAMvEzjHrdAyFTsoYgBrI12zVGEbRQwJixPdAPmJcUsPDq4y5/OANSYvbVg9a+hatlH1l6NbJJse7fspmxpSF4AcW39G1MvK+jj/YMA1nRaC5vcLU8rJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GnLZW2R/3voD2RuJ+KRFuhJocuTJT29iOZ65stCUqyE=;
 b=I3veDGInRIpQ1kHVr6RbtD4MYS+JoC7OP0cPOB3dnbNyJiEba2SWm1/UaE2MJJcOoIXOBzQ2muYzdZjzgdvOT1fnPHtUP9XM0D8DzbkJIIxJTf4bp6w9RtZSOEjv6gfN8s4kXe2ETUMRLIy98mRvGQbr/nDkmvlc5aGSTTCMUy/1bWAiD2RgtMXhrM45eKP+FrHn6JB8t1I6ldtPdiKeS48Z0SqDPJtvRmNNCsCMFxnZuBbQ7V2+O6DWPJEKQV1vFjoLx7fyrnieUZWN098Gf0lfmgN5a20z/qCxvnSTf4cgFgNaMksCOxZ8Sdk7wXUxTtp9/hWnhSJIFX85BsVZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:59:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 08:59:55 +0000
Message-ID: <04b3cc65-fcb0-4a33-b012-0085e7886e33@intel.com>
Date:   Wed, 25 Oct 2023 17:02:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/8] iommu/vt-d: Add nested domain allocation
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
 <20231024151412.50046-8-yi.l.liu@intel.com>
 <20231024230319.GW3952@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231024230319.GW3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 4817d645-46af-483a-5c89-08dbd538c107
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ofJCwp97dV9uof7qpAzNIRj4CkmgaPq9wbKeYLg5EJsPWgYDd6aVV/PZpUNdWoZRvbynfbjjkCkojygi7myH2Tpd2Lr81ClSDG8roF1sSVfH0hjH7BMB1UUq+/He2GBbue6+S1msH/l9gdNGVp856eexkipLzxei8A5wcZDwcaVM0rDCnSohox0pXSdby61foKS5QmEnfRsanDd1uhDM2RMIuJlkUsqJgCSmTBuvX8Oyodzy5K5Zhk9s2gORLyJx4xEvQuT/7roWfSZMn+QXhQWO3c7I1HiJHplqcNWmjhT2O8lZ1EJ+uahNqdmNFqmmEyGeLXEBb2PXB10iQmG7AJdfjjK6mPhMONHKH36zdYfoZk+i+H0lUR6ncLuo4IB6f5AyW6ox9jpJCCeGlxOHisWeqKdw6EtEXz2b8zbjiweWlnbnj0jh4OlN7cyUNOu5Ww12ooYgyZgeoe3jPc6m+3RIxIHymma6y9yXnfRZIocKkohwzgWEzidTeURQFDyJnI4gtIWiQnHLgatB86VeKfnFk4KIZCtdmURue82thTSxf0lNS5s9oHaSkUWhMI8X4GJ4IDYIO4zDGUtTx6HtloPMaDCYh3SFdpsc3d58mTrfiwIN30Oq4VlEkD/MiiPvP0H0E7C38l3dZdb+a9v6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(478600001)(26005)(6512007)(86362001)(6666004)(6506007)(316002)(6916009)(66946007)(66476007)(66556008)(38100700002)(36756003)(2616005)(7416002)(6486002)(2906002)(83380400001)(8936002)(8676002)(4326008)(5660300002)(31686004)(82960400001)(41300700001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bW9lNVNBd0xoU0VrakxYQXFBempxa0gxMkJGVU5ZMUtZNlRlbisvSW8xeXFn?=
 =?utf-8?B?Q0VzVmZVT0hnakZmaHlOb1VJckpBeDBmVjBVT21ReUZVQXlhbnUyYzdLcHJ4?=
 =?utf-8?B?b2ZLM2RMK1hCNkFDNnhEM0h2aDFhTUwxOGxZMndKNDl0QnpMcno1ZXNvYVhX?=
 =?utf-8?B?S3RObW82c2JYQUlmTnNXUHlVcS9Ibm1Ma2s1K3NGRGprZzcwdFJ2QVFqNEhj?=
 =?utf-8?B?OWpqRVUxVDQrSTY3YXZpRmVtR0lHK243YjMzcnU4UVo4L1EzQ1ptejNlcHZM?=
 =?utf-8?B?REpha2hRWjUrcnFXN1NIN25RaFBlbEw1RWVDVTlucjBsZ1NNMnNRZWwzTFcx?=
 =?utf-8?B?WDg0b05tSEJ1RnNMcFNQd0ZBOWZYUEc1dHAyOVVtR1BUUkorMFFqNzFzZzlp?=
 =?utf-8?B?aDFHaGo0aXRMcDYycU11bEJHK1RBVVlBOElNNWRGbC9LS0NHN3FWRUlPWlN1?=
 =?utf-8?B?QW8yeWV0MzlLSTNXd2MyUUlCWmcwTkVhOUFUOWE4R3VPL1ovdHFXRzJ3RGl1?=
 =?utf-8?B?MTJnOE4wT3llNWhHOENrYTRIRXpVOThNSEFINWV4RXNKeEcvQzBaOGd1aVg3?=
 =?utf-8?B?WUNsUU9aem9VOVkzYmIvOW5NQ2RYUUxLSXBNRUpvOHNjRGxuOWdvRHdhdmIr?=
 =?utf-8?B?R2creVJtdXowaHpxZUNodkx1NHJUa0RZdzVjb0F2QVhHQlQyVVNGZytKa3pP?=
 =?utf-8?B?N2d2THJtTlUrMzk2a0FEOU1QT2RWanZ0ZmxpVFhjb0h5MnVaZExvZkhGZnJP?=
 =?utf-8?B?dTJXdndjSklPUDRzQlBueDBVZ3N6K0wxSy9PcVNsenRqRUdoOE15RlNJV054?=
 =?utf-8?B?bGxrckZ1RlE3eUg2anFjK0MvM1d5L01ZOVVTWHRQSGFMN0RxcldnRGxRMFdl?=
 =?utf-8?B?MlZqVURpR05GZlpBM3JxSXZhaFI5Mld1Q1d6NTZRSEpDUlppWDZ6cDR2WC9F?=
 =?utf-8?B?a0o5d0VGV0wrMzduK3A5UDQ5Y0U2Tklhbk5nQTBWdDdpTFBxdzNnMnZVQWZS?=
 =?utf-8?B?ZjV2dGxVZTNueDlyN20zQ0ZpdTY2ZXdESkZaanFqdzV6WXVGNXorZlBWRFlu?=
 =?utf-8?B?cVpNSGRQWnFXalFGQXdTUlQ0VzBXS1kxb2pIZG1NZWExZHdjWnpnSXBJS09l?=
 =?utf-8?B?VWI0NkFDNDhVZnZXNkNZZTZ0bG1LQ1orQ2dMUFpuYmVvZVJjQjNxKzRLbGhi?=
 =?utf-8?B?dXlFODdtZEt6cFphbzhRdGU5aUtmL1QrUXV6VVRvOTNTQXZKUHp3eHFTWGk1?=
 =?utf-8?B?QWgyd3N0Y093V0F6WGtrL1U3YWNJR09FcXhDQTJTaFgrcFZ6UyttdXdHeC9X?=
 =?utf-8?B?amFnRlJobGIxWVk2czk1ejlZMzNxKzZOS0hNdXhxNkwzSkwxcmRoaUNKeVoz?=
 =?utf-8?B?THBmLzFuV0tzeURFMWJMdDBwajhnOHVoVU9GNExibFQrTXdPdHdFYVBtbWtv?=
 =?utf-8?B?dGRhaDQ0NnZXMlllbDBpRnJ1RWdWS29heTh4ajk3djUzM1dpNHM0WStJWlM2?=
 =?utf-8?B?bHZvQTN2VDdxa2tCMUdDQWtDenUwNFhhOWhjaUM5K29TUnRaN1V2N3BzUmtO?=
 =?utf-8?B?VDJUdUhpQ0dFbTdGVklRTDdLam5YZy9mU0MveFY3SHJIb2JXcDRwc2xOdzBz?=
 =?utf-8?B?ZE5KYVpYR29TTmFYazFkU05PaGpkQ29OaXZ2aS9PUGUreDUvcmdvbm81SWZn?=
 =?utf-8?B?K2U3UVlFNmVxZzlRWkQweU1hZTVCQURPUVR3ZVlCOWJmNFVqQnRqR2JZcDJQ?=
 =?utf-8?B?eldWKzBaWFU3ejkrQ01Yb3ZCdTJpZ0RpdHJPb2h1UytyM3QrYWk1T0xLelBR?=
 =?utf-8?B?YnJ2S1RNRzZvTGVqOHM3U1JJS0ZSd3F0Z0FDQVZ1aDhMS0VrOEJFRFo4RG5j?=
 =?utf-8?B?OE1wWWdpTWoreFZYZ0dzN3RReDRSWWZ2cXRabEI0T2lweEZkNkRDa0RTNGZS?=
 =?utf-8?B?akUvZGtENllBWERESkcvRXVPdVZCSVBVTzNSQnR3MXZ5a0o2OWZYZEFKSkls?=
 =?utf-8?B?Q1RXRlRDaU1SSW4wN0N0dDZhbEZ2TGpvaHNrVGNXSWcxQVZnSjl3bklrR1hi?=
 =?utf-8?B?Qk5CdDdkUjRTanQyazJiK1hPNEs3ZEt4cWtXQVZnSEhUSnM2eFI5cFc0NFB0?=
 =?utf-8?Q?vzXu78LTFXsYzNi3BdKcdcFYi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4817d645-46af-483a-5c89-08dbd538c107
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:59:54.7959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSrE3ijMFFMinbae4RJpr3ycWClF/mmGDn8nlDBhNw4E1cMLRIe2CmTljiQJo8X7T1j8vTWbkSyRH/k5Hj9NKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
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

On 2023/10/25 07:03, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 08:14:11AM -0700, Yi Liu wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> This adds the support for IOMMU_HWPT_DATA_VTD_S1 type. And 'nested_parent'
>> is added to mark the nested parent domain to sanitize the input parent domain.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c | 67 +++++++++++++++++++++++++------------
>>   drivers/iommu/intel/iommu.h |  1 +
>>   2 files changed, 46 insertions(+), 22 deletions(-)
> 
> I think it should be written like this:
> 
> @@ -4077,38 +4082,39 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
>   			      struct iommu_domain *parent,
>   			      const struct iommu_user_data *user_data)
>   {
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> +	bool nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
> +	struct intel_iommu *iommu = info->iommu;
>   	struct iommu_domain *domain;
> -	struct intel_iommu *iommu;
> -	bool dirty_tracking;
> +
> +	/* Must be NESTING domain */
> +	if (parent) {
> +		if (!nested_supported(iommu) || flags)
> +			return ERR_PTR(-EOPNOTSUPP);
> +		return intel_nested_domain_alloc(parent, user_data);
> +	}
>   
>   	if (flags &
>   	    (~(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING)))
>   		return ERR_PTR(-EOPNOTSUPP);
> -
> -	if (parent || user_data)
> +	if (nested_parent && !nested_supported(iommu))
>   		return ERR_PTR(-EOPNOTSUPP);
> -
> -	iommu = device_to_iommu(dev, NULL, NULL);
> -	if (!iommu)
> -		return ERR_PTR(-ENODEV);
> -
> -	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !nested_supported(iommu))
> -		return ERR_PTR(-EOPNOTSUPP);
> -
> -	dirty_tracking = (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
> -	if (dirty_tracking && !ssads_supported(iommu))
> +	if (user_data || (dirty_tracking && !ssads_supported(iommu)))
>   		return ERR_PTR(-EOPNOTSUPP);
>   
>   	/*
> -	 * domain_alloc_user op needs to fully initialize a domain
> -	 * before return, so uses iommu_domain_alloc() here for
> -	 * simple.
> +	 * domain_alloc_user op needs to fully initialize a domain before
> +	 * return, so uses iommu_domain_alloc() here for simple.
>   	 */
>   	domain = iommu_domain_alloc(dev->bus);
>   	if (!domain)
> -		domain = ERR_PTR(-ENOMEM);
> +		return ERR_PTR(-ENOMEM);
>   
> -	if (!IS_ERR(domain) && dirty_tracking) {
> +	if (nested_parent)
> +		to_dmar_domain(domain)->nested_parent = true;
> +
> +	if (dirty_tracking) {
>   		if (to_dmar_domain(domain)->use_first_level) {
>   			iommu_domain_free(domain);
>   			return ERR_PTR(-EOPNOTSUPP);
> @@ -4849,6 +4855,7 @@ static void *intel_iommu_hw_info(struct device *dev, u32 *length, u32 *type)
>   	if (!vtd)
>   		return ERR_PTR(-ENOMEM);
>   
> +	vtd->flags = IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;

this flag is introduced in [8/8]. still make sense to keep it there?

>   	vtd->cap_reg = iommu->cap;
>   	vtd->ecap_reg = iommu->ecap;
>   	*length = sizeof(*vtd);
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index d9197dd72748b1..b5a5563ab32c6b 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -78,13 +78,21 @@ static const struct iommu_domain_ops intel_nested_domain_ops = {
>   	.free			= intel_nested_domain_free,
>   };
>   
> -struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
> +struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *parent,
>   					       const struct iommu_user_data *user_data)
>   {
> +	struct dmar_domain *s2_domain = to_dmar_domain(parent);
>   	struct iommu_hwpt_vtd_s1 vtd;
>   	struct dmar_domain *domain;
>   	int ret;
>   
> +	/* Must be nested domain */
> +	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (parent->ops != intel_iommu_ops.default_domain_ops ||
> +	    !s2_domain->nested_parent)
> +		return ERR_PTR(-EINVAL);
> +
>   	ret = iommu_copy_struct_from_user(&vtd, user_data,
>   					  IOMMU_HWPT_DATA_VTD_S1, __reserved);
>   	if (ret)
> @@ -95,7 +103,7 @@ struct iommu_domain *intel_nested_domain_alloc(struct iommu_domain *s2_domain,
>   		return ERR_PTR(-ENOMEM);
>   
>   	domain->use_first_level = true;
> -	domain->s2_domain = to_dmar_domain(s2_domain);
> +	domain->s2_domain = s2_domain;
>   	domain->s1_pgtbl = vtd.pgtbl_addr;
>   	domain->s1_cfg = vtd;
>   	domain->domain.ops = &intel_nested_domain_ops;

-- 
Regards,
Yi Liu
