Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A045B298F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 00:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiIHWoi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 18:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIHWog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 18:44:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389201705C;
        Thu,  8 Sep 2022 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662677075; x=1694213075;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0kzJSnB3Je1KbIoZ7FOwGvJNgIA9lA4gdyltavflnEE=;
  b=CO9ey2C+C48QgfKh3PuLHinM+gg4KS2l57zVYrvbpeR4oWT3/OxDeP5+
   QdR1U4t9rKI/STih7Hp3d/CT3qMD6mEX8LeafOs0VVM8yrE42DexGbNUY
   qTLHo76/v+Dzv3/CnyxkoeGb6FdasF64//GrDzO/jiF0EBmXqb+XAnqL/
   C4seziGzvYu2w7OcbsQ1qah+1EXtbl1uOBqXFOlgxzGWDK1II8vcfcybA
   0y4aFCREmCm5ewuW+bOPdRFSDhzU9rHwyqsY0kizo67xmb+AXtJvwMuPB
   U5xp/mmpSpLtPJgILekoOeAd4DxqPvhYmDUMhXvjPN5A0qiiWKLkNuMNe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="323543287"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="323543287"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 15:44:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="592379016"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 08 Sep 2022 15:44:34 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:44:33 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:44:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 15:44:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 15:44:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS6bRKzRuOHVpOo424N+wN55i0TfEHJfiqwcP9pDk/JcRm0jVYB8RQ5T/XastcNSjV+1qho8WnSPqNgaHlubkJVhVUjF5cdq24Ldj2NnyCkk+Xvm6BqOX8+4gWpwCSEexzyBHIhxcG0D/Iqtg1KrCAfq5gIDSzsTurQPjwuz/8h3FHF8qY9gU6/MwDATTXIGD2bo52zgcH5xNVSECy8y5sRRoc3ogb05LkGZTnnQtr+mF6G0sTiHeyBnUzRrSGnOxeSdoCspyNkwl0N5D+bFwGpy9VujH5XkQd/ere+oR+sllADor6hx9rECfy2X/AXkbf6AF1tSErBp4KKjD7yweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7p67DJve8yR7GIKUKJOjijtnv6ZAJEr7C1VtOKts8Nk=;
 b=Rn0nmQbc4eK2vAiocYZGweDp5UI6YbTPnEy85XKPJbjZaiSPMJAnU722aP2pusb+325ccQa6v+gXOxmg1Jr4HwGR5xj9EfQlX4LB+wOYlSWiLBSmbrdll0XzIcD3O60gqczoHn0910/wVGnT2NWiA7XQyVhC8SHVDtA2W13ZjQw3rIXjmC3u7zzsMPQEtm6OAcVZLS4RQ9CIEjb1bTSgKTHOKDyzG1vS09c6oCREJr1DkNGw4TwhHQ/znl9pfitN5DTga5uElX09mcS2dkgJQ4BOhYV7jM/Xrx6HFgbn13e8PkWrHDLvOPkoaaXsdkMDkQuHeZR9JKyxQS08H4wb3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY4PR11MB1862.namprd11.prod.outlook.com (2603:10b6:903:124::18)
 by DM6PR11MB4075.namprd11.prod.outlook.com (2603:10b6:5:198::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 22:44:31 +0000
Received: from CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743]) by CY4PR11MB1862.namprd11.prod.outlook.com
 ([fe80::a824:112:52f7:5743%12]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 22:44:31 +0000
Message-ID: <ecd03fbb-8019-07ae-e27d-44b1dd20bfb1@intel.com>
Date:   Thu, 8 Sep 2022 15:44:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.1
Subject: Re: [PATCH v2 5/5] selftests/sgx: Add SGX selftest
 augment_via_eaccept_long
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, <linux-sgx@vger.kernel.org>
CC:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shuah Khan" <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220905020411.17290-1-jarkko@kernel.org>
 <20220905020411.17290-6-jarkko@kernel.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220905020411.17290-6-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::24) To CY4PR11MB1862.namprd11.prod.outlook.com
 (2603:10b6:903:124::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 162b33eb-4609-4abc-21fb-08da91ebb1d8
X-MS-TrafficTypeDiagnostic: DM6PR11MB4075:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHCkeYLFnc2qvcLLqI+DBTxMqFK7OsKrPRlyPjvdA9djlDBA5g23FUVqwf6J/0HQWHjBcvD03tydDjmnsGVGNgpFszPXljfJ1eHZUlU7RXC9TFGVOaqnF0g/MMOaY6exLMuzhlKUgDaDVTyeGRFOKAj5tTq2DapiSWoSziTalsdEDCLv3PNsRIqsqnaRoCCwxrabevPdIEI8nWVjNMS1E3Chm/Z9gnPC+ems6WVVERpkH2vOhZYHCHODQDTry8ArhkTQnAASW58IO1l2GctNGheHukiM+d2SV8gb6r6vboiF9vUVG8UJ6vZgHy+XgMHykAv1Mm3LejiPaBH95oT3vHdnH3N/9fM9ev2O8dXZ5q4KEoILgqX0xNZcrdOqEMlQB435644qe4XYxzqYXeonWY3TU6n+OztwNl04qmjO5uCEDbOQdNUCGwXL5Z2NGDfBbBcdFvABcb4Sg+/aoo8mGpnchQV/6LP0BXM+mWvMdHn+0ecGLBoJdylUnzrvx2DNi4ONIe9WJL2AeFaFypBis87doNXHXoux5HekoftJZojre9UmPwLrdsWrk87RbHpe5fR5i5znB/UAiHBZT3MBRM/C+CGavO62IzD3jwpxmJAdXlZyQ4gS53mY941K2qqAZ3BiMwP/uaHzpHN1FFQo7QRQdmgexIEB9Zbb+WPg/NZLMy0R+75kCGu9MIiPnKajfMnOo+YleOKVdnrzSama+7D9PgUG6X5GnPyFu3jkRAvO7cZakl0zgXiPInXde2AXdf+X15u8zZVGcWaZsbOZIitPZqjj6jPYsV/Lq43jV5k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(346002)(376002)(39860400002)(54906003)(478600001)(316002)(6506007)(6512007)(26005)(31696002)(8936002)(36756003)(2906002)(53546011)(5660300002)(86362001)(66476007)(66556008)(4326008)(8676002)(83380400001)(31686004)(66946007)(44832011)(186003)(41300700001)(82960400001)(2616005)(38100700002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEE5eXhOZ0FCdTdzR2crVnhYcElLck91c3hCQkMvdTNJYkYvQkllbzdnaU1E?=
 =?utf-8?B?SlNTYUxsSitGWmdhTXdUZ0JKcDY4cWpYQ3ZFNHVpOGw3WVNiTURiUlQ5ejdm?=
 =?utf-8?B?L2oxNHZoTThodFlja0pRank4NkpGcFFoditwUVhsUmlLc3ZnMEpreENseWZW?=
 =?utf-8?B?SlgyaUFXZy9zRmlCNElLU0ZKOWtWOGhnVXRVRnpXTFc4SjZQZlI1TnUrU0NY?=
 =?utf-8?B?cW9PbXoxeUtaYUFEd3E5NU9sWE1aaUZkelQ2YjVFcFpjOXplUm0yaEFPRGc3?=
 =?utf-8?B?d04vT1ZUODlFYU0yOEFsRzJPWlpFL3B5RnpPSWhqOHFyMFJDNGxlUmxhMVVW?=
 =?utf-8?B?cXp6eVh1NGJZOGU5NVhxMDhjSUI1TUVSeEtmdzVYOFBXL1EycGRaV1RDNjFu?=
 =?utf-8?B?c3F4M2h0Mk5ZTUE0MEw1Qk9GS0xmYVY5OStoUmZUTXJiblpEdlRhMCtRZHNm?=
 =?utf-8?B?OUpvK2xhaXlyeFBJcEVZTms5RUYyRHRPWDZjNE1rZ2pUMXgrRlBCWmRCaHZ3?=
 =?utf-8?B?OXMrWHFTVzRCRUYwS01Ia2tWc3FLdnl5SXlURnFxaHVJTUlZM2dUVkp3dUxw?=
 =?utf-8?B?aUZ3ckxFcml3NzB5ak1pVk5BalUwbko0OVRMRzI1c0I4Q0pHUnJndmNFK1Bq?=
 =?utf-8?B?bUJ3Y3hiWmR4MDRNMHRPczE0ZU1CcGNBL3Q0ZXQyWWpHWmVBK2NQbW53UXNX?=
 =?utf-8?B?TWludGZaWWo1ZXFaYlQ1V2h0UGRJUzhTM25paTM1dEx4MU12WXBSV2djZWE0?=
 =?utf-8?B?ZzJBeEV1b2UveThzc3JTSVlZLzY4VmZHekhicjQ4RGkveG12R0l3enBlbkVT?=
 =?utf-8?B?RHY5YWZxd1lpTGxwaFBMb1Y4aXJJYTRMME1aQ0hxS1dBMW56NEJINDgxTzNO?=
 =?utf-8?B?bGU4d0lUSElkeFowUFFiUFlaZCtwT1kyRzU1Y0k0WlNrVlVvMFJ6emZWREtO?=
 =?utf-8?B?aEZldjJReDkzQjQwekdpYnR2c3lXVjM5SEVkcGlRaS8wWWZqK1M4OTRKSkFr?=
 =?utf-8?B?N3ZYTkJKd09jbDFrNFk5VnFtUFRtbHI5UU5Rd2ZvMnVvK0NIMHQzMG4zREZ0?=
 =?utf-8?B?cWJFQmpGaG9PVENERzh2Y3d3VmU4MWFweEpMOWVXSjFFemNWLzc3dzQ3Mkw5?=
 =?utf-8?B?aHphQjdtVHdrSEJxRFhlcS9QR0lKdGlrVHA5V01PTnBKdUo2RERueVJUbExz?=
 =?utf-8?B?aFl0NERVQm1BZ3RJZ3NQVmVtcTlsdXU0QUlMbmVjWVFrc0dicXhDWVZ6aDdT?=
 =?utf-8?B?N1U4bnZiMTRNdEJsbXVXeVlocFlIRlpodWgzVExDY2JYOUJiUUVvRVZwN2RW?=
 =?utf-8?B?Z216UXduWmZBOXJiRFJlZU51TGhaMVp1SGIvM3MxbW96MGQ0NVI3SlBkZERm?=
 =?utf-8?B?Q1FTV1EyOGVSZXpGaXlLUG93ZjdjYytxSVdJTFdRYVYrTnRWYWQxRHkyU2tm?=
 =?utf-8?B?UW96VWNUb0RtdExyazRVOEhFeWtxV0JnSi8xUWVMT21jN2JuUXk0bzI1bVNx?=
 =?utf-8?B?V0FWMmU0c1BQb2F5YW9LT1BuV08reExVd3NTWmY4ZVJvVk5zaFV2eFIyM3VQ?=
 =?utf-8?B?NURha3hZSDZGU2RKNTFLQmdaT1k0SU1LTjRSQlcrRityc1FoS3c3NU54YWhI?=
 =?utf-8?B?amlTY2F3UCtMczcvYXM1a3pLZlBuSDcwcGFqbXgyZzhab1c5VjdMSUNlcjBU?=
 =?utf-8?B?SnRSL2VKVVdwaFdZeXJHZG9QOUJ5WnpFLzA0YWd4SGhpZWZRc0QvZjlIMnRQ?=
 =?utf-8?B?a2ZhOGpLOGlIVUx1blNDUkhTMnRiRFdQQy91dVNSaVV5eFNISkQ4ZEkvWm5w?=
 =?utf-8?B?SG1IU0hwWlNoVE5zdTNzV2tjMjJFTDdUZXc1ZmR0eEVOeHk2UnNBS1dzZVRH?=
 =?utf-8?B?TC9aMzZubnl2ZmRaNUM4RDYySE5aSXF6YUd2bkxyQVRPZ3BzWlpPNW8wVDA1?=
 =?utf-8?B?aUJpQURoTm5aN2FSMHFxSHFSU2FZWmJpVzF1Yjd1VUxVa1kyd3RaV08xVFVK?=
 =?utf-8?B?RzFNczNxWS9kWWRCRzJweE1iS01STlB0TzR4cGt4ZW1KMWk1c1RucUc2L0VR?=
 =?utf-8?B?aHVvWXBQTHZhSnFUT3lyT3BlZjVKSVliOVJwT2lPWE5HVWE1TzJlSE1DdDhr?=
 =?utf-8?B?ek0vdHI3bUhFNVhNMEFpRFY0V0xsZ1JFRkJNaVRJY2xVTTZtMzA2bXlWYndJ?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 162b33eb-4609-4abc-21fb-08da91ebb1d8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 22:44:31.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHUZUKodG8CSDZosdJL2IWEF0YIYGIUlxXbOLgwxJZHJPJy30rWCv3IpPWHLgIHTlxUnkd2I4im/VmKbxhfJGFtAegUkbO5CHVXtA5vpZkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4075
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jarkko and Vijay,

On 9/4/2022 7:04 PM, Jarkko Sakkinen wrote:
> From: Vijay Dhanraj <vijay.dhanraj@intel.com>
> 
> Add a new test case which is same as augment_via_eaccept but adds a
> larger number of EPC pages to stress test EAUG via EACCEPT.
> 
> Signed-off-by: Vijay Dhanraj <vijay.dhanraj@intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

...

> diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
> index 78c3b913ce10..e596b45bc5f8 100644
> --- a/tools/testing/selftests/sgx/main.c
> +++ b/tools/testing/selftests/sgx/main.c
> @@ -22,8 +22,10 @@
>  #include "main.h"
>  
>  static const size_t ENCL_HEAP_SIZE_DEFAULT = PAGE_SIZE;
> +static const unsigned long TIMEOUT_DEFAULT = 900;

I am not sure about the naming here ... it is _very_ close to
(and thus appears to be in the same namespace as)
TEST_TIMEOUT_DEFAULT from the included kselftest_harness.h.

This is surely a nitpick but how about SGX_TEST_TIMEOUT_DEFAULT?

>  static const uint64_t MAGIC = 0x1122334455667788ULL;
>  static const uint64_t MAGIC2 = 0x8877665544332211ULL;
> +

There is an extra empty line here ... but it looks like intended code
organization?

>  vdso_sgx_enter_enclave_t vdso_sgx_enter_enclave;
>  
>  /*


Apart from the naming comment this addition looks good. 

This is a valuable addition to the SGX tests.

Reinette
