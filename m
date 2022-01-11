Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28C548A778
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jan 2022 06:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347404AbiAKFw4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jan 2022 00:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347383AbiAKFw4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jan 2022 00:52:56 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489E3C06173F;
        Mon, 10 Jan 2022 21:52:56 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id r16-20020a17090a0ad000b001b276aa3aabso3171029pje.0;
        Mon, 10 Jan 2022 21:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8izNN1CH17wIIsXqec4/Z1Hegm0aWPFiD659FrlOgN4=;
        b=Jr2c2svWQBxdpk5UMBy3vjw2aqYrWRXYfLOmEwzO6nXxhKrKcvnhX0/iGgCJydkCKP
         NUhkgOVK3sEhwT7Ywdq64Udx7UguuQEB4lsxEb2WDfsx3zfjcTtuLfTRQGrukuC0LpZ4
         6yVHHLJOz26PM82h+eD3JtKFDVW4DbSLYQQREtBqqkMKiyiLRLITOmAJ9qryKbHobpW0
         hzEYlITfBpR+NDEw2JD71NhEs1+13BIfZj3vCGR+rbicy8qC6lojQD/i8ZRs+6cL4pdt
         y9kAqDE38bZBcu9H923uvo4LJ3OwfoGV1FBoqreQnRK/4M4xwZVz2ZzzrIKnd6hkMjsh
         EJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8izNN1CH17wIIsXqec4/Z1Hegm0aWPFiD659FrlOgN4=;
        b=lA9n2RWQ82I7aUdks3gBn7yUd/HRp46R+D/3CSdCrR5U0iMTOI3b4h3StaBrqs7w6g
         tyNLt3VDFM8rIledJTZga0lbFPR4T72FBkYswelDp11jYVg95YpImMuKWL2AQ93bcbYn
         ipS6Fgs+xC4+Wa0krAwp4d6KoQ7Bnp3tLPcaTK8piNy63KQs8qLbrh1NA9l/gfTaeOKy
         uuF74kOJjaIIOBRvqUrpl+To3W/11D/gSORCHRuO/7v7H34EWaXJ8toTxCkfZ40W9ixz
         fR725/4Sj2bhjZqus6dfyOI+Jq2bukZfbBWK/e1CYk2sdf5H3yxlQKM4i7GMARU6aUAD
         6okg==
X-Gm-Message-State: AOAM530AoIo7YjGIedN86j/C3n+vZUt48Jz9TCQ7iAoEmiz1SlB6EQnx
        UOZIfliXfYexgIwdtzLlqzY=
X-Google-Smtp-Source: ABdhPJya9+ka4mTEpG4biB0uvDatieGUdi3kOKWEdH1UE4Ag2RkTU+4+K79+oSOqDsSKi4OHoeno3w==
X-Received: by 2002:a63:7a41:: with SMTP id j1mr2772570pgn.20.1641880375764;
        Mon, 10 Jan 2022 21:52:55 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id k3sm843254pjt.39.2022.01.10.21.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 21:52:55 -0800 (PST)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     jarkko@kernel.org
Cc:     Tadeusz Struk <tstruk@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: tpm: add async space test with noneexisting handle
Date:   Mon, 10 Jan 2022 21:52:28 -0800
Message-Id: <20220111055228.1830-2-tstruk@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220111055228.1830-1-tstruk@gmail.com>
References: <20220111055228.1830-1-tstruk@gmail.com>
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
Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
---
Changes in v2:
- Updated commit message
---
 tools/testing/selftests/tpm2/tpm2_tests.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/tpm2/tpm2_tests.py b/tools/testing/selftests/tpm2/tpm2_tests.py
index 9d764306887b..b373b0936e40 100644
--- a/tools/testing/selftests/tpm2/tpm2_tests.py
+++ b/tools/testing/selftests/tpm2/tpm2_tests.py
@@ -302,3 +302,19 @@ class AsyncTest(unittest.TestCase):
         log.debug("Calling get_cap in a NON_BLOCKING mode")
         async_client.get_cap(tpm2.TPM2_CAP_HANDLES, tpm2.HR_LOADED_SESSION)
         async_client.close()
+
+    def test_flush_invlid_context(self):
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

