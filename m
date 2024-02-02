Return-Path: <linux-kselftest+bounces-4043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F9847A53
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F196F1F27981
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 20:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD16381724;
	Fri,  2 Feb 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N74BO7gP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDE80636
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904885; cv=none; b=SPefF/qUpoRqhVNrEhguXlyWcht4W9OkzASfSC/M5SFsFZ1EEHVBjL2IpqigUUYPXNNa6tQoN6jNVGMM65YEvERZ0XJuSqwBoVjGqL4nyQlhbDsso9KSkudl+ilqLKsuUOJgn1YA/8LNG54o4d0UQLo7Iv6ab0BN7V+Zbh11PF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904885; c=relaxed/simple;
	bh=sx4sFIFIHZ82OGYD+khz42RvuPih8T9qNkm0UgLfxCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MT6Jl2ZbTPEcOS0tGtaG+ki4z9VVvdrM5SXfu/F2k7+Dirv1i6jmz6r3eRyVs2aUb9FyKx69QzPmXwHZHqSeH+zRP5KeNJKyOIaU12hyh5Jmvd3m+vxXQOiZmAmHgrRWfpQ9kPe/KNKRBUZOrBbBK8NDEXmfXFvQPWcoSlfk35A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N74BO7gP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2144c37f3d3so1377476fac.0
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Feb 2024 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706904883; x=1707509683; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqTNsAxhlA2YuESAciCqyaWHxO/Ad9sPBhytH5Lgwoo=;
        b=N74BO7gP4Bl8t1oytthp3F2tkb0+NRqXG7rMXDT6f7aY42IDLRji+2z50dHq13e5qe
         516tctlhfcdTosZ7XxqvPBwd8KIQXLBTFdFJnGkP1ZJ6NyHH2xV4caKp2tnuxUyh9Z0E
         K6XK2MTfJy31FyuIqyxJN9l40nntzCKjxY5UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706904883; x=1707509683;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqTNsAxhlA2YuESAciCqyaWHxO/Ad9sPBhytH5Lgwoo=;
        b=ohIqv0yAPKvVmkj5IbcdlNYzb8V7iXoiZGK3jUnnFnSFtmEU7Q9OzW/PLDJyH/Y0rE
         BePeFP70a/t9/vpeWcnh0u9WHDnp9MFaTWQ9FZNmzJGRqKEQrzZDK96Ekgndct+dQzFC
         f89kDUkDTUYi/fMDij7101qD5LCKOSJBum5M0WVu/l7iwXvq3y9vIy7tBWChsK0QJ6V4
         3YVEbZQVsllnuct14fki72pvjxkQV0C9dnk4T05CNAAYYG/ZTBPXt6WtkH7RgUISxHvO
         dv45eEAQkz2JPFlgS1E9gcfOmndQx80GebLIjmSAWQxtM3VorRkBFAI1Ryd8/7m4jfOd
         8fXg==
X-Gm-Message-State: AOJu0YxNpMRsnOJKXSW7t9hvfcCTA2JtKG5DpvjPjLMfspQIAFxTmHmf
	lz+nTVJELF1LYckNKCl1eSpasxvJrCVFo+b6nF6m19b8jpEgqktDDg2S1Gg554kjqFaUAYfsPQ9
	3398gcihn8xuoeW8K207DwUcGxukLdaBYolyg
X-Google-Smtp-Source: AGHT+IFXZk9NEru0SMUk4ua6BbcA0uxSwiHUSIrvMKOjEmnDZTutfkU8uby9d0bZyeAELY8c6gc2tX4NnGWiDQ1x4nA=
X-Received: by 2002:a05:6870:3920:b0:219:3d70:97c4 with SMTP id
 b32-20020a056870392000b002193d7097c4mr863481oap.20.1706904882945; Fri, 02 Feb
 2024 12:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
 <20240202151345.kj4nhb5uog4aknsp@revolver> <CABi2SkUSWLHM5KD=eK9bJrt3bBsEaB3gEpvJgr0LSTAE2G00Tg@mail.gmail.com>
 <20240202192137.6lupguvhtdt72rbr@revolver>
In-Reply-To: <20240202192137.6lupguvhtdt72rbr@revolver>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 2 Feb 2024 12:14:30 -0800
Message-ID: <CABi2SkV+DaHHOwpVsbYbgkQNZ=Ynjx1vXWkPuz4J3O2vspTNLA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, 
	rdunlap@infradead.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 11:21=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240202 12:24]:
>
> ...
>
> > > Provide code that uses this feature.
>
> Please do this too :)
>
Yes. Will do.


> > >
> > > Provide benchmark results where you apply mseal to 1, 2, 4, 8, 16, an=
d
> > > 32 VMAs.
> > >
> > I will prepare for the benchmark tests.
>
> Thank you, please also include runs of calls that you are modifying for
> checking for mseal() as we are adding loops there.
>
It will includes mmap/mremap/mprotect/munmap

> >
> > > Provide code that tests and checks the failure paths.  Failures at th=
e
> > > start, middle, and end of the modifications.
> > >
> > Regarding, "Failures at the start, middle, and end of the modifications=
."
> >
> > With the current implementation, e.g. it checks if the sealing is
> > applied before actual modification of VMAs, so partial modifications
> > are avoided in mprotect, mremap, munmap.
> >
> > There are test cases in the selftests to cover the failure path,
> > including the beginning, middle and end of VMAs.
> > test_seal_unmapped_start
> > test_seal_unmapped_middle
> > test_seal_unmapped_end
> > test_seal_invalid_input
> > test_seal_start_mprotect
> > test_seal_end_mprotect
> > etc.
> >
> > Are those what you are looking for ?
>
> Those are certainly good, but we need more checking in there.  You have
> a seal_split test that splits the vma by mseal but you don't check the
> flags on the VMAs.
>
I can add the flag check.

> What I'm more concerned about is what happens if you call mseal() on a
> range and it can mseal a portion.  Like, what happens to the first vma
> in your test_seal_unmapped_middle case?  I see it returns an error, but
> is the first VMA mseal()'ed? (no it's not, but test that)
>
The first VMA is not sealed.
That was covered by test_seal_mprotect_two_vma_with_gap.

> What about the other system calls that will be denied on an mseal() VMA?
The other system call's behavior is kept as is, if the memory is not sealed=
.

> Do they still behave the same?  do_mprotect_pkey() will break out of the
> loop on the first error it sees - but it has modified some VMAs up to
> that point, I believe?
Yes. The description about do_mprotect_pkey() is correct.

> You have changed this to abort before anything
> is modified.  This is probably acceptable because it won't affect
> existing applications unless they start using mseal(), but that's just
> my opinion.
>
To make sure this, the test was written with sealing=3Dfalse, those
tests are passed in the main (before applying my patch) to make sure
the test is correct.

> It would be good to state the change in behaviour because it is changing
> the fundamental model of changing mprotect/madvise until an issue is
> hit.  I think you are covering this by "it blocks X" but it's doing more
> than, say, a flag verification.  One could reasonably assume this is
> just another flag verification.
>
Will add more in documentation.

> >
> > > Document what happens in those failure paths.
>
> I'd like to know how this affects other system calls in the partial
> success cases/return error cases.  Some will now return new error codes
> and some may change the behaviour.
>
For the mapping that is not sealed, all remain unchanged, including
the error handling path.
For the mapping that is sealed, EPREM is returned if the sealing check
fails, and all of VMAs remain unchanged.

> It may even be okay to allow munmap() to split VMAs at the start/end of
> the region and fail to munmap because some VMA in the middle is
> mseal()'ed - but maybe not?  I haven't put a whole lot of thought into
> it.
If you are referring to something like below
[unmapped][map1][unmapped][map2][unmapped][map3][unmapped]
and map2 is sealed.

unmap(start of map1,end of map3) will fail.
mmap/mremap/unmap/mprotect on an address range that includes map2 will
fail with EPERM, with map1/map2/map3 unchanged.

Thanks
-Jeff

>
> Thanks,
> Liam

