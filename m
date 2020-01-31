Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D567514E747
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 03:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgAaCwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 21:52:11 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41097 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgAaCwJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 21:52:09 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so2529394pfw.8
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2020 18:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEAmTEdNizSUWXKdPuS6LL74RLJsP+T/eHBkCvQrdqk=;
        b=YH6f4GSJ+puDeLRjgj4sqKC9rM+5OJMAMj5bNNAd45cq6tZQTvXMo4fghb0bFVA42+
         o/ohcEcjKUtelQb0ZPJAmxNseIaNui1/Rgc317qpwZs2UNJCaQo0HKHtop2sl9EhGO4N
         d7wWKo98hocqI0covxpI/hwF7dc7/W71PHWUbe3cFbVxKW+qDh+vf33eR7LoMTyKUI4k
         hpKX7hyrSPC10XASVqL4BP7QSWFD0Vd+SWPRWPaMw2Hcobh1+IY9a5aWYj08CP2Nh5c/
         cLS4UizbkV2g344TvyJ8+VPhud2IS87QjDrR7kgmOiyq63mCTElGnTXqQWwyaav7ln+b
         48eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEAmTEdNizSUWXKdPuS6LL74RLJsP+T/eHBkCvQrdqk=;
        b=OeA9opH7WV3X/7ar2b/2GUW0mVFgCzxTWZ6Aw5peNY/NIrx2auz45r9MMshnwRUMx/
         nYJrAJX+x1lqAIbugykuIx1eOkdkL9MLTmHDzaTYj/RHUG7LLAv7lN/faB5RSppwz8/N
         zdrNMQq37p4kJO9Ee0IIOGbv+9EPJRgAMHZ3Owv80QdmobUXL73nz+6tkVMaNQjTioJg
         lTi2ARTEEZ/4zdkaW3Z6IThhOwiW103aTZRdehpmZppUCq372al3vWpaAqPvY/2wuykR
         tia+V/hV9uS1ns4ljgs5WRH4Vnx97+AXh+kFGw0HjNfzBk1h/qNsK+bJSQdLhiCb7Iir
         LWPg==
X-Gm-Message-State: APjAAAXiJxgXJGwzPcYzYB1j5sS+jQPLdeuZmyQUJE4+5A0+sIt/XtAa
        JogVM9RKIC56Gzq9494O0JJr6qfCw7ASFvwh2dftgCnqkvg=
X-Google-Smtp-Source: APXvYqyTWwzXtyR6VV/gPEURYRBzZmF1ECoiufrMJUPTEqRROpWZw2y6VmhfY4hH0YNQLvf2eJDbaS0GoaxHCXaeZ/0=
X-Received: by 2002:a63:597:: with SMTP id 145mr7644337pgf.384.1580439127902;
 Thu, 30 Jan 2020 18:52:07 -0800 (PST)
MIME-Version: 1.0
References: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com> <1579805221-31905-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1579805221-31905-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 18:51:56 -0800
Message-ID: <CAFd5g47sbW25MeOs87NuP_kRMNQc0JfiVVDTcLCbNk06KNo-ww@mail.gmail.com>
Subject: Re: [PATCH v2 kunit-next 3/3] kunit: update documentation to describe
 debugfs representation
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 23, 2020 at 10:47 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Documentation should describe debugfs layout and semantics.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  Documentation/dev-tools/kunit/usage.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 7cd56a1..b05c843 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -590,3 +590,22 @@ able to run one test case per invocation.
>
>  .. TODO(brendanhiggins@google.com): Add an actual example of an architecture
>     dependent KUnit test.
> +
> +KUnit debugfs representation
> +============================
> +When kunit test suites are initialized, they create an associated directory
> +in /sys/kernel/debug/kunit/<test-suite>.  The directory contains two files
> +
> +- results: "cat results" displays results of last test run
> +- run: "cat run" runs the test suite and displays the results
> +
> +Thus to re-run all currently loaded suites and display results, we can do this:
> +
> +```
> +$ cat /sys/kernel/debug/kunit/*/run
> +```

This should be in a ".. code-block:: bash", see above in this file for
an example.

> +
> +The debugfs representation is primarily of use when kunit test suites are
> +run in a native environment, either as modules or builtin.  Having a way
> +to display results like this is valuable as otherwise results can be
> +intermixed with other events in dmesg output.
> --
> 1.8.3.1
>
