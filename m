Return-Path: <linux-kselftest+bounces-14758-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78361946888
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 09:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB28C1F21CB0
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Aug 2024 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41E14D2B3;
	Sat,  3 Aug 2024 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5aa3zn6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42050D2EE
	for <linux-kselftest@vger.kernel.org>; Sat,  3 Aug 2024 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722669497; cv=none; b=BBXl89hixFEVUh/3SbEFOjp6LU9kLIP4L6ZYI+F8BsuueAj0xgY+hBN0mM1Otg+GsnWloh14j0HdkG6bmCqm3X7d6Ja5C/6M4ZLogSC9CBTbTpdReG5zurS7hO02ShvagRgYTCFYZCKnRA2BjlLF5UFjC9QMiGTtyLjrUrpuQQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722669497; c=relaxed/simple;
	bh=QBuD7ZVsZHWfCWESouV0BzDU1ZT3z6fSV+14Ngzo5BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QuNdg47xKwwMZEG5CMOg0Mavo9LocrZFX3dCZWUmqdjfj6/4QSwJkQQPV5cgPeckmcaY0q/cjD7niGHiuZU1GTM5+3btPjEeqpYw908ZRZ4Ll/M7hug4DG5OdlNBg6hHTyQO+PNlwFYS8LNtCV+3CJu6CIdjpIMCTQRiiKz3JSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5aa3zn6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45029af1408so32231cf.1
        for <linux-kselftest@vger.kernel.org>; Sat, 03 Aug 2024 00:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722669494; x=1723274294; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1qALrchnprqR0/YmCREFy/a0oh85eh0muuWbDxlV93A=;
        b=b5aa3zn6+a5Smdk/uC/pbTMvGMgkHR5t/GuqZip8C0T/bZka7L3MAq6QEIjVhiCqf0
         fC4kCLIBNa3dVuWVYXpJQQpQzPEkqTFt6qb/PlMzaAlIqs7RDNgfc81GiJ0NQD8XRH6t
         xSNToeeFgm9Y785YQhxRe2VFBRJNsYBz8hd4vW+dvdn28EY+DlC04obiRvN4npSuITCV
         VcWKZrwlvwItYUgRvsIsqVN4f4Af4Gie39cpJxwPAF/by6ej4MgGLCZJPse93FQcgubb
         vPMhctMp0PvYiAPedLaq2aHP2BczAeYKYerzRTjIBdh8ZcVat6ONKQi147EdSI7XqCjc
         9ihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722669494; x=1723274294;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qALrchnprqR0/YmCREFy/a0oh85eh0muuWbDxlV93A=;
        b=G1LLMzyCg6l9CW+LFzTH91W3swX3nLEFSkyo0XA8om/bGwtAmKHg+0Y0r4LOZTKq7G
         x9MHTcbeddWWvxC3fn+DgjH/QN7lgOTQEoWdIRusjCuBTODowBvfxqxaC2fg2T6S/d6e
         bSqUd6gfDijJ01zOZlIZVbK3P9clDLlnaaB7vycl+1wdID5LCvallroJSG8jaoSSQwDp
         iI0E3lDjFKsZJ0fFE9U75exbBlZ6NWKojzDRbvI5QaL1qUmVjfVy6Oh5pWqcllAn0Dx/
         cdGS6pSIyUxVJ72UTPxMUYKtpOXO2lhp4w4GhRHPfVaNYdtFTo8JqZiTricLcMRYfJ/V
         NOWw==
X-Forwarded-Encrypted: i=1; AJvYcCVB5baiPZ/UqD/GXGzE5qUBBoo4WofdLF/FuxNwXCeLJoaFSdg9R9GLK9MOo2HxckMyNb0E/juu4oYpG52X3ha+bjD1VyAnJB7jIyXpoTj9
X-Gm-Message-State: AOJu0YzAVnrvTWB5EsIsLfJ/gHeY+AMBWwLv9RCUgncVj7MiBJFr2YoK
	eg3Mne+LYwt2tDk8C6yhWTQ4J+b8XYa9hRVhgGJ2gIPYJMHgtEblarAZ3nNZIfplgSgHGAfMh7C
	9fLMXsVe3E7f0vAPb1MPIyAd04QdfsWSkd9cz
X-Google-Smtp-Source: AGHT+IGGkxBdicWDVTVNBSNNtbztUV7M1MtySUFxtd6qSO+kBZZiBL/t4qlWb6IDTtAMZ+dUZdKM1UO3FxHbwDJ+0ek=
X-Received: by 2002:ac8:124a:0:b0:447:e393:fed1 with SMTP id
 d75a77b69052e-4519b42ad12mr831341cf.7.1722669494031; Sat, 03 Aug 2024
 00:18:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201508.53805-1-rmoar@google.com>
In-Reply-To: <20240731201508.53805-1-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Sat, 3 Aug 2024 15:17:57 +0800
Message-ID: <CABVgOSmKK2qeZ58+iCkgT9HGaPozVXE0+Z0K4u0hpx9GKg+_gw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: add test duration attribute
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000049ed2f061ec23fcf"

--00000000000049ed2f061ec23fcf
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Aug 2024 at 04:15, Rae Moar <rmoar@google.com> wrote:
>
> Add a new test duration attribute to print the duration of a test run.
>
> Example:
>  KTAP version 1
>     # Subtest: memcpy
>     # module: memcpy_kunit
>     1..4
>     # memcpy_large_test.speed: slow
>     # memcpy_large_test.duration: 1.134787584s
>     ok 1 memcpy_large_test
>     ...
>
> This attribute is printed for each test (excluding parameterized tests).
>
> Add documentation for this new attribute to KUnit docs.
>
> In order to save the timespec64 object, add the ability to save a memory
> allocated object to the attributes framework.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

I like this, but have a few suggestions, neither of which are
blockers, but would be useful future features:
- I'd like a way to filter what attributes are printed at runtime.
Once we get more attributes, this will get rapidly more annoying.
- We should think about keeping attributes around for longer, so we
can access them programmatically after the test finishes.
- (An example of these two could be to re-print out the results with
attributes filtered from debugfs)
- And, one day, it'd be nice to support attributes on parameterised
tests. Maybe with the parameterised test re-work.

None of these ideas are quite organised enough to block this patch,
which otherwise looks good and works well here. But I think they could
inspire some longer-term changes to the way we structure KUnit tests
in-memory and handle debugfs, alongside the other feature requests
we've had for parameterised tests. (Like having explicit context
associated with them, or supporting more arbitrary nesting.)

Regardless, this is

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

> Changes v1->v2:
> - Change sprintf to kasprintf
>
>  .../dev-tools/kunit/running_tips.rst          |  7 +++
>  include/kunit/attributes.h                    |  5 ++
>  include/kunit/test.h                          |  1 +
>  lib/kunit/attributes.c                        | 54 ++++++++++++++++++-
>  lib/kunit/test.c                              | 25 +++++++--
>  5 files changed, 86 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
> index bd689db6fdd2..a528d92e5d8f 100644
> --- a/Documentation/dev-tools/kunit/running_tips.rst
> +++ b/Documentation/dev-tools/kunit/running_tips.rst
> @@ -446,3 +446,10 @@ This attribute indicates whether the test uses init data or functions.
>
>  This attribute is automatically saved as a boolean and tests can also be
>  filtered using this attribute.
> +
> +``duration``
> +
> +This attribute indicates the length of time in seconds of the test execution.
> +
> +This attribute is automatically saved as a timespec64 and printed for each test
> +(excluding parameterized tests).
> diff --git a/include/kunit/attributes.h b/include/kunit/attributes.h
> index bc76a0b786d2..89ca54ef380d 100644
> --- a/include/kunit/attributes.h
> +++ b/include/kunit/attributes.h
> @@ -18,6 +18,11 @@ struct kunit_attr_filter {
>         char *input;
>  };
>
> +/*
> + * Frees all of a test's allocated attributes.
> + */
> +void kunit_free_attr(void *test_or_suite, bool is_test);
> +
>  /*
>   * Returns the name of the filter's attribute.
>   */
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index ec61cad6b71d..dca78d9bd3f6 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -82,6 +82,7 @@ enum kunit_speed {
>  /* Holds attributes for each test case and suite */
>  struct kunit_attributes {
>         enum kunit_speed speed;
> +       struct timespec64 *duration;
>  };
>
>  /**
> diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
> index 2cf04cc09372..fd01d54e52d7 100644
> --- a/lib/kunit/attributes.c
> +++ b/lib/kunit/attributes.c
> @@ -40,6 +40,7 @@ struct kunit_attr {
>         int (*filter)(void *attr, const char *input, int *err);
>         void *attr_default;
>         enum print_ops print;
> +       bool to_free;
>  };
>
>  /* String Lists for enum Attributes */
> @@ -79,8 +80,22 @@ static const char *attr_string_to_string(void *attr, bool *to_free)
>         return (char *) attr;
>  }
>
> +static const char *attr_duration_to_string(void *attr, bool *to_free)
> +{
> +       struct timespec64 *val = (struct timespec64 *)attr;
> +       char *str = kasprintf(GFP_KERNEL, "%lld.%09lds", val->tv_sec, val->tv_nsec);
> +
> +       *to_free = true;
> +       return str;
> +}
> +
>  /* Filter Methods */
>
> +static int attr_default_filter(void *attr, const char *input, int *err)
> +{
> +       return false;
> +}
> +
>  static const char op_list[] = "<>!=";
>
>  /*
> @@ -246,8 +261,20 @@ static void *attr_is_init_get(void *test_or_suite, bool is_test)
>                 return ((void *) suite->is_init);
>  }
>
> +static void *attr_duration_get(void *test_or_suite, bool is_test)
> +{
> +       struct kunit_case *test = is_test ? test_or_suite : NULL;
> +
> +       if (test && !test->generate_params)
> +               return ((void *) test->attr.duration);
> +       else
> +               return ((void *) NULL);
> +}
> +
>  /* List of all Test Attributes */
>
> +static struct timespec64 duration_default = {0, 0};
> +
>  static struct kunit_attr kunit_attr_list[] = {
>         {
>                 .name = "speed",
> @@ -256,6 +283,7 @@ static struct kunit_attr kunit_attr_list[] = {
>                 .filter = attr_speed_filter,
>                 .attr_default = (void *)KUNIT_SPEED_NORMAL,
>                 .print = PRINT_ALWAYS,
> +               .to_free = false,
>         },
>         {
>                 .name = "module",
> @@ -264,6 +292,7 @@ static struct kunit_attr kunit_attr_list[] = {
>                 .filter = attr_string_filter,
>                 .attr_default = (void *)"",
>                 .print = PRINT_SUITE,
> +               .to_free = false,
>         },
>         {
>                 .name = "is_init",
> @@ -272,10 +301,33 @@ static struct kunit_attr kunit_attr_list[] = {
>                 .filter = attr_bool_filter,
>                 .attr_default = (void *)false,
>                 .print = PRINT_SUITE,
> +               .to_free = false,
> +       },
> +       {
> +               .name = "duration",
> +               .get_attr = attr_duration_get,
> +               .to_string = attr_duration_to_string,
> +               .filter = attr_default_filter,
> +               .attr_default = (void *)(&duration_default),
> +               .print = PRINT_ALWAYS,

I'd love to see a way of toggling this at runtime (e.g., from the
kernel command-line or debugfs). Not needed for the initial patch, but
a mechanism for suppressing this (rather noisy) attribute would be
good to get at some point.

> +               .to_free = true,
>         }
>  };
>
> -/* Helper Functions to Access Attributes */
> +/* Helper Functions to Access/Free Attributes */
> +
> +void kunit_free_attr(void *test_or_suite, bool is_test)
> +{
> +       int i;
> +       void *attr;
> +
> +       for (i = 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
> +               if (kunit_attr_list[i].to_free) {
> +                       attr = kunit_attr_list[i].get_attr(test_or_suite, is_test);
> +                       kfree(attr);
> +               }
> +       }
> +}
>
>  const char *kunit_attr_filter_name(struct kunit_attr_filter filter)
>  {
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e8b1b52a19ab..0d18e4969015 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -376,11 +376,11 @@ static void kunit_run_case_check_speed(struct kunit *test,
>  /*
>   * Initializes and runs test case. Does not clean up or do post validations.
>   */
> -static void kunit_run_case_internal(struct kunit *test,
> +static struct timespec64 kunit_run_case_internal(struct kunit *test,
>                                     struct kunit_suite *suite,
>                                     struct kunit_case *test_case)
>  {
> -       struct timespec64 start, end;
> +       struct timespec64 start, end, duration;
>
>         if (suite->init) {
>                 int ret;
> @@ -389,7 +389,9 @@ static void kunit_run_case_internal(struct kunit *test,
>                 if (ret) {
>                         kunit_err(test, "failed to initialize: %d\n", ret);
>                         kunit_set_failure(test);
> -                       return;
> +                       duration.tv_sec = 0;
> +                       duration.tv_nsec = 0;
> +                       return duration;
>                 }
>         }
>
> @@ -399,7 +401,11 @@ static void kunit_run_case_internal(struct kunit *test,
>
>         ktime_get_ts64(&end);
>
> -       kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
> +       duration = timespec64_sub(end, start);
> +
> +       kunit_run_case_check_speed(test, test_case, duration);
> +
> +       return duration;
>  }
>
>  static void kunit_case_internal_cleanup(struct kunit *test)
> @@ -424,6 +430,7 @@ struct kunit_try_catch_context {
>         struct kunit *test;
>         struct kunit_suite *suite;
>         struct kunit_case *test_case;
> +       struct timespec64 duration;
>  };
>
>  static void kunit_try_run_case(void *data)
> @@ -440,7 +447,7 @@ static void kunit_try_run_case(void *data)
>          * abort will be called, this thread will exit, and finally the parent
>          * thread will resume control and handle any necessary clean up.
>          */
> -       kunit_run_case_internal(test, suite, test_case);
> +       ctx->duration = kunit_run_case_internal(test, suite, test_case);
>  }
>
>  static void kunit_try_run_case_cleanup(void *data)
> @@ -521,6 +528,7 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>  {
>         struct kunit_try_catch_context context;
>         struct kunit_try_catch *try_catch;
> +       struct timespec64 *duration = kmalloc(sizeof(struct timespec64), GFP_KERNEL);
>
>         try_catch = &test->try_catch;
>
> @@ -533,6 +541,10 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
>         context.test_case = test_case;
>         kunit_try_catch_run(try_catch, &context);
>
> +       duration->tv_sec = context.duration.tv_sec;
> +       duration->tv_nsec = context.duration.tv_nsec;
> +       test_case->attr.duration = duration;
> +
>         /* Now run the cleanup */
>         kunit_try_catch_init(try_catch,
>                              test,
> @@ -670,6 +682,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>                 }
>
>                 kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
> +               kunit_free_attr((void *)test_case, true);

Do we want to keep this attribute around for, e.g., debugfs access? I
think we're okay at the moment (we're writing the actual value to the
log), but if we want a more structured way of accessing it, we'll want
to hold off on freeing this until the test is re-executed or the
module unloaded.

>
>                 kunit_print_test_stats(&test, param_stats);
>
> @@ -680,6 +693,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>
>                 kunit_update_stats(&suite_stats, test_case->status);
>                 kunit_accumulate_stats(&total_stats, param_stats);
> +
>         }
>
>         if (suite->suite_exit)
> @@ -688,6 +702,7 @@ int kunit_run_tests(struct kunit_suite *suite)
>         kunit_print_suite_stats(suite, suite_stats, total_stats);
>  suite_end:
>         kunit_print_suite_end(suite);
> +       kunit_free_attr((void *)suite, false);

As above do we want to delay this until module unload and/or test re-execution?

>
>         return 0;
>  }
>
> base-commit: 67c9971cd6d309ecbcb87b942e22ffc194d7a376
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

--00000000000049ed2f061ec23fcf
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPqgYJKoZIhvcNAQcCoIIPmzCCD5cCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg0EMIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
JEfDtvHU6wy3MSBE3/TrMFcGA1UdIARQME4wCQYHZ4EMAQUBATBBBgkrBgEEAaAyASgwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgw
FoAUfMwKaNei6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEB
AGwXYwvLVjByVooZ+uKzQVW2nnClCIizd0jfARuMRTPNAWI2uOBSKoR0T6XWsGsVvX1vBF0FA+a9
DQOd8GYqzEaKOiHDIjq/o455YXkiKhPpxDSIM+7st/OZnlkRbgAyq4rAhAjbZlceKp+1vj0wIvCa
4evQZvJNnJvTb4Vcnqf4Xg2Pl57hSUAgejWvIGAxfiAKG8Zk09I9DNd84hucIS2UIgoRGGWw3eIg
GQs0EfiilyTgsH8iMOPqUJ1h4oX9z1FpaiJzfxcvcGG46SCieSFP0USs9aMl7GeERue37kBf14Pd
kOYIfx09Pcv/N6lHV6kXlzG0xeUuV3RxtLtszQgxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIz
IFNNSU1FIENBIDIwMjACEAFsPHWl8lqMEwx3lAnpufYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZI
hvcNAQkEMSIEIG+ROvIZvWM63JLmQtupYBMAmqIPbF8SNQdVW0qFgCtgMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDgwMzA3MTgxNFowaQYJKoZIhvcNAQkPMVww
WjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkq
hkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAyUkVT
kRxwp9nIkdm/R4k7JZePImevj/bKPTW9HWU7k3JjCS6VqRruyowbUnxyEqC/MZXABz4Oe8PPlIDG
coYIgKnQJczeyqCPxAvTNbwSrfwxwsXwn7iDafxyWtuFDNf4+tyPmidSxR7+F/w0IrsENrNKlT3o
hfM2rciZDOHV3gIR12aHKm6p88dyEQQtPTTLBn3i/chrpEgyqwUin6UsBoLubfUoVlWOoQgUZpW0
sCKdgzu5d+vfwR1SqtUa2hHRh807yN4BW77a8ZMsTFFOeQRtmD8WPblwd0r9dqMWDwenvW/BodvS
TRcTzEZzQhnsyTfjW+2dmrSaUsiGoA7p
--00000000000049ed2f061ec23fcf--

