Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3F7A3111
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 17:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjIPPW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 11:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjIPPWN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 11:22:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26752CE7;
        Sat, 16 Sep 2023 08:22:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c136ee106so403741366b.1;
        Sat, 16 Sep 2023 08:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694877726; x=1695482526; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVGzsDlKuJKroPOhSkmnAeMyQ1dYs3e+BSZkz5C7wOU=;
        b=BO1HRME2KvN9zXrpEpC5QWa6BSI85H9/JuUS7nfBSWB3OvxCYfRrclkChLEoMn85Tn
         5jo2enHSEbs9VN0BnWaCZ5KZN7tHuu/2VBIU/B9L5ItTK/8f6WLObfko/aqcvhGicvXs
         wHl0xzVXev0keMJRTSE5snJOi+8CzMSeYfwGKOYnXGDZkpFdTA839FHJL192nRdwkm/+
         4on4DE9HfKA+6IdB/LjoSoytdhim/mSIvO1oysITgb06waNR/NkMI8+4DCMK+gUccN36
         ddxxKUFiRW6ZJFTRFavlVF92GXgTSvlt0/KGLrWRgacjYxWGv8UMRU39I4yXBPP8OKEr
         r0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694877726; x=1695482526;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVGzsDlKuJKroPOhSkmnAeMyQ1dYs3e+BSZkz5C7wOU=;
        b=sjo2YONCitfUyMWDyNIVgutPuVBZjdQRQ3bIiJD5/rtKmL1T8smfSoZMC7f+NyxufR
         kv9r1ilCnTCICfIIQ6pb1qamTrDN1fGtm8u2VJIoMrZbtC+mHB1fy5kqSH5yqhCfLCyq
         FvlUDUWtQaMGfbO8F3p5L2XYc3SSc0TnGu3YSNB2ftTKzVnGqX5mvkOpqrM/Wz5JZbL3
         wOmnfvYyrSmN7af8VVrJQkOEhGOPbg7H/JjjenaE0caFX0ojIGLJBeLHbkA0ce9lFfTn
         Q1mjZP3sZd8qFIYh/t3J3rhHUux/qlPUuGQzV0Xp3QKzjVu5ZPXqNBUDbEf97uXC+m8H
         xeuQ==
X-Gm-Message-State: AOJu0YwtwU1B/T50vIM50amOzccQ4AuZnm8lJZHN4jdXtSVsr9dCevMp
        8j2YGmPiPf+4NZXWUeZryeZM8qjhDagE6A==
X-Google-Smtp-Source: AGHT+IHYNxN0HDzjVIHcKx5NFiuIgw2hmYh9a/qE3zJvic4TrmflB/86K+hC+AI3uFH9B7Jd9ovMNw==
X-Received: by 2002:a17:906:5183:b0:9a1:fb4c:3b6c with SMTP id y3-20020a170906518300b009a1fb4c3b6cmr3989754ejk.59.1694877726288;
        Sat, 16 Sep 2023 08:22:06 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41b4-ce80-0e99-b4c7-72af-eba7.cable.dynamic.v6.surfer.at. [2a02:8389:41b4:ce80:e99:b4c7:72af:eba7])
        by smtp.gmail.com with ESMTPSA id p5-20020a1709061b4500b0099bcf9c2ec6sm3822103ejg.75.2023.09.16.08.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 08:22:04 -0700 (PDT)
From:   Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date:   Sat, 16 Sep 2023 17:22:02 +0200
Subject: [PATCH] selftests: ALSA: fix warnings in 'test-pcmtest-driver'
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-pcmtest_warnings-v1-1-2422091212f5@gmail.com>
X-B4-Tracking: v=1; b=H4sIABnIBWUC/x2NXQqDMBAGryL73EA0pX9XKaXE5Ksu2DVk0yqId
 2/o4wwMs5EiM5RuzUYZX1aepUJ7aCiMXgYYjpWps52z1/Zkypw4mBTeBVqei8/CMqhBtOcjIuD
 chWrce4Xps5cw1lw+01Rlynjx+r/dH/v+A291bfJ9AAAA
To:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694877723; l=1641;
 i=javier.carrasco.cruz@gmail.com; s=20230509; h=from:subject:message-id;
 bh=/ZkE2aVCHFyUYumMe8VecCnjdA9CPGn0CksaV8Mvf/s=;
 b=8rbNDw8hACyDjOlhCkl50WXigQ4v6zK0hH4HJvTe2D8UM3KCBmiJyRrH8nDQxrnwPxEjg8Pju
 6zVzSh+w6YfAHc/Z9L0ZOVHUfipd17mJDMcpSj0RgUeo9+F/GEWVrH6
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Defining the 'len' variable inside the 'patten_buf' as unsigned
makes it more consistent with its actual meaning and the rest of the
size variables in the test. Moreover, this removes an implicit
conversion in the fscanf function call.

Additionally, remove the unused variable 'it' from the reset_ioctl test.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Defining the 'len' variable inside the 'patten_buf' as unsigned
makes it more consistent with its actual meaning and the rest of the
size variables in the test. Moreover, this removes an implicit
conversion in the fscanf function call.

Additionally, remove the unused variable 'it' from the reset_ioctl test.
---
 tools/testing/selftests/alsa/test-pcmtest-driver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index 357adc722cba..f0dae651e495 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -13,7 +13,7 @@
 
 struct pattern_buf {
 	char buf[1024];
-	int len;
+	unsigned int len;
 };
 
 struct pattern_buf patterns[CH_NUM];
@@ -313,7 +313,6 @@ TEST_F(pcmtest, ni_playback) {
  */
 TEST_F(pcmtest, reset_ioctl) {
 	snd_pcm_t *handle;
-	unsigned char *it;
 	int test_res;
 	struct pcmtest_test_params *params = &self->params;
 

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230916-topic-pcmtest_warnings-ed074edee338

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

