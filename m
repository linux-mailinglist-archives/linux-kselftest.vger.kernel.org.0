Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9185E59FD32
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 16:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbiHXOZf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 10:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239215AbiHXOZd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 10:25:33 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452E614097;
        Wed, 24 Aug 2022 07:25:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w138so14022837pfc.10;
        Wed, 24 Aug 2022 07:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yJOiwlr5dN415WVoIAxDSomoqMBK4mBmdE1V5KIJNj0=;
        b=iRPyxRAWmjmKn8q42Yo0vAkVoU9QNM1gpKJwVA5WZzxqH77PVAGtqJhpnMkhAxmMXd
         A/szJntskmzkODi0jCwd2JBMG4iYC2PQLlOra5qWSVzBp9P8VLkp2wd8jErJBp72zqZI
         8o5UtPR4b1RlAml0LZ+O8SiRrpTIEojxlgVyvXaMP07d9P5NuLYC5KvoEx5TCOL+yLzY
         E5m2wFKXhy//OyvSw1SDRZQc57sTqeQW0RCc/p6fDsjLc0ASSgLqBtXQhUd50XlJUHJ0
         8C7hIxJe8m7t60ZDznVUhabEiktoUt+gOzWYscLpDriZCEHaJRoOgnnvfdqZ7E2dsZWf
         f+ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yJOiwlr5dN415WVoIAxDSomoqMBK4mBmdE1V5KIJNj0=;
        b=rUywW4nNt9mg3Ns8LQjO/mRUwIUJd4A7reoh1Omp7F7N0C1cJiuz4v+BlZqe8OSdOs
         vOdNQX5v5ALCBxCI9MmYsrHj8vyBkmG/oDDhQ5zxdb/MGhXgMnWKwm7kxL2LNWE04xSt
         PbA/swDywLbqgmx33afTBkhiVZAzzOiLTpM0+LfVyCZww+G6zm9/C9PA+Gt1fyjGprb3
         TkF8Rg292VO+GYxz6xrehOo1lZ+HjfKjCHG9gfdRR8FjtniLQuprWRHoIsgTTDWiVYm7
         Qbo0qo4GwsEIxQ0yevW1krETiKBhWIzpWFeQmb6kPqPqBOyYKVegeKnljCfTWp5b5Rb8
         IaWA==
X-Gm-Message-State: ACgBeo0ogblWh7KSKyi2keshIj2em+3ayF+y2K6dM/SV1hjIBdxiKE7v
        gKsemWnxHNPsEDmnTO9GcfI=
X-Google-Smtp-Source: AA6agR6tAbgks5XjT6jCn0g0eHPA3B+ctqLbI3P6s6S0pj9lVQz+r8iXOxYq2A8ITySt/CEhTBEMFw==
X-Received: by 2002:a65:588d:0:b0:42a:2778:164f with SMTP id d13-20020a65588d000000b0042a2778164fmr23490088pgu.616.1661351130348;
        Wed, 24 Aug 2022 07:25:30 -0700 (PDT)
Received: from localhost.localdomain (124244014158.ctinets.com. [124.244.14.158])
        by smtp.gmail.com with ESMTPSA id s21-20020a170903201500b0016bf5557690sm7821800pla.4.2022.08.24.07.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 07:25:29 -0700 (PDT)
From:   Hoi Pok Wu <wuhoipok@gmail.com>
To:     shuah@kernel.org, corbet@lwn.net
Cc:     Hoi Pok Wu <wuhoipok@gmail.com>, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs:kselftest: fix kselftest_module.h path of example module
Date:   Wed, 24 Aug 2022 22:25:05 +0800
Message-Id: <20220824142505.145612-1-wuhoipok@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"module.h" does not exist in kselftest, it should be "kselftest_module.h".

Signed-off-by: Hoi Pok Wu <wuhoipok@gmail.com>
---
 Documentation/dev-tools/kselftest.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index e87973763b91..12b575b76b20 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -320,7 +320,7 @@ A bare bones test module might look like this:
 
    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
-   #include "../tools/testing/selftests/kselftest/module.h"
+   #include "../tools/testing/selftests/kselftest_module.h"
 
    KSTM_MODULE_GLOBALS();
 
-- 
2.37.2

