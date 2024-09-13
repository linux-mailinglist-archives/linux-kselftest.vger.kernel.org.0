Return-Path: <linux-kselftest+bounces-17967-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B9978B95
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Sep 2024 01:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D170E1C22A91
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2024 23:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B2817BEBA;
	Fri, 13 Sep 2024 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hmVr/0/8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3422513D251
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268416; cv=none; b=AS9Wjoo1bXGZlOK8NCuyFyrpFPjj7A1hfP2rTKp3vLAXf1Z6bVFdb6O+9XBWlfco9YVpidaFbnAHSPR8NEzGiMLyQcxGfSFZvDYSRwF5ib6sJ/gdDARGshm54dD4SZxC88CzVpvNrmP+XmWsYF3BP69FAeTYnRY4OGFgprLNcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268416; c=relaxed/simple;
	bh=yPKQceVlPlKwm4pgJ2pTlOEXhyGfmpk1MUlQVYNrhYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XicdSiW48C5r/z9GWUNc6XJClcdDlJzpxoPCiqJjoWemrNVxe5MiHqYvG/E5tBJg2z/lf+euI8Z0dJHBmKwJxOWyyEiHvrKD5bhXK9smV+jAh2JU0QKJREeBwNO2q4rgnLlV7tSxcCSCIVo+N+cV2QfrOM+rjW64pjN42/ZUAjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hmVr/0/8; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-26110765976so152601fac.1
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2024 16:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726268414; x=1726873214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkIOvqXp0bknmVx1Vck74B49RD+y94/wq8LEP+SHHiM=;
        b=hmVr/0/8luBb8yTHCIOrViiI4/Xi18M610EyUrFDD3Hlm25hddSvPGcl9dsFCfh+wS
         u8EuYIN8HjySjszhB/H1GLXyIoUCswrZiwGA4NzXtNk9331yTkRssw5lHC617wUJNYgl
         P/KtdrIaGbzcdJ6plm0vdVAzdw5ZHYXCp6u7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726268414; x=1726873214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkIOvqXp0bknmVx1Vck74B49RD+y94/wq8LEP+SHHiM=;
        b=d+O6OYY3BT6q6NRONOKNWPielBI4DNh+JoMekKbkuWBUgdcBtV5x4xgvwQ7Yv1xmHO
         nJ4mW9K978oKaWylstrhnezSRyJZWAk4kpdll1eMrNC3zkb2N1E6Qjsdv/I2/8czTYKA
         nvw0BiSm8EU2Yv96/vUPOULMziTD3Or8ieMnHZHmsxCa/O5BIwTFWMIusa2in33TqEs+
         4TrES6LUXjYigSwEW+AJLrXpmwXTKSFid60IyoinMwZhOHKD2gNhZqnjb9W69aox78/Z
         t9mp6XHKIGbHNk1Mi+6NWsHhrkZFaJcUeeetBXdmNQxn4+2BrSkzd/GcdN/igwcQIvFI
         NwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU661XMi0WqBoL3m8gYhcVJeBse3Irt6HS9knr1u3mMW9xI1gvaXWPc8WEDFXk8Ar7kgmn8j/jfc+uzunq3lYo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv6XmTlorn7eoln8o2cV0q5oiBsbsQ1Wohzfwiplgt8JADGh58
	YfRCZfCFmvoCj6KOV7Oxw1Is+rmFK3Ru/7QhxKoJoJuDSPBbNTZPBZ2xjdsr+mSJcz9bhbOWKFa
	gPIhgKguBpoVwJKoMNvV9gik/EgGir1nr7wrS
X-Google-Smtp-Source: AGHT+IHPuIs8Xo6Q9Nqk9p5B4mSRmV8QUmXfFXF8O6+1IoOb5C/bPaCY7foKwpfjxOPYErsM3rEYqH12IqZ0JQPe9+A=
X-Received: by 2002:a05:6870:9381:b0:27b:9f8a:7a7f with SMTP id
 586e51a60fabf-27c3f68be4bmr1479138fac.12.1726268414034; Fri, 13 Sep 2024
 16:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <ihclooyralrg2yugyrkwvw3kay6k7hpdgzczhcxh5dgmakulwb@wpb4kyofz7ot>
In-Reply-To: <ihclooyralrg2yugyrkwvw3kay6k7hpdgzczhcxh5dgmakulwb@wpb4kyofz7ot>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 13 Sep 2024 16:00:00 -0700
Message-ID: <CABi2SkUDwuuwiFw7pDspPibUaQbdBaGaqvi8_XV7bjq+ZUrr_Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pedro

On Sun, Sep 8, 2024 at 2:35=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.c=
om> wrote:
>
> I agree with most of the points. Sitting down here to write unofficial
> guidelines for mseal behavior.
>
> mseal should seal regions and mark them immutable, which means their prot=
ection
> and contents (ish?) (not _only_ backing mapping, but also contents in gen=
eral
> (see madvise below)) should not be changed throughout the lifetime of the=
 address space.
>
> For the general syscall interface, this means:
> 1) mprotect and munmap need to be blocked on mseal regions.
>  1a) munmap _cannot_ tolerate partial failure, per POSIX.
>  2b) mmap MAP_FIXED counts as an unmap operation and also needs to be blo=
cked and return -EPERM.
>
> 2) Most madvise calls are allowed, except for destructive operations on
> read-only anonymous _pages_ (MADV_DONTNEED is destructive for anon, but w=
e also don't care
> about blocking these ops if we can do it manually with e.g memset)
>  2a) The current implementation only blocks discard on anonymous _regions=
_, which is slightly
>      different. We probably do want to block these on MAP_PRIVATE file ma=
ppings, as to block
>      stuff like madvise MADV_DONTNEED on program rodata.
>  2b) We take into account pkeys when doing the permission checks.
>
> 3) mremap is not allowed as we'd change the "contents" of the old region.
>  3a) Should mremap expansion be allowed? aka only block moving and shrink=
ing, but allow expansion.
>      We already informally allow expansion if e.g mmapping after it + mse=
al.
>
> 4) mlock and msync are allowed.
>
> 5) mseal is blocked.
mseal is not blocked, i.e. seal on an already sealed memory is
no-op. This is described in mseal.rst [1]

[1] https://github.com/torvalds/linux/blob/master/Documentation/userspace-a=
pi/mseal.rst

>
> 6) Other miscellaneous syscalls (mbind, etc) that do not change contents =
in any way, are allowed.
>  6a) This obviously means PTEs can change as long as the contents don't. =
Swapping is also ok.
>
> 7) FOLL_FORCE (kernel-internal speak, more commonly seen as ptrace and /p=
roc/self/mem from userspace)
>    should be disallowed (?)
>  7a) This currently does not happen, and seems like a large hole? But dis=
allowing this
>      would probably severely break ptrace if the ELF sealing plans come t=
o fruition.
>
Jann Horn  pointed out FOLL_FORCE during RFC [2], and this is in mseal.rst =
too.

In short, FOLL_FORCE is not covered by mseal. On ChromeOS, FOLL_FORCE
is disabled. Recently, Adrian Ratiu upstreamed that [3]

[2] https://lore.kernel.org/lkml/CAG48ez3ShUYey+ZAFsU2i1RpQn0a5eOs2hzQ426Fk=
cgnfUGLvA@mail.gmail.com/
[3]   https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@coll=
abora.com/

-Jeff

> When we say "disallowed", we usually (apart from munmap) allow for partia=
l failure. This
> means getting an -EPERM while part of the call succeeded, if we e.g mprot=
ect a region consisting
> of [NORMAL VMA][SEALED VMA]. We do not want to test for this, because we =
do not want to paint ourselves
> into a corner - this is strictly "undefined behavior". The msealed region=
s themselves
> will never be touched in such cases. (we do however want to test munmap o=
peration atomicity, but this is
> also kind of a munmap-related test, and might not really be something we =
really want in the mseal tests)
>
> Kernel-internal wise: The VMA and PTE modifications resulting from the ab=
ove operations are blocked.
> Sealed VMAs allow splitting and merging; there was contention about the s=
plitting issue, but it truly
> does not make sense to block operations unless they affect a VMA entirely=
, and that would also force
> VMA merging to be ABI ("vma_merge isn't merging these two regions and now=
 my madvise works/doesn't work :(").
>
>
> Do I have everything right? Am I missing anything?
>
> --
> Pedro

