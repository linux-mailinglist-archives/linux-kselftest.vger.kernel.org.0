Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26746FFBF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 May 2023 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjEKVjM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 May 2023 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbjEKViz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 May 2023 17:38:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B494965B0;
        Thu, 11 May 2023 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683841131; x=1715377131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vfnkXZBHdDEjYawlGxiGye/XXdFjaUPnGt+xvRkb0ys=;
  b=FTx8TFCMOobNAMdmpKjy6wDRVTphSOtZoVHy8tDVnGGw14/vS9TY72n1
   m/q4AH6t0Co1qZ+AiJYYyO6mZySDjg8pfziZNzTPvMEEcpzsMb0nx2V3B
   v4WJOLQv0td/i1d544ZibkOm78NHFOJJV6nuBvTbkTs02fZLrn5v8DTwd
   qU83OOkbPF093ScZBWKC/Mka8RWgpkeYYPBoQvH26EakBkBYU5aclPbOK
   zeLWPjieiQnDyIoq64XAuNLgR3uXBgxp6zOQ49gQJtdJOztsHlMThKRoE
   XIpeDC2yl0EiZW6R2hzOLF+JZbCOxqYxuNKSeI3hHSEuOHmKA81+tAFFP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="352878388"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="352878388"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 14:38:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="1029797787"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="1029797787"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2023 14:38:51 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 14:38:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 14:38:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 14:38:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfZiVAO3K7RXa+70Z/vHfgKF7BH63TneMHbAeY1szzzLhvWEWoUfaSo0mCL/krap6KcQmzwgsSN6IxIBGV5igqBzV6t/kOEwNTDaVJf9oqB7H6MbZA9x6Qm3lTLDKSK9qG3Z1TvTmToWlL/t/e3sFqPGrzyDrmAsIgAgA4mjUr8lIcXauHfQjsD9qYeWdvbByTDBwc6njtqiTSIgFpNvyQ//3o/69eG53w4KW2mOqoO443jo0+Bp6ThreJqk9HtLcOinI0UXrlTaXLhveWDwvYCpw3jN81O+79a1g85kK42Vohp2nrMaYeZtRzlJTLpvvzIAWsdPRw67gy2tQxBjPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPhujyCrQj41sF7Je3IQUG7ZV4bYktcGLssRIWstl60=;
 b=K1L+zPsypsRpdwALmLkO/RWgkg9UfKPtwMIFDKt0s7k5iDUBPK0mPFG5uH6T0efX9zxigmO+Uf79mRcSxHPvWMvBR2g4FPNQKj4YoX91lOVYTEwu4RBKyRrJ0VYORODuRVIkfmg3Dtp4EyVpMTWn4oIwmIQkbPS8bNXe6+9meQmEVIZjgKhnjU2yqQc5EpyeA5fFnZAkT2Jz7jZc1+yI+BnX1YReEfwPr0FXhF6DeaD6Aypyh6uXFSPdscnzMp/nmgiDq+fv01WMB96VjQd7VS/WJKcRuS2lszdwy+yBM4s4HFUlJafoao303uijpGZzTwWIBphN1MD5/wKIpK2ZSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MN0PR11MB5964.namprd11.prod.outlook.com (2603:10b6:208:373::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.21; Thu, 11 May
 2023 21:38:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::591f:4873:fd80:9a6d%6]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 21:38:47 +0000
Message-ID: <1a84e1ad-4f6a-17e2-b49f-bf02c7b70fa2@intel.com>
Date:   Thu, 11 May 2023 14:38:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH v1 6/9] x86/resctrl: Create soft RMID version of
 __mon_event_count()
Content-Language: en-US
To:     Peter Newman <peternewman@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>
CC:     Babu Moger <babu.moger@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stephane Eranian <eranian@google.com>,
        James Morse <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20230421141723.2405942-1-peternewman@google.com>
 <20230421141723.2405942-7-peternewman@google.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230421141723.2405942-7-peternewman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MN0PR11MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: bc4c87aa-6637-4c83-bc51-08db52681a35
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1S5GoJZ/Y/CjdjNKl3b4QJu3DssLVdsLll32RQX6Vgq76jCuYCYGE8WHo8gQwLm1MbJwGz8ypKnB+lt6l2ULwQUKeBznMUm+XntwNPrkjgUiwaDTRRyE3t+6hLhxALK4sXN7y4WSkANZM/5Blb2pASfauouYRXDEfjM6VrvrUWPRywAM8OdeJ9BIA+4lXRio/yk4bEYnIoLVH4ZOdw9jAl/iPD3RbZM1JQUdQxAyxrJwW+sBVeQZ5HXNBBz6pDNjmX3nqyBbLOQIeBD+oxQ/YnsS1Q5/KlU7rYUDKB61+/DnXVy732aytHgGv9netkl+/dkFkX7F+QmGablK8HyHn9xvG0AD9V2gBKqZvhypVgpGJ4sL2TdgP6+4CzVmFEr9k0pQEAKxGuUmq5OtpCHTiy6X3ML/L6dKQ8wT61gCNXwSebP5iyC0DgKbbo3sw3UYj8BmCzejGdWyXdZZ9Kn9VWpakErAErfWfF+73M3zdhmi1PckJR+xOUStMXQy0iT43MRrpKe4PGjB+tAcsXg1JAm/BHVBvNfpjOUtUg8ifZ5btpKJrnMpitlwdaPP7IPF5fh2UJF4eS668BBO6u4bCViP7H1CpNzo5QM4J0XtBkycyVpTX2qvq8SX1Pth6PsG9o6+rwXM8/0Rwu3XQsDSQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199021)(5660300002)(44832011)(7416002)(8936002)(8676002)(83380400001)(2616005)(2906002)(186003)(36756003)(82960400001)(38100700002)(31696002)(86362001)(6636002)(4326008)(26005)(6506007)(6512007)(41300700001)(31686004)(66476007)(66946007)(66556008)(478600001)(316002)(53546011)(6486002)(54906003)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStzdFY0R21VU1ErTzNPbGpINDJnT1J6cU54N2N1SUljOWFBRVl0UGlUcnJn?=
 =?utf-8?B?YzVVSkxjVURkUHQ5WnFQcDE5MXpNaWZ2U0t2NjJGYVdVU05CKzlMeERoajhu?=
 =?utf-8?B?QXA5T2JWNnlWeFVLR3JXMmVIcHZFSzYrMjVrNmNjVlY4Umsrd3kyaWk4MCtL?=
 =?utf-8?B?VUhDTEdzZk54dWdnSThQRXVwWExJWm9mYjJtR3JESWNnRlY3bmREa2ZYODIr?=
 =?utf-8?B?dEU1d2t6UjFqakZTOUtqK3RXMko3OXZnbm1xNjEvNjFXWWs0WXZZYjlVdit4?=
 =?utf-8?B?dVMrZ1Vqb1pWOHU1OW5CYnRGUGlFOUtTVXN0dVU2TlpEejRTcmdHVzFWVWd3?=
 =?utf-8?B?ZytzNnZROFBVeWhoMTNuVWNVd2x4TnBWa2ZuU2pJdDI3THp5V3dLUFd3NDR2?=
 =?utf-8?B?VkFIbSsrU2svaTAyTVFLRFlnMGpBMTFvZ1JVYXdJelBYNW1aMFNXOUlndXhX?=
 =?utf-8?B?WVlubEFhMXNrU1FhZ0ZscWdYalRDSnphMC9HS05LZ3VlMHhoT0FtWGNtUk44?=
 =?utf-8?B?bzZ5L0YvWVB2SElUc0FJNnpFZXdJV0tEK2Y1dWJmRURYUUxzSlJpakZlMEpY?=
 =?utf-8?B?endHUHBPcm1TWjFxZnVXcmJ4bEt0blRTOHhSWitmT0dHbWJsWlZGZWJDdi9S?=
 =?utf-8?B?QkRSUUhCbXowWGdtL2pyeGRqMURkQlg5S24rcWFPdk5RTG5XTXJmYllLVjgr?=
 =?utf-8?B?ZXFmSEJqcjVPU09rVFZ6aTQvR0ZQTHZPaGcyKzNTekxMZCthQ2oyWE83aTNY?=
 =?utf-8?B?dnNwV1Z3SHlScTRQTEo0YlZXSjhyU0lFK0ptcEdaSVRPLzVmZFM5OEM4THdw?=
 =?utf-8?B?d0dCTzNEWUJmK0RyeUJCVFgrcVEyNUJXZ2NSMUFqVFF3dkNQSXlSMEdJTnhF?=
 =?utf-8?B?dTY0bjRhWjdUK1YzRjJtZDU3VXpyZi9mQUJ2RGJUbC9hUkdaYi9tSys4cDhU?=
 =?utf-8?B?SFN5NFcvTkVGemRNRG1aNTF0VDVKenFpbkc4RVNhTWVrVE03ajJmL3dSalZC?=
 =?utf-8?B?TmlkREZtQU5NN3M1QkNlVzFkWlEvbVVHTlRkUDZ3am45eWJ3eVNERnN6cGhr?=
 =?utf-8?B?ViszSmV2V2ptR3JudDQrQm1ySGVEdWtESklmYVJXczdJVlZEbXVtSXpYemdI?=
 =?utf-8?B?T3lTWEJwNTE1L2ZLTFVWSnFEdzNBT2hKbmNGaHE4WHlGQVQ1NFZKWXV2UkF6?=
 =?utf-8?B?VEtLN2FWOW5LZHhjR2llV3NyVTRpbmllY0hldkttcUlUaXBNZDJINlV4d2t2?=
 =?utf-8?B?akdoSEZOYmxxb1dpQ1lVeUNtUW5PRUo5TzhSUUVzMmhyTitWWk9VeUNzRFBH?=
 =?utf-8?B?WnJOb01QRmRmYmxvWmJscjdCMjU4dE9uTjhHQXdOaGhOaVZBRVFHYi9oSTlh?=
 =?utf-8?B?QkdxWHhoV2hnK1JKTnU1blFJWmhwRlVvK0EzbXlNcWFCY1VKSWlQbmJaKzhp?=
 =?utf-8?B?dVdwdVhMKzlWblhsNjc4YXRkWmZkd0crRHdNY2RyaFV4dEd1aGExY1djZWkx?=
 =?utf-8?B?VktCTGo5SlprQllINUpxZlFRWDNVenhGcTMvSTBOcmY4cTF1UWdzdDNvNTk1?=
 =?utf-8?B?MmlXcklpVDFlK0RtMWRCaktFRVFtcnpwcjhEMmIyc1lJU0JJK21TVktRTnZB?=
 =?utf-8?B?YlNIb2pUbTc1UGpPc0Q3R2UzeHBZVDBEZmpGVW9KeERseVhRNDBtck82bmo1?=
 =?utf-8?B?ZzdpWGZYcERuMnFaMUlyN0xrWXlMOThKM3BvSEtZNmc0TTJoSHlEMloyMlNq?=
 =?utf-8?B?WEFYUTVSUlV5V2lHNTN3cmdMdFV6bHlmNU5BRnZSVHJrUWZCY0U3S3hSK0p2?=
 =?utf-8?B?V1djTDJvaU96dm43K0tadldHMzlQMjY1ZXRPY1J4L1pLdUtsZnRHOWo5eklz?=
 =?utf-8?B?VkdnVDlyaW8xMzRIZjBJTEJRenhMa1JwYUt4cXVycE1oV0k0anlVckxMbTJh?=
 =?utf-8?B?blJCdVdDVzVNbS9sV3BFZEZPc3hKUU8zbDlaU3Nscy92Qkd3UDBPZjcwaHYx?=
 =?utf-8?B?eG83S3YvZ1NDc25XZ3VBang1aUhBd09FbEp2c2szWFZSaW9Qc1U3aGNxQUJI?=
 =?utf-8?B?MkluUk5OZzJSVDE5VmJCWGpJYTcvZlUwRlhhV3NTbzNTejBPdms0cHFCNFox?=
 =?utf-8?B?c2dYcEprcEd2OVZRc3pXREo3M0JoYnJwV3E2UzVibndsWVg1ZldEa2QxY01I?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4c87aa-6637-4c83-bc51-08db52681a35
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:38:47.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LXfIvTHDRox5+YmtWrm0Ck+0ngYjWQ3gizHwwdlEu/kzzWoxMHvf9FcN6LTDOdI64mpQOFUawYIbZnpIt4lRvx4ZCGu0EL5gTEN1mcFB1Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5964
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

On 4/21/2023 7:17 AM, Peter Newman wrote:
> When RMIDs are soft, __mon_event_count() only needs to report the
> current byte count in memory and should not touch the hardware RMIDs.
> 
> Create a parallel version for the soft RMID configuration and update
> __mon_event_count() to choose between it and the original depending on
> whether the soft RMID static key is enabled.

Please note that the changelog refers to "whether the soft RMID static
key is enabled" but the patch uses a bool instead of a static key.

> 
> Signed-off-by: Peter Newman <peternewman@google.com>
> ---
>  arch/x86/kernel/cpu/resctrl/monitor.c | 33 ++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index bb857eefa3b0..3d54a634471a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -487,7 +487,30 @@ void resctrl_mbm_flush_cpu(void)
>  		__mbm_flush(QOS_L3_MBM_TOTAL_EVENT_ID, r, d);
>  }
>  
> -static int __mon_event_count(u32 rmid, struct rmid_read *rr)
> +static int __mon_event_count_soft_rmid(u32 rmid, struct rmid_read *rr)
> +{
> +	struct mbm_state *m;
> +
> +	WARN_ON(!is_mbm_event(rr->evtid));
> +	m = get_mbm_state(rr->d, rmid, rr->evtid);
> +	if (!m)
> +		/* implies !is_mbm_event(...) */
> +		return -1;
> +
> +	rr->val += atomic64_read(&m->soft_rmid_bytes);
> +
> +	if (rr->first) {
> +		/*
> +		 * Discard any bandwidth resulting from the initial HW counter
> +		 * reads.
> +		 */
> +		atomic64_set(&m->soft_rmid_bytes, 0);
> +	}

The above is not clear to me. If rr->first is true then it would read
soft_rmid_bytes and then immediately reset it? 


Reinette
