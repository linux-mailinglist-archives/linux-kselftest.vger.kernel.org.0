Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03C57E6497
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Nov 2023 08:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjKIHqC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Nov 2023 02:46:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjKIHqB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Nov 2023 02:46:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE8D268D;
        Wed,  8 Nov 2023 23:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699515959; x=1731051959;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ELyq3gVEQIYxMFqLbWIT0ROXWF7V1vELa/teCRoLsTQ=;
  b=E3JiR/iTci39bCtyS5OLZMyOLayzfdl0rACy87bpRCl9HDOO5J3K0Gzg
   NJK7lhLduAaPXL/ynmMLadd/ZJ46En82jq2N8sOjZTCidn7XIALyJAN7m
   JKzYhzdUhrlrb/VoIG8pplpWMUqz6a0mmY4WOsfL0FIrHhJq4zlmdZBT0
   6pIg4o0QEepDGAjT3asLv7LCdGoQTojOUvI31T3ws2xxrmJtzH+w3+qtV
   JqfwwDlTXsKqXbqqoWh3uk9LBISxntaEfvTAev97eMMNRLQDUqWJw0X4J
   540+dQemUe3NHAumR4PgJIhdfDGKQw0DLKcQJn+awTWCqT01okEa2JBw6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="370138005"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="370138005"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:45:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="739762889"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="739762889"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Nov 2023 23:45:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 23:45:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 8 Nov 2023 23:45:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 8 Nov 2023 23:45:58 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 8 Nov 2023 23:45:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMhxZxbUiEVKlejsvKXfIKHu9711pd6aMGhR39uF3fqjydRuGcx/0JBCkMSY+H9dx25t+ZywdEoOs+dp9R7H6fQAkawNZWaAXWeEeeuhnc7ChXeWplkXbevSW7hVvoDMvOZJ003cqRP7Az20J1muBqdKZLOurP901bkLgPKk6EI3VxSGxGm8xjECzRu36qK6Z7Jcrw4OUCVu5/yGsJu0nBuBZYFainDBs37ScbS3TSfzs8Po2s+78kN6nZLrVIxCXrbkta50wUrogxah3BL3ALP/AyMA7peOyEVTs6PQSG6S0GUNYny43n0qXxJBSpmBJKUuSfxiRhSG+eflv5ZVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDvFcfAp9Ix8J4GLPgYOC/YqOeGlsUl2CFE2XpuDK+c=;
 b=OpiBGI2Bq9uSsZA/p9uJ6lkNrA0FaUa5NVnLG3kQQZmZokcF8eiCtNlGa3aD9GjItfFlbYnH/BkqxaaIaPLbzEBgkEfqXYf+0CdM9yCKUJ5HkocvNiWFjfKRbZXXMR+ltQmw37mPQiUyJ98AeMF///Mx26KVqMEUsC7c/pVlsltU9BJ77OSacNYApJZuXeY6yOCGW4k7DBLSwZBla1KHTVEGI6iWBykzeszcIjNVz1jNS7fYdAUWZFcJM5C+r0vQMRzD854NYt7hFefimGitqbC09RKlg2IqTE/jLd5f3SiviU+ObQ5FRLJvxQ9HFxF9Dtq0YF8T25c0LP7kFUAUSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB7361.namprd11.prod.outlook.com (2603:10b6:930:84::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 07:45:55 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::e4ae:3948:1f55:547d%4]) with mapi id 15.20.6954.024; Thu, 9 Nov 2023
 07:45:55 +0000
Message-ID: <110f5a3a-7f3f-4b82-bb12-c7ca5df5c98f@intel.com>
Date:   Thu, 9 Nov 2023 15:48:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 6/7] iommufd/selftest: Add test coverage for SIOV virtual
 device
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
 <20231009085123.463179-7-yi.l.liu@intel.com>
 <BN9PR11MB5276A82597B194611BE01DFE8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276A82597B194611BE01DFE8CCDA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:54::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 3602fb21-473f-4ed5-77ee-08dbe0f7e6f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3tK55rDfjmbU+5g27hsu+CbhZtvL/o5l9ZXtxoY/LElTEAqRH9Bck6up868TMmog0Lp2aPt4nRg5qUIW25iLsZ6mFtqIRP/p2zyb10toLXlsZmcyMMkCC9Gxz1AgiykaC7JrZ1jcWek/DgsiuKt2ZIA9W+LKQXIPlhHI0d15cj38BbmS6tV494DRIXhXMa2g7iGrAqfdtx1Lu5aXsJitGvzQV64g5Jww6GNXFUhmVmXcvzMGHm9LoG2czUG1x++KRtv03szDTUVHWDM8dF/ydvsCTPQ/LqrYOPtgcwerqQez8OOZwd4QzaYEYVVDEyDJjlIja50q+Ge2/vqa9oN0DSq78Sx1LNJn6FQ6l/j/mhKkbeiCT6042/J6JZIIEAyNiisZFxGUarTUq/WEPaO+I7lZpEViiJNMRH9MLMRBbpcJ9PVbmPk0rxT7IGM8JPVCpOOJ50lwEM/COlAJz7F7CAHanMTEJzktji1oBUqR+S/e4L27Q72CqQyxmKB/+hJzUnSnaBItLtBb68AweHrZsyERSc7jjBMJ3zhA+WZwlOysG5Tr8LBuM+wrvzPkqHwezjLz+kA/+ZiU5L3doNlV+u0ag+Tm26qEuG+iZjbz+0ZdpCrdH9DhFtpN9KSwB7poQ7Pvql/WTccsPVqC5AUDbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(41300700001)(6512007)(6486002)(53546011)(2616005)(478600001)(6666004)(6506007)(7416002)(26005)(4326008)(110136005)(8676002)(316002)(8936002)(5660300002)(66476007)(66946007)(54906003)(66556008)(31696002)(2906002)(31686004)(82960400001)(86362001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGVBTHN0RTU0U2EwUVF3N0tQSDMycGJRUjMwUTd4THNMeXRRcFNiT1ozazZu?=
 =?utf-8?B?azBTRVh1VnVVUWZIbEtta0FtVnVhZzllTDEzdytsRkF5YXduRnhmUk1WbjFU?=
 =?utf-8?B?aVAvMmRUWmp3alR5VXNWN2F0YXhHN2xxK2tMTjhDcDdleStVMFJXNzlLbFZz?=
 =?utf-8?B?MCt4ekxnN3VGWjRta25IMTZST3NqRW04VXdRbHgyeW0yeUFidHdGQUZ2UHpW?=
 =?utf-8?B?M09FeHliLzhXRzBDRFdXbisvaU05VHJxbWxIMVNtNzdTYlFNK0NNUkhzbUVy?=
 =?utf-8?B?cnQzaExvMVp6ZSsvaVhmWjViZVJpbFpEcnFKVXJ0SDY1dlQ5SmtXZktPZ0Zo?=
 =?utf-8?B?OENhN1ZxM2FqSWhuVUFybHY0MTlIa1JNRmkzY2JCWUJ2bktKKzh6NWtUc1B5?=
 =?utf-8?B?dWg3Zk0wQmpRT3p0SGRNVG84VStDSnF0WU1QMHRiSTJCVmVrMFVzNWR4aDhs?=
 =?utf-8?B?NlgwZ0V5QzdDRm45ZkVIVUszR3liaUJxQmExS2pGRmFKOHdyMWhHWGxLOGlG?=
 =?utf-8?B?L2FYSVUveEp1OWxKVC9xSmk5bG9Xejl4RllxTHgrWDI0M0tsaE9nOENST3Vs?=
 =?utf-8?B?K3JTUFVNUjE2MU15cVNsYVNPSDlNKzkzVUdoc052Lzlpc1NqNW9JWTE0YVVT?=
 =?utf-8?B?OHVoUi9qZU5KZnBDc2NXZDVHL1JDK3BISDFzdnpEaDdSVCtBcndzYVVBNmlV?=
 =?utf-8?B?VDJSdWV4ZmFSYkQ4enNKYkNBZmxPazlwOVFueGpVTnFUalBjM2h5cEFIMGFC?=
 =?utf-8?B?S1k5Q1BESWlxY25pSHlNd3M4eTQrMmVwS0tHQkYwWmdYbmVlRXBnMjZRSkRa?=
 =?utf-8?B?NUVUS0RLSURKWXdaaVpPUnUrTkp5M3NOb2ZKdnpKV3ZzMndEN0NSeERqOFlW?=
 =?utf-8?B?M2NwQno3VEpVZ283anBaaWhYQ29zNHViSEZ6RnlIMDQ1d0ZmSHh3WUk2bGc1?=
 =?utf-8?B?ZHh0Qkh2Sy91b2t0VHEzUlh3OTRMTnVIV1p3Z21XYTFGY0l4QWxrbGVUREdh?=
 =?utf-8?B?K2l2bkJ2bmpnVjU3eFZ2Ry9VWUs4RnFuSGpoM2xydTBZaURONVdRditDRlZZ?=
 =?utf-8?B?R2sveU1OUUFnUFcyQ2hnMk9rZkt6Q3RvbUFmcWZHZ2tybmR4cXRWQUlOSmhC?=
 =?utf-8?B?VjQ1S3c5RDloeUlXMERta2ZRY2ZwUDB5b29iY1E2b3ZvbG9PY1BMSExsQmdT?=
 =?utf-8?B?dDFoNm0wN1kza3JLVVpaRGRhWU9aelhZODlMZ1pRSmNXM0huY0lJeDVXWk9p?=
 =?utf-8?B?Mmllc09HNy9sZXFtZCtFaGNUb29nT2hneC82MWYxT0F0ZGw3RkY4cVNNcjhu?=
 =?utf-8?B?d1hNcElSRXI0Vm9GdFAxTTBTWTU1akR2Tkgyand4Y0VhYXAzWEJTUVAvVWlp?=
 =?utf-8?B?ZmErTjlNN3B3WmlZZGEyMTNzVndBRlEyR2Z6OHBDWGh4SmJjZG9oYU9Zd3Ri?=
 =?utf-8?B?WVQ3Y0toVVk5OUxnZWZTOGtkNEdDN2ZDbTg4NlFybXY5YTBhSEM1UzJwWWtP?=
 =?utf-8?B?UHVEZks5c2lHN1NsQWEwUi9kTGFiRzdUS2xXUjd3c2lvT21DVUFQOUoxa0NH?=
 =?utf-8?B?NjNOaUVoQW1GRzRhZHlsb3ZubE1EU3ZHWVBvemNKM245ZDRHSDk2L1hwMWhL?=
 =?utf-8?B?VGFoREtuS0N3OTZGemZld1BGSG9JSDJJUnc5V1JQcCtIdUV2b1JCcVRBYzZY?=
 =?utf-8?B?ZnQ4WVBHSERBNmFDNnZQNlFNWHRRcVZnRUI3Q01KbGpoYjRkUWRqTVBDQlll?=
 =?utf-8?B?S0gzRlc0WHlwa3FFVllzQWhzeE11MEN4eUdKUDdYMnBGb3NmSUl0UTVJa254?=
 =?utf-8?B?dmpOejZGeVBycktRY0R2ZDIyb2NPVDJheTVRdHBhU1l3ZXNpaVRONE5aQS85?=
 =?utf-8?B?VUJrNG1BWkpiVldmYWI1THprbCtZWnpVTC9WWDFSUU9zTnRSRWFUdjBlV1R6?=
 =?utf-8?B?RDA3bjFDVHVRa2NQVTNUZnBlNCs0bkFWTTh3VzFuSmVmZFJrMHMvSWNNamVp?=
 =?utf-8?B?aVJaVzJyK3dDQ2VnVFh0ZUZKNldUTVZwRTJKRVdwNm9OMUhEeUZxWjAxMmow?=
 =?utf-8?B?UkdGZ2xVR3NhK2JRa0Z1bklpUlhIa1FDalBVTlFOVEZNY21McXlySldIK3RX?=
 =?utf-8?Q?ys6tiMpkwi5db2xOtTA2XGlvg?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3602fb21-473f-4ed5-77ee-08dbe0f7e6f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 07:45:54.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZeZDM0O0HoRo/NG1GCEUB5oUSmTwXqar7kEmuB8ZzUhbN3ZvYe631+5ix4CUIp2RjLu84ivVEJRIoRuxxWHuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7361
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/10 16:30, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, October 9, 2023 4:51 PM
>>
>> @@ -2071,6 +2083,43 @@ TEST_F(iommufd_device_pasid, pasid_attach)
>>
>> IOMMU_HWPT_ALLOC_DATA_SELFTEST,
>>   					   &data, sizeof(data));
>>
>> +		if (variant->pasid) {
>> +			uint32_t new_hwpt_id = 0;
>> +
>> +			ASSERT_EQ(0,
>> +				  test_cmd_pasid_check_domain(self->fd,
>> +							      self->stdev_id,
>> +							      variant->pasid,
>> +							      self->hwpt_id,
>> +							      &result));
>> +			EXPECT_EQ(1, result);
>> +			test_cmd_hwpt_alloc(self->device_id, self->ioas_id,
>> +					    0, &new_hwpt_id);
>> +			test_cmd_mock_domain_replace(self->stdev_id,
>> +						     new_hwpt_id);
>> +			ASSERT_EQ(0,
>> +				  test_cmd_pasid_check_domain(self->fd,
>> +							      self->stdev_id,
>> +							      variant->pasid,
>> +							      new_hwpt_id,
>> +							      &result));
>> +			EXPECT_EQ(1, result);
>> +
>> +			/*
>> +			 * Detach hwpt from variant->pasid, and check if the
>> +			 * variant->pasid has null domain
>> +			 */
>> +			test_cmd_pasid_detach(variant->pasid);
>> +			ASSERT_EQ(0,
>> +				  test_cmd_pasid_check_domain(self->fd,
>> +							      self->stdev_id,
>> +							      variant->pasid,
>> +							      0, &result));
>> +			EXPECT_EQ(1, result);
>> +
>> +			test_ioctl_destroy(new_hwpt_id);
>> +		}
>> +
> 
> I wonder whether above better reuses the device attach/replace cases
> given default_pasid is hidden inside iommufd_device. this pasid_attach
> case is more for testing user pasids on a iommufd_device which hasn't
> yet been supported by SIOV device?

perhaps the way how the above code checks the attached domain misled you.
Actually, this is still testing the siov default_pasid. In the variant
setup, the default_pasid is passed to the testing driver when creating
the stdev. That's why the replace test does not require a pasid.

maybe I can let have a new selftest op to check attached domain for a given 
stdev instead of reusing test_cmd_pasid_check_domain().

-- 
Regards,
Yi Liu
