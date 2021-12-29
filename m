Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951C5480FD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Dec 2021 06:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbhL2FHj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Dec 2021 00:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhL2FHj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Dec 2021 00:07:39 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA90C061574;
        Tue, 28 Dec 2021 21:07:39 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id x1-20020a17090a2b0100b001b103e48cfaso14028900pjc.0;
        Tue, 28 Dec 2021 21:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjCLCTLgRl+VxxTbnOcpXTd3N8VppC1kQAYRqG5dHQQ=;
        b=lkJTec5XrlABZowPSZtaVmGeqtHP5XS1nfn//31aLqevX3sZ2zK439KIvYuAhDqM87
         jIPpWO2z/3MyxCiyUFRbMFZLupUevtpxRtUl0QK002dZHeYdUQLqYv5Xu3DLoEZaPCe5
         3+C5ttw3YvFhjm2+nHbqO+WcIH6kfgbylXl3/RC90DH0gvlr0zh1mo2/LHqmyvNvrXK1
         Tww3GQ1Dm76xRsZjDTDxpD+tR20rO1j/jyQ7mCHSdpKNi9IvRLytyNkUT4HCvNGUmHkm
         VF2aB7Lt/dIwy7xwrbw3OG4xSEeqmVdxmcPEJ63kxnBOoGEPG2rgnhqQhXoTVG1fXD/+
         3+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjCLCTLgRl+VxxTbnOcpXTd3N8VppC1kQAYRqG5dHQQ=;
        b=UOImRkzYGUX2xbF2GmhM2FnclAOEU9kVQ/Hc04WFhcJ9JRgiCWFFEvBE0MTvC5D6nY
         HMoI4WOZWJbM6IsRUWtQ8kv1WPJ98mdmJ2+BlFp7zgOC6waG/gEiGZimq9W9dHq8f6BN
         /Ia7i9bYfzlc7+6kS0DIcjmmcnZ5wAcU7Wtx5Uq9BF6pxLjN2oCTrxEanv+fYfi+3T79
         gRB3kTti0+QvbU0NuIiSikUqK5EuKjVeU/rRRRN22tXzkvEIfNJPTDzqzyBex6+nzp9a
         sU7dV0soQipNe9eicKS6/8OAq8m9BDConMmHhWSUufYkrxfbzy9cxp7IhLaUmfbUiepD
         G1Lw==
X-Gm-Message-State: AOAM533t3aVEAwa166ne2pJ3KZt4edfpddaR6Yu5X1TnFJtsb4oil6H/
        RTU3oHjsjGZLhYAx7DBvpeM=
X-Google-Smtp-Source: ABdhPJxIGCl+ZtRcKOxpTNiPNB9uGX3m+FSFYvlx8E9fkoGsvQkBf8zdS5Upm50mXOB9DlIKtnAquA==
X-Received: by 2002:a17:90b:4d8a:: with SMTP id oj10mr30644203pjb.4.1640754458843;
        Tue, 28 Dec 2021 21:07:38 -0800 (PST)
Received: from localhost.localdomain ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id w9sm18484274pge.18.2021.12.28.21.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 21:07:38 -0800 (PST)
From:   Tadeusz Struk <tstruk@gmail.com>
To:     jarkko@kernel.org
Cc:     Tadeusz Struk <tstruk@gmail.com>, Shuah Khan <shuah@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: tpm: add async space test with noneexisting handle
Date:   Tue, 28 Dec 2021 21:06:55 -0800
Message-Id: <20211229050655.2030-2-tstruk@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211229050655.2030-1-tstruk@gmail.com>
References: <20211229050655.2030-1-tstruk@gmail.com>
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

