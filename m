Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C36AC571
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Mar 2023 16:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCFPfE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Mar 2023 10:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCFPeV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Mar 2023 10:34:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E1B746;
        Mon,  6 Mar 2023 07:33:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D13E961013;
        Mon,  6 Mar 2023 15:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBBEBC433EF;
        Mon,  6 Mar 2023 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678116820;
        bh=kjkLcMTHMhUQo+1dss9UtQxijigDsuNvBFLdj/WoWN4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=e+wX/eVsuUJwCEoIWhFLHcOcuml9DySTPbsOllizEjQo1TjE5Bywzoi63J8GJjCzN
         TLiC1qgsF6kb9nDgF4k2VfYG2rCL4aBpYzN3mkgvT9vfEGk95EULm6aG5ZP/AM9KKv
         I6CA3hVLTYrI/QdlOC3+KoWlzkli/B3S9qXDbpoXEja5R7T6KD3JrPgYM9LccxR/IG
         KUfcMa1lnDiueTriDUmjA8cRUjxxhAq3ySSnyQOMEgjGMGvXrQHTeILZARmHzmMnKI
         4c2M5TZP61e5UlNXT7ZRJCLrVFGMcm+jLWIKetMIBHI+fbtnIt1V5wsjNnEopAEKgV
         iZvNHfqquevng==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 06 Mar 2023 15:33:29 +0000
Subject: [PATCH 2/2] kselftest/alsa: Log card names during startup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230223-alsa-log-ctl-name-v1-2-ac0f10cc4db2@kernel.org>
References: <20230223-alsa-log-ctl-name-v1-0-ac0f10cc4db2@kernel.org>
In-Reply-To: <20230223-alsa-log-ctl-name-v1-0-ac0f10cc4db2@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kjkLcMTHMhUQo+1dss9UtQxijigDsuNvBFLdj/WoWN4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBgfOjSTU6E4IeqLtriafYbjJ+o8/50y5yBIJdGX1
 pRzA5bGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAYHzgAKCRAk1otyXVSH0A0qB/
 9cwhfgE/NUT2kBgs5Adm3g8+H0MgXxeiR3TOPMfeXM+L9An6QrYirbEneOjFDZ+l06jguu7mkg2FHS
 eTm+KKN6FSizi9W1M5DCCbv0DojvNKD4MSI2WrCYkEDhM5kSTDjsnYSll97FCTURSkD+Vus4sCl/hi
 wRQf8HC8o6rRerZjFc58AZNz/L0A8JcuSfg8j11IGILtpry3YC1TPDFARXTllbPjdtEu4bkbVD3V6e
 p95SgsJyJhSZmFsnBMBTP+fQYAU3Qj7y96cWcxHv03Jl0+S1GEz+bGQ5ilG6agEstOBU0WM0jYmfKI
 d701WCf5n/wMXeH/9dd3lU1QncEyJ1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It can be helpful to know which card numbers apply to which cards in a
multi-card system so log the card names when we start the test programs.
People looking at the logs may not have direct access to the systems being
tested.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/mixer-test.c | 10 ++++++++++
 tools/testing/selftests/alsa/pcm-test.c   | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index 12f58c9c17ab..f9307bb0e453 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -63,6 +63,7 @@ static void find_controls(void)
 	struct card_data *card_data;
 	struct ctl_data *ctl_data;
 	snd_config_t *config;
+	char *card_name, *card_longname;
 
 	card = -1;
 	if (snd_card_next(&card) < 0 || card < 0)
@@ -84,6 +85,15 @@ static void find_controls(void)
 			goto next_card;
 		}
 
+		err = snd_card_get_name(card, &card_name);
+		if (err != 0)
+			card_name = "Unknown";
+		err = snd_card_get_longname(card, &card_longname);
+		if (err != 0)
+			card_longname = "Unknown";
+		ksft_print_msg("Card %d - %s (%s)\n", card,
+			       card_name, card_longname);
+
 		/* Count controls */
 		snd_ctl_elem_list_malloc(&card_data->ctls);
 		snd_ctl_elem_list(card_data->handle, card_data->ctls);
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 58b525a4a32c..d73600e93e83 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -149,6 +149,7 @@ static void missing_devices(int card, snd_config_t *card_config)
 static void find_pcms(void)
 {
 	char name[32], key[64];
+	char *card_name, *card_longname;
 	int card, dev, subdev, count, direction, err;
 	snd_pcm_stream_t stream;
 	struct pcm_data *pcm_data;
@@ -175,6 +176,15 @@ static void find_pcms(void)
 			goto next_card;
 		}
 
+		err = snd_card_get_name(card, &card_name);
+		if (err != 0)
+			card_name = "Unknown";
+		err = snd_card_get_longname(card, &card_longname);
+		if (err != 0)
+			card_longname = "Unknown";
+		ksft_print_msg("Card %d - %s (%s)\n", card,
+			       card_name, card_longname);
+
 		card_config = conf_by_card(card);
 
 		card_data = calloc(1, sizeof(*card_data));

-- 
2.30.2

