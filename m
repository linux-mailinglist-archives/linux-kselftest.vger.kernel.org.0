Return-Path: <linux-kselftest+bounces-23989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52504A04300
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593E01887072
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 14:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834E1E3DE8;
	Tue,  7 Jan 2025 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBSBUrTU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4112733993
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261095; cv=none; b=R0yDeSi+fAM1vmnaQN0i/ZAzzb2s9VIxunG0BOtxOE5MJ5s0F9OsY31uoaBJATIKLYprncsEzqqn0N2IwyVSv4aES83pajf5uwQ2/5ljqIwBLYuunnqUOjqsi7CSsHypQA6Q8GlLU23EqgG8mbbeRa7hlJyR1iw3MsZKt0D1tZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261095; c=relaxed/simple;
	bh=bvaI3ZSJncwwKImrExqQ54eqSqL/KplIVjh7jEygl0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmSn0JHbQrtbp/LH72YHoxJAraspCmiRdYakvYOj5eWDgnG4t8p0d2K3TKxYMwDJ2MAFezw9LaUiSYLivGPN5P3KFUtNuO+tlxjstoW+PjPJNgVEpk5n+DEvEhp55DLhUf0r5MusKGR+zhpEg3JM8HxoS1s2aaSbFsw0lmKwCF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBSBUrTU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736261092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jk+IhBveK1863xcnAi4gkF5xy6PO211FAhJyJ7RJFvY=;
	b=LBSBUrTUoimqPuD1NifLph1ynNh4KSzEUWgJS5Ob07luUA6bRSfh2jqr9ANVLwrCpLQunA
	g/XAI+RrWtvEdGPeKSOgTnZ47mklO+KPD1eF6tEO78KFBDhciTPy4oYx2bpOoBcXYQamHy
	fahtBvDLEmroS1aBd2K5Yx9LTstSq/k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-TgqZy6hRPc6TqPwDBFmXqw-1; Tue, 07 Jan 2025 09:44:51 -0500
X-MC-Unique: TgqZy6hRPc6TqPwDBFmXqw-1
X-Mimecast-MFC-AGG-ID: TgqZy6hRPc6TqPwDBFmXqw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-436379713baso75841825e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Jan 2025 06:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261090; x=1736865890;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jk+IhBveK1863xcnAi4gkF5xy6PO211FAhJyJ7RJFvY=;
        b=r84Uq2V2lFMmqvs6hsqszl6isbsYoVLkZ3uAystC2ce3r10uEA6CbrZ5HwWoNNlCrF
         n3HxFCNGGkyhszekZP36aM/hWa4SukjeXzb4tY2Wn6qMMMc7ynFbhQufuWdx/Oc0qmDz
         dEyYvrSpcbhAuCZnn2B6RGSHItywS2JLRwr3gln1IvKoIsJpmHe+ZqI65bORsz/Mi+RV
         tcfPW++4wshXnUGZnEt4yk9Gr3zd6HV1dx0BhGs15NfdKtwzeA5zsj/BlL13FvXiHuo6
         S/lhm5+6FNyszxqAOUjkEarIHR/Q3YMzQymWzXSC9VvLkFJ42X9VKnYcsyhAD5Iy8kgt
         /X6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXsp4XVc/4jQnH5kzYtf25ivQ/ch0TeSWg/mpfMmajbHUsrmcNVSUr6r1aEr/D31EWDnAtjz2IwKX+6Ci7t/UM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+s3BSNuRndInjPoXLlwFVP02O2Am1fBG8sykx85K441l450HC
	v7iWnaNRbSMALWe9orrvZW+B+jm7nVwtI8ktXWYWoXLZlqGLzS3ozlVVG9rXwdJKYm3e7eVifR0
	ykyeAr4/Ok4DK30JMo5MscgvYw6Wc3gErSRJqBq7tuSrHwDDP9RruQIqc6KGBbLVi9g==
X-Gm-Gg: ASbGnctDWeQgy9QvIC/NBiLJIBdwG40yIciVwhQz0reERr7rgER5c+bGHCqC+i3RSDG
	h2qfJi/ar6k0pqotTXNpgMfTmSOiR2GgHXmjrc2caAT5IYO1Ge8PYYHMWSbhcawQWy7KjGgwOWq
	gYhTQH/8Sr+x6M7d1lg+rQhqpz0kB0YIRqMQ0mJBJXt9ROKfOqPeEuUJSiNTmbaaKPiJUyCEsmQ
	w2JPAHlaJOZHBUshUjvDTxSUrybVp2qlO9ed7/6gaQBNT1DZ+IidkouCyJ5sDErztIVZqi/xD4z
	dltetvOUv+8mtS9oaOY0a0fGohpepuOdz/GZpX2uiE0oyB8M1pEnm6XywPzN8r1H8r6eQjvTEO1
	x55zl5Jqq
X-Received: by 2002:a05:600c:1d21:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-4366790e3fdmr587229035e9.0.1736261088382;
        Tue, 07 Jan 2025 06:44:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0bheRyAxXgWEalBrfH6Vx8Wp8tRZsTBzk4+e9gnV3N8zoE6oyCZt/eX9AZEbU0psou5ZfFA==
X-Received: by 2002:a05:600c:1d21:b0:434:a4a6:51f8 with SMTP id 5b1f17b1804b1-4366790e3fdmr587228085e9.0.1736261086550;
        Tue, 07 Jan 2025 06:44:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c719:1700:56dc:6a88:b509:d3f3? (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4367086e40esm566646445e9.30.2025.01.07.06.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 06:44:45 -0800 (PST)
Message-ID: <9da0d0a7-c9dc-4ce6-8768-d3aea5c0040e@redhat.com>
Date: Tue, 7 Jan 2025 15:44:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Set allocated memory to non-zero content
 in cow test
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250107142555.1870101-1-ryan.roberts@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250107142555.1870101-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.01.25 15:25, Ryan Roberts wrote:
> After commit b1f202060afe ("mm: remap unused subpages to shared zeropage
> when splitting isolated thp"), cow test cases involving swapping out
> THPs via madvise(MADV_PAGEOUT) started to be skipped due to the
> subsequent check via pagemap determining that the memory was not
> actually swapped out. Logs similar to this were emitted:
> 
>     ...
> 
>     # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (16 kB)
>     ok 2 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>     # [RUN] Basic COW after fork() ... with single PTE of swapped-out THP (16 kB)
>     ok 3 # SKIP MADV_PAGEOUT did not work, is swap enabled?
>     # [RUN] Basic COW after fork() ... with swapped-out, PTE-mapped THP (32 kB)
>     ok 4 # SKIP MADV_PAGEOUT did not work, is swap enabled?
> 
>     ...
> 
> The commit in question introduces the behaviour of scanning THPs and if
> their content is predominantly zero, it splits them and replaces the
> pages which are wholly zero with the zero page. These cow test cases
> were getting caught up in this.
> 
> So let's avoid that by filling the contents of all allocated memory with
> a non-zero value. With this in place, the tests are passing again.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
> 
> Applies on top of mm-unstable (f349e79bfbf3)
> 
> Thanks,
> Ryan
> 
>   tools/testing/selftests/mm/cow.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 32c6ccc2a6be..1238e1c5aae1 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -758,7 +758,7 @@ static void do_run_with_base_page(test_fn fn, bool swapout)
>   	}
> 
>   	/* Populate a base page. */
> -	memset(mem, 0, pagesize);
> +	memset(mem, 1, pagesize);
> 
>   	if (swapout) {
>   		madvise(mem, pagesize, MADV_PAGEOUT);
> @@ -824,12 +824,12 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>   	 * Try to populate a THP. Touch the first sub-page and test if
>   	 * we get the last sub-page populated automatically.
>   	 */
> -	mem[0] = 0;
> +	mem[0] = 1;
>   	if (!pagemap_is_populated(pagemap_fd, mem + thpsize - pagesize)) {
>   		ksft_test_result_skip("Did not get a THP populated\n");
>   		goto munmap;
>   	}
> -	memset(mem, 0, thpsize);
> +	memset(mem, 1, thpsize);
> 
>   	size = thpsize;
>   	switch (thp_run) {
> @@ -1012,7 +1012,7 @@ static void run_with_hugetlb(test_fn fn, const char *desc, size_t hugetlbsize)
>   	}
> 
>   	/* Populate an huge page. */
> -	memset(mem, 0, hugetlbsize);
> +	memset(mem, 1, hugetlbsize);

Interesting, thanks!

"1" should work, because we use "0xff" to detect modifications.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


