Return-Path: <linux-kselftest+bounces-34213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98CACC6BB
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AB6B3A27CC
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 12:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54BC22D4DC;
	Tue,  3 Jun 2025 12:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLf1QUm2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311C011CA9
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 12:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748954173; cv=none; b=Ct+lCvvpYxEsKopzg0qnTYaGrtkC9+Dz8qUheTccxM7gXgtroEFnpRh5lsIBJ5TC17Ko9GAblQvKz38bUomrIA3jbKPteah8aUeoDI/VZlFV11pRsttRupRZjDJ3k1B4gR1qpuuHz0QFjwbirc6JOOoHBeDiDXtAuk6SkdeX7ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748954173; c=relaxed/simple;
	bh=p9y14r2RcfY01VH69cWiPEIPUMdhwafuZ4zU+FN7cuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BI064vGFvA1euLCFXDtfy3WQ5PhKTO/UenFRJ/TOQL2KyX9IflDk6j9D/k1zaZfjayPZ9SaNZ5tLXCM870DLA1lLVR75+RpnD9uxLm2wRuPoEJylbbPyMxdZPa3WAa6ydOfm10xndfzFXaJerXsl+UOXGNXV4O3c/jUQuUWAIPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLf1QUm2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748954171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/tQxECYS1/smC9hMUUweuEWVJJtPYjs1Zxiotrh33KM=;
	b=RLf1QUm2yY2x7nVANYOA9O3z/mCiZucbMg/L81Llb1Lgmt0bCAExLa9x/kO7A96twAjPQr
	Nr2F72iEsrCs4kOpEKVwRkqZuXu8MB/L4L5l5DATSRikdXwoWiY5v71b7VsmA65TbOg4gO
	Jb3JBMyRLyjH3EzUKNhxOHgRV8yuEFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-g0dqegJlN-Olk-IVRmbgEg-1; Tue, 03 Jun 2025 08:36:10 -0400
X-MC-Unique: g0dqegJlN-Olk-IVRmbgEg-1
X-Mimecast-MFC-AGG-ID: g0dqegJlN-Olk-IVRmbgEg_1748954169
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso29907585e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 05:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748954169; x=1749558969;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tQxECYS1/smC9hMUUweuEWVJJtPYjs1Zxiotrh33KM=;
        b=RlqJe9JeIoa/6eO5Xeh5E1pcawRMfcfjsNfQxnaNFUw0v8mV8paAhEmKpbdWleXbyB
         /TXzCOrjXzIMFjiUNVj+k5XEUUbsgAk3R8UIK+N2ZlYT3PuZm4j0t3mHEeBiA1Yu5Npq
         XBGVmz8YEAX8K8tzr7/oGxRqE8Mf8VClspPrqzGC0Gnvt0IU4qBB5iwVm4H5Wd4ju0c4
         FbddMQfTJtbMwiGuoq3SPCpJzdfd6fBB36DuP5uugtlBZj8WQddYPZOMYpDNwYBgiWTz
         kxTT5/aM1tVoYGLW8TlK6XxVkeHQFulD1OYL9tj9uglZOEEov7xoitLCvj2PVMyp/Ws7
         UxJw==
X-Forwarded-Encrypted: i=1; AJvYcCXqZxirXT/vjUd5BBLg4Y6K7kmUxwwdAiQlxE3ZAHbs9FlaPRC4kYScn6CBHhKrv7oHVE/igw4CRyIvKsq1QL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/e0ntQWzAEWfkUbVjpzvWTpYLrew+87/eZn7VLWz3PyM76Rv
	MraPIBB7eWxyVI2XwbaZAhirbmK3/701YGmc2v+U9LTg1j16wQb+2uab9J60VJYXEovoKo6kxqJ
	smFVWyI7YCbLIcCcPL7zdv3ELgU350KhvLHpkEGNwgBADKk6LvQpE6u/NsanAOv37JStOAA==
X-Gm-Gg: ASbGnctZUn3gLp5XxKrhIb0wfwOXtHNYppFSj5bkv9QOQc9bItC4SfPpkbd7I+muS6S
	QC0uEshxFltBGoWo4/ZmOqu++3/gR5eSST2tKPA+BLtwggEr6rL/f3JsFX44zClBNtgkDfr8v5A
	pbQg7wqifAaJ7aBzOHdJ+5DLE49KMFqX+vAc6uitQy9hMg/sGGUeMK/jn1BWF4rzT9yx7xX7VAr
	wNCezzE2GDaeJTcl2jrBEUYDlAOGBUTRoa5HScPnAZobewrsGvtQr6r04hvlOKR2mrVVZ2zoss2
	zWPt1+YY90WscpmmaDFvJUmUGZ53kh8Qgf11m72a2rsPn55EcAMpo5VP1X1/I82LuH5B8GlD18x
	TCbLcMVnktgHZeungfrlYha1WZ+ZsCLC90PeUj4Y=
X-Received: by 2002:a05:600c:21c6:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-451e6145d37mr18297235e9.0.1748954168762;
        Tue, 03 Jun 2025 05:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcMznGkf/3PuTOjTnCzKPSm+vpB95SJjFtp4NeDGhsc3C3lfBjzt4eDnWq3j8e6MwshfvgFg==
X-Received: by 2002:a05:600c:21c6:b0:450:c9e3:91fe with SMTP id 5b1f17b1804b1-451e6145d37mr18296995e9.0.1748954168347;
        Tue, 03 Jun 2025 05:36:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7f8ed1bsm167340075e9.8.2025.06.03.05.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 05:36:07 -0700 (PDT)
Message-ID: <7ca09fbb-8b10-4dea-9456-dce21ade2099@redhat.com>
Date: Tue, 3 Jun 2025 14:36:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] selftests/mm: Fix test result reporting in
 gup_longterm
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250527-selftests-mm-cow-dedupe-v2-4-ff198df8e38e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.05.25 18:04, Mark Brown wrote:
> The kselftest framework uses the string logged when a test result is
> reported as the unique identifier for a test, using it to track test
> results between runs. The gup_longterm test fails to follow this
> pattern, it runs a single test function repeatedly with various
> parameters but each result report is a string logging an error message
> which is fixed between runs.
> 
> Since the code already logs each test uniquely before it starts refactor
> to also print this to a buffer, then use that name as the test result.
> This isn't especially pretty but is relatively straightforward and is a
> great help to tooling.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/mm/gup_longterm.c | 150 +++++++++++++++++++-----------
>   1 file changed, 94 insertions(+), 56 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
> index e60e62809186..f84ea97c2543 100644
> --- a/tools/testing/selftests/mm/gup_longterm.c
> +++ b/tools/testing/selftests/mm/gup_longterm.c
> @@ -93,33 +93,48 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
>   	__fsword_t fs_type = get_fs_type(fd);
>   	bool should_work;
>   	char *mem;
> +	int result = KSFT_PASS;
>   	int ret;
>   
> +	if (fd < 0) {
> +		result = KSFT_FAIL;
> +		goto report;
> +	}

Not a fan of that, especially as it suddenly converts 
ksft_test_result_skip() -- e.g., on the memfd path -- to KSFT_FAIL.

Can we just do the log_test_result(KSFT_FAIL/KSFT_SKIP) in the caller?


-- 
Cheers,

David / dhildenb


