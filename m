Return-Path: <linux-kselftest+bounces-6387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02A87E699
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 11:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BDB1F210EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Mar 2024 10:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A7A2CCB3;
	Mon, 18 Mar 2024 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGJnAtkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723302D604
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756167; cv=none; b=XdWsFsgnkSYS9PKk+NnuDGEa2DK1kFMl8vHc4jgsoaiww8J+4+gzkQ6PAaq8v6QIVvS+v1uypaMG3/cF6iO4EL9a2JsyG9Mv3uzX/mQD2iOKDYQcs3UewT8OkDJWM9iwUk732ss8tyDAdKJukcMNtIilR1CJydGzP/RwHCQPbIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756167; c=relaxed/simple;
	bh=fv713jnC4eTu0LjzOoM6QuqX7SLnyNlX9P4G5L56o7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Drv590R45pbTM77Z8BM6l06TNHd0x7WnNBahu7+XytRGR7s4Tt/B8N3KIxm7py5GSE+I/4ylQB1KuezYAJrS5XJT3/zBE4TU9n7G/0i5Kpqq3DyF8WsQ8hrTN1kXA93MOKe2nyH0wRnomCiuMEt1hIHdLBI6rtboDQYAT4cPrHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGJnAtkI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710756164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=i+31X8Ytz3OwzmlxhlwOLx4ZRoR3tqXflabXQ06eudU=;
	b=iGJnAtkIMJS1Dc3kK5YyNBci9WzfiYL7lsSvQhi0br3B4d5DFW6Njdu3glhBst7g1f7WaZ
	oNhkkvGgRCty/MecZrtCtkuH/pELoWj5Q3mWavff2o3gtIsQ1d9eP5/Gg8syy8UCRRWl0M
	6mJAU68sK4xh3CtaC89dUg90cos3g64=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-79sKcAYzODa6m1t0oxQwXA-1; Mon, 18 Mar 2024 06:02:43 -0400
X-MC-Unique: 79sKcAYzODa6m1t0oxQwXA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41408a44c91so7642705e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Mar 2024 03:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710756162; x=1711360962;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+31X8Ytz3OwzmlxhlwOLx4ZRoR3tqXflabXQ06eudU=;
        b=qfIikP0IQ/TSn8+GobwpVkJr7P2Qnu1SwKJ9bnNkcOOuv+arGXnA0I7WSIz5OSjSeM
         lLlAEZVPJadyiEzReHVh+kPpZvJocV7DQDxjIvFgJfbz1Csplub9wyGkQfrXh3zp19aV
         Fei8bWX5+WOT3i1/1MiEF2YldUlNNPCEe+GPm4PvTQBPWKOqU5/12q4kHjO3zU5V5qjK
         aOuua2Rh5hGG5JyeyJwEWeo/vGohTzizknIjqvG8uZor656spiFlzDAsr8BJCrVEtHVD
         +e0DgC3RRGnWl/sO+CXf3mHJgELc72u51/hzAtXM2HD7f1BVddNlUtkscdimhQsAOhbD
         UVkA==
X-Forwarded-Encrypted: i=1; AJvYcCW/IlRCjn8qbXnUWIyP8uy4Hbzooi0qh5q/8FQSanX2O9iIOrPeHy8Lta2duAQLrSwiTcPWey6ba94utDXAOWsMRnzu7RdLfKuwiymVlJBp
X-Gm-Message-State: AOJu0Ywtuo5PxfPyij9Hz6RLbsdRFyKfr7VS0l3IA/u4etYNYjP2gGjy
	ClMI+kz/AOzRwJWfdALtqPjNy3/sdnEdYVSyEIQYF6glvaPLvBQb+zGic5bSEG5fciG0t7aox/t
	tK0lzDDSdHKXuUZZOrvIW3d8PqeJW6pg1eAwcJ4BeM+rPSPkaLH8g0DzwaTot+LZlGg==
X-Received: by 2002:a05:600c:444c:b0:414:12ef:83a9 with SMTP id v12-20020a05600c444c00b0041412ef83a9mr940083wmn.20.1710756161915;
        Mon, 18 Mar 2024 03:02:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQYOGxJB/CV+mFNG8uE93IvPkEoL7pVcQIg3RAdxLAWY2djf+MU0C9QMvFDPCb15losXY+xg==
X-Received: by 2002:a05:600c:444c:b0:414:12ef:83a9 with SMTP id v12-20020a05600c444c00b0041412ef83a9mr940057wmn.20.1710756161466;
        Mon, 18 Mar 2024 03:02:41 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:1f00:94ff:246b:30d0:686b? (p200300cbc7371f0094ff246b30d0686b.dip0.t-ipconnect.de. [2003:cb:c737:1f00:94ff:246b:30d0:686b])
        by smtp.gmail.com with ESMTPSA id dw11-20020a0560000dcb00b0033b66c2d61esm9375131wrb.48.2024.03.18.03.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 03:02:41 -0700 (PDT)
Message-ID: <b7c3a0be-00c6-4add-a3da-3c6195e47b7e@redhat.com>
Date: Mon, 18 Mar 2024 11:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix build with _FORTIFY_SOURCE
Content-Language: en-US
To: Vitaly Chikunov <vt@altlinux.org>,
 Andrew Morton <akpm@linux-foundation.org>, Keith Busch <kbusch@kernel.org>,
 Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Nadav Amit
 <nadav.amit@gmail.com>, Shuah Khan <shuah@kernel.org>
References: <20240318023445.3192922-1-vt@altlinux.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240318023445.3192922-1-vt@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.03.24 03:34, Vitaly Chikunov wrote:
> Add missing flags argument to open(2) call with O_CREAT.
> 
> Some tests fail to compile if _FORTIFY_SOURCE is defined (to any valid
> value) (together with -O), resulting in similar error messages such as:
> 
>    In file included from /usr/include/fcntl.h:342,
>                     from gup_test.c:1:
>    In function 'open',
>        inlined from 'main' at gup_test.c:206:10:
>    /usr/include/bits/fcntl2.h:50:11: error: call to '__open_missing_mode' declared with attribute error: open with O_CREAT or O_TMPFILE in second argument needs 3 arguments
>       50 |           __open_missing_mode ();
>          |           ^~~~~~~~~~~~~~~~~~~~~~
> 
> _FORTIFY_SOURCE is enabled by default in some distributions, so the
> tests are not built by default and are skipped.
> 
> open(2) man-page warns about missing flags argument: "if it is not
> supplied, some arbitrary bytes from the stack will be applied as the
> file mode."
> 
> Fixes: aeb85ed4f41a ("tools/testing/selftests/vm/gup_benchmark.c: allow user specified file")
> Fixes: fbe37501b252 ("mm: huge_memory: debugfs for file-backed THP split")
> Fixes: c942f5bd17b3 ("selftests: soft-dirty: add test for mprotect")
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


