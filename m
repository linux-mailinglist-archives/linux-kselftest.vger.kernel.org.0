Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA2D4A743F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Feb 2022 16:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243333AbiBBPJW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Feb 2022 10:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242321AbiBBPJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Feb 2022 10:09:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8EC061714
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 07:09:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FB661139
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Feb 2022 15:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E6C004E1;
        Wed,  2 Feb 2022 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643814560;
        bh=KyvzvDEn31PT0qnOSvFcZh8V7MfsKqbcd2rduG4Pom8=;
        h=From:To:Cc:Subject:Date:From;
        b=ZHHQzpijn0B09vRNZMrtWhqREHP/A4SOSdpHK+/UImVrj4IoE6rnJW4PoP3eMloOp
         nZzugADsgmkBJtzFJLF/sE4JpUmxwB0w7awlI2dCETDiowivAT8+HEG4/2cdU+6saa
         HT9rXZBz5s/dZUOkfexCcPUBmn2wo6dVylAELUt9tDxHQHTPcd2O2evCreolSCQXlh
         b9CmnC+8ApqEU97xS2KC/WHTKBfnlqpXeL927b5KB+2ib0Yc00jOlrfr5IuYf7PBIc
         4P2ka/F7QJZlZ97MyW7XN8QrNpCLEWD4re176xAzvetYADWH5gfC5lRTHAzwg3W25B
         LdW/hrCbt+D8w==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 1/2] kselftest: alsa: Check for event generation when we write to controls
Date:   Wed,  2 Feb 2022 15:09:01 +0000
Message-Id: <20220202150902.19563-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8566; h=from:subject; bh=KyvzvDEn31PT0qnOSvFcZh8V7MfsKqbcd2rduG4Pom8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh+p53G9/WK1AVrUgEKA7MN6qNkH7J0vuzv8Brhpm8 oUaUmImJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfqedwAKCRAk1otyXVSH0NstB/ 9ha/7PtsimFQHzOzJSvzZQ7uXOdjSazQHRNX3u5uxTWgVScYu7TMPtPfxQ+speqsmdhSEIpx9TsgvP L3vZ9J9zfxKZeSkcfLlJxPYmzU3j6gy38Fn/vbcbcgpJ6jL7YHOD7QAyYEl0QFcsVUn6BYjvXkODYe QsN55xDyOJoMEMUkmhwsowAsPtph2tBq+NGfEnpkJpleqGe4FafxuxWZJilp9q4776NXqPsWnslVsb L+Q7JfPmJLPot1FMw3cPeNEtylksWRWQYRF563woqDmnSn1mxTu6tYtDbF60UYp5WR8S6+ryUfx8jK tC3PYKUMbZWY2UFvEKpBkAXfBXHDbr
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some coverage of event generation to mixer-test. Rather than doing a
separate set of writes designed to trigger events we add a step to the
existing write_and_verify() which checks to see if the value we read back
from non-volatile controls matches the value before writing and that an
event is or isn't generated as appropriate. The "tests" for events then
simply check that no spurious or missing events were detected. This avoids
needing further logic to generate appropriate values for each control type
and maximises coverage.

When checking for events we use a timeout of 0. This relies on the kernel
generating any event prior to returning to userspace when setting a control.
That is currently the case and it is difficult to see it changing, if it
does the test will need to be updated. Using a delay of 0 means that we
don't slow things down unduly when checking for no event or when events
fail to be generated.

We don't check behaviour for volatile controls since we can't tell what
the behaviour is supposed to be for any given control.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
---

v3:
 - Add a check for a removal event when monitoring for events, if one is
   seen then return an error.
v2:
 - Get the numid from the API rather than using the control index.

 tools/testing/selftests/alsa/mixer-test.c | 154 +++++++++++++++++++++-
 1 file changed, 151 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 0e88f4f3d802..6edb7dca32af 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -3,7 +3,7 @@
 // kselftest for the ALSA mixer API
 //
 // Original author: Mark Brown <broonie@kernel.org>
-// Copyright (c) 2021 Arm Limited
+// Copyright (c) 2021-2 Arm Limited
 
 // This test will iterate over all cards detected in the system, exercising
 // every mixer control it can find.  This may conflict with other system
@@ -27,11 +27,12 @@
 
 #include "../kselftest.h"
 
-#define TESTS_PER_CONTROL 4
+#define TESTS_PER_CONTROL 6
 
 struct card_data {
 	snd_ctl_t *handle;
 	int card;
+	struct pollfd pollfd;
 	int num_ctls;
 	snd_ctl_elem_list_t *ctls;
 	struct card_data *next;
@@ -43,6 +44,8 @@ struct ctl_data {
 	snd_ctl_elem_info_t *info;
 	snd_ctl_elem_value_t *def_val;
 	int elem;
+	int event_missing;
+	int event_spurious;
 	struct card_data *card;
 	struct ctl_data *next;
 };
@@ -149,6 +152,7 @@ void find_controls(void)
 			if (!ctl_data)
 				ksft_exit_fail_msg("Out of memory\n");
 
+			memset(ctl_data, 0, sizeof(*ctl_data));
 			ctl_data->card = card_data;
 			ctl_data->elem = ctl;
 			ctl_data->name = snd_ctl_elem_list_get_name(card_data->ctls,
@@ -184,6 +188,26 @@ void find_controls(void)
 			ctl_list = ctl_data;
 		}
 
+		/* Set up for events */
+		err = snd_ctl_subscribe_events(card_data->handle, true);
+		if (err < 0) {
+			ksft_exit_fail_msg("snd_ctl_subscribe_events() failed for card %d: %d\n",
+					   card, err);
+		}
+
+		err = snd_ctl_poll_descriptors_count(card_data->handle);
+		if (err != 1) {
+			ksft_exit_fail_msg("Unexpected desciptor count %d for card %d\n",
+					   err, card);
+		}
+
+		err = snd_ctl_poll_descriptors(card_data->handle,
+					       &card_data->pollfd, 1);
+		if (err != 1) {
+			ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
+				       card, err);
+		}
+
 	next_card:
 		if (snd_card_next(&card) < 0) {
 			ksft_print_msg("snd_card_next");
@@ -194,6 +218,79 @@ void find_controls(void)
 	snd_config_delete(config);
 }
 
+/*
+ * Block for up to timeout ms for an event, returns a negative value
+ * on error, 0 for no event and 1 for an event.
+ */
+int wait_for_event(struct ctl_data *ctl, int timeout)
+{
+	unsigned short revents;
+	snd_ctl_event_t *event;
+	int count, err;
+	unsigned int mask = 0;
+	unsigned int ev_id;
+
+	snd_ctl_event_alloca(&event);
+
+	do {
+		err = poll(&(ctl->card->pollfd), 1, timeout);
+		if (err < 0) {
+			ksft_print_msg("poll() failed for %s: %s (%d)\n",
+				       ctl->name, strerror(errno), errno);
+			return -1;
+		}
+		/* Timeout */
+		if (err == 0)
+			return 0;
+
+		err = snd_ctl_poll_descriptors_revents(ctl->card->handle,
+						       &(ctl->card->pollfd),
+						       1, &revents);
+		if (err < 0) {
+			ksft_print_msg("snd_ctl_poll_desciptors_revents() failed for %s: %d\n",
+				       ctl->name, err);
+			return err;
+		}
+		if (revents & POLLERR) {
+			ksft_print_msg("snd_ctl_poll_desciptors_revents() reported POLLERR for %s\n",
+				       ctl->name);
+			return -1;
+		}
+		/* No read events */
+		if (!(revents & POLLIN)) {
+			ksft_print_msg("No POLLIN\n");
+			continue;
+		}
+
+		err = snd_ctl_read(ctl->card->handle, event);
+		if (err < 0) {
+			ksft_print_msg("snd_ctl_read() failed for %s: %d\n",
+			       ctl->name, err);
+			return err;
+		}
+
+		if (snd_ctl_event_get_type(event) != SND_CTL_EVENT_ELEM)
+			continue;
+
+		/* The ID returned from the event is 1 less than numid */
+		mask = snd_ctl_event_elem_get_mask(event);
+		ev_id = snd_ctl_event_elem_get_numid(event);
+		if (ev_id != snd_ctl_elem_info_get_numid(ctl->info)) {
+			ksft_print_msg("Event for unexpected ctl %s\n",
+				       snd_ctl_event_elem_get_name(event));
+			continue;
+		}
+
+		if ((mask & SND_CTL_EVENT_MASK_REMOVE) == SND_CTL_EVENT_MASK_REMOVE) {
+			ksft_print_msg("Removal event for %s\n",
+				       ctl->name);
+			return -1;
+		}
+	} while ((mask & SND_CTL_EVENT_MASK_VALUE) != SND_CTL_EVENT_MASK_VALUE);
+
+	return 1;
+}
+
 bool ctl_value_index_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val,
 			   int index)
 {
@@ -428,7 +525,8 @@ int write_and_verify(struct ctl_data *ctl,
 {
 	int err, i;
 	bool error_expected, mismatch_shown;
-	snd_ctl_elem_value_t *read_val, *w_val;
+	snd_ctl_elem_value_t *initial_val, *read_val, *w_val;
+	snd_ctl_elem_value_alloca(&initial_val);
 	snd_ctl_elem_value_alloca(&read_val);
 	snd_ctl_elem_value_alloca(&w_val);
 
@@ -446,6 +544,18 @@ int write_and_verify(struct ctl_data *ctl,
 		snd_ctl_elem_value_copy(expected_val, write_val);
 	}
 
+	/* Store the value before we write */
+	if (snd_ctl_elem_info_is_readable(ctl->info)) {
+		snd_ctl_elem_value_set_id(initial_val, ctl->id);
+
+		err = snd_ctl_elem_read(ctl->card->handle, initial_val);
+		if (err < 0) {
+			ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+				       snd_strerror(err));
+			return err;
+		}
+	}
+
 	/*
 	 * Do the write, if we have an expected value ignore the error
 	 * and carry on to validate the expected value.
@@ -470,6 +580,30 @@ int write_and_verify(struct ctl_data *ctl,
 		return err;
 	}
 
+	/*
+	 * Check for an event if the value changed, or confirm that
+	 * there was none if it didn't.  We rely on the kernel
+	 * generating the notification before it returns from the
+	 * write, this is currently true, should that ever change this
+	 * will most likely break and need updating.
+	 */
+	if (!snd_ctl_elem_info_is_volatile(ctl->info)) {
+		err = wait_for_event(ctl, 0);
+		if (snd_ctl_elem_value_compare(initial_val, read_val)) {
+			if (err < 1) {
+				ksft_print_msg("No event generated for %s\n",
+					       ctl->name);
+				ctl->event_missing++;
+			}
+		} else {
+			if (err != 0) {
+				ksft_print_msg("Spurious event generated for %s\n",
+					       ctl->name);
+				ctl->event_spurious++;
+			}
+		}
+	}
+
 	/*
 	 * Use the libray to compare values, if there's a mismatch
 	 * carry on and try to provide a more useful diagnostic than
@@ -898,6 +1032,18 @@ void test_ctl_write_invalid(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
+void test_ctl_event_missing(struct ctl_data *ctl)
+{
+	ksft_test_result(!ctl->event_missing, "event_missing.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
+void test_ctl_event_spurious(struct ctl_data *ctl)
+{
+	ksft_test_result(!ctl->event_spurious, "event_spurious.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
 int main(void)
 {
 	struct ctl_data *ctl;
@@ -917,6 +1063,8 @@ int main(void)
 		test_ctl_write_default(ctl);
 		test_ctl_write_valid(ctl);
 		test_ctl_write_invalid(ctl);
+		test_ctl_event_missing(ctl);
+		test_ctl_event_spurious(ctl);
 	}
 
 	ksft_exit_pass();
-- 
2.30.2

