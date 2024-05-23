Return-Path: <linux-kselftest+bounces-10625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F098CD8C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 18:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E8D1C212F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 16:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A2621A06;
	Thu, 23 May 2024 16:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8C5NO4i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1389A18622
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 16:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483393; cv=none; b=JdWs4NR0pXauEJ5wDv2QAFKz0AT/2IJkis+h3hTXRGyZHAZnrHQvyj5cnvQZgwgisN8mk6nZNesWM/mLAHwuh8669DWhlHY49S0vFXQuZXmPB5ICytP24XQUe5iLUl0DDUwXoYHM8Xk16fM/zYVVbtxYzpuZ0V96jQQKB1LtzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483393; c=relaxed/simple;
	bh=YfD9x1g6qsIKtJyoOpnGZso8OyH0pVAlCijDbTqHqaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VsuKNfon1iUNazyDr3tFPy9aAEsDNM9J9522ccJ4HkWvFroyox+Up5m6m7O3+lsGFvIVvMMtv8SM2mfiJH4lAR6gliKKxu2zuGYuKjjn3wDyA1thIj1CIRlM71sI+rDIeTkaE5BXPOK5zOE1dwLEeYY1aERUg+c09pcaWjGwLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b8C5NO4i; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso161a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 09:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716483389; x=1717088189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPAtRznjngEuylGql36bL+F2W4ou0WGvI25eR8lDSc8=;
        b=b8C5NO4iduiWjxm71nzJZLgi88DD8541MOkOSUPEBDJKowTL5GFeGu1n1GKzV+Z7TQ
         hdmAOQvAiMmrX+55MZpVV3WeZzKKzIyyoxn79lHWxuA4NjNkPF4/xhLR8ZMp32YvMVeN
         gKq8irrRv2UiQ8jfLTXyYMjJ8MH7MGSMDPoJJkA2DpeRA+nyswxVYEsRYfBjVnBUtw9E
         6PJWrwhE8q6k+wTzgAKA33pRIzt6v8OU4h/xiKiQ4mm3shOXTEKj7r/P+OW+egavfkK2
         YGned/WJ0SFNLoXd6MtBpoCMMqC/ULaC8JVXU7usfDLQw752aKYtA46A/getWskBvWsO
         mKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716483389; x=1717088189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPAtRznjngEuylGql36bL+F2W4ou0WGvI25eR8lDSc8=;
        b=SR/kp9lDj1E5lDy1TJGoBcwi7d/wQ4wwMjbTxbWkpGLX2qgCXwV5l5JjaArzaTU1iN
         rv+beK90E2R8/hAO55Vu7fPnCtbf7kvIwmxgalITLVSakI2j3l9N+ytBSMT/jrIEMqFC
         tZw/oK+cMd2tRQY5wtCHN28hH0BWx+8sR8xJoN2mXS9w3R/DmxUBF13RXrZiGhiR261L
         M1YZPFwH6w4dI55BK3of1zK2ZffU7rp1wt5/xF4kV60aX7+WOEa5IkjJIhyGgEUafjG7
         NIVlKr811QiuFOlZtsVNB4eKQvgDDOxruSKRE9WwU8MIkMrUbYOm2hS2anMnb36bITjl
         eoQA==
X-Forwarded-Encrypted: i=1; AJvYcCURhCZsP+RID3MtoMHq+XUe3chp9O4HuzBP4JCkui6G44i7jUrIWiolz6QQsUS5m/tRNRTvY3fSxCGfme7xbBLb+jxeBqftd2c88tzI1Mbv
X-Gm-Message-State: AOJu0Yzzg0+XhmobOK71RPlyuPtNzFBVxG5KjuLWh8Cc6ojciXRrJnZ7
	UDUPaTQPKARUbnvXCVKjoIZdpJX3StByfhaylQw3SemFoF57bLlcpKhYcL6WzVnh5DwXjbrc1If
	UP+hciEnPZxKjT/VF626E3HR0W3HpIkNEqndj
X-Google-Smtp-Source: AGHT+IEKxt/I7KxNLtu/2LXDIV7NhlcEwSk7jCcefTmMVoqPfxnhzgRDeNpi0+DdXteBBS3nmRzXpW9VoLpXJ+m+V9I=
X-Received: by 2002:a05:6402:5209:b0:576:68c7:f211 with SMTP id
 4fb4d7f45d1cf-57843f5afc9mr236334a12.6.1716483389025; Thu, 23 May 2024
 09:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com> <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
In-Reply-To: <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 23 May 2024 09:55:49 -0700
Message-ID: <CALmYWFtedtEnfGFp5DYacHYOE7+GB8yoQC-iyw7JAxySmgQ7vw@mail.gmail.com>
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
To: David Rheinsberg <david@readahead.eu>, Aleksa Sarai <cyphar@cyphar.com>
Cc: =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	dmitry.torokhov@gmail.com, Daniel Verkamp <dverkamp@chromium.org>, hughd@google.com, 
	jorgelo@chromium.org, skhan@linuxfoundation.org, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:20=E2=80=AFAM Jeff Xu <jeffxu@google.com> wrote:
>
> On Thu, May 23, 2024 at 1:24=E2=80=AFAM David Rheinsberg <david@readahead=
.eu> wrote:
> >
> > Hi
> >
> > On Thu, May 23, 2024, at 4:25 AM, Barnab=C3=A1s P=C5=91cze wrote:
> > > 2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel,=
 Andrew Morton
> > > <akpm@linux-foundation.org> =C3=ADrta:
> > >> It's a change to a userspace API, yes?  Please let's have a detailed
> > >> description of why this is OK.  Why it won't affect any existing use=
rs.
> > >
> > > Yes, it is a uAPI change. To trigger user visible change, a program h=
as to
> > >
> > >  - create a memfd
> > >    - with MFD_NOEXEC_SEAL,
> > >    - without MFD_ALLOW_SEALING;
> > >  - try to add seals / check the seals.
> > >
> > > This change in essence reverts the kernel's behaviour to that of Linu=
x
> > > <6.3, where
> > > only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctl=
y
> > > on those
> > > kernels, it will likely work correctly after this change.
> > >
> > > I have looked through Debian Code Search and GitHub, searching for
> > > `MFD_NOEXEC_SEAL`.
> > > And I could find only a single breakage that this change would case:
> > > dbus-broker
> > > has its own memfd_create() wrapper that is aware of this implicit
> > > `MFD_ALLOW_SEALING`
> > > behaviour[0], and tries to work around it. This workaround will break=
.
> > > Luckily,
> > > however, as far as I could tell this only affects the test suite of
> > > dbus-broker,
> > > not its normal operations, so I believe it should be fine. I have
> > > prepared a PR
> > > with a fix[1].
> >
> > We asked for exactly this fix before, so I very much support this. Our =
test-suite in `dbus-broker` merely verifies what the current kernel behavio=
r is (just like the kernel selftests). I am certainly ok if the kernel brea=
ks it. I will gladly adapt the test-suite.
> >
memfd is by default not sealable, and file is by default sealable,
right ? that makes the memfd  semantics different from other objects
in linux.
I wonder what is the original reason to have memfd  this way?

Another solution is to change memfd to be by-default sealable,
although that will be an api change, but what side effect  will it be
?
If we are worried about the memfd being sealed by an attacker, the
malicious code could also overwrite the content since memfd is not
sealed.

> > Previous discussion was in:
> >
> >     [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
> >     https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahea=
d.eu/
> >
> > Note that this fix is particularly important in combination with `vm.me=
mfd_noexec=3D2`, since this breaks existing user-space by enabling sealing =
on all memfds unconditionally. I also encourage backporting to stable kerne=
ls.
> >
> Also with vm.memfd_noexec=3D1.
> I think that problem must be addressed either with this patch, or with
> a new flag.
>
> Regarding vm.memfd_noexec, on another topic.
> I think in addition to  vm.memfd_noexec =3D 1 and 2,  there still could
> be another state: 3
>
> =3D0. Do nothing.
> =3D1. This will add MFD_NOEXEC_SEAL if application didn't set EXEC or
> MFD_NOEXE_SEAL (to help with the migration)
> =3D2: This will reject all calls without MFD_NOEXEC_SEAL (the whole
> system doesn't allow executable memfd)
> =3D3:  Application must set MFD_EXEC or MFD_NOEXEC_SEAL explicitly, or
> else it will be rejected.
>
> 3 is useful because it lets applications choose what to use, and
> forces applications to migrate to new semantics (this is what 2 did
> before 9876cfe8).
> The caveat is 3 is less restrictive than 2, so must document it clearly.
>
> -Jeff
>
> > Reviewed-by: David Rheinsberg <david@readahead.eu>
> >
> > Thanks
> > David

