Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5CF507C9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 00:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358228AbiDSWhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358226AbiDSWhF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 18:37:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6B72C669;
        Tue, 19 Apr 2022 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650407661; x=1681943661;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rt05lD41NQLJulCNR5DK2Rwct+9l7hvRmvTmNt8S9HI=;
  b=V72WipbfQsOrfxv7zCp1i+pmjKojwGzJNW1Z3I95mUl+yB882NkYWLkX
   evP/k1t9zhTivZGrJLDxVSj3q7m6+k00qEXcKieHeM2lFsDvD3Ci7bM7w
   AtnrXN4VxjJfCMpYJtQofe8GcO0k2qOJ346dx863JwF1ny/AMQhgNBzX3
   FV0yI4QXmNyqAjoAMrmYnkZpFUJy1uFU+4eCEslNN6oLvTCBee8ozqsxe
   Z9NK+odVPPf51CkUQMTKd/OvB0GQnISqnt92sRg1iOuRGLlRmKRG9s1h9
   D0AKIZSh9vVoNxNdItX3ZzCOqfey89rgZXul4E4gBCKjwl5F2Qzgr/6uK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261490506"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="261490506"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 15:34:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="510307284"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 19 Apr 2022 15:34:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 15:34:20 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 15:34:19 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 15:34:19 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 15:34:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQfYT4TrjVKw0nlUBtzl8Rr+IdA/Iqlk3rRfdUnD0vDi3AO2Ap9qEV1RP0AWzHNm4+u9e8L1hutyUQ9n6MPkYwrFweP3JXezBTiDv4aTI0jnRsh2vFbZVpQZvBC6jMDW0R+4IWEfJdPU8qOpQnVLcnH0IBcy1hTeydi3zvBqV5YTYa2mfxNJgfYam3hnXTCm5qC0U7KyKzCF1j3Pj9zYnf92DcdBsX6ItUzZo13fBaJ8R/96mhhcDUL71t/6kE3VwMwj8zj4kI1zJl3+B4X7zXjDdN0azJ9bOITMsgpvp/1x+tDMATzDb0sI2sZUmQfsgGOe+tMsEqZ0yNjJGWMGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a85sBTgzU/A2i86PPjss25r0cGqrE/Usc52EahfBiGo=;
 b=bKtKY3CMXemsSp1hD2sNf2laN6ExIsOsjKocx+qR0FYf3o8bEdPGf8KvDCwOmKTJrABRbvhqNcfGmUle11KXqkeIgbUXF36e5Gkz2/3LzkRH9538H2hpKVH0aDhiA3v1NLRj7WYMN+12AHPzWlCMjzvoL1eOhIW4jylkErIr6ST3f9uXk0csfHeTvU4mzbyWkIkXAOirR1GqsPbDxvyI/whUS4G+aqj4VmL0LQ5kpNCOb/mI1VocDoYOQafm7IBHo/klUPqmsi2O/cklc/ysGtN/+YANZPbFuIZh8THoA3Hr+iDAj+4A6Tv9UMcgVezuSt56UsrZc+wGmmZ99ndnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 22:34:16 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 22:34:16 +0000
Message-ID: <a3ceede0-ebab-6586-dfd5-247c37b976ec@intel.com>
Date:   Tue, 19 Apr 2022 15:34:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: Re: [PATCH V2 1/4] selftests: Provide local define of __cpuid_count()
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>
CC:     <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dave.hansen@linux.intel.com>,
        <sandipan@linux.ibm.com>, <fweimer@redhat.com>,
        <desnesn@linux.vnet.ibm.com>, <mingo@kernel.org>,
        <bauerman@linux.ibm.com>, <mpe@ellerman.id.au>,
        <msuchanek@suse.de>, <linux-mm@kvack.org>,
        <chang.seok.bae@intel.com>, <bp@suse.de>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <luto@kernel.org>,
        <heng.su@intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
 <7c49dbfe5bab04389ed84c516fcbfe31d66df880.1647360971.git.reinette.chatre@intel.com>
 <Ylp1oFenjgxWpM0D@xpf.sh.intel.com>
 <50067c2d-5563-7d8c-f992-5fef787d4d38@intel.com>
 <Yl47IGLggYsFYolo@xpf.sh.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Yl47IGLggYsFYolo@xpf.sh.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8220f024-89e4-4aed-2bbd-08da2254bc5c
X-MS-TrafficTypeDiagnostic: MWHPR11MB1423:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MWHPR11MB142352260B5A0A207496008BF8F29@MWHPR11MB1423.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BpRcekzO0j/AIxoBXyNd2A1BcsZCnx5StrzbX2mmUkw8Dj5F7ogTv9NOiU8qyOCms2eABHOJFnynrLMJXvNjclpDjcHyfuFdCg95lu5BtYD5mMxyAsvpPZbGqpg44BvX41oeV0MO3CQGOC/fBEoX1oYpltXA4dNZh44hWcIv/pRDbY1RhYdPAOZYm/eI1gbZEwEZ4VzeBkAxj4WIHGs0GPrVbHxAJLn9U6MeqFxOUedKOhlJi6rP4lqG8egpTxUDnu1KBUH6fySLfgH08jiKrzxMJ/I8N64ZkcaQG5V+Syt0vpR00ZFQaeWqyONwIMiHjs1wuCX2B58CdR5MoVj21hFeGv+LAtPQRWzzF1OMwaE0vFmCzy/8E8m0g38PeTUTa80E+EkN7xg8yIMalgATAI9Uvr1Czn8NVkVPhVVgguoP9LyO6/wwFPX5Y5rLB6rO9Fl9GBJ9632Fz8QnmDIUjCSYmQQcq2GpRQO56Nbwl+3WrFWJamoEnuU9KCojdv4AEFbDWHNIP6PQBhiMMQlZAyvZUTleR5uk43YpCPQSDLnlv07lZlmTdpdHlc9fY4r6NJM2ocmgct9digvnA8iSvQr6pzC5oa3+HZ4ey5nQSNSSfKjOz/emVuP2Yis1K2O5bE2N48B0lBwRN+ulvkBexF9l2dQtQbr+Zz0741Yt9u04RGkHecM1Kqai3NFayoKl/LOerXIgue5GmNEsxD/vv+U9ObNOCIzJXWT7Wg9Rjo7OvDmcyqD0qewPyVdoXAy2uX9+3VbpUR0FSYgO+e1GD3QjhXQjlgPN8wTBtWj6GrSh3dVxZQ+3t5KNccaGePj1Zq7JE0Z0KvNEMbUQql1+5ZX+ffcx0/3Mpk32e5UH+bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(38100700002)(66556008)(966005)(6486002)(316002)(66476007)(8936002)(31696002)(44832011)(6636002)(8676002)(7416002)(4326008)(2616005)(26005)(53546011)(37006003)(2906002)(5660300002)(6862004)(83380400001)(508600001)(186003)(36756003)(82960400001)(31686004)(6506007)(6512007)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2VsZEE0TUJjYUtWd1BWbHlMUmR5b1UvTUYrUitNWGxnZ1Jza1ErZDFReXZZ?=
 =?utf-8?B?bzYvbDRPVkwzN2FrTVdGSEh6aU94alpwYjVxbExwTDdkQjgwQkJiMkVYTXFM?=
 =?utf-8?B?aW1GMVdDMzkwcDdGYzRtbjVNbEo0VlJseVdVSHcxbDU1c0V4UmtjV2NJT0R6?=
 =?utf-8?B?RWEyV05oNHNYUDlsOCtnRTMvVEpibUR2VUlIdS9tQVFOVmdtYy9uNDFJNFln?=
 =?utf-8?B?NFFGWWowUmVRZ0dlby9OWTdWczR4dXA0cEd4c2pFbEJkMUR4dmdzdEUxRzkz?=
 =?utf-8?B?ZjRhN3hBUlc1Wm9VQWhOOXdlVy9zM1kzeGVrd2ZKMjdTciswQVRVdklzNkt2?=
 =?utf-8?B?VWp5UGRVVWw2SjRTYmVMVkhQSWlORVovWmJ4eXNuSjMrQVgvZEp5MXQ2Tlky?=
 =?utf-8?B?Uk5PRW14RXJuamRtVUlYOFEyb0tPY2FYOTRpNEhxUkdBV0p3YmZBMk9Hc3Ji?=
 =?utf-8?B?ZzlaL0c4SGIrM3hMQ1ZSRUNJZnJvSzJjUC9jQ3ZmeXlYekRISkIyZEE3ZEJB?=
 =?utf-8?B?VFM1b1k4aU15RXIzUW9pYlFkZm5KTHp5WEJQQzU3WWowSzZ5ak01VlBDcTZ4?=
 =?utf-8?B?RVJXRm5oNDE3UmJ1a1V5bWw0cGxrVVQ4UEhpb3JLUy9aSktQRWN4cHh4K0xm?=
 =?utf-8?B?Q09lZ095cGtnaEVWdXFhblBUK1BSMGRCVWk2a3pBQ3QzbXE1SUgvcTJ4clc2?=
 =?utf-8?B?ODJzZ1laNHAwRnlDRDFQSDhNUmR1aWtad1JYV3Y3RmpQVklaemNDOHhNLytV?=
 =?utf-8?B?cmFtNitiYi9md2UwZGVUMTJ2bFIrVnZlWThmazdUaCtKTjZnTWZCb3VhemJ4?=
 =?utf-8?B?b0pFc093NHU2SUtRSStyT2FKdWZpVy9Lc00rOTU0b3RCN3Q4VzJsWWhLS0dk?=
 =?utf-8?B?NmNUZEVXQXZjTk9jRHRnRkgzZTVmSHhnYXVWNmZmSEMycG10cE9HNVBLbDFF?=
 =?utf-8?B?QjJkQmpoZ3ZnSXM0ZEg1bWpqQXJPSkZqVHE2MnhLMU1jUzBuV2ZYakNCR0lt?=
 =?utf-8?B?M3Jmd0JOeUMvVE1ZUlhKSVdTVFJ6dGdkYWRuekN3aWdmdXFwZGxRWmNQWlBh?=
 =?utf-8?B?VGdVNmtER1VKMElqQy9oN0hTU1Q4Z1czZG1vbkt0V0tLYkFmTzlVUzl5cFdN?=
 =?utf-8?B?dHhBMFBmTmFQbjRoU0J3eXEzOEtRajNKU09hVk4zVFkvRTVHcFhJai9jRU8z?=
 =?utf-8?B?Q0l1MGI3a0gwR3B6Q2lVUWFTK05LcXAwNldaRVloRndHaUxaMnJhVktJWi9r?=
 =?utf-8?B?VmdQa2xjQURyZFlnVWNrSEI4WFlER2F6TVloeXJBeHNBb0IyeUlBZlpqcmNr?=
 =?utf-8?B?Ri9FbzJFdjJ2ejgzZHVDazRMeVpxa2JRdVhTd3RScSszVHBUYVBlS2tXTitO?=
 =?utf-8?B?VmlWckVUaHlDUnprZkJ0WFJXS2lmZG1VVnEwS09XRnJZZVFnZVZmK0xxWVZC?=
 =?utf-8?B?TnlZWE94Uy9ib0tsUFVOd1hrcXFHb2FjaHcva2lIZGxiMGU3ZmZ5SlhoTWV6?=
 =?utf-8?B?L1dJTTdMWkZ5aDlMM2R5Q2xSa3F1TGNqOVVMbnpLYUptVmdxalEzazJEL3pL?=
 =?utf-8?B?OTVPeDlJQjgxNWExYi9JV3QyU0ZGZ3RKMjVZSzBUcGpVOWZ6cmp4TkN1bG1m?=
 =?utf-8?B?dERFRUVEOGtqYnY1UWZYcStJRGdxMFJpdFVWUHVUMmJKMEhDR2kvT0lEc0RY?=
 =?utf-8?B?Z0l5YjFiZVF4eUdqeHpIcDFxbjJySHNDa0FWUXltWE5tOExXQU5UNVZPaTlX?=
 =?utf-8?B?cEZ5S1R4TmhhZGRFZ0daR0w0cGx3dWxicXUxRksrNG40Rm5abi80TzcxQm5D?=
 =?utf-8?B?QmZ2TjdSb3NUWUo5K2g3UE51Tmx2UGRyMEoyZThaa1k2OWdTbGZnakg0a295?=
 =?utf-8?B?dktKUGRjeTRkMStQclpCU2VxQ0ZBbHJrRzMxaWtIQk5ZN2pjbXg3ZERpS3RM?=
 =?utf-8?B?NW5CUCt0QnBMSnYwbjJ6T3BadzhZcEJGZXgxOE9kSWUyUHNPRXVkSEoyUWtE?=
 =?utf-8?B?c0ZscWdzTFF5aHRsTTMzcW9yNmlkZkEyZkZ1QVJSYzlwcXlSRDl4OWJHcmd3?=
 =?utf-8?B?OVpoSWg3VUlqbTl2TmN6SlhvMmhnOGZoUjZqbkZzZlhIKzRjV1hKZXNkdXRB?=
 =?utf-8?B?OXJoeVBwZ3QxemtFQTV6bnNaOWIyL0xpR2l6dTRQbUFmYkVDSk9za09RbUFj?=
 =?utf-8?B?ai9rVGs0WUFJYXVzWWJwTUlNYVJlOXNyQlpoN0tBRVJmR3FWUUZWUlJZZ0pR?=
 =?utf-8?B?RUlsT1pTR2lDaUc0YnhWemRYTHhyWU9ReGl2WWl3Um5CNFRvYktreC9ZRHdt?=
 =?utf-8?B?MkxKSVVjY1dSK0U1dXh4U0t4S3o1djA3eVc2NW5sd2ZEMUZSSUVvQmxLQjg5?=
 =?utf-8?Q?NeBowhofsZ1FtjL0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8220f024-89e4-4aed-2bbd-08da2254bc5c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 22:34:16.2863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AyRRMq5iq5B1BppqyNhzeFKkmV0sPnLlvu8uHwIg8PGmG7dveIeDRwboRUIYfrRyA9pO/vY3Pk44spU2uwZ1tbMfKHa36ypqFHvYfWvtNRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1423
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Pengfei,

On 4/18/2022 9:31 PM, Pengfei Xu wrote:
> On 2022-04-18 at 09:04:33 -0700, Reinette Chatre wrote:
>> Hi Pengfei,
>>
>> On 4/16/2022 12:52 AM, Pengfei Xu wrote:
>>> On 2022-03-15 at 09:44:25 -0700, Reinette Chatre wrote:
>>>> Some selftests depend on information provided by the CPUID instruction.
>>>> To support this dependency the selftests implement private wrappers for
>>>> CPUID.
>>>>
>>>> Duplication of the CPUID wrappers should be avoided.
>>>>
>>>> Both gcc and clang/LLVM provide __cpuid_count() macros but neither
>>>> the macro nor its header file are available in all the compiler
>>>> versions that need to be supported by the selftests. __cpuid_count()
>>>> as provided by gcc is available starting with gcc v4.4, so it is
>>>> not available if the latest tests need to be run in all the
>>>> environments required to support kernels v4.9 and v4.14 that
>>>> have the minimal required gcc v3.2.
>>>>
>>>> Provide a centrally defined macro for __cpuid_count() to help
>>>> eliminate the duplicate CPUID wrappers while continuing to
>>>> compile in older environments.
>>>>
>>>> Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
>>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>>> ---
>>>> Note to maintainers:
>>>> - Macro is identical to the one provided by gcc, but not liked by
>>>>   checkpatch.pl with message "Macros with complex values should
>>>>   be enclosed in parentheses". Similar style is used in kernel,
>>>>   for example in arch/x86/kernel/fpu/xstate.h.
>>>>
>>>>  tools/testing/selftests/kselftest.h | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
>>>> index f1180987492c..898d7b2fac6c 100644
>>>> --- a/tools/testing/selftests/kselftest.h
>>>> +++ b/tools/testing/selftests/kselftest.h
>>>> @@ -52,6 +52,21 @@
>>>> + * have __cpuid_count().
>>>> + */
>>>> +#ifndef __cpuid_count
>>>> +#define __cpuid_count(level, count, a, b, c, d)				\
>>>> +	__asm__ __volatile__ ("cpuid\n\t"				\
>>>> +			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>>>> +			      : "0" (level), "2" (count))
>>>> +#endif
>>>    Linux C check tool "scripts/checkpatch.pl" shows an error:
>>> "
>>> ERROR: Macros with complex values should be enclosed in parentheses
>>
>> I encountered this also and that is why this patch contains the "Note to
>> maintainers" above. It is not clear to me whether you considered the note
>> since your response does not acknowledge it.
>>
>   Sorry, I just made a suggestion to fix this problem mentioned by the script.
>   I didn't notice and reply for the note.
> 
>>> ...
>>> +#define __cpuid_count(level, count, a, b, c, d)                        \
>>> +       __asm__ __volatile__ ("cpuid\n\t"                               \
>>> +                             : "=a" (a), "=b" (b), "=c" (c), "=d" (d)  \
>>> +                             : "0" (level), "2" (count))
>>> "
>>> Googling:
>>> https://www.google.com/search?q=Macros+with+complex+values+should+be+enclosed+in+parentheses&rlz=1C1GCEB_enUS884US884&oq=Macros+with+complex+values+should+be+enclosed+in+parentheses&aqs=chrome.0.69i59j0i5i30l2.313j0j7&sourceid=chrome&ie=UTF-8
>>> -> https://stackoverflow.com/questions/8142280/why-do-we-need-parentheses-around-block-macro
>>
>> More information available in
>> https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html#Statement-Exprs
>> but from what I understand it does not apply to this macro. Even so, I do
>> not know what checkpatch.pl uses to determine that this is a "Macro with
>> complex values".
>>
>   Checked checkpatch.pl and it seems to suggest using ({ }) for any asm macro
>   definition.
> 
>>>
>>> Could we fix it as follow, shall we?
>>> "
>>> #ifndef __cpuid_count
>>> #define __cpuid_count(level, count, a, b, c, d) ({			\
>>> 	__asm__ __volatile__ ("cpuid\n\t"				\
>>> 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
>>> 			      : "0" (level), "2" (count))		\
>>> })
>>> #endif
>>> "
>>
>> Sure, I can do so.
>>
>   I just made a suggestion to fix the problem reported by the checkpatch.pl.
>   But I didn't think deeply enough before: I'm not sure is there any real
>   improvment or help after the fix.

In this case I would prefer to not implicitly follow the checkpatch.pl without
understanding what the concern is.

The goal of this change is to make the __cpuid_count() macro available
within kselftest and it does so by duplicating gcc's __cpuid_count() macro.

The macro style is not unique and you would, for example, encounter the same
checkpatch.pl complaint if you run:
./scripts/checkpatch.pl -f arch/x86/kernel/fpu/xstate.h

Reinette
