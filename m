Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAE15A6BE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 20:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiH3SSP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 14:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3SSO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 14:18:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A2958083;
        Tue, 30 Aug 2022 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661883493; x=1693419493;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3FWdgitCHCzG6+7zq0MwB4Mc+9bVKXzzsnZ/PIVKV6s=;
  b=G6tEsub5LfG1iu79JrwmgIoZtS/SIdg0DXk+IsDuZRFxylNpMMiFHmc0
   eId4tdUUJuXnrftPK7GhaKlrhmE45K6dQFTxKPUEVvISH0egv83C+EAqV
   0eZhfoELbBdTZmSKuXEoEWbkt+ynfC7xnvyGCMBpEI55ZQuN1DxbDxXmr
   Yd1/fFpZLoISCIQVBCd2jPVan+DEPlrvZ5oYnOZDErrheyD/gEjRvFTEc
   N8mRxKN1tnoPeppp0Da3EdpgVqasWabgCbNaytPfsPpUoxdpcd/cgCyeo
   F41X1E7TgdPumKb7fHlaQ0qzcFYLZIvHly7b2NQZEQLQpuJ4NoWyU/K2Y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282238475"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="282238475"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 11:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="614719218"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 30 Aug 2022 11:18:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 11:18:09 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 11:18:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 11:18:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 11:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBgyh2UqgCfhGBOcQlcV2atloBR8Ij6nU8RrfHxTIwRIpfe8Awz1PWr53h/WxJoU1lPOsQ/2aFpA6BytR5lR9ZcW06PDsluibnQHBWV0Zga+ZV+KhfgVORHNUq3yGuZB/ccQ/uCJa2q6qQs/4DHksGLLAedUUd8YpUprcs7F4Tzwj7mRYK/jtH4uFpbEDUB+XSsoJ9GFCwZxOY7MHrc0VN2Ccg72UFAUWV+eaycw56eWGycSsXYrqtRhN0cv5EzsP/N9EzaWmmrg1NR82x6vle0FKbUNxBidmWcKWUTHBqRef05i3xb8jZ3wnBVUBc6IBTY/M45+X1yX92HObOA29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NbZlJ2HXMH7jOWDM5B5BBwyYwYM2Cd7I1/3Lt+QXxs=;
 b=nTLneMlrfM2hobQBBr2zlFKNUl5XP9XEU2GLmiZFlhnF8fRwrPShre0+QC3GP7ERJbV+3+E2qph92V7+8yP1WIv/YoRr/lZOd+NexJOw7t/g8ajMNf1NDB/AprEQfSY6XxRoSYl3zrvwTN82JRtKfeqdWIXDA7acnOel87RsHpWC1jZ53Buef3Gkqe7gU2eZ24VtFF+r30QYS3yBp76DUrJdQHHuSJiXopgYZltM1HtmLcGojGHkO6SQIIxIfwIBPogzW1pprkEuYKiIfTYZtf9pa1GjLKpjLdGv8/F0kzvQfxtQKXtCL3Up2SvmBydk1FygRWXGcoilmECYGVj+5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by BN6PR11MB1619.namprd11.prod.outlook.com (2603:10b6:405:10::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Tue, 30 Aug
 2022 18:18:07 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%11]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 18:18:07 +0000
Message-ID: <1445d3bd-55d6-e2c1-d4f6-b30628759c8c@intel.com>
Date:   Tue, 30 Aug 2022 11:18:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH 3/6] selftests/sgx: Ignore OpenSSL 3.0 deprecated
 functions warning
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-4-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220830031206.13449-4-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0032.prod.exchangelabs.com (2603:10b6:a02:80::45)
 To CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d36cce96-5ad8-415f-a4a5-08da8ab3fc9f
X-MS-TrafficTypeDiagnostic: BN6PR11MB1619:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8rR0FNmkADw8hdS6MdenG9YFl9pmS+EhYQlABVHjRjknYrw8508li2NNew0nbcpFdqICA8Gy1wJuVjdiXsPsHNfhu1wwBzjtD/+8KOdkFZMgoze+3TLHnQtj2RbHaIHlLFOfFPNgkabdogWhJ2U6WAjx0FYvmFo2ckPmxpebEgyYI+t8QlnZNE0cd52muqXpuyRTZf1GwNPjAP4+JPdooS1eevTVT4jIdOn6HxTj0pFzDkZ4ZRbbwCMxJS9s58fulU8nqea8RF4BCsXSf7MxZx1fD0IN1rIRqiEOBbFqOnF8PcN7BCApCuEHnuesjKNbEsw8mRrrW7eF1oHHQH5DWATnK550/N2WJcW4xRc+zoNO3AAMsKUj3GAGePb8GJhEHDR0JIxSMZsZBbBq4/G+Od7Szsoaf2UCeo6We260jrLavPFSLNyZWTaEgQhq2EtnfMvPskVuIUKskno8ZrhHSh5TyKsF4OXb/rz6/Q/I/vcjWqSKvE+Hnb5X/jkz/OYvwKGJ/W8zMipybyLCNX3t5IlOH4/9efTmxPzFcdpzqtZddyd8JNuDAH+Jv8F9n2yjOjfrZS7X65d6kptuiGwG3lB74huBPOFaVL7qPE4HVrDBcN1Y0GClBDw5ZaKPqhZCFj4T11A+Uiwb5zJ2+R/RMngg8+MSQvvf7EJSbkL3KOfZEvyIzQYXyebaYqRJ3sFQDpAKPHLWMlqsNEQJ13iHLY7pW3pDNvlkSKPiuCR5iwleky5S+xJxXs5/AVWBKYQf6kjyzSWW9fxoerIZbHXVFQbQA6YwA1zYnU3Pe1Ke4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(346002)(136003)(376002)(366004)(316002)(31686004)(6506007)(66476007)(6666004)(53546011)(36756003)(6512007)(26005)(66946007)(38100700002)(86362001)(82960400001)(5660300002)(31696002)(66556008)(4744005)(2616005)(8936002)(83380400001)(44832011)(2906002)(186003)(4326008)(41300700001)(54906003)(478600001)(8676002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlYMDdNdlJ0Z3IzOUJ2N2lTWHdVbkg3Y3dJV1A5emF6QzN5R0tLalFZSGRx?=
 =?utf-8?B?K3psUXhHUkE5MVdWRmFvOVRHMUxMODBhaUt4LzQ2a3NJYTNRbWpIS2VBOG5J?=
 =?utf-8?B?ZlE4Y0FFdkJ6MmIvSWxzUmlubk12T1FEMVBFZDhJNVBSTlhkSHB1elFHZjhr?=
 =?utf-8?B?RWRMeXRTZkYzdnE3VjBxaUFvQzRzc1duNlZpWmZMbE1OY29CVHBFemN6RDF2?=
 =?utf-8?B?MDI5ZDd5K1hxSGJweXlCcUdUTnBjU2FOZnRwcklxWExUdE05NDg0K1lrU2E1?=
 =?utf-8?B?YkdaaFRMSFROdzU4ZXBZRzhDWmhYS1V4R3Z2czlFaTUwaS85REl5MVRHS2lB?=
 =?utf-8?B?ci9jblFta0N5V2dIdzlDcENzMmZleXVSMkxBaUloUnh6Mkl1azNMSDBITXJJ?=
 =?utf-8?B?ZDNZenhJV2NYUkRiTkJEaXVIOFBnL3F0ekdlZXUrVzkvWDBVTE5saitGZnNL?=
 =?utf-8?B?ZkZySWpPSmNLM3JvOVFabm1rcmw2NEcwaEdCcGgyZ3lHMUZWVlE2TTg2K0Qr?=
 =?utf-8?B?RGRvRlNtMVFTRlh4dTViYnVvY3FWK05ZM1MraUFRUUI0R0ZjdFN3blBBTCs0?=
 =?utf-8?B?K0IxbTJOTEZQK3NYVDUva1JPYUhKZ09IcDFyTzNQTWk1bHRyR0U4d09SK2ZV?=
 =?utf-8?B?dnZwRjV4aXgzQVFTTHNDbGxxOElhL0FjRGxQNFRSZTJnMFJRZHFhYnJNSXFY?=
 =?utf-8?B?dDErVXE3dkpOa2tUaGhHSEtLditHbHFCSCt5TzJNSlFWaEdDaFRtZFk1c0U1?=
 =?utf-8?B?VTQvZzVxejcyQ0pJYVhDK20yY0NQU2pCNlRVQlVZd2VhNkZVZzZlby83QWNB?=
 =?utf-8?B?ZHZUdC9lR3JDSC9WZDVFbXcwSFM5Y1pLVkVGU2FJL1BpQ0kxK1hxbkxyYXY2?=
 =?utf-8?B?UW1nUHR2NDhnYzNNM3B4bENRUnArMlp1ZUh2aVNmT0UwMHdRNDdyMkdnZWps?=
 =?utf-8?B?OGo1KzJ0Y0tIdk1OS3JnblFsMmFMYTlIUUorZ0Vpd0M3aElkRFVSaWV6T016?=
 =?utf-8?B?V2NQSmI0YUFSM3VCZ3o4SGJXMlV2ODZRaWZqSmlwSGV0ZUVaYmMwYUYxTnpa?=
 =?utf-8?B?STRLZEVCby90SThjdEdQa21wR0xlcnZNKzFtU0hadlBQdVpGd3IxWkF4OVMw?=
 =?utf-8?B?cytObzg3S05wL0puVXcvVFF6clpPaTZJclBRVkVRRCtReVdVaUNoK0Nwa2lP?=
 =?utf-8?B?U0NOVFgwNndrKzVmajIyc3gzejM0L2ttT0NRaTFJSWhBTUJ0NSt0ZUVNK1hX?=
 =?utf-8?B?amJTQU8zdnlqekZpWDYrMm10TEN5ZHRsNUs5VU9LQW42eER2TllDTU00cjY0?=
 =?utf-8?B?SytsUXlaL3dyQ0JxQnhmMWVUQWUreHJWZ3NUMk1weFNUd3hqeW5wVGF5cno1?=
 =?utf-8?B?RXdvZW5DVEFTc0dzWXdxMUNyMC95c0NTeGFpTEhzVmZ3S1NTYTErNng5UGxL?=
 =?utf-8?B?MWNWcE9aS1BRVm1ZUWZ3TWdxb3VROUc2SXBMalBuSTljTzFJZXBncThQaE5y?=
 =?utf-8?B?NzR2dWUwNGNuOXVIblRQYVJ1U3BSOEo5cExrZE4zUFJ4dVNneWlubDFJeXd0?=
 =?utf-8?B?eFpRNnpMd3l5UHlTQWRLM3Q1STJOQnIxQWNENmRzZ1ZZN3NjcjMvZlkyZm45?=
 =?utf-8?B?a2tLbm5HbFczZlQvY1RZWmQybktVYUZBcjEvNXh5Z0YybXozWHpMdjBUMTRF?=
 =?utf-8?B?OEdrZ0Y2Nmd3NStEa0pJYXlaRTkyN2hSTlZveTQ2cHZNb3hrTUJEbUlyNDVo?=
 =?utf-8?B?aExuV2V3Ukp3M0llajl5d0RWWldDd0pYQjZVdGl6bSs2RlgyN0M5bFV5bmxV?=
 =?utf-8?B?cSsyMXhXZHU4bXhBVUZKSWgzOWoxMHlYbmloK0RBTSttMHM0Y0orV05GNy92?=
 =?utf-8?B?QldJOUtQZTZjcmIrRUgySlVSVklvYlRZcFdMZ0tOcWpUbnZBVXVhREZvUE5v?=
 =?utf-8?B?bU1NOFNXMnFVYlA1MmJjV05jY3lBZzQ1U213T1pDdXVaLzNQNDZTN3hxbDJj?=
 =?utf-8?B?T0xTeXpWT2RZc0ZRSjcrdEQ3TWFEdjR3KzI2elhlSDVBYVo5MU1PQ3U0T2hW?=
 =?utf-8?B?STQ0czZaUEk1b1c1V2VQd0ZWYmxnMDRKcmxQK3lLaVp2RFBGOUxQWmovUzZ1?=
 =?utf-8?B?Qm42dytpbzV6YkxZZDBuZGIwc0JlaTRLUUpZY1dQYVlvK0ZGYjErZ1J0UnRl?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d36cce96-5ad8-415f-a4a5-08da8ab3fc9f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 18:18:07.0164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9mcWCvp6J4iybNSSdjuqIvPsxKyvAf3BWqIgRtrO+e1ylyimxFftBn9DwC3u6taw3z+Cm5Tf7E42dxWrcLyi4YnfTP7xquF5FncrV9Wgfk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1619
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko,

On 8/29/2022 8:12 PM, Jarkko Sakkinen wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> 
> OpenSSL 3.0 deprecates some of the functions used in the SGX
> selftests, causing build errors on new distros. For now ignore
> the warnings until support for the functions is no longer
> available and mark FIXME so that it can be clear this should
> be removed at some point.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

This one can be dropped from this series. The fix already made it
into v6.0-rc3 via selftest.

Reinette
