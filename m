Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307C6787943
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Aug 2023 22:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbjHXU0I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Aug 2023 16:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbjHXUZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Aug 2023 16:25:37 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E471D1FCE;
        Thu, 24 Aug 2023 13:25:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so159111f8f.1;
        Thu, 24 Aug 2023 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692908715; x=1693513515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CT70rySUmSO2bksh3FYToT/efZgAxO1OuH/DvcX6pRY=;
        b=WUSRCgZ5zI1H+MXDszraZ+zjwXXxwh0GZZ0r5TZLdWKZY7ihpxk4c2mSlYd7nz35Wc
         3AGz3QmxoZVe2FsaqxnFxL6rAy10Yoonxp60VYKhLdOTw62NyFmSg6UODsOMMpP+A4Cm
         1v/eK0pHF/UsIuzflUVWa1N8mr/DYTMcAzBFnhRX2Ay2lMgjmdVt1vN2SjInjGz0bhZ0
         7wsSD+C0XbMR51TAwDvZcv8EePYLirQhPA2OiRo4wCYE9Jt3F77gRFMlIJMwuu9EKog9
         8BDVN+tMlUUcxH0+hML4Q94ul6PvaqRkHW/5RHK1RjsSPlAlsGU5T7IvXO9X9lX9FDeR
         UJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692908715; x=1693513515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CT70rySUmSO2bksh3FYToT/efZgAxO1OuH/DvcX6pRY=;
        b=mDprYmcQgvTlIBcCYDw+Fmid2w8oRATRWSBxQyWMsXZsXn1Ogk4Q2BkaDD/InCGMzJ
         4qDdcqSm3Pjd2FBcTG7iTsJdPMEIP+PNyucFUUxRoobTF4rWZ8QmGrVRENrxA2TW1SbY
         n1VZA/8Txq652ghAeoyV1DIPqfAT4WsBMNeAAJbCPHXhJAognPnbv7iqozE5yafEYhPM
         17Gr4Fjor4j35xrExFN5+zAL2hIbt5XqI5w8JWzTdzhpkVuXKeJI8cLbhWeWWg3F+I78
         1vf0qQasWvi9VYYwiVGxG0FCTwbXRbjGvoIKtwKDZ+ycOpTyKuOUwjxu7sA1dDV12ecQ
         X7zA==
X-Gm-Message-State: AOJu0YxxzYwTzzWsYSwa4QPUDcn3aOpCALWLzK2cuYHaVNYBr3CEiFBz
        gXW80pcTmHQilrwJKN2mhlM=
X-Google-Smtp-Source: AGHT+IFVggixjRKv+k1PsUsi/3yPBGxoC4sdW7AW7aYjPdoFyMRrFWA/l3xDWvG7qGe41ZHVQn5tSw==
X-Received: by 2002:a5d:630e:0:b0:314:1ca4:dbd9 with SMTP id i14-20020a5d630e000000b003141ca4dbd9mr12062013wru.27.1692908715030;
        Thu, 24 Aug 2023 13:25:15 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([2001:8f8:1163:806e:f960:7197:6afd:b6ed])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d5405000000b0031435731dfasm150416wrv.35.2023.08.24.13.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 13:25:14 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     keescook@chromium.org, edumazet@google.com,
        willemdebruijn.kernel@gmail.com, wad@chromium.org,
        luto@amacapital.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org, shuah@kernel.org,
        pabeni@redhat.com, linux-kselftest@vger.kernel.org,
        davem@davemloft.net
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>,
        David Laight <David.Laight@aculab.com>
Subject: [PATCH v2 1/2] selftests: Provide local define of min() and max()
Date:   Fri, 25 Aug 2023 00:24:14 +0400
Message-Id: <20230824202415.131824-1-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

to avoid manual calculation of min and max values
and fix coccinelle warnings such WARNING opportunity for min()/max()
adding one common definition that could be used in multiple files
under selftests.
there are also some defines for min/max scattered locally inside sources
under selftests.
this also prepares for cleaning up those redundant defines and include
kselftest.h instead.

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Suggested-by: David Laight <David.Laight@aculab.com>
---
changes in v2:
redefine min/max in a more strict way to avoid 
signedness mismatch and multiple evaluation.
is_signed_type() moved from selftests/kselftest_harness.h 
to selftests/kselftest.h.
---
 tools/testing/selftests/kselftest.h         | 24 +++++++++++++++++++++
 tools/testing/selftests/kselftest_harness.h |  2 --
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 829be379545a..93d029471cc9 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -55,6 +55,30 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#ifndef is_signed_type
+#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+#endif
+
+#ifndef min
+#define min(x, y) ({ \
+	_Static_assert(is_signed_type(typeof(x)) == is_signed_type(typeof(y)), \
+	       "min: signedness mismatch"); \
+	typeof(x) _x = (x); \
+	typeof(y) _y = (y); \
+	_x < _y ? _x : _y; \
+})
+#endif
+
+#ifndef max
+#define max(x, y) ({ \
+	_Static_assert(is_signed_type(typeof(x)) == is_signed_type(typeof(y)), \
+	       "max: signedness mismatch"); \
+	typeof(x) _x = (x); \
+	typeof(y) _y = (y); \
+	_x > _y ? _x : _y; \
+})
+#endif
+
 /*
  * gcc cpuid.h provides __cpuid_count() since v4.4.
  * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5fd49ad0c696..e4e310815226 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -699,8 +699,6 @@
 	if (_metadata->passed && _metadata->step < 253) \
 		_metadata->step++;
 
-#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
-
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
-- 
2.34.1

