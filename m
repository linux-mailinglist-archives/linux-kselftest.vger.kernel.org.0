Return-Path: <linux-kselftest+bounces-10369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2098C8DAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 23:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C06B227CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 May 2024 21:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D951411D7;
	Fri, 17 May 2024 21:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b6Da8imk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1CE140E2E
	for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981258; cv=none; b=EfSAhHwqY9MKr6/5C9g9Q7xUJZ17Cl7MwLcR71T4PM41Bgk1P7PEt1FzMQncknF23TMtFeppL1Qd9F3PBIRgyuO7oNkFdvTAt1WdQ9/snnAEhYSlUDCBI5XlgLsNGsZERXxD6xaQrW30Fv98+Fxwq4jmmScx9NDq6oNtDmvpdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981258; c=relaxed/simple;
	bh=mZcbn9pTbHdvbEiKdVCqeMJrWb4nqNiC86MZdFsD0r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gf56E1mgRu7pa60vh/P5cNIzvSz7vn8SSGBTgmOjgXZvNaoq5p0sKcNxpOmAUl/+ACwIGDvF+FhT53Qq1ZYUvYlF/wDFzuIMhfOmzhlSkwtEeCFqryrlvnSyvMb023eI3Pumf+Om1j5s+aoSFNMXuDHuzyYEAOkp1wj1uF7Mo7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b6Da8imk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f082d92864so22854205ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 17 May 2024 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715981257; x=1716586057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nwumsOFzLhcSRvtv4E4XIjWS9Wdw51QyanOFC9u3vrw=;
        b=b6Da8imk/8gNmVRmYGGLEwQhRFhk/mMpo33gVKEfmfcgQPdk0Zwys3suUOqqyu7Xys
         EE/ww405sMpTuu9o+efr9ZgadxYEdCkmU9QkNnYvm8efavBQGbxHx0h2/r/bc+MWQ7sT
         I+qcM9DR2v65iGT5xJE1h2aPz2B/l5t+uWaws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715981257; x=1716586057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwumsOFzLhcSRvtv4E4XIjWS9Wdw51QyanOFC9u3vrw=;
        b=NdCU0rDT28qNPZbUDBovFN4zVJKJMcbdBxg2LIzEneFh8tlOs2WGOle97kHsczb98y
         cAoOAVvt1/JXaWOxAYuohdh9pJvj9rn0zdQ6DAIg6vKlUklIH99S00UovzHkqQs5inum
         hxd+/+cQDgepDl4JDwKdLEgDiuLSet3L3DlE5nATn698tsGfSZFIug81VpLhk9GVn3rb
         BbRNKQouubYPgrz3IrG/PLXsCz9QgLG+IETKkYppiNhiHpOM+su3MLXqYeLbp+RPSN6b
         cj6l0J4RHfTmEVt18XEkf3wlnR4ZZCD/zD1X+nAzoKzftkmUh8Ev5oerDMZiNoS/d9ns
         wb8g==
X-Forwarded-Encrypted: i=1; AJvYcCVEwb6Qx7Z5kKMNNbaWGCMVnan08di8X5sxn9XG2nB7v1HFeAzGMc8NG6aE72uxOogev0Z4VLPXbAo49e8azW4uv8w3LEb8V203Q+e4dMGi
X-Gm-Message-State: AOJu0Yy5OE4hfHfTdg60fsSFnnWoSYOyfDMq0xU3eqA8ZoUzC4lo0Q5P
	ZjfN9WUHOGztrAJYSjS/9sa8ErqmM8dqNEhh4PRtqXIPi7l77Fa/YcjfcAzBCg==
X-Google-Smtp-Source: AGHT+IFluK3Eyorpte5TQvgACdUYQTNtTr1OkCqbBB7MpwGA6ZSBRPFcAQ5PudVW8axjuibL4dnJqQ==
X-Received: by 2002:a17:902:9886:b0:1e2:577:f694 with SMTP id d9443c01a7336-1ef440596a9mr187163085ad.61.1715981256849;
        Fri, 17 May 2024 14:27:36 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c2567absm160788595ad.297.2024.05.17.14.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 14:27:35 -0700 (PDT)
Date: Fri, 17 May 2024 14:27:35 -0700
From: Kees Cook <keescook@chromium.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org, kvm@vger.kernel.org,
	linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 0/2] selftests: harness: refactor __constructor_order
Message-ID: <202405171426.B1ED9AD@keescook>
References: <20240517114506.1259203-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517114506.1259203-1-masahiroy@kernel.org>

On Fri, May 17, 2024 at 08:45:04PM +0900, Masahiro Yamada wrote:
> 
> This series refactors __constructor_order because
> __constructor_order_last() is unneeded.
> 
> BTW, the comments in kselftest_harness.h was confusing to me.
> 
> As far as I tested, all arches executed constructors in the forward
> order.
> 
> [test code]
> 
>   #include <stdio.h>
> 
>   static int x;
> 
>   static void __attribute__((constructor)) increment(void)
>   {
>            x += 1;
>   }
> 
>   static void __attribute__((constructor)) multiply(void)
>   {
>           x *= 2;
>   }
> 
>   int main(void)
>   {
>           printf("foo = %d\n", x);
>           return 0;
>   }
> 
> It should print 2 for forward order systems, 1 for reverse order systems.
> 
> I executed it on some archtes by using QEMU. I always got 2.

IIRC, and it was a long time ago now, it was actually a difference
between libc implementations where I encountered the problem. Maybe
glibc vs Bionic?

-Kees

-- 
Kees Cook

