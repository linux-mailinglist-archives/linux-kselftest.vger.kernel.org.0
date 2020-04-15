Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED51A9313
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 08:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634769AbgDOGSW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 02:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634767AbgDOGST (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 02:18:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B24C061A0C;
        Tue, 14 Apr 2020 23:18:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 2so998400pgp.11;
        Tue, 14 Apr 2020 23:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Z6dDXrpHCpb7QojGdJNeUUCIdrdGWNtgqpKwnuCk6j0=;
        b=eLOWgaBqZYmjC9zj5lo0gSh2lMVT5vngHBkvkm8lJA/2MOQ1VFcbzk1ZgN83e56OFb
         c2AeijNIzKQ1lvhspUZB6eDBAU2u5Qi62C4B+BoDAKg/we66nv2IXSRGO4CT7fg/zMkT
         iwe/uTS+VxHP8Zl7HWyCAE9oY/Xt17fHezxHq0L4yJwsBBsQ+W40B5BTWX1I9xMoG/La
         mETMuyOLtjD1q7onc30R3GCBvNwBeF/BhlC48SW6ZB7w4Clym64C1J8qgvamhtYEcfyM
         QJoq9T5Q+rVsg+fRzIS9flb0fPk3MkIJviMso5H6DOEZsd70n8Wv29nmJ76RQDjAbuiN
         pcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z6dDXrpHCpb7QojGdJNeUUCIdrdGWNtgqpKwnuCk6j0=;
        b=C1MlqazwCF8aSCqg/OuLq12/o9A1z0pklmuayJwiRmAyQy8hpAp3mGBNmmN9ClkozZ
         8C6PeF6fe5TF76GzpHvPpYQzwBpcYdEEqbmWxN5k3PXrEusWbbauHA+VfDiPvjJGH3OR
         8d9LP3k1QeJ38r4Mh7LCRNbxsq7JJ5Cq/6hw5KewmCNliAgMISRc4Fvv5qErzcxKxYFd
         5JNfRrPJFhOWiEpOwweDaAGU7RatAfA3a5RJhIJlt0I3QcIZbytzh/Iyy8Tmf26GOQft
         bdQIp0duuSD8WZym263bBf+K5eQsur8QNiRXUmvlyJSnsBAyqNSYJDKXzBRqV1MaIrBr
         5BbQ==
X-Gm-Message-State: AGi0PuYmodNuEFLKHAtDNVZkSf9KSLdhT1YuhTcnZnaJJY6tqZDlVvSi
        dxfhaP5tFU+cAvERxa96PQ8=
X-Google-Smtp-Source: APiQypIMB3BTefjO/UkPylwPC1Tp3Dk9VsE2452jM37H/UaMqGX6nhVLVm04Cdjr6QH7Ui2+q+URDQ==
X-Received: by 2002:a63:f45:: with SMTP id 5mr24543924pgp.31.1586931498023;
        Tue, 14 Apr 2020 23:18:18 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id e22sm11694502pgh.14.2020.04.14.23.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:18:17 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrei Vagin <avagin@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH] selftests/timens: handle a case when alarm clocks are not supported
Date:   Tue, 14 Apr 2020 23:18:02 -0700
Message-Id: <20200415061802.722485-1-avagin@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This can happen if a testing node doesn't have RTC (real time clock)
hardware or it doesn't support alarms.

Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 tools/testing/selftests/timens/clock_nanosleep.c |  2 +-
 tools/testing/selftests/timens/timens.c          |  2 +-
 tools/testing/selftests/timens/timens.h          | 13 ++++++++++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timens/clock_nanosleep.c b/tools/testing/selftests/timens/clock_nanosleep.c
index 8e7b7c72ef65..72d41b955fb2 100644
--- a/tools/testing/selftests/timens/clock_nanosleep.c
+++ b/tools/testing/selftests/timens/clock_nanosleep.c
@@ -119,7 +119,7 @@ int main(int argc, char *argv[])
 
 	ksft_set_plan(4);
 
-	check_config_posix_timers();
+	check_supported_timers();
 
 	if (unshare_timens())
 		return 1;
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 559d26e21ba0..07feebe8e53e 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -156,7 +156,7 @@ int main(int argc, char *argv[])
 
 	nscheck();
 
-	check_config_posix_timers();
+	check_supported_timers();
 
 	ksft_set_plan(ARRAY_SIZE(clocks) * 2);
 
diff --git a/tools/testing/selftests/timens/timens.h b/tools/testing/selftests/timens/timens.h
index e09e7e39bc52..d4fc52d47146 100644
--- a/tools/testing/selftests/timens/timens.h
+++ b/tools/testing/selftests/timens/timens.h
@@ -14,15 +14,26 @@
 #endif
 
 static int config_posix_timers = true;
+static int config_alarm_timers = true;
 
-static inline void check_config_posix_timers(void)
+static inline void check_supported_timers(void)
 {
+	struct timespec ts;
+
 	if (timer_create(-1, 0, 0) == -1 && errno == ENOSYS)
 		config_posix_timers = false;
+
+	if (clock_gettime(CLOCK_BOOTTIME_ALARM, &ts) == -1 && errno == EINVAL)
+		config_alarm_timers = false;
 }
 
 static inline bool check_skip(int clockid)
 {
+	if (!config_alarm_timers && clockid == CLOCK_BOOTTIME_ALARM) {
+		ksft_test_result_skip("CLOCK_BOOTTIME_ALARM isn't supported\n");
+		return true;
+	}
+
 	if (config_posix_timers)
 		return false;
 
-- 
2.24.1

