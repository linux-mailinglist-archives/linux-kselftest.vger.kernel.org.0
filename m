Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABE43D19D
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 21:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbhJ0T2u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 15:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239173AbhJ0T2s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 15:28:48 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C87EC061570
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 12:26:22 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id w15so4167660ilv.5
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e5YZjIqFS3XEM8PNKx7ucxOOTkjl+7hvUjE9ax3Rto=;
        b=SAc4jpTlJZ5sfMgAG4HnrkkNmqiWa6azmcMKvJMA03VZnqOQ0gsUv/p0VVmLew6oDj
         dNvuJKiOix7Ypt6QqbN9kbd7EX8r61IHAf01YKPIi7pdeMKOc68DddbS2TTVPHer/h0T
         sPLJf/xodHmfyCWK7PbJfKtc0pA12FcAlH4PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/e5YZjIqFS3XEM8PNKx7ucxOOTkjl+7hvUjE9ax3Rto=;
        b=I8W4li5AduvM2A33xRI6BmE81IOIeBQyA+9zpAN341yRqssSzMNnsrssMrQqP1hp3A
         xy/GKN3Lw2sPhzK0znqIxFFK8vBGYoje+MNdEUik2WOxSOysSzFuC5yYhA3gt/4+bcgh
         fJ6KFLu9lEgCIymSzjOWAoTInSEnTX12sgYAXRtodHcJ117Hpfjgz4RNwHaSae9OtK/5
         PCdVSrWDzNOCtESUC4O6hRilDTAqOrguhOFVhITqJ4/xX1p/mZ5B0IPYpm8TYL73wV6M
         dUDsNoCslvV6vLdV/ar2bkG8U27qUoQARRUbI6fjJE764QaFoAA33mETIblwL3uQCr7Q
         6rPg==
X-Gm-Message-State: AOAM533qG9Lb3KRgmo5WvxVMKlUxAS+9WXNCE9elcyVdL5yXrGHkOuJb
        WNgKsQL0aGOfqp+6QtiDeoKqvA==
X-Google-Smtp-Source: ABdhPJxaaXFdZYD44Y9Hl85VrAmCVXcDpARlqiFpS4FLbe06gx8CH2vrI0MnmsIH1AagHnB+qQOW6w==
X-Received: by 2002:a05:6e02:190f:: with SMTP id w15mr8451092ilu.121.1635362781924;
        Wed, 27 Oct 2021 12:26:21 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id w11sm377796ior.40.2021.10.27.12.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 12:26:21 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, christian.brauner@ubuntu.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/core: fix conflicting types compile error for close_range()
Date:   Wed, 27 Oct 2021 13:26:19 -0600
Message-Id: <20211027192619.21813-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

close_range() test type conflicts with close_range() library call in
x86_64-linux-gnu/bits/unistd_ext.h. Fix it by changing the name to
core_close_range().

gcc -g -I../../../../usr/include/    close_range_test.c  -o ../tools/testing/selftests/core/close_range_test
In file included from close_range_test.c:16:
close_range_test.c:57:6: error: conflicting types for ‘close_range’; have ‘void(struct __test_metadata *)’
   57 | TEST(close_range)
      |      ^~~~~~~~~~~
../kselftest_harness.h:181:21: note: in definition of macro ‘__TEST_IMPL’
  181 |         static void test_name(struct __test_metadata *_metadata); \
      |                     ^~~~~~~~~
close_range_test.c:57:1: note: in expansion of macro ‘TEST’
   57 | TEST(close_range)
      | ^~~~
In file included from /usr/include/unistd.h:1204,
                 from close_range_test.c:13:
/usr/include/x86_64-linux-gnu/bits/unistd_ext.h:56:12: note: previous declaration of ‘close_range’ with type ‘int(unsigned int,  unsigned int,  int)’
   56 | extern int close_range (unsigned int __fd, unsigned int __max_fd,
      |            ^~~~~~~~~~~

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/core/close_range_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 73eb29c916d1..aa7d13d91963 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -54,7 +54,7 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
-TEST(close_range)
+TEST(core_close_range)
 {
 	int i, ret;
 	int open_fds[101];
-- 
2.32.0

