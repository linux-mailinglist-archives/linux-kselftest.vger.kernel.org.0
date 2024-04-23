Return-Path: <linux-kselftest+bounces-8732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C988AF8CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 23:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AE41C228DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 21:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC8143872;
	Tue, 23 Apr 2024 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPiC37X/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B55F142E97
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713906795; cv=none; b=W9WvkGMG4PyOmYNwiV5J1uDj6vYBi1BK05FDtlVg+Gv6wBEwg7Fw3wZNuohq3hUxLjtso3xYFUDdFwUtkhlGkD256AcDaslkaCFnJPrHoqvkf2wBWUpvTk05pKWgLfR3rtXIDWnJuxk2QaGQbSm/grG/p084VZktLLRRfp+whb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713906795; c=relaxed/simple;
	bh=myriipUeoB1/JaZQkm9XDuzk4YU50w6UP6wACK7rMbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDMUdxm4btvNUZNJeX8SsvvEhSrPBAOXKohmTHBtcoZXKgs6ZM8exHlGoJ/f1ZewCjKGbjTTj/Xa/RZAUzpBA8S5kS88N8t5msbHG9H1XLTDcl8txGw9v0I3Iw4x7AjYj3IyD5V4cTEl/yMj91Z5l+uegVRNbw1EO+VQOKY6r9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPiC37X/; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-436ed871225so35621cf.1
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713906792; x=1714511592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9J1SHCnjXki1s8tfPNEpfyniTQlQg6e6yMISySpF958=;
        b=vPiC37X/7mbQcx4t0bJ9bDv+KoQXL82NykU+1qdHjQoDxR2bWngPIfNwuAH4uzYahV
         mVmEjcuLGIuzPh40vrWHitSWxIBNNYmPs12PfHz5RpAVopLsu05K/YU0o7shVTI898vC
         3uzgohy4W9c6swA4D7uHfGXy+T32jdrjiTYC12X1XIg2vNxbf8dmV19+ETymYKKB/o7W
         b/iFNdOyxRQdhvzgBEkM0/PIPXZQpOR6zEwtezE19t7CBigMGWetfv1r0enHEJHELUjc
         O7g+K2wK7DXBtrNXchoi97S4YoJQ3/P/PO0b8gCtSUNLd4PJ43E1xBAWpyIwN4n56iHj
         k31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713906792; x=1714511592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9J1SHCnjXki1s8tfPNEpfyniTQlQg6e6yMISySpF958=;
        b=Y96qY0RFF05yA2o9vY5zbosHWZESWjrUiHOGkS1HKGmgD0yCZ2YDIweD3e4bc4JYhB
         Z9/jpjNgG/u6EmFKEYU8D6S03Sj3EUwcNThvwSow63eAOODgdFUzaJqTbom6q0YP0r15
         Ia+lOMOtFqA0OZAus3xA95yIoHfb6xAOvbfNaquzhnNSvtn7bC5YSGSblzHCIu1ipnu1
         NkUMF7nYDni3aqk+Y6+e5+YDghrP24ynsiucr74qIZNlBVdwyMkJzOSkZR+2PXxQy0lV
         7Dj2/Bu8dnRhEobSHFBM/tU2NBxnkfMWFaCuoti/WgCHuVsJXNM2pLEonroctsYvybKi
         A1Wg==
X-Forwarded-Encrypted: i=1; AJvYcCU2dWLpwYbQi5+SrLnSBhv96ybQjiDYq5G9OH0iPMl/tPl5KgZ4eQ5ze5rKYMCw0RCdDukkq6rQzDFBc0qHbOiC7fmfsVAfrw2tlX6ZJkQ3
X-Gm-Message-State: AOJu0YzWxDNbD0gliJs/maVPDIRlroANwOeLZ0yhomliot3Z4DfB6npR
	O6MtBgb16ws4xjjUeVnWGbw24e9Jq9irSuImyXDmwXJZY9PnxB16wfgkkUv01lRF3TH3uXyLatW
	nPKrWhbfDjrodEjMkj1r+e3+UTtzzthen47+X
X-Google-Smtp-Source: AGHT+IHdKnzSgrPiEJFhwcoSEHOd74I6o6QZI1g2bWQ2ETFQjDsZasweCZwLZNK8Bei7SvSkDePgJ0V+es5FZ3WsMXE=
X-Received: by 2002:ac8:6d0:0:b0:431:8176:e4e5 with SMTP id
 j16-20020ac806d0000000b004318176e4e5mr13491qth.13.1713906792165; Tue, 23 Apr
 2024 14:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423090808.242389-1-davidgow@google.com>
In-Reply-To: <20240423090808.242389-1-davidgow@google.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 23 Apr 2024 17:12:59 -0400
Message-ID: <CA+GJov4SLN-=V0RrqkgwG6WN-DUwcsmtpH-fEzJ4+NyOfaDgow@mail.gmail.com>
Subject: Re: [PATCH] kunit: test: Move fault tests behind KUNIT_FAULT_TEST
 Kconfig option
To: David Gow <davidgow@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 5:08=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> The NULL dereference tests in kunit_fault deliberately trigger a kernel
> BUG(), and therefore print the associated stack trace, even when the
> test passes. This is both annoying (as it bloats the test output), and
> can confuse some test harnesses, which assume any BUG() is a failure.
>
> Allow these tests to be specifically disabled (without disabling all
> of KUnit's other tests), by placing them behind the
> CONFIG_KUNIT_FAULT_TEST Kconfig option. This is enabled by default, but
> can be set to 'n' to disable the test. An empty 'kunit_fault' suite is
> left behind, which will automatically be marked 'skipped'.
>
> As the fault tests already were disabled under UML (as they weren't
> compatible with its fault handling), we can simply adapt those
> conditions, and add a dependency on !UML for our new option.
>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Link: https://lore.kernel.org/all/928249cc-e027-4f7f-b43f-502f99a1ea63@ro=
eck-us.net/
> Fixes: 82b0beff3497 ("kunit: Add tests for fault")
> Signed-off-by: David Gow <davidgow@google.com>

Hello!

This looks good to me. Very useful!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  lib/kunit/Kconfig      | 11 +++++++++++
>  lib/kunit/kunit-test.c |  8 ++++----
>  2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 68a6daec0aef..34d7242d526d 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -24,6 +24,17 @@ config KUNIT_DEBUGFS
>           test suite, which allow users to see results of the last test s=
uite
>           run that occurred.
>
> +config KUNIT_FAULT_TEST
> +       bool "Enable KUnit tests which print BUG stacktraces"
> +       depends on KUNIT_TEST
> +       depends on !UML
> +       default y
> +       help
> +         Enables fault handling tests for the KUnit framework. These tes=
ts may
> +         trigger a kernel BUG(), and the associated stack trace, even wh=
en they
> +         pass. If this conflicts with your test infrastrcture (or is con=
fusing
> +         or annoying), they can be disabled by setting this to N.
> +
>  config KUNIT_TEST
>         tristate "KUnit test for KUnit" if !KUNIT_ALL_TESTS
>         default KUNIT_ALL_TESTS
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index 0fdca5fffaec..e3412e0ca399 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -109,7 +109,7 @@ static struct kunit_suite kunit_try_catch_test_suite =
=3D {
>         .test_cases =3D kunit_try_catch_test_cases,
>  };
>
> -#ifndef CONFIG_UML
> +#if IS_ENABLED(CONFIG_KUNIT_FAULT_TEST)
>
>  static void kunit_test_null_dereference(void *data)
>  {
> @@ -136,12 +136,12 @@ static void kunit_test_fault_null_dereference(struc=
t kunit *test)
>         KUNIT_EXPECT_TRUE(test, ctx->function_called);
>  }
>
> -#endif /* !CONFIG_UML */
> +#endif /* CONFIG_KUNIT_FAULT_TEST */
>
>  static struct kunit_case kunit_fault_test_cases[] =3D {
> -#ifndef CONFIG_UML
> +#if IS_ENABLED(CONFIG_KUNIT_FAULT_TEST)
>         KUNIT_CASE(kunit_test_fault_null_dereference),
> -#endif /* !CONFIG_UML */
> +#endif /* CONFIG_KUNIT_FAULT_TEST */
>         {}
>  };
>
> --
> 2.44.0.769.g3c40516874-goog
>

