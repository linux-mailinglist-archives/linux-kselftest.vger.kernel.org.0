Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56E8BDDE67
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Oct 2019 14:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfJTMZM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Oct 2019 08:25:12 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46060 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfJTMZM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Oct 2019 08:25:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id y72so6570926pfb.12
        for <linux-kselftest@vger.kernel.org>; Sun, 20 Oct 2019 05:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MjBgH+WtnWkVHpZ7Eaciulw3LRwfEFADPiSrzJDcSx8=;
        b=iU4vz4GVASJ6bHAu5T5NV2SDt7nydXLwSrKpDJLwYD8kjRnuHeI6/SwtRW341G/0SL
         zOlIH3L7qlC5b62qbOCuH7ZnsR55gvyWbh388tshi9Jw//be39s5mji8mtC/KpZglNR9
         Jv3+fXPKo0ssRVx/P+U1AgiMsuaI2UlqavM9SIXp5iJEHPjqH/hEXubThnSmDQyvKwg/
         LNYkOfwmkgakw+JQzEO9Xz3Jv6zvWtYMijekNqpH1Z5MB/69Ht1Pe/wDaP7NEs8+Z/Ku
         xsKZikseX3MgpTPI9JsDY5yM7BW+32ymU8UqUeB0ry1innIN2KoNsbdo8WvWyC9diLPq
         efvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MjBgH+WtnWkVHpZ7Eaciulw3LRwfEFADPiSrzJDcSx8=;
        b=hBNHMLFzfqoWBEG8Q8OlltFIS7uhuyly4BePEnKl/EfH4d3ud+X6CFSKRjnxkA50+4
         Jkq5K6RurH4kOyZVzdln+ZS6yTFKluJuiCjvsGI5vH6wmd1UsoqehYy0jyDPMhM93Q/O
         bC7KHzixbji6naVqVBw91vYD5oCky0ubNH22ku219W+Gc/nMAOhkeiNg91DBS9m8BpuZ
         zkITfqW9lIOz8d7jAb8opc+gU2anvBbLXnmyYm3vlTPsD9t3TbFULJXEzF0WeEVULwCJ
         fD6Svx3v09ulwXS+7r7/aZyWu5HkNNYgNJy6HKDaX6sq9A/r5iU3I/F3jE9+9btpv81D
         tmgw==
X-Gm-Message-State: APjAAAVOqgqeIGciTd+RnaEJnMI8xn2c84pvCUreRdbCw4YJiuAIU5h1
        KeiarnO/97PIpmm8enspQw6LXedE
X-Google-Smtp-Source: APXvYqyDN+xuQ39NjLA3fJG/aIgv4S6XAdfeb5Y/cyRovb/nRcnL/CMtLJlIo9WnxCAuxtsY7CSQ0w==
X-Received: by 2002:a63:5417:: with SMTP id i23mr20478844pgb.305.1571574310093;
        Sun, 20 Oct 2019 05:25:10 -0700 (PDT)
Received: from BG-LT7522.marvell.com ([43.224.157.56])
        by smtp.gmail.com with ESMTPSA id g19sm14255772pgm.63.2019.10.20.05.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 05:25:09 -0700 (PDT)
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
To:     linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
Date:   Sun, 20 Oct 2019 17:54:52 +0530
Message-Id: <20191020122452.3345-1-prabhakar.pkin@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As per commit 131b30c94fbc ("kselftest: exclude failed TARGETS from
runlist") failed targets were excluded from the runlist. But value
$$INSTALL_PATH is always NULL. It should be $INSTALL_PATH instead
$$INSTALL_PATH.

So, fix Makefile to use $INSTALL_PATH. 

Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Signed-off-by: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
CC: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cdbae6f4e61..612f6757015d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -213,7 +213,7 @@ ifdef INSTALL_PATH
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
-- 
2.17.0

