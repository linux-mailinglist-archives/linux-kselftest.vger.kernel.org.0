Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156064C9AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Dec 2022 14:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238416AbiLNNEX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Dec 2022 08:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238495AbiLNNEI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Dec 2022 08:04:08 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4C7285;
        Wed, 14 Dec 2022 05:04:05 -0800 (PST)
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A54B76602C4E;
        Wed, 14 Dec 2022 13:04:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671023043;
        bh=GZEykBLRY6xcsFpVXkvhdUKjKSjymjAXbtZtme1Q4E8=;
        h=From:To:Cc:Subject:Date:From;
        b=L3MWub+8UXzsNySJvlrzmj27f8o4iAeJkAW/wJr1oroFMO3CU1WQ3qUge9+bbPzNe
         Ae11AYDf73jO3Gaw8m2dafrgJJYi71g03hapgtNhMmQ64q3bP+nR26mcykZWFbaQwT
         mZ79vee70XXhrT34BpQKMxvtvzYLnZ7BOU81Go0bGBQV2H16WcrwAkMSrfodIG7m5V
         xJD0cjymPN3rfA3qla4hullm7nSo3XLnLj/ODU4zsHsnnCQq90mQ18pSlKAQM714kx
         28FQ+y+AV/F3TJ/L0Q6zGi9BBMeJM0GKKSSX5X8A8+5BUIQm4qZVJPYgSXL6DZg9Mw
         FqXop6nFTqcEA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] kselftest/alsa: Increase kselftest timeout
Date:   Wed, 14 Dec 2022 10:03:53 -0300
Message-Id: <20221214130353.1989075-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default timeout for kselftests is 45 seconds, but that isn't enough
time to run pcm-test when there are many PCMs on the device, nor for
mixer-test when slower control buses and fancier CODECs are present.

As data points, running pcm-test on mt8192-asurada-spherion takes about
1m15s, and mixer-test on rk3399-gru-kevin takes about 2m.

Set the timeout to 4 minutes to allow both pcm-test and mixer-test to
run to completion with some slack.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Reduced timeout from 10 to 4 minutes
- Tweaked commit message to also mention mixer-test and run time for
  mixer-test on rk3399-gru-kevin

 tools/testing/selftests/alsa/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/alsa/settings

diff --git a/tools/testing/selftests/alsa/settings b/tools/testing/selftests/alsa/settings
new file mode 100644
index 000000000000..b478e684846a
--- /dev/null
+++ b/tools/testing/selftests/alsa/settings
@@ -0,0 +1 @@
+timeout=240
-- 
2.39.0

