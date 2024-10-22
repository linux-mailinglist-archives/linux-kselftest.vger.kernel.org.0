Return-Path: <linux-kselftest+bounces-20425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1169AB852
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 23:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD3628496E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE0F1BDA95;
	Tue, 22 Oct 2024 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1AENrhU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC6E153565
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631806; cv=none; b=c3TQfmoR74IW8IZcVmGQuzmKvn5/0mXLu8w+OJuOs3o44mPNYMazMuKfNNfVV7FDjGMWcykAhJR4QPaxLzeizcKmwfg1uISa/iB3rjVNEpiGHu5LzdpoAWvAdvzCJ0My3dZcJMtBizmVHPNqYLnFl2j4gtk4SbvtDrU7cask9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631806; c=relaxed/simple;
	bh=c6n0gWbvqw7oAddRF2Ek6T7PRom7ya1+ouXjjqO0yRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brOIfLtVDepSdFMJHyUWLOwVuVzpR67q5NxVNWO6AZoGlRsSzgk5jXCRFEhwoemgTQeIGSXNWFVmjAHiVv8f8tzoqWaw1jx1zleEg0GBWjiiVBX5JeiSiuI/nsy/UCd5QwdW+tEgKD4SV66EvBP8Gq6PYdQDQojAO5ZR0jsrhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1AENrhU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2cc47f1d7so184911a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 14:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729631804; x=1730236604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2yWqm8AWRnPf2GnNAOnZK8arNwZlIGQowX3/ant1gA=;
        b=V1AENrhUH5D6oem3ATiohlmAoLHC9Xp5HzKYhOvUKUICeMz5dinACfrY6TZtaiojPH
         ISCTnb2x3oApvq1e8sDLfowIDU5uayoGPVcntHL4VbfazcYrsdQaTWK1BQDj0d4cRz2O
         BMYKsmYvOkwdTOWibHnCetvaTye1BW1oYLEmaDxr7eE6e15QvPKiCUjEtjO3CSV22DEY
         4FH4T3gwYaiclN8ueEcKAd7PQRSc/mztS8jgjt0dX+JKoqebdTynvCorBvNaxLFliO/n
         p4nlWORbTdN1WGBrf80rlzOmWAa4ETFpSCj74rYNNS+tJgVxtVGLB5RU5SznNmM0WfG1
         sUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631804; x=1730236604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2yWqm8AWRnPf2GnNAOnZK8arNwZlIGQowX3/ant1gA=;
        b=aom3AFiHy9Mk/msjN7WLaLF1yJRsats6ho0pPPXuEfdRVr8lL5E9p82EgdWW74WNrt
         WR6tTPMZsTaKQ03NkjEViuFBtM7IXroKQFucRxhzCEzHXY44znouemGnut9Wa0vpM/Xm
         jyoDRGRJUd/nXeDXtgFFXHtNmsH7hZQfyfaW6soCIIszkfAK6OB0u3rdNmgucNcic5Gc
         J3KcrZS4C+66i9IpcLFbiRd4XfxnoYYYcn1Irlx0V6+Z9Jbz9z7X9QU8LP/Rav4fcEV2
         aCYkLDP5dmsh8WmIT4Q/0HVkxPTwUq1q+MClbiNgHEBJcTQtXjHRY5MvtK4wFF/2s83k
         gAlw==
X-Forwarded-Encrypted: i=1; AJvYcCXl32UegzVC/jNZm7FrqFrsyH91GKsG6x1uVr9GQheJtpbM0fS95+uNHTxEeShslz6rEN3KaHmtoxJ6Ueteijk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWiAYa0kucmRFFMTZrTYFUJD3Eo/6logsxvS4ucXuABhHcPaki
	+x6W/+055uNHdzRGED+d/RlbKNOmod2s+FeWID6fcpf1XaYB1xSkAT51ghYcUTqFQLC7MThC/1Q
	gMu7xS+hJV/GPJ8pdcJRSNiMnwFEilg+c5lJZ
X-Google-Smtp-Source: AGHT+IH6IlqYAW005LeUD186a2cIqciZIMo7JqQ6nFckAGmNU4SoG3dW3HRcZe2XPh7GaowHYN67S0kpXaedR0hpYJ8=
X-Received: by 2002:a17:90b:4b0d:b0:2e2:878a:fc6 with SMTP id
 98e67ed59e1d1-2e5dbaeb69dmr7000590a91.18.1729631804210; Tue, 22 Oct 2024
 14:16:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172920085854.4578.9203147717033046574.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <172920085854.4578.9203147717033046574.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 22 Oct 2024 17:16:31 -0400
Message-ID: <CA+GJov4Kfo5EwjXRe8vufhMetsYzHG7bJS6VERaE8+1rNL69Vg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Introduce autorun option
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 5:34=E2=80=AFPM Stanislav Kinsburskii
<skinsburskii@linux.microsoft.com> wrote:
>
> The new option controls tests run on boot or module load. With the new
> debugfs "run" dentry allowing to run tests on demand, an ability to disab=
le
> automatic tests run becomes a useful option in case of intrusive tests.
>
> The option is set to true by default to preserve the existent behavior. I=
t
> can be overridden by either the corresponding module option or by the
> corresponding config build option.
>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Hello!

This patch looks good to me! The functionality seems to be working
well. I do have one comment below.

Thanks!
-Rae

> ---
>  include/kunit/test.h |    4 +++-
>  lib/kunit/Kconfig    |   12 ++++++++++++
>  lib/kunit/debugfs.c  |    2 +-
>  lib/kunit/executor.c |   18 +++++++++++++++++-
>  lib/kunit/test.c     |    6 ++++--
>  5 files changed, 37 insertions(+), 5 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 34b71e42fb10..58dbab60f853 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -312,6 +312,7 @@ static inline void kunit_set_failure(struct kunit *te=
st)
>  }
>
>  bool kunit_enabled(void);
> +bool kunit_autorun(void);
>  const char *kunit_action(void);
>  const char *kunit_filter_glob(void);
>  char *kunit_filter(void);
> @@ -334,7 +335,8 @@ kunit_filter_suites(const struct kunit_suite_set *sui=
te_set,
>                     int *err);
>  void kunit_free_suite_set(struct kunit_suite_set suite_set);
>
> -int __kunit_test_suites_init(struct kunit_suite * const * const suites, =
int num_suites);
> +int __kunit_test_suites_init(struct kunit_suite * const * const suites, =
int num_suites,
> +                            bool run_tests);
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suite=
s);
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 34d7242d526d..a97897edd964 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -81,4 +81,16 @@ config KUNIT_DEFAULT_ENABLED
>           In most cases this should be left as Y. Only if additional opt-=
in
>           behavior is needed should this be set to N.
>
> +config KUNIT_AUTORUN_ENABLED
> +       bool "Default value of kunit.autorun"
> +       default y
> +       help
> +         Sets the default value of kunit.autorun. If set to N then KUnit
> +         tests will not run after initialization unless kunit.autorun=3D=
1 is
> +         passed to the kernel command line. The test can still be run ma=
nually
> +         via debugfs interface.
> +
> +         In most cases this should be left as Y. Only if additional opt-=
in
> +         behavior is needed should this be set to N.
> +
>  endif # KUNIT
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index d548750a325a..9df064f40d98 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -145,7 +145,7 @@ static ssize_t debugfs_run(struct file *file,
>         struct inode *f_inode =3D file->f_inode;
>         struct kunit_suite *suite =3D (struct kunit_suite *) f_inode->i_p=
rivate;
>
> -       __kunit_test_suites_init(&suite, 1);
> +       __kunit_test_suites_init(&suite, 1, true);
>
>         return count;
>  }
> diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
> index 34b7b6833df3..340723571b0f 100644
> --- a/lib/kunit/executor.c
> +++ b/lib/kunit/executor.c
> @@ -29,6 +29,22 @@ const char *kunit_action(void)
>         return action_param;
>  }
>
> +/*
> + * Run KUnit tests after initialization
> + */
> +#ifdef CONFIG_KUNIT_AUTORUN_ENABLED
> +static bool autorun_param =3D true;
> +#else
> +static bool autorun_param;
> +#endif
> +module_param_named(autorun, autorun_param, bool, 0);
> +MODULE_PARM_DESC(autorun, "Run KUnit tests after initialization");
> +
> +bool kunit_autorun(void)
> +{
> +       return autorun_param;
> +}
> +
>  static char *filter_glob_param;
>  static char *filter_param;
>  static char *filter_action_param;
> @@ -266,7 +282,7 @@ void kunit_exec_run_tests(struct kunit_suite_set *sui=
te_set, bool builtin)
>                 pr_info("1..%zu\n", num_suites);

When using this feature, I still see some KTAP output that are printed
from this function (kunit_exec_run_tests). I think it would be great
if we could remove this output as to not clutter the kernel log.

At first, I was confused as to why we needed to call this function and
initialize the tests but I realized the debugfs suites need to be
created.

So instead, could we check for kunit_autorun() here instead as a
condition before printing the output?

>         }
>
> -       __kunit_test_suites_init(suite_set->start, num_suites);
> +       __kunit_test_suites_init(suite_set->start, num_suites, kunit_auto=
run());
>  }
>
>  void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool inclu=
de_attr)
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 089c832e3cdb..146d1b48a096 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -708,7 +708,8 @@ bool kunit_enabled(void)
>         return enable_param;
>  }
>
> -int __kunit_test_suites_init(struct kunit_suite * const * const suites, =
int num_suites)
> +int __kunit_test_suites_init(struct kunit_suite * const * const suites, =
int num_suites,
> +                            bool run_tests)
>  {
>         unsigned int i;
>
> @@ -731,7 +732,8 @@ int __kunit_test_suites_init(struct kunit_suite * con=
st * const suites, int num_
>
>         for (i =3D 0; i < num_suites; i++) {
>                 kunit_init_suite(suites[i]);
> -               kunit_run_tests(suites[i]);
> +               if (run_tests)
> +                       kunit_run_tests(suites[i]);
>         }
>
>         static_branch_dec(&kunit_running);
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/172920085854.4578.9203147717033046574.stgit%40skinsburskii-clou=
d-desktop.internal.cloudapp.net.

