Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD705978CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbiHQVOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 17:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241683AbiHQVOF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 17:14:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F142A431
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Aug 2022 14:14:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-334f49979a0so51113077b3.10
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Aug 2022 14:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=URg+UMQZgJAJZD19p4gwvvadtL6QiS5A6GMenmjwJgY=;
        b=SRObGBGBG2sRxe2+tGmXszzXIzti/OIGxkLLhYH/K9EzOKWGAOSbFZcnNiSbSrfEH1
         IS03Ciz5Y5XLkip4EtQzvRPLpihmjrh/kzWkFvimmx1y/IMQfU8uz8sSVeXI70UajTdv
         VEPUBCb/EaS6GLIE9GpsLB+ouvqg5iovDF9cmXOrKm9tsHMfQ1Jfued6B9TLqONuxlcz
         5jswcGo+LoYU8w3wK6e6vvrXw1U2Oher3+46zQDHkwPj5fzemLZ+5CSQF5b46ZC9+djo
         UXjXOpcwSjExip49HwmqLqdjoPKWC+gXaUHyhunxTTeeKEN9pJGOodbr+X2YitB8bnA2
         k7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=URg+UMQZgJAJZD19p4gwvvadtL6QiS5A6GMenmjwJgY=;
        b=ERDZBGWyhFmF1GsNh3TA8tDWpX0qZe/ry91m2N79zFLHR6+renx5j/XtSnpzZX7SOt
         iP1koCcpTSWYXmI3uzq8vPgywkdloRo/GuyQ3GhKy4SqKzSRR+/66E7BZs3Q6PWjthz6
         qUT/encYpwa4RJnA/m01PEgU9KDSvcpWTOoVEeTq77rT34lCjVkpXU5yY9FC044V5p5L
         uDfvz2yCTOkfFTXSymcLp/94CZ1bawT/Amso8cRUaIJwQ8rKe86AwY36olWaAyUTeJF1
         i8/xFg8NJV1PoyNqlfCI0xYlmJnPIEzAPxhyT4m5p4nN/LaBdXrZSKXol0LkId6HohoJ
         hEmA==
X-Gm-Message-State: ACgBeo21Ctz8eVx194eoBVUHgvDjYPS9odJqW06GoeHI0WdsGukkK7K7
        3elNgpBTdDC5I2mGr1JadOSjgCWqCbb275QIkALZ
X-Google-Smtp-Source: AA6agR6WBtTNLco5wa8t9uk8XSJjuDXXNwRdbOpIyGssHp2EbU6D8jDQ4yBgt9G5ppX7ffVKK3xkGU+G4y+8VrFU7KYb
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2d4:203:2f41:f176:4bac:b729])
 (user=axelrasmussen job=sendgmr) by 2002:a81:ad58:0:b0:329:5b1:106e with SMTP
 id l24-20020a81ad58000000b0032905b1106emr10097ywk.371.1660770840476; Wed, 17
 Aug 2022 14:14:00 -0700 (PDT)
Date:   Wed, 17 Aug 2022 14:13:56 -0700
Message-Id: <20220817211356.273019-1-axelrasmussen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] selftests/vm: fix inability to build any vm tests
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When we stopped using KSFT_KHDR_INSTALL, a side effect is we also
changed the value of `top_srcdir`. This can be seen by looking at the
code removed by:

    49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target"):

(Note though that this commit didn't break this, technically the one
before it did since that's the one that stopped KSFT_KHDR_INSTALL from
being used, even though the code was still there.)

Previously lib.mk reconfigured `top_srcdir` when KSFT_KHDR_INSTALL was
being used. Now, that's no longer the case.

As a result, the path to gup_test.h in vm/Makefile was wrong, and
since it's a dependency of all of the vm binaries none of them could
be built. Instead, we'd get an "error" like:

    make[1]: *** No rule to make target '/[...]/tools/testing/selftests/vm/compaction_test', needed by 'all'.  Stop.

If we specify the path of gup_test.h relatively using selfdir instead,
now it is found correctly, and things work again.

Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d9fa6a9ea584..f2a12494f2d8 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 
-LOCAL_HDRS += $(selfdir)/vm/local_config.h $(top_srcdir)/mm/gup_test.h
+LOCAL_HDRS += $(selfdir)/vm/local_config.h $(selfdir)/../../../mm/gup_test.h
 
 include local_config.mk
 
-- 
2.37.1.595.g718a3a8f04-goog

