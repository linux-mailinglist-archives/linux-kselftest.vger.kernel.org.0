Return-Path: <linux-kselftest+bounces-10599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC73C8CCAC4
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 04:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379521F20FD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 02:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CF713A3E0;
	Thu, 23 May 2024 02:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xe1KfzvX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB93FD4
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 02:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431597; cv=none; b=UFFNsf4uvmxNhTerQLrJMXocSDBDMip+4ms+AnUVQI24pntXf4l7OskmiIOK67BBY5PbNen6uIuem2020SJFEdmMfZmnFdZYb52FLLcRvxZ4FBKijTekbzBkfBY9jJe5t9JQowom0WBTCu7Y4Z4mUK8Wm3nWfyNz6h01s0dDt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431597; c=relaxed/simple;
	bh=vpsfbCQk0PdJYIQqYIqdVJydenIqOknn2QrFSFRN3s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fuciwiIXenRHkq5e1EtMg9B41Taqh4ELfWUX6jSVLjktjb2fIjQVBlm/0SKa2N18vek7iJOQ6I4F2LGzMyCdm5z0tK+KUowzOhh/7657u/mPfrENPePIlaQMke0qHJGt/lbSBu/YPCDNckWMfnDMKGTR2olVu5eh5VuEfn1TS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xe1KfzvX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so6888a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2024 19:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716431594; x=1717036394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRtZAXBVtEg5v5aAZ0fCa+gcBJjQ9sT10KYuWxMy/d8=;
        b=xe1KfzvX2cgjKMZAUBX6/pOGb8IgIdWXO00oYHE6+V6nx31e2T5I6UITU9czEV7KGJ
         d1ig3RCbyGQcNyAD5w3YJKoNDhU0ujUhbkP6GPfFVF5BAJ1Qnm2mvN0oxQV9NjCUCUSi
         +prF9Tve4NF+e6g87YfNgTNEDfy+Li2mur48p7jWq8mDMpl0ZQBw35RqstcsK3tqRtfu
         qsPLbfU1BrkBF+uizyeTWFGa32AvkBuUqR68eAEaZrbdhQtdzvQkW7yOMOTet99IPTcs
         z6WQ25AhPdiOpcsC8lyt9+EqL+TB+LDtTjXnUZwsCdrIa5kT7J0j2/srYYOMQkqT/ZdY
         gJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716431594; x=1717036394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRtZAXBVtEg5v5aAZ0fCa+gcBJjQ9sT10KYuWxMy/d8=;
        b=MOpA80pHuoAwFkmzjpxpdQxdTFSrQytQeVJCYC3uewYcY9DEezzRHFg2VdV4wLX9oG
         jjFiA0E/pLpWP8b9bVDyht16MVv/5AQf8GaCwIZgXmYDQGCdeTiX1Aa9fCqTxe4xZsXu
         6epJbCy7Ex+Kzul13uTIOJFc6asnMko8Kz1zem/PgW2yVI+K2OcB0VSVW6CLtVmXeDMF
         XZZcVCJJkeqWpDwy/4G4KClaY66iaqnZjg0IGnSVcfCMjesr3Cpx1/wKpNbmIrjWVdMr
         VrsnHtvgZS2ZviZDdwNOmd3LgJ+Or1wVEmkSL9sTUOeaD6Uy3Yj6ChbA0Ny1PW2REEdj
         UGdg==
X-Forwarded-Encrypted: i=1; AJvYcCUWv9mQKm9NZUiGMPF8y0QEuO7CaR971kxhDhoNEHWde1Vopx1/lg4M099tP6Qjq/bSTDHLyDvjCjQgYgckZJGdaWLSkffyagPNADuT25O1
X-Gm-Message-State: AOJu0YxDBYUquqmCQ/N2JkPzqkZIu4JmlvBtT3T9/Ge6mrUIL2b/9xzt
	lAoxRdLBn0tjU6pFGonzBcT+ouZWSS23+NvM79anIItbsmd/6lKvtNUZbJbawTz0DyeJct1Nosf
	StmJQgccrOZFI11YJXSXrf89ZLVjgDCWF3NHi
X-Google-Smtp-Source: AGHT+IFP2LXTGYjyoELOx8sjoR8gHZ7ritbYrH6yk10eTrPzyQaTdWK1XdlYfkD/76p4KOa4GdSBq578XOid7R6AGCM=
X-Received: by 2002:a05:6402:3549:b0:572:a154:7081 with SMTP id
 4fb4d7f45d1cf-57843f25a14mr100130a12.4.1716431594087; Wed, 22 May 2024
 19:33:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
In-Reply-To: <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 22 May 2024 19:32:35 -0700
Message-ID: <CALmYWFuLe6RaJkZ4koQpgZR-77b9PP=wooPYN-jFFw1KQ5K3aQ@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com, 
	dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, 
	skhan@linuxfoundation.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 4:23=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 15 May 2024 23:11:12 -0700 Jeff Xu <jeffxu@google.com> wrote:
>
> > On Mon, May 13, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobr=
n@protonmail.com> wrote:
> > >
> > > `MFD_NOEXEC_SEAL` should remove the executable bits and set
> > > `F_SEAL_EXEC` to prevent further modifications to the executable
> > > bits as per the comment in the uapi header file:
> > >
> > >   not executable and sealed to prevent changing to executable
> > >
> > > However, currently, it also unsets `F_SEAL_SEAL`, essentially
> > > acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies
> > > that it should be so, and indeed up until the second version
> > > of the of the patchset[0] that introduced `MFD_EXEC` and
> > > `MFD_NOEXEC_SEAL`, `F_SEAL_SEAL` was not removed, however it
> > > was changed in the third revision of the patchset[1] without
> > > a clear explanation.
> > >
> > > This behaviour is suprising for application developers,
> > > there is no documentation that would reveal that `MFD_NOEXEC_SEAL`
> > > has the additional effect of `MFD_ALLOW_SEALING`.
> > >
> > Ya, I agree that there should be documentation, such as a man page. I w=
ill
> > work on that.
> >
> > > So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested.
> > > This is technically an ABI break, but it seems very unlikely that an
> > > application would depend on this behaviour (unless by accident).
> > >
> > > [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@goog=
le.com/
> > > [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@goog=
le.com/
> >
> > ...
> >
> > Reviewed-by: Jeff Xu <jeffxu@google.com>
>
> It's a change to a userspace API, yes?  Please let's have a detailed
> description of why this is OK.  Why it won't affect any existing users.
>
Unfortunately, this is a breaking change that might break a
application if they do below:
memfd_create("", MFD_NOEXEC_SEAL)
fcntl(fd, F_ADD_SEALS, F_SEAL_WRITE); <-- this will fail in new
semantics, due to mfd not being sealable.

However, I still think the new semantics is a better, the reason is
due to  the sysctl: memfd_noexec_scope
Currently, when the sysctl  is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
kernel adds MFD_NOEXEC_SEAL to memfd_create, and the memfd  becomes sealabl=
e.
E.g.
When the sysctl is set to MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
The app calls memfd_create("",0)
application will get sealable memfd, which might be a surprise to applicati=
on.

If the app doesn't want this behavior, they will need one of two below
in current implementation.
1>
set the sysctl: memfd_noexec_scope to 0.
So the kernel doesn't overwrite the mdmfd_create

2>
modify their code  to get non-sealable NOEXEC memfd.
memfd_create("", MEMFD_NOEXEC_SCOPE_NOEXEC)
fcntl(fd, F_ADD_SEALS, F_SEAL_SEAL)

The new semantics works better with the sysctl.

Since memfd noexec is new, maybe there is no application using the
MFD_NOEXEC_SEAL to create
sealable memfd. They mostly likely use
memfd(MFD_NOEXEC_SEAL|MFD_ALLOW_SEALING) instead.
I think it might benefit in the long term with the new semantics.

If breaking change is not recommended,  the alternative is to
introduce a new flag.
MFD_NOEXEC_SEAL_SEAL. (I can't find a better name...)

What do you think ?

> Also, please let's give consideration to a -stable backport so that all
> kernel versions will eventually behave in the same manner.
>
Yes. If the new semantics is acceptable, backport is needed as bugfix
to all kernel versions.
I can do that if someone helps me with the process.

And sorry about this bug that I created.

