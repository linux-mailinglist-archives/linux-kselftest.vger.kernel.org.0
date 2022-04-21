Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D6150A41E
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 17:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390082AbiDUPcJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 11:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390075AbiDUPcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 11:32:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31D543391;
        Thu, 21 Apr 2022 08:29:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8B9FE1F748;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650554954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3HQQK/ahKzOFQfSanytEFirEBOLzYKPfyJHKxVcTxg=;
        b=jOefWiU2lR+aS8LI47ZgQeSB8RKfnCfjIhixUnIvoba8WlrYLNULzRl13NnHCnXx5UD57B
        LNOP7FnHhM8TuL08BgNraLdMNfVthVfVmVlY/5p9UyyyzMAVYhp6YpbeqhrNwLQlC1oMMw
        hbFFBVbkEOncbaQ1tQ8J+nPx64AuE6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650554954;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U3HQQK/ahKzOFQfSanytEFirEBOLzYKPfyJHKxVcTxg=;
        b=0zoWgrUpp9wKGyanjC1G4AZ4vcnkyICkdUZFwH/Q49a3KTcmyLyvAYErSgyihKKcTT61De
        cqnBo2A8iMhYAKBw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id 818FD2C14B;
        Thu, 21 Apr 2022 15:29:14 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] firmware: Add the support for ZSTD-compressed firmware files
Date:   Thu, 21 Apr 2022 17:29:04 +0200
Message-Id: <20220421152908.4718-2-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220421152908.4718-1-tiwai@suse.de>
References: <20220421152908.4718-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the growing demand on ZSTD compressions, there have been requests
for the support of ZSTD-compressed firmware files, so here it is:
this patch extends the firmware loader code to allow loading ZSTD
files.  The implementation is fairly straightforward, it just adds a
ZSTD decompression routine for the file expander.  (And the code is
even simpler than XZ thanks to the ZSTD API that gives the original
decompressed size from the header.)

Tested-by: Piotr Gorski <lucjan.lucjanov@gmail.com>
Link: https://lore.kernel.org/all/20210127154939.13288-1-tiwai@suse.de/
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/base/firmware_loader/Kconfig | 24 ++++++---
 drivers/base/firmware_loader/main.c  | 76 ++++++++++++++++++++++++++--
 2 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
index 38f3b66bf52b..08bb50451a96 100644
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -159,21 +159,33 @@ config FW_LOADER_USER_HELPER_FALLBACK
 
 config FW_LOADER_COMPRESS
 	bool "Enable compressed firmware support"
-	select FW_LOADER_PAGED_BUF
-	select XZ_DEC
 	help
 	  This option enables the support for loading compressed firmware
 	  files. The caller of firmware API receives the decompressed file
 	  content. The compressed file is loaded as a fallback, only after
 	  loading the raw file failed at first.
 
-	  Currently only XZ-compressed files are supported, and they have to
-	  be compressed with either none or crc32 integrity check type (pass
-	  "-C crc32" option to xz command).
-
 	  Compressed firmware support does not apply to firmware images
 	  that are built into the kernel image (CONFIG_EXTRA_FIRMWARE).
 
+if FW_LOADER_COMPRESS
+config FW_LOADER_COMPRESS_XZ
+	bool "Enable XZ-compressed firmware support"
+	select FW_LOADER_PAGED_BUF
+	select XZ_DEC
+	help
+	  This option adds the support for XZ-compressed files.
+	  The files have to be compressed with either none or crc32
+	  integrity check type (pass "-C crc32" option to xz command).
+
+config FW_LOADER_COMPRESS_ZSTD
+	bool "Enable ZSTD-compressed firmware support"
+	select ZSTD_DECOMPRESS
+	help
+	  This option adds the support for ZSTD-compressed files.
+
+endif # FW_LOADER_COMPRESS
+
 config FW_CACHE
 	bool "Enable firmware caching during suspend"
 	depends on PM_SLEEP
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 94d1789a233e..74830aeec7f6 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -35,6 +35,7 @@
 #include <linux/syscore_ops.h>
 #include <linux/reboot.h>
 #include <linux/security.h>
+#include <linux/zstd.h>
 #include <linux/xz.h>
 
 #include <generated/utsrelease.h>
@@ -304,10 +305,74 @@ int fw_map_paged_buf(struct fw_priv *fw_priv)
 }
 #endif
 
+/*
+ * ZSTD-compressed firmware support
+ */
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+static int fw_decompress_zstd(struct device *dev, struct fw_priv *fw_priv,
+			      size_t in_size, const void *in_buffer)
+{
+	size_t len, out_size, workspace_size;
+	void *workspace, *out_buf;
+	zstd_dctx *ctx;
+	int err;
+
+	if (fw_priv->allocated_size) {
+		out_size = fw_priv->allocated_size;
+		out_buf = fw_priv->data;
+	} else {
+		zstd_frame_header params;
+
+		if (zstd_get_frame_header(&params, in_buffer, in_size) ||
+		    params.frameContentSize == ZSTD_CONTENTSIZE_UNKNOWN) {
+			dev_dbg(dev, "%s: invalid zstd header\n", __func__);
+			return -EINVAL;
+		}
+		out_size = params.frameContentSize;
+		out_buf = vzalloc(out_size);
+		if (!out_buf)
+			return -ENOMEM;
+	}
+
+	workspace_size = zstd_dctx_workspace_bound();
+	workspace = kvzalloc(workspace_size, GFP_KERNEL);
+	if (!workspace) {
+		err = -ENOMEM;
+		goto error;
+	}
+
+	ctx = zstd_init_dctx(workspace, workspace_size);
+	if (!ctx) {
+		dev_dbg(dev, "%s: failed to initialize context\n", __func__);
+		err = -EINVAL;
+		goto error;
+	}
+
+	len = zstd_decompress_dctx(ctx, out_buf, out_size, in_buffer, in_size);
+	if (zstd_is_error(len)) {
+		dev_dbg(dev, "%s: failed to decompress: %d\n", __func__,
+			zstd_get_error_code(len));
+		err = -EINVAL;
+		goto error;
+	}
+
+	if (!fw_priv->allocated_size)
+		fw_priv->data = out_buf;
+	fw_priv->size = len;
+	err = 0;
+
+ error:
+	kvfree(workspace);
+	if (err && !fw_priv->allocated_size)
+		vfree(out_buf);
+	return err;
+}
+#endif /* CONFIG_FW_LOADER_COMPRESS_ZSTD */
+
 /*
  * XZ-compressed firmware support
  */
-#ifdef CONFIG_FW_LOADER_COMPRESS
+#ifdef CONFIG_FW_LOADER_COMPRESS_XZ
 /* show an error and return the standard error code */
 static int fw_decompress_xz_error(struct device *dev, enum xz_ret xz_ret)
 {
@@ -401,7 +466,7 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
 	else
 		return fw_decompress_xz_pages(dev, fw_priv, in_size, in_buffer);
 }
-#endif /* CONFIG_FW_LOADER_COMPRESS */
+#endif /* CONFIG_FW_LOADER_COMPRESS_XZ */
 
 /* direct firmware loading support */
 static char fw_path_para[256];
@@ -757,7 +822,12 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	if (!(opt_flags & FW_OPT_PARTIAL))
 		nondirect = true;
 
-#ifdef CONFIG_FW_LOADER_COMPRESS
+#ifdef CONFIG_FW_LOADER_COMPRESS_ZSTD
+	if (ret == -ENOENT && nondirect)
+		ret = fw_get_filesystem_firmware(device, fw->priv, ".zst",
+						 fw_decompress_zstd);
+#endif
+#ifdef CONFIG_FW_LOADER_COMPRESS_XZ
 	if (ret == -ENOENT && nondirect)
 		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
 						 fw_decompress_xz);
-- 
2.31.1

