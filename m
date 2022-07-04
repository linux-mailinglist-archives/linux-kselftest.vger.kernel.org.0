Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A857356580B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 15:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234810AbiGDN71 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbiGDN7L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:11 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B73DF42
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:59:07 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id z66so9095446vsb.3
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bzJenq/qxXZmxxl1Ksk6HJARtm3Ihl+B/CevCTs1JBk=;
        b=X2BYzcnRkUF9v6ZNqHr/J99bVmc6++VMWdfFNw36eEddAOQr4vRkHVyotRUK42q4bW
         5fK+j8JbnkgPutr6FLwuTu4IhOuvnYXJK9KhSRIE074BY3hJIA/dSCQ0ZPokoYKRq9bG
         K2w65R5Pr8SdwAtf0y4ushiB/Qi4Gt/KoqyOQ6V7U/lK23q17WXGXZaYWD0URiM/D1lA
         KKLDW8cek6v4qnaFNCRC1ANZEcL0kVN0mz+4wBzKyMnZ1sxdBX07rM3AMrM19cVrRaxe
         8WAHIANoBJg3qczWKPs9+w29IEuY+hvYAIDCH3/4EoTNTkMSYKR8Y4WjU1ffGUNI3QKy
         Aebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bzJenq/qxXZmxxl1Ksk6HJARtm3Ihl+B/CevCTs1JBk=;
        b=ToO5/ai2t368HmqjzObap9u6eXbO8dtWT7xZbFm+iH/RpYHMPJ3tHbxnNuncUNGNUg
         V32GAo785nxJXPus3cZMqbiTA37t6NcRPAIuhfl9DxTj8u3gvKpvo6atzdmjd68BV2DX
         CLESGF+037YwfLSJYhr2wDnj8s8jmc3tBzuDKOEeCd60jR0lNjO9KObHc2Si7eKO4vRI
         37bkVonGlggknYY/TkKVfzHJWQzds5nYRkiGKWygKzP5GQXpoX05I7LaxA8HaJwkQdn1
         caruskfOcTW15nmu0Eu0s7QpwisL9N7S23468cpjwFFou78rm2GZSxJ8NqPvsKg95oHF
         lXBg==
X-Gm-Message-State: AJIora8c39adOJUMK1WstHAja9JvbLKFV9AL1Gx0HJm/b589mJ8hSdPL
        i+FQ61JglzdVTjpfQKFFsnVIyw==
X-Google-Smtp-Source: AGRyM1sww168oavtBsM/BaefGrhT8xpWzlBWhslMAxgTNmfgjWhNTVANPgnpuFJruMWEoqpoYBxi6Q==
X-Received: by 2002:a67:f74c:0:b0:354:5c29:aad7 with SMTP id w12-20020a67f74c000000b003545c29aad7mr14534161vso.40.1656943146559;
        Mon, 04 Jul 2022 06:59:06 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id j68-20020a1fa047000000b0036cefdde1cbsm4173891vke.10.2022.07.04.06.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:59:06 -0700 (PDT)
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
Subject: [PATCH v9 3/9] x86/e820: Add infrastructure to refactor e820__range_{update,remove}
Date:   Mon,  4 Jul 2022 10:58:27 -0300
Message-Id: <20220704135833.1496303-4-martin.fernandez@eclypsium.com>
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

__e820__range_update and e820__range_remove had a very similar flow in
its implementation with a few lines different from each other, the
lines that actually perform the modification over the e820_table. The
similiraties were found in the checks for the different cases on how
each entry intersects with the given range (if it does at all). These
checks were very presice and error prone so it was not a good idea to
have them in both places.

Since I need to add a third one, similar to this two, in this and the
following patches I'll propose a refactor of these functions.

In this patch I introduce:

- A new type e820_entry_updater that will carry three callbacks, those
callbacks will decide WHEN to perform actions over the e820_table and
WHAY actions are going to be performed.

  Note that there is a void pointer "data". This pointer will carry
  useful information for the callbacks, like the type that we want to
  update in e820__range_update or if we want to check the type in
  e820__range_remove. Check it out in the next patches where I do the
  rework of __e820__range_update and e820__range_remove.

- A new function __e820__handle_range_update that has the flow of the
original two functions to refactor. Together with e820_entry_updater
will perform the desired update on the input table.

On version 6 of this patch some people pointed out that this solution
was over-complicated. Mike Rapoport suggested a another solution [1].

I took a look at that, and although it is indeed simpler it's more
confusing at the same time. I think is manageable to have a single
function to update or remove sections of the table (what Mike did),
but when I added the functionality to also update the crypto_capable
it became really hard to manage.

I think that the approach presented in this patch it's complex but is
easier to read, to extend and to test.

[1] https://git.kernel.org/rppt/h/x86/e820-update-range

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>

--------------------------------------------------

Changes from v7 to v8:

(Some) Callbacks of e820_entry_updater can now be NULL to avoid
defining empty functions

Remove kerneldocs in favor of plain comments just to explain what the
functions do.
---
 arch/x86/kernel/e820.c | 127 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..e0fa3ab755a5 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -459,6 +459,133 @@ static int __init append_e820_table(struct boot_e820_entry *entries, u32 nr_entr
 	return __append_e820_table(entries, nr_entries);
 }
 
+/**
+ * struct e820_entry_updater - Helper type for
+ * __e820__handle_range_update().
+ * @should_update: Return true if @entry needs to be updated, false
+ * otherwise.
+ * @update: Apply desired actions to an @entry that is inside the
+ * range and satisfies @should_update. Can be set to NULL to avoid empty functions.
+ * @new: Create new entry in the table with information gathered from
+ * @original and @data. Can be set to NULL to avoid empty functions.
+ *
+ * Each function corresponds to an action that
+ * __e820__handle_range_update() does. Callbacks need to cast @data back
+ * to the corresponding type.
+ */
+struct e820_entry_updater {
+	bool (*should_update)(const struct e820_entry *entry, const void *data);
+	void (*update)(struct e820_entry *entry, const void *data);
+	void (*new)(struct e820_table *table, u64 new_start, u64 new_size,
+		    const struct e820_entry *original, const void *data);
+};
+
+/*
+ * Helper for __e820__handle_range_update to handle the case where
+ * neither the entry completely covers the range nor the range
+ * completely covers the entry.
+ */
+static u64 __init
+__e820__handle_intersected_range_update(struct e820_table *table,
+					u64 start,
+					u64 size,
+					struct e820_entry *entry,
+					const struct e820_entry_updater *updater,
+					const void *data)
+{
+	u64 end;
+	u64 entry_end = entry->addr + entry->size;
+	u64 inner_start;
+	u64 inner_end;
+	u64 updated_size = 0;
+
+	if (size > (ULLONG_MAX - start))
+		size = ULLONG_MAX - start;
+
+	end = start + size;
+	inner_start = max(start, entry->addr);
+	inner_end = min(end, entry_end);
+
+	/* Range and entry do intersect and... */
+	if (inner_start < inner_end) {
+		/* Entry is on the left */
+		if (entry->addr < inner_start) {
+			/* Resize current entry */
+			entry->size = inner_start - entry->addr;
+		/* Entry is on the right */
+		} else {
+			/* Resize and move current section */
+			entry->addr = inner_end;
+			entry->size = entry_end - inner_end;
+		}
+		if (updater->new != NULL)
+			/* Create new entry with intersected region */
+			updater->new(table, inner_start, inner_end - inner_start, entry, data);
+
+		updated_size += inner_end - inner_start;
+	} /* Else: [start, end) doesn't cover entry */
+
+	return updated_size;
+}
+
+/*
+ * Update the table @table in [@start, @start + @size) doing the
+ * actions given in @updater.
+ */
+static u64 __init
+__e820__handle_range_update(struct e820_table *table,
+			    u64 start,
+			    u64 size,
+			    const struct e820_entry_updater *updater,
+			    const void *data)
+{
+	u64 updated_size = 0;
+	u64 end;
+	unsigned int i;
+
+	if (size > (ULLONG_MAX - start))
+		size = ULLONG_MAX - start;
+
+	end = start + size;
+
+	for (i = 0; i < table->nr_entries; i++) {
+		struct e820_entry *entry = &table->entries[i];
+		u64 entry_end = entry->addr + entry->size;
+
+		if (updater->should_update(entry, data)) {
+			/* Range completely covers entry */
+			if (entry->addr >= start && entry_end <= end) {
+				updated_size += entry->size;
+				if (updater->update != NULL)
+					updater->update(entry, data);
+			/* Entry completely covers range */
+			} else if (start > entry->addr && end < entry_end) {
+				/* Resize current entry */
+				entry->size = start - entry->addr;
+
+				if (updater->new != NULL)
+					/* Create new entry with intersection region */
+					updater->new(table, start, size, entry, data);
+
+				/*
+				 * Create a new entry for the leftover
+				 * of the current entry
+				 */
+				__e820__range_add(table, end, entry_end - end,
+						  entry->type);
+
+				updated_size += size;
+			} else {
+				updated_size +=
+					__e820__handle_intersected_range_update(table, start, size,
+										entry, updater, data);
+			}
+		}
+	}
+
+	return updated_size;
+}
+
 static u64 __init
 __e820__range_update(struct e820_table *table, u64 start, u64 size, enum e820_type old_type, enum e820_type new_type)
 {
-- 
2.30.2

