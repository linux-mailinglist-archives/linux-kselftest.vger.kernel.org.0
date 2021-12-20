Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A402E47B4F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Dec 2021 22:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhLTVRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Dec 2021 16:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhLTVRp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Dec 2021 16:17:45 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D76AC061574;
        Mon, 20 Dec 2021 13:17:45 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso610385pjc.0;
        Mon, 20 Dec 2021 13:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjCLCTLgRl+VxxTbnOcpXTd3N8VppC1kQAYRqG5dHQQ=;
        b=ac8IzJYL9fsZrjnp07aRRuwJarw9CpkxnWRgt2gsLN7+YZtxatgnFrhEmmdVTSygvU
         fYSUmsF5xfNln8Ak9ZQNfx5FYacSPsgscEfQ/+cKjqm1cEtaXbt+z2eLIm4geBu0WKep
         JkqjufwFbMZfEzf+X+oXhle36as4bY6B77qqu4FSR/V7lWdKxrGpJhL59sHgDCwkJHG5
         OPx/VbopCZd1V+asL/Fqp+96f+2BRpwYKQi9JD6Xshq2BInrCn74A2xSdCV6QBEHrsW4
         d5owDfiIEsPQVFeDxBi0gPt+5KIZvrFJEFL8Abm6X795yK+eAi36RVTbydrYcgowtbwo
         kOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjCLCTLgRl+VxxTbnOcpXTd3N8VppC1kQAYRqG5dHQQ=;
        b=A0Qe6b+57khKiss7v21mZ9v38URK/tCbLxO09zJKKyscGK9ZYnq1gs72pu6bEUFfwM
         f81PGkGalX9N3PyfSPipde1kURZzy887QydB19w8VjjebdblUn1/bT+wxv4eXBe0W09i
         gT9siwqLUqm1jI+Le9SgvfqrbWueMBfUItY1E19aXkmJp0RuM8W9WBVmGBTp1Ehv7M9I
         dIVxgFXXNJJHjQd7ndaFbMPPvr1CMOsKr7ojEHea1SscqJDXkX/WgX/4XnfS/rIM3WJE
         bUeqFRgS+N5y5M6xDdjiFhinJb8vZDFvoZdmG2K1LLUuCh85N7eTw4qxdL7SHqKCVH1I
         NKtA==
X-Gm-Message-State: AOAM533Y0l7DR6CeQorHb/tCYY4h/Zl8v8cGOmuDP2RUQdTPyiInF/q8
        ++JyT139ol6QRCdAD8VWpA4=
X-Google-Smtp-Source: ABdhPJxSz2UePJw+WwNPOXMCXdtfr7R/Dc+IAmsXkeM/vXTRvkUJnFzOC74SfJsVzXxa8C0JK4iVNg==
X-Received: by 2002:a17:90b:3889:: with SMTP id mu9mr77979pjb.160.1640035064527;
        Mon, 20 Dec 2021 13:17:44 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id ot6sm301975pjb.32.2021.12.20.13.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 13:17:44 -0800 (PST)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     jarkko@kernel.org
Cc:     Tadeusz Struk <tstruk@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: tpm: add async space test with noneexisting handle
Date:   Mon, 20 Dec 2021 13:17:00 -0800
Message-Id: <20211220211700.5772-2-tstruk@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211220211700.5772-1-tstruk@gmail.com>
References: <20211220211700.5772-1-tstruk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test for tpm2 spaces in async mode that checks if
the code handles invalid handles correctly.

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: <linux-integrity@vger.kernel.org>
Cc: <linux-kselftest@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Tadeusz Struk <tstruk@gmail.com>
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

