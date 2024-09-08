Return-Path: <linux-kselftest+bounces-17452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29C970A34
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 23:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41C451C20E36
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Sep 2024 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F002176ACB;
	Sun,  8 Sep 2024 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQq7R1Mo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4DA1C01;
	Sun,  8 Sep 2024 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725832619; cv=none; b=FGJ1KNdKKTh6Lbl3FVdz3b4317Ddq2GoDN/qzBac8ycI98ArZ+2TVh97yiwvcABrmZHyiQY02sJFtk5H5xPxFp7/TQacDPYpmNmk6Uc6Kifjmt0U5y9mMwmzp4DkbMfW3LUnggZI8k+5k/kxT/g4IP0gr0BGLSMutAgKL+E7lqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725832619; c=relaxed/simple;
	bh=LWVbIjKgMIlpOSp8Sq32TT+YaC27UoQbAqL+kUbko5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYDAbbruOpqiVAFFfoBWwY+FyYa7Woyv3hzg/wfS9Sc5Q2YCFnCQLPRqiYsozaCkHeXNkRQsvCMxVUQqnp20LDTvIHeZf670ltLkNQgccWrOekOTW9m7HpUVR57zdvJ6BZOX9q+U91wmAXtdY54PmDSW8WZVDJUVTkslNEOgqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQq7R1Mo; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-848769482c9so950347241.0;
        Sun, 08 Sep 2024 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725832616; x=1726437416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bNi04gh8Ppwp4T2sUaifRCrgHKoKyytEnRJoKdjXyQ=;
        b=eQq7R1MoN/ZSlCY0yTTXqtl3J4EXc+454tLGl4k8Gd4bsctY0UKIzpZs2tn4TO0Ht/
         GVr5z5Y1qFP6mDHaXOPEOWrEQ2a+lCH2ASYN3CS0r48l7hr0M/xHteQTa6xmu92THiJ8
         ET6JU1BubFAqnovqOx9A/b8oa1Mo89NYrZ+X0dHeOhwJT7J63pSzQmYhfxLOY5kFzdnm
         xstuoIS6C8r1Y7Sew764otTlKJd8SrZVKyZnxj5nz1YQ/nl3qg64IhSvXcEedQcKR3zy
         8fULCr+ro0ayHzFpcbuttVQ0GsgtwSCBRmnyfd4HHiqH5w/5FDCsH3nx5XH346FBAu3f
         lelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725832617; x=1726437417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bNi04gh8Ppwp4T2sUaifRCrgHKoKyytEnRJoKdjXyQ=;
        b=cKkWUMyYor8ijnpd20lbsUIQo7vSPfAUHOugFNqt8okDNAjpg30vqiriLhn5Vfflvi
         voMRWDD56vVl2n1Rj+zl8ZwXmQ9ryUldlpFRhFZ79SOj0wzRIF2ZuHsPARaCc8OIj6tG
         WL1+MIvWCJVBzC6zfIcMKDru27+KEH6G6Dqh2KWdsy2EFPDf1wJROS2sABxMyG0nk2ii
         odtVf7mnIyh8by6YNxUTjg3welMXOOWgsnlT90dA6PoRVVZOZXm3ZkCysSGTMVeoqSSb
         041ViN8oFOfpuWhaFpZEmeCbhpqD1VQIs5ga+RuYsKyrSRcxdRNfPwQVAL36PtmI/y9n
         aklQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMnWDEoE8+VPA/iZ5vC8mVNU310/A4OgmVpKEyAnaGTZ7ubuKVFSiwjXZ5SDm2YEdjuCqXB+D1Mse0A5CEbzsh@vger.kernel.org, AJvYcCW0GgUBXDTXcl6vW6Qt4mcr/uIPxUoQ0+jwSegqziy2fyAW5ct8l71wCzevwBMLZozciuDM6kAWP4pak9tz@vger.kernel.org, AJvYcCXoPTQr/HcGkj0RmTICZnV+oVEgAzffYND9t+4TtOMTv8les2uJXyoGQ6vZmnnNPjXmUwL7dr3MZNzZnAiAeMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXBXH6uuPV0nbGGay8GwzfXWn4dHJKYMMqiXn7hK0YKS7YNZs+
	vTBlf7bon0nz7YY/01DUhssHP1W1D8tAPim65i0kLa8aNNVn9TXpmWc/9lvbYh7vGfT3NNzx8Tz
	aIsccUNWzXp6MPRLqcwbU3VCWWMChhA==
X-Google-Smtp-Source: AGHT+IHTmy0HSSt2RALtUjPBDItygp6q4MMxq/Z1eCpdrWr07YwXnnknIoe/vKKp9he0xcv0LJ7Ip0FHDemI74/YJT8=
X-Received: by 2002:a05:6102:cc8:b0:49b:d066:3e9e with SMTP id
 ada2fe7eead31-49bedbc1635mr3459267137.10.1725832616371; Sun, 08 Sep 2024
 14:56:56 -0700 (PDT)
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
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Sun, 8 Sep 2024 22:56:45 +0100
Message-ID: <CAKbZUD1pfwN_vyq3y1rBoc=66WRBTXJU5gJjpFKttFiaVznaPQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy@infradead.org, broonie@kernel.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, rientjes@google.com, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 10:35=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
> Hi,
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

Small addendum: file write, truncate and hole punching might also
matter for sealed file-backed regions, as these change the region's
contents, but we probably
want to rely on file write permissions to protect against this (as we
already do). Any other solution is probably terrible and probably
endlessly NAK'd by fs folks, but it does
mean sealed regions aren't really immutable if you or the attacker can
write to the file.

--=20
Pedro

