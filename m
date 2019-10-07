Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F2DCEEC3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfJGWDn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Oct 2019 18:03:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43364 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbfJGWDn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Oct 2019 18:03:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id i32so1728951pgl.10
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Oct 2019 15:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UZGzcGWSg7j1xVwFlul4lYcpfYvPiRRuiper8S6eU8I=;
        b=OHR/EYO3cx6EzPLG+F/+e+l1QFiXnAScx7C66XtHVA4XkmhUKC8GCyCrw7porywgnY
         G52UMxivFJ3ALT04VoTi+K9+uuJlh/wG2mFaMuwE1MEax0cvsjjShc4khXPVh4hHfaPC
         MJWsVeU9IwaEM5alXFzudcZCuLv9f7HlfNXiTVP5q8HP0CMxVn5Z0xvYWY5j4YyIx35n
         skIA2xwOCPTtHRZR9D7bw++okRR0sytqs8Aie70egpUaO4SDNSz5qd63ZmEM5JIYeRP3
         VRvH4ETFFPrsUZ4CTtji1vrAzMLrnv3Bv+stoP0+uZEWJzKMC1E3fng9tz/Q5E9Cgtuh
         0rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZGzcGWSg7j1xVwFlul4lYcpfYvPiRRuiper8S6eU8I=;
        b=PpNUvohDWoiOaf9v1r2ZwhNttTNppzxwEMK/4Gz1iD5QIGAXsbQzv+wh0zvc7BvZMu
         XykGOBa2DrMaGkUqQJlv8LWK3dXhSRMH43v0TY9vV2uQu1mIce4ObSTyMxaipuZ50xNX
         5rd1RW7FjucoKsISixqOKxrLTGRrNrHqwrZJFN6vTEMOzpugZ4jhDsd1RT9JW7pn9VXT
         HE6nwUXR4tpv8Y9Xnf0oNCUjfpfDQ3C4M68iGi+EO34q4A3k3w7WIHMtcvgYR7FTB/4y
         5i2bSk1VTcx7WnveBhYJqpxQoxHCzhOlb8eFEVrchpxYdST8d21pTz3dSRV/iT/GhfkO
         +2pQ==
X-Gm-Message-State: APjAAAWYydWxK6USeND0eVn4QAUZ4B7UGsHvocRQRY1MbquCxDcrrv5k
        /4cS6XKjt8O6Kp/iOMdHON8KeyxLguGr70nbsu8nsA==
X-Google-Smtp-Source: APXvYqymIFmH/VdtekqcD7IGssXBBT3ftOgwACxjQDDGzT3sa3TN5XbpsxVHSgFRKPMOa6CZsa+r/b9Fhw8989/rN3o=
X-Received: by 2002:a63:6641:: with SMTP id a62mr31888287pgc.384.1570485821624;
 Mon, 07 Oct 2019 15:03:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
 <1567786314-12330-1-git-send-email-sj38.park@gmail.com> <CAFd5g44=8TV4VciMkcD2DHR+UsnpwyEFbw2Xucwo7-as6Py_4g@mail.gmail.com>
 <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
In-Reply-To: <1bc1c5da-2810-60d3-4e76-8d0b73fdd521@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 7 Oct 2019 15:03:29 -0700
Message-ID: <CAFd5g47GXbVk4AbRgKb5voG+DLyEEM+KEb+Fgw3u1qjRY2ZhmQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     shuah <shuah@kernel.org>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 6, 2019 at 7:33 PM shuah <shuah@kernel.org> wrote:
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

Shuah, can you apply this to the kselftest KUnit branch? This should
not require a resend.
