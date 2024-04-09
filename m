Return-Path: <linux-kselftest+bounces-7480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525289D85A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 13:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2B81F21161
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 11:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314E6127B4E;
	Tue,  9 Apr 2024 11:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FtwpSfcR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A586AF4
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Apr 2024 11:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712663144; cv=none; b=BwONhNB0GNkHSxMYCa7EIU403vzxymqfrNI8RsNP3AdG/iNE/VVcYWgZJxUVb6YOSoVIpIsJoRXZZAc+5pu14ajShGXuumEd2vVTfg6JTTnjKpyeaVQxYUvnfmnNVRMVXLD48jlxEEZQXPhJY0ptRMi4oriY3Mt/E+z7dHxd14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712663144; c=relaxed/simple;
	bh=lB9SkxiER1Va36w0Sjtn8mKx8w/76n4SXUDde9QyjsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWNJIkb3FC7nTWXGmRPsDYtUyk7/95wMBWH+1KP3CEMJUHlosFo/m75IsDXUq7H6cDnHUsixptTHUnQMMmryLju/whf2j+LqkF98/DyO3dZyD92n0OOMg8+lHMb1nUmjALMr7xB4VWW2Z1l9J4ik534nsUkCDgphctCeP359SZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FtwpSfcR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso73645e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Apr 2024 04:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712663141; x=1713267941; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XdtnM0pMYunPj+eUYeM0gH2TJdeUBrC57PV1HZeV+xE=;
        b=FtwpSfcRjTd8rIlxBDYJ/C9ma++M/t7gpFHfYO0QCE5mnu9tSBinUzoCVDqlsJCotu
         +Ep+cvWKtscri+DqQDCAOrwQu0pobO0KVeqeIIT+9mq71mNYPI58JyLkdbQAi4ZkxcCf
         cMt7PJzoxyv8yrdtmOB1XLx+XIidrrFPK7ENDK7ZV/l4Ji88SGX/6JW5wdyDMMHIkUXC
         aVm6ZZx0dtfNrCJaRd0JnBry7Mx2quvJN5p6dfL8/cByV+FHZUqdSMDfkdlxf26uNPVH
         ao63CUUwL6yPu1AYzLMRHCkhF0fZPXwFFHtRax1OPedcez+3vgUvbffIDr9G9zmA/5/c
         YtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712663141; x=1713267941;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XdtnM0pMYunPj+eUYeM0gH2TJdeUBrC57PV1HZeV+xE=;
        b=nmrcgzaVirVribZxZC6MVVx/fct6a2udLQ9AGX5rFD6AZjGN9e0tTVAyHa5tlMOAnj
         LbScNJ0ruDg3MAETLDcf3gs1jxn8V+MpM74Qs4LotGLgcX9UZRAiMdyTJ8M/vicnsP5g
         u8pZq9eIlyHlLns4fcchRUiifMz+jZL3PeFkhceHf0qSYbJkPxMrev9hvrTCCpW5ix2R
         FiYNdo+XwIReacozYGQ12aS9lh5sah4c7uyb029XSzkBHZ59XiAC079ajY56tUg4Tr9J
         ACk2JQMA14b6wvdd0cE4+49du0rMK7BAIIZNMSkZVaoKUHWJAHhy+ZFXAt7l6xeeh6Jx
         Thvg==
X-Forwarded-Encrypted: i=1; AJvYcCVVAaXg9yqI6OKfJdysCJjBjvXX8Qvkx4uqQJOfgiE/1TJLxFB7hWzj3xWUw3mMosJSaASH26MS4I8eGxWmleKRsslD1sMxNlzgtMBH/6Gj
X-Gm-Message-State: AOJu0Yx+Rib22mJAiHXoC5YjJ1S4mpgcBH0wU6YBhljyNg8fJO5fLh3p
	5ROcG9ki2I+ViAICXbicuXp58zU0rIoDFy/qPCSwtveFH3oTz1BUbIWDZU50IVanuYKgGgFGeFG
	mbTXVh7hNjCvxHSYeYb5FJsXLZj8KQc1LHSYw
X-Google-Smtp-Source: AGHT+IFk2eCxUClDlHllVGYfhicaZlD8wiHkH34x8yIkk8F4QLS2RHAaCO/kSbDi3dS4EpxrPHmqIS3ZTgbTGQMKE1U=
X-Received: by 2002:a05:600c:314c:b0:416:7f8a:c6ea with SMTP id
 h12-20020a05600c314c00b004167f8ac6eamr120300wmo.1.1712663140470; Tue, 09 Apr
 2024 04:45:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANDhNCreA6nJp4ZUhgcxNB5Zye1aySDoU99+_GDS57HAF4jZ_Q@mail.gmail.com>
 <87frw2axv0.ffs@tglx> <20240404145408.GD7153@redhat.com> <87le5t9f14.ffs@tglx>
 <20240406150950.GA3060@redhat.com> <20240406151057.GB3060@redhat.com>
 <CACT4Y+Ych4+pdpcTk=yWYUOJcceL5RYoE_B9djX_pwrgOcGmFA@mail.gmail.com>
 <20240408102639.GA25058@redhat.com> <20240408184957.GD25058@redhat.com>
 <87il0r7b4k.ffs@tglx> <20240409111051.GB29396@redhat.com>
In-Reply-To: <20240409111051.GB29396@redhat.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 9 Apr 2024 13:45:24 +0200
Message-ID: <CACT4Y+ZOn3n+NL=JH-=yNWOv8RWOg_idGqQz10fD-F-FW27M+g@mail.gmail.com>
Subject: Re: [PATCH] selftests/timers/posix_timers: reimplement check_timer_distribution()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>, 
	Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kasan-dev@googlegroups.com, 
	Edward Liaw <edliaw@google.com>, Carlos Llamas <cmllamas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 13:12, Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 04/09, Thomas Gleixner wrote:
> >
> > The discussion started about running new tests on older kernels. As this
> > is a feature and not a bug fix that obviously fails on older kernels.
>
> OK, I see... please see below.
>
> > So something like the uncompiled below should work.
>
> Hmm... this patch doesn't apply to Linus's tree...
>
> It seems that this is because in your tree check_timer_distribution() does
>
>         if (timer_delete(id)) {
>                 ksft_perror("Can't delete timer");
>                 return 0;
>         }
>
> while in Linus's tree it returns -1 if timer_delete() fails. Nevermind.
>
> Thomas, I am almost shy to continue this discussion and waste your time ;)
> But ...
>
> > +static bool check_kernel_version(unsigned int min_major, unsigned int min_minor)
> > +{
> > +     unsigned int major, minor;
> > +     struct utsname info;
> > +
> > +     uname(&info);
> > +     if (sscanf(info.release, "%u.%u.", &major, &minor) != 2)
> > +             ksft_exit_fail();
> > +     return major > min_major || (major == min_major && minor >= min_minor);
> > +}
>
> this looks useful regardless. Perhaps it should be moved into
> tools/testing/selftests/kselftest.h as ksft_ck_kernel_version() ?
>
> > +static int check_timer_distribution(void)
> > +{
> > +     const char *errmsg;
> > +
> > +     if (!check_kernel_version(6, 3)) {
> > +             ksft_test_result_skip("check signal distribution (old kernel)\n");
> >               return 0;
>
> ...
>
> > +     ksft_test_result(!ctd_failed, "check signal distribution\n");
>
> Perhaps
>
>         if (!ctd_failed)
>                 ksft_test_result_pass("check signal distribution\n");
>         else if (check_kernel_version(6, 3))
>                 ksft_test_result_fail("check signal distribution\n");
>         else
>                 ksft_test_result_skip("check signal distribution (old kernel)\n");
>
> makes more sense?

This looks even better!

> This way it can be used on the older kernels with bcb7ee79029d backported.
>
> Oleg.
>

