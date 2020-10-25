Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6162983C7
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 22:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418982AbgJYVtA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418975AbgJYVsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 17:48:54 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B47C0613CE
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so7386598edq.4
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOzxSXm+DGRoQV0sCFeUY614U62H2fJhtP9E6Tri+CI=;
        b=DO8DQqwbYycUzHRUdNhG9dr1ti5lEGR2HO916Oncn+gYlMV1VTWMH2xiOwy0qP+bs4
         PAu/zKktPCtkEtJJufdHiqxkftnY+eEyCsGMpqaXmZvr8LrLyoeupnX+ds1aevZKLlY6
         SNj6kz6lI7sd9YTv88UQ1k+yHDlMIcrzo/yag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOzxSXm+DGRoQV0sCFeUY614U62H2fJhtP9E6Tri+CI=;
        b=SbgxdU1A7m3xPEIai5jeUW3KvvOs1OkQs970qlkDIR2kFK3jUigN0pky5WtGyEdMj2
         IQkGed13TMwNZiSCfFyiJFJk1NUNe74P1zvI6RWnYQFdxkOXReXB9f+ctIV/AS19Kja/
         pGx5388vicK9ZUY8ugFIjOtRWUqLVYhSpcpepBSuMBFvf5Z5XQf4+iAuT+1MgTbxRVmw
         d+tVFUaJBCO8W6uJ51Wzv0/RtgU6xMcMfqwbcssOTU1I+pRRH6IBlKpVA3lJc7bAw2nh
         FlTuJGK1PbWG4u6nhBpbe2ezZqutVg5/QAZQD6HLdl2OYtHkuXYviBkqn0fAfWZvxvzT
         xz4Q==
X-Gm-Message-State: AOAM532NpUVLOr8ps82SorESW+3CNTWVR/DbMYaqx60d2jrhk9vac8i4
        Ns9KcbY5PSisETCSdf/0CaBhaQ==
X-Google-Smtp-Source: ABdhPJy2e5d/k6Zop8cdZM0rcepaSTsDLRCzyjrELc9c0jo8dyv11PtAaUz66tipa28fG3ixChKW9w==
X-Received: by 2002:aa7:d28a:: with SMTP id w10mr13156098edq.192.1603662531235;
        Sun, 25 Oct 2020 14:48:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id k18sm4115867eds.93.2020.10.25.14.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:48:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/4] lib/test_printf.c: use deterministic sequence of random numbers
Date:   Sun, 25 Oct 2020 22:48:42 +0100
Message-Id: <20201025214842.5924-5-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The printf test suite does each test with a few different buffer sizes
to ensure vsnprintf() behaves correctly with respect to truncation and
size reporting. It calls vsnprintf() with a buffer size that is
guaranteed to be big enough, a buffer size of 0 to ensure that nothing
gets written to the buffer, but it also calls vsnprintf() with a
buffer size chosen to guarantee the output gets truncated somewhere in
the middle.

That buffer size is chosen randomly to increase the chance of finding
some corner case bug (for example, there used to be some %p<foo>
extension that would fail to produce any output if there wasn't room
enough for it all, despite the requirement of producing as much as
there's room for). I'm not aware of that having found anything yet,
but should it happen, it's annoying not to be able to repeat the
test with the same sequence of truncated lengths.

For demonstration purposes, if we break one of the test cases
deliberately, we still get different buffer sizes if we don't pass the
seed parameter:

root@(none):/# modprobe test_printf
[   15.317783] test_printf: vsnprintf(buf, 18, "%piS|%pIS", ...) wrote '127.000.000.001|1', expected '127-000.000.001|1'
[   15.323182] test_printf: failed 3 out of 388 tests
[   15.324034] test_printf: random seed used was 0x278bb9311979cc91
modprobe: ERROR: could not insert 'test_printf': Invalid argument

root@(none):/# modprobe test_printf
[   13.940909] test_printf: vsnprintf(buf, 22, "%piS|%pIS", ...) wrote '127.000.000.001|127.0', expected '127-000.000.001|127.0'
[   13.944744] test_printf: failed 3 out of 388 tests
[   13.945607] test_printf: random seed used was 0x9f72eee1c9dc02e5
modprobe: ERROR: could not insert 'test_printf': Invalid argument

but to repeat a specific sequence of tests, we can do

root@(none):/# modprobe test_printf seed=0x9f72eee1c9dc02e5
[  448.328685] test_printf: vsnprintf(buf, 22, "%piS|%pIS", ...) wrote '127.000.000.001|127.0', expected '127-000.000.001|127.0'
[  448.331650] test_printf: failed 3 out of 388 tests
[  448.332295] test_printf: random seed used was 0x9f72eee1c9dc02e5
modprobe: ERROR: could not insert 'test_printf': Invalid argument

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 lib/test_printf.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 1ed4a27390cb621715ab..bbea8b807d1eafe67e01 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -24,6 +24,7 @@
 
 #include <linux/property.h>
 
+#define KSTM_RANDOM 1
 #include "../tools/testing/selftests/kselftest_module.h"
 
 #define BUF_SIZE 256
@@ -111,8 +112,14 @@ __test(const char *expect, int elen, const char *fmt, ...)
 	 * be able to print it as expected.
 	 */
 	failed_tests += do_test(BUF_SIZE, expect, elen, fmt, ap);
-	rand = 1 + prandom_u32_max(elen+1);
-	/* Since elen < BUF_SIZE, we have 1 <= rand <= BUF_SIZE. */
+	rand = prandom_u32_range_state(&rnd_state, 1, elen + 1);
+	/*
+	 * Except for elen == 0, we have 1 <= rand <= elen < BUF_SIZE,
+	 * i.e., the output is guaranteed to be truncated somewhere in
+	 * the middle, and we're not pretending the buffer to be
+	 * larger than it really is. For the boring case of elen == 0,
+	 * rand is 1, which is of course also <= BUF_SIZE.
+	 */
 	failed_tests += do_test(rand, expect, elen, fmt, ap);
 	failed_tests += do_test(0, expect, elen, fmt, ap);
 
-- 
2.23.0

