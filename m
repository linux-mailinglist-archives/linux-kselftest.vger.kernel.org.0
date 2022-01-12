Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2448CC2F
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jan 2022 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbiALToA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jan 2022 14:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344616AbiALTl7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jan 2022 14:41:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBC7C034001;
        Wed, 12 Jan 2022 11:41:58 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id E97761F45477
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642016516;
        bh=j1WfXZUz+wC9kqhM1EXQE7wmwlkIqg3xZKNoHdE+zsc=;
        h=From:To:Cc:Subject:Date:From;
        b=UViVjohB8AQZ8CMFZdINzd6tR3m1h7AeoyD7I0YxkLwdrHmERgMWet1kVbNkTJ7Wt
         HLS+HWBKVI0ah60gKk98VimUnWC6P4PxwLexIG65A+iIZjX5Iz1bTULR21/DV5xaWr
         tH/kUjaCo5jtsxW6/4oR0XSlQc4fDO3QZUfIDFDbTqQIZz5dUaemT91YSSm9/qjdqT
         DvKdAXJorG0Rga2briDUW48ymqMB25JTjQncFUiPLMjPOoRhKfw4mMFn0qw8dMjsHM
         C68H8HZe4hGSljKUl2DloCQePSejdpQnuVnkrKWDC+rSMxAGMDXkFjJprt7qnofEjb
         8LpANljyChipQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Shuah Khan <shuah@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>
Cc:     linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
Subject: [PATCH v2] selftests: rtc: Increase test timeout so that all tests run
Date:   Wed, 12 Jan 2022 14:41:42 -0500
Message-Id: <20220112194142.3276385-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The timeout setting for the rtc kselftest is currently 90 seconds. This
setting is used by the kselftest runner to stop running a test if it
takes longer than the assigned value.

However, two of the test cases inside rtc set alarms. These alarms are
set to the next beginning of the minute, so each of these test cases may
take up to, in the worst case, 60 seconds.

In order to allow for all test cases in rtc to run, even in the worst
case, when using the kselftest runner, the timeout value should be
increased to at least 120. Set it to 180, so there's some additional
slack.

Correct operation can be tested by running the following command right
after the start of a minute (low second count), and checking that all
test cases run:

	./run_kselftest.sh -c rtc

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---

Changes in v2:
- Expanded commit message to make the issue, and how to test the fix, clearer

v1: https://lore.kernel.org/all/20220112165359.3206047-1-nfraprado@collabora.com/

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

