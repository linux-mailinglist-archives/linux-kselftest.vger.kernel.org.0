Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4632E3DD10A
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Aug 2021 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbhHBHOW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Aug 2021 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhHBHOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Aug 2021 03:14:21 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EBDC06175F;
        Mon,  2 Aug 2021 00:14:12 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so14868578pjz.0;
        Mon, 02 Aug 2021 00:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYGE701/ldiF9KITcm5HXRiWM/dLf2ZAwVce1ur94Jk=;
        b=DIRDfI+J9salXANALN6k12/S6q39hYPOE12NNmePaVxc44rIbPEt3P9fkaPpOQbB/p
         n1lhtrjyjBx1h4dApSOEFpEYm6jaGWMZmI+7u8GnCNldJNac6p4EuNwDN/E5XKWOKrD5
         l7lswtEMlnKH3qo8qr+QohR9gO2+7UMglJuqFU2Qo1QacDlZO4w8gJgDD8GaqPK9qfL4
         U/UGy6ldgTJDD5veSbeEeDCHmakmEBT0MWXykeBh1EHCTersBnBr0XMTqBLbxrcKTbEO
         P9k4V2mRP9YWf1WqrghvuErISXE9SQTAN5SWDW6LuChTUN0H9gzMhWhBjhZos0A1x9MW
         Qa/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oYGE701/ldiF9KITcm5HXRiWM/dLf2ZAwVce1ur94Jk=;
        b=BDcj2N5CBJcRoFhrywFVW0oeMeRa51c7SYGMMUMZli6oZ9Hu7do0kxSEqsyDJI3ZJ2
         8gxMayEIl7t7Qi6jnlZ/42y5TtPQEUZ1WmvgAJgMhFTgm57qgBYli5PAWVmO1HtXmwU5
         68GC7J8Y4umthsxwc9wiUne0qJJuoAF4qe4C7L54zflD0po5ZQpEGDeDqSuJIJF7ZSFU
         9m7DrDc6CG4zYFczX6mnf/F0xN7IDSLyZEQ+rFAZjjUTYIfmphmy228KLObnxgabOsZL
         GiPiftN09KbPSVx1OwBj6YcX18GleTwtVkE1K0LZDv5idH8pJPrGKedyciep8wnwe+Vx
         mBkg==
X-Gm-Message-State: AOAM530LyMowo8yokRT/tOAoJcWWaKV+fw7mO+diggW6Nh2RdbPX6pEc
        udtIGHL0zFoc5Odpsin9lLSIGRMJr1YycQ==
X-Google-Smtp-Source: ABdhPJwsyeWiLLqfHUyWXSj4bhFKoFz5Dy8Kja7ki47VV1ZtfvLOUGmXFl7BnFo7/wRgnTIJvPCtMQ==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr15418664pfh.17.1627888451608;
        Mon, 02 Aug 2021 00:14:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 20sm10883973pfi.170.2021.08.02.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 00:14:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     jasowang@redhat.com
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        shuah@kernel.org, mst@redhat.com, zhang.yunkai@zte.com.cn,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools: remove unneeded semicolon
Date:   Mon,  2 Aug 2021 00:14:49 -0700
Message-Id: <20210802071449.588393-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

Fix the following coccicheck REVIEW:
./tools/testing/selftests/timers/inconsistency-check.c:75:2-3 REVIEW
Unneeded semicolon
./tools/testing/selftests/timers/set-timer-lat.c:83:2-3 REVIEW Unneeded
semicolon
./tools/virtio/virtio-trace/trace-agent-ctl.c:78:2-3 REVIEW Unneeded
semicolon
./tools/testing/selftests/timers/nanosleep.c:75:2-3 REVIEW Unneeded
semicolon
./tools/testing/selftests/timers/nsleep-lat.c:75:2-3 REVIEW Unneeded
semicolon
./tools/testing/selftests/timers/alarmtimer-suspend.c:82:2-3 REVIEW
Unneeded semicolon

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 tools/testing/selftests/timers/alarmtimer-suspend.c  | 2 +-
 tools/testing/selftests/timers/inconsistency-check.c | 2 +-
 tools/testing/selftests/timers/nanosleep.c           | 2 +-
 tools/testing/selftests/timers/nsleep-lat.c          | 2 +-
 tools/testing/selftests/timers/set-timer-lat.c       | 2 +-
 tools/virtio/virtio-trace/trace-agent-ctl.c          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

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
 
diff --git a/tools/virtio/virtio-trace/trace-agent-ctl.c b/tools/virtio/virtio-trace/trace-agent-ctl.c
index 73d253d4b559..39860be6e2d8 100644
--- a/tools/virtio/virtio-trace/trace-agent-ctl.c
+++ b/tools/virtio/virtio-trace/trace-agent-ctl.c
@@ -75,7 +75,7 @@ static int wait_order(int ctl_fd)
 
 		if (ret)
 			break;
-	};
+	}
 
 	return ret;
 
-- 
2.25.1

