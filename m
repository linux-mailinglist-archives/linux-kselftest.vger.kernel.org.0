Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF02E7C8703
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjJMNiz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 09:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjJMNiy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 09:38:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B5595;
        Fri, 13 Oct 2023 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697204333; x=1728740333;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kimw9NkPaQSrQZ57vm5QNoZoOnodQP2ttqXmSgxibOk=;
  b=jyPB7k33VKzMw9A+5zhNHR8M06vpoj4S/osS9WrDke4tl05Kfz5q288b
   s+qTmUgUCNujao+eCWCxNvmDsgS32VkSaADAnkfKFuGIi/vh4+3u0hNIL
   deM7nD4HE3df+hoGj4ibrI4Opi4dyzG85w5dsfGhq607w1mpVZXSsPXR+
   5zz5pVarU2zHZpZxXqBdpMApPcureT5xJYaNo184S5dyDZuL5ytgOkKro
   bDLgU0bL0S7KEEeyi4cJbB1POspDcv3+jEuQOY1CjxTZNxelPVtgCb1sd
   OVXL0OeCOtnU6T8tn1ftyBVkIMu9jA2VrSaZyV3N7moosb/bLnR7LtqvS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389047802"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="389047802"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 06:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="754704368"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="754704368"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 06:38:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 06:38:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 06:38:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 06:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXD9PWjyWkAdd4aOEzjg+lMQ5iWpMcvVl4btXarlX8CyZqR9n6Gm83WzVn2zETBe59awiZodgEa+fw062V247yLcRIo+q3R8VUD4zPYZ9UjixU0X7Nj6R6LceDLD2UyAoVd6nTRfhAH+XCbuc/6b8AcOK7DAUp4TKskqArZUP4tGpf5POkxHnQQliQsfALmlNBPFkF0jcvFw1/IBT90xKuLErYdVpUhUdLPVRzNdZiLulr65gWTlPDDAMGESZRN2ssvPcX5BkNceOG8Ypjb11WHoyEGmtNjP01Xj9hlDyeb3DMpiDH5uGLQO9gj5kYMiTTi7DN33xQT76cpJKnZX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24UbXFQ7W2+VfrBjzx8pzm5l5VKHrNp5N5D+M2q22aQ=;
 b=W7e4vpQTO5kbogR+Gb3kYUh56f6FrydOovVF/ddWXhDx0rZB2sZ6WHFsDaJth/HqPOYBsXqedSYolgH9aQrObSoNpnCyJzvTAMSiEin5ZCUGee1OtXnJMlgy6ukh4Ta0xEZEHtk3E773OMS8gkTOY4RF5ODRFm1YSiVY42JhotmFn5OhT4yoLO4Gfh419codrC5c1aFOG6x0hraROwFqE2UXsDC2hDJhghGZgJuAxt9kd8FxlvLond3EnpcXtv9xmShSeoxb0gGIt+J6kDrLz1EBNA+mHC5zgeXJbIkZSfvEE6xHbU/nbplXlQU3CkPpkEeHTjW+gESS5rQlFNT2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 13:38:46 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 13:38:46 +0000
Message-ID: <e30442fb-281f-cc5f-387b-b557ccf11920@intel.com>
Date:   Fri, 13 Oct 2023 21:41:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 10/11] iommu/vt-d: Add nested domain allocation
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
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-11-yi.l.liu@intel.com>
 <BN9PR11MB527619427F9C41061FB3CA408CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527619427F9C41061FB3CA408CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SA1PR11MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4c6953-2473-4fd6-8768-08dbcbf1b943
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2L+XwoZjaeer4CwJ48APTSPbmzAuJVYc5GfHVxlERHNhL9NJBvuvqLNOfO+Df1XDdnWBt0fptMUUPdewwM0R02TK83sFDILc5hvW1TCwF/SlNEc2FSEAyC01QTctNEwV2DC/l+GQsipqxb2OxC9h5vJ35uDhomKHnNOL9ZH1fwyNYF+tNdsoDBv4J/awuEkJ0Fuopb2insVXOcASn5YRPPdjTezxtdySP/wY9Rgq+gPWSo/kAAdUn8LbjZC24rcOUZw9m+XCjmWsWwjVRyVOuxjdSjVpKucgp/S0B99fNcQYcFFgpgGJs8946fP72nrrfcBvo+nuc45VAwHWYryq3pHsvUITc4xhki7RgaAqxrZL1Cmg0oRHgnqYQhY63oQP5GjNhpYHNOWW/RkSCjBGFoUTYd45RKjZ4p9mYYX+OJ1Vf36lhbG5aPx/jm9weCC5W5IwYcmDLzZDa2FEijeAMOrDJgTyYs7xsGX3FDKUYmLWoJDEL15EKNk54/bY/w5k7g2XhRQRSsjiqY76WeLrRte4R5o9Iq4peMsnHPSk7dBQCludYRJcvQIMMpHsLLEleTA69Ycqetwbp+Rot2XR7zWJQ3iEp8Z5lbofkhepgVl7fweaDTpP+uPwL/sMCFSU3Hayihu7HwC3rtS1fk77tAFc9C/c9V5OXx+bJFxYHxUkVBKAIJnyes0M0QzbSWfy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(26005)(53546011)(31686004)(6486002)(6666004)(2616005)(38100700002)(316002)(110136005)(54906003)(41300700001)(66476007)(66556008)(66946007)(83380400001)(5660300002)(8676002)(8936002)(4326008)(6506007)(6512007)(478600001)(2906002)(7416002)(31696002)(82960400001)(4744005)(86362001)(36756003)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzViNU1YOHpCTnR2cGhPVE9LWlVzWCtLUE9RQit3MVdOYXVHcXBqcUwxRzRx?=
 =?utf-8?B?VGNVdktqdjV6b1YrTzdkTmUySjFNVkcyRC9NQzF5SDZPRGdHRS9xUHViNU1O?=
 =?utf-8?B?emgvZEo2aGJaTkdQcnZSTlIzbEFqd2x2M3ViUDhmQlFsRUEwUUd1eTRnckJP?=
 =?utf-8?B?OUIvVlFDSGxOTEU0OS8vK0hzV3ZuY0JpbUpiTkFRSENhbmpEV1U0OWtjRDIv?=
 =?utf-8?B?T2dlUXRlcWQ3YVA3MmFxa3JBSTlPV0dlamhxWmFQc2lRVitESm96dGhJYUx3?=
 =?utf-8?B?VGRMajNFeGdqUjBQY0h6eWFyV1kzWlRMczJTV2MvZG9uVHNlSFF4ZnJSS3VZ?=
 =?utf-8?B?eVpDYmJuLzhLOExabk51UjBCektPZ1hpb3drdWNMaU9zMEFPOERqQlh4MkJK?=
 =?utf-8?B?a1d6UlppandvMU9nN3YxdUk0OGRVRXdCZTI0RGhHTy92b3BCU0lWeVk2aXk3?=
 =?utf-8?B?U1E0NXA2WjUzT2JOZkJ4NEhCS3RFTDA3ZEEvOVBzSm0rSXU0RHJXcFArVlhN?=
 =?utf-8?B?TEpMUkx0OGFzUS9zWVpaTmpDb1FPL2I2cWF4VkFQZjc5by84b1VFdmVkUitB?=
 =?utf-8?B?aEUyam05RW1nT2NTNEhsQVU4bGtrN1NSUk9VUFZoK2RWOFJ5OHdKZUpiZkFs?=
 =?utf-8?B?R3RodVJBTStmblNXME51ajh5WHNDYXFKYjJHR3J1OTgveDVlSis4ZGNzelRV?=
 =?utf-8?B?RlR4a3MyQXdzUEtnMGI5WUo5OFM5R2VOMHBtTHlxU1FvUXYyQ001Y3JhQXBz?=
 =?utf-8?B?U0tOSUV2SkdpSUVJb2JObnBLV2pWVzdUcVdIN0M5OFYrTWpjQXZoNncrVDNG?=
 =?utf-8?B?RUE5RVVYU3pCWldxUCtOZThjdTNRNG5wMmNrMTZISVl5RG1GRkx5OUhRSHBK?=
 =?utf-8?B?WDFianpiMWtmK0NJQktreWxuQkhOM0tpbGMwMmVXZ3QwRHUweUp3cUJpL1VI?=
 =?utf-8?B?L01HempjM2poTG9zZ0ZlbUNhS3dIRlJDOFUwUE1MYXB6bWozbkJ0M1gzanpO?=
 =?utf-8?B?aUZ4dFYyS24xOHptTVRPWnhGSjNsSFRGN05xQUxkUE9tN0lDMnRzT0NscEhq?=
 =?utf-8?B?ekFHVFJqZHAzM2ZXTFVNdGdSMEZ6VEc3S01EMVNONFZ6V0FFb0F6NElBbkNY?=
 =?utf-8?B?bGcydHN4SHFibEpmUnhTNFpzdzlOS25pSTNaYjYrQ1pzQjlUVWRUUU9YYVpH?=
 =?utf-8?B?cnBxR3FOMjBwVmxFR2VVcVk5MWZ1Y3c0OTVUaE1BMHpESHVpSTJSRjh2cXRp?=
 =?utf-8?B?VzJieXB1S05wSTRwUE5Sb2U3a1daK2xPWUhUaU8yY1VNWTZmNjZMV2w0TGRw?=
 =?utf-8?B?a2VhZEVzMDdYWHhYR0V0cDQ4Nmo0cHRoYjBRalJxWWdoMHhJWHZHZGZicWpR?=
 =?utf-8?B?UkJ5dGh3VHJVTXNqY1QzcXNoVXdNb1Zselhlc0FGMFFSVnIvKy9YU29IVjFN?=
 =?utf-8?B?NUpKTU9qYVFtdmxjZjYzYk9xdHVjMSs2U0FjSGVTaHdKSWJVRWlxV3FweDhi?=
 =?utf-8?B?cC9uREgrWVlNUXF0b2hURFdSQkc4SUJJSDRFc05laU56enpQcURwKzlHVXFa?=
 =?utf-8?B?MEc5bGo2NnV0OSs4Z3BvcTlWUmxYbUMxMjFjeDdaVlJsN0xnZFN3YmcrVjE0?=
 =?utf-8?B?NUFORWczSTV4bEpxZWY4OWp5WWpnRGhCOFpnZjJVekNYSEt5V2pWM09TR0tU?=
 =?utf-8?B?c0c0dHV1a3pDd0pDZW5aT2N4SU5qc2tEc0JaTjVjeitibnRqZVpqemJMZTZZ?=
 =?utf-8?B?aEVPTDI5V1M2Zm5VVzZxb1Yza3Ezcmp2K2lGa1h4cnBldldicldFTGtmaml6?=
 =?utf-8?B?K2R5ODJlYWRPMlZUVFMxRk9hWDFhS0hQaWZjT3FDL2E1djFxbUlUeFhjb21P?=
 =?utf-8?B?bW84VDFWVFlFZGxONFBMckdrQ0ZjVWw3MGxCT1pxSVl6dlVHK09CODg0TXNr?=
 =?utf-8?B?WndDUmtldjBwNG9NdHptREZpRzg3TlRVQTEyQWViZm11ZGJQcUNoS0gwaENy?=
 =?utf-8?B?YnlXM0lydmVIR004UCtXQWhkQXcyS0FORHhWemcxdGd6TzN6aUNBa25vS0Za?=
 =?utf-8?B?cnZNc1JLVzVkcnJCWWdoSzBmVzRlYmVBaE5pZ0J2dTBNVnU4YWZHZ0JuVUE0?=
 =?utf-8?Q?OnM92fRMoWxgtX1PLsjGA7ch1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4c6953-2473-4fd6-8768-08dbcbf1b943
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 13:38:46.2590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /r86LJg8CcTyrDDkofByKtoOCBRjGow4h7u4za0ZEtEaAy95/O8aCv0aTrksFWvmDVoqF56UP8FRUq5hw159rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8280
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

On 2023/9/27 14:56, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, September 21, 2023 3:55 PM
>>
>>
>> +	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
>> +	    hwpt_type != IOMMU_HWPT_TYPE_VTD_S1)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	if ((hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) == !!parent)
>> +		return ERR_PTR(-EINVAL);
> 
> this is probably too strict. What about intel-iommu driver supports a
> IOMMU_HWPT_TYPE_VTD_S2 later for some tweak w/o nesting?

in that case, this check needs to be updated

> let's make the parent match specific to VTD_S1 type.

ok. how about below?

if ((data_type == IOMMU_HWPT_ALLOC_DATA_VTD_S1) && !parent)

>> +
>> +	if (parent && request_nest_parent)
>> +		return ERR_PTR(-EINVAL);
> 
> this check should be moved to iommufd?
> 

oops, maybe no need, iommufd_hwpt_alloc() has below check.

if (cmd->flags & IOMMU_HWPT_ALLOC_NEST_PARENT &&
     cmd->data_type != IOMMU_HWPT_ALLOC_DATA_NONE)
         return -EINVAL;

-- 
Regards,
Yi Liu
