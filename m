Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D6049B8B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 17:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiAYQdA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Jan 2022 11:33:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51500 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354505AbiAYQ2g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Jan 2022 11:28:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD2A9B81742
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 16:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6314C340E6;
        Tue, 25 Jan 2022 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643128113;
        bh=qqGMcYD15tOZUPxYPYVlBPdHrM8w4yH5kXBYa9U5Rr0=;
        h=From:To:Cc:Subject:Date:From;
        b=eWrEwxN+lMv6kUR/NAt+msNotqhthwRq+KX2DJszaTLrxS0ky0Q8JdF853wVXyIH3
         j4r/Imqy9UrKp+1u9R11ClXTnqH+ihVkFU6FXilO4xQwZyeSvWzjmvj/RgKrtMF9cu
         x+vge9U2a/7GKk89y+ALIOuizleONcdToQxm0oXfKtPcWFlh+E7SStvSbkH6PDQLC5
         owa44HvpSVzg2mH7YMnBO3anwqaYcJS+y9+HjN3qGaSnD8i6TP8NqbzywJTOX4AZYs
         0xkjF1jzkJ/pUlDpF04xA3TpK5/Te95o/DrCutIWvQ4ja9cCQfAeeSYvXHdKiDnNBr
         qS9StThrqBFfw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] kselftest: alsa: Add test case for writing invalid values
Date:   Tue, 25 Jan 2022 16:28:24 +0000
Message-Id: <20220125162824.3816659-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7599; h=from:subject; bh=qqGMcYD15tOZUPxYPYVlBPdHrM8w4yH5kXBYa9U5Rr0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8CS02EHLhbrO005cM9UxiRd6EIRKIOGphtN9/4cA zMeTfEiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfAktAAKCRAk1otyXVSH0C58CA CFQh7lxci5KvmQ7HvNlzVRC04KS/lnmZ5YFfkS0x+nh83i8G6Z0FH1XAL00FtDKcWT7xj2HCb4lmgq E5PsJvXZr6SHlcBlFBKZhyI+GbMh1uNrbTZU/1JAHDqhmC6nQZdq1WYLugutolcmhVzfKxJq6jiqQQ LKEbr17sV7H5H+ummuL4+RUv7ZepjNLOSmmJCg5oJD36TWY17Rdd34nG3b69vM5pHXulOsN0bTYZbh pXyn8/zLpN2ZLxzxrYuO7/XCwsvbqey4z8rBjnWbm+MEzyVwRBlvoYoHWe94VOavpR3NNJFg/1BRNh F8V7ptFwDB9ManjH0XLJU2D6BZesvj
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

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---

v2:
 - Fix a couple of _integer()/_integer64() confusions.

 tools/testing/selftests/alsa/mixer-test.c | 222 +++++++++++++++++++++-
 1 file changed, 221 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 17f158d7a767..0e88f4f3d802 100644
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
+			snd_ctl_elem_value_set_integer64(val, i, LLONG_MIN);
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
+			snd_ctl_elem_value_set_integer64(val, i, LLONG_MAX);
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

