Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111931F49C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jun 2020 00:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgFIW6U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Jun 2020 18:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbgFIW5q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Jun 2020 18:57:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F2C008745
        for <linux-kselftest@vger.kernel.org>; Tue,  9 Jun 2020 15:57:36 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e18so79026pgn.7
        for <linux-kselftest@vger.kernel.org>; Tue, 09 Jun 2020 15:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cM+rCpZobNDrkDN9s+cJ/Q1XgGFeWXzm3UzYtFYpyy4=;
        b=ByJPGZ0fwC+pHYx4+jr86EPnUJT03kDN80FFAKD7I5rX+wsF2f7csCPEgbu0Vv5JXD
         ZyLWQTOAA/02+ZV08uuMrd6LxZHpZq8t+zpNoZQcJEL4vViRm5Z4Qrylf4XzyxMH9i+e
         6RPwx+6tj/r3KDMiIgbqsv1cvcx5htVk6ttBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cM+rCpZobNDrkDN9s+cJ/Q1XgGFeWXzm3UzYtFYpyy4=;
        b=DR9OJQo7M8pHaL62dckJ3CIw2X4Jtdb3zicCyxOcnJ+1BNjDX3BLm8hLTj7Z073kJX
         NWNJXEeQ6AoenOui5QdCBIJPJmU7vyKjdTf3gd2aiNYtryMgzU+ys7Glu0iB9S7gDVeX
         W27jzM5VWWWHVeqLeS7WMXQ0cpBJbgSKLS3vOZD3GTQacn8QnYzglaHl2mguHjV5bAZB
         IqzVW7o8Vkwbb5iwH60XEaTuNCzAFhGJMFy2KDkTd8ZP78gqBEdNn6P5Ml8VPvJYyMku
         LrIC0PunmeVc0HjdAfW86Cr1s927pzUPIU5iVB+YiO0mk5Zsr+DHOLurmBHmD4u3GTvQ
         //hQ==
X-Gm-Message-State: AOAM533cjAW0bqBTOA71HKaqSuUaL580kaQPUzOObiy5W0nYCtOhyRNZ
        5o0cdaA1A5JoAUtCz4VE7O1TTw==
X-Google-Smtp-Source: ABdhPJzt2on8TT/VRipqTfFNR4O9ShRqcpSzbecmhCO8fd5EePg4uWMnzAa84LqTYB4Rh0Gh65kwjA==
X-Received: by 2002:a63:145f:: with SMTP id 31mr212923pgu.383.1591743455670;
        Tue, 09 Jun 2020 15:57:35 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p8sm9104978pgs.29.2020.06.09.15.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:57:34 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v8 8/8] ima: add FIRMWARE_PARTIAL_READ support
Date:   Tue,  9 Jun 2020 15:56:56 -0700
Message-Id: <20200609225656.18663-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609225656.18663-1-scott.branden@broadcom.com>
References: <20200609225656.18663-1-scott.branden@broadcom.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add FIRMWARE_PARTIAL_READ support for integrity
measurement on partial reads of firmware files.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 security/integrity/ima/ima_main.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 800fb3bba418..fc5134807acf 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -609,6 +609,9 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	enum ima_hooks func;
+	u32 secid;
+
 	/*
 	 * READING_FIRMWARE_PREALLOC_BUFFER
 	 *
@@ -617,11 +620,27 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	 * of IMA's signature verification any more than when using two
 	 * buffers?
 	 */
-	return 0;
+	if (read_id != READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
+	if (!file) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
+
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PARTIAL_READ] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
@@ -648,6 +667,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
+	if (read_id == READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.17.1

