Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0225C63CC2D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiK3AHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231314AbiK3AHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:07:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE1A7044E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:07:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58B7E6188A
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:07:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6097BC433B5;
        Wed, 30 Nov 2022 00:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766820;
        bh=Kn+BswH7rAycY9VeynvDcjRtACgC1wb2IYiNOSjS+Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F/iVjO3eQ6O5SgF4L+pW9wQc9nwBwqAboxcJv9JEJRFeJ/drWcxPH5BBlqDfHhqA3
         kGABAq+BeP9U+y+XPW8m1PQszD+9pGLFw3E5MLA6JaFZM1jZupLKV73IbVEgXhYGlM
         BVPqPjREhoNqRbxPga1qUP247txfym8MPKg94sFUtigBGDRpoY7qDp51eR5Uroyjrm
         KwH3JtqnreECU67fSnB7BY6tnQ0R4wMJ4kg9bf0pL6RJ5AlxNR4bqA3LEqQrJ8xikp
         miueaeBcBuTclKcS4XBE5C0KrbVkMRa/opcJmVUE+Uo6q/Oedb7+IGrJy6s9UQkYMw
         2Hnf6XyRvGCnQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/6] kselftest/alsa: Don't any configuration in the sample config
Date:   Wed, 30 Nov 2022 00:06:06 +0000
Message-Id: <20221130000608.519574-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=broonie@kernel.org; h=from:subject; bh=Kn+BswH7rAycY9VeynvDcjRtACgC1wb2IYiNOSjS+Q8=; b=owGbwMvMwMWocq27KDak/QLjabUkhuS2eXnZc4R1tCP8b77YUvVbKE7uxMflSW0cHPYavxjNPyp4 eEl0MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATUShg/2eYF78weJ3a86ZGpnfu5i /kv7SciZHoYFb9teXqbmZJzc96i4qK6hNql027XRo8//srOTlb75gTF0SzU+3Xm9ma+mczPNqrJLXF rdblc+xU3X/rW+/mf5leOKPQJ/q19mORXQ5BARZ/ysr0OKUFWs+HGDxLirX4zbcgMtju8Ruxt2+/GN vPcWl9KMkdduSYkImZ0/vAFbwbxZsDorsX8BxpfhLAX7OuM+5AYZNW0Jrf2Svr+lcXBLo2vrz4WuIE V6+QzM974ldOsHJpT3u69IBIbwWzaBiL5KKn08V38vAJa8dtqpPfq2stFb3i5VyPA15BU7ZvfbDJ7/ nzD/Lsj+4U8R7/XNARmCVSd3ItAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The values in the one example configuration file we currently have are the
default values for the two tests we have so there's no need to actually set
them. Comment them out as examples, with a rename for the tests so that we
can update the tests in the code more easily.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf  | 35 ++++++++++---------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
index 0a83f35d43eb..9eca985e0c08 100644
--- a/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
+++ b/tools/testing/selftests/alsa/conf.d/Lenovo_ThinkPad_P1_Gen2.conf
@@ -39,22 +39,25 @@ card.hda {
 	#
 	pcm.0.0 {
 		PLAYBACK {
-			test.time1 {
-				access RW_INTERLEAVED	# can be omitted - default
-				format S16_LE		# can be omitted - default
-				rate 48000		# can be omitted - default
-				channels 2		# can be omitted - default
-				period_size 512
-				buffer_size 4096
-			}
-			test.time2 {
-				access RW_INTERLEAVED
-				format S16_LE
-				rate 48000
-				channels 2
-				period_size 24000
-				buffer_size 192000
-			}
+			#
+			# Uncomment to override values for specific tests
+			#
+			#test_name1 {
+			#	access RW_INTERLEAVED
+			#	format S16_LE
+			#	rate 48000
+			#	channels 2
+			#	period_size 512
+			#	buffer_size 4096
+			#}
+			#test_name2 {
+			#	access RW_INTERLEAVED
+			#	format S16_LE
+			#	rate 48000
+			#	channels 2
+			#	period_size 24000
+			#	buffer_size 192000
+			#}
 		}
 		CAPTURE {
 			# use default tests, check for the presence
-- 
2.30.2

