Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34077EBCD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 23:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346488AbjHPV3H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 17:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346499AbjHPV2n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 17:28:43 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34241FD;
        Wed, 16 Aug 2023 14:28:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 19DF260174;
        Wed, 16 Aug 2023 23:28:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692221320; bh=rIZf+tAqF67XAb0OfH9NkRmreg9cRVOUccORHUbh0H4=;
        h=From:To:Cc:Subject:Date:From;
        b=ip8HZAJDpPj4BkPt74Lq9cHX2vfPStRQpP7FbobsLN1TTqe10LT+MixTwEAaOEBsF
         oWK0r2HuOPsrVjtIboxyzlw3b0IEIF1+Znp/bEaWY4IvSWROWft3gH+BEnAXQ45loi
         k3chfVnEcxr8wpy0UNfoCYBM6g1kpRiCdvT+FeIWAx0fVUkraR8+6EB6xE6OeRr/8A
         ICQAru91zWnNjB9WNPyaH8E8DqIxZ1OkISAhaX3s+7SOlzpFtOT0lNA2gwPyWHgl9K
         +tlfom2aszpaiUdbzsw8mj7XigOShBCvDHkzIp2jkc47m5nljKRkcVlTcaEIce7Ip6
         aigUO4Qq9wE8A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YeHIiorDg4g1; Wed, 16 Aug 2023 23:28:36 +0200 (CEST)
Received: from defiant.. (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 39A6B6015E;
        Wed, 16 Aug 2023 23:28:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692221316; bh=rIZf+tAqF67XAb0OfH9NkRmreg9cRVOUccORHUbh0H4=;
        h=From:To:Cc:Subject:Date:From;
        b=LWpPMdZ6/Zn4Mqa3h4TvyvYrd3+6FpBCr+FCQVHpTkgc6VtAFWp2PdYo444oHEJ8k
         26ALhOk4jmEMP38WH9I0oQBtucoIRfIjbFrxKn4xzHneBACkw9lbJtAW2IjMccALG6
         F0iypWoinFein3WPA18nps7m6CGZxUe73qiP0MggSmekVvAJNCYVQWd/tf1+TPzg5Q
         6K+ETVN+jiHpEkqrhv0OeYStLPb8q8SOPFEQFDZNdhCffkEJc5IemfFTlQcIaZzZYX
         vtNZzPv/FbaVUtQ2eA3NXGYXOebntnqQOc0z4/TQnGepYk16jnXKSN4mBG5qgAFdQP
         9nQehndIxFAJw==
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        linux-kernel@vger.kernel.org
Cc:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Tianfei Zhang <tianfei.zhang@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v4 4.19 1/1] test_firmware: prevent race conditions by a correct implementation of locking
Date:   Wed, 16 Aug 2023 23:27:18 +0200
Message-Id: <20230816212717.817202-1-mirsad.todorovac@alu.unizg.hr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>

[ This is the patch to fix the racing condition in locking for the 5.4, ]
[ 4.19 and 4.14 stable branches. Not all the fixes from the upstream    ]
[ commit apply, but those which do are verbatim equal to those in the   ]
[ upstream commit.                                                      ]

---
 v4:
	verbatim the same patch as for the 5.4 stable tree which patchwork failed to apply.

 lib/test_firmware.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/lib/test_firmware.c b/lib/test_firmware.c
index b5e779bcfb34..be3baea88b61 100644
--- a/lib/test_firmware.c
+++ b/lib/test_firmware.c
@@ -284,16 +284,26 @@ static ssize_t config_test_show_str(char *dst,
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
@@ -323,7 +333,7 @@ static ssize_t test_dev_config_show_int(char *buf, int cfg)
 	return snprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
-static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
+static inline int __test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
 {
 	int ret;
 	long new;
@@ -335,14 +345,23 @@ static int test_dev_config_update_u8(const char *buf, size_t size, u8 *cfg)
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
@@ -375,10 +394,10 @@ static ssize_t config_num_requests_store(struct device *dev,
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

