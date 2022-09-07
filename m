Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4F5B0B15
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 19:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiIGRJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 13:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiIGRJH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 13:09:07 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67D9BCCEF;
        Wed,  7 Sep 2022 10:09:05 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id t7so16452096wrm.10;
        Wed, 07 Sep 2022 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=7jFPudVaz4OSN9szXdkTPFTFgzH+9Ixx1ps2IBTuQl0=;
        b=NtkJVrOeIGJ/HMlhhvFJZW4iepJpTseqtM4kCZie+kh5rj7T1lUPiQPaysY7Uw0KB5
         9VkBzinlRLMF9+laNSHrUjEd3RpkG5k+bjBLBAOWPp14Zw+q8KUTr45iZipmEA10Qw3M
         POF5FHUUJjF7GoPrvw32CacbmavrGq8arYq/ojO3rg5BlfAxkX4Ur75y151brzmRPu4M
         KYhnyAmJGHVKwBWBUT9DDKnyXVmzY5yHAAIoOgCV9ajcZiBAbPipmyDEBx+iEHcRtxUr
         yXzIdMYk6ucupK9httrNrJBSPL4T/X1X4nZdhXubukKFzXafIs+VRMnkyibjuOn8e7KA
         RYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7jFPudVaz4OSN9szXdkTPFTFgzH+9Ixx1ps2IBTuQl0=;
        b=E/yrWydoFn+GuyaP5xQ3xKFPeldgYppquywu/CpD3q/HkOtzuzjnyi7lkE9oUEzubQ
         kvZ4IvX4A2+h/96tq3bOEbYjoGQbeR35JWV6QRDCTt0U4HPRejklc5ttY8LlBW7tdIUV
         W90CmE4+b2NW2RRDmlzwF2RgiZYpX7Op9RUtlL6nA31Eh8tS/mRx8gqPZOPjCoTMIaOG
         B8Z/P9Y/wnyxbfPid5g0LSucrnVeNW/cgrw/LznpvWx8qcOUoO1qgmva/KveTDM1R6mB
         I+jUX442RUCIElD5N8/VUBe+K99oUPsQmnWYtJZqJ8BFAkKI18adCmgEv7Hyg/mJYED7
         BrKA==
X-Gm-Message-State: ACgBeo2sBiOK+a1a8GzrbiBQ4QK1DYS2zLaM8SFTA27qxEojTsoBmyAU
        cZ9aiCfe0QZsRW71HODKPlM=
X-Google-Smtp-Source: AA6agR7tZxr2jYBm30jItjzzfnofiLHxpHNXoXirnKLa6HJ9SWLryoXydGyezxk8ahZ+KYdS+Msg7w==
X-Received: by 2002:a5d:6d0b:0:b0:222:955a:8774 with SMTP id e11-20020a5d6d0b000000b00222955a8774mr2618258wrq.129.1662570544170;
        Wed, 07 Sep 2022 10:09:04 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p7-20020a05600c358700b003a8418ee646sm29535520wmq.12.2022.09.07.10.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:09:03 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kselftest/arm64: Fix spelling misakes of signal names
Date:   Wed,  7 Sep 2022 18:09:02 +0100
Message-Id: <20220907170902.687340-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are a couple of spelling mistakes of signame names. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 01cef1962ab5..a5c0ebef2419 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -247,7 +247,7 @@ static void handle_child_signal(int sig, siginfo_t *info, void *context)
 	}
 
 	if (!found)
-		ksft_print_msg("SIGCHILD for unknown PID %d with status %d\n",
+		ksft_print_msg("SIGCHLD for unknown PID %d with status %d\n",
 			       info->si_pid, info->si_status);
 }
 
@@ -457,7 +457,7 @@ int main(int argc, char **argv)
 			       strerror(errno), errno);
 	ret = sigaction(SIGTERM, &sa, NULL);
 	if (ret < 0)
-		ksft_print_msg("Failed to install SIGTEM handler: %s (%d)\n",
+		ksft_print_msg("Failed to install SIGTERM handler: %s (%d)\n",
 			       strerror(errno), errno);
 	sa.sa_sigaction = handle_child_signal;
 	ret = sigaction(SIGCHLD, &sa, NULL);
-- 
2.37.1

