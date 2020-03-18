Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D328C18940B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Mar 2020 03:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgCRCmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Mar 2020 22:42:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46614 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCmi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Mar 2020 22:42:38 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jEOfE-00084l-Nm
        for linux-kselftest@vger.kernel.org; Wed, 18 Mar 2020 02:42:36 +0000
Received: by mail-pg1-f199.google.com with SMTP id j19so16073877pgh.14
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Mar 2020 19:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GsOy9t03XGdTipJAvqpux+ltTjSLmiQ456gUIIsZRek=;
        b=k4AQWEf9b6lF1OXxJnQ9jL98RuURmc2q5zpAu+fqRTrVMYW9tzNtThXhEfEz6+eBvP
         LY2GBKzOYnwwshGsQfmguJIy3AjmVsLDbMiGkzLEd0AwDthFrGytLVJaQrZdAdPIOJ59
         aqN0fj6jxO/So9OevB7askk6lj52HJeoPW/M3F7KHAZ8zo8+iIAuimbeHdijHCzzm8/e
         cvqzdRn4KcNvGxPDb8jJseeVGkkDn5Vrh3w8gywwa866pyCB2/OXGOwkm4QZVGMUxYUe
         ZFh7sw07K+gVagix4JoFnwDHERH9sR50AsL0zYaBHpF7kkMafqIdyfP4AXyYAy4CwdKm
         wBcg==
X-Gm-Message-State: ANhLgQ0NUd5LNj2U/4JkSfcHZtinFZEI0NZU6fkR1Imi4T2JlbN5N9cl
        T911Q7NcLDH9DQKlezwxv1d0CyreUTx+yl9aGZ+OXOek56rm3JiyFghRRuwcrqvDN1I1U5mSCcZ
        8B0mu7CYKNeEp3M8oze8+ipBr+EMmJLtWJt2OFmqhqQ4w
X-Received: by 2002:a63:ba59:: with SMTP id l25mr2360394pgu.68.1584499354991;
        Tue, 17 Mar 2020 19:42:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vss9SUSECX13z9sVq6fy0RmtXj7ZGlEYGUBOwbZ+k+Decq1wFjFrELMFURMZeJhzOfZARn/NQ==
X-Received: by 2002:a63:ba59:: with SMTP id l25mr2360365pgu.68.1584499354662;
        Tue, 17 Mar 2020 19:42:34 -0700 (PDT)
Received: from localhost.localdomain (114-136-162-243.emome-ip.hinet.net. [114.136.162.243])
        by smtp.gmail.com with ESMTPSA id fz3sm613938pjb.41.2020.03.17.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 19:42:33 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org, sboyd@kernel.org, tglx@linutronix.de,
        john.stultz@linaro.org, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3] selftests/timers: Turn off timeout setting
Date:   Wed, 18 Mar 2020 10:42:15 +0800
Message-Id: <20200318024215.5270-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The following 4 tests in timers can take longer than the default 45
seconds that added in commit 852c8cbf34d3 ("selftests/kselftest/runner.sh:
Add 45 second timeout per test") to run:
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
Fixes: 852c8cbf34d3 ("selftests/kselftest/runner.sh: Add 45 second timeout per test")
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

