Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAAC38F83F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhEYCiH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 May 2021 22:38:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33240 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhEYCiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 May 2021 22:38:07 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1llMvt-0005EW-99
        for linux-kselftest@vger.kernel.org; Tue, 25 May 2021 02:36:37 +0000
Received: by mail-pl1-f197.google.com with SMTP id 2-20020a1709020202b02900eecb50c2deso13960917plc.0
        for <linux-kselftest@vger.kernel.org>; Mon, 24 May 2021 19:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxWORDn7FXXGusrxXN6Ya4hOqqaatsEoxdo+mNZJQ3w=;
        b=OpHAU4vN4Gef4LzD0Ay4UPyalA+Nvu6v3p29IXAAnrxcF7LR2gnyR/SmiuCA0g8DNi
         ZEaXD06dPCxDvBGXAbrsNUjuM/D4VbRUhWdA6leUtiqAZfPIrc7SEDnJ7MeCp++np9Ap
         sruXg2f4ICBuRSuzClcfvttuQC8ovTlYVuNvU9FRtxNvpuFyTmmMc6F23yp9DYAX30CX
         fYCZApOA0IaiFrRdKzBDvOyio31lNAYke1qRlY1BLn8YHiI/plXgSXv5Dftwt8VoBHHb
         UPiUdOxYeuknoYmZ+g3PqoD/y+IRxL2nIYTh8Z0y6o8mryl5vL9xO7d7Pr5DpNIG168T
         3mvQ==
X-Gm-Message-State: AOAM532FtTAoc/t+40007pfFcQTx9pjjM6NShA9DCxwHOu9b3tn6cATq
        mcxaRGB0ltnEoAY5ir5iOYucyBp2PITOfI+VRqBVwmTg9oL9vOItzGwAjs8dvnJ/k54TCrJZfGb
        7mIUK7UNWY9MBk8GCCAQLxabwOn/pGHpNRjUyKPt86HxV
X-Received: by 2002:a17:902:6b08:b029:f5:ece8:e96f with SMTP id o8-20020a1709026b08b02900f5ece8e96fmr25772104plk.34.1621910195768;
        Mon, 24 May 2021 19:36:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdz71g+9a02cELFio7Ho3sGkQfvbS7sYOolgtXb682E8iabu9agArgbCuGdfwK7JecFdHzMw==
X-Received: by 2002:a17:902:6b08:b029:f5:ece8:e96f with SMTP id o8-20020a1709026b08b02900f5ece8e96fmr25772080plk.34.1621910195499;
        Mon, 24 May 2021 19:36:35 -0700 (PDT)
Received: from localhost.localdomain (223-136-150-121.emome-ip.hinet.net. [223.136.150.121])
        by smtp.gmail.com with ESMTPSA id y14sm588077pjr.51.2021.05.24.19.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 19:36:34 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH] selftests: timers: rtcpie: skip test if default RTC device does not exist
Date:   Tue, 25 May 2021 10:36:14 +0800
Message-Id: <20210525023614.7251-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test will require /dev/rtc0, the default RTC device, or one
specified by user to run. Since this default RTC is not guaranteed to
exist on all of the devices, so check its existence first, otherwise
skip this test with the kselftest skip code 4.

Without this patch this test will fail like this on a s390x zVM:
# selftests: timers: rtcpie
# /dev/rtc0: No such file or directory
not ok 1 selftests: timers: rtcpie # exit=22

With this patch:
# selftests: timers: rtcpie
# Default RTC /dev/rtc0 does not exist. Test Skipped!
not ok 9 selftests: timers: rtcpie # SKIP

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/timers/rtcpie.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/timers/rtcpie.c b/tools/testing/selftests/timers/rtcpie.c
index 47b5bad..4ef2184 100644
--- a/tools/testing/selftests/timers/rtcpie.c
+++ b/tools/testing/selftests/timers/rtcpie.c
@@ -18,6 +18,8 @@
 #include <stdlib.h>
 #include <errno.h>
 
+#include "../kselftest.h"
+
 /*
  * This expects the new RTC class driver framework, working with
  * clocks that will often not be clones of what the PC-AT had.
@@ -35,8 +37,14 @@ int main(int argc, char **argv)
 	switch (argc) {
 	case 2:
 		rtc = argv[1];
-		/* FALLTHROUGH */
+		break;
 	case 1:
+		fd = open(default_rtc, O_RDONLY);
+		if (fd == -1) {
+			printf("Default RTC %s does not exist. Test Skipped!\n", default_rtc);
+			exit(KSFT_SKIP);
+		}
+		close(fd);
 		break;
 	default:
 		fprintf(stderr, "usage:  rtctest [rtcdev] [d]\n");
-- 
2.7.4

