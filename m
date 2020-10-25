Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D454D2983C5
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Oct 2020 22:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418997AbgJYVs4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Oct 2020 17:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1418983AbgJYVsv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Oct 2020 17:48:51 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C17C0613CE
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:50 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id h24so10656427ejg.9
        for <linux-kselftest@vger.kernel.org>; Sun, 25 Oct 2020 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8eMXvsvg9BKuvbiMtTV/x1wTbSkW08nldOMRM04gVE=;
        b=SgKOIcp7ljjN/k7H6UCS0Y7NynkbWvZVbGPBv2tLe/0Osgbn5xPavA2c4yMo8Y/+kW
         59BpfB8dySKXPrlLmTbc59XTfeHXbzopfaF6Ewe8XJsfr7c7DZSKDQREQ/Qa3ohHDYXq
         ECTPXGt0EIgCUk7P4IwGf/HFPNRoZSKzZVZS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8eMXvsvg9BKuvbiMtTV/x1wTbSkW08nldOMRM04gVE=;
        b=q3vYKSkEFPNqSNg/90OKECOzJMEpC6bKe/35PlgC58yeDNByWUic7K2e+3Mqb97Wah
         GcA1KxSZZE0EdbAcJ+0j4yuUAPRAr6LQgmuRRlp8ndwJLRcaopZx/GLIEcI53cAMEqqh
         bs7ZxZX1mDOyDbYiCVpZzDnE4SebE7yq7zFm4ijC7cwGMWL+yDuqbljqBLVN5qgOxAlN
         +5dOHjEfJfPinuJV+5XPd7j3A2gXqtKKTFNA/BvfQjBRrkmKtebV8uZzX47hjzuQnSSz
         xUuMq9q/L9kqg1U92qJ4ArR3uNRNb+CzLlpGA5p6Bd7EAZ4GK2xWUhGF2LxNHy5D32x7
         xbkg==
X-Gm-Message-State: AOAM533JUhqea3yW/aSHqKRkPecg/AbL4Uk2PyBVYrlz6ZVzJhtvH4nt
        YKUKR8YCmja7KVwEn6ueHybxrw==
X-Google-Smtp-Source: ABdhPJzl65jjUTXLnuyUB4F723Zhjro7B1zyAUTcs9chy30IidECBGQyUpaZmpGerwwbRz0inncydA==
X-Received: by 2002:a17:906:5f96:: with SMTP id a22mr12604437eju.168.1603662528956;
        Sun, 25 Oct 2020 14:48:48 -0700 (PDT)
Received: from prevas-ravi.prevas.se (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id k18sm4115867eds.93.2020.10.25.14.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 14:48:48 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>, Willy Tarreau <w@1wt.eu>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arpitha Raghunandan <98.arpi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 2/4] kselftest_module.h: unconditionally expand the KSTM_MODULE_GLOBALS() macro
Date:   Sun, 25 Oct 2020 22:48:40 +0100
Message-Id: <20201025214842.5924-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
References: <20201025214842.5924-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Two out of three users of the kselftest_module.h header
manually define the failed_tests/total_tests variables instead of
making use of the KSTM_MODULE_GLOBALS() macro. However, instead of
just replacing those definitions with an invocation of that macro,
just unconditionally define them in the header file itself.

A coming change will add a few more global variables, and at least one
of those will be referenced from kstm_report() - however, that's not
possible currently, since when the definition is postponed until the
test module invokes KSTM_MODULE_GLOBALS(), the variable is not defined
by the time the compiler parses kstm_report().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 Documentation/dev-tools/kselftest.rst      | 2 --
 lib/test_bitmap.c                          | 3 ---
 lib/test_printf.c                          | 2 --
 lib/test_strscpy.c                         | 2 --
 tools/testing/selftests/kselftest_module.h | 5 ++---
 5 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a901def730d95ca4c2c1..9899e86ed470ae527fdc 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -281,8 +281,6 @@ A bare bones test module might look like this:
 
    #include "../tools/testing/selftests/kselftest/module.h"
 
-   KSTM_MODULE_GLOBALS();
-
    /*
     * Kernel module for testing the foobinator
     */
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4425a1dd4ef1c7d85973..02fc667a9b3d5d7de7eb 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -16,9 +16,6 @@
 
 #include "../tools/testing/selftests/kselftest_module.h"
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
-
 static char pbl_buffer[PAGE_SIZE] __initdata;
 
 static const unsigned long exp1[] __initconst = {
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 7ac87f18a10ff8209ad5..1ed4a27390cb621715ab 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -30,8 +30,6 @@
 #define PAD_SIZE 16
 #define FILL_CHAR '$'
 
-static unsigned total_tests __initdata;
-static unsigned failed_tests __initdata;
 static char *test_buffer __initdata;
 static char *alloced_buffer __initdata;
 
diff --git a/lib/test_strscpy.c b/lib/test_strscpy.c
index a827f94601f5d945b163..be477a52d87185ee6a01 100644
--- a/lib/test_strscpy.c
+++ b/lib/test_strscpy.c
@@ -10,8 +10,6 @@
  * Kernel module for testing 'strscpy' family of functions.
  */
 
-KSTM_MODULE_GLOBALS();
-
 /*
  * tc() - Run a specific test case.
  * @src: Source string, argument to strscpy_pad()
diff --git a/tools/testing/selftests/kselftest_module.h b/tools/testing/selftests/kselftest_module.h
index e8eafaf0941aa716d9dc..c81c0b0c054befaf665b 100644
--- a/tools/testing/selftests/kselftest_module.h
+++ b/tools/testing/selftests/kselftest_module.h
@@ -9,9 +9,8 @@
  * See Documentation/dev-tools/kselftest.rst for an example test module.
  */
 
-#define KSTM_MODULE_GLOBALS()			\
-static unsigned int total_tests __initdata;	\
-static unsigned int failed_tests __initdata
+static unsigned int total_tests __initdata;
+static unsigned int failed_tests __initdata;
 
 #define KSTM_CHECK_ZERO(x) do {						\
 	total_tests++;							\
-- 
2.23.0

