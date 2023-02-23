Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163966A0BE6
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Feb 2023 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjBWOcc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Feb 2023 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjBWOcb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Feb 2023 09:32:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4FE55048;
        Thu, 23 Feb 2023 06:32:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id ck15so44041510edb.0;
        Thu, 23 Feb 2023 06:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677162748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hI9AYfo2vkeh8LJLJ62ywUBp+xjNfPbHlFhXyS9ADk=;
        b=If+KJkWnVnSQ0e8UH/zKyfMnfWUKBrxoVM4ziAgfhk/mNOmXLOc1/UEzg/JFMqgBOL
         V10xZjxKXLIeprGB84JxlkCRFL/5ShOG0RvrJ0zhWNU/aXNhRfZumHAlwX9gQ0/BGdR7
         XjPiDcyb6DJ8eQxzfnTeKgR9ANhASfq2msQfjEa4a9+bLAXB4jXXeXvzOZsPKIm5IHdx
         j21kDf6JyzGvSGHRdHV9P93gWwx3b/wSD6YR/a45nEa7D25Rv1uiXThjkFjxtsL5fNPI
         /KTVKodQmULZRuqyEo2TLQ54+ntTc/Q91Qnu7iDd+CRU9hpOkcv1D6OV/Zh6RKN89tFk
         2MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677162748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hI9AYfo2vkeh8LJLJ62ywUBp+xjNfPbHlFhXyS9ADk=;
        b=x6JXTki/bgGTCZC6OqOfFepHJ4ZLD7aboZFk3X0ta9C3QrEnjefG9knYa3PaWjCw/o
         OMRNyeTHQr0BEgtNlJ6OWu+rPUcE+qXkFzEjbJUo4st7LJ37IKfp/fAR4DXaVrOkmkjq
         xHYd3DZGB+u59WbMUDb5a40sjhrWUvdahJZLAGsCI5LruGYPdZ+UHUOZmP6kmT6Lr6XI
         AG82XiH7n/Tmu1HX1LOS+COJ60Zq7cA5LlkQmxrpyXpoNSRc48flWnD/7c6hdfzbqSK+
         jcmxXKLTn2OgEScCeRswcxjejwetgszRtpZuwQHWtC2npam671eoT2gkEkVO5V/l1wgy
         +13Q==
X-Gm-Message-State: AO0yUKVb7xeiNeoftRhqooVZRzZEaSX78Ao9vu12BzwhozlQ9iZnPbjk
        4cq+guQHHQ4uO+ZPM3RfKQs=
X-Google-Smtp-Source: AK7set8VR6mBMUFQbc8DS56GFmWhwsINpNhuXfNnC0hGJEn9VF27jsYJu58HVUwilxFVChJAlMpDvw==
X-Received: by 2002:a05:6402:34d5:b0:4ae:e4d2:174b with SMTP id w21-20020a05640234d500b004aee4d2174bmr12747120edc.2.1677162748494;
        Thu, 23 Feb 2023 06:32:28 -0800 (PST)
Received: from mineorpe-virtual-machine.localdomain ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id t29-20020a508d5d000000b004acb696a0f6sm3994603edt.91.2023.02.23.06.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 06:32:28 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        shuah@kernel.org
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>, alsa-devel@alsa-project.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH] Fix snprintf format warnings during 'alsa' kselftest compilation
Date:   Thu, 23 Feb 2023 17:32:14 +0300
Message-Id: <20230223143214.16564-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix 'alsa' kselftest compilation warnings by making snprintf
format correspond the actual parameters types.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 tools/testing/selftests/alsa/pcm-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index f293c7d81009..52b109a162c6 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -318,7 +318,7 @@ static void test_pcm_time1(struct pcm_data *data,
 		goto __close;
 	}
 	if (rchannels != channels) {
-		snprintf(msg, sizeof(msg), "channels unsupported %ld != %ld", channels, rchannels);
+		snprintf(msg, sizeof(msg), "channels unsupported %ld != %u", channels, rchannels);
 		skip = true;
 		goto __close;
 	}
@@ -329,7 +329,7 @@ static void test_pcm_time1(struct pcm_data *data,
 		goto __close;
 	}
 	if (rrate != rate) {
-		snprintf(msg, sizeof(msg), "rate unsupported %ld != %ld", rate, rrate);
+		snprintf(msg, sizeof(msg), "rate unsupported %ld != %u", rate, rrate);
 		skip = true;
 		goto __close;
 	}
@@ -393,24 +393,24 @@ static void test_pcm_time1(struct pcm_data *data,
 			frames = snd_pcm_writei(handle, samples, rate);
 			if (frames < 0) {
 				snprintf(msg, sizeof(msg),
-					 "Write failed: expected %d, wrote %li", rate, frames);
+					 "Write failed: expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 			if (frames < rate) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 		} else {
 			frames = snd_pcm_readi(handle, samples, rate);
 			if (frames < 0) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 			if (frames < rate) {
 				snprintf(msg, sizeof(msg),
-					 "expected %d, wrote %li", rate, frames);
+					 "expected %ld, wrote %li", rate, frames);
 				goto __close;
 			}
 		}
-- 
2.34.1

