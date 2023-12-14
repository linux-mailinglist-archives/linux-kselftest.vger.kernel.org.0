Return-Path: <linux-kselftest+bounces-1888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E362A81249A
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 02:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1A1C2084F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 01:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E4E63D;
	Thu, 14 Dec 2023 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="K93ycnPB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4446FE4
	for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 17:32:00 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-551c03adfc6so2801615a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 17:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702517518; x=1703122318; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Bu41HfL0rPJ5dM5yXqa7CgHUFFdONYm5ZwaUE4WWVI=;
        b=K93ycnPBXuf0EIOZYvDQoqOY3sdlq7A1KZXqTHxnGl7NJV5Dh9XjfLsSXsli/2wweN
         +4/vCSQFukR2zFCXcM2oP98hkZ+XxWp/CDV9/9tc1zjhauCxGsUy6UzmUOLGBAd7//R5
         zYK4J8p4/oOCchhtOD5F65gu+a/gxWp1pa6b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702517518; x=1703122318;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Bu41HfL0rPJ5dM5yXqa7CgHUFFdONYm5ZwaUE4WWVI=;
        b=cnwnVgkZJbKXGLMj97bzrEYecnueEx3LgfbNyigFAl1CWRjT4noX9ZeMXkUkYkWbwt
         TVzX4knY8VCyrdS/p1ekZlLvxn3ih3BN3p2Vh2d6mEreaCzV0RNXCV0L8Yb+DhQcxsPY
         +i0Ulo+FJqYALfAzAEW3CX5iBcILHN4NJ6rLdzQF1lrAdnNGOkbaOrQwwHtcXIJZEITS
         9Bbir7YUD2zRX5A/TysqhALNjpSG5um1oAEhdo/Uwg7VRfayHvZSb75iL0FtXCs9oFT6
         Jz/fwoZiE24cBH7wU5zcOoOGW92CNNEcc8Zzygi2N7onkA3gCzcNaD6arx++cKQmN/96
         Ev/w==
X-Gm-Message-State: AOJu0YxG+j378VSwknQF+yAQGEQoMpz31jCqsr9b+hQq2fSDpbA6gMHe
	6E7+yqTA55fjqVgHT2qP9yXACIZT1S2QaDkifDAKPnP/
X-Google-Smtp-Source: AGHT+IFxbttSCsD6L0PlvEb4sN5RnX7gX2bRafs2Ps4z1R22+5GCQeCEN7hyFvyPtHG6u/EZdMjKcg==
X-Received: by 2002:a50:c90d:0:b0:551:cdbd:b052 with SMTP id o13-20020a50c90d000000b00551cdbdb052mr925340edh.46.1702517518633;
        Wed, 13 Dec 2023 17:31:58 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id r21-20020a50aad5000000b00551da4f364csm1618217edc.44.2023.12.13.17.31.57
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 17:31:57 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so10333744a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 13 Dec 2023 17:31:57 -0800 (PST)
X-Received: by 2002:a50:d592:0:b0:54c:4837:7d1e with SMTP id
 v18-20020a50d592000000b0054c48377d1emr3150337edi.93.1702517516946; Wed, 13
 Dec 2023 17:31:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com> <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
In-Reply-To: <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Dec 2023 17:31:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
Message-ID: <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: Jeff Xu <jeffxu@google.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Dec 2023 at 16:36, Jeff Xu <jeffxu@google.com> wrote:
>
>
> > IOW, when would you *ever* say "seal this area, but MADV_DONTNEED is ok"?
> >
> The MADV_DONTNEED is OK for file-backed mapping.

Right. It makes no semantic difference. So there's no point to it.

My point was that you added this magic flag for "not ok for RO anon mapping".

It's such a *completely* random flag, that I go "that's just crazy
random - make sealing _always_ disallow that case".

So what I object to in this series is basically random small details
that should just eb part of the basic act of sealing.

I think sealing should just mean "you can't do any operations that
have semantic meaning for the mapping, because it is SEALED".

So I think sealing should automatically mean "can't do MADV_DONTNEED
on anon memory", because that's basically equivalent to a munmap/remap
operation.

I also think that sealing should just automatically mean "can't do
mprotect any more".

And yes, the OpenBSD semantics of "immutable" apparently allowed
reducing permissions, but even the openbsd man-page seems to think
that was a bug, so we should just not allow it. And the openbsd case
seems to be because of how they made certain things immutable by
default, which is different from what this mseal() thing is.

End result: I'd really like to make the thing conceptually simpler,
rather than add all those random (*very* random in case of
MADV_DONTNEED) special cases.

Is there any actual practical example of why you'd want a half-sealed thing?

And no, I didn't read the pdf that was attached. If it can't just be
explained in plain language, it's not an explanation.

I'd love for "sealed" to be just a single bit in the vm_flags things
that we already have. Not a config option. Not some complicated thing
that is hard to explain. A simple "I have set up this mapping, you
can't change it any more".

And if it cannot be that kind of thing, I want to have clear and
obvious examples of why it can't be that simple thing.

Not a pdf file that describes some google-chrome design. Something
down-to-earth and practical (and not a "we might want this in the
future" thing either).

IOW, what is wrong with "THIS VMA SETUP CANNOT BE CHANGED ANY MORE"?

Nothing less, but also nothing more. No random odd bits that need explaining.

              Linus

