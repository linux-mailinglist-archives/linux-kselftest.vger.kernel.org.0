Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91A4A6363
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiBASQv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 13:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241939AbiBASPi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 13:15:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5431FC061758
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 10:15:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6746CCE1A65
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Feb 2022 18:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3ECC340EC;
        Tue,  1 Feb 2022 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643739334;
        bh=mft+vRadQppyWRJx/t7qdEiGgdk/j5wn6xnhaDNyV2A=;
        h=From:To:Cc:Subject:Date:From;
        b=pd5jCXs7GrTY6LML0qLarvxgftAXp/cBfteCza7LubjrYsubQrbgR1MZXOfVsuqqa
         495K/QeymnUNfGJEtHhEgleGZKzJowQmDy7et6u4S2KYi41vjZcsdu0iWtns83qKix
         ztDqLgUb8D2Feaz9O1v2Q17npzDZXEx0a/S62oALWtXLqakDNNpvhegcHKhdA8xi+S
         X/ogV01rugj1rkIR7vBHHRC1Ayobtbd7nJ6p9U4cp0D9TRq8tTJd4G9SDR2iRuGdMR
         PSVdPiKGM8x5/4hCvQVayTCHvTt1+7wwoV90F9g+OpVEEX2nLNE0wZrSukLMfgBB0f
         VnyGKVO90/e4Q==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest: alsa: Declare most functions static
Date:   Tue,  1 Feb 2022 18:15:30 +0000
Message-Id: <20220201181530.2405077-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7411; h=from:subject; bh=mft+vRadQppyWRJx/t7qdEiGgdk/j5wn6xnhaDNyV2A=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh+Xi3zP/OoLzM8o41EnVBQSL9oXXly9/jU9nUKFKi 2P4PxSiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfl4twAKCRAk1otyXVSH0FI8B/ 9/L9HOpnyeA4hBsE9ORgj/kgCN+QGdMO+R0mdtvxbkPCrMqk9dkA1yB5TDSoo/hqbEzNm464vbnymz 0ESAIOReU4+iOYWdJZO7sDJOemrL/xBJ2VmDrtwR0Ot1mYJoq8NUhDdI8+vRgc3dvTOcuobvSSliJ8 6tOGr1g2OrqhmvSuJE9HOcVgjgaHl4NT+EHxzbpaeAlL4h9Wiwf72M5odUIk3tqAGrbyCH6FB+MTDp v0puyKPzBYSSAVJjxXgPH0Pbghz6Xh8K4cUXE05GVTiDzlG4o6Lekpoe8mt3a+g+fuk4giig8Ql0ws NqMJvCD0UWqcv6BFbNEniF7yl6uCCQ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This program has only one file so most functions can be static.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
This depends on my previously posted patch adding coverage of events:

  https://lore.kernel.org/all/20220201151551.21497-1-broonie@kernel.org/

 tools/testing/selftests/alsa/mixer-test.c | 58 ++++++++++++-----------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 42cf3b724586..8faae89b7b48 100644
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

