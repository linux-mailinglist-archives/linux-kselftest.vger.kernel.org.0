Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BBC6A487D
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjB0RrQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjB0RrM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 12:47:12 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54856222E5
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 09:47:11 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id q15-20020a63d60f000000b00502e1c551aaso2208254pgg.21
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Feb 2023 09:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bx7GMwBIOHxrHorivUo24uUgRWemT3+721qT8hA0RRM=;
        b=fL0sCAtJCbBQmUG9K1il5cmtYgU+ic6RembCIXUKuPBlJzRuirBy8XzEmXwgH1PU31
         kkpjFWighHghmJVkVQltONa/wKox7B8FVpYn27OhLvhYDq9l3gFmp2uavdK4dbsIRPIs
         p6hT2TYtw2O1FmzxBjIR6E3nJWQCqGc/ICMdXPprWdFVQlEBTlgYjA8qiVLqAihMPQ25
         K9iFdZVJOJrtL6AugVJN5qR2lA0rJOhOrTeaYjBIryyDheil7WOfb5fzdqMp2ivFylsv
         tjFfvQlIsax/515iS33dcPRRbtggsuz+LI7vS0bZ992wD4rJLMsA6tbdVdfFaiMvE5K+
         9rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bx7GMwBIOHxrHorivUo24uUgRWemT3+721qT8hA0RRM=;
        b=yMdTmIp2Prnzp4rTj/vs04qG34ZeRai5rWq7qj0S4gbNrhCrAoysNzOOI99qyiFokA
         GXCjGZn3Awjbl0LYyYnK7fTyfP9m0qKCEZl1tiNxYKXRxLeL0Hm0HSc4SfQ22AlWTdWr
         5WmR7Kzoyoh5iRIqb4O57oU3HwOEeeLDEnUx9a5yJFY8GBTyAaB0SIA1HuqwHHoYcQ0l
         B345Io8g6wke0ImTYJqxKiHeAR7DRwUi3vbOcPKqsV2AYcRGcftuqa/cTH+xFE+QLPvQ
         bLpBAnnniODkftIWb8j2Z1dzAg2pZU6ZVnyk3PUKU1YQ6NHglSUqaKkpP+bE0QFPm8E4
         r1sg==
X-Gm-Message-State: AO0yUKUk+0mSmGAiyUMgPAIPdRaFpUYir27dYDWqskO5QaJHrkmPNHcb
        jrSiEV2HN0NCjZBO/09y4g+KcxRMaV+cwCgojA==
X-Google-Smtp-Source: AK7set+vnOMHR/cn8CdD2DfS9+dSlM7HFryOJfCIJPWETMAvw/+OV5UIcKBg4NX/PtA17R+5rlfEtd6GoQ73nZQ9bA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a63:921c:0:b0:503:6bbe:20cf with SMTP
 id o28-20020a63921c000000b005036bbe20cfmr606208pgd.0.1677520030680; Mon, 27
 Feb 2023 09:47:10 -0800 (PST)
Date:   Mon, 27 Feb 2023 17:46:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227174654.94641-1-ackerleytng@google.com>
Subject: [PATCH] tools: Copy linux/align.h into tools/
From:   Ackerley Tng <ackerleytng@google.com>
To:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk, seanjc@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This provides alignment macros for use in selftests.

Also clean up tools/include/linux/bitmap.h's inline definition of
IS_ALIGNED().

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/include/linux/align.h  | 15 +++++++++++++++
 tools/include/linux/bitmap.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 tools/include/linux/align.h

diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..2b4acec7b95a
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_ALIGN_H
+#define _LINUX_ALIGN_H
+
+#include <linux/const.h>
+
+/* @a is a power of 2 value */
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
+#define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
+#define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif	/* _LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index f3566ea0f932..8c6852dba04f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/find.h>
 #include <stdlib.h>
@@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline bool bitmap_equal(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
-- 
2.39.2.722.g9855ee24e9-goog

