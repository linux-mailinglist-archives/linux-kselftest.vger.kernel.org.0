Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949A42B7081
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Nov 2020 21:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgKQU5E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Nov 2020 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQU5E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Nov 2020 15:57:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B1AC0617A7
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 12:57:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so18127322pfp.5
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Nov 2020 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf9n4l7EOSL8uXdRL9UcruoyeN94agPo5jcXDhX5nJY=;
        b=jMJNd1lM27olGuBxYU0sDngc2zuZeRq5lDKU5rOo2wtnUwZ4jfa4T725Tygz07t15a
         TU8VyMCTM6dXGgeiravn3uQtZjP7pKLH09v76BS/6su0Z2BSW+JB0UMbeI5eZalXmiF0
         8TSnButTlMZ/XkuaWmMlqSrWxG85xBInJUGVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uf9n4l7EOSL8uXdRL9UcruoyeN94agPo5jcXDhX5nJY=;
        b=bvQP5PqPdAFUbpj8fGFd8GrPbfofhzymwEnO3xXZkg/dUNCIEuDOsDFRFyvHh4tCt0
         +kWnOEHDbJn84W+TbAyqy5x80sUm2IjcG5DtwnTohY/rHy/UJNSX2urY4gqkWR42N/zZ
         Qi8HVVTz5IBgEM69k+gaiQYhnHJURZLFT+VBalM2EuNkHz0oUpNRO6/LIoJU5aFyypFC
         hQic6TCwCgfVo6vhB7RCPYnwLG3UH3Y84a9A8oHFEwuem1H5upikLv7MVMA6g2zPOOe/
         xcJ1zK45kJU7QvD8dkzIgm4zhz+Q6E2ds2XgNKrzxZ19fGYlPPKsIKJ1hY0ywM1Y6rvK
         lYfQ==
X-Gm-Message-State: AOAM533KbJkS20jASl/CGlgW126AHdM+h1FBxRbcmZKZpPpTZQULYZYp
        7VDlKlaJ86jcouZx5RIL2MuAdw==
X-Google-Smtp-Source: ABdhPJw3j1XCkoo/ADs9hWbTzIJn4p6GlAXgdrb/on1MkteJCUDhZcYZTutrBGXrcTCm/MG8EIRZZA==
X-Received: by 2002:a63:1a1e:: with SMTP id a30mr5301001pga.168.1605646623572;
        Tue, 17 Nov 2020 12:57:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12sm4412524pjl.41.2020.11.17.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 12:57:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Rich Felker <dalias@libc.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: sh: Fix register names
Date:   Tue, 17 Nov 2020 12:56:56 -0800
Message-Id: <20201117205656.1000223-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It looks like the seccomp selftests were never actually built for sh.
This fixes it, though I don't have an environment to do a runtime test
of it yet.

Fixes: 0bb605c2c7f2b4b3 ("sh: Add SECCOMP_FILTER")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7f7ecfcd66db..26c72f2b61b1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1804,8 +1804,8 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 #define SYSCALL_RET(_regs)	(_regs).a[(_regs).windowbase * 4 + 2]
 #elif defined(__sh__)
 # define ARCH_REGS		struct pt_regs
-# define SYSCALL_NUM(_regs)	(_regs).gpr[3]
-# define SYSCALL_RET(_regs)	(_regs).gpr[0]
+# define SYSCALL_NUM(_regs)	(_regs).regs[3]
+# define SYSCALL_RET(_regs)	(_regs).regs[0]
 #else
 # error "Do not know how to find your architecture's registers and syscalls"
 #endif
-- 
2.25.1

