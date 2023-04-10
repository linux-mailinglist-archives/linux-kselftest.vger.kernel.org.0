Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE36DC979
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 18:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjDJQng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 12:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDJQnf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 12:43:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BB19B4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681145014; x=1712681014;
  h=message-id:date:from:subject:to:cc:
   content-transfer-encoding:mime-version;
  bh=gUwpu752IJosqxSi11GkOjAfN7LC7f2Wu1f7RbtcVAI=;
  b=JvydYJWhC6Qgu7UWE9ptrH7ytSx7kaDWISRmWmdzzJ78eYulMNL6H9HU
   XNDrQ8XkzgUaky6mN5y+WlVgOJJBKwPz0uH29Lgpca/iG4Vl2T8eIcsBv
   GoirwOGyisDMwvbJLYtWX8VrzAuhsdBlwmSiuY2gVGm1pd02VkY0sEuDC
   HXsn+ZY+Uh6u/cT6vYiQ2RzsxEQlJzpG8Mf1MK29HE8X9tWU0a+KcQvKe
   H8l1VE6x8y1C3i/L7TLzwC2IKIfsxmKsd1bpHkXdGA5v1C0yiTxqhr9tn
   ZsUGCFIELtk9CEf+uHJyTa6RFI/OhKpkxpDFyDwO5B5upeU0zrqjvuJsr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="429684466"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="429684466"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 09:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="688318416"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="688318416"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2023 09:43:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 10 Apr 2023 09:43:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 10 Apr 2023 09:43:28 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 10 Apr 2023 09:43:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU7LSbgfJRJixHwRnkABps23lyTMJUUeWWv/vfkKn8caeeOmI9sJQGMsSECqc7nEgBOh22kg8PgfA20piPil8n97u2wmukY6Ew/YB0yXWYMFTgpQXLtT1ySvzl1BecJicDGAPW3sQCU5yxuy/ThRKNC05LrbXukoeY8A91UFhBNptenQXPswoPr+G/dN52L87f+pwik4FtAHirNy/ff3cTz+mjjNL/4KjTYG2YFRzpTEsFQYqFYhj9oZ9Kd3c/HPFvTjNwyzR51BfIir0fSvYbDukS7uPKlN8R/dw+Mx31qxUkQs4ESPNVMNUutaPAi3pqu/yu/XOYchZtz2UOz2eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLXZdpt8BvznsumhJJgG1wROJZpi/tsl5M5pf+Th7nA=;
 b=MZjk0TXH7oMFvAIBsGvVQJPsmImaXoBEOP0rCcLA25IzM65VbbZvRuDa7OoIZY0Yv72/MYj1efI4iXTS6Q9ZLGNwVjnnF66M9G3Jk0WMuEu4Prt2e/oBtGTgyWE3L42VoHGpSB31Gh5iSkY2EKAQP/AFM3ZU9jBrphoZQE0Chuv+CeE84i4HzKyoElCYQ4uO2Vn4SRaaaCJBNMkQQmMVGz3UYgMcKULMZ793mfAp+Dp+TM2rWhV8TCv2OWb0Smv60TJ+kL4L/Z/I7uRabpH2kfBRHxg0HmOOdlBa6TqAXjJsrH7xumRjHMCCkX2ZvpedFM+k0J1N+M5bq4x/mDbbvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by PH8PR11MB7095.namprd11.prod.outlook.com (2603:10b6:510:215::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 16:43:24 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::d651:ac39:526d:604f%12]) with mapi id 15.20.6277.038; Mon, 10 Apr
 2023 16:43:24 +0000
Message-ID: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
Date:   Mon, 10 Apr 2023 09:43:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.1
Content-Language: en-US
From:   Reinette Chatre <reinette.chatre@intel.com>
Subject: resctrl selftest patches
To:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
CC:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:a03:255::11) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PR11MB1862:EE_|PH8PR11MB7095:EE_
X-MS-Office365-Filtering-Correlation-Id: 9156e521-b9fe-4271-d2b7-08db39e2b391
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 05akzHR90a8/j6Jd4+ctzfKT9bqr0T3ZaJs2CmxXMzFT/z4ovmVHAY8QJFMDHRqleP7szSnmr7NfmVMVhqrQsTddfhkNt2rCuiO+NJvOPtUbF1KIb1ACJuoQeFKdKMjobJJuE70EbsTaKpiNPVXDCojf3+Grqq/H1oIoSCpa6xXsYpPWjAsnljz6yG3B3lDgt7MR/NVDXWmnWdGt/DQRUODSLrk32jwMBxvozqzr/suMTKysKJU5xxUP+emGZROXDejbTT4teOKTOBiwXhsmEcU1+QXNvJ3Y+HTTIEzDSKpeswPKRK+z/RUjWzeuoaQMBcMfRLea97zjfw/abgKjcdEV/CIvQao2q9hCQYkRVcmWFRglKDLyzdwqZrI5N7N7PFZGl3G82ye41poZWE1NWn+GN51u/2bL+Rm89puZm2ATFopjLT83KvwnDBdzV675S1mckrgADswrhBj7pRbiVpPYEldVTKj9L7XRkLgh+/8xrTr/Gha5xA3K2/B+YeKE+ZCi+Pc+Ko7hhZq/ENF8A9oRaa4YNqsBX0ESa/i1456E2bGTA/7J92k87xivi50TnIjicDHnNhO/5YvLx7bWNUYkwvLluWe/6VfODit6Y3gJLPm6Gn2PTeKhuw197ERqq9U0KWuQ5VnBTO5IoNProf3T8kcv+UVQx/7puvNThPNQVBPfTmFhDw43jDt7Dq3R31J2uG3PQBYJ06mbezWaFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(31686004)(6486002)(6666004)(4326008)(66556008)(66476007)(478600001)(54906003)(966005)(41300700001)(316002)(66946007)(110136005)(86362001)(31696002)(36756003)(2616005)(6512007)(6506007)(26005)(107886003)(8936002)(2906002)(5660300002)(8676002)(7116003)(44832011)(82960400001)(38100700002)(186003)(3480700007)(133083001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dy83LzR2WHBxNlhXZnh6d1h2TDNrY1NESmNHZmlla0w2R212MENYS3R3ckZB?=
 =?utf-8?B?cGhCakp4T01YWjRaOUNEM1k1VCs5LzVnR0lQNDBEL1c3VXBmZHRIUE96S29S?=
 =?utf-8?B?cFNGZmdPK3RCUlk0MFBEZ1JxQ0Q0Y0d6akVpR09XQjVWa0crYUNOQm81azMr?=
 =?utf-8?B?RGF0cnl4a0c3VU42TmNWaWxBT3JsY3pCaXZUb2Jqem1GcHM3VERnTVZ4bFNy?=
 =?utf-8?B?d3dINzZZWnk5ZThVcHBvdm95WndtWlBMRG5BditaVmhVc0ZUOVRZTm93ZHZk?=
 =?utf-8?B?UVdqbGRhc3E5eERaMi9pd1k4RlpxbWhPcERDOVRUcmFjSWVqLzZhc29zRWti?=
 =?utf-8?B?aHpWK2szQnV3emlqeno5VDRlRUlKdGt1WVZ6SC9vTGZwaXBaVnJPeU5ocXdZ?=
 =?utf-8?B?Vy9UeXJjNk16ZjJJZWZibjVoMGdLUis0UWQ1UzlNaTRTYkN0VEFSWTVhRW9o?=
 =?utf-8?B?MFhFcmtzYlFwVHZHamF0WEJpQU1BSjh6ODRJa1c3RC9xUjJld0RHbDd6Vzk4?=
 =?utf-8?B?REFZdXh2em5XMVVoM0hiVXhHdGxpOERQMzRMYnFvdGpqMEpUMTFuemQ3QW9D?=
 =?utf-8?B?THpENzU1TVkyTFlhSXpncEVYSG40TElpUkFMTFhxWGVudk9PSDR3VW5kZkh4?=
 =?utf-8?B?dDdNZUwxVlRaQUV5QXd1blNZUXA0dFBoenk2S3BlSVZ2WDArNlpxSmxHUUZJ?=
 =?utf-8?B?YnNUK24wR3VYNVVhTFlmaFBWcWVkcm5Ua3dDQ1lDenJSWUxBbzJQblQvcXJq?=
 =?utf-8?B?TkN5d1Q1bk5PM2ZsSEozRHNIcEUrQVRKb2cvRmt6MDNQWklEUGdjSjZMZTNx?=
 =?utf-8?B?eVI3VS9nNzh3U2hyMjV4ZnZDNld2clB1SUVjZmdQMXRmVzlGL0RmR2FlY0FP?=
 =?utf-8?B?YWFuQ2JRY3MxTDk3RlhOQ3lBeHFCdGFDQzFQSnV5TWZIdTk3TnVXTzFqUVVP?=
 =?utf-8?B?dXBFeFV2YVY1S2ZKcDVGV29iLzZ5ekJ2b0h4YzdUUm1hc09LelQwS2JQQ09D?=
 =?utf-8?B?MVJSSmJFc2VRVkwxdzlTNDB6NHFJZ0dQaDJXQzMrcXp5dG5Cc2pNTnFublBi?=
 =?utf-8?B?VkRlMHNYaDNKRUZGTC80VmV2cnBEWGM5Wkt3VkMrL2tYWXUwYXUzaWNNdThO?=
 =?utf-8?B?dWVIaHdBLzNTdm15czNMMHBNeU5HOXJTTE1HRWtucnhmRDRrYy8yeGMvVG0r?=
 =?utf-8?B?U2owYXpSMnR3UkZQNGNXU2sraVorY3ZIVWl2N1hudWMyT01nR0VsOVRYdkVu?=
 =?utf-8?B?THlpTEdITTQ1eUpQYWRndW4vQWdzZUczNkl2d2t1UVYzanEvL1VVdVlzU3R5?=
 =?utf-8?B?bFNJYytTaEdQNFB6R3FRZ2xZUmpOZVlPbU9QUlhNV2hEeFlRam5yQ1pVczda?=
 =?utf-8?B?V0hqUlNHYWpsU2c3L0QrWm1wWVRYdGZBVXI4NjBadmFLYVovMmdTcjNLaTJ3?=
 =?utf-8?B?b09EZFhqSm1SbDhMeTFrSDlKelFVNWRPQnJqcFNwd3FjYnlKU3QxVFpKcksy?=
 =?utf-8?B?VmVGRlN5a0htT0FhV0RrYkxIUlNza25HWVdsTnQ1Rm0zcmRoc1F5Q2ZSdXFw?=
 =?utf-8?B?MUpka3dSTlUyclVicnFEYXAyTjE0a3E2T0pyc3B3d3g3L0xCR3VoeEczOGxh?=
 =?utf-8?B?clNVcWZObENMa1NKQmhoN2Zlc29MdFN2RjVTVHB2cjZubVEyRFM4bmlnM2Uy?=
 =?utf-8?B?ajJ2a0laK2tleU9xVXpRMDVFSnhLRTJJSW5LbTRmZEI1cllzblFibXpwUFJt?=
 =?utf-8?B?OUt5S3ZtU0NZZWJLb05udGUxZ0l5N0p6RkJWaldiQnJ5QjM0ZlAyVWZsQ2th?=
 =?utf-8?B?MTZtcjFkMklrNHMxTGhHQUt0RjR5M1pGMFViM3dUb1NBS3EwYTBKdm9Bc2ZV?=
 =?utf-8?B?MnVLd0JBRDlqalUxOTErTzFzTHgvaWlQVzRPYXVYcUdwR2ljKzhvWi9MQjls?=
 =?utf-8?B?RDVhemExd2M4NDRpcDBJYWpJZGtNelZqYnlnK2lqNlNLZkpXUHI0YzQvRmlR?=
 =?utf-8?B?Z3ZuMVJhQU9oaVBudjVlZFJUZFdHd0JrNE5wdUxRWWNDSzNKcFlDMWJiRUhk?=
 =?utf-8?B?T0hDeHdUTnprcHBKaFJEM2dlVU92TTNTcEQxUWlwV3EyQlorc1JCa1QxZTNF?=
 =?utf-8?B?bVZUK2VxdERPclNiS25PbmVvUnhPdmhsSnFQdkZvZ290a2tiQTBBbHZyd0Ex?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9156e521-b9fe-4271-d2b7-08db39e2b391
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 16:43:24.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJWBGff9RAmKY4b63h6tI8tTF2KV4vo6Rw4g7Ft5vgHCk0LJcuJiJ4FFwkjNmb0C+7bUuJFC1jAlBJEazzlrCWWt9Z76vaZgQMgng0DuZVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7095
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah and kselftest team,

There are a couple of resctrl selftest patches that are ready for inclusion. They have been percolating on the list for a while without expecting more feedback. All have "Reviewed-by" tags from at least one reviewer. Could you please consider including them into the kselftest repo? There is one minor merge conflict between two of the series for which the snippet below shows resolution.

[PATCH v8 0/6] Some improvements of resctrl selftest
https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/

[PATCH v2 0/9] selftests/resctrl: Fixes to error handling logic and cleanups
https://lore.kernel.org/lkml/20230215130605.31583-1-ilpo.jarvinen@linux.intel.com/

[PATCH] selftests/resctrl: Use correct exit code when tests fail
https://lore.kernel.org/lkml/20230309145757.2280518-1-peternewman@google.com/

The snippet below shows resolution of the merge conflict between the
first and second series:

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 040ca1f9c173..775f9e542ff6 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -98,7 +98,7 @@ static int mbm_setup(int num, ...)
 
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
-		return -1;
+		return END_OF_TESTS;
 
 	/* Set up shemata with 100% allocation on the first run. */
 	if (p->num_of_runs == 0)


Thank you very much.

Reinette
