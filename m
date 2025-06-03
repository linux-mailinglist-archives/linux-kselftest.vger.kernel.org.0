Return-Path: <linux-kselftest+bounces-34214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B2ACC6C0
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 14:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5903A2DB4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D873422DA02;
	Tue,  3 Jun 2025 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzNfIW+8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F01F237A
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954269; cv=none; b=il8h6+kZsj1bSTApDwLmC3ivFNgOnJjm5owb5tHYAqrL32n37IUOKm//JqhRwAkGd9fkVn7wNPn45yXGUSb4Jn0IuyaDoj0jt7tZZVUpJpZFsHQ6dF35nV67iSkeKlsTosoIaslGYYMSz6V6EjMDRdQaSVVFRZ8/79PuDLhYUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954269; c=relaxed/simple;
	bh=HVxuF/TLh3KWMJoR0FiCFN0I7IF2BxKS9juTKwwH2Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKuYqHTFV46bP3u8b2EdkFG7nwzsPaueHze5duU2Hgx4x/nYT6HTZslUo9Z/4pm7tG9i5PWIcHX9WlpyjxfskSe4jYBvVRuow9L0LspSvoqBjXERyER5nxoiM+kYbQQ6Z5JETbJei1w/XWSW9klqscFZwZ7rtE9gmsKj/w+xktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzNfIW+8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748954266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHS2t2oaHj5ILyKgrMhDZwz0UVPhJxY3OnyQEFGAuCE=;
	b=SzNfIW+8OFJevEbSitgMPuofhiBR+8evR/D+S06q+BRwDv2nPu+yWG05VJUSXm/xyljdEF
	RGwNqpUI0Q/daqUW5nITiDdk/Pem6+X76vqW0eCDBXdN2vATv1JJk8d/dN8ktUwQxQWOVn
	5q+SA8DgcZV9bgGH6nm9l2k50sexPso=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-414z5yJhNOawiamxvb9yiw-1; Tue, 03 Jun 2025 08:37:45 -0400
X-MC-Unique: 414z5yJhNOawiamxvb9yiw-1
X-Mimecast-MFC-AGG-ID: 414z5yJhNOawiamxvb9yiw_1748954264
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-450d64026baso22920065e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 05:37:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748954264; x=1749559064;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kHS2t2oaHj5ILyKgrMhDZwz0UVPhJxY3OnyQEFGAuCE=;
        b=ZsqtlBQGazwHakm6aZREqY7xVFd1MIZrkrIOZq42BmoUHNn139KVGPascBxoNPaQyH
         CfyWmo1PP28vZpoVLuKYQtcdBivF5qezMOvkFZUa6UyE3tRwXYQM3VclW3SJQJbBof0i
         q3MMxBRps1RUthfoOMWHdfdxh/BJ5y/A7qxtQM9xyXinhEx079cyJX4V/Qd+f84tLupH
         QmWqwI03JMCw3QIVqcK3LeRkTBdkBk6n4ffzcM/OOaBPHOw+/3zGSKYDzGctWMYDW0tk
         3QwP9CAncZutMabTl+/4WX0pzRQklbEdzmn5HHJsvOg2SkmglwhEeDipbNnVv+892LN/
         Cq3w==
X-Forwarded-Encrypted: i=1; AJvYcCVlTorTTdc+4YTr5EqANgDvVALqTdeO2y6A8TYBgsw27pHJ5GJKSvxvFPYSZ2Z5FU7+Qlg1Jh57pJ6BEvbsHpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7VUDkqxPfuY6a3Zj8N07gW4dsca3pax18i6whgD+q+ZxdwFHV
	jh114a91uoUVByiAmtAKgdlj1iYJCf08xyiS+KfkJtivlRdifT5JUnPNMDpZzlcDI+lsyCim2xm
	2sxKbPqWwPy9KQkQ9w8JEBBrXYEGlHoyZ5cZKkJugERfploZ8NVm06q+eHxRD93oePVv7ig==
X-Gm-Gg: ASbGncuRR6SMJjIb3RfQgvpFpM2XXAyQZvT4SLHZLyoPDxvYHbs/wmPIW5b+I3cCzUC
	10n9t//fneqEswEzABlNVTa+Xb+dlZtmruLPh7d+efiy2W9Tdp1MaLtYyXb0750swZ9XwwWxHgm
	LSvHiwLzQ/FoBZyNJ6Oe/hPIK+49S8yE0Tc2R7Rce/NXBQ8h/DjLQdzEWavlgethhh9hI3+sQ97
	v5v0qqYs14BqW7d0roRa5GcU16d0cftm93ZmFvY7mIRw/JxQZwE5Y9mmBUB57RkJoBLvvOZTzS9
	J5NVl6MRSyCPGpJN0bYHd7QJY2okOLw4KAv8c/NhqskXvIAMFnXUTgpEL5bpEMmfxYEJycMQ/2I
	gPyXUiCON2oUukGu3/EAQiehZIwk7AvAGkkQ+Mxg=
X-Received: by 2002:a05:600c:3b27:b0:450:d00d:d0 with SMTP id 5b1f17b1804b1-450d6515da1mr135418035e9.19.1748954264352;
        Tue, 03 Jun 2025 05:37:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6hOntpImmJhhOr2kc0P39r0QNY5mPbQ/1OxLQCnMbzyUGLdDBvPRo5mvUE9vEi3arTd5ONw==
X-Received: by 2002:a05:600c:3b27:b0:450:d00d:d0 with SMTP id 5b1f17b1804b1-450d6515da1mr135417775e9.19.1748954263972;
        Tue, 03 Jun 2025 05:37:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fb86d2sm161320595e9.30.2025.06.03.05.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 05:37:43 -0700 (PDT)
Message-ID: <63e00cf8-8592-4117-bb27-42bc8c1f8921@redhat.com>
Date: Tue, 3 Jun 2025 14:37:41 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] selftests/mm: Add helper for logging test start
 and results
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-2-ff198df8e38e@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250527-selftests-mm-cow-dedupe-v2-2-ff198df8e38e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.25 18:04, Mark Brown wrote:
> Several of the MM tests have a pattern of printing a description of the
> test to be run then reporting the actual TAP result using a generic string
> not connected to the specific test, often in a shared function used by many
> tests. The name reported typically varies depending on the specific result
> rather than the test too. This causes problems for tooling that works with
> test results, the names reported with the results are used to deduplicate
> tests and track them between runs so both duplicated names and changing
> names cause trouble for things like UIs and automated bisection.
> 
> As a first step towards matching these tests better with the expectations
> of kselftest provide helpers which record the test name as part of the
> initial print and then use that as part of reporting a result.
> 
> This is not added as a generic kselftest helper partly because the use of
> a variable to store the test name doesn't fit well with the header only
> implementation of kselftest.h and partly because it's not really an
> intended pattern. Ideally at some point the mm tests that use it will be
> updated to not need it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/vm_util.h | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
> index 6effafdc4d8a..4944e4c79051 100644
> --- a/tools/testing/selftests/mm/vm_util.h
> +++ b/tools/testing/selftests/mm/vm_util.h
> @@ -3,6 +3,7 @@
>   #include <stdbool.h>
>   #include <sys/mman.h>
>   #include <err.h>
> +#include <stdarg.h>
>   #include <strings.h> /* ffsl() */
>   #include <unistd.h> /* _SC_PAGESIZE */
>   #include "../kselftest.h"
> @@ -74,6 +75,25 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
>   unsigned long get_free_hugepages(void);
>   bool check_vmflag_io(void *addr);
>   
> +/* These helpers need to be inline to match the kselftest.h idiom. */
> +static char test_name[1024];
> +
> +static inline void log_test_start(const char *name, ...)
> +{
> +	va_list args;
> +	va_start(args, name);
> +
> +	vsnprintf(test_name, sizeof(test_name), name, args);
> +	ksft_print_msg("[RUN] %s\n", test_name);
> +
> +	va_end(args);
> +}
> +
> +static inline void log_test_result(int result)
> +{
> +	ksft_test_result_report(result, "%s\n", test_name);
> +}

Won't win a beauty contest, but should get the job done.

We could allocate the array in log_test_start() and free it in 
log_test_result(). Then, we could assert more easily that we always have 
a log_test_result() follow exactly one log_test_start() etc.

-- 
Cheers,

David / dhildenb


