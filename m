Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F7876F031
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 18:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHCQ6Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 12:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjHCQ6I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 12:58:08 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873EF4684;
        Thu,  3 Aug 2023 09:57:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 1D9BB60182;
        Thu,  3 Aug 2023 18:57:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691081858; bh=EyEwB/t6S5pIqpZtYgxvhXUDUQzkNhq8UneDqrgAzDI=;
        h=From:To:Cc:Subject:Date:From;
        b=AVn3ZF3QRLvCumt/5LEpg8/SEl5ex86j7Gz8NZ9+tX4lpO9Uz2Ln1fRqiwj6Aul+C
         Nx1BvXt2piSEH+gcYZSQmeMBO/LJe41L3Kaqfp4TjGLnt4bMRi7LXTKg8SzcxL2S9s
         SOnc7r+apiVKzsYvlhdU9OzsXcQSkzThP+6viA0vlKE0mLk4uKft7VDEO59f95rBX5
         OiBbpo/up4s8QLXncnxzjvR10bfhiEgnSMGRl82ZmtJ9QtyjW5y3aIs9xJ8ZU2dGDI
         Dl0b9/jTPTX8L10rcqITTgviVo+j2UHyo84BaKrj4p7GouoEMm7baRA7mI6byF2MQp
         gJSVcen86YHdw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eNnLZ3TT8tFW; Thu,  3 Aug 2023 18:57:35 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id BDEA36017F;
        Thu,  3 Aug 2023 18:57:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1691081855; bh=EyEwB/t6S5pIqpZtYgxvhXUDUQzkNhq8UneDqrgAzDI=;
        h=From:To:Cc:Subject:Date:From;
        b=z1ZlDhqR5flUzggebox+Ffxa28pRC0WR0opp/P5WZ3dxqMQCcWNG8mxKG+RL08Sp+
         Ifb1KEngRWZlEeJ9h7YZiKyx9ZqrPRCS5gd1keuN++bwMt9Ta5XhKHj2N/zuyN3ajm
         RrgTPpkeH6LT5LabuG8OOOMxMrSgSUAL0QnZ/AZhfrZVwxiYH4tyLwO5mYCndeJWOa
         7JKPa67GL/UtbuzQHbQbUmp0Q+QqAMsgZjTqAAHre+k+hWbzWHxjI2xEWlOfFsmvgl
         D3FFyybZs5/ieJtvH+JjDhGoqCAwVfwCMBxIWdfcd7CmubBWie5MLAzNETHEEqeQSm
         Twn/jsc9fJdXg==
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 1/2] test_firmware: prevent race conditions by a correct implementation of locking
Date:   Thu,  3 Aug 2023 18:53:04 +0200
Message-Id: <20230803165304.9200-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

        // NOTE: HERE is the race!!! Function can be preempted!

        // test_fw_config->reqs can change between the release of
        // the lock about and acquire of the lock in the
        // test_dev_config_update_u8()

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

Fixes: c92316bf8e948 ("test_firmware: add batched firmware tests")
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russ Weight <russell.h.weight@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Tianfei Zhang <tianfei.zhang@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Colin Ian King <colin.i.king@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kselftest@vger.kernel.org
Cc: stable@vger.kernel.org # v5.4, 4.19, 4.14
Suggested-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/20230509084746.48259-1-mirsad.todorovac@alu.unizg.hr
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This is the patch to fix the racing condition in locking for the 5.4,	]
[ 4.19 and 4.14 stable branches. Not all the fixes from the upstream	]
[ commit apply, but those which do are verbatim equal to those in the	]
[ upstream commit.							]
---
 v3:
 minor bug fixes in the commit description. no change to the code.
 5.4, 4.19 and 4.14 passed build, 5.4 and 4.19 passed kselftest.
 unable to boot 4.14, should work (no changes to lib/test_firmware.c).

 v2:
 bundled locking and ENOSPC patches together.
 tested on 5.4 and 4.19 stable.

 lib/test_firmware.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index 38553944e967..92d7195d5b5b 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -301,16 +301,26 @@ static ssize_t config_test_show_str(char *dst,
 	return len;
 }
 
-static int test_dev_config_update_bool(const char *buf, size_t size,
-				       bool *cfg)
+static inline int __test_dev_config_update_bool(const char *buf, size_t size,
+						bool *cfg)
 {
 	int ret;
 
-	mutex_lock(&test_fw_mutex);
 	if (strtobool(buf, cfg) < 0)
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
@@ -340,7 +350,7 @@ static ssize_t test_dev_config_show_int(char *buf, int cfg)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static inline int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	int ret;
 	long new;
@@ -352,14 +362,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 	if (new > U8_MAX)
 		return -EINVAL;
 
-	mutex_lock(&test_fw_mutex);
 	*(u8 *)cfg = new;
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
 static ssize_t test_dev_config_show_u8(char *buf, u8 cfg)
 {
 	u8 val;
@@ -392,10 +411,10 @@ static ssize_t config_num_requests_store(struct device *dev,
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
-- 
2.34.1

