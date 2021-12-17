Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26118478BF5
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 14:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhLQNC7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Dec 2021 08:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhLQNC7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Dec 2021 08:02:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB10C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 05:02:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3026215A
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Dec 2021 13:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1403BC36AEA;
        Fri, 17 Dec 2021 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639746178;
        bh=p0EUVadnjEh+VEL3Df8aeJ2FHtPzcNPsATIRNxkT7xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K9oOVkOCIPvAczOM/dV0jwQ1pRgLzB4qvdy9gxQ3XPbRR/uF/6OhjPzO5cq2k9t8T
         0pDFeSI+q4KsmGrySqUqZ1Qd4xV4MwbQ7ouorQQmpJk6EUV1dhZqeULHELEPJG/U7c
         5T9pDVByrn6DIedqyjIUZb2YFvq7gXWwOOcLBZ9YMTZ1QWEUKU0G+P26ttXkvT3nyl
         WXQSuCqbU+z5PaUaSdDwx3wtIOwn7yf9FwovE+ltKXRMLTEgGfK6lN6ybR5cYKsYFH
         SYAPYctv0HxdnoT6iHGJyxY11g4e6qf40sC+P4uvaiOGbFQqvyULdGD6NLldH7mJdx
         T+mJ1EUDUA0+g==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] kselftest: alsa: Factor out check that values meet constraints
Date:   Fri, 17 Dec 2021 13:02:12 +0000
Message-Id: <20211217130213.3893415-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211217130213.3893415-1-broonie@kernel.org>
References: <20211217130213.3893415-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7253; h=from:subject; bh=p0EUVadnjEh+VEL3Df8aeJ2FHtPzcNPsATIRNxkT7xA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhvIpMaXS59ZIdcpQYdCf0oZ/8LhvZ5MVIMefs1FbN uSjEfOyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbyKTAAKCRAk1otyXVSH0IwJB/ 9qGRnHpW7v0s7bsizAQl0W10zZ+Qwr6sJNsFpiAuw/6nK4+nTmZSv6Q7+9p34v7B5xwbKVsEvIq4AB oEjdlAv1qj0914T5Sj8C0cn1nmuqcQTt0HV37e+hqOMnIEq5BrtKqHWEoNhVGfThwlaj+/gA6nX1J3 UqhK9iovaV3g7em8H+X6RI2QT+rQB1HSeaxpQu/6dMxZjmHIL/qzPsZRnPquiXS5SJmgAgNoUX33PA GaK6hYvyl9v5S9ZA7VIMg0Ahdrp5iv9B8qeLJjKMEi6CZpwIwNv7md0I0SQryyKIgsxrW/k23llxjT LAUz5yrU7ec1zoPKSCv1ZJX8EYIzRX
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To simplify the code a bit and allow future reuse factor the checks that
values we read are valid out of test_ctl_get_value() into a separate
function which can be reused later. As part of this extend the test to
check all the values for the control, not just the first one.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 141 +++++++++++++---------
 1 file changed, 82 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index b798a76f6825..b009fc5df605 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -193,124 +193,147 @@ void find_controls(void)
 	snd_config_delete(config);
 }
 
-/*
- * Check that we can read the default value and it is valid. Write
- * tests use the read value to restore the default.
- */
-void test_ctl_get_value(struct ctl_data *ctl)
+bool ctl_value_index_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val,
+			   int index)
 {
-	int err;
 	long int_val;
 	long long int64_val;
 
-	/* If the control is turned off let's be polite */
-	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
-		ksft_print_msg("%s is inactive\n", ctl->name);
-		ksft_test_result_skip("get_value.%d.%d\n",
-				      ctl->card->card, ctl->elem);
-		return;
-	}
-
-	/* Can't test reading on an unreadable control */
-	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
-		ksft_print_msg("%s is not readable\n", ctl->name);
-		ksft_test_result_skip("get_value.%d.%d\n",
-				      ctl->card->card, ctl->elem);
-		return;
-	}
-
-	err = snd_ctl_elem_read(ctl->card->handle, ctl->def_val);
-	if (err < 0) {
-		ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
-			       snd_strerror(err));
-		goto out;
-	}
-
 	switch (snd_ctl_elem_info_get_type(ctl->info)) {
 	case SND_CTL_ELEM_TYPE_NONE:
-		ksft_print_msg("%s Invalid control type NONE\n", ctl->name);
-		err = -1;
-		break;
+		ksft_print_msg("%s.%d Invalid control type NONE\n",
+			       ctl->name, index);
+		return false;
 
 	case SND_CTL_ELEM_TYPE_BOOLEAN:
-		int_val = snd_ctl_elem_value_get_boolean(ctl->def_val, 0);
+		int_val = snd_ctl_elem_value_get_boolean(val, index);
 		switch (int_val) {
 		case 0:
 		case 1:
 			break;
 		default:
-			ksft_print_msg("%s Invalid boolean value %ld\n",
-				       ctl->name, int_val);
-			err = -1;
-			break;
+			ksft_print_msg("%s.%d Invalid boolean value %ld\n",
+				       ctl->name, index, int_val);
+			return false;
 		}
 		break;
 
 	case SND_CTL_ELEM_TYPE_INTEGER:
-		int_val = snd_ctl_elem_value_get_integer(ctl->def_val, 0);
+		int_val = snd_ctl_elem_value_get_integer(val, index);
 
 		if (int_val < snd_ctl_elem_info_get_min(ctl->info)) {
-			ksft_print_msg("%s value %ld less than minimum %ld\n",
-				       ctl->name, int_val,
+			ksft_print_msg("%s.%d value %ld less than minimum %ld\n",
+				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_min(ctl->info));
-			err = -1;
+			return false;
 		}
 
 		if (int_val > snd_ctl_elem_info_get_max(ctl->info)) {
-			ksft_print_msg("%s value %ld more than maximum %ld\n",
-				       ctl->name, int_val,
+			ksft_print_msg("%s.%d value %ld more than maximum %ld\n",
+				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_max(ctl->info));
-			err = -1;
+			return false;
 		}
 
 		/* Only check step size if there is one and we're in bounds */
-		if (err >= 0 && snd_ctl_elem_info_get_step(ctl->info) &&
+		if (snd_ctl_elem_info_get_step(ctl->info) &&
 		    (int_val - snd_ctl_elem_info_get_min(ctl->info) %
 		     snd_ctl_elem_info_get_step(ctl->info))) {
-			ksft_print_msg("%s value %ld invalid for step %ld minimum %ld\n",
-				       ctl->name, int_val,
+			ksft_print_msg("%s.%d value %ld invalid for step %ld minimum %ld\n",
+				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_step(ctl->info),
 				       snd_ctl_elem_info_get_min(ctl->info));
-			err = -1;
+			return false;
 		}
 		break;
 
 	case SND_CTL_ELEM_TYPE_INTEGER64:
-		int64_val = snd_ctl_elem_value_get_integer64(ctl->def_val, 0);
+		int64_val = snd_ctl_elem_value_get_integer64(val, index);
 
 		if (int64_val < snd_ctl_elem_info_get_min64(ctl->info)) {
-			ksft_print_msg("%s value %lld less than minimum %lld\n",
-				       ctl->name, int64_val,
+			ksft_print_msg("%s.%d value %lld less than minimum %lld\n",
+				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_min64(ctl->info));
-			err = -1;
+			return false;
 		}
 
 		if (int64_val > snd_ctl_elem_info_get_max64(ctl->info)) {
-			ksft_print_msg("%s value %lld more than maximum %lld\n",
-				       ctl->name, int64_val,
+			ksft_print_msg("%s.%d value %lld more than maximum %lld\n",
+				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_max(ctl->info));
-			err = -1;
+			return false;
 		}
 
 		/* Only check step size if there is one and we're in bounds */
-		if (err >= 0 && snd_ctl_elem_info_get_step64(ctl->info) &&
+		if (snd_ctl_elem_info_get_step64(ctl->info) &&
 		    (int64_val - snd_ctl_elem_info_get_min64(ctl->info)) %
 		    snd_ctl_elem_info_get_step64(ctl->info)) {
-			ksft_print_msg("%s value %lld invalid for step %lld minimum %lld\n",
-				       ctl->name, int64_val,
+			ksft_print_msg("%s.%d value %lld invalid for step %lld minimum %lld\n",
+				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_step64(ctl->info),
 				       snd_ctl_elem_info_get_min64(ctl->info));
-			err = -1;
+			return false;
 		}
 		break;
 
 	default:
 		/* No tests for other types */
+		break;
+	}
+
+	return true;
+}
+
+/*
+ * Check that the provided value meets the constraints for the
+ * provided control.
+ */
+bool ctl_value_valid(struct ctl_data *ctl, snd_ctl_elem_value_t *val)
+{
+	int i;
+	bool valid = true;
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++)
+		if (!ctl_value_index_valid(ctl, val, i))
+			valid = false;
+
+	return valid;
+}
+
+/*
+ * Check that we can read the default value and it is valid. Write
+ * tests use the read value to restore the default.
+ */
+void test_ctl_get_value(struct ctl_data *ctl)
+{
+	int err;
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
 		ksft_test_result_skip("get_value.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
 	}
 
+	err = snd_ctl_elem_read(ctl->card->handle, ctl->def_val);
+	if (err < 0) {
+		ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+			       snd_strerror(err));
+		goto out;
+	}
+
+	if (!ctl_value_valid(ctl, ctl->def_val))
+		err = -EINVAL;
+
 out:
 	ksft_test_result(err >= 0, "get_value.%d.%d\n",
 			 ctl->card->card, ctl->elem);
-- 
2.30.2

