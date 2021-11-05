Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99884445D5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 02:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhKEBif (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 21:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhKEBie (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 21:38:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2EDC061714;
        Thu,  4 Nov 2021 18:35:56 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id az8so7535562qkb.2;
        Thu, 04 Nov 2021 18:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiaOGKq4FmlnzvPuVfHkcdLQnMCut1ocGVdyodYUkvU=;
        b=foTH20+IWuvdIPU1jo5HDx577DWQ0Em/tVGo5imA9rHJ4Bx0na7IaYpA29FJdzUEN+
         Z01zKxyM71E9VtOv9yQOGb8mnDegLAbJAeEgrj99UuSu8hHKv3krld5FQu7ABLHOHvVI
         Jx9lz8AY8O7Gfarci1TYC+L/jnt9KDKk+N7HvJF9DfTLcSJInHYpZfbMDZcL8tj1JlBk
         hwaobRMTM6lT8QaDGQYiJnde39TI5ezk3tXPCuBvpuwmSN4LCsjeG/dI2qLeWc3tpR2a
         kpyARzEfTeyD1AdmqJKFK9bkwspbzqN4L2XUYUlF85SElMiOdEhCxlBO9hm4BnnyOCkY
         OAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiaOGKq4FmlnzvPuVfHkcdLQnMCut1ocGVdyodYUkvU=;
        b=8G+GineGpjVXC4fIk+khj/bsmvdcoNyWimCclq9DxskzECyhufXsTMv1EC8ptmoYfY
         HsXGFTSmCIQQL38G49a98dR6Cd/FcAC44xlYs7FqkNKjzEGbbzdCH7QrxSv3z0H5sikQ
         H2jYIebQWSkRgbOuIi9Djc4fKORLppG9+Kqn4qFazYt1xLBNrwv8zMzQySF+etUvxO+9
         Eczdkzv95hC0dxUDKem5UWYLJWxtpzf63QdjBWZj9UykZwqPAYKa24k16AocfkfdzAsx
         AqUVDoP9t9AUytoaHpus8lZjMCJMLgm1Qx1cAucDsDCN0meP2j48IdXbuj7Hr1O5VFHA
         aJcg==
X-Gm-Message-State: AOAM530qqNngmnSH5+6iz8QLJCDjCr0uj98GvQr2sJxsoUPNCFRFPZXE
        qZeCocC42hxm0wSL1Az0+Yo=
X-Google-Smtp-Source: ABdhPJwsVZPqK7JetU/48F1kQvt56eFGAZT8NyBCqKHbgtA09EfZ6gWapJoqKoT07nlMhk/03evkQw==
X-Received: by 2002:a05:620a:4312:: with SMTP id u18mr44551553qko.483.1636076155429;
        Thu, 04 Nov 2021 18:35:55 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u11sm4905341qko.119.2021.11.04.18.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:35:55 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] kselftests: timers:Remove unneeded semicolon
Date:   Fri,  5 Nov 2021 01:35:47 +0000
Message-Id: <20211105013547.74922-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
tools/testing/selftests/timers/alarmtimer-suspend.c:82:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 tools/testing/selftests/timers/alarmtimer-suspend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.25.1

