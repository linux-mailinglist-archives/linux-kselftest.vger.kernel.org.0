Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5527AE215
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Sep 2023 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjIYXIn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 19:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIYXIl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 19:08:41 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DC93A3;
        Mon, 25 Sep 2023 16:08:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.113])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9BB57212C81D;
        Mon, 25 Sep 2023 16:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BB57212C81D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695683314;
        bh=cV/WXohPzUkk94WshSKSjmA5ZbzTW6O2vSKuW13yiOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fzHA6zWq415MTGGxr7MdegCOW7vc9tYTg82HpemY2R12P75BlOHj9hh1hDMhyePBd
         olpwYstubwptYFObnZJ9X6oZjj/+HqhJ3Jh3qXPG9WB1p7RdqbSsw+GhQooOKMGJLY
         r8aJPc3MHlg5r+nX3LUM13d8gcZRPRVh27nqaz7U=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        cleger@rivosinc.com, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] tracing/user_events: Align set_bit() address for all archs
Date:   Mon, 25 Sep 2023 23:08:28 +0000
Message-Id: <20230925230829.341-2-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925230829.341-1-beaub@linux.microsoft.com>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All architectures should use a long aligned address passed to set_bit().
User processes can pass either a 32-bit or 64-bit sized value to be
updated when tracing is enabled when on a 64-bit kernel. Both cases are
ensured to be naturally aligned, however, that is not enough. The
address must be long aligned without affecting checks on the value
within the user process which require different adjustments for the bit
for little and big endian CPUs.

Add a compat flag to user_event_enabler that indicates when a 32-bit
value is being used on a 64-bit kernel. Long align addresses and correct
the bit to be used by set_bit() to account for this alignment. Ensure
compat flags are copied during forks and used during deletion clears.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Link: https://lore.kernel.org/linux-trace-kernel/20230914131102.179100-1-cleger@rivosinc.com/

Reported-by: Clément Léger <cleger@rivosinc.com>
Suggested-by: Clément Léger <cleger@rivosinc.com>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 58 ++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 6f046650e527..b87f41187c6a 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -127,8 +127,13 @@ struct user_event_enabler {
 /* Bit 7 is for freeing status of enablement */
 #define ENABLE_VAL_FREEING_BIT 7
 
-/* Only duplicate the bit value */
-#define ENABLE_VAL_DUP_MASK ENABLE_VAL_BIT_MASK
+/* Bit 8 is for marking 32-bit on 64-bit */
+#define ENABLE_VAL_32_ON_64_BIT 8
+
+#define ENABLE_VAL_COMPAT_MASK (1 << ENABLE_VAL_32_ON_64_BIT)
+
+/* Only duplicate the bit and compat values */
+#define ENABLE_VAL_DUP_MASK (ENABLE_VAL_BIT_MASK | ENABLE_VAL_COMPAT_MASK)
 
 #define ENABLE_BITOPS(e) (&(e)->values)
 
@@ -174,6 +179,30 @@ struct user_event_validator {
 	int			flags;
 };
 
+static inline void align_addr_bit(unsigned long *addr, int *bit,
+				  unsigned long *flags)
+{
+	if (IS_ALIGNED(*addr, sizeof(long))) {
+#ifdef __BIG_ENDIAN
+		/* 32 bit on BE 64 bit requires a 32 bit offset when aligned. */
+		if (test_bit(ENABLE_VAL_32_ON_64_BIT, flags))
+			*bit += 32;
+#endif
+		return;
+	}
+
+	*addr = ALIGN_DOWN(*addr, sizeof(long));
+
+	/*
+	 * We only support 32 and 64 bit values. The only time we need
+	 * to align is a 32 bit value on a 64 bit kernel, which on LE
+	 * is always 32 bits, and on BE requires no change when unaligned.
+	 */
+#ifdef __LITTLE_ENDIAN
+	*bit += 32;
+#endif
+}
+
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata, bool *faulted);
 
@@ -482,6 +511,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	unsigned long *ptr;
 	struct page *page;
 	void *kaddr;
+	int bit = ENABLE_BIT(enabler);
 	int ret;
 
 	lockdep_assert_held(&event_mutex);
@@ -497,6 +527,8 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 		     test_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler))))
 		return -EBUSY;
 
+	align_addr_bit(&uaddr, &bit, ENABLE_BITOPS(enabler));
+
 	ret = pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL_NOFAULT,
 				    &page, NULL);
 
@@ -515,9 +547,9 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(ENABLE_BIT(enabler), ptr);
+		set_bit(bit, ptr);
 	else
-		clear_bit(ENABLE_BIT(enabler), ptr);
+		clear_bit(bit, ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
@@ -849,6 +881,12 @@ static struct user_event_enabler
 	enabler->event = user;
 	enabler->addr = uaddr;
 	enabler->values = reg->enable_bit;
+
+#if BITS_PER_LONG >= 64
+	if (reg->enable_size == 4)
+		set_bit(ENABLE_VAL_32_ON_64_BIT, ENABLE_BITOPS(enabler));
+#endif
+
 retry:
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -2377,7 +2415,8 @@ static long user_unreg_get(struct user_unreg __user *ureg,
 }
 
 static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
-				   unsigned long uaddr, unsigned char bit)
+				   unsigned long uaddr, unsigned char bit,
+				   unsigned long flags)
 {
 	struct user_event_enabler enabler;
 	int result;
@@ -2385,7 +2424,7 @@ static int user_event_mm_clear_bit(struct user_event_mm *user_mm,
 
 	memset(&enabler, 0, sizeof(enabler));
 	enabler.addr = uaddr;
-	enabler.values = bit;
+	enabler.values = bit | flags;
 retry:
 	/* Prevents state changes from racing with new enablers */
 	mutex_lock(&event_mutex);
@@ -2415,6 +2454,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	struct user_event_mm *mm = current->user_event_mm;
 	struct user_event_enabler *enabler, *next;
 	struct user_unreg reg;
+	unsigned long flags;
 	long ret;
 
 	ret = user_unreg_get(ureg, &reg);
@@ -2425,6 +2465,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	if (!mm)
 		return -ENOENT;
 
+	flags = 0;
 	ret = -ENOENT;
 
 	/*
@@ -2441,6 +2482,9 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 		    ENABLE_BIT(enabler) == reg.disable_bit) {
 			set_bit(ENABLE_VAL_FREEING_BIT, ENABLE_BITOPS(enabler));
 
+			/* We must keep compat flags for the clear */
+			flags |= enabler->values & ENABLE_VAL_COMPAT_MASK;
+
 			if (!test_bit(ENABLE_VAL_FAULTING_BIT, ENABLE_BITOPS(enabler)))
 				user_event_enabler_destroy(enabler, true);
 
@@ -2454,7 +2498,7 @@ static long user_events_ioctl_unreg(unsigned long uarg)
 	/* Ensure bit is now cleared for user, regardless of event status */
 	if (!ret)
 		ret = user_event_mm_clear_bit(mm, reg.disable_addr,
-					      reg.disable_bit);
+					      reg.disable_bit, flags);
 
 	return ret;
 }
-- 
2.34.1

