Return-Path: <linux-kselftest+bounces-12479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29972912F20
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 23:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D634D28157B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 21:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F816D4F5;
	Fri, 21 Jun 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qiU9nc3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC61155329
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719003803; cv=none; b=U0/3fZ93Xnff/LGqNRHKurex6Gvme2EsBRwI0Ie7l50CGZ2IQh1iGNaaGGLLYyqa9Zlrf/5IH7kFvJwxSDC652uQ2UnnecarjY3I4TL7ESPcn//XFoKJ50CcXqkIqkPkibIVDxbXoDCBctsboDPG7CcjogWafaxMbGuhhH2OoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719003803; c=relaxed/simple;
	bh=kaUnb9GUIh+3+2Uo9N6ltu5y13680z2bwqpz7SR7n2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6ivYOycfUGFpBsRAwSoE3jCFIASE+LKwRqcRj3L8uZMfIGydBRNtElppVMoqvBaSLCFRk6Or3b7F4C8z1ZLl8czH+EsNRtrTsGdKPKdfnkXBQvl6hPmN1DBq7NIfHzunoz7RS7v8gLvMxIplhl4iHcEuz6EnldG7Tf2dJgzvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qiU9nc3Q; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4405dffca81so295471cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 14:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719003801; x=1719608601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3aUiyjQtRe9LhRXIffkf+PpHYA1RmU+WBq33FtrT+24=;
        b=qiU9nc3QC1qkNPtc4XYnInqfWOReIAWL/icot4791ZiUkqGg2GU+gzF1PidgzJHCsU
         ToA+VUOjGLhKCZoKJJ2SpnjumDdziEYWiDDfeYXp/Dpmx7TIaAApD2Lnf0VGFJVMGvng
         dkIDwvPMElv/4kWxXKnWgeL+I0TLQOmhA7ZiGHiXadN9yEZMhhDyV+ayOQnbq0UG2gVo
         St7ankChKcLsb6z8wLtoVmGauqBnNS2FYzcg3hQY1YFExzV1JBddlXE9TFMVKAgWuuUw
         j702S5/qeuP+wc2obu2IPNZTZV3IKLBPOeaJB70Rmdi01PYiUGR9GUe5JG2j9a2mk6r8
         KJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719003801; x=1719608601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3aUiyjQtRe9LhRXIffkf+PpHYA1RmU+WBq33FtrT+24=;
        b=R41jv9kxRxBHnfUbWMCOlAbf21Qo9ZENJJ/9jnMvBzj+pBH8lKa3rXdKtEY71KusTo
         RO5Rzt9pPuqBtnzFb3aA/vVcZ13Z5VDiLgBeytYxGg80dMG9uMQw+Rxkm7grGemBBjDK
         CbeNUwPlq2yeNVyG9eVTmhMVECbFyP5fZyySX9Mbkf5ROW29uNwQeHKIfdmrDrvy25du
         pVXfbSQV/AvpiUphw9z0TyloGhBvzXIg3uBodYgM/kSIduikGlm7UM1A6i4i1UDycoYr
         iHm6tOjCMm26bpNxNVpI9FBv8wlVKo3PofVWm1kq6RX51qvf9o21aFq+QIMosmbTwS4d
         UlGA==
X-Forwarded-Encrypted: i=1; AJvYcCWs3JKM6oMgLFVjdG93QHaDd2uDqS/yDEdL+36g946xX8qUFlD+31s4Z5rE3w8de+0Hv7Fvq8z3uYXpt2jjeG/a55Ht4S01AOkCx7AUm3Gl
X-Gm-Message-State: AOJu0YwvzByUjC4wocEbX8HE+PbCJQF9KpwmC9SI/0pLe7boS0XEQ5ja
	vz6mTBbjSEFc7k0lqt4vsoESevtB3kHtWownRLs5LNzXk3mv/4V1crijHF1UD61ib0ULvsHj5Ai
	LJBVzHWY3o8svLGrkQg/mgjv/a0k3hiyNrgfY
X-Google-Smtp-Source: AGHT+IFp4GG2MnBEz7c2jvV67DljerT/BuE+XXwOGgKTK7ODlchWTRsArj6WiJv8/CIQuHgsV3DoQnFGZbylU/vOeqs=
X-Received: by 2002:a05:622a:1303:b0:43e:295:f160 with SMTP id
 d75a77b69052e-444ce38ab64mr327271cf.24.1719003801237; Fri, 21 Jun 2024
 14:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618170331.264851-1-ivan.orlov0322@gmail.com> <20240618170331.264851-3-ivan.orlov0322@gmail.com>
In-Reply-To: <20240618170331.264851-3-ivan.orlov0322@gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Fri, 21 Jun 2024 17:03:10 -0400
Message-ID: <CA+GJov5iSJuQuk9=VMkxRKr+CYAmuZw9YHqydSJnG0HX0U2ASA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] kunit: kunit-test: Remove stub for log tests
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 1:03=E2=80=AFPM Ivan Orlov <ivan.orlov0322@gmail.co=
m> wrote:
>
> Since now we are exporting string-stream functions into the KUnit
> namespace, we can safely use them in kunit-test when it is compiled as
> a module as well. So, remove the stubs used when kunit-test is compiled
> as a module. Import the KUnit namespace in the test.
>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Hello!

This seems good to me.

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
> V1 -> V2:
> - No changes
>
>  lib/kunit/kunit-test.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 37e02be1e710..d86f7cb3b3e4 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -577,12 +577,6 @@ static struct kunit_suite kunit_resource_test_suite =
=3D {
>         .test_cases =3D kunit_resource_test_cases,
>  };
>
> -/*
> - * Log tests call string_stream functions, which aren't exported. So onl=
y
> - * build this code if this test is built-in.
> - */
> -#if IS_BUILTIN(CONFIG_KUNIT_TEST)
> -
>  /* This avoids a cast warning if kfree() is passed direct to kunit_add_a=
ction(). */
>  KUNIT_DEFINE_ACTION_WRAPPER(kfree_wrapper, kfree, const void *);
>
> @@ -637,17 +631,6 @@ static void kunit_log_newline_test(struct kunit *tes=
t)
>                 kunit_skip(test, "only useful when debugfs is enabled");
>         }
>  }
> -#else
> -static void kunit_log_test(struct kunit *test)
> -{
> -       kunit_skip(test, "Log tests only run when built-in");
> -}
> -
> -static void kunit_log_newline_test(struct kunit *test)
> -{
> -       kunit_skip(test, "Log tests only run when built-in");
> -}
> -#endif /* IS_BUILTIN(CONFIG_KUNIT_TEST) */
>
>  static struct kunit_case kunit_log_test_cases[] =3D {
>         KUNIT_CASE(kunit_log_test),
> @@ -872,4 +855,5 @@ kunit_test_suites(&kunit_try_catch_test_suite, &kunit=
_resource_test_suite,
>                   &kunit_fault_test_suite);
>
>  MODULE_DESCRIPTION("KUnit test for core test infrastructure");
> +MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING);
>  MODULE_LICENSE("GPL v2");
> --
> 2.34.1
>

