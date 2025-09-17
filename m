Return-Path: <linux-kselftest+bounces-41668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8940B7CDA8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CFB1775E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 10:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B929B76F;
	Wed, 17 Sep 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTnkE6Ae"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CC285CA1
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106291; cv=none; b=jTE1q7/mTsyHMNmMYBXsNOY4K/4Z7ieZRdCxd8TFoZ0MD/j3yq/q4Cfqi+ud0Q0e0eMkdS2sbbjSmstbgaCTmvgQlm6lPyatQUYIjyoQwFoB7+3pwN8q+OZCMnvxz3zhpxgtKJPxMzf3H2E55c5K7F2lTl7MrGawVjPqw3TiMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106291; c=relaxed/simple;
	bh=P5xwqq9hlIAvFrIe+NtVkLGw6BsTyX4DcHVXOMN4a8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G9/ZlYmw9lKgugJz0Nk/9ni9EhL+j7NRf+orLzmTrVwBDW/2JO/hr7xsooRan3WoO13FKgREInfDXlNOBlcJ3byFqlZRd2qF2iyzQK6dgrZZyuavX0DsoSdy40DZf54LbkIkt6kK59NA2VGt94mwYFqhdZwUJAS4LC0JbV/FnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTnkE6Ae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758106288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nERaJxhjcjrAaXh7c6wWUw3HqICZEnqzuOIyghOUsOY=;
	b=jTnkE6AegwR+1c8VnUzW+V1tTRE1urB0pXFMCR3TRZEUKFoaiOgOZrAMWHVdwRyEsOU8lH
	FOfyRtBdrn+EzOQqVHzJyqGRuqucX+G8rRKnpY6TBTsSN+WzvW3ECKVmeEHam0KtfbjL4j
	AlDVQSdTdZD2dWYKKYGaOGhQESJB7Cc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-k7buvRkYMZKyCi8DCulwVg-1; Wed, 17 Sep 2025 06:51:26 -0400
X-MC-Unique: k7buvRkYMZKyCi8DCulwVg-1
X-Mimecast-MFC-AGG-ID: k7buvRkYMZKyCi8DCulwVg_1758106285
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b990eb77cso6344605e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 03:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758106285; x=1758711085;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nERaJxhjcjrAaXh7c6wWUw3HqICZEnqzuOIyghOUsOY=;
        b=BBNSx4uyELnxcLKyj1M1N+qcgMCT7kURDd+PLMFQGruMyLrR/KIZUigJq62l7i7MjV
         wNyaskmAcwhzWnEuqyrHY40Zp5177NhhYcCxWj2slup1Xnwn+tKldJE22RaTrRVIWX6q
         MyLHZf8oVXbAcjWuuVKOh8SIlEFIIAioEm9XQot9wHlvo4L3rLS/9QU1i+vUHEk6MUR3
         jaRizvDtShqrPOo5A1iAIQ1IQfO+kyNjku3JzDWU89sUgtJm/xpFo48mtSCRbTzWPhHj
         cA79EhjxanyTIWg7Hqc4UJG7YY0yh6z4OirCYipHxLRAopJlg3sI/Tq5JUGkQ69PyFd9
         BSZw==
X-Forwarded-Encrypted: i=1; AJvYcCXYXc/d8oa9OfrZx0lj+KTzC138PCK0/MKsxYYONgzJ9GGrCT70cr+Dp34AY+B/iLgcGPU6nE9nQMKXtab6BNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9QvzQ+3TmVUUMiv/fqoXQcf9kGRZaS9ry0TLvorFna+fw6R8
	Y2rLXcgXEYTAHLhR2kJGafuGLbhyecTXdB4l5CK7pRiz8LwtthxHpL9lcG1cLGzdpx5DYlqEaLT
	ZzA2kb/3l1G/dEMZHNjUdNVGQieL0O5WTnwBq/7YqOrbqowkffUScILGh5bxFdbagN0E6Xg==
X-Gm-Gg: ASbGnctximMoueyuiIMXL9OGWRfKnDB2n27NOIjNda7lRR1kZ9oGZfmleiSWv6aUpu5
	l0T8eqauOg6fDxBKEu9wUkFqCyzKqbsqwVc1LGiP4f3kB2sf18XP3MujERcTlHv9C0f88KgdBP8
	9SeBKuXvrIbhyDEsPJCcExb6LIc2hYQpEdF1YWfgJrieIk8nFVVihKKl36aqDixCo15kB70BUm1
	ErTi4TgD/LJiZdu5Tf3tQh7UM+T7MaOKnCLXIfUhPgWItw43PHftOKRoD4K4NhsnZTWBZFLrpb6
	RRNe4sLzCCt1ahDQo0QiAU9ofUqQgYDG5iT3T91s0nGPNBT2yxS3Cr/48HpGrJYSki1QVtuL5pg
	HWJgTZKuCZxucvq/SbwTD9cV9YZOY6tUtHhsLHE98W+oQaSC3aA+Q8/CaBT23S4fg
X-Received: by 2002:a05:600c:12ca:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-462d73e52f9mr7092345e9.6.1758106285440;
        Wed, 17 Sep 2025 03:51:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ZygKbzExyxPazwktd3Op+PMSIyLXZ5fVLowDy+xVLe7/9FL4ydneS0ztJyucS3gyZvcYNA==
X-Received: by 2002:a05:600c:12ca:b0:45b:86bb:af5f with SMTP id 5b1f17b1804b1-462d73e52f9mr7092025e9.6.1758106284912;
        Wed, 17 Sep 2025 03:51:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f27:6d00:7b96:afc9:83d0:5bd? (p200300d82f276d007b96afc983d005bd.dip0.t-ipconnect.de. [2003:d8:2f27:6d00:7b96:afc9:83d0:5bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613ddc01e6sm30967065e9.18.2025.09.17.03.51.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:51:24 -0700 (PDT)
Message-ID: <353bf8f0-d9ad-4800-80d7-4177ae64eb95@redhat.com>
Date: Wed, 17 Sep 2025 12:51:23 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 1/1] selftests/mm: skip soft-dirty tests when
 CONFIG_MEM_SOFT_DIRTY is disabled
To: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com
Cc: shuah@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250917055913.49759-1-lance.yang@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250917055913.49759-1-lance.yang@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.25 07:59, Lance Yang wrote:
> From: Lance Yang <lance.yang@linux.dev>
> 
> The madv_populate and soft-dirty kselftests currently fail on systems where
> CONFIG_MEM_SOFT_DIRTY is disabled.
> 
> Introduce a new helper softdirty_is_supported() into vm_util.c/h to ensure
> tests are properly skipped when the feature is not enabled.

I'll note that tools/testing/selftests/mm/config contains

	CONFIG_MEM_SOFT_DIRTY=y

But yes, the current arm64 handling is nasty, because some other archs 
(e.g., riscv) also don't support it yet.

LGTM, some nits below:

> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lance Yang <lance.yang@linux.dev>
> ---
>   tools/testing/selftests/mm/madv_populate.c | 21 ++--------------
>   tools/testing/selftests/mm/soft-dirty.c    |  5 +++-
>   tools/testing/selftests/mm/vm_util.c       | 28 ++++++++++++++++++++++
>   tools/testing/selftests/mm/vm_util.h       |  1 +
>   4 files changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index b6fabd5c27ed..43dac7783004 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -264,23 +264,6 @@ static void test_softdirty(void)
>   	munmap(addr, SIZE);
>   }
>   
> -static int system_has_softdirty(void)
> -{
> -	/*
> -	 * There is no way to check if the kernel supports soft-dirty, other
> -	 * than by writing to a page and seeing if the bit was set. But the
> -	 * tests are intended to check that the bit gets set when it should, so
> -	 * doing that check would turn a potentially legitimate fail into a
> -	 * skip. Fortunately, we know for sure that arm64 does not support
> -	 * soft-dirty. So for now, let's just use the arch as a corse guide.
> -	 */
> -#if defined(__aarch64__)
> -	return 0;
> -#else
> -	return 1;
> -#endif
> -}
> -
>   int main(int argc, char **argv)
>   {
>   	int nr_tests = 16;
> @@ -288,7 +271,7 @@ int main(int argc, char **argv)
>   
>   	pagesize = getpagesize();
>   
> -	if (system_has_softdirty())
> +	if (softdirty_is_supported())
>   		nr_tests += 5;
>   
>   	ksft_print_header();
> @@ -300,7 +283,7 @@ int main(int argc, char **argv)
>   	test_holes();
>   	test_populate_read();
>   	test_populate_write();
> -	if (system_has_softdirty())
> +	if (softdirty_is_supported())
>   		test_softdirty();
>   
>   	err = ksft_get_fail_cnt();
> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index 8a3f2b4b2186..98e42d2ac32a 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -200,8 +200,11 @@ int main(int argc, char **argv)
>   	int pagesize;
>   
>   	ksft_print_header();
> -	ksft_set_plan(15);
>   
> +	if (!softdirty_is_supported())
> +		ksft_exit_skip("soft-dirty is not support\n");
> +
> +	ksft_set_plan(15);
>   	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
>   	if (pagemap_fd < 0)
>   		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
> diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
> index 56e9bd541edd..3173335df775 100644
> --- a/tools/testing/selftests/mm/vm_util.c
> +++ b/tools/testing/selftests/mm/vm_util.c
> @@ -449,6 +449,34 @@ bool check_vmflag_pfnmap(void *addr)
>   	return check_vmflag(addr, "pf");
>   }
>   
> +bool softdirty_is_supported(void)

I'd just call it "softdirty_supported" similar to 
"pagemap_scan_supported()".

> +{
> +	char *addr;
> +	int ret = 0;

bool supported = false;

> +	size_t pagesize;
> +
> +	/* We know for sure that arm64 does not support soft-dirty. */
> +#if defined(__aarch64__)
> +	return ret;
> +#endif

Just drop this arm special case now.

> +	pagesize = getpagesize();

const size_t pagesize = getpagesize();

> +	/*
> +	 * __mmap_complete() always sets VM_SOFTDIRTY for new VMAs, so we
> +	 * just mmap a small region and check its VmFlags in /proc/self/smaps
> +	 * for the "sd" flag.
> +	 */

/* New mappings are expected to be marked with VM_SOFTDIRTY (sd). */

> +	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
> +		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> +	if (!addr)
> +		ksft_exit_fail_msg("mmap failed\n");
> +
> +	if (check_vmflag(addr, "sd"))
> +		ret = 1;

supported = true;

> +
> +	munmap(addr, pagesize);
> +	return ret;
> +}
> +

-- 
Cheers

David / dhildenb


