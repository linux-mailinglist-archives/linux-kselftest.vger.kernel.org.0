Return-Path: <linux-kselftest+bounces-35606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78E9AE3866
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 10:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1B0188C63A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1622D4C0;
	Mon, 23 Jun 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cy//k0Yp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A1211C
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750667620; cv=none; b=O5A6dttN8exd+ZX/EAgcf9bwc0p4QIBaiOHD8H9/ij+vGThE5hwK+7HGw1f71znUwS8vBkCUV/7eF8HemD2h86jH3OrIYVKYGRD2WlshkGAfEW/mNsVv0rUGG82zx2tjrPw/SRtFhde/CY1S9fUNNoHF+3/MLMUQgaxC6IwK6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750667620; c=relaxed/simple;
	bh=9m94uQJSiCXnY7//UgNH+rQhmcSjtMU+IgNkB9l4Vgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q9tizxb1GrH3aBIF1edvbhZ2slJuhC0lk1Rs++EaQJwJEsXGHt8J8A2hCEIEuQ20BylLGJaZhyIj3ozFEP24H+OFxNaigZTFqrVQMZ9Ol6nEDO8pc15HVtGF43kVlryrx0f/vN4/cWFC6IWiWVHAMJe4ijoROtBRChCBb8vmDmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cy//k0Yp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750667618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3+npad/odQqphVJbiB+rZH6xk0guAOkaC0w0dlFOsa4=;
	b=cy//k0YpOGlACDPwOi2nsGcTTDt7SvlqjldG2bJZs5wRVJ9y1RVXZ6FVqy9uWF6FlFgmGe
	ZdLpr68F1e2zlRkO1O85tYmAWjdXmynxBybRBv0wF7xxXsoQatvSjySkyh7u6Mdz752+vA
	85JrVjTMuUx3n6hrefX8gG27g7Z9iNQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-e3iEq5F5MAaNr-SsKVP2WA-1; Mon, 23 Jun 2025 04:33:35 -0400
X-MC-Unique: e3iEq5F5MAaNr-SsKVP2WA-1
X-Mimecast-MFC-AGG-ID: e3iEq5F5MAaNr-SsKVP2WA_1750667614
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4530c186394so17312915e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 01:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750667614; x=1751272414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3+npad/odQqphVJbiB+rZH6xk0guAOkaC0w0dlFOsa4=;
        b=G/oEm8uk2OAdc8u/Tfn1hdKqwZyytoBaQGNj/RVm/O72giOy79LNJ2GFiLtBxnMdzi
         svzNfzTMD7OhYBNOgAh2zo/zilK43+ytyyKcszRetndbz4GPjueahoIM9DxON355bSEN
         2WX2qQdHyfYcEIOkoaMI2Og1YFQhGzMRdQtP/lOweWED06tLoJbltQ1YgtedLAHC3Db8
         f02T5DGYPgTN+3An9bz3twJFrSaFwMPuQyj4bYzzZqedh7Q/Fua2smncmQAjsJu4kxkN
         B9Exr0RNC6qg3epRAS3Uz6FcAHst396JvKnkx5flvGhquQE/tcD2041+8DktWqGMW+9H
         0vGA==
X-Forwarded-Encrypted: i=1; AJvYcCX3anv1qnUCVkpx1J2CjMckwaOIOkLJiYrdjSm5IEXdJkP/6BIaPOD5yi+o7oEwrxXqSQG9zM8w/KNpk/nJzdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuH8OtdMG90egooQgo2dlIYqgyqqlt01uBhoQ4tzxgqelAnhZT
	fwIqFTjW5EIQND5EuZlVOnjIM2AY08KwlbNvNKUU2W+NLhmEWJwJUfDvwaodk2OA0n/djy8u6pU
	swf1JjLRa38C46gPw5nq9dMO6j7YLip96C8f51BuEIzwMYzCpHftWNkkrYfFpCq7UTLPDjA==
X-Gm-Gg: ASbGncs4sOuWDimEw58Sv12E1tu8JQU7HW81ipX0NUtiQLHEm2NQps5w6l+VqBV+hyy
	24zFAauaHtGjXTQ8MoquVVgVF9TPHpxkM51TdNOkstZdzeG/9P6IaD9D+avfG55deV0SMBazvao
	xAi5WH1NKHyfMIomcUnEqk0mYKQB2xSLZp3B/C1Y4i9wdR8zxD18QKaEYNLGO2EwvB+kn1XmVnI
	Nb3q0DsKB/KhDqcKxPl0LjSr51n+jPjykHm4mzNhbs0+ulPowITXYPW+cViUCZY50so+v5ZGCe/
	HizEhamBZoMnnjhEsBmE6CmXGBzGNA4IugO0gdm1IoBCTfJzQgp6xYkJgRMmNg/Hkh0zsJsH27M
	Pj9eSy0vc4HbfmLpbgpojP0T8HwyR8NE0aA8zm6KJZuqBav/xAA==
X-Received: by 2002:a05:600c:81c8:b0:441:d4e8:76cd with SMTP id 5b1f17b1804b1-453659f6a8cmr109834635e9.29.1750667614347;
        Mon, 23 Jun 2025 01:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVA500VKWrMeirc3PvoA8BjNGub6mQK+nWWl3iBoZR+AeysXOc0nTX+nZuUKIriBmKwAv1MQ==
X-Received: by 2002:a05:600c:81c8:b0:441:d4e8:76cd with SMTP id 5b1f17b1804b1-453659f6a8cmr109834275e9.29.1750667613899;
        Mon, 23 Jun 2025 01:33:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453647082a2sm103293925e9.37.2025.06.23.01.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 01:33:33 -0700 (PDT)
Message-ID: <ce92ebb5-92fd-47e0-a7f6-445655e60999@redhat.com>
Date: Mon, 23 Jun 2025 10:33:30 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/selftests: improve UFFD-WP feature detection in KSM
 test
To: Li Wang <liwang@redhat.com>, akpm@linux-foundation.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
References: <20250622081035.378164-1-liwang@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250622081035.378164-1-liwang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22.06.25 10:10, Li Wang wrote:
> The current implementation of test_unmerge_uffd_wp() explicitly sets
> `uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP` before calling
> UFFDIO_API. This can cause the ioctl() call to fail with EINVAL on kernels
> that do not support UFFD-WP, leading the test to fail unnecessarily:
> 
>    # ------------------------------
>    # running ./ksm_functional_tests
>    # ------------------------------
>    # TAP version 13
>    # 1..9
>    # # [RUN] test_unmerge
>    # ok 1 Pages were unmerged
>    # # [RUN] test_unmerge_zero_pages
>    # ok 2 KSM zero pages were unmerged
>    # # [RUN] test_unmerge_discarded
>    # ok 3 Pages were unmerged
>    # # [RUN] test_unmerge_uffd_wp
>    # not ok 4 UFFDIO_API failed     <-----
>    # # [RUN] test_prot_none
>    # ok 5 Pages were unmerged
>    # # [RUN] test_prctl
>    # ok 6 Setting/clearing PR_SET_MEMORY_MERGE works
>    # # [RUN] test_prctl_fork
>    # # No pages got merged
>    # # [RUN] test_prctl_fork_exec
>    # ok 7 PR_SET_MEMORY_MERGE value is inherited
>    # # [RUN] test_prctl_unmerge
>    # ok 8 Pages were unmerged
>    # Bail out! 1 out of 8 tests failed
>    # # Planned tests != run tests (9 != 8)
>    # # Totals: pass:7 fail:1 xfail:0 xpass:0 skip:0 error:0
>    # [FAIL]
> 
> This patch improves compatibility and error handling by:
> 
> 1. Changes the feature check to first query supported features (features=0)
>     rather than specifically requesting WP support.
> 
> 2. Gracefully skipping the test if:
>     - UFFDIO_API fails with EINVAL (feature not supported), or
>     - UFFD_FEATURE_PAGEFAULT_FLAG_WP is not advertised by the kernel.
> 
> 3. Providing better diagnostics by distinguishing expected failures (e.g.,
>     EINVAL) from unexpected ones and reporting them using strerror().
> 
> The updated logic makes the test more robust across different kernel versions
> and configurations, while preserving existing behavior on systems that do
> support UFFD-WP.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Joey Gouly <joey.gouly@arm.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Keith Lucas <keith.lucas@oracle.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Shuah Khan <shuah@kernel.org>
> ---
>   tools/testing/selftests/mm/ksm_functional_tests.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index b61803e36d1c..f3db257dc555 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -393,9 +393,13 @@ static void test_unmerge_uffd_wp(void)
>   
>   	/* See if UFFD-WP is around. */
>   	uffdio_api.api = UFFD_API;
> -	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> +	uffdio_api.features = 0;
>   	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> -		ksft_test_result_fail("UFFDIO_API failed\n");
> +		if (errno == EINVAL)
> +			ksft_test_result_skip("UFFDIO_API not supported (EINVAL)\n");
> +		else
> +			ksft_test_result_fail("UFFDIO_API failed: %s\n", strerror(errno));
> +
>   		goto close_uffd;
>   	}
>   	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {


The man page (man UFFDIO_API) documents:

        Since  Linux  4.11,  applications should use the features field to perform a two-step handshake.
        First, UFFDIO_API is called with the features field set to zero.  The kernel responds by setting
        all supported feature bits.

        Applications which do not require any specific features can begin using the userfaultfd  immedi‐
        ately.   Applications which do need specific features should call UFFDIO_API again with a subset
        of the reported feature bits set to enable those features.

So likely, what you want in this patch here is something like:

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index b61803e36d1cf..5cf819ac958d0 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -393,7 +393,7 @@ static void test_unmerge_uffd_wp(void)
  
         /* See if UFFD-WP is around. */
         uffdio_api.api = UFFD_API;
-       uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+       uffdio_api.features = 0;
         if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
                 ksft_test_result_fail("UFFDIO_API failed\n");
                 goto close_uffd;
@@ -403,6 +403,14 @@ static void test_unmerge_uffd_wp(void)
                 goto close_uffd;
         }
  
+       /* Now, enable it ("two-step handshake") */
+       uffdio_api.api = UFFD_API;
+       uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+       if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
+               ksft_test_result_fail("UFFDIO_API failed\n");
+               goto close_uffd;
+       }
+
         /* Register UFFD-WP, no need for an actual handler. */
         if (uffd_register(uffd, map, size, false, true, false)) {
                 ksft_test_result_fail("UFFDIO_REGISTER_MODE_WP failed\n");


-- 
Cheers,

David / dhildenb


