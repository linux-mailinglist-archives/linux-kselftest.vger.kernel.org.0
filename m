Return-Path: <linux-kselftest+bounces-20975-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641CE9B4E52
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 16:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A953AB25465
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC472195B1A;
	Tue, 29 Oct 2024 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuToelo6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA9E192D91
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216630; cv=none; b=AFDPoJXBF/XUblCIGQLgSfrr+95+1G3PIikBTsoNq5Z4E8EPL2Nlraavr5wcQuaUN1EnK78oQLwlJFeaEKQEOAqyT7cwaNQ5mDdGe4lrtBgfMtcCSvwLRYsq5nAUbJkP+B6yHu0Dwm1/9XBt4KGSZbSeT876l754jvMgIKcwG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216630; c=relaxed/simple;
	bh=/1y8wy/+8RsNiczZdUc9OTqY+F7kGhxHvR2T0Vw7BaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6P7gl2IFeIMB08LjHgTWjwHpYO4nWg2G+p1o+fPl3xutwxK9QHF1sqF8qwQmIMyIBUsEEPcOvkzs4OPlnyUJq1mv7VAXv+FZRJ4yW5Tmz9LcyBgvdPOV0gb4galmBn8ZJJsGLUq7ISYgmShdTPgYDiqvyPT3mCgchGRRZiWt2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TuToelo6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e983487a1so4135648b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730216628; x=1730821428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dNrBCtbdWT9WqWi/UcHw/O+xVwFE+xizukhtenAkdnc=;
        b=TuToelo6xLMi1xGZkF9QBftqsihqwPYtcb41TJkfAabHFMfHTVGLEMadwlRq4BsO2B
         3BKCZKuVqP1QH05ABfCd1Y51XSli9pyszR5M8MmjK79oSduxiObLC+ayZXa+6iwPxHfo
         tt5qgAWn8pPycEb2pFv6otqb9tUt7utGioqKJNTcUQ0RRz1kws3fdJLUR7n/VaM2pbo5
         6WX9ste3rNgFW0O2n0WT/U3NB4d4EtuGXqvLFNFKq8UeMUwrniAMnahSKvYexle6lPpU
         jPmy7GktNMQJatrwuD3bLri3ewq4WFOHj9XIO8qDFRUI5Lq2mNi5M04Zb6CKfbYAwvsL
         Koxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216628; x=1730821428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNrBCtbdWT9WqWi/UcHw/O+xVwFE+xizukhtenAkdnc=;
        b=N0kyXLuXo0XT7ITwZzsMJ0mcoZNjjumhAyile9X2yGrIhXk2wyeCwR1/HJ8D0bS+TS
         twYEp1wBOGuaRfHYMSYeDMIO9YqpKMzs5Szuydr03t4pOxMviIK0bsiGLh3QlHGSmrWf
         8Ie+q0vhlNATRiS79O2iNiO6q7nYCqgWhVYumXMnUt0vAqKEkxASEnFW/ArR5I6MU26/
         s9W23xrb5n7SBijQy1RpbAQmujDFkag+dzC4RDYUMGJcAuRfMxqrQv4tpTel9eimTtv8
         LNdMj/rQHC9IKIUPlDpsz7jKChWRCipF45Z1hvjnifwqEDbLenbqaVv9zr7YcB3wm+CK
         tYng==
X-Forwarded-Encrypted: i=1; AJvYcCXfd+i3jt14ObysczyugTnWEAFIiOUcQ66r7UzlyIHBAEPlGSvsDEgXdZ7iuxRyCdXiThGi4dFlpzCEKYjKTjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhCrSVY7T7vQiFDM6oxGwHzKm3lkz5wjNaNdQXQn9Syl5lOq1y
	o4Dx+qb8O/lhttjMl1kZ1D06zXTAeWyRD39JX6JuhUvB81FnGXYcIlgB6Kqj2QnoHKOVH2ByQCf
	38XfBibePLz/sQ5Qd3bwUEgeoilJA77lkD8Uu
X-Google-Smtp-Source: AGHT+IHuHITAnMQg/vpdknOyzHnFC9zzfu+BGV4bB0VUAyKolP0v/4oWZlpvxVXw/wpnxXnUu3vpjZkmmJ7+SFaBR40=
X-Received: by 2002:a05:6a20:d74d:b0:1d9:cc2:2c00 with SMTP id
 adf61e73a8af0-1d9a83c9ff4mr16244776637.14.1730216627412; Tue, 29 Oct 2024
 08:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173015245931.4747.16419517391658830640.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <173015245931.4747.16419517391658830640.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Rae Moar <rmoar@google.com>
Date: Tue, 29 Oct 2024 11:43:35 -0400
Message-ID: <CA+GJov7YB9b3nA0rUexZ=2gU5h49mCuJuZ-gRFkqppSwDPimxA@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Introduce autorun option
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: brendan.higgins@linux.dev, davidgow@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:54=E2=80=AFPM Stanislav Kinsburskii
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

Hello,

This looks good to me!

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

> ---
>  include/kunit/test.h |    4 +++-
>  lib/kunit/Kconfig    |   12 ++++++++++++
>  lib/kunit/debugfs.c  |    2 +-
>  lib/kunit/executor.c |   21 +++++++++++++++++++--
>  lib/kunit/test.c     |    6 ++++--
>  5 files changed, 39 insertions(+), 6 deletions(-)
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
> index 34b7b6833df3..3f39955cb0f1 100644
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
> @@ -260,13 +276,14 @@ kunit_filter_suites(const struct kunit_suite_set *s=
uite_set,
>  void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builti=
n)
>  {
>         size_t num_suites =3D suite_set->end - suite_set->start;
> +       bool autorun =3D kunit_autorun();
>
> -       if (builtin || num_suites) {
> +       if (autorun && (builtin || num_suites)) {
>                 pr_info("KTAP version 1\n");
>                 pr_info("1..%zu\n", num_suites);
>         }
>
> -       __kunit_test_suites_init(suite_set->start, num_suites);
> +       __kunit_test_suites_init(suite_set->start, num_suites, autorun);
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
> To view this discussion visit https://groups.google.com/d/msgid/kunit-dev=
/173015245931.4747.16419517391658830640.stgit%40skinsburskii-cloud-desktop.=
internal.cloudapp.net.

