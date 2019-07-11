Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC60B652D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2019 10:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbfGKIKV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jul 2019 04:10:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36215 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfGKIKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jul 2019 04:10:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so2386118pfl.3
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jul 2019 01:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJ7vYCdAPuLCapGRPSaARhnlaV4Ty17w22yZ+g3QAz4=;
        b=op8KyGONrSDXlvwCBwG3YIhe2wB8O/Dx8Ab+bYBOigybwZNM8zILaZq+1qvlRIbT76
         OdcWqx7WW8ObCxZiJwlccFrCIaTQaNAJYUX9EwEvsMkl60JkEFqjkIerEMeW86Rzn58Q
         d/OrTTFPVTHnDilI7LmYdJ0XOXbOqPmGxuaZfyJkCcs+2B0Iusxj1zClK4c1CAhpzvsc
         /vHc+k6Xaqlwh9jJIuFQOKnF9o9PG9S95WdAzgWtPgwp0efldUxovLaVJOuQSIJqKcI9
         2mntv6yHvR37/RswRb48wU2ZdZ06IDKhsjB91VuSGZY8Wi0p/MsnPKjdgfmnx/PfGkq1
         KrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJ7vYCdAPuLCapGRPSaARhnlaV4Ty17w22yZ+g3QAz4=;
        b=VowLWl10o4geLGtPvwltDpIP2o02XRfrJy1DJcr5wQsyEGAEpujm9u+oU7JSLytTpi
         P4ebijpR+HisFwEU46tc8VXePlai34x3bV8tLDt9MxntYZPt/+Zle3Yt3gX5yegbWOzo
         zXN2IZk+Rtjlfp2knyg+0AjatDeyj/s2bd4VykCdkODLNCDBndDvNV/QPvXhyFHvD4Tg
         ZDGStZRi+q3Src+Qv3VntnnIKi55NLcZN0zrHlHSlkPdy3XSfiG5qM2tYCOPT9NMHAXK
         3XrKVAQPlT/5u33tpbI3+cudUek59O8EGTS44PLFlnzjzwVMEMKw8EXraDyyk+3Ggsvi
         CSvA==
X-Gm-Message-State: APjAAAX7vWRhOu/Z/JfMsPg4srHhP4SxmdKFpZ21N+tDACCTVNsPmXVn
        P2pVUBPf9IBvRVfykdMVo/e0XrI=
X-Google-Smtp-Source: APXvYqy9MZTz7x+oLIATNCrzKZt5Q0GQ7hHswID3EYNoMiJJwCr6qKpmfNST6s0KSqxdgk9gREgRsg==
X-Received: by 2002:a63:4554:: with SMTP id u20mr3109942pgk.406.1562832620455;
        Thu, 11 Jul 2019 01:10:20 -0700 (PDT)
Received: from chimu.flets-east.jp ([2405:6581:5360:1800:b0a6:d3a0:2355:6c2b])
        by smtp.gmail.com with ESMTPSA id h21sm4959042pgg.75.2019.07.11.01.10.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 01:10:19 -0700 (PDT)
From:   Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
To:     linux-kselftest@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: [PATCH] selftests: breakpoints: Fix compile error with arun_test()
Date:   Thu, 11 Jul 2019 17:10:09 +0900
Message-Id: <20190711081009.31808-1-iwamatsu@nigauri.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

By undefined run_test(), compile of breakpoint_test_arm64.c fails.
This changes arun_test to run_test.

----
reakpoint_test_arm64.c: In function 'main':
breakpoint_test_arm64.c:217:14: warning: implicit declaration of function
    'run_test'; did you mean 'arun_test'? [-Wimplicit-function-declaration]
     result = run_test(size, MIN(size, 8), wr, wp);
              ^~~~~~~~
              arun_test
----

Fixes: 5821ba969511 ("selftests: Add test plan API to kselftest.h and adjust callers")
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 tools/testing/selftests/breakpoints/breakpoint_test_arm64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index 58ed5eeab709..ad41ea69001b 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -109,7 +109,7 @@ static bool set_watchpoint(pid_t pid, int size, int wp)
 	return false;
 }
 
-static bool arun_test(int wr_size, int wp_size, int wr, int wp)
+static bool run_test(int wr_size, int wp_size, int wr, int wp)
 {
 	int status;
 	siginfo_t siginfo;
-- 
2.20.1

