Return-Path: <linux-kselftest+bounces-10623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7838CD856
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 18:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9271F21314
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81A3179A3;
	Thu, 23 May 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gvBuEoG2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20493D304
	for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716481298; cv=none; b=ijNa0NYWQTMYlZ2svRcCA6xL7teo4XesPjhRWGhOh+aDDUeq/BJg3XJ7Dsbveieunv38RSv6PTO3ga0zJglwy6QwLj+o3BImpEG1HwwvoIVm6/SuYsZ/3kI6BsdhDMHfbuTXc0bwGpqmdB3BUf93EtosnDNrlxn4FnHugGJCSsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716481298; c=relaxed/simple;
	bh=+ehJ0HgY9Kbm/BV+/w1j7XuMWnlOPM8zqAp0NNdOWC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GM1/tYuj0lltgbseC+O4iSMp+5jg3a0z+OAeCzJmApP/o1mAZMmITTjCJ6jB+aw5Z1bGqwpcO39tYTGeYDqwSdwT55F1bF4m3afRcwbtkDpuxfROgonlapsip1NQlMGHKj2pOQdEObf42PeKIBcw1BZ3RUf0iQ42Wm6Xb7OJuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gvBuEoG2; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5750a8737e5so17321a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 23 May 2024 09:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716481295; x=1717086095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB9/RUM+ns3PLgFlSVcvmGls/4xMPa5pg/Lm96fgSy4=;
        b=gvBuEoG2+2LlQrHQKxL+PCzfImapP1Mn9YmBZVOtGBNhHbDJmL/b4vZgyZTJ2f5QmW
         SWmlkr2fX2oD5AVJcaW5oa4GHKQUkjcC0q8gNLeLQLoFJbk45EcANubiJW9OVcTqj8yY
         u7boBKZs32kkHBMilro/NI+oNkeRFTDAMcZFPyNwJQNtyAy92PB5ovRojNbI32xaX4Af
         ATrF0eSAzlSnOjpr6UhER1yUIFzfYVM2mDr8aFHtZIgzne81LcjJJEXUGce92e2ILsav
         KwZaoCVxC+DXe2uQ/JXoFbCgGPH70IwfmjzmPrJOED/FSkEmSU3BSA2MqcIX0OMKeDyC
         1gbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716481295; x=1717086095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FB9/RUM+ns3PLgFlSVcvmGls/4xMPa5pg/Lm96fgSy4=;
        b=k2n3Q+1z6I5+uaVd8vyAQYDFsCPZjuP0FRSsqfcDrPn7QlFRcJAI3wfT5I5wRZ8INq
         Onx+k5wVaKZjp67L+murLBxyC2kdZ/aHOlsLdIOdTPTC5VkmhfFVHdeub05+SRIn3Ja6
         AzvIDwLY6x07jgFOVElrD5LrhFlgjgFsCvUy+vjCIwdd/0Whd1PCdbKdpIaTLQ+MmIyG
         qy3WdxzW1uytxDueKEAUUHz/vlWC08uNbDu0wyN8oo0Q7tBhHosPe8QDgN6yM6fk2kuh
         pWhfpri2zD9WE/Xz8xHa3oespM/prm8D1szzggGItqhTuEGHYbRafm3x2tZgGo58V4bE
         YjWg==
X-Forwarded-Encrypted: i=1; AJvYcCVGKLDlXYI53LCaYTalKuMASzWoC3z3IdxlI32L0W2H696ejtehZEkcGxBOPCD2bhkRaa2iHYwNqjZs2ezLua40ZrnUfeH7O6OObiIVfE9Z
X-Gm-Message-State: AOJu0YxP6/elKhsX1w7/BPoRENVXdVdapmEfETLAqfaTm+AA1bq/Ji06
	Yylp3UjnQIZd/Q5KJcoUicEgN5OpSCzDEkUvHkLiFp/Tp3z8CCl4dsKSUF4zfX7/XRIDzivXkxm
	EOs4j2yEVU1bMRJbisrSJ1RZGL3VQTRKGnXg7
X-Google-Smtp-Source: AGHT+IGwZjQzBM7QW+l92UBGowEyvL4YIjIqR4mt4bRhFqZ40GRMBXjmulC2dCc7aOz5TMEW+XWiI6fiAZVRymPuD1w=
X-Received: by 2002:a50:8d85:0:b0:574:e7e1:35bf with SMTP id
 4fb4d7f45d1cf-57845bac601mr156326a12.7.1716481295251; Thu, 23 May 2024
 09:21:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com>
 <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
 <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
 <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
In-Reply-To: <08450f80-4c33-40db-886f-fee18e531545@app.fastmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 23 May 2024 09:20:55 -0700
Message-ID: <CALmYWFv9dK5ZPzwx3WCLMXzuuDadvFxh84+8rrT7aL105+ZZAQ@mail.gmail.com>
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

On Thu, May 23, 2024 at 1:24=E2=80=AFAM David Rheinsberg <david@readahead.e=
u> wrote:
>
> Hi
>
> On Thu, May 23, 2024, at 4:25 AM, Barnab=C3=A1s P=C5=91cze wrote:
> > 2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel, A=
ndrew Morton
> > <akpm@linux-foundation.org> =C3=ADrta:
> >> It's a change to a userspace API, yes?  Please let's have a detailed
> >> description of why this is OK.  Why it won't affect any existing users=
.
> >
> > Yes, it is a uAPI change. To trigger user visible change, a program has=
 to
> >
> >  - create a memfd
> >    - with MFD_NOEXEC_SEAL,
> >    - without MFD_ALLOW_SEALING;
> >  - try to add seals / check the seals.
> >
> > This change in essence reverts the kernel's behaviour to that of Linux
> > <6.3, where
> > only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctly
> > on those
> > kernels, it will likely work correctly after this change.
> >
> > I have looked through Debian Code Search and GitHub, searching for
> > `MFD_NOEXEC_SEAL`.
> > And I could find only a single breakage that this change would case:
> > dbus-broker
> > has its own memfd_create() wrapper that is aware of this implicit
> > `MFD_ALLOW_SEALING`
> > behaviour[0], and tries to work around it. This workaround will break.
> > Luckily,
> > however, as far as I could tell this only affects the test suite of
> > dbus-broker,
> > not its normal operations, so I believe it should be fine. I have
> > prepared a PR
> > with a fix[1].
>
> We asked for exactly this fix before, so I very much support this. Our te=
st-suite in `dbus-broker` merely verifies what the current kernel behavior =
is (just like the kernel selftests). I am certainly ok if the kernel breaks=
 it. I will gladly adapt the test-suite.
>
> Previous discussion was in:
>
>     [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
>     https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.=
eu/
>
> Note that this fix is particularly important in combination with `vm.memf=
d_noexec=3D2`, since this breaks existing user-space by enabling sealing on=
 all memfds unconditionally. I also encourage backporting to stable kernels=
.
>
Also with vm.memfd_noexec=3D1.
I think that problem must be addressed either with this patch, or with
a new flag.

Regarding vm.memfd_noexec, on another topic.
I think in addition to  vm.memfd_noexec =3D 1 and 2,  there still could
be another state: 3

=3D0. Do nothing.
=3D1. This will add MFD_NOEXEC_SEAL if application didn't set EXEC or
MFD_NOEXE_SEAL (to help with the migration)
=3D2: This will reject all calls without MFD_NOEXEC_SEAL (the whole
system doesn't allow executable memfd)
=3D3:  Application must set MFD_EXEC or MFD_NOEXEC_SEAL explicitly, or
else it will be rejected.

3 is useful because it lets applications choose what to use, and
forces applications to migrate to new semantics (this is what 2 did
before 9876cfe8).
The caveat is 3 is less restrictive than 2, so must document it clearly.

-Jeff

> Reviewed-by: David Rheinsberg <david@readahead.eu>
>
> Thanks
> David

