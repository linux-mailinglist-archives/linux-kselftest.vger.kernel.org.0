Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D807C66F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Oct 2023 09:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347119AbjJLHbr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Oct 2023 03:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbjJLHbq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Oct 2023 03:31:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70E90;
        Thu, 12 Oct 2023 00:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697095905; x=1728631905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rvo+65jiaR3BU2yOCPV4XrHrwOlY1U516o/r9SAh9as=;
  b=e06mVdJWcV6emojca8PLEuz1SDMXrFB4mHN72ZROZUXUFJnHmxiqzYFP
   EinimM74/aO3ypbPkG5tY2OEDEMAUNSfHpaCSWAJK9AmL6ifWoDEwa5D4
   +kr+k60DCdKnQSVxcQiR3OTQaBEx+HJqVHVKX9lH9buqzMgSs9vCMbKxS
   zijf9BYZ4dB8PrQIzmiDRD39itSxFi2hav4+djDfOiljG8fyeNWqlwY61
   2nCDLqEEUP5cIWYyaFYfqBBZ0onnx+WMy+QkuIhsyiz35LUj5F9ajyVAy
   wkU6HFo5zBzssc8qlbsrHft+NUv4XSx5zwzSFrVay60dTtft0AHClDPfP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="384708706"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="384708706"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 00:31:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="1085559471"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="1085559471"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 00:31:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 00:31:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 00:31:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 00:31:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 00:31:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIcCtfGsYXuSwECpCU/4zA3eG0R6ivEdWma1U3KyrZks/Y/pLzWglNpmh+5VruF3Q47sP+goZtYPm1/hr+0jWOefGVCUmQtbo6V/YGKpy2+5S8eNocU1G41UtxrYmY40tTsiscRCTzGrCilz5yEYczrZifVoTo5F12QdGQS4lla/b9NYH+GZs19FkF18gaY3qw3MATtFNi5d3Qj/tdeiLvs5naRfZeFy7h0QA+zB02luZoByXRyUAQ+ebFVPSn3SL4Hk+mLSPCyBK5lssY9WdyYW0f4RisZJUHE6uJ2z5E4DXjLPyojKwFjxPV3RiqXs2pGF1T7N9SbYt3cAUG+KSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW2PRUegq3VGPAkd2889Ac8+lQRICrv4KSmUTRtXkx4=;
 b=mN5ZYKe7q1f6UVLSLgD4RlPBYIm7rA1fIV+9aCL4Uuu+YcJUwbHFB3p0o5Z20vO5QcH6Fe+UJW7n18Um7qHkkDUK7Guu2akE3wMZb3HY7/hte+vL9G2E3LLdQCD8D5fktbf7+cvYyDYaaRLbG2rjNZa4IegLgiVevtNscsTxju1/5EXZ1uSIyc77TmR5tEbPNXHBQtKWKW0Vz/y3/cKNB1ZKmy5xOV/ev5sOFYj43vpsguw10Zngg8IYHw+VxL6Q4ggFrDkD3XKTde8TheHQADS82LAkl+UGapWYRIiCmtMUhwYkt9MhPQc63R7CaJib9T/0LMzJtGrQqEQsMdDy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 07:31:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 07:31:40 +0000
Message-ID: <7c4ce355-c602-7ffa-40cb-5d5a27c1a866@intel.com>
Date:   Thu, 12 Oct 2023 15:33:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/6] iommufd support allocating nested parent domain
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
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20231010164742.GA75531@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20231010164742.GA75531@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:3:17::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4649:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c95305-e158-4b10-34df-08dbcaf5464e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RxuKG0SzkvgJl+M81kwZ7weiKN/khfaCrd25RpKtHZ2l7/Y6kS2HtruY1In4s5az7YeZKQn5pBE7+GAclrvqnHEvrd4MFs/srIHbREguxe1vZB3NVGiYmEpo8QvFXkOpe25UZVogt6ujL1KYCMNBA+3HljQRK+3LDVBnitPIjInPeajA0gZ57/AyuGJ8DuNE/xxMJ/HaWIJTiWQZ4q/p4rB8egK3djnL5naPuuUGz+Odh/bE2MYwr4Voj6Z+jnbCf/jvBOuhzfFGgMPik5FUoWwXrTKLoEOF0IwTf3VItNlpE59fdtBBtYZCFAtxe2GqXsBOICYgrHJaCrVfqwoI+Jx6Wmyl9CUKSiMDfP96EABT+8b5+pGNRhLpY8Rn8ot2qbIqshdnBi1lR20996CHpEYKAZuzR/Bxfe/jIlhSEK/AVLrhoJSBDfsO/cKdwd4pcUor//S/srxmLK50vcT0PjAyESOcI7Kly80jtzUF0ewaDkv+ey8OMfOihSoNUvFo7ixcC7SO10ZKlE7C7sw/O1fzzaIRPd7KijsjjWccp+sGF0LhIl7NYjeejwXqe4KLQiUrSWyh0uRr1ZaQTcl1PmLQv6U4mRs3DjIIs0oYjRN6A9gEp8DvCrCwGFnz37LH6c9uEp4rg1Gg5jrfYivd5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(136003)(366004)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4326008)(478600001)(8936002)(8676002)(38100700002)(5660300002)(6666004)(66946007)(66556008)(66476007)(6916009)(36756003)(41300700001)(6486002)(316002)(2906002)(2616005)(4744005)(83380400001)(7416002)(26005)(31686004)(86362001)(6506007)(53546011)(6512007)(31696002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWNjS05pSmMrZzQ5aGdRWXFKUTh6U0ZVUmp5N3lpcFQxZWU1TFBOanQ1dmtM?=
 =?utf-8?B?N2wyL2NkN2dKVEozWHJKdlM1QW41aitWd3dLdWRLSE1Ja2VVWU9xaWtBNlll?=
 =?utf-8?B?R0hsN2IxOVk2cVZ5VkFPYlhUVkc0dG8weUY4TUYxRlVDZC9qMG9scGdaUUxz?=
 =?utf-8?B?cHRhY05yQ1ZNcEEyby9EK0pCZGFHK3VZQXB5bTZESTZxckJ1SncrRzUrUFlu?=
 =?utf-8?B?RnJacjkzSFhYNUl3bFhsNC8xa1NnaWpvTlM1ODJmc01qaHEzOUo2RHp6RWhL?=
 =?utf-8?B?RTUzUjRIWTVXSWhZbXkyZVhpRjlTRjMweU1oVlhuYSsyOE5kSENYQ3NCWXpi?=
 =?utf-8?B?aHYrbERXTk5zaXJRUFVLZXgrOTQ2YUV4Tm9hZEt1YVlPVjVndk9WWWc5allq?=
 =?utf-8?B?WkVFbWlPcVloNUdYK3JBOEMrbVJwRHFERXdOTm9kUWdEWWZXc2xiMWxGV1Rw?=
 =?utf-8?B?UlZ4aUxvTmdnTWNCNDlFcGxmdjdQTVNieGc1SUhTK09QVEp1bWQvMzhnMFM3?=
 =?utf-8?B?dFJWTFJ1UkRpV2JxaDhwaHQraC9MTFh1NnBJWjJOQlRES21zcTRoYmI4M1Bw?=
 =?utf-8?B?U1YzdTAwU3ZPaFNpV0ZsZ0ZoVTYyMUhnelRpUWxMVzAzMG5SYVJkUkk4WEZN?=
 =?utf-8?B?WDc3WG95b0IzQTN3SkJ0SklIVkFweHIvdHJLcXIwa0ZHZUpZMlRLbit4QzZi?=
 =?utf-8?B?SE9XTDVYS1doZlhUcE5TRDV4ZjhsZnNhUDR0YzZFU05UVjJLZElpd0l4TVl6?=
 =?utf-8?B?emlneU0rdllnNFB6QWhqVXlSZ2ZJMjczZTRESzRQTUVMTG96QmFrMXlCMklX?=
 =?utf-8?B?dTFDUlkrR05tZE9QNXFtaWFmNTNLYUJyOFNJS2tLRHJYYW82TTduclpXb0wv?=
 =?utf-8?B?WUx3OFZodkpsL3dzWVJWUjhmdDV4dVdyZ0Fwc0QxSEVyNTIvZnNTU2hEVWsx?=
 =?utf-8?B?UlVKVW1YQmZlcUZSRlhwTWM4MzBjazlOSTEvMEVSOXNuVnVrdEJ1MjhIc2hi?=
 =?utf-8?B?ZjAzaGtSZ0QxVGJUUDNKK2piUlZMZjBDV0NsOVhKelNNdEc4OThWd2Y2WVFK?=
 =?utf-8?B?QVY0UkRFQi9wbmRDWDdUNHdsSUNuMFMwY2FXRlJRYzhnYStLaFg4dmhvZitz?=
 =?utf-8?B?L2NEU0h4SGV2UURKVUVtaUQxMW1sQm1ubVJnU1pJdEJuZ25UQ3lnQk5LLzQ0?=
 =?utf-8?B?VWFPSjNtSEhQcEdtOGM1TGpTcjk0eVdxaXJQL3pvNjFTTGJsUXpuRWt2dWYx?=
 =?utf-8?B?NUY0TGJJZ2NETW1WTE9NaXBUOW1JR0xSYWJUYUdBR0dobGlTR3BsbHFiK1Y2?=
 =?utf-8?B?ZzA5Mi9yaXR1bkFRbW1MTUY2TUZaT0xOYjVJeGhmS2xjaWNBU1hrbGdON2Rz?=
 =?utf-8?B?ZVhxcndrOVFrUDhoVXQ4SVVaa2lNejdFdDhhWEM1U1lUWUd3b3BFMFV0aDJZ?=
 =?utf-8?B?NzZFaW9DaXhCSFIxakdqUDE0Uk50NVRoZDh1NE12Y013VVpLcHFLRHFQTnhq?=
 =?utf-8?B?V0lMSU8xV0VxWCtNWVp0TUxtVDNLSzJFMTRKcVBDMm12MCt1QlcwWmZOeFNy?=
 =?utf-8?B?MlliRXBLUUNIV25BSkk1cXRaYTE1VlNUYzkvNVorcEZjY0tTMVZwcFltUzdH?=
 =?utf-8?B?aCswaVE0RkpZcjlYVTN3cHJRdW95QXdvWEVQaUIycUVsUTBvc0VFdFpnaEdM?=
 =?utf-8?B?YjIweTlyVGdCbTgxTWY3WkRlRGNBbWFDdzJocG4yalNWOTdhK0lId09oZ09B?=
 =?utf-8?B?aXAxMVMveE9qYmZ1MTl4NzJQNVRGUzlJL2VCa0U4NmppWjJyYVFQdDRtbWo0?=
 =?utf-8?B?NXJNbDdGMWt5WnFnR0x5dzIrdUNVSVEwaGpUYlFVS0tpTVBNdHVMck13SVJX?=
 =?utf-8?B?UUxTaVJKc2R4MUlHaXJ2MjZCeVRwUFdBcFZ5UUlEOEUvQmREMEhnREhMUFMv?=
 =?utf-8?B?N0x1SmhEcEM5RWIyNU5QWkcxdzZSU0dwc3Q0WTUzWDhVQ0x2bzZOak1LU3Iv?=
 =?utf-8?B?dVNOTmxyc21Xa2lLMkF1ZWllWkRkYnMrdUdKaEowbUI4RnV5Rzl3dXNNSUg1?=
 =?utf-8?B?V3Z2cDJHWVZNaFJnOWFDYnJ1ckVVTWJQZkhIRkYzWEFNSlNldXp5TGlCVUtw?=
 =?utf-8?Q?ekfLsxvZzrOwlbL9QmISy07lJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c95305-e158-4b10-34df-08dbcaf5464e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 07:31:40.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xg+e+VzMjmCKwFN4HyVzmQeHFs0puiVGKq0h4R8dYb0H4AButbelGnB8NyuOePPmLWiwubrfffi84wNSiUw4yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/11 00:47, Jason Gunthorpe wrote:
> On Thu, Sep 28, 2023 at 12:15:22AM -0700, Yi Liu wrote:
> 
>> Yi Liu (6):
>>    iommu: Add new iommu op to create domains owned by userspace
>>    iommufd/hw_pagetable: Use domain_alloc_user op for domain allocation
>>    iommufd/hw_pagetable: Accepts user flags for domain allocation
>>    iommufd/hw_pagetable: Support allocating nested parent domain
>>    iommufd/selftest: Add domain_alloc_user() support in iommu mock
>>    iommu/vt-d: Add domain_alloc_user op
> 
> I copy edited the commit messages, and moved the hunk adding
> IOMMU_HWPT_ALLOC_NEST_PARENT from 'iommu: Add new iommu op to create
> domains owned by userspace' into 'iommufd: Support allocating nested
> parent domain'

sure. this movement makes sense to me.

> Otherwise applied to iommufd for-next

thanks. feel free to let me know if an updated version is needed.

-- 
Regards,
Yi Liu
