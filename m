Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A671203EF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgFVSRF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbgFVSRC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:17:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A2C061795
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so225666pjv.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rA2WXMqgPYAeqAuK7s/zzGefwkZbfch+R0KvxQ9iJfU=;
        b=VSNzjOCo/0ywmXKgV4GQ/yiHvhW+WvSxetHzcbI+9J9pyZMzQOXBotMwcL1OA4/Ws7
         NcLboXYTqZ2LC8itpaPL8sX7TVp7ckZsfKZL8UpR/MDvbi/3lG4H3QqnAm8UODAkMmqw
         cbr0hY6tyGj2l4YBXUa3dxZdEMNH0jHo14Y3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rA2WXMqgPYAeqAuK7s/zzGefwkZbfch+R0KvxQ9iJfU=;
        b=DQ+D3bOmP8WHcHctk60JUwulTLtkXmOdlLNYFuwXju8pHpH2QzS6KjunH9+SQi5qGe
         0uy67lzzs16suCqAaAz3NX1nkGYM4McsEoUW0A9e6X1sqYcLeZC/jrS+pi6t3ZS4STl2
         Uj2cebuerULE0NOwn3/0SrgqmNuD7ZMnlnVdzSVlnsYzqbZsM0OAjy/DT06VHHy+3kE6
         +PXKEZDBByLnShxsYJO8mVhujao/KzLK9lLR0YaWq9KFtd26tcuGhdzI9YEGLH/7QybU
         YhFy+eIKQZlCx5ZQuOyV5kP5asXWTDiiUwiHrqeB3+u8FvS0JDQ9dJ/OcBkpuElAwjxi
         l7/w==
X-Gm-Message-State: AOAM530dPC7+HC2bYc9CLdZ3o6kVY1j2baXjz2uo/xYzWI7yuu6AwnYs
        l0nJVU/eKU/YYgWf4kDoUufuJA==
X-Google-Smtp-Source: ABdhPJwe2wVGocTiHf38yZGYDVPhtrV4HFUMadNy7uTBj3Dv0xSfNvOjzuem+IAa71O97TpoKdMtpQ==
X-Received: by 2002:a17:902:bb95:: with SMTP id m21mr20430230pls.111.1592849822330;
        Mon, 22 Jun 2020 11:17:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f14sm187660pjq.36.2020.06.22.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:59 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] selftests/harness: Display signed values correctly
Date:   Mon, 22 Jun 2020 11:16:50 -0700
Message-Id: <20200622181651.2795217-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
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

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 42 ++++++++++++++++++---
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b519765904a6..ae51b762d120 100644
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

