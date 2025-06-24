Return-Path: <linux-kselftest+bounces-35673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C1EAE5F05
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 10:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2212C4A28F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C68257431;
	Tue, 24 Jun 2025 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxqZ/xOc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C8A2571DD
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753349; cv=none; b=Z0QNfx/84cVdLtYIBh4HwE3SyYlESWeqVRT1oX+JiDrXOLYZvoM5U7Muma952EMXfVl/qlDqRXNHzHrI4ja9bOItOuQmH4BNwOEK2BqbJROnxLr+rl3po7TFJJdUe5Cnw+MVG0gJz3aHsaRQSAzVuf1GpkEd/6mDgrusgo8m50E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753349; c=relaxed/simple;
	bh=qlUbqBvMmD0e21BzZEmQ46rc1md+uea2WjfHV3BcNpo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UmneiKmkQImZx5/mI418Zk7c2w1H8X29vVbl1qrnYJClVKCiprvVTfcuUISEEwdzm1YgRoAJWyJQKs7d7rRGD7j123o3B3cmXu/PxCqXXTUGc92jdmwJ7D2zeuX4b3TnaRqVak0AJXzuUZi16xHOXBRKEgmbs/unrWB57iCXukk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxqZ/xOc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750753346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZAXW2ObNiN166AVHQG+rchufqfO943ZmrYW+Xoift3g=;
	b=DxqZ/xOcPVwihoCauJdK5jKyRhCLa/UEA3ZfxwGrXggHASFizJCUcRsizs/DgN6JGdKl92
	UWUj4GulkwgfBtO/cKXVA71Nta+9Agv15pyhD7UsW/sLx8pR3nLKqC/Y4OV3SvXGtnJnRi
	1ZFU4Nej8z3lLzgZoDdCOyx8Vwh+I70=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-MOtH4_KkMAKTB9VYwCw6xA-1; Tue, 24 Jun 2025 04:22:22 -0400
X-MC-Unique: MOtH4_KkMAKTB9VYwCw6xA-1
X-Mimecast-MFC-AGG-ID: MOtH4_KkMAKTB9VYwCw6xA_1750753341
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3397403f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 01:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753341; x=1751358141;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZAXW2ObNiN166AVHQG+rchufqfO943ZmrYW+Xoift3g=;
        b=tSXZljqW/EiT9IFBj/DilnsLP/rVaYMF5gYn//u4xF4ijPBlqe1dHKsDZ8BKnOeTbY
         ZZPavFOE9lQvP5Lc8ZmFfllPbomVpqViOETgPMkrGHWPYs7olQck0Ek7RyLCyKSl9chw
         lmR1wmLAnttERgmDwF2H2Lw3wrsrQwZX2BJT97c1RJ8iMPFfJMDHe90Gh8CPEqOjQiic
         X6kLMwifgiPk+5sP374RlKW6ky+Hij4caqJyeteFmRunDPn9u/8pRwjwk4dwNj2iFE2n
         rawf4p1JYtKgNbdzOSo6fME8lAJaF4jqFodBYctSSb+ASJaxDT5ThlBKwyXA8NVvYe9Q
         juLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT7XEo45Chg12se4bGfEabH1cpuI1MQX13i3uJPDJJJfCpL8HSZAP9wDJWEegAnkjUWBXi0aWBF64CogqIdAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0YeDPjeRt4HNmj0KnmuJq1cBamBshRwvfMff7bH13H/te6Go
	bHdSkLVLfoK3iEx3W1wsr0b2tESEPxq3SNsmwe7zIzzTkYi3TI+i+CxO/7qB5s5tnB+NJCjVuFt
	UaZ1e5Rd/qJx3sgHxKmFbfEeoAa+gLt0LWhS1o9zFslJeX2EmtbvfggHD+xtghuE8YWWUYg==
X-Gm-Gg: ASbGnctcCHYTTq5xumecdHWg3ZS+BtBdlZ1j/NGWy4nm1mJb8dfd0o3bdOoX/2jg3vM
	+DLURLqdQq5RGGgUbTk8EvSoRoXoOH6y2VWnQDrOzZU1whlqsol2rZ1VEoKp0GW2oBlEcwEn/Hx
	1L0DWGveV0JpBZxxl1Jci3t7prKqhs4lKazaAYezpMLLumCtiqzduaLNWvPy9Uu/0TpGFrahK6C
	2WEHjMqzz+EDBvjU/HtKRgxHn6uKhXPnKOJ0FMds9AM6JZtE70ccFZgVLk711ThkRofAbzbsoPn
	+0H4AwEJSvaSpVNyhBUgLkvcauWwS1Ng7YtI
X-Received: by 2002:a05:6000:4818:b0:3a4:d5e8:e352 with SMTP id ffacd0b85a97d-3a6d128a386mr10194272f8f.7.1750753341349;
        Tue, 24 Jun 2025 01:22:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJk9fm5NnEZ3d5fgmv/9SQmTP12jUT0gCEVu6gFtISRKkse6hnpFAZd9PlyMEhYMbx1MRCVQ==
X-Received: by 2002:a05:6000:4818:b0:3a4:d5e8:e352 with SMTP id ffacd0b85a97d-3a6d128a386mr10194241f8f.7.1750753340881;
        Tue, 24 Jun 2025 01:22:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:84::108? (mischulz23.caps.cit.tum.de. [2a09:80c0:84::108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453632312a3sm144304825e9.1.2025.06.24.01.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 01:22:20 -0700 (PDT)
Message-ID: <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
Date: Tue, 24 Jun 2025 10:22:19 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
From: David Hildenbrand <david@redhat.com>
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
References: <20250622081035.378164-1-liwang@redhat.com>
 <20250624042411.395285-1-liwang@redhat.com>
 <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.25 10:07, David Hildenbrand wrote:
> On 24.06.25 06:24, Li Wang wrote:
>> The current implementation of test_unmerge_uffd_wp() explicitly sets
>> `uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP` before calling
>> UFFDIO_API. This can cause the ioctl() call to fail with EINVAL on kernels
>> that do not support UFFD-WP, leading the test to fail unnecessarily:
>>
>>     # ------------------------------
>>     # running ./ksm_functional_tests
>>     # ------------------------------
>>     # TAP version 13
>>     # 1..9
>>     # # [RUN] test_unmerge
>>     # ok 1 Pages were unmerged
>>     # # [RUN] test_unmerge_zero_pages
>>     # ok 2 KSM zero pages were unmerged
>>     # # [RUN] test_unmerge_discarded
>>     # ok 3 Pages were unmerged
>>     # # [RUN] test_unmerge_uffd_wp
>>     # not ok 4 UFFDIO_API failed     <-----
>>     # # [RUN] test_prot_none
>>     # ok 5 Pages were unmerged
>>     # # [RUN] test_prctl
>>     # ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
>>     # # [RUN] test_prctl_fork
>>     # # No pages got merged
>>     # # [RUN] test_prctl_fork_exec
>>     # ok 7 PR_SET_MEMORY_MERGE value is inherited
>>     # # [RUN] test_prctl_unmerge
>>     # ok 8 Pages were unmerged
>>     # Bail out! 1 out of 8 tests failed
>>     # # Planned tests != run tests (9 != 8)
>>     # # Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0
>>     # [FAIL]
>>
>> This patch improves compatibility and robustness of the UFFD-WP test
>> (test_unmerge_uffd_wp) by correctly implementing the UFFDIO_API
>> two-step handshake as recommended by the userfaultfd(2) man page.
>>
>> Key changes:
>>
>> 1. Use features=0 in the initial UFFDIO_API call to query supported
>>      feature bits, rather than immediately requesting WP support.
>>
>> 2. Skip the test gracefully if:
>>      - UFFDIO_API fails with EINVAL (e.g. unsupported API version), or
>>      - UFFD_FEATURE_PAGEFAULT_FLAG_WP is not advertised by the kernel.
>>
>> 3. Close the initial userfaultfd and create a new one before enabling
>>      the required feature, since UFFDIO_API can only be called once per fd.
>>
>> 4. Improve diagnostics by distinguishing between expected and unexpected
>>      failures, using strerror() to report errors.
>>
>> This ensures the test behaves correctly across a wider range of kernel
>> versions and configurations, while preserving the intended behavior on
>> kernels that support UFFD-WP.
>>
>> Suggestted-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Li Wang <liwang@redhat.com>
>> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
>> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Joey Gouly <joey.gouly@arm.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Keith Lucas <keith.lucas@oracle.com>
>> Cc: Ryan Roberts <ryan.roberts@arm.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> ---
>>
>> Notes:
>>       v1 --> v2:
>>       	* Close the original userfaultfd and open a new one before enabling features
>>       	* Reworked UFFDIO_API negotiation to follow the official two-step handshake
>>
>>    .../selftests/mm/ksm_functional_tests.c       | 28 +++++++++++++++++--
>>    1 file changed, 26 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
>> index b61803e36d1c..19e5b741893a 100644
>> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
>> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
>> @@ -393,9 +393,13 @@ static void test_unmerge_uffd_wp(void)
>>    
>>    	/* See if UFFD-WP is around. */
>>    	uffdio_api.api = UFFD_API;
>> -	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
>> +	uffdio_api.features = 0;
>>    	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
>> -		ksft_test_result_fail("UFFDIO_API failed\n");
>> +		if (errno == EINVAL)
>> +			ksft_test_result_skip("The API version requested is not supported\n");
>> +		else
>> +			ksft_test_result_fail("UFFDIO_API failed: %s\n", strerror(errno));
>> +
> 
> Not sure if that is really required. If UFFDIO_API failed after
> __NR_userfaultfd worked something unexpected is happening.
> 
>>    		goto close_uffd;
>>    	}
>>    	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
>> @@ -403,6 +407,26 @@ static void test_unmerge_uffd_wp(void)
>>    		goto close_uffd;
>>    	}
>>    
>> +	/*
>> +	 * UFFDIO_API must only be called once to enable features.
>> +	 * So we close the old userfaultfd and create a new one to
>> +	 * actually enable UFFD_FEATURE_PAGEFAULT_FLAG_WP.
>> +	 */
>> +	close(uffd);
> 
> Is that actually required?
> 
> The man page explicitly documents:
> 
> "       EINVAL A  previous  UFFDIO_API  call already enabled one or more
> features for this userfaultfd.  Calling UFF‐
>                 DIO_API twice, the first time with no features set, is
> explicitly allowed as per the two-step  feature
>                 detection handshake.
> "
> 
> So if that doesn't work, something might be broken.

CCing Nadav and Peter:

Could it be that

commit 22e5fe2a2a279d9a6fcbdfb4dffe73821bef1c90
Author: Nadav Amit <nadav.amit@gmail.com>
Date:   Thu Sep 2 14:58:59 2021 -0700

     userfaultfd: prevent concurrent API initialization
     
     userfaultfd assumes that the enabled features are set once and never
     changed after UFFDIO_API ioctl succeeded.
     
     However, currently, UFFDIO_API can be called concurrently from two
     different threads, succeed on both threads and leave userfaultfd's
     features in non-deterministic state.  Theoretically, other uffd operations
     (ioctl's and page-faults) can be dispatched while adversely affected by
     such changes of features.
     
     Moreover, the writes to ctx->state and ctx->features are not ordered,
     which can - theoretically, again - let userfaultfd_ioctl() think that
     userfaultfd API completed, while the features are still not initialized.
     
     To avoid races, it is arguably best to get rid of ctx->state.  Since there
     are only 2 states, record the API initialization in ctx->features as the
     uppermost bit and remove ctx->state.

Accidentally broke the documented two-step handshake in the man page where we
can avoid closing + reopening the fd?

Without testing, the following might fix it if I am right:

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22f4bf956ba1c..f03e7c980e1c5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1944,9 +1944,9 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
  static int userfaultfd_api(struct userfaultfd_ctx *ctx,
                            unsigned long arg)
  {
+       unsigned int new_features, old_features = 0;
         struct uffdio_api uffdio_api;
         void __user *buf = (void __user *)arg;
-       unsigned int ctx_features;
         int ret;
         __u64 features;
  
@@ -1990,9 +1990,12 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
                 goto out;
  
         /* only enable the requested features for this uffd context */
-       ctx_features = uffd_ctx_features(features);
+       new_features = uffd_ctx_features(features);
+       /* allow two-step handshake */
+       if (userfaultfd_is_initialized(ctx))
+               old_features = UFFD_FEATURE_INITIALIZED;
         ret = -EINVAL;
-       if (cmpxchg(&ctx->features, 0, ctx_features) != 0)
+       if (cmpxchg(&ctx->features, old_features, new_features) != old_features)
                 goto err_out;
  
         ret = 0;


-- 
Cheers,

David / dhildenb


