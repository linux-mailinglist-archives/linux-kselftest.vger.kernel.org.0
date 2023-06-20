Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EAB737740
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFTWIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 18:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjFTWIw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 18:08:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213401730;
        Tue, 20 Jun 2023 15:08:51 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19D056606F70;
        Tue, 20 Jun 2023 23:08:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687298929;
        bh=oc8eRilh+UL0gC7vlGxWO3QMKLhgfG0/Q1DqxC6qW1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgGTpQXDGsH0OD9JD+Nzxs0bnMhhciLwkp5WIGj2hR1zoh0/1+YRYjc587FRHxGjq
         V+fgot0OR4R+WL8FMkWEZU0NRDcTBNe79beD8IKJGFyD5jrsLcWhnTlgZETmu/0gyw
         FbePyK0jXkQrdD2oqpAD0A/yofnyqUhZSCUPtiIwKonnusW8tPn9esgU8KK0XcfF3L
         t33x3DByTCf+UclqDEGYM+5BcHCcDczAw06p3sbF/T7wT34jD60cRPO8Tn6oOdlc/z
         KA7YJVXA3DdGO4syUyOB8ZwaFx+ZQR7BJL5Y3zSOJgEOuIYr1fVz4OgsAnxeSbRA7m
         1o+1hTSpcIIdw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] kselftest/alsa: pcm-test: Move stream duration and margin to variables
Date:   Tue, 20 Jun 2023 18:08:25 -0400
Message-ID: <20230620220839.2215057-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620220839.2215057-1-nfraprado@collabora.com>
References: <20230620220839.2215057-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The duration to stream for and time margin to consider the stream failed
are currently hardcoded values. Move them to variables so they can be
reused and more easily changed.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/alsa/pcm-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 3e390fe67eb9..a2b6db33b513 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -258,6 +258,8 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			  const char *test_name, snd_config_t *pcm_cfg)
 {
 	char name[64], key[128], msg[256];
+	const int duration_s = 4, margin_ms = 100;
+	const int duration_ms = duration_s * 1000;
 	const char *cs;
 	int i, err;
 	snd_pcm_t *handle = NULL;
@@ -442,7 +444,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	skip = false;
 
 	timestamp_now(&tstamp);
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < duration_s; i++) {
 		if (data->stream == SND_PCM_STREAM_PLAYBACK) {
 			frames = snd_pcm_writei(handle, samples, rate);
 			if (frames < 0) {
@@ -472,8 +474,8 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 
 	snd_pcm_drain(handle);
 	ms = timestamp_diff_ms(&tstamp);
-	if (ms < 3900 || ms > 4100) {
-		snprintf(msg, sizeof(msg), "time mismatch: expected 4000ms got %lld", ms);
+	if (ms < duration_ms - margin_ms || ms > duration_ms + margin_ms) {
+		snprintf(msg, sizeof(msg), "time mismatch: expected %dms got %lld", duration_ms, ms);
 		goto __close;
 	}
 
-- 
2.41.0

