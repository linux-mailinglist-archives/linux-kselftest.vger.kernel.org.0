Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF506EE9AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Apr 2023 23:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjDYV2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Apr 2023 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjDYV2F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Apr 2023 17:28:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7236B238;
        Tue, 25 Apr 2023 14:27:20 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PLEDN2022298;
        Tue, 25 Apr 2023 14:26:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CzEQZ5gka1RIxivt4rkTWfy8aj7iwhasIB+al8Y/8aI=;
 b=Ml2TyOzLObzpwmTtMNQYyQSIX3mc6eNUWTnuWFnG0Dd0L67ZrTT6Mur320jwrS9yeNmU
 IQpx1H8b3Wq4hq0jyRvOIHKmBZeyORts6mwIS8KqlWzm8mY8FUlZF0+DDnuO7BNIRwO9
 tbkKaXLHfkAdQBbzq+Y8bP9rsmx5gH9bNTf38NbYqHlZCZARGKTC9b4ZzsyyKHr9ZFE3
 h+k1eNShrFcw1iNI9pVxCcDcPiFmIvbmtD1a315HubGuqboTEEve3kGhX2ugXD0cA2BJ
 17NkTyvAhzg6GMZwUyHyybz0ysHI0ri96gfPPIxOr4MAicUDonj/g+Zb4m1zSGIRUpcW BQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6mws8s90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 14:26:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gk4FNrAxpwmQkZSwL0Slo7OFFRY6xnrWxgS3lSKfqxOalhXIMJf3J0QArzBM2jQ9s1ldVl5NbGr4WhWFZqeZeKSg0M0f/gy7591np57X0JlWLcFYOq4A0yyBt2zttjEp0EJb1KFSo4hAnGTDMtEfUTNCQ6QrBXTn6GyT1SbPr5Q/jUGgXJ7nY5eyvG3Sn4hAvu0WsUdN6NfGQSSzEAdTQrAb34Oa3FL1wgesHTssS2Vp6tcelJCbvkc9wGHvjb/fFwPAQsRwDzjMLHj0+Jnzg+hXg4r5ad6hxKjH3Kk1adSGYouZkjzCFtJ7wp46ETDtlPIxw9DFp1PlxNAS8X0gbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzEQZ5gka1RIxivt4rkTWfy8aj7iwhasIB+al8Y/8aI=;
 b=S1OVRxg3YpQc8NuOd0FlWQdUkmxVnImaM/kebALVVpVWY/nLuncYQg70V97aSBEUevhND5f7iKuIU77TulARRPytML5FR5/wdBn7hJ55Xlumr+RC9O+7zupKp+Mp/5goj+9hKnOQfRYHtcp1shu43IMMpCvQTxZwwYRg6n8OjgIT1RMMORxlcbHpP7xZSmEMzSrfOc+c1t+v5cnt1xndf5ykgumMTTTl0eJDxD6+zXdgMosts/yySPYEUWqwaIdzgGdFo6DzVbEYB336t5BjHmyTEkh+ditsdOZG+2ICOHd6EBGJYV2xmhk9hfHzfICaZrNDbyucqjaeAasBVw2Zzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5468.namprd15.prod.outlook.com (2603:10b6:208:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 21:25:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 21:25:59 +0000
Message-ID: <23649e1d-8fee-079a-21de-87f7024add81@meta.com>
Date:   Tue, 25 Apr 2023 14:25:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [RFC][PATCH 4/6] bpf: Introduce bpf_verify_umd_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mykolal@fb.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, bpf@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230425173557.724688-1-roberto.sassu@huaweicloud.com>
 <20230425173557.724688-5-roberto.sassu@huaweicloud.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230425173557.724688-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: b0a84833-eae0-4ee5-a269-08db45d3aa0c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AF9VZRo07uMYgCEol/pk3/cvzL3XkNIsoFv/Zqqe3vKveVzMrmPJ4TD/vQrfN5Z0j+FVxjPrJGvt2rZWJeECa9V3groX4cF4tYLnpIwKHKpjvqnJkhbI+ETXU6eY18dz+HoD5bCVO9gi4fiEWcMUhBjNgt84w2uK28Xea0evmQ0vaGWRFRa+2cO2dVJr9NjaUqOxK+SqDJ1nLxitQ1rGdlQ6UjVPHjA0/v755ha76eNpRITWyP/ucV+CYknpU91gK16Ki1sn0STWuSyGe1on//YvN/lRg42OP1yCSq7Yan1atKXvhD8o63HRfnmyq3PWIy6CsX3tQEXmHXpmob1DsVK5hJIAmg8R2OW7Xik4rMGvYSzHt0gNqAE5VcemVRGSXldthxwozWcBh/zzJ2g1oxwtuLp9d5OMiTAaZxgdGsbVJVAWB7j5ORi1K4q6G0LfideuN+PGvS+b74WYQQacSmu9SrTalDUnKSdjOWu7/6IxRK365fXkPKXS7Nk40BbaojL3LgtFtamDCBe7VRvHPx7JYlwkpIarRsAabaoDXC7TA3CkZpE4bb5rUCSH1pByX1aIbabLFibNRLp7tQJfMMxZEaSJb+apU4M4Cz1IRJGUDmBa9MWZc5BlwOmvg6gio0ujHKo+CK6FQrPZUwjOAtxlVVDsyA3MWQ5PJ6deeoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(36756003)(8676002)(8936002)(478600001)(66476007)(4326008)(66946007)(7416002)(66556008)(41300700001)(316002)(38100700002)(2906002)(921005)(5660300002)(2616005)(86362001)(186003)(31686004)(6506007)(6512007)(53546011)(31696002)(6666004)(6486002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NZRUN6VjJhQURxOWNTcW9ibGl2Q01VOE5kbXd0QjVJQ2JqcklmaVF2UUtU?=
 =?utf-8?B?aDR6RHVQNnhBZ0sxOFNyUEp4aDFpUkdnSEhkcFRWQXNjb1lGK29rMVZicmIr?=
 =?utf-8?B?QVpHWjZoQjF1TlVNb3hMYmFjZ1h1SURGK2pjLzN3TTVCa0EvUHRXQzZuVEJv?=
 =?utf-8?B?THNwcXlHWDB2aTBQL29icnM4aXE0OEVTb2FSYnlKQ1lYTVJLcThpbUJEeU5h?=
 =?utf-8?B?M0JsS1NjbzdkbFBZbmJIYUZ0K3RLa1pod1loUW5jR1o5emJuMytSVGg2QTRN?=
 =?utf-8?B?OFVyeFR0RkQvb0lFSWJ1SlpJNm1FcDlJNlNqMlVxOFVUenc2UUpBcDkzRnB2?=
 =?utf-8?B?VVMrejJiUzFBUGtFM0NnRG1ZKzJ2akhtazdzRGhZeTBBdzNNOVRxaWFVZFlr?=
 =?utf-8?B?YzRHaE0xVWN6RUxybStNV2ZMenlsUlE5NXpIMnpnN2c4empBUURlK0pVWmNZ?=
 =?utf-8?B?WFlRZmdhOGRKajVWZTVhUGpsZHJBa0R1SGtPbkIvbHpydGxDbE1IQnQvanFn?=
 =?utf-8?B?bnpTdVhiZnhvL3RSSGIvYkVBSHVVdjlLUzZ2eXE1dmtSSGkrOExHOEt0L2VG?=
 =?utf-8?B?R3IwTlhZNmR4cy9YVWNuek1sVE1hUTJyUGxyS2lxMVdjTUxwczlUN2FiZnUv?=
 =?utf-8?B?eSsycUFUWmlDU3BrUkMzaTJTUVV5NUNrQm1uWXRDeFRnd1pablUwdlNNQ3Zl?=
 =?utf-8?B?Nk82b2Q0TG1HUW1GdmxCQnZuTnN4T0ZMT0NzRTg2TWtjUTdRNGllNnFrVTNQ?=
 =?utf-8?B?Nnp0ZFJhQ2RRTU1ERlZ0K25zVTFza1VyNG8xbDE5aE5tb0N5RDFtK3k0WHZz?=
 =?utf-8?B?a3d4Q2xYS2dia2UvelgrQlhwbHVVVWE3TUQvVjk4V0ZKRzRVWURKL2ZYMzRM?=
 =?utf-8?B?cmlWeis3VUdndHpXZEJac25rMUxESjd2V0FZekxET3c1SHlMMnR5cjBWYXJW?=
 =?utf-8?B?VjI1R3RZM0pGWnJzMDYxempoaDVSTzZnUFZFa3ByQ1JDY2VsamVqT0NIRFkw?=
 =?utf-8?B?U0RJVytUMzQvalRLYzV2Ti9UbWNjcXJ3MlV6RVRVSVdiVE42NVVnSG1EZm9k?=
 =?utf-8?B?T0J5NFJTVkd0VW5LSEdWdlk4OUt6MVFSYjEvRVVCbVBRaW1EdzQxT1E2Ym5r?=
 =?utf-8?B?L1RncWt4bE5hSnJnSDVsdFRJUnk0YUtIQ1pQTVpER1hTWFBMazB0b29hYXJh?=
 =?utf-8?B?NFRwK0dBaGVyREFMOWt1NnhHQ1RPRzQyM2k2bW5KRUFIWlA1MU95RUFvOVcv?=
 =?utf-8?B?c21RblQwWExFTFVlK2V6aUtnYVVhRWxSTVBiQkRmb2tyS2lmOHZiUzlMU2dh?=
 =?utf-8?B?N0pwSzArZ1pyS2I0OEJRR01iaDFEaVk0b0QrdzQxYVkrL0h4dGh3UENJMmVU?=
 =?utf-8?B?Z2hsTFRvdUU1YmI4V0tlWnQzRkN3VHQ3UmZQY3FidDFMZFd6WVR6ZnMxQ2JZ?=
 =?utf-8?B?U1MyNFkzcG4reUlkYUtFeWhxWERRbFg3Mmd3ZjBMenVjelVHL1NNSCs2anhk?=
 =?utf-8?B?eDVWbWNHVEg5aDBFeHZYRmp5R2lHYWIyYUNzUldvRGpWa3cyQXJDclFZUEV4?=
 =?utf-8?B?U1p6SUFJTWZQQ3BTdmw4Wk9MRGlVWENFclhjSmNlUW1yd2dNWi9Rc2YrTDFQ?=
 =?utf-8?B?TC9uUXN1cVR5RjRWYUZsNjRpc2VTTVloMnlqdDNQaS94Z0pkNmVYZ1cxSVRu?=
 =?utf-8?B?dkhKRzBpc3g2RlVNODNiOXg1T01nUU5RN3NoRnhVZ3laQzVmdytCZVVrRTJm?=
 =?utf-8?B?bzFCTHR3UUtRUGFjamoxME5Nb2ZCMkFvdUxWVHlZclhQZEEvRlVJQlB3RlB3?=
 =?utf-8?B?OG02VGNzb3pXR3MzUlpDc2YyZ3BhVm5MeEJYV2FhS0FJMG1Lamt0UFFtM0Jr?=
 =?utf-8?B?MVN3eHhpTkljd2NWRjNta2N3aWxyRFlmbzRydytpTWsydWRDcWN5aDIvMjlm?=
 =?utf-8?B?MWVOKzlFcC9LcE4zSEhuOTNjZGxXTlhXVjQ5NUxsUkdGcE1Jemg0Rmt2ejdx?=
 =?utf-8?B?RHcrdVRUaHNuNGl6eEJLY1E4RlNjczJmSkJwdlNjcVYycnFNRFd1NFk5WUFI?=
 =?utf-8?B?Ry9XOVhBVVRoN2kwUlUrdmNuMmp6QXJaSk1TZDNFM3NUaE9nbkhqUXR6MmxX?=
 =?utf-8?B?YWswc2FON1ExS0lXNkhiZVoxSnlJMjFlWGRNQzhIZk9QNmRySzBTMm51RE9C?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0a84833-eae0-4ee5-a269-08db45d3aa0c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 21:25:59.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9Hr59ysr0qZFN12+VMRokc1OfEeNSt7EsS9eW6ZNKyes5I3Im4/zzQ9mhBqb33F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5468
X-Proofpoint-GUID: nU1ZT4x-9HxVnFAQmOyWJUUlp9O36u0A
X-Proofpoint-ORIG-GUID: nU1ZT4x-9HxVnFAQmOyWJUUlp9O36u0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/25/23 10:35 AM, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Introduce the bpf_verify_umd_signature() kfunc, to verify UMD-parsed
> signatures. The parameters and usage are the same as for
> bpf_verify_pkcs7_signature().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   kernel/trace/bpf_trace.c | 69 ++++++++++++++++++++++++++++++++--------
>   1 file changed, 55 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e8da032bb6f..c9cae337596 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1271,7 +1271,7 @@ __bpf_kfunc struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
>    * The key pointer is marked as invalid, to prevent bpf_key_put() from
>    * attempting to decrement the key reference count on that pointer. The key
>    * pointer set in such way is currently understood only by
> - * verify_pkcs7_signature().
> + * verify_pkcs7_signature() and verify_umd_signature().
>    *
>    * Set *id* to one of the values defined in include/linux/verification.h:
>    * 0 for the primary keyring (immutable keyring of system keys);
> @@ -1317,6 +1317,27 @@ __bpf_kfunc void bpf_key_put(struct bpf_key *bkey)
>   }
>   
>   #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> +static int validate_key(struct bpf_key *trusted_keyring)
> +{
> +	int ret = 0;
> +
> +	if (trusted_keyring->has_ref) {
> +		/*
> +		 * Do the permission check deferred in bpf_lookup_user_key().
> +		 * See bpf_lookup_user_key() for more details.
> +		 *
> +		 * A call to key_task_permission() here would be redundant, as
> +		 * it is already done by keyring_search() called by
> +		 * find_asymmetric_key().
> +		 */
> +		ret = key_validate(trusted_keyring->key);
> +		if (ret < 0)
> +			return ret;

The above
	if (ret < 0)
		return ret;
can be removed.

> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
>    * @data_ptr: data to verify
> @@ -1334,19 +1355,9 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
>   {
>   	int ret;
>   
> -	if (trusted_keyring->has_ref) {
> -		/*
> -		 * Do the permission check deferred in bpf_lookup_user_key().
> -		 * See bpf_lookup_user_key() for more details.
> -		 *
> -		 * A call to key_task_permission() here would be redundant, as
> -		 * it is already done by keyring_search() called by
> -		 * find_asymmetric_key().
> -		 */
> -		ret = key_validate(trusted_keyring->key);
> -		if (ret < 0)
> -			return ret;
> -	}
> +	ret = validate_key(trusted_keyring);
> +	if (ret < 0)
> +		return ret;
>   
>   	return verify_pkcs7_signature(data_ptr->data,
>   				      bpf_dynptr_get_size(data_ptr),
> @@ -1356,6 +1367,35 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
>   				      VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
>   				      NULL);
>   }
> +
> +/**
> + * bpf_verify_umd_signature - Verify a UMD-parsed signature
> + * @data_ptr: Data to verify
> + * @sig_ptr: Signature of the data
> + * @trusted_keyring: Keyring with keys trusted for signature verification
> + *
> + * Verify the UMD-parsed signature *sig_ptr* against the supplied *data_ptr*
> + * with keys in a keyring referenced by *trusted_keyring*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_verify_umd_signature(struct bpf_dynptr_kern *data_ptr,
> +					 struct bpf_dynptr_kern *sig_ptr,
> +					 struct bpf_key *trusted_keyring)
> +{
> +	int ret;
> +
> +	ret = validate_key(trusted_keyring);
> +	if (ret < 0)
> +		return ret;
> +
> +	return verify_umd_signature(data_ptr->data,
> +				    bpf_dynptr_get_size(data_ptr),
> +				    sig_ptr->data, bpf_dynptr_get_size(sig_ptr),
> +				    trusted_keyring->key,
> +				    VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> +				    NULL);
> +}
>   #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
>   
>   __diag_pop();
> @@ -1366,6 +1406,7 @@ BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
>   BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
>   #ifdef CONFIG_SYSTEM_DATA_VERIFICATION
>   BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_verify_umd_signature, KF_SLEEPABLE)
>   #endif
>   BTF_SET8_END(key_sig_kfunc_set)
>   
