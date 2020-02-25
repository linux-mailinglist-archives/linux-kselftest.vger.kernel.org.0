Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED84816EBDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 17:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgBYQ6F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 11:58:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgBYQ6F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 11:58:05 -0500
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j6dX1-0000Pi-7Q
        for linux-kselftest@vger.kernel.org; Tue, 25 Feb 2020 16:58:03 +0000
Received: by mail-pl1-f198.google.com with SMTP id g5so7763707plq.17
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2020 08:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tmq5/QscEAlIKXHg+Ug+knf6u6cqRVBxVv3NqJuFm50=;
        b=OGxeZMaf05uNwI3s68daxjBpsGm5qvjRlDq8kj5q7ZXxxcDvUB/qRF43VAqUlk1eBu
         Ly8VHyfWUsDtx4UiQu2hXnOrdsGFVfoqrD3jNM5Xq28gZxPs7Ldi8ZL2rymJW+Un7ND5
         bkk2mqqIVXdytqc5M28xWtTaNfTcR5nB/MR7qhq5qXv185GMJ09uedZXVR6jb8JaMBkT
         NRn6V3djj/z5J0TrXU/75zy5O+MaFTv5l7gdZ4TDvE++7s4J1YDTEQa+0sN3pBIseMVn
         LYD6Ijq0mKUvQakhHwhoJ4+GwbN0WoE91jd6I736BHZ5HuUKpBsv44HiX0SEEG0YypVG
         x1BA==
X-Gm-Message-State: APjAAAV4wvWwtOKxng3dMPZtSmJIpud0OeDulgrl8PT68+sXUHr6eF3P
        mRNdeIYYVSaTj1dAzTyBm9ilx+m0do1QmtGGlJe9q7fPDplZshFij0fkVFgqcsp+mxc34Sqyh3+
        0Icl3ETpOH/xOZQwbiZjGBFIONCsCH35CnJpx/yBzhdZv
X-Received: by 2002:a63:7d46:: with SMTP id m6mr56273065pgn.38.1582649881487;
        Tue, 25 Feb 2020 08:58:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzDCUsO23WLo7Kej+kPuOKSIr5NpcgPj7a/xYcGbZxHSW4SNQ4GSRF97BOQStSuVJhPvD3Zbg==
X-Received: by 2002:a63:7d46:: with SMTP id m6mr56273040pgn.38.1582649881092;
        Tue, 25 Feb 2020 08:58:01 -0800 (PST)
Received: from localhost.localdomain (223-137-37-84.emome-ip.hinet.net. [223.137.37.84])
        by smtp.gmail.com with ESMTPSA id i22sm3558212pgi.69.2020.02.25.08.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 08:58:00 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, sboyd@kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] selftests/timers: Turn off timeout setting
Date:   Wed, 26 Feb 2020 00:57:49 +0800
Message-Id: <20200225165749.6399-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following 4 tests in timers can take longer than the default 45
seconds that added in commit 852c8cbf (selftests/kselftest/runner.sh:
Add 45 second timeout per test) to run:
  * nsleep-lat - 2m7.350s
  * set-timer-lat - 2m0.66s
  * inconsistency-check - 1m45.074s
  * raw_skew - 2m0.013s

Thus they will be marked as failed with the current 45s setting:
  not ok 3 selftests: timers: nsleep-lat # TIMEOUT
  not ok 4 selftests: timers: set-timer-lat # TIMEOUT
  not ok 6 selftests: timers: inconsistency-check # TIMEOUT
  not ok 7 selftests: timers: raw_skew # TIMEOUT

Disable the timeout setting for timers can make these tests finish
properly:
  ok 3 selftests: timers: nsleep-lat
  ok 4 selftests: timers: set-timer-lat
  ok 6 selftests: timers: inconsistency-check
  ok 7 selftests: timers: raw_skew

https://bugs.launchpad.net/bugs/1864626
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/timers/Makefile | 1 +
 tools/testing/selftests/timers/settings | 1 +
 2 files changed, 2 insertions(+)
 create mode 100644 tools/testing/selftests/timers/settings

diff --git a/tools/testing/selftests/timers/Makefile b/tools/testing/selftests/timers/Makefile
index 7656c7c..0e73a16 100644
--- a/tools/testing/selftests/timers/Makefile
+++ b/tools/testing/selftests/timers/Makefile
@@ -13,6 +13,7 @@ DESTRUCTIVE_TESTS = alarmtimer-suspend valid-adjtimex adjtick change_skew \
 
 TEST_GEN_PROGS_EXTENDED = $(DESTRUCTIVE_TESTS)
 
+TEST_FILES := settings
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/timers/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4

