Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60400162FDC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2020 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBRT04 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Feb 2020 14:26:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36588 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgBRT0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Feb 2020 14:26:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id 185so11152328pfv.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2020 11:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PG1inGCjkR8mbsV9FBAGsiFoMPIEZyx6SU/E1O5JF7M=;
        b=LKslbmH0dvmcG60Ck8sK/dmQiiexpGxXSgYtk3lY8upWmpuvOz/oM+fPI6ZbcDhDsa
         RpPSJd2RUqGFX/QQYtGVauBVeZypL2oKXrEObFBe12YylfCiFeSoI80UMMRdjEsdg7n3
         POgU5qp0Tgi8hPVyOf17vRI1G2fQe7rF6uWKLJxDaereKr+1W2qiRv0L6RwRmoOfryLx
         h96KAO8dbjtrrnazYDf6UwT1vUQ+L70DL0X/CZlKWXMQT7OYN3/dnpovh7DVQASJ7rMX
         IguDxDfOK8XUGiszApK+IDSIuUQMX1PFq8XSomi7opasBfzniD9phH9yq00SVfztmKO3
         xZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PG1inGCjkR8mbsV9FBAGsiFoMPIEZyx6SU/E1O5JF7M=;
        b=JUvqx+Cd0Y/sYb+SWpRF9NAxUKt11TZ/U8qiVFMm2GhI8NrIYxhRsyq4MM4EPUReep
         5um/Selq3vngIatDTB3xzNUsI6vHcqrHaGdAI9A3Xxu/xdF3ncaz1m7Qf0OUa55t/Okk
         Q1vQK+Ap4QCROOtd6aaz30UeYtw7WKk8krn+qoYD3fsSj5YYe8kYWsY6QKbewtjwWXWt
         dgUdThb++fEMfOYxroED/G+cHRab8c6m3wfBjW9HzWQwe/NYfsaNZvEwDF21Osjqdn/j
         SVrtC53oH41b6yDuoN/OHQuzXpWWj9hwk61tOjr3/RGXS4tZlRKor/c63ESErA4TyOZK
         hkUw==
X-Gm-Message-State: APjAAAWWUSq4BpcNQ5J1dk8fV1Ej/fZubB2hcNGKSMlAMUxKwFt7UntQ
        ziYZkSptaxdZjKuJvBsa00tiqIw6nqFcvormnfAM/w==
X-Google-Smtp-Source: APXvYqz4+UZUuuR5h/fNaE5Tzptkbuq8wJ2Z/GQxsLTn9qb7rpgmkUShMVAz14BtnZOgirr4od0cln9sN1EnrYiTfSs=
X-Received: by 2002:a62:6842:: with SMTP id d63mr23106087pfc.113.1582054013382;
 Tue, 18 Feb 2020 11:26:53 -0800 (PST)
MIME-Version: 1.0
References: <1581949660-20113-1-git-send-email-alan.maguire@oracle.com> <1581949660-20113-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1581949660-20113-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 Feb 2020 11:26:42 -0800
Message-ID: <CAFd5g47bU+5dEb2FxbT1X0oXgcD0jOkqW7a4WfCxVttRhDSYoA@mail.gmail.com>
Subject: Re: [PATCH v4 kunit-next 2/3] kunit: add log test
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Feb 17, 2020 at 6:28 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> the logging test ensures multiple strings logged appear in the
> log string associated with the test when CONFIG_KUNIT_DEBUGFS is
> enabled.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

One minor comment below.

> ---
>  lib/kunit/kunit-test.c | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
> index aceb5bf..0789060 100644
> --- a/lib/kunit/kunit-test.c
> +++ b/lib/kunit/kunit-test.c
> @@ -329,6 +329,31 @@ static void kunit_resource_test_exit(struct kunit *test)
>         .exit = kunit_resource_test_exit,
>         .test_cases = kunit_resource_test_cases,
>  };
> -kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite);
> +
> +static void kunit_log_test(struct kunit *test)
> +{
> +       kunit_log(KERN_INFO, test, "put this in log.");
> +       kunit_log(KERN_INFO, test, "this too.");
> +
> +#ifdef CONFIG_KUNIT_DEBUGFS
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(test->log, "put this in log."));
> +       KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
> +                                    strstr(test->log, "this too."));
> +#endif
> +}

Would you mind adding some expectations against the suite log? It
might be good for the sake of completeness.

> +
> +static struct kunit_case kunit_log_test_cases[] = {
> +       KUNIT_CASE(kunit_log_test),
> +       {}
> +};
> +
> +static struct kunit_suite kunit_log_test_suite = {
> +       .name = "kunit-log-test",
> +       .test_cases = kunit_log_test_cases,
> +};
> +
> +kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
> +                 &kunit_log_test_suite);
>
>  MODULE_LICENSE("GPL v2");
> --
> 1.8.3.1
>
