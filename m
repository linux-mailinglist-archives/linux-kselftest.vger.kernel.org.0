Return-Path: <linux-kselftest+bounces-3977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DC846677
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10F981C24297
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA35C2D7;
	Fri,  2 Feb 2024 03:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4JTSwgo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E07C8C3
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 03:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844049; cv=none; b=c+yIZxEuEM3mG+AU7MXg9NjL5Vn4WC6zQ1wMOwIrZA+N+IJeRNGyucWJwre2oCum9xL/+ZiWgUCcJ8805FxDWhNYRTUK1PcKVI9YLDx4zAD/MWeztg0hYHVkoxHXDT/zpA3zyLVx9WLdJLjK/Zf1DJcZGiEJiLQRYl7zka6LRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844049; c=relaxed/simple;
	bh=fFGQ13+l6AOmPqowb86TJOcUlDYRhScyADQyTyzjTkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHBkAhuPct328eIPLGkqsEppvkIbfChU6N8/bdX0VhmwThEpm16P82rxuiSz/QVKCUKYGLTakaPibMHyscnHkgmwZKldW3xu5b67mYvqiNMXIrk0ZvYfsk+V3q+Oc0WO5payqnTbGG5iaCpQgor2672Ba5Sp7uxXjVS8ZwRHz1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4JTSwgo; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55f63fd3dd8so6390a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 19:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706844046; x=1707448846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1ccPOcrfBOBxKgyXEOc4T5KfmNv7K5VpG7dfv94EiA=;
        b=d4JTSwgoRq0LM/kFQkEfCBe2/B8a7HwN27Wsdda2aAeV4Y7wRlNrL9jo10G9W7A4HD
         pxaRBilK8fApyx19xzPD7JXBbj0lDfc+VQvfQovon7mQiU+/wybufBCjqDUgNuqzMOEZ
         UZ6VifYwX4FBj7oqn03wUJz6LcYFqUwZ3y5usU6RH1x6VuoKE555+YTfX83e1VcutCRE
         ZQtXcj7ezLMYh2i+R+Ni/bGwHDtZDqo7DwRsckbmJqqf4KDi3QgbHuZhFIi9y2s9BZjh
         ZxG5So/jFuNnpEOj4kP57FlDGpMbBLGZT/gv1jj0U4E28EZTOlXstw7d5J1cYyT63ELD
         qPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706844046; x=1707448846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1ccPOcrfBOBxKgyXEOc4T5KfmNv7K5VpG7dfv94EiA=;
        b=gLgcz7ACyKFhGDRZyAG1WQ8XdJfEV4Lu+0sG7sQux5htCMMTeN4Clt1D9Nb5RfzF33
         8s+rKIJ4rbiY8ja0eGgYZk0xeGp0VKjVqvanlLl6n+SmD2+0Yhrlj3Q1McFdxq44VvrT
         W2tmOvVvcvCHBD4DmXS6/b4klHtpV8eJCNjf1rR/6bv7iSNLtTkMeK9QRcTS/urz5wlE
         Cvy4s8vIlJHjVd2JESfOFNQt71QZu88HMo9lIHyArebLkMw+Tk4HAAEIfwi8xTeaOhKO
         AhHy/YOPaYSxmyCX6huiz+ta6ka6qw1sK+XusVlqQDLayPeTA63KGkxSBi0Bt9ipRuVr
         qq7Q==
X-Gm-Message-State: AOJu0YzytXu+LORWSUyPnm9FVBlQWLpQ0UPjFBgjCLAV/QW/1d3ZeSsE
	/WGwRIgyYlH9B3y8fJvt9HFzsEX9xj3VOzK0TPR5jfOB+NULw+BL9gJvkyzNXLTPowd8AvigW0c
	tFszeCXsP9XxZ7u1DZD7qgtEaDQK+LTPODDP8
X-Google-Smtp-Source: AGHT+IETV/je7D6y3Sm+exJ30FP4o+/gQJbnsW13jxMrj5U3Y6RvNW5CXCTWMCQ6Ci/5MpOeg2RKxta4JNZl5e2HZ+o=
X-Received: by 2002:a50:951e:0:b0:55f:993a:f1c2 with SMTP id
 u30-20020a50951e000000b0055f993af1c2mr87759eda.6.1706844045871; Thu, 01 Feb
 2024 19:20:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org> <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
In-Reply-To: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 1 Feb 2024 19:20:08 -0800
Message-ID: <CALmYWFtqcixi3p3Ab44wENJr+n2k2SNaCJEofNm_awnNdJZnDQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Theo de Raadt <deraadt@openbsd.org>, Jeff Xu <jeffxu@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 3:15=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 1 Feb 2024 at 14:54, Theo de Raadt <deraadt@openbsd.org> wrote:
> >
> > Linus, you are in for a shock when the proposal doesn't work for glibc
> > and all the applications!
>
> Heh. I've enjoyed seeing your argumentative style that made you so
> famous back in the days. Maybe it's always been there, but I haven't
> seen the BSD people in so long that I'd forgotten all about it.
>
> That said, famously argumentative or not, I think Theo is right, and I
> do think the MAP_SEALABLE bit is nonsensical.
>
> If somebody wants to mseal() a memory region, why would they need to
> express that ahead of time?
>
I like to look at things from the point of view of average Linux
userspace developers,  they might not have the same level of expertise
as the other folks on this email list or they might not have time and
mileage for those details.

To me, the most important thing is to deliver a feature that's easy to
use and works well. I don't want users to mess things up, so if I'm
the one giving them the tools, I'm going to make sure they have all
the information they need and that there are safeguards in place.

e.g. considering the following user case:
1> a security sensitive data is allocated from heap, using malloc,
from the software component A, and filled with information.
2> software component B then uses mprotect to change it to RO, and
seal it using mseal().

Yes. we could choose to allow it. But there are complications:

1> Is this the right pattern ? why don't component A already seal it
if they think it is important ?
2> Why  heap, why not mmap() a new memory mapping for that security data ?
3>  free() will not respect the situation of whether the memory is
sealed or not. How would a new developer know they probably shall
never free the sealed memory ?
4>  brk-shrink will never be able to pass the VMA that gets splited
out by mseal(), there are memory footprint implications to the
process.
5>  what if the security sensitive data happens to be the first VMA or
last VMA of the heap, will sealing the first VMA/last VMA cause any
issue there ? since they might carry important VMA flags ? ( I don't
know enough about brk.)
6> If we ever support sealing the heap for its entirety (make it not
executable), and still want to support other brk behaviors, such as
shrink/grow, would that conflict with current mseal(), if we allow it
on heap from beginning ?

Questions like that, without clear answers, to me it is premature to
already let developers start using  mseal() for heap.

And even if we have all the answers for heap, how about stack, or
other types of virtual memory ?

Again, I don't have enough knowledge to get a complete list that
shouldn't be sealed,  the input from Theo is none should I worry
about.  However it  is clearly not none to me, besides heap mentioned,
there is also aio/shm.

So MAP_SEALABLE is a conservative approach to limit the scope to ***
two known use cases *** that  I want to work on (libc and chrome) and
give  time needed to answer those questions. It is like a claim: only
those marked by MAP_SEALABLE support the sealing at this point of
time.

And MAP_SEALABLE is reversible, e.g. a sysctl could be added to make
all memory sealable in the future, or we could obsoleted it entirely
when time comes, an application that already passes MAP_SEALABLE can
be treated as noop. However, if all memory were allowed to be sealable
from the beginning, reversing that decision would be hard.

After those considerations, if MAP_SEALABLE is still not preferred by
you. Then I have the following options for you to choose:

1. MAP_NOT_SEALABLE in the mmap(). And I will use them for the
heap/aio/shm case.
This basically says Linux does not officially support sealing on
those,  until we support them, we discourage the sealing on those
mappings.

2. make MAP_NOT_SEALABLE only a kernel visible flag. So application
space won't be able to use it.

3. open for all, and list as much as details in the documentation.
 If we choose this route, I would like to have more discussion on the
heap/stack, at least the Linux developers will learn from those
discussions.

> So the part I think is sane is the mseal() system call itself, in that
> it allows *potential* future expansion of the semantics.
>
> But hopefully said future expansion isn't even needed, and all users
> want the base experience, which is why I think PROT_SEAL (both to mmap
> and to mprotect) makes sense as an alternative form.
>
> So yes, to my mind
>
>     mprotect(addr, len, PROT_READ);
>     mseal(addr, len, 0);
>
> should basically give identical results to
>
>     mprotect(addr, len, PROT_READ | PROT_SEAL);
>
> and using PROT_SEAL at mmap() time is similarly the same obvious
> notion of "map this, and then seal that mapping".
>
> The reason for having "mseal()" as a separate call at all from the
> PROT_SEAL bit is that it does allow possible future expansion (while
> PROT_SEAL is just a single bit, and it won't change semantics) but
> also so that you can do whatever prep-work in stages if you want to,
> and then just go "now we seal it all".
>

To clarify: do you mean to have the following ?

mmap(PROT_READ|PROT_SEAL)
mseal(addr,len,0)
mprotect(addr,len,PROT_READ|PROT_SEAL) ?

I have to think about the mprotect() case.

For mmap(PROT_READ|PROT_SEAL),  I might  have a use case already:

fs/binfmt_elf.c
if (current->personality & MMAP_PAGE_ZERO) {
                /* Why this, you ask???  Well SVr4 maps page 0 as read-only=
,
                   and some applications "depend" upon this behavior.
                   Since we do not have the power to recompile these, we
                   emulate the SVr4 behavior. Sigh. */

                error =3D vm_mmap(NULL, 0, PAGE_SIZE,
                                PROT_READ | PROT_EXEC,   <-- add PROT_SEAL
                                MAP_FIXED | MAP_PRIVATE, 0);
        }

I don't see the benefit of RWX page 0, which might make a null
pointers error to become executable for some code.

Best Regards,
-Jeff

>           Linus

