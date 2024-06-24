Return-Path: <linux-kselftest+bounces-12547-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3449143F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 09:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15C5281B08
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFBB487BE;
	Mon, 24 Jun 2024 07:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGZXdO3M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C1487A9;
	Mon, 24 Jun 2024 07:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719215719; cv=none; b=K8EIrqWrDUPBWSxR2I1C03Ho4dwiJAo8+D6arulTZ565sfXZpk53asdBSqAelya1nqrtPYhkkd8QAlqaZEYd1IxkzqfRZFIDQlaQCeJvKcK6kdMnYxUiORQLVH9MppUICigzgmsT1p79p+bbg2471EFS4PJuBlQ3gwrOWeqol4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719215719; c=relaxed/simple;
	bh=LXHYzbtHJtkCNTXIFjXDRy9bP02BLCvJWQT4CG0sHUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSPtT+4CjphKJDm5ke7rbm6AmC8FyCaSzyD4JtuXlHTGJ2YNKVgc8zXRLnhqLLigfIinPNweGtQmsOgPMA9KOodfnDKm5n4qwt8jzJlOxITmmjV9NNpn+a+r1OJqIl7dGSEKkKW1cH330zeYhgS6T0qPMeX4lK2SK6rhho+PaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGZXdO3M; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4ef7cf84648so240856e0c.3;
        Mon, 24 Jun 2024 00:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719215716; x=1719820516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M44QliiGI4wbA+J/OJex8f2IcZehHAYy3iurIa3mQM=;
        b=BGZXdO3MM4goSPwCYd50nr1NONoti2jO+xM562vUcj4nBvoQz1M2RMUgCKdzT90Mxd
         2QKbD8w9wjbqOQwoFZ8ZN3ptL74IupH4QeKHGmdIimM7XGB7TFDvafCNAIVYAfCttChu
         QsVds8qMh78hBRkPgSHa7z+NVczYYg1050eBLdPaOuU18rGenRIh/Ov4bKGyyqbZz7UM
         VZP1wyvFsglUIoFXyntj6T4LgYMpFxc3LSIFcMBJPaiyYX2MegN01INt2l2n8xngXZbv
         hsY2zfio2pi3J1ZSsyB9Q5CEyEqfDF0YjucQ+mR7NL9wwiO3ul/oyIV+qyHYoRDXi8t5
         uV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719215716; x=1719820516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M44QliiGI4wbA+J/OJex8f2IcZehHAYy3iurIa3mQM=;
        b=qLAhaJOzhZDsT0TWfuesClMF5++uJRFsUCwz7sD65t9gYEdKCwlb5dM+Cq1G9LafHe
         k3sCiRdr0aauFXj2CPHfKY5p86yytUoDzNS6UO8ubVQFSP5zWuwmuU1NknlEYDUOTLVG
         bG6qjTel6K+hBExYoZ7w5HYUiwX5tAPZVMQcI6E8ZAoDMCGa5B1zHIohO8YXUI3apdOd
         7HvNN8ZAG0PgPAruikWjN2jA1u7AjvPj35tx/vsaiqtqSlDwjL3di8NM1dGUd4HIyAY3
         HNlfWu+Joc5voAigVbi1OhyR+mxJkOJutE58xM/ToRNIAmT6GRkFQtF2UOBWX7QWWDkR
         70pg==
X-Forwarded-Encrypted: i=1; AJvYcCWW3waYF5brGO984tyni7mXlYeexiyrMS/R+9uL4xC1jDsTPtW7oIE/26GjNoriNyVTUEXOtJAccXQ+veudy25tynv1rI9wTwA+awQR6bWbQi6o0Qll9x5XAh/Mf2+lr3b6T37aVxwLUDIz72H3
X-Gm-Message-State: AOJu0YwP8QtnPArtVta0MUn9UabWWPzkNfQOVG1A59/N1EN2mv/O2l1c
	QC2AVnx9uTZ6U+f1azUwg+6KfokpXIqxqjziUiOTOgVaClwq6papPaPZTtvIqesHjmF2zB/WYaq
	CGlv/DODA6btJWpYHk9QU0MXXe9U=
X-Google-Smtp-Source: AGHT+IEoT41PuDFqnUrEIizToRPT7FgMJf748qpwaLIXeADY612U8AoFnLspB3mb/g0vYtPvYir2H58zuLI/uLbS4kA=
X-Received: by 2002:a05:6122:1ad0:b0:4ef:678e:8a90 with SMTP id
 71dfb90a1353d-4ef6d7d7e4dmr2403905e0c.3.1719215716234; Mon, 24 Jun 2024
 00:55:16 -0700 (PDT)
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
 <878qyv0zwk.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4y9JinvzA6Wd2aXe_FRYhxED0vkkvU2HwWW8WBEX+8oqw@mail.gmail.com>
 <871q4m25du.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <871q4m25du.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 24 Jun 2024 19:55:04 +1200
Message-ID: <CAGsJ_4yH4xOBtch1XEq4hPz9inWC+c60Wa84XxU-BXFg_1ga-Q@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	shuah@kernel.org, linux-mm@kvack.org, chrisl@kernel.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 7:01=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Mon, Jun 24, 2024 at 3:44=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Fri, Jun 21, 2024 at 9:24=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.robert=
s@arm.com> wrote:
> >> >> >>
> >> >> >> On 20/06/2024 12:34, David Hildenbrand wrote:
> >> >> >> > On 20.06.24 11:04, Ryan Roberts wrote:
> >> >> >> >> On 20/06/2024 01:26, Barry Song wrote:
> >> >> >> >>> From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >>>
> >> >> >> >>> Both Ryan and Chris have been utilizing the small test progr=
am to aid
> >> >> >> >>> in debugging and identifying issues with swap entry allocati=
on. While
> >> >> >> >>> a real or intricate workload might be more suitable for asse=
ssing the
> >> >> >> >>> correctness and effectiveness of the swap allocation policy,=
 a small
> >> >> >> >>> test program presents a simpler means of understanding the p=
roblem and
> >> >> >> >>> initially verifying the improvements being made.
> >> >> >> >>>
> >> >> >> >>> Let's endeavor to integrate it into the self-test suite. Alt=
hough it
> >> >> >> >>> presently only accommodates 64KB and 4KB, I'm optimistic tha=
t we can
> >> >> >> >>> expand its capabilities to support multiple sizes and simula=
te more
> >> >> >> >>> complex systems in the future as required.
> >> >> >> >>
> >> >> >> >> I'll try to summarize the thread with Huang Ying by suggestin=
g this test program
> >> >> >> >> is "neccessary but not sufficient" to exhaustively test the m=
THP swap-out path.
> >> >> >> >> I've certainly found it useful and think it would be a valuab=
le addition to the
> >> >> >> >> tree.
> >> >> >> >>
> >> >> >> >> That said, I'm not convinced it is a selftest; IMO a selftest=
 should provide a
> >> >> >> >> clear pass/fail result against some criteria and must be able=
 to be run
> >> >> >> >> automatically by (e.g.) a CI system.
> >> >> >> >
> >> >> >> > Likely we should then consider moving other such performance-r=
elated thingies
> >> >> >> > out of the selftests?
> >> >> >>
> >> >> >> Yes, that would get my vote. But of the 4 tests you mentioned th=
at use
> >> >> >> clock_gettime(), it looks like transhuge-stress is the only one =
that doesn't
> >> >> >> have a pass/fail result, so is probably the only candidate for m=
oving.
> >> >> >>
> >> >> >> The others either use the times as a timeout and determines fail=
ure if the
> >> >> >> action didn't occur within the timeout (e.g. ksm_tests.c) or use=
 it to add some
> >> >> >> supplemental performance information to an otherwise functionali=
ty-oriented test.
> >> >> >
> >> >> > Thank you very much, Ryan. I think you've found a better home for=
 this
> >> >> > tool . I will
> >> >> > send v2, relocating it to tools/mm and adding a function to swap =
in
> >> >> > either the whole
> >> >> > mTHPs or a portion of mTHPs by "-a"(aligned swapin).
> >> >> >
> >> >> > So basically, we will have
> >> >> >
> >> >> > 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocati=
on code under
> >> >> > high exercise in a short time.
> >> >> >
> >> >> > 2. Use MADV_DONTNEED to simulate the behavior of libc and Java he=
ap in freeing
> >> >> > memory, as well as for munmap, app exits, or OOM killer scenarios=
. This ensures
> >> >> > new mTHP is always generated, released or swapped out, similar to=
 the behavior
> >> >> > on a PC or Android phone where many applications are frequently s=
tarted and
> >> >> > terminated.
> >> >>
> >> >> MADV_DONTNEED 64KB memory, then memset() it, this just simulates th=
e
> >> >> large folio swap-in exactly, which hasn't been merged by upstream. =
 I
> >> >> don't think that it's a good idea to make such kind of trick.
> >> >
> >> > I disagree. This is how userspace heaps can manage memory
> >> > deallocation.
> >>
> >> Sorry, I don't understand how.  Can you show some examples?  Such as
> >> strace log with 64KB aligned MADV_DONTNEED?
> >
> > In Java heap and memory allocators such as jemalloc and Scudo, memory i=
s freed
> > using the MADV_DONTNEED flag when either free() is called or garbage co=
llection
> > occurs. In Android, the Java heap is freed in chunks aligned to 64KB
> > or larger.
>
> Originally, I heard about that MADV_FREE is used by jemalloc.  Now, I
> know that they use MADV_DONTNEED too.  Thanks!
>
> Although I still suspect that libc/java allocator will free pages in
> exact 64KB size (IIUC, they should free pages in much larger trunk).  I
> agree that MADV_DONTNEED is a way to create fragmentation in swap
> devices.

Right.

They don't always free memory in exact 64KB sizes or mTHP size, but we
need to define a minimum granularity. Typically, when many objects are
freed, they combine into a larger free block, which is then released to
kernel all at once.

As an example, libc might map lots of 4MB VMAs and classify them into
different size categories=E2=80=94some for small objects and others for lar=
ger ones.
While attempts are made to consolidate adjacent free blocks to reduce
system calls, MADV_DONTNEED is often utilized at the minimum granularity
for small objects when merging is temporarily impractical - We don't always
encounter two or more memory blocks where all the objects have been
released :-)


>
> > In
> > Scudo and jemalloc, there is a configuration option to set the
> > management granularity.
> > This granularity is set to match the mTHP size(though the default
> > value is 16KB in the
> > latest Android if we don't run mTHP). Otherwise, you could end up with
> > millions of
> > partial unmap operations, which would severely degrade the performance =
of mTHP.
> >
> > Imagine libc/Java functioning like a slab allocator. When kfree() is
> > called, some pages
> > may become completely unoccupied and can be returned to the buddy alloc=
ator. In
> > userspace, memory is given back to the kernel in a similar manner,
> > typically using
> > MADV_DONTNEED. Therefore, MADV_DONTNEED is the most common memory
> > reclamation behavior in Android, coming with free(), delete() or GC.
> >
> > Imagine a system with extensive malloc, free, new, and delete
> > operations, where objects
> > are constantly being created and destroyed.
> >
> > On the other hand, whether libc/Java use MADV_DONTNEED to free memory i=
s not
> > crucial, although they do. We need a method to simulate the lifecycle
> > of applications
> > =E2=80=94exiting and starting anew=E2=80=94on PCs or Android phones. It=
 doesn't matter if you
> > use MADV_DONTNEED or munmap to achieve this.
> >
> > It is important to note that mTHP currently operates on a one-shot
> > basis(after swap-out,
> > you never get them back as mTHP as we don't support large folios
> > swapin). For the test
> > program, we need a method to generate new mTHPs continuously. Without t=
his,
> > after the initial iterations, we would be left with only folios,
> > rendering the entire
> > test program *pointless*.
>
> I understand the requirements for new mTHPs.
>
> >>
> >> > Additionally, in the event of an application exit, munmap, or OOM ki=
ller, the
> >> > amount of freed memory can be much larger than 64KB. The primary pur=
pose
> >> > of using MADV_DONTNEED is to release anonymous memory and generate
> >> > new mTHP so that the iteration can continue. Otherwise, the test pro=
gram
> >> > becomes entirely pointless, as we only have large folios at the begi=
nning.
> >> > That is exactly why Chris has failed to find his bugs by using other=
 small
> >> > programs.
> >>
> >> Although I still don't understand how 64KB aligned MADV_DONTNEED is us=
ed
> >> for libc/java heap or munmap in a practical way.  After more thoughts,=
 I
> >> think 64KB Aligned MADV_DONTNEED can simulate the fragmentation effect
> >> of processes exit at some degree if 64KB folios in these processes are
> >> swapped out without splitting.  If you have no other practical use
> >> cases, I suggest to make it explicit with comments in program.
> >>
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

