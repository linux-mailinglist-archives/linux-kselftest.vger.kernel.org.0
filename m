Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E780419346F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 00:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgCYXQy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 19:16:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37829 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYXQy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 19:16:54 -0400
Received: by mail-io1-f65.google.com with SMTP id q9so4186314iod.4
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJCMwzo3yMFuXtW7pmQ5jd39wGw6Oc54qR2LxzO1Ulw=;
        b=C0vyGHrhuZGj6NBfIGYgu9W6dQu/WqogQ8PgukvtDzdgwH5MJd4UYOU2BvbDQei3Cj
         U4dZksYJL8O1gDhykPrmSze2eki/fUQwWLe7KKGwX5/xIryRqRnnvXvbuZRhqNBypZjU
         /G5Fd+n6fKJCONwVzVm9ZD3lYiOCxAk399OA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XJCMwzo3yMFuXtW7pmQ5jd39wGw6Oc54qR2LxzO1Ulw=;
        b=K7D4dDeo2Ywrl1P8XzRxI84QrtkgHxj0UsyD4H+SJ49bPLeEPfbeOZQXmOV4u9bE6f
         eQYuAmQDv84P1kgjExuE1Vu303ZL+hc2Q3UeYm7uh3u0YXFTAzJJxlNDBX4HSphDwdpG
         uladRFV/kdcM+HrCpHUixWPUFKqcEx5X36FnIxPbqe/osd4DEcdIT89ri07ko7AFTk6Z
         oOGwT75o60NmliBH+g+E1kjyOWVTMmirM0XCRMh6uNJH9ys4jUdAKDhNOk9Y54OtuTTE
         hi7Fwaomu7LzkQI0ZwhB7KFiiXBuXYxeUnnJxJLBt0+cUDSdssbj6ER+udwsYLMMfZR/
         vssA==
X-Gm-Message-State: ANhLgQ3LzqCzDVV3guJvw0J8fmm6uhw7qfN6TaJ6cYVHWpMZ8gvlh8h7
        1sYrtUmMtIhTOci8VpLTtzbLPw==
X-Google-Smtp-Source: ADFU+vuDiN8pAems79PXJ/vr0MBd7aVBfGqoYgua2VRPgjMHRcsBA0xkyR8i8tyr3Sdi5Nvq9bXXtQ==
X-Received: by 2002:a02:86:: with SMTP id 128mr1076385jaa.3.1585178213439;
        Wed, 25 Mar 2020 16:16:53 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id u4sm153818ioc.27.2020.03.25.16.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:16:52 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, keescook@chromium.org,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: enforce local header dependency in lib.mk
Date:   Wed, 25 Mar 2020 17:16:49 -0600
Message-Id: <20200325231649.13049-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add local header dependency in lib.mk. This enforces the dependency
blindly even when a test doesn't include the file, with the benefit
of a simpler common logic without requiring individual tests to have
special rule for it.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/lib.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 3ed0134a764d..b0556c752443 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -137,7 +137,8 @@ endif
 # Selftest makefiles can override those targets by setting
 # OVERRIDE_TARGETS = 1.
 ifeq ($(OVERRIDE_TARGETS),)
-$(OUTPUT)/%:%.c
+LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
+$(OUTPUT)/%:%.c $(LOCAL_HDRS)
 	$(LINK.c) $^ $(LDLIBS) -o $@
 
 $(OUTPUT)/%.o:%.S
-- 
2.20.1

