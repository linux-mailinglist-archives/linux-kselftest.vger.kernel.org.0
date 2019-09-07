Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AAAAC57E
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2019 11:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbfIGJI4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 7 Sep 2019 05:08:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44448 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfIGJI4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 7 Sep 2019 05:08:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id u14so8140484ljj.11;
        Sat, 07 Sep 2019 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57pJ4no4y9N9rdXaPnbc6NKFvi7Sztl7VDY6EouK97c=;
        b=sA6scNG5yXnhj8Uegl1+IgPLtcdsp033+yXU14Qvq0obowVGM2Ize3/9ManY4kNpCs
         dNfzGsc+pxK18EAkrX6+NufgjUjrI0qzxG9qcuWwh6VBvpMn5s2y+oD2ClVUNacfcWb/
         jxFMkrex6wCqhSJK5rRS+kWjz8wCaeUq4AvBhhOlLYHZn6u9DEmKcs7VaRCEeGAzpeEo
         9k21j1lkPT+Mp73aaiikYYU1FnhNewBjae9F1IzGk4HPHZWtxa0SsMcqtoVF9RfVf3j/
         /BHqklrPJIBA6pESqIj7TxlYvejNiubWPEvlSFqEKyal7XjqQ89qXX85g8YvfEUr3yum
         QUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57pJ4no4y9N9rdXaPnbc6NKFvi7Sztl7VDY6EouK97c=;
        b=pzEIZIGsTlJDyCaMKQyM8e6B0IcKa2dFy9x8wtxCaXjJYCqZtAhLq7g/Xh33hoa9zn
         T4/HdmiWd5r/1rBxVFnNFOVcRaTxlbUBIsM0wpgOXN1DRg4Z+yrsCfZFz8qi1Hogfv59
         IKe126tt2hFhogpf7TCH6MwrQ5z1sQ0m5gvcvRoalc9XM6uMgXf/1Anm+X6y9JDPGaYR
         hJiAKt5uw3Ft8XfvLPj36yNJ46xmuEmEA/mmJ+s+MNsRZ67FD4xmr6Bg0+2s6aGX+pNb
         I3DHga36rpbs45zJaRTvW59Wmnq/USQyVfvYCgrdRHelDpUV/rqzYvlQqgg9fT2p8rLQ
         LcNg==
X-Gm-Message-State: APjAAAX+3X/j0IfpJv4hVCcNR3pOaGHbX2/KUghV1/DRZ6d3K6kHkc+L
        KrdxZMDmYjgpnhX2eaDpms/vEwBhsmDDTrE+DLI=
X-Google-Smtp-Source: APXvYqx0vCqXuT6U9buB7r0r2uh65Ik//yileB7tiom+hol9mqP/t6XtaTjNszHtlETH4QtB8/isVNDz0EDrUpQk1+c=
X-Received: by 2002:a2e:9012:: with SMTP id h18mr8660506ljg.45.1567847333996;
 Sat, 07 Sep 2019 02:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
 <1567786314-12330-1-git-send-email-sj38.park@gmail.com> <CAFd5g44=8TV4VciMkcD2DHR+UsnpwyEFbw2Xucwo7-as6Py_4g@mail.gmail.com>
 <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
In-Reply-To: <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Sat, 7 Sep 2019 11:08:27 +0200
Message-ID: <CAEjAshqmSG8FdUvBpv892jvMyWy5=YqXjEEU65=Z=9URBRCQ9A@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     shuah <shuah@kernel.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Sep 7, 2019 at 4:33 AM shuah <shuah@kernel.org> wrote:
>
> On 9/6/19 7:16 PM, Brendan Higgins wrote:
> > On Fri, Sep 6, 2019 at 9:12 AM SeongJae Park <sj38.park@gmail.com> wrote:
> >>
> >> Running kunit with '--build_dir' option gives following error message:
> >>
> >> ```
> >> $ ./tools/testing/kunit/kunit.py run --build_dir ../linux.out.kunit/
> >> [00:57:24] Building KUnit Kernel ...
> >> [00:57:29] Starting KUnit Kernel ...
> >> Traceback (most recent call last):
> >>    File "./tools/testing/kunit/kunit.py", line 136, in <module>
> >>      main(sys.argv[1:])
> >>    File "./tools/testing/kunit/kunit.py", line 129, in main
> >>      result = run_tests(linux, request)
> >>    File "./tools/testing/kunit/kunit.py", line 68, in run_tests
> >>      test_result = kunit_parser.parse_run_tests(kunit_output)
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
> >> 283, in parse_run_tests
> >>      test_result =
> >> parse_test_result(list(isolate_kunit_output(kernel_output)))
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
> >> 54, in isolate_kunit_output
> >>      for line in kernel_output:
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
> >> 145, in run_kernel
> >>      process = self._ops.linux_bin(args, timeout, build_dir)
> >>    File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
> >> 69, in linux_bin
> >>      stderr=subprocess.PIPE)
> >>    File "/usr/lib/python3.5/subprocess.py", line 947, in __init__
> >>      restore_signals, start_new_session)
> >>    File "/usr/lib/python3.5/subprocess.py", line 1551, in _execute_child
> >>      raise child_exception_type(errno_num, err_msg)
> >> FileNotFoundError: [Errno 2] No such file or directory: './linux'
> >> ```
> >>
> >> This error occurs because the '--build_dir' option value is not passed
> >> to the 'run_kernel()' function.  Consequently, the function assumes
> >> the kernel image that built for the tests, which is under the
> >> '--build_dir' directory, is in kernel source directory and finally raises
> >> the 'FileNotFoundError'.
> >>
> >> This commit fixes the problem by properly passing the '--build_dir'
> >> option value to the 'run_kernel()'.
> >>
> >> Signed-off-by: SeongJae Park <sj38.park@gmail.com>
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> > Tested-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > Thanks!
> >
>
> Thanks Brendan! I will apply the patch for 5.4-rc1.

Thank you both!

>
> SeongJae Park! In the future, please send tag versions. This should
> have been [PATCH v2].

Yes, I will.


Thanks,
SeongJae Park

>
> thanks,
> -- Shuah
