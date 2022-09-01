Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6C5A8EF0
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 08:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiIAG7d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 02:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiIAG7c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 02:59:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3813122056
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:59:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u22so16240143plq.12
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=5zD63//05MgDrU1w2Zt/sYyNIOeJWPHdLsrxWSODUj8=;
        b=HQ6lKT5/JNpOCSjvFQwqq00+XvPUxGpOvaNcglNbskGo44IxmXcllioc/YL57N/QAn
         7TspqWbtM/e9SKH9BKSCQEU2CElxpJBiU4AQMiVmQOFQxDIeSxHgClcwubT6Hn+DMA61
         HsHhVtFcb2M81RxDwQzlbQfXdPUn7vdVbIT2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=5zD63//05MgDrU1w2Zt/sYyNIOeJWPHdLsrxWSODUj8=;
        b=WlpY95OAaz9RZrxxua4E+MVNyJro1zaDWEGGRJ3P0lhCSKYgNi9FpbKMEYn0dbVe3s
         sMetJD15PSKoQ/CFlACppyiXa5Vzi+GLo4+BEoo9Qf+nszDRJU1htY4NTpaUWYgNngLD
         e0x055d4ishCk0MZBNs9/zNJlyf7IWCUK9o3P0wqSEny0T5XPUr0c3B41GnkuW7TMokF
         FRb5PHv5FjXeyjRcNmEng/p9JXvcb8BxFqvWjDZ8pqF8QXe3GSTn5NuDXOqFcZdWnXyZ
         X34cAS70lDDD2GB8RizcsjQRBxgr2oTHmCN7QABpgY1Zbcb0IQcLaLR7nE2znj11mh4C
         /Hfw==
X-Gm-Message-State: ACgBeo1BfpolndvXCDFypWIngtuUrvepT37W+8VZRIzW5Q20kertpRBj
        Dh9ff1nbVBMftc+lNUZfLL0BUg==
X-Google-Smtp-Source: AA6agR79zSsv1/U0SFzruYx6/A01jNuVR2BpWmQ8aUjcwvh+CcCv4tLcaj4m9F4AB6asLudvZSc8bQ==
X-Received: by 2002:a17:903:189:b0:175:4643:f862 with SMTP id z9-20020a170903018900b001754643f862mr5762738plg.5.1662015558557;
        Wed, 31 Aug 2022 23:59:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g16-20020aa796b0000000b005385555e647sm6755525pfk.155.2022.08.31.23.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 23:59:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 1/2] fortify: Add run-time WARN for cross-field memcpy()
Date:   Wed, 31 Aug 2022 23:59:13 -0700
Message-Id: <20220901065914.1417829-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901065914.1417829-1-keescook@chromium.org>
References: <20220901065914.1417829-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7128; h=from:subject; bh=OPwd1urZjnL/sFRYREYgKX+k6ufc3hbn/XSHlj88wUI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEFhCSODVZ7smkPYeLq9P5OfRFSY7/eAHjZtzAi0c 9ubXhbeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxBYQgAKCRCJcvTf3G3AJkegD/ 42Irslmz7F4CdoTT2NyeRtfSgtC1K1407SWEtirPWZccQIc+N6GUB80PLbQJjmmiAt2/NFD33QnF0G 0az0JfTpknG/8+KzwK0rElQigW7Q59NMGBvPBEHYyAwKGNk020gCYhBkxjoIfUG5pSYlNu4GlhxZaI ibXhD3X8y7O6MPgetoZmWPytbvBY0cOAekj1kOVl2+RzBlTO5aHfsgPNeWrk3Beol6WzvRnRNoKEQe R7kbNQ0mW+HMo7Ya220KgkOgKWpGw6esRQCUT2yiqMXBLvNAjx7plsVdDoRmW4cG3milj6YUil8hIO Z+XhKduxTaZtTstV89QNNejf72Qs73zWLw3BVPTu4Z49MgHe7dPjlTtWDsdLMOCIxXWScGxgPi8CvO rJAGEg/f3t0mViDRlm3h0OvDINW0sZkWVm4nB8mMYLdI2td3FBJQhQt0fYWf6sqoC8UYQoBeRR2TmR Nn665Gh0RROl2PZadPeZ7nl3oSO8/RLY6hme9C419x3DxY3zLt3yoI1E0QapHuCiR5nywYwXSj4125 Yr3Qx0BH3eG2n0I4EOCWwww9KjJW0F34DP196a4S6hHvDI/9D6upT3WhtPdcLTsn8FBofeS8pKiWEm A9rSpJyqMB/k1glXp6qUElRYNHTfmzLECKreOXE2mYXTOb8UKU/rDWG2DblA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Enable run-time checking of dynamic memcpy() and memmove() lengths,
issuing a WARN when a write would exceed the size of the target struct
member, when built with CONFIG_FORTIFY_SOURCE=y. This would have
caught all of the memcpy()-based buffer overflows in the last 3 years,
specifically covering all the cases where the destination buffer size
is known at compile time.

This change ONLY adds a run-time warning. As false positives are currently
still expected, this will not block the overflow. The new warnings will
look like this:

  memcpy: detected field-spanning write (size N) of single field "var->dest" (size M)
  WARNING: CPU: n PID: pppp at source/file/path.c:nr function+0xXX/0xXX [module]

There may be false positives in the kernel where intentional
field-spanning writes are happening. These need to be addressed
similarly to how the compile-time cases were addressed: add a
struct_group(), split the memcpy(), or some other refactoring.

In order to make counting/investigating instances of added runtime checks
easier, each instance includes the destination variable name as a WARN
argument, prefixed with 'field "'. Therefore, on an x86_64 defconfig
build, it is trivial to inspect the build artifacts to find instances.
For example on an x86_64 defconfig build, there are 78 new run-time
memcpy() bounds checks added:

  $ for i in vmlinux $(find . -name '*.ko'); do \
      strings "$i" | grep '^field "'; done | wc -l
  78

Simple cases where a destination buffer is known to be a dynamic size
do not generate a WARN. For example:

struct normal_flex_array {
	void *a;
	int b;
	u32 c;
	size_t array_size;
	u8 flex_array[];
};

struct normal_flex_array *instance;
...
/* These will be ignored for run-time bounds checking. */
memcpy(instance, src, len);
memcpy(instance->flex_array, src, len);

However, one of the dynamic-sized destination cases is irritatingly
unable to be detected by the compiler: when using memcpy() to target
a composite struct member which contains a trailing flexible array
struct. For example:

struct wrapper {
	int foo;
	char bar;
	struct normal_flex_array embedded;
};

struct wrapper *instance;
...
/* This will incorrectly WARN when len > sizeof(instance->embedded) */
memcpy(&instance->embedded, src, len);

These cases end up appearing to the compiler to be sized as if the
flexible array had 0 elements. :( For more details see:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
https://godbolt.org/z/vW6x8vh4P

These "composite flexible array structure destination" cases will be
need to be flushed out and addressed on a case-by-case basis.

Regardless, for the general case of using memcpy() on flexible array
destinations, future APIs will be created to handle common cases. Those
can be used to migrate away from open-coded memcpy() so that proper
error handling (instead of trapping) can be used.

As mentioned, none of these bounds checks block any overflows
currently. For users that have tested their workloads, do not encounter
any warnings, and wish to make these checks stop any overflows, they
can use a big hammer and set the sysctl panic_on_warn=1.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 70 ++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 3b401fa0f374..ca3626c41785 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -3,6 +3,7 @@
 #define _LINUX_FORTIFY_STRING_H_
 
 #include <linux/const.h>
+#include <linux/bug.h>
 
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
@@ -319,7 +320,7 @@ __FORTIFY_INLINE void fortify_memset_chk(__kernel_size_t size,
  * V = vulnerable to run-time overflow (will need refactoring to solve)
  *
  */
-__FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
+__FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 					 const size_t p_size,
 					 const size_t q_size,
 					 const size_t p_size_field,
@@ -368,16 +369,79 @@ __FORTIFY_INLINE void fortify_memcpy_chk(__kernel_size_t size,
 	if ((p_size != (size_t)(-1) && p_size < size) ||
 	    (q_size != (size_t)(-1) && q_size < size))
 		fortify_panic(func);
+
+	/*
+	 * Warn when writing beyond destination field size.
+	 *
+	 * We must ignore p_size_field == 0 for existing 0-element
+	 * fake flexible arrays, until they are all converted to
+	 * proper flexible arrays.
+	 *
+	 * The implementation of __builtin_object_size() behaves
+	 * like sizeof() when not directly referencing a flexible
+	 * array member, which means there will be many bounds checks
+	 * that will appear at run-time, without a way for them to be
+	 * detected at compile-time (as can be done when the destination
+	 * is specifically the flexible array member).
+	 * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101832
+	 */
+	if (p_size_field != 0 && p_size_field != (size_t)(-1) &&
+	    p_size != p_size_field && p_size_field < size)
+		return true;
+
+	return false;
 }
 
 #define __fortify_memcpy_chk(p, q, size, p_size, q_size,		\
 			     p_size_field, q_size_field, op) ({		\
 	size_t __fortify_size = (size_t)(size);				\
-	fortify_memcpy_chk(__fortify_size, p_size, q_size,		\
-			   p_size_field, q_size_field, #op);		\
+	WARN_ONCE(fortify_memcpy_chk(__fortify_size, p_size, q_size,	\
+				     p_size_field, q_size_field, #op),	\
+		  #op ": detected field-spanning write (size %zu) of single %s (size %zu)\n", \
+		  __fortify_size,					\
+		  "field \"" #p "\" at " __FILE__ ":" __stringify(__LINE__), \
+		  p_size_field);					\
 	__underlying_##op(p, q, __fortify_size);			\
 })
 
+/*
+ * Notes about compile-time buffer size detection:
+ *
+ * With these types...
+ *
+ *	struct middle {
+ *		u16 a;
+ *		u8 middle_buf[16];
+ *		int b;
+ *	};
+ *	struct end {
+ *		u16 a;
+ *		u8 end_buf[16];
+ *	};
+ *	struct flex {
+ *		int a;
+ *		u8 flex_buf[];
+ *	};
+ *
+ *	void func(TYPE *ptr) { ... }
+ *
+ * Cases where destination size cannot be currently detected:
+ * - the size of ptr's object (seemingly by design, gcc & clang fail):
+ *	__builtin_object_size(ptr, 1) == -1
+ * - the size of flexible arrays in ptr's obj (by design, dynamic size):
+ *	__builtin_object_size(ptr->flex_buf, 1) == -1
+ * - the size of ANY array at the end of ptr's obj (gcc and clang bug):
+ *	__builtin_object_size(ptr->end_buf, 1) == -1
+ *	https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836
+ *
+ * Cases where destination size is currently detected:
+ * - the size of non-array members within ptr's object:
+ *	__builtin_object_size(ptr->a, 1) == 2
+ * - the size of non-flexible-array in the middle of ptr's obj:
+ *	__builtin_object_size(ptr->middle_buf, 1) == 16
+ *
+ */
+
 /*
  * __builtin_object_size() must be captured here to avoid evaluating argument
  * side-effects further into the macro layers.
-- 
2.34.1

