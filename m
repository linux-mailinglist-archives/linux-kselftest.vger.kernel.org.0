Return-Path: <linux-kselftest+bounces-3912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FC844EA5
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 02:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBF42871A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Feb 2024 01:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259C442C;
	Thu,  1 Feb 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mjg46Iif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDAC4417
	for <linux-kselftest@vger.kernel.org>; Thu,  1 Feb 2024 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750845; cv=none; b=GegvTNm0QCLq8bVh5bnSm8m4qp44CVMCCGd3F8OZNUKzw3hJ4OKqAxtedQ7LAIViOTw9MOrvc2WfuCu8KvrHd88gtxhHFNfpw5KisxkTpEYzTvJ2Lmz1L8jQ4wvFoGLrtz5XsnLz5TamWmEnW3qgfGCSQFO4kuQe0yI5n27fGPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750845; c=relaxed/simple;
	bh=BQfrkfnAjRHW3tpPJSA0bCjLjUMIPrCPNnB/AXFgCO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pWl+4PgUMJL8QTbjZbtTqxX3+VM5Uxp2qAOxVSCVXxI0Zib6KwLH4QhdcE+LEj+czyPcXljyZcOnDW5+ouCtrwTvjpIzpKvvb0iSHwsVoIIPrrPNSdjAytbSPhqvALJlL2nnU+vM4FnF4rnyB3NbZKrAWfW0N5/GaYuyAAU7lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mjg46Iif; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-21428d99395so682877fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Jan 2024 17:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706750843; x=1707355643; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDzJ7JgQvwxL4RB0XYtG8kPAD5jbJ2pvE+FQi7xvQPU=;
        b=mjg46Iifo7aTLzPS5SP/EHQpyYgBjzADJcvv2oA8/jHWI0nJ0NmnJ51XFM/7rNTuso
         YKQlmabt8guNijLJpUkNalvermaVyTKU3530A4aBTG5b+Apyx34EeAdAzAtOlCM6yEYv
         lXhW2oZkcpjKFayh2gNph3nv6XYbg4K7UmGho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706750843; x=1707355643;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDzJ7JgQvwxL4RB0XYtG8kPAD5jbJ2pvE+FQi7xvQPU=;
        b=S9s81QrqkeLzbwDTNHvgR3xLdQz0QkLNnnFGlmS7hjjm8j/r/6sdlskuRNmVnH5s2B
         leQQ4QRwdm2DME12CPVxhjOeYQXjHkf6b5L401biGTP7yq2zyRvzP9hcjOAvfqmm/Xb4
         e9nMtSrjrf6P4Gb+EYXTJ5Tvgs/R+iNb8EWvOXi6C4JMAvQGmkrGPgb631EOr3TMZIlp
         V1nuQmeTsTcr2KnknVeu66/OO4W+YI+iGG8C0Q6RMwdCA5HVXG3fAxO3GECYQPJv061i
         3iuttS+QK3/wWIiai9W8T2NrZc9ogxpOTguOOquYh23p7jpUMGvCIaaA/YAyM/jbdDxw
         01UA==
X-Gm-Message-State: AOJu0YyCy7rFI9QiyZrQbPR/QkxxGh4f/DLE8f6jGuusgJDyDgisosjx
	aCgyb1akHMW2cqngN9SR0mhdJuYw/yp29zwKelA3aD02FMLFN/ht0ufWxDah+f/iVbL8q4ZGuQY
	eSudyJDm0oKlw29nHfwVORtbw1NmMee8kBQTh
X-Google-Smtp-Source: AGHT+IE9K01TCTZhsWGjePujNgbATRhQaKALuXvW0OHXOMwQOD3gFk7KgtXrb7TM6FbH4tdFNU0N+tvMZqAhTTCe8YA=
X-Received: by 2002:a05:6871:a417:b0:210:dcdc:be39 with SMTP id
 vz23-20020a056871a41700b00210dcdcbe39mr1311243oab.20.1706750843175; Wed, 31
 Jan 2024 17:27:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
In-Reply-To: <20240131193411.opisg5yoyxkwoyil@revolver>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 31 Jan 2024 17:27:11 -0800
Message-ID: <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:34=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> Please add me to the Cc list of these patches.
Ok.
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [240131 12:50]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This patchset proposes a new mseal() syscall for the Linux kernel.
> >
> > In a nutshell, mseal() protects the VMAs of a given virtual memory
> > range against modifications, such as changes to their permission bits.
> >
> > Modern CPUs support memory permissions, such as the read/write (RW)
> > and no-execute (NX) bits. Linux has supported NX since the release of
> > kernel version 2.6.8 in August 2004 [1]. The memory permission feature
> > improves the security stance on memory corruption bugs, as an attacker
> > cannot simply write to arbitrary memory and point the code to it. The
> > memory must be marked with the X bit, or else an exception will occur.
> > Internally, the kernel maintains the memory permissions in a data
> > structure called VMA (vm_area_struct). mseal() additionally protects
> > the VMA itself is against modifications of the selected seal type.
>
> ... The v8 cut Jonathan's email discussion [1] off and
> instead of
> replying there, I'm going to add my question here.
>
> The best plan to ensure it is a general safety measure for all of linux
> is to work with the community before it lands upstream.  It's much
> harder to change functionality provided to users after it is upstream.
> I'm happy to hear google is super excited about sharing this, but so
> far, the community isn't as excited.
>
> It seems Theo has a lot of experience trying to add a feature very close
> to what you are doing and has real data on how this went [2].  Can we
> see if there is a solution that is, at least, different enough from what
> he tried to do for a shot of success?  Do we have anyone in the
> toolchain groups that sees this working well?  If this means Stephen
> needs to do something, can we get that to happen please?
>
For Theo's input from OpenBSD's perspective;
IIUC: as today, the mseal-Linux and mimmutable-OpenBSD has the same
scope on what operations to seal, e.g. considering the progress made
on both sides since the beginning of the RFC:
- mseal(Linux): dropped "multiple-bit" approach.
- mimmutable(OpenBSD): Dropped "downgradable"; Added madvise(DONOTNEED).

The difference is in mmap(), i.e.
- mseal(Linux): support of PROT_SEAL in mmap().
- mseal(Linux): use of MAP_SEALABLE in mmap().

I considered Theo's inputs from OpenBSD's perspective regarding the
difference, and I wasn't convinced that Linux should remove these. In
my view, those are two different kernels code, and the difference in
Linux is not added without reasons (for MAP_SEALABLE, there is a note
in the documentation section with details).

I would love to hear more from Linux developers on this.

> I mean, you specifically state that this is a 'very specific
> requirement' in your cover letter.  Does this mean even other browsers
> have no use for it?
>
No, I don=E2=80=99t mean =E2=80=9Cother browsers have no use for it=E2=80=
=9D.

About specific requirements from Chrome, that refers to "The lifetime
of those mappings are not tied to the lifetime of the process, which
is not the case of libc" as in the cover letter. This addition to the
cover letter was made in V3, thus, it might be beneficial to provide
additional context to help answer the question.

This patch series begins with multiple-bit approaches (v1,v2,v3), the
rationale for this is that I am uncertain if Chrome's specific needs
are common enough for other use cases.  Consequently, I am unable to
make this decision myself without input from the community. To
accommodate this, multiple bits are selected initially due to their
adaptability.

Since V1, after hearing from the community, Chrome has changed its
design (no longer relying on separating out mprotect), and Linus
acknowledged the defect of madvise(DONOTNEED) [1]. With those inputs,
today mseal() has a simple design that:
 - meet Chrome's specific needs.
 - meet Libc's needs.
 - Chrome's specific need doesn't interfere with Libc's.

[1] https://lore.kernel.org/all/CAHk-=3DwiVhHmnXviy1xqStLRozC4ziSugTk=3D1JO=
c8ORWd2_0h7g@mail.gmail.com/

> I am very concerned this feature will land and have to be maintained by
> the core mm people for the one user it was specifically targeting.
>
See above. This feature is not specifically targeting Chrome.

> Can we also get some benchmarking on the impact of this feature?  I
> believe my answer in v7 removed the worst offender, but since there is
> no benchmarking we really are guessing (educated or not, hard data would
> help).  We still have an extra loop in madvise, mprotect_pkey, mremap_to
> (and mreamp syscall?).
>
Yes. There is an extra loop in mmap(FIXED), munmap(),
madvise(DONOTNEED), mremap(), to emulate the VMAs for the given
address range. I suspect the impact would be low, but having some hard
data would be good. I will see what I can find to assist the perf
testing. If you have a specific test suite in mind, I can also try it.

> You also did not clean up the loop you copied from mlock, which I
> pointed out [3].  Stating that your copy/paste is easier to review is
> not sufficient to keep unneeded assignments around.
>
OK.

> [1]. https://lore.kernel.org/linux-mm/87a5ong41h.fsf@meer.lwn.net/
> [2]. https://lore.kernel.org/linux-mm/86181.1705962897@cvs.openbsd.org/
> [3]. https://lore.kernel.org/linux-mm/20240124200628.ti327diy7arb7byb@rev=
olver/

