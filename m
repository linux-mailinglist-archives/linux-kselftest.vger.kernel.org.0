Return-Path: <linux-kselftest+bounces-3991-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96A28466F4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDDE61C235C6
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1817E57C;
	Fri,  2 Feb 2024 04:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aQyZUZTw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB10E568
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 04:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847763; cv=none; b=Ltqcvtpu6R/4AdiOarrxj5fStb4ofplAC57G6pHZm/g+mC3gVegwWlCPFPYeasz2U+XPTG/p3bKGxvu2BUGF+jiMfPgiqnmw+buxtsoLeivgQJ81VKBWJ9W5NT3IozQQ3KhbJsN2rnCNEQACyjCr0LfGxsu0rbWxldNTxdQdY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847763; c=relaxed/simple;
	bh=vA7tvTQxROFPNSNZmoB+xRvwpT15aZOnZMRAVU3yE5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXpuE11VILHLCZpMXpPe8Jr/9AOUp41p6J3PwOm4i66N/HMf7jwpCJjU+qImp0TjqEjzlhA0b2l16ChYENkhuUiLiysqPTsL+/7A6WBp75lJeY4dBGypHkHn0Wn5J1+0ubsDtd8aPjTjOdSqpgy+Vxe7EpyXdkhSljqNgoSWzt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aQyZUZTw; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-219108b8e9cso218403fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Feb 2024 20:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706847761; x=1707452561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GY7gduymNb2zU8foO6bHqxA7R4wx0/8BTl8lBqhvbv0=;
        b=aQyZUZTwSfdF9GVvvBhz9gla/Tj8GAEMgMn00U2j9246xVlcC7/RgWmIPXJRmFr7lS
         xV3xp2Fm31nUIgTJNupttWMcGq7VZmsGzkCg76sftejdNg9ZpoFDoMyNe9EilkOyT48d
         CJnMT2kkU7v8cCpYt2lCKZtj389I+MuqeFZQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706847761; x=1707452561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GY7gduymNb2zU8foO6bHqxA7R4wx0/8BTl8lBqhvbv0=;
        b=KS68E8VO5THImdH7egElQG+wVajOhuH9ij2MhprS832xNFv48/IE89wmi6F9VmcFiC
         T4TKkoRyYj+WZpMPjAkiHfTqSjHfvJdViXMlL8hEtCvfuS4ySGMxyY1+W6w0lmmtk8Z5
         IdROeItaKsbwvlKJK+VBgMusjZ//N+RfSqZz2Jj5iTbOprOVeFR4JnW0c0zHWc9lkEqt
         i1gUgcPo8lYVbKjEs8w83SjJMpKA4rASbW4CMtgbLSv5ZxMX/V9lCfV3RG4GCK3crvw2
         Co3nn7IdEu0kdlfbpvuMXTEa2nVUj3vs7cmlAclNPLW2H1G3z5l6EwrJ8BWKRvVb2rbN
         sWJw==
X-Gm-Message-State: AOJu0Ywb7cr1kOomsmx5NhQrXFhsEkVAU/lHdubSHtZwZiJ/NjqT5AMV
	NWkh/a19rgD6AAB1fOgj3+/6bX2g2LkiOuFHzuDvyWi5KvMDGcwz0jYudpQTyXKIfpbdqA8qMCp
	PD1DQpIAhZpXB52l8QJkaUDLLNFLforw+wtWg
X-Google-Smtp-Source: AGHT+IEkUEa7oB3LxBaxRdRQm5KW+tylq4x0W184us0zAIA6K3G/17ndemyjfLrzARBtr3pklpjp5BmCmP98g7ITzIA=
X-Received: by 2002:a05:6870:7908:b0:214:2a08:897d with SMTP id
 hg8-20020a056870790800b002142a08897dmr8699235oab.46.1706847761083; Thu, 01
 Feb 2024 20:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131175027.3287009-3-jeffxu@chromium.org>
 <20240201231151.GA41472@sol.localdomain> <CABi2SkWW78n3PK3Qk5cCzpjb57ZCoLmybA1ds3=rHrGMams7sw@mail.gmail.com>
 <96087.1706846050@cvs.openbsd.org> <CABi2SkWP=N_V9+VvH3omw3gw=VcRqhqenti-qABijo-SNqXxhQ@mail.gmail.com>
 <72434.1706847038@cvs.openbsd.org>
In-Reply-To: <72434.1706847038@cvs.openbsd.org>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 1 Feb 2024 20:22:29 -0800
Message-ID: <CABi2SkW=jDvjknG-OheqDg0qtZRKRO-byK=YMyeE6ohcch4eTA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] mseal: add mseal syscall
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Eric Biggers <ebiggers@kernel.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org, 
	usama.anjum@collabora.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 8:10=E2=80=AFPM Theo de Raadt <deraadt@openbsd.org> =
wrote:
>
> Jeff Xu <jeffxu@chromium.org> wrote:
>
> > On Thu, Feb 1, 2024 at 7:54=E2=80=AFPM Theo de Raadt <deraadt@openbsd.o=
rg> wrote:
> > >
> > > Jeff Xu <jeffxu@chromium.org> wrote:
> > >
> > > > On Thu, Feb 1, 2024 at 3:11=E2=80=AFPM Eric Biggers <ebiggers@kerne=
l.org> wrote:
> > > > >
> > > > > On Wed, Jan 31, 2024 at 05:50:24PM +0000, jeffxu@chromium.org wro=
te:
> > > > > > [PATCH v8 2/4] mseal: add mseal syscall
> > > > > [...]
> > > > > > +/*
> > > > > > + * The PROT_SEAL defines memory sealing in the prot argument o=
f mmap().
> > > > > > + */
> > > > > > +#define PROT_SEAL    0x04000000      /* _BITUL(26) */
> > > > > > +
> > > > > >  /* 0x01 - 0x03 are defined in linux/mman.h */
> > > > > >  #define MAP_TYPE     0x0f            /* Mask for type of mappi=
ng */
> > > > > >  #define MAP_FIXED    0x10            /* Interpret addr exactly=
 */
> > > > > > @@ -33,6 +38,9 @@
> > > > > >  #define MAP_UNINITIALIZED 0x4000000  /* For anonymous mmap, me=
mory could be
> > > > > >                                        * uninitialized */
> > > > > >
> > > > > > +/* map is sealable */
> > > > > > +#define MAP_SEALABLE 0x8000000       /* _BITUL(27) */
> > > > >
> > > > > IMO this patch is misleading, as it claims to just be adding a ne=
w syscall, but
> > > > > it actually adds three new UAPIs, only one of which is the new sy=
scall.  The
> > > > > other two new UAPIs are new flags to the mmap syscall.
> > > > >
> > > > The description does include all three. I could update the patch ti=
tle.
> > > >
> > > > > Based on recent discussions, it seems the usefulness of the new m=
map flags has
> > > > > not yet been established.  Note also that there are only a limite=
d number of
> > > > > mmap flags remaining, so we should be careful about allocating th=
em.
> > > > >
> > > > > Therefore, why not start by just adding the mseal syscall, withou=
t the new mmap
> > > > > flags alongside it?
> > > > >
> > > > > I'll also note that the existing PROT_* flags seem to be conventi=
onally used for
> > > > > the CPU page protections, as opposed to kernel-specific propertie=
s of the VMA
> > > > > object.  As such, PROT_SEAL feels a bit out of place anyway.  If =
it's added at
> > > > > all it perhaps should be a MAP_* flag, not PROT_*.  I'm not sure =
this aspect has
> > > > > been properly discussed yet, seeing as the patchset is presented =
as just adding
> > > > > sys_mseal().  Some reviewers may not have noticed or considered t=
he new flags.
> > > > >
> > > > MAP_ flags is more used for type of mapping, such as MAP_FIXED_NORE=
PLACE.
> > > >
> > > > The PROT_SEAL might make more sense because sealing the protection =
bit
> > > > is the main functionality of the sealing at this moment.
> > >
> > > Jeff, please show a piece of software that needs to do PROT_SEAL as
> > > mprotect() or mmap() argument.
> > >
> > I didn't propose mprotect().
> >
> > for mmap() here is a potential use case:
> >
> > fs/binfmt_elf.c
> > if (current->personality & MMAP_PAGE_ZERO) {
> >                 /* Why this, you ask???  Well SVr4 maps page 0 as read-=
only,
> >                    and some applications "depend" upon this behavior.
> >                    Since we do not have the power to recompile these, w=
e
> >                    emulate the SVr4 behavior. Sigh. */
> >
> >                 error =3D vm_mmap(NULL, 0, PAGE_SIZE,
> >                                 PROT_READ | PROT_EXEC,   <-- add PROT_S=
EAL
> >                                 MAP_FIXED | MAP_PRIVATE, 0);
> >         }
> >
> > I don't see the benefit of RWX page 0, which might make a null
> > pointers error to become executable for some code.
>
>
>
> And this is a lot faster than doing the operation as a second step?
>
>
> But anyways, that's kernel code.  It is not userland exposed API used
> by programs.
>
> The question is the damage you create by adding API exposed to
> userland (since this is Linux: forever).
>
> I should be the first person thrilled to see Linux make API/ABI mistakes
> they have to support forever, but I can't be that person.
>
Point taken.
I can remove PROT_SEAL.

>
>

