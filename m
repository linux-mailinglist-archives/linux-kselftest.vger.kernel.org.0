Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB2F73773E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 00:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFTWIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Jun 2023 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjFTWIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Jun 2023 18:08:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAB1988;
        Tue, 20 Jun 2023 15:08:49 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6C9A96606F5C;
        Tue, 20 Jun 2023 23:08:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687298927;
        bh=O6nBVgd9ap44QM7G+RNtH4uWhatsD2Et596Aj8S3xvg=;
        h=From:To:Cc:Subject:Date:From;
        b=Ttr8MNyzYdZv+GJsMJOL981JZeLwZ/t3Sjv+BcXrwDJdB0PI0e0P6CkCe458Usbux
         4jwGX0yH4RLDpX0TvwjlE44iCWq7oqjRF8o/aBIeM7X4VL0PJKbMp4KJpALSCAr/pB
         9L7ncbp5op9y9Fmq1QefLswM8Yvqv1eer7+Eca9Rlc9W1hHeS9U0xGfsVW3+YM2ENF
         4DgHN6LQj4qewFmHpZd9GLzOoRq3UzfsQ/QfflVWnYdbr2Frryd6WvMJ6La+lJMkI/
         AqZAujRDwtAxjQHMBmHSlXNpDu1wJhvzuM/Jkrrebs8giusGcbS9rWt8t+nDuYA81p
         lCgYQOTijMpiw==
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
Subject: [PATCH 0/2] kselftest/alsa: Decrease pcm-test duration to avoid timeouts
Date:   Tue, 20 Jun 2023 18:08:24 -0400
Message-ID: <20230620220839.2215057-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.41.0
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


This series decreases the pcm-test duration in order to avoid timeouts
by first moving the audio stream duration to a variable and subsequently
decreasing it.


Nícolas F. R. A. Prado (2):
  kselftest/alsa: pcm-test: Move stream duration and margin to variables
  kselftest/alsa: pcm-test: Decrease stream duration from 4 to 2 seconds

 tools/testing/selftests/alsa/pcm-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.41.0

