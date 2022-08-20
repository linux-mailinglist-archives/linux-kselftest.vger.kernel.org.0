Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4F59A9E9
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 02:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244833AbiHTALq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 20:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHTALp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 20:11:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD000115982;
        Fri, 19 Aug 2022 17:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwjDZ8ECgCaNfawKN9wV/D13mNr9gjMHswctrEicb9h3PQTBLMIHHK0P5gLB8lQLcgKobpAAmu5PhIaObDTWxIMPwGBRbjR8/6zwOgPFvxkB0aOwW33TnzMRxhati3y9GUB1LYAtzoNPTFaYrbXVvFJPGCY/HTnTZ+trWrbIlRqRCQHdDsO0dgGxZQEumRVErG5cd3m2fL08wPE2auB/3rHs3v4HNpL2eRULTCmzWALpkocbwKocTBR/sDdRqKjLk+hDW/+HDYEtcsMbt3IOutlYpX36Pb4XhKJf9d+H5gLU4wkB0Dmk3usHaMaHYqeE18mtPafO8TYtqLc0haQumQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQGWZ4RFbDG1VI9nxDeyzl0NmMRZbaVV/mz4yAGbgwg=;
 b=Ea0FPUTKG5geq2Zs8oPfnLgnlSOBB0Lffs/EJWXkb4YxJASE7tHxvDV+6c/XjGgNdK3FJEPfoy/BpoYsIsx27oaGIWiAEGaWRDphamx2Jbzn48hqmAIwVZ91UZYGUpdyRR1YdguJaPwZckRVeCl35FonFWPlXGERuZt/JTVnoA4GLe3Wtsb04x+W57Aff6elUr+UCChW9zzzqh0kb05phIh+rRr6bQ7XRKp9Dj7h8qsynksva9omRUBskQ8+kms8EOr7be/s8d3K6hmpd+6AFToRlXGhLRtEARxziyrWCHwvtKT6s2LMiUFYspw3sS+DLBUl7xHFg8cbHLhYb+AARQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQGWZ4RFbDG1VI9nxDeyzl0NmMRZbaVV/mz4yAGbgwg=;
 b=oVQZBFfRyvfLmg/R6sGrV0qS2czl0cWAjkGyrZ7L2FIGdzXPIlzMRk3a8cV57ILRuCRun6mYV9JRUigH8rptoMxjfgahOLzbCRLyDHaPCsHqL+zEU9nEYv7ZbJXbpbTQKL1wcLzrHguJkqeuXP+rrhTnGRLoO4BkZzGYsXTEJh12ygp98AVqbIPh+NajNMZv7fZFXhwdYpsh5PEq9OxuZTg0yaW5mEZY5HcH271x1xUoECSLmF0QpAzbtoAuLcZ7g1zLpojtAg4hJZwE7Q6gX0KMwSizVoTP2Zr6tMs5zg6hZlp8pb+tV8VvvzlS03itWJ9XtzPLbkS1kyPrl7hGxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by CY4PR12MB1797.namprd12.prod.outlook.com (2603:10b6:903:124::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Sat, 20 Aug
 2022 00:11:40 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%8]) with mapi id 15.20.5546.019; Sat, 20 Aug 2022
 00:11:40 +0000
Message-ID: <75024e6e-2060-18ce-06e5-19769f7eb05b@nvidia.com>
Date:   Fri, 19 Aug 2022 17:11:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] selftests/vm: fix inability to build any vm tests
Content-Language: en-US
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220819191929.480108-1-axelrasmussen@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220819191929.480108-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:a03:80::18) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625a2c30-51ac-46b6-82a5-08da82408e64
X-MS-TrafficTypeDiagnostic: CY4PR12MB1797:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XdTtAe6alY8Ij83V8cJNa4qD1eOqOOrC/ilzKMz/uLjREX/vzcJ+xnMvMJ9PpNvsialhj6bYoO1Uvg54Evn5AWDWN11QoJP6lbpqc7QLezTgHSSamzZlElkystNOu/Z8gm9zjEzgsi0+OMd+pre0Gt71BrbP+wkqRr2LQBeXWFFTwCOf//eYetBVQB0zodiwsXanmz5LlyC0g8Iq84Q3/WdN9syO1cQsBUUwkXqL3RjS+qL4j8slKZ95d0TN0bHM4g6pHUXa18DWfpr1HsOgz2+EbJUpjuzOaC+uekmt01S+V/cWE//rPnjfcb5Qc4eqvsbFD/D45oK136xf7mYsiTsHqTjx2NZQQ3Cc6nsV3ZJo+NB0L/WAsZZtPa8doXhF4eWovchvpD1AzwR6jqx2qslDuRoyJy0UUvWW32kyR+jyiDAEMa2w1fHpOfqCD3jl0ZJ1JD5n9q5KRZuUMd12Qm9yL+5wbqOybRGheI23Q9jBotxG9jgNfSIwX4UKS/SJuyeOyNaznX/LPjFNmYh9uRbTF3xxunqLprpWYLwYDTOanBa/zohHScP1ZpbFcrj+AUZ0qthZpPYF/gX1QmstlQ04pyE/Hj0zQDID819vf694Ze9mlj+0imdzrRviixQ+fqotRSw5tDhdPm7ncbdHs20JQJ8cxMfBoafptDYHO7U1ktTD6468+Y16pXSebHxd1vFwk/yve2rMRyJuoRRWMGQFfVKIAT7qQEWuJxgbt1dH5QEdYQGCNEACEp7mEaH+i3j3RbHs3ZbvvNIEinHUSE14ssVU4KF+YonAb7QnPyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(478600001)(53546011)(6486002)(6512007)(66946007)(6666004)(6506007)(8676002)(66476007)(66556008)(41300700001)(31686004)(36756003)(2906002)(86362001)(31696002)(26005)(110136005)(316002)(38100700002)(186003)(2616005)(5660300002)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1gxY0VJdkRWTkxBQzByTXkzbVJielZVU0szK2NUMk5iVVlBdFpsOFRwaEJ5?=
 =?utf-8?B?RTBlKzBDQXRSVi9sczFCYVBGZFpLRURhellyODVGSzlIMnh2M1FaNCtSNTJW?=
 =?utf-8?B?MDRLcllkRDRoZER4MHVNTnBMcnNUTlZkdEI3TkhRWGlaTUM4Uk0vamVRaVcz?=
 =?utf-8?B?aWpGbWhMT2Vrb0FMaUR1NjJUeXpEMjhlbmtrY2xBV1AxQVY0eDNQTlROZ2JX?=
 =?utf-8?B?b1R6YUwydzRKRHNNNkg1L1J5RGRyUndzL2lPZDUyaXFWNWw3eURtRTJFcUxk?=
 =?utf-8?B?YXNYUklZQUdNNFlQcXJEb0J2OXFnMjlTYkszeDNDNXFBNEtZaVZXOHFMeUN2?=
 =?utf-8?B?emRxVVRHUjFHdzEvbHk4VEVqMDZUTW1QYWtsYkJPZDUvamF0bWpiL1ZsWjA4?=
 =?utf-8?B?VTBqaCtpSUtWVnpnVkZvY1FmeW5sUndOVzVYbUdVYnRXa1RaQnYrV1dGbjF0?=
 =?utf-8?B?bnlTaTJVZXhmZ0xIUnE4cFFQVUlGMWhFL2NxYTM4VjRuRHRDNEs0N25ITlN4?=
 =?utf-8?B?c21pWUtON2NCWGE5dURLb3BRY3I4b1A0ZzhDVFdndUdKTnhVWHkxckk1NnFD?=
 =?utf-8?B?REM1aFB5MlhPMlJLczJmbFU1YWZGcDcxRnhSeFRYckdjMmd6S2ZMdmVZYjdl?=
 =?utf-8?B?aW1selc2eEt5c2lDaWtMd21ORndEMEllc3NiOUh5QTNIQzFZY2d4OHhIQTZN?=
 =?utf-8?B?dDdCbmtlSzVzK29mZkkzS3lhOFFTZnJpNm1adUZsVnYwMUtZdU51ZnpxdlJC?=
 =?utf-8?B?b25CUlEzK1RFVngvZ3ozWlBQZmc5dHdrbHlaRGdCUnp6K0hMRitVa0hBUzZD?=
 =?utf-8?B?YVdKQWpUbUxzOWl4QjcvL2JSNEsxVUljNGNUUkR1RWRHRk04bTlnazZYUFVQ?=
 =?utf-8?B?bklYUGdtejJZbkdWb3hoL24vUnd0V09EVnJxSGZEZ3A1L25tZ0t4U0RCWSth?=
 =?utf-8?B?cGszaDVINFAreWtLMGdwMCtsSWQyU01FVnc4L05TY3doSXVuZGRpL0ZYUDNi?=
 =?utf-8?B?L2M2N0tFaTVMMzlVeHVIY2Q4czJNM0NVWlhvd2FGWHphejRwTkxQYVhKTTYr?=
 =?utf-8?B?S0ozRm1kT3NBd0psb01wNUh3RW1oc2hVNGtSVXdrVy9ZclZYU1dWd1QrdytS?=
 =?utf-8?B?RjRPYVExRDFNaDNpTzduOEMwM3N5c2d1QUFnN1RlOEhkeUIvV01KZGlPbEV1?=
 =?utf-8?B?YnBTL0RudmFrQmovWFJxelBPdmtscEtNK00zQWdCSzdwTVV6Z0c5WkdPTlNN?=
 =?utf-8?B?VlpLZG94QjVEcmozeXZLTGxQcm5IMnF1Ty8zWm9MSUlPdUNMQzFGUFJvRWJo?=
 =?utf-8?B?U2ZGLy9pVk5uSWdXSjMzdnZnYndZUGkrL3l5OXNKdUw0dy9vUW5kbkMvcVdj?=
 =?utf-8?B?cTNJeHRGc3BPdnh0aXJSVEJMQkJIdHROT2orRXpqcmNNYkpqRHBuekxsSC8z?=
 =?utf-8?B?dHliUmdadDlXcXlXR0pNbjIwQ2FCdmdpMTBHOTlNbEtPL2JaUDBtZHBGbEd1?=
 =?utf-8?B?cTB3ckIxUG9oMFB4TXkyaGhKMTZ2VHhJajd1MFoyclpyZzQzWkxRalc1N0dF?=
 =?utf-8?B?eFhTTFBzenF2R0ZsU25YbWREaVFIVzRUakQ3cEI1NFZKWGFRaXhhSUMvR2RJ?=
 =?utf-8?B?UnRnQnNIY1BzTTlpcXEzUDZROUpXUWM5cHpwZVNxRXoyd2lzTkFBaVlIREtP?=
 =?utf-8?B?cmNNbWhuSEg0M0FzbDJPK0U4KzFrS3ZrMkFmNTdEK3BJWXdBeWNmZXR3VjBR?=
 =?utf-8?B?M3hrSUpMeHN4dTc5ZU1xOHFNWHZXeUtzM0tra3NUaHlJVlpWRk9xQTViTm54?=
 =?utf-8?B?bkhqN0Z5T1B0dkp0ZXJVaFl1dHRqaDJoSnhJeTJSNmdyaXBKdFVNUjFHU0Fa?=
 =?utf-8?B?TUJCYUZ6SlRKTW5vZVpBc1J2ZHpkMTBraXBUMjRLUDZVVVpsUUJWZzltNDhz?=
 =?utf-8?B?c29qRXZCRkxEYncvMEhvaGVNT3I2UmJ1a3JjZWRXVXFmT3U5RjRlWkRhQnFy?=
 =?utf-8?B?TmxpekNLTkN2ZGdtYUl4TjNkNy9ZSzNWenpWb2Z3eTdxci9CVERxOWQxUGV2?=
 =?utf-8?B?VU5rQ0pzTzVhU1BUL1JkNWd6UEFBTTUwMW1KQXZyYmVPckdmY2pmeEhPbWpG?=
 =?utf-8?Q?B8jzgbCSkWGhqgXAeTF0zpy35?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625a2c30-51ac-46b6-82a5-08da82408e64
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2022 00:11:40.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BYTb7BEjafnuHqgBAGdruVKqSnozuqvh3en9DqeiXLNd0Eh7oxRLnKMQQY26poytpUxYT5Qa+SXB0uXQ1Xb1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1797
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/22 12:19, Axel Rasmussen wrote:
> When we stopped using KSFT_KHDR_INSTALL, a side effect is we also
> changed the value of `top_srcdir`. This can be seen by looking at the
> code removed by commit 49de12ba06ef
> ("selftests: drop KSFT_KHDR_INSTALL make target").
> 
> (Note though that this commit didn't break this, technically the one
> before it did since that's the one that stopped KSFT_KHDR_INSTALL from
> being used, even though the code was still there.)
> 
> Previously lib.mk reconfigured `top_srcdir` when KSFT_KHDR_INSTALL was
> being used. Now, that's no longer the case.
> 
> As a result, the path to gup_test.h in vm/Makefile was wrong, and
> since it's a dependency of all of the vm binaries none of them could
> be built. Instead, we'd get an "error" like:
> 
>      make[1]: *** No rule to make target
>          '/[...]/tools/testing/selftests/vm/compaction_test', needed by
> 	'all'.  Stop.
> 
> So, modify lib.mk so it once again sets top_srcdir to the root of the
> kernel tree.
> 
> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/lib.mk | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 947fc72413e9..d44c72b3abe3 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -40,6 +40,7 @@ ifeq (0,$(MAKELEVEL))
>       endif
>   endif
>   selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
> +top_srcdir = $(selfdir)/../../..
>   
>   # The following are built by lib.mk common compile rules.
>   # TEST_CUSTOM_PROGS should be used by tests that require


Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
