Return-Path: <linux-kselftest+bounces-13588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A492EAD6
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92D91C22C9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF01E1662FE;
	Thu, 11 Jul 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9A1ZWus"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAC167DA8;
	Thu, 11 Jul 2024 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720708487; cv=none; b=S6FAM1IoBDnZrlV6T7duDpu+/mvXotImeVqMnCLqkuWEilONF7MUHalIqKIL/b5XcyqeP9qvLhdrHAE13pqAL1dA0nhFhDRxAxaEV1bzzoJSKGJaHsSJjyxdvsfHkEyKX5AHUNs5X1oM4iGshPNj810r6Ksn0kBFDigy8kYyj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720708487; c=relaxed/simple;
	bh=u+JLQpY2OGFSvyqiP0oNI4X+ySZWmc0hNBY3OoLpvTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BmydqMBce4r4LbHdnaF7aW6Ks8Ku7UZk+v05VFR7iJrXwm7Y/J8Zrp/Jw8NTCalSeOxctuaH9otSlOnpUOOKJgRiHY1kdZqOxzVIk0SBKgYZOVRr/e1bVHAvrGRcHVhevbz0f151LYWLS1TkMXeyi+Pipc1Qj9M/S6yNUaCm1L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9A1ZWus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8490BC116B1;
	Thu, 11 Jul 2024 14:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720708487;
	bh=u+JLQpY2OGFSvyqiP0oNI4X+ySZWmc0hNBY3OoLpvTw=;
	h=From:Date:Subject:To:Cc:From;
	b=s9A1ZWus2u/s3VdNqvfq5TnQkOHcQ+E+yMcB8FG3yojvKvocStUsBpAEJnqkpVVnI
	 NEcpIyKsKgGNll95XbRT2sH6pt1BcuJjprDmYrPGONiyNQKLs59mnBJ6y3GmaqzLBd
	 i+feY7H7u5fNayN8vpmU+KeoaJzq3fPVQ+8Sgi7Jjcv27qHYHi+a1rID+K1r6DuMxa
	 YuBUwV6/WlRDvup3E3H1o8B2lcf8ksTWmi8TZoFqGNQ94tzwnD6H0cASHk94zbdMGQ
	 /XOTVo+jBrxPwEPvesKCp0AEUN8P3hNPYywJF5lDahq6XIjg0du9ElidpX2TtPAfxA
	 GwwLEcYftnBog==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 11 Jul 2024 15:33:28 +0100
Subject: [PATCH] kselftest/alsa: Use card name rather than number in test
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-alsa-kselftest-board-name-v1-1-ab5cf2dbbea6@kernel.org>
X-B4-Tracking: v=1; b=H4sIADftj2YC/x3MQQqDMBBG4avIrB1IJCB4ldLF1PzRoTaWjIgg3
 t3g8lu8d5KhKIyG5qSCXU3XXOHbhsZZ8gTWWE2d64LrvWdZTPhrWNIG2/izSomc5QdGEC8xhjG
 Jo9r/C5Iez/v1vq4bQlO3K2sAAAA=
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=13170; i=broonie@kernel.org;
 h=from:subject:message-id; bh=u+JLQpY2OGFSvyqiP0oNI4X+ySZWmc0hNBY3OoLpvTw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmj+2Ekf3wRYUeio+n3/rUkalFzeUoYxJ/Da2Erwhc
 MbQDjA+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZo/thAAKCRAk1otyXVSH0EB5B/
 sGj1T4OaXaWh/RtRN5F+4/hqe4v9bV9sFApvnwk0NpdGrvCsVzCh98D1chMighLDbtCdBX9Wbcjw09
 TFjbudmgyVi+2dMH5lObbEWMeuCYGevyOFvUkorT1OE+nE0FNZFJNgm/i8E8EJHdcNSBDsJ6cjsdbV
 NpPB/ejUDKZcISa+osgM/2mxTSwdGnXHgsB7dcGg4ip3wakezG7ZIwS6gRokJF8inAuv//1EY3ffWy
 lrAFXaBkn1CLX4e7VSlEn8RQUHdHSwt6m7lL4DltSo7HAdxdTtzf+csdxJhJ7TAKQEQYs7N6uenuLG
 DfmGpFdmHRY8dza9h2hQO9gJ7gcpAr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently for the PCM and mixer tests we report test names which identify
the card being tested with the card number. This ensures we have unique
names but since card numbers are dynamically assigned at runtime the names
we end up with will often not be stable on systems with multiple cards
especially where those cards are provided by separate modules loeaded at
runtime. This makes it difficult for automated systems and UIs to relate
test results between runs on affected platforms.

Address this by replacing our use of card numbers with card names which are
more likely to be stable across runs. We use the long name since in the
case where we have two of the same card it is more likely to include
deduplication information (eg, HDA cards include the address/IRQ). The
resulting information is not the most beautiful for human readers but the
majority of kselftest output consumption is automated systems and it wasn't
that great anyway.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 76 ++++++++++++++++---------------
 tools/testing/selftests/alsa/pcm-test.c   | 35 ++++++++------
 2 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..df9ae3b4e2df 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -33,6 +33,7 @@
 struct card_data {
 	snd_ctl_t *handle;
 	int card;
+	const char *card_name;
 	struct pollfd pollfd;
 	int num_ctls;
 	snd_ctl_elem_list_t *ctls;
@@ -91,6 +92,7 @@ static void find_controls(void)
 		err = snd_card_get_longname(card, &card_longname);
 		if (err != 0)
 			card_longname = "Unknown";
+		card_data->card_name = card_longname;
 		ksft_print_msg("Card %d - %s (%s)\n", card,
 			       card_name, card_longname);
 
@@ -389,16 +391,16 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
 		ksft_print_msg("%s is inactive\n", ctl->name);
-		ksft_test_result_skip("get_value.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("get_value.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	/* Can't test reading on an unreadable control */
 	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
 		ksft_print_msg("%s is not readable\n", ctl->name);
-		ksft_test_result_skip("get_value.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("get_value.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
@@ -413,8 +415,8 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 		err = -EINVAL;
 
 out:
-	ksft_test_result(err >= 0, "get_value.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(err >= 0, "get_value.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static bool strend(const char *haystack, const char *needle)
@@ -431,7 +433,7 @@ static void test_ctl_name(struct ctl_data *ctl)
 {
 	bool name_ok = true;
 
-	ksft_print_msg("%d.%d %s\n", ctl->card->card, ctl->elem,
+	ksft_print_msg("%s.%d %s\n", ctl->card->card_name, ctl->elem,
 		       ctl->name);
 
 	/* Only boolean controls should end in Switch */
@@ -453,8 +455,8 @@ static void test_ctl_name(struct ctl_data *ctl)
 		}
 	}
 
-	ksft_test_result(name_ok, "name.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(name_ok, "name.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static void show_values(struct ctl_data *ctl, snd_ctl_elem_value_t *orig_val,
@@ -682,30 +684,30 @@ static void test_ctl_write_default(struct ctl_data *ctl)
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
 		ksft_print_msg("%s is inactive\n", ctl->name);
-		ksft_test_result_skip("write_default.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_default.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
 		ksft_print_msg("%s is not writeable\n", ctl->name);
-		ksft_test_result_skip("write_default.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_default.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	/* No idea what the default was for unreadable controls */
 	if (!snd_ctl_elem_info_is_readable(ctl->info)) {
 		ksft_print_msg("%s couldn't read default\n", ctl->name);
-		ksft_test_result_skip("write_default.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_default.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	err = write_and_verify(ctl, ctl->def_val, NULL);
 
-	ksft_test_result(err >= 0, "write_default.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(err >= 0, "write_default.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static bool test_ctl_write_valid_boolean(struct ctl_data *ctl)
@@ -815,15 +817,15 @@ static void test_ctl_write_valid(struct ctl_data *ctl)
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
 		ksft_print_msg("%s is inactive\n", ctl->name);
-		ksft_test_result_skip("write_valid.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_valid.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
 		ksft_print_msg("%s is not writeable\n", ctl->name);
-		ksft_test_result_skip("write_valid.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_valid.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
@@ -846,16 +848,16 @@ static void test_ctl_write_valid(struct ctl_data *ctl)
 
 	default:
 		/* No tests for this yet */
-		ksft_test_result_skip("write_valid.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_valid.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	/* Restore the default value to minimise disruption */
 	write_and_verify(ctl, ctl->def_val, NULL);
 
-	ksft_test_result(pass, "write_valid.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(pass, "write_valid.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static bool test_ctl_write_invalid_value(struct ctl_data *ctl,
@@ -1027,15 +1029,15 @@ static void test_ctl_write_invalid(struct ctl_data *ctl)
 	/* If the control is turned off let's be polite */
 	if (snd_ctl_elem_info_is_inactive(ctl->info)) {
 		ksft_print_msg("%s is inactive\n", ctl->name);
-		ksft_test_result_skip("write_invalid.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_invalid.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	if (!snd_ctl_elem_info_is_writable(ctl->info)) {
 		ksft_print_msg("%s is not writeable\n", ctl->name);
-		ksft_test_result_skip("write_invalid.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_invalid.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
@@ -1058,28 +1060,28 @@ static void test_ctl_write_invalid(struct ctl_data *ctl)
 
 	default:
 		/* No tests for this yet */
-		ksft_test_result_skip("write_invalid.%d.%d\n",
-				      ctl->card->card, ctl->elem);
+		ksft_test_result_skip("write_invalid.%s.%d\n",
+				      ctl->card->card_name, ctl->elem);
 		return;
 	}
 
 	/* Restore the default value to minimise disruption */
 	write_and_verify(ctl, ctl->def_val, NULL);
 
-	ksft_test_result(pass, "write_invalid.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(pass, "write_invalid.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static void test_ctl_event_missing(struct ctl_data *ctl)
 {
-	ksft_test_result(!ctl->event_missing, "event_missing.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(!ctl->event_missing, "event_missing.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static void test_ctl_event_spurious(struct ctl_data *ctl)
 {
-	ksft_test_result(!ctl->event_spurious, "event_spurious.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(!ctl->event_spurious, "event_spurious.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 int main(void)
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index de664dedb541..a7b1e6e876c5 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -24,6 +24,7 @@ typedef struct timespec timestamp_t;
 
 struct card_data {
 	int card;
+	const char *name;
 	pthread_t thread;
 	struct card_data *next;
 };
@@ -35,6 +36,7 @@ struct pcm_data {
 	int card;
 	int device;
 	int subdevice;
+	const char *card_name;
 	snd_pcm_stream_t stream;
 	snd_config_t *pcm_config;
 	struct pcm_data *next;
@@ -191,6 +193,7 @@ static void find_pcms(void)
 		if (!card_data)
 			ksft_exit_fail_msg("Out of memory\n");
 		card_data->card = card;
+		card_data->name = card_longname;
 		card_data->next = card_list;
 		card_list = card_data;
 
@@ -232,6 +235,7 @@ static void find_pcms(void)
 					pcm_data->card = card;
 					pcm_data->device = dev;
 					pcm_data->subdevice = subdev;
+					pcm_data->card_name = card_name;
 					pcm_data->stream = stream;
 					pcm_data->pcm_config = conf_get_subtree(card_config, key, NULL);
 					pcm_data->next = pcm_list;
@@ -294,9 +298,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 
 	desc = conf_get_string(pcm_cfg, "description", NULL, NULL);
 	if (desc)
-		ksft_print_msg("%s.%s.%d.%d.%d.%s - %s\n",
+		ksft_print_msg("%s.%s.%s.%d.%d.%s - %s\n",
 			       test_class_name, test_name,
-			       data->card, data->device, data->subdevice,
+			       data->card_name, data->device, data->subdevice,
 			       snd_pcm_stream_name(data->stream),
 			       desc);
 
@@ -352,9 +356,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			old_format = format;
 			format = snd_pcm_format_value(alt_formats[i]);
 			if (format != SND_PCM_FORMAT_UNKNOWN) {
-				ksft_print_msg("%s.%d.%d.%d.%s.%s format %s -> %s\n",
+				ksft_print_msg("%s.%s.%d.%d.%s.%s format %s -> %s\n",
 						 test_name,
-						 data->card, data->device, data->subdevice,
+						 data->card_name, data->device, data->subdevice,
 						 snd_pcm_stream_name(data->stream),
 						 snd_pcm_access_name(access),
 						 snd_pcm_format_name(old_format),
@@ -430,9 +434,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		goto __close;
 	}
 
-	ksft_print_msg("%s.%s.%d.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
+	ksft_print_msg("%s.%s.%s.%d.%d.%s hw_params.%s.%s.%ld.%ld.%ld.%ld sw_params.%ld\n",
 		         test_class_name, test_name,
-			 data->card, data->device, data->subdevice,
+			 data->card_name, data->device, data->subdevice,
 			 snd_pcm_stream_name(data->stream),
 			 snd_pcm_access_name(access),
 			 snd_pcm_format_name(format),
@@ -491,9 +495,10 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 		 * Anything specified as specific to this system
 		 * should always be supported.
 		 */
-		ksft_test_result(!skip, "%s.%s.%d.%d.%d.%s.params\n",
+		ksft_test_result(!skip, "%s.%s.%s.%d.%d.%s.params\n",
 				 test_class_name, test_name,
-				 data->card, data->device, data->subdevice,
+				 data->card_name, data->device,
+				 data->subdevice,
 				 snd_pcm_stream_name(data->stream));
 		break;
 	default:
@@ -501,14 +506,16 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	}
 
 	if (!skip)
-		ksft_test_result(pass, "%s.%s.%d.%d.%d.%s\n",
+		ksft_test_result(pass, "%s.%s.%s.%d.%d.%s\n",
 				 test_class_name, test_name,
-				 data->card, data->device, data->subdevice,
+				 data->card_name, data->device,
+				 data->subdevice,
 				 snd_pcm_stream_name(data->stream));
 	else
-		ksft_test_result_skip("%s.%s.%d.%d.%d.%s\n",
+		ksft_test_result_skip("%s.%s.%s.%d.%d.%s\n",
 				 test_class_name, test_name,
-				 data->card, data->device, data->subdevice,
+				 data->card_name, data->device,
+				 data->subdevice,
 				 snd_pcm_stream_name(data->stream));
 
 	if (msg[0])
@@ -609,8 +616,8 @@ int main(void)
 					      conf->filename, conf->config_id);
 
 	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
-		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
-				 pcm->card, pcm->device, pcm->subdevice,
+		ksft_test_result(false, "test.missing.%s.%d.%d.%s\n",
+				 pcm->card_name, pcm->device, pcm->subdevice,
 				 snd_pcm_stream_name(pcm->stream));
 	}
 

---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240711-alsa-kselftest-board-name-e4a1add4cfa0

Best regards,
-- 
Mark Brown <broonie@kernel.org>


