Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1746D05F
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhLHJ5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 04:57:05 -0500
Received: from mail1.perex.cz ([77.48.224.245]:59486 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230129AbhLHJ5E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 04:57:04 -0500
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9FE12A0040;
        Wed,  8 Dec 2021 10:53:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9FE12A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1638957209; bh=JuYu2EwltgvZDeWCVSX3GmeTuEgcMK1XbrXNAuDm4x0=;
        h=From:To:Cc:Subject:Date:From;
        b=bHlthd0MPRQWoAbc6dM879KDexslkbjSW5Y34jFzMG/3p3uiCp4LSxstzyiVHD+B3
         JG164HoH0HRErXgUMf1RpE8nrnlrj4vHD0I4CaiYQiDd2IXjOvgAYGqoaiMGG0UVrB
         ltJKs8Bb6pvLRDYkm+h/Ij6gwYqpn+EbpexNEePM=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed,  8 Dec 2021 10:53:21 +0100 (CET)
From:   Jaroslav Kysela <perex@perex.cz>
To:     ALSA development <alsa-devel@alsa-project.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest: alsa: Use private alsa-lib configuration in mixer test
Date:   Wed,  8 Dec 2021 10:52:09 +0100
Message-Id: <20211208095209.1772296-1-perex@perex.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As mentined by Takashi Sakamoto, the system-wide alsa-lib configuration
may override the standard device declarations. This patch use the private
alsa-lib configuration to set the predictable environment.

Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org
Link: https://lore.kernel.org/alsa-devel/Ya7TAHdMe9i41bsC@workstation/
Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 tools/testing/selftests/alsa/mixer-test.c | 50 ++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index b87475fb7372..0f533707484c 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -46,22 +46,68 @@ struct ctl_data {
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
 
+#if !defined(SND_LIB_VER) || SND_LIB_VERSION < SND_LIB_VER(1, 2, 6)
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
 
@@ -71,7 +117,7 @@ void find_controls(void)
 			ksft_exit_fail();
 		}
 
-		err = snd_ctl_open(&card_data->handle, name, 0);
+		err = snd_ctl_open_lconf(&card_data->handle, name, 0, config);
 		if (err < 0) {
 			ksft_print_msg("Failed to get hctl for card %d: %s\n",
 				       card, snd_strerror(err));
@@ -147,6 +193,8 @@ void find_controls(void)
 			break;
 		}
 	}
+
+	snd_config_delete(config);
 }
 
 /*
-- 
2.31.1
