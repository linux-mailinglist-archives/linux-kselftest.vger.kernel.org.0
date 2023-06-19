Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9F735484
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 12:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbjFSK4x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 06:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjFSK4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 06:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7435410E0;
        Mon, 19 Jun 2023 03:54:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 796A560B4B;
        Mon, 19 Jun 2023 10:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BB0C433C0;
        Mon, 19 Jun 2023 10:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172080;
        bh=3k8XIXTXjc5NE7UTTTzwhXpoWsBvOz3UVGBX67ySbXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KYZ1XNbWNuPkj8qSgpu4msWT0uklz4YAcgA4DCbXmShlVWMJYQ1VDbRUK2gQtHp8o
         iOF43nn+H+O+qsObhZVXtbJpAnwHnzqKvcGbNkHr3HjLRjyVKYsAUccOpY7drdkUlM
         byT7F580g7hhIPL5p7W4gi9EuYJi70N882TpCTts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luis Chamberlain <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, Dan Carpenter <error27@gmail.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 04/89] test_firmware: prevent race conditions by a correct implementation of locking
Date:   Mon, 19 Jun 2023 12:29:52 +0200
Message-ID: <20230619102138.489344343@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
References: <20230619102138.279161276@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

[ Upstream commit 4acfe3dfde685a5a9eaec5555351918e2d7266a1 ]

Dan Carpenter spotted a race condition in a couple of situations like
these in the test_firmware driver:

static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
{
        u8 val;
        int ret;

        ret = kstrtou8(buf, 10, &val);
        if (ret)
                return ret;

        mutex_lock(&test_fw_mutex);
        *(u8 *)cfg = val;
        mutex_unlock(&test_fw_mutex);

        /* Always return full write size even if we didn't consume all */
        return size;
}

static ssize_t config_num_requests_store(struct device *dev,
                                         struct device_attribute *attr,
                                         const char *buf, size_t count)
{
        int rc;

        mutex_lock(&test_fw_mutex);
        if (test_fw_config->reqs) {
                pr_err("Must call release_all_firmware prior to changing config\n");
                rc = -EINVAL;
                mutex_unlock(&test_fw_mutex);
                goto out;
        }
        mutex_unlock(&test_fw_mutex);

        rc = test_dev_config_update_u8(buf, count,
                                       &test_fw_config->num_requests);

out:
        return rc;
}

static ssize_t config_read_fw_idx_store(struct device *dev,
                                        struct device_attribute *attr,
                                        const char *buf, size_t count)
{
        return test_dev_config_update_u8(buf, count,
                                         &test_fw_config->read_fw_idx);
}

The function test_dev_config_update_u8() is called from both the locked
and the unlocked context, function config_num_requests_store() and
config_read_fw_idx_store() which can both be called asynchronously as
they are driver's methods, while test_dev_config_update_u8() and siblings
change their argument pointed to by u8 *cfg or similar pointer.

To avoid deadlock on test_fw_mutex, the lock is dropped before calling
test_dev_config_update_u8() and re-acquired within test_dev_config_update_u8()
itself, but alas this creates a race condition.

Having two locks wouldn't assure a race-proof mutual exclusion.

This situation is best avoided by the introduction of a new, unlocked
function __test_dev_config_update_u8() which can be called from the locked
context and reducing test_dev_config_update_u8() to:

static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
{
        int ret;

        mutex_lock(&test_fw_mutex);
        ret = __test_dev_config_update_u8(buf, size, cfg);
        mutex_unlock(&test_fw_mutex);

        return ret;
}

doing the locking and calling the unlocked primitive, which enables both
locked and unlocked versions without duplication of code.

The similar approach was applied to all functions called from the locked
and the unlocked context, which safely mitigates both deadlocks and race
conditions in the driver.

__test_dev_config_update_bool(), __test_dev_config_update_u8() and
__test_dev_config_update_size_t() unlocked versions of the functions
were introduced to be called from the locked contexts as a workaround
without releasing the main driver's lock and thereof causing a race
condition.

The test_dev_config_update_bool(), test_dev_config_update_u8() and
test_dev_config_update_size_t() locked versions of the functions
are being called from driver methods without the unnecessary multiplying
of the locking and unlocking code for each method, and complicating
the code with saving of the return value across lock.

Fixes: 7feebfa487b92 ("test_firmware: add support for request_firmware_into_buf")
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v5.4
Suggested-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/r/20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/test_firmware.c | 52 ++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index b99cf0a50a698..4884057eb53f0 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -321,16 +321,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
 				       bool *cfg)
 {
 	int ret;
 
-	mutex_lock(&test_fw_mutex);
 	if (kstrtobool(buf, cfg) < 0)
 		ret = -EINVAL;
 	else
 		ret = size;
+
+	return ret;
+}
+
+static int test_dev_config_update_bool(const char *buf, size_t size,
+				       bool *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_bool(buf, size, cfg);
 	mutex_unlock(&test_fw_mutex);
 
 	return ret;
@@ -341,7 +351,8 @@ static ssize_t test_dev_config_show_bool(char *buf, bool val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_size_t(const char *buf,
+static int __test_dev_config_update_size_t(
+					 const char *buf,
 					 size_t size,
 					 size_t *cfg)
 {
@@ -352,9 +363,7 @@ static int test_dev_config_update_size_t(const char *buf,
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(size_t *)cfg = new;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
@@ -370,7 +379,7 @@ static ssize_t test_dev_config_show_int(char *buf, int val)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	u8 val;
 	int ret;
@@ -379,14 +388,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	if (ret)
 		return ret;
 
-	mutex_lock(&test_fw_mutex);
 	*(u8 *)cfg = val;
-	mutex_unlock(&test_fw_mutex);
 
 	/* Always return full write size even if we didn't consume all */
 	return size;
 }
 
+static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+{
+	int ret;
+
+	mutex_lock(&test_fw_mutex);
+	ret = __test_dev_config_update_u8(buf, size, cfg);
+	mutex_unlock(&test_fw_mutex);
+
+	return ret;
+}
+
 static ssize_t test_dev_config_show_u8(char *buf, u8 val)
 {
 	return snprintf(buf, PAGE_SIZE, "%u\n", val);
@@ -413,10 +431,10 @@ static ssize_t config_num_requests_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_u8(buf, count,
-				       &test_fw_config->num_requests);
+	rc = __test_dev_config_update_u8(buf, count,
+					 &test_fw_config->num_requests);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -460,10 +478,10 @@ static ssize_t config_buf_size_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->buf_size);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->buf_size);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
@@ -490,10 +508,10 @@ static ssize_t config_file_offset_store(struct device *dev,
 		mutex_unlock(&test_fw_mutex);
 		goto out;
 	}
-	mutex_unlock(&test_fw_mutex);
 
-	rc = test_dev_config_update_size_t(buf, count,
-					   &test_fw_config->file_offset);
+	rc = __test_dev_config_update_size_t(buf, count,
+					     &test_fw_config->file_offset);
+	mutex_unlock(&test_fw_mutex);
 
 out:
 	return rc;
-- 
2.39.2



