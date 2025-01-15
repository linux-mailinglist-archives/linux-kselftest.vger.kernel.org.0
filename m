Return-Path: <linux-kselftest+bounces-24552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0F6A11A16
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 07:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A788F1881B89
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 06:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BBE1D5ACF;
	Wed, 15 Jan 2025 06:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XnFrdri"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E765223
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736923872; cv=none; b=FKh6nrSKEjKgc7A0iJ7QgwdbaU8V8YnytHKOpQaENcKIB/ecwu3bd46hJCQ3zhIeO/6FmTZrZe2f5n7aadGzLZ6VRG+XRmjyv2Vok9+IdvPH1oWF8dmHga3/j/gS0qD1/nSyVrnKWpZPTAzYDOKLEkuL8i2tIBlEVH1+YObgW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736923872; c=relaxed/simple;
	bh=6djwiMmntO7OTLHPpyAIxvlCsrhbUXTL0aEUrWjCNT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KDT/mdP5BjNjLLupcObVSVB4kB4J9Uk5oHFpsqq8VUnOMWHafZz8Q/QqVPQHOXpYc1RbornJrEbPYMY+/HkY4Sl5Lfwjvc/UbPRDy1mJBUGVOFNxAyDUUMSKHCdihg+Hje70Fi0MY7xGOxoLuV8mgNGpFAAroayzmA0XwXiYohY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XnFrdri; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6eb531e13so359958185a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 22:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736923870; x=1737528670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NJFpF1bOlD9CsMRtKqdr9Fxxvzwr89+k226GVF9IcrQ=;
        b=3XnFrdriJjAU/idiebVEquRlj/X+9/pHzOJLUytFCoIImZ852QoMs09Um3owsHEnBx
         rENZQWo2UviqsYF4rVFJQ7brA4lpJJ/4rZpVCdY4+C5Jgz/ekIqUSTPtVvcEXv1ATaLI
         3IiI/kjO9mRdBJ5EQHJvu1XzgNKn5f+i6Ds2lCCjDmSBCbWnj2EGDZ7WjTA0HjPZ5Eb6
         SqSIEfcIMAV6I3RO5B6ryJabncj1TpM+Ui7ksxRqHG+CsFIsBkee8mfFJf6+CHkpIocN
         qtA9eyxpgNPIv+yUyAkUcECyDurU8w0aJ9ECcaL9J6V9fDF8MN3Edep8Dc2pUKs6pPB9
         q5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736923870; x=1737528670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJFpF1bOlD9CsMRtKqdr9Fxxvzwr89+k226GVF9IcrQ=;
        b=IE2U2G1L3eun+suUfpmmDfZYI1jwcMax8isgZ2u+lL5/AUyV27rPciBWFNG09wDJbh
         ixdO9ubw4ySMmW3IYdEuwI6C11WrL805JXKfXzsHmw/wWpyX+T7+dTAQ5/+tfc6DDMVu
         7ZuOUiI5S2VfCf9puA1MBya2ZFZmIM8hP4sEtmrd09zUvyCTaZaDy1eMwfFSSImGcqgn
         P0Y+hjkaTRlJAvcaaQsfxz+ntvasyPn44ApcX1lc8jtBjGzxTb654KQQtfa7TPNPC7FU
         cWbjCBzZX8Nz+DZwDlQbw7zQdDhlEaQg5cH4kcs9dhOCcEwEmEbGWuk7pqtwKihr4wML
         5NQg==
X-Forwarded-Encrypted: i=1; AJvYcCV/Y81YgHuriFlT0vq9JTlz0MRx5hmDJKEE4q+v5HQve/vJfpmbm+Y0V5tzQupYmaDv0Ok429+4tOzMsfRAElQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPP5+t4/x4khZDuUR5FQNDHHH+bPJWmrLWRbe4HGF0O6W8iiK6
	Yvoq4qO2xoPO69qqaLVUa/i+fcjrTyn861R/o5ytq0DFkxRAqrR277x4+7uyuR+A3Mh4XvINQdS
	TJYsogPzWIqr9qq/M7UXncf8jBfzzUlEXwhwR
X-Gm-Gg: ASbGncsT1p+nwOcLEateoNgRML7Ov4xiVF8YqjsAc7GSkI3y/EyQFYlgWORs5//CvxZ
	BbV70wFyb/CXmRhd0Xx5MJUwenvdB2frD9H0Bx58=
X-Google-Smtp-Source: AGHT+IHVUg24TssCZM7uLqYH14KOubamje0JqfLocgrdu+wo8HMRQPSxDxZgJS6RQzQursjU0ZTOkWmQRClSDkYxVjU=
X-Received: by 2002:a05:6214:5e10:b0:6e1:9126:4d14 with SMTP id
 6a1803df08f44-6e1912650c2mr30028316d6.11.1736923869693; Tue, 14 Jan 2025
 22:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173015245931.4747.16419517391658830640.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <173015245931.4747.16419517391658830640.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: David Gow <davidgow@google.com>
Date: Wed, 15 Jan 2025 14:50:57 +0800
X-Gm-Features: AbW1kvbPdwjDM4BjQUu8BbmwTSvSVigIKxw_kUK6CPgdfi0XmVhNqb9QCHxoCTw
Message-ID: <CABVgOSnV90-oMbNJM_XZokJQBfhm5+FbLKH=7N-n+E6Kt=hrpQ@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: Introduce autorun option
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: brendan.higgins@linux.dev, rmoar@google.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000047e8ea062bb91af8"

--00000000000047e8ea062bb91af8
Content-Type: text/plain; charset="UTF-8"

On Tue, 29 Oct 2024 at 05:54, Stanislav Kinsburskii
<skinsburskii@linux.microsoft.com> wrote:
>
> The new option controls tests run on boot or module load. With the new
> debugfs "run" dentry allowing to run tests on demand, an ability to disable
> automatic tests run becomes a useful option in case of intrusive tests.
>
> The option is set to true by default to preserve the existent behavior. It
> can be overridden by either the corresponding module option or by the
> corresponding config build option.
>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---

Thanks very much -- this is a feature we've wanted for a long time.

Acked-by: David Gow <davidgow@google.com>

Cheers,
-- David

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
> @@ -312,6 +312,7 @@ static inline void kunit_set_failure(struct kunit *test)
>  }
>
>  bool kunit_enabled(void);
> +bool kunit_autorun(void);
>  const char *kunit_action(void);
>  const char *kunit_filter_glob(void);
>  char *kunit_filter(void);
> @@ -334,7 +335,8 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>                     int *err);
>  void kunit_free_suite_set(struct kunit_suite_set suite_set);
>
> -int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites);
> +int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites,
> +                            bool run_tests);
>
>  void __kunit_test_suites_exit(struct kunit_suite **suites, int num_suites);
>
> diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
> index 34d7242d526d..a97897edd964 100644
> --- a/lib/kunit/Kconfig
> +++ b/lib/kunit/Kconfig
> @@ -81,4 +81,16 @@ config KUNIT_DEFAULT_ENABLED
>           In most cases this should be left as Y. Only if additional opt-in
>           behavior is needed should this be set to N.
>
> +config KUNIT_AUTORUN_ENABLED
> +       bool "Default value of kunit.autorun"
> +       default y
> +       help
> +         Sets the default value of kunit.autorun. If set to N then KUnit
> +         tests will not run after initialization unless kunit.autorun=1 is
> +         passed to the kernel command line. The test can still be run manually
> +         via debugfs interface.
> +
> +         In most cases this should be left as Y. Only if additional opt-in
> +         behavior is needed should this be set to N.
> +
>  endif # KUNIT
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index d548750a325a..9df064f40d98 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -145,7 +145,7 @@ static ssize_t debugfs_run(struct file *file,
>         struct inode *f_inode = file->f_inode;
>         struct kunit_suite *suite = (struct kunit_suite *) f_inode->i_private;
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
> +static bool autorun_param = true;
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
> @@ -260,13 +276,14 @@ kunit_filter_suites(const struct kunit_suite_set *suite_set,
>  void kunit_exec_run_tests(struct kunit_suite_set *suite_set, bool builtin)
>  {
>         size_t num_suites = suite_set->end - suite_set->start;
> +       bool autorun = kunit_autorun();
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
>  void kunit_exec_list_tests(struct kunit_suite_set *suite_set, bool include_attr)
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 089c832e3cdb..146d1b48a096 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -708,7 +708,8 @@ bool kunit_enabled(void)
>         return enable_param;
>  }
>
> -int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites)
> +int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_suites,
> +                            bool run_tests)
>  {
>         unsigned int i;
>
> @@ -731,7 +732,8 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
>
>         for (i = 0; i < num_suites; i++) {
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
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kunit-dev/173015245931.4747.16419517391658830640.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net.

--00000000000047e8ea062bb91af8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgtwNy8Vf/U49LHlm6zuGF+W1Jpg7o
XKN5q41l/cv2lUIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MTE1MDY1MTEwWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAKYRpdWRxVzjOawjQPZr8QAZwfayhpDmwGh8KFQ9XNyXWP9Z
3W3XUtpfJ7Pey8R1vFzDWgBXu91FOUZUG25k8Hsgo1FK56V/OCjZM0Vy9QDLSbNHx6mCvBPfYnFG
e+TVgNzTSIteiJo2FN2ZS3DdJcw8jRm/hnu0zHzUJBcUra5kWUifzCAhR80TQE03DMJL2oGD1qMf
hi+JofK8g/8VVS8TAhzbQFyNl249tNEosSNwwgS23hu9WbbiCHhvVxJUK7sB3Tb9WMRoDnKYOzLk
EdZBYGL0fbDdnJnrC976+4T7grZKOsemG8rukovEgmc524HXxZOBZm59PJz6mUiUDHA=
--00000000000047e8ea062bb91af8--

