Return-Path: <linux-kselftest+bounces-12405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C639911D38
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D03EB22A07
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3A16D333;
	Fri, 21 Jun 2024 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErtuEyC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF416D322;
	Fri, 21 Jun 2024 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956037; cv=none; b=mfNI96X83N2MHWD4mNwZ4HDQFPIBzbsmCK2F68dnWR7bdgeYnQAH3VkrfGF+B/5gII/hfT+XehEpnESKeQ3K4sOv0sjUtmZ3vKU7MwcaWb1giDEJdaJeki/VcEt9c67GnogWGM4o0EySHNYB+TKl3wCc52Qpsc80M2OgGghgqGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956037; c=relaxed/simple;
	bh=hb2Fy9ZwHI1dYIHOgnUy42pdbjf6n2Bld7IZk3B0d8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GINiEJZlTz8Ylw8nsN7GYzqW17Aee6OmE9j55RlI0sAj4uRmFK1E13TPcIHC0vBh2vE6ALZ5ORASrp7dgEqEhIRDZpWnF9h73qare4+Nn1DP58NHEoVZpArfk2bUw7lwS5hKPBDjgl/31DLfJUAP/l2TsX3s0DrEA+o+mXk4Vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErtuEyC5; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-48f3b3165e1so63125137.3;
        Fri, 21 Jun 2024 00:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718956035; x=1719560835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hb2Fy9ZwHI1dYIHOgnUy42pdbjf6n2Bld7IZk3B0d8I=;
        b=ErtuEyC5DFkTDPcHoTK10JJetcU2w4gdI5n1b+taKRqaiKoi/n/Svj0x+OzCtfoiR9
         vBfp3U3JCaycjFUjIRPUiwIbdVbAQ9s+fg0KB6Ycc4Mz/BmbXPqtHcXurTmv7wLbQ66J
         SpNSDM8YxZPL+0g6j3xxKd4AfsqaK8KlMUsUQtKjkWqosdhVVS5GGC+pnwPIMstaLvfW
         A7UdIvjHe6GxbIo0/eTYW5JZfxkq2e8navx5dl9whxnn4+tawTGYArQQ7kus0s4wBHP6
         ocR6JZy+8nB/3K5KMlziVoophYTGhRLx7g22gfmbewhDJ2nXG8xL0mgg93WycHL15uk3
         KQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718956035; x=1719560835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hb2Fy9ZwHI1dYIHOgnUy42pdbjf6n2Bld7IZk3B0d8I=;
        b=mYdTPpAb1hTIyB7uM4YFbl+ioABEdvZGEFMJ3ruQyzL0DXSiixgai/ozWyn6vLMvRj
         eZbtLXM0DjZQt95TkeO1OLBqWkDWOj0fJOTEqddE5iRYmBk3bFttHnd7MDIfrSM2sYu7
         hu2eYE+GsU22t9HzFsqbvgf2rlN2lhQ1NsvKaKJsZcfM+TiH1mcejSN1pUeQOpuRlBUy
         W9aOrLUFBH7YOnguRxC8Zc2LIOzCBRbRMb5imx/2aB2VlZ0KQwKqy0qIYh5iYcA8f6ID
         nvwDj00lbD0rE86wOw7O3RdIrukE92M0pVt5aJmLmF0yWxTO0aEj//EwGw2hfpjdw3bK
         +odw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUjNK6QpYwC0aiK7ASH+FW2MgeZPDMOhFRBIQiA3yvOYcLxyrV/raSzDHohdU06DyHt1dILob+dC9UhuhgwN+uuPBU+ZoVJD27jyve8y2SsdWamQbJIBRZEYWLxsfU/bLlwEhDCzt2qB8QPNu
X-Gm-Message-State: AOJu0YzSmVzZKKbUKP9CoCScOJ+lOBjYMPAglC0e7a6DjS3uarW+0Ycr
	fztxq6Umfulm0NOcTzSvuMLG6ydNeUyAfCgsQNv5jQzV3mu89n864sYU0o9hcnQzoR7eyamzgyS
	Gjuqgt3+U8AWojHxGl93KNuKC84A=
X-Google-Smtp-Source: AGHT+IENxJpB3fR9O1qG5MmYWU2eUwfRE0yy8BBUjnzGd+z9Xs2T3ZKskBIctY2so5qNjGrbh91CJEO2hUli5f90diw=
X-Received: by 2002:a67:f505:0:b0:48f:30cd:d94c with SMTP id
 ada2fe7eead31-48f30cde5f3mr2014409137.6.1718956034943; Fri, 21 Jun 2024
 00:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com> <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
In-Reply-To: <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 21 Jun 2024 19:47:02 +1200
Message-ID: <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, shuah@kernel.org, 
	linux-mm@kvack.org, chrisl@kernel.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, linux-kselftest@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 20/06/2024 12:34, David Hildenbrand wrote:
> > On 20.06.24 11:04, Ryan Roberts wrote:
> >> On 20/06/2024 01:26, Barry Song wrote:
> >>> From: Barry Song <v-songbaohua@oppo.com>
> >>>
> >>> Both Ryan and Chris have been utilizing the small test program to aid
> >>> in debugging and identifying issues with swap entry allocation. While
> >>> a real or intricate workload might be more suitable for assessing the
> >>> correctness and effectiveness of the swap allocation policy, a small
> >>> test program presents a simpler means of understanding the problem an=
d
> >>> initially verifying the improvements being made.
> >>>
> >>> Let's endeavor to integrate it into the self-test suite. Although it
> >>> presently only accommodates 64KB and 4KB, I'm optimistic that we can
> >>> expand its capabilities to support multiple sizes and simulate more
> >>> complex systems in the future as required.
> >>
> >> I'll try to summarize the thread with Huang Ying by suggesting this te=
st program
> >> is "neccessary but not sufficient" to exhaustively test the mTHP swap-=
out path.
> >> I've certainly found it useful and think it would be a valuable additi=
on to the
> >> tree.
> >>
> >> That said, I'm not convinced it is a selftest; IMO a selftest should p=
rovide a
> >> clear pass/fail result against some criteria and must be able to be ru=
n
> >> automatically by (e.g.) a CI system.
> >
> > Likely we should then consider moving other such performance-related th=
ingies
> > out of the selftests?
>
> Yes, that would get my vote. But of the 4 tests you mentioned that use
> clock_gettime(), it looks like transhuge-stress is the only one that does=
n't
> have a pass/fail result, so is probably the only candidate for moving.
>
> The others either use the times as a timeout and determines failure if th=
e
> action didn't occur within the timeout (e.g. ksm_tests.c) or use it to ad=
d some
> supplemental performance information to an otherwise functionality-orient=
ed test.

Thank you very much, Ryan. I think you've found a better home for this
tool . I will
send v2, relocating it to tools/mm and adding a function to swap in
either the whole
mTHPs or a portion of mTHPs by "-a"(aligned swapin).

So basically, we will have

1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code un=
der
high exercise in a short time.

2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in free=
ing
memory, as well as for munmap, app exits, or OOM killer scenarios. This ens=
ures
new mTHP is always generated, released or swapped out, similar to the behav=
ior
on a PC or Android phone where many applications are frequently started and
terminated.

3. Swap in with or without the "-a" option to observe how fragments
due to swap-in
and the incoming swap-in of large folios will impact swap-out fallback.

And many thanks to Chris for the suggestion on improving it within
selftest, though I
prefer to place it in tools/mm.

Thanks
Barry

