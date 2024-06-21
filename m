Return-Path: <linux-kselftest+bounces-12410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B1911F4A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 10:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A63828BBC8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 08:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5F16D4DD;
	Fri, 21 Jun 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4ytXGOm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87B18E20;
	Fri, 21 Jun 2024 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959848; cv=none; b=MRn8Ylys2Q1x4AFfJ4w7lOxN5QgF77otHNX+0ajVeuZEMg4QTNEXl+U133HjtplHLPkokmWVJrOYJLAzuQbBkjjlaVQKz8BFsf37BAMdCBbY3moRegA2ysy2P5lUQ2rUgcMR2/oTqr+e48ibhYvJWtzrU+d4jOWM0cFlRlMFysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959848; c=relaxed/simple;
	bh=PZK+y9IrBmfcyL/NEma5WNE67KPzT5Vfy29QsNFdLTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOcXM2ZJh8PvHr73KTtTBf/9bfM91vrwnj95wX1SPZtV0HPeWMx/wJNdLyoz/8whJd3LisA03j3p5PbNl+NVkt7fjMKnQeE0roXIQgmcUv1nYcXZE+lJao2uGHg/wEBN0GeGIrHqhJikunuznuPitOhN/Yn4Fa1zDldKXAyWoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4ytXGOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6405CC4AF0C;
	Fri, 21 Jun 2024 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718959848;
	bh=PZK+y9IrBmfcyL/NEma5WNE67KPzT5Vfy29QsNFdLTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U4ytXGOm45qB6KIjZ1kb557AnaG6CYKw4iJZwhRN0/L74mmUZXeywYHZ/AVwB+55N
	 tGIq5ELrXS7axJAxf+P7O/l7HE7C8QI5k4MlmGrtOYG97kz7h8v3zs/N7Agrh4MhJw
	 a0Ff6Ycgod9u2V5kApL8zxmXiZkVlnXIqJoDiy3QuhHV6chZuz5Sw0atQ24p07u2eG
	 ErYl9ctHE0kc1UET2GhksU1SMOACACqFjx/L6B1euo6XXxRNTLIcHsFEOfe7V18vl/
	 TeNeAnBs77pAt4zSWNQ8ZqAMKp7j6/oZRkcPJqX91iliPIcFI5CKbeAPPnvwxkFkJ8
	 o8T4A7rZt33Ew==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52bbf73f334so1520012e87.2;
        Fri, 21 Jun 2024 01:50:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6XAtXhcr19lNPlRWVSzq2JJJDV/vnBpV4zBaw9jRwacGJT5KMoeM+MFHJ3r9HNrtVnSp8g4PW5JsyWsVkIpYa3I0f9n9wLDq6H24Luc/WApXLkE5swHJNI3mwf7fS9FidspaWqhjBoWTL7N79
X-Gm-Message-State: AOJu0YyjpP1zPMih5K8LtFDFR/ey+a/L2pOtHAEMckUqO46jByHnnmEH
	9tsu9Gcr4wrRpcQWcBFVXiFL8nccaA76jDXMUe3D+STZkJJ07c8K7LVjjcLMVbwJJo2tODAjgm8
	bzzOhrjVq6RFcjXaH4lEUbaVdCA==
X-Google-Smtp-Source: AGHT+IGZ4e8uRVE52VeLsDYoPWEaG0mJ9iQuxHimYcfx3rr7/xXSmVv+Q+yczg1q7bSKqw5UBCj0KNWaAQ0+bKY18+8=
X-Received: by 2002:a19:4347:0:b0:52c:8318:dc14 with SMTP id
 2adb3069b0e04-52ccaa5dc33mr4448995e87.25.1718959846994; Fri, 21 Jun 2024
 01:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <f3c18806-34ac-41d3-8c79-d7dd6504547e@arm.com>
 <d0b20f47-384d-49f1-8449-0da6da11089c@redhat.com> <b99c2f80-3b53-4b04-b610-a66179b928a9@arm.com>
 <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
In-Reply-To: <CAGsJ_4y_pjMpNOFzrPZ6u7=M83-CQ0umDCPt=ZDuSKJWssiCqA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 21 Jun 2024 01:50:35 -0700
X-Gmail-Original-Message-ID: <CANeU7QnURKHyz8c5KzfdCW1fFCcsJw9HbTAL2d4L0RP6hiCoMA@mail.gmail.com>
Message-ID: <CANeU7QnURKHyz8c5KzfdCW1fFCcsJw9HbTAL2d4L0RP6hiCoMA@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: Barry Song <21cnbao@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org, 
	shuah@kernel.org, linux-mm@kvack.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, linux-kselftest@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:47=E2=80=AFAM Barry Song <21cnbao@gmail.com> wro=
te:
>
> On Fri, Jun 21, 2024 at 7:25=E2=80=AFPM Ryan Roberts <ryan.roberts@arm.co=
m> wrote:
> >
> > On 20/06/2024 12:34, David Hildenbrand wrote:
> > > On 20.06.24 11:04, Ryan Roberts wrote:
> > >> On 20/06/2024 01:26, Barry Song wrote:
> > >>> From: Barry Song <v-songbaohua@oppo.com>
> > >>>
> > >>> Both Ryan and Chris have been utilizing the small test program to a=
id
> > >>> in debugging and identifying issues with swap entry allocation. Whi=
le
> > >>> a real or intricate workload might be more suitable for assessing t=
he
> > >>> correctness and effectiveness of the swap allocation policy, a smal=
l
> > >>> test program presents a simpler means of understanding the problem =
and
> > >>> initially verifying the improvements being made.
> > >>>
> > >>> Let's endeavor to integrate it into the self-test suite. Although i=
t
> > >>> presently only accommodates 64KB and 4KB, I'm optimistic that we ca=
n
> > >>> expand its capabilities to support multiple sizes and simulate more
> > >>> complex systems in the future as required.
> > >>
> > >> I'll try to summarize the thread with Huang Ying by suggesting this =
test program
> > >> is "neccessary but not sufficient" to exhaustively test the mTHP swa=
p-out path.
> > >> I've certainly found it useful and think it would be a valuable addi=
tion to the
> > >> tree.
> > >>
> > >> That said, I'm not convinced it is a selftest; IMO a selftest should=
 provide a
> > >> clear pass/fail result against some criteria and must be able to be =
run
> > >> automatically by (e.g.) a CI system.
> > >
> > > Likely we should then consider moving other such performance-related =
thingies
> > > out of the selftests?
> >
> > Yes, that would get my vote. But of the 4 tests you mentioned that use
> > clock_gettime(), it looks like transhuge-stress is the only one that do=
esn't
> > have a pass/fail result, so is probably the only candidate for moving.
> >
> > The others either use the times as a timeout and determines failure if =
the
> > action didn't occur within the timeout (e.g. ksm_tests.c) or use it to =
add some
> > supplemental performance information to an otherwise functionality-orie=
nted test.
>
> Thank you very much, Ryan. I think you've found a better home for this
> tool . I will
> send v2, relocating it to tools/mm and adding a function to swap in
> either the whole
> mTHPs or a portion of mTHPs by "-a"(aligned swapin).
>
> So basically, we will have
>
> 1. Use MADV_PAGEPUT for rapid swap-out, putting the swap allocation code =
under
> high exercise in a short time.
>
> 2. Use MADV_DONTNEED to simulate the behavior of libc and Java heap in fr=
eeing
> memory, as well as for munmap, app exits, or OOM killer scenarios. This e=
nsures
> new mTHP is always generated, released or swapped out, similar to the beh=
avior
> on a PC or Android phone where many applications are frequently started a=
nd
> terminated.

Will this cover the case that the ratio of order 0 and order 4 swap
requests change during LMK, and swapfile is almost full?

If not, please add that :-)

> 3. Swap in with or without the "-a" option to observe how fragments
> due to swap-in
> and the incoming swap-in of large folios will impact swap-out fallback.
>
> And many thanks to Chris for the suggestion on improving it within
> selftest, though I
> prefer to place it in tools/mm.

I am perfectly fine with that. Looking forward to your V2.

Chris

