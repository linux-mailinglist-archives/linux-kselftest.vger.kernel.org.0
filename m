Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70A33B3F52
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 10:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYIcs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 04:32:48 -0400
Received: from m12-16.163.com ([220.181.12.16]:59200 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhFYIcr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 04:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=iEG0H
        ZrfdsRExiS31Jv9b2U7w7zkg1w6bByu3vwJ0YQ=; b=pzEzBc5Tk/lomC97EBWbW
        GVXFUZ7KyVq6p4mjFSN+/FWSp/aNbY8gbiuukp0zmsxFl+T5+j6rvwo4SBgAtsUP
        z2LoB93QwCrfjmNV8LcvXTnO8D7DIaGVfsdWUYj8PbY1WyTP+CnskAxqeADZWm1m
        b70U4IxpfR/nZDpjKlwDgQ=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAAntI0HlNVgXvyPzA--.36169S2;
        Fri, 25 Jun 2021 16:30:00 +0800 (CST)
From:   13145886936@163.com
To:     shuah@kernel.org, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] tools: timers: remove unneeded semicolons
Date:   Fri, 25 Jun 2021 01:29:57 -0700
Message-Id: <20210625082957.23908-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAntI0HlNVgXvyPzA--.36169S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF4xGw4DXF45Gw17Zw4ruFg_yoW5Wry5p3
        W8A3sIkr4xKF13JF18tr4qgFWrWF9rKrW8JF15A34DZw4fJFyfXF47tFy7JFZ3u3y5X393
        Aas7WF45uw4UCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07b1byZUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzh68g1QHNBBrawACsa
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove unneeded semicolons.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 tools/testing/selftests/timers/alarmtimer-suspend.c  | 2 +-
 tools/testing/selftests/timers/inconsistency-check.c | 2 +-
 tools/testing/selftests/timers/nanosleep.c           | 2 +-
 tools/testing/selftests/timers/nsleep-lat.c          | 2 +-
 tools/testing/selftests/timers/set-timer-lat.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 4da09dbf83ba..54da4b088f4c 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -79,7 +79,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 022d3ffe3fbf..e6756d9c60a7 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441c2fd9..433a09676aeb 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index eb3e79ed7b4a..a7ca9825e106 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -72,7 +72,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..d60bbcad487f 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -80,7 +80,7 @@ char *clockstring(int clockid)
 		return "CLOCK_BOOTTIME_ALARM";
 	case CLOCK_TAI:
 		return "CLOCK_TAI";
-	};
+	}
 	return "UNKNOWN_CLOCKID";
 }
 
-- 
2.25.1


