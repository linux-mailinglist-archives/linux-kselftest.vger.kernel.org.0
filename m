Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826FA48C8E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 17:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355388AbiALQyz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 11:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355400AbiALQyp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 11:54:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CCCC06173F;
        Wed, 12 Jan 2022 08:54:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E85B71F45406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642006480;
        bh=98h15yTAeCchfHlevZIufCufbR+WIqPYpWLbkpoz8gc=;
        h=From:To:Cc:Subject:Date:From;
        b=oW/HZVDk86/E9cS2akQLtrRrHfgHGAtsBMX7h6fKl8WFEAFDMdCXCdKNIjxnRFSRs
         koPCJgoMt+AHsDmTKQTnjyJhTuoPWG+wS0sqQiZnTLqw7eTsj/BHtPzl/Tas0/yoz7
         jxtnWi5VDwgpc8ANGEhjue73pgZ8K/YoMmHkY6Z83KHW1kBMmIu74JyPvF9L3N0nUK
         DcrS/Sgz+i6yzpMDayYqYJ8Y46WkCApRZxcVskI450yP2lYfO0MAqXKECptEDyvw22
         Z8UeXfXWpVnPTrbceN6KEKHmAsHMI+Ld3r+FdB3CsDNZ12Jhf2Tx/oU7YuhoO3ImXo
         qCIfEACxW1miA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH] selftests: rtc: Increase test timeout so that all tests run
Date:   Wed, 12 Jan 2022 11:53:59 -0500
Message-Id: <20220112165359.3206047-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The timeout setting for the rtc kselftest is currently 90 seconds.
However, two of the tests set alarms, which take one minute to complete
each. So the timeout should be at least 120. Set it to 180, so that all
tests are able to complete and still have some slack.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

This issue was discovered as part of adding the rtc kselftest to run on KernelCI
for the rk3399-gru-kevin device, which uses rtc-cros-ec as the RTC driver.

The output log with the current timeout is shown in [1]. As can be seen, the
whole test times out before the alarm_wkalm_set_minute test has had a chance to
complete:

	# #  RUN           rtc.alarm_wkalm_set_minute ...
	# # rtctest.c:294:alarm_wkalm_set_minute:Alarm time now set to 11/01/2022 23:03:00.
	#
	not ok 1 selftests: rtc: rtctest # TIMEOUT 90 seconds

With the increased timeout, as shown in [2], the alarm_wkalm_set_minute test
does complete its run:

	# #  RUN           rtc.alarm_wkalm_set_minute ...
	# # rtctest.c:294:alarm_wkalm_set_minute:Alarm time now set to 12/01/2022 15:54:00.
	# #            OK  rtc.alarm_wkalm_set_minute
	# ok 7 rtc.alarm_wkalm_set_minute
	# # FAILED: 6 / 7 tests passed.

The fact that the alarm_alm_set_minute test times out on its own is probably an
issue with the rtc-cros-ec driver. Still, since the tests are independent, all
of them should be able to run regardless of how long each one takes (so,
assuming the worst case scenario).

[1] https://lava.collabora.co.uk/scheduler/job/5409783
[2] https://lava.collabora.co.uk/scheduler/job/5415176

 tools/testing/selftests/rtc/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/settings b/tools/testing/selftests/rtc/settings
index ba4d85f74cd6..a953c96aa16e 100644
--- a/tools/testing/selftests/rtc/settings
+++ b/tools/testing/selftests/rtc/settings
@@ -1 +1 @@
-timeout=90
+timeout=180
-- 
2.34.1

