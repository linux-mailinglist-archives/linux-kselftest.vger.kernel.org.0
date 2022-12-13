Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF2A64BC01
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Dec 2022 19:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiLMSdF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Dec 2022 13:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiLMScz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Dec 2022 13:32:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BDDFFF;
        Tue, 13 Dec 2022 10:32:52 -0800 (PST)
Received: from localhost.localdomain (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 921D06602C3C;
        Tue, 13 Dec 2022 18:32:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670956370;
        bh=in4KxuaodXSv+hPUQOAviPmjlubzU66m7rSKlYo79rE=;
        h=From:To:Cc:Subject:Date:From;
        b=DkBhhHO54ulTMHSX2348dRKJx3krNKGcmpQtCRz1cUkCeXPGFlVInA+k3o6+xdWAi
         n5fIszy0mo7oxsBy5NAlyvHV3qONLScqbsnzVmv7OshmjKWHXWAZ7C+KfsTMUCBHMh
         BuVtnuqp1IBl9ew97pcDoomSZmuDcYFIdMAMH8j8WF5utuizi0U9f8Ip4nwMBhjmnW
         xnfhVK5jxDMJ9pKJhirwt+X6lB8TmcM8BtF+a5ETMryp7Y8ralDmmXRDjQtP7+Nsjx
         Z2SMfwYVRpTob+ENrMDqJ8BEFWRHEds40ykK52OImDd+jarHDufDFviKlJv31wesYF
         nk3HF8QX4O9yQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftest/alsa: Increase kselftest timeout
Date:   Tue, 13 Dec 2022 15:32:42 -0300
Message-Id: <20221213183242.1908249-1-nfraprado@collabora.com>
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

The default timeout for kselftests is 45 seconds, but pcm-test can take
longer than that to run depending on the number of PCMs present on a
device.

As a data point, running pcm-test on mt8192-asurada-spherion takes about
1m15s.

Set the timeout to 10 minutes, which should give enough slack to run the
test even on devices with many PCMs.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/alsa/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/alsa/settings

diff --git a/tools/testing/selftests/alsa/settings b/tools/testing/selftests/alsa/settings
new file mode 100644
index 000000000000..a62d2fa1275c
--- /dev/null
+++ b/tools/testing/selftests/alsa/settings
@@ -0,0 +1 @@
+timeout=600
-- 
2.39.0

