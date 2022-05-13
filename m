Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654B52630E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 May 2022 15:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiEMNu0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 May 2022 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351055AbiEMNlE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 May 2022 09:41:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5566461;
        Fri, 13 May 2022 06:41:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d25so7711193pfo.10;
        Fri, 13 May 2022 06:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:from:content-transfer-encoding;
        bh=Yjtm4TDhkZtPjvLj2CJu9Tr06U0DT6HkX3URKOfA7lQ=;
        b=FqKw8GOAkZTyl4i0OmbpnBtWwJ+2ON7rOgQ6yPidXOsA6PstOKor82YhlbYaKAx+5G
         WXxtoxSqlXCREOl2yHGtTvc+bPghJt0nnhm87iu2PN4vNEEgRfsxrbYoiOvuPBTyPSM8
         aoHsSYQUHjkr4FTpXToHGAODE6qWmcpRnQzlDsqPKViodMYIzpOCdo3SkjVw+AP3eF8M
         6gvO4LtcYZnipBES8PdlJValHMAWvJtry9sQHe4Fadq8Cx1r5gGmDjSM43w/8/EyqeXp
         7giNmOFaeIdH4Js22sTXGQPhRBSIGfazq+bTJiFrLQ+x7X3o9/piDb8umPJCaQAOHCqZ
         Qdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:from:content-transfer-encoding;
        bh=Yjtm4TDhkZtPjvLj2CJu9Tr06U0DT6HkX3URKOfA7lQ=;
        b=K3EXg/Co5cynLkMzRCmNecezjaaYeOxFk9jRFzuY8geg6H+I+Z9cwFtWvk2gnar9wf
         nH6xpoX+yAtWmy8Xcya6b+TmfPeJ0zlafAzespKN3KjVjtfvNv5tc2EIig2UMGwmcjjv
         S/WQ+QjgQlGk6KK+JxaNisqYyhVaCVMq/rR0IsYP+jRxFkOwGWuHBl/86frGs3FKhkJV
         MlubEGGSWXTDppS6LqlkGgT86HCAjBREcE8gOkAdAeWQIo5Cv5ej0W1jC6yUGSrsokWk
         icBIAHDXJJpsPY3cd7/D2yiQILJoTOgBR1TQhbT5Ak79XrLTqQCTSBRi2Y61Ze3+9Xju
         +qUg==
X-Gm-Message-State: AOAM533opKpN8lztMbLq/23iuh74BqJAoFV+iSm3L5dPSzk7c08UDwz2
        niNIJCF8KC4xc91q8RLx9fo=
X-Google-Smtp-Source: ABdhPJyxn8x4zJCImIbVxuOBToPY4MBUnHEEoB6fJu6X8/eii+QaSQa+kbmBfj42KmIdjbK0kGFKsA==
X-Received: by 2002:a62:a211:0:b0:50d:cdb2:87f4 with SMTP id m17-20020a62a211000000b0050dcdb287f4mr4525151pff.63.1652449262451;
        Fri, 13 May 2022 06:41:02 -0700 (PDT)
Received: from [192.168.0.107] ([103.249.234.205])
        by smtp.gmail.com with ESMTPSA id u7-20020a170902e80700b0015e8d4eb207sm1879077plg.81.2022.05.13.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 May 2022 06:41:02 -0700 (PDT)
Message-ID: <8598037d-0e24-9bc1-3f2c-a2751ec8e871@gmail.com>
Date:   Fri, 13 May 2022 19:10:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: [PATCH] selftests: alsa: Better error messages
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Siddh Raman Pant <siddhpant.gh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows for potentially better machine-parsing due to an
expected / fixed format. Also because of eyecandy reasons.

Whenever possible, errors will start with the name of the
offending card/control, separated by the error with colons.

Whenever there is a description of an error given, the generated
error string from snd_strerror will be (mostly) enclosed in
parentheses at the end.

Clarity of error messages have been (hopefully) improved.

Signed-off-by: Siddh Raman Pant <siddhpant.gh@gmail.com>
---
 tools/testing/selftests/alsa/mixer-test.c | 94 +++++++++++------------
 1 file changed, 47 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index a38b89c28..4719b12a5 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -114,7 +114,7 @@ static void find_controls(void)
 
 	err = snd_config_load_string(&config, alsa_config, strlen(alsa_config));
 	if (err < 0) {
-		ksft_print_msg("Unable to parse custom alsa-lib configuration: %s\n",
+		ksft_print_msg("Unable to parse custom alsa-lib configuration (%s)\n",
 			       snd_strerror(err));
 		ksft_exit_fail();
 	}
@@ -128,7 +128,7 @@ static void find_controls(void)
 
 		err = snd_ctl_open_lconf(&card_data->handle, name, 0, config);
 		if (err < 0) {
-			ksft_print_msg("Failed to get hctl for card %d: %s\n",
+			ksft_print_msg("Card %d: Failed to get hctl (%s)\n",
 				       card, snd_strerror(err));
 			goto next_card;
 		}
@@ -177,9 +177,8 @@ static void find_controls(void)
 			err = snd_ctl_elem_info(card_data->handle,
 						ctl_data->info);
 			if (err < 0) {
-				ksft_print_msg("%s getting info for %d\n",
-					       snd_strerror(err),
-					       ctl_data->name);
+				ksft_print_msg("%s : %s while getting info\n",
+					       ctl_data->name, snd_strerror(err));
 			}
 
 			snd_ctl_elem_value_set_id(ctl_data->def_val,
@@ -192,20 +191,20 @@ static void find_controls(void)
 		/* Set up for events */
 		err = snd_ctl_subscribe_events(card_data->handle, true);
 		if (err < 0) {
-			ksft_exit_fail_msg("snd_ctl_subscribe_events() failed for card %d: %d\n",
+			ksft_exit_fail_msg("Card %d : snd_ctl_subscribe_events() failed (%d)\n",
 					   card, err);
 		}
 
 		err = snd_ctl_poll_descriptors_count(card_data->handle);
 		if (err != 1) {
-			ksft_exit_fail_msg("Unexpected descriptor count %d for card %d\n",
-					   err, card);
+			ksft_exit_fail_msg("Card %d : Unexpected descriptor count %d\n",
+					   card, err);
 		}
 
 		err = snd_ctl_poll_descriptors(card_data->handle,
 					       &card_data->pollfd, 1);
 		if (err != 1) {
-			ksft_exit_fail_msg("snd_ctl_poll_descriptors() failed for %d\n",
+			ksft_exit_fail_msg("Card %d : snd_ctl_poll_descriptors() failed (%d)\n",
 				       card, err);
 		}
 
@@ -236,8 +235,8 @@ static int wait_for_event(struct ctl_data *ctl, int timeout)
 	do {
 		err = poll(&(ctl->card->pollfd), 1, timeout);
 		if (err < 0) {
-			ksft_print_msg("poll() failed for %s: %s (%d)\n",
-				       ctl->name, strerror(errno), errno);
+			ksft_print_msg("%s : poll() failed (%d - %s)\n",
+				       ctl->name, errno, strerror(errno));
 			return -1;
 		}
 		/* Timeout */
@@ -248,12 +247,12 @@ static int wait_for_event(struct ctl_data *ctl, int timeout)
 						       &(ctl->card->pollfd),
 						       1, &revents);
 		if (err < 0) {
-			ksft_print_msg("snd_ctl_poll_descriptors_revents() failed for %s: %d\n",
+			ksft_print_msg("%s : snd_ctl_poll_descriptors_revents() failed (%d)\n",
 				       ctl->name, err);
 			return err;
 		}
 		if (revents & POLLERR) {
-			ksft_print_msg("snd_ctl_poll_descriptors_revents() reported POLLERR for %s\n",
+			ksft_print_msg("%s : snd_ctl_poll_descriptors_revents() reported POLLERR\n",
 				       ctl->name);
 			return -1;
 		}
@@ -265,7 +264,7 @@ static int wait_for_event(struct ctl_data *ctl, int timeout)
 
 		err = snd_ctl_read(ctl->card->handle, event);
 		if (err < 0) {
-			ksft_print_msg("snd_ctl_read() failed for %s: %d\n",
+			ksft_print_msg("%s : snd_ctl_read() failed (%d)\n",
 			       ctl->name, err);
 			return err;
 		}
@@ -283,7 +282,7 @@ static int wait_for_event(struct ctl_data *ctl, int timeout)
 		}
 
 		if ((mask & SND_CTL_EVENT_MASK_REMOVE) == SND_CTL_EVENT_MASK_REMOVE) {
-			ksft_print_msg("Removal event for %s\n",
+			ksft_print_msg("%s : Removal event\n",
 				       ctl->name);
 			return -1;
 		}
@@ -301,7 +300,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 
 	switch (snd_ctl_elem_info_get_type(ctl->info)) {
 	case SND_CTL_ELEM_TYPE_NONE:
-		ksft_print_msg("%s.%d Invalid control type NONE\n",
+		ksft_print_msg("%s.%d : Invalid control type NONE\n",
 			       ctl->name, index);
 		return false;
 
@@ -312,7 +311,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		case 1:
 			break;
 		default:
-			ksft_print_msg("%s.%d Invalid boolean value %ld\n",
+			ksft_print_msg("%s.%d : Invalid boolean value %ld\n",
 				       ctl->name, index, int_val);
 			return false;
 		}
@@ -322,14 +321,14 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		int_val = snd_ctl_elem_value_get_integer(val, index);
 
 		if (int_val < snd_ctl_elem_info_get_min(ctl->info)) {
-			ksft_print_msg("%s.%d value %ld less than minimum %ld\n",
+			ksft_print_msg("%s.%d : Value %ld is less than the minimum (%ld)\n",
 				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_min(ctl->info));
 			return false;
 		}
 
 		if (int_val > snd_ctl_elem_info_get_max(ctl->info)) {
-			ksft_print_msg("%s.%d value %ld more than maximum %ld\n",
+			ksft_print_msg("%s.%d : Value %ld is more than the maximum (%ld)\n",
 				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_max(ctl->info));
 			return false;
@@ -339,7 +338,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		if (snd_ctl_elem_info_get_step(ctl->info) &&
 		    (int_val - snd_ctl_elem_info_get_min(ctl->info) %
 		     snd_ctl_elem_info_get_step(ctl->info))) {
-			ksft_print_msg("%s.%d value %ld invalid for step %ld minimum %ld\n",
+			ksft_print_msg("%s.%d : Value %ld is invalid for step %ld, minimum %ld\n",
 				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_step(ctl->info),
 				       snd_ctl_elem_info_get_min(ctl->info));
@@ -351,14 +350,14 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		int64_val = snd_ctl_elem_value_get_integer64(val, index);
 
 		if (int64_val < snd_ctl_elem_info_get_min64(ctl->info)) {
-			ksft_print_msg("%s.%d value %lld less than minimum %lld\n",
+			ksft_print_msg("%s.%d : Value %lld is less than the minimum (%lld)\n",
 				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_min64(ctl->info));
 			return false;
 		}
 
 		if (int64_val > snd_ctl_elem_info_get_max64(ctl->info)) {
-			ksft_print_msg("%s.%d value %lld more than maximum %lld\n",
+			ksft_print_msg("%s.%d : Value %lld is more than the maximum (%lld)\n",
 				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_max(ctl->info));
 			return false;
@@ -368,7 +367,7 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		if (snd_ctl_elem_info_get_step64(ctl->info) &&
 		    (int64_val - snd_ctl_elem_info_get_min64(ctl->info)) %
 		    snd_ctl_elem_info_get_step64(ctl->info)) {
-			ksft_print_msg("%s.%d value %lld invalid for step %lld minimum %lld\n",
+			ksft_print_msg("%s.%d : Value %lld is invalid for step %lld, minimum %lld\n",
 				       ctl->name, index, int64_val,
 				       snd_ctl_elem_info_get_step64(ctl->info),
 				       snd_ctl_elem_info_get_min64(ctl->info));
@@ -380,13 +379,13 @@ static bool ctl_value_index_valid(struct ctl_data *ctl,
 		int_val = snd_ctl_elem_value_get_enumerated(val, index);
 
 		if (int_val < 0) {
-			ksft_print_msg("%s.%d negative value %ld for enumeration\n",
+			ksft_print_msg("%s.%d : Negative value %ld for enumeration\n",
 				       ctl->name, index, int_val);
 			return false;
 		}
 
 		if (int_val >= snd_ctl_elem_info_get_items(ctl->info)) {
-			ksft_print_msg("%s.%d value %ld more than item count %ld\n",
+			ksft_print_msg("%s.%d : Value %ld is more than item count (%ld)\n",
 				       ctl->name, index, int_val,
 				       snd_ctl_elem_info_get_items(ctl->info));
 			return false;
@@ -427,7 +426,7 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
-		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_print_msg("%s : Inactive\n", ctl->name);
 		ksft_test_result_skip("get_value.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
@@ -435,7 +434,7 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 
 	/* Can't test reading on an unreadable control */
 	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
-		ksft_print_msg("%s is not readable\n", ctl->name);
+		ksft_print_msg("%s : Not readable\n", ctl->name);
 		ksft_test_result_skip("get_value.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
@@ -443,7 +442,7 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 
 	err = snd_ctl_elem_read(ctl->card->handle, ctl->def_val);
 	if (err < 0) {
-		ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+		ksft_print_msg("snd_ctl_elem_read() failed (%s)\n",
 			       snd_strerror(err));
 		goto out;
 	}
@@ -474,7 +473,7 @@ static void test_ctl_name(struct ctl_data *ctl)
 	/* Only boolean controls should end in Switch */
 	if (strend(ctl->name, " Switch")) {
 		if (snd_ctl_elem_info_get_type(ctl->info) != SND_CTL_ELEM_TYPE_BOOLEAN) {
-			ksft_print_msg("%d.%d %s ends in Switch but is not boolean\n",
+			ksft_print_msg("%d.%d %s : Not a boolean, but name ends in Switch\n",
 				       ctl->card->card, ctl->elem, ctl->name);
 			name_ok = false;
 		}
@@ -484,7 +483,7 @@ static void test_ctl_name(struct ctl_data *ctl)
 	if (snd_ctl_elem_info_get_type(ctl->info) == SND_CTL_ELEM_TYPE_BOOLEAN &&
 	    snd_ctl_elem_info_is_writable(ctl->info)) {
 		if (!strend(ctl->name, " Switch")) {
-			ksft_print_msg("%d.%d %s is a writeable boolean but not a Switch\n",
+			ksft_print_msg("%d.%d %s : Not a Switch despite being a writeable boolean\n",
 				       ctl->card->card, ctl->elem, ctl->name);
 			name_ok = false;
 		}
@@ -542,11 +541,12 @@ static bool show_mismatch(struct ctl_data *ctl, int index,
 		/*
 		 * NOTE: The volatile attribute means that the hardware
 		 * can voluntarily change the state of control element
-		 * independent of any operation by software.  
+		 * independent of any operation by software.
 		 */
 		bool is_volatile = snd_ctl_elem_info_is_volatile(ctl->info);
-		ksft_print_msg("%s.%d expected %lld but read %lld, is_volatile %d\n",
-			       ctl->name, index, expected_int, read_int, is_volatile);
+		ksft_print_msg("%s.%d : Expected %lld, but read %lld (%s)\n",
+			       ctl->name, index, expected_int, read_int,
+			       (is_volatile ? "Volatile" : "Non-volatile"));
 		return !is_volatile;
 	} else {
 		return false;
@@ -590,7 +590,7 @@ static int write_and_verify(struct ctl_data *ctl,
 
 		err = snd_ctl_elem_read(ctl->card->handle, initial_val);
 		if (err < 0) {
-			ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+			ksft_print_msg("snd_ctl_elem_read() failed (%s)\n",
 				       snd_strerror(err));
 			return err;
 		}
@@ -602,7 +602,7 @@ static int write_and_verify(struct ctl_data *ctl,
 	 */
 	err = snd_ctl_elem_write(ctl->card->handle, w_val);
 	if (err < 0 && !error_expected) {
-		ksft_print_msg("snd_ctl_elem_write() failed: %s\n",
+		ksft_print_msg("snd_ctl_elem_write() failed (%s)\n",
 			       snd_strerror(err));
 		return err;
 	}
@@ -615,7 +615,7 @@ static int write_and_verify(struct ctl_data *ctl,
 
 	err = snd_ctl_elem_read(ctl->card->handle, read_val);
 	if (err < 0) {
-		ksft_print_msg("snd_ctl_elem_read() failed: %s\n",
+		ksft_print_msg("snd_ctl_elem_read() failed (%s)\n",
 			       snd_strerror(err));
 		return err;
 	}
@@ -631,13 +631,13 @@ static int write_and_verify(struct ctl_data *ctl,
 		err = wait_for_event(ctl, 0);
 		if (snd_ctl_elem_value_compare(initial_val, read_val)) {
 			if (err < 1) {
-				ksft_print_msg("No event generated for %s\n",
+				ksft_print_msg("%s : No event generated\n",
 					       ctl->name);
 				ctl->event_missing++;
 			}
 		} else {
 			if (err != 0) {
-				ksft_print_msg("Spurious event generated for %s\n",
+				ksft_print_msg("%s : Spurious event generated\n",
 					       ctl->name);
 				ctl->event_spurious++;
 			}
@@ -658,7 +658,7 @@ static int write_and_verify(struct ctl_data *ctl,
 			mismatch_shown = true;
 
 	if (!mismatch_shown)
-		ksft_print_msg("%s read and written values differ\n",
+		ksft_print_msg("%s : Read and written values differ\n",
 			       ctl->name);
 
 	return -1;
@@ -674,14 +674,14 @@ static void test_ctl_write_default(struct ctl_data *ctl)
 
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
-		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_print_msg("%s : Inactive\n", ctl->name);
 		ksft_test_result_skip("write_default.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
 	}
 
 	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
-		ksft_print_msg("%s is not writeable\n", ctl->name);
+		ksft_print_msg("%s : Not writeable\n", ctl->name);
 		ksft_test_result_skip("write_default.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
@@ -689,7 +689,7 @@ static void test_ctl_write_default(struct ctl_data *ctl)
 
 	/* No idea what the default was for unreadable controls */
 	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
-		ksft_print_msg("%s couldn't read default\n", ctl->name);
+		ksft_print_msg("%s : Couldn't read default\n", ctl->name);
 		ksft_test_result_skip("write_default.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
@@ -808,14 +808,14 @@ static void test_ctl_write_valid(struct ctl_data *ctl)
 
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
-		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_print_msg("%s : Inactive\n", ctl->name);
 		ksft_test_result_skip("write_valid.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
 	}
 
 	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
-		ksft_print_msg("%s is not writeable\n", ctl->name);
+		ksft_print_msg("%s : Not writeable\n", ctl->name);
 		ksft_test_result_skip("write_valid.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
@@ -868,7 +868,7 @@ static bool test_ctl_write_invalid_value(struct ctl_data *ctl,
 	/* ...but some devices will clamp to an in range value */
 	err = snd_ctl_elem_read(ctl->card->handle, val);
 	if (err < 0) {
-		ksft_print_msg("%s failed to read: %s\n",
+		ksft_print_msg("%s : Failed to read (%s)\n",
 			       ctl->name, snd_strerror(err));
 		return true;
 	}
@@ -1026,14 +1026,14 @@ static void test_ctl_write_invalid(struct ctl_data *ctl)
 
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
-		ksft_print_msg("%s is inactive\n", ctl->name);
+		ksft_print_msg("%s : Inactive\n", ctl->name);
 		ksft_test_result_skip("write_invalid.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
 	}
 
 	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
-		ksft_print_msg("%s is not writeable\n", ctl->name);
+		ksft_print_msg("%s : Not writeable\n", ctl->name);
 		ksft_test_result_skip("write_invalid.%d.%d\n",
 				      ctl->card->card, ctl->elem);
 		return;
-- 
2.35.1
