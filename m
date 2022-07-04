Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4CA565821
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 16:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbiGDOAE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiGDN7j (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:39 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F6BDF54
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:59:28 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id l7so3481473ual.9
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YiEyrkk7zAfWqeyIGUzFkmdI1NMExWAuPYFixtI2XBY=;
        b=RShTyro/t+3yHpqWRsCttc9MszdQZtO3zGbp/Xdpr35/Vq47G6fLUGZvcvHS5hwi/v
         WI4SjH57gA+ThZQkNBKiJ9M+QVum6LiE5aon0AseaOO816PXQSXgtyxtr2gsJc3rDVrZ
         EL/CSk67bbN1oPa+SqqjhG3nRkJLpfg03JS2CZm0wuLUEV05jVU4daNaRVD+SgGAOvfi
         axEOBfzsCw0Y5DmnACNzWhubwKbO6sb56iuZsrvH/seJCleBZslWdr74yxXTJmw35nBx
         Cd4L1df5X3jmGhSMFgFRiBqu7MVwN31ka2hQjX4xXKhwrK+hTCAMSnxABA0y8UNMbPa4
         QeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YiEyrkk7zAfWqeyIGUzFkmdI1NMExWAuPYFixtI2XBY=;
        b=cIa6pC5SuM5f6/Ll3vuVBfUcLxeQLHWQQXXFrruSRMOz6y+OcxOpWc2I+hgdcbXlrp
         HtnUPR7VWqu9UvCwH2dwB4HkBlXALfzpA7WxKe8/nifiVvjBbWl7urDMW5ftLHppc3p/
         A80jBhbOQaB6f3a4ATwv8UQ/mgFPJgRdJ9nbvBrJk5FH53iXhpTYi7XBj9U8HCiARgUE
         DkxIe+hd4MD5to9MevWhMPHbOJ3AVAD70LZl6GXJ+hCZJezi3Tbfsu15iFUNE2bB6Vcx
         MB8lKijYCjSgObF36OhQXHPbUYyTABL+NMo03LOBLR6vVnsRjRTF3vZLjm8r9fwwsyty
         te1g==
X-Gm-Message-State: AJIora8mx+irRyXeR2FQuKmv/cks4aTVfLvMMi782mCbZ40k5HXtMGGC
        19E6D0eohODhGtTQzg0Uhyja5g==
X-Google-Smtp-Source: AGRyM1uh+dtYwcEVNnwTgVE50IeoqbYCHITAu0RuThJV5+xla1vgT2mPtaGX0ThCQRCIvsXn4jKOcw==
X-Received: by 2002:ab0:409:0:b0:382:746b:4c5a with SMTP id 9-20020ab00409000000b00382746b4c5amr3162878uav.83.1656943167360;
        Mon, 04 Jul 2022 06:59:27 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id r1-20020a1fa801000000b0036ca2afd7c9sm5759379vke.0.2022.07.04.06.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:59:26 -0700 (PDT)
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
Subject: [PATCH v9 6/9] x86/e820: Tag e820_entry with crypto capabilities
Date:   Mon,  4 Jul 2022 10:58:30 -0300
Message-Id: <20220704135833.1496303-7-martin.fernandez@eclypsium.com>
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

Add a new enum for crypto capabilities. I choosed an enum instead of a
boolean for more visibility in the code and because maybe in the
future we would like to track from where the cryptographic
capabilities comes (in this case, the EFI memmap).

Add a new member in e820_entry to hold this new enum.

Add a new function e820__range_set_crypto_capable to mark all the
entries in a range of addresses as encryptable. This will be called
when initializing EFI.

Change e820__update_table to handle merging and overlap problems
taking into account crypto_capable.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/include/asm/e820/api.h   |  1 +
 arch/x86/include/asm/e820/types.h | 12 +++--
 arch/x86/kernel/e820.c            | 88 +++++++++++++++++++++++++++++--
 3 files changed, 93 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
index e8f58ddd06d9..4b3b01fafdd1 100644
--- a/arch/x86/include/asm/e820/api.h
+++ b/arch/x86/include/asm/e820/api.h
@@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
 extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
 extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
 extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
+extern u64  e820__range_set_crypto_capable(u64 start, u64 size);
 
 extern void e820__print_table(char *who);
 extern int  e820__update_table(struct e820_table *table);
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d886d0..aef03c665f5e 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -46,6 +46,11 @@ enum e820_type {
 	E820_TYPE_RESERVED_KERN	= 128,
 };
 
+enum e820_crypto_capabilities {
+	E820_NOT_CRYPTO_CAPABLE	= 0,
+	E820_CRYPTO_CAPABLE	= 1,
+};
+
 /*
  * A single E820 map entry, describing a memory range of [addr...addr+size-1],
  * of 'type' memory type:
@@ -53,9 +58,10 @@ enum e820_type {
  * (We pack it because there can be thousands of them on large systems.)
  */
 struct e820_entry {
-	u64			addr;
-	u64			size;
-	enum e820_type		type;
+	u64				addr;
+	u64				size;
+	enum e820_type			type;
+	enum e820_crypto_capabilities	crypto_capable;
 } __attribute__((packed));
 
 /*
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 0e5aa13ebdb8..dade59758b9f 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -163,7 +163,9 @@ int e820__get_entry_type(u64 start, u64 end)
 /*
  * Add a memory region to the kernel E820 map.
  */
-static void __init __e820__range_add(struct e820_table *table, u64 start, u64 size, enum e820_type type)
+static void __init __e820__range_add(struct e820_table *table, u64 start,
+				     u64 size, enum e820_type type,
+				     enum e820_crypto_capabilities crypto_capable)
 {
 	int x = table->nr_entries;
 
@@ -176,12 +178,13 @@ static void __init __e820__range_add(struct e820_table *table, u64 start, u64 si
 	table->entries[x].addr = start;
 	table->entries[x].size = size;
 	table->entries[x].type = type;
+	table->entries[x].crypto_capable = crypto_capable;
 	table->nr_entries++;
 }
 
 void __init e820__range_add(u64 start, u64 size, enum e820_type type)
 {
-	__e820__range_add(e820_table, start, size, type);
+	__e820__range_add(e820_table, start, size, type, E820_NOT_CRYPTO_CAPABLE);
 }
 
 static void __init e820_print_type(enum e820_type type)
@@ -211,6 +214,8 @@ void __init e820__print_table(char *who)
 			e820_table->entries[i].addr + e820_table->entries[i].size - 1);
 
 		e820_print_type(e820_table->entries[i].type);
+		if (e820_table->entries[i].crypto_capable == E820_CRYPTO_CAPABLE)
+			pr_cont("; crypto-capable");
 		pr_cont("\n");
 	}
 }
@@ -327,6 +332,7 @@ int __init e820__update_table(struct e820_table *table)
 	unsigned long long last_addr;
 	u32 new_nr_entries, overlap_entries;
 	u32 i, chg_idx, chg_nr;
+	enum e820_crypto_capabilities current_crypto, last_crypto;
 
 	/* If there's only one memory region, don't bother: */
 	if (table->nr_entries < 2)
@@ -367,6 +373,7 @@ int __init e820__update_table(struct e820_table *table)
 	new_nr_entries = 0;	 /* Index for creating new map entries */
 	last_type = 0;		 /* Start with undefined memory type */
 	last_addr = 0;		 /* Start with 0 as last starting address */
+	last_crypto = E820_NOT_CRYPTO_CAPABLE;
 
 	/* Loop through change-points, determining effect on the new map: */
 	for (chg_idx = 0; chg_idx < chg_nr; chg_idx++) {
@@ -388,13 +395,19 @@ int __init e820__update_table(struct e820_table *table)
 		 * 1=usable, 2,3,4,4+=unusable)
 		 */
 		current_type = 0;
+		current_crypto = E820_CRYPTO_CAPABLE;
 		for (i = 0; i < overlap_entries; i++) {
+			if (overlap_list[i]->crypto_capable < current_crypto)
+				current_crypto = overlap_list[i]->crypto_capable;
+
 			if (overlap_list[i]->type > current_type)
 				current_type = overlap_list[i]->type;
 		}
 
 		/* Continue building up new map based on this information: */
-		if (current_type != last_type || e820_nomerge(current_type)) {
+		if (current_type != last_type ||
+		    current_crypto != last_crypto ||
+		    e820_nomerge(current_type)) {
 			if (last_type != 0)	 {
 				new_entries[new_nr_entries].size = change_point[chg_idx]->addr - last_addr;
 				/* Move forward only if the new size was non-zero: */
@@ -406,9 +419,12 @@ int __init e820__update_table(struct e820_table *table)
 			if (current_type != 0)	{
 				new_entries[new_nr_entries].addr = change_point[chg_idx]->addr;
 				new_entries[new_nr_entries].type = current_type;
+				new_entries[new_nr_entries].crypto_capable = current_crypto;
+
 				last_addr = change_point[chg_idx]->addr;
 			}
 			last_type = current_type;
+			last_crypto = current_crypto;
 		}
 	}
 
@@ -572,7 +588,8 @@ __e820__handle_range_update(struct e820_table *table,
 				 * of the current entry
 				 */
 				__e820__range_add(table, end, entry_end - end,
-						  entry->type);
+						  entry->type,
+						  entry->crypto_capable);
 
 				updated_size += size;
 			} else {
@@ -618,7 +635,8 @@ static void __init type_updater__new(struct e820_table *table, u64 new_start,
 	const struct e820_type_updater_data *type_updater_data = data;
 
 	__e820__range_add(table, new_start, new_size,
-			  type_updater_data->new_type);
+			  type_updater_data->new_type,
+			  original->crypto_capable);
 }
 
 static u64 __init __e820__range_update(struct e820_table *table, u64 start,
@@ -719,6 +737,64 @@ u64 __init e820__range_remove(u64 start, u64 size, enum e820_type old_type,
 					   &data);
 }
 
+static bool __init crypto_updater__should_update(const struct e820_entry *entry,
+						 const void *data)
+{
+	const enum e820_crypto_capabilities *crypto_capable = data;
+
+	return *crypto_capable != entry->crypto_capable;
+}
+
+static void __init crypto_updater__update(struct e820_entry *entry,
+					  const void *data)
+{
+	const enum e820_crypto_capabilities *crypto_capable = data;
+
+	entry->crypto_capable = *crypto_capable;
+}
+
+static void __init crypto_updater__new(struct e820_table *table, u64 new_start,
+				       u64 new_size,
+				       const struct e820_entry *original,
+				       const void *data)
+{
+	const enum e820_crypto_capabilities *crypto_capable = data;
+
+	__e820__range_add(table, new_start, new_size, original->type, *crypto_capable);
+}
+
+static u64 __init
+__e820__range_update_crypto(struct e820_table *table, u64 start, u64 size,
+			    enum e820_crypto_capabilities crypto_capable)
+{
+	struct e820_entry_updater updater = {
+		.should_update = crypto_updater__should_update,
+		.update = crypto_updater__update,
+		.new = crypto_updater__new
+	};
+
+	printk(KERN_DEBUG "e820: crypto update [mem %#018Lx-%#018Lx]", start,
+	       start + size - 1);
+	pr_cont(" ==> ");
+	if (crypto_capable == E820_CRYPTO_CAPABLE)
+		pr_cont("crypto capable");
+	else
+		pr_cont("not crypto capable");
+	pr_cont("\n");
+
+	return __e820__handle_range_update(table, start, size, &updater,
+					   &crypto_capable);
+}
+
+/*
+ * Set %E820_CRYPTO_CAPABLE to [@start, @start + @size) in e820_table.
+ */
+u64 __init e820__range_set_crypto_capable(u64 start, u64 size)
+{
+	return __e820__range_update_crypto(e820_table, start, size,
+					   E820_CRYPTO_CAPABLE);
+}
+
 void __init e820__update_table_print(void)
 {
 	if (e820__update_table(e820_table))
@@ -1461,6 +1537,8 @@ void __init e820__memblock_setup(void)
 			continue;
 
 		memblock_add(entry->addr, entry->size);
+		if (entry->crypto_capable == E820_CRYPTO_CAPABLE)
+			memblock_mark_crypto_capable(entry->addr, entry->size);
 	}
 
 	/* Throw away partial pages: */
-- 
2.30.2

