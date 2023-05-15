Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EBA702D89
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbjEONHH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjEONGo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:06:44 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8978C26BC
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:15 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ab267e3528so90729055ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 15 May 2023 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684155966; x=1686747966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD0d2al7XFldRkjYP37ZWtTdhmPaRGV8lU2SKIN3qFc=;
        b=Md2uy27iyG56QmAk/eMUrPY9FgIbjWQ34NOlHqHXzvq/n+f6KFeUNnAfHdTfIROgpr
         i+HrFD3SDGN7cdg0bpeMPna+t3GxvzduQzy5yue646dWIIdgWqwFvGeyeP2WvGuBIaf9
         lca9gTUHWxnlNULGlhCBRARLT0/pk0Uz/OAmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155966; x=1686747966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oD0d2al7XFldRkjYP37ZWtTdhmPaRGV8lU2SKIN3qFc=;
        b=GVGfW1vSEWM6KIztvG6DN8c1iPzlPpvs0V27DDtoM6jAX4KbQdaQ/E2fl9pSksNFoT
         ykRCPc3hN04A+0cyNvqOBsLeJUzlFajVA/gbgQr0DMLc/htk1SaYrFELrSVZcj41XlBy
         BwnEpPUZrNLARJTwHB2dYU7WmE8Dj0afh+cip2AU29OoIG1SdWqqj4YpxgRu43ncNAMv
         SfoW9MuaaXJ6YDXSf2orH/5F4foqtgEy/JkEGLpO1G/f57pngOTMbu7J1kNlxFRzdSRK
         0nrbram2sgaqvMrF4s41MpLV4iGu9AfHmx+KNo70GtxTATyIqlGtoFgcaTh/IL1Pvcjc
         SXZg==
X-Gm-Message-State: AC+VfDyGBgrBhlfQzTm2k5rIrsLtcavfTkqT2SgEG1LGyr9ZYOIXaevX
        6vBr54Us/w3v7TO/7aL27HdbWg==
X-Google-Smtp-Source: ACHHUZ7kRs6SmTa1z+RVcotvr+mhyGciDo5UlpdWfWoFRJZOmx9Unzfl0FpNuZrj13ngH72aAGPZ1g==
X-Received: by 2002:a17:903:234f:b0:1ae:bf5:7b5 with SMTP id c15-20020a170903234f00b001ae0bf507b5mr6078985plh.34.1684155966087;
        Mon, 15 May 2023 06:06:06 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id g13-20020a170902c38d00b0019f9fd10f62sm13454823plg.70.2023.05.15.06.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 06:06:05 -0700 (PDT)
From:   jeffxu@chromium.org
To:     dave.hansen@intel.com, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 6/6] PKEY:selftest pkey_enforce_api for munmap
Date:   Mon, 15 May 2023 13:05:52 +0000
Message-ID: <20230515130553.2311248-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230515130553.2311248-1-jeffxu@chromium.org>
References: <20230515130553.2311248-1-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add selftest for pkey_enforce_api for mprotect

Signed-off-by: Jeff Xu<jeffxu@google.com>
---
 tools/testing/selftests/mm/pkey_enforce_api.c | 437 ++++++++++++++++++
 1 file changed, 437 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey_enforce_api.c b/tools/testing/selftests/mm/pkey_enforce_api.c
index 23663c89bc9c..92aa29248e1f 100644
--- a/tools/testing/selftests/mm/pkey_enforce_api.c
+++ b/tools/testing/selftests/mm/pkey_enforce_api.c
@@ -833,6 +833,429 @@ void test_mprotect_child_thread(bool enforce)
 	clean_single_address_with_pkey(pkey, ptr, size);
 }
 
+// mmap one address with one page.
+// assign PKEY to the address.
+// munmap on the address is protected.
+void test_munmap_single_address(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_single_address_with_pkey(enforce, size, &pkey, &ptr);
+
+	// disable write access.
+	pkey_write_deny(pkey);
+
+	ret = munmap(ptr, size);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr, size);
+		assert(!ret);
+	}
+
+	clean_single_address_with_pkey(pkey, ptr, size);
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to them with one mprotect_pkey call (merged address).
+// munmap two address in one call (merged address).
+void test_munmap_two_address_merge(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_with_pkey(enforce, size, &pkey, &ptr,
+						    &ptr2);
+
+	// disable write.
+	pkey_write_deny(pkey);
+
+	// munmap on both addresses with one call (merged).
+	ret = munmap(ptr, size * 2);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr, size * 2);
+		assert(!ret);
+	}
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to the second address.
+// munmap on the second address is protected.
+void test_munmap_two_address_deny_second(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_protect_second_with_pkey(
+		enforce, size, &pkey, &ptr, &ptr2);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	ret = munmap(ptr2, size);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr2, size);
+		assert(!ret);
+	}
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap two address (continuous two pages).
+// assign PKEY to the second address.
+// munmap on the range that includes the second address.
+void test_munmap_two_address_deny_range(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	void *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_two_continues_fixed_address_protect_second_with_pkey(
+		enforce, size, &pkey, &ptr, &ptr2);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	ret = munmap(ptr, size * 2);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr, size * 2);
+		assert(!ret);
+	}
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// munmap on memory range that includes the second pages is protected.
+void test_munmap_vma_middle_addr(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// munmap support merge, we are going to make sure we don't regress.
+	ret = munmap(addr1, size * 4);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr, size * 4);
+		assert(!ret);
+	}
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// munmap from 2nd page.
+void test_munmap_shrink(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// munmap support merge, we are going to make sure we don't regress.
+	ret = munmap(ptr2, size * 3);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr2, size * 3);
+		assert(!ret);
+	}
+
+	ret = munmap(ptr, size);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// munmap from 2nd page but size is less than one page
+void test_munmap_unaligned(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// munmap support merge, we are going to make sure we don't regress.
+	ret = munmap(ptr2, size - 1);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr2, size - 1);
+		assert(!ret);
+	}
+
+	ret = munmap(ptr, size * 4);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap one address with 4 pages.
+// assign PKEY to the second page only.
+// munmap from 2nd page but size is less than one page
+void test_munmap_unaligned2(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr, *ptr2, *ptr3;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_4pages_fixed_protect_second_page(enforce, size, &pkey, &ptr,
+					       &ptr2, &ptr3);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// munmap support merge, we are going to make sure we don't regress.
+	ret = munmap(ptr2, size + 1);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(ptr2, size + 1);
+		assert(!ret);
+	}
+
+	ret = munmap(ptr, size * 4);
+	assert(!ret);
+
+	ret = sys_pkey_free(pkey);
+	assert(ret == 0);
+}
+
+// mmap one address with one page.
+// assign PKEY to the address.
+// munmap on the address but with size of 4 pages(should OK).
+void test_munmap_outbound_addr(bool enforce)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_single_fixed_address_with_pkey(enforce, size, &pkey, &ptr);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	// Interesting enough, this is allowed, even the other 3 pages are not allocated.
+	ret = munmap(addr1, size * 4);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey);
+
+	if (enforce) {
+		ret = munmap(addr1, size * 4);
+		assert(!ret);
+	}
+
+	clean_single_address_with_pkey(pkey, ptr, size);
+}
+// mmap two addresses, with a page gap between two.
+// assign pkeys on both address.
+// disable access to the second address.
+// munmap from start of address1 to the end of address 2,
+// because there is a gap in the memory range, mprotect will fail.
+void test_munmap_gapped_address_with_two_pkeys(bool enforce)
+{
+	int pkey, pkey2;
+	int ret;
+	void *ptr, *ptr2;
+	int size = PAGE_SIZE;
+
+	LOG_TEST_ENTER(enforce);
+
+	setup_address_with_gap_two_pkeys(enforce, size, &pkey, &pkey2, &ptr,
+					 &ptr2);
+
+	// disable write access.
+	pkey_write_deny(pkey2);
+
+	// Interesting enough, this is allowed, even there is a gap beween address 1 and 2.
+	ret = munmap(addr1, size * 3);
+	if (enforce)
+		assert(ret < 0);
+	else
+		assert(!ret);
+
+	pkey_write_allow(pkey2);
+	if (enforce) {
+		ret = munmap(addr1, size * 3);
+		assert(!ret);
+	}
+}
+
+// use write-deny pkey and see if program can exit properly.
+// This is manual test, run it at end if needed.
+void test_exit_munmap_disable_write(void)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+
+	pkey = sys_pkey_alloc(PKEY_ENFORCE_API, 0);
+	assert(pkey > 0);
+
+	// allocate 1 page.
+	ptr = mmap(addr1, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr1);
+
+	// assign pkey to the first address.
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+				pkey);
+	assert(!ret);
+
+	// disable write through pkey.
+	pkey_write_deny(pkey);
+
+	ret = munmap(ptr, size);
+	assert(ret < 0);
+}
+
+// use disable-all pkey and see if program can exit properly.
+// This is manual test, run it at end if needed.
+void test_exit_munmap_disable_all(void)
+{
+	int pkey;
+	int ret;
+	void *ptr;
+	int size = PAGE_SIZE;
+
+	pkey = sys_pkey_alloc(PKEY_ENFORCE_API, 0);
+	assert(pkey > 0);
+
+	// allocate 1 page.
+	ptr = mmap(addr2, size, PROT_READ,
+		   MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	assert(ptr == addr2);
+
+	// assign pkey to the first address.
+	ret = sys_mprotect_pkey(ptr, size, PROT_READ | PROT_WRITE | PROT_EXEC,
+				pkey);
+	assert(!ret);
+
+	// disable write through pkey.
+	pkey_access_deny(pkey);
+
+	ret = munmap(addr1, size);
+	assert(ret < 0);
+}
+
 void test_enforce_api(void)
 {
 	for (int i = 0; i < 2; i++) {
@@ -848,7 +1271,21 @@ void test_enforce_api(void)
 		test_mprotect_unaligned2(enforce);
 		test_mprotect_child_thread(enforce);
 		test_mprotect_gapped_address_with_two_pkeys(enforce);
+
+		test_munmap_single_address(enforce);
+		test_munmap_two_address_merge(enforce);
+		test_munmap_two_address_deny_second(enforce);
+		test_munmap_two_address_deny_range(enforce);
+		test_munmap_vma_middle_addr(enforce);
+		test_munmap_outbound_addr(enforce);
+		test_munmap_shrink(enforce);
+		test_munmap_unaligned(enforce);
+		test_munmap_unaligned2(enforce);
+		test_munmap_gapped_address_with_two_pkeys(enforce);
 	}
+
+	test_exit_munmap_disable_write();
+	test_exit_munmap_disable_all();
 }
 
 int main(void)
-- 
2.40.1.606.ga4b1b128d6-goog

