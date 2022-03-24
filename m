Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0324E6B26
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Mar 2022 00:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355736AbiCXXUq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Mar 2022 19:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355723AbiCXXUp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Mar 2022 19:20:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E553A62
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s72so5033617pgc.5
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Mar 2022 16:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+W+ADoWLoOEU6HBF2tydQ14SzjI5R4yTLibkuVNSzI=;
        b=j81dgt71J0dbVcOzA5AbnzZ2giZC/bZ1k//nKXbyqwAoqAdx7xDLBPE08Y+w6zgljY
         ht+5MxHamQSMEcHb+BnecXhzpA0uEAtXJG+6qN+P64TATCdQttlnTVttQeKgrcG2SxX0
         ydlt4L8mOnm4EhQbR4vnVsmLeN52cxWdvZKt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+W+ADoWLoOEU6HBF2tydQ14SzjI5R4yTLibkuVNSzI=;
        b=UaCRQPxMNgyyKFiAJ/uWZzqsjPzYnaCXuIYEBzgCYfa+UlqjJPce8aeVPnGACYMtEv
         nMdAWyNxawpb0Od0nTTNi7LQVMA0kKhs0RP4pJZDFcaipIVDeH5o3Pf00Lkg4mXk2ePE
         DMip5C3wboEAl7aUhHjwU/v5zeCdXnQS544UhqKYs+FwiKq2PNktCWHRF/OA5GudRkbq
         oLLoCV3PGL40Umdin/wQGCaDybmHYYWtfVAh0cdBTOIXpreUsL238frzMPhhKXjvri3+
         lWCP8q1vCzCwWpkM3C6osbJUrIq0hjXC9Zj6YML/uzvt5gjDYXJ3bSB8sVwfBfq6m7Xu
         9YPg==
X-Gm-Message-State: AOAM532/p/ultMsH9kH3aXtJA9jgZqLibktnBRxsuK4yC25BOwnRYTtc
        t3/Fto1G9wIIgPd7XdIB5fFQ0Q==
X-Google-Smtp-Source: ABdhPJwgn8KFoQhC6OlMAFWWee+pIw34BL/z1l6uAZT83dRmrhlsq00kPIDyo+QLfiGUltyKod5FbQ==
X-Received: by 2002:a65:6753:0:b0:385:fa8a:188f with SMTP id c19-20020a656753000000b00385fa8a188fmr5725762pgu.499.1648163951829;
        Thu, 24 Mar 2022 16:19:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm4445176pfh.83.2022.03.24.16.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 16:19:11 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     shuah@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] selftests/harness: Pass variant to teardown
Date:   Thu, 24 Mar 2022 16:19:07 -0700
Message-Id: <20220324231907.1363887-3-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220324231907.1363887-1-keescook@chromium.org>
References: <20220324231907.1363887-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2243; i=keescook@chromium.org; h=from:subject; bh=s5I+YaMjoeoicBYfZgT6+xmRuT2Bm5TDH0htvPF34tc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiPPxreGpnoDVxBHq9oVJfM656X06ztHfoXOlmN4Yv QJnuxHqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYjz8awAKCRCJcvTf3G3AJnT3D/ 0XU6tnnx16d5AyjCasjLRVDC5yZ/UlbVu0DMwVB+G1AhW8inYAXpheEnmign/IoRe60RQy98YQ6nSb tEKU3X9OgUOyMGUcLNPbe7fCAhyCeqU55cmNOF8T/c0/JQhA1IrlPKTXasQzxr+zyp/lqlq5jC2HNs FqvAVNihqqr0lNTtL8M966mwZJDCPkbT1MzbYNlJ0Ey+oG1Mj5g/QirkhhbAqC/HtHAg9v8As4p/wX q/1dXZp+roY4rcnaT/DK2WarVWsLCqCN23tazgJtdH2xchB/1DWEPypWIe6kOs6PTEj4Z1hSCBUNb/ fuSSKd/GccSxWd7PwA4dO3RzuChOjq8wF7bdozfLbUh7Zqyg7ag7KPYA9hMpN4oeUu9zVRmKH7oA4S Z8bMs2yvv0Fv8B0p9s5h7azjbi281KnpzFjLyuVCPZzw8H7vp+K3IVn7GO1IiW5dB0Vjh3PGAdRc7t 2xVsDe3lgxkEYLqcXtLk/ofsRGhFVrgcrr4dpP4KiqP8k0P2O+wD8yHUjiJPrb7+IyJLEGn/cojpkh DnE5srpBV6ofaLA/BL0HJkIlI2B7ESgczPoo5r2rRtCEfksQYTBoOn6duKvHRTABV8ZFPJXoMfDdrr ez8x6D3Pbk4hJs+wSy/heSsojmeCuuXgNK7jY/XX+ffGM7m/x9GtJkPyD0Aw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Willem de Bruijn <willemb@google.com>

FIXTURE_VARIANT data is passed to FIXTURE_SETUP and TEST_F as "variant".

In some cases, the variant will change the setup, such that expectations
also change on teardown. Also pass variant to FIXTURE_TEARDOWN.

The new FIXTURE_TEARDOWN logic is identical to that in FIXTURE_SETUP,
right above.

Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20201210231010.420298-1-willemdebruijn.kernel@gmail.com
---
 tools/testing/selftests/kselftest_harness.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index bef08f824eb5..f5cb5fd1d974 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -291,7 +291,9 @@
 #define FIXTURE_TEARDOWN(fixture_name) \
 	void fixture_name##_teardown( \
 		struct __test_metadata __attribute__((unused)) *_metadata, \
-		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self)
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
+		const FIXTURE_VARIANT(fixture_name) \
+			__attribute__((unused)) *variant)
 
 /**
  * FIXTURE_VARIANT() - Optionally called once per fixture
@@ -306,9 +308,9 @@
  *       ...
  *     };
  *
- * Defines type of constant parameters provided to FIXTURE_SETUP() and TEST_F()
- * as *variant*. Variants allow the same tests to be run with different
- * arguments.
+ * Defines type of constant parameters provided to FIXTURE_SETUP(), TEST_F() and
+ * FIXTURE_TEARDOWN as *variant*. Variants allow the same tests to be run with
+ * different arguments.
  */
 #define FIXTURE_VARIANT(fixture_name) struct _fixture_variant_##fixture_name
 
@@ -391,7 +393,7 @@
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
 		} \
 		if (_metadata->setup_completed) \
-			fixture_name##_teardown(_metadata, &self); \
+			fixture_name##_teardown(_metadata, &self, variant->data); \
 		__test_check_assert(_metadata); \
 	} \
 	static struct __test_metadata \
-- 
2.32.0

