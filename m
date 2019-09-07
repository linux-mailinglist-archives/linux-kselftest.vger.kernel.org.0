Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D21AC3D2
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2019 03:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405657AbfIGBQp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 21:16:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40196 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405656AbfIGBQo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 21:16:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so5703086pfb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Sep 2019 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CUMLUYw11DOEGaOt2c3KR4xlcT4J6qqAgrc0awCt3Eg=;
        b=vj2w/e5cynYE+vjfAZI2tX5TyOa/eIly90Mtloq9dBUi4zV3OZBAX+V5D5J9JIseOG
         RVAP+maymyZ9QcA4ipuuzzpb8QujB0NJSTP6gzJ2W4XlfE8yzBdlYqE7ZIQnmrCIoSWV
         UqjcrpLJ3/OPmpSyA8sPj/o9pNcrNJ1oM09VH91yWHpK99FK8jHCHOG2Wg8CkgiUP+Np
         5ZNlOa6OKdWi0q6Bvp3WF/SDQT91OEOlcGWS3zIHeWSFX4IZfirFiwDFLqkKA8hR488T
         0bo0DaZwtEwwEMa4OmpA097YR4u1fZA7mJbAHmMihtE/I8Z8uLb0ZDPzxCWg2+x0mkLF
         nHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CUMLUYw11DOEGaOt2c3KR4xlcT4J6qqAgrc0awCt3Eg=;
        b=XuRouJIQMqyjiYmHmzdbiUwBzaReywJm0/I217NnOizk5PLir6nG4AxnB/LJ3FUWQY
         i1VQu+KxhMMUWY0AttQMoAaYBCG9bVvaknj0m3hf4OvKZE+A6CUIyTUKh9ZAvBayvXW0
         Fe8Oh7pmBGbg30tE5FMLxfzL+VhNEse4I4GomyPDtYqkr71c00kyrWSeKgGm/CmChf6g
         0J+4MlrY9kmuYNxIvs8Gxuovf54gYhfetb6CO6a3jpdrHqWsxhQVnWrqTlX2NkucredX
         pAqzRw3m1x7BJM7dcIu/lli9PSQxe6B1uDncFUmQaBUu+sxPCqMKdHqStlM//v3iywbj
         TiHQ==
X-Gm-Message-State: APjAAAViSijBHDlZH+T53opCILDPvmg1WJ0hip04pklo5n9CHSIQ39x/
        UHHbiWG9ZLQNDvOBC7Cj/vJ7PiiUWinUZbXwYyTdPQ==
X-Google-Smtp-Source: APXvYqxR7S1A/sQRfcM0XOrt9xhBDpv1jiYBpo79su3QI6BNtMNGtX/Qi3gydenKSctOVWxhVYDRklQXBkHTIDB5eKo=
X-Received: by 2002:a63:205f:: with SMTP id r31mr3094032pgm.159.1567819003432;
 Fri, 06 Sep 2019 18:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
 <1567786314-12330-1-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1567786314-12330-1-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 6 Sep 2019 18:16:32 -0700
Message-ID: <CAFd5g44=8TV4VciMkcD2DHR+UsnpwyEFbw2Xucwo7-as6Py_4g@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 6, 2019 at 9:12 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> Running kunit with '--build_dir' option gives following error message:
>
> ```
> $ ./tools/testing/kunit/kunit.py run --build_dir ../linux.out.kunit/
> [00:57:24] Building KUnit Kernel ...
> [00:57:29] Starting KUnit Kernel ...
> Traceback (most recent call last):
>   File "./tools/testing/kunit/kunit.py", line 136, in <module>
>     main(sys.argv[1:])
>   File "./tools/testing/kunit/kunit.py", line 129, in main
>     result = run_tests(linux, request)
>   File "./tools/testing/kunit/kunit.py", line 68, in run_tests
>     test_result = kunit_parser.parse_run_tests(kunit_output)
>   File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
> 283, in parse_run_tests
>     test_result =
> parse_test_result(list(isolate_kunit_output(kernel_output)))
>   File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
> 54, in isolate_kunit_output
>     for line in kernel_output:
>   File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
> 145, in run_kernel
>     process = self._ops.linux_bin(args, timeout, build_dir)
>   File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
> 69, in linux_bin
>     stderr=subprocess.PIPE)
>   File "/usr/lib/python3.5/subprocess.py", line 947, in __init__
>     restore_signals, start_new_session)
>   File "/usr/lib/python3.5/subprocess.py", line 1551, in _execute_child
>     raise child_exception_type(errno_num, err_msg)
> FileNotFoundError: [Errno 2] No such file or directory: './linux'
> ```
>
> This error occurs because the '--build_dir' option value is not passed
> to the 'run_kernel()' function.  Consequently, the function assumes
> the kernel image that built for the tests, which is under the
> '--build_dir' directory, is in kernel source directory and finally raises
> the 'FileNotFoundError'.
>
> This commit fixes the problem by properly passing the '--build_dir'
> option value to the 'run_kernel()'.
>
> Signed-off-by: SeongJae Park <sj38.park@gmail.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
