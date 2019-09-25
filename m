Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3914FBE8C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2019 01:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbfIYXFJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 19:05:09 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38309 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbfIYXFI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 19:05:08 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so1366933iom.5
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2019 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+b6H124ZTnuWVLwpA+w8I3lt6Bfem5vLH0ApPGFNuR4=;
        b=CEKaiLvSUKGkt9kJikJ4frh0/mKqeP2axdt/8who5BPBFIDeQM39dUFtxSf3ibq+XU
         t9DvdyOX/lF/ZfMY7hJi6Eizlu/gZEyxqUoRwvJKNLKrIq+f5BA2o8cIMfXOv/0S5SdM
         16CkWbqDTanlWQQK554kaOOzjZqaqneNE1aRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+b6H124ZTnuWVLwpA+w8I3lt6Bfem5vLH0ApPGFNuR4=;
        b=EMsD9vgNTaMQCH9s/69sU5aKyaUHRY3fhCxCgjqDbpCjjhWCVwELX9xeMGKdJwyVvM
         kTm6CfTF1ARvRja4x7+85/vlAmGPrw4bxiaO0Im/sALjC0Z0H1js1v2KNzHF6ZLm+FuZ
         XFqrxgJYQxdK8qSCKzJCN7RDLzAwKHD28KBAZgZEzVnR2EXdGeb3XP3XY7xQkpo26R9l
         n9uzUaTaZx1KufuaR9hk2cR4AXqvpKnGhGmVMcbwJZCm7RU/Gej9j6z07tMdBODkjhv/
         6u7EfovqZZ8m5hHKMHUkQVUMm6QZi6WqXkzVNoEVv/ujBxZwxd3C8twwvxjminE2ce0y
         L6Cg==
X-Gm-Message-State: APjAAAXTcJl9NR2oRWmpM7aVm0oSdEBT327D6NWTOLTQQsAK2ZlgeTVM
        BEn0ro3dEn4l1pI52TKOelVZEQ==
X-Google-Smtp-Source: APXvYqyjRRInxClK01iFOyoqVb48oB0vJYhbYNGchBjzPtQmKBhsAVGG+7+KJMKiPJZOg6kqgAf0+Q==
X-Received: by 2002:a02:ac82:: with SMTP id x2mr883743jan.18.1569452707372;
        Wed, 25 Sep 2019 16:05:07 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f23sm70767ioc.36.2019.09.25.16.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 16:05:06 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Makefile: Add kselftest_build target to build tests
Date:   Wed, 25 Sep 2019 17:04:34 -0600
Message-Id: <f13deab77f9e118bd290b6a978734871efac4bf2.1569452305.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1569452305.git.skhan@linuxfoundation.org>
References: <cover.1569452305.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add kselftest_build target to build tests from the top level
Makefile. This is to simplify kselftest use-cases for CI and
distributions where build and test systems are different.

Current kselftest target builds and runs tests on a development
system which is a developer use-case.

This change addresses requests from developers and testers to add
support for building from the main Makefile.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index d456746da347..ac4af6fc4b50 100644
--- a/Makefile
+++ b/Makefile
@@ -1233,6 +1233,10 @@ scripts_unifdef: scripts_basic
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
+PHONY += kselftest_build
+kselftest_build:
+	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests all
+
 PHONY += kselftest
 kselftest:
 	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
-- 
2.20.1

