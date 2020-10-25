Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772D02983BE
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 22:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418970AbgJYVsu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 17:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409271AbgJYVst (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 17:48:49 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B486C0613CE
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:49 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c15so10708382ejs.0
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5U5b0c60OiFhVBev3K4PZ1W16Gukohw1HLrLU313w4=;
        b=RW8QN6BsYUCXyComtBNVPU+Wuq7tGZce9IKJCqRFMeJFb4UOTB0H+p7OtuKYDOxloX
         SGy4VJSUpLgwmepKy5TB3bPmvKpAf0UdY80LU3u6PbEWPvsBAHGld5F1Tl6wDU1/WBZA
         ieEFEZbBWeNSZo246dtVlZPew5w9JoD84iN9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5U5b0c60OiFhVBev3K4PZ1W16Gukohw1HLrLU313w4=;
        b=RvNrRdoqWD/Be2gQMBJ0fxDiKt+hn9CAxATS0maKIbggfoZ21Iqt+edSEqoX89L2c3
         7kMqqcs+KKOSNVDZ7EdRkhTwGXgSlEqCR8cYoMn8Hs0gsQWEisHAz5+o1fCTMGA5Sv7n
         oJKXxQGcQ1r5fC0r7+DPfh8xzj8/X8K0J4i2+WejEkkmtLoVqmf0eggSsUchAIJ7wq5D
         wSevUZrWS0Xax8LTA2j3AvpvQ4vC1D4XDdM2yyMGPgtNNPcCX7uRqFoaVzj4nKC2Abna
         9ue40RsIT/Ajr656cBEwTTfvevzPxn+HISaXvrIs0htxevbUHN4JyaF+ksnHEu7kKkoj
         MYVQ==
X-Gm-Message-State: AOAM5321Mq5xpHgAtL5SYchmX0M27U6HGW3NGFFfhoUm4Y3psXFPKWFO
        cAmKGvAXYPEVzIABFWNhWR+7Lg==
X-Google-Smtp-Source: ABdhPJwxybB6/16DSKWT5fFJnAy73ROXTKxIaOw0NFDYYHOGwzcOCa8wK+ww7arm7DyMpMYdOTC8YQ==
X-Received: by 2002:a17:906:2987:: with SMTP id x7mr12651220eje.301.1603662527946;
        Sun, 25 Oct 2020 14:48:47 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id k18sm4115867eds.93.2020.10.25.14.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:48:47 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/4] prandom.h: add *_state variant of prandom_u32_max
Date:   Sun, 25 Oct 2020 22:48:39 +0100
Message-Id: <20201025214842.5924-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is useful for test modules that make use of random numbers to allow
the exact same series of test cases to be repeated (e.g., after fixing
a bug in the code being tested). For that, the test module needs to
obtain its random numbers from a private state that can be seeded by a
known seed, e.g. given as a module parameter (and using a random seed
when that parameter is not given).

There's a few test modules I'm going to modify to follow that
scheme. As preparation, add a _state variant of the existing
prandom_u32_max(), and for convenience, also add a variant that
produces a value in a given range.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 include/linux/prandom.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index aa16e6468f91e79e1f31..58ffcd56c705be34fb98 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -46,6 +46,35 @@ static inline u32 prandom_u32_max(u32 ep_ro)
 	return (u32)(((u64) prandom_u32() * ep_ro) >> 32);
 }
 
+/**
+ * prandom_u32_max_state - get pseudo-random number in internal [0, hi)
+ *
+ * Like prandom_u32_max, but use the given state structure.
+ * @state: pointer to state structure
+ * @hi: (exclusive) upper bound
+ *
+ * Exception: If @hi == 0, this returns 0.
+ */
+static inline u32 prandom_u32_max_state(struct rnd_state *state, u32 hi)
+{
+	return ((u64)prandom_u32_state(state) * hi) >> 32;
+}
+
+/**
+ * prandom_u32_range_state - get pseudo-random number in internal [lo, hi)
+ *
+ * @state: pointer to state structure
+ * @lo: (inclusive) lower bound
+ * @hi: (exclusive) upper bound
+ *
+ * Exception: If @lo == @hi, this returns @lo. Results are unspecified
+ * for @lo > @hi.
+ */
+static inline u32 prandom_u32_range_state(struct rnd_state *state, u32 lo, u32 hi)
+{
+	return lo + prandom_u32_max_state(state, hi - lo);
+}
+
 /*
  * Handle minimum values for seeds
  */
-- 
2.23.0

