Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75B851A16FC
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 22:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDGUtL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 16:49:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41611 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgDGUtL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 16:49:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id a24so1345889pfc.8
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Apr 2020 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XN3Hi/KOGZ4I3yO5TT9h5eYiHzkPBo/PhJqLxBlIoY4=;
        b=rKk9ylpQOyh/46enNtjGZFa/5MvYkhrH6WDL/9+oN7cql79fQ+oIm+TN4nd2qKMwmZ
         Vg0UsmJyOgOGe0kcJv8Kr13xGeJf8ETfBxLMLnPlvTevgBW6WLaWAOuOCjtg/phgjswG
         z7nzQ308dZMQBnlf+D1fMUwS5aBbwaXOyrdkW9fo7pJXpXser616pMV8CVgLpCRfAKQp
         bfttxU5okheUoSjv4RLQnqe8q16nwie7ZZISZWpo+splS0r6/uo1vCwx51Bbb1ARJaok
         zCdlzZpBvfyj+tdyjywsk7UHsOhjpMTzSr4zZxhMqTtAM2GUQDpQfUj4faO8GCvpjUYs
         G4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XN3Hi/KOGZ4I3yO5TT9h5eYiHzkPBo/PhJqLxBlIoY4=;
        b=jfVuewo1VmdjuIHHGntZ16mcPxvHIBxlINP9d5RLkBAYAlScaG2lV00MOBVa84VVWc
         cDd9+ZMHAA7Udj2q8Kk2Ko1W2md8T0zYKMHiq2u/xO/XxzKqPo6H6L8sSeH5awEH5iyf
         50/q3CQavS+RHaT5kNq9T4SQBn6D0RniQY9E2P2jTqt70QYoJ5krMBLNBZdoowl3AIjB
         3ENZFexcf2hpQFZs/VI81rCQFo+qo7j9VaIg7PQAyFtQdYzFnbgy2dS496eKO+rB28C/
         4jnk+Zjlg5VvgNv+FYseWyn2ySugZkQB0tRjQUsR25CxERG1iU9i83qhw13ZhgAyrLmm
         iqtQ==
X-Gm-Message-State: AGi0PuaftH8N2NoFjBsV2iK7+a21ibm5dYR7x/rJN71UgR2VdFqkJiYV
        GM15Iui/oyyT7+gWWJGbg14e8plbfb+zv6nlSdY/tfEp
X-Google-Smtp-Source: APiQypLzsqrQAMnN49p/Mbx+1XZWEuvCQc/OuT39w8Xm/a4wdNkUrqNuxLXXLnb8E5vhcvAPFkuBJ1HdI8F64zBYk+o=
X-Received: by 2002:a63:ff59:: with SMTP id s25mr3823170pgk.159.1586292550382;
 Tue, 07 Apr 2020 13:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200406214130.21224-1-l.rubusch@gmail.com>
In-Reply-To: <20200406214130.21224-1-l.rubusch@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Apr 2020 13:48:59 -0700
Message-ID: <CAFd5g448Qz0bGkNCPR+zS-gH-T9A64L1tExgKb_-jQO3bysGOA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: test.h - fix warnings
To:     Lothar Rubusch <l.rubusch@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Apr 6, 2020 at 2:41 PM Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> Fix several sphinx warnings at 'make htmldocs'
> - privately declared members not correctly declared as such
> - 'suits' actually is not a function parameter, change declaration to fix
>   warning but keep information in comment
>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

Thanks for taking care of this!

> ---
>  include/kunit/test.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 9b0c46a6ca1f..fe4ea388528b 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -175,7 +175,7 @@ struct kunit_suite {
>         void (*exit)(struct kunit *test);
>         struct kunit_case *test_cases;
>
> -       /* private - internal use only */
> +       /* private: internal use only. */
>         struct dentry *debugfs;
>         char *log;
>  };
> @@ -232,7 +232,7 @@ void __kunit_test_suites_exit(struct kunit_suite **suites);
>   * kunit_test_suites() - used to register one or more &struct kunit_suite
>   *                      with KUnit.
>   *
> - * @suites: a statically allocated list of &struct kunit_suite.
> + * suites - a statically allocated list of &struct kunit_suite.

So, I am pretty sure you can name the variadic arguments and then that
gives you a valid parameter to use with kernel doc. Can you try that
out?

>   *
>   * Registers @suites with the test framework. See &struct kunit_suite for

Also, if my suggestion ends up not working, you should change this
line to match.

>   * more information.
> --
> 2.20.1
>
