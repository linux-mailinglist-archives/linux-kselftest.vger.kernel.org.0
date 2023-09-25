Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33567AD037
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjIYGfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 02:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjIYGfY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 02:35:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F65A2;
        Sun, 24 Sep 2023 23:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695623716; x=1727159716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ymes/EbanWNAO0iLdzIHL8NlLEmgiepNl34IqH1ytis=;
  b=E7QuO9yoyqiP1B/l+AoKj9Uiki6cq/RWBuE1JALgPvlpOqSoxOoWTDi5
   vJ/1Vhr2B0FSAKu/G7Dw+C9Q/odiUxggBwDIzPCptReyMQiqCmoqnClZR
   T5zlhdTS8rDDKR4Ng53tEUwwHD86gOEEZ0U2C4CMPqL1s7QMMSA+cz2Wa
   EIHMKDMA/Evv8aDjNeNI2q34oxp9HNE3mIy9Q1L6S+L3o75vMcj0HIYMf
   vHFIfv2muC01g97mkS7QNzT/a9lwP9Pu2yo44uaaj29JDBXxJ2enrwQ1e
   vH+05OeWzQmLnw27d5nYIB7LrbaWxk37OCSPF00CZi8n49tL7D9vGa3pa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361431768"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="361431768"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="777553242"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="777553242"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Sep 2023 23:34:47 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 24 Sep 2023 23:34:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 24 Sep 2023 23:34:47 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 24 Sep 2023 23:34:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZEEhfWMd2WZ8SJ8Bw+nJ55ud8Rvj9r71HElpL1STMt8LfkphBiqSVrO348Jh2C+1bW4Keay64Pev0HS7ShK57WZStFamjDo3rnq6c1+eubgurDFnNFssOHG44TXz76wl60poU0cHX2haWnf7+KHmYi5Unho3r6tmfOooHsCf3A+SDYJtD00BV6zWBiArAimaHnPH7tB6wh2te3k1hLteiTcTPcmketzq+rFWJVZQ/DmBQQSXn4zmyT/p+zK1tyMtFym9Bb6p+TBp0skLBNO7R6GQC26I+hK+U0JcYZZ6Kc4/C9thnYOrTJYZFcvK+WsbmmJXfHe5hJMdlmNQamR/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvzdIzjY6dPYyltTXO9/bgEd5c5BRrOuu8l6f6CoxsI=;
 b=Pv+YFtS2r5OxXn6mQDzG+9ikca/8j7ouf+uNjOP7JESKRKkypOI/rzYBUabV5zWVMeLNCHmNJpPMXpVoDm27Vqa6ToM8m7FZvXDRjGlpKlCOPzkbalWXHmoAVv34M19huuj7GjWD+VikCLrbFt6BlK27VbBXV/WkzUMDXOePl2gz9eQHA2i13BOvh6GvG7x0P9caUAFoeTHAS8TttqaMteddUEMOprwemIONmNwKg00sZyvJnuHYw+jxZ7M1bcLEsPJjkzHEJ1hZjEp+sDeNRIOH+H5ohYJVpiB26WYWV4Y2LPL7SSrnqid0Zwxkoqdghi09Pd8v9WZeNnPABlIvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6090.namprd11.prod.outlook.com (2603:10b6:930:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Mon, 25 Sep
 2023 06:34:45 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 06:34:44 +0000
Message-ID: <60384ef3-0176-4ed6-fd05-55e852a38dd1@intel.com>
Date:   Mon, 25 Sep 2023 14:36:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] iommu/vt-d: Add domain_alloc_user op
Content-Language: en-US
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-7-yi.l.liu@intel.com>
 <7aa8fd9e-e43d-db68-bdb6-fe4f891255ca@linux.intel.com>
 <20230920130522.GV13733@nvidia.com>
 <DS0PR11MB7529609BC4574A17ECE469A2C3F9A@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ea19494d-8de6-e907-a735-7f2e5f98f9fb@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ea19494d-8de6-e907-a735-7f2e5f98f9fb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0210.apcprd04.prod.outlook.com
 (2603:1096:4:187::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 063af98d-8d64-4bca-213d-08dbbd9180f8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dq1bMMlA6pqUfmCGt6Q0H4GXArTkuu2wSVzINyRZtEL3E02HP/YpraKgVTFALnPvHGlf3FvmYj0SETCee3xph4TNUMEjVqIMqdbpWzpZdWZcj25QihWHk1JAnvpH0DJrXxYCJPzdlJDY5SSny8j2Gu3aILAIMNT8/s+0zxcNm8bX3aGMFTjGef6VKToKjkVTkzFeYxNLu+DiLwTsx8u39DGlrq990arfnrMOiiWkWBLQzq9cYPc3u66YxQ0V4djSIbg5MtPJk2bifrzJrMA3u55ooV9Qm46PFVMLrNAhD9JyuPPk4qxEumtLgY4IrChCOzw2lpwyl6aiwSBnkq9pOMrtSpol5cbSa6MjSY9jMNqMGEokwC6d99K076MBtVTvDVLzCdnExd9nMmA/Glkg6XZxy3oPSNLiPtw1LQCWr8U2/aQasz5DzPh+jEN4bqlnHnLdLExUwsZ3g1lcehaR4BXUjj/dGetEvmLtW/SqyxL3aI/lGyu17M2MyUEQJyxTe6Ub/+szTQv657hDtQOf4UtQjMlxinLbusb06TbiEqSvALlvqLk4IHaWDw+Q6pViShAkNtA/88oFWIBAHpiMPdY/Z9egJvFhAqYVbFfKu/q+o2jvRemxt3iTfwANtMYrdUfMgm55kNFPaIhPMAhbmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(6506007)(6666004)(6512007)(53546011)(6486002)(36756003)(54906003)(478600001)(5660300002)(8936002)(2616005)(110136005)(66556008)(66946007)(316002)(7416002)(2906002)(26005)(8676002)(4326008)(66476007)(31696002)(41300700001)(4744005)(38100700002)(82960400001)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0svM0kzWUhxYXhtNU1weER3MEZ0cXBKRDdWN1dPSU41VmsyUHVBb2tpL1d3?=
 =?utf-8?B?eUFTWG1LelY3UnNsWVFCaDRKcnZINms1QzlhVnd6b3IzY1IrYlVlTHFpUE5W?=
 =?utf-8?B?WFMxb2p4UGVUT2dML0NWZ0YrNDRnckhSVFZGWGdIV05WZkQxRnF1aGgzUWZo?=
 =?utf-8?B?WmRFSlp6bUFkaHIyZEhHaXNGWGpwQm9RRnM4eS9TQUZFNzM5SlJjWkllREwy?=
 =?utf-8?B?dTlZMGV3WWhYMFhhUVg0Q2U3Vm14SEZIVC83M1VNc1Z0VWtyY1k1ejBTcEl3?=
 =?utf-8?B?T1QyUjBXRUd3NGt4Ym00aVhMRTQ3WlhWMUcwN0J2Mnd0VmNaTXBZOElLMXhI?=
 =?utf-8?B?ZU91cXN3bWhvSnZtNXdCYkNYbTJhaklRQWRrODVKd2RTK00xYkMwSVE0MEJU?=
 =?utf-8?B?TzcwSDZSRk44Uy84WGlFWnRLTnpFdnZkdWZYU043UU1VZFdtSFowT1RnczBU?=
 =?utf-8?B?QmRwc2hQR3haWHlhdnJhZnd4Q1RaMi9DQXBwNmw3Y2ZHZnJ1WHROeFFFclhn?=
 =?utf-8?B?Tksva3ViQ3RYTG1rdkdwbm9sbkUyUDJ1cDkxcWxLZEVITUZEUzEzOFh6YSs3?=
 =?utf-8?B?UVUvZGZ5L0NlYkdkR1dWRlFVOXo0TVBPZjlMNDdwMDh2V0lNb2Q5dFZhWThS?=
 =?utf-8?B?K3R4S0xqUzBQWVBmMzlGa2NzYW5ZdXp6WktHRHR0WmJMZWV6cjJSYnRmOVRU?=
 =?utf-8?B?Tnl3RnU3QXBZZyt3SUNNUmxuN2J1SlkvWlJESWNrTUlrVTlGOVNKT0tzYjJp?=
 =?utf-8?B?RDdHVW5qU1BsajRBdnBXeSt4Vys5WWNIOXFuUHNOMzB3N2ZzSjFtTWZBOHMz?=
 =?utf-8?B?UEtLTEM2bFpRdkc0akpvMzMraTJZNllBZm9JR0FyT1AzeDU3MmFsb0VEamdq?=
 =?utf-8?B?djgyYU1WTFZhQktWcElzOUlqRWs2QmhsekYvWDVudzV4d3puTHpINHBxc2RD?=
 =?utf-8?B?MEhLUC9LSVFPWWdFSkpvdUQ3dkFDL1lwQmtSdVlvdlVQTk5yMDR5ZnZ6OThF?=
 =?utf-8?B?c25NVWRIMU9HT3dRWG1mQUJVQ2xXaFhORGRoOGg1YmhhZ3pCa0NhTm1idmQ0?=
 =?utf-8?B?MnJtQWNkVktMWXRTMC9WcGZERXVITHF5OFVWT2RMV0VZTGJ1VjhPZmdCZUh1?=
 =?utf-8?B?Tk9RamErcWlXSGFHSWR0QmpUbSsyS1J6ZWhuVEM5bUVxaW84NWx1NHR1MjE3?=
 =?utf-8?B?dG9MajR3WGZ3WkRkWWlhT2VJMVl2STl3RW1hU0hTNkpSVm9xWHFQK1VPWjZ2?=
 =?utf-8?B?ZmlPRERLeFpnU2hDZ1d2a0phNXlqZHFmbjR6YVN2VU5iVGh4enBuaHM2SUtO?=
 =?utf-8?B?T1prNkpiN3ZJMUp2MWxNMTBpRlZCUUtGM1dGeWxzZ3I0T3IvdmdQQTRtNlQ3?=
 =?utf-8?B?dUt0aDNqc1FzR244OUJCQnFnRGE1alVzQWhEd1RoaUptVTI0cFg0S0dYd0Fq?=
 =?utf-8?B?eHpjeTdncC8vcnBIamtjYUlVeE5jS0ZoZEk3UWZlRWJLSy9mSS8relJOSFdV?=
 =?utf-8?B?RDdFbVVLUTQ1ek83WnN3QkFkMHQ2KzVJOHJGcUowNXpOdE1BK0pjT1I4Y2Rz?=
 =?utf-8?B?b3NKcVFvdjdxTDNWaDBSdTVIa2srbGxTWDc5dFcrSnM3Skk2SkwrNUVhZDdI?=
 =?utf-8?B?aU5kREF1MWdTakhKWUNmcCtaa2oyeG5JWFpFWmtxMGZtQ3AxQUM1bTZNSUxM?=
 =?utf-8?B?RFp3TmZVclhEbG1Xb2NRZE9NYlFIZWp4eUNzRElrZEFNYVJlZ1h6dk5oMGVN?=
 =?utf-8?B?U1FVMXpWckd3VVdKb2t0bXBrSVYvN242aFlCRVIrYVVOVHV4TzZMM2Vxenpu?=
 =?utf-8?B?akY1ZVM5ZnpqclYva1AxNWRrdFgxYVZNbGtvblAvUDBEa0IvS2ZnODhkUUhK?=
 =?utf-8?B?K1ZicENKdEFZWldPWFBKRFpwUjIyZzNwcXkxdDNTenhwR3FpNDR3MThNRC9Y?=
 =?utf-8?B?cEM4cUY0RlgrajhFbWV4TGdGeFJaQktQMWsrQndOR1oydEtzcExNUXNqbkRh?=
 =?utf-8?B?dGxSVlBpK25hNTE0NWRLV1IwT2lOSUUxR1BuOTNkU2VtWjFWTXNKOTl2SGRD?=
 =?utf-8?B?Y1Mvb3RndFJxWXViWkdKZUNCWVp2Q1pZeStMZnM2MzlubFF3d2pLT1FQV3Zm?=
 =?utf-8?Q?xsHTN9KlCANZ3DYiplOtgSqcU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 063af98d-8d64-4bca-213d-08dbbd9180f8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 06:34:44.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZHcgqchtDDogg2QUHmcBFhtNXm4wYOCGzDtvQSF157Pul+YzgUef+zdR4bhfUDJuJWaQUFIn+qoFsFd8cN9Qkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6090
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/9/21 09:31, Baolu Lu wrote:
> On 9/20/23 9:10 PM, Liu, Yi L wrote:
>>>>> +
>>>>> +    domain = iommu_domain_alloc(dev->bus);
>>>> No need to bounce between core and driver. Just,
>>>>
>>>>     intel_iommu_domain_alloc(IOMMU_DOMAIN_UNMANAGED);
>>>>
>>>> and fully initialize it before return.
>>> If you are going to do that then intel_iommu_domain_alloc() should
>>> fully initialize the domain, not here.
>> I've also considered what Baolu described, but it requires to do some
>> extra initialization which is duplicated with iommu_domain_alloc().
>> So I chose this simple way.
> 
> Okay, got you.
> 
> Once Jason's paging domain and Robin's bus->iommu_ops retirement series
> have landed, the VT-d driver will need some refactoring. Therefore, I'm
> fine with you using a simpler approach here. I'll refactor everything
> later.

yes.

-- 
Regards,
Yi Liu
