Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC0B654916
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 00:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLVXFM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 18:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVXFL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 18:05:11 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2281827176
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 15:05:10 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id j21-20020a63fc15000000b00476d6932baeso1772573pgi.23
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 15:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBAw5tj+XZKcsIopd0PuHb+ptawoD6UcsAoOXegakKM=;
        b=FfldrF5j7ml2+CyoMh3UJZdx5Pxju6v8JLoR8Wzy2EtSgDfNcusRpSzdVQZqNygCpn
         SZ3vOQ6VlsgZiFOoPcrXdy5xDFDbcJD/VaI9iTUAl7/NsaqKVRVqapxytseWUc4rxYBH
         xiqb0qD98zWkh6H6j4ELJo4ovoYeP0IZbdw854nhsTbtx2jvusYI+QDJDGyrw2+aM6H+
         f7hkkezSm6ioLPf8mXrkiHjkzaSv4O6onclZxkidov4mde4JXNvddnVQ4rQkCr7Wvy7n
         kzX4IbhrucHz5Oi6mBMDXXoGgivY91w9kHq7+mGfV3bKJplyLAVLEEm+vqdg+WTgxOG0
         lZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBAw5tj+XZKcsIopd0PuHb+ptawoD6UcsAoOXegakKM=;
        b=ZHoVrCIwNNEQ2ogbyzqWQiybXMv5cDbzch3oIMrT5C41wxCCvM+8UFUS/Eiupbo0LR
         QaFtcvS4CGUFGShTy44Kpmrh4SPM+XlXw1QUCSSmiBsMgGC9MK1i3ZRX+WzY7xTqVuG+
         LNKzUTI1rLR9dbxZ4D5Zl4bYW5yh+ha5j7a+ZEz/3gkqcHP0VzDzwp+16LLlWzD/MWiH
         1pLzTaAhQrXNMejHoydcyjliMxWHEVvT1uc5tcYIo3IjOygIiXwDGqxY4xSBs1Ijl6Ug
         qBHhc75nc12LOQ6ZlZm7vR4ZMokldYra5yLabJOK3nbeFT5aLqgP2x6ClpUXwtCFl76y
         0ATw==
X-Gm-Message-State: AFqh2koHo1yANJ4pBwK2ijYMO+H3v92ImULkP51lGtJpyqCnEA4mTlwM
        BnrOOk2L+tsbXZoygIcAulwOU8Nlle5kE14X
X-Google-Smtp-Source: AMrXdXtZlLSwGeOw1fDYwDB6/onhlXQraxe0XRLS92zZDtVnK31Kdv0Z6As55v2VbKjC/TUH0H08l4HhIgez3WZJ
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90a:7083:b0:219:2d33:9504 with SMTP
 id g3-20020a17090a708300b002192d339504mr597027pjk.171.1671750309699; Thu, 22
 Dec 2022 15:05:09 -0800 (PST)
Date:   Thu, 22 Dec 2022 23:04:57 +0000
In-Reply-To: <20221222230458.3828342-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221222230458.3828342-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221222230458.3828342-2-vannapurve@google.com>
Subject: [V3 PATCH 1/2] KVM: selftests: x86: Cache the cpu vendor type
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, shuah@kernel.org, bgardon@google.com,
        seanjc@google.com, oupton@google.com, peterx@redhat.com,
        vkuznets@redhat.com, dmatlack@google.com, pgonda@google.com,
        andrew.jones@linux.dev, Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Query cpuid once per guest selftest and store the cpu vendor type so that
subsequent queries can reuse the cached cpu vendor type.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/lib/x86_64/processor.c      | 33 ++++++++++++++++---
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 097cef430774..1e93bb3cb058 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -20,6 +20,9 @@
 
 vm_vaddr_t exception_handlers;
 
+static bool is_cpu_vendor_intel;
+static bool is_cpu_vendor_amd;
+
 static void regs_dump(FILE *stream, struct kvm_regs *regs, uint8_t indent)
 {
 	fprintf(stream, "%*srax: 0x%.16llx rbx: 0x%.16llx "
@@ -1017,18 +1020,36 @@ void kvm_x86_state_cleanup(struct kvm_x86_state *state)
 	free(state);
 }
 
-static bool cpu_vendor_string_is(const char *vendor)
+static void check_cpu_vendor(void)
 {
-	const uint32_t *chunk = (const uint32_t *)vendor;
+	const char *intel_id = "GenuineIntel";
+	const uint32_t *intel_id_chunks = (const uint32_t *)intel_id;
+	const char *amd_id = "AuthenticAMD";
+	const uint32_t *amd_id_chunks = (const uint32_t *)amd_id;
+	static bool cpu_vendor_checked;
 	uint32_t eax, ebx, ecx, edx;
 
+	if (cpu_vendor_checked)
+		return;
+
 	cpuid(0, &eax, &ebx, &ecx, &edx);
-	return (ebx == chunk[0] && edx == chunk[1] && ecx == chunk[2]);
+
+	if (ebx == intel_id_chunks[0] && edx == intel_id_chunks[1] &&
+		ecx == intel_id_chunks[2])
+		is_cpu_vendor_intel = true;
+	else {
+		if (ebx == amd_id_chunks[0] && edx == amd_id_chunks[1] &&
+			ecx == amd_id_chunks[2])
+			is_cpu_vendor_amd = true;
+	}
+	cpu_vendor_checked = true;
 }
 
 bool is_intel_cpu(void)
 {
-	return cpu_vendor_string_is("GenuineIntel");
+	check_cpu_vendor();
+
+	return is_cpu_vendor_intel;
 }
 
 /*
@@ -1036,7 +1057,9 @@ bool is_intel_cpu(void)
  */
 bool is_amd_cpu(void)
 {
-	return cpu_vendor_string_is("AuthenticAMD");
+	check_cpu_vendor();
+
+	return is_cpu_vendor_amd;
 }
 
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
-- 
2.39.0.314.g84b9a713c41-goog

