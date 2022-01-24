Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479D0498352
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 16:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiAXPO3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 10:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240656AbiAXPO2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 10:14:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A84C06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 07:14:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D7CCCE11A0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 15:14:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8EDC340E5;
        Mon, 24 Jan 2022 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643037264;
        bh=gSh+ppXT8OgdNzTtGtJNoVLqbm1WPjb1DsXzaMFqlZw=;
        h=From:To:Cc:Subject:Date:From;
        b=inWT6lgAZyJS9lALzbl+/q/bvDVOnE2xiSkLTTl9+3jr3gqPbpxAcYwG/fyBdFnjK
         oO9Z6HJHgsRPuSUUdLw74uD+SKcN7PvxHC9qpt35Dt1POwaqljLZjEo97heRDd27Zq
         uCVnRAyWQn9dYViqqnO6crC4lFw4dtzGEUs7a6TF1lpSAnmwN3EOWpt9xfn+fRhcTL
         s+xtXqu78dKJ7lj6YmFLzUm1EOltnbeD8N3FIvj+X0xX2FaI8bkDFd+EgA0B1orDpI
         ng45K6dwuaGhMCfZBvkQIC0aa6Ret0G6ckpnP1PWqyyK6Pd/32WzRZYO8BnLJ72Vy/
         6HE9AXYTXVnBA==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest: alsa: Add test case for writing invalid values
Date:   Mon, 24 Jan 2022 15:14:10 +0000
Message-Id: <20220124151410.2715572-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7477; h=from:subject; bh=gSh+ppXT8OgdNzTtGtJNoVLqbm1WPjb1DsXzaMFqlZw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7sFpEatmip+S1fQ8LqsKlXS2EQvqhJsFjQWEOWUX lQtYjaKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7BaQAKCRAk1otyXVSH0JqVB/ wNK2h30z3VFIOmb+niZMJQNoMkRrufjNmFilOaunfc3iOkLEfG3M2F/F5F2iVznwHzZ4L/C5etMoPK VgjxIMPPgSHCaTgL+UbO71cNS7FL6qBc71ELZI74lDX/3gxsMaUXBvT/1pDb5ws2hycRc8OybS0OmB fpGngFuhKosV1WGSO828U+KpZrHiM/ui5kXonpxTtLGEwTHSj8zRgRXPeRtQ/6jStmsxSLzx28L/ni v59+xmCOOZ86l9K9FZsctpwisFt8mgvqJzVCPerYxVEN2I2gnMALe6IZJgYzgFUhAR777yMaBLWoWB D64WOGDfTAwqNJqONPlNjWlBi74fHT
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Attempt to write various invalid values for control types we know about and
check that something sensible happens. The ABI isn't quite as clearly
defined as one might like, rather than generating an error when an invalid
value is written many devices will silently rewrite the value into one that
is valid for the control. The exact value chosen is not predictable so in
the case the write succeeds we just check that the value we read back is
one that is valid for the control.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 222 +++++++++++++++++++++-
 1 file changed, 221 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 17f158d7a767..15e05b241468 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdbool.h>
+#include <limits.h>
 #include <string.h>
 #include <getopt.h>
 #include <stdarg.h>
@@ -26,7 +27,7 @@
 
 #include "../kselftest.h"
 
-#define TESTS_PER_CONTROL 3
+#define TESTS_PER_CONTROL 4
 
 struct card_data {
 	snd_ctl_t *handle;
@@ -679,6 +680,224 @@ void test_ctl_write_valid(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
+bool test_ctl_write_invalid_value(struct ctl_data *ctl,
+				  snd_ctl_elem_value_t *val)
+{
+	int err;
+	long val_read;
+
+	/* Ideally this will fail... */
+	err = snd_ctl_elem_write(ctl->card->handle, val);
+	if (err < 0)
+		return false;
+
+	/* ...but some devices will clamp to an in range value */
+	err = snd_ctl_elem_read(ctl->card->handle, val);
+	if (err < 0) {
+		ksft_print_msg("%s failed to read: %s\n",
+			       ctl->name, snd_strerror(err));
+		return true;
+	}
+
+	return !ctl_value_valid(ctl, val);
+}
+
+bool test_ctl_write_invalid_boolean(struct ctl_data *ctl)
+{
+	int err, i;
+	long val_read;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		snd_ctl_elem_value_copy(val, ctl->def_val);
+		snd_ctl_elem_value_set_boolean(val, i, 2);
+
+		if (test_ctl_write_invalid_value(ctl, val))
+			fail = true;
+	}
+
+	return !fail;
+}
+
+bool test_ctl_write_invalid_integer(struct ctl_data *ctl)
+{
+	int i;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		if (snd_ctl_elem_info_get_min(ctl->info) != LONG_MIN) {
+			/* Just under range */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer(val, i,
+			       snd_ctl_elem_info_get_min(ctl->info) - 1);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+
+			/* Minimum representable value */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer(val, i, LONG_MIN);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+		}
+
+		if (snd_ctl_elem_info_get_max(ctl->info) != LONG_MAX) {
+			/* Just over range */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer(val, i,
+			       snd_ctl_elem_info_get_max(ctl->info) + 1);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+
+			/* Maximum representable value */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer(val, i, LONG_MAX);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+		}
+	}
+
+	return !fail;
+}
+
+bool test_ctl_write_invalid_integer64(struct ctl_data *ctl)
+{
+	int i;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		if (snd_ctl_elem_info_get_min64(ctl->info) != LLONG_MIN) {
+			/* Just under range */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer64(val, i,
+				snd_ctl_elem_info_get_min64(ctl->info) - 1);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+
+			/* Minimum representable value */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer(val, i, LLONG_MIN);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+		}
+
+		if (snd_ctl_elem_info_get_max64(ctl->info) != LLONG_MAX) {
+			/* Just over range */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer64(val, i,
+				snd_ctl_elem_info_get_max64(ctl->info) + 1);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+
+			/* Maximum representable value */
+			snd_ctl_elem_value_copy(val, ctl->def_val);
+			snd_ctl_elem_value_set_integer(val, i, LLONG_MAX);
+
+			if (test_ctl_write_invalid_value(ctl, val))
+				fail = true;
+		}
+	}
+
+	return !fail;
+}
+
+bool test_ctl_write_invalid_enumerated(struct ctl_data *ctl)
+{
+	int err, i;
+	unsigned int val_read;
+	bool fail = false;
+	snd_ctl_elem_value_t *val;
+	snd_ctl_elem_value_alloca(&val);
+
+	snd_ctl_elem_value_set_id(val, ctl->id);
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		/* One beyond maximum */
+		snd_ctl_elem_value_copy(val, ctl->def_val);
+		snd_ctl_elem_value_set_enumerated(val, i,
+				  snd_ctl_elem_info_get_items(ctl->info));
+
+		if (test_ctl_write_invalid_value(ctl, val))
+			fail = true;
+
+		/* Maximum representable value */
+		snd_ctl_elem_value_copy(val, ctl->def_val);
+		snd_ctl_elem_value_set_enumerated(val, i, UINT_MAX);
+
+		if (test_ctl_write_invalid_value(ctl, val))
+			fail = true;
+
+	}
+
+	return !fail;
+}
+
+
+void test_ctl_write_invalid(struct ctl_data *ctl)
+{
+	bool pass;
+	int err;
+
+	/* If the control is turned off let's be polite */
+	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
+		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_test_result_skip("write_invalid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
+		ksft_print_msg("%s is not writeable\n", ctl->name);
+		ksft_test_result_skip("write_invalid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	switch (snd_ctl_elem_info_get_type(ctl->info)) {
+	case SND_CTL_ELEM_TYPE_BOOLEAN:
+		pass = test_ctl_write_invalid_boolean(ctl);
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER:
+		pass = test_ctl_write_invalid_integer(ctl);
+		break;
+
+	case SND_CTL_ELEM_TYPE_INTEGER64:
+		pass = test_ctl_write_invalid_integer64(ctl);
+		break;
+
+	case SND_CTL_ELEM_TYPE_ENUMERATED:
+		pass = test_ctl_write_invalid_enumerated(ctl);
+		break;
+
+	default:
+		/* No tests for this yet */
+		ksft_test_result_skip("write_invalid.%d.%d\n",
+				      ctl->card->card, ctl->elem);
+		return;
+	}
+
+	/* Restore the default value to minimise disruption */
+	err = write_and_verify(ctl, ctl->def_val, NULL);
+	if (err < 0)
+		pass = false;
+
+	ksft_test_result(pass, "write_invalid.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
 int main(void)
 {
 	struct ctl_data *ctl;
@@ -697,6 +916,7 @@ int main(void)
 		test_ctl_get_value(ctl);
 		test_ctl_write_default(ctl);
 		test_ctl_write_valid(ctl);
+		test_ctl_write_invalid(ctl);
 	}
 
 	ksft_exit_pass();
-- 
2.30.2

