Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92F37CD3E2
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 08:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjJRGKS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 02:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJRGKR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 02:10:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC244106;
        Tue, 17 Oct 2023 23:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697609414; x=1729145414;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wwOVio2e2HuyVNcj3ljbEBJQ4bRlusOO+VH8XB0Rm+g=;
  b=Mp4PR9u2mBnK0ud1+Ik0uMY0ClBKqaIOPQLZdeVRicXFGvAfJyP/WwTX
   b8XIMQubRK5cHGaI97MU307aOQVmGtdF8BiROo6t1GteDqfK3OOqKAeYO
   L7t3QbIxU1+zzHlG4L6Y6ho5c82ojqMAvui+o5OQqii6DSSfkTBKaTLWX
   Zfq34HGnmfoXqcrV94HI2B5UpENnZEJ8H+IkV9+nyzqd4S3YgXOGZ8T3P
   Q/0VFamGnZGSpGVan1ZDUOfWKCvLfVrVT8Op689YxhfPhcS5C3B3gBjvP
   bx/ZvHer+FeVyn8fXFe4hbKSCIPMxqasRpPe8pVTIQt6gquhkJUbui1D2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="452418670"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="452418670"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 23:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706304202"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="706304202"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2023 23:10:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 23:10:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 23:10:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 23:10:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 23:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cb6VCIxtG7nQ14uc714LIe/jZU4/uyFWLR6Rg07rKLRfmRDhHVZD5OZnpIiD2WZ+655v8pmS2373rZjrhSyZRMslO3ZKKqCki+YMzlBZLERP37qda0VAM2X8vyQp0+KUvV/JD54KlXuPZ5YJFykEZuNjexn3FPH3meWl3JMpz6H/o63+sY/Zfi1Gd91pKawcWgoptfeb/i+OGJutSZjjtr+J9cQZ9Ev2EN2R+ajaSZX+kEq98WRQUl2KEO93SKMhPcqLnnfHzUtt2XIAKQuU55H7WwwLSi6a4jRF9c2W88bM+kQllykWH49mCl4cnwB2KSWNXBmluArm6gYtfRdUdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaiDfdb6K0sj/9AJc+AfBdoSz/Mg+IEOyeoCVTGfx9g=;
 b=a/OJgBoRPdnRzvLgdIfRRVMrzlZv/W5xxtE8uPiTaG++RtV2sW2LbpEo9/t66CDtBpk6oEYb4j1ibW0bCGuD9GHpOIKBZHU2Id0/kJTZaKOEwZ0zl5CScqllbAKcKsPT6jIwMBwcFYUt/Lv0mq9U17mr53R+5VzUusYyTERLHGpi0hpv7ut3707+SWwNq1dAfVB/3rOL3xBrfeziqY8EY9qSy2GDxCVDbIbsQGc11yQIcPRL6N4IcR1zEzdnvZH6IIyANecEUDmgBPop28OJ9MSVuAX2mWmlBwAOwn6s8w9Jg+3N7q5DuZOAElWOFTrU7DcUgzGogoDwXjWl2q7ncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5940.namprd11.prod.outlook.com (2603:10b6:a03:42f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Wed, 18 Oct
 2023 06:09:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 06:09:56 +0000
Message-ID: <4aca68f7-f2ea-76e8-c79c-ab4852e5cb50@intel.com>
Date:   Wed, 18 Oct 2023 14:12:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/17] iommu: Add hwpt_type with user_data for
 domain_alloc_user op
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
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
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-2-yi.l.liu@intel.com>
 <20231010165844.GQ3952@nvidia.com>
 <03ba68e9-33ef-35c1-5720-8f559f94f8a1@intel.com>
 <20231012133917.GL3952@nvidia.com>
 <3659d9a7-d9e9-bb73-daf5-41c765e99c8c@intel.com>
 <20231013140456.GR3952@nvidia.com> <ZSmE6unIukqJ3GKu@Asurada-Nvidia>
 <79f0cab5-39ad-3d98-3896-6e1ba7b8db21@intel.com>
 <20231016115407.GO3952@nvidia.com> <ZS1+VMEo+0bCecui@Asurada-Nvidia>
 <2a86074f-94a9-667d-6e94-c582d49b7588@intel.com>
 <BN9PR11MB527671149ECD3DF3696A39988CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB527671149ECD3DF3696A39988CD6A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0219.apcprd06.prod.outlook.com
 (2603:1096:4:68::27) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 123cbd51-7305-419c-5b30-08dbcfa0d9dd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IToRZUHKzuKP2svCrzaBo1End4Ns7b+IerytxvtRW+7JWe/1MhNPe8gzlc6m39cqVa9jGeI7dNG4/DiDuaeWyqrX9LSaOpSt3FNVVFmVU2IFp9wbv+UHf6dMxlUCCnm/fTMBH37hFAYVdektivJhk6YAxtwajpZID83LUK0V/AoeXzoEcXkP43R+TklBs0K9K9jjBFYbbRJtxZciN+JUd06HyB53l7BYW53Bob1h/ZSWBlhJXCAOP2Cz3YR4BhBNaQ+0HyH/wpG4euXYyllF4YTMM4tQJgAWPd1tENS4rgLBQ8Cv7CQhQdLBd6VafB1oM/xv2q3NjYfVQx274OFPrpWTIlgIKERot3z+83TifppkNBPGcUDOhQYNVjoA31GLeiojtqc9mGFe8qr5rmCzWa+uW/P1FhsHrwBwMc0bhkNw4Smi3aK6OK+axin5g9VA7oGgw+FZxncKlXIFezTWn+CQR5tUGCfFu/746MYIftgDp64YXESKsrZ1HC3KD2M8sAWBHUi0aAC7JUd5xUTQDqUfP7+4MGwxf6ZLSe2djj0hi6jKQYYw5R6RG7KbevgotQqKvstteFGI1IcW+uH13NwIYphpW0e6ZwXGDp0OG2VcTdpNSYCO/nagg3243wjdGLFHLxgg/5eYzbll79jMRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6486002)(83380400001)(478600001)(6506007)(26005)(6666004)(53546011)(82960400001)(2906002)(6512007)(38100700002)(31686004)(110136005)(31696002)(86362001)(7416002)(54906003)(66476007)(66946007)(66556008)(316002)(8676002)(4326008)(2616005)(5660300002)(36756003)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUh2Zm0zWHhhaHRnb1d6SVgzbUZ5WjkrNWN3VDk4blVWWmovZFRnV3U1T3k0?=
 =?utf-8?B?VFBFZlpMdUdBNXNSTEJkMm51czFQUEk5Y2huVHVaRzVRK0lLUFRYeHF0WWNr?=
 =?utf-8?B?QzE5emdLQ2FjQ0QrRXg2TE1XL1Z0YTd4UUpZUXEyVDNDTm05bitlV1RTeitT?=
 =?utf-8?B?d2pJd1dsTFArZ0VYNXBneE5NNVYrNzM5WkZ0NXBkbW5VV3FEcXBGL0xBY2t5?=
 =?utf-8?B?RFlRQ2t3U2lLRElmd294RFBrV1ZsNmpBOEZrRlkzUFIrNXZtUGdYZytycm1Y?=
 =?utf-8?B?c1ZBYUYyMitKR0JzdWFhUnd1Z3Q3UWlGQ0JENVl6YUVNaC9SaU1JVVN1RWlQ?=
 =?utf-8?B?T3lqRjZjZkk4dW5zU3RqbmtZcGpPRlNqRnRwRVRSbzN5S3ZiTlBRNE5zMVJ4?=
 =?utf-8?B?VDVoaGpGQ0p6TVZFbytqM1MzbFlMZGY0VUZzbE9oc0JkNWZmbXdTc2QvZ3E1?=
 =?utf-8?B?cEc3alVCZHdwTGNmYnorQmg4dk5wSXBQTEtsWVlPZENUZzExRHpVZ0pvMngx?=
 =?utf-8?B?Y3N2LzRPR3E1K0NNWm5ja29oY1YwWEFqdFB1dzAxenRyK3o0UktnakxzWFBT?=
 =?utf-8?B?NktMbGM2LzkvQjJmb2tyUkd2dURJcjI0eVFLbTR2UGpGMXRPbHlnaFNPOXUx?=
 =?utf-8?B?aUQwcTJGMEFXbTZSZjNJaUlEeFFTM0tjRlhlSU1iMncrN3FpenY3ai9NbUNx?=
 =?utf-8?B?b1AySk0xUEtaL3Zrejc2djl6TEFlTUFtbDd5d3BsRTJ3dkNxS3RJd3BqTGZx?=
 =?utf-8?B?cm5sZHJXT0lHYktlM3FXZzI0QWg4MCtNc2NWeS9YeEl1Y3JkbGxOZ1Y0MFhn?=
 =?utf-8?B?Q3R4MDRTYVY4V3NZSEVFQUhaRnYxRnF0N3BqRlVTSHBFMm1KRDR6T1VyYzZu?=
 =?utf-8?B?Uy9aVkttM1JidmRWbnlOWTRkVGNlRUExUzllZ01KZyt1Z280SDlBTUNYOHJs?=
 =?utf-8?B?UFY0eThsb3pzNlpmODRId3dTLzlqVnMzNExtczVwMUl4V2t0V1VoWXNCb2Nz?=
 =?utf-8?B?REZSOG4zR1ZhRDVDR1gwdjViMEdueWo0Q0tFSEdkNXBPd2Uzb3VEbWI1V1ZR?=
 =?utf-8?B?MGFqZ1hRWmZEaHNYNEthZGFzWi9taUI2eVNDQXA4SWNUNXZLMmhuNS9tQ2Rn?=
 =?utf-8?B?R2p0cm45UjkzQTFyMi9Zbk9hbnd4dEtEVWtsdEZZWlZYdTduK3lndFl5cnhI?=
 =?utf-8?B?WEtiWUZvbG9OTXRySEhCQlZaeTNhdGU0UG0zNXBYMWErbHhEMVZveHJZOEVy?=
 =?utf-8?B?T2l2b0oyU0llZVl2Ui85VkpkWHRNWDV6cDl2Z0FUbmNjY0hUZ0c2TnExWURI?=
 =?utf-8?B?WGJPSVZjMTVSRWkrTFQ3V2l3MjVhelBoQStpRzd1dEdHNlNldE9TdEdRNzBl?=
 =?utf-8?B?NDVzb0g5cElnb05EMVI5SVJxd2NzYjZqTXF6UDF1blhkVWxzNzRtczVzQkU5?=
 =?utf-8?B?TkFJTGl2MHR2RGhDeXpSdCtuWTM2Qkl0RDJzVVJRYm1pT1o0TGlLSmp2UUh5?=
 =?utf-8?B?aWpyRkIvVVFyVld4OW1MeTRLYVAwRnlUNEdjMnZzc1RhY1pMUVdscHhCbTVR?=
 =?utf-8?B?eVNJem5ZSjIxMVEwV2Nva3E0L2tkc3pyekhOeFpveHB6d0FQVzNoREZjVDRm?=
 =?utf-8?B?TE5HZlZXWlZsbW9GTmZWNGNrTkRLV3ZOa1A3cXFac01tK1hBYU41NXltZG9B?=
 =?utf-8?B?bk1ybkc3R1NRMTdSSnNxRW1PeUV2ZGlFbWl1RGM3MW45a1A3T0dsWU1vbXBC?=
 =?utf-8?B?Ynd6OHUwYThtQk1vcXFvUUVwY3dsQW5Sd0J3OFVEWDZZbTlLamtwVU1xS1BE?=
 =?utf-8?B?OVljdnJXTjd0cmNIS09vSWVMK1pHYmppWGVMV1l5eFFXY0VCZXhZdXFPbGhL?=
 =?utf-8?B?RnZUcGc1ZXJzUjFIK2RpUDJTYVd3Nk1EekJEeDM0VGx6OWpjM1lZUERES242?=
 =?utf-8?B?b1EvN2hCL0QxM0hlQlJXYXZPZEYyTy9HUURkVHM4OE1wQUtabDNMeFN1Nlli?=
 =?utf-8?B?M1ZXbC8zaUsxZ1AzcXJaWVRqQXE1MXAwbnhyU2tCRVJxNUFodFFIblRoLzhq?=
 =?utf-8?B?azRZNzY0UkVueTJrcC9hbE53dWZDNjMyZnVzQ2lBb0IzMXNNUFdpVHhaR0t3?=
 =?utf-8?Q?sZzL549uX/LUusCTYUX55EXs6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 123cbd51-7305-419c-5b30-08dbcfa0d9dd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:09:56.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nya+xIhoHiqXlUtkoHVEK8o292abrybPt+ucWj7mJR/hBy/Pdd0v6XlQyQMQw5o5iJLOEPNFMAxeCWt+50Umqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5940
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

On 2023/10/17 17:28, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, October 17, 2023 4:52 PM
>>
>> On 2023/10/17 02:17, Nicolin Chen wrote:
>>> On Mon, Oct 16, 2023 at 08:54:07AM -0300, Jason Gunthorpe wrote:
>>>> On Mon, Oct 16, 2023 at 11:28:15AM +0800, Yi Liu wrote:
>>>>> On 2023/10/14 01:56, Nicolin Chen wrote:
>>>>>> On Fri, Oct 13, 2023 at 11:04:56AM -0300, Jason Gunthorpe wrote:
>>>>>>> On Fri, Oct 13, 2023 at 12:33:13PM +0800, Yi Liu wrote:
>>>>>>>
>>>>>>>> not really. Below the users of the struct iommu_user_data in my
>> current
>>>>>>>> iommufd_nesting branch. Only the domain_alloc_user op has type as
>> there
>>>>>>>> can be multiple vendor specific alloc data types. Basically, I'm ok to
>>>>>>>> make the change you suggested, just not sure if it is good to add type
>>>>>>>> as it is only needed by one path.
>>>>>>>
>>>>>>> I don't think we should ever have an opaque data blob without a type
>>>>>>> tag..
>>>>>>
>>>>>> I can add those "missing" data types, and then a driver will be
>>>>>> responsible for sanitizing the type along with the data_len.
>>>>>>
>>>>>> I notice that the enum iommu_hwpt_data_type in the posted patch
>>>>>> is confined to the alloc_user uAPI. Perhaps we should share it
>>>>>> with invalidate too:
>>>>>
>>>>> invalidation path does not need a type field today as the data
>>>>> type is vendor specific, vendor driver should know the data type
>>>>> when calls in.
>>>>
>>>> I'm not keen on that, what if a driver needs another type in the
>>>> future?  You'd want to make the invalidation data format part of the
>>>> domain allocation?
>>>
>>> The invalidation data has hwpt_id so it's tied to a hwpt and its
>>> hwpt->domain. Would it be reasonable to have a different type of
>>> invalidation data for the same type of hwpt?
>>
>> this seems like what Jason asks. A type of hwpt can have two kinds
>> of invalidation data types. Is it really possible?
>>
> 
> e.g. vhost-iommu may want its own vendor-agnostic format from
> previous discussion...

ok. So in future, if there is vendor-agnostic format cache invalidation
data structure, then each existing hwpt types would have two cache
invalidation types. is it?

So it is required to make the invalidation data format part of the
domain allocation. Perhaps we can add it later?

Regards,
Yi Liu

-- 
Regards,
Yi Liu
