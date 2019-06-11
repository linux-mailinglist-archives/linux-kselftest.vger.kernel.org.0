Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9AA63CB08
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2019 14:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfFKMUF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Jun 2019 08:20:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:46164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728758AbfFKMUE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Jun 2019 08:20:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 43607B023;
        Tue, 11 Jun 2019 12:20:03 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/2] firmware: Add support for loading compressed files
Date:   Tue, 11 Jun 2019 14:19:55 +0200
Message-Id: <20190611121956.27460-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190611121956.27460-1-tiwai@suse.de>
References: <20190611121956.27460-1-tiwai@suse.de>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds the support for loading compressed firmware files.
The primary motivation is to reduce the storage size; e.g. currently
the files in /lib/firmware on my machine counts up to 419MB, while
they can be reduced to 130MB by file compression.

The patch introduces a new kconfig option CONFIG_FW_LOADER_COMPRESS.
Even with this option set, the firmware loader still tries to load the
original firmware file as-is at first, but then falls back to the file
with ".xz" extension when it's not found, and the decompressed file
content is returned to the caller of request_firmware().  So, no
change is needed for the rest.

Currently only XZ format is supported.  A caveat is that the kernel XZ
helper code supports only CRC32 (or none) integrity check type, so
you'll have to compress the files via xz -C crc32 option.

Since we can't determine the expanded size immediately from an XZ
file, the patch re-uses the paged buffer that was used for the
user-mode fallback; it puts the decompressed content page, which are
vmapped at the end.  The paged buffer code is conditionally built with
a new Kconfig that is selected automatically.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Slight code refactoring, no functional changes

 drivers/base/firmware_loader/Kconfig    |  18 ++++
 drivers/base/firmware_loader/firmware.h |   8 +-
 drivers/base/firmware_loader/main.c     | 147 ++++++++++++++++++++++++++++++--
 3 files changed, 161 insertions(+), 12 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 38f2da6f5c2b..3f9e274e2ed3 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -26,6 +26,9 @@ config FW_LOADER
 
 if FW_LOADER
 
+config FW_LOADER_PAGED_BUF
+	bool
+
 config EXTRA_FIRMWARE
 	string "Build named firmware blobs into the kernel binary"
 	help
@@ -67,6 +70,7 @@ config EXTRA_FIRMWARE_DIR
 
 config FW_LOADER_USER_HELPER
 	bool "Enable the firmware sysfs fallback mechanism"
+	select FW_LOADER_PAGED_BUF
 	help
 	  This option enables a sysfs loading facility to enable firmware
 	  loading to the kernel through userspace as a fallback mechanism
@@ -151,5 +155,19 @@ config FW_LOADER_USER_HELPER_FALLBACK
 
 	  If you are unsure about this, say N here.
 
+config FW_LOADER_COMPRESS
+	bool "Enable compressed firmware support"
+	select FW_LOADER_PAGED_BUF
+	select XZ_DEC
+	help
+	  This option enables the support for loading compressed firmware
+	  files. The caller of firmware API receives the decompressed file
+	  content. The compressed file is loaded as a fallback, only after
+	  loading the raw file failed at first.
+
+	  Currently only XZ-compressed files are supported, and they have to
+	  be compressed with either none or crc32 integrity check type (pass
+	  "-C crc32" option to xz command).
+
 endif # FW_LOADER
 endmenu
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 35f4e58b2d98..7048a41973ed 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -64,12 +64,14 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
-#ifdef CONFIG_FW_LOADER_USER_HELPER
+#ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
-	bool need_uevent;
 	struct page **pages;
 	int nr_pages;
 	int page_array_size;
+#endif
+#ifdef CONFIG_FW_LOADER_USER_HELPER
+	bool need_uevent;
 	struct list_head pending_list;
 #endif
 	const char *fw_name;
@@ -133,7 +135,7 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 int assign_fw(struct firmware *fw, struct device *device,
 	      enum fw_opt opt_flags);
 
-#ifdef CONFIG_FW_LOADER_USER_HELPER
+#ifdef CONFIG_FW_LOADER_PAGED_BUF
 void fw_free_paged_buf(struct fw_priv *fw_priv);
 int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
 int fw_map_paged_buf(struct fw_priv *fw_priv);
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 7e12732f4705..bf44c79beae9 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -33,6 +33,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/reboot.h>
 #include <linux/security.h>
+#include <linux/xz.h>
 
 #include <generated/utsrelease.h>
 
@@ -266,7 +267,7 @@ static void free_fw_priv(struct fw_priv *fw_priv)
 		spin_unlock(&fwc->lock);
 }
 
-#ifdef CONFIG_FW_LOADER_USER_HELPER
+#ifdef CONFIG_FW_LOADER_PAGED_BUF
 void fw_free_paged_buf(struct fw_priv *fw_priv)
 {
 	int i;
@@ -335,6 +336,105 @@ int fw_map_paged_buf(struct fw_priv *fw_priv)
 }
 #endif
 
+/*
+ * XZ-compressed firmware support
+ */
+#ifdef CONFIG_FW_LOADER_COMPRESS
+/* show an error and return the standard error code */
+static int fw_decompress_xz_error(struct device *dev, enum xz_ret xz_ret)
+{
+	if (xz_ret != XZ_STREAM_END) {
+		dev_warn(dev, "xz decompression failed (xz_ret=%d)\n", xz_ret);
+		return xz_ret == XZ_MEM_ERROR ? -ENOMEM : -EINVAL;
+	}
+	return 0;
+}
+
+/* single-shot decompression onto the pre-allocated buffer */
+static int fw_decompress_xz_single(struct device *dev, struct fw_priv *fw_priv,
+				   size_t in_size, const void *in_buffer)
+{
+	struct xz_dec *xz_dec;
+	struct xz_buf xz_buf;
+	enum xz_ret xz_ret;
+
+	xz_dec = xz_dec_init(XZ_SINGLE, (u32)-1);
+	if (!xz_dec)
+		return -ENOMEM;
+
+	xz_buf.in_size = in_size;
+	xz_buf.in = in_buffer;
+	xz_buf.in_pos = 0;
+	xz_buf.out_size = fw_priv->allocated_size;
+	xz_buf.out = fw_priv->data;
+	xz_buf.out_pos = 0;
+
+	xz_ret = xz_dec_run(xz_dec, &xz_buf);
+	xz_dec_end(xz_dec);
+
+	fw_priv->size = xz_buf.out_pos;
+	return fw_decompress_xz_error(dev, xz_ret);
+}
+
+/* decompression on paged buffer and map it */
+static int fw_decompress_xz_pages(struct device *dev, struct fw_priv *fw_priv,
+				  size_t in_size, const void *in_buffer)
+{
+	struct xz_dec *xz_dec;
+	struct xz_buf xz_buf;
+	enum xz_ret xz_ret;
+	struct page *page;
+	int err = 0;
+
+	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
+	if (!xz_dec)
+		return -ENOMEM;
+
+	xz_buf.in_size = in_size;
+	xz_buf.in = in_buffer;
+	xz_buf.in_pos = 0;
+
+	fw_priv->is_paged_buf = true;
+	fw_priv->size = 0;
+	do {
+		if (fw_grow_paged_buf(fw_priv, fw_priv->nr_pages + 1)) {
+			err = -ENOMEM;
+			goto out;
+		}
+
+		/* decompress onto the new allocated page */
+		page = fw_priv->pages[fw_priv->nr_pages - 1];
+		xz_buf.out = kmap(page);
+		xz_buf.out_pos = 0;
+		xz_buf.out_size = PAGE_SIZE;
+		xz_ret = xz_dec_run(xz_dec, &xz_buf);
+		kunmap(page);
+		fw_priv->size += xz_buf.out_pos;
+		/* partial decompression means either end or error */
+		if (xz_buf.out_pos != PAGE_SIZE)
+			break;
+	} while (xz_ret == XZ_OK);
+
+	err = fw_decompress_xz_error(dev, xz_ret);
+	if (!err)
+		err = fw_map_paged_buf(fw_priv);
+
+ out:
+	xz_dec_end(xz_dec);
+	return err;
+}
+
+static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
+			    size_t in_size, const void *in_buffer)
+{
+	/* if the buffer is pre-allocated, we can perform in single-shot mode */
+	if (fw_priv->data)
+		return fw_decompress_xz_single(dev, fw_priv, in_size, in_buffer);
+	else
+		return fw_decompress_xz_pages(dev, fw_priv, in_size, in_buffer);
+}
+#endif /* CONFIG_FW_LOADER_COMPRESS */
+
 /* direct firmware loading support */
 static char fw_path_para[256];
 static const char * const fw_path[] = {
@@ -354,7 +454,12 @@ module_param_string(path, fw_path_para, sizeof(fw_path_para), 0644);
 MODULE_PARM_DESC(path, "customized firmware image search path with a higher priority than default path");
 
 static int
-fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
+fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
+			   const char *suffix,
+			   int (*decompress)(struct device *dev,
+					     struct fw_priv *fw_priv,
+					     size_t in_size,
+					     const void *in_buffer))
 {
 	loff_t size;
 	int i, len;
@@ -362,9 +467,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
 	char *path;
 	enum kernel_read_file_id id = READING_FIRMWARE;
 	size_t msize = INT_MAX;
+	void *buffer = NULL;
 
 	/* Already populated data member means we're loading into a buffer */
-	if (fw_priv->data) {
+	if (!decompress && fw_priv->data) {
+		buffer = fw_priv->data;
 		id = READING_FIRMWARE_PREALLOC_BUFFER;
 		msize = fw_priv->allocated_size;
 	}
@@ -378,15 +485,15 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
 		if (!fw_path[i][0])
 			continue;
 
-		len = snprintf(path, PATH_MAX, "%s/%s",
-			       fw_path[i], fw_priv->fw_name);
+		len = snprintf(path, PATH_MAX, "%s/%s%s",
+			       fw_path[i], fw_priv->fw_name, suffix);
 		if (len >= PATH_MAX) {
 			rc = -ENAMETOOLONG;
 			break;
 		}
 
 		fw_priv->size = 0;
-		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
+		rc = kernel_read_file_from_path(path, &buffer, &size,
 						msize, id);
 		if (rc) {
 			if (rc != -ENOENT)
@@ -397,8 +504,24 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
 					 path);
 			continue;
 		}
-		dev_dbg(device, "direct-loading %s\n", fw_priv->fw_name);
-		fw_priv->size = size;
+		if (decompress) {
+			dev_dbg(device, "f/w decompressing %s\n",
+				fw_priv->fw_name);
+			rc = decompress(device, fw_priv, size, buffer);
+			/* discard the superfluous original content */
+			vfree(buffer);
+			buffer = NULL;
+			if (rc) {
+				fw_free_paged_buf(fw_priv);
+				continue;
+			}
+		} else {
+			dev_dbg(device, "direct-loading %s\n",
+				fw_priv->fw_name);
+			if (!fw_priv->data)
+				fw_priv->data = buffer;
+			fw_priv->size = size;
+		}
 		fw_state_done(fw_priv);
 		break;
 	}
@@ -645,7 +768,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
-	ret = fw_get_filesystem_firmware(device, fw->priv);
+	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
+#ifdef CONFIG_FW_LOADER_COMPRESS
+	if (ret == -ENOENT)
+		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
+						 fw_decompress_xz);
+#endif
+
 	if (ret) {
 		if (!(opt_flags & FW_OPT_NO_WARN))
 			dev_warn(device,
-- 
2.16.4

