Return-Path: <linux-kselftest+bounces-29877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AB2A74501
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 09:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2026E189C70F
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 08:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8EB212F83;
	Fri, 28 Mar 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCd2a/4K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB4A211706
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 08:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149229; cv=none; b=c/qZA45uspLU6J6HzoLj36xItSskJ52O5sC+IaHH8v62lkHWbwASjf6Z03Z/OEvxCX/3/pdUskUeI/wjkiSzNuYFZpgvQTfmRY8iRNKAi6mWYbmOVf/esERssu5+R9ALJxRWQNlAD4gjn1js8wsXVtyQyzbWMrdzEdy/PQ1ffYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149229; c=relaxed/simple;
	bh=tNMF3zrqLTbFUR+yWnQKYfUFroHVNsAfscGsVGDoOmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INsDWYrL8sGjYGxbUGq7/PytkotcPUYbrfSOtQfO4XjCwiypaBgq3Nv2epZVtMNn31tKtbst7wf7qXUHt6cIB/v532h9ZB7JxICJtX4F0fMG6VCy4pSfMjUMKcQxVVHLsMuF+SErGRyxJZN5+albCFBQKecXDSQ57bKPA/hVd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCd2a/4K; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8f6970326so16355896d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Mar 2025 01:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743149226; x=1743754026; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LyDg7tL+z3VRYNcM0J68Wwi8K9zl0Qcxm1t8RUqdRXA=;
        b=JCd2a/4KmQi/u24/CtwKX8pg1eJGOxeKALSlPTiaj1dJUDPam+DYp3owRWjpTHl3aJ
         itJjQsmwmb10MmvQYVwR/qhvYXzJ+Z2+2dUxiyEdzjN3cHLzCcdpnZ2SlsgPPv5ii8xH
         PPe3wZiH/d+2LbuPeeRcuPQ97bVO760yIr6WL0zm8PJP1pmfQAyqHxn2eLLqZuP5QLFM
         knoIhNTiFswU+qeL8iiGc2VJMxBAJP4s9g2nc9m9SAUNWdllYSQkcc2D6ILbOKNHNXQm
         Xj2ZF/WM7IjvDJ1dEdonnFt51oJ7IhEM0hEPuHY/X7e8nRpFuwZ7FcFb2YAgEfNR4JWD
         d3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743149226; x=1743754026;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyDg7tL+z3VRYNcM0J68Wwi8K9zl0Qcxm1t8RUqdRXA=;
        b=AxC/ls1vnPGWhYvSjY2vOqpgjn3SLquwojR7g2jVQ3saLfFVaRmXKt0dTXzw5XFsDH
         IsQuPD/x9pxuoIdUAZNi1XVZIn8Nhrcx0sxXEF3wRi/g9+hyxKni69t65XMEfmWGRAn1
         UwWfpXaPNWXk4+kpky+OYHNC4Ae4V0jNs88ZQuCWzg8U3pHA+bl00BfhjIGOmVi13er2
         cwjS2nuNZpbCH7hvSjxbMxinEFEJExrej57p9UbpWqCF3n/b+AsSHyAMaKp5qRkcGyVm
         NXgDQEYFevt0UgKTDueJX1355hFZs6LfRo/8zKhoEIeVzYAgNgbvdsjTbrkzs7IGEMHK
         3qhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBTUxKOfFL5SxrSVDLQQUYIlZx3F4dRHLAdEw2XZ4/i3HjM+xR5M7ZPSwZWe5G2l/IHfJVIJUfXniyPGYtzMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5Ie4QPrjrepOV+QRHXTs+pzwB2YEVe0sRPLxHUgJgUun1PZA
	+AWDCAk8pD/C/nbqHGwhdCH8gP/+fwhWhy05zmVAmn7OTMgnkorHGWl4U2gZFX8bF4Qf51HWjAR
	vq0eElrK38Rgh4y29BwjNd6atny0ylcU3bGotznvpMkxt6Cgt/XFz
X-Gm-Gg: ASbGnctjAzibCFXIQu+muzkyfmUixL2gCNf3GbN/ZEh4iGwe7lYVpjxtA8NLsKFNjV/
	AlCjiQ9uDTFEGVUkkAxhSXrBqRSupSUt43sO/8rJ3t8wlkaU2kAXcW2A3XEPNO4+De6ZkTpJIsz
	yKByLZc+S5Sal5yO0glltzhxEOEts+1/aJxcsGLg==
X-Google-Smtp-Source: AGHT+IGzUIk/v4ngoHdg/Z6l+1SFfpDik4JMUXQN0rKpviOsqy0lYMG15bjYEY2aKIZJgqol2xEiIx8lx2010LrD9QA=
X-Received: by 2002:a05:6214:c63:b0:6e8:f464:c9a0 with SMTP id
 6a1803df08f44-6ed238a860emr95218916d6.13.1743149225867; Fri, 28 Mar 2025
 01:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49d57ab512c47f01d6c374d533f1752871ea4246.1743091573.git.geert@linux-m68k.org>
In-Reply-To: <49d57ab512c47f01d6c374d533f1752871ea4246.1743091573.git.geert@linux-m68k.org>
From: David Gow <davidgow@google.com>
Date: Fri, 28 Mar 2025 16:06:52 +0800
X-Gm-Features: AQ5f1Jr3hZn89B9ROY2nPLdEcgv9EW_VI3KKZ2dFFxe1Po-FS7WLFRntzSls0Z4
Message-ID: <CABVgOSmxsXEyLVyhhffhXUXf3-QnGmZurXaRhpiK8w894mrwzg@mail.gmail.com>
Subject: Re: [PATCH/RFC] kunit/rtc: Add real support for very slow tests
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-rtc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000710de00631628ece"

--000000000000710de00631628ece
Content-Type: text/plain; charset="UTF-8"

Hi Geert,

Thanks for sending this out: I think this raises some good questions
about exactly how to handle long running tests (particularly on
older/slower hardware).

I've put a few notes below, but, tl;dr: I think these are all good
changes, even if there's more we can do to better scale to slower
hardware.

On Fri, 28 Mar 2025 at 00:07, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> When running rtc_lib_test ("lib_test" before my "[PATCH] rtc: Rename
> lib_test to rtc_lib_test") on m68k/ARAnyM:
>
>     KTAP version 1
>     1..1
>         KTAP version 1
>         # Subtest: rtc_lib_test_cases
>         # module: rtc_lib_test
>         1..2
>         # rtc_time64_to_tm_test_date_range_1000: Test should be marked slow (runtime: 3.222371420s)
>         ok 1 rtc_time64_to_tm_test_date_range_1000
>         # rtc_time64_to_tm_test_date_range_160000: try timed out
>         # rtc_time64_to_tm_test_date_range_160000: test case timed out
>         # rtc_time64_to_tm_test_date_range_160000.speed: slow
>         not ok 2 rtc_time64_to_tm_test_date_range_160000
>     # rtc_lib_test_cases: pass:1 fail:1 skip:0 total:2
>     # Totals: pass:1 fail:1 skip:0 total:2
>     not ok 1 rtc_lib_test_cases
>
> Commit 02c2d0c2a84172c3 ("kunit: Add speed attribute") added the notion
> of "very slow" tests, but this is further unused and unhandled.
>
> Hence:
>   1. Introduce KUNIT_CASE_VERY_SLOW(),

Thanks -- I think we want this regardless.

>   2. Increase timeout by ten; ideally this should only be done for very
>      slow tests, but I couldn't find how to access kunit_case.attr.case
>      from kunit_try_catch_run(),


My feeling for tests generally is:
- Normal: effectively instant on modern hardware, O(seconds) on
ancient hardware.
- Slow: takes O(seconds) to run on modern hardware, O(minutes)..O(10s
of minutes) on ancient hardware.
- Very slow: O(minutes) or higher on modern hardware, infeasible on
ancient hardware.

Obviously the definition of "modern" and "ancient" hardware here is
pretty arbitrary: I'm using "modern, high-end x86" ~4GHz as my
"modern" example, and "66MHz 486" as my "ancient" one, but things like
emulation or embedded systems fit in-between.

Ultimately, I think the timeout probably needs to be configurable on a
per-machine basis more than a per-test one, but having a 10x
multiplier (or even a 100x multiplier) for very slow tests would also
work for me.

I quickly tried hacking together something to pass through the
attribute and implement this. Diff (probably mangled by gmail) below:
---
diff --git a/include/kunit/try-catch.h b/include/kunit/try-catch.h
index 7c966a1adbd3..24a29622068b 100644
--- a/include/kunit/try-catch.h
+++ b/include/kunit/try-catch.h
@@ -50,6 +50,13 @@ struct kunit_try_catch {
       void *context;
};

+struct kunit_try_catch_context {
+       struct kunit *test;
+       struct kunit_suite *suite;
+       struct kunit_case *test_case;
+};
+
+
void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context);

void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 146d1b48a096..79d12c0c2d25 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -420,12 +420,6 @@ static void kunit_run_case_cleanup(struct kunit *test,
       kunit_case_internal_cleanup(test);
}

-struct kunit_try_catch_context {
-       struct kunit *test;
-       struct kunit_suite *suite;
-       struct kunit_case *test_case;
-};
-
static void kunit_try_run_case(void *data)
{
       struct kunit_try_catch_context *ctx = data;
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 92099c67bb21..5f62e393d422 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -34,30 +34,15 @@ static int kunit_generic_run_threadfn_adapter(void *data)
       return 0;
}

-static unsigned long kunit_test_timeout(void)
+static unsigned long kunit_test_timeout(struct kunit_try_catch *try_catch)
{
-       /*
-        * TODO(brendanhiggins@google.com): We should probably have some type of
-        * variable timeout here. The only question is what that timeout value
-        * should be.
-        *
-        * The intention has always been, at some point, to be able to label
-        * tests with some type of size bucket (unit/small, integration/medium,
-        * large/system/end-to-end, etc), where each size bucket would get a
-        * default timeout value kind of like what Bazel does:
-        * https://docs.bazel.build/versions/master/be/common-definitions.html#test.size
-        * There is still some debate to be had on exactly how we do this. (For
-        * one, we probably want to have some sort of test runner level
-        * timeout.)
-        *
-        * For more background on this topic, see:
-        * https://mike-bland.com/2011/11/01/small-medium-large.html
-        *
-        * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
-        * the task will be killed and an oops generated.
-        */
-       // FIXME times ten for KUNIT_SPEED_VERY_SLOW?
-       return 10 * 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
+       struct kunit_try_catch_context *ctx = (struct
kunit_try_catch_context *)try_catch->context;
+       struct kunit_case *test_case = ctx->test_case;
+       unsigned long base_timeout = 300 *
msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
+       /* VERY_SLOW tests get 10 times the time to execute (50 minutes). */
+       unsigned long multiplier = (test_case->attr.speed ==
KUNIT_SPEED_VERY_SLOW) ? 10 : 1;
+
+       return multiplier * base_timeout;
}

void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
@@ -87,7 +72,7 @@ void kunit_try_catch_run(struct kunit_try_catch
*try_catch, void *context)
       wake_up_process(task_struct);

       time_remaining = wait_for_completion_timeout(task_done,
-                                                    kunit_test_timeout());
+
kunit_test_timeout(try_catch));
       if (time_remaining == 0) {
               try_catch->try_result = -ETIMEDOUT;
               kthread_stop(task_struct);

---

I'll get around to extending this to allow the "base timeout" to be
configurable as a command-line option, too, if this seems like a good
way to go.

>   3. Mark rtc_time64_to_tm_test_date_range_1000 slow,
>   4. Mark rtc_time64_to_tm_test_date_range_160000 very slow.

Hmm... these are definitely fast enough on my "modern" machine that
they probably only warrant "slow", not "very slow". But given they're
definitely causing problems on older machines, I'm happy to go with
marking the large ones very slow. (I've been waiting for them for
about 45 minutes so far on my 486.)

Do the time tests in kernel/time/time_test.c also need to be marked
very slow, or does that run much faster on your setup?


>
> Afterwards:
>
>     KTAP version 1
>     1..1
>         KTAP version 1
>         # Subtest: rtc_lib_test_cases
>         # module: rtc_lib_test
>         1..2
>         # rtc_time64_to_tm_test_date_range_1000.speed: slow
>         ok 1 rtc_time64_to_tm_test_date_range_1000
>         # rtc_time64_to_tm_test_date_range_160000.speed: very_slow
>         ok 2 rtc_time64_to_tm_test_date_range_160000
>     # rtc_lib_test_cases: pass:2 fail:0 skip:0 total:2
>     # Totals: pass:2 fail:0 skip:0 total:2
>     ok 1 rtc_lib_test_cases
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Is this causing you enough strife that you want it in as-is, straight
away, or would you be happy with it being split up and polished a bit
first -- particularly around supporting the more configurable timeout,
and shifting the test changes into separate patches? (I'm happy to do
that for you if you don't want to dig around in the somewhat messy
KUnit try-catch stuff any further.)

Does anyone else (particularly anyone involved with the rtc tests)
have thoughts?

Cheers,
-- David

>  drivers/rtc/rtc_lib_test.c |  4 ++--
>  include/kunit/test.h       | 11 +++++++++++
>  lib/kunit/try-catch.c      |  3 ++-
>  3 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/rtc/rtc_lib_test.c b/drivers/rtc/rtc_lib_test.c
> index c30c759662e39b48..fd3210e39d37dbc6 100644
> --- a/drivers/rtc/rtc_lib_test.c
> +++ b/drivers/rtc/rtc_lib_test.c
> @@ -85,8 +85,8 @@ static void rtc_time64_to_tm_test_date_range_1000(struct kunit *test)
>  }
>
>  static struct kunit_case rtc_lib_test_cases[] = {
> -       KUNIT_CASE(rtc_time64_to_tm_test_date_range_1000),
> -       KUNIT_CASE_SLOW(rtc_time64_to_tm_test_date_range_160000),
> +       KUNIT_CASE_SLOW(rtc_time64_to_tm_test_date_range_1000),
> +       KUNIT_CASE_VERY_SLOW(rtc_time64_to_tm_test_date_range_160000),
>         {}
>  };
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b773406e01f3c43..4e3c1cae5b41466e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -183,6 +183,17 @@ static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>                 { .run_case = test_name, .name = #test_name,    \
>                   .attr.speed = KUNIT_SPEED_SLOW, .module_name = KBUILD_MODNAME}
>
> +/**
> + * KUNIT_CASE_VERY_SLOW - A helper for creating a &struct kunit_case
> + * with the very slow attribute
> + *
> + * @test_name: a reference to a test case function.
> + */
> +
> +#define KUNIT_CASE_VERY_SLOW(test_name)                        \
> +               { .run_case = test_name, .name = #test_name,    \
> +                 .attr.speed = KUNIT_SPEED_VERY_SLOW, .module_name = KBUILD_MODNAME}
> +
>  /**
>   * KUNIT_CASE_PARAM - A helper for creation a parameterized &struct kunit_case
>   *
> diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
> index 6bbe0025b0790bd2..92099c67bb21d0a4 100644
> --- a/lib/kunit/try-catch.c
> +++ b/lib/kunit/try-catch.c
> @@ -56,7 +56,8 @@ static unsigned long kunit_test_timeout(void)
>          * If tests timeout due to exceeding sysctl_hung_task_timeout_secs,
>          * the task will be killed and an oops generated.
>          */
> -       return 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
> +       // FIXME times ten for KUNIT_SPEED_VERY_SLOW?
> +       return 10 * 300 * msecs_to_jiffies(MSEC_PER_SEC); /* 5 min */
>  }
>
>  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
> --
> 2.43.0
>

--000000000000710de00631628ece
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
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgzByQRcYnaQenoVp6PPSPaSERQfUC
Y2kvpHb3/e42Fq0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MzI4MDgwNzA2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAENVM3tz7uK7WnnOPenb8ndbSNXfYUw+dlmCZg0o588AL5TItjC8+DQOpjjc3Ffkd
p6Ru68g15xjTr8fM+MDpPmeTApSBiIAVb8tCUtRBEZTvfbceKhwK8zKZtfW0/RV6CeCxgA9s5GM/
HUce3WieuT88uVbtGuKvw+ifmBf7OhDfjfCeF+0ZIxyTHE7Ti+qDMAZxr+B4Z8GCpGITuhsYAkbm
+GEfhMp40fWsm7+e5QReajIccOXJCP1K98KQbrDWdyTSveoE/xQ10SIn/UJrkav5zNTP1/0mMGT4
qjyYKXqkCGIakGinJYdVAymM8UVD13SAcpQQv0gEfuwRdBfaPg==
--000000000000710de00631628ece--

