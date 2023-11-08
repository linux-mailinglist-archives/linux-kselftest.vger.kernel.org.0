Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FA67E5146
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKHHno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 02:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbjKHHnn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 02:43:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAB1706;
        Tue,  7 Nov 2023 23:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699429421; x=1730965421;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LNvpcA/0bp1yfoy8AQ0iBwlhAZniXpI2f8Mudgao17c=;
  b=gzfMoU13t4GHxv4veCnnWcCcOIbNn1ABCIo7lSQtD3DZki8iPECMWAnp
   diC9rRv5MGnb3hnDnz6wAygGKIqLod4CmpGdgwvEkGrRDyaSR+EIZDg09
   nto6t1slzS8evdOuImprJbhH9m3gVgSUeQ2nqqkAKIeIDOtciPk6eiGMD
   VcOA7HR+icFIJCOaCdjr2ZOU0+Inlkj+9fBwzV6mqZeaFyZ+DwQmT6UBB
   ULOwOANqKFjsvR9U3NMjwxqEWwA8iQS4mVVkJlv3zsQnB2b6pI+MRzkhn
   61W6PP6iHEHxUGGvVxLNgy0IhBHiy4GVRaw5CH0srjahgzELaDL3/Fl2H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374752676"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="374752676"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 23:43:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="833403459"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="833403459"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 23:42:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 23:42:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 23:42:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 23:42:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kssmyc9QldApz4ClJebsPQHAol2HIfi41tTYa1HTZxK1uhKnEqLzVfsH/KYJyzfn9jT6KJ05U9koOX9vVga1wOIPjOfOp1YAFhUV7MLCXc6IpFNgns3gfVye6yEt5FFI83GztbDjbMgd2lp/MwQU/mtSakeRKlP3x9CcXXg4E/+ET4392iVSH/yv7teWglXtS6PJxxneoGQFE4SG+vWPrO1i6+nv6xFKN6/v2LO15GET4r0JyrCa5rzzNGlm4SJXXSbVLCzIL2Z8O7gnwK04BqJt26lfwqjcsKARU1rcd5hypXSEbxCC26dwawAXlYGR/XXWFqUu04g5jA7hoDt9yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRzQC3EGAabLCZiR4j67gssJVDb8XBWcuiRRWx6tPmQ=;
 b=EILEgPlkO4ixYzyrioPaoelJY1M35mWxapv1xSDALLy6gsWZDI1lkqbwRgRHLAt5EMM8XGmdjqSIyzvc5pBSgETMCLYZp9j52FgjsndmlszgRFgCjR/z//6Hda0uEp5MrFZTyoneZ6XESCEdtpQQooQVZlxDhgaEuj5rIxKSBa9dWf0wGjuS88e436WGikGjjKxqnPmHkL5/4vHrVMdvKbYa7nLJZ7sp0k4JMYtUurmbrWHUYAFwmT6xnAX4cqTA2clxwu3Bu8/6r6Q0cSMZAv+XwuH//+rD4Iq/ODSxpKhdQLpl4wQOVOqbVY5qDdXRtb7h34+C8dbmmRGjnSjXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB6806.namprd11.prod.outlook.com (2603:10b6:806:24d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 07:42:50 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Wed, 8 Nov 2023
 07:42:50 +0000
Message-ID: <0ea819d9-1169-48b1-8579-3a054a0bd077@intel.com>
Date:   Wed, 8 Nov 2023 15:45:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 3/7] iommufd: Add iommufd_device_bind_pasid()
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
References: <20231009085123.463179-1-yi.l.liu@intel.com>
 <20231009085123.463179-4-yi.l.liu@intel.com>
 <BN9PR11MB5276BCF486E9E4F24913883E8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276BCF486E9E4F24913883E8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0015.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB6806:EE_
X-MS-Office365-Filtering-Correlation-Id: ce2082ae-b13d-4a6f-127d-08dbe02e4e79
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tZFRKpOrtxrz/9Je/KqYYqWv0eYMnvB7Ci13V59o/auojaOcWKRtbxXUWVxrTmcQdRgG26Sr/8Nvrjf4cPunI/rKYT/1xJxziTqm2eeNqbGNVyjYGMuTE9q/I71AgpiGzAXB9KaFPzZPwfO5oWIMLhIBRtWj8lFaTLKhrdo9/oWZkbwWbcyKIviIi3FfT/lzmG7bkBMkDILODJ5/Wgem9VYU7nmKwFnn8/agRFhuSqHol1Qz6fK082Fi36qr79cfILYSOwYcKjxraEp7f6jsYkXqfceyQWZLFyDRSz5G5jdj0pmULZxFsHWrDFQP4qLKqgMF88YegfKxAzH1X6KUq8rRmRnp/AGm0MHtn/pIeylBIhw14rRV6kIoSlq2nZvzJRYT5RP6wYObgOo+2pXDBcIVKcbsmcBjjiitIfgpWB1gPcoVNTW9etqvSuQAnn6m+VVOfvnpwq8BuexniU0ICho/QszGYWtolk3P8DkK7UBlFTA/2ZUQr4UbS9dRaq6BcK0jITQj8ON6g0pbeBnVLZgFTeLUMpLhOJ367Gvxyi82xND+rpr3f1hF3QNB7DSmKKq4bRzvst4IePwuilt8y1p2FXdRX0VwfIsiIvWXcq3TPPc9P0YE2cJSkYOcpd8oaa2sOrHhjAz1jUDlurfWRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(31686004)(66899024)(6486002)(6666004)(478600001)(2616005)(53546011)(6506007)(6512007)(83380400001)(36756003)(38100700002)(86362001)(31696002)(82960400001)(66556008)(7416002)(5660300002)(66476007)(54906003)(66946007)(2906002)(41300700001)(26005)(110136005)(4326008)(8676002)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFl3eXcxMWYwRFIwVzVHZTNQNndYWXJhMDFlUEI3aUI0dVpxVjNwM2NWM05p?=
 =?utf-8?B?NjM5VVRIOHZZUW9oK3JnL1VlYXRUc0t0MC9nRHk3VlJVZ0hKVGdCSzBUalpI?=
 =?utf-8?B?U0FRZ1AzS3pPQ09pRmZWVlVRS0xtK3pjb2R4V2kxSzNOVFBZZFlGdElDdHhV?=
 =?utf-8?B?TkNSOWtFTUNBMFBVeFM4Nld3OW0rZENzOHhkcnFQL3p6eWNHQ0k1SGhxSWJB?=
 =?utf-8?B?SWFmNWxNRWRrcmpzaWs5SHVzWDlwc1JTVVIyVFFRWjNhbzVVcjh5NVFQbmFr?=
 =?utf-8?B?cFdiTFVPZVE2VU5SU294WHN5dVNGOVg5Tk5kVzlId2pBQm5odjFLbkllOVBE?=
 =?utf-8?B?U0NkckJEY0VIK2RLcVlHOVVHeTdmd2RCYlVMRUEvSm50UllZSUJSd2Y3U3Yz?=
 =?utf-8?B?YWZwaDl5N0I2YW1qdEF2a2lzak9SRFJsRWZyZTZWVUVQN2FkQlg3Z1R0Y09s?=
 =?utf-8?B?eThVR0JGYVRLbVFUZlVOREpIZW5UK2lkSmNudVVrYnNidmJTWm5SeVZ5VG5h?=
 =?utf-8?B?UjFJalVSVS9NenpWS09hcUwrTGdFdDE0K0p5NnJ6bDJOcmVIR3JDR3ZZRGhK?=
 =?utf-8?B?bUhOSVVCMmdNamZ4Z0VReUEwWnRIQkJsZEFodERlU1p2MENWNjdMdGlOT1hx?=
 =?utf-8?B?dUgvZ3lhaHRldFd2UndQT3BSOFdtU1F1RjJVWHVMem1mRUYyNGxPbElWT0NW?=
 =?utf-8?B?OWI1dXJITC9sNG1wTEtRMVhJc3AvdzQ2ZHIrNkw2c2hTWTBha0VJN25pQXJZ?=
 =?utf-8?B?WXdCYmpFVlU1M01xVGxRN24zYXdSaWEySFRPUzAxMStzWXNaSGdZYS9GL2Y0?=
 =?utf-8?B?dzcrYzluMHkvWDd0Z3VhMTl5S2grOHBqMmRzdWhWcGFlenF1dXFOOTh0dFR6?=
 =?utf-8?B?T2tSWmFRRjF6cjhBcC9JRUFIVElXV1pSRW05cVJYeXpGQ0tPMDd6N0ZJMHVD?=
 =?utf-8?B?ZzJpaVY0SEtTL1JabXhqbmxGMUxQTkhDaHVud3h6allJeEVIR0xNeFJrd3pn?=
 =?utf-8?B?VXNPbC9uQ2pxUnY1WnVxMEJDdmR5d3lDemowcGptbFRXNTR0dHFnVHJpbjR5?=
 =?utf-8?B?b0MxYkt1V2gvbVM0STBTazhOQnl1QmliTU1peFI2T1B5NzQ1RU13T015TGJ6?=
 =?utf-8?B?QTc2OEkrcTBNOXV0dk9Lc3h1VVNlY1RMYnRyczdTckZRNDhieHRDbkNGc2Jr?=
 =?utf-8?B?ZTJ1bHZyTnBYbCtwb1JBNkZzeVpTZDRrVCtLVTQ1RU1HNEp0OUQ4Mm53Q1l5?=
 =?utf-8?B?dlVIZStPZmJUMXpjaWVSdHo0V1d1RS9POURoU0pGbm5SU0FtTjVVd0ZpY0pw?=
 =?utf-8?B?TEIvU0N0VVRndElnd1ZxNHpFM08xdUhUbVJXRnQ0eTBFRXpaNElhUW4ycWZQ?=
 =?utf-8?B?VSsycVpjdkVpeFJlcmcvZUFNT2RqeVZqaEc2R1NoOG9xaXFySHhHZXd6TUFk?=
 =?utf-8?B?T2wwUlFoVmljQk1DWTBKOTE5ZkJrUk5oOGsxbTJaSlArN2gramFkVWkzZHU0?=
 =?utf-8?B?RlYrTWpkcWp6c08xbWpaSTF1NGM3K0o1SkhDUnFjRG55czdJOHREK2ZSVHhE?=
 =?utf-8?B?ekdwNlN3dUJPdzc4Ly9MeUFzNnJRd2VRNTNhcUUyRnpUeVlVaFlYS0s1dzZI?=
 =?utf-8?B?MEc0QVNDcE1IeTFvMmErRllYWGt0THVMV1FvaGI3SUZURG5vWHpIcDFSaER5?=
 =?utf-8?B?QWFDWWpMNmtOTDVkVUV2NmMveDdZRHQzb2ZaVThnVUE2ZHN6YVBVd2RrLzc4?=
 =?utf-8?B?Zkd5Y3c3R3BTd2hBbDdoc3h0eGgvK1krTVNaM2FJcFhTRmw3Z2p6bVQvOE1Z?=
 =?utf-8?B?MFRBRWY3TGNHZ2xDRXV4T2VGWmEyZVdrelJhc0x2U3lheVQ1MWdvRW1kcEcz?=
 =?utf-8?B?ZXFkaVhTaHVub1BHS3BNT2FrQXk0d1BrallSUVdWbjBFdzhVWjJkUUltbkdy?=
 =?utf-8?B?SkM3cjhtRVg5MG5ZMGRmU2RaemFkaUE4QUFuUlJDQm1GM1doTFVuQmhWSFVl?=
 =?utf-8?B?OGhmTFArZUYvQkttRkxQN3RLL2JKQXRvOHdMOXRPd3lJb015ZnJhR0dvMHk1?=
 =?utf-8?B?dmoyYUJXeGFueDBoMDgrNVZXa1NoVldITU8vd0dJeDd3WlpLenZycWdNZTM0?=
 =?utf-8?Q?w+WE2dIAeohp+c7R/PwgBDXfb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce2082ae-b13d-4a6f-127d-08dbe02e4e79
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 07:42:49.5949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKpwG1rMDqLjVf4x7J8BYs7gGHHuFAMQgYha7Nkj8JhwG8VZCUfh8bbnzS6QxurgLOwVn85TUUT29Mo63KK/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6806
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/10 16:19, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, October 9, 2023 4:51 PM
>>
>> +struct iommufd_device *iommufd_device_bind_pasid(struct iommufd_ctx
>> *ictx,
>> +						 struct device *dev,
>> +						 u32 pasid, u32 *id)
>> +{
>> +	struct iommufd_device *idev;
>> +	int rc;
>> +
>> +	/*
>> +	 * iommufd always sets IOMMU_CACHE because we offer no way for
>> userspace
>> +	 * to restore cache coherency.
>> +	 */
>> +	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	/*
>> +	 * No iommu supports pasid-granular msi message today. Here we
>> +	 * just check whether the parent device can do safe interrupts.
>> +	 * Isolation between virtual devices within the parent device
>> +	 * relies on the parent driver to enforce.
>> +	 */
>> +	if (!iommufd_selftest_is_mock_dev(dev) &&
>> +	    !msi_device_has_isolated_msi(dev)) {
>> +		rc = iommufd_allow_unsafe_interrupts(dev);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +	}
>> +
> 
> Only MemWr w/o pasid can be interpreted as an interrupt message
> then we need msi isolation to protect.

yes.

> 
> But for SIOV all MemWr's are tagged with a pasid hence can never
> trigger an interrupt. From this angle looks this check is unnecessary.

But the interrupts out from a SIOV virtual device do not have pasid (at
least today). Seems still need a check here if we consider this bind for
a SIOV virtual device just like binding a physical device.

-- 
Regards,
Yi Liu
