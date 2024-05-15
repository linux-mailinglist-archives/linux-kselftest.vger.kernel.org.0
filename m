Return-Path: <linux-kselftest+bounces-10217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 338668C5F18
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CE41F21F43
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB0063B9;
	Wed, 15 May 2024 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZfVGUVi1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE12E8493
	for <linux-kselftest@vger.kernel.org>; Wed, 15 May 2024 02:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740155; cv=none; b=buFEOMtUadi0kcKDGixWAZR2bUn0nfczMP8wN2kq5y3js6UJonzNjmQ67FCiVc2JxzUwZKGfY+DaLzhmht6KgkP8kqbYj3GDPdLCmwUiVX9FkRfPFjXwDc0tnAqYAQKlfgkJVlFtEr4Z8WPmCw+X2P7eh6J79mHVZXvnYqz5tNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740155; c=relaxed/simple;
	bh=uIVALT8fMTxGKl7HLSAvodUgkyb/d8KBVovit9yBBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLJ/gXyWgYk8uhLV6BBn6MgfHlVWIcSr7bMqpSuD1lUbhdFs//MB8D3ThPC3E+Rr4eWQ4SQXmBks+WeFQXhawgb6WKpSjw4+v7wU3r56tz4g8RgD0d37eGoJdPhw0r6Yv0WtRFfHQz0QJdDiaSqTKDHVcvg83mosDYwibLGLSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZfVGUVi1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso1070340a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715740151; x=1716344951; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhWK/QjBhcq/4T9972QoRB3M6/JeMKBp9jipg24+Woc=;
        b=ZfVGUVi1Zt4zGzoP9BuOkhPT0cp6BqZn4xtFRnGzEBQV6fd7FKcwywfoPV07YNRpzN
         dqn6nj7blb+M4f4mnW3/Dp/rL9TiPpHNwn1PySZM8jB7+RmlVJDsnw0e3LEq4yb+/XRD
         uH2AJG6MJ4TMuTqjcbQIRbyf96GBrpDCoC5Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715740151; x=1716344951;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhWK/QjBhcq/4T9972QoRB3M6/JeMKBp9jipg24+Woc=;
        b=HfsnSXQeZ97MCa+MTU6BcFNrRYk1DcptPNaEG/9VkxNsk6w8dLp71D/Kbtf5epwR9n
         g8aDhTHeT45AivV4ACFUNOeZd529I5Uq0A/+WGhwnM+72eedy7DSfnguNpuJYxLt51ZO
         H+uN7++Atgw0XWGBnSy9aswpRxCQ5D3u8bP4KRJwz9Yf9la+U8s0VnE/b05XamwxeVD9
         cunDytL4Xoo7CqwVtFBZnSZEr2UTQUyZAqHmWtKV1cVEk42ujrGcdBDi6/RqB5dax2lk
         pN3/AexEmnOCRP8c6mcSQ3LxAgvGXo60QzYlWKIgEI2M8v7vNgKtiXJpFOJSA3tqTuRv
         XdcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOmMesfEs2ACtB7AqVBSdE1qqFmc/nj7lrosvqZkt29eOh+e0vucweCxrPK/qpX++Dtmnrqvdfrxg3kDyJxFmZHo9klQoTYC4yaiRDZ7P+
X-Gm-Message-State: AOJu0YwWnURyTHpGqv6lPtvjON1kIld9iuWBeWuFcl8xqjIxxaM2PrCI
	9Gb6+XTbi6rZZPAD1ACBTGWD3OXeEB2Y3OAkr2SfJ4NunFvO7RbQA9lPcZ68Yz8AEtRl4+DLUap
	Vdp+gFw==
X-Google-Smtp-Source: AGHT+IE4pDtMz8qcHeLC4uMbcULOvZdJJQYekNHagkaH5Ku9udW6xWtN38Nub9N/KGvjLZcPA1FJqg==
X-Received: by 2002:a50:9e61:0:b0:566:d333:45e8 with SMTP id 4fb4d7f45d1cf-5734d5ce24fmr11044289a12.20.1715740151264;
        Tue, 14 May 2024 19:29:11 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574d8f5501esm2152430a12.75.2024.05.14.19.29.10
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 19:29:11 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso99788566b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 19:29:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU380x/DYQR8Y7wJY1Je1EBidoLPckHGrcs07PLFMwK7mz+RQD8U+1mKrP9HQpj63Ni8wjzQ913K4QtsLzzgVt0Yl10w/xhrfFsBfZYuJ3e
X-Received: by 2002:a17:907:7f08:b0:a5a:63bf:5175 with SMTP id
 a640c23a62f3a-a5a63bf5227mr784689766b.10.1715740150546; Tue, 14 May 2024
 19:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org> <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
 <84192.1715737666@cvs.openbsd.org>
In-Reply-To: <84192.1715737666@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 19:28:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
Message-ID: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 18:47, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Regarding mprotect(), POSIX also says:
>
>     An implementation may permit accesses other than those specified by
>     prot; however, no implementation shall permit a write to succeed where
>     PROT_WRITE has not been set or shall permit any access where PROT_NONE
>     alone has been set.

Why do you quote entirely irrelevant issues?

If the mprotect didn't succeed, then clearly the above is irrelevant.

> When sealed memory is encountered in the middle of a range, an error
> will be returned (which almost noone looks at). Memory after the sealed
> region will not be fixed to follow this rule.
>
> It may retain higher permission.

This is not in any way specific to mseal().

Theo, you're making shit up.

You claim that this is somehow new behavior:

> The other previous errors have been transient system effects, like ENOMEM.

but that's simply NOT TRUE. Try this:

    #include <stdio.h>
    #include <sys/mman.h>

    int main(int argc, char **argv)
    {
        /* Just three pages for VM space allocation */
        void *a = mmap(NULL, 3*4096, PROT_READ, MAP_PRIVATE |
MAP_ANONYMOUS, -1, 0);

        /* Make the second page a shared read mapping of stdin */
        mmap(a+4096, 4096, PROT_READ, MAP_FIXED | MAP_SHARED, 0, 0);

        /* Turn them all PROT_WRITE */
        mprotect(a, 3*4096, PROT_WRITE);

        fprintf(stderr, "Write to first page\n");
        *(int *) (a+0) = 0;

        fprintf(stderr, "Write to second page\n");
        *(int *) (a+4096) = 0;

        fprintf(stderr, "Write to third page\n");
        *(int *) (a+2*4096) = 0;
    }

and what you will get (under Linux) is

    $ ./a.out < ./a.out
    Write to first page
    Write to second page
    Segmentation fault (core dumped)

because that mprotect() will have returned EACCES on the shared
mapping, but will have successfully made the first one writable.

End result: this whole "transient system effects" is just not true.
And "mseal()" isn't somethign new.

If somebody makes random mprotect() calls, and doesn't check the
result, they get exactly what they deserve. And mseal() isn't the
issue - bad programming is.

Anyway, you're just making things up for your nonexistent arguments. I'm done.

            Linus

