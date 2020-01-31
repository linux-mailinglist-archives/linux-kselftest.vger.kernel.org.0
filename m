Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 439BB14E740
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 03:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgAaCn0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Jan 2020 21:43:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35947 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgAaCnY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Jan 2020 21:43:24 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so2120824plm.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2020 18:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4suyYkXbNFHJu6nR83esXm6d9jNuI9T+dxjGDdnev+8=;
        b=WgRndJe7v47Sd5/yP+Q2MM4YJxqmiWvh2UEGgG0AViQbhWwmEBFPaAKfION2FVS7vM
         DeMnV7VKkTyn12ER3XedUx11fTwXJrrso9/YYIBmtX2sjyx0WnSgruXE8hUkCspMZIfg
         WtmUfovhPIsCwpcZ0dybIP1DctyTRP5DGTM7wLzk/Y9kimqAZAbUtaIuyKgBBkQ1oPN9
         YQ123dwvHLxsYk2+yIkz6laMaHDJq5Fl964VvHiWRUJFs16thGYLXOPSwIxVXHiup62q
         +TSq8otOdeYdu70rFU5H9JeYYBzpsmYr8CLLzX4nzAPJHTZ14lIDLKx51hgYjSXiIsb2
         2doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4suyYkXbNFHJu6nR83esXm6d9jNuI9T+dxjGDdnev+8=;
        b=pjd9SZb5tiV7oPH10kpeZDe8ruztbcJLdFfRmY7ShQDQJcVa7ec6JqBciGp8YEKLq5
         krJLuQcoDUEIUiBuxj23U7p2cSQFJlaCqCYMnd12QSwterjf5/skDm2cv1g3oXwE8Zfb
         aeB9IwXJQMInqQLmxReOHNAyNVoDCyn4SKZhZLKpsQC82HRA5X4qo0vurl8JzV8g9Go9
         5U+XkoGPdhzS7ASuY/e67+RNuIZu/qbP/zt4DCiAl0dufi4Zrm9uECeUOyMDSzsz8tEO
         nlV2IQfjtS3ljie/VI3pP9/MdujQz5I/AJYXL+i8+xwCvUGantH6+A50VglNHNWl52Cq
         Jg3g==
X-Gm-Message-State: APjAAAXJjRpwlS+c6m/znjA3eurqyBlhLXEr/SzBL9VxaJnm7rihhILm
        ZHcGpvlu1EJzaMTFRxhnC0p0BXBG356v2holI+YC/w==
X-Google-Smtp-Source: APXvYqzLCoqeYEUIdYaVYOZjxilyNPEdVvq+YMaG+ZmOYh6w6fHf++ulv2cYUjgS62K4Xj7BozzSkt4gDyav+dXjIhE=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr7541412plv.297.1580438602920;
 Thu, 30 Jan 2020 18:43:22 -0800 (PST)
MIME-Version: 1.0
References: <1579805221-31905-1-git-send-email-alan.maguire@oracle.com> <1579805221-31905-3-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1579805221-31905-3-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 30 Jan 2020 18:43:11 -0800
Message-ID: <CAFd5g454i8KJPRqXwB8=aU7eTV3YQr_4BTaewKuJYj0VfC13qA@mail.gmail.com>
Subject: Re: [PATCH v2 kunit-next 2/3] kunit: add "run" debugfs file to run
 suites, display results
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
> Add /sys/kernel/debug/kunit/<suite>/run file which will run the
> specified suite and show results.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

If you don't mind, I would like to see the device tree unit test from
Frank before we accept this patch. I definitely like your approach
here, but this would break with KUnit test cases which depend on
__init code and data. I just figure that it would be easier for us to
solve the __init problem now if we have a working example that uses it
rather than having someone who wants to write a test which depends on
__init having to fix this after the fact. Let me know if this is a
problem for you.

> ---
>  lib/kunit/debugfs.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 578843c..1ea3fbc 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -13,6 +13,7 @@
>
>  #define KUNIT_DEBUGFS_ROOT             "kunit"
>  #define KUNIT_DEBUGFS_RESULTS          "results"
> +#define KUNIT_DEBUGFS_RUN              "run"
>
>  /*
>   * Create a debugfs representation of test suites:
> @@ -20,6 +21,7 @@
>   * Path                                                Semantics
>   * /sys/kernel/debug/kunit/<testsuite>/results Show results of last run for
>   *                                             testsuite
> + * /sys/kernel/debug/kunit/<testsuite>/run     Run testsuite and show results
>   *
>   */
>
> @@ -67,6 +69,18 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
>         return 0;
>  }
>
> +/*
> + * /sys/kernel/debug/kunit/<testsuite>/run (re)runs suite and shows all results.
> + */
> +static int debugfs_run_print_results(struct seq_file *seq, void *v)
> +{
> +       struct kunit_suite *suite = (struct kunit_suite *)seq->private;
> +
> +       kunit_run_tests(suite);
> +
> +       return debugfs_print_results(seq, v);
> +}
> +
>  static int debugfs_release(struct inode *inode, struct file *file)
>  {
>         return single_release(inode, file);
> @@ -88,6 +102,22 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
>         .release = debugfs_release,
>  };
>
> +static int debugfs_run_open(struct inode *inode, struct file *file)
> +{
> +       struct kunit_suite *suite;
> +
> +       suite = (struct kunit_suite *)inode->i_private;
> +
> +       return single_open(file, debugfs_run_print_results, suite);
> +}
> +
> +static const struct file_operations debugfs_run_fops = {
> +       .open = debugfs_run_open,
> +       .read = seq_read,
> +       .llseek = seq_lseek,
> +       .release = debugfs_release,
> +};
> +
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>  {
>         /* First add /sys/kernel/debug/kunit/<testsuite> */
> @@ -96,6 +126,9 @@ void kunit_debugfs_create_suite(struct kunit_suite *suite)
>         debugfs_create_file(KUNIT_DEBUGFS_RESULTS, S_IFREG | 0444,
>                             suite->debugfs,
>                             suite, &debugfs_results_fops);
> +       debugfs_create_file(KUNIT_DEBUGFS_RUN, S_IFREG | 0444,
> +                           suite->debugfs,
> +                           suite, &debugfs_run_fops);

Should anyone be able to read this? I think I agree since I am of the
opinion that people shouldn't build or load tests into a production
environment, but still I think it should be brought up.

I was actually talking to David the other day and we had the idea that
maybe KUnit should taint the kernel after tests run or after a
failure. Maybe that might communicate to a user that after running
tests the kernel shouldn't be used for production purposes.
(Obviously, I don't expect you to make that change here, the point of
anyone being able to cause tests to run just made me think of it.)
What do you think?

>  }
>
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
> --
> 1.8.3.1
>
