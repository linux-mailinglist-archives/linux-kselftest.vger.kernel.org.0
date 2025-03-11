Return-Path: <linux-kselftest+bounces-28703-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF2A5BBE9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 10:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808881890DB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 09:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF0322AE7C;
	Tue, 11 Mar 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFjTCSy8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219041EBFED
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741684780; cv=none; b=Cw1Y9LjcFW29QqxC6fu9O0QfTtmRJ+pts3qNuaJqL+gR6JYVXAx3Fc4Mv7I6H4Qk29OiM2hjNM35TUxEzlFA7CW2ChwYGraO178Ntek+DVI+tWuKxQ+rjuGDd79fcG8q+Jf4fFsnXNIGMxFzvvZ+DDWYI56E2iMqMTbIgrfjnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741684780; c=relaxed/simple;
	bh=uYAXlhhmrR6aYhD1Dtku56EVWjgcSXvI6gGyiutoebE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/lRz4Z5aee34wiMFlR8TMG8VPvIRYFynUZOdkOFliA6r8w7EteXePcZ2rdjpSHHd75upqAimKsOHL4fiENdfBhPZtxqLOJmuIRsqiJGHPyYu19cxxg+7//T2xyZ+475DlDjZZw187dPXYsgDVx1FlpLj+Sa8D4sBTSsYo9NT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JFjTCSy8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741684777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HYrmKhtPai2LPdacEcsqL3kmpFFiX3Wa+ZrPyUQ9258=;
	b=JFjTCSy8XPJYDCCNyL56VOEvRvVHT3rudhnI127mMMJLd2GIzBmd/r4T1yWfUid3c+Zl0r
	9dK+i4e+629cnpek7nA4SI5EBtEovw5PXfr610WAa3S0WvWGZEaC9i47K1PgYpq6WIi4Mu
	Gm3pm+MCWCmKdgrr+DsetQPm8eft3ZQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-i9Mzem2_P9WjhG-KibZ5Cg-1; Tue, 11 Mar 2025 05:19:35 -0400
X-MC-Unique: i9Mzem2_P9WjhG-KibZ5Cg-1
X-Mimecast-MFC-AGG-ID: i9Mzem2_P9WjhG-KibZ5Cg_1741684774
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf5196c25so11200535e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Mar 2025 02:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741684774; x=1742289574;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HYrmKhtPai2LPdacEcsqL3kmpFFiX3Wa+ZrPyUQ9258=;
        b=qnaRpqptW/YYGf0u8HN/wn+8Bb7SrxtBmYMwttIuNlkYibpEZWtO8eoPGRGMzLgNwE
         wb6M51h2WWIrOQSqQSAV2iOx0ITghISfJTkLfPUF66IXrrvfFqJAGrFkeAbv1PjmjtbK
         yIJ+dyfW6KseJpXH1TdhmRdhDDGwbLdsl9e1jATEHFZ8WIzZ9GCQoFSjfdW7SbhFXCAl
         gFPvg5wjtjg2s54Tygcb+k8n4vwk+Zhl0Rdp9PsQHLVBJ9LGjSYC9+DwR1CWEHQq6Q5p
         9siOmcfHQdFF84hymlMCea0EUUbTGJd0tymykNBP3UYK9cLkYTSTTUTmNIL62rH2zXma
         2TOg==
X-Forwarded-Encrypted: i=1; AJvYcCVk/nyWvf4Iut5+mlzH3GhtLssklKrrP4jd219nyb27sbKZWChqyRcsWRjGbC0S1aAHDp7hopBbHhrbLdzbwrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKGhteeqrtKIGIUdLTD3mznIFNXokV8uypi6N0ktk0F5jG7Ku8
	ByZr5XRnNuPLBJTyi0INVbqwPLtIE+ZVub3TgqjaocThQxv3rRa0kq3PusINZDYMvLd2kigsNbS
	RJJ23yohq5M2vdI36NF6e7lHhTsSCLZLSYbZweuMH8UxKwjhC9SHVhzTR52wQQJhscg==
X-Gm-Gg: ASbGncuOkr+JK21RQj+g9iYcAOQLo+9z52qnd3TNKxILo99YRPGLDGlkZt/CGPwA2Te
	fmmyGCX7WGm74WTwpCNh/eFGR0gVI0K2E5hMQqymcQtUWUv4JWehBk8f5jZWQXUI1ZVvigESQ6H
	ElFfBb6D18I2S3EuRfAvEq/QZs/MbVgtaQStdWvPHb1uTulFia58RgFdk2HUmOo6qJEVTIXkyR1
	+XCRAN/OtiD/78iIoiAYwqidfoaQclfLH3RENmtJ8PoD3hZhtxmELYfcO4FPUeUdFQJSy2ghI4e
	w2Lwpp8JyEg6aMdq4D75MLQBGHgvcuFwIv3CV6RiaqyooxKvAK110mRTAkxVFNgqmgxyPIdnw/h
	R9MVnqJc9LSfjjY2RAmYV0rTgxesloRU4PqIkFc45WUo=
X-Received: by 2002:a05:600c:470c:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-43cf051022dmr92517695e9.11.1741684774356;
        Tue, 11 Mar 2025 02:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0Lxs5i27MDjud5TrhD9KawVefCONxScQwN/Kn4gcIWpRE2Eeb/bg06AHrefH2S3zDLbi60g==
X-Received: by 2002:a05:600c:470c:b0:43c:f050:fed3 with SMTP id 5b1f17b1804b1-43cf051022dmr92517295e9.11.1741684773950;
        Tue, 11 Mar 2025 02:19:33 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf595a771sm71598245e9.36.2025.03.11.02.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:19:33 -0700 (PDT)
Message-ID: <4a068856-328f-48ae-9b1c-0ec7d65dde6b@redhat.com>
Date: Tue, 11 Mar 2025 10:19:32 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow: Fix the incorrect error handling
To: Cyan Yang <cyan.yang@sifive.com>, akpm@linux-foundation.org,
 shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250311023730.56658-1-cyan.yang@sifive.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250311023730.56658-1-cyan.yang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 03:37, Cyan Yang wrote:
> There are two error handlings did not check the correct return value.
> This patch will fix them.
> 
> Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
> ---
>   tools/testing/selftests/mm/cow.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 9446673645eb..16fcadc090a4 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -876,13 +876,13 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>   		mremap_size = thpsize / 2;
>   		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
>   				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -		if (mem == MAP_FAILED) {
> +		if (mremap_mem == MAP_FAILED) {
>   			ksft_test_result_fail("mmap() failed\n");
>   			goto munmap;
>   		}

Yes, that check is wrong.

>   		tmp = mremap(mem + mremap_size, mremap_size, mremap_size,
>   			     MREMAP_MAYMOVE | MREMAP_FIXED, mremap_mem);
> -		if (tmp != mremap_mem) {
> +		if (tmp == MAP_FAILED) {
>   			ksft_test_result_fail("mremap() failed\n");
>   			goto munmap;
>   		}

As Dev says, this one is just fine. Leave it as it is.

-- 
Cheers,

David / dhildenb


