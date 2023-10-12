Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D147C6855
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjJLIpS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 04:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233476AbjJLIpQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 04:45:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66991;
        Thu, 12 Oct 2023 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697100315; x=1728636315;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F/bNZgfNIIpZWLLtFLimFgnyvQ/4fsEK2fuDXkkGXko=;
  b=A7S084ullKi/uZC+kyS3eW2rnqYXzMhfm59rmt1nAqaluQsRvzZo1NTl
   A+7IulUJAUdqXSWDMgMO5o0VjqlxculWzbOBGFNuvfHaw5Cr4Z7r3LtaT
   GPGz0jqVDqNKiWC4s7mM6MRebyDhoAwqlFdIWpiBupSWjspAeYVC4Md6X
   Uv6sP3O4E91eTMB7glTGyfC0fqHk4Q5S59L+ebHxhcPSjaH+JpreMEtCh
   7sYatGEGtJ7ahQRl97IFcgs2I0so3/JsUnnnz2qn8C4Azt+pM7NCBGqQG
   jsQ78UET4VQP84ZCwime0nnrurmaZOUF8k6De46Bq+srqw7rdMQQNXPPr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="415918964"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="415918964"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 01:45:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747801079"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="747801079"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 01:45:13 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 01:45:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 01:45:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 01:45:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQTh2Jw/cI4bv4OjX/4VMopBgWBmHAElYPEX+uAoKT58uKKVtIQnh9ARRLLAWbo9SuKHBa/yWP9L6ghJEot7yy46nv3koR2IBPs50e/j85wf256IieO3+uGCHD5FkhMZnQ1aKVtYzix1RmSwsQfeNT0s9KyfrQ6/6pXgLH23FGbdZSqHs98vzuMbZifPBBIpmlVvLNELhjkC/ZWWvCVhu61tnpAHKQLx7735BA/pKsujxtcjjk0+6XdhuGXHUHcF47FVR6abgQRC5KWKaTzdfZWJvGF0yUdrdR6DVg0/wrwo821/thKM7bDI4A39KX0zioQxi1OBiU7TUlfcNDD4aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgXe2PTjepVt/BarApwLWCGy/0WaNz6+yQDjmnWajDc=;
 b=c3Wof5B84WNAHurnmHOCy2lPTuN2834Nhbxn8nZC4JBY9yd/E+aCKnCZjD7gGm+n3JWtzONhdnw4fOKgLg/PFgLqCzJv33fdDye/ZPnjxPfXT47IZYtXkZaqFLLnEkPbFCOkC4N/fssljSS6Q0jPk7qUbgUO3x/1yiv7ht2Y4xJJJQ8jfVSs9bjl2w4U84t0iVV/077svpuhLcPN0SvEZHtNNab/BcVaZ1t99jjqEYlgTq7MwQEjW3jjGQoXDjSfKqQYtpX0S05weBEZotjRdyU5w9PP9HmxIE834CmNDc5mVVdW1VCMwTUfoKp09sRFXeBgzTF1kLsMrhOFwurcXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Thu, 12 Oct
 2023 08:43:25 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 08:43:25 +0000
Message-ID: <38c4c1a9-6ebf-5dc3-c36e-56a8433d6cf1@intel.com>
Date:   Thu, 12 Oct 2023 16:45:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 00/17] iommufd: Add nesting infrastructure
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
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20231010165312.GP3952@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231010165312.GP3952@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0164.apcprd04.prod.outlook.com (2603:1096:4::26)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: eb765621-c875-4aa1-209c-08dbcaff4c31
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOpq7HT4KGrm4cTN/yA4vTkrBRyyGgJqgqx5WTH3PxF53zqPiYoYAJLcT+fMoqGnAT5DoryG9+zNzOnyYrNlB8c6/X6SbAJwjlwmtQfrwkPt6XK1hZ4C6gwxH6TZ+O3oTUx9Ll74Y50kTgCtCy/PyV4SSYPy1LrdkviCfoKKUvObxZ5tYPtTq6i64LpzHlavQCpQLS+yvDqjdC6+kHILhyNotbnirlbm9kP5GdvPzPjxXD8Ko9ZApWZAuwuGMNFztgcCluXfellskZ2P+wJ/26my4XljhFCw3XU/BhQcB8XNtFhSRZxiDLecRY5jM07aO8JxWpjnTsT2gvQInQZ/AYFqpKl0GcWUxLW+HED8cl2C38ktW3jrLm4X8PzXwlPra2T4Z7U8T13KnsbQUHj3c+xXGT9fEy4HYf77O0FGeRVXb2Xix48cCXM4cyZcndMoWuPoFdaiN2/cBl9THrNEyV5b+I6cDGp+NfjFCeEJdJYEnUZ6him2kDer+ullZgVSYBcSuj41ms9gjGH4dc4DkMHtT99unnBI9IQm63xpRFR/XToD9ohdfIMM04BUecY4Z31mlO4gVs6fIzwmHzkxFSMrnXWj6KMB71hP1xKhL3iqt09eWS2LA9FsrPb1iIHv6SDbCsHoFWoyKDbZDcPRBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8936002)(6486002)(2906002)(2616005)(6506007)(83380400001)(26005)(316002)(6916009)(7416002)(66946007)(6666004)(6512007)(4326008)(5660300002)(4744005)(41300700001)(8676002)(53546011)(478600001)(66476007)(86362001)(36756003)(31696002)(82960400001)(38100700002)(31686004)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmZXZ244QnQ3clluc2xxSVV4WkNBbGJ0eEI5Z1N2WmZPSk9vNE9maFVZWVRm?=
 =?utf-8?B?K09Fc2tOSFAyMmNiM3RwRW5iZmcwcEdRVU54ajhFb1ZaUkxhTnFBSUFXRitk?=
 =?utf-8?B?NGtvSDZiUGdVQmVyb0hRZFFGSm80OFM0NHRxYXhDZmpsNEJWTWxqaXo4RjQw?=
 =?utf-8?B?TDZBSTFjMW9zZ2l0SGdBakl2cVFLa09Wa2l3V0VUL0dHM3BWeG1SV05ibG5w?=
 =?utf-8?B?NS84VE42ejk3UHBMbnBsZVBlV2ZKTzVwZVB0bk1oY3doUEx1VHdwaHorN3g0?=
 =?utf-8?B?OVp3bHpJSmNxR2h3bkxjL2xGMWY4UEI3UDduWG04emtBSlYzNkRUOTZ5d0Ew?=
 =?utf-8?B?d1ZaTDJsdWx0c1VsTmZ2eHRyOEdsY2g5aE1uaE4yLzhoTCsvMDFqNzk3Nm9L?=
 =?utf-8?B?YUczaHhCbm5tbERPRkIvVHBPQks4SlVIbWRqV2dpYUFaVWVheEtnOUFOaExO?=
 =?utf-8?B?Sld1Q0RZdDU1L3lpMDhBU3dsR2ZSbXZyT0kvM0Zlai9wVWMzU0tNcEtpSnp3?=
 =?utf-8?B?WUVYMm0vRElEMmk0UXdVUHdHWDNGS0dyWDBNUG5IRktObko3eDFFSDVQZHZB?=
 =?utf-8?B?aTQ4Z1Z2bWJQOUNvdDhaZDJCQXRRRXY1Nm5LUEowZU1SdGZ4TnRSdUtCRmts?=
 =?utf-8?B?aGs5VFVSaENvQTBsNzc0VjIyWFJIZHhvaVRPSmhTbUl5NVJoMUJ4MmZKOUVR?=
 =?utf-8?B?eFozNWllQmtWRWJPWHd6SFpmZHBOcjFVdEFWVG1nUkpSbE1SYWpMT0dHUXkv?=
 =?utf-8?B?NkZKdFpOb3NKK1BQTTdhb1NPT2gvVk9Sbk5xREdBaldxTFQ1bFBUZWJTc1Jn?=
 =?utf-8?B?WjJYRXN2OG1HM2w3Slc5WXRaSlRtOGxqbmNNZGJBVW5VOXVNR3VzZnUwZ205?=
 =?utf-8?B?UlVPaHdwbDVKNXFzYkY2MzlGQnhJWVVER1RhMUZ4N3c0ZEJHdXd1Y0RVbkRn?=
 =?utf-8?B?dHBMeUw0NjY5WUlxRmVWR1FRSURPZUlEOVkxUHBhZDdDTWJjb0wrL1poVHhz?=
 =?utf-8?B?TUlaWW5JQmpXMkM4VEtuZzJMSU4wK1dndFA5R1N1ZnJ6Q0JYZ3JrTGhCeXNo?=
 =?utf-8?B?SlBsRHFROGVlOGxHY3RXYVhjOGJvTTA5YUxBRWRWWWJ1OHI2dk1WMDVNWDJS?=
 =?utf-8?B?VzZPMXlhWktIb0xrNTd5QUIzUWcxWDNpQlY5bGtZOGdhQm5OcjRMMlYxTThs?=
 =?utf-8?B?SFErTEZ5NTdMYys1MjJ6WWIwNzVJcXZOQlFrK013ZXliMkhCbFVQTTJwenBx?=
 =?utf-8?B?UlJBK1dlNlo2YVFKWTlXOXhpU0FBNjJHYUZvYlpOMzV6WHB0S0djcVI0VGdI?=
 =?utf-8?B?djdwVS9VVmxyMHl5Q2svalJ2RWNlYTY2MHZiQWpBSkROaWhvT1dCRWR0OTAv?=
 =?utf-8?B?V3JCNWhkQlJVTm9tTTJXOUp5bzVWMG5ibG8yRk9Ib1oxc1VrZ0lhb3NEVy83?=
 =?utf-8?B?bXlRRHozWTBVeWc4UWJBRlhhVWtKN0MrbUw4bGprZGNocEtqRDc5NXZjVlBZ?=
 =?utf-8?B?U3Jla1dCMWNka3kzZWNwRWM2NHhNUlRYdXJpdHY2OWFGUi9pQzlDT0NqdUYr?=
 =?utf-8?B?TFNOZ0xKYjhvK2ZwaTRWVWE1QUNoWHhzRlBRYzJ2TkVPdk56YmNhTlFpMTc1?=
 =?utf-8?B?WXB3cHB0L3ZEeDhmUW9kb1MyT2RDRWtWT0lyWDBGRlV6YXpXcXZycFNWRWF2?=
 =?utf-8?B?L3JIMzBDSzNFb3QrZ29nbWlBVDNLeVZTSHRoQlMxTmd6Q3U2Mm11T3pPdlg3?=
 =?utf-8?B?MkRBblNMcTRFMnZXN2I1V0pHbU1PWmFOM2ZyQ1BwZzE5UzlmME14K3hPUDR5?=
 =?utf-8?B?QTgwV1RGS1N5T0hLcmpwZlJ2aEYxSzFFbGc3Vk4rL0w0ZWVvR0VJdFd5OFJo?=
 =?utf-8?B?QTJZd0lxdWpTQTNCUXFtSngybzNMWUl2QVpHQnRhaW9XeXVKR3dZRktkZzhC?=
 =?utf-8?B?clA2TlB1TzNyT3pXT3dib0paUEdadjR5dVE5V1l3MHV6bGtqaFF3cHZEMWhp?=
 =?utf-8?B?NzFhTkYwRXlCWmpvSllCNkgwdU4vMS90b2VINmtGeG1jRE8rK241T21NeWxt?=
 =?utf-8?B?TnNSTFRJWWJpWmVUM2ZVQXN6eDBDT3AzWFZqb0RkZWZvU0ppemxQdjVuazVa?=
 =?utf-8?Q?weUlImj9awkUMHLbzh659wB75?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb765621-c875-4aa1-209c-08dbcaff4c31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 08:43:25.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHWmFA020iCFWTwrp+PqUcB7HDobaKNyhdD49BwWMGK3QOlKIAqg4yCo25FxeuR/kmo+j9l8CAd7PgvKpNT8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/11 00:53, Jason Gunthorpe wrote:
> On Thu, Sep 21, 2023 at 12:51:21AM -0700, Yi Liu wrote:
>> v4:
>>   - Separate HWPT alloc/destroy/abort functions between user-managed HWPTs
>>     and kernel-managed HWPTs
>>   - Rework invalidate uAPI to be a multi-request array-based design
>>   - Add a struct iommu_user_data_array and a helper for driver to sanitize
>>     and copy the entry data from user space invalidation array
>>   - Add a patch fixing TEST_LENGTH() in selftest program
>>   - Drop IOMMU_RESV_IOVA_RANGES patches
>>   - Update kdoc and inline comments
>>   - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation,
>>     this does not change the rule that resv regions should only be added to the
>>     kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be added in later series
>>     as it is needed only by SMMU so far.
> 
> This doesn't apply to iommufd next so you will have to resend it

sure. I'm working with Nic on a new version.

-- 
Regards,
Yi Liu
