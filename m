Return-Path: <linux-kselftest+bounces-12533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043599140E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F402F1C2119A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6782479DE;
	Mon, 24 Jun 2024 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAUaXmh0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EB376;
	Mon, 24 Jun 2024 04:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719201960; cv=none; b=D35N15c8//2mNcFtAWRDA3lujmDbe/qVyuzTz/M0GsRCTLsORYXYCWOE44CpVEqJjU/asO6c8IaxtZkvPlh7qnvFoyKgAUpwizNWRI4CflMX0194vdt/9iY4yQ2UXObP/i3fjH+3qcus2Vj1DDAK48bOEJlRMy3Jz3MIYBdRixU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719201960; c=relaxed/simple;
	bh=FWt5CXDOVLZF0RY7H2vzKgPZsHf23vWMih7MvtWQ0Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q55r9B+VZtKYXO+/32pR5A7DI2Ci63VLBbQGxOb7fvf/offiE4WJbsqQ3/+wU0uducLKo9D9HtQNAVij7inAoW2abgzU3SCEWowJJC7McbDHB3Qysr1KGpUTKlCbrGPEsPULlvSrkvp6lp08q0ToDeriAJTn2lGHJ+A/Ehi73LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAUaXmh0; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4ef12e5658bso1082952e0c.2;
        Sun, 23 Jun 2024 21:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719201957; x=1719806757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFYYQvDriXIp8ZXDGg/PZl7S86PYVcjLjRy0AZ9fGK4=;
        b=ZAUaXmh0u/CCs4Wvfa9DHD1Qubhth/tBhs4K78Yh/nxxdEtFI//WCjU+Uf2M0A7Z1L
         krrNv5mufU6FyoXdGqTSYKQNgYmq/oejQtiyaeXGOzVCkvopsxwZd21elJyI4gqCXJYz
         1Owd2HzOJJtnHNAuk28tdnBE7JqH9+nS6uQQrNLe/G3xqo97PpOuaIAYZ3ORMvLn11qG
         cIXaXR25jtzPl8FVpNJOvNSrQP8eDqBS6gtrD1r9axEURJUfM3gkkuYQICqjwetMjKBN
         FgoEnKtMoiekC6gtZAGb/F5m96qcsihVHKUvRy2A3g3Geb68+zVwyE+9PPASR9E5iokY
         sxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719201957; x=1719806757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFYYQvDriXIp8ZXDGg/PZl7S86PYVcjLjRy0AZ9fGK4=;
        b=pyn57LiE9xRLp+HjnnR+Et4pFPybpXNow/aFxBIFxUt65X0vSLqcLYxgZwtVF/zhwu
         Y25qZM7TEqQeZXnp/aFf2kvNe9zKzGjrhV8YYsf+eZ2qzzp8C4FU6r0hD96qXkDvP21P
         t2l02ucakVy/LBOvT2Z0jV7MWTUv6cnHJQ4n+O6mm5TswYzlygqvEAURqVEAAdyyL3IF
         +WKiXN+n/BsfhA9gCIft2V8V2uIPSDZud3O63uOYHImGdT7kJCKI/qfdNG3x9qzChdoa
         kaju54Zsy0ij2MsfERkStx8b/8yelOwEfxL54CWGfAIoKa+rlwO4zImbKSugUh2FM/Tv
         nW1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUkG7HL/eLp/0x9UTzTN1afp0U7OYcNphxzJso9Z9NdK8uOS0dbcWq4ypjNLspEoLZjKhtLjN+gFw63QfgYZBfr1cbaWMMXdVJXSAyVKfmNeYXT3hH6lbLvPPVXHxPRPbQ6PiimXt6zUnmI0xs4
X-Gm-Message-State: AOJu0YyJyEsaW6ucYVIOCi37wWI/v8yVJFEQ2pq8aqtI22PaJPZbo6Ol
	HUYuFe2cR0amUqP5j0L5txY5uQ8zTKseFD9MrMqYK6qknDlvlFcVw9O132sGhdR1qxSiOQTauXC
	L9XlTQEYj60z7rLEEGhhuSbGjwRA=
X-Google-Smtp-Source: AGHT+IGPTUnYz46c/rYn3eU3BAHwiHrWl6KuTHDvpUvUvzhUDIRlvAJ3b0pmr5gYcl/o3/6HW1IDCV3P3qnqmdqE20U=
X-Received: by 2002:a05:6122:2a52:b0:4e4:ee60:a60b with SMTP id
 71dfb90a1353d-4ef6d7d0a70mr1240888e0c.3.1719201957445; Sun, 23 Jun 2024
 21:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com> <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
 <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
 <87cyoa1wgm.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4xX52FKG+o7vsjAwBLjvfPH=tg_36xqjCnwc5yGV=SaVg@mail.gmail.com>
 <878qyv0zwk.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <878qyv0zwk.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 24 Jun 2024 16:05:44 +1200
Message-ID: <CAGsJ_4y9JinvzA6Wd2aXe_FRYhxED0vkkvU2HwWW8WBEX+8oqw@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	shuah@kernel.org, linux-mm@kvack.org, chrisl@kernel.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 3:44=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Fri, Jun 21, 2024 at 9:24=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@a=
rm.com> wrote:
> >> >>
> >> >> On 20/06/2024 12:34, David Hildenbrand wrote:
> >> >> > On 20.06.24 11:04, Ryan Roberts wrote:
> >> >> >> On 20/06/2024 01:26, Barry Song wrote:
> >> >> >>> From: Barry Song <v-songbaohua@oppo.com>
> >> >> >>>
> >> >> >>> Both Ryan and Chris have been utilizing the small test program =
to aid
> >> >> >>> in debugging and identifying issues with swap entry allocation.=
 While
> >> >> >>> a real or intricate workload might be more suitable for assessi=
ng the
> >> >> >>> correctness and effectiveness of the swap allocation policy, a =
small
> >> >> >>> test program presents a simpler means of understanding the prob=
lem and
> >> >> >>> initially verifying the improvements being made.
> >> >> >>>
> >> >> >>> Let's endeavor to integrate it into the self-test suite. Althou=
gh it
> >> >> >>> presently only accommodates 64KB and 4KB, I'm optimistic that w=
e can
> >> >> >>> expand its capabilities to support multiple sizes and simulate =
more
> >> >> >>> complex systems in the future as required.
> >> >> >>
> >> >> >> I'll try to summarize the thread with Huang Ying by suggesting t=
his test program
> >> >> >> is "neccessary but not sufficient" to exhaustively test the mTHP=
 swap-out path.
> >> >> >> I've certainly found it useful and think it would be a valuable =
addition to the
> >> >> >> tree.
> >> >> >>
> >> >> >> That said, I'm not convinced it is a selftest; IMO a selftest sh=
ould provide a
> >> >> >> clear pass/fail result against some criteria and must be able to=
 be run
> >> >> >> automatically by (e.g.) a CI system.
> >> >> >
> >> >> > Likely we should then consider moving other such performance-rela=
ted thingies
> >> >> > out of the selftests?
> >> >>
> >> >> Yes, that would get my vote. But of the 4 tests you mentioned that =
use
> >> >> clock_gettime(), it looks like transhuge-stress is the only one tha=
t doesn't
> >> >> have a pass/fail result, so is probably the only candidate for movi=
ng.
> >> >>
> >> >> The others either use the times as a timeout and determines failure=
 if the
> >> >> action didn't occur within the timeout (e.g. ksm_tests.c) or use it=
 to add some
> >> >> supplemental performance information to an otherwise functionality-=
oriented test.
> >> >
> >> > Thank you very much, Ryan. I think you've found a better home for th=
is
> >> > tool . I will
> >> > send v2, relocating it to tools/mm and adding a function to swap in
> >> > either the whole
> >> > mTHPs or a portion of mTHPs by "-a"(aligned swapin).
> >> >
> >> > So basically, we will have
> >> >
> >> > 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation =
code under
> >> > high exercise in a short time.
> >> >
> >> > 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap =
in freeing
> >> > memory, as well as for munmap, app exits, or OOM killer scenarios. T=
his ensures
> >> > new mTHP is always generated, released or swapped out, similar to th=
e behavior
> >> > on a PC or Android phone where many applications are frequently star=
ted and
> >> > terminated.
> >>
> >> MADV_DONTNEED 64KB memory, then memset() it, this just simulates the
> >> large folio swap-in exactly, which hasn't been merged by upstream.  I
> >> don't think that it's a good idea to make such kind of trick.
> >
> > I disagree. This is how userspace heaps can manage memory
> > deallocation.
>
> Sorry, I don't understand how.  Can you show some examples?  Such as
> strace log with 64KB aligned MADV_DONTNEED?

In Java heap and memory allocators such as jemalloc and Scudo, memory is fr=
eed
using the MADV_DONTNEED flag when either free() is called or garbage collec=
tion
occurs. In Android, the Java heap is freed in chunks aligned to 64KB
or larger. In
Scudo and jemalloc, there is a configuration option to set the
management granularity.
This granularity is set to match the mTHP size(though the default
value is 16KB in the
latest Android if we don't run mTHP). Otherwise, you could end up with
millions of
partial unmap operations, which would severely degrade the performance of m=
THP.

Imagine libc/Java functioning like a slab allocator. When kfree() is
called, some pages
may become completely unoccupied and can be returned to the buddy allocator=
. In
userspace, memory is given back to the kernel in a similar manner,
typically using
MADV_DONTNEED. Therefore, MADV_DONTNEED is the most common memory
reclamation behavior in Android, coming with free(), delete() or GC.

Imagine a system with extensive malloc, free, new, and delete
operations, where objects
are constantly being created and destroyed.

On the other hand, whether libc/Java use MADV_DONTNEED to free memory is no=
t
crucial, although they do. We need a method to simulate the lifecycle
of applications
=E2=80=94exiting and starting anew=E2=80=94on PCs or Android phones. It doe=
sn't matter if you
use MADV_DONTNEED or munmap to achieve this.

It is important to note that mTHP currently operates on a one-shot
basis(after swap-out,
you never get them back as mTHP as we don't support large folios
swapin). For the test
program, we need a method to generate new mTHPs continuously. Without this,
after the initial iterations, we would be left with only folios,
rendering the entire
test program *pointless*.

>
> > Additionally, in the event of an application exit, munmap, or OOM kille=
r, the
> > amount of freed memory can be much larger than 64KB. The primary purpos=
e
> > of using MADV_DONTNEED is to release anonymous memory and generate
> > new mTHP so that the iteration can continue. Otherwise, the test progra=
m
> > becomes entirely pointless, as we only have large folios at the beginni=
ng.
> > That is exactly why Chris has failed to find his bugs by using other sm=
all
> > programs.
>
> Although I still don't understand how 64KB aligned MADV_DONTNEED is used
> for libc/java heap or munmap in a practical way.  After more thoughts, I
> think 64KB Aligned MADV_DONTNEED can simulate the fragmentation effect
> of processes exit at some degree if 64KB folios in these processes are
> swapped out without splitting.  If you have no other practical use
> cases, I suggest to make it explicit with comments in program.
>
> > On the other hand, we definitely want large folios swap-in, otherwise, =
mTHP
> > is just a toy to Android or similar system where more than 2/3 memory c=
ould
> > be in swap. We do NOT want single-use mTHP.
>
> I agree that large folios swap-in has its value at least in some
> situations.  Whether we should take it as default behavior is another
> topic, we can discuss it further in the future.

Cool. Just imagine that mTHP is beneficial for systems that don't frequentl=
y
use swap. However, for Android, where most memory resides in swap, mTHP
acts like a one-way ticket: you end up with small folios and can't revert t=
o
large ones. This is so BAD.

>
> >>
> >> > 3. Swap in with or without the "-a" option to observe how fragments
> >> > due to swap-in
> >> > and the incoming swap-in of large folios will impact swap-out fallba=
ck.
> >>
> >> It's good to create fragmentation with swap-in.  Which is more practic=
al
> >> and future-proof.  And, I believe that we can reduce large folio
> >> swap-out fallback rate without the large folio swap-in trick.
> >>
> >> > And many thanks to Chris for the suggestion on improving it within
> >> > selftest, though I
> >> > prefer to place it in tools/mm.
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

