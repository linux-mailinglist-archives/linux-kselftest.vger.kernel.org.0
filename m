Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D2D4A72B9
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 15:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiBBOKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 09:10:22 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35428 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344790AbiBBOKU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 09:10:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE02A6187F
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCCBC340F0;
        Wed,  2 Feb 2022 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643811019;
        bh=undVi2xoxeBWosZOo7DDc5Nxn/ZvS7RImD4dfo8aGzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PrQDpZWzbNuiXFltPWaepIQQ6/QYtV+bxM7M4oFMsRmE289mokJ63AEJPrrzH6iGg
         z488v35qFJVCSc4P45MgLyPat+ut5wzY1lGwI2U64ixMJ3KCUaN7+ZHqenEItISHpl
         emN6iMGnkLOYhvCzNToZlY1wqGYU7puUftHD6KnlHegI1Eg8LafZvrV3DKBwABdSfU
         W8gSqkfiZ6po7U+1pd/v57TFQgpOHsSNl9YyLUH6CNfVrgGI4u6Q9r0A8iCsR6KJEz
         nND4J55VZ0vEzf1dOuXZUxLd018EE3+Y9zRBLAfhrA+FlZZYi1m5FjPDqADVC8Nq4M
         b+HaVdEmTyRIg==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/2] kselftest: alsa: Declare most functions static
Date:   Wed,  2 Feb 2022 14:10:11 +0000
Message-Id: <20220202141011.14924-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220202141011.14924-1-broonie@kernel.org>
References: <20220202141011.14924-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7315; h=from:subject; bh=undVi2xoxeBWosZOo7DDc5Nxn/ZvS7RImD4dfo8aGzo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh+o9/qS3pVequsO6jsQTu5vObI6h7yD33Lqsnjndj Ep+15UGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfqPfwAKCRAk1otyXVSH0FDEB/ 0cr60mTmz5zM14OwI+xxU5NxXN2nF2+Jqk86lOWCRt3tLMqOziLMp5I8U/GrrpipgbeNvy0ecz8Ewq gKv0Ap5v1T1YQ9wYd7CjpeeqDn5jsl+6sPNWVv55IEEAG9xPLU1WGPxS6BpKIpzotVXSSiJ4FOAPVu UeW43qNKnqXXNTmEmLB/iqVKZCe44Si9YKH2Bv/KWWnlCig76R0CIOtHvox5VRBj/8ZalAPXemTkcG JbzBrGzD90FAAyVVIczdcrXs329Y3uos79niEpRNmzMKo0G76+NbHI6Uz/92cZKFWzkaVS+D2ZBBJ8 i391ssKl3KWOhFe/Paq5fhKEJq5oED
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This program has only one file so most functions can be static.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 58 ++++++++++++-----------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 79ffbca429ee..ac40c7d17152 100644
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
@@ -285,8 +286,9 @@ int wait_for_event(struct ctl_data *ctl, int timeout)
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
@@ -397,7 +399,7 @@ bool ctl_value_index_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val,
  * Check that the provided value meets the constraints for the
  * provided control.
  */
-bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
+static bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
 {
 	int i;
 	bool valid = true;
@@ -413,7 +415,7 @@ bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
  * Check that we can read the default value and it is valid. Write
  * tests use the read value to restore the default.
  */
-void test_ctl_get_value(struct ctl_data *ctl)
+static void test_ctl_get_value(struct ctl_data *ctl)
 {
 	int err;
 
@@ -448,9 +450,9 @@ void test_ctl_get_value(struct ctl_data *ctl)
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
 
@@ -513,9 +515,9 @@ bool show_mismatch(struct ctl_data *ctl, int index,
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
@@ -622,7 +624,7 @@ int write_and_verify(struct ctl_data *ctl,
  * Make sure we can write the default value back to the control, this
  * should validate that at least some write works.
  */
-void test_ctl_write_default(struct ctl_data *ctl)
+static void test_ctl_write_default(struct ctl_data *ctl)
 {
 	int err;
 
@@ -655,7 +657,7 @@ void test_ctl_write_default(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
-bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
+static bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
 {
 	int err, i, j;
 	bool fail = false;
@@ -676,7 +678,7 @@ bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_valid_integer(struct ctl_data *ctl)
+static bool test_ctl_write_valid_integer(struct ctl_data *ctl)
 {
 	int err;
 	int i;
@@ -706,7 +708,7 @@ bool test_ctl_write_valid_integer(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
+static bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
 {
 	int err, i;
 	long long j, step;
@@ -734,7 +736,7 @@ bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
+static bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
 {
 	int err, i, j;
 	bool fail = false;
@@ -755,7 +757,7 @@ bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
 	return !fail;
 }
 
-void test_ctl_write_valid(struct ctl_data *ctl)
+static void test_ctl_write_valid(struct ctl_data *ctl)
 {
 	bool pass;
 	int err;
@@ -808,8 +810,8 @@ void test_ctl_write_valid(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
-bool test_ctl_write_invalid_value(struct ctl_data *ctl,
-				  snd_ctl_elem_value_t *val)
+static bool test_ctl_write_invalid_value(struct ctl_data *ctl,
+					 snd_ctl_elem_value_t *val)
 {
 	int err;
 	long val_read;
@@ -830,7 +832,7 @@ bool test_ctl_write_invalid_value(struct ctl_data *ctl,
 	return !ctl_value_valid(ctl, val);
 }
 
-bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
 {
 	int err, i;
 	long val_read;
@@ -849,7 +851,7 @@ bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
 {
 	int i;
 	bool fail = false;
@@ -895,7 +897,7 @@ bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
 {
 	int i;
 	bool fail = false;
@@ -941,7 +943,7 @@ bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
 	return !fail;
 }
 
-bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
+static bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
 {
 	int err, i;
 	unsigned int val_read;
@@ -973,7 +975,7 @@ bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
 }
 
 
-void test_ctl_write_invalid(struct ctl_data *ctl)
+static void test_ctl_write_invalid(struct ctl_data *ctl)
 {
 	bool pass;
 	int err;
@@ -1026,13 +1028,13 @@ void test_ctl_write_invalid(struct ctl_data *ctl)
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

