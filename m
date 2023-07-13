Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FE375209C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjGML6r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 07:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbjGML6o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 07:58:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208B82709
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 04:58:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-314417861b9so744533f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689249511; x=1691841511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nBLkkw1G6WSJr1HvvBebHePyOgAnthAqxl0kKfFGkRY=;
        b=YprnJVutMhoiweGKBDkkZSmbZayXXBuZ0/GI8RFNmiLty3opDI4z1QzMtCVecjtgw/
         TVZ9QWZaDwUoB/JKREJ7H/HZ7fMsu9HxP96g/gXK8bcS6kUj/+hn0BBvtiq3HanIRfRP
         g/1v98zt5DDuKQpr7Rsqsx7XrqWF6/9V5h4EQ/BNCN7CbBYYUuqwkq+Pjo6KkHGCpFly
         5RCssvuBkdbwHDkq562tto5dnLMnnTpSFhMca9Xxtwjd3okewrzOUejXH2jjfTTdAYHQ
         R7M4GP/m/IxWTsHAJ5tpSdZ0yYXTDMsYBIHA87/mLAWszrG3xVVzWbULrJhVjGgwca22
         fmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689249511; x=1691841511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBLkkw1G6WSJr1HvvBebHePyOgAnthAqxl0kKfFGkRY=;
        b=WCvTfC7d00YmprL3vFAJfaSN6fWZHhgYqRefs6XRUM6DN067YPHfGSeUMW/xigg3EO
         ckoj4htGTJ3CJ1W8ONpMbV7g2XvIi85LRCfFhk4r9oxNXtd7Xh7hMFI4wrrOYDnchtxz
         zAz8xf/7JXo2tDJ33UY8t5d5+goJSFbO168BsPbbwa4qRA14PqouDDuvYsSlTpcQWbEA
         d4P0sVmWUaWpS0Q9Z0wklFExg8036eg7/RIo1y69S+cgPcefTEwCDrCemoqtpL6KuS6N
         OI7UUHosYRRQLYT71JME86sjqUsanzEeFi1feZS9EWsFJJFw17bicVkmlCTnJIhCK/G+
         +sBg==
X-Gm-Message-State: ABy/qLagMSbqJbAg5I02luNbp65lPOsyaywHNlsqbbAhxP8rdDis1PFw
        kzpam5EQ9bGyUhDd5shqgAW2FA==
X-Google-Smtp-Source: APBJJlFfpzpAdIOQcPc6dpdK4fawVhchxwxSJ5mWwgcfyvbo9h+OdkX+A2HfhE1WN+ZtCs33kZQVtw==
X-Received: by 2002:adf:e98f:0:b0:314:220d:7 with SMTP id h15-20020adfe98f000000b00314220d0007mr1219828wrm.45.1689249511576;
        Thu, 13 Jul 2023 04:58:31 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm7767115wrx.48.2023.07.13.04.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 04:58:31 -0700 (PDT)
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
To:     Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] selftests: riscv: Fix compilation error with vstate_exec_nolibc.c
Date:   Thu, 13 Jul 2023 13:58:29 +0200
Message-Id: <20230713115829.110421-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following error happens:

In file included from vstate_exec_nolibc.c:2:
/usr/include/riscv64-linux-gnu/sys/prctl.h:42:12: error: conflicting types for ‘prctl’; h
ave ‘int(int, ...)’
   42 | extern int prctl (int __option, ...) __THROW;
      |            ^~~~~
In file included from ./../../../../include/nolibc/nolibc.h:99,
                 from <command-line>:
./../../../../include/nolibc/sys.h:892:5: note: previous definition of ‘prctl’ with type
‘int(int,  long unsigned int,  long unsigned int,  long unsigned int,  long unsigned int)
’
  892 | int prctl(int option, unsigned long arg2, unsigned long arg3,
      |     ^~~~~

Fix this by not including <sys/prctl.h>, which is not needed here since
prctl syscall is directly called using its number.

Fixes: 7cf6198ce22d ("selftests: Test RISC-V Vector prctl interface")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
index 5cbc392944a6..2c0d2b1126c1 100644
--- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-only
-#include <sys/prctl.h>
-
 #define THIS_PROGRAM "./vstate_exec_nolibc"
 
 int main(int argc, char **argv)
-- 
2.39.2

