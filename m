Return-Path: <linux-kselftest+bounces-13783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D22D9329A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1BEB21A4F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7523C19DF5D;
	Tue, 16 Jul 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVhFYD5B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB819DF52;
	Tue, 16 Jul 2024 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721141298; cv=none; b=R3FrbZMf3vj7y6RnvEJFnfEgK8g5M41XfU8W3QWXZU0uJ4P/NjECkYDEVC/qjGuOwE+vBBPjAjqn+bdcQ42ox9fC5gu5IOaiAWvgFDj6SFdiKxio9DNUkwWXqSo/TBNTrvws0K8kG0eKmnHCwKDTx6+V5BaRLNfniwqLfdUgz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721141298; c=relaxed/simple;
	bh=DmC/WspTlgsriMZ2NTJYnzCgocdcB1ekPIwsNxd+JAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHQAz4+ZFkbjFa/7JPIaig1WFIVAcz6uKVtkfOfnUJqlP1cqoyqJQBVydIQUr1zkNFZ6n5aLLcH0D2JAvGJyrG3rPGVz2o+Va0RVgWkuaJdS1lHDpVRcq21Lfecs49wumSRRXi+LDj0+a7eg00TDn7+2qbc6NuQI6vQfSXOdq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVhFYD5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32107C4AF09;
	Tue, 16 Jul 2024 14:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721141297;
	bh=DmC/WspTlgsriMZ2NTJYnzCgocdcB1ekPIwsNxd+JAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVhFYD5Bui+qOKznedbyTmIfvkNrdtvySAD3QWdA9MUt+H7mR7tf6V5OeJBKTEbYz
	 A2PkBKwTTI02MQqsd+BGyzrx8fRbF3YConF7kyRMJHGIoRi8MuzqkBDi4muSFVl40U
	 nJ5KxfaQMEYoGOVxJRnvIOTR12uk9qTfACXJ0B+0+Q+D+/NACfdU5St0nNc9XdaHh8
	 G5RgkAtZ9cY/zAKgYEPBrsSNVcQXthuE9Ag+nK/5OfKP3tzDlz4ap4QRiZng5/HgrJ
	 xp2vCGy1hxuTCB7xatEzrYgTOfH6LiKzvkFHUFPOGKVBgHQRYFR3vymuevYOBf1GYu
	 M5Ph0YBIWtaEQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 16 Jul 2024 15:47:59 +0100
Subject: [PATCH v2 1/2] kselftest/alsa: Use card name rather than number in
 test names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-alsa-kselftest-board-name-v2-1-60f1acdde096@kernel.org>
References: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
In-Reply-To: <20240716-alsa-kselftest-board-name-v2-0-60f1acdde096@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=14916; i=broonie@kernel.org;
 h=from:subject:message-id; bh=DmC/WspTlgsriMZ2NTJYnzCgocdcB1ekPIwsNxd+JAA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmlogrK9pGvGWInqCvKnmhlFv2DUZY0A47zCLgM1FB
 +24aXviJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZpaIKwAKCRAk1otyXVSH0MFQB/
 4/+Yv6pLBOajgRkBkdP37aQQwkVptm0RjJVdbC1PkQbpdeurV4dsdhTZTdsav4nrvIWlhZ4PtYRPti
 Tu7h8fgLB6/ZkgBks+h0fzcwBn6Xz+17yWN3AJDJlhfb5hzhSpxmjo1tZcINyNFieoFkuSrPgZa1hy
 +431duApa2puH8SKfE2whU9Oyxi8RPfTVXmli/D0vHd0BK6UygWj9+xLcfI0MFxLYr8NI/csLrpJu3
 CiDSnz/SiPoOxiX0AZzEE4FR6VaDBzFREuVUOwg9og0x9vKkugSRSQmPemykzRj+M64gmpvuM3Tox0
 apvlelsomRYZJzT99j5oNohOzxGFKf
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
more likely to be stable across runs. We use the card ID since it is
guaranteed to be unique by default, unlike the long name. There is still
some vulnerability to ordering issues if multiple cards with the same base
ID are present in the system but have separate dependencies but not all
drivers put distinguishing information in their long names.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 98 +++++++++++++++++++------------
 tools/testing/selftests/alsa/pcm-test.c   | 64 ++++++++++++++------
 2 files changed, 104 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 1c04e5f638a0..ba437f789768 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -33,6 +33,8 @@
 struct card_data {
 	snd_ctl_t *handle;
 	int card;
+	snd_ctl_card_info_t *info;
+	const char *card_name;
 	struct pollfd pollfd;
 	int num_ctls;
 	snd_ctl_elem_list_t *ctls;
@@ -91,8 +93,26 @@ static void find_controls(void)
 		err = snd_card_get_longname(card, &card_longname);
 		if (err != 0)
 			card_longname = "Unknown";
-		ksft_print_msg("Card %d - %s (%s)\n", card,
-			       card_name, card_longname);
+
+		err = snd_ctl_card_info_malloc(&card_data->info);
+		if (err != 0)
+			ksft_exit_fail_msg("Failed to allocate card info: %d\n",
+				err);
+
+		err = snd_ctl_card_info(card_data->handle, card_data->info);
+		if (err == 0) {
+			card_data->card_name = snd_ctl_card_info_get_id(card_data->info);
+			if (!card_data->card_name)
+				ksft_print_msg("Failed to get card ID\n");
+		} else {
+			ksft_print_msg("Failed to get card info: %d\n", err);
+		}
+
+		if (!card_data->card_name)
+			card_data->card_name = "Unknown";
+
+		ksft_print_msg("Card %d/%s - %s (%s)\n", card,
+			       card_data->card_name, card_name, card_longname);
 
 		/* Count controls */
 		snd_ctl_elem_list_malloc(&card_data->ctls);
@@ -389,16 +409,16 @@ static void test_ctl_get_value(struct ctl_data *ctl)
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
 
@@ -413,8 +433,8 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 		err = -EINVAL;
 
 out:
-	ksft_test_result(err >= 0, "get_value.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(err >= 0, "get_value.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static bool strend(const char *haystack, const char *needle)
@@ -431,7 +451,7 @@ static void test_ctl_name(struct ctl_data *ctl)
 {
 	bool name_ok = true;
 
-	ksft_print_msg("%d.%d %s\n", ctl->card->card, ctl->elem,
+	ksft_print_msg("%s.%d %s\n", ctl->card->card_name, ctl->elem,
 		       ctl->name);
 
 	/* Only boolean controls should end in Switch */
@@ -453,8 +473,8 @@ static void test_ctl_name(struct ctl_data *ctl)
 		}
 	}
 
-	ksft_test_result(name_ok, "name.%d.%d\n",
-			 ctl->card->card, ctl->elem);
+	ksft_test_result(name_ok, "name.%s.%d\n",
+			 ctl->card->card_name, ctl->elem);
 }
 
 static void show_values(struct ctl_data *ctl, snd_ctl_elem_value_t *orig_val,
@@ -682,30 +702,30 @@ static void test_ctl_write_default(struct ctl_data *ctl)
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
@@ -815,15 +835,15 @@ static void test_ctl_write_valid(struct ctl_data *ctl)
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
 
@@ -846,16 +866,16 @@ static void test_ctl_write_valid(struct ctl_data *ctl)
 
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
@@ -1027,15 +1047,15 @@ static void test_ctl_write_invalid(struct ctl_data *ctl)
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
 
@@ -1058,28 +1078,28 @@ static void test_ctl_write_invalid(struct ctl_data *ctl)
 
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
index de664dedb541..7abb21845e10 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -24,6 +24,8 @@ typedef struct timespec timestamp_t;
 
 struct card_data {
 	int card;
+	snd_ctl_card_info_t *info;
+	const char *name;
 	pthread_t thread;
 	struct card_data *next;
 };
@@ -35,6 +37,7 @@ struct pcm_data {
 	int card;
 	int device;
 	int subdevice;
+	const char *card_name;
 	snd_pcm_stream_t stream;
 	snd_config_t *pcm_config;
 	struct pcm_data *next;
@@ -167,6 +170,10 @@ static void find_pcms(void)
 	config = get_alsalib_config();
 
 	while (card >= 0) {
+		card_data = calloc(1, sizeof(*card_data));
+		if (!card_data)
+			ksft_exit_fail_msg("Out of memory\n");
+
 		sprintf(name, "hw:%d", card);
 
 		err = snd_ctl_open_lconf(&handle, name, 0, config);
@@ -182,14 +189,29 @@ static void find_pcms(void)
 		err = snd_card_get_longname(card, &card_longname);
 		if (err != 0)
 			card_longname = "Unknown";
-		ksft_print_msg("Card %d - %s (%s)\n", card,
-			       card_name, card_longname);
+
+		err = snd_ctl_card_info_malloc(&card_data->info);
+		if (err != 0)
+			ksft_exit_fail_msg("Failed to allocate card info: %d\n",
+				err);
+
+		err = snd_ctl_card_info(handle, card_data->info);
+		if (err == 0) {
+			card_data->name = snd_ctl_card_info_get_id(card_data->info);
+			if (!card_data->name)
+				ksft_print_msg("Failed to get card ID\n");
+		} else {
+			ksft_print_msg("Failed to get card info: %d\n", err);
+		}
+
+		if (!card_data->name)
+			card_data->name = "Unknown";
+
+		ksft_print_msg("Card %d/%s - %s (%s)\n", card,
+			       card_data->name, card_name, card_longname);
 
 		card_config = conf_by_card(card);
 
-		card_data = calloc(1, sizeof(*card_data));
-		if (!card_data)
-			ksft_exit_fail_msg("Out of memory\n");
 		card_data->card = card;
 		card_data->next = card_list;
 		card_list = card_data;
@@ -232,6 +254,7 @@ static void find_pcms(void)
 					pcm_data->card = card;
 					pcm_data->device = dev;
 					pcm_data->subdevice = subdev;
+					pcm_data->card_name = card_data->name;
 					pcm_data->stream = stream;
 					pcm_data->pcm_config = conf_get_subtree(card_config, key, NULL);
 					pcm_data->next = pcm_list;
@@ -294,9 +317,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 
 	desc = conf_get_string(pcm_cfg, "description", NULL, NULL);
 	if (desc)
-		ksft_print_msg("%s.%s.%d.%d.%d.%s - %s\n",
+		ksft_print_msg("%s.%s.%s.%d.%d.%s - %s\n",
 			       test_class_name, test_name,
-			       data->card, data->device, data->subdevice,
+			       data->card_name, data->device, data->subdevice,
 			       snd_pcm_stream_name(data->stream),
 			       desc);
 
@@ -352,9 +375,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
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
@@ -430,9 +453,9 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
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
@@ -491,9 +514,10 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
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
@@ -501,14 +525,16 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
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
@@ -609,8 +635,8 @@ int main(void)
 					      conf->filename, conf->config_id);
 
 	for (pcm = pcm_missing; pcm != NULL; pcm = pcm->next) {
-		ksft_test_result(false, "test.missing.%d.%d.%d.%s\n",
-				 pcm->card, pcm->device, pcm->subdevice,
+		ksft_test_result(false, "test.missing.%s.%d.%d.%s\n",
+				 pcm->card_name, pcm->device, pcm->subdevice,
 				 snd_pcm_stream_name(pcm->stream));
 	}
 

-- 
2.39.2


