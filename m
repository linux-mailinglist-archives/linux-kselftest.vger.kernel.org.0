Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4588C4EFC9E
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347359AbiDAWKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 18:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353242AbiDAWKs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 18:10:48 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464CA46159
        for <linux-kselftest@vger.kernel.org>; Fri,  1 Apr 2022 15:08:56 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e5so3574518pls.4
        for <linux-kselftest@vger.kernel.org>; Fri, 01 Apr 2022 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lOkjGfGfl98SeySdZvzcrWOJEVOKytJoGvUFiOZ1aAI=;
        b=k3QYjMQbIkpZJu+RzninncrAbEnag3EmGlo4bQTg2Fc2+RK1oPVHKalNH09F6XaLOx
         k24r7rfB5xVIZvuu0s2NKWZ3DovCWTvt6Y0Y9zbNT6yHqQFH7IA3fZLbuFyHZSQeurjy
         G+A9aaph7FDTPINrdzYeKwqcjp/tXVW3oDQfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lOkjGfGfl98SeySdZvzcrWOJEVOKytJoGvUFiOZ1aAI=;
        b=lAKTtmAjQ+sdTyYOxQK03xKhhIUPugijWsaUJq0jKKVPtTAB9jBiyxBYMt5jseCLC1
         egAKdejn7t1WThu2c8CSnWbsbTEGw0fSC2w0qt5DJ1kXUOA+3/k7iCIcDbzTtqe6s4hP
         5Ag757dvwKsxmzEFX7L4FQD+Yz00iZCRPzMbWKzfYORyyP3hL8yINSQ28EAep9C4/tLV
         v9AVAPLDWbF2+DWuCNe4EoZPMp8JyCN1jR9BtSbehGuUHsy9NQi1FXYTFuxB/eFH+RD/
         S2LDShVqb35SSTpjlt4XErRb0428RGcozQgO0Qmkq1NLu4VfceEmr/OYOaXURUJ1M/ey
         yJ8A==
X-Gm-Message-State: AOAM530xa+e7lk1TOx3tZhoNVV7yOooLz8bd5kcZNMrX75KoD2hPikUq
        2NGGPN5/8oVWeohurPaLYEuXpA==
X-Google-Smtp-Source: ABdhPJw/qfYgMATifUmtsmB46MXU37QSE6npLKOGpPlqsWgKaI76Pgjk/RohjePaQficI+4rGcFbvQ==
X-Received: by 2002:a17:90b:30ca:b0:1c9:a577:5e8c with SMTP id hi10-20020a17090b30ca00b001c9a5775e8cmr14185468pjb.227.1648850935864;
        Fri, 01 Apr 2022 15:08:55 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:72c9:527e:d936:c24b])
        by smtp.gmail.com with UTF8SMTPSA id b19-20020a17090ae39300b001ca070d9dafsm8369294pjz.19.2022.04.01.15.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 15:08:55 -0700 (PDT)
From:   Daniel Verkamp <dverkamp@chromium.org>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH 4/4] selftests/memfd: add tests for MFD_NOEXEC
Date:   Fri,  1 Apr 2022 15:08:34 -0700
Message-Id: <20220401220834.307660-5-dverkamp@chromium.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
In-Reply-To: <20220401220834.307660-1-dverkamp@chromium.org>
References: <20220401220834.307660-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests that ensure MFD_NOEXEC memfds have the appropriate mode bits and
cannot be chmod-ed into being executable.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 tools/testing/selftests/memfd/memfd_test.c | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index fdb0e46e9df9..a79567161cdf 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -32,6 +32,10 @@
 #define F_SEAL_EXEC	0x0020
 #endif
 
+#ifndef MFD_NOEXEC
+#define MFD_NOEXEC	0x0008U
+#endif
+
 /*
  * Default is not to test hugetlbfs
  */
@@ -959,6 +963,35 @@ static void test_seal_exec(void)
 	close(fd);
 }
 
+/*
+ * Test memfd_create with MFD_NOEXEC flag
+ * Test that MFD_NOEXEC applies F_SEAL_EXEC and prevents change of exec bits
+ */
+static void test_noexec(void)
+{
+	int fd;
+
+	printf("%s NOEXEC\n", memfd_str);
+
+	/* Create with NOEXEC and ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_NOEXEC);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	/* Create with NOEXEC but without ALLOW_SEALING */
+	fd = mfd_assert_new("kern_memfd_noexec",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+}
+
 /*
  * Test sharing via dup()
  * Test that seals are shared between dupped FDs and they're all equal.
@@ -1132,6 +1165,7 @@ int main(int argc, char **argv)
 
 	test_create();
 	test_basic();
+	test_noexec();
 
 	test_seal_write();
 	test_seal_future_write();
-- 
2.35.1.1094.g7c7d902a7c-goog

