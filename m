Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5190596043
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 18:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236488AbiHPQ3Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236487AbiHPQ3D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 12:29:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922125FAE9;
        Tue, 16 Aug 2022 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660667334; x=1692203334;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ePV0+H+Wop34mbJvepqashpmtPa738V3cUHCGY9DGYg=;
  b=bo2NQud03YLStD2NON/poV6c+Tj/uDYs527j2VWoFe2YqxjkpcvbJ1DK
   PSkFiRIQ/nYGpbnXtFTDUQ4n0GWySC8EuAd4s4XRpTMYTYCbKgoYgm/xf
   Bkr9jn2EM7gmTAMAbHf3eMqrWkL2UYixW5ywJ2RopmKbWLNCxmjKt+db7
   EIXy25uvkeMM0W5J+Q9OTN3I+hQEpdhtffoBAEeafD1xWGrHdYSXjM9N0
   RB+siXXsebJX95XSAjXnitcKj0E8x/JByJXdDc8giAIlLnLC6uzQke9L5
   JOo0MOMb9n28fl8jXsaflJe2hPkNel4bBa7YXiFJS8zqe0IK2UJ2cotyZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="292264816"
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="292264816"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 09:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,241,1654585200"; 
   d="scan'208";a="934976651"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 09:27:02 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 09:27:01 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 09:27:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 09:27:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 09:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAYvD1C5Fa6c0D0E4QzCdSIE8vfQsBY40U5vt691f94bcgyMykBH3gixNvv/SVgM9E3jgUl1LR3pLtoiiDPRbivePJ5SX2Z4gJRjzqOtdFPB+K12F9CuK6lCe13iZk0ghgzYA1uXaDtFzM543VBUXNMkiPYo6PsR8bZsWEke9DT4wob/j8m9zDf6c+JosF5Yeorv6xO8xBGOdG5YVHRLykb3N1OD/0i1faji2PMMX/pEKUQTsS52AMOJuIlOGZMLJBBFzM+gRheCgDvqDPzXS1P25ViKBBrixjlM75PJj708taxRNoieyGflOkYufRrzdOf2UAyiAK4Or10vlSfC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWBRh6rT19LwNHE8M51KeYwYuWrMDFbyJ4iVkkHNc/Q=;
 b=k7+zq4+w1Hw5xIedIcgRDMA+wCsVg27E9afRnMT97o/XTXQhPz8EAxrcQIoI+6GGpZZUsKcPCsVTeYO3PHdN1IhLWMSFtuWKryX0H2gm6K5XQizjEO3cOQR4yDekaVATnnpHNmWPWDGeW28sCdd6OYVa9pZclFWO+vu2259gPzseqq+8Kv0+dsxRk4K1Xiq9gLSDpdH3OmMOJ4/GibwoZOyneDi18zEJYK5A2QL8lE1pJ1iTqDkUZiKozIaZF8LDe6VHvirfRxGDm/S62v42GCl/EJSPTfqFojQSVWTh0V64glTHjcfMn1yOl321+YAZmNFyUbekum0392o9BaaD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by CY4PR11MB1750.namprd11.prod.outlook.com (2603:10b6:903:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Tue, 16 Aug
 2022 16:26:43 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::1cf8:26d2:e93a:9aad]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::1cf8:26d2:e93a:9aad%8]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 16:26:43 +0000
Message-ID: <6b304bb4-01cc-c88a-7299-19217a7a692b@intel.com>
Date:   Tue, 16 Aug 2022 09:26:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        <linux-sgx@vger.kernel.org>
CC:     Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220815233900.11225-1-jarkko@kernel.org>
 <20220815233900.11225-2-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220815233900.11225-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39c6492e-2cd7-4d6f-3122-08da7fa41b1b
X-MS-TrafficTypeDiagnostic: CY4PR11MB1750:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDy4DO2PVLzHc0cLcF30VK6Nz6t12OQMVyw3SCVuwDGFdd+Ir/VmjBUe+8niAN97e4nstiZU9CpIX9TE5HH5dOBR7gtSOuvqe6QTqbmLDpwxa4n6tnkD6V3Rkqm/+SUpS5PaiHMRUnhxBenKWJX5s1GV88Rnd9ZAVsy4h5qNqga/dtOv4CmJ9Jg8Jb3fHy4fpofEuSzeko3600CLLO4b9+1i8GfSpzybGhiJKiwnAKSt2J3k9dxmgQqEFrvVG6sJVYMcw2x6o1tt0bLaH5tzfVYgxzv+KCnKoctfCsEf8Nv9ZcWttcJR1393GVCDXGsvd2TkZBJ3Gxvi9PwHnLVERPIvLgdrYHBzfLOMEs09xZXQT0xbOoza+EnfRrLILAJZ14ytzvnG0a4sTesmPfXsXX1//U2ZvBNYOSeaiZ3KjJoVJnXC99c8CCik7WhCDWui1SvloVJ3yo7c/1U7IPqATrcqaxdA/FfPqQQTb6kQzZ+AMVDXMBJw05zQsdbJdB0vVaW9aHTlji9aOthPP6cGfl3TQEsE89Y8Od0cnZ9qVVp+g6YZELhrCVt2UwYQbPlOt8Tjx6p6ZFGWbKUuOuWuSFLQ29lLghS204DmS8MF2lx8lJpPyDvKxXfuOMZP0YE8Ij5ByujQgJmH6iOL2EM9VnDQplsriAoZDFNB680OzA5fwO1fJUXTLCEzmD1DhqcVBlRlQ/CoDyPPl78I1kA7MAfzXsovlHySpLjicjC/IEI6hmEFkG8USbVL4dwnqUX/xybxgnWYrNjo7gqv2/DG6A3cYVJFsVT+ECouHak/8bxNYL6xwkwJK9czuSj0pfj5mSiakr874PJ7vJfXyLZfEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(39860400002)(136003)(366004)(26005)(6486002)(478600001)(2906002)(53546011)(6506007)(6512007)(66476007)(8676002)(41300700001)(66556008)(31686004)(82960400001)(31696002)(110136005)(54906003)(316002)(2616005)(36756003)(83380400001)(86362001)(186003)(44832011)(5660300002)(4326008)(8936002)(66946007)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2UxMDMzcDFKQjVyclJmSVk5NkM0NCtsbWpsZDE5Sitxd3VOUmVFa3V2UzFy?=
 =?utf-8?B?Q0dDVVNVTGZtbUkrMWtJVVNWR0laUk1Ucm9ZbDRUMDk4SXl6WlFlZ2NsWkFD?=
 =?utf-8?B?eE51UGdJRnlOM1hSYnViWmhwRjBOQThpeTdGZDBxUVBuSWM3TjBqL0xWalhU?=
 =?utf-8?B?Mmg4S21ySlcvV1NJQjhQQTZjd2hzNFV4STVzRFpJUysyMUM0OTNxdTErTzFR?=
 =?utf-8?B?cE5IbUZaejJZaEc5YUNSR0RzRU9EeU4wbW5FcStZZzQ4ZFdESVBkWHFVdmcr?=
 =?utf-8?B?VDUrblZpTFBKNHhzS1FoMW1pajZLSkNWa2d6cnpFK1pEY0grZFRRNHV6Vmdm?=
 =?utf-8?B?SE90Rjg1aHB3cHQwVGQ5M0hMUEpEVE1UZktlc29KUHIzanBNVzN6QTd2R2xp?=
 =?utf-8?B?bnJsWkV1RWkxVHNCT2lGSlJlVytKemwrWWswbWJrVmV0amJ5VlowYlRoMHpm?=
 =?utf-8?B?ak9lYkN1cTNWekNQSGhoOGVZWk9mdzNYUGNxQ1Z4Vml3amZHRE4rMkU1Vmda?=
 =?utf-8?B?RGxERzB4M1lWWjN2VTFEUUhDczIxV05lNWpCZUJSbmNxSk9oQlRRbnF6UlN6?=
 =?utf-8?B?QXVjZ2FtL1JFeFJLMUVZcmhaaVI1SGhtcjZJTnMwREtZS1JiUjBNN1MwOFNh?=
 =?utf-8?B?M3p4Q25VTlhMVlJmZUxJRTFnN1EvbktUaUp2b1RJQXZoK0xPTXVldTNPQ2tE?=
 =?utf-8?B?NkRiaFdDNEFBR0ZDWDlkT1J4K1hiVzlZWXpBUTRBY0plclFHRnZnSGltaFl6?=
 =?utf-8?B?VVkwTWEyTnEwMHR4ZTFTWkwrQzlod3JpSXZNbjNxcktRM0ExZkVEeVdzeldj?=
 =?utf-8?B?VEpnTzBDOWFQZDlvckoxRkZrYkJZMTgxcmM3bnNuekRwK0R4VjBpMWE5Sk9V?=
 =?utf-8?B?b2FYQ2FtUVVCWUJZdmtEbXMxRG9VNXpiMWlQd0RjRnFGVS8zOUR5N2dPYjZP?=
 =?utf-8?B?QUxUY3dzT0U4TFlQaVlGQzA2cWFMTDhQU0FHaHQ2MVVhVGNWWW5uZlNPYUY1?=
 =?utf-8?B?d0plWVVaUklhRUs4NGVndTVGdFAvV0ZHRnRGMzlodWZjV0ljYTVPZFRBNjQr?=
 =?utf-8?B?VEh3SkJ0T3dOaGlCVGtlMStvb1NFM0xDdmpTZVl3elNOZ2dzMmVCSEowcWR4?=
 =?utf-8?B?NEJ0bFY3ajJpUXRpQ0I1ZmlBR0JYNGdpaEVDWlBsSk0wcVY0WS92bk5RelNj?=
 =?utf-8?B?Y2dwc2VtSFRsTWh4TFRxZkxxVitRQUFDbnZPQjFCZG5XbVZzRHNZYm16L1Fw?=
 =?utf-8?B?MHZ3TkFhc0pzMWRxT0ZXUFVZNVp1NmY3U3JoK1VhK3N0c2dCb1dlbElmdmJh?=
 =?utf-8?B?eG1LemhCdnh3OEo4cFhOdFJtbGJkOVJ4VjcxMlFKY2pzNmUvNkJLRDNqMVBH?=
 =?utf-8?B?QUtXNlpGWGpDV1FOWUd1cVlHOGJRYWluVnlRRWJEZDdrd3dLSSsyM1p0OXZ6?=
 =?utf-8?B?dXh0a1U0elZQWGpuUnltQ01JaC9XOUNGU1dveWhIdXJnTWZDMkV6WmdvSmF5?=
 =?utf-8?B?MmZ1cEMvMDRZeTlieVY4QmxKcElYZTljUjYvTy9FMk5NOHNHQndPcWJIUGZ0?=
 =?utf-8?B?UzlZV3JkWnk2aExnazJBRnNQWm9Ja2xOOTRsNFpBdWZoQUxNRzU3aEw0ZHRs?=
 =?utf-8?B?bnkrU2YySE9ZNG42TnZKdndJZFdJd210bzUwT0Z5N3BDdXcrTW44TzhGRGg2?=
 =?utf-8?B?cjdhMWVuVnJzR3hVanc4dWE0bnhlNHNHMnA5SkR0T0wxcnVKYjN0R3NKWEVS?=
 =?utf-8?B?bDZ6OUtxeGFQTVlvV1ZVcm1yRC9hazFDVy9xNEdOWmtjWmE4VDY3SlhiTUkz?=
 =?utf-8?B?a1BZd0U0MzZkN2Rac1ZSMHpXd04rSkRRY2tFSFBuN3k2Sk1SUDc3dnRPTm1T?=
 =?utf-8?B?aWtKcDNTRXZ4U0ZXSFNYUTNrMmZCd1BvVmE3dENoR0tPYytGcEhaeU12QXda?=
 =?utf-8?B?NXh1V3ljTHViTlJRNDJidXFjNEUyUHIxeWlyN2I4ZFl4V0FiMUtEcWF6SUJm?=
 =?utf-8?B?cnJlNHJ4YjI2K0hxMi9PRFN5OTR2d3hpOVJxWEZjc0d6SkVDZmpid0RLbFg3?=
 =?utf-8?B?SEpsYjdMQlFIVmJETXBIOFNjRjgxbndvckljTTVyUXJQMnlONFBMaksvblJM?=
 =?utf-8?B?dGlKRkZ0TWFlaENRRktpZGhVdGRhVnBwL0tLWFZka2xXTHA2R0NkeTIxQ1V3?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c6492e-2cd7-4d6f-3122-08da7fa41b1b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 16:26:43.5914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nhP4gtLrmQJaSK7PU12uQRYXTVxuENkEcVmeiNautR0dPXJHVw6A/sm5BJhXtm6LGIxbsmivMF5WGLEccaO1NkZB5Vc5VimU7A6LKczPQXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Vijay,

Thank you very much for digging into this. A few comments below.

On 8/15/2022 4:39 PM, Jarkko Sakkinen wrote:
> From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> 
> Add a new test case which is same as augment_via_eaccept but adds a
> larger number of EPC pages to stress test EAUG via EACCEPT.
> 
> Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> I removed Githubisms (hyphens), added missing subsystem tag, and
> cleaned up the commit message a bit.
>  tools/testing/selftests/sgx/load.c      |   5 +-
>  tools/testing/selftests/sgx/main.c      | 120 +++++++++++++++++++++++-
>  tools/testing/selftests/sgx/main.h      |   3 +-
>  tools/testing/selftests/sgx/sigstruct.c |   2 +-
>  4 files changed, 125 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
> index 94bdeac1cf04..7de1b15c90b1 100644
> --- a/tools/testing/selftests/sgx/load.c
> +++ b/tools/testing/selftests/sgx/load.c
> @@ -171,7 +171,8 @@ uint64_t encl_get_entry(struct encl *encl, const char *symbol)
>  	return 0;
>  }
>  
> -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
> +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> +			   unsigned long edmm_size)
>  {
>  	const char device_path[] = "/dev/sgx_enclave";
>  	struct encl_segment *seg;
> @@ -300,7 +301,7 @@ bool encl_load(const char *path, struct encl *encl, unsigned long heap_size)
>  
>  	encl->src_size = encl->segment_tbl[j].offset + encl->segment_tbl[j].size;
>  
> -	for (encl->encl_size = 4096; encl->encl_size < encl->src_size; )
> +	for (encl->encl_size = 4096; encl->encl_size < encl->src_size + edmm_size;)
>  		encl->encl_size <<= 1;
>  

This seems to create the hardcoded 8GB larger enclave for all (SGX1 and SGX2) tests,
not just the test introduced with this commit (and the only user of this extra space).
Is this intended? This can be done without impacting all the other tests.

>  	return true;
> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 9820b3809c69..65e79682f75e 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -25,6 +25,8 @@ static const uint64_t MAGIC = 0x1122334455667788ULL;
>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
>  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
>  
> +static const unsigned long edmm_size = 8589934592; //8G
> +

Could you please elaborate how this constant was chosen? I understand that this test helped
to uncover a bug and it is useful to add to the kernel. When doing so this test will be
run on systems with a variety of SGX memory sizes, could you please elaborate (and add a
snippet) how 8GB is the right value for all systems?

>  /*
>   * Security Information (SECINFO) data structure needed by a few SGX
>   * instructions (eg. ENCLU[EACCEPT] and ENCLU[EMODPE]) holds meta-data
> @@ -183,7 +185,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
>  	unsigned int i;
>  	void *addr;
>  
> -	if (!encl_load("test_encl.elf", encl, heap_size)) {
> +	if (!encl_load("test_encl.elf", encl, heap_size, edmm_size)) {
>  		encl_delete(encl);
>  		TH_LOG("Failed to load the test enclave.");
>  		return false;
> @@ -1210,6 +1212,122 @@ TEST_F(enclave, augment_via_eaccept)
>  	munmap(addr, PAGE_SIZE);
>  }
>  
> +/*
> + * Test for the addition of large number of pages to an initialized enclave via
> + * a pre-emptive run of EACCEPT on page to be added.

/on page to be added/on every page to be added/ ?

> + */
> +#define TIMEOUT_LONG 900 /* seconds */
> +TEST_F_TIMEOUT(enclave, augment_via_eaccept_long, TIMEOUT_LONG)
> +{
> +	struct encl_op_get_from_addr get_addr_op;
> +	struct encl_op_put_to_addr put_addr_op;
> +	struct encl_op_eaccept eaccept_op;
> +	size_t total_size = 0;
> +	void *addr;
> +	unsigned long i;

(reverse fir tree order)

> +
> +	if (!sgx2_supported())
> +		SKIP(return, "SGX2 not supported");
> +
> +	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
> +
> +	memset(&self->run, 0, sizeof(self->run));
> +	self->run.tcs = self->encl.encl_base;
> +
> +	for (i = 0; i < self->encl.nr_segments; i++) {
> +		struct encl_segment *seg = &self->encl.segment_tbl[i];
> +
> +		total_size += seg->size;
> +		TH_LOG("test enclave: total_size = %ld, seg->size = %ld", total_size, seg->size);
> +	}
> +
> +	/*
> +	 * Actual enclave size is expected to be larger than the loaded
> +	 * test enclave since enclave size must be a power of 2 in bytes while
> +	 * test_encl does not consume it all.
> +	 */
> +	EXPECT_LT(total_size + edmm_size, self->encl.encl_size);

Will this test ever fail?

> +
> +	/*
> +	 * mmap() a page at end of existing enclave to be used for dynamic
> +	 * EPC page.

copy&paste line still refers to single page

> +	 *
> +	 * Kernel will allow new mapping using any permissions if it
> +	 * falls into the enclave's address range but not backed
> +	 * by existing enclave pages.
> +	 */
> +	TH_LOG("mmaping pages at end of enclave...");
> +	addr = mmap((void *)self->encl.encl_base + total_size, edmm_size,
> +			PROT_READ | PROT_WRITE | PROT_EXEC, MAP_SHARED | MAP_FIXED,
> +			self->encl.fd, 0);
> +	EXPECT_NE(addr, MAP_FAILED);
> +
> +	self->run.exception_vector = 0;
> +	self->run.exception_error_code = 0;
> +	self->run.exception_addr = 0;
> +
> +	/*
> +	 * Run EACCEPT on new page to trigger the #PF->EAUG->EACCEPT(again
> +	 * without a #PF). All should be transparent to userspace.
> +	 */

copy&paste from single page test referring to one page

> +	TH_LOG("Entering enclave to run EACCEPT for each page of %zd bytes may take a while ...",
> +			edmm_size);
> +	eaccept_op.flags = SGX_SECINFO_R | SGX_SECINFO_W | SGX_SECINFO_REG | SGX_SECINFO_PENDING;
> +	eaccept_op.ret = 0;
> +	eaccept_op.header.type = ENCL_OP_EACCEPT;
> +
> +	for (i = 0; i < edmm_size; i += 4096) {
> +		eaccept_op.epc_addr = (uint64_t)(addr + i);
> +
> +		EXPECT_EQ(ENCL_CALL(&eaccept_op, &self->run, true), 0);
> +		if (self->run.exception_vector == 14 &&
> +			self->run.exception_error_code == 4 &&
> +			self->run.exception_addr == self->encl.encl_base) {
> +			munmap(addr, edmm_size);
> +			SKIP(return, "Kernel does not support adding pages to initialized enclave");
> +		}
> +
> +		EXPECT_EQ(self->run.exception_vector, 0);
> +		EXPECT_EQ(self->run.exception_error_code, 0);
> +		EXPECT_EQ(self->run.exception_addr, 0);
> +		ASSERT_EQ(eaccept_op.ret, 0);
> +		ASSERT_EQ(self->run.function, EEXIT);
> +	}
> +
> +	/*
> +	 * New page should be accessible from within enclave - attempt to
> +	 * write to it.
> +	 */

This portion below was also copied from previous test and by only testing
a write to the first page of the range the purpose is not clear. Could you
please elaborate if the intention is to only test accessibility of the first
page and why that is sufficient?


> +	put_addr_op.value = MAGIC;
> +	put_addr_op.addr = (unsigned long)addr;
> +	put_addr_op.header.type = ENCL_OP_PUT_TO_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&put_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	/*
> +	 * Read memory from newly added page that was just written to,
> +	 * confirming that data previously written (MAGIC) is present.
> +	 */
> +	get_addr_op.value = 0;
> +	get_addr_op.addr = (unsigned long)addr;
> +	get_addr_op.header.type = ENCL_OP_GET_FROM_ADDRESS;
> +
> +	EXPECT_EQ(ENCL_CALL(&get_addr_op, &self->run, true), 0);
> +
> +	EXPECT_EQ(get_addr_op.value, MAGIC);
> +	EXPECT_EEXIT(&self->run);
> +	EXPECT_EQ(self->run.exception_vector, 0);
> +	EXPECT_EQ(self->run.exception_error_code, 0);
> +	EXPECT_EQ(self->run.exception_addr, 0);
> +
> +	munmap(addr, edmm_size);
> +}
> +
>  /*
>   * SGX2 page type modification test in two phases:
>   * Phase 1:
> diff --git a/tools/testing/selftests/sgx/main.h b/tools/testing/selftests/sgx/main.h
> index fc585be97e2f..fe5d39ac0e1e 100644
> --- a/tools/testing/selftests/sgx/main.h
> +++ b/tools/testing/selftests/sgx/main.h
> @@ -35,7 +35,8 @@ extern unsigned char sign_key[];
>  extern unsigned char sign_key_end[];
>  
>  void encl_delete(struct encl *ctx);
> -bool encl_load(const char *path, struct encl *encl, unsigned long heap_size);
> +bool encl_load(const char *path, struct encl *encl, unsigned long heap_size,
> +			   unsigned long edmm_size);
>  bool encl_measure(struct encl *encl);
>  bool encl_build(struct encl *encl);
>  uint64_t encl_get_entry(struct encl *encl, const char *symbol);
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> index 50c5ab1aa6fa..6000cf0e4975 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -343,7 +343,7 @@ bool encl_measure(struct encl *encl)
>  	if (!ctx)
>  		goto err;
>  
> -	if (!mrenclave_ecreate(ctx, encl->src_size))
> +	if (!mrenclave_ecreate(ctx, encl->encl_size))
>  		goto err;
>  
>  	for (i = 0; i < encl->nr_segments; i++) {


Looking at mrenclave_ecreate() the above snippet seems separate from this test and incomplete
since it now obtains encl->encl_size but continues to compute it again internally. Should
this be a separate fix?

Reinette
