Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4607616BE6D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2020 11:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgBYKSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Feb 2020 05:18:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56521 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgBYKSV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Feb 2020 05:18:21 -0500
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1j6XIB-0002Ri-5H
        for linux-kselftest@vger.kernel.org; Tue, 25 Feb 2020 10:18:19 +0000
Received: by mail-pj1-f72.google.com with SMTP id kx17so1794907pjb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2020 02:18:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+pTBMgNSyaWEJEV8vOsVhnaFO3AzlXBJYTusRgM9dWk=;
        b=Ec6xYsijcON6lURZaI8smj224KLJsSWElib8ze8pS8sPRo+67RaFczFe5KzjxgCSC9
         NBWoXTaO4WhTENYco5e087SC37gvisN6oHVYImMOUuGatRONi8z5XjvqUQHWoRAvzpYu
         XKB2CBMAFZXVWloJcycPn9WPS3fb1Lt4shuGqlzgXolma9YKJsCLi0jsL2hwWtcyFTiO
         cXcTBP7sP9hV0pmn0YLFqIWujgmuQ2lznrFSPs2JVQ1fg/Cyd5pE0sYOsbZtg3A0kX0q
         jNqvvfjwbArHvGHoQbb4t7hXjQMSDl8ixrD4wzy263Kzix8xPUCgKnfiNYLVPwYhgxPC
         ITVg==
X-Gm-Message-State: APjAAAWVNELx9GIJOBVb0xi/OwHlHfO8KDg0ialgknI9OlYfLB51WIQh
        Qb8da8GsTQaNcva7GRfy4fQvo5f+Gotvf80Y3aGabomnI2v5/TE3tgdKrKHzpNY2SEuHAKSqShK
        qM1QLjvk0pCK2iMc/aI+58iWFRjdnVsYDBeLvIPqCDDqq
X-Received: by 2002:a63:354d:: with SMTP id c74mr23102386pga.234.1582625897554;
        Tue, 25 Feb 2020 02:18:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqw32U8UJaAFKSu2igL+Ekf4jExX3nYSTtO0z6U+Ccmd+biRlFPNdgDC/4yTVAeys7G/igMjVg==
X-Received: by 2002:a63:354d:: with SMTP id c74mr23102359pga.234.1582625897225;
        Tue, 25 Feb 2020 02:18:17 -0800 (PST)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id v4sm15770025pff.174.2020.02.25.02.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 02:18:16 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org, sboyd@kernel.org,
        tglx@linutronix.de, john.stultz@linaro.org
Subject: [PATCH] selftests/timers: Turn off timeout setting
Date:   Tue, 25 Feb 2020 18:18:09 +0800
Message-Id: <20200225101809.9986-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Tests in timers especially nsleep-lat, set-timer-lat,
inconsistency-check and raw_skew these 4 tests can take longer than
the default 45 seconds that introduced in commit 852c8cbf
(selftests/kselftest/runner.sh: Add 45 second timeout per test) to run.

Disable the timeout setting for timers instead of looking for an proper
value to make it more general.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/timers/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/timers/settings

diff --git a/tools/testing/selftests/timers/settings b/tools/testing/selftests/timers/settings
new file mode 100644
index 0000000..e7b9417
--- /dev/null
+++ b/tools/testing/selftests/timers/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.7.4

