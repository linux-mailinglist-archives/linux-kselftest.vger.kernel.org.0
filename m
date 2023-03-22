Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89466C4F40
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Mar 2023 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjCVPSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Mar 2023 11:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjCVPST (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Mar 2023 11:18:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A247FCC26
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 08:18:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 542D4B81D1D
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Mar 2023 15:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9298EC433EF;
        Wed, 22 Mar 2023 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679498296;
        bh=G91Xxoht3fjT/ksBx7WK39E+k66GaFoCv6vtPQKyrIc=;
        h=From:Date:Subject:To:Cc:From;
        b=QaWquMRs0vLW629HLsF0AR2Mf+8ZKwsgWEJ+bmdMu9QIHIlXnZgfcUOp/nYigHNHO
         2NBtLFYzTkCRVdxH/T3r9ZgEVZYaLJBCNSa9OBjiiHaQf1/rO+mFeX/XR8ajHKZsLS
         BOyejorKR8KNY64I2rDfW9kf7uJ9bC64tz+bAFr9zoWBOsqzrO+bDBf7J76/HNRf1R
         3BEDsV5bvAxAJT2QGAHE+k9OszbE7vJ1fG5vR905iiTCp7y4RN0f1/uRhsk6zynsHH
         6MsQ57q/Ncb/UTeIu4oAJvpgz1OHQq6+roq48ysDVaghJb6xaweZl9ixyFFLrzUzYR
         nVQrNBfatFwiQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 22 Mar 2023 15:18:07 +0000
Subject: [PATCH] kselftest/alsa - mixer-test: Log values associated with
 event issues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230322-alsa-mixer-event-values-v1-1-78189fcf6655@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC4cG2QC/xXNQQrCQAyF4auUrA20aUHrVcRFZow2WKeS1FEov
 bszy//Bx9vAxVQczs0GJlldl1SiOzQQJ04PQb2VBmqpb3si5NkZX/oTQ8mSVsw8f8TxOIynEJl
 GGjooOrALBuMUp+q/iz3r/Da5F1wPL9d9/wPAkofJgAAAAA==
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=2870; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G91Xxoht3fjT/ksBx7WK39E+k66GaFoCv6vtPQKyrIc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkGxw1pNw+kqrw+UT6UrYdlwhHdKFk0xjSV6/AlI0x
 +G/DaoSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZBscNQAKCRAk1otyXVSH0PB2B/
 9cZ6FBiQvVna4Jf9J4Wi+vyJSupNBGGqijeKbrI65XwPMb7+xkhpgddnRUDR00wiNrQx7J1iXklBxo
 2exeYAyDGmQt0z4vIe9phw7JFSQytvl35PTM3hCx/yQuz0LgWXINAngpKmtvjIS6nm9dqydaIgrh9Z
 VY4TX0itnVAjpLN55ThrKOURqzktphQhwSO8wuULdEp7hHY/cCLfF59mL6Y+oBtY3pJR4RU/DO5Esp
 KyLshOyxCZ4WtxrZtk83BOBFabP+/RUK4m/MyZhHnKUqLshMFyxxyl3zYu35mBbVGOnucKO64HyzAX
 zoWrPbFD1g7OQvZEPJyAmhvIT4Rzzp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While it is common for driver bugs with events to apply to all events there
are some issues which only trigger for specific values. Understanding these
is easier if we know what we were trying to do when configuring the control
so add logging for the specific values involved in the spurious event.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 44 +++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 05f1749ae19d..15d2ef8d4d27 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -445,6 +445,48 @@ static void test_ctl_name(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
+static void show_values(struct ctl_data *ctl, snd_ctl_elem_value_t *orig_val,
+			snd_ctl_elem_value_t *read_val)
+{
+	long long orig_int, read_int;
+	int i;
+
+	for (i = 0; i < snd_ctl_elem_info_get_count(ctl->info); i++) {
+		switch (snd_ctl_elem_info_get_type(ctl->info)) {
+		case SND_CTL_ELEM_TYPE_BOOLEAN:
+			orig_int = snd_ctl_elem_value_get_boolean(orig_val, i);
+			read_int = snd_ctl_elem_value_get_boolean(read_val, i);
+			break;
+
+		case SND_CTL_ELEM_TYPE_INTEGER:
+			orig_int = snd_ctl_elem_value_get_integer(orig_val, i);
+			read_int = snd_ctl_elem_value_get_integer(read_val, i);
+			break;
+
+		case SND_CTL_ELEM_TYPE_INTEGER64:
+			orig_int = snd_ctl_elem_value_get_integer64(orig_val,
+								    i);
+			read_int = snd_ctl_elem_value_get_integer64(read_val,
+								    i);
+			break;
+
+		case SND_CTL_ELEM_TYPE_ENUMERATED:
+			orig_int = snd_ctl_elem_value_get_enumerated(orig_val,
+								     i);
+			read_int = snd_ctl_elem_value_get_enumerated(read_val,
+								     i);
+			break;
+
+		default:
+			return;
+		}
+
+		ksft_print_msg("%s.%d orig %lld read %lld, is_volatile %d\n",
+			       ctl->name, i, orig_int, read_int,
+			       snd_ctl_elem_info_is_volatile(ctl->info));
+	}
+}
+
 static bool show_mismatch(struct ctl_data *ctl, int index,
 			  snd_ctl_elem_value_t *read_val,
 			  snd_ctl_elem_value_t *expected_val)
@@ -584,12 +626,14 @@ static int write_and_verify(struct ctl_data *ctl,
 			if (err < 1) {
 				ksft_print_msg("No event generated for %s\n",
 					       ctl->name);
+				show_values(ctl, initial_val, read_val);
 				ctl->event_missing++;
 			}
 		} else {
 			if (err != 0) {
 				ksft_print_msg("Spurious event generated for %s\n",
 					       ctl->name);
+				show_values(ctl, initial_val, read_val);
 				ctl->event_spurious++;
 			}
 		}

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230322-alsa-mixer-event-values-7498bca29241

Best regards,
-- 
Mark Brown <broonie@kernel.org>

