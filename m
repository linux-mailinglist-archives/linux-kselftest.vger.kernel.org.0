Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D432565825
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 16:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiGDOAT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiGDN75 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 09:59:57 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C57DFC3
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 06:59:42 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id j1so9071606vsj.12
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFcwfz9YjnTwBY53CZ26/cKSWQCH95fLXQHITYfVqQs=;
        b=CQTNFByZSPbcjp+kBGJxruUIiefylatXkTKZ4UXWXph7ZtNVp8T6HpEfD1XKzuncEy
         y3FR1f6yAyetwOtLdPHa0NQDBeJgn7zQpIarid63VNYuSxz4OGxt1VLadB3LAfdvW+aw
         JwrhslRX3sESXzTPsm5dzaMQdQKd1ykl1P4YJXXYlQn3Wb8Q0Ro2q8KdWxdfb1ke5HU5
         cTmyxBSvuFbDFi2x49F91NFcxUqn/XPns/cqItahB3rYnpS0VgEsz46iamTD1IvZni3+
         s4yfyUsSiGmDTuIfozuuX80v86m2Q/l0Op6AZ+KtMUA/qUrt2196D1PPf4BMGWhUuzJG
         gU0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFcwfz9YjnTwBY53CZ26/cKSWQCH95fLXQHITYfVqQs=;
        b=5I/qmj4qb7+3ujzaK84UFoMcomB71DSWIcs5awSWgmhe0IVSymb8WGwItPSZGAhfyh
         EuVNUQ9rKvoyN5j0JnFzKJwy9o+pke22NR3zd6xkbzXX2r9aip1YnGaYu/j1AFnPfW6Y
         6I3LHheGtxry3J0lYnrgQtQENJSVDDua+v1Ffue2Zm4+8yjdpQ+TEGO3Fsa+24dB3DsY
         SdYwA4sLy0WB4s+cimWeSD0/3IiYSlTUqIAIlUvoWNloS5wo0fdnU4ickKd73x3Y0Qf5
         T4EJNe1ZUcrh2xsENHoLMfew3H36EcgIfyD022WTUBh7UGR+QUaCUVlKk7E+CkvR8Uq0
         e2Vg==
X-Gm-Message-State: AJIora827DIeoKgAXTkupZsTqNHC7/RXgzuJrbMfXRfmfbREc+2bTbcp
        H6T9xdYDx3B4XuFIOHySIyAxNQ==
X-Google-Smtp-Source: AGRyM1u4xzaefoptHuBiQ/eWFY+5bcW4tRDbJaAC2o6qv7KsWce1Xme3nK+Lkq/KSfHakteIXi79og==
X-Received: by 2002:a05:6102:4410:b0:356:f108:157b with SMTP id df16-20020a056102441000b00356f108157bmr272236vsb.66.1656943181405;
        Mon, 04 Jul 2022 06:59:41 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id q192-20020a1f5cc9000000b00356d8a0fbb2sm4413105vkb.51.2022.07.04.06.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 06:59:41 -0700 (PDT)
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
Subject: [PATCH v9 8/9] x86/efi: Mark e820_entries as crypto capable from EFI memmap
Date:   Mon,  4 Jul 2022 10:58:32 -0300
Message-Id: <20220704135833.1496303-9-martin.fernandez@eclypsium.com>
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

Add a function to iterate over the EFI Memory Map and mark the regions
tagged with EFI_MEMORY_CPU_CRYPTO in the e820_table; and call it from
efi_init if add_efi_memmap is disabled.

Also modify do_add_efi_memmap to mark the regions there.

If add_efi_memmap is false, also check that the e820_table has enough
size to (possibly) store also the EFI memmap.

Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
---
 arch/x86/platform/efi/efi.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 1591d67e0bcd..397d5e54d65e 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -187,6 +187,8 @@ static void __init do_add_efi_memmap(void)
 		}
 
 		e820__range_add(start, size, e820_type);
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_set_crypto_capable(start, size);
 	}
 	e820__update_table(e820_table);
 }
@@ -444,6 +446,34 @@ static int __init efi_config_init(const efi_config_table_type_t *arch_tables)
 	return ret;
 }
 
+static void __init efi_mark_e820_regions_as_crypto_capable(void)
+{
+	efi_memory_desc_t *md;
+
+	/*
+	 * Calling e820__range_set_crypto_capable several times
+	 * creates a bunch of entries in the E820 table. They probably
+	 * will get merged when calling update_table but we need the
+	 * space there anyway
+	 */
+	if (efi.memmap.nr_map + e820_table->nr_entries >= E820_MAX_ENTRIES) {
+		pr_err_once("E820 table is not large enough to fit EFI memmap; not marking entries as crypto capable\n");
+		return;
+	}
+
+	for_each_efi_memory_desc(md) {
+		if (md->attribute & EFI_MEMORY_CPU_CRYPTO)
+			e820__range_set_crypto_capable(md->phys_addr,
+						       md->num_pages << EFI_PAGE_SHIFT);
+	}
+
+	/*
+	 * We added and modified regions so it's good to update the
+	 * table to merge/sort
+	 */
+	e820__update_table(e820_table);
+}
+
 void __init efi_init(void)
 {
 	if (IS_ENABLED(CONFIG_X86_32) &&
@@ -497,6 +527,13 @@ void __init efi_init(void)
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 	efi_clean_memmap();
 
+	/*
+	 * If add_efi_memmap then there is no need to mark the regions
+	 * again
+	 */
+	if (!add_efi_memmap)
+		efi_mark_e820_regions_as_crypto_capable();
+
 	if (efi_enabled(EFI_DBG))
 		efi_print_memmap();
 }
-- 
2.30.2

