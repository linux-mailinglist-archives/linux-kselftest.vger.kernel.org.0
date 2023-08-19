Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126EA781B6B
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 02:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjHTAKA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 20:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjHTAJu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 20:09:50 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAAD69BDA;
        Sat, 19 Aug 2023 12:50:37 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31972944f30so1840252f8f.0;
        Sat, 19 Aug 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692474636; x=1693079436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=syjYuYouKG6x9vMzQTgaYE6bMGQKoGTf55WJXqWNgfk=;
        b=L4w33MvZDt+bejgB59yoSFPXfvYoa7sF0Bzw4eS6/jas4uM7W/XKooWVqYB1iRy66l
         gnFpFknuahxpz1L1cGsQ6oMiUQrIN2a3l1jDwWQNtZbHhtdQl6O/VjLLAx7qk99jnpv3
         Zv3aWmfvwcdLG2b0uajwFiA0OarHIjj4XXSVJOGvSSOygt+bVKObZYDWvJNwj8tlN1DU
         j/+qVeaUN0i2XnKHVcEiSS5xkFL/aY75kBqJ5bEwkDgE2Z/txDZK7XV6wkQSNJFuh1Z5
         lJR9HtrlCfBAicwNDH2PwXY9kS7kNVpncpDdMB4DpS7SyqHnAYXfpgLfgjnrsPtNKJMA
         CkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692474636; x=1693079436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=syjYuYouKG6x9vMzQTgaYE6bMGQKoGTf55WJXqWNgfk=;
        b=h+yW/3FEVl1xP8AaQRIZuHNGXILYWwotTxs5HbGOxj7fRxxtrttTG2qRE+EvC58ByS
         V2M+/au4oKq/qH5rYpGV1Hd/r60hYQ4rZwbLftWN7pMGXs1Z4FZ4T4Z8B72mcZY4oLja
         r4QUh+rkvnJKB4lAx8TRACUiXH7QKWEM/7sE7GnSCNUwllvFDrhNFNsCA735Ia8Ie7g7
         /Ti2yJxWY4VhxPLhHlu3rS5ZZMttpL8uv/979vBJXMlBEWz93pNl4kEyjTU9Jucrc7Dk
         54c1fhB14a5z3tZR8IfKCdukkZNZ3j3pa+rhd+GmZuTAI4g625OavrUYPS21tJYTjJ0A
         GIMQ==
X-Gm-Message-State: AOJu0Yz5Gog53QML7KGVRGNdohj5PSDMJDyq34bx+PueCLgv5LfxxcPw
        p53RgBS4SN6kHKMjsdSW7trAlSkHxkdZ3O+W
X-Google-Smtp-Source: AGHT+IHwz9i9RZEGQSJnV0omevwRbtNhcOM2kfj2XUSJk9HKoTKu5AgwgZFEvFvjQFf7QVMhzBYynA==
X-Received: by 2002:adf:e802:0:b0:313:f45f:74a1 with SMTP id o2-20020adfe802000000b00313f45f74a1mr2071265wrm.51.1692474635765;
        Sat, 19 Aug 2023 12:50:35 -0700 (PDT)
Received: from mmaatuq-HP-Laptop-15-dy2xxx.. ([5.194.84.172])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003fe26bf65e7sm6861382wme.13.2023.08.19.12.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 12:50:35 -0700 (PDT)
From:   Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        pabeni@redhat.com, edumazet@google.com, shuah@kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
Subject: [PATCH 1/2] selftests: Provide local define of min() and max()
Date:   Sat, 19 Aug 2023 23:50:04 +0400
Message-Id: <20230819195005.99387-2-mahmoudmatook.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
References: <20230819195005.99387-1-mahmoudmatook.mm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

to avoid manual calculation of min and max values
and fix coccinelle warnings such WARNING opportunity for min()/max()
adding one common definition that could be used in multiple files
under selftests.
there are also some defines for min/max scattered locally inside sources
under selftests.
this also prepares for cleaning up those redundant defines and include
kselftest.h instead.

Signed-off-by: Mahmoud Maatuq <mahmoudmatook.mm@gmail.com>
---
 tools/testing/selftests/kselftest.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 829be379545a..e8eb7e9afbc6 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -55,6 +55,13 @@
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #endif
 
+#ifndef min
+# define min(x, y) ((x) < (y) ? (x) : (y))
+#endif
+#ifndef max
+# define max(x, y) ((x) < (y) ? (y) : (x))
+#endif
+
 /*
  * gcc cpuid.h provides __cpuid_count() since v4.4.
  * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
-- 
2.34.1

