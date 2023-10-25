Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927387D681C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 12:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbjJYKRx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 06:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJYKR3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 06:17:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3FA198;
        Wed, 25 Oct 2023 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698229046; x=1729765046;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vn65HDtNynysCmtkWBqIZD/ucQHA3yJsqlZqwMnHqvA=;
  b=bUZc9nuHR2nWAn3JbuflhMx4NrHGGciV6kylkAGRRtYOqTLBKBrHAr/G
   US8p41h0SfATOf58yBNZcoJ2Icy+Sm0+1KN9bEoBaqnXMrkWgCmUEmxtu
   3SG/0R8W5IcpSIf3Ll5DPOwALMuYrz9Aqm/ecXUIfgTyaHflaV2490goH
   xQMHO2ZU9kc0KvSbOZ9sujDpgVqf6AX/K1iGRkfEjHCb5/ruGksvYS0vK
   helyG0epL+D/FrJL94lURgw6fJ6geuJviCeTVZuIcszHqr+5AYKWzPNpx
   gM8q6TloEw0cU0vILXrgaxFfYmgbdPnFPah+ZgqX8gtQY9KWpNJr9GoPN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="5892062"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="5892062"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 03:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="932314751"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932314751"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 03:17:24 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 03:17:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 03:17:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 03:17:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 03:17:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QfJR9TCGYtOHO3WvwWfA9fXYDufXt1PyaJ12IB7ZghqjJm2yxWgX4N2Af865l1kbaEqNoJVCBoiIGk9DRpNIRd+/WrsEyK4ZNIb4ABRP3oJEqkgKWPW+MU9sQ1C7OChMj+2mXBrUJ5+SXhLJPOMO9Ya9qX7iODNPK3dPtjyKpQa9Wmwr5ZRC7A9sBwB8BMPWsJTbYC58qwgh/M38azN0+1uimXSqqsjCshnqFQGqjwDn0HtPR5O6m2mZ6Z/o1Xidj1Z9ciyG/dhiqWSsqslOPexwjb6ZbxGVh+/pVMWfBnOPvyVsXaw/xIoC1CzjTO0bQK1bg5N4TYWGI+MVnZ5I/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l91LqXDEVQnKEj6DuwPpS8ThHZ4YT0kDhlh396YjoNA=;
 b=a/ejY38SrJ+TrXVUnHQQ4xqKJqRZXc9GrlCOyKbK0tI4tz3GfRUXXM1+HWPsW8GeN2vfqHPmeJnGIyWp+b08vo/TM3vZ6/dNpyb+VWZDEUE2IL24beVAcDGlv1mEDGP3d7TtT+s1rTQwN2zorHqMWBc4uH32z3tjkTlNuJ1lTlev4c9YqtmtwlqiIrHmyIN+FDu+7Pj9Cwtsnd01CO8gTvcPfnOyJEbizT7IITm4A04pNHMTFFcf0vFPej+jFU5qUQHBdX8/FlnSPG0b0KWPDZsCLMhs8CKdONpccBa/aEW9yizMABv4KA4lDm7vIJYm1ptE0ze0RMU+am5memrMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SN7PR11MB6774.namprd11.prod.outlook.com (2603:10b6:806:265::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 10:17:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 10:17:20 +0000
Message-ID: <5938157a-dfd4-43de-9e63-7669fc727a7f@intel.com>
Date:   Wed, 25 Oct 2023 18:19:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
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
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
 <20231024171810.GO3952@nvidia.com> <20231024173009.GQ3952@nvidia.com>
Content-Language: en-US
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231024173009.GQ3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0031.apcprd04.prod.outlook.com
 (2603:1096:820:e::18) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SN7PR11MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: a378a077-52ca-4e2e-a501-08dbd5439277
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 221YBOHwjTlXNP/BhmEFsR2/c/Dry3EDc8xHfppFWqdLTgm01ogviHKGH9zZRxSyNDGDtqzm2LcCXzZqYlfyxTBcF8Jd2Qhv9o+jPRaq4IBE7Q8s7Ia+y+yHdH8Zp4AINHTWuVVJFnhTheGk+aDECBtuEXsCw/gPD+9YhSpKmAfJzCXp/gdMRt1iv7LPTI7SieIVjA6RUKpzgbffOGDrRhAg9JJUdYg9CFuTiejlRGuUcX6f9MxokvQ4+3sIBK1cq3hK9nFisfIBSLMF7ZztQYJSBzuu60G/+hh+8Np2/6hS1KS9lOzIlYchlOrdbTHRpFpL3AzLBvBqKbeefYPdhm64uSCvu0rKnUG0uCR6gD311HxzLl/HrjP10+HpPmBxt8GKc/hbmh5vwvKP4C7ZO9d2N6ozvsUiBgnDEAI02E6rJ8ovVvGA6IuTHIw7fyVJ7toQCZ85Mx9d1tsfGTUKNWFjkBMikmfBJI75UZSZF2g/XfkuXkWbNJMZqelYjP4IsY5Oko6bYGi9ovGBAkpdi+jacwQbaf10RvxBaZm4ATzigMdabSSUOBaFK0fz5TCaHdC/Bv7wYsBmkuAmtfQAQvQ4sjyJt6QtyayBER6H/EfItwjF3XHtgEc5k8pc+KOaABjakUzSABhLOvHeEX+xnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39860400002)(366004)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2906002)(86362001)(38100700002)(41300700001)(66476007)(6506007)(66946007)(66556008)(82960400001)(6916009)(2616005)(316002)(478600001)(6486002)(53546011)(6512007)(83380400001)(31696002)(5660300002)(36756003)(4326008)(6666004)(8936002)(7416002)(8676002)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDVLRVF1VW4xSTQwSVJFMGxiTmlzMVdweFg3Um5TMDNKNy9zOGJ0aXFJYjhx?=
 =?utf-8?B?WXllcjE1Ri9PVWgyOThobkxjYjZXZXRycXpMWngxbXhkTFlwMVVITmVPR0p4?=
 =?utf-8?B?ZmNFcEhqRWx1UnllZkNXNDM1WE5aNjlndjQvc2FoQ0xMZndtcm9FSXJIS1Iw?=
 =?utf-8?B?UTBnWXBwZzgrNUJQUnVaNXZsRk9tYmlpbjZObzdEaG1DQ1EvSnAzSjM4VFRh?=
 =?utf-8?B?bUZSdWZSV3RjT1FGaGxjMmIxZDRQdU1od3ZDSWpqR0tFK245a3VrYXdIUEdF?=
 =?utf-8?B?NVBMaG5WOUhKTGlENnZUZTBXaTJNWEN6K1NlU1V2ekpEdkV3QTJNV05XazZY?=
 =?utf-8?B?V1cyTUxhOG14SlpJTGplQXlER3dXZWdTNFIvRzJYalVLSHlmWmQ1eDBrWEZ1?=
 =?utf-8?B?ZkZGdFdTVzFSWEFhVnEwRzBMZTF2d2d0R3g1SmVoV3dwSGkyangvZXZ5NzFZ?=
 =?utf-8?B?VGFlamNtV2FIdFFQYkl0MEtWalc5ZTBpelFFVEtrNndaL1pWblpETHk4aVdz?=
 =?utf-8?B?ZmZxTjBiTjM2WDBkV0NCamR0Z0tHREp5eU5xb3NsY0pUS2pwS3BidGU3QW1k?=
 =?utf-8?B?VEtnNTNxOW1GcWM5L1hlMnExbSttZFEzUjhaSmtEd29uVk1LKzJQZW1Ta0pX?=
 =?utf-8?B?M0RSUWt2ckJiSTVPL2hCcGhMd0tCRFNTL0c3QW52VXVrcVl1bkRDbnVVYzdQ?=
 =?utf-8?B?b0lEU1ZTODV0UjhqbTIxZkwrcnU0cDRtbnVSSXRtNWhaUXdIRSs1Z0ZpYm5Q?=
 =?utf-8?B?OCtxLzZ3Ym9BTnVveWdabkI2a1RDYSt2VDIrKzl0ZEZVTWt5clh5WEhidmFO?=
 =?utf-8?B?aW5ZWkVsYlVNSlV4Y0lRdUhVUmVIMEVNcFJXWWNhdWFvN0oxWTMvYkg0R3dl?=
 =?utf-8?B?cnE4VEJPUlZ4NjZ6V2Yzd1M0UkE3cEI1T0t5VTdFTk1vSzlOa3AxcWZMNHZX?=
 =?utf-8?B?SFhGN0RuMGpvUisySGFWYXlBeDVKeno0VWhZb0tNcVFKVndBUWZlVnpLMU5Z?=
 =?utf-8?B?SGFBOEpzS2tVQkxVR3hEaUZKR1NMM3poZG1DaVAzejFTY2tMVldFRUlaQndX?=
 =?utf-8?B?aVRLQmt0RTYrb3Q1Yk1ubS9uQ3VuVG1Ua2t1MTBMRjhGZm1WMU1hUVUxRld3?=
 =?utf-8?B?SW5ITkpGQ2RYWnpPME4vNTJJZE5sb2xuamZ5eTZlcVR0Q3BUUnJ1eVZhbjZi?=
 =?utf-8?B?MGRmOVFyaS9GcHBnUEV3VWdQdWVjMWJEbnRWMWlEY3M1bGlyNVVtbis2NkRr?=
 =?utf-8?B?bVVDcEhlNzRmcTRLbEtDeWx4Zjg5VHlGYzlBTFNENDlBMmpyelRsY3ZBWUtl?=
 =?utf-8?B?dDU1bXovZ1puTE9DZXVnVWxKQ2tkczhJSnJqSUtjNy85VWxUYWxaTkp2clI1?=
 =?utf-8?B?SDVsN1I2NDI1dVJHcEJzcndhWXlSQUVoZ2lGV2VZaTFIT2dhMWdRWmZhT0xy?=
 =?utf-8?B?dnBDUjEwL2gvcHU5WWZJNFlPT2hkRjFHajBOdmRvbnRqcUtOT0VPVTUwVjBW?=
 =?utf-8?B?ZDFPSVB0WTZrS1UzYlVuNkZuY0h1SXpFa2I5RHIyUHpiVExvaDdMSGJEMXFF?=
 =?utf-8?B?cTA2T3dBdkxuc1NOaVdxdWNJM3lUZE1wb3hISFJiUjZTTGNxaE5xN3JvTXdR?=
 =?utf-8?B?eDZ6R0x6dk8rQUdRNFFRSFEvZGRTQ3paU25VNk93ajlWZnAyWCtGSkF6VlJ0?=
 =?utf-8?B?UkptV2NCcnlBcnRoSGN4emVsU3ByZ2FuQzNNV2lxY0R5NGZyMWdnL0hMSzlx?=
 =?utf-8?B?TTJxd3FwcWY5SzZxYmE3MTZ5SlU3ZS9LbW11SC9JYlBMOWxzeEZ4M1VlWWVq?=
 =?utf-8?B?dVJqdklkdStxU1RpSDVQNmptMFZjNndRUFR4Y1JFcTRjN2FjdjJ2N3QxZmRJ?=
 =?utf-8?B?QndxQUFGZUx1eVJHZUlqS3MvQVFGWU1UcExCTnlVbnp3QXdhOFRWQXZUMjlR?=
 =?utf-8?B?ZHI3d2U5OUh4d1FDR1RZekgvb2lmU0c5ZUNTb3k2eVcwaysySE11VEErSmFB?=
 =?utf-8?B?LzJqRC9sYzE3WG5ESWZEUFRmSGNZaFBwQzIwaDZwZHR1MGY0eGJ3QmVuQmdZ?=
 =?utf-8?B?WG1vWnBxa2Z3bU9pY0ZyZnp4WDNsRUlieVRzc2hKaVJ5STlLSEswSkNQWFRp?=
 =?utf-8?Q?ef2NtRi/qJoNABNro5MN1Rdmy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a378a077-52ca-4e2e-a501-08dbd5439277
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 10:17:20.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DoZ6SQ1g6QucR+uioUfrh/qmF72IjRUVL4uUNwDn18Eu3t331Wfr/+zoEgJPzqvxM4uWyJxhBspO14Q0sSEuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6774
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

On 2023/10/25 01:30, Jason Gunthorpe wrote:
> On Tue, Oct 24, 2023 at 02:18:10PM -0300, Jason Gunthorpe wrote:
>> On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
>>> @@ -195,6 +279,10 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>>>   	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
>>>   		struct iommufd_hwpt_paging *hwpt_paging;
>>>   
>>> +		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
>>> +			rc = -EINVAL;
>>> +			goto out_put_pt;
>>> +		}
>>>   		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
>>>   		mutex_lock(&ioas->mutex);
>>>   		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
>>
>> ?? What is this?
>>
>> Ah something went wrong earlier in "iommu: Pass in parent domain with
>> user_data to domain_alloc_user op"
> 
> Bah, I got confused because that had half the uapi, so in this pathc
>   
>> Once we added the user_data we should flow it through to the op
>> always.
> 
> Like this:

ack.

> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 92859b907bb93c..a3382811af8a81 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -586,8 +586,8 @@ iommufd_device_auto_get_domain(struct iommufd_device *idev,
>   		goto out_unlock;
>   	}
>   
> -	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev,
> -						 0, immediate_attach);
> +	hwpt_paging = iommufd_hwpt_paging_alloc(idev->ictx, ioas, idev, 0,
> +						immediate_attach, NULL);
>   	if (IS_ERR(hwpt_paging)) {
>   		destroy_hwpt = ERR_CAST(hwpt_paging);
>   		goto out_unlock;
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index cfd85df693d7b2..324a6d73f032ee 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -96,7 +96,8 @@ iommufd_hwpt_paging_enforce_cc(struct iommufd_hwpt_paging *hwpt_paging)
>   struct iommufd_hwpt_paging *
>   iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   			  struct iommufd_device *idev, u32 flags,
> -			  bool immediate_attach)
> +			  bool immediate_attach,
> +			  const struct iommu_user_data *user_data)
>   {
>   	const u32 valid_flags = IOMMU_HWPT_ALLOC_NEST_PARENT |
>   				IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
> @@ -107,7 +108,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   
>   	lockdep_assert_held(&ioas->mutex);
>   
> -	if (flags && !ops->domain_alloc_user)
> +	if ((flags || user_data) && !ops->domain_alloc_user)
>   		return ERR_PTR(-EOPNOTSUPP);
>   	if (flags & ~valid_flags)
>   		return ERR_PTR(-EOPNOTSUPP);
> @@ -127,7 +128,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   
>   	if (ops->domain_alloc_user) {
>   		hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
> -						      NULL, NULL);
> +						      NULL, user_data);
>   		if (IS_ERR(hwpt->domain)) {
>   			rc = PTR_ERR(hwpt->domain);
>   			hwpt->domain = NULL;
> @@ -210,8 +211,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   	struct iommufd_hw_pagetable *hwpt;
>   	int rc;
>   
> -	if (flags || user_data->type == IOMMU_HWPT_DATA_NONE ||
> -	    !ops->domain_alloc_user)
> +	if (flags || !user_data->len || !ops->domain_alloc_user)
>   		return ERR_PTR(-EOPNOTSUPP);
>   	if (parent->auto_domain || !parent->nest_parent)
>   		return ERR_PTR(-EINVAL);
> @@ -249,6 +249,11 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>   int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   {
>   	struct iommu_hwpt_alloc *cmd = ucmd->cmd;
> +	const struct iommu_user_data user_data = {
> +		.type = cmd->data_type,
> +		.uptr = u64_to_user_ptr(cmd->data_uptr),
> +		.len = cmd->data_len,
> +	};
>   	struct iommufd_hw_pagetable *hwpt;
>   	struct iommufd_ioas *ioas = NULL;
>   	struct iommufd_object *pt_obj;
> @@ -273,25 +278,17 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   	if (pt_obj->type == IOMMUFD_OBJ_IOAS) {
>   		struct iommufd_hwpt_paging *hwpt_paging;
>   
> -		if (cmd->data_type != IOMMU_HWPT_DATA_NONE) {
> -			rc = -EINVAL;
> -			goto out_put_pt;
> -		}

it can be covered by iommu driver when checking user data pointer. hence
remove above if.

>   		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
>   		mutex_lock(&ioas->mutex);
> -		hwpt_paging = iommufd_hwpt_paging_alloc(ucmd->ictx, ioas, idev,
> -							cmd->flags, false);
> +		hwpt_paging = iommufd_hwpt_paging_alloc(
> +			ucmd->ictx, ioas, idev, cmd->flags, false,
> +			user_data.len ? &user_data : NULL);
>   		if (IS_ERR(hwpt_paging)) {
>   			rc = PTR_ERR(hwpt_paging);
>   			goto out_unlock;
>   		}
>   		hwpt = &hwpt_paging->common;
>   	} else if (pt_obj->type == IOMMUFD_OBJ_HWPT_PAGING) {
> -		const struct iommu_user_data user_data = {
> -			.type = cmd->data_type,
> -			.uptr = u64_to_user_ptr(cmd->data_uptr),
> -			.len = cmd->data_len,
> -		};
>   		struct iommufd_hwpt_nested *hwpt_nested;
>   		struct iommufd_hwpt_paging *parent;
>   
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6fdad56893af4d..24e5a36fc875e0 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -290,7 +290,8 @@ int iommufd_hwpt_get_dirty_bitmap(struct iommufd_ucmd *ucmd);
>   struct iommufd_hwpt_paging *
>   iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   			  struct iommufd_device *idev, u32 flags,
> -			  bool immediate_attach);
> +			  bool immediate_attach,
> +			  const struct iommu_user_data *user_data);
>   int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   				struct iommufd_device *idev);
>   struct iommufd_hw_pagetable *

-- 
Regards,
Yi Liu
