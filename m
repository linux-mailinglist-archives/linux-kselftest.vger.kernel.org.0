Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F2487104
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jan 2022 04:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345666AbiAGDH2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jan 2022 22:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiAGDH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jan 2022 22:07:27 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E137C061245;
        Thu,  6 Jan 2022 19:07:27 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 200so4286350pgg.3;
        Thu, 06 Jan 2022 19:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrHlmIX3ye0jx29v1ryUPTnUa+JQoFItY+qNfZbdSu8=;
        b=WT2C/Z93DPpWF4hga6hm/qiEapwtzLQAIigP7KHMqMD40QW1Htj8X5p1+RwT+EhovO
         aTutOXerK0n0j6i93u/kCaZGxea9v2M1BMa3YnzvNV/x5ZrhN4Pe5cj2XIpqfhEMhH3H
         Nyv63niP0L9p0/IWPc6bE5wInzNRVkuCpdGtw7eLHHqCba+i0GkAGq0Q7xnfLTNF8SUx
         1tufdZcX9h6xpewBnwWccpcKuhQsgMnFN9YGZp4syBEAuc8uIPzQvL3z+BDUUPi7WdrT
         PGHz5z5sARFmC/vdRsDP9ED+Tf6vsa+zf5lwbSIzQ7zA5hCZZIdbEpjvqaEVCTqR6SAY
         2sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MrHlmIX3ye0jx29v1ryUPTnUa+JQoFItY+qNfZbdSu8=;
        b=MX+cculV5tP3gtK3tOP1swaWvoOl0ElABfU14umCykzFdU87qBXbp2W3e4E5ey3oj/
         gXzybZP5/5MBOnVY76wSW3F0b8RCX4Tcbkx3F1+a6k6EmhCAHsgF10lkFYBYe5rcilkl
         Y7BV/xLMuIkLnVI/Ple1ZEebVJ1ydFgtraWzxIcpsxrkWbEwlrtUjue7uW3qdlai3zqv
         hO19YkFHX3+KzXK3oujX+4AW4TKfzjrl45HxP1KrqcWQePBCYp1lo08HDhcyAA1KS9wp
         aqG11BVyIUz+Rm7ArmERHsP4e1Z9QgmN16ALxrKyxi51zMPqyuZLyncW8Z256WA2dwrw
         /5FQ==
X-Gm-Message-State: AOAM533OYMIa8F6QmQR3cOqTGcMTI9V9+05sVRwlk7PgQ6ZLioOEPzm5
        KNutcCxgS/uT2t1dSXmNPE0=
X-Google-Smtp-Source: ABdhPJwWxca6Qy0lf9jKV5ryVkTp5hCx2FTfSEvqOCrsTSR8XEBBMjrGh9t24daNdH0PCFUTy74FeQ==
X-Received: by 2002:a63:348a:: with SMTP id b132mr49836144pga.204.1641524847102;
        Thu, 06 Jan 2022 19:07:27 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.38])
        by smtp.googlemail.com with ESMTPSA id s29sm3062584pgo.34.2022.01.06.19.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:07:26 -0800 (PST)
From:   Qinghua Jin <qhjin.dev@gmail.com>
Cc:     Qinghua Jin <qhjin.dev@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: kunit: Fix typo
Date:   Fri,  7 Jan 2022 11:05:53 +0800
Message-Id: <20220107030553.398321-1-qhjin.dev@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix a typo: actualy -> actual

Signed-off-by: Qinghua Jin <qhjin.dev@gmail.com>
---
 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 63f1bb89ebf5..b9940758787c 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -615,7 +615,7 @@ kunit_tool) only fully supports running tests inside of UML and QEMU; however,
 this is only due to our own time limitations as humans working on KUnit. It is
 entirely possible to support other emulators and even actual hardware, but for
 now QEMU and UML is what is fully supported within the KUnit Wrapper. Again, to
-be clear, this is just the Wrapper. The actualy KUnit tests and the KUnit
+be clear, this is just the Wrapper. The actual KUnit tests and the KUnit
 library they are written in is fully architecture agnostic and can be used in
 virtually any setup, you just won't have the benefit of typing a single command
 out of the box and having everything magically work perfectly.
-- 
2.30.2

