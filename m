Return-Path: <linux-kselftest+bounces-12445-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7191233A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 13:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADCE6B23431
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB742173326;
	Fri, 21 Jun 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx4xNJRE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3E17332A;
	Fri, 21 Jun 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968857; cv=none; b=IytZ9TDYfZB0RKT5Pn7Cf2MhlFscVlVu3dcqi6EfjZb+SpthCnU4aup96ingVD/sqHNrRGVcf9iJpuL3d1K19O+prDztwXkS2OXsVFfsxPE7Eg1zDF/DMlQERuBmFiaEheKNXRunXWFW+eeCyz9T6YlkGToz4fUy6WcSIe6PZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968857; c=relaxed/simple;
	bh=expKverTQwLFbgLvc5JqaPG/XGjYSuNCZkjywWmUcWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XM1rz/TifgObYbWxzkqW81Pv/3YQTPjssno7VHH1AK3FslkgsmvwKHz3HSlgIA20gnIpvmnVzdgLoHdHzihnmnr8dJwX+RLTZ4MREMMl0QYu9bh4XJ1KbYdqMtZjMvV9ihvg6Iuh8vZw/44XX3Z6FH0GhWPErMJaRjRTxkZeHXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yx4xNJRE; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-797a8cfc4ecso118417385a.3;
        Fri, 21 Jun 2024 04:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718968855; x=1719573655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=expKverTQwLFbgLvc5JqaPG/XGjYSuNCZkjywWmUcWc=;
        b=Yx4xNJRE6cwO23RlMEBJ6iMVA7wnISA3NeQBWUeyL80dj5Q8Mb2sV7srry/nd9hO6y
         DeqCNtrmDRutg4yYWWleIgRa6CEe4QXw/bIxkYDRrOFjsxQirA+OW05MXB0sr+H/mDXp
         YMe0t9xagnJcvV/TowzaHey21I4xDm2xZmTzeB4RDHaUVsmDMe7D/AzpyHa1efJgmi0F
         rpQFd17teL2sOSDN5ssE8I2vMvWvN6w7bsfxymY4mgWHSh9oUY6d2Lu08odQPoga2eGV
         hiAfM+cNxyYdas0TtwoPu0YmGwVZLrwIC35n0nvk8enBiL8UIwoi48/dd1SxxrGyqglN
         D5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718968855; x=1719573655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=expKverTQwLFbgLvc5JqaPG/XGjYSuNCZkjywWmUcWc=;
        b=mV/qKdhxcpe+qsjpRm4/GsC9YFIcgr8HJAq1Uvwxg2SdiD8bkLjbnWF189q7+HGMWH
         XDXnLzhz8PmwN2tkxfjx0JEueaYiYpBhcEhYlZUW9rGMp+pWB9Tkje5SmLyNwGOYYXAP
         pGqCxorL6ugeucC1MfCS02KFH/HODFKsnAMRxoOorYbWGZFufRowPtmccKSCGzvK+ZNQ
         kemH1Ktj7q5Q62AZELN7SBZgWRywuhUnLF5kAePbyo4LaVW1b1M2cIMD++Ei4Zs6JZnh
         voofd6DWKBPBuk2tqT8drR88edNpsbdHrm6f8MeFTOZlBDwxbs+VcSynWSBnxajPN9ut
         v2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUDQOrkXEXMc+CiF1ZDGSewxsb24YxOGoY+LdrFjTEH/hGrssO9iRo/hujIDSkg5oO+i/qca6mvZH3ZrzvrCUgt/hxHilIWp1tq0zJy2b2sPS35aZMYbs1sqLnVYn/CStYR4DU1+gX1gK4M7Z8T
X-Gm-Message-State: AOJu0YxTTXU2cYkxE/Wz6z7/ujbUN9mo22ZideSQwClY+evclcNbTjMF
	UsK02Iy41DTZ+O7RaNvjPasEdu6q/8meByWZy7S7h6nTsle7dRRHaOBI2eTxUCkSKEUsWb6ZBJt
	OqRvm6JxYX9SVcKNfJSWy8XyjVFc=
X-Google-Smtp-Source: AGHT+IGmJ6cnArzxMGquykZMa9FOUQZ2LPltqRLgO4ZbdvrZSjSCd8tc4lPHCPg3LwW9FM4RyDa2LZl9geq/qEjVUUM=
X-Received: by 2002:a05:6214:80c:b0:6b0:7864:90ac with SMTP id
 6a1803df08f44-6b501e06c38mr90689636d6.11.1718968855094; Fri, 21 Jun 2024
 04:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com> <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
 <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com> <CANeU7QnURKHyz8c5KzfdCW1fFCcsJw9HbTAL2d4L0RP6hiCoMA@mail.gmail.com>
In-Reply-To: <CANeU7QnURKHyz8c5KzfdCW1fFCcsJw9HbTAL2d4L0RP6hiCoMA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Jun 2024 19:20:43 +0800
Message-ID: <CAGsJ_4w5uLXSZrwM2HPSuZC6Dinj09P3623jnqr5edoNBwb1sQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: Chris Li <chrisl@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	shuah@kernel.org, linux-mm@kvack.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, linux-kselftest@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:50=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Fri, Jun 21, 2024 at 12:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
> > >
> > > On 20/06/2024 12:34, David Hildenbrand wrote:
> > > > On 20.06.24 11:04, Ryan Roberts wrote:
> > > >> On 20/06/2024 01:26, Barry Song wrote:
> > > >>> From: Barry Song <v-songbaohua@oppo.com>
> > > >>>
> > > >>> Both Ryan and Chris have been utilizing the small test program to=
 aid
> > > >>> in debugging and identifying issues with swap entry allocation. W=
hile
> > > >>> a real or intricate workload might be more suitable for assessing=
 the
> > > >>> correctness and effectiveness of the swap allocation policy, a sm=
all
> > > >>> test program presents a simpler means of understanding the proble=
m and
> > > >>> initially verifying the improvements being made.
> > > >>>
> > > >>> Let's endeavor to integrate it into the self-test suite. Although=
 it
> > > >>> presently only accommodates 64KB and 4KB, I'm optimistic that we =
can
> > > >>> expand its capabilities to support multiple sizes and simulate mo=
re
> > > >>> complex systems in the future as required.
> > > >>
> > > >> I'll try to summarize the thread with Huang Ying by suggesting thi=
s test program
> > > >> is "neccessary but not sufficient" to exhaustively test the mTHP s=
wap-out path.
> > > >> I've certainly found it useful and think it would be a valuable ad=
dition to the
> > > >> tree.
> > > >>
> > > >> That said, I'm not convinced it is a selftest; IMO a selftest shou=
ld provide a
> > > >> clear pass/fail result against some criteria and must be able to b=
e run
> > > >> automatically by (e.g.) a CI system.
> > > >
> > > > Likely we should then consider moving other such performance-relate=
d thingies
> > > > out of the selftests?
> > >
> > > Yes, that would get my vote. But of the 4 tests you mentioned that us=
e
> > > clock_gettime(), it looks like transhuge-stress is the only one that =
doesn't
> > > have a pass/fail result, so is probably the only candidate for moving=
.
> > >
> > > The others either use the times as a timeout and determines failure i=
f the
> > > action didn't occur within the timeout (e.g. ksm_tests.c) or use it t=
o add some
> > > supplemental performance information to an otherwise functionality-or=
iented test.
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
> Will this cover the case that the ratio of order 0 and order 4 swap
> requests change during LMK, and swapfile is almost full?
>
> If not, please add that :-)

Due to 2, we ensure a certain proportion of mTHP. Similarly, because
of 3, we maintain
a certain proportion of small folios, as we don't support large folios
swap-in, meaning
any swap-in will immediately result in small folios. Therefore, with
both 2 and 3, we
automatically achieve a system containing both mTHP and small folios.
Additionally,
1 provides the ability to continuously swap them out. If we set the
same sizes for 2
and 3, we'll achieve a 1:1 ratio of large folios to small folios. How
about starting with
a 1:1 ratio?

To meet the requirement that the swapfile is almost full, I can
increase the memory to
ensure the total size is quite close to zRAM. This way, we give the
small folios a chance
to perform a slow scan and observe the impact.

>
> > 3. Swap in with or without the "-a" option to observe how fragments
> > due to swap-in
> > and the incoming swap-in of large folios will impact swap-out fallback.
> >
> > And many thanks to Chris for the suggestion on improving it within
> > selftest, though I
> > prefer to place it in tools/mm.
>
> I am perfectly fine with that. Looking forward to your V2.
>
> Chris

Thanks
Barry

