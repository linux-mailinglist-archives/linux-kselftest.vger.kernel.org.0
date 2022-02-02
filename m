Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C64A7440
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 16:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344158AbiBBPJY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 10:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiBBPJY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 10:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0006DC061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 07:09:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 791136154B
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 15:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAFEC340EB;
        Wed,  2 Feb 2022 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643814562;
        bh=S7cvBuUA7E92mwC6z6HrbYredDqrn9Nav7s0tks3JW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qum0W52CXAyKZmLKbJGPEQw7yQT7uRckra3ogUSi27qOrm9iA6Lm9nDVsj/0q5Ebz
         TgouP7U+PlkM33Fcu8wBMD8UJ4pSxCNmifOR5HCKMb5UsCRormI+4wvSAhphVYOsCv
         MkuatE3x6I40ZoAkrImfio2B6/UAniiLdOnE6dvMfCO+8VSsHjNMGXw817xYxUa42E
         f4jcjBnCW6MQCGm86bL6B4C/KVZvcnfcNoz6iPpEZ3JEhkC630j2RlQ32+3UWC0js/
         Vw0TquwvjZW2/PuMrVl3WIjIKBHN94p+6XaT7ZvgDvXpeOcNod1GVHywXlaKqmHIST
         fi+BRR9GqUCWw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 2/2] kselftest: alsa: Declare most functions static
Date:   Wed,  2 Feb 2022 15:09:02 +0000
Message-Id: <20220202150902.19563-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202150902.19563-1-broonie@kernel.org>
References: <20220202150902.19563-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7362; h=from:subject; bh=S7cvBuUA7E92mwC6z6HrbYredDqrn9Nav7s0tks3JW4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh+p54d2FCbgYPVpYhArjxg/SQX6o8Lhuqcm+IuKiv SM+tWn2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfqeeAAKCRAk1otyXVSH0LwMB/ 4heuGa2hUDlrJtfy/1/g0NUecT/g/CHW3B1E2DitxYmuqo7nYoXeKhmP+IBIc71MvgvfQe1IaUbvGx nE8/Yg6/OAY3x6e3LUDc5M8b6F9W6s7qfkO1pi1Ox36r+GeSj+t8ONZrBKUzb0xKGgfxmNRKAH/jhI Tq0PCdhkS4WBqwQXTFEdqovfaMC3sHbQ1ZJ4PcDt7OExxlLX54Qdwi7a5lx8mVm/ao0FzQRRVXErpU Z/YhaEQyHtmzUU4lfAusd5RYfSTZrktEMiQ0nd0KIOQjGXbmhlGtpT1oGF7d+bXcdtvdP3grRXrQsM EZtBWT+FKBSdcE8xIPV9vU8NGv3RU4
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This program has only one file so most functions can be static.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
---
 tools/testing/selftests/alsa/mixer-test.c | 58 ++++++++++++-----------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 6edb7dca32af..d0b788b8d287 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -71,7 +71,8 @@ struct ctl_data *ctl_list = NULL;
 #endif
 
 #ifndef LIB_HAS_LOAD_STRING
-int snd_config_load_string(snd_config_t **config, const char *s, size_t size)
+static int snd_config_load_string(snd_config_t **config, const char *s,
+				  size_t size)
 {
 	snd_input_t *input;
 	snd_config_t *dst;
@@ -99,7 +100,7 @@ int snd_config_load_string(snd_config_t **config, const char *s, size_t size)
 }
 #endif
 
-void find_controls(void)
+static void find_controls(void)
 {
 	char name[32];
 	int card, ctl, err;
@@ -222,7 +223,7 @@ void find_controls(void)
  * Block for up to timeout ms for an event, returns a negative value
  * on error, 0 for no event and 1 for an event.
  */
-int wait_for_event(struct ctl_data *ctl, int timeout)
+static int wait_for_event(struct ctl_data *ctl, int timeout)
 {
 	unsigned short revents;
 	snd_ctl_event_t *event;
@@ -291,8 +292,9 @@ int wait_for_event(struct ctl_data *ctl, int timeout)
 	return 1;
 }
 
-bool ctl_value_index_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val,
-			   int index)
+static bool ctl_value_index_valid(struct ctl_data *ctl,
+				  snd_ctl_elem_value_t *val,
+				  int index)
 {
 	long int_val;
 	long long int64_val;
@@ -403,7 +405,7 @@ bool ctl_value_index_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val,
  * Check that the provided value meets the constraints for the
  * provided control.
  */
-bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
+static bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
 {
 	int i;
 	bool valid = true;
@@ -419,7 +421,7 @@ bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
  * Check that we can read the default value and it is valid. Write
  * tests use the read value to restore the default.
  */
-void test_ctl_get_value(struct ctl_data *ctl)
+static void test_ctl_get_value(struct ctl_data *ctl)
 {
 	int err;
 
@@ -454,9 +456,9 @@ void test_ctl_get_value(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
-bool show_mismatch(struct ctl_data *ctl, int index,
-		   snd_ctl_elem_value_t *read_val,
-		   snd_ctl_elem_value_t *expected_val)
+static bool show_mismatch(struct ctl_data *ctl, int index,
+			  snd_ctl_elem_value_t *read_val,
+			  snd_ctl_elem_value_t *expected_val)
 {
 	long long expected_int, read_int;
 
@@ -519,9 +521,9 @@ bool show_mismatch(struct ctl_data *ctl, int index,
  * the write to fail, for verifying that invalid writes don't corrupt
  * anything.
  */
-int write_and_verify(struct ctl_data *ctl,
-		     snd_ctl_elem_value_t *write_val,
-		     snd_ctl_elem_value_t *expected_val)
+static int write_and_verify(struct ctl_data *ctl,
+			    snd_ctl_elem_value_t *write_val,
+			    snd_ctl_elem_value_t *expected_val)
 {
 	int err, i;
 	bool error_expected, mismatch_shown;
@@ -628,7 +630,7 @@ int write_and_verify(struct ctl_data *ctl,
  * Make sure we can write the default value back to the control, this
  * should validate that at least some write works.
  */
-void test_ctl_write_default(struct ctl_data *ctl)
+static void test_ctl_write_default(struct ctl_data *ctl)
 {
 	int err;
 
@@ -661,7 +663,7 @@ void test_ctl_write_default(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
-bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
+static bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
 {
 	int err, i, j;
 	bool fail = false;
@@ -682,7 +684,7 @@ bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_valid_integer(struct ctl_data *ctl)
+static bool test_ctl_write_valid_integer(struct ctl_data *ctl)
 {
 	int err;
 	int i;
@@ -712,7 +714,7 @@ bool test_ctl_write_valid_integer(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
+static bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
 {
 	int err, i;
 	long long j, step;
@@ -740,7 +742,7 @@ bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
+static bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
 {
 	int err, i, j;
 	bool fail = false;
@@ -761,7 +763,7 @@ bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
 	return !fail;
 }
 
-void test_ctl_write_valid(struct ctl_data *ctl)
+static void test_ctl_write_valid(struct ctl_data *ctl)
 {
 	bool pass;
 	int err;
@@ -814,8 +816,8 @@ void test_ctl_write_valid(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
-bool test_ctl_write_invalid_value(struct ctl_data *ctl,
-				  snd_ctl_elem_value_t *val)
+static bool test_ctl_write_invalid_value(struct ctl_data *ctl,
+					 snd_ctl_elem_value_t *val)
 {
 	int err;
 	long val_read;
@@ -836,7 +838,7 @@ bool test_ctl_write_invalid_value(struct ctl_data *ctl,
 	return !ctl_value_valid(ctl, val);
 }
 
-bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
 {
 	int err, i;
 	long val_read;
@@ -855,7 +857,7 @@ bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
 {
 	int i;
 	bool fail = false;
@@ -901,7 +903,7 @@ bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
 {
 	int i;
 	bool fail = false;
@@ -947,7 +949,7 @@ bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
 {
 	int err, i;
 	unsigned int val_read;
@@ -979,7 +981,7 @@ bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
 }
 
 
-void test_ctl_write_invalid(struct ctl_data *ctl)
+static void test_ctl_write_invalid(struct ctl_data *ctl)
 {
 	bool pass;
 	int err;
@@ -1032,13 +1034,13 @@ void test_ctl_write_invalid(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
-void test_ctl_event_missing(struct ctl_data *ctl)
+static void test_ctl_event_missing(struct ctl_data *ctl)
 {
 	ksft_test_result(!ctl->event_missing, "event_missing.%d.%d\n",
 			 ctl->card->card, ctl->elem);
 }
 
-void test_ctl_event_spurious(struct ctl_data *ctl)
+static void test_ctl_event_spurious(struct ctl_data *ctl)
 {
 	ksft_test_result(!ctl->event_spurious, "event_spurious.%d.%d\n",
 			 ctl->card->card, ctl->elem);
-- 
2.30.2

