Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A16728D5E
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 00:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388520AbfEWWm7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 May 2019 18:42:59 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48695 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387616AbfEWWm6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 May 2019 18:42:58 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9B0D71C0008;
        Thu, 23 May 2019 22:42:52 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] selftests: rtc: rtctest: specify timeouts
Date:   Fri, 24 May 2019 00:42:23 +0200
Message-Id: <20190523224223.11054-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
References: <20190523224223.11054-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

uie_read is a commonly failing test that will block forever on buggy rtc
drivers. Shorten its timeout so it fails earlier. Also increase the timeout
for the two alarm test on a minute boundary.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 tools/testing/selftests/rtc/rtctest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index b2065536d407..66af608fb4c6 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -49,7 +49,7 @@ TEST_F(rtc, date_read) {
 	       rtc_tm.tm_hour, rtc_tm.tm_min, rtc_tm.tm_sec);
 }
 
-TEST_F(rtc, uie_read) {
+TEST_F_TIMEOUT(rtc, uie_read, NUM_UIE + 2) {
 	int i, rc, irq = 0;
 	unsigned long data;
 
@@ -211,7 +211,7 @@ TEST_F(rtc, alarm_wkalm_set) {
 	ASSERT_EQ(new, secs);
 }
 
-TEST_F(rtc, alarm_alm_set_minute) {
+TEST_F_TIMEOUT(rtc, alarm_alm_set_minute, 65) {
 	struct timeval tv = { .tv_sec = 62 };
 	unsigned long data;
 	struct rtc_time tm;
@@ -264,7 +264,7 @@ TEST_F(rtc, alarm_alm_set_minute) {
 	ASSERT_EQ(new, secs);
 }
 
-TEST_F(rtc, alarm_wkalm_set_minute) {
+TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
 	struct timeval tv = { .tv_sec = 62 };
 	struct rtc_wkalrm alarm = { 0 };
 	struct rtc_time tm;
-- 
2.21.0

