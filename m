Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9101BABD5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 18:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405908AbfIFQMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 12:12:15 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37274 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfIFQMP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 12:12:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id r195so7735336wme.2;
        Fri, 06 Sep 2019 09:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ILtVojFZTEb8FF/wRJjeokcFy4RpmNFGdpdwHcd1aO8=;
        b=BPdcx31t0hDAFBE30vtwm4hig+o034kYfzODtpi0q5S/KqUMu0s9T0lZ6c+fLDtVtJ
         0ofl7RWMb6D0503ACI4CDIR/YWzvOQ8F1R11iIZo0H/nwwtwDYicX9Z0S3U4DjrWk4Zb
         NDD/ealmzdW9Z/XLlioNmhZTuG22PQFrEFroDRf5qDuQeofz6ogMVFFeFhgaYkeqaQuO
         VKcipF8vE67mcQNeWtOst642MwWKiWCp3+tFAcxaffX7mP7BJFrWQQ/C3Tuj+8SkFO0A
         KBUKM1nmocLAZ2iQKQ/4zqX1HhUlDh+7BuScNAcR4/+qHz9wxH4sH74YPc9fDWvvazpw
         NiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ILtVojFZTEb8FF/wRJjeokcFy4RpmNFGdpdwHcd1aO8=;
        b=IpiYiShyJcLmD+uFERKJSJJG8XxgCHfM6errSFpKPwYKZQ40odUWEBTO0NMPrunUfn
         knvZz+8doIbLljNSuuSWhK3/EDcWb7rvHBGS38yoFpiG8yVwS/zNQPolCLGaWAwN58fp
         6Ax381ojKOFb3STVhTFyg0FM0AuGX7cLqDal4vUVRid0hOh67UbmQG8nM6e9c5i/bsNx
         TmbwzDUhgxU8LRGtZFHN7s4TaaR2bos0emEWqhObJ4DYOHe8jLh+skFCO/Acxs+bbzPz
         2Jr9n0097szNwOHR23/p27eW6VQjXLiQGtYor5n7JlA2kFxgYg5rSR1JOJJFGRTMfsUO
         1APg==
X-Gm-Message-State: APjAAAWKy422kx7RhdEMp/GDgbo4EajaaxtMQMG8wDKy97CmCmI++13f
        uSdUKe6nut+eBRIZ+PcJR7s=
X-Google-Smtp-Source: APXvYqzb4xcjjCICO3KDg3wCqhtGEBriueUximMF6pCjL8W7M1akQCuiDZ68PS4ixXZxskJX7MSLbg==
X-Received: by 2002:a1c:be04:: with SMTP id o4mr8181369wmf.60.1567786332669;
        Fri, 06 Sep 2019 09:12:12 -0700 (PDT)
Received: from localhost.localdomain (bl5-208-252.dsl.telepac.pt. [82.154.208.252])
        by smtp.gmail.com with ESMTPSA id f23sm7198141wmf.1.2019.09.06.09.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Sep 2019 09:12:11 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     shuah@kernel.org, brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sj38.park@gmail.com>
Subject: [PATCH] kunit: Fix '--build_dir' option
Date:   Sat,  7 Sep 2019 01:11:54 +0900
Message-Id: <1567786314-12330-1-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
References: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Running kunit with '--build_dir' option gives following error message:

```
$ ./tools/testing/kunit/kunit.py run --build_dir ../linux.out.kunit/
[00:57:24] Building KUnit Kernel ...
[00:57:29] Starting KUnit Kernel ...
Traceback (most recent call last):
  File "./tools/testing/kunit/kunit.py", line 136, in <module>
    main(sys.argv[1:])
  File "./tools/testing/kunit/kunit.py", line 129, in main
    result = run_tests(linux, request)
  File "./tools/testing/kunit/kunit.py", line 68, in run_tests
    test_result = kunit_parser.parse_run_tests(kunit_output)
  File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
283, in parse_run_tests
    test_result =
parse_test_result(list(isolate_kunit_output(kernel_output)))
  File "/home/sjpark/linux/tools/testing/kunit/kunit_parser.py", line
54, in isolate_kunit_output
    for line in kernel_output:
  File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
145, in run_kernel
    process = self._ops.linux_bin(args, timeout, build_dir)
  File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line
69, in linux_bin
    stderr=subprocess.PIPE)
  File "/usr/lib/python3.5/subprocess.py", line 947, in __init__
    restore_signals, start_new_session)
  File "/usr/lib/python3.5/subprocess.py", line 1551, in _execute_child
    raise child_exception_type(errno_num, err_msg)
FileNotFoundError: [Errno 2] No such file or directory: './linux'
```

This error occurs because the '--build_dir' option value is not passed
to the 'run_kernel()' function.  Consequently, the function assumes
the kernel image that built for the tests, which is under the
'--build_dir' directory, is in kernel source directory and finally raises
the 'FileNotFoundError'.

This commit fixes the problem by properly passing the '--build_dir'
option value to the 'run_kernel()'.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
---
 tools/testing/kunit/kunit.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 8d33980..e016430 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -62,9 +62,11 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 					      'Tests not Parsed.')
 	if request.raw_output:
 		kunit_parser.raw_output(
-			linux.run_kernel(timeout=request.timeout))
+			linux.run_kernel(timeout=request.timeout,
+					 build_dir=request.build_dir))
 	else:
-		kunit_output = linux.run_kernel(timeout=request.timeout)
+		kunit_output = linux.run_kernel(timeout=request.timeout,
+						build_dir=request.build_dir)
 		test_result = kunit_parser.parse_run_tests(kunit_output)
 	test_end = time.time()
 
-- 
2.7.4

