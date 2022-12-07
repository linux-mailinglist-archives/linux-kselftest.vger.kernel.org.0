Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40DB645F2E
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Dec 2022 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiLGQoC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Dec 2022 11:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLGQoA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Dec 2022 11:44:00 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2385D6AE
        for <linux-kselftest@vger.kernel.org>; Wed,  7 Dec 2022 08:43:58 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id c1-20020a2e9d81000000b00279805978a3so5315953ljj.14
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Dec 2022 08:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FMcxzvpQ79NigTE1Z+XywTBOeZAVWjGPGIVGHcTu/LY=;
        b=hB/sk0afJO4g4k73aTVkKJ1vNRhCYGcH2LDEGEF6h0UVflD/+52ZaUq0TwvY/20lIB
         V6Pm/Q6cInPd1VngVfp45sQ9arCcu3CBHL+Nj7lxzVXdU10/6FVwzJnRWROgriBMD3d9
         mvk0pi1qcBr9D7CcHlDHb6JyipEL5TwzF0CballDjeL88MIUVyHqnidLAgBo4va/GztN
         nmYu4nOMyRkrKQ596r/kTMY4z+snc/GTMkVNoUGS87kPV74Rgk3J7cMYgnuoTPgE0Jpe
         F37SUXjpOiiNvsfzW98G05VwdoRbpcXUMtC9BgJmGOxtqOHTNSr6wgahra+KRwFnkTF1
         3pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMcxzvpQ79NigTE1Z+XywTBOeZAVWjGPGIVGHcTu/LY=;
        b=LHbkFFKd97br+WXS0zxrkwgA574m2iPKJPB2pwWN8ENSYBxfPYmcHrz36xO/o5MIfO
         uWKE8AqdD5YOQ7Br/LOGhHPpSMcXjYL2SRhSkZPNDHWbNcavRMCGPm4YsX5wK11rZSNX
         +UZauwp98OwOnsvOVDOzj9xdkaQapveAADZTmZG1G8m2aR5NZO9g1jh6BTomK2e641Cd
         xuLCbzpaVcMuC7buT5a6v4hX+67YdRB5UD/CGY80S0LwI8hH1a6gB22Uh8uQhHkLiGCf
         9wusdS0NsCmdXHIwXxrrKij4eOiw4pXzzdbCTvhEsQ1KY8m3jY+NOtBpP5IUR/peKt6k
         qRAQ==
X-Gm-Message-State: ANoB5pmXH85EBupgqc/YF/EUwfx/YxfDUajKGSZzs+KnpBubWbZC73ys
        fjyOC2B0utqw9iCk+NU3FHCGsbNrpUb/FXPe
X-Google-Smtp-Source: AA0mqf4xrI8w0q5oOG5W2+kw/G/DXZljwzYZt9o7MMuLcR38iNbo42aEEbZZw85XqQVA++M5vTtKinrJ/TIke8AN
X-Received: from mclapinski.waw.corp.google.com ([2a00:79e0:9b:0:3d6d:f78e:bc73:df])
 (user=mclapinski job=sendgmr) by 2002:a05:651c:1586:b0:277:38f:ffad with SMTP
 id h6-20020a05651c158600b00277038fffadmr21919328ljq.439.1670431438583; Wed,
 07 Dec 2022 08:43:58 -0800 (PST)
Date:   Wed,  7 Dec 2022 17:43:38 +0100
In-Reply-To: <20221207164338.1535591-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20221207164338.1535591-1-mclapinski@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221207164338.1535591-3-mclapinski@google.com>
Subject: [PATCH 2/2] selftests/membarrier: Test MEMBARRIER_CMD_GET_REGISTRATIONS
From:   Michal Clapinski <mclapinski@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrei Vagin <avagin@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Keep track of previously issued registrations and compare the result
with MEMBARRIER_CMD_GET_REGISTRATIONS return value.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 .../membarrier/membarrier_test_impl.h         | 33 +++++++++++++++++++
 .../membarrier/membarrier_test_multi_thread.c |  2 +-
 .../membarrier_test_single_thread.c           |  6 +++-
 3 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index 186be69f0a59..af89855adb7b 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -9,11 +9,38 @@
 
 #include "../kselftest.h"
 
+static int registrations;
+
 static int sys_membarrier(int cmd, int flags)
 {
 	return syscall(__NR_membarrier, cmd, flags);
 }
 
+static int test_membarrier_get_registrations(int cmd)
+{
+	int ret, flags = 0;
+	const char *test_name =
+		"sys membarrier MEMBARRIER_CMD_GET_REGISTRATIONS";
+
+	registrations |= cmd;
+
+	ret = sys_membarrier(MEMBARRIER_CMD_GET_REGISTRATIONS, 0);
+	if (ret < 0) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, errno = %d\n",
+			test_name, flags, errno);
+	} else if (ret != registrations) {
+		ksft_exit_fail_msg(
+			"%s test: flags = %d, ret = %d, registrations = %d\n",
+			test_name, flags, ret, registrations);
+	}
+	ksft_test_result_pass(
+		"%s test: flags = %d, ret = %d, registrations = %d\n",
+		test_name, flags, ret, registrations);
+
+	return 0;
+}
+
 static int test_membarrier_cmd_fail(void)
 {
 	int cmd = -1, flags = 0;
@@ -113,6 +140,8 @@ static int test_membarrier_register_private_expedited_success(void)
 	ksft_test_result_pass(
 		"%s test: flags = %d\n",
 		test_name, flags);
+
+	test_membarrier_get_registrations(cmd);
 	return 0;
 }
 
@@ -170,6 +199,8 @@ static int test_membarrier_register_private_expedited_sync_core_success(void)
 	ksft_test_result_pass(
 		"%s test: flags = %d\n",
 		test_name, flags);
+
+	test_membarrier_get_registrations(cmd);
 	return 0;
 }
 
@@ -204,6 +235,8 @@ static int test_membarrier_register_global_expedited_success(void)
 	ksft_test_result_pass(
 		"%s test: flags = %d\n",
 		test_name, flags);
+
+	test_membarrier_get_registrations(cmd);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index ac5613e5b0eb..a9cc17facfb3 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -62,7 +62,7 @@ static int test_mt_membarrier(void)
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(13);
+	ksft_set_plan(16);
 
 	test_membarrier_query();
 
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index c1c963902854..4cdc8b1d124c 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -12,7 +12,9 @@
 int main(int argc, char **argv)
 {
 	ksft_print_header();
-	ksft_set_plan(13);
+	ksft_set_plan(18);
+
+	test_membarrier_get_registrations(/*cmd=*/0);
 
 	test_membarrier_query();
 
@@ -20,5 +22,7 @@ int main(int argc, char **argv)
 
 	test_membarrier_success();
 
+	test_membarrier_get_registrations(/*cmd=*/0);
+
 	return ksft_exit_pass();
 }
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

