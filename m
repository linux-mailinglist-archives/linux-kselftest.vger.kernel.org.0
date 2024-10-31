Return-Path: <linux-kselftest+bounces-21246-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198969B82C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 19:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F9D283494
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9C31CCB26;
	Thu, 31 Oct 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKs9cVWB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97BE1CC88F
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730400211; cv=none; b=mwIZB6xrHeLKFIlcuc9BUNy5YbIUCmwoMr/OCkl83GvlQ+WqLCuUnoh7RnMNBGFfRYGf4XbVZ1/7jjFXvPNLCBsGOOfEoGo+YUPGNC2NVr404b+d5h9TqzL6oiV2yAYWHMMcYnfGYXWdFUFbQeZNffdSmTRCWazYDFQk2JBkV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730400211; c=relaxed/simple;
	bh=fbRxElWAfw0KCiVDJKBevq3Ta0/tr5/VpNOm+QxkSUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ii0g5bH0aIg0DnMHACrur1A7IU4xe1KEP4DptbggS5Ud0W8SlvZlRDi83ww7SfspHBAy7SSdr81jVWWfvLfV8xx3lG8EuYO7j4tit1JR23zqv4gO+7DHYnhyVhfBHs8WojYu8qHGAEwPaTyRz03DigJRP3FqHzhJ1iDDh4yxxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JKs9cVWB; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-268d0979e90so118122fac.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 11:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730400208; x=1731005008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9pkCMrlG+6d8KDFXYWlMBHxdGI2r5U3tUuEXE09VQM=;
        b=JKs9cVWB+3WbGW2MebYxAk+QX2N8PwgofGKjAyMjqKpy4G7G3BEc26iW3zQ8Wr8TJs
         qecQ4Ikp4Pit0wTy6VPjf70Ye9FXagXRydi0+p7LEtIzhtjzxvDP9jDRvWywS2xW/dpS
         nxepEyhjgon2N9OAmPR8aqGG2bghuWucTlbeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730400208; x=1731005008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9pkCMrlG+6d8KDFXYWlMBHxdGI2r5U3tUuEXE09VQM=;
        b=KDIZ5i9DSixhYPw7bDtTqXxxAHFLIjqjrXvGhoOOY2FC6cIUJ2UEE8OYZW199Iag29
         nlAIWK945kOGqhArC61KM9BOCZQI1kRazF4uTkb+mmSohYiEGYyM5TzlD62O5KH+2515
         zdTtoki2kRuE4Bp2v0uVpVvyYW7XcyK4WGcujbNSWvzWduhquI2VDwFy2uIo04fVBi8n
         LCggF4kOSGxu8E6yl0Fd4hl3jAXyILJbJDNnOdGolLpPNgkduGA2ZYLu2/Xd2jCOPtje
         x75dyfhEz4rT5FsVry9pFdOvaOd23RBF/WWg+Nqd5weSMK/fa+t5CcZ+Jxl/sjurM4Jc
         7F8g==
X-Forwarded-Encrypted: i=1; AJvYcCVY/IjPj8hZnFQdEwmosxEFa5a9nxg908kpb8EshF9FXG/aljEj7mDqq0jEOS4Uv63av9j4l8FfbAo73cZIkrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtbzmToAYrl9K6KRFCmfhwmWDlN3wVxWfbgRFxblKUXXR9e0I
	GCapghN5wPwGjLYeFroqUYt3LS1x5WSGp9eeLLHxzyyX//+NjuGBMtngnODJClJUg6oMWUuW0Ce
	9bWNHMhETxdtedeiJxajc9ZA0OLo0Q0oBsKGo
X-Google-Smtp-Source: AGHT+IFGIJKLWI/BUm9W6oX5BAu9UJongzEp3ksTnogYOtUiu9chLn5n70BL50s4fYBWdm9xYpy2QybIo/hGZpLsz+c=
X-Received: by 2002:a05:6870:7311:b0:288:2955:3efb with SMTP id
 586e51a60fabf-29051c4e8a4mr4891117fac.8.1730400207786; Thu, 31 Oct 2024
 11:43:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029144539.111155-1-kevin.brodsky@arm.com>
 <20241029144539.111155-2-kevin.brodsky@arm.com> <CABi2SkUTSuk_PS9==_czM=64FGWK_5DyUe5QELxiFHtPFsKaHw@mail.gmail.com>
 <cd0e114d-57eb-4c90-bb6f-9abf0cc8920f@arm.com>
In-Reply-To: <cd0e114d-57eb-4c90-bb6f-9abf0cc8920f@arm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 31 Oct 2024 11:43:16 -0700
Message-ID: <CABi2SkW6_CACjYheaEMuCYGnwnXKoVGuACtnCyDb8Zjfac6Wog@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] arm64: signal: Improve POR_EL0 handling to avoid
 uaccess failures
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, 
	anshuman.khandual@arm.com, aruna.ramakrishna@oracle.com, broonie@kernel.org, 
	catalin.marinas@arm.com, dave.hansen@linux.intel.com, Dave.Martin@arm.com, 
	joey.gouly@arm.com, keith.lucas@oracle.com, pierre.langlois@arm.com, 
	shuah@kernel.org, sroettger@google.com, tglx@linutronix.de, will@kernel.org, 
	yury.khrustalev@arm.com, linux-kselftest@vger.kernel.org, x86@kernel.org, 
	Kees Cook <keescook@chromium.org>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 1:45=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
>
> On 30/10/2024 23:01, Jeff Xu wrote:
> >> -static int restore_poe_context(struct user_ctxs *user)
> >> +static int restore_poe_context(struct user_ctxs *user,
> >> +                              struct user_access_state *ua_state)
> >>  {
> >>         u64 por_el0;
> >>         int err =3D 0;
> >> @@ -282,7 +338,7 @@ static int restore_poe_context(struct user_ctxs *u=
ser)
> >>
> >>         __get_user_error(por_el0, &(user->poe->por_el0), err);
> >>         if (!err)
> >> -               write_sysreg_s(por_el0, SYS_POR_EL0);
> >> +               ua_state->por_el0 =3D por_el0;
> >>
> >>         return err;
> >>  }
> >> @@ -850,7 +906,8 @@ static int parse_user_sigframe(struct user_ctxs *u=
ser,
> >>  }
> >>
> >>  static int restore_sigframe(struct pt_regs *regs,
> >> -                           struct rt_sigframe __user *sf)
> >> +                           struct rt_sigframe __user *sf,
> >> +                           struct user_access_state *ua_state)
> >>  {
> >>         sigset_t set;
> >>         int i, err;
> >> @@ -899,7 +956,7 @@ static int restore_sigframe(struct pt_regs *regs,
> >>                 err =3D restore_zt_context(&user);
> >>
> >>         if (err =3D=3D 0 && system_supports_poe() && user.poe)
> >> -               err =3D restore_poe_context(&user);
> >> +               err =3D restore_poe_context(&user, ua_state);
> >>
> >>         return err;
> >>  }
> >> @@ -908,6 +965,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
> >>  {
> >>         struct pt_regs *regs =3D current_pt_regs();
> >>         struct rt_sigframe __user *frame;
> >> +       struct user_access_state ua_state;
> >>
> >>         /* Always make any pending restarted system calls return -EINT=
R */
> >>         current->restart_block.fn =3D do_no_restart_syscall;
> >> @@ -924,12 +982,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
> >>         if (!access_ok(frame, sizeof (*frame)))
> >>                 goto badframe;
> >>
> >> -       if (restore_sigframe(regs, frame))
> >> +       if (restore_sigframe(regs, frame, &ua_state))
> >>                 goto badframe;
> >>
> >>         if (restore_altstack(&frame->uc.uc_stack))
> >>                 goto badframe;
> >>
> > Do you need to move restore_altstack ahead of restore_sigframe?
>
> This is not necessary because restore_sigframe() no longer writes to
> POR_EL0. restore_poe_context() (above) now saves the original POR_EL0
> value into ua_state, and it is restore_user_access_state() (called below
> just before returning to userspace) that actually writes to POR_EL0,
> after all uaccess is completed.
>
Got it, thanks for the explanation.

-Jeff

> Having said that, I somehow missed the call to restore_altstack() when
> writing the commit message, so these changes in sys_rt_sigreturn are in
> fact necessary. Good catch! At least the patch itself should be doing
> the right thing.
>
> - Kevin
>
> > similar as x86 change [1],
> > the discussion for this  happened  in [2] [3]
> >
> > [1] https://lore.kernel.org/lkml/20240802061318.2140081-5-aruna.ramakri=
shna@oracle.com/
> > [2] https://lore.kernel.org/lkml/20240425210540.3265342-1-jeffxu@chromi=
um.org/
> > [3] https://lore.kernel.org/lkml/d0162c76c25bc8e1c876aebe8e243ff2e68623=
59.camel@intel.com/
> >
> > Thanks
> > -Jeff
> >
> >
> >> +       restore_user_access_state(&ua_state);
> >> +
> >>         return regs->regs[0];
>

