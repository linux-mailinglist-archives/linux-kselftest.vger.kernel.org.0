Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A683A467E42
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 20:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382887AbhLCThE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Dec 2021 14:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343888AbhLCThE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Dec 2021 14:37:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65149C061751
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 11:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA02B62CC1
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Dec 2021 19:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8580AC53FAD;
        Fri,  3 Dec 2021 19:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638560019;
        bh=Wy6Trwq8yEAPzhbaVMT729UBBAEpNkJ7PzfcfU1nGME=;
        h=From:To:Cc:Subject:Date:From;
        b=ZhZLRh3zwlqxfx0URT8RjQm+a141KIrsB6i6D4YR0xOFcZiiUlO8Xcmo/E/XNaHhQ
         qrxsJN8ZCuynlohXvWGVTrGKkAIKKJevErwOkeYhwN0uxClro7Rjrrd1rFqKqtnG9U
         TqvmpCDIdKxEHU2TVAM59sXkNGy2o/RhINqEtC/BqVMUlxLHXfcSN4tDKP1WNhgh/q
         rDqDHh8YiRdwRrbflug8b6H0INl8XFTP18QIcp5nmmahfHZmos6/MwMijBfJoNwb7Z
         NXRUQj3NUlawoDj2O7ip18UPMerja/2VfprvF+bvDYigOozcOhsmMhbMm6V0REBiij
         mUcB0Xpf02DaA==
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest: alsa: Add simplistic test for ALSA mixer controls kselftest
Date:   Fri,  3 Dec 2021 19:33:11 +0000
Message-Id: <20211203193311.211400-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=20439; h=from:subject; bh=Wy6Trwq8yEAPzhbaVMT729UBBAEpNkJ7PzfcfU1nGME=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhqnDkNpa9F2ooNy653nVazj1rVm6rVWaw654121cd xQoHZ0uJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYapw5AAKCRAk1otyXVSH0DRMB/ wK4rw6+NrwmnGsjO559Dg6zxi4mywikcz7geUB79Ac6w1cQMMoFMZ6LM5EZv5OkwCFCL3Nb0ilGCuv /ofuATZCNEd7sFdYUMUiIPzKm0QdpEfLYLZi9v1NNQHC4e6uD9hXrKWAIOurrqwCHeGrVNgfQj5J+2 pXw5A8v/qN9R47V/YO2wljNorzOQ5jmfeA0O+/ryEOOS5huPm+RZ8y74bS/+UHTaintV1YSfkPACTe OZCGP1qq3Cp0HQjlm/lfvLCpE3REt4MLPFXShsll0+PRoTbDdt85Y+wgGdBFN/9L1+ybMLOIIwKI85 Vmb1A8i+lezt5hp1bktxsoiDMxOpI/
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a basic test for the mixer control interface. For every control on
every sound card in the system it checks that it can read and write the
default value where the control supports that and for writeable controls
attempts to write all valid values, restoring the default values after
each test to minimise disruption for users.

There are quite a few areas for improvement - currently no coverage of the
generation of notifications, several of the control types don't have any
coverage for the values and we don't have any testing of error handling
when we attempt to write out of range values - but this provides some basic
coverage.

This is added as a kselftest since unlike other ALSA test programs it does
not require either physical setup of the device or interactive monitoring
by users and kselftest is one of the test suites that is frequently run by
people doing general automated testing so should increase coverage. It is
written in terms of alsa-lib since tinyalsa is not generally packaged for
distributions which makes things harder for general users interested in
kselftest as a whole but it will be a barrier to people with Android.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS                               |   7 +
 tools/testing/selftests/Makefile          |   3 +-
 tools/testing/selftests/alsa/.gitignore   |   1 +
 tools/testing/selftests/alsa/Makefile     |   8 +
 tools/testing/selftests/alsa/mixer-test.c | 616 ++++++++++++++++++++++
 5 files changed, 634 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/alsa/.gitignore
 create mode 100644 tools/testing/selftests/alsa/Makefile
 create mode 100644 tools/testing/selftests/alsa/mixer-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5b1e79f8e3d8..92deb9a83b8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17934,6 +17934,7 @@ F:	Documentation/sound/
 F:	include/sound/
 F:	include/uapi/sound/
 F:	sound/
+F:	tools/testing/selftests/alsa
 
 SOUND - COMPRESSED AUDIO
 M:	Vinod Koul <vkoul@kernel.org>
@@ -17953,6 +17954,12 @@ F:	include/sound/dmaengine_pcm.h
 F:	sound/core/pcm_dmaengine.c
 F:	sound/soc/soc-generic-dmaengine-pcm.c
 
+SOUND - ALSA SELFTESTS
+M:	Mark Brown <broonie@kernel.org>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	tools/testing/selftests/alsa
+
 SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEMENT (ASoC)
 M:	Liam Girdwood <lgirdwood@gmail.com>
 M:	Mark Brown <broonie@kernel.org>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c852eb40c4f7..d08fe4cfe811 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-TARGETS = arm64
+TARGETS += alsa
+TARGETS += arm64
 TARGETS += bpf
 TARGETS += breakpoints
 TARGETS += capabilities
diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
new file mode 100644
index 000000000000..3bb7c41266a8
--- /dev/null
+++ b/tools/testing/selftests/alsa/.gitignore
@@ -0,0 +1 @@
+mixer-test
diff --git a/tools/testing/selftests/alsa/Makefile b/tools/testing/selftests/alsa/Makefile
new file mode 100644
index 000000000000..e62f227ce02c
--- /dev/null
+++ b/tools/testing/selftests/alsa/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+
+LDLIBS += -lasound
+
+TEST_GEN_PROGS := mixer-test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
new file mode 100644
index 000000000000..6082efa0b426
--- /dev/null
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// kselftest for the ALSA mixer API
+//
+// Original author: Mark Brown <broonie@kernel.org>
+// Copyright (c) 2021 Arm Limited
+
+// This test will iterate over all cards detected in the system, exercising
+// every mixer control it can find.  This may conflict with other system
+// software if there is audio activity so is best run on a system with a
+// minimal active userspace.
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <getopt.h>
+#include <stdarg.h>
+#include <ctype.h>
+#include <math.h>
+#include <errno.h>
+#include <assert.h>
+#include <alsa/asoundlib.h>
+#include <poll.h>
+#include <stdint.h>
+
+#include "../kselftest.h"
+
+#define TESTS_PER_CONTROL 3
+
+struct card_data {
+	snd_ctl_t *handle;
+	int card;
+	int num_ctls;
+	snd_ctl_elem_list_t *ctls;
+	struct card_data *next;
+};
+
+struct ctl_data {
+	const char *name;
+	snd_ctl_elem_id_t *id;
+	snd_ctl_elem_info_t *info;
+	snd_ctl_elem_value_t *def_val;
+	int elem;
+	struct card_data *card;
+	struct ctl_data *next;
+};
+
+int num_cards = 0;
+int num_controls = 0;
+struct card_data *card_list = NULL;
+struct ctl_data *ctl_list = NULL;
+
+void find_controls(void)
+{
+	char name[32];
+	int card, ctl, err;
+	struct card_data *card_data;
+	struct ctl_data *ctl_data;
+
+	card = -1;
+	if (snd_card_next(&card) < 0 || card < 0)
+		return;
+
+	while (card >= 0) {
+		sprintf(name, "hw:%d", card);
+
+		card_data = malloc(sizeof(*card_data));
+		if (!card_data) {
+			ksft_print_msg("Out of memory\n");
+			ksft_exit_fail();
+		}
+
+		err = snd_ctl_open(&card_data->handle, name, 0);
+		if (err < 0) {
+			ksft_print_msg("Failed to get hctl for card %d: %s\n",
+				       card, snd_strerror(err));
+			goto next_card;
+		}
+
+		/* Count controls */
+		snd_ctl_elem_list_malloc(&card_data->ctls);
+		snd_ctl_elem_list(card_data->handle, card_data->ctls);
+		card_data->num_ctls = snd_ctl_elem_list_get_count(card_data->ctls);
+
+		/* Enumerate control information */
+		snd_ctl_elem_list_alloc_space(card_data->ctls, card_data->num_ctls);
+		snd_ctl_elem_list(card_data->handle, card_data->ctls);
+
+		card_data->card = num_cards++;
+		card_data->next = card_list;
+		card_list = card_data;
+
+		num_controls += card_data->num_ctls;
+
+		for (ctl = 0; ctl < card_data->num_ctls; ctl++) {
+			ctl_data = malloc(sizeof(*ctl_data));
+			if (!ctl_data) {
+				ksft_print_msg("Out of memory\n");
+				ksft_exit_fail();
+			}
+
+			ctl_data->card = card_data;
+			ctl_data->elem = ctl;
+			ctl_data->name = snd_ctl_elem_list_get_name(card_data->ctls,
+								    ctl);
+
+			err = snd_ctl_elem_id_malloc(&ctl_data->id);
+			if (err < 0) {
+				ksft_print_msg("Out of memory\n");
+				ksft_exit_fail();
+			}
+
+			err = snd_ctl_elem_info_malloc(&ctl_data->info);
+			if (err < 0) {
+				ksft_print_msg("Out of memory\n");
+				ksft_exit_fail();
+			}
+
+			err = snd_ctl_elem_value_malloc(&ctl_data->def_val);
+			if (err < 0) {
+				ksft_print_msg("Out of memory\n");
+				ksft_exit_fail();
+			}
+
+			snd_ctl_elem_list_get_id(card_data->ctls, ctl,
+						 ctl_data->id);
+			snd_ctl_elem_info_set_id(ctl_data->info, ctl_data->id);
+			err = snd_ctl_elem_info(card_data->handle,
+						ctl_data->info);
+			if (err < 0) {
+				ksft_print_msg("%s getting info for %d\n",
+					       snd_strerror(err),
+					       ctl_data->name);
+			}
+
+			snd_ctl_elem_value_set_id(ctl_data->def_val,
+						  ctl_data->id);
+
+			ctl_data->next = ctl_list;
+			ctl_list = ctl_data;
+		}
+
+	next_card:
+		if (snd_card_next(&card) < 0) {
+			ksft_print_msg("snd_card_next");
+			break;
+		}
+	}
+}
+
+/*
+ * Check that we can read the default value and it is valid. Write
+ * tests use the read value to restore the default.
+ */
+void test_ctl_get_value(struct ctl_data *ctl)
+{
+	int err;
+	long int_val;
+	long long int64_val;
+
+	/* If the control is turned off let's be polite */
+	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
+		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_test_result_skip("get_value.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	/* Can't test reading on an unreadable control */
+	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
+		ksft_print_msg("%s is not readable\n", ctl->name);
+		ksft_test_result_skip("get_value.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	err = snd_ctl_elem_read(ctl->card->handle, ctl->def_val);
+	if (err < 0) {
+		ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+			       snd_strerror(err));
+		goto out;
+	}
+
+	switch (snd_ctl_elem_info_get_type(ctl->info)) {
+	case SND_CTL_ELEM_TYPE_NONE:
+		ksft_print_msg("%s Invalid control type NONE\n", ctl->name);
+		err = -1;
+		break;
+
+	case SND_CTL_ELEM_TYPE_BOOLEAN:
+		int_val = snd_ctl_elem_value_get_boolean(ctl->def_val, 0);
+		switch (int_val) {
+		case 0:
+		case 1:
+			break;
+		default:
+			ksft_print_msg("%s Invalid boolean value %ld\n",
+				       ctl->name, int_val);
+			err = -1;
+			break;
+		}
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER:
+		int_val = snd_ctl_elem_value_get_integer(ctl->def_val, 0);
+
+		if (int_val < snd_ctl_elem_info_get_min(ctl->info)) {
+			ksft_print_msg("%s value %ld less than minimum %ld\n",
+				       ctl->name, int_val,
+				       snd_ctl_elem_info_get_min(ctl->info));
+			err = -1;
+		}
+
+		if (int_val > snd_ctl_elem_info_get_max(ctl->info)) {
+			ksft_print_msg("%s value %ld more than maximum %ld\n",
+				       ctl->name, int_val,
+				       snd_ctl_elem_info_get_max(ctl->info));
+			err = -1;
+		}
+
+		/* Only check step size if there is one and we're in bounds */
+		if (err >= 0 && snd_ctl_elem_info_get_step(ctl->info) &&
+		    (int_val - snd_ctl_elem_info_get_min(ctl->info) %
+		     snd_ctl_elem_info_get_step(ctl->info))) {
+			ksft_print_msg("%s value %ld invalid for step %ld minimum %ld\n",
+				       ctl->name, int_val,
+				       snd_ctl_elem_info_get_step(ctl->info),
+				       snd_ctl_elem_info_get_min(ctl->info));
+			err = -1;
+		}
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER64:
+		int64_val = snd_ctl_elem_value_get_integer64(ctl->def_val, 0);
+
+		if (int64_val < snd_ctl_elem_info_get_min64(ctl->info)) {
+			ksft_print_msg("%s value %lld less than minimum %lld\n",
+				       ctl->name, int64_val,
+				       snd_ctl_elem_info_get_min64(ctl->info));
+			err = -1;
+		}
+
+		if (int64_val > snd_ctl_elem_info_get_max64(ctl->info)) {
+			ksft_print_msg("%s value %lld more than maximum %lld\n",
+				       ctl->name, int64_val,
+				       snd_ctl_elem_info_get_max(ctl->info));
+			err = -1;
+		}
+
+		/* Only check step size if there is one and we're in bounds */
+		if (err >= 0 && snd_ctl_elem_info_get_step64(ctl->info) &&
+		    (int64_val - snd_ctl_elem_info_get_min64(ctl->info)) %
+		    snd_ctl_elem_info_get_step64(ctl->info)) {
+			ksft_print_msg("%s value %lld invalid for step %lld minimum %lld\n",
+				       ctl->name, int64_val,
+				       snd_ctl_elem_info_get_step64(ctl->info),
+				       snd_ctl_elem_info_get_min64(ctl->info));
+			err = -1;
+		}
+		break;
+
+	default:
+		/* No tests for other types */
+		ksft_test_result_skip("get_value.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+out:
+	ksft_test_result(err >= 0, "get_value.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
+bool show_mismatch(struct ctl_data *ctl, int index,
+		   snd_ctl_elem_value_t *read_val,
+		   snd_ctl_elem_value_t *expected_val)
+{
+	long long expected_int, read_int;
+
+	/*
+	 * We factor out the code to compare values representable as
+	 * integers, ensure that check doesn't log otherwise.
+	 */
+	expected_int = 0;
+	read_int = 0;
+
+	switch (snd_ctl_elem_info_get_type(ctl->info)) {
+	case SND_CTL_ELEM_TYPE_BOOLEAN:
+		expected_int = snd_ctl_elem_value_get_boolean(expected_val,
+							      index);
+		read_int = snd_ctl_elem_value_get_boolean(read_val, index);
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER:
+		expected_int = snd_ctl_elem_value_get_integer(expected_val,
+							      index);
+		read_int = snd_ctl_elem_value_get_integer(read_val, index);
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER64:
+		expected_int = snd_ctl_elem_value_get_integer64(expected_val,
+								index);
+		read_int = snd_ctl_elem_value_get_integer64(read_val,
+							    index);
+		break;
+
+	case SND_CTL_ELEM_TYPE_ENUMERATED:
+		expected_int = snd_ctl_elem_value_get_enumerated(expected_val,
+								 index);
+		read_int = snd_ctl_elem_value_get_enumerated(read_val,
+							     index);
+		break;
+
+	default:
+		break;
+	}
+
+	if (expected_int != read_int) {
+		ksft_print_msg("%s.%d expected %lld but read %lld\n",
+			       ctl->name, index, expected_int, read_int);
+		return true;
+	} else {
+		return false;
+	}
+}
+
+/*
+ * Write a value then if possible verify that we get the expected
+ * result.  An optional expected value can be provided if we expect
+ * the write to fail, for verifying that invalid writes don't corrupt
+ * anything.
+ */
+int write_and_verify(struct ctl_data *ctl,
+		     snd_ctl_elem_value_t *write_val,
+		     snd_ctl_elem_value_t *expected_val)
+{
+	int err, i;
+	bool error_expected, mismatch_shown;
+	snd_ctl_elem_value_t *read_val, *w_val;
+	snd_ctl_elem_value_alloca(&read_val);
+	snd_ctl_elem_value_alloca(&w_val);
+
+	/*
+	 * We need to copy the write value since writing can modify
+	 * the value which causes surprises, and allocate an expected
+	 * value if we expect to read back what we wrote.
+	 */
+	snd_ctl_elem_value_copy(w_val, write_val);
+	if (expected_val) {
+		error_expected = true;
+	} else {
+		error_expected = false;
+		snd_ctl_elem_value_alloca(&expected_val);
+		snd_ctl_elem_value_copy(expected_val, write_val);
+	}
+
+	/*
+	 * Do the write, if we have an expected value ignore the error
+	 * and carry on to validate the expected value.
+	 */
+	err = snd_ctl_elem_write(ctl->card->handle, w_val);
+	if (err < 0 && !error_expected) {
+		ksft_print_msg("snd_ctl_elem_write() failed: %s\n",
+			       snd_strerror(err));
+		return err;
+	}
+
+	/* Can we do the verification part? */
+	if (!snd_ctl_elem_info_is_readable(ctl->info))
+		return err;
+
+	snd_ctl_elem_value_set_id(read_val, ctl->id);
+
+	err = snd_ctl_elem_read(ctl->card->handle, read_val);
+	if (err < 0) {
+		ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+			       snd_strerror(err));
+		return err;
+	}
+
+	/*
+	 * Use the libray to compare values, if there's a mismatch
+	 * carry on and try to provide a more useful diagnostic than
+	 * just "mismatch".
+	 */
+	if (!snd_ctl_elem_value_compare(expected_val, read_val))
+		return 0;
+
+	mismatch_shown = false;
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++)
+		if (show_mismatch(ctl, i, read_val, expected_val))
+			mismatch_shown = true;
+
+	if (!mismatch_shown)
+		ksft_print_msg("%s read and written values differ\n",
+			       ctl->name);
+
+	return -1;
+}
+
+/*
+ * Make sure we can write the default value back to the control, this
+ * should validate that at least some write works.
+ */
+void test_ctl_write_default(struct ctl_data *ctl)
+{
+	int err;
+
+	/* If the control is turned off let's be polite */
+	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
+		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_test_result_skip("write_default.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
+		ksft_print_msg("%s is not writeable\n", ctl->name);
+		ksft_test_result_skip("write_default.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	/* No idea what the default was for unreadable controls */
+	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
+		ksft_print_msg("%s couldn't read default\n", ctl->name);
+		ksft_test_result_skip("write_default.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	err = write_and_verify(ctl, ctl->def_val, NULL);
+
+	ksft_test_result(err >= 0, "write_default.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
+bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
+{
+	int err, i, j;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	snd_ctl_elem_value_set_id(val, ctl->id);
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		for (j = 0; j < 2; j++) {
+			snd_ctl_elem_value_set_boolean(val, i, j);
+			err = write_and_verify(ctl, val, NULL);
+			if (err != 0)
+				fail = true;
+		}
+	}
+
+	return !fail;
+}
+
+bool test_ctl_write_valid_integer(struct ctl_data *ctl)
+{
+	int err;
+	int i;
+	long j, step;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	snd_ctl_elem_value_set_id(val, ctl->id);
+
+	step = snd_ctl_elem_info_get_step(ctl->info);
+	if (!step)
+		step = 1;
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		for (j = snd_ctl_elem_info_get_min(ctl->info);
+		     j <= snd_ctl_elem_info_get_max(ctl->info); j += step) {
+
+			snd_ctl_elem_value_set_integer(val, i, j);
+			err = write_and_verify(ctl, val, NULL);
+			if (err != 0)
+				fail = true;
+		}
+	}
+
+
+	return !fail;
+}
+
+bool test_ctl_write_valid_integer64(struct ctl_data *ctl)
+{
+	int err, i;
+	long long j, step;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	snd_ctl_elem_value_set_id(val, ctl->id);
+
+	step = snd_ctl_elem_info_get_step64(ctl->info);
+	if (!step)
+		step = 1;
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		for (j = snd_ctl_elem_info_get_min64(ctl->info);
+		     j <= snd_ctl_elem_info_get_max64(ctl->info); j += step) {
+
+			snd_ctl_elem_value_set_integer64(val, i, j);
+			err = write_and_verify(ctl, val, NULL);
+			if (err != 0)
+				fail = true;
+		}
+	}
+
+
+	return !fail;
+}
+
+bool test_ctl_write_valid_enumerated(struct ctl_data *ctl)
+{
+	int err, i, j;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	snd_ctl_elem_value_set_id(val, ctl->id);
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		for (j = 0; j < snd_ctl_elem_info_get_items(ctl->info); j++) {
+			snd_ctl_elem_value_set_enumerated(val, i, j);
+			err = write_and_verify(ctl, val, NULL);
+			if (err != 0)
+				fail = true;
+		}
+	}
+
+	return !fail;
+}
+
+void test_ctl_write_valid(struct ctl_data *ctl)
+{
+	bool pass;
+	int err;
+
+	/* If the control is turned off let's be polite */
+	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
+		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_test_result_skip("write_valid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
+		ksft_print_msg("%s is not writeable\n", ctl->name);
+		ksft_test_result_skip("write_valid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	switch (snd_ctl_elem_info_get_type(ctl->info)) {
+	case SND_CTL_ELEM_TYPE_BOOLEAN:
+		pass = test_ctl_write_valid_boolean(ctl);
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER:
+		pass = test_ctl_write_valid_integer(ctl);
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER64:
+		pass = test_ctl_write_valid_integer64(ctl);
+		break;
+
+	case SND_CTL_ELEM_TYPE_ENUMERATED:
+		pass = test_ctl_write_valid_enumerated(ctl);
+		break;
+
+	default:
+		/* No tests for this yet */
+		ksft_test_result_skip("write_valid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	/* Restore the default value to minimise disruption */
+	err = write_and_verify(ctl, ctl->def_val, NULL);
+	if (err < 0)
+		pass = false;
+
+	ksft_test_result(pass, "write_valid.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
+int main(void)
+{
+	struct ctl_data *ctl;
+
+	ksft_print_header();
+
+	find_controls();
+
+	ksft_set_plan(num_controls * TESTS_PER_CONTROL);
+
+	for (ctl = ctl_list; ctl != NULL; ctl = ctl->next) {
+		/* 
+		 * Must test get_value() before we write anything, the
+		 * test stores the default value for later cleanup.
+		 */
+		test_ctl_get_value(ctl);
+		test_ctl_write_default(ctl);
+		test_ctl_write_valid(ctl);
+	}
+
+	ksft_exit_pass();
+
+	return 0;
+}
-- 
2.30.2

