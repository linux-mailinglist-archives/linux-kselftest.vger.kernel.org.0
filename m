Return-Path: <linux-kselftest+bounces-12431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19878912116
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 11:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B171F25907
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3E16EC01;
	Fri, 21 Jun 2024 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8JvkVKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888316E899;
	Fri, 21 Jun 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718963016; cv=none; b=i1Rm5dF8EU6dsYFxEBo7MXHIadG8Um5uMBBD26WUBoNw6ZsgdlBd2sS/dqaYsqkhw1iBAqmnvnfmQO/Ckjy5nK0wINtNxSQq4Mjt1qYKlrY+e54AOrcELmFG39UKJG0SvtYkctim7mSXoQiBrZ+U5mR7CCsY8YPjA/z9588UEUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718963016; c=relaxed/simple;
	bh=1qanX/q3WKZYHC6rEcONLtYsNe0oE006qtvSKCQMHI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so/jhRNRTYMZnJr15yE4MY0K21qAhmBjHLNzhR0kO5pUhXLxRA1qsMZzM1tNywp346mRAa50bNurRaQEJf/TsL/OUrdx37D6RwZtoudZhoF5p6uJ53NHmAqDp4BhA1r7wMKggQ9UPTnahd6IHURMerecb+W3z7EG4U1H11oHlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8JvkVKm; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-48f350bcd89so158792137.2;
        Fri, 21 Jun 2024 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718963013; x=1719567813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqLHgiTMJFtaX6sfG34bK9oM4kNpdFNFa/14p8/lD7w=;
        b=J8JvkVKmJqDH3YzOvPolY/miMNjSUdFrSTPLjf+M8UFE2UYSEQIVK8xYFuZj+G+Bam
         uJm2BDuGevBEjDGukYdjKuNpEi2adJggfqJOwVwaTrCIy2b5d1FKMS/wHwWLLArDSVi2
         ohEqnL0JUrN2/ScYF3PLYKUtcF5kF1Lk1KSM9XBoRxW2+FvfW5NvT27iyg/Q+uN3gdd1
         nemDtVQwZHraZxHDOPKbwqN/41osRrPUVDMOy+brPt64NGM9WFMmr2gD+NqA0lU6Qlck
         KiOEn/oetnRt12V0kFdbwE59tHFDTI4fIzFwSmyyJacasrqO4bSKYBuxVtgJiJxp0z9X
         TFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718963013; x=1719567813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqLHgiTMJFtaX6sfG34bK9oM4kNpdFNFa/14p8/lD7w=;
        b=ODFXhwSEi+I6Zg7CLKNE2ruciRT/KqRB6i7WiCeXwuuKD5yf7YG7MbPpbjQxuuBnxK
         M82qgr9mQmMj16sf6MXPZs+KzrES4wYoTboYZGspTQjqRqyBQK0Xy7oedhcRNZrytO0z
         2i7MEhsMVO2XC4U5ryswbCMI50DVgRDkJgcOvLrZzOqLvAC2TxSUevsNc5U5YaIRUh4S
         9l0+SX0uNQqAQ+rh/HvF5DlNw564U+MZg8U+1KwBPPSpRhEWAd2T3riHW6ql7CgVGtWO
         sXY5D6qyiYnwm2o5C+vskIv7pXF32enxZIKLBThRAmgOFiQZ8if65ZUv+2xHn3HuHQhr
         G5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPzLDtKnKsJeFubI+3mpyYcJRLiJtH8Fqj/S9Ipw719ofzu+VkUi3oPBkV9MM/eDRuATOoZrSbDOi6gq/MbZp9k3pBNrqeocG+vQT3caJFhS+jundVlsfDwqfL6+fTPnkLkcJaSQaJIXNHPQg4
X-Gm-Message-State: AOJu0YzrOHqFSbWk/rvAtMGNodCIkdM8GD4oqz1nK4p6v4bSmGhEtlZU
	yCot5/1xx99FvfjO79B/d1CdkkElJpRnl6kCrRqo+zvy66CAR+Skyaw5+4PR8/4PzQlLADyITil
	07c5Lbg1Qev2oVS8SVooBxNRhWEM=
X-Google-Smtp-Source: AGHT+IFMAoId7SY6B8VMs2FjQVmw40Rm/hJ1bVJU21YbkSpCM+udbaveFI7IM5pfBccw7MCoooc+zgTiRHPq4fDpT5g=
X-Received: by 2002:a05:6102:3595:b0:48d:b0c5:7fe4 with SMTP id
 ada2fe7eead31-48f130e4323mr9965440137.29.1718963013554; Fri, 21 Jun 2024
 02:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com> <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
 <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com> <87cyoa1wgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87cyoa1wgm.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Jun 2024 21:43:20 +1200
Message-ID: <CAGsJ_4xX52FKG+o7vsjAwBLjvfPH=tg_36xqjCnwc5yGV=SaVg@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	shuah@kernel.org, linux-mm@kvack.org, chrisl@kernel.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 9:24=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> >>
> >> On 20/06/2024 12:34, David Hildenbrand wrote:
> >> > On 20.06.24 11:04, Ryan Roberts wrote:
> >> >> On 20/06/2024 01:26, Barry Song wrote:
> >> >>> From: Barry Song <v-songbaohua@oppo.com>
> >> >>>
> >> >>> Both Ryan and Chris have been utilizing the small test program to =
aid
> >> >>> in debugging and identifying issues with swap entry allocation. Wh=
ile
> >> >>> a real or intricate workload might be more suitable for assessing =
the
> >> >>> correctness and effectiveness of the swap allocation policy, a sma=
ll
> >> >>> test program presents a simpler means of understanding the problem=
 and
> >> >>> initially verifying the improvements being made.
> >> >>>
> >> >>> Let's endeavor to integrate it into the self-test suite. Although =
it
> >> >>> presently only accommodates 64KB and 4KB, I'm optimistic that we c=
an
> >> >>> expand its capabilities to support multiple sizes and simulate mor=
e
> >> >>> complex systems in the future as required.
> >> >>
> >> >> I'll try to summarize the thread with Huang Ying by suggesting this=
 test program
> >> >> is "neccessary but not sufficient" to exhaustively test the mTHP sw=
ap-out path.
> >> >> I've certainly found it useful and think it would be a valuable add=
ition to the
> >> >> tree.
> >> >>
> >> >> That said, I'm not convinced it is a selftest; IMO a selftest shoul=
d provide a
> >> >> clear pass/fail result against some criteria and must be able to be=
 run
> >> >> automatically by (e.g.) a CI system.
> >> >
> >> > Likely we should then consider moving other such performance-related=
 thingies
> >> > out of the selftests?
> >>
> >> Yes, that would get my vote. But of the 4 tests you mentioned that use
> >> clock_gettime(), it looks like transhuge-stress is the only one that d=
oesn't
> >> have a pass/fail result, so is probably the only candidate for moving.
> >>
> >> The others either use the times as a timeout and determines failure if=
 the
> >> action didn't occur within the timeout (e.g. ksm_tests.c) or use it to=
 add some
> >> supplemental performance information to an otherwise functionality-ori=
ented test.
> >
> > Thank you very much, Ryan. I think you've found a better home for this
> > tool . I will
> > send v2, relocating it to tools/mm and adding a function to swap in
> > either the whole
> > mTHPs or a portion of mTHPs by "-a"(aligned swapin).
> >
> > So basically, we will have
> >
> > 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation cod=
e under
> > high exercise in a short time.
> >
> > 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in =
freeing
> > memory, as well as for munmap, app exits, or OOM killer scenarios. This=
 ensures
> > new mTHP is always generated, released or swapped out, similar to the b=
ehavior
> > on a PC or Android phone where many applications are frequently started=
 and
> > terminated.
>
> MADV_DONTNEED 64KB memory, then memset() it, this just simulates the
> large folio swap-in exactly, which hasn't been merged by upstream.  I
> don't think that it's a good idea to make such kind of trick.

I disagree. This is how userspace heaps can manage memory deallocation.
Additionally, in the event of an application exit, munmap, or OOM killer, t=
he
amount of freed memory can be much larger than 64KB. The primary purpose
of using MADV_DONTNEED is to release anonymous memory and generate
new mTHP so that the iteration can continue. Otherwise, the test program
becomes entirely pointless, as we only have large folios at the beginning.
That is exactly why Chris has failed to find his bugs by using other small
programs.

On the other hand, we definitely want large folios swap-in, otherwise, mTHP
is just a toy to Android or similar system where more than 2/3 memory could
be in swap. We do NOT want single-use mTHP.

>
> > 3. Swap in with or without the "-a" option to observe how fragments
> > due to swap-in
> > and the incoming swap-in of large folios will impact swap-out fallback.
>
> It's good to create fragmentation with swap-in.  Which is more practical
> and future-proof.  And, I believe that we can reduce large folio
> swap-out fallback rate without the large folio swap-in trick.
>
> > And many thanks to Chris for the suggestion on improving it within
> > selftest, though I
> > prefer to place it in tools/mm.
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

