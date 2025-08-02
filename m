Return-Path: <linux-kselftest+bounces-38210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB50B18DCA
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 11:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5687B9AA4
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Aug 2025 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D8212FA0;
	Sat,  2 Aug 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj/CkPdd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C2F20298E
	for <linux-kselftest@vger.kernel.org>; Sat,  2 Aug 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754127896; cv=none; b=SP4CMV/83Hopyj7yaTHoAAiKNhy0aoCvCkr7/elZA127rut8k6z/RnoDmyHxu8VjwdDb4mannRp8cXHTne/5RgmLydbUbLcP36Vb1VorRerz/WmqIjrRH9thX95oQ6hEpmL8FIBln6HA3s2bg6foIwbj6L+bu7E3hQonFgEuvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754127896; c=relaxed/simple;
	bh=3acCYIlwAEPf2CksrwqZd9+8XJ3afNpbh1oYHaGzrgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+lYqqO77BFyl/pPJ2y/XqweVNnAlntHoSNtNa1Wf3sQg8ypiNBkIRJ4rKOUB8zsph8gH1WV3pvJV+KCsXnBxx4UDuY6yOidxP98F00tepZFshnBFUpNsm0ocGJmCjN73StCoJulty7GWR2KcWinYNn1lvD87oX56Ro8+9W4KNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mj/CkPdd; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-707389a2fe3so28599726d6.2
        for <linux-kselftest@vger.kernel.org>; Sat, 02 Aug 2025 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754127892; x=1754732692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YyVGV8fbe02/OYrAYYhvMpUpUnehXbYnNQKla7xamNo=;
        b=mj/CkPdd/N/FkWeRiRAPW1gB/M2/BKtsFIa5+zReYug6q4+5nAUSVbK39hG3EmhLV3
         EboywzvmbyCN6oGICD8c6jgQAnBiCvqM4V1tKMD4gXuq4Pu+YLOvPGFljm46PoA1UyDp
         VYETpXXgXvggN8qOT9A1+lF1aWxreAW+xaYAhW0uoULrQPoxj/6OxAWY5q8SFtUhNjum
         ec4UCvPlxiLjLyhbyW+0vYUIj6EnnItZIIVCZ/ZruDRGreQRYGuNN91Z3FrxhZN7Pb1d
         xp3lP+52otZp0YMaAdo2MB8rCfKTcmav/LdndekaPZwXxHMf0HgBLtRa7xJOtFB1VBeT
         0cyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754127892; x=1754732692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyVGV8fbe02/OYrAYYhvMpUpUnehXbYnNQKla7xamNo=;
        b=bi1OoN/e+KFYFIxJ+3nWR13TVhdxgLq1lsORAZXWOoOauUcvJqajUZbfZo1AdJclDZ
         40OdnLj6/z1hlITYMIkeTec1HPkGc8NZl/qTO3oLpS3cKtPKyUhB+UUhhgWSGa4voZRY
         vhruXqDsjkvd098zdaoFF6ThoH4hKEjCV0CrZLN49sNxdf1iBDRBtpS+G611f078kuR1
         orsnStWL08VvLfoFxuqq0rxqqcEhgnFIYnU8IjOkUuof1L8CAVnxiRaUa7nkVuLOAzYS
         SGtQ/AIynUJ6j8natzMGYdpLfQZxYZxliIchbxlTzpemHpewxKBS/HgIj8UMsUai+7TZ
         3dmA==
X-Forwarded-Encrypted: i=1; AJvYcCXzgKGjWlZ+NCmLItCimtB0rgCq5GFgvv4X5RM4SR5SsGZTTm5lNvihjjfuhIeobWybEhaqLZs2r3yIHJPgKYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75mA3IgAMLYaaz2omdah/XkXAXXG28WFaxpozsNlKc2EecrgC
	A3OXtgKDcvTf46fHFN0JwcDyPmD6xhNd2ufpLXTEqHFkUTtMp89+Jrant6Uw3rAANM2PS97XUsI
	00q3XgGxLA2gPO+vE+T6AzKdgaCmKfKT0pia+ymPH
X-Gm-Gg: ASbGncvF2yT4kHbDZLENWu3owILeHqBakFrcNwHUUCG8AhMg4qanIS009l+B1E5+lPd
	P6I7ooP42cfIrgrqvWI9YS1GcplnM+SNbQrOmuiSyMmzRhFx7/2MY4IxeUnGDDzX6BJlzzcn4Gg
	ChI4RYYIf//hstAVaPn9TkZa0gHkyOTtaHR3bmsJX35MrpTBFUEksasTlW2HhQjzmlVMalWmWJJ
	XUofAjI
X-Google-Smtp-Source: AGHT+IHq1VkHhYPf/TlrvntLw51Da+ZM5l9Klm/OXeDv/ePAaNqOW2PBZIE7xeZURZTBR0Ae+i3vu92sPihk+DrTDmo=
X-Received: by 2002:a05:6214:2a4c:b0:707:4229:6e8c with SMTP id
 6a1803df08f44-70935f7681dmr45877396d6.12.1754127892104; Sat, 02 Aug 2025
 02:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729193647.3410634-1-marievic@google.com> <20250729193647.3410634-3-marievic@google.com>
In-Reply-To: <20250729193647.3410634-3-marievic@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 2 Aug 2025 17:44:39 +0800
X-Gm-Features: Ac12FXzXfGgkKw84HTUHTA1VpjNWzhFIir87zpRY1R2N1G6lbLlU-1K1xKejtKg
Message-ID: <CABVgOS=6kNCrFZXC2RZGBSb0QNng++kNjEtLr++rS+O+Txd_+w@mail.gmail.com>
Subject: Re: [PATCH 2/9] kunit: Introduce param_init/exit for parameterized
 test shared context management
To: Marie Zhussupova <marievic@google.com>
Cc: rmoar@google.com, shuah@kernel.org, brendan.higgins@linux.dev, 
	elver@google.com, dvyukov@google.com, lucas.demarchi@intel.com, 
	thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	kasan-dev@googlegroups.com, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000f12cb5063b5eb9c5"

--000000000000f12cb5063b5eb9c5
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 03:37, Marie Zhussupova <marievic@google.com> wrote:
>
> Add `param_init` and `param_exit` function pointers to
> `struct kunit_case`. Users will be able to set them
> via the new `KUNIT_CASE_PARAM_WITH_INIT` macro.
>
> These functions are invoked by kunit_run_tests() once before
> and once after the entire parameterized test series, respectively.
> They will receive the parent kunit test instance, allowing users
> to register and manage shared resources. Resources added to this
> parent kunit test will be accessible to all individual parameterized
> tests, facilitating init and exit for shared state.
>
> Signed-off-by: Marie Zhussupova <marievic@google.com>
> ---

Thanks: this looks good to me, modulo the issues below (particularly
the Rust breakage).

I was initially unsure of the names 'param_init' and 'param_exit',
preferring just 'init'/'exit', but have since come to like it, as
otherwise it'd be easy to confuse it with the kunit_suite init/exit
functions, which behave differently. So happy to keep that.

With the Rust issue fixes, this is:
Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  include/kunit/test.h | 33 ++++++++++++++++++++++++++++++++-
>  lib/kunit/test.c     | 23 ++++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index a42d0c8cb985..d8dac7efd745 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -92,6 +92,8 @@ struct kunit_attributes {
>   * @name:     the name of the test case.
>   * @generate_params: the generator function for parameterized tests.
>   * @attr:     the attributes associated with the test
> + * @param_init: The init function to run before parameterized tests.
> + * @param_exit: The exit function to run after parameterized tests.
>   *
>   * A test case is a function with the signature,
>   * ``void (*)(struct kunit *)``
> @@ -129,6 +131,13 @@ struct kunit_case {
>         const void* (*generate_params)(const void *prev, char *desc);
>         struct kunit_attributes attr;
>
> +       /*
> +        * Optional user-defined functions: one to register shared resources once
> +        * before the parameterized test series, and another to release them after.
> +        */
> +       int (*param_init)(struct kunit *test);
> +       void (*param_exit)(struct kunit *test);
> +

As noted by the test robot, these need to be initialised in
rust/kernel/kunit.rs when a kunit_case is being set up. Since
parameterised tests aren't used in Rust, they can just be set to None.

>         /* private: internal use only. */
>         enum kunit_status status;
>         char *module_name;
> @@ -218,6 +227,27 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>                   .generate_params = gen_params,                                \
>                   .attr = attributes, .module_name = KBUILD_MODNAME}
>
> +/**
> + * KUNIT_CASE_PARAM_WITH_INIT() - Define a parameterized KUnit test case with custom
> + * init and exit functions.
> + * @test_name: The function implementing the test case.
> + * @gen_params: The function to generate parameters for the test case.
> + * @init: The init function to run before parameterized tests.
> + * @exit: The exit function to run after parameterized tests.
> + *
> + * Provides the option to register init and exit functions that take in the
> + * parent of the parameterized tests and run once before and once after the
> + * parameterized test series. The init function can be used to add any resources
> + * to share between the parameterized tests or to pass parameter arrays. The
> + * exit function can be used to clean up any resources that are not managed by
> + * the test.
> + */
> +#define KUNIT_CASE_PARAM_WITH_INIT(test_name, gen_params, init, exit)          \
> +               { .run_case = test_name, .name = #test_name,                    \
> +                 .generate_params = gen_params,                                \
> +                 .param_init = init, .param_exit = exit,                       \
> +                 .module_name = KBUILD_MODNAME}
> +
>  /**
>   * struct kunit_suite - describes a related collection of &struct kunit_case
>   *
> @@ -269,7 +299,8 @@ struct kunit_suite_set {
>   * @priv: for user to store arbitrary data. Commonly used to pass data
>   *       created in the init function (see &struct kunit_suite).
>   * @parent: for user to store data that they want to shared across
> - *         parameterized tests.
> + *         parameterized tests. Typically, the data is provided in
> + *         the param_init function (see &struct kunit_case).
>   *
>   * Used to store information about the current context under which the test
>   * is running. Most of this data is private and should only be accessed
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index 4d6a39eb2c80..d80b5990d85d 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -641,6 +641,19 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
>         total->total += add.total;
>  }
>
> +static void __kunit_init_parent_test(struct kunit_case *test_case, struct kunit *test)

There's no fundamental reason this needs to start '__': other internal
functions here don't.

(But please keep it static and internal.)

> +{
> +       if (test_case->param_init) {
> +               int err = test_case->param_init(test);
> +
> +               if (err) {
> +                       kunit_err(test_case, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
> +                               "# failed to initialize parent parameter test.");
> +                       test_case->status = KUNIT_FAILURE;
> +               }
> +       }
> +}
> +
>  int kunit_run_tests(struct kunit_suite *suite)
>  {
>         char param_desc[KUNIT_PARAM_DESC_SIZE];
> @@ -668,6 +681,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 struct kunit_result_stats param_stats = { 0 };
>
>                 kunit_init_test(&test, test_case->name, test_case->log);
> +               __kunit_init_parent_test(test_case, &test);
> +
>                 if (test_case->status == KUNIT_SKIPPED) {
>                         /* Test marked as skip */
>                         test.status = KUNIT_SKIPPED;
> @@ -677,7 +692,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                         test_case->status = KUNIT_SKIPPED;
>                         kunit_run_case_catch_errors(suite, test_case, &test);
>                         kunit_update_stats(&param_stats, test.status);
> -               } else {
> +               } else if (test_case->status != KUNIT_FAILURE) {
>                         /* Get initial param. */
>                         param_desc[0] = '\0';
>                         /* TODO: Make generate_params try-catch */
> @@ -727,6 +742,12 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_update_stats(&suite_stats, test_case->status);
>                 kunit_accumulate_stats(&total_stats, param_stats);
> +               /*
> +                * TODO: Put into a try catch. Since we don't need suite->exit
> +                * for it we can't reuse kunit_try_run_cleanup for this yet.
> +                */
> +               if (test_case->param_exit)
> +                       test_case->param_exit(&test);

Not thrilled that this is introducing another TODO here, but since we
already have a number of places around parameterised tests where we're
not running things from the separate try-catch thread, I don't think
we should hold up useful features on it. The actual test code is still
properly handled.

But I'm looking forward to going through and cleaning all of these up
at some point.


>                 /* TODO: Put this kunit_cleanup into a try-catch. */
>                 kunit_cleanup(&test);
>         }
> --
> 2.50.1.552.g942d659e1b-goog
>

--000000000000f12cb5063b5eb9c5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgJYINxxie/13U5jFi7vMOJrN1B+jz
qsl6IBheTGriGFMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
ODAyMDk0NDUyWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAJBBWiTpZp591aYHuf1phoJoSMxSuXByUlal1YaJJz57zWxZXjhWWZ6CzEjTZDXm0
asU9ZFf1Ocki7XH2Xrv+6QU6mDCz7UrDjV4EaJNVOrj6hEb1zO25iBBFdO+/ZepAdethv2lF3Q+m
2uY1fHVNjU2QxuarQOjZSx4PMEQKnapCSElxH2cXLlYmhf5LeI9rjM2ye9AOsXMr6OT/MsKRo5i2
W7UxisSIUkzysRXE/IacxRg8wLzrckqMJyT4YwV5vxuZNmgVVj3aKKKUXMwXxUmKWsXrQ4movkEm
I4eQ5HU3+ZnlXLOaA+BAyUATTI2ZpKgcBO87BSmjnP7F+jb6qw==
--000000000000f12cb5063b5eb9c5--

