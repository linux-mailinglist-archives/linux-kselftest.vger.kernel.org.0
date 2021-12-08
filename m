Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994B646DD7F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 22:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbhLHVVd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 16:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhLHVVd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 16:21:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E05C061746
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 13:18:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71BAFB822E0
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 21:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D02C341C7;
        Wed,  8 Dec 2021 21:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638998278;
        bh=Bc0lu4qiZTB48rR3MkFZ7RgJ7f79eVaOiiX8CvqQB1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vh4u+Eu4vm8Dp7cgvC5QdxxfJSQeFy1z/Cc77n8NfN6C2ibgoUg5l1SPLfVZEB643
         XRlMeustlQOG5mUbUshrZINcfgVAQhBY3hmBmVgUCDKiEXEs8WKiHPIQ6pBBH2urkE
         9WRjsE1R+BeffuerhQQq4kxaYmW2TTfdhDqKpX7b8aoEf0z2OyR7R2/vpca86Qv9m1
         72+2WGVjwSJZN/X/8Z1bjCzE0xfHrXzHG9xYBtj+IgiPTMlZcA/u1TWxOJJ5UNgCQk
         qwUctuh5lwiXynZ6Oz6o8guVFb0t7rYa0JLLEjSQWr/e7S8axCAhonWvjRQSUMeSOT
         aXrfR5G/AdQqA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 3/3] kselftest: alsa: Use private alsa-lib configuration in mixer test
Date:   Wed,  8 Dec 2021 21:17:45 +0000
Message-Id: <20211208211745.533603-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211208211745.533603-1-broonie@kernel.org>
References: <20211208211745.533603-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2881; i=broonie@kernel.org; h=from:subject; bh=vfQBJ8nhILzQt7bp6al4mErrBsurvMvk0ZXwkvtk2YI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhsSD4gULYOlkDuYb0Oa/ILDyKH5LnDzv5YJpnB9Lk 4S/vYlSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbEg+AAKCRAk1otyXVSH0PMeB/ 0ZM9xwVWpiKaTWaPx8YOiLaCs0XUSLy8wUEBqh08UYL+XBdlckQ9Q2rg81SZP+08HCNqBb6Qs/DBVy Hfhkbp9ao/w36vDWtYBxO+BPh1RJQ7bjtXhQGYtCXRE3mL98mnuQmfHM6SxXMk77xV0u7CA33V9NMi nw19DO9Q3JH+cZzrLPT5ZG2J1e8TKACvVuVmk/8uWDWoOwNVE+lMv0NTmfm2905B2+5P/v9VrF7vyQ mRTGD/Zsd91wOi6bSSDvKeJcTu9YSTPOkXr29tRxukXBF1ffHIiBTErmUrqpDbrFa4JOVkmgZw95j7 2uRXP/bdaJcdbUo3xEvoi+lfpkCGMr
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jaroslav Kysela <perex@perex.cz>

As mentined by Takashi Sakamoto, the system-wide alsa-lib configuration
may override the standard device declarations. This patch use the private
alsa-lib configuration to set the predictable environment.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20211208095209.1772296-1-perex@perex.cz
[Restructure version test to keep the preprocessor happy -- broonie]
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 56 ++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 171d33692c7b..a177676c530e 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -46,22 +46,74 @@ struct ctl_data {
 	struct ctl_data *next;
 };
 
+static const char *alsa_config =
+"ctl.hw {\n"
+"	@args [ CARD ]\n"
+"	@args.CARD.type string\n"
+"	type hw\n"
+"	card $CARD\n"
+"}\n"
+;
+
 int num_cards = 0;
 int num_controls = 0;
 struct card_data *card_list = NULL;
 struct ctl_data *ctl_list = NULL;
 
+#ifdef SND_LIB_VER
+#if SND_LIB_VERSION >= SND_LIB_VER(1, 2, 6)
+#define LIB_HAS_LOAD_STRING
+#endif
+#endif
+
+#ifndef LIB_HAS_LOAD_STRING
+int snd_config_load_string(snd_config_t **config, const char *s, size_t size)
+{
+	snd_input_t *input;
+	snd_config_t *dst;
+	int err;
+
+	assert(config && s);
+	if (size == 0)
+		size = strlen(s);
+	err = snd_input_buffer_open(&input, s, size);
+	if (err < 0)
+		return err;
+	err = snd_config_top(&dst);
+	if (err < 0) {
+		snd_input_close(input);
+		return err;
+	}
+	err = snd_config_load(dst, input);
+	snd_input_close(input);
+	if (err < 0) {
+		snd_config_delete(dst);
+		return err;
+	}
+	*config = dst;
+	return 0;
+}
+#endif
+
 void find_controls(void)
 {
 	char name[32];
 	int card, ctl, err;
 	struct card_data *card_data;
 	struct ctl_data *ctl_data;
+	snd_config_t *config;
 
 	card = -1;
 	if (snd_card_next(&card) < 0 || card < 0)
 		return;
 
+	err = snd_config_load_string(&config, alsa_config, strlen(alsa_config));
+	if (err < 0) {
+		ksft_print_msg("Unable to parse custom alsa-lib configuration: %s\n",
+			       snd_strerror(err));
+		ksft_exit_fail();
+	}
+
 	while (card >= 0) {
 		sprintf(name, "hw:%d", card);
 
@@ -69,7 +121,7 @@ void find_controls(void)
 		if (!card_data)
 			ksft_exit_fail_msg("Out of memory\n");
 
-		err = snd_ctl_open(&card_data->handle, name, 0);
+		err = snd_ctl_open_lconf(&card_data->handle, name, 0, config);
 		if (err < 0) {
 			ksft_print_msg("Failed to get hctl for card %d: %s\n",
 				       card, snd_strerror(err));
@@ -137,6 +189,8 @@ void find_controls(void)
 			break;
 		}
 	}
+
+	snd_config_delete(config);
 }
 
 /*
-- 
2.30.2

