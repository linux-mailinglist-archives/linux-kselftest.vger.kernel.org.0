Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625865BB6E2
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 09:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIQHPf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 03:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiIQHPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 03:15:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A952E3DBD0;
        Sat, 17 Sep 2022 00:15:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so1865513pjq.3;
        Sat, 17 Sep 2022 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=euiEboSX4sdbeq9UmO12nvx8uEAMFtLZgxLVQeziaMM=;
        b=HlDkWDLtMRywKdOKQmpeW5A+Q5bj6Cui32N7zuzHb17bwiyg2C+8ioFKvjm+7JmTC3
         vd60jGNsfAG20BL8ZbC/C/lvToJLVupK3xLf1MlbQrLC5lqiAbX7/IyIhJ/XBhG7vW+S
         ouMufuuQEenPqxykeiBRlQyGoKUvBBAzSpGOBZ41pWdHESLhg1SCXWd9D2JkRRgPtnDs
         5hK7SmWFCqhMbryVHn3I4e6OeI503DLjoLjg0+LFzK+ngelEZFl6vub4PlV8WH0or4vE
         WEO2ma7CkG2EL6jmEu7SGWDmRRwqLEWuvME+JG56c+6cmXFHeB834x0UJsbFBsKI9K6Z
         zW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=euiEboSX4sdbeq9UmO12nvx8uEAMFtLZgxLVQeziaMM=;
        b=05GfCM2SnF5Ec+3zImiHrAFTElJuUNDQdI4WLPsp+RTcMGEpqRRo2rTwsC7KyN4EEK
         3sIuDTIlq69IGauym8ezXlgwm7BsKSL7A5CLtIFlmACYzMm7H0mRYnlnmZJRucxo4/ms
         E7W/ZhXjYEOOwD05qCzN6S5WuZ7K/fEIVZFAasAirfTAgJE1u4ny0v0lqA1Ma5E0V1P4
         jl7lxsM5J2zeBeqmoLyzQL1XYi/kD/ZmLF72Y9juGsCK9vtEtHLCHyX+6Eu0gT1amkyM
         Etw85/fx4fY5qmcacFtGgPuiJp87Z5+3nF62/ULz1mhMyUt7oApeX69A74Mb1Gv+vQOx
         zpVg==
X-Gm-Message-State: ACrzQf3cT/nirU+ahuuK6/x+hshROGnDVRsz/byWGPwryzdMKoI5OwMX
        C/kvLKHebMBopAaF4BjdAeN5QbonCvc=
X-Google-Smtp-Source: AMsMyM7HJcgHweGOWmpLFyDkTHHlATOBWe+dMv9CzetA3a6U53V746dEsWDsUM4gjqiMcMKHuIWEeA==
X-Received: by 2002:a17:902:c245:b0:178:3912:f1fe with SMTP id 5-20020a170902c24500b001783912f1femr3491026plg.13.1663398929823;
        Sat, 17 Sep 2022 00:15:29 -0700 (PDT)
Received: from localhost.localdomain (KD027092233113.ppp-bb.dion.ne.jp. [27.92.233.113])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b0016c0c82e85csm16327792plg.75.2022.09.17.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 00:15:29 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        akinobu.mita@gmail.com, corbet@lwn.net, david@redhat.com,
        osalvador@suse.de, shuah@kernel.org,
        Zhao Gongyi <zhaogongyi@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: [PATCH -v2] lib/notifier-error-inject: fix error when writing errno to debugfs file
Date:   Sat, 17 Sep 2022 16:14:27 +0900
Message-Id: <20220917071427.28499-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The simple attribute files do not accept a negative value since the
commit 488dac0c9237 ("libfs: fix error cast of negative value in
simple_attr_write()"), so we can no longer use DEFINE_SIMPLE_ATTRIBUTE() to
define a file operations for errno value.

Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
v2: Fix Reported-by line

 lib/notifier-error-inject.c | 38 ++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/lib/notifier-error-inject.c b/lib/notifier-error-inject.c
index 21016b32d313..30ec41f58d53 100644
--- a/lib/notifier-error-inject.c
+++ b/lib/notifier-error-inject.c
@@ -3,20 +3,44 @@
 
 #include "notifier-error-inject.h"
 
-static int debugfs_errno_set(void *data, u64 val)
+static int notifier_err_errno_show(struct seq_file *m, void *data)
 {
-	*(int *)data = clamp_t(int, val, -MAX_ERRNO, 0);
+	int *value = m->private;
+
+	seq_printf(m, "%d\n", *value);
+
 	return 0;
 }
 
-static int debugfs_errno_get(void *data, u64 *val)
+static int notifier_err_errno_open(struct inode *inode, struct file *file)
 {
-	*val = *(int *)data;
-	return 0;
+	return single_open(file, notifier_err_errno_show, inode->i_private);
+}
+
+static ssize_t notifier_err_errno_write(struct file *file, const char __user *ubuf, size_t len,
+					loff_t *offp)
+{
+	struct seq_file *m = file->private_data;
+	int *value = m->private;
+	int ret;
+
+	ret = kstrtoint_from_user(ubuf, len, 0, value);
+	if (ret)
+		return ret;
+
+	*value = clamp(*value, -MAX_ERRNO, 0);
+
+	return len;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(fops_errno, debugfs_errno_get, debugfs_errno_set,
-			"%lld\n");
+static const struct file_operations fops_errno = {
+	.owner = THIS_MODULE,
+	.open = notifier_err_errno_open,
+	.read = seq_read,
+	.write = notifier_err_errno_write,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
 
 static struct dentry *debugfs_create_errno(const char *name, umode_t mode,
 				struct dentry *parent, int *value)
-- 
2.34.1

