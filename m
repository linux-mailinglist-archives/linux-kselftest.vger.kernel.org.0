Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BD4626978
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Nov 2022 13:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbiKLMof (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Nov 2022 07:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiKLMod (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Nov 2022 07:44:33 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE391573F;
        Sat, 12 Nov 2022 04:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668257072; x=1699793072;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8wT7y6FdF5XnpvrHtcwIONYfRFLDZeeNv8vlAAkNo1o=;
  b=UTBSxXqTf01CP8MUWSeFd8GeuFr8X/HWIAhAN81A2mwxDVcLC1u0QljZ
   McbBOUK5r4yV46MPI+ziBOD1a2ECB7P6nX9Mv5HCEhSs9hGF+TRGITuDb
   OTVob8m6XCO3JN93fC4Uq6lhkeFg0G5nM3o6A46yHxBNmLA5WN00dXSxm
   +Ze5niYfX58OCsIw6sFYB3yEZ4lLcdox91TSd/oyyIBi+jmMLdJGmR4Se
   dgAl/eB1JMg9SbJqE2PIPbFyxW+Y+F7wzBS1AJkFC0xUooBfSqRHtj9vP
   uMaWDczC8r6mWuOLrZHwLfa/7IOXUP36+upLw62i4mvRJMv4h4wI0/ABt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="375992822"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="375992822"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2022 04:44:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="615727081"
X-IronPort-AV: E=Sophos;i="5.96,159,1665471600"; 
   d="scan'208";a="615727081"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 12 Nov 2022 04:44:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 04:44:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 04:44:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Sat, 12 Nov 2022 04:44:30 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Sat, 12 Nov 2022 04:44:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyeInzL95iTIv4dFKbGcJWqYGIrdEZwYEGPSl7/CD4m50lNpZ04zAZIII2Pa4KC2rTkKL6owD/8zvIxNtAwtRz8670pFuD7SbsDMKpMKzYj0DCIEQwCg/dNI+5UuYbDjdN8WYbuXvs8g8EdGvM9TG6QGt6m553StkndpiHQsJbBilBBVVaLoahfUgapNRQcYSZpo1oXxJO43H4HVfav3qJ7pF6Ttid0V0NNsd6yHrg7xJ/D8Dnne3P7HP4TQd6z3udp2EdJHbPbKFfpwEhbYWsdJzn0IFUJCg61xhUvQUjNH2eLrdvO8kmE/KT11kqipFn/H4yjQMy388tK12jMa2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TVi5DNtO8Hm/Pzr9hawZRLq+GfVatUjFLhl65uCjyU=;
 b=P2MBABK55EKXL3dKhZ7WATZajkQUHvtddldy2fNNPBOWgmRpuMmcEZZeCp07hhyeM8ep1OZ3nC75weyARjRvEadxvmmeD5LE2NMz1tUsF9XpHtXGlol90fn7plKhJFfW0XadZNxOx/FDLtxPsswgIW7xKgqi0vUsuIm6W2bMybRlNETHhiFulxJZHHhGVgG+klPNNFFXu7u1jGhS9bpJRsugIYa0kdWfw13kCo7vf5OzKdbDXnAOIqELqJyaRfvTllAJL5Hly/ryfmqPXrHmrYytETr9zDQ9ZKcVGx3xu7KfkrbsgIyS0r8KeVf0U8MvMEvEjlt/g7mdXNcQMMpkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7644.namprd11.prod.outlook.com (2603:10b6:510:26a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14; Sat, 12 Nov
 2022 12:44:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::ad39:e00a:a7cb:4ada]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::ad39:e00a:a7cb:4ada%7]) with mapi id 15.20.5791.026; Sat, 12 Nov 2022
 12:44:28 +0000
Message-ID: <000cf099-9824-39b8-3719-cf43b33ae1ef@intel.com>
Date:   Sat, 12 Nov 2022 20:44:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 00/17] IOMMUFD Generic interface
Content-Language: en-US
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
CC:     Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        zhukeqian <zhukeqian1@huawei.com>
References: <0-v4-0de2f6c78ed0+9d1-iommufd_jgg@nvidia.com>
 <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <3a20e56423f544dab312bca1bcb56ce4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 19883de2-7469-4e72-3c7e-08dac4aba2b3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5I3lw73/tum0+oXrh0CtwXBM0eBC92vCpRNpIyzMtfZstKfAoCrAK1ytCDAgiEuOsyuO1lK6qYpPK6//8gtX+mdiXFC3IZBtphWTIFbOyd/c2QWtHMeiPoA1G3WoNFGeO/QK9QhMUsNgmsw0pPelAZp9XvIWHm3Fzrv6cDwFBPYJ3/rsEZ6ekljfcEsjaPvfSxls8YeZ4mfKeG8x/6/+75HXbfm59rrhP9C/Ntxz+RJ/hZus+eNn/PkNapy0yrAUCzoaGwXsDehRh+2+3AXtW89Xerg5WATUVjjbFq5kQGNfxxJs6re0hhJp93w7n0TbiRhw2CdmDLUaMrt0z09DfBEqtyUzY1zpksrOR3hkQW+soMyK0QzqT15YjSUYMnxhiXJ8O2+e7p53fNOdjg51/YB+4Zc6yjLwJQ3HXLtH0yByJdtTEgTpHMrDRetSHpUCrilJwjLgKDPl0aUCwh7ZXISYMPiBOpwVXQRYXLTPcTnSbBhy0UDvNXoi1XmTpLKgn6Yh/9usWoPpCi0YA+xILCnNctZq9X5NGzwA1WmY25FdGpZ7p682SSM+LxrgnoS4bhWHzo6fnRWFGV4typRVuZ0+8BCIZQ9CZBjVL2TwaVOLRE9IhCX31KAqUFjW7OHq7Hlvu6UBp2gR8sZDmVNMNCfihG5hq4xQDi7WSd2zeKQsjDOu/DT6mi4k5S6VNTxh7NN7LyjPcOjkIFhXJ+WdsEQfd3xnMabovrfoCg8kF04x/eU5oebIiGwxAw3rQhpuvQp3De8Yq6Vi0qtLld2p+e+2q7X8+XNwesWJsb6XkEZ6HLnNgIGhOmuSQdUa7D26PKb/GZ9y7mA1fZ6pQH7pro9MO87W73aGG9IL9SuVLzMiRV7bJDkSqbpcQScUXBJ5XR+rwVk/YRwnhoY4q+UCTwG0lpVmSSWc3fFajFXOAUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199015)(186003)(83380400001)(2616005)(26005)(6506007)(6512007)(6666004)(82960400001)(53546011)(921005)(86362001)(31696002)(36756003)(38100700002)(316002)(110136005)(54906003)(2906002)(5660300002)(31686004)(66556008)(41300700001)(66476007)(4326008)(66946007)(8676002)(7416002)(8936002)(7406005)(966005)(6486002)(478600001)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V200VGtSMHhGYm51ckNGZUpiM3MxMU91YTJ2SHllTUxlSHhVd091S0RUVDJL?=
 =?utf-8?B?enJ3U3UwVitqbFJaNUZiTjNhbFdMaTRlNDQxY3lESk05TDZLNlUwWE9rNVcw?=
 =?utf-8?B?MGovTDNDYmc3WFR4SXkzcGFyM3BIb0VwaFZyQW1ROGVCMTZvNjhNUGpqSzlI?=
 =?utf-8?B?UlhDYmE0VXB2b3ZaUUtzQWN0T0h3dTExVllKTjY4QUxXUjVBZTFHSmFtZjQz?=
 =?utf-8?B?UmFFaHVVS29xYVRiWm4yMnFiMkY1VDQrZWpJS0tnOXgzTjVCS2RjTVZwYjcw?=
 =?utf-8?B?M3VqdXhmVXlyL2xjMVplM1FEenpoL0U4SjQ2M1hEYTBaZEliQnJCNUIxNGFy?=
 =?utf-8?B?N2h4OW8zeC9iSk42eCsvSTBXV0NES0gyRDBOcnpKMDg1VDViK3JxZi9NcDQ3?=
 =?utf-8?B?K0Y3MmY1WTZuSFh4Q3RXT0NOdXBVVEI2WDl6MUcvRkJ0alNtNklmRU9iM1p1?=
 =?utf-8?B?ZTVNOXhzZlR2a3owQ2NNUE5rem5Vak5hWklVRFM1Q1N2aTZPWG9LZTZXeEk3?=
 =?utf-8?B?bUlTeFJ0ZWhMbnBEMjFkcTJyYmZ4cFE5M3VuSE9sNklqejF1YStNdVdUdHF0?=
 =?utf-8?B?NllwOWd1RnQvRUtxeTFRdWRyL2RIemgwbXcrRHpNUndtcHh0K3VPY1FwNWN4?=
 =?utf-8?B?dHhONForSnFvaUVXdFdWTHIyU3NvR0lzTElSYWRjWXFiK0JGVFhqZjF0QWQ2?=
 =?utf-8?B?YkRLSFR1b2wyMUUxYUtqZUx3MnIrTkJMV2hIeW9GR0YvbllONEdXWG5wc0lV?=
 =?utf-8?B?V1FNYkpYWXhjcmZJSmJqOXo4Y3Q1WkhraE1QMnBzZmVUa2VXR0ZDR2Q0L290?=
 =?utf-8?B?RVA4aEU3aVFTNFo5by9nSDJlRmN6VVFvR0hwMEZUY1ppY3g3cnRVMFRKa3VQ?=
 =?utf-8?B?QTVrSndLaXpsRldEZWZjK2JVdTlVdjlmUFkzMENRRXdTMHU4Y0ZlanNUSmNE?=
 =?utf-8?B?STBpekhHU2owVUhJdTN1L3BGc1hOdGtObWx0dXVtYXd6elF1b1lBaXRZRmkv?=
 =?utf-8?B?eVNiLzUyWW1tNnZoVzRFcXZDajdTVlR3K0JNMzhveUNjRnA5L2VrZUVSRWtu?=
 =?utf-8?B?K2dRNmFtRk0yY21CN3NWem15YU03YjUwWmQydDE4WUk0V0dNRWhxZ1dwbGt4?=
 =?utf-8?B?ejFkNXB0QTNTdmFkaThzSHZxZzlVSk5ubFcvM1FKOTdkUlVoUFkweU5wUjZK?=
 =?utf-8?B?ekg0TzRLMHVYbktQM0NCRnl1UkFoZWZtb0NQTGNQZkRia09qcXNBaXcvRFJj?=
 =?utf-8?B?MEJCVVVoT1V3VGdHZW9wSWJadXFsVHB2VzExbXN2My9zczY5U0hYUnE5VjZN?=
 =?utf-8?B?NTZFcHVJOC9aWlZWWTg5ZlB3YStadXZTcUwvenlpVVIybytkaHF4V0tZQ1pI?=
 =?utf-8?B?ZVZUeWN1MVdSQ2N6MHMxNVAxVTZGbEl4OFlBYVdYVjNGNnJhbGlWL2JZbWR1?=
 =?utf-8?B?TmZFNWgrRlQyYjdmRzNjbWJvdGE2SkxqQ0RNUEpTdGU2STNlN0pkdFdtakNN?=
 =?utf-8?B?THNiVENmUFlXUXo2bmx3WXNKY1dDRU5wZlFLRThYbHIrR2J4RnBSTWEraGRh?=
 =?utf-8?B?OWRvSG45bk05UVhMa2JsR2VlZ2Y5Y2lOWHc1N3BaWVB5Q3ZLdkJHZ2swRnlr?=
 =?utf-8?B?bnE5ZE9tZndVU00zL1hGTHRHclJsYit5NnYrNUNGU0lPOFI0WHZFeHZneFdZ?=
 =?utf-8?B?VFowdHdhUURGSmd4b2gzMzl6dnFocjNkV2ZiYkR5aDR3ZVlLUFdBRS9zOFJS?=
 =?utf-8?B?U2xkWDdsakovcmRNZ29HUUZiTVRQaVZmeUhLN29FSHgrUjFDWnFUbHFCM0wx?=
 =?utf-8?B?eVdXRXlhWXJVT1Z6UzF4Q2Ntc2pjemVXNXpvZEsxbTk0UGVobUVTM05CSTFY?=
 =?utf-8?B?cWJwZ1pHNXMxaUJyemJRT28reEJHaEx5a3ZacHBNTU83ZW94a0JwNnllYTRK?=
 =?utf-8?B?N2RsV08yaWs1SnhEWnAxaERsckhlbzEzQW8yOEp6UE1xaDFocS9RcTd0TGNy?=
 =?utf-8?B?b2d3N0N5bkxkNGltTzJTRTNGTEdXb2Z3MWRuN2UrNU0xRUVvUUpSb0ZwWGNH?=
 =?utf-8?B?MlJwYWQ0U1Mrd3R0b2FBTnhudkIxS3JDYmdzdld1WEJndnlIU1VJRVR0ZFQz?=
 =?utf-8?Q?1ur5xB3ySInwSipqbOHPvI4X2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19883de2-7469-4e72-3c7e-08dac4aba2b3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2022 12:44:27.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgAtXHDenkcgQFGe0DXEQKF+n88w5VUiOVyAVy92kiK+sJN45ankFTDOUlmi8FkDcotqgOxdEOxbTb8XhswqkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7644
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

Hi Shameer,

On 2022/11/11 23:51, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Jason Gunthorpe [mailto:jgg@nvidia.com]
>> Sent: 08 November 2022 00:49
>> To: bpf@vger.kernel.org; Jonathan Corbet <corbet@lwn.net>; David
>> Woodhouse <dwmw2@infradead.org>; iommu@lists.linux.dev; Joerg Roedel
>> <joro@8bytes.org>; Kevin Tian <kevin.tian@intel.com>;
>> linux-doc@vger.kernel.org; linux-kselftest@vger.kernel.org;
>> llvm@lists.linux.dev; Nathan Chancellor <nathan@kernel.org>; Nick
>> Desaulniers <ndesaulniers@google.com>; Miguel Ojeda <ojeda@kernel.org>;
>> Robin Murphy <robin.murphy@arm.com>; Shuah Khan <shuah@kernel.org>;
>> Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>; Tom Rix
>> <trix@redhat.com>; Will Deacon <will@kernel.org>
>> Cc: Alex Williamson <alex.williamson@redhat.com>; Lu Baolu
>> <baolu.lu@linux.intel.com>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
>> Cornelia Huck <cohuck@redhat.com>; Daniel Jordan
>> <daniel.m.jordan@oracle.com>; David Gibson
>> <david@gibson.dropbear.id.au>; Eric Auger <eric.auger@redhat.com>; Eric
>> Farman <farman@linux.ibm.com>; Jason Wang <jasowang@redhat.com>;
>> Jean-Philippe Brucker <jean-philippe@linaro.org>; Joao Martins
>> <joao.m.martins@oracle.com>; kvm@vger.kernel.org; Matthew Rosato
>> <mjrosato@linux.ibm.com>; Michael S. Tsirkin <mst@redhat.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; Niklas Schnelle <schnelle@linux.ibm.com>;
>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>; Yi
>> Liu <yi.l.liu@intel.com>; zhukeqian <zhukeqian1@huawei.com>
>> Subject: [PATCH v4 00/17] IOMMUFD Generic interface
> [...]
>>
>> - Userspace page tables aka 'nested translation' for ARM and Intel iommu
>>    drivers:
>>    https://github.com/nicolinc/iommufd/commits/iommufd_nesting
> 
> Hi Eric/Yi/Nicolin,
> 
> Could you please provide a latest Kernel/Qemu branch for the ARM nesting support?
> The above link points to Yi's git, but not sure which one is latest/stable to
> have a play.

Nicolin and I are working on the new version for nesting support. Below 
kernl branch is our latest progress so far. As the naming, it's still
wip. We also need to workout a Qemu version, so still need some time
before sharing with you.

https://github.com/yiliu1765/iommufd/tree/wip/iommufd-v6.1-rc3-nesting

-- 
Regards,
Yi Liu
