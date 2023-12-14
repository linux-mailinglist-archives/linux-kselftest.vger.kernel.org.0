Return-Path: <linux-kselftest+bounces-1964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D613813B59
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 21:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B1528115E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Dec 2023 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C016A032;
	Thu, 14 Dec 2023 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zt2jpx02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F56A006
	for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso10049920e87.0
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 12:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702584867; x=1703189667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzpbUH5EkrEm9i3H+vtEmgiPJGsbQVnri/dVuua/oQA=;
        b=Zt2jpx025or3R+upmsZBAVw4TOoB+Ar5UIfFUYL3+8E6/abQk4KE/tEjPxEvxTlKPQ
         6xPjUI5NVejZoryHs4aq0ZtkAARA2pdMRUymSHR8o2aRrDBgCJaSejdLgRr71ROsJ93d
         u167LzKpsgZ9bixi8zJVFHomwewvdKU5AFyt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702584867; x=1703189667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzpbUH5EkrEm9i3H+vtEmgiPJGsbQVnri/dVuua/oQA=;
        b=rvVlYvH/GaPNOuRpxgm+/yOqGOac0IsHV0S1GYlBCjDEuGgGQ/iWYEJU7jtggFWlXC
         nlLE67g+4mw01yLvweHyBmmkyZNmD+H7LOBegBuJdImzhAd+OVM0/8cmYMMFG6s+kS27
         rn31q6422bWlUTg8ciNfTgEe202U97cb37YDRNG2KWoN+RMc113lXGWq8ARSk/mr8g1e
         Zceer7mrkZbYtIZ935+vnxUcug6rJwKEkR3Jk/eqZ/QyM5qKGgNjisQWe/WEi5o8kZ7/
         xBcSmDnIF4q3fsisilbONlhGjmFe0JLwFys1p09KqN+4JiOrZayRYWTgKYPjvPq/v8R0
         8gGw==
X-Gm-Message-State: AOJu0YzIH4SDKL3FFMwqcA8m1uNmzAMywLSuioZdM58EVH06Z7ZkIPAu
	dG6x6n3hDgR3J71pOUFVpadMtm6IogqlgOv4C9UtwKgP1Bw=
X-Google-Smtp-Source: AGHT+IGx5cEN6+bOtjcwpvk3R3oScHiClitqb7fMuBo9TN88hvLcEqwWOnIICIWQhzvX5TyOPYB6xA==
X-Received: by 2002:a05:6512:e82:b0:50e:17e6:6bd2 with SMTP id bi2-20020a0565120e8200b0050e17e66bd2mr772759lfb.0.1702584866942;
        Thu, 14 Dec 2023 12:14:26 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i14-20020a056512340e00b0050bf8129d47sm1962620lfr.146.2023.12.14.12.14.26
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 12:14:26 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c9fbb846b7so98216891fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Dec 2023 12:14:26 -0800 (PST)
X-Received: by 2002:a2e:b80d:0:b0:2cc:3f14:405d with SMTP id
 u13-20020a2eb80d000000b002cc3f14405dmr1108832ljo.102.1702584866181; Thu, 14
 Dec 2023 12:14:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212231706.2680890-1-jeffxu@chromium.org> <20231212231706.2680890-12-jeffxu@chromium.org>
 <CAHk-=wgn02cpoFEDQGgS+5BUqA2z-=Ks9+PNd-pEJy8h+NOs5g@mail.gmail.com>
 <CALmYWFu39nzHvBmRsA326GcmV9u=eM-2aCGOvLK31rrb2R9NEw@mail.gmail.com>
 <CAHk-=wh_VViVZxjiQ5jtB0q=p=JtJMj2R24UAmj-fL-RNLWxNw@mail.gmail.com> <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
In-Reply-To: <CAEAAPHZpYXHNPdca+xfj77bwYaL6PY-c_oQ54r+=wtJa6_hmCA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Dec 2023 12:14:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
Message-ID: <CAHk-=wiVhHmnXviy1xqStLRozC4ziSugTk=1JOc8ORWd2_0h7g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] mseal:add documentation
To: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Cc: Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Dec 2023 at 10:07, Stephen R=C3=B6ttger <sroettger@google.com> w=
rote:
>
> AIUI, the madvise(DONTNEED) should effectively only change the content of
> anonymous pages, i.e. it's similar to a memset(0) in that case. That's wh=
y we
> added this special case: if you want to madvise(DONTNEED) an anonymous pa=
ge,
> you should have write permissions to the page.

Hmm. I actually would be happier if we just made that change in
general. Maybe even without sealing, but I agree that it *definitely*
makes sense in general as a sealing thing.

IOW, just saying

 "madvise(DONTNEED) needs write permissions to an anonymous mapping when se=
aled"

makes 100% sense to me. Having a separate _flag_ to give sensible
semantics is just odd.

IOW, what I really want is exactly that "sensible semantics, not random fla=
gs".

Particularly for new system calls with fairly specialized use, I think
it's very important that the semantics are sensible on a conceptual
level, and that we do not add system calls that are based on "random
implementation issue of the day".

Yes, yes, then as we have to maintain things long-term, and we hit
some compatibility issue, at *THAT* point we'll end up facing nasty
"we had an implementation that had these semantics in practice, so now
we're stuck with it", but when introducing a new system call, let's
try really hard to start off from those kinds of random things.

Wouldn't it be lovely if we can just come up with a sane set of "this
is what it means to seal a vma", and enumerate those, and make those
sane conceptual rules be the initial definition. By all means have a
"flags" argument for future cases when we figure out there was
something wrong or the notion needed to be extended, but if we already
*start* with random extensions, I feel there's something wrong with
the whole concept.

So I would really wish for the first version of

     mseal(start, len, flags);

to have "flags=3D0" be the one and only case we actually handle
initially, and only add a single PROT_SEAL flag to mmap() that says
"create this mapping already pre-sealed".

Strive very hard to make sealing be a single VM_SEALED flag in the
vma->vm_flags that we already have, just admit that none of this
matters on 32-bit architectures, so that VM_SEALED can just use one of
the high flags that we have several free of (and that pkeys already
depends on), and make this a standard feature with no #ifdef's.

Can chrome live with that? And what would the required semantics be?
I'll start the list:

 - you can't unmap or remap in any way (including over-mapping)

 - you can't change protections (but with architecture support like
pkey, you can obviously change the protections indirectly with PKRU
etc)

 - you can't do VM operations that change data without the area being
writable (so the DONTNEED case - maybe there are others)

 - anything else?

Wouldn't it be lovely to have just a single notion of sealing that is
well-documented and makes sense, and doesn't require people to worry
about odd special cases?

And yes, we'd have the 'flags' argument for future special cases, and
hope really hard that it's never needed.

           Linus

