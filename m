Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE79748FA2A
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jan 2022 02:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbiAPB1V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jan 2022 20:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234022AbiAPB1U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jan 2022 20:27:20 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6EDC061574;
        Sat, 15 Jan 2022 17:27:20 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id s15so6366646pfw.1;
        Sat, 15 Jan 2022 17:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fVNk1oSC2wmUwoQeO0W1p6ZN64nd0MuS2ZCKpwibvj4=;
        b=GNZE6fOKDnUfdraKk5RMFrgn9lwisSNz9qvP3BqHa7m9ijXROEICvFS/tlJWK8yENJ
         DUxZsUOoNoauCkntdnUV+vdr9ED1siJYrLHxrlLJrV40p/bNWNwXPe2n3iz0WpOQzyoG
         Q/rrfTGoFtQKQ8nxsF0FWg0cJoH7Dm7PCbRWeDPIYG5Mx7VEl/llYyqNAUfx2sFLo63/
         KW2ucz0iP3QH/bmMGkbInDU5JhuCZNOFDsTD6N9W5uuzxHIJQeKiqg96AJ+yh1TGSJwW
         u24vuoUUqdoDSyUc8bVXG9Wl0A04BEvpLxXOtE0+niVckGUpF6fqbIgXxw1GEtDqnhKM
         /6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fVNk1oSC2wmUwoQeO0W1p6ZN64nd0MuS2ZCKpwibvj4=;
        b=mjR94hV5zRkHeClYCQI5Ny7ZvflpI2CXrJprFhfUxkPjxf6zA0u8ci/Y17Tm1nE6Ev
         ef7bAJiSjaoFHmyqUlH8Ih2U02KHEf0bnSsTHK7cYU/B8OP0vJsDJH7rDiT/3MARsYIr
         mOOSYSVOdRaWzt1reYFoiOzBvN7MKt+Sy5IDyH2u2kuhdaNX7EXXw12eGJ8UO748TKX1
         8rKigI5bI2DdBJgVn3Y4a+79h3t0krWh1Cw2VGShMZCu4ugZroq1VDqzjJul/7CMkbF2
         lRZCjHu39dmoI4HWkjKQvUfFXu5O4pu8beM3hgy0lyMacagYw3Tzy8TPz6YOo2KwQJTL
         5d6A==
X-Gm-Message-State: AOAM532AUI7Ijg5kIlz+pEwiBxPAHREPhdh85uZSXpzPvgOJmx8qpROq
        JHNPrykwuAk3r+6qPY1oxOemTO3iE/w7xxQRz/8=
X-Google-Smtp-Source: ABdhPJwusC2Ptee2VAtRyN8/4WCPspEyEzpVkFcqIlTzBenyInh58k+gHcrFVc+c2xZNXscINK2gYw==
X-Received: by 2002:a63:6f08:: with SMTP id k8mr13368971pgc.51.1642296439601;
        Sat, 15 Jan 2022 17:27:19 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ot18sm9478939pjb.8.2022.01.15.17.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 17:27:19 -0800 (PST)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Tadeusz Struk <tstruk@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] selftests: tpm: add async space test with noneexisting handle
Date:   Sat, 15 Jan 2022 17:26:27 -0800
Message-Id: <20220116012627.2031-2-tstruk@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220116012627.2031-1-tstruk@gmail.com>
References: <20220116012627.2031-1-tstruk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test for /dev/tpmrm0 in async mode that checks if
the code handles invalid handles correctly.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <linux-integrity@vger.kernel.org>
Cc: <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>

Tested-by: Jarkko Sakkinen<jarkko@kernel.org>
Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
---
Changed in v2:
- Updated commit message
Changed in v3:
- Fixed typo in the function name
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 9d764306887b..340ffef97fb6 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -302,3 +302,19 @@ class AsyncTest(unittest.TestCase):
         log.debug("Calling get_cap in a NON_BLOCKING mode")
         async_client.get_cap(tpm2.TPM2_CAP_HANDLES, tpm2.HR_LOADED_SESSION)
         async_client.close()
+
+    def test_flush_invalid_context(self):
+        log = logging.getLogger(__name__)
+        log.debug(sys._getframe().f_code.co_name)
+
+        async_client = tpm2.Client(tpm2.Client.FLAG_SPACE | tpm2.Client.FLAG_NONBLOCK)
+        log.debug("Calling flush_context passing in an invalid handle ")
+        handle = 0x80123456
+        rc = 0
+        try:
+            async_client.flush_context(handle)
+        except OSError as e:
+            rc = e.errno
+
+        self.assertEqual(rc, 22)
+        async_client.close()
-- 
2.30.2

