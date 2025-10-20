Return-Path: <linux-kselftest+bounces-43553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BFCBF1A12
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF08B1894453
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A85320CC3;
	Mon, 20 Oct 2025 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="hINppOgg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0465031D750
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968082; cv=none; b=jhYKyKIWaGBnH2ZwH4bSr3t57MR6EWcUrQhHCvtaoWDorjxRAKzKNNFV2dF20zdsFmfReR15hkvZv69m/VHc9vtqrVL267rQM2iH3v3vll/mp753KZBAU6HJNfrydR6pfNBQ+Zocy8tq47LVD7bDGPCek4s6sCXzK8hcvUb28Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968082; c=relaxed/simple;
	bh=P+aFf9oth4LiKv2hExgb8uC+PnKCw7ZhDOkJopU58r0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4ZJYFdPAYwkcZaphPAnbJtIBZTDlm8L16BxptIkg3tEBvIkvkRol6U+AS951Cpfn6usMq3P4+LKNiyuf6JIqzOkSQFjhSJe9/2M0IR0JUDUMJc19gknHR39ykXP2ybTxipSpUTsq8d+mSzjcsGU0fDWmCQwxq76fwMl/QyMouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=hINppOgg; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso8027076a12.2
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760968079; x=1761572879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owfB6MZ/RaTOdbtTEnPA/HVBHwSA4OIJrzJG673UzUg=;
        b=hINppOggA8fVRnKjRaE9phEEFuBRXXqg4dTzeh0HMwjTj61TSvG81KShztWwA+ZdeI
         D8NrRTH1VVs56xsGnoMnP3JlLqLnU2I4N/qmqvmmUyBpVVI7oTeiEB3B370fT85c0lGM
         frJu1C7Fovn9RtXaoxuAHJ9E/JvW2fvG5oJlEuA6dd2IA50HE2/0cFlqPZAo5TIGzulm
         ZwNIIDXgqYmqIN5Lrceo4jMazGfDjBD9CK2dSgnpMp96x56Xy1v6RyQf85L8vEgvJrun
         J9g42WRBwHv22BAxjCSenW2/Y9Zf+ac9wSoRkIm18dFuwk8xtMzS7iKErGlqu0D8Bwin
         Kh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968079; x=1761572879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owfB6MZ/RaTOdbtTEnPA/HVBHwSA4OIJrzJG673UzUg=;
        b=Me6oiFFKJ5jdmP3A4OREL3+AVn8s7NgvGAhsYFHFJOJceOyPqGRWXuZTcYrYCufx+K
         je+F6kgCc4PfE1/fHnTzTVlplpgpvjlthpz2WAgGhSwKHfuU4BSfYINKCWexdPVvYMEB
         b7XLlQEa1i1L2wcTePIq6BNh+9DBQu2c3fDCDvpKBEmva7ywTYsnDpomihpTDMraGpSD
         j5PoAqnJgkcSotZltjqz2YmUE1XLPG6LN/4gAM/DGOTMS1NN8GGGjQnKLyf0LzYIKQoA
         KQEO+JMoldlq6dsH11+/aF8r16HUt6Nj/TfFPhDQkIXQ/BVaVn187ulEs4B3ruCTZzRU
         KfGw==
X-Forwarded-Encrypted: i=1; AJvYcCUl+7scDRc8EmZLCZV1+csc9nTPc6ayx8WUPTqJbxC+FcpHHh+CJ5lU6ASm4th6TsAR9EQs2lgBj7s9pSNvW4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrozbgAkb5uGjAKFMc8WeUEsWtZXzrpDx9Ryf8QFFH4ZQU2h88
	IA5583BU9ON+BQoY49IzAmABcpY70zzpI/AH0w2l/2GsBzeVludtzKzlRjctZ88P1DCV+YI+MVR
	okv6MRHghpFR+ElvBAO+AldAVVkBKjAs1ZLFlyYpSmg==
X-Gm-Gg: ASbGncut/bwe+RkiL/AaEQTx2a+cex7n8E454+nqearhc4glEwSUekwC26ZwkB6S2UA
	rEc0KqMJMWvZ5HvQhuGIxCdqjst+pJYqG1gTXBkvBea6F51rYg6PZWm5m/lnfypwVr3xc4lsTxw
	421aIXkz9iJmPIaE98XvAVcZWnnKDD83XfYcWirti+JBhA8R3wdbtKeDXBcC8jvGnnRti633/HJ
	NpkaRGtGJ0/z7qSivIL1gQpIfpyDa/XvuGrrP7vxU0kzqQGqJoy1DH05vplio/U5A0BiLDmUCBg
	Qnw=
X-Google-Smtp-Source: AGHT+IFcr4yYt5BkZRvwg4aS3vOuI/dUA++JB1Pa5n/q7YHF3s544Z0m9fDyyoCLymYJhHWCIs054zb/31d4lLoohCo=
X-Received: by 2002:a05:6402:2113:b0:637:ee5f:d89e with SMTP id
 4fb4d7f45d1cf-63c1f6b4c29mr12824950a12.20.1760968078712; Mon, 20 Oct 2025
 06:47:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <aPXz-IPDRniMHN0u@kernel.org> <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>
In-Reply-To: <CA+CK2bDMc8RdcNq_qmmW02DNzLePxQNWBgdOuwrfJ=jmr0YK8w@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 09:47:22 -0400
X-Gm-Features: AS18NWAHh0mRsVXmirlOiWUS1kBKZtHjFUd9z0xLGz6uGryTcRWZa3G7aWSpR-I
Message-ID: <CA+CK2bDaN5quQd+3UOXguxRfdq2OMLSVqnPU-cM-=YCCRw8=Tw@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] liveupdate: Rework KHO for in-kernel users & Fix
 memory corruption
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 9:46=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On Mon, Oct 20, 2025 at 4:34=E2=80=AFAM Mike Rapoport <rppt@kernel.org> w=
rote:
> >
> > On Sat, Oct 18, 2025 at 01:17:46PM -0400, Pasha Tatashin wrote:
> > > This series addresses comments and combines into one the two
> > > series [1] and [2], and adds review-bys.
> > >
> > > This series refactors the KHO framework to better support in-kernel
> > > users like the upcoming LUO. The current design, which relies on a
> > > notifier chain and debugfs for control, is too restrictive for direct
> > > programmatic use.
> > >
> > > The core of this rework is the removal of the notifier chain in favor=
 of
> > > a direct registration API. This decouples clients from the shutdown-t=
ime
> > > finalization sequence, allowing them to manage their preserved state
> > > more flexibly and at any time.
> > >
> > > Also, this series fixes a memory corruption bug in KHO that occurs wh=
en
> > > KFENCE is enabled.
> > >
> > > The root cause is that KHO metadata, allocated via kzalloc(), can be
> > > randomly serviced by kfence_alloc(). When a kernel boots via KHO, the
> > > early memblock allocator is restricted to a "scratch area". This forc=
es
> > > the KFENCE pool to be allocated within this scratch area, creating a
> > > conflict. If KHO metadata is subsequently placed in this pool, it get=
s
> > > corrupted during the next kexec operation.
> > >
> > > [1] https://lore.kernel.org/all/20251007033100.836886-1-pasha.tatashi=
n@soleen.com
> > > [2] https://lore.kernel.org/all/20251015053121.3978358-1-pasha.tatash=
in@soleen.com
> > >
> > > Mike Rapoport (Microsoft) (1):
> > >   kho: drop notifiers
> > >
> > > Pasha Tatashin (9):
> > >   kho: allow to drive kho from within kernel
> > >   kho: make debugfs interface optional
> > >   kho: add interfaces to unpreserve folios and page ranes
> > >   kho: don't unpreserve memory during abort
> > >   liveupdate: kho: move to kernel/liveupdate
> > >   kho: move kho debugfs directory to liveupdate
> > >   liveupdate: kho: warn and fail on metadata or preserved memory in s=
cratch area
> > >   liveupdate: kho: Increase metadata bitmap size to PAGE_SIZE
> > >   liveupdate: kho: allocate metadata directly from the buddy allocato=
r
> >
> > The fixes should go before the preparation for LUO or even better as a
> > separate series.
> >
> > I've reread the LUO preparation patches and I don't think they are usef=
ul
> > on their own. They introduce a couple of unused interfaces and I think =
it's
> > better to have them along with the rest of LUO patches.
>

Forgot to add:
The LUO preparation patches have been soaking in linux-next for some
time now and are mostly reviewed.
...
> Pulling them out to apply fixes separately feels counterproductive,
> especially since we agreed to add the new kexec_handover_debug.c file.
> The most straightforward path is to build on what's already in -next.
> Let's stick with the current approach.
>
> Thanks,
> Pasha
>
> >
> > --
> > Sincerely yours,
> > Mike.

