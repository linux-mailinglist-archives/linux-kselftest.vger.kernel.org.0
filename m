Return-Path: <linux-kselftest+bounces-3980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E2084668C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0459BB24CFC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0371CA71;
	Fri,  2 Feb 2024 03:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLXf0gDh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F759C8EA
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 03:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844643; cv=none; b=S4xJiBvPSd+G3zwcMzOy6igAPcpkJfFnN+niG8inVk0vDFxU6y6tp3SSSEXT/xIvRZUvhqxbJG/resvvlf+CrNUeEf6QzNlfy/ZJpQF4ZapcznPua263OZQqM7IeWZBjzda9LT/3J/isrqqbndCmz8lYfVx9bFQwD/uP9jIhBYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844643; c=relaxed/simple;
	bh=EmKjmDmXRKrnBxWdzwix5j1O1b1nVwMXkAT/mk3vi8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffDUSEQd6HMrqW9IrERdEVXMp9nmtC2QCiiTe50Xzw+2/GmIOwYjzogzg0SL++jOvw2UnqCFRELX6tThrRoIJN0dcxFXedd+tHZI33RPZZX7UonGtWguzYEMjsdcHDJx3JvEq87wPe32O5CUH6xlB7toApwfICtiSP7W1ib2XPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BLXf0gDh; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-214dbe25f8aso863649fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 19:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706844641; x=1707449441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDdYwb6bms529iTi0p0xaIF4DMRKf1eH479RkB5tVc0=;
        b=BLXf0gDhlqX9CQNr1kZBBPk/qOrFd1ie1yZdE/gDvKCIoYg4Z2ZEmW2M3skB/VFAVI
         FQ+eJf1E5khc761ns7yKe0S4bNLloXYqXShf0h+WEybB7uIM7KpXDHs+hqTxFW+LYCoj
         HzdKnS0Cz0WwpRUkLFm1VZpDP0yImt2kRj/BI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844641; x=1707449441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDdYwb6bms529iTi0p0xaIF4DMRKf1eH479RkB5tVc0=;
        b=K/RJEFjJNMzRkVv8HN9fg3Jc2Jnc8xWZFgL1Fz98ss+8Yvvaf9CQYe3/ob55EhWIYy
         VxSH6Y2HVMX9Z9TOvtLjXB45jVwfG2JjBxuqtknRwylE+RNGbaHfWLAG0lo57ln1Q65z
         u+edos2XvgnXyAXK/BEFDVHtNqErooUZcKHXvQL7uGG+03TZyAeQj5jcRfKLjSfCqgo5
         VNknRz4iQPwNQOe+l2M0f1nFmcKtH8xFYKwrj7XdGTF4iJDISChwRdlHMKzDVzxZ8fgB
         G1+ePqyQ1SbTSg3MaRLU/tr0+JzQZYIvB+0gZrYV0mMXg5SXJYch0h9Jh6DQwvy1Y/hO
         VMbw==
X-Gm-Message-State: AOJu0YwxBM+xokafHiE14Dl1pULSpR5Aof78XP67YA6MsjrZr3hjXFQV
	d3x9O2YAOgKz1LugJKJ59hkJgT4lfht3v4nII/l+JaW5dnt5Ufn/zI4+XfFHWOoxuZ0zyaXHGl8
	C5lg4uO0tR///nuQx0P/EVF8+hJiXSNK1P429
X-Google-Smtp-Source: AGHT+IF/r05G9r4pqnUYufTxyrklaLY34VPoujkR9dH8bcGKq2ZHmLdBhM1/R7dkd0o8lqJL0U36sbeOMj+cQAyiOs0=
X-Received: by 2002:a05:6871:7584:b0:219:2219:29d7 with SMTP id
 nz4-20020a056871758400b00219221929d7mr203072oac.48.1706844641233; Thu, 01 Feb
 2024 19:30:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org>
 <20240201231151.GA41472@sol.localdomain>
In-Reply-To: <20240201231151.GA41472@sol.localdomain>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 19:30:29 -0800
Message-ID: <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
To: Eric Biggers <ebiggers@kernel.org>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wrote:
> > [PATCH v8 2/4] mseal: add mseal syscall
> [...]
> > +/*
> > + * The PROT_SEAL defines memory sealing in the prot argument of mmap()=
.
> > + */
> > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > +
> >  /* 0x01 - 0x03 are defined in linux/mman.h */
> >  #define MAP_TYPE     0x0f            /* Mask for type of mapping */
> >  #define MAP_FIXED    0x10            /* Interpret addr exactly */
> > @@ -33,6 +38,9 @@
> >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, memory cou=
ld be
> >                                        * uninitialized */
> >
> > +/* map is sealable */
> > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
>
> IMO this patch is misleading, as it claims to just be adding a new syscal=
l, but
> it actually adds three new UAPIs, only one of which is the new syscall.  =
The
> other two new UAPIs are new flags to the mmap syscall.
>
The description does include all three. I could update the patch title.

> Based on recent discussions, it seems the usefulness of the new mmap flag=
s has
> not yet been established.  Note also that there are only a limited number=
 of
> mmap flags remaining, so we should be careful about allocating them.
>
> Therefore, why not start by just adding the mseal syscall, without the ne=
w mmap
> flags alongside it?
>
> I'll also note that the existing PROT_* flags seem to be conventionally u=
sed for
> the CPU page protections, as opposed to kernel-specific properties of the=
 VMA
> object.  As such, PROT_SEAL feels a bit out of place anyway.  If it's add=
ed at
> all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure this asp=
ect has
> been properly discussed yet, seeing as the patchset is presented as just =
adding
> sys_mseal().  Some reviewers may not have noticed or considered the new f=
lags.
>
MAP_ flags is more used for type of mapping, such as MAP_FIXED_NOREPLACE.

The PROT_SEAL might make more sense because sealing the protection bit
is the main functionality of the sealing at this moment.

Thanks
-Jeff




> - Eric

