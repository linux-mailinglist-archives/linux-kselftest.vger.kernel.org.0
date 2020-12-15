Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54F2DB42A
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Dec 2020 20:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbgLOS7x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Dec 2020 13:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731797AbgLOS7w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Dec 2020 13:59:52 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE97C06138C
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 10:59:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id m23so6768054ioy.2
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Dec 2020 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=xRj/mOaFoEo9MOuo2TtzraoXsL0t9sn69debK9wpzTg=;
        b=fpX9UTQ3nZP3DUZ4YtdPDi4ST4vPCmj0ViAycBq1SgM2mFujpAA2aoYBAyyeBkpuME
         nACverDmzBWN4S19g0p1wwek0ciDNAsoSHg38STRfqzTafvvK9X5FM/YG8O3/TKio+cG
         BOfb//FiJDfBUyNve89qhhTLBY4jydZ3qh1AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=xRj/mOaFoEo9MOuo2TtzraoXsL0t9sn69debK9wpzTg=;
        b=KIF0kbUnhOBtB1YfHMhndfeOEY0oEPzQlXZrsmf++E741lZK4cp+do2djhvvQw9ZHS
         wcfbDAStraH4DLACg6yZBNBp6jXP/UnoMZ75FvaX1fNM9mwqVzDjg2IKFmI7wFycCXF1
         oT6XwzDE/zL0zYsaSUayL3n591V3/11/jHIxY9wpt7V+I6U/PDCF6hma+kUwHV5xBiSo
         5sXxcns30qKF9p17DvAdPZNRqhkGxroecWpd3Yzg/NJx5aX9S7nKOuQ7CU6fOAKJYsTD
         JG4XH98wo/h8CXpeteZQgWzKIh4EoieymTwxYWAlWsrd/PD9Ue6UA1UbaMV9aMO/PKfS
         ucGQ==
X-Gm-Message-State: AOAM531ADhT8QlXb3fQ04xiyw4isZn5tn0y9VR9DdHGggQuBjUcGi/wQ
        JzW+ZHZXL25nb3Q2NmzuLdB6lA==
X-Google-Smtp-Source: ABdhPJyvNjjulGvfsDY6oyhvQgUpfYmIc26avTIJSt4/zWgESmpu4L/5OtpUJiZybv2o27UN1AwGNA==
X-Received: by 2002:a5e:8344:: with SMTP id y4mr38781968iom.116.1608058751862;
        Tue, 15 Dec 2020 10:59:11 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id l6sm14440517ili.78.2020.12.15.10.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 10:59:10 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.11-rc1
Message-ID: <bd9a480f-80f9-5beb-2f1f-dbc28a7af80c@linuxfoundation.org>
Date:   Tue, 15 Dec 2020 11:59:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2F37C74BE26B0E1B10880709"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F37C74BE26B0E1B10880709
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this Kselftest fixes update for Linux 5.11-rc1.

This Kselftest fixes update for Linux 5.11-rc1 consists of build error
fixes for clone3 and rseq tests.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

   Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.11-rc1

for you to fetch changes up to 88f4ede44c585b24674dd99841040b2a1a856a76:

   selftests/clone3: Fix build error (2020-12-07 14:34:55 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.11-rc1

This Kselftest fixes update for Linux 5.11-rc1 consists of build error
fixes for clone3 and rseq tests.

----------------------------------------------------------------
Xingxing Su (2):
       rseq/selftests: Fix MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ build 
error under other arch.
       selftests/clone3: Fix build error

  tools/testing/selftests/clone3/Makefile   | 2 +-
  tools/testing/selftests/rseq/param_test.c | 4 ++--
  2 files changed, 3 insertions(+), 3 deletions(-)
----------------------------------------------------------------



--------------2F37C74BE26B0E1B10880709
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.11-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.11-rc1.diff"

diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
index ef7564cb7abe..79b19a2863a0 100644
--- a/tools/testing/selftests/clone3/Makefile
+++ b/tools/testing/selftests/clone3/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -g -I../../../../usr/include/
+CFLAGS += -g -std=gnu99 -I../../../../usr/include/
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 384589095864..699ad5f93c34 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1133,6 +1133,8 @@ static int set_signal_handler(void)
 	return ret;
 }
 
+/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
 struct test_membarrier_thread_args {
 	int stop;
 	intptr_t percpu_list_ptr;
@@ -1286,8 +1288,6 @@ void *test_membarrier_manager_thread(void *arg)
 	return NULL;
 }
 
-/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
-#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
 void test_membarrier(void)
 {
 	const int num_threads = opt_threads;

--------------2F37C74BE26B0E1B10880709--
