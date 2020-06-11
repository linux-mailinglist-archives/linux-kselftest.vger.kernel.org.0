Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15011F7070
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jun 2020 00:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFKWks (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Jun 2020 18:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgFKWkh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Jun 2020 18:40:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12DFC08C5C5
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u5so3169195pgn.5
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Jun 2020 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lwTXYmugGfPyRmPXLVDMLZeDAwOpJTMJJZD/3cGJRTs=;
        b=lPJU1Y2R2NywIskyfYs77rROpVYDKiNxiU+FtrWqYim2ntaPqIl0oZxPeEtP9GTf1C
         2E8AfFC1z3sz+x3Seh/d0VaZQy6MBLjU+Rwj3Yq5ukGEGN4u8ljUuv7c1Ey1d6Isqj2t
         iGqCwXCUaftykqwKRps/aQXbzP0Hkgml3wSoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lwTXYmugGfPyRmPXLVDMLZeDAwOpJTMJJZD/3cGJRTs=;
        b=j8hpbCXLNjLyZMu6D/HZ0OGjXwdeLIZ7Oo5YFdQFUQTOBCyxJ0KskBC9uxWeqsZuJF
         rz7TjrLDxSqbO9WYSOcTyprTNOSCGkiiBFGpY14GclZpIkyEvMMSjITZfx/NB068y54W
         JOxpBwTFzqQlPP/cKcjU0rj19hOb2Ex4qBYqzEaCsfOt4f8g9eBTJoDedXUSkqqlcq9x
         kZQ0u8VPluAd3Dv1u4JhygwND3O9eWIBnYHGhf5o+eFSb7FlEKjOFuvk5LUsZtreQ55Y
         FDO9y+sEdL+T5RBbTW/K4D5RZaFinEZxYw0IAtqOUacA3d9QHrqWhylrOX2NMKYfaNdE
         155g==
X-Gm-Message-State: AOAM533yYRRdssbwIM3FfZAq4gfJJrEXXaeAX/Il7cl7UgWiyEgLpvmd
        OyFfOdvB6r0zgPS4zjJsmw0dJg==
X-Google-Smtp-Source: ABdhPJxaLlAeRBLlbl1E4AmmW/uBOo/KQCB0mkrVPg0oSPK1ysCZFN+nVdaUrf0lamB1krUMqXB6Gw==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr8608634pgi.215.1591915237243;
        Thu, 11 Jun 2020 15:40:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 9sm4186457pfu.181.2020.06.11.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 15:40:35 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] selftests/harness: Display signed values correctly
Date:   Thu, 11 Jun 2020 15:40:28 -0700
Message-Id: <20200611224028.3275174-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611224028.3275174-1-keescook@chromium.org>
References: <20200611224028.3275174-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since forever the harness output for signed value tests have reported
unsigned values to avoid casting. Instead, actually test the variable
types and perform the correct casts and choose the correct format
specifiers.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 6b06930468e5..8802f20d1915 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -679,17 +679,49 @@
 	if (_metadata->passed && _metadata->step < 255) \
 		_metadata->step++;
 
+#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
+
 #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
 	/* Avoid multiple evaluation of the cases */ \
 	__typeof__(_expected) __exp = (_expected); \
 	__typeof__(_seen) __seen = (_seen); \
 	if (_assert) __INC_STEP(_metadata); \
 	if (!(__exp _t __seen)) { \
-		unsigned long long __exp_print = (uintptr_t)__exp; \
-		unsigned long long __seen_print = (uintptr_t)__seen; \
-		__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
-			 _expected_str, __exp_print, #_t, \
-			 _seen_str, __seen_print); \
+		/* Report with actual signedness to avoid weird output. */ \
+		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
+		case 0: { \
+			unsigned long long __exp_print = (uintptr_t)__exp; \
+			unsigned long long __seen_print = (uintptr_t)__seen; \
+			__TH_LOG("Expected %s (%llu) %s %s (%llu)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 1: { \
+			unsigned long long __exp_print = (uintptr_t)__exp; \
+			long long __seen_print = (intptr_t)__seen; \
+			__TH_LOG("Expected %s (%llu) %s %s (%lld)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 2: { \
+			long long __exp_print = (intptr_t)__exp; \
+			unsigned long long __seen_print = (uintptr_t)__seen; \
+			__TH_LOG("Expected %s (%lld) %s %s (%llu)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		case 3: { \
+			long long __exp_print = (intptr_t)__exp; \
+			long long __seen_print = (intptr_t)__seen; \
+			__TH_LOG("Expected %s (%lld) %s %s (%lld)", \
+				 _expected_str, __exp_print, #_t, \
+				 _seen_str, __seen_print); \
+			break; \
+			} \
+		} \
 		_metadata->passed = 0; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
-- 
2.25.1

