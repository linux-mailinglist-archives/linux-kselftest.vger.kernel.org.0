Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8557565814
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 15:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbiGDN7r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 09:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbiGDN73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:29 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0AAE092
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:59:21 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id r1so4472842vke.8
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rnE47zkhbqWUJCOF0oFEixfkiu1ztx/JWB/tGri5YXI=;
        b=LPaDJYKM/DGiUp92Hh+jPbmInAsxrzuU0gaRNet6zG9cOie6oZ549PRb7KfPsYEAE+
         HT+Z8VnJYmxAZDDADvU5oJsQTb96tcokrDSY9ESIQ/Avq4F0dqKDdRdiVdhzH5+fc+su
         fTZHP+JiqUbKTr5LPoZ3FJyLmgK/NTHxa0HmS1z60R9vUPkQ6YFr8wjBwHBpDiB4ndAi
         +oWLWmAKK3VzUR0A5KgO+mouqtrfvhrJf2JcoZdlBIohxQoLcA6EXMSTgVkgDl+MuMRv
         00ZdBkTssQWwSgp7WN00hdh5KoWXbc4eMznXdDuJk4B/+n7DH9HCAl9gWwxm76WIA8a7
         XkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rnE47zkhbqWUJCOF0oFEixfkiu1ztx/JWB/tGri5YXI=;
        b=0mRPNSaYTJFLUxLUyDa65U331c9BNI+yYkWlXuKWnFoQ8UjyrEiCBvR38B/LLuYklT
         EEH7XoGVW3scdRTW1bLT/lfONAypwrRp6Tu0WvsvDuobnKkapKTPxqTJfrhrMqwfiJmX
         3eM3UP5J33p3YjCZHNCDIOa4UHrWBotcA0FipPtCFB+9RblwOOGLEGt6GTTbGIPxqGV3
         CTUQnb0QcjCcQoJzzKV2E+BUGnb08PpqZOahXI6k4v94Iuu1/T132WIIZzYTlfeVeQt1
         5o+FJMxlvHMywHrLJs2EdJbqbgwnpSsBIsu3I08PFhMLC8PcshvxujvD7ag2Zsh9cmTd
         i7Sw==
X-Gm-Message-State: AJIora9Nmcf9gfChl5JC3qkbVld4fV2LPykF+Fovv+DTeYNjAYdUIfy/
        NDx4iAPRTdpfRXM59zxHRibtcw==
X-Google-Smtp-Source: AGRyM1uhvKX9DY0lHDCjtBY+5BrycH2Gr0rJb29k0daor6bM+GZnlj9mVlr6FF1AhkwgIQkJl3l0dQ==
X-Received: by 2002:a05:6122:1485:b0:36c:c60b:877f with SMTP id z5-20020a056122148500b0036cc60b877fmr17367399vkp.4.1656943160742;
        Mon, 04 Jul 2022 06:59:20 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id w1-20020ab055c1000000b0037c965ac47fsm4564520uaa.31.2022.07.04.06.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:59:20 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v9 5/9] x86/e820: Refactor e820__range_remove
Date:   Mon,  4 Jul 2022 10:58:29 -0300
Message-Id: <20220704135833.1496303-6-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Refactor e820__range_remove with the introduction of
e820_remover_data, indented to be used as the void pointer in the
e820_entry_updater callbacks, and the implementation of the callbacks
remove a range in the e820_table.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 94 ++++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 53 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 36a22c0a2199..0e5aa13ebdb8 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -669,66 +669,54 @@ static u64 __init e820__range_update_kexec(u64 start, u64 size,
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
 
-/* Remove a range of memory from the E820 table: */
-u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type)
-{
-	int i;
-	u64 end;
-	u64 real_removed_size = 0;
-
-	if (size > (ULLONG_MAX - start))
-		size = ULLONG_MAX - start;
-
-	end = start + size;
-	printk(KERN_DEBUG "e820: remove [mem %#010Lx-%#010Lx] ", start, end - 1);
-	if (check_type)
-		e820_print_type(old_type);
-	pr_cont("\n");
-
-	for (i = 0; i < e820_table->nr_entries; i++) {
-		struct e820_entry *entry = &e820_table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
-
-		if (check_type && entry->type != old_type)
-			continue;
+/*
+ * Type helper for the e820_entry_updater callbacks.
+ */
+struct e820_remover_data {
+	enum e820_type old_type;
+	bool check_type;
+};
 
-		entry_end = entry->addr + entry->size;
+static bool __init remover__should_update(const struct e820_entry *entry,
+					  const void *data)
+{
+	const struct e820_remover_data *remover_data = data;
 
-		/* Completely covered? */
-		if (entry->addr >= start && entry_end <= end) {
-			real_removed_size += entry->size;
-			memset(entry, 0, sizeof(*entry));
-			continue;
-		}
+	return !remover_data->check_type ||
+	       entry->type == remover_data->old_type;
+}
 
-		/* Is the new range completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			e820__range_add(end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_removed_size += size;
-			continue;
-		}
+static void __init remover__update(struct e820_entry *entry, const void *data)
+{
+	memset(entry, 0, sizeof(*entry));
+}
 
-		/* Partially covered: */
-		final_start = max(start, entry->addr);
-		final_end = min(end, entry_end);
-		if (final_start >= final_end)
-			continue;
+/*
+ * Remove [@start, @start + @size) from e820_table. If @check_type is
+ * true remove only entries with type @old_type.
+ */
+u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type,
+			      bool check_type)
+{
+	struct e820_entry_updater updater = {
+		.should_update = remover__should_update,
+		.update = remover__update,
+		.new = NULL
+	};
 
-		real_removed_size += final_end - final_start;
+	struct e820_remover_data data = {
+		.check_type = check_type,
+		.old_type = old_type
+	};
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * the size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
+	printk(KERN_DEBUG "e820: remove [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	if (check_type)
+		e820_print_type(old_type);
+	pr_cont("\n");
 
-		entry->addr = final_end;
-	}
-	return real_removed_size;
+	return __e820__handle_range_update(e820_table, start, size, &updater,
+					   &data);
 }
 
 void __init e820__update_table_print(void)
-- 
2.30.2

