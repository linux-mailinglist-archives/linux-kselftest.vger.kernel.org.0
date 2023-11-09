Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14F7E650A
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 09:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjKIIRn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 03:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjKIIRm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 03:17:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898C7273E;
        Thu,  9 Nov 2023 00:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699517860; x=1731053860;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=39zGuC2iZ8fCZcKOIwKN9lqle20EuH/5lvQoeK/qZUQ=;
  b=QlwECxUQmt5N02lwr746OHqFh1WZieTHvN143/sRe/5FUsAu21S3taDO
   nt2NPQHLQvd3GQ0MUnflX3jmq8CRhKmN2tS4C/Wy/oBU7692sA1d/X2Yl
   WAgOd9bEkJAikRJxnQYtz80Tc4z8FWoRg4D7bquMz0ADp5EVd66zVN5Bv
   KQzTqE5CI7LTRNdecKmNFweOapyWI0xDvGxnogfh3NRL4rxMF+HiHEIrB
   53fBCZFOqqER/Xbvq9ACgcGf3OHEEOxvFaCRazjHwZR3RHqWyr+/tYzsU
   S6DZJqX10+EleicDOUEnsRtMgotH9WeO2aUi+4GR/EHDH5pDO5ADryNBr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="476170564"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="476170564"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 00:17:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="886929041"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="886929041"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Nov 2023 00:17:39 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 00:17:39 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 00:17:39 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 00:17:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOp7RmIJ9X8o/C9wGGFWWbII6Hzqbq7aAPWdHxvEvGUkrLP02+ZsxfmD/KkcQXh07g17Zk87Oh59PC2N/QlCyG0x94iy4I7PhMptATKol+GmIO0UVwvKpvE3rkUv75TVpDgTRaSXw4lw4idcgRSrCmY+dpNQ4p70JnDNrYFYk9W3HIbad0Oe4Jcff8g3MHR5SdVs3xsL9S4ihfwwVhD5Bt001BPW7gmdK7G3/JBDk8en0yfjLOJgt1Y0O+ZD9fUDoPfkZBBbZvBixVRD7eG6/NVBTpatJl7RoxM3M/ZvrqRFAqGYtvzXWfxlJBwgO7nV07HagfSXgI8pFf0j8EJ9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aGkuxku7bmkWpyBxvMAIkSK61TBBMIYb34klhd4ZQk=;
 b=nLbCPSge6tRlW86AbXuzzRHBdt5OpRoF9590xZXU9iFelGB9dIDU0UV+9Yfh8+IJg6+8/ZC0cdFRiEdm21NZ3WvBjJQkxj8bDnBhRxGDBZDm1w6r7xgcnIEp0HE7p+4DZPkFAdkOovFsfo/v5Mte17xd2ixb+WtmTAJfHU+Kn7lABfWnjkisttftDhoBFKuxwX9zMN69VHBcaCZTdD8P2zQMO/Cm5sKFo1CCLRyMW6rmMxLa39Xq0QtA7wvWCvwXufqvjWYC7rg9hf6fp4dCZI7ClfD9NW8WJCXflumsDgEHhAZDpz5mCZLUvDo2128wiAXfixo00vH2dsK9tlAxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 08:17:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Thu, 9 Nov 2023
 08:17:36 +0000
Message-ID: <0096f532-157b-4477-b305-2164b42e5084@intel.com>
Date:   Thu, 9 Nov 2023 16:20:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 7/7] vfio: Add vfio_register_pasid_iommu_dev()
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
 <20231009085123.463179-8-yi.l.liu@intel.com>
 <BN9PR11MB52767FED0A5AE43AE86C4F568CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52767FED0A5AE43AE86C4F568CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW3PR11MB4556:EE_
X-MS-Office365-Filtering-Correlation-Id: edd80283-a9db-49ae-91cd-08dbe0fc549c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oZCagImdq28SnJOSpHX/rRPEGnzeCcWId3UILQw6IXqFFzN2C8m4MeSpd9+fGz0feaE05dO6XOz7X+8q9RhWbsjENjzI7jCa8AMAdmXEXCYwpFaGNiKUTYbLQHGNy5AnFvrm2lNUSY76S85dx0rzI3/xAV2ZcCtNGgD5Hny0W/+cFRQUpz+i2DVmM1V1KSvOTLDGDA9eKubDzFEWfw9dPcoG+2RdHVvrIunznGCDoXV2/EiX/T7ADsEKn2mdBnRA9LGWodprraVX7AhOmHAfd80MRtaurY0aoEgLt40Bo0KY7ZRRgpbHOcnDSviZdLDd07rSz1CfoawOtAKzf9dBFor2Bvbgcq/1S7jdrBcomU5MRkeF5BN8zo3nrZX0ubPkl1V1q2WYhAHryIyteGP3y8P8OpMMKF5VbgiQ6JO0JR6m+BrQJd/NdbQu95yZiKmPbVGG60+K36+ZhwwLqwLm85pdLxhnSdsH4SKSBK5m0wVsl2K492H648kXxWk720C+Cd0n9RDaEd0V7CZJawfnSUNmM8kEnHkNaQZaFXxuUR1lbpLZPZl5kgmB/N2r0v2pY5iqifMmlE3OMW5/UcNX9qNzvYMSkzGKNA9QyzQJeXhGbew/xlCC8G8Sg2UDzcwjUlmdPBazm5p/3GIBmxu54A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(36756003)(4326008)(478600001)(5660300002)(8936002)(7416002)(8676002)(6506007)(6512007)(2906002)(31686004)(2616005)(66476007)(6486002)(66556008)(54906003)(66946007)(26005)(110136005)(316002)(53546011)(6666004)(31696002)(86362001)(41300700001)(38100700002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1VRQ29QQ2VpY0JxODFuZDBDeHpBN01ubXRPUkRWL2ZXSTdhcVhaV0ZNeFAx?=
 =?utf-8?B?OHlTamJOamFtUURQQ2l1eVB3VWM1a3ZOMlFtMWxNV3QvcnZCVUYxejJjeGg2?=
 =?utf-8?B?ZVBHdWpUcEx4TFNuajRjS0JVQzNOd091Ykg5dXJNdUxzeU1oWDcwdVluS0t6?=
 =?utf-8?B?L28vL2MwMW1RajJFWm1lclhRMDh3azBWVnBUZnFJaUlBbDF1Z1RabzZpUnZB?=
 =?utf-8?B?YjJiZUZqZUJLcVQrTVo5eTBwU1VyVGdpa1VDbXQ0a3FCUGZnNDVSVVBzRVpx?=
 =?utf-8?B?WEhYNEIxS2NNMGNMbVJ1ZGQ5cGM5WnUzblVPek9HbUs1bGZUZGNjYk1zM0Mx?=
 =?utf-8?B?TUdzTnpUREtWbzhNUXhTTUJmM0VGL0VDMVJwVFNIT09LcEtvcTFVaE9BVVN0?=
 =?utf-8?B?V0padkdhQ1BZSDNCNDYyODFLbU9YUDZEb0lHMzloN0JvRlJMRFduMnRLaWJX?=
 =?utf-8?B?ekQ3RWhndGd2cytsczhHbEs0SmdhK0RSSnNobUlFeE9JT1hpZ3hqNmlMeC9Z?=
 =?utf-8?B?c2s0a0ZRa3g1dWxsWnF0MjJqNk1qNll6bHg2YVRuK2h0Skk5ek9lQ3pMM3lG?=
 =?utf-8?B?TXc5Mk5tam15VHVtV3hKTEpDeHFsTlY1UTlsa01NSThsN3VyZHdjc3NZdUpG?=
 =?utf-8?B?S3BaM1NTVDlVajZmS29MVkpZVlFTM0NzUlRodXJLNmx5QlF0dkZvajBXWVl2?=
 =?utf-8?B?UzJxT01CVFFqajA5ek5PQ1dIVUdNaU50L0xlVmEzSmpCTTN5QWtTcGlqckx5?=
 =?utf-8?B?bFZrNFRicGErQ0dHLzBxSzdTdVlMN0FxU25IeTFWUW9EeWFVajNmTi9MRTcy?=
 =?utf-8?B?cTB0U3FWMEpxTll2Vm9EN0N0bzRtbzZCcUdodXlQMWRsWGdqbVJvUGxOQ0ZO?=
 =?utf-8?B?NjYwZzZraTlJSWpZVi8zejQxRGFHOEFMQ1M5YWRRVmxDdTBCQ1lpQUZKREt3?=
 =?utf-8?B?c2pTalkrb1dUU1ZUanRhZHd2QnFkYnR6VGtadThsNjhNY0Z3bVZzaFExNWFR?=
 =?utf-8?B?QkRSVTFsLzdoblFLSkx2YnpVQ2lEekM1YUc4WUJ0MEZMYmwycXFHSDFIL2d2?=
 =?utf-8?B?WHNJTjhoelcrVmRDOWFmMTdxVHV3aUd0aE5jQ3ZFcW9QSDlmd0F6SjdDeXlq?=
 =?utf-8?B?aDhCd1RLOUpUYzhlaUFIZW9lVjQxTGRLWDJ1Q0JORXQwNXBuenFIejQrSmlm?=
 =?utf-8?B?VFpxdzJyY0V1Uk1tQ3FUaTFiQmlVYU5LUTcxSW5xUVFqUEJOMGZYUFk0MFMv?=
 =?utf-8?B?VGVWTnVMUlFOci9VajVPSkNhd2ZpZ3BSdmZpdVNzRUM5L3VJcEM0TjJNZjFR?=
 =?utf-8?B?elFjenhESFpZU2NVYVZQOHp0Z05LOEpQbmFBMi9WTnF6TFNaN1Zya1NOQkwv?=
 =?utf-8?B?UFJXbGxkN2dhM1FwWkIrVVV2SXYrODBtY2JIQlhjUnkyT1IxL0Vlb2dQNEdP?=
 =?utf-8?B?M1BraXpDc3ZBQ01kUmV4MWgyNTlZMjNKOVp2UGFxTHd4TURpbXZacmxMWkZR?=
 =?utf-8?B?TmRGdmd3U2JLaG4yNU5pRXEyUld5Y1FlQ3dwV1VsVXZCN0dlaFJWMDI2S3JB?=
 =?utf-8?B?QnM4Z1BtTTZEdkg5NUxQa0U3VVVtNThjVWVmdDlnZUkzWlpqMkFQU0xtTE9q?=
 =?utf-8?B?UTZMc2xnZGp3Z1FMN1lOcjRSRktCaWFLTkJuVmJJc01aRjFNWTZ0bDAwVEov?=
 =?utf-8?B?UllvOUZJd2J5czIwWWhjUVhsM0hnMi9iMFJ2WnJTaXNCSGRHazZlVUZkWVlt?=
 =?utf-8?B?VFZmODBqbExkSmw2MzBhWFJGeFpCSXovcHkrY3c0SXZvd1J2MGY5ZXNTd21S?=
 =?utf-8?B?MU5iTlZWdFY2ZTJJaXhFOHZuRmh3YklERjRkcmFhaWZrWlpHRktsbkczc0Jh?=
 =?utf-8?B?bC9tSmNrR1FIekdDYUwyNDBLNkZEUGNTb0Z3Wm9kSk9yeGpvTnc4QmJaNW93?=
 =?utf-8?B?WGpHck5JU3prelgwbjJ1ZlFmUEtzd3h6ZDhZWUw4SGQ3SG1xYUVmU3IzK1Zl?=
 =?utf-8?B?eE42cFVrMDFNdzNFUUYyRVNJUG53dkdlN0Zla1d1ODV4MlRZbENkTWNud0xs?=
 =?utf-8?B?QTdocDE0bEl1d01kazJHTERNcy9WdzByNXFYN0FuUjFTZlI2ZTlxNFREWG1Q?=
 =?utf-8?Q?GRz0fu8jfbsOOwEumw+GvKkB9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edd80283-a9db-49ae-91cd-08dbe0fc549c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:17:36.2632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Fy8jvG/MFJsujjwhtYg+PtItjLtpU74hrrMSugTWjp2D6V44RHu+ksEL3elUpinhdzxm9lgV2+gV2+CMlD7BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4556
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/10 16:33, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, October 9, 2023 4:51 PM
>>
>> From: Kevin Tian <kevin.tian@intel.com>
>>
>> This adds vfio_register_pasid_iommu_dev() for device driver to register
>> virtual devices which are isolated per PASID in physical IOMMU. The major
>> usage is for the SIOV devices which allows device driver to tag the DMAs
>> out of virtual devices within it with different PASIDs.
>>
>> For a given vfio device, VFIO core creates both group user interface and
>> device user interface (device cdev) if configured. However, for the virtual
>> devices backed by PASID of the device, VFIO core shall only create device
>> user interface as there is no plan to support such devices in the legacy
>> vfio_iommu drivers which is a must if creating group user interface for
>> such virtual devices. This introduces a VFIO_PASID_IOMMU group type for
>> the device driver to register PASID virtual devices, and provides a wrapper
>> API for it. In particular no iommu group (neither fake group or real group)
>> exists per PASID, hence no group interface for this type.
>>
> 
> this commit msg needs some revision. The key is that there is no group
> per pasid *in concept* so it doesn't make sense to fake a group...

how about below?

This adds vfio_register_pasid_iommu_dev() for device driver to register
virtual devices which are isolated per PASID in physical IOMMU. The major
usage is for the SIOV devices which allows the device driver to tag the
DMAs out of virtual devices within it with different PASIDs.

For the PASID virtual devices, there is no iommu group in concept. Hence
the VFIO core only creates device user interface for such devices. This
introduces a VFIO_PASID_IOMMU group type to differentiate from the other
devices that have iommu group in concept.

-- 
Regards,
Yi Liu
