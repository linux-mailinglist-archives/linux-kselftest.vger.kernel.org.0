Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C563F5F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiLARLE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiLARLE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E08A897B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:11:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F01CE62098
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:11:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028FAC433C1;
        Thu,  1 Dec 2022 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914662;
        bh=Kn+BswH7rAycY9VeynvDcjRtACgC1wb2IYiNOSjS+Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CkRtaRQp6x7iwTvF6XjTffEjvgtpwLH/Se4dvQttOtl6J4dv5C99vVHBYoYYNTSDQ
         92iI4DDI1OPIJU2mTOqNcJ6K+4HMdGLROxTbDCFqj6TkiOh5/jHVCVI1MBSwv/MRN+
         A1nWEq9Bm9sC3zhgHywWgPEpTle6Wt/DvvhRLPlIc8+70iORa3UCY+XGasu5hT2ynT
         AIOSC5CqZDxTNdrKCO+tdYMnuxan7Flc5wt6F8qYkl5bOovsj7geYBhYApjr+ePlMw
         0curbL4zE5cMwEfxhMPs0JExBqU8q5aXp8TRFZ955RAVWfDrEH5vEr0sbNagVLHzNy
         FA9z3iPOYH7jA==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/6] kselftest/alsa: Don't any configuration in the sample config
Date:   Thu,  1 Dec 2022 17:07:43 +0000
Message-Id: <20221201170745.1111236-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201170745.1111236-1-broonie@kernel.org>
References: <20221201170745.1111236-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=broonie@kernel.org; h=from:subject; bh=Kn+BswH7rAycY9VeynvDcjRtACgC1wb2IYiNOSjS+Q8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiN9fa5wTLCtYT9notHr7El4eyPGnYoYICD8o+gE3 8SBIShiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4jfXwAKCRAk1otyXVSH0K+vB/ 4jhJBvtqbxPvVCaIt3Nmv4O/SMt/nFZjEiK40mVWdP6p6cZtuMufcWu0yElXfkHqdlM5GfHlK0JKY4 YjcbKzMos2akkn1OQFWcZOkg2Qy6FAnuqgzz9wZ7gT7SNmjLfr/r8o5xXbzqWpRX3b2XWyAwTNPezF DRgrajELlpmgJ7IbNK44+8vV2+bjQhMuFD38xNbHiWeuDSbLt0pt9dFbPVva9lFqX14eYIY0q693Py 3t7l9r4BtGrbDiw5PQnFmeJ4+Gx8ZkLe7dkSI4rGaoOPIkKxbSqXinOTswgolGhjV+mxX+P6TABT8G /Gx2Uv8VblE2QYnzx5jx98HXDnbFXG
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

