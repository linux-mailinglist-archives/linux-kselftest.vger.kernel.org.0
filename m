Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8861C7D6601
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Oct 2023 11:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjJYJAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Oct 2023 05:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjJYJAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Oct 2023 05:00:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56735129;
        Wed, 25 Oct 2023 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698224442; x=1729760442;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=82XRNUp31EaNpkcQex2lQtFH0hj5yUMh8++4kX2JWl4=;
  b=hK4CQFmR4nPL4NlyCB4/kQ/JvPGaXmAZrd7HJi9kDivVaTSonfydhDsg
   srOv0ohh8oa2YN56zzUOsPFtanvwy/a/PLWWfq5T/e00TCXAuxugmiGZo
   JZSVfZ+s5/acIdmDZe5XPHm0h9xigBBo8LPob1jtk2mpve3Adypx8XlKu
   QVDZ8gDAza+T6E6l9qtvje3Sf0MzgQLOe+ptySmY30I8qE0RCsbnCox9d
   OuruULuGagiR0F4eWVzRK/dVf2sdFinBlzqhocQ+pHzzd/iQ4g/AbrS9m
   mjkwYDDdgpfRM1JAXKK5PcssUaTGc4bKeB5cGbgksY82bs/IUa/7HFJsp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="372325157"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="372325157"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 02:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="932292448"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="932292448"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 02:00:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 02:00:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 02:00:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 02:00:39 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 02:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKEXj5EHb6fampxt6tZnUd8Bg33t5YAvbBWlfyGlNEq/vVuJa6MCCkhE2TmVlLheOJ9HfteKiaKQm1TFJ9FQ8nznYCp3vd9gkk9RSLJH3Ux6jJNIxVGpSILZVNJZD557213HOnNg/MTbhIV416THA8g56W6OwB5sCBuBpR51ZmHiWnb+q4dVmxJqXlL+/x2Es4H/UMEgr7cFDf+BqFoOr1tAj7Zih8MZ31G2P1yq+lMWQy79f5XudbmYd/1jbuGX+pNe8nUAiBUA7LS2dEWzUdZAUdkBxoHo4hVWT5swi7IKMfX7U6Aqtmh06UpUvmwJE8YRXpWs2zIvZhS7RR0ifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnWIxrcQIj/epeZFHqiQb65jzH0+1CFour3RHhdOfZU=;
 b=FzPKsL13S4ywpG+oti85Sh/DsQ1qZNP/WQj9aVok1deIGC4NhyIXdlAiO23RQpoLPPYTr9NAn17aboOElnLwjCaTBHBx8DHlLWDv4cKHCHbxJrvPQyeBXq6Io/Ep94P8GojFbN4Izs0SrNrrMRqO73DLNoN9OCxeO+dVMmxKqvc6ldNQYMrWbvECvAIqj7AjfEZLD0GMseNo6e4UDRaM2Wpjv+fcSNT73GplF73wFH31BoAiiD9f/sGOG+xGftFy0Of8CxLaA8A+2DJQQZOJa4URrsdNBhyB6sO1x3gjRcqeMlBHJysm2KQ18qNG7eFso+Pf5hLcctSTlvPldirMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB6427.namprd11.prod.outlook.com (2603:10b6:510:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 09:00:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6907.025; Wed, 25 Oct 2023
 09:00:34 +0000
Message-ID: <c1e638f8-594a-4b09-bfe5-924ca68956ba@intel.com>
Date:   Wed, 25 Oct 2023 17:03:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
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
References: <20231024151412.50046-1-yi.l.liu@intel.com>
 <20231024151412.50046-9-yi.l.liu@intel.com>
 <BN9PR11MB52766B032686E89E960426D98CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52766B032686E89E960426D98CDEA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0098.apcprd02.prod.outlook.com
 (2603:1096:4:92::14) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f25887-652a-4b0e-1ad1-08dbd538d8e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKsgvmYunn/o/fLJJaoD67DiuOIMdOeBB0bK0TjELtvyZAaFrVkV9gAUMda8R45CMNVs2nR3dvrkAjN6LJ/43SXTVNopxeEc35qeR8TJ4o9JryCuJ8VS0CVUv6/TWptG2W0m5MYaHxpf5BVap7LTjkGFaR7PhY4UDZ9SOp5aGZGJiaxIsl9nrzKQOu+s+MEDTxRaNlwjmdzgIdXMnssyywZmkvJ722dj5h1GnrwA9XsTKLOiyK0DgPTZZzVLiw50SwXNE9kDNcTNJunYWZEefU1+aGPKLkL7AUEZwmp6c2P6qJwsnp6Uve+gDFlcLN340hrbiVyEXkWyGpSrWRiHPA8vAy44kyQFqoybA3CptamVZ0xbrr9hEoS6wtzD8J4J9eUZZqUcARJgIrjdx8sYfu20FXMqwthfqt/KtYKlfshN84MtS9pZXQS87Pu/uZLgWZcX5SUcnTTd+qpD5e3yntaGqOdb5knVA7Yimsx8JSs2tSn16OZaX8C37ZaiNk4kR6gYhO56gj5m+7Mm336Mk4uMdCq6HUnJt/LdazVEy/2SmqT34bTXI8tuarndlWDVGhq6Zc5V78kd4v6r8KEvVcE6vkGs2HUNVKD7GiE9+l3q7dv9cOfxSI6RdQ02ec3EcA0awdLKBA1u1bv21CezAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(110136005)(478600001)(26005)(6512007)(86362001)(6666004)(6506007)(316002)(54906003)(66946007)(66476007)(66556008)(38100700002)(36756003)(2616005)(7416002)(6486002)(2906002)(4744005)(8936002)(8676002)(4326008)(5660300002)(31686004)(82960400001)(41300700001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm4va2FUcWpYMk5PRjI4VlZNSXVlK3ZiL1NPNlY2c1JIck90bmx4aWRGQkNo?=
 =?utf-8?B?U1M0SXJvYjI5OWxUbVNOa1FxRldLTTR3MUNRelhLcFVPRDNEQ0laa1NldDBW?=
 =?utf-8?B?MFJ5eHEzRHJEalBRcmEvTkVkNnBWd01Lb0hlcFh4NlBxejI2RjlDeXFQRHRl?=
 =?utf-8?B?dWl0QTdnT1ZkaDROb1Y0ckFkNW4yZkpNa2Q2ZGZWcmc5ZGVPUWkydmFxYTlS?=
 =?utf-8?B?VHF5WmN3ZFM5Q3dPcVhQaXM1T0xPUUkzdUwzcVhNUXo5TmRPaXVvSmNxcC9J?=
 =?utf-8?B?U1I4bG16VGg3Wm0wRk42QmRxdjR2aEtQNmo0bGU3anFTK3JrbWl3UndQa1hR?=
 =?utf-8?B?cnlJMUNkTXgzWkpRbmVJOW1hWURWSk1qdXhTTXFtZ2ZVQjRlRm03cDlERWd3?=
 =?utf-8?B?a2tEMzE4TjIwT3dQQmdFSnBheWJNcXJHdmxXaUxSUWtPbWU5aUVLQTFLdGlD?=
 =?utf-8?B?SXhRU0RsNlNCOGJXV0xlTmVVa2dra2xwM1RWMzNMc1h1MDRkVGdjUEJOaGdx?=
 =?utf-8?B?bUVONWdqY2F5cE04TzJ5MStHMTdxbnpIcmFiSkR1djlnM2lUblNGUEd0L1o2?=
 =?utf-8?B?dEZlNk1MZzRlQzRnTWw2eVJiL2VUTUx5Qko3SjRwUTFmVEs1Nkx4cjQxazVG?=
 =?utf-8?B?TE1reGhGNkFYOCtRNm9CZWNtMXVxNXFmWkhWNHVKVGJCelJmdDFZcndlb3BH?=
 =?utf-8?B?cWVDZTlBVVJaTjZWaDJadmZnSUNxa0RidW9XUzNRVHZJVE82YXNuTE1ZMU9S?=
 =?utf-8?B?Q29qYkw3WnJ0RkpoVU0xREJSTkhoMXowbFFqOUpoZW05R2hDTXR6bGdVd2dm?=
 =?utf-8?B?VW1SOG1Uc202eVBKVllISmRZdHlzYldTbFpLWmJGa3RHL2VDb2ZENVhKYktC?=
 =?utf-8?B?RVpCaHhnQWJyNlk4TkFPNWVzcmhQdVIzclZoZmRzbjJkUkx1emM5QmQwS0Zl?=
 =?utf-8?B?QnBxeUIySlh1SHlmUVZwSWF1RzV0RGlsM2dmakRJU3h3NC9LUEZnUnJxZU9B?=
 =?utf-8?B?NU1oOGpEQ2RUNjJVdFEzUCtwYmVoNVdxQ2kxUTByeEhBMlFnVER0MVpaanhO?=
 =?utf-8?B?YmZlVEVxVi9iR2EwcnBydG5ZeTFjNUJXblFJMDEyVUd5VUluWWZrSWI1TEJ2?=
 =?utf-8?B?ejg2UGdzeWlNZG44YjZLdk1PRlI0aTVHQjRjb2xkcXhRYmhtR0ZocCswbFlr?=
 =?utf-8?B?TlRoR2NZMThjeFdINXZvSXFMQWtSdmVRNkZiMExlUHZMQ29NSzdVbVlSM3Rv?=
 =?utf-8?B?a2xoNkgyNS81MUFaYWdRUm5RLzllby8rK2lhL09SRFkrKzZJcjEyMVlPbVpz?=
 =?utf-8?B?MUlPSVZMUVBFbllFUW1ma2tEYy8wa3dyS015anlibVU2RmpMdFYxSnF3SVc2?=
 =?utf-8?B?T1dEYUZrdVNETjl6Mmx1eVZZeDd0alp6cDNYekY3ektTc2Zlem1rUUk3Vzgz?=
 =?utf-8?B?Vlk0TmIrZTdGM3ZmTG1HTTJlT0JOTytWVUd6SGNqUGhob2llZVlyNXA4eHhT?=
 =?utf-8?B?blpXQW12SUtqNjVvZXdhOU05MFZRdmFIejRGVk5IMWN1TGhHQlU3TDZ6bzJJ?=
 =?utf-8?B?cTNMelN4ZzBOVGFIQVBUa0FTd0pUSUpKTWk3UXVxR3YzQlNvbnpGaHhzMFNG?=
 =?utf-8?B?ZnFxTEY0YXBVVHJyVGJDajVXZDZnVS9rbkVXTEVrWDdqcmZlYjhKSitCNkFt?=
 =?utf-8?B?UlBTNDlEVHI1aEFzVk1sbGVtbzY3QXFncEVlc0hLK3AyQWdSR0RwWW9qQnZr?=
 =?utf-8?B?dlZ3a05nR3liK0VwWjRCaFRYNjVMWURmcUo4S0hlajdhWGg4S1BGMjJqcHNO?=
 =?utf-8?B?VU90N1pIZ3JsWm5COVo1TWFyTHplaC9wS3BGMEpxdEdBMHcwcG8wL09GSko5?=
 =?utf-8?B?dW9GVUJ2a3VGaklOY1gzVkFZQ0pnVlBXei9IZE1JNTZyVkF1RkN1eDFBUkI2?=
 =?utf-8?B?cW5TQ05saXNub2VncDhHcnNYZXBYc0JsSHJiMVJTeW9CSmR1ZnJFRUNpcmov?=
 =?utf-8?B?WlYzcE4yREMrU3NLYXNWMWFmU3F3QWFWZEFJdnp6THdPbUhkZzM2dis1QVJt?=
 =?utf-8?B?T1ROTmFOMVNUU1oxR3d1NVVLS1lBaW84Wkdab1AyeTB5akpOU1dWYi9TWGp2?=
 =?utf-8?Q?RjS19UwZdiL6UUVYdFS2Xw/+g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f25887-652a-4b0e-1ad1-08dbd538d8e6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 09:00:33.9812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HwLs/9eao21lbef2jELWr667H/wmophl4exI03XhE3FtKaMgAZcAUZ6B3TijsYWE4zYlWu6eTNbbGkaaReiyUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6427
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 2023/10/25 15:35, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, October 24, 2023 11:14 PM
>>
>> +/**
>> + * enum iommu_hw_info_vtd_flags - Flags for VT-d hw_info
>> + * @IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17: If set, disallow
>> nesting on domains
>> + *                                   with read-only mapping.
> 
> with how it's implemented now the description should be revised to:
> 
> "If set, disallow read-only mappings on a nested_parent domain"

sure.

-- 
Regards,
Yi Liu
