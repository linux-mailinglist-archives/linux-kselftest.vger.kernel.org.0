Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89012323FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 19:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgG2R7d (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbgG2R7H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 13:59:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDB2C08C5DB
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so7279251pfd.2
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jul 2020 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+NaGsZ6LkqLP7N90n/8Avv/y2oDkj/LqGy0xmUe3sQI=;
        b=hp7mbpgpzEbT4hmsg/0VefWpKjWuMD8517bITA0szXsxyzLErrtYxEne3GSIfYyf1a
         TbEZZ3NQ3QLjzbI0vCoMwVy4hBW0R6Gd9ppCmdX5jDyH5QP8CHt+Ed6X8dJ6iSEQDMqP
         qZ+HawSNZSCQwfzbfxd8luxWK5q5OVS5vXT1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+NaGsZ6LkqLP7N90n/8Avv/y2oDkj/LqGy0xmUe3sQI=;
        b=FqLQykehnfFapVobe6y72u7bqGi6PuNF1A7M2XIch0dKL455myEQ9jQcN7xbwy2Mgu
         OuBaRnsQbhyS2QneEo3DBGBDZM0J5LAmo72z1G1Yu/zDNk66o7IahI2AIgK5zGG+K/Zu
         R0tJXsblnMDsR4hHuaHXZk6d+OsSY2Z348pmGjNvLhcrnmYZdK+zEzI0ReY3ULcMVTDa
         dG19VQ/RkvxM3JjZokfjrhWi6eVnMNrhIZhTzWWE1A9Qd4Q4MhtG6gF5OLjomEubBuS3
         gwHc0Z0IpccxWHkd4/5vH3XfWAX+QYzBW4ijmHvoXn+aLPc3qPw9L98LlhfqcalLeNvM
         0IQg==
X-Gm-Message-State: AOAM533O85AdMU9hX+px869SY7k7dcCDoDBwacDLLxmEDpQP+76as1Ny
        gDbkVlo80wO2SZ6s43Mo741auA==
X-Google-Smtp-Source: ABdhPJxyBV4lMmdEC9afNAeBvnS7qOJJXJuf2R/sr7FyvukYVdfczUkitscrueNwT/Og6LWrh8CU+g==
X-Received: by 2002:a62:7705:: with SMTP id s5mr12985932pfc.52.1596045546921;
        Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s125sm1247882pfc.63.2020.07.29.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/17] firmware: Add request_partial_firmware_into_buf()
Date:   Wed, 29 Jul 2020 10:58:44 -0700
Message-Id: <20200729175845.1745471-17-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>

Add request_partial_firmware_into_buf() to allow for portions of a
firmware file to be read into a buffer. This is needed when large firmware
must be loaded in portions from a file on memory constrained systems.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Co-developed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/firmware.h |   4 +
 drivers/base/firmware_loader/main.c     | 101 +++++++++++++++++++-----
 include/linux/firmware.h                |  12 +++
 3 files changed, 99 insertions(+), 18 deletions(-)

diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index 7ad5fe52bc72..3f6eda46b3a2 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -32,6 +32,8 @@
  * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedded in
  *	the platform's main firmware. If both this fallback and the sysfs
  *      fallback are enabled, then this fallback will be tried first.
+ * @FW_OPT_PARTIAL: Allow partial read of firmware instead of needing to read
+ *	entire file.
  */
 enum fw_opt {
 	FW_OPT_UEVENT			= BIT(0),
@@ -41,6 +43,7 @@ enum fw_opt {
 	FW_OPT_NOCACHE			= BIT(4),
 	FW_OPT_NOFALLBACK_SYSFS		= BIT(5),
 	FW_OPT_FALLBACK_PLATFORM	= BIT(6),
+	FW_OPT_PARTIAL			= BIT(7),
 };
 
 enum fw_status {
@@ -68,6 +71,7 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	size_t offset;
 	u32 opt_flags;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 67d8afa91ae0..54c5d57b6327 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -170,10 +170,19 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
 					  void *dbuf,
 					  size_t size,
+					  size_t offset,
 					  u32 opt_flags)
 {
 	struct fw_priv *fw_priv;
 
+	/* For a partial read, the buffer must be preallocated. */
+	if ((opt_flags & FW_OPT_PARTIAL) && !dbuf)
+		return NULL;
+
+	/* Only partial reads are allowed to use an offset. */
+	if (offset != 0 && !(opt_flags & FW_OPT_PARTIAL))
+		return NULL;
+
 	fw_priv = kzalloc(sizeof(*fw_priv), GFP_ATOMIC);
 	if (!fw_priv)
 		return NULL;
@@ -188,6 +197,7 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->offset = offset;
 	fw_priv->opt_flags = opt_flags;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
@@ -216,12 +226,17 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 				struct fw_priv **fw_priv,
 				void *dbuf,
 				size_t size,
+				size_t offset,
 				u32 opt_flags)
 {
 	struct fw_priv *tmp;
 
 	spin_lock(&fwc->lock);
-	if (!(opt_flags & FW_OPT_NOCACHE)) {
+	/*
+	 * Do not merge requests that are marked to be non-cached or
+	 * are performing partial reads.
+	 */
+	if (!(opt_flags & (FW_OPT_NOCACHE | FW_OPT_PARTIAL))) {
 		tmp = __lookup_fw_priv(fw_name);
 		if (tmp) {
 			kref_get(&tmp->ref);
@@ -232,7 +247,7 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 		}
 	}
 
-	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, opt_flags);
+	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, offset, opt_flags);
 	if (tmp) {
 		INIT_LIST_HEAD(&tmp->list);
 		if (!(opt_flags & FW_OPT_NOCACHE))
@@ -485,6 +500,9 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 		return -ENOMEM;
 
 	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
+		size_t file_size = 0;
+		size_t *file_size_ptr = NULL;
+
 		/* skip the unset customized path */
 		if (!fw_path[i][0])
 			continue;
@@ -498,9 +516,18 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
 
 		fw_priv->size = 0;
 
+		/*
+		 * The total file size is only examined when doing a partial
+		 * read; the "full read" case needs to fail if the whole
+		 * firmware was not completely loaded.
+		 */
+		if ((fw_priv->opt_flags & FW_OPT_PARTIAL) && buffer)
+			file_size_ptr = &file_size;
+
 		/* load firmware files from the mount namespace of init */
-		rc = kernel_read_file_from_path_initns(path, 0, &buffer, msize,
-						       NULL,
+		rc = kernel_read_file_from_path_initns(path, fw_priv->offset,
+						       &buffer, msize,
+						       file_size_ptr,
 						       READING_FIRMWARE);
 		if (rc < 0) {
 			if (rc != -ENOENT)
@@ -691,7 +718,7 @@ int assign_fw(struct firmware *fw, struct device *device)
 static int
 _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 			  struct device *device, void *dbuf, size_t size,
-			  u32 opt_flags)
+			  size_t offset, u32 opt_flags)
 {
 	struct firmware *firmware;
 	struct fw_priv *fw_priv;
@@ -710,7 +737,7 @@ _request_firmware_prepare(struct firmware **firmware_p, const char *name,
 	}
 
 	ret = alloc_lookup_fw_priv(name, &fw_cache, &fw_priv, dbuf, size,
-				  opt_flags);
+				   offset, opt_flags);
 
 	/*
 	 * bind with 'priv' now to avoid warning in failure path
@@ -757,9 +784,10 @@ static void fw_abort_batch_reqs(struct firmware *fw)
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		  struct device *device, void *buf, size_t size,
-		  u32 opt_flags)
+		  size_t offset, u32 opt_flags)
 {
 	struct firmware *fw = NULL;
+	bool nondirect = false;
 	int ret;
 
 	if (!firmware_p)
@@ -771,18 +799,22 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 	}
 
 	ret = _request_firmware_prepare(&fw, name, device, buf, size,
-					opt_flags);
+					offset, opt_flags);
 	if (ret <= 0) /* error or already assigned */
 		goto out;
 
 	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
+
+	/* Only full reads can support decompression, platform, and sysfs. */
+	if (!(opt_flags & FW_OPT_PARTIAL))
+		nondirect = true;
+
 #ifdef CONFIG_FW_LOADER_COMPRESS
-	if (ret == -ENOENT)
+	if (ret == -ENOENT && nondirect)
 		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
 						 fw_decompress_xz);
 #endif
-
-	if (ret == -ENOENT)
+	if (ret == -ENOENT && nondirect)
 		ret = firmware_fallback_platform(fw->priv);
 
 	if (ret) {
@@ -790,7 +822,9 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 			dev_warn(device,
 				 "Direct firmware load for %s failed with error %d\n",
 				 name, ret);
-		ret = firmware_fallback_sysfs(fw, name, device, opt_flags, ret);
+		if (nondirect)
+			ret = firmware_fallback_sysfs(fw, name, device,
+						      opt_flags, ret);
 	} else
 		ret = assign_fw(fw, device);
 
@@ -833,7 +867,7 @@ request_firmware(const struct firmware **firmware_p, const char *name,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, NULL, 0,
+	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT);
 	module_put(THIS_MODULE);
 	return ret;
@@ -860,7 +894,7 @@ int firmware_request_nowarn(const struct firmware **firmware, const char *name,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware, name, device, NULL, 0,
+	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN);
 	module_put(THIS_MODULE);
 	return ret;
@@ -884,7 +918,7 @@ int request_firmware_direct(const struct firmware **firmware_p,
 	int ret;
 
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, NULL, 0,
+	ret = _request_firmware(firmware_p, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT | FW_OPT_NO_WARN |
 				FW_OPT_NOFALLBACK_SYSFS);
 	module_put(THIS_MODULE);
@@ -909,7 +943,7 @@ int firmware_request_platform(const struct firmware **firmware,
 
 	/* Need to pin this module until return */
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware, name, device, NULL, 0,
+	ret = _request_firmware(firmware, name, device, NULL, 0, 0,
 				FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
 	module_put(THIS_MODULE);
 	return ret;
@@ -965,13 +999,44 @@ request_firmware_into_buf(const struct firmware **firmware_p, const char *name,
 		return -EOPNOTSUPP;
 
 	__module_get(THIS_MODULE);
-	ret = _request_firmware(firmware_p, name, device, buf, size,
+	ret = _request_firmware(firmware_p, name, device, buf, size, 0,
 				FW_OPT_UEVENT | FW_OPT_NOCACHE);
 	module_put(THIS_MODULE);
 	return ret;
 }
 EXPORT_SYMBOL(request_firmware_into_buf);
 
+/**
+ * request_partial_firmware_into_buf() - load partial firmware into a previously allocated buffer
+ * @firmware_p: pointer to firmware image
+ * @name: name of firmware file
+ * @device: device for which firmware is being loaded and DMA region allocated
+ * @buf: address of buffer to load firmware into
+ * @size: size of buffer
+ * @offset: offset into file to read
+ *
+ * This function works pretty much like request_firmware_into_buf except
+ * it allows a partial read of the file.
+ */
+int
+request_partial_firmware_into_buf(const struct firmware **firmware_p,
+				  const char *name, struct device *device,
+				  void *buf, size_t size, size_t offset)
+{
+	int ret;
+
+	if (fw_cache_is_setup(device, name))
+		return -EOPNOTSUPP;
+
+	__module_get(THIS_MODULE);
+	ret = _request_firmware(firmware_p, name, device, buf, size, offset,
+				FW_OPT_UEVENT | FW_OPT_NOCACHE |
+				FW_OPT_PARTIAL);
+	module_put(THIS_MODULE);
+	return ret;
+}
+EXPORT_SYMBOL(request_partial_firmware_into_buf);
+
 /**
  * release_firmware() - release the resource associated with a firmware image
  * @fw: firmware resource to release
@@ -1004,7 +1069,7 @@ static void request_firmware_work_func(struct work_struct *work)
 
 	fw_work = container_of(work, struct firmware_work, work);
 
-	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0,
+	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
 			  fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
 	put_device(fw_work->device); /* taken in request_firmware_nowait() */
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index cb3e2c06ed8a..c15acadc6cf4 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -53,6 +53,9 @@ int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
 	const char *name, struct device *device, void *buf, size_t size);
+int request_partial_firmware_into_buf(const struct firmware **firmware_p,
+				      const char *name, struct device *device,
+				      void *buf, size_t size, size_t offset);
 
 void release_firmware(const struct firmware *fw);
 #else
@@ -102,6 +105,15 @@ static inline int request_firmware_into_buf(const struct firmware **firmware_p,
 	return -EINVAL;
 }
 
+static inline int request_partial_firmware_into_buf
+					(const struct firmware **firmware_p,
+					 const char *name,
+					 struct device *device,
+					 void *buf, size_t size, size_t offset)
+{
+	return -EINVAL;
+}
+
 #endif
 
 int firmware_request_cache(struct device *device, const char *name);
-- 
2.25.1

