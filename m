Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F2F6E13AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Apr 2023 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDMRkU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Apr 2023 13:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDMRkT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Apr 2023 13:40:19 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FA71998
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Apr 2023 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681407618; x=1712943618;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+s9HMorLjzThTRrFffkQHpA5lICU+W6xwHaCNuJxY1w=;
  b=CNphOt7ovv5F0lXVGSNfm5NAPmMv3T6XScJcL2v2xZbd+JnGMglhw/L0
   OHILud7+bpBICg1hoKy/o6NRs/p8zJU3xXqKJ/oMytvKWYPw2kYKdfIBg
   1cLSNm5TetfovQ7t9q6RRDJGpdl5sCy0S1vjXCXkSZKU+S61sqWQ3vE1p
   02eYcxMb79sOWUW0ZhqQk0yJDTjbLmBTNEau+KSOEJCjSbQ6lsEn+e8JG
   1fZ4yGJcZw/uNZ8sJvpLwZVvCVHhOl8KP9oZdd15g26RcTtRrgwdRE4HH
   aUsomW5ftZKMAHxJPo5f0Ayivmd1iuRo6fK7kJHYQ6zQLfyyYoN39gpzV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="409435769"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="409435769"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 10:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="935690086"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="935690086"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 13 Apr 2023 10:40:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 10:40:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 10:40:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 10:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=haqP3h+W+Ifwf88SANl1dK8YDIPMO4IlpAJZCYfE3Y7OsgUOE3uMCaBAZyftLbFYtjrPlJ13BvAON8LQVZ00Xbpc1K/aJRddjTbyx/rW+aLdpWISHX3DlMAfm8ZrxbUUbQeLiFELGPGgw8z8lEMrJnrAG9/TT1sf55eEuwXryR4N25WxU11kod04TmMU3eiL70bi7IbfFFNbWJaHO1239MOVRTHtWQJI1YFpDCP9isH3/NzIa03nWiki5u8bwIjGQu+FZ+VeWHvlfAaL3onHXqH27NsWJEcDwWvsnna954cuViy1LnRT43DSSmjON4vBXMXlfPElhgNubj4nZsuUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XYk4FqPaveV2DiilJCOW+SEhuH6uEFw8M8XOmcV8XM=;
 b=a5hGe87boavByBA6zQlmZwHrbHTa2AdpwAIBw4xIipzRY72z3GzqGs6ExUREIsbtSk8qeT2C2EfCb6GLIS2LA6z5oo1JPmJlizNQ5caMbowexfsbKBOxiqew+If5sg8t3PCKZLKh7zGDgaYul8/Id6PtI2I9o2DwFvz5qq2hPGFJ6R72sirMJ8I8fYY2q1q8fEzsGmW3Yy54KE7n5bdgd8ags3i3QHMPCLXIw1/aP9aZ1pWXZX5UihblK2Awa5VSMi8H/NMolXrz5/+dBgmcWgybXaebFOH/NlWjfCkUB+JEcsrccszU7FS4tQsixrRSH3WA8bODDb6+tY0B3XBJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CH0PR11MB5409.namprd11.prod.outlook.com (2603:10b6:610:d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 17:40:15 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::4bd:cce2:58ce:cd6b%3]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 17:40:15 +0000
Message-ID: <1cf8fb08-0c5f-c305-379c-48951237a630@intel.com>
Date:   Thu, 13 Apr 2023 10:40:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Subject: Re: resctrl selftest patches
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
References: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
 <71b769fd-6cde-0ccc-ca41-c94d4737b596@linuxfoundation.org>
 <168d8f63-3d42-96e4-e8b1-89f92fb8cf36@intel.com>
 <753f0eae-527d-c909-2b6e-8c59b788d4e2@intel.com>
 <bc4ffec9-293d-0b8e-d92c-27cdb81fb83c@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <bc4ffec9-293d-0b8e-d92c-27cdb81fb83c@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|CH0PR11MB5409:EE_
X-MS-Office365-Filtering-Correlation-Id: 1664be73-df24-4d90-b2ce-08db3c462396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: spx9bTFPIju17SHyjTlBao97IXBg3tw6LZ4FjI0836lkNjqbyXq/6JuziShpqJ4Oz4KDgMZn+g0z87yMLS0zJLapQsZMlYE+D4eSve0BwFHyDK+ZaMGG0yBgvYVdyWCpgn9HiNyLSdRSPAe/2wAzjMykkTMc/4qwSbbQ1etOPK0ldFsWzR5kyrGNlQVwoNyDB8HX3jpurreNIos2sRzztDx4YYaxIGa9Tp9cQQFGC2BC02qsG5TBko0lvR8Od6ZnlBnjSRsNeNb5g5hpKDEKP4dn+6f228vu+gUhqlddvEwn8KxyqVPfg36b4+ccQqo/gv0vdzPeNWBhlq/KNKFj8X2nbIC7gHcmRwHOUmB/0dv/YJaTRGkVohj0yJ8xFAglG0xyZJw7qke95Ity6dkae9Zo5pqaNC7iLZbPRePXu325FDboCE5FP2Kpnn+ddhCGwss7Nu6n//QjRwWidF1k36qfh+ztJ17YodnhUlaCoc9V9eDlT+/8bsODQ95fPkQuF6CzIGiF7XlNZXtlHyMImNiF7anW/ncrVcVxY+CugLBA8ZpM7kIqEMSiI2AvUCdU1aDXCbj07776Hf/TlVQXiEgRgBkYSbJkHhu9EPa8ERJQw1dIRI+yiP7Iev7uhWeEnztxTdW59wqspJxH4f+QHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199021)(31686004)(38100700002)(5660300002)(36756003)(7116003)(2906002)(44832011)(31696002)(316002)(8676002)(8936002)(86362001)(66556008)(41300700001)(66946007)(66476007)(82960400001)(4326008)(3480700007)(2616005)(54906003)(107886003)(6506007)(186003)(478600001)(110136005)(26005)(6512007)(558084003)(53546011)(6486002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEh1OEFqN3Y3YWd1M05lTjB2YWd0a1dxOGFUdHpkSGFnTmYzUFgxbXdFY1I1?=
 =?utf-8?B?M3lvdWZQd0NvcThwNUFocG5MSEQrOGw0N2tqOXhNT3prcTFlaWwyQ0RoRCtM?=
 =?utf-8?B?dGpYNTBCRzZIY1kwT1JHQkRIem82em5iSmJGRDBOUEJWaW1EWTJnN0p6ODQw?=
 =?utf-8?B?cnZXS0s0THRXbU9NbEJOQk9PWXd2Qlc0L2Z5VWlnMWdBZmxwV3lmbi9UK21F?=
 =?utf-8?B?LzZZYXFFWWlLY09uVjAvdGYraW1jakZITzE0Z3RRVExIeUxpemNnWXovWk5p?=
 =?utf-8?B?QzlwOFZIZnZVdnY2WjZWV0d4SVZ4U2tzVHNEbE1YMUJ3NVRxd3ZBdG90MXNS?=
 =?utf-8?B?Mm1JUU9NMzd2cTdnRFhVMVBHQ1lmYVZjK2lHVTRicy9XUlVrWTZpRldya0py?=
 =?utf-8?B?SmxsMDBVYnFzbHRCY0lWZjhTUVduVTRIRUxlVlZkek1CZmo4QVFCNzVrZCtm?=
 =?utf-8?B?ZUl5R2xsbjFJeFlOUjJqSXo0SHhvSGtMYTQ0bVRRUmNrUVBaVzRkdGNOZVBq?=
 =?utf-8?B?bkNjd2hFL3psY2lDM01Kb3FzMzhDQ2ZpaE1lbkl6MFlDdmhiRVZKSDE1NG40?=
 =?utf-8?B?UTVSZ1dzV1RLU0NtSlRvdnE5WE1TeWR6WWI5Q3Qya3dRTThQb1BOY0swTzlU?=
 =?utf-8?B?blV1cE0xbHZ1L09ZTjJtTW1PSU1tdWlTd2xZK0pjMEVkeEdMNzVLZGRvNzVJ?=
 =?utf-8?B?QmJCV1JOVFE0UFlsNmswODNGRnViUjJQZDQzakFMOEJQODdvSFp5T2hoS2ho?=
 =?utf-8?B?MDd4OWVRT2s2MDAvWG9IcFdMTjF6YXdsQktYL284amppejBBUEFZRHdIZCtJ?=
 =?utf-8?B?bDNqZjVCNW1reWUvekRqd1pJTGhwRTg4eHlvcWwxNC9XMEdxN29FcFk2Y2JL?=
 =?utf-8?B?bE9vVWtNdURxUWIxWFZITzJRQzl0U1ZSWUt2SHI4M1JiYkJCLzdPTnE4eFZS?=
 =?utf-8?B?STNjRTRjY1FZV0VmZTFLcjlpU2JWYXh1TWFEN2srUFN5RzBiMXF4Qk1wM0Nz?=
 =?utf-8?B?V3NId3BON0d5MkIxV2Y3YkJ2elRrS2poK3YzOTAvbTBxRUNwNjdRUFFIUU0x?=
 =?utf-8?B?UUJKWWdaMnhWVyswTzVYRExta0tGMDNlVHRWL25Nb1R2YW5qL1NHcVVoTjdp?=
 =?utf-8?B?L1ZTUEExcEErQkFDaXN1QmJQS1dLZytGdFNBeGRhRUI3UWpBWWdKYysrRkJU?=
 =?utf-8?B?bExEYis5M2JiS0hROEJIZlZQRVhUam9nMDlnTEE2TFE1VytueXpoQzZjR0tH?=
 =?utf-8?B?cGh3YU9UL3ZpUDY1S2dxbkVFVit2QUx5SXVrMXFCVzRIZi95ZzJ0KzJZUWhs?=
 =?utf-8?B?bllUU0I4cnYyTUN1NmxFemNxRnZIZ2s5RjNucHNvRXdXMVpmVDM3U3Q3L203?=
 =?utf-8?B?bW85UEhGdDcwdzhWNUJ2S281NFgyeUw2eXNpUmhZdFlqcitLTmEzYm5iMFFC?=
 =?utf-8?B?K3lrOVFFaEtsTEJjdTFyNkMwUWRhVnNpT2RxMlBOZGRWMFpCV29Rek1sWkZv?=
 =?utf-8?B?S2NrUDZna2VsQVQ5Mi9QRTRWcUN2MTZ1YWJ3b0g2eFhneThFdHBIdnIvcXYy?=
 =?utf-8?B?eUtkTFZMc1R5dkxONVRJS0V6VDZLY2xvdjBKNEhmK3VtVWFhTXZNQ212TDk0?=
 =?utf-8?B?RGN5dkdGcHA0cmxXM1R5ejQvdTJ5QVFZTWFFbHYxR0xFaUpjaDdaRTRnRkJo?=
 =?utf-8?B?Yjg5RU5ZODJ4RTRIcjFwTCtxdjUxWVhabWFDQTBsT0llbTM5cVF4YXE5Y29R?=
 =?utf-8?B?b1hwVllVL3VTcjBDM2lDQzZNRUFEQ2swL2xzcGY1WUp1TnNta1FSUGl1QmhK?=
 =?utf-8?B?cTY5UVN6YWVRUkF6ck1PaCtrRW5aWVREeEZoejVWSFV5TU1XREVhSkxhUHlV?=
 =?utf-8?B?K2pNelE5TDVjRXFiU0gzY0FIdGpPQlBScm5pZHo4Y0NySUZtOXZIN2l2dU1p?=
 =?utf-8?B?dVpndEswNEN6VHQrNmVmdm5pVTRNZzdPYjloU2tLbjdoSUxtN3pmcDFDYnBo?=
 =?utf-8?B?Qkl3ZTFkSXVaY0JVSUZaMmtKb21yQlN4RUxQc3BFSnpqZjlZR2JMaUJnei9v?=
 =?utf-8?B?NmV6VjBsMjVlWGhXQXRlZy9UWFF6eC9wTllhT1ZrRGh3RXhJYlM4LzZ2dHZq?=
 =?utf-8?B?TjZwVlF6dWJMdUM5MW9BUXo4L2R3VUJkRDdQREQ0WmNvS0ZHMU04eWYvRldZ?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1664be73-df24-4d90-b2ce-08db3c462396
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 17:40:14.8523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC/LwaKOKKP7xO7+OLOi/Sb6WcIU2bmmsYaB8eobPAiB4VZbuTG3EQLsKh9Q9RLSzqn5gioW3ZKXMmU/TE6+rzTF3uXFxTm4+fnnpu8V5Gc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5409
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/13/2023 10:36 AM, Shuah Khan wrote:
> 
> All 7 patches are now in linux-kselftest next for Linux 6.4-rc1
> 

Thank you very much Shuah.

Reinette
