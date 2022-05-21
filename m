Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7F52F947
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 08:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbiEUGgp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 02:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiEUGgo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 02:36:44 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F4215A0A;
        Fri, 20 May 2022 23:36:43 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id y199so9383532pfb.9;
        Fri, 20 May 2022 23:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LI4LxelWEjEaX1Q8c74mSsIuglj1BIMj7hPy6RZdBWU=;
        b=krDiS0tWzf4yZqe9YLwZohr5GraL2gzIFd9ot/Kj0fRMoOtw4+cET5/WyGnPwPHIyw
         dckRcE/nyT+u8ePN8HZxY85dxQYBJfVDY89t61rOHerC9SIN/2SbOjgZNG3QQQuv+0Qr
         cl4Wx3mhK0wz3gvKpssMoO4H3eVFoyUaIhqdr4kGYyN8WcjKRWqHBztrmM+GGlUueuH2
         8AMjuRBj+X/QTfzvNJqIe+/HydLmpzzogZgcZzbw6c7ky8pN8M5dPaUwI0gEaKTt4k9s
         eQsq9Hvv449COPCNLiz5gPMq3uXJW0G+i2Oh/4+INPoQ4VkdCaCM965ild5pQpnNen0i
         kofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LI4LxelWEjEaX1Q8c74mSsIuglj1BIMj7hPy6RZdBWU=;
        b=m6lkSfF5EH7kL9lOZydWkYR88XjhryVQL2FRSl47cQPSFjSeg5Y/bk3NqIbxRoaZ5B
         4mXy0hW6mYkqebW6P521nk00MUq/yOlsxzo4SrXmNhkEp/tSasJCvvl4/HH0HxGktaHS
         iAoHia11U8uogjj5zBL4naqvWXeYc5DgrtfHsoG7upeStauf6H685R7Rp3ds3XOSFzR2
         XYbo1ItWOC6CgUBxvy/2xgZ48R+6t4gKy1udXVfjZorCPHwPiPe5BCtE9pvZZm6ZlZDy
         kXVs8bQNq6lAmoXZ3JOd1n8/e55/M8tLIv3nvxNc/xm5dX9jnUqfgsGoQzN/pkt+Bow6
         NPeQ==
X-Gm-Message-State: AOAM533JUGcpj0bk4SzJ3pg2o8Y4uwERFtWneGvrF+veAngMCmIDNspG
        Td2opDA7u11XkBjKL1k6kvbCO5CWsebXDQ==
X-Google-Smtp-Source: ABdhPJzDUUyxPh+4E2F/F1Ikqk8CKNA1QtsqzcgZ7yuZwLkqqeloj+WzWL3eWZPGPvlRSOK6iO6mIA==
X-Received: by 2002:a63:f355:0:b0:3f6:41f4:b551 with SMTP id t21-20020a63f355000000b003f641f4b551mr9790328pgj.383.1653115002830;
        Fri, 20 May 2022 23:36:42 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id h5-20020a62de05000000b0051831863f10sm2848702pfg.109.2022.05.20.23.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 23:36:42 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: drivers/dma-buf: Improve message in selftest summary
Date:   Fri, 20 May 2022 23:36:10 -0700
Message-Id: <20220521063610.4924-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Selftest udmabuf for the dma-buf driver is skipped when the device file
(e.g. /dev/udmabuf) for the DMA buffer cannot be opened i.e. no DMA buffer
has been allocated.

This patch adds clarity to the SKIP message.

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index de1c4e6de0b2..c812080e304e 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -32,7 +32,8 @@ int main(int argc, char *argv[])
 
 	devfd = open("/dev/udmabuf", O_RDWR);
 	if (devfd < 0) {
-		printf("%s: [skip,no-udmabuf]\n", TEST_PREFIX);
+		printf("%s: [skip,no-udmabuf: Unable to access DMA buffer device file]\n",
+		       TEST_PREFIX);
 		exit(77);
 	}
 
-- 
2.17.1

