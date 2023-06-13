Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A956672E313
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 14:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240399AbjFMMck (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 08:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbjFMMci (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 08:32:38 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF361984
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:36 -0700 (PDT)
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5F1583F12E
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 12:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686659555;
        bh=dOdvEfMQ7tMAD4TKPEtU/Y162rlS8uUUjrZkK5fcMV4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=AlGxmm3NPeRCL5xhakNWS82xNmSaR14dUKKQPuBkVuWCid7HqvkVrKEYdO7q5FlON
         O99Ke98ApBgpYzKu1fAb4PHmrE0jEDnYTWVrIBwT8+Swk+HQp9Gaa4a8j7r/h9rT6l
         wyhrPpi+QXUHE/Zea1oo2bEyrQHN0/40ajcjGT0NLXz/83T+9ToeAP7qQBVJ8YsQIO
         bfCUtLfBEkeP7pKeMW0zZJFiPFBtOvZEAYjapKPVCemzb92UsqGVTPNya3vscmvaHd
         D27emKBX868QMqKmzKVFpkNVR8XsIihvJ1DcfK2Vl9LzaxINv0CXCO8UXpcoR//Kfi
         uBVGWVHzqx8Uw==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-39cb2a0b57aso2682383b6e.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 05:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686659554; x=1689251554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOdvEfMQ7tMAD4TKPEtU/Y162rlS8uUUjrZkK5fcMV4=;
        b=jhRy7xDxrAs0LjqtaHXbfKHHY3xfgqkljti/RteFxuwsX3VmZ+SV+iH9zDEdsqRVyo
         dimzn0KkWKjPM5TjWWux9Mmp8AwrhFihS89ipGhatNRmGamkwUHKFPoXHAeFOp2qkLF8
         dTtd6mYy6ykKa5P0nBz3pXMc8WT5kTWZBtI/NdUYuum+Qol8KXlpd5xmTE3iuPobmC0+
         AgJlHxwYPiVUUUg98wsHLcnYVx/lbWtPT01Bb5oyqqbfe9vzIdqkXGvVHVEbJuXMakLt
         9kx0oIY1P70QOk6GofZXCfzSFj1vawtxmBf89JFompqGSvXSEKKHlLQil/A9i272FHTE
         t8TQ==
X-Gm-Message-State: AC+VfDzIN5TR4J/RG+aBdhtb9boF98G+NPWRw8CVYAg9wlh7HkE6MpNv
        dB9Zk5Vb1oNwvm982tjupdSTsN5Evuecym1z6HGp6xVccdViP5KemOm7OUCRXrFvqwbn/nNrIWb
        FkrusK8U5spQnakhA9yQH+PBq5vvzYW3IOuf2bg7/8RAUMA==
X-Received: by 2002:a05:6808:2221:b0:39a:7830:f250 with SMTP id bd33-20020a056808222100b0039a7830f250mr9033212oib.1.1686659553990;
        Tue, 13 Jun 2023 05:32:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7RoHcGYWIZgUHJeY1UXV78LS1K1+OSDeyiYBqiHZ01bS5tDwNvQAEjex3yls8V+mcmzqTp4w==
X-Received: by 2002:a05:6808:2221:b0:39a:7830:f250 with SMTP id bd33-20020a056808222100b0039a7830f250mr9033195oib.1.1686659553771;
        Tue, 13 Jun 2023 05:32:33 -0700 (PDT)
Received: from magali.. ([2804:14c:bbe3:4606:ac1a:e505:990c:70e9])
        by smtp.gmail.com with ESMTPSA id z26-20020a056808049a00b0039c532c9ae1sm4838116oid.55.2023.06.13.05.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 05:32:33 -0700 (PDT)
From:   Magali Lemes <magali.lemes@canonical.com>
To:     keescook@chromium.org, shuah@kernel.org
Cc:     andrei.gherzan@canonical.com, netdev@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] selftests/harness: allow tests to be skipped during setup
Date:   Tue, 13 Jun 2023 09:32:19 -0300
Message-Id: <20230613123222.631897-2-magali.lemes@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613123222.631897-1-magali.lemes@canonical.com>
References: <20230613123222.631897-1-magali.lemes@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before executing each test from a fixture, FIXTURE_SETUP is run once.
When SKIP is used in FIXTURE_SETUP, the setup function returns early
but the test still proceeds to run, unless another SKIP macro is used
within the test definition, leading to some code repetition. Therefore,
allow tests to be skipped directly from the setup function.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Magali Lemes <magali.lemes@canonical.com>
---
No change in v4.

Changes in v3:
 - Add this patch.

 tools/testing/selftests/kselftest_harness.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index d8bff2005dfc..5fd49ad0c696 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -249,7 +249,7 @@
 
 /**
  * FIXTURE_SETUP() - Prepares the setup function for the fixture.
- * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
+ * *_metadata* is included so that EXPECT_*, ASSERT_* etc. work correctly.
  *
  * @fixture_name: fixture name
  *
@@ -275,7 +275,7 @@
 
 /**
  * FIXTURE_TEARDOWN()
- * *_metadata* is included so that EXPECT_* and ASSERT_* work correctly.
+ * *_metadata* is included so that EXPECT_*, ASSERT_* etc. work correctly.
  *
  * @fixture_name: fixture name
  *
@@ -388,7 +388,7 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-			if (!_metadata->passed) \
+                       if (!_metadata->passed || _metadata->skip) \
 				return; \
 			_metadata->setup_completed = true; \
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
-- 
2.34.1

