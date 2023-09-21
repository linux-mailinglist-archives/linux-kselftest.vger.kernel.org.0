Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52DBD7AA2B5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Sep 2023 23:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjIUVcM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Sep 2023 17:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjIUVb5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Sep 2023 17:31:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415DBAFC1E;
        Thu, 21 Sep 2023 14:08:06 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E071366072A2;
        Thu, 21 Sep 2023 22:08:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695330485;
        bh=4WzhXX1uaBfz0iPkLduXsSe9s+j07QrDW6eVjUz4YQc=;
        h=From:To:Cc:Subject:Date:From;
        b=Xq+7sEqKMT1vt4K2chwQVwiFPZh87u8UZcHR85YtRTxEST+m/bOEzap9pEDI/jlvN
         Bc2E4iawedB1CvcQfsWQ+SdjoYUMhCQ6w5uIybBe4T4KSyGY2ZH3qEyepqXCq8TylO
         REOdNMAuaQ95GP79HV1mStHUe0Zb1hued3xRm6AhJgpipF59NKVzsvi9fe2x3b4p0Y
         dWp3gWQsUx+IbolK/IvPrioWEF97/lKb6ENurhUFp9thNde9DqTs/n15P4CGbvoyO5
         w/glxgy8t7xhjp2/QuKtQ1ZHA2VftQ23iKelU92xiazICGo+rMJeA9B2Wq76p6J1Am
         p6bhSKYwpqY8g==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [RFC PATCH] kselftest/alsa: Add configuration for mt8192-asurada-spherion
Date:   Thu, 21 Sep 2023 17:07:42 -0400
Message-ID: <20230921210800.230330-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a configuration file for the mt8192-asurada-spherion platform to
validate that the card and PCMs used for speaker, headphone and
microphones (internal and headset) are correctly exposed to userspace.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Sending this patch as RFC because I'd like to ask a question. What would
be the most suitable entry to identify the card in a future-proof way?

I have used the card ID here, but given that it is generated at runtime
with the purpose of being unique among the cards present on the system
(and I couldn't find any documentation that states it is stable), I'm
not sure it is supposed to be relied on.

The card ID is derived from the driver name or card longname, which are
themselves stable given userspace (alsa-ucm-conf) relies on them, but
those aren't exposed through sysfs so I can't check for them here.

Another option would be to look for the card number 0. But in the (very
unlikely) case that another soundcard would be connected to the platform
and detected first during boot, it wouldn't work.

Yet another option would be to look at the device's uevent file for
the compatible as defined in the Devicetree, ie

        path "device/uevent"
        regex "OF_COMPATIBLE_.*=mediatek,mt8192_mt6359_rt1015p_rt5682"

Though it is possible (in rare circumstances) for the compatible in the
Devicetree to need to be updated to enable a driver behavior that isn't
backward compatible.

I realize most of these issues are very rare and probably won't ever
occur, but it seems worthwhile to use the most future-proof mechanism
available to identify the card to avoid unnecessary maintenance, even
more so considering the example would be followed by future
configurations.

Thanks,
Nícolas

 .../alsa/conf.d/mt8192-asurada-spherion.conf  | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 tools/testing/selftests/alsa/conf.d/mt8192-asurada-spherion.conf

diff --git a/tools/testing/selftests/alsa/conf.d/mt8192-asurada-spherion.conf b/tools/testing/selftests/alsa/conf.d/mt8192-asurada-spherion.conf
new file mode 100644
index 000000000000..6a7e15dc17da
--- /dev/null
+++ b/tools/testing/selftests/alsa/conf.d/mt8192-asurada-spherion.conf
@@ -0,0 +1,32 @@
+sysfs [
+	{
+		path "firmware/devicetree/base/compatible"
+		regex "google,spherion"
+	}
+]
+
+card.mt8192 {
+	sysfs [
+		{
+			path "id"
+			regex "mt8192mt6359rt1"
+		}
+	]
+
+	pcm.0.0 {
+		PLAYBACK {
+		}
+	}
+	pcm.3.0 {
+		PLAYBACK {
+		}
+	}
+	pcm.10.0 {
+		CAPTURE {
+		}
+	}
+	pcm.11.0 {
+		CAPTURE {
+		}
+	}
+}
-- 
2.42.0

