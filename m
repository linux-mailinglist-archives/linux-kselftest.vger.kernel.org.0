Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04210F7EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 07:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfLCGlC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 01:41:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37946 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfLCGlC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 01:41:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id l4so1108582pjt.5
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txqB93EC07vnRxRZaCApt0VS2Bxm0RCf+BrdUWlZ5n8=;
        b=mQgWYUsazi3iLKeYXps0csdlVmrHlYsQ8PPJW+N+TvkqBxRZLF3r9hThklk0JAeT/E
         95g4K9LXGYqaiyl3PMjAA8hEHNCwh0BHK3lCTFehF1JZCKBWQHbkK6vJgg494kuCoDG0
         llgHa+eD0gQ3/JVO/nYpmFM2RtR0AE9/LCgiwjx4ateE5sRsltCWYyijqdVXbwi+HRes
         vAHJESd5WrwgpkCCzoDg870kMIk27sNmUhT66e6ZAP2rm/l3UZyLLgaVD9YwyJnpCc/5
         27YtK8VqP5y5D1N+TabQGA+Y7kir+ClhGf7zWb5Uesoh0JkPs0xH/jNkTmocqNFHv3Oy
         ZduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txqB93EC07vnRxRZaCApt0VS2Bxm0RCf+BrdUWlZ5n8=;
        b=B82GnIw5Fw21vP1xgL7BKBPlLENcHl2XskvqDiwzBQxsH+EbnCi+no47Dbn/rW6lPd
         9/9Sn4sWSSQg0PqbXKhqO37/gjzcx0F6kpq42uE0iM+xGPzTStxzAix5+LjxkZ4FtOKt
         r96hAjpvHhtl89PMf0DpMl5MscBwig3VY5sclUe9aOUjvTuV7V8uK5krKcA+eyfDC3/I
         9bZlT5CTQ34V0c06RgF1pvUlbcqJby3w0xfjS6PCvz+VPWOWNXIrFw0dum6OTdDvPjrL
         5TYyow+y5yelkXBa3tN9upCU5zQQEX/zAW4nTt36ge4/+qM259Py0qGYlVM1tUdq+c1I
         libg==
X-Gm-Message-State: APjAAAUMHunEq5rX7qP2IcWHRo6xyFiYEZIP+7j7q/IXL07FGyEM7f5K
        ZWmE8JZ4qpNWBb1E7cY5PgiG5YBeA68URnk8BpF7Jg==
X-Google-Smtp-Source: APXvYqxFV1COUKvWUrh7FKcPNPvAl5pzHEfFxQVmduhIljm7Zx5aez1Zqxp7kxFQPcnSN/a6hmWpDnEap+IdDr9XjLE=
X-Received: by 2002:a17:902:9f98:: with SMTP id g24mr3446029plq.325.1575355260934;
 Mon, 02 Dec 2019 22:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <1575242724-4937-5-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575242724-4937-5-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 2 Dec 2019 22:40:49 -0800
Message-ID: <CAFd5g46bb_46dCpu3t=qT0FMqifS8wodnhjWC7jfpkuhT1ngAQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] kunit: Create default config in 'build_dir'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> If both '--build_dir' and '--defconfig' are given, the handling of
> '--defconfig' ignores '--build_dir' option.  This commit modifies the
> behavior to respect '--build_dir' option.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/kunit/kunit.py | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index f8f2695..1746330 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -114,6 +114,11 @@ def main(argv, linux=None):
>         cli_args = parser.parse_args(argv)
>
>         if cli_args.subcommand == 'run':
> +               if cli_args.build_dir:
> +                       kunit_kernel.KUNITCONFIG_PATH = os.path.join(

If you are going to modify the value of KUNITCONFIG_PATH can you
rename the variable to make it lower_snake_case? UPPER_SNAKE_CASE in
Python is usually (at least in this directory) used to indicate the
variable is a constant.

> +                               cli_args.build_dir,
> +                               kunit_kernel.KUNITCONFIG_PATH)
> +
>                 if cli_args.defconfig:
>                         create_default_kunitconfig()
>
> --
> 2.7.4
>
