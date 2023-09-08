Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05916798C57
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjIHSOe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 14:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbjIHSOd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 14:14:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136FC1FEA;
        Fri,  8 Sep 2023 11:13:56 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C384F66072B9;
        Fri,  8 Sep 2023 19:12:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694196768;
        bh=58aqhulC4fc6Pn7pCzoNspVmthf7zQNQ+CuztnXMM9k=;
        h=From:To:Cc:Subject:Date:From;
        b=D3/TDBhLtJg+v4QCDK7vby4V4RgDhW59/2BiowmTy3GpcnlDjbyicbjTnYuXicxEw
         Y3HdFg7/iU+AW7hn6vfue4HXulIbjdLeNSOvrlJjMtWG2orbl9SS4g253yI2zewFsR
         4ubUq5xRQzqU7rhz0+C+JAL7/52MaDdE27nJX/TdCHVWKJaIdUJ+1Xus1l4mnpsuNI
         jSy5GprjgCaIWa7MIelrOWKCZobhBdVer6TQNpO42wuXZYvK/epcHg139TYdHhkZrN
         rJCbVR3nLXC6KLoJ3RDlACvxkdLGlEcwKm8HPQKTW5Muz4OMnEVcnDX/VO4qw5gxTB
         F/A9njH6ylDcw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest/alsa: Mark test plan as skipped when no cards are available
Date:   Fri,  8 Sep 2023 14:12:40 -0400
Message-ID: <20230908181242.95714-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When no soundcards are available, it won't be possible to run any tests.
Currently, when this happens, in both pcm-test and mixer-test, 0
tests are reported, and the pass exit code is returned. Instead, call
ksft_exit_skip() so that the whole test plan is marked as skipped in the
KTAP output and it exits with the skip exit code.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/alsa/mixer-test.c | 7 +++++--
 tools/testing/selftests/alsa/pcm-test.c   | 7 +++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index c95d63e553f4..8f45c15a5667 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -66,8 +66,11 @@ static void find_controls(void)
 	char *card_name, *card_longname;
 
 	card = -1;
-	if (snd_card_next(&card) < 0 || card < 0)
-		return;
+	err = snd_card_next(&card);
+	if (err < 0)
+		ksft_exit_skip("Couldn't open first soundcard. rc=%d\n", err);
+	if (card < 0)
+		ksft_exit_skip("No soundcard available\n");
 
 	config = get_alsalib_config();
 
diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 2f5e3c462194..74d9cf8b5a69 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -161,8 +161,11 @@ static void find_pcms(void)
 	snd_pcm_info_alloca(&pcm_info);
 
 	card = -1;
-	if (snd_card_next(&card) < 0 || card < 0)
-		return;
+	err = snd_card_next(&card);
+	if (err < 0)
+		ksft_exit_skip("Couldn't open first soundcard. rc=%d\n", err);
+	if (card < 0)
+		ksft_exit_skip("No soundcard available\n");
 
 	config = get_alsalib_config();
 
-- 
2.42.0

