Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D2939C1D0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhFDVGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 17:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhFDVGq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 17:06:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9092EC061766
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Jun 2021 14:04:59 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z26so8328665pfj.5
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Jun 2021 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDhLv97E2DQUPuoqpwMPEvyKe4QzBUBFor31yGtCwjM=;
        b=Q9GyhGWTAKnh7t7JfYv/78Exr1BZPtx2xBqGF06ejPcRb6rXhZfUPhNV4+D9MPybNV
         KJ4Nx9EGiZDPPBZSAr9LylkvVYgISv3qERJEZCjO+CddZ22oeaLf6IndtiEVSyCD1WG8
         42iZbgT8eqxmEEV2v2HyWU92T21ClG04PB3O14Fl1Gu0xDGDOH2Nj2BNRhEpFXK1Pg8b
         1ufNXXMADY0mNfxeK9j2/jIIlZH7O24Fti4VW84oIqLHvTFuk4o3NcaRERM/NNIKuzNh
         kpmJwMrufjJ67c+k5IzOfTY6nqosTZ8ff8IxBU4fagP8IMEtlSTB04Smnkh7OsLgCpbE
         yi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDhLv97E2DQUPuoqpwMPEvyKe4QzBUBFor31yGtCwjM=;
        b=SPs/s+xKqnkzqZXfZ1ajTifvqp1elWzsS7joynxnE9d4neBPXVxZtjroRYDzxyaSUE
         YnF3G5IhHn+tk9jOHUYzOfqc3Q+jlOfwOfRTh+br+G2Pzvh+5ApBg6cdJiXUhN7rx1iQ
         ioxKB7ObvbB9Ci1fF2zYOVgxx9Hl7gn0QD6klDzt9qTvpOFhNmqg2JSGYVuiVHOFQg18
         3U/r96ewC0W+4XrAsp2jryP2XzyLXUgPFR71SXvYq0KkGJZpTsHQMyv8Ximl10E5DCg1
         e/Ryl8ZBJMRcck4ochN+CfZTDHw2SoSNKTg4Lb5g2kOv+TSNfX49Sx2wzICP2rMmQr/t
         xArg==
X-Gm-Message-State: AOAM530JHNWnymUeKFrb27c8A5yvA1x02MCbXyRxJu0LwOmRRGcwiqLT
        7Qcnl8JENZ4PiDSB57BEmSlnOn0L3Mk5RGocodgcRA==
X-Google-Smtp-Source: ABdhPJxwFoi2DmuVD0IrszNbc/IHftwdGlvHNKO+HOCuthlFORJMu/oEI1eSS53JcAWiRRb5eE8v2dZ4GbFN7TBiWuw=
X-Received: by 2002:a63:1559:: with SMTP id 25mr7006094pgv.384.1622840697130;
 Fri, 04 Jun 2021 14:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210528075932.347154-1-davidgow@google.com>
In-Reply-To: <20210528075932.347154-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 4 Jun 2021 14:04:45 -0700
Message-ID: <CAFd5g44iCQtQ0XqDsKgQaVu=c2hq0NXbsqquEaQpRFEqnAMyFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] kunit: Support skipped tests
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 28, 2021 at 12:59 AM David Gow <davidgow@google.com> wrote:
>
> The kunit_mark_skipped() macro marks the current test as "skipped", with
> the provided reason. The kunit_skip() macro will mark the test as
> skipped, and abort the test.
>
> The TAP specification supports this "SKIP directive" as a comment after
> the "ok" / "not ok" for a test. See the "Directives" section of the TAP
> spec for details:
> https://testanything.org/tap-specification.html#directives
>
> The 'success' field for KUnit tests is replaced with a kunit_status
> enum, which can be SUCCESS, FAILURE, or SKIPPED, combined with a
> 'status_comment' containing information on why a test was skipped.
>
> A new 'kunit_status' test suite is added to test this.
>
> Signed-off-by: David Gow <davidgow@google.com>
> Tested-by: Marco Elver <elver@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

One fairly minor nit below. Other than that, looks great!

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

> ---

[...]

> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b68c61348121..1401c620ac5e 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -105,6 +105,18 @@ struct kunit;
>  #define KUNIT_SUBTEST_INDENT           "    "
>  #define KUNIT_SUBSUBTEST_INDENT                "        "
>
> +/**
> + * enum kunit_status - Type of result for a test or test suite
> + * @KUNIT_SUCCESS: Denotes the test suite has not failed nor been skipped
> + * @KUNIT_FAILURE: Denotes the test has failed.
> + * @KUNIT_SKIPPED: Denotes the test has been skipped.
> + */
> +enum kunit_status {
> +       KUNIT_SUCCESS,
> +       KUNIT_FAILURE,
> +       KUNIT_SKIPPED,
> +};
> +
>  /**
>   * struct kunit_case - represents an individual test case.
>   *
> @@ -148,13 +160,20 @@ struct kunit_case {
>         const void* (*generate_params)(const void *prev, char *desc);
>
>         /* private: internal use only. */
> -       bool success;
> +       enum kunit_status status;
>         char *log;
>  };
>
> -static inline char *kunit_status_to_string(bool status)
> +static inline char *kunit_status_to_ok_not_ok(enum kunit_status status)
>  {
> -       return status ? "ok" : "not ok";
> +       switch (status) {
> +       case KUNIT_SKIPPED:
> +       case KUNIT_SUCCESS:
> +               return "ok";
> +       case KUNIT_FAILURE:
> +               return "not ok";
> +       }
> +       return "invalid";
>  }
>
>  /**
> @@ -212,6 +231,7 @@ struct kunit_suite {
>         struct kunit_case *test_cases;
>
>         /* private: internal use only */
> +       char status_comment[256];

nit: How about we make the 256 a constant since you use it in a number
of places?

If not, at least when you reference the struct, you might want to use
ARRAY_SIZE(...).

>         struct dentry *debugfs;
>         char *log;
>  };
[...]
