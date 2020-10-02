Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB89281993
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 19:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388403AbgJBRjE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 13:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbgJBRiq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EA9C0613E9
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 10:38:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t14so1227935pgl.10
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WHTJVbq+NEdOn0KG7xTVbIO+EPWzmJJD7edvoSx0fhQ=;
        b=SDW1aCXsi7GB1NUdEmgnrp+bHwHQoGoSWJOyLP0qTqqUQlVSknq7NxFIPEVQ9Y2j+P
         QIaJOySy3FRN2lvGV0GXbU/VyifBQ99x9nCJ2UBKC3L31TPgViV4h+DoOFY1gS5NfQyc
         8+LKzKpNMC3OpSEL4GuhCkElvCK6DRm03gm9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WHTJVbq+NEdOn0KG7xTVbIO+EPWzmJJD7edvoSx0fhQ=;
        b=sj+z1GMEeuMH4pX6D8uKISYe4CTQ7DIaNu79ekrJucygit0L+cLTHxJTdsUZx3IJAK
         /dU56lHTJkzgSKK8N18hhtjXigw565Bn1qYMVp0YvliJbiPEmPaSuotcEKJvdr17Muq6
         FEUXSv1VJ6hl1mdWlNLh50LcdfmRYczl0LJmLeN6a0m2EoF5j8ZvmnEOpIOAnOxC2IJt
         Sf+3X1+yzpExwkBkcSVbP3TJnqvpsggD8Paz3yjKcRgSdLMaHTeeBJHI8nEGw0yKZb4j
         lSE8j3TAMC7FKYFcpmx9PXiSk5xVeebCVeWPmm+IcdTVHfReMkPAgXa6sd6KcApbSCem
         iU6w==
X-Gm-Message-State: AOAM531PRbDPWoUFL4XnjHrWoHU+OlQB88ef9ilUdKgp2YljsGf1Oqr/
        3quGmd3tGrv46GIIIQupeDwZ9g==
X-Google-Smtp-Source: ABdhPJxsFl7w0eHssgJAlItrXZUpI3j4cF+J9i83MBIGzUru+Nf9hzhT67KCdEEp/s/JO0pwtKcNbw==
X-Received: by 2002:aa7:8f21:0:b029:142:2501:39e0 with SMTP id y1-20020aa78f210000b0290142250139e0mr3924207pfr.47.1601660324643;
        Fri, 02 Oct 2020 10:38:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r19sm2104873pjz.23.2020.10.02.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:42 -0700 (PDT)
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
Subject: [PATCH v5 14/16] firmware: Store opt_flags in fw_priv
Date:   Fri,  2 Oct 2020 10:38:26 -0700
Message-Id: <20201002173828.2099543-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Instead of passing opt_flags around so much, store it in the private
structure so it can be examined by internals without needing to add more
arguments to functions.

Co-developed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/base/firmware_loader/fallback.c       | 11 +++-----
 drivers/base/firmware_loader/fallback.h       |  5 ++--
 .../base/firmware_loader/fallback_platform.c  |  4 +--
 drivers/base/firmware_loader/firmware.h       |  3 ++-
 drivers/base/firmware_loader/main.c           | 25 +++++++++++--------
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 251d92fc8bae..c4765461a951 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -490,13 +490,11 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
 /**
  * fw_load_sysfs_fallback() - load a firmware via the sysfs fallback mechanism
  * @fw_sysfs: firmware sysfs information for the firmware to load
- * @opt_flags: flags of options, FW_OPT_*
  * @timeout: timeout to wait for the load
  *
  * In charge of constructing a sysfs fallback interface for firmware loading.
  **/
-static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
-				  u32 opt_flags, long timeout)
+static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs, long timeout)
 {
 	int retval = 0;
 	struct device *f_dev = &fw_sysfs->dev;
@@ -518,7 +516,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
 	list_add(&fw_priv->pending_list, &pending_fw_head);
 	mutex_unlock(&fw_lock);
 
-	if (opt_flags & FW_OPT_UEVENT) {
+	if (fw_priv->opt_flags & FW_OPT_UEVENT) {
 		fw_priv->need_uevent = true;
 		dev_set_uevent_suppress(f_dev, false);
 		dev_dbg(f_dev, "firmware: requesting %s\n", fw_priv->fw_name);
@@ -580,10 +578,10 @@ static int fw_load_from_user_helper(struct firmware *firmware,
 	}
 
 	fw_sysfs->fw_priv = firmware->priv;
-	ret = fw_load_sysfs_fallback(fw_sysfs, opt_flags, timeout);
+	ret = fw_load_sysfs_fallback(fw_sysfs, timeout);
 
 	if (!ret)
-		ret = assign_fw(firmware, device, opt_flags);
+		ret = assign_fw(firmware, device);
 
 out_unlock:
 	usermodehelper_read_unlock();
@@ -625,7 +623,6 @@ static bool fw_run_sysfs_fallback(u32 opt_flags)
  * @fw: pointer to firmware image
  * @name: name of firmware file to look for
  * @device: device for which firmware is being loaded
- * @opt_flags: options to control firmware loading behaviour
  * @ret: return value from direct lookup which triggered the fallback mechanism
  *
  * This function is called if direct lookup for the firmware failed, it enables
diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
index 2afdb6adb23f..3af7205b302f 100644
--- a/drivers/base/firmware_loader/fallback.h
+++ b/drivers/base/firmware_loader/fallback.h
@@ -67,10 +67,9 @@ static inline void unregister_sysfs_loader(void)
 #endif /* CONFIG_FW_LOADER_USER_HELPER */
 
 #ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
-int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags);
+int firmware_fallback_platform(struct fw_priv *fw_priv);
 #else
-static inline int firmware_fallback_platform(struct fw_priv *fw_priv,
-					     u32 opt_flags)
+static inline int firmware_fallback_platform(struct fw_priv *fw_priv)
 {
 	return -ENOENT;
 }
diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/base/firmware_loader/fallback_platform.c
index 8bdf88043079..00af99f0aff2 100644
--- a/drivers/base/firmware_loader/fallback_platform.c
+++ b/drivers/base/firmware_loader/fallback_platform.c
@@ -8,13 +8,13 @@
 #include "fallback.h"
 #include "firmware.h"
 
-int firmware_fallback_platform(struct fw_priv *fw_priv, u32 opt_flags)
+int firmware_fallback_platform(struct fw_priv *fw_priv)
 {
 	const u8 *data;
 	size_t size;
 	int rc;
 
-	if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
+	if (!(fw_priv->opt_flags & FW_OPT_FALLBACK_PLATFORM))
 		return -ENOENT;
 
 	rc = security_kernel_load_data(LOADING_FIRMWARE, true);
diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
index d08efc77cf16..f86de5d7e0d7 100644
--- a/drivers/base/firmware_loader/firmware.h
+++ b/drivers/base/firmware_loader/firmware.h
@@ -68,6 +68,7 @@ struct fw_priv {
 	void *data;
 	size_t size;
 	size_t allocated_size;
+	u32 opt_flags;
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 	bool is_paged_buf;
 	struct page **pages;
@@ -136,7 +137,7 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
 	__fw_state_set(fw_priv, FW_STATUS_DONE);
 }
 
-int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags);
+int assign_fw(struct firmware *fw, struct device *device);
 
 #ifdef CONFIG_FW_LOADER_PAGED_BUF
 void fw_free_paged_buf(struct fw_priv *fw_priv);
diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index 79f86466d472..78c8e44c08cb 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -168,7 +168,9 @@ static int fw_cache_piggyback_on_request(const char *name);
 
 static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 					  struct firmware_cache *fwc,
-					  void *dbuf, size_t size)
+					  void *dbuf,
+					  size_t size,
+					  u32 opt_flags)
 {
 	struct fw_priv *fw_priv;
 
@@ -186,6 +188,7 @@ static struct fw_priv *__allocate_fw_priv(const char *fw_name,
 	fw_priv->fwc = fwc;
 	fw_priv->data = dbuf;
 	fw_priv->allocated_size = size;
+	fw_priv->opt_flags = opt_flags;
 	fw_state_init(fw_priv);
 #ifdef CONFIG_FW_LOADER_USER_HELPER
 	INIT_LIST_HEAD(&fw_priv->pending_list);
@@ -210,8 +213,10 @@ static struct fw_priv *__lookup_fw_priv(const char *fw_name)
 /* Returns 1 for batching firmware requests with the same name */
 static int alloc_lookup_fw_priv(const char *fw_name,
 				struct firmware_cache *fwc,
-				struct fw_priv **fw_priv, void *dbuf,
-				size_t size, u32 opt_flags)
+				struct fw_priv **fw_priv,
+				void *dbuf,
+				size_t size,
+				u32 opt_flags)
 {
 	struct fw_priv *tmp;
 
@@ -227,7 +232,7 @@ static int alloc_lookup_fw_priv(const char *fw_name,
 		}
 	}
 
-	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size);
+	tmp = __allocate_fw_priv(fw_name, fwc, dbuf, size, opt_flags);
 	if (tmp) {
 		INIT_LIST_HEAD(&tmp->list);
 		if (!(opt_flags & FW_OPT_NOCACHE))
@@ -640,7 +645,7 @@ static int fw_add_devm_name(struct device *dev, const char *name)
 }
 #endif
 
-int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
+int assign_fw(struct firmware *fw, struct device *device)
 {
 	struct fw_priv *fw_priv = fw->priv;
 	int ret;
@@ -659,8 +664,8 @@ int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 	 * should be fixed in devres or driver core.
 	 */
 	/* don't cache firmware handled without uevent */
-	if (device && (opt_flags & FW_OPT_UEVENT) &&
-	    !(opt_flags & FW_OPT_NOCACHE)) {
+	if (device && (fw_priv->opt_flags & FW_OPT_UEVENT) &&
+	    !(fw_priv->opt_flags & FW_OPT_NOCACHE)) {
 		ret = fw_add_devm_name(device, fw_priv->fw_name);
 		if (ret) {
 			mutex_unlock(&fw_lock);
@@ -672,7 +677,7 @@ int assign_fw(struct firmware *fw, struct device *device, u32 opt_flags)
 	 * After caching firmware image is started, let it piggyback
 	 * on request firmware.
 	 */
-	if (!(opt_flags & FW_OPT_NOCACHE) &&
+	if (!(fw_priv->opt_flags & FW_OPT_NOCACHE) &&
 	    fw_priv->fwc->state == FW_LOADER_START_CACHE) {
 		if (fw_cache_piggyback_on_request(fw_priv->fw_name))
 			kref_get(&fw_priv->ref);
@@ -783,7 +788,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 #endif
 
 	if (ret == -ENOENT)
-		ret = firmware_fallback_platform(fw->priv, opt_flags);
+		ret = firmware_fallback_platform(fw->priv);
 
 	if (ret) {
 		if (!(opt_flags & FW_OPT_NO_WARN))
@@ -792,7 +797,7 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
 				 name, ret);
 		ret = firmware_fallback_sysfs(fw, name, device, opt_flags, ret);
 	} else
-		ret = assign_fw(fw, device, opt_flags);
+		ret = assign_fw(fw, device);
 
  out:
 	if (ret < 0) {
-- 
2.25.1

