Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D5957582A
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jul 2022 01:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbiGNXuv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jul 2022 19:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNXuu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jul 2022 19:50:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663756D9D9;
        Thu, 14 Jul 2022 16:50:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id ay25so1934653wmb.1;
        Thu, 14 Jul 2022 16:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14gDsozi2dxw36iEkIGIYX8ruOdQSltClzgyGBSvwFk=;
        b=QTSLPpcMK6UNDDFzArozTzjeYq/T6FkU0p6ZFqv4CsYkMU8UYFGCmpowTvfGWqdJnh
         NpJ649Yh6MHohMCeHxVX0VVypptQOczDV13puf7wGqbVtvj+G38QMQR6qtzih2N9VKDL
         kP8bVj1ZQ1tdrz87DWtY6WbV/wRfu+mYszLGaTqbbNUt+/Rn6Vv0Emg7hlsijzOaqIo2
         vUMqKhc7UXRkRHKPfaGMrOpsLDmWPtLT/qHqJekrphGjH7tQ1HlP3GTmW6U/ewDFfq5u
         JLMGa+XoAKJioLjAG09khYm/UC+3OsHfcSEnGc8wRBiaUmzt4DVdjQdToR7esSIKOqpB
         78UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=14gDsozi2dxw36iEkIGIYX8ruOdQSltClzgyGBSvwFk=;
        b=LBpRfxK2Uk+YSMvquNuOaUpzEKGwfoXl4jo/378/KVhdEBtFo/7ysOyAPK+m8YRTRe
         bfOq2GTdmE+aSMTYLxibBpqzKOMUfXy31fkgh5sFYw0Q2afhQy+hFHu1+Go0+8FxWLFV
         WIpjCTc8WZkOKlmNmrWSQ0JkgAXPIT+1vffOa1Ynxp0dGib0sRZnER/zYPmFjRryAk3b
         R7HwtHWX7LfU1vwj9UJatTwwOrO8XsARglpiJ81oREpxzdROHvfGs8/JdRjW/R+QeZhn
         j/Jp09SThTyKR0f87cY4RIZCqOJ6g6voiwbL3wRACY7G0rsHE+Ceb59C3g+U7cjhPCmx
         A3dw==
X-Gm-Message-State: AJIora9fE6tP83jTpSJdWA7v6SP9Sdz8zWHBOh3EL645W/r1nu10KH+E
        9oYJn0SoJbfqsALePLLUDl7Y5ppKBJk=
X-Google-Smtp-Source: AGRyM1tDqEf5e0eBYK0ycbdjnJC8BpH0NwXcMd/GEDaYfRLQNhJQWq5NOMETdDU3FmbubBNfcuun5w==
X-Received: by 2002:a05:600c:4f08:b0:3a1:99ed:4f1f with SMTP id l8-20020a05600c4f0800b003a199ed4f1fmr17363082wmq.199.1657842646873;
        Thu, 14 Jul 2022 16:50:46 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-102-55.retail.telecomitalia.it. [95.235.102.55])
        by smtp.gmail.com with ESMTPSA id a16-20020adfdd10000000b0021d6e917442sm2920854wrm.72.2022.07.14.16.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 16:50:45 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] firmware_loader: Replace kmap() with kmap_local_page()
Date:   Fri, 15 Jul 2022 01:50:30 +0200
Message-Id: <20220714235030.12732-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The use of kmap() is being deprecated in favor of kmap_local_page().

Two main problems with kmap(): (1) It comes with an overhead as mapping
space is restricted and protected by a global lock for synchronization and
(2) kmap() also requires global TLB invalidation when the kmap’s pool
wraps and it might block when the mapping space is fully utilized until a
slot becomes available.

kmap_local_page() is preferred over kmap() and kmap_atomic(). Where it
cannot mechanically replace the latters, code refactor should be considered
(special care must be taken if kernel virtual addresses are aliases in
different contexts).

With kmap_local_page() the mappings are per thread, CPU local, can take
page faults, and can be called from any context (including interrupts).

Call kmap_local_page() in firmware_loader wherever kmap() is currently
used. In firmware_rw() use the helpers copy_{from,to}_page() instead of
open coding the local mappings + memcpy().

Successfully tested with "firmware" selftests on a QEMU/KVM 32-bits VM
with 4GB RAM, booting a kernel with HIGHMEM64GB enabled.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: According to the comments from Greg Kroah-Hartman (thanks!),
extend the commit message adding information about why kmap() should be
avoided. Delete an unused variable left in the code of v1, which has been
Reported-by: kernel test robot <lkp@intel.com>

 drivers/base/firmware_loader/main.c  |  4 ++--
 drivers/base/firmware_loader/sysfs.c | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index ac3f34e80194..7c3590fd97c2 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -435,11 +435,11 @@ static int fw_decompress_xz_pages(struct device *dev, struct fw_priv *fw_priv,
 
 		/* decompress onto the new allocated page */
 		page = fw_priv->pages[fw_priv->nr_pages - 1];
-		xz_buf.out = kmap(page);
+		xz_buf.out = kmap_local_page(page);
 		xz_buf.out_pos = 0;
 		xz_buf.out_size = PAGE_SIZE;
 		xz_ret = xz_dec_run(xz_dec, &xz_buf);
-		kunmap(page);
+		kunmap_local(xz_buf.out);
 		fw_priv->size += xz_buf.out_pos;
 		/* partial decompression means either end or error */
 		if (xz_buf.out_pos != PAGE_SIZE)
diff --git a/drivers/base/firmware_loader/sysfs.c b/drivers/base/firmware_loader/sysfs.c
index 5b0b85b70b6f..77bad32c481a 100644
--- a/drivers/base/firmware_loader/sysfs.c
+++ b/drivers/base/firmware_loader/sysfs.c
@@ -242,19 +242,17 @@ static void firmware_rw(struct fw_priv *fw_priv, char *buffer,
 			loff_t offset, size_t count, bool read)
 {
 	while (count) {
-		void *page_data;
 		int page_nr = offset >> PAGE_SHIFT;
 		int page_ofs = offset & (PAGE_SIZE - 1);
 		int page_cnt = min_t(size_t, PAGE_SIZE - page_ofs, count);
 
-		page_data = kmap(fw_priv->pages[page_nr]);
-
 		if (read)
-			memcpy(buffer, page_data + page_ofs, page_cnt);
+			memcpy_from_page(buffer, fw_priv->pages[page_nr],
+					 page_ofs, page_cnt);
 		else
-			memcpy(page_data + page_ofs, buffer, page_cnt);
+			memcpy_to_page(fw_priv->pages[page_nr], page_ofs,
+				       buffer, page_cnt);
 
-		kunmap(fw_priv->pages[page_nr]);
 		buffer += page_cnt;
 		offset += page_cnt;
 		count -= page_cnt;
-- 
2.37.0

