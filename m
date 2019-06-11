Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D284E3CB59
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbfFKM0m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 08:26:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:48288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390598AbfFKM0h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 08:26:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DFF84B025;
        Tue, 11 Jun 2019 12:26:35 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2.5 1/3] firmware: Factor out the paged buffer handling code
Date:   Tue, 11 Jun 2019 14:26:24 +0200
Message-Id: <20190611122626.28059-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190611122626.28059-1-tiwai@suse.de>
References: <20190611122626.28059-1-tiwai@suse.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is merely a preparation for the upcoming compressed firmware
support and no functional changes.  It moves the code to handle the
paged buffer allocation and mapping out of fallback.c into the main
code, so that they can be used commonly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/fallback.c | 61 ++++-----------------------------
 drivers/base/firmware_loader/firmware.h |  4 +++
 drivers/base/firmware_loader/main.c     | 52 ++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 54 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index b5cd96fd0e77..80b20f6c494f 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -219,25 +219,6 @@ static ssize_t firmware_loading_show(struct device *dev,
 	return sprintf(buf, "%d\n", loading);
 }
 
-/* one pages buffer should be mapped/unmapped only once */
-static int map_fw_priv_pages(struct fw_priv *fw_priv)
-{
-	if (!fw_priv->pages)
-		return 0;
-
-	vunmap(fw_priv->data);
-	fw_priv->data = vmap(fw_priv->pages, fw_priv->nr_pages, 0,
-			     PAGE_KERNEL_RO);
-	if (!fw_priv->data)
-		return -ENOMEM;
-
-	/* page table is no longer needed after mapping, let's free */
-	kvfree(fw_priv->pages);
-	fw_priv->pages = NULL;
-
-	return 0;
-}
-
 /**
  * firmware_loading_store() - set value in the 'loading' control file
  * @dev: device pointer
@@ -283,7 +264,7 @@ static ssize_t firmware_loading_store(struct device *dev,
 			 * see the mapped 'buf->data' once the loading
 			 * is completed.
 			 * */
-			rc = map_fw_priv_pages(fw_priv);
+			rc = fw_map_paged_buf(fw_priv);
 			if (rc)
 				dev_err(dev, "%s: map pages failed\n",
 					__func__);
@@ -388,41 +369,13 @@ static ssize_t firmware_data_read(struct file *filp, struct kobject *kobj,
 
 static int fw_realloc_pages(struct fw_sysfs *fw_sysfs, int min_size)
 {
-	struct fw_priv *fw_priv= fw_sysfs->fw_priv;
-	int pages_needed = PAGE_ALIGN(min_size) >> PAGE_SHIFT;
-
-	/* If the array of pages is too small, grow it... */
-	if (fw_priv->page_array_size < pages_needed) {
-		int new_array_size = max(pages_needed,
-					 fw_priv->page_array_size * 2);
-		struct page **new_pages;
+	int err;
 
-		new_pages = kvmalloc_array(new_array_size, sizeof(void *),
-					   GFP_KERNEL);
-		if (!new_pages) {
-			fw_load_abort(fw_sysfs);
-			return -ENOMEM;
-		}
-		memcpy(new_pages, fw_priv->pages,
-		       fw_priv->page_array_size * sizeof(void *));
-		memset(&new_pages[fw_priv->page_array_size], 0, sizeof(void *) *
-		       (new_array_size - fw_priv->page_array_size));
-		kvfree(fw_priv->pages);
-		fw_priv->pages = new_pages;
-		fw_priv->page_array_size = new_array_size;
-	}
-
-	while (fw_priv->nr_pages < pages_needed) {
-		fw_priv->pages[fw_priv->nr_pages] =
-			alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
-
-		if (!fw_priv->pages[fw_priv->nr_pages]) {
-			fw_load_abort(fw_sysfs);
-			return -ENOMEM;
-		}
-		fw_priv->nr_pages++;
-	}
-	return 0;
+	err = fw_grow_paged_buf(fw_sysfs->fw_priv,
+				PAGE_ALIGN(min_size) >> PAGE_SHIFT);
+	if (err)
+		fw_load_abort(fw_sysfs);
+	return err;
 }
 
 /**
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index d20d4e7f9e71..35f4e58b2d98 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -135,8 +135,12 @@ int assign_fw(struct firmware *fw, struct device *device,
 
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 void fw_free_paged_buf(struct fw_priv *fw_priv);
+int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
+int fw_map_paged_buf(struct fw_priv *fw_priv);
 #else
 static inline void fw_free_paged_buf(struct fw_priv *fw_priv) {}
+int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed) { return -ENXIO; }
+int fw_map_paged_buf(struct fw_priv *fw_priv) { return -ENXIO; }
 #endif
 
 #endif /* __FIRMWARE_LOADER_H */
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 2e74a1b73dae..7e12732f4705 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -281,6 +281,58 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
 	fw_priv->page_array_size = 0;
 	fw_priv->nr_pages = 0;
 }
+
+int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed)
+{
+	/* If the array of pages is too small, grow it */
+	if (fw_priv->page_array_size < pages_needed) {
+		int new_array_size = max(pages_needed,
+					 fw_priv->page_array_size * 2);
+		struct page **new_pages;
+
+		new_pages = kvmalloc_array(new_array_size, sizeof(void *),
+					   GFP_KERNEL);
+		if (!new_pages)
+			return -ENOMEM;
+		memcpy(new_pages, fw_priv->pages,
+		       fw_priv->page_array_size * sizeof(void *));
+		memset(&new_pages[fw_priv->page_array_size], 0, sizeof(void *) *
+		       (new_array_size - fw_priv->page_array_size));
+		kvfree(fw_priv->pages);
+		fw_priv->pages = new_pages;
+		fw_priv->page_array_size = new_array_size;
+	}
+
+	while (fw_priv->nr_pages < pages_needed) {
+		fw_priv->pages[fw_priv->nr_pages] =
+			alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
+
+		if (!fw_priv->pages[fw_priv->nr_pages])
+			return -ENOMEM;
+		fw_priv->nr_pages++;
+	}
+
+	return 0;
+}
+
+int fw_map_paged_buf(struct fw_priv *fw_priv)
+{
+	/* one pages buffer should be mapped/unmapped only once */
+	if (!fw_priv->pages)
+		return 0;
+
+	vunmap(fw_priv->data);
+	fw_priv->data = vmap(fw_priv->pages, fw_priv->nr_pages, 0,
+			     PAGE_KERNEL_RO);
+	if (!fw_priv->data)
+		return -ENOMEM;
+
+	/* page table is no longer needed after mapping, let's free */
+	kvfree(fw_priv->pages);
+	fw_priv->pages = NULL;
+
+	return 0;
+}
 #endif
 
 /* direct firmware loading support */
-- 
2.16.4

