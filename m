Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17F330840F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 04:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhA2DF6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jan 2021 22:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA2DF5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jan 2021 22:05:57 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA181C061573
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:17 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id e9so4487355plh.3
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FtqZbVLoNhYzW/5zxBFGSTg2OJ2tv0Ub0qNAJ13xHs=;
        b=j5yLzHZt+6y1rTjQAaHsDOTxGgaIO1Q9C9yvGJP/x3SkVLLnhJSUKnESb/H0Z9JJM3
         X3o9CasXX6DZTksNat7StXwigWk+Orm9ia/zA32HYjwgB7fSoTv26tV1S3bs6YrGsFEp
         z4HPk5S+5CgJFgVQdxw+V7SZtaTKny8EBvZ3oJTURUzJ+ccHaYle+g1y092cga4L8huN
         RJggFGQ7Nhlb7TYWCH0Ubq1AsPnmdAUnLmHsDZinfH7eAFf/GnRcL4Dm4SijBHNx+FHZ
         Bw43r3f9o5DaCRZX9xsjG0o3Lr7MVysYUjjKamy51VBjfsyrADAgEtsWNzZdhWgazp4N
         PuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6FtqZbVLoNhYzW/5zxBFGSTg2OJ2tv0Ub0qNAJ13xHs=;
        b=Fm24oKLxPHLbu2M2Mo7ZfzDeLFfJZP5889BBkJU2KjbjjJuIcCW4VnHEN9x+saSipt
         6Pt+SDCW685WJAeaKfFpyrlHBSCinOXBJ5KDavzP3kvemR5MWNr8ocuH1411alW39UGs
         WqIfVfRJg/HkorvAdOyg7eymjLHQa7hR8TQ+Uvn1fvr4XOjp6u0BKOGzOUBFqlDcW8+i
         A7ye8XneQKpn8evJZw8Ocww8az7ooDDVGOcfJM/OXYwy8CqlNsEXuC5EYRNbiClxg1ge
         vOYXXwAd+lIA/bwZ+iA3wW/DGA7+U00q2cae2X5BZxs8eEaHhA18UNY6pvSWzzmLVCCD
         Z/3Q==
X-Gm-Message-State: AOAM530ARnOANFFEnx/sRzg5G1BT0fo85W61Rq+J9NMNQr2BiOdhOd3j
        zFgdyEmNp6Bf2fMyoGpe3yyyrg==
X-Google-Smtp-Source: ABdhPJxNcoBMcdOeDQYd3FdgzjZ86Cf272Rz2la9I9NvjeaL4IhlWxZTBvB3/43QEa/+/6QJlLWKNA==
X-Received: by 2002:a17:90a:d913:: with SMTP id c19mr2416772pjv.19.1611889517371;
        Thu, 28 Jan 2021 19:05:17 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y75sm6854496pfg.119.2021.01.28.19.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:05:16 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Laura Abbott <labbott@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] kselftests: dmabuf-heaps: Fix Makefile's inclusion of the kernel's usr/include dir
Date:   Fri, 29 Jan 2021 03:05:10 +0000
Message-Id: <20210129030514.1231773-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Copied in from somewhere else, the makefile was including
the kerne's usr/include dir, which caused the asm/ioctl.h file
to be used.

Unfortunately, that file has different values for _IOC_SIZEBITS
and _IOC_WRITE than include/uapi/asm-generic/ioctl.h which then
causes the _IOCW macros to give the wrong ioctl numbers,
specifically for DMA_BUF_IOCTL_SYNC.

This patch simply removes the extra include from the Makefile

Cc: Shuah Khan <shuah@kernel.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kselftest@vger.kernel.org
Fixes: a8779927fd86c ("kselftests: Add dma-heap test")
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 tools/testing/selftests/dmabuf-heaps/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
index 607c2acd2082..604b43ece15f 100644
--- a/tools/testing/selftests/dmabuf-heaps/Makefile
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
 
 TEST_GEN_PROGS = dmabuf-heap
 
-- 
2.25.1

