Return-Path: <linux-kselftest+bounces-7876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38B8A37E7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 23:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94EA286784
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56CC15099F;
	Fri, 12 Apr 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PXF3Zz5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DF152176
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712957555; cv=none; b=OMA2KJcNesUs8jJKCBINjEQ0w4gTGsw0CoJKfKfgt5NEB2o6zWZMi7/m/x7dKzyp2T2Nh7UewFDM3PX1rtPgsV8bhdFutumkEOFCfk0extg9bL1HTe5/wd2g9LFF2WA8YKjpYZjqGNIi2L1vso7Ymbkbz7XkLra0MlAXTk8QrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712957555; c=relaxed/simple;
	bh=gbwgYTpF/BcSQV0HXsiHe1579SMMnmR3GWasc0GUJc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENyS9B9pViNKq6cYkACFQwRIwZDFj0v72vIp/CtDyRbNfnYaGRWO5FjbmIC4CnuTKcyC7R7n+tx6SH2vpZnxuc1Pi4sSeY+A/KrHBN2Kc3H+kZ2SSf5skueCX06e+l2kEjCeFuZS7APMlOjtHUMpbxA9cTA+I0a+jJOW2rOXUjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PXF3Zz5Q; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-434ffc2b520so36041cf.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 14:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712957553; x=1713562353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bOsXTEuHSJ7y+R+ng6MulWBYUcUx1JMdZqOniqnEV8=;
        b=PXF3Zz5QqLYslSKTWLtcejFioLU/JxedoaAIRJRnT2LwRU0VHDhIbDWBYXwccSlK6O
         p6I4na2yEtF7n81cnN2YWnhlY2CxombfhzCf4LidohTwflZ/5jnlBqyHsLvV2Zg6vuCj
         P2Fg42gkRyjpNn9vaUBQWMiQ0suyYXJZyzKlOQKIPvVpHxrzO7g6v3rxUqekY9SR3XTv
         c8Id6+hvKH24pblUcRDVcv310beaPnS+BXmL2KAc3WPBe8FKpaqeL/zx1t63bLXWzit6
         BntzBJlGFjbKkXCYp4/F1mSNpTMZSuaf36z+zX3+rjeZUUdxtfcofiIm1s0ndcnXIAlP
         TfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712957553; x=1713562353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5bOsXTEuHSJ7y+R+ng6MulWBYUcUx1JMdZqOniqnEV8=;
        b=sSfkSy5Y+UYhi5rmuNFfHWbQ2itquS0sdZvxKdiDYA+RNCJbb/mDQXKl+jryoPLzKw
         wxbUxqKK7IcW1hjaHphXYwuHTVswplZna2bLK+tQa+1m6rfn8S9AY0p1Sfk+x2ew22vQ
         qY28Fg2yAeOG1PPQPCoLRjuUFV88bgcomgmIjONjiAuv9oG+i2XVO0ZZTAhcQe50o8Bx
         eeRFYm2fbHczyUttZ8pN3l2OwZzVEfzEgpzArqJdb+kLwdMama0XVluu9ybVpc1PIK6U
         x2OFtVmBQwpqbfKJCU1g6B3EAqoUzbsN1u7YGKFMivcjCF54l+vD+B9PHjy70z4Bz8Qh
         /Mkg==
X-Forwarded-Encrypted: i=1; AJvYcCXjIXZMjh/N2qLL29gPr/We9GsXhDzNrQBIkQ2qy2d9OKjWwM2y8ekQCoYOQhj0U+49sYLVb/oQSx61QYhrOrSBvPukPLzeIQgUK5daBw86
X-Gm-Message-State: AOJu0YwqfHLTxEKsZDxiRV7iZW1fK5NFTMJvcyMXnbuS5GgHkEpHm3TL
	a0pxBlTlYxwIIQVOP6Nf5fNeP6nL041oI44MGaU8q8GCS7AOE9m0OrHLkwYrCrNyjrjHiFsc3wi
	Qpy4X6ZzN78s8J+6p8cQjVTULpVfBUyG6H9Wk
X-Google-Smtp-Source: AGHT+IHoLnA8rSSQsZ3I5df06ZmXxHEMFSYbpT/WK4qJDmffFK7AEoxvfrE5gza6mQMl3dOr4fy1NaKIHmZsf8NM7Zs=
X-Received: by 2002:a05:622a:1995:b0:434:a690:e326 with SMTP id
 u21-20020a05622a199500b00434a690e326mr25736qtc.9.1712957553270; Fri, 12 Apr
 2024 14:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412025903.489470-1-davidgow@google.com>
In-Reply-To: <20240412025903.489470-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 12 Apr 2024 17:32:21 -0400
Message-ID: <CA+GJov7BGQmPUCzA_3Em6P0tXAWnUX-YD5r3pdPKFSSNL0tgyw@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix race condition in try-catch completion
To: David Gow <davidgow@google.com>
Cc: Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Will Deacon <will@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Guenter Roeck <linux@roeck-us.net>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Brendan Higgins <brendan.higgins@linux.dev>, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 10:59=E2=80=AFPM David Gow <davidgow@google.com> wr=
ote:
>
> KUnit's try-catch infrastructure now uses vfork_done, which is always
> set to a valid completion when a kthread is created, but which is set to
> NULL once the thread terminates. This creates a race condition, where
> the kthread exits before we can wait on it.
>
> Keep a copy of vfork_done, which is taken before we wake_up_process()
> and so valid, and wait on that instead.
>
> Fixes: 4de2a8e4cca4 ("kunit: Handle test faults")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/lkml/20240410102710.35911-1-naresh.kamboj=
u@linaro.org/
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Signed-off-by: David Gow <davidgow@google.com>

Hello,

This fix looks good to me. I have tested it and besides the fortify
test error discussed in the previous patch series I am happy.

Thanks!
-Rae

Reviewed-by: Rae Moar <rmoar@google.com>


> ---
>  lib/kunit/try-catch.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index fa687278ccc9..6bbe0025b079 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -63,6 +63,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_ca=
tch, void *context)
>  {
>         struct kunit *test =3D try_catch->test;
>         struct task_struct *task_struct;
> +       struct completion *task_done;
>         int exit_code, time_remaining;
>
>         try_catch->context =3D context;
> @@ -75,13 +76,16 @@ void kunit_try_catch_run(struct kunit_try_catch *try_=
catch, void *context)
>                 return;
>         }
>         get_task_struct(task_struct);
> -       wake_up_process(task_struct);
>         /*
>          * As for a vfork(2), task_struct->vfork_done (pointing to the
>          * underlying kthread->exited) can be used to wait for the end of=
 a
> -        * kernel thread.
> +        * kernel thread. It is set to NULL when the thread exits, so we
> +        * keep a copy here.
>          */
> -       time_remaining =3D wait_for_completion_timeout(task_struct->vfork=
_done,
> +       task_done =3D task_struct->vfork_done;
> +       wake_up_process(task_struct);
> +
> +       time_remaining =3D wait_for_completion_timeout(task_done,
>                                                      kunit_test_timeout()=
);
>         if (time_remaining =3D=3D 0) {
>                 try_catch->try_result =3D -ETIMEDOUT;
> --
> 2.44.0.683.g7961c838ac-goog
>

