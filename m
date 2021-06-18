Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA773AD3D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhFRUsV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 16:48:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38650 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbhFRUsV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 16:48:21 -0400
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <seth.forshee@canonical.com>)
        id 1luLMu-0000Nm-1S
        for linux-kselftest@vger.kernel.org; Fri, 18 Jun 2021 20:46:08 +0000
Received: by mail-oi1-f200.google.com with SMTP id v142-20020acaac940000b02901f80189ca30so5468497oie.22
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 13:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVw79iU/33NoUWfSkfo4983/AAm4Rz8I7TNR8nI6E14=;
        b=H7FvUdjqiCiinQbMVyar8l6GjJlN+TQ0+R4kvoabbQpG2rwj+S3yT9WTBcWuJ4PXgI
         5HtDpirj3dMa+IgFTx4xmtt3H/Z3UFb22MVDgwvysm6bEhD/5Dzhdr2h2O7+V8j76skt
         1hGUw2BfW613kdaoP/vqW/9tSIrvpFPEnlZqu+2YC6lKhQ5U0fPZc9o0btdxJyNo0/Gr
         0SfadS64vlck+Oqgj2HGc6GCWnt6FGlxdUIYG+KTaEoXra7N5k+ac9AmKDmcSLRApRrl
         kRD78tMCsG952eF6WgMoYM+eSeWVN/OkkW3qrF2dVIUvyzidqbZgltMmRQXUidP9uFf+
         DW4g==
X-Gm-Message-State: AOAM532IXBOmmqBliF1XYGkXSfo7F6sZaNadxtWRrlG3dbYKbKegwmqP
        rA4GmhA357d3x+4wVFv/dDZe33VJn9EKemTmT1qKQmMkWQY2Gc4t5/55c/vU3jFn3cFDgQWq7w5
        i8OPSHwnKbac2uC4IpP76F3nyTSwoQ4q2Wz9/3PqiEHE9Yg==
X-Received: by 2002:aca:c60c:: with SMTP id w12mr8616542oif.59.1624049134892;
        Fri, 18 Jun 2021 13:45:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmQG5KkxQKSJFYnEV9DPrJ3hC0tOa0J4wPnAYuEpy423vSkcokq3iPbIOf0H1fk4tvtjDwnQ==
X-Received: by 2002:aca:c60c:: with SMTP id w12mr8616531oif.59.1624049134667;
        Fri, 18 Jun 2021 13:45:34 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:ada:6eea:499c:8227])
        by smtp.gmail.com with ESMTPSA id f12sm2238728otc.79.2021.06.18.13.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 13:45:32 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        seth.forshee@canonical.com
Subject: [PATCH] selftests/tls: don't change cipher type in bidirectional test
Date:   Fri, 18 Jun 2021 15:45:32 -0500
Message-Id: <20210618204532.257773-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The bidirectional test attempts to change the cipher to
TLS_CIPHER_AES_GCM_128. The test fixture setup will have already set
the cipher to be tested, and if it was different than the one set by
the bidir test setsockopt() will fail on account of having different
ciphers for rx and tx, causing the test to fail.

Forcing the use of GCM when testing ChaCha doesn't make sense anyway,
so just use the cipher configured by the test fixture setup.

Fixes: 4f336e88a870 ("selftests/tls: add CHACHA20-POLY1305 to tls selftests")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 tools/testing/selftests/net/tls.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 426d07875a48..9f4c87f4ce1e 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -831,23 +831,6 @@ TEST_F(tls, bidir)
 	char const *test_str = "test_read";
 	int send_len = 10;
 	char buf[10];
-	int ret;
-
-	if (!self->notls) {
-		struct tls12_crypto_info_aes_gcm_128 tls12;
-
-		memset(&tls12, 0, sizeof(tls12));
-		tls12.info.version = variant->tls_version;
-		tls12.info.cipher_type = TLS_CIPHER_AES_GCM_128;
-
-		ret = setsockopt(self->fd, SOL_TLS, TLS_RX, &tls12,
-				 sizeof(tls12));
-		ASSERT_EQ(ret, 0);
-
-		ret = setsockopt(self->cfd, SOL_TLS, TLS_TX, &tls12,
-				 sizeof(tls12));
-		ASSERT_EQ(ret, 0);
-	}
 
 	ASSERT_EQ(strlen(test_str) + 1, send_len);
 
-- 
2.31.1

