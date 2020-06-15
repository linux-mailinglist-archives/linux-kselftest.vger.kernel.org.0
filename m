Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307F21FA097
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jun 2020 21:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgFOTmo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Jun 2020 15:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731143AbgFOTmd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Jun 2020 15:42:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A99C00862E
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 12:42:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so7214712plb.11
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jun 2020 12:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JfL5rZ2jBHVHruE8gOvtqg9JyZgUNdlEVNmiNcV2KM=;
        b=fZanf+Q+DkHfo4aMqHOFUedXmvMVZgrQLA/WZwrpg3u80ggEz5uw8dl6q1DJv6I69K
         eYo3FCvwRfsraJfmLiMYBs2O/FSWtFfrZQSFOcptNWbiVrSU5HTXZzTDtSQsIil04nL+
         zttQYNpicIkl/Y5bhmPKZWvnMFmApQ6ukgXro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3JfL5rZ2jBHVHruE8gOvtqg9JyZgUNdlEVNmiNcV2KM=;
        b=lbaQiFjrL4mOBIPXVnZrKOFCxyRhOga4fY3KKLYy6qrv3aN39y6npkn+3Qqqk5NREB
         aupCqTjPX1VtokrW8zr5O29ucPiv+cpFiiuxnKqdGJILE0PBfo8IvF3OgofnI+8WFE3n
         3lSPIdCVtmPso/LGUC/5rkB/wHe7G/nvRRVcfvf+iUBwGjkm4BC9zzgrPItN3XWGeovJ
         01ph296e8jmtr5lDoaYgZvIs35I0Uek3BTlHm+Pt6sbNCXK3oIZajnl53SEd5nKdOsjM
         0UCkUPIrEIyptuNDltoR+TdiE0RbMtv+IfOWw0lNd/ID7SkviC3ctPJkOdJ+iH3uD5rq
         AbZg==
X-Gm-Message-State: AOAM531VNrTBw5GS223aExbxuOaIgoNs91PT6jdd6gd7pIR0V0KmoWea
        e20f/TRqnlqsY7VhrQ3ddzpHLw==
X-Google-Smtp-Source: ABdhPJx3kMXK9CvuRG607l8hAulj7XpeylNQZX9QIPNmIiTc3+hVVDCGFUV4snMFUNJ8QV1CHz5ttA==
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr13325262pln.114.1592250149282;
        Mon, 15 Jun 2020 12:42:29 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id gq8sm293663pjb.14.2020.06.15.12.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:42:28 -0700 (PDT)
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
Subject: [PATCH v9 8/8] ima: add FIRMWARE_PARTIAL_READ support
Date:   Mon, 15 Jun 2020 12:41:51 -0700
Message-Id: <20200615194151.7011-9-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615194151.7011-1-scott.branden@broadcom.com>
References: <20200615194151.7011-1-scott.branden@broadcom.com>
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
index c1583d98c5e5..5602bc858369 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -610,6 +610,9 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	enum ima_hooks func;
+	u32 secid;
+
 	/*
 	 * READING_FIRMWARE_PREALLOC_BUFFER
 	 *
@@ -618,11 +621,27 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
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
@@ -649,6 +668,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
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

