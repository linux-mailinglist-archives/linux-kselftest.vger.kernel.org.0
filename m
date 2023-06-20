Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB79737742
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 00:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjFTWI7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 18:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjFTWIy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 18:08:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234311729;
        Tue, 20 Jun 2023 15:08:53 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 274586606F8A;
        Tue, 20 Jun 2023 23:08:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687298932;
        bh=g1Ge7OS0fr37jsbP/Xrz0cMOpZ9QFiuqkEuRXr45wpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=keBZDB/qPPd4GgrMzo8SeAUd+1s5SQOLo/TyAovssps9kWDPo9TVSne5g5X/uY1QK
         wWAPE4tW9UVGnYJCPu/Fb9LATyCXwIqhAZ+gFUza0WZ5TnmP1RoNiFesbl8iZ3+4Q7
         sLRk7KPxDV4hhxPMcyXxHzUFM6z6HHc/vNx05dEMvUh1PjWuK3tqillU2CLebZ4xIK
         2gDQMMERY8VDHZEnVg8RlHEbytH5hbGoLltCuIzD4sIjfFDw8XC+6mDFB5/YC3sIon
         UNplbzV0veEY/S+bytao02xVIS7gQyV8JATXT90lfovZn9mMWx2ev1JSB2zYxopbQ9
         Ooi4YfeZYPl8A==
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
Subject: [PATCH 2/2] kselftest/alsa: pcm-test: Decrease stream duration from 4 to 2 seconds
Date:   Tue, 20 Jun 2023 18:08:26 -0400
Message-ID: <20230620220839.2215057-3-nfraprado@collabora.com>
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

Currently test_pcm_time() streams audio on each PCM with each
configuration for 4 seconds. This time can add up, and with the current
45 second kselftest timeout, some machines like mt8192-asurada-spherion
can't even run to completion. Lower the duration to 2 seconds to cut the
test duration in half, without reducing the test coverage.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

 tools/testing/selftests/alsa/pcm-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index a2b6db33b513..de42fc7e9b53 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -258,7 +258,7 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 			  const char *test_name, snd_config_t *pcm_cfg)
 {
 	char name[64], key[128], msg[256];
-	const int duration_s = 4, margin_ms = 100;
+	const int duration_s = 2, margin_ms = 100;
 	const int duration_ms = duration_s * 1000;
 	const char *cs;
 	int i, err;
-- 
2.41.0

