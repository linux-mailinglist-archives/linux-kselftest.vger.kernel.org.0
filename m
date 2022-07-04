Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940DB565810
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 15:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbiGDN7l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 09:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbiGDN7Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:25 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD5DFA4
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:59:14 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id s3so1218517uaq.2
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PLuObBmPkIWHGGIa0YgrZ0Lq4zFfhIdvg//A8xn7ggo=;
        b=gN9JTuRL5WoxiIFiSJH2BsN3ItwrNWqzLFOY4N3NUhOsXJIwDtjxxMEHz41YepsIDP
         W5E6V7n5JvDJ/i5baNtKTxaK2W6aWVWX9mVibtQoRH44epoqm/m8uN5jdit9wmjVdYS8
         +hdvMwPPAKccBpDl0ixE6hnJML8ORQ3KT/4DcMLEnag6hMpoBtf2VLDNqUlCMCeEImNz
         uwHVQaW6fsQ3nXFqvFUctCXE6YBk4kl9EDCXPRv58XWMJg+HfRVk6NzIQX7sp6cQPuJY
         KZMLXxpZoH/68Tlsu1k83O0hChoQL7Pyx5RKXY6wF4QbeZ3eKGDBfBcgbvElggYQeek8
         lyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PLuObBmPkIWHGGIa0YgrZ0Lq4zFfhIdvg//A8xn7ggo=;
        b=3nJXFH84E+jafVFJ//oBbUmk5TpDfNxFnNdfDPIO5ZUDw/LUnchSL48HhM/qJrg4VH
         WPf1hXK/ySWxBuKuXYHlTiZfk7DIqIrwMTIKUi9Rpg9xoYd2m4FpVCHs9W03NpGxukx+
         2jwV6t97J/vVfjeaATAq+6xmsExSu5MDVxMmB2r7hjHVvIJh4N3kjHEt3itHMppEIV83
         RKRPcSQ3PR633DLrbPovgR+tN9Bl3cCVX1GlEvQPtF29ECsB+mNE4XbpqmJbOx7T4aVj
         jAVTC3noOa5YQcKtLrusdwi8fxbWUGdH/IaDAms9zWVDbzeyYmiFO4pi10GspBrTLG0x
         VfvQ==
X-Gm-Message-State: AJIora9o4lCylxptA7Q24dOs8bvM1O7qUxXJcd2sVoA9vhnlJaYeGS+s
        hXmMpzIxEA7iiFMDHmS7d7C1Hg==
X-Google-Smtp-Source: AGRyM1tNxtduN57UQfGfrlt1doS6keFtGNxx4LQceUUCxOy7O2ATtIFJcC6rdjX3eolce6y12vCeSQ==
X-Received: by 2002:a9f:22ac:0:b0:382:3c6c:f238 with SMTP id 41-20020a9f22ac000000b003823c6cf238mr5926773uan.123.1656943153149;
        Mon, 04 Jul 2022 06:59:13 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id x24-20020ab036f8000000b0038296f80d22sm723705uau.8.2022.07.04.06.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:59:12 -0700 (PDT)
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
Subject: [PATCH v9 4/9] x86/e820: Refactor __e820__range_update
Date:   Mon,  4 Jul 2022 10:58:28 -0300
Message-Id: <20220704135833.1496303-5-martin.fernandez@eclypsium.com>
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

Refactor __e820__range_update with the introduction of
e820_type_updater_data, indented to be used as the void pointer in the
e820_entry_updater callbacks, and the implementation of the callbacks
to perform the update of the type in a range of a e820_table.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/kernel/e820.c | 119 +++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 57 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index e0fa3ab755a5..36a22c0a2199 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -586,80 +586,85 @@ __e820__handle_range_update(struct e820_table *table,
 	return updated_size;
 }
 
-static u64 __init
-__e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
-{
-	u64 end;
-	unsigned int i;
-	u64 real_updated_size = 0;
-
-	BUG_ON(old_type == new_type);
-
-	if (size > (ULLONG_MAX - start))
-		size = ULLONG_MAX - start;
+/*
+ * Type helper for the e820_entry_updater callbacks.
+ */
+struct e820_type_updater_data {
+	enum e820_type old_type;
+	enum e820_type new_type;
+};
 
-	end = start + size;
-	printk(KERN_DEBUG "e820: update [mem %#010Lx-%#010Lx] ", start, end - 1);
-	e820_print_type(old_type);
-	pr_cont(" ==> ");
-	e820_print_type(new_type);
-	pr_cont("\n");
+static bool __init type_updater__should_update(const struct e820_entry *entry,
+					       const void *data)
+{
+	const struct e820_type_updater_data *type_updater_data = data;
 
-	for (i = 0; i < table->nr_entries; i++) {
-		struct e820_entry *entry = &table->entries[i];
-		u64 final_start, final_end;
-		u64 entry_end;
+	return entry->type == type_updater_data->old_type;
+}
 
-		if (entry->type != old_type)
-			continue;
+static void __init type_updater__update(struct e820_entry *entry,
+					const void *data)
+{
+	const struct e820_type_updater_data *type_updater_data = data;
 
-		entry_end = entry->addr + entry->size;
+	entry->type = type_updater_data->new_type;
+}
 
-		/* Completely covered by new range? */
-		if (entry->addr >= start && entry_end <= end) {
-			entry->type = new_type;
-			real_updated_size += entry->size;
-			continue;
-		}
+static void __init type_updater__new(struct e820_table *table, u64 new_start,
+				     u64 new_size,
+				     const struct e820_entry *original,
+				     const void *data)
+{
+	const struct e820_type_updater_data *type_updater_data = data;
 
-		/* New range is completely covered? */
-		if (entry->addr < start && entry_end > end) {
-			__e820__range_add(table, start, size, new_type);
-			__e820__range_add(table, end, entry_end - end, entry->type);
-			entry->size = start - entry->addr;
-			real_updated_size += size;
-			continue;
-		}
+	__e820__range_add(table, new_start, new_size,
+			  type_updater_data->new_type);
+}
 
-		/* Partially covered: */
-		final_start = max(start, entry->addr);
-		final_end = min(end, entry_end);
-		if (final_start >= final_end)
-			continue;
+static u64 __init __e820__range_update(struct e820_table *table, u64 start,
+				       u64 size, enum e820_type old_type,
+				       enum e820_type new_type)
+{
+	struct e820_entry_updater updater = {
+		.should_update = type_updater__should_update,
+		.update = type_updater__update,
+		.new = type_updater__new
+	};
 
-		__e820__range_add(table, final_start, final_end - final_start, new_type);
+	struct e820_type_updater_data data = {
+		.old_type = old_type,
+		.new_type = new_type
+	};
 
-		real_updated_size += final_end - final_start;
+	BUG_ON(old_type == new_type);
 
-		/*
-		 * Left range could be head or tail, so need to update
-		 * its size first:
-		 */
-		entry->size -= final_end - final_start;
-		if (entry->addr < final_start)
-			continue;
+	printk(KERN_DEBUG "e820: update [mem %#018Lx-%#018Lx] ", start,
+	       start + size - 1);
+	e820_print_type(old_type);
+	pr_cont(" ==> ");
+	e820_print_type(new_type);
+	pr_cont("\n");
 
-		entry->addr = final_end;
-	}
-	return real_updated_size;
+	return __e820__handle_range_update(table, start, size, &updater, &data);
 }
 
-u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
+/*
+ * Update type of addresses in [@start, @start + @size) from @old_type
+ * to @new_type in e820_table.
+ */
+u64 __init e820__range_update(u64 start, u64 size, enum e820_type old_type,
+			      enum e820_type new_type)
 {
 	return __e820__range_update(e820_table, start, size, old_type, new_type);
 }
 
-static u64 __init e820__range_update_kexec(u64 start, u64 size, enum e820_type old_type, enum e820_type  new_type)
+/*
+ * Update type of addresses in [@start, @start + @size) from @old_type
+ * to @new_type in e820_table_kexec.
+ */
+static u64 __init e820__range_update_kexec(u64 start, u64 size,
+					   enum e820_type old_type,
+					   enum e820_type new_type)
 {
 	return __e820__range_update(e820_table_kexec, start, size, old_type, new_type);
 }
-- 
2.30.2

