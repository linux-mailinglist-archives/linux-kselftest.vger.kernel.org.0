Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8B043804F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Oct 2021 00:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhJVWkz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Oct 2021 18:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbhJVWkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Oct 2021 18:40:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A732DC061225
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x1-20020a17090a530100b001a1efa4ebe6so1749983pjh.0
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VhP6k2Ptbi7uCRsPURWI/pJVVcmD5lbioz9gtAtZ1ig=;
        b=Pf8qWPlOj2elRq79FtuDFpwrlId3NjX+NBYrabhdvxWQMtM6CIeJbqJYM6/vtXX1cf
         ftnv1ge5eVo/dCwXN58kz0flviZ1i7dNtXjo6B+m38UoFWpBdslQOewNvmdW7bgrWDTr
         5X/NqfIlMH0USas7A/PSmaZMHPn7uHyxgY9rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VhP6k2Ptbi7uCRsPURWI/pJVVcmD5lbioz9gtAtZ1ig=;
        b=W+M6RWnLonR9c6z9zghEHM0U93i04Ca1NFe8x3lM4w+2JilF6SbvuVygL62w4kmlEM
         x+3WhCeECNKkSrOtc4Yd8mL9Ng2A+hpdeO+itO+enTNEkfLEKCo/5Rjbq5p1KLYBXc8i
         CJV9hxmgV8BSsAGUS6h1OEDxxYOG2GOcdaEiankPA1gjtXfJHnK5JOjUKYYPdGK59ycl
         KSDdKHhPKPTjF/g6uMOfYGTnlgUQcnqs78CRiCjAT2EhKR1tTlLeKxidsbMI3Rty5Kfm
         aXXefcmGMDd2azx+FHvU3KJMNaAJw+f3kw3L47s/XWOtZUWRGIiqUObv6QCjX/ZRlIxq
         F/2g==
X-Gm-Message-State: AOAM5322KlCJ++Qvpr+zX46PgbfxJXgma1D7ImaLUCFodbqKLOYV2JE2
        lliqjzR4290haL3jGoivioxVJw==
X-Google-Smtp-Source: ABdhPJxZaYw7iwxMsd6qWzzFw9KMbHqpMeg8bdlw5gtZ24LK8HXzXpBKY+7Hxx/oYRy7fLc26A0R+Q==
X-Received: by 2002:a17:902:82c4:b0:13f:fa72:4b4f with SMTP id u4-20020a17090282c400b0013ffa724b4fmr2489653plz.18.1634942315178;
        Fri, 22 Oct 2021 15:38:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm71827pfc.126.2021.10.22.15.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 15:38:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] lkdtm/bugs: Check that a per-task stack canary exists
Date:   Fri, 22 Oct 2021 15:38:26 -0700
Message-Id: <20211022223826.330653-3-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211022223826.330653-1-keescook@chromium.org>
References: <20211022223826.330653-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5525; h=from:subject; bh=lFob2SpNOd7JioxJ+tKziNQRUDdHLjyUqAKU0YX5xYw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhcz1hVQtS3LUL2AUyeIS59y3JAiez/OuPxCzOHRBp IRmdLiaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYXM9YQAKCRCJcvTf3G3AJonqEA Cmp0FF89pmJoM7uNrr6aQdyv6i6tmr6ZJIntqUq9HrTLYUzzUIr8HVIRuQeY4z/HXshYK+oSOcI7Bu +EFfwvmuEuyRnyprP4PE8d12Qr30B6MoN/ed0rkoq9kEn/OK+RQbbLo7+oArTAgvlYYbC+U+rV+05d 0mxcnlY32VReNXEVDr5cFavsvJ48icYkEfrTLZbgp4xnqZqF7hIQY2/DInokgrufoCrfid3Zj8kKnc y6U+Al4JRSVat3BEL+we5HvF+rudWFW8rwV2pVyiuoNEjD44r20v4V899GtlUB3F5rhggYaQK8ljbd eoCbqy9ihl+zRD9ZSHgjlRulrGFWiSp/oUHZZO/gsgw9UUGO5eB9cEYbwkRCHCa5wJTXsPSpVPg/EF iEmZ3/lAOgUC514G3T2yk77AhUC5qobWfQApsIbNpNWDEQPTpffzJHT6ipWgKlrYuEKK+yhGv6g9E1 A7QKxsMqA8F3ttOZNcSIevp3etMdqwIlyjlRMWxsZb6D3oFgPF5Oz9avUNk1LuqGWWLz02Jyve2l1W fvnEMJ28Vh8CGKkmKj/YjlawvGEzhMDI4/h0a4hlRe/5mMGVKyCSwZvmptLC+kRfMxoB3NDZxSArHR 3UWzbyaRB+sjY50cMekmCzncSJBk7E97KuySQ9Rgqf4hU0MDFi4TKqpQGWNQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce REPORT_STACK_CANARY to check for differing stack canaries
between two processes (i.e. that an architecture is correctly implementing
per-task stack canaries), using the task_struct canary as the hint to
locate in the stack. Requires that one of the processes being tested
not be pid 1.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c               | 77 +++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c               |  1 +
 drivers/misc/lkdtm/lkdtm.h              |  1 +
 tools/testing/selftests/lkdtm/config    |  1 +
 tools/testing/selftests/lkdtm/tests.txt |  1 +
 5 files changed, 81 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 41fa558675c4..f21854ac5cc2 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -153,6 +153,83 @@ void lkdtm_REPORT_STACK(void)
 	pr_info("Stack offset: %d\n", (int)(stack_addr - (uintptr_t)&magic));
 }
 
+static pid_t stack_canary_pid;
+static unsigned long stack_canary;
+static unsigned long stack_canary_offset;
+
+static noinline void __lkdtm_REPORT_STACK_CANARY(void *stack)
+{
+	int i = 0;
+	pid_t pid = task_pid_nr(current);
+	unsigned long *canary = (unsigned long *)stack;
+	unsigned long current_offset = 0, init_offset = 0;
+
+	/* Do our best to find the canary in a 16 word window ... */
+	for (i = 1; i < 16; i++) {
+		canary = (unsigned long *)stack + i;
+#ifdef CONFIG_STACKPROTECTOR
+		if (*canary == current->stack_canary)
+			current_offset = i;
+		if (*canary == init_task.stack_canary)
+			init_offset = i;
+#endif
+	}
+
+	if (current_offset == 0) {
+		/*
+		 * If the canary doesn't match what's in the task_struct,
+		 * we're either using a global canary or the stack frame
+		 * layout changed.
+		 */
+		if (init_offset != 0) {
+			pr_err("FAIL: global stack canary found at offset %ld (canary for pid %d matches init_task's)!\n",
+			       init_offset, pid);
+		} else {
+			pr_warn("FAIL: did not correctly locate stack canary :(\n");
+			pr_expected_config(CONFIG_STACKPROTECTOR);
+		}
+
+		return;
+	} else if (init_offset != 0) {
+		pr_warn("WARNING: found both current and init_task canaries nearby?!\n");
+	}
+
+	canary = (unsigned long *)stack + current_offset;
+	if (stack_canary_pid == 0) {
+		stack_canary = *canary;
+		stack_canary_pid = pid;
+		stack_canary_offset = current_offset;
+		pr_info("Recorded stack canary for pid %d at offset %ld\n",
+			stack_canary_pid, stack_canary_offset);
+	} else if (pid == stack_canary_pid) {
+		pr_warn("ERROR: saw pid %d again -- please use a new pid\n", pid);
+	} else {
+		if (current_offset != stack_canary_offset) {
+			pr_warn("ERROR: canary offset changed from %ld to %ld!?\n",
+				stack_canary_offset, current_offset);
+			return;
+		}
+
+		if (*canary == stack_canary) {
+			pr_warn("FAIL: canary identical for pid %d and pid %d at offset %ld!\n",
+				stack_canary_pid, pid, current_offset);
+		} else {
+			pr_info("ok: stack canaries differ between pid %d and pid %d at offset %ld.\n",
+				stack_canary_pid, pid, current_offset);
+			/* Reset the test. */
+			stack_canary_pid = 0;
+		}
+	}
+}
+
+void lkdtm_REPORT_STACK_CANARY(void)
+{
+	/* Use default char array length that triggers stack protection. */
+	char data[8] __aligned(sizeof(void *)) = { };
+
+	__lkdtm_REPORT_STACK_CANARY((void *)&data);
+}
+
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index e99db37e56d5..d4c6cdced37b 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -111,6 +111,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
 	CRASHTYPE(REPORT_STACK),
+	CRASHTYPE(REPORT_STACK_CANARY),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index c212a253edde..d6137c70ebbe 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -69,6 +69,7 @@ void lkdtm_EXHAUST_STACK(void);
 void lkdtm_CORRUPT_STACK(void);
 void lkdtm_CORRUPT_STACK_STRONG(void);
 void lkdtm_REPORT_STACK(void);
+void lkdtm_REPORT_STACK_CANARY(void);
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
 void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
index 38edea25631b..a26a3fa9e925 100644
--- a/tools/testing/selftests/lkdtm/config
+++ b/tools/testing/selftests/lkdtm/config
@@ -8,3 +8,4 @@ CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
 CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
 CONFIG_UBSAN_BOUNDS=y
 CONFIG_UBSAN_TRAP=y
+CONFIG_STACKPROTECTOR_STRONG=y
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index 09f7bfa383cc..6b36b7f5dcf9 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -12,6 +12,7 @@ CORRUPT_LIST_ADD list_add corruption
 CORRUPT_LIST_DEL list_del corruption
 STACK_GUARD_PAGE_LEADING
 STACK_GUARD_PAGE_TRAILING
+REPORT_STACK_CANARY repeat:2 ok: stack canaries differ
 UNSET_SMEP pinned CR4 bits changed:
 DOUBLE_FAULT
 CORRUPT_PAC
-- 
2.30.2

