Return-Path: <linux-kselftest+bounces-3976-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD484666C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAAC91C255FD
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 03:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67974C2D9;
	Fri,  2 Feb 2024 03:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqhlkDgU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A2C2D3
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843726; cv=none; b=ApJnKkq1Z+3bPYQc/1ZuqlOdyfImpnAZhBdD1YVBuMem+nZkZqAW2yGdZYF3cER/3J6dYTPlWVrtCUhTTeIMN1Ks/KUT6gjz3ccJTMks+Picu1XLjepcgS28CqKbkzF6xPgFG4NzKPD1mrtJO/+SWKvXaj5wnhPVYvj85+fF/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843726; c=relaxed/simple;
	bh=+aKsF4bZUw1R7o/3cYRtqYTnwDl/ul3fVHGiEe8I1EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=rP0vkLo4o5Vw25166mxi2GQrDgRZTNj2Q/p0BSQCyX3ayT9wF1FBPbis6dI5UXLiPdbbW2QlwZdfQl05ioWsCDBQ/uQGmu0nH7XhhnPSitZxbAcbLyGafMkS+l16hC6mgaUd4Sbb8AwbJSJKlcwxUwdCPX0p614sDb1bIXidQRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RqhlkDgU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55f63fd3dd8so6356a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 19:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706843722; x=1707448522; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tbMa2Y0zXDlCnN04UdSXdSWMrrR/rUx45iZWj/g4cU=;
        b=RqhlkDgU40fFrHKyb/kWWVA2uhhQyOHZuBgzRPFdgNI1801bSD2pnTZl+3VRQuHbRz
         ZUBj+/J7AbDBDddhnYXbPlNedplLREDtY3rO3yd2ogqS7E3Els6CKVcm8/6V8bubOkJ/
         e7V6Dq4FQilFTrtXTobRqrbeWRYQM/wNj2LsEoTFBinbdpsZaOwsfvv2AT3K/BU+7Mkf
         9kcyQrZubgShvBnHmUfPQF9eV+4SSQ872o5phImO8fin5Ol9mDPdeCLn2DWTzJIC37TD
         l2tfYYL8VKqPXoya47PyIcALY7lbyGbeso4RU9vHGz7gmbp4XAhslXdprxrAr5NgZ5kg
         u6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843722; x=1707448522;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tbMa2Y0zXDlCnN04UdSXdSWMrrR/rUx45iZWj/g4cU=;
        b=whOAbhMTFAGEWUMftmX1JTqMIKQi8BuG+l8Qd0SQXQMqhSyrIs35r37pl5yyiZBpnX
         7B3xVht4+5bud1E78PDfdEm/C3XMsYHFslDqDFbcOXO2jSll0vfwa2JsEUaZ3BZhhJXc
         g+ktrb9NwojMGDXFveSLs4/l6+AnOhdE3gbgcYDEmqqujo/pUZMh8cj8m+PlKzXemJNx
         +CtX6ye2ydtbFkSyGS7qkSOhlnbbmEow+snLOE9aR9zb7KX0pIyub7A3/TFRjFOoIAGd
         mdaFRIsQsWypmPPmLHtZNEBB4gPpW18qj8AunmJPUKV/CU70P+diKPp/SOOpXFS6L+Tk
         sKXg==
X-Gm-Message-State: AOJu0YzCwobEsPs4NndHbVmrtv84Sfcb3YKa4VXlZWcnCYbdANiDF1ui
	DUVO0XltPbXeyW+wmroo1Q+Ql1CFpl9XTKZ5OURpAXC/hDz0BHeifMybJZ7NDhBIrtAu2G/XJTl
	/I8O2KBeDt8nAlEbr9XJeEncgDI+rrlN17OUr
X-Google-Smtp-Source: AGHT+IHeBmo0iI/CF7yQpc5a3P4jwIWNuulPfEyk+hpP8ZFTKhZLVbX0RzAe8SgBRYbu8IMS8jXp352GwiCcAquWmAo=
X-Received: by 2002:a50:d598:0:b0:55f:e704:85ce with SMTP id
 v24-20020a50d598000000b0055fe70485cemr37702edi.3.1706843721564; Thu, 01 Feb
 2024 19:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com> <20240201204512.ht3e33yj77kkxi4q@revolver>
In-Reply-To: <20240201204512.ht3e33yj77kkxi4q@revolver>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 1 Feb 2024 19:14:42 -0800
Message-ID: <CALmYWFupdK_wc6jaamjbrZf-PzHwJ_4=b69yCtAik_7uu3hZug@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 12:45=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Jeff Xu <jeffxu@chromium.org> [240131 20:27]:
> > On Wed, Jan 31, 2024 at 11:34=E2=80=AFAM Liam R. Howlett
> > <Liam.Howlett@oracle.com> wrote:
> > >
>
> Having to opt-in to allowing mseal will probably not work well.
I'm leaving the opt-in discussion in Linus's thread.

> Initial library mappings happen in one huge chunk then it's cut up into
> smaller VMAs, at least that's what I see with my maple tree tracing.  If
> you opt-in, then the entire library will have to opt-in and so the
> 'discourage inadvertent sealing' argument is not very strong.
>
Regarding "The initial library mappings happen in one huge chunk then
it is cut up into smaller VMAS", this is not a problem.

As example of elf loading (fs/binfmt_elf.c), there is just a few
places to pass in what type of memory to be allocated, e.g.
MAP_PRIVATE, MAP_FIXED_NOREPLACE, we can  add MAP_SEALABLE at those
places.
If glic does additional splitting on the memory range, by using
mprotect(), then the MAP_SEALABLE is automatically applied after
splitting.
If glic uses mmap(MAP_FIXED), then it should use mmap(MAP_FIXED|MAP_SEALABL=
E).

> It also makes a somewhat messy tracking of inheritance of the attribute
> across splitting, MAP_FIXED replacement, vma_move, vma_copy.  I think
> most of this is forced on the user?
>
The inheritance is the same as other VMA flags.

> It makes your call less flexible, it means you have to hope that the VMA
> origin was blessed before you decide you want to mseal it.
>
> What if you want to ensure the library mapped by a parent or on launch
> is mseal'ed?
>
> What about the initial relocated VMA (expand/shrink of VMA)?
>
> Creating something as "non-sealable" is pointless.  If you don't want it
> sealed, then don't mseal() that region.
>
> If your use case doesn't need it, then can we please drop the opt-in
> behaviour and just have all VMAs treated the same?
>
> If it does need it, can you explain why?
>
> The glibc relocation/fixup will then work.  glibc could mseal once it is
> complete - or an application could bypass glibc support and use the
> feature itself.

Yes. That is the idea.

>
> If we proceed to remove the MAP_SEALABLE flag to mmap, then we have the
> heap/stack concerns.  We can either let people shoot their own feet off
> or try to protect them.
>
> Right now, you seem to be trying to protect them.  Keeping with that, I
> guess we could either get the kernel to mark those VMAs or tell some
> other way?  I'd suggest a range, but people do very strange things with
> these special VMAs [1].  I don't think you can predict enough crazy
> actions to make a difference in trying to protect people.
>
> There are far fewer VMAs that should not be allowed to be mseal'ed than
> should be, and the kernel creates those so it seems logical to only let
> the kernel opt-out on those ones.
>
> I'd rather just let people shoot themselves and return an error.
>
> I also hope it reduces the complexity of this code while increasing the
> flexibility of the feature.  As stated before, we remove the dependency
> of needing support from the initial loader.
>
> Merging VMAs
> I can see this going Very Bad with brk + mseal.  But, again, if someone
> decides to mseal these VMAs then they should expect Bad Things to
> happen (or maybe they know what they are doing even in some complex
> situation?)
>
> vma_merge() can also expand a VMA.  I think this is okay as it checks
> for the same flags, so you will allow VMA expansion of two (or three)
> vma areas to become one.  Is this okay in your model?
>
> >
> > > I mean, you specifically state that this is a 'very specific
> > > requirement' in your cover letter.  Does this mean even other browser=
s
> > > have no use for it?
> > >
> > No, I don=E2=80=99t mean =E2=80=9Cother browsers have no use for it=E2=
=80=9D.
> >
> > About specific requirements from Chrome, that refers to "The lifetime
> > of those mappings are not tied to the lifetime of the process, which
> > is not the case of libc" as in the cover letter. This addition to the
> > cover letter was made in V3, thus, it might be beneficial to provide
> > additional context to help answer the question.
> >
> > This patch series begins with multiple-bit approaches (v1,v2,v3), the
> > rationale for this is that I am uncertain if Chrome's specific needs
> > are common enough for other use cases.  Consequently, I am unable to
> > make this decision myself without input from the community. To
> > accommodate this, multiple bits are selected initially due to their
> > adaptability.
> >
> > Since V1, after hearing from the community, Chrome has changed its
> > design (no longer relying on separating out mprotect), and Linus
> > acknowledged the defect of madvise(DONOTNEED) [1]. With those inputs,
> > today mseal() has a simple design that:
> >  - meet Chrome's specific needs.
>
> How many VMAs will chrome have that are mseal'ed?  Is this a common
> operation?
>
> PROT_SEAL seems like an extra flag we could drop.  I don't expect we'll
> be sealing enough VMAs that a hand full of extra syscalls would make a
> difference?
>
> >  - meet Libc's needs.
>
> What needs of libc are you referring to?  I'm looking through the
> version changelog and I guess you mean return EPERM?
>
I meant libc's sealing RO part of the elf binary, those memory's
lifetime are associated with the lifetime of the process.

> >  - Chrome's specific need doesn't interfere with Libc's.
> >
> > [1] https://lore.kernel.org/all/CAHk-=3DwiVhHmnXviy1xqStLRozC4ziSugTk=
=3D1JOc8ORWd2_0h7g@mail.gmail.com/
>
> Linus said he'd be happier if we made the change in general.
>
> >
> > > I am very concerned this feature will land and have to be maintained =
by
> > > the core mm people for the one user it was specifically targeting.
> > >
> > See above. This feature is not specifically targeting Chrome.
> >
> > > Can we also get some benchmarking on the impact of this feature?  I
> > > believe my answer in v7 removed the worst offender, but since there i=
s
> > > no benchmarking we really are guessing (educated or not, hard data wo=
uld
> > > help).  We still have an extra loop in madvise, mprotect_pkey, mremap=
_to
> > > (and mreamp syscall?).
> > >
> > Yes. There is an extra loop in mmap(FIXED), munmap(),
> > madvise(DONOTNEED), mremap(), to emulate the VMAs for the given
> > address range. I suspect the impact would be low, but having some hard
> > data would be good. I will see what I can find to assist the perf
> > testing. If you have a specific test suite in mind, I can also try it.
>
> You should look at mmtests [2]. But since you are adding loops across
> VMA ranges, you need to test loops across several ranges of VMAs.  That
> is, it would be good to see what happens on 1, 3, 6, 12, 24 VMAs, or
> some subset of small and large numbers to get an idea of complexity we
> are adding.  My hope is that the looping will be cache-hot in the maple
> tree and have minimum effect.
>
> In my personal testing, I've seen munmap often do a single VMA, or 3, or
> more rare 7 on x86_64.  There should be some good starting points in
> mmtests for the common operations.
>
Thanks. Will do.


> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kerne=
l/mem/mmapstress/mmapstress03.c
> [2] https://github.com/gormanm/mmtests
>
> Thanks,
> Liam

