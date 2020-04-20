Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD31B1131
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Apr 2020 18:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgDTQLk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Apr 2020 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725958AbgDTQLk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Apr 2020 12:11:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7885BC061A0C
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 09:11:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h69so5277975pgc.8
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Apr 2020 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEO68H9LWxUP8e7V9qIEZ4RFCwqXB+4bdYHYEcs5ssU=;
        b=AOyItZaa1cf6ofqtJl1E1UyuujFCehxcBbtHwHSAHnRzg2vnQXHPdHcChTJn5kxN6B
         EeaQtKuUJoHl6IN/NzdZb4yITxbBeodZg09MMNGygDJi6GLVqWdqKEkVocOUohoHW2ZL
         vN1pg3ku8nh/exZJjBqI4vltQcqt+HHcThFvVI0908UFCHXjuRwaA+slyK9q+5X5EzLx
         YMf84ZbB0tMIXS0iHwdPDYsVQrNj9Au3ZA0hUd4wwmFWAlHATg6AAwNWvuES33cH/Z9V
         PxEP15DwFmt8eP/WH/znIkz5rx4ogwMRZS9Tlsyf6lLjKD7jZmvPlrl3uUgpUnu79pPH
         5EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEO68H9LWxUP8e7V9qIEZ4RFCwqXB+4bdYHYEcs5ssU=;
        b=O7/CbXrYZt8BOx4OuiqXFNjnnto8XZUi5iL641zKhtvdJ6LZqqhr3hDnAkqpUhaP7L
         4kY97HtiswbYvsNP5hZPU8x06zzXI7Y3LAR/xAFkxQlGCWMU7N8ziOfmgv8rKNqcMLy6
         h8+mHyvdxfhgdOI8hm/KoUiVo716m+wb6no6OlRZzKuKAjcgIUvR0w7NA0KIBLmxNgSX
         6gR9l5n7dnzDro2BWrhuLoFTbzDrb+b1Ub4K1rDkhQS9KIeC9q3cz7WEk1ZZf+vBUEV8
         tL4kwoqtck38uSUnC61hi3Kf+G6OU7EWIQTTj5fufQ3czmX0XgF+aToopgBYYRPziUtu
         naWg==
X-Gm-Message-State: AGi0PuaJJ5jiWiGdr2men04uc2k3S7vXfvOi1g7PQEzWZkvcfSGTMsSc
        cia/HDko+cl06Hm/kMoYJUVlSwkRdnHsiVqIewnYdAA4
X-Google-Smtp-Source: APiQypLk63D8vwXRkZXdPPbMeBIl9gET7jIvY60vpotreHbVObfVflSlVmvHjtNKUDloHkgGG6Vc+AW80Pd0gfR8JaQ=
X-Received: by 2002:a63:1007:: with SMTP id f7mr15218133pgl.384.1587399099757;
 Mon, 20 Apr 2020 09:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200418172554.GA802865@mwanda>
In-Reply-To: <20200418172554.GA802865@mwanda>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 20 Apr 2020 09:11:28 -0700
Message-ID: <CAFd5g46mUAbxtnnEMx2+-mQbryFpr+SENgcvV34kcKsYNy2s_Q@mail.gmail.com>
Subject: Re: [bug report] kunit: test: add support for test abort
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Apr 18, 2020 at 10:26 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Brendan Higgins,
>
> The patch 5f3e06208920: "kunit: test: add support for test abort"
> from Sep 23, 2019, leads to the following static checker warning:
>
>         lib/kunit/try-catch.c:93 kunit_try_catch_run()
>         misplaced newline? '    # %s: Unknown error: %d
>
> lib/kunit/try-catch.c
>     58  void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
>     59  {
>     60          DECLARE_COMPLETION_ONSTACK(try_completion);
>     61          struct kunit *test = try_catch->test;
>     62          struct task_struct *task_struct;
>     63          int exit_code, time_remaining;
>     64
>     65          try_catch->context = context;
>     66          try_catch->try_completion = &try_completion;
>     67          try_catch->try_result = 0;
>     68          task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
>     69                                    try_catch,
>     70                                    "kunit_try_catch_thread");
>     71          if (IS_ERR(task_struct)) {
>     72                  try_catch->catch(try_catch->context);
>     73                  return;
>     74          }
>     75
>     76          time_remaining = wait_for_completion_timeout(&try_completion,
>     77                                                       kunit_test_timeout());
>     78          if (time_remaining == 0) {
>     79                  kunit_err(test, "try timed out\n");
>                                                       ^^
> The kunit_log() macro adds its own newline.  Most of the callers add
> a newline.  It should be the callers add a newline because that's how
> everything else works in the kernel.

Whoops, I thought I removed that extra newline.

Thanks! I will look into this.

> The dev_printk() stuff will sometimes add a newline, but never a
> duplicate newline.  In other words, it's slightly complicated.  But
> basically the caller should add a newline.
>
>     80                  try_catch->try_result = -ETIMEDOUT;
>     81          }
>     82
>     83          exit_code = try_catch->try_result;
>     84
>     85          if (!exit_code)
>     86                  return;
>     87
>     88          if (exit_code == -EFAULT)
>     89                  try_catch->try_result = 0;
>     90          else if (exit_code == -EINTR)
>     91                  kunit_err(test, "wake_up_process() was never called\n");
>                                                                            ^^
>
>     92          else if (exit_code)
>     93                  kunit_err(test, "Unknown error: %d\n", exit_code);
>                                                           ^^
>
>     94
>     95          try_catch->catch(try_catch->context);
>     96  }
>
> regards,
> dan carpenter
