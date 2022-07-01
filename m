Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD35633B6
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Jul 2022 14:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbiGAMvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Jul 2022 08:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiGAMvm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Jul 2022 08:51:42 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA331355;
        Fri,  1 Jul 2022 05:51:41 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so6323084pjj.3;
        Fri, 01 Jul 2022 05:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=LI4LxelWEjEaX1Q8c74mSsIuglj1BIMj7hPy6RZdBWU=;
        b=M7Mb6TYVMz5tzKe9yvrHm0hj4iojUpB3gA+OWfLHAU2gIBbc//BWLgsLT6vT23JrTn
         YHbbX0upeseqhLOefVXwgajhtIqy9AqCzjsA/8BSm/gkjSfv2sUOyKCgXut62IcfZA6p
         as0QZ3m2pHC8Sv/BMRYY3fWCYW4bBDpCv7TgdBrZpmeMXT+dbesyC3BKACOPMzwFIs6i
         UsogCpXFpTXNXjkBT4Z26I6Srs++42MBZC6qeyIO0JpmA8eXczIoynDwIlsyWB7YmGvw
         dmE8q+LUNIbco/H3cfISYQNMlG5BQ8R9LCKlf5+Xgjj2CKFqclsP62DZnRwI46EK7EWa
         nZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LI4LxelWEjEaX1Q8c74mSsIuglj1BIMj7hPy6RZdBWU=;
        b=ZhrW2AFcwR4uLOds67kwQgVkbxphpvpAMc2ta6Xw2diIAdwvFEu8bBMonZ03sEET6M
         MmWKv76x7Yh51xH6GhGjEScnllh3BFLC1/w+X2opWU9f5NNCTcbevGwxkoxnSR+MWOrI
         9jzfxSc3wYb10NEpstSlKSvw6BI3FZr26Oa8GWaDT8QkiMXE31JeZsSS27ovpT9kHyJK
         gim3kpeilm6WxI6eGEGgrOVS3o0qr8XX5Kmg4ir958xLHbSjM2S/iOJJgBvLAzVefsjh
         +SXHxmIkoh6/3LGjZqk7ALVVrLyUrWV8Y1UxTq2BBpwxCFR3ncdfsnapN6fepf9sEUTo
         3n1Q==
X-Gm-Message-State: AJIora8oAh1qDOk1suuvTtnqFEXBvQQZgsN9i5l3lC4RffMXJg6IXXfD
        3nQOoTOQZ+NZ1F56nd/h9AVtK2n7poDc8A==
X-Google-Smtp-Source: AGRyM1ssIZSAjCSS/BH6CNkAGsHwBNKucbfiSDUis538OdLV97pyXbAdS1YasJb2xKooMt6CRZLLOw==
X-Received: by 2002:a17:90b:1c86:b0:1ee:e795:a6a with SMTP id oo6-20020a17090b1c8600b001eee7950a6amr17985059pjb.205.1656679900162;
        Fri, 01 Jul 2022 05:51:40 -0700 (PDT)
Received: from Negi ([68.181.16.243])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0016a3f9e528asm10452851plb.57.2022.07.01.05.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 05:51:39 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] selftests: drivers/dma-buf: Improve message in selftest summary
Date:   Fri,  1 Jul 2022 05:50:52 -0700
Message-Id: <20220701125052.5300-1-soumya.negi97@gmail.com>
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

