Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2494D5BB6DB
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Sep 2022 09:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIQHGc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 17 Sep 2022 03:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQHGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 17 Sep 2022 03:06:31 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E2B4F690;
        Sat, 17 Sep 2022 00:06:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t3so23410943ply.2;
        Sat, 17 Sep 2022 00:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gB5h/T33V9gpZKvAPxPSR02YTU84Z6GoD+iIQZO//cY=;
        b=KH74j79optJm/jPjL8g74slfPsyfsrBezccD6mT1SE1JxPaLQL9PcAasqLT2ogJTnc
         u2RN+2epzvo6OXn1yrsZ0OMngtA8qiGMVqSuDkDHTUuC5YvZP4gKuZ2z98k0zife6kHS
         8R2yoHS4RyNGM6uq3W1HMsBwtggPAJhTXCBS1zx8RxlBCG6/russaXzgnSyBlXK1LSgb
         RdfwUxlvlMRLhVQ76xHs9cqCDtJh98IbGp241D0iLkFtq+1JDBr58g+0xFVE5Nj3jx9u
         ku04TBuWF3q/sO6bX22FqtnwsXBTH+2zaaTJRY+WWWHxILKGfLtuCl0SBUptQ6xaqEnp
         dDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gB5h/T33V9gpZKvAPxPSR02YTU84Z6GoD+iIQZO//cY=;
        b=KJr7BDBkuEv3dpWasHxYHOpMui6MKBdpNv+VfKZFXi1eaku4njKyowKR+o0ICe05/9
         6RxwGoCbVD3bGl6JH8Vyx3L7Vj2vS0tPJSpDpE5jhV6RpsD/e5mDNFyymTVkO4unPDiN
         HICVUjY5kq2s9PTS6d6BH61cCJc8PIo6Me1HrSxI6UAZf/aZfmXodLZMym3A1mLTn+tR
         uxgvOdYNS0CCk2tYkqQpSFlzqFfl+gU4DmB/juUtehBmKJ3Q1HV6bhH72gy/k9BQqO2Z
         yMrHH+034rD9HJ2MmtLWKd5wiYogaWKdkgNwWy/yeGGX90XZiXEKVSAcmCqNlVpjET2G
         98RQ==
X-Gm-Message-State: ACrzQf0xKFwtbjqiKujm4EvLCnEmjxqmFkeipdXHLbnz3N9gV2DX/9F4
        03OoWZCzIskhFmPVArW8wnmovbOgEsw=
X-Google-Smtp-Source: AMsMyM6k0Z64A48kwS2YrIh5ozABVQWXIz9gKGJ41VuS260vYGjV8WzBpSP8gfKm8gJLFhIDiscBKw==
X-Received: by 2002:a17:90b:3101:b0:203:776b:6494 with SMTP id gc1-20020a17090b310100b00203776b6494mr388079pjb.43.1663398389493;
        Sat, 17 Sep 2022 00:06:29 -0700 (PDT)
Received: from localhost.localdomain (KD027092233113.ppp-bb.dion.ne.jp. [27.92.233.113])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b00177faf558b5sm16241114pla.250.2022.09.17.00.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 00:06:29 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        corbet@lwn.net, david@redhat.com, osalvador@suse.de,
        shuah@kernel.org, Zhao Gongyi <zhaogongyi@huawei.com>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH] lib/notifier-error-inject: fix error when writing errno to debugfs file
Date:   Sat, 17 Sep 2022 16:06:08 +0900
Message-Id: <20220917070608.28210-1-akinobu.mita@gmail.com>
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
Reported-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
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

