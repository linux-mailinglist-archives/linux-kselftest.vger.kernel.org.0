Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B11C47097A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 19:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245673AbhLJS6D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 13:58:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54134 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245672AbhLJS6C (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 13:58:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE825B829A5
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 18:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8938CC341D9;
        Fri, 10 Dec 2021 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639162465;
        bh=Fc/bw/unbr6pnYpOf0Jjsuop4bTiapC8pJ+EK6pHeBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLrz6r9nnoGmXoe762JzfsWRLttaOjz8jhUOX6/2ux6uJSslbWvRZWHXfhHgqJE8U
         vbUIvMh0n0AWzj5h+lApetcoLu9ZEoOlnnxP7jOXfbgxB+WppnOYOXWDiflvm/235h
         NWUO7RuqIdHtfK0jFPndDQhZNcQ/f6/COL+MF2ThKuP0LeksbDGfU8Z7tHH0RVqMdD
         vaio32ASwWfCJBOySTAQNUhcZQ4rzguUihEj91lZ4tnx6cFSpBKYRWWKB5l2G3TQsA
         HROo0xcG9W89+m0DObWkibJ7r0vI+SNpRRI59Lr4p98OJLEQldz8hkTzx+q13K6Rls
         59QHqmVo7R24g==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 3/3] kselftest: alsa: Use private alsa-lib configuration in mixer test
Date:   Fri, 10 Dec 2021 18:54:10 +0000
Message-Id: <20211210185410.740009-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210185410.740009-1-broonie@kernel.org>
References: <20211210185410.740009-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=broonie@kernel.org; h=from:subject; bh=f0TLcCAP2UDRiRjGIjxFa6TawJKyod1pyghrkAWhsyI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhs6JQRGy7DfGWwaa5gkm3hK5ZpTPZcayNQSK9hRu8 3R99H7mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYbOiUAAKCRAk1otyXVSH0AK9B/ 4ox4tAKU+y2cWKJQacX1fqP+lKoo+yZNo84EoHIvJMNsQjsRYbJO6weIqo9PytnHOOuohL1Ahx3zv4 vjuagkWYSH51P/cRQ0PLHcJhowJa3jmzvQJNKzFy20A3028qMy/L8XhXp2vLjHR9Gr+wCPnNGeAcns X3/zHqGjbK7jWubucjKC9pV0D1okiJFOvvg+ro1MIn54JkAjcVK3lkdkO9GUjwf1FYsvAngnqHn3Ni xB5G5RlqSTG9XoBlAPwigrGKzTgKUCVesBJevU0tn6AmW9t0mrp3tXmP7G9cX8/u2RQxBJuIRrdU6o FEwx5h9rG5ZTW5/kla+hVM7e65EMjh
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
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 56 ++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index f65a9046e708..b798a76f6825 100644
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

