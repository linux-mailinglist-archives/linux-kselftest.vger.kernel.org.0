Return-Path: <linux-kselftest+bounces-40534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FEFB3F93D
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E793BA270
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 08:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F602E88AB;
	Tue,  2 Sep 2025 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOSj8Sdb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26302E8B8F
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803400; cv=none; b=i9F/NLjnM4t9smTq51yDNoJuM/y6Ql02kVMfhgULu+7kQijZnwcmiTS+aZ06HFkJ94KXBeNKqRSP41Y8n7JffViuwqlpX72Hja2DkCGBoXPJhDcebmj8O15BuANItTw23zRRSjLeNH2Nfq3hKIfNSwj7qUQ5Hja/4m1KOTLJS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803400; c=relaxed/simple;
	bh=A6K88WcChbCNhfKxt/hC71H+aKecDXN0yZaU+lUMOEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RzvPLCGKSp4MkrdoGlE4GFOdt2UfzG6Qh7oUpsPzROZfcI0hhbmSnsHBT8n9TvemstuVFchjflUg6/yrTspFzSnMrKWxdFQI87SjP/5MEs8X2xbtSaNkAEhnEts79Ln/MAmGmQtHHlYQafFQBkKPK4X0XPRK0Zal9lhQkD1WkbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OOSj8Sdb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756803398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lImTkCvs1XMwtayZpeMnD+gBReBeYA5Sp6xX4F8BQTI=;
	b=OOSj8Sdbc/sXvr0uDgGXF078Lzjvym0EySROqlfSpGrGbf9/flQXsJmRFW5QAZ4JoIix8R
	W4ruY+YEJCHf7hF50xwOcf/5fHJuLCsENbT17F5C9iFv36cvdEMiD+dDaUHJBJSo8BzVt6
	zkl30J7TdtiNtnp0QfAgHn3glfMuW/g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-2IKWwd13OXmn9HoOODqgQw-1; Tue, 02 Sep 2025 04:56:36 -0400
X-MC-Unique: 2IKWwd13OXmn9HoOODqgQw-1
X-Mimecast-MFC-AGG-ID: 2IKWwd13OXmn9HoOODqgQw_1756803396
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70de52d2904so126167906d6.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 01:56:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756803396; x=1757408196;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lImTkCvs1XMwtayZpeMnD+gBReBeYA5Sp6xX4F8BQTI=;
        b=i3jrOF2fH40ThLj/f1y8bDy+VSAuXU3nCeOBlkS/bk2Rdg19VzXRDe7DqUuWwKj8Nn
         /xkLfFBRHa2zYR7xImOgEwNfqc1ZE4YxD5n89sNvTK+ji9nx3IcmtjjLMmTHcA+dLMeD
         V7kI85HwcArPpdW6J/84ew5ikDFd9p4KGiCaok8Ii6EvP/CrOEF1fvnr2sSP+y9gYcu0
         IeF5KPPhOyYJKCMfTHKIdd9gtsGUSKHerHt2ALK3bnz2SsD5AkRtfterxsK2IJLjFUDA
         ovrkCntPcd0YNBqLBGx5KTTGY8kZc8Fy9SszpBVdQzp13lDHWaADA/jeopg6XwcVsl55
         E0Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWdz7I/3byQ2xTTUynZ9D9meypOfYt+wsY7DPq+hE5o9Cw66x3MAdS5tR/ECh2RVIfIv5lNKiPkITPJzuCzwGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0aRI06kzfy6AjrjovrfDkSX7ip0aAjlowotdcI9oKMGJF205
	jrhXLLYA4t1YIBU5ruIvia9LIobGzeYjvv2lLH8FTToRyqKoydpPLhCTYU08YtZncZC3uVc2hfT
	R4F4KIravklo2pW6ZZt+tfn+SAlMAER2FpZNVmqPQYFNEO2I003AUYIwhfby8/hAnTiq8
X-Gm-Gg: ASbGncsfMnnONoo8eX/Mu5JOTH8r+mtYlQM27pZk93eYE2k4EbI1Ad4s2KuCebKN0/Z
	UxB51/pGKSMJCX2uSJMf8WYSkfISyqsoeGADvUAD61RYZ9sZHvjWorKL29jc5VgJKyAltLG12Ra
	+Vw/sqt/7Js4K4YG5h+5sxwEYkTQDlt7FYH57KSTdYuZosddinTLxxZopCulEK/qrd6vlZYG+GU
	tbrDSgWtylTYaR0xQB4hZxv0cNWIRqXYSoTEaOb3sQDlZTVfJI9PyrD9ZrgaCp0eLMno2RqO6US
	udRWGI32TkKuCbHQSzn5Qtl5ONwdLPsbU2E=
X-Received: by 2002:ad4:5c4c:0:b0:718:ee5e:a360 with SMTP id 6a1803df08f44-718ee5ea558mr69268816d6.30.1756803396254;
        Tue, 02 Sep 2025 01:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6gmfnqL14RyPQXyc1ORuNcdh31l1y3psF0bOrlARcUXY0vC+jQr5wYcNzKa22lIpYqk2Gbg==
X-Received: by 2002:ad4:5c4c:0:b0:718:ee5e:a360 with SMTP id 6a1803df08f44-718ee5ea558mr69268596d6.30.1756803395793;
        Tue, 02 Sep 2025 01:56:35 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b5b9c7e1sm8312216d6.58.2025.09.02.01.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:56:35 -0700 (PDT)
Message-ID: <76f6ed83-48a2-4dad-9229-1169050e9552@redhat.com>
Date: Tue, 2 Sep 2025 10:56:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test kfunc bpf_strcasecmp
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756798860.git.rtoax@foxmail.com>
 <tencent_00107416F7259ACAC62BF8681F22B5C19D06@qq.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <tencent_00107416F7259ACAC62BF8681F22B5C19D06@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/25 09:55, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Add testsuites for kfunc bpf_strcasecmp.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
>  tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
>  tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 5 +++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> index 53af438bd998..99d72c68f76a 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> @@ -31,6 +31,8 @@ char *invalid_kern_ptr = (char *)-1;
>  /* Passing NULL to string kfuncs (treated as a userspace ptr) */
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_null1(void *ctx) { return bpf_strcmp(NULL, "hello"); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx) { return bpf_strcmp("hello", NULL); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
> +SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *ctx) { return bpf_strcasecmp("HELLO", NULL); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) { return bpf_strchr(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ctx) { return bpf_strchrnul(NULL, 'a'); }
>  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx) { return bpf_strnchr(NULL, 1, 'a'); }
> @@ -49,6 +51,8 @@ SEC("syscall")  __retval(USER_PTR_ERR)int test_strnstr_null2(void *ctx) { return
>  /* Passing userspace ptr to string kfuncs */
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr1(void *ctx) { return bpf_strcmp(user_ptr, "hello"); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *ctx) { return bpf_strcmp("hello", user_ptr); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(void *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
> +SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(void *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *ctx) { return bpf_strchr(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
>  SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
> @@ -69,6 +73,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strnstr_user_ptr2(void *ctx) { re
>  /* Passing invalid kernel ptr to string kfuncs should always return -EFAULT */
>  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault1(void *ctx) { return bpf_strcmp(invalid_kern_ptr, "hello"); }
>  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx) { return bpf_strcmp("hello", invalid_kern_ptr); }
> +SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
> +SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
>  SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) { return bpf_strchr(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ctx) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
>  SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx) { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> index 89fb4669b0e9..e41cc5601994 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> @@ -7,6 +7,7 @@
>  char long_str[XATTR_SIZE_MAX + 1];
>  
>  SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp(long_str, long_str); }
> +SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_strcasecmp(long_str, long_str); }

This is not sufficient, you also need to update
prog_tests/string_kfuncs.c so that the test case is actually triggered.

Viktor

>  SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr(long_str, 'b'); }
>  SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_strchrnul(long_str, 'b'); }
>  SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnchr(long_str, sizeof(long_str), 'b'); }
> diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> index 46697f381878..67830456637b 100644
> --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> @@ -12,6 +12,11 @@ char str[] = "hello world";
>  /* Functional tests */
>  __test(0) int test_strcmp_eq(void *ctx) { return bpf_strcmp(str, "hello world"); }
>  __test(1) int test_strcmp_neq(void *ctx) { return bpf_strcmp(str, "hello"); }
> +__test(0) int test_strcasecmp_eq1(void *ctx) { return bpf_strcasecmp(str, "hello world"); }
> +__test(0) int test_strcasecmp_eq2(void *ctx) { return bpf_strcasecmp(str, "HELLO WORLD"); }
> +__test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(str, "HELLO world"); }
> +__test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(str, "hello"); }
> +__test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(str, "HELLO"); }
>  __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e'); }
>  __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\0'); }
>  __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strchr(str, 'x'); }


