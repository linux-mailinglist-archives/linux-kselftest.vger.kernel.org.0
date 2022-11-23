Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF86352A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 09:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbiKWIaN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 03:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbiKWIaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 03:30:10 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA8923160;
        Wed, 23 Nov 2022 00:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669192208; x=1700728208;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DjE5/pslN1u524wSHVRPCq4BGpnC8c90AidlOQKvGVw=;
  b=TBLE7iImFqWcJv0gmh5bpzE/Li0lufIGl6poIKlv7HJZNjthkNmGDq/a
   qP0GyCKu+dSAFLYp6ahbed3ho2QWAl4Wcu4Ovfffg0D0AunjlilRT3+we
   tVa27AbiIeywzchZeJWRhKNpwMrdiJyyKd+M7Mj+i+R6ID1Um3CmrYSSE
   QoTOISaEAJBWLUu1Fy/N9kRRe5ifCwVMBG6xbJFrkVzI5mwieK2A8eOiE
   dHdwgvP69FaOXbFL3YJD6rkAcT8PFFZv1rsvKR+QA6Cknvud4LC1W/76Y
   MgawvLUQBIKKiN0nwtVZyD1dugdRoj5dXsYwui2b07y13uLWCLTyCOmC/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="312713374"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="312713374"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 00:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10539"; a="766631962"
X-IronPort-AV: E=Sophos;i="5.96,186,1665471600"; 
   d="scan'208";a="766631962"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 23 Nov 2022 00:30:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:30:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 00:30:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 23 Nov 2022 00:30:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 23 Nov 2022 00:30:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzD7ZSqdIs830JN0XdQ8Y9dK0xKlXXsgM2Sm85WaL5lgnLUIwDAWVmPzAZFqC/btYDpbxl6LmW29pAER+UJqwOx/BOQ/o6HxUbZfXZap89aXSPnICQyWQdSsaLKQIltqCMyWvjrYOsE1ZsZ3hmZhSMeT6DAXhQVREtxLWlWKmOEqJcC0OlaMD5twaIo6PqEYuQEtpe+Y8YTIz3KURTBu2OEtmKsI+ydDZ4fFEZPRkBkXPnBOspRkuDqTeMFtT9ZQ5rkNHjvD0hntZ9aNyho6smoHCxNiTIoKGIHuajeYfKX5AS7QzVsziK22n7ZO0OBxME8XCrw04sfvgz6OIvR1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HTKdX7G3yYq1JHjamVXkOgECqujF4SGrAKrXcFTaAw=;
 b=kVNzgWpShaipoqk4h6oR3YAVtv0FUOinljUSC/G2FlHLSr6mZd9k0ToBcCallWXLyxhSchu1/xHvZlDJL8qBLwHRQWeQWoyZO8eoxCCtwQ5ooA96dWE2TbQZp/b6eDImTiW7hSskYsrYq8crf4X6xHdD8mp8vgiitygKOHiXueUiMDiLWQueojdolb0NYqBtYlmbd8SBmbHu4I2dtv1AhGabL/3+75P1ig2eE89W2VkbCs8y7RT/XLzjVtgSxeKoHBZbQ9h3Bdhf0YTupdN90z4wZ9+YgGiGo0rKtvJvLBccojUldh5GoH08k4ULMMfzEkQkntX4J+9x3SnU0eOUTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 08:29:58 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::61c3:c221:e785:ce13]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::61c3:c221:e785:ce13%6]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:29:57 +0000
Message-ID: <da5dffaf-3e75-9681-8e0d-4b7402b05b1f@intel.com>
Date:   Wed, 23 Nov 2022 16:30:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v5 01/19] iommu: Add IOMMU_CAP_ENFORCE_CACHE_COHERENCY
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        <kvm@vger.kernel.org>, Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
References: <1-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <1-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0160.apcprd04.prod.outlook.com (2603:1096:4::22)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CO1PR11MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: de01f7c7-e584-44cc-3f47-08dacd2ce6f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aq8X53UHIyQKeQVOCMT9vKPHKuEo6OWRqNKqyibUQe0iw8uKAE3oTWULAnYe20oQasrOG40Q1L+w+qjjQAY4e9tUBv66106atxf+OmvceCgNCaUtpWKmp55tHwfiPGT9OxHuJSjPlvdoHjp9PwzqJy7i/aKzUf5BNC58L7Rm/KQaYXI6mY37FOQWcdCSw5Gvy+7/TCDwmDM4a8n1UWG60qJ32DT5c21pONVSDfggze1zwMbJmBWzueCROjSTK3xf4FsbI+6xuFnAzG1Mrwro3YQvGumGLzSfYxgQd8haYFaOK9VxVXRXtpBhNkQSTzyTEpUN3wyGECJE5M2LcOvgnOXHSENheJAyfcqM1nkaUJBRON/VhhG2Af4KThPeGzMlw6BZG00KMrkZTi/DFsfQCpz0PFq6OQRF2LVuvTlUiNF8148dw+CyMGdVuPWn+k/H/H9fiElUdLFd2iJYBZpUdDJojQIgJDNhGgv/dpgaO1BjxjhQEDEAKcXup9VdbaL636E6j7PVMN+PiUrWj+9EvkPcIw38UUrRc2rBDtsqtFpZ7SgjgvoAhOdTEHZq4i+lpITgoSd/99GMzwG5mB1ClRlKR7CJ5hQ0Mt54WB4gVmnJk23XwCMWC/mhCEqf0YGCNsfvmlNnRq41nePfrEdM3E+f6Uv4vAaL4IMxM7/+HfhVTm4cFT19bJ1qQf1auhHRMNXQE3moEN05uqi5l0SNXowJfpibpcA+CZWVzgQsQ406gwomVm2sgA1zGA2ZMqOMDqw9wRR7U8XD7GdD+3dHDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(39860400002)(366004)(376002)(396003)(451199015)(2906002)(31686004)(2616005)(66946007)(53546011)(41300700001)(36756003)(31696002)(86362001)(66556008)(110136005)(921005)(83380400001)(6506007)(54906003)(82960400001)(38100700002)(4326008)(6486002)(8936002)(8676002)(6666004)(5660300002)(66476007)(186003)(6512007)(966005)(45080400002)(7406005)(26005)(7416002)(478600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdVYU9kbTNVNlRZMTMvQnk2OVpLNzB0dmJSRHltVkhmb0ZLSGc3bGpZV1V2?=
 =?utf-8?B?RWNNYkRBb1RZaFF2ajVkcDd4SmpPWkdHaENzbXY1R200RzI3aXRvMXNDRFc3?=
 =?utf-8?B?RktOQmRDYkdBZE9pWVVNK1FmSGNmb0RqREJkbjkwSWdDZWVsOEZCdjh3Ykg5?=
 =?utf-8?B?RkZpdEEzZVgyK1RNcCtIemU1QXNHMnY0ZHF1alBEaGRtdjNPdDNTS0JzRU1C?=
 =?utf-8?B?TDU1MldXdEtRNjNFQURObzJqNVpLMW1PMzc2K1dKcmExZldwTVpYTm40MkVB?=
 =?utf-8?B?RTZZWWxjTDBzcURORGlEd1pXd0pmNXBwUTZCdjAyM0RMeEVrL3NsZm9yclFQ?=
 =?utf-8?B?WjFpcnoxYUdmRjZPTjhYR1pOMSttNnUvd1dUVlNuemNkTGt1by83bGUwcUt5?=
 =?utf-8?B?REpzSmh3NlVoVG9OL1FWeWE4RTlIdkl5MXB0SlJuZHhMblQwUmdlQjhqQVhl?=
 =?utf-8?B?QVkvSUhhMVBZNXBKY2JzR3EvUmJpN3d0K2hxN1JjbkVSb2FHTHJFZHprZEVJ?=
 =?utf-8?B?NWFxODdSSzJ2MDhNYXlUcS8rUFdaOExvSmZWNStDUmx6b09hblFzbTdIUVlW?=
 =?utf-8?B?TzNsbCtzREZ0YWtJVHVkOUFrNm93TnFkVlQ4K0NhV3RSeGQ5TmlCSlVDMUNJ?=
 =?utf-8?B?QUpUS2FhUm9IWndwRm1URXowbGVRekUwOXBoa1JCYTNvM2Q3eG16RDAyYTN6?=
 =?utf-8?B?aUplWGZ4KzA1VGFGWmQ0S2c1a21NNVZIYWxwejJPdG8zc1lJck5nZ2VYRGxC?=
 =?utf-8?B?OExBNHovcWF5cklKcERxM3JFZ0lES1VMaTZNd3AxdDlTTDhtMUowRFY3aDJK?=
 =?utf-8?B?YXZldkp0Wlg4VXgwZGNzQm4wazFpWFZTL25UZ2xlN3N0NkIzdFlubVFHSG9i?=
 =?utf-8?B?UGdSNGF3RFcyVGRFbjVGUC93dERQV1ViSTkwMG8yaW9qZ2U5cjhQbzVOaVBZ?=
 =?utf-8?B?V0J2Z1NLMHZmc01BZm8ycHVOR0p0QzZZYjYwdURSRHlDcFFPTHdDVmNRZnlC?=
 =?utf-8?B?b0ticXl6aC81V3RNUkZQeHZZRkVlVVBROGd6NlpFRnZrRWR3SnhDcWNnOVhs?=
 =?utf-8?B?Qmh2QjhTQi9uWHQyYXJURytpNWZYZk83dmsxWmdsMEhPODBxb3MxNFJRSkhX?=
 =?utf-8?B?aHJrdklCRUNQMU5zSk1VMFV3eEY3VUgzc3pUbkZ2QTU5MGNLbEliWVRzdWt5?=
 =?utf-8?B?bXZObDNoUHVmN3kraTBNRTNrYzVFWVRkYWtVcEJkK3A2cDE1VWo0WWh2WkVl?=
 =?utf-8?B?Ky9UNHhVYkJkV0k5d0xkclVTOCtBYUVKU3c3RlJDZm1DNDU3bFplNFc2MndR?=
 =?utf-8?B?djZURldaVGhwMzZSY2VUMWxRbUM4QlhjdDdSZlA4VXdlRE9zNk1GWlhwUHcy?=
 =?utf-8?B?cDZmYTRMdkFmdkM4cmJaT2U1bkxUb3FnRTlDbkVNYW8wRlpkMEV3amhleVpw?=
 =?utf-8?B?N2tIa1RsR2VoMDRoZ1l5eVAvaVZEWDFWTGczbnJ4cG5WYnpBbm1jS3FDb1JL?=
 =?utf-8?B?V0VMZ29ra05paVByU2lxSmg4bVRpc05ndlAya0xmazl0WEdjY01CQTNZVzFw?=
 =?utf-8?B?b0FHUVFoRC80c1l3RmwyOWU5amEzOXA0R3Z4TDJLT2pXYnFFS21CL0VlT25C?=
 =?utf-8?B?Vy93OCtZZlhSUXFIbmxyOG1JRDJLY2l2bElOaWFEOE9wUm0yZlV0aTZhZ1JR?=
 =?utf-8?B?dnNKN2s1RnI5TnlUZHg2RVh0NU52dGQ4aktPditZdks2NkdaUDVtOEU1d3pw?=
 =?utf-8?B?RTZJenY3amRBbkxIaUxLYkdUVGtPdEM5OXdaMEwxZjZwTmNJVm1MWENPTW45?=
 =?utf-8?B?dUc5MTBpM29Dc2RnT0MzOW1DZUZwWEJWNDVWZDVaMTBoeUJkZDNnblBHczNx?=
 =?utf-8?B?RVU0OWt5VVlQdkxqT0Q1UHhBZkRaZ2NsMUJrcnFSZHdWd2YrUHNSSUF5bXZu?=
 =?utf-8?B?L2NSb25QUXB6a3FSNUZCZmJTWGtNV0ZjbEl3eWtFQWdRRlNrSlNCN1NWckc0?=
 =?utf-8?B?RTRBa0xZR0FEVGNYRkdZdHZ3dEJObEx1dmgwcG5CZXN0ZDFuWTUzVGNFQzFp?=
 =?utf-8?B?WEpacU0wam9Cc0orUzl2N0xXc2ZLOEd2S3ZJMjBMNVJmYU1RKzl5S1RMU1dP?=
 =?utf-8?Q?4H5dsZMIAEyRxuSFDzoz2V9s6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de01f7c7-e584-44cc-3f47-08dacd2ce6f4
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 08:29:57.7115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LJTGtwHYsUi48z/UP1FtNuLnX9XpFjgGxdXBysi8l06gNgDtQAtx5PXbgIuDhlpu3L+1osazq3VD8ceHeX3qiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022/11/17 05:00, Jason Gunthorpe wrote:
> This queries if a domain linked to a device should expect to support
> enforce_cache_coherency() so iommufd can negotiate the rules for when a
> domain should be shared or not.
> 
> For iommufd a device that declares IOMMU_CAP_ENFORCE_CACHE_COHERENCY will
> not be attached to a domain that does not support it.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>

looks like Yu He's test-by was missed. :-) She has given it in below link.

https://lore.kernel.org/kvm/DM6PR11MB268429C4986C7808760CCE72E0049@DM6PR11MB2684.namprd11.prod.outlook.com/

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/amd/iommu.c   |  2 ++
>   drivers/iommu/intel/iommu.c | 16 +++++++++++-----
>   include/linux/iommu.h       |  5 +++++
>   3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 45299eb7e8e306..240c535e317cc7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2278,6 +2278,8 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
>   		return false;
>   	case IOMMU_CAP_PRE_BOOT_PROTECTION:
>   		return amdr_ivrs_remap_support;
> +	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
> +		return true;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f298e51d5aa67a..157c9727411076 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4450,14 +4450,20 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>   
>   static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
>   {
> -	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +
> +	switch (cap) {
> +	case IOMMU_CAP_CACHE_COHERENCY:
>   		return true;
> -	if (cap == IOMMU_CAP_INTR_REMAP)
> +	case IOMMU_CAP_INTR_REMAP:
>   		return irq_remapping_enabled == 1;
> -	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
> +	case IOMMU_CAP_PRE_BOOT_PROTECTION:
>   		return dmar_platform_optin();
> -
> -	return false;
> +	case IOMMU_CAP_ENFORCE_CACHE_COHERENCY:
> +		return ecap_sc_support(info->iommu->ecap);
> +	default:
> +		return false;
> +	}
>   }
>   
>   static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 68d7d304cdb761..a09fd32d8cc273 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -124,6 +124,11 @@ enum iommu_cap {
>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
>   	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
>   					   DMA protection and we should too */
> +	/*
> +	 * Per-device flag indicating if enforce_cache_coherency() will work on
> +	 * this device.
> +	 */
> +	IOMMU_CAP_ENFORCE_CACHE_COHERENCY,
>   };
>   
>   /* These are the possible reserved region types */

-- 
Regards,
Yi Liu
