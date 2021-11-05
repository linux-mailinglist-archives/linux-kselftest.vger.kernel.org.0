Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C790445D6D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 02:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhKEBo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Nov 2021 21:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhKEBo6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Nov 2021 21:44:58 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2FC061714;
        Thu,  4 Nov 2021 18:42:19 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id p17so6430820qkj.0;
        Thu, 04 Nov 2021 18:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITrJUnw7rkfh2Wf9B9wfIDhx+P5qj5dAVCCwNnxlr+M=;
        b=Kan0rv4WLr9CMltmC7lRAGKJNjz1BuvyghuANn2y/rrQLCKzNpJC/8ey8GHfsWIIVy
         WvGWCu3PUEvohuQjtRHnySFx4A52q44e+znVdIluj6Z9WyOw+RKVoKvSnbW67ExofjWq
         X994tlgR2F7qBi4HsdfO7w733EMAS2W0NPrKuuyBW9A+CCCB1crjCD97y731ZTOn8/yc
         Vezcblpdc//g+jQ0hjepFYtpveVSMZ5r9i18RTi35LHE8cE1h2vxCUyH64NKXdOMkHPQ
         2a3HiOu6B90rRlTcDSd6pmOuc8D96b5n4Q74rGgAMkRijH5RpHEY64SEvII6YRrMuK0B
         1x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ITrJUnw7rkfh2Wf9B9wfIDhx+P5qj5dAVCCwNnxlr+M=;
        b=LoPIB1CUTaQQWGyAeIqfrBmdVUeMPdN1kUkQN51OaULMAn8L+D2lZfKkQcJk+2e/CH
         eaIHR7UY9lnL3/A6QRMLB9TTBJfaT4lo7nDVDL/orJ5nm4oC5nnjeUHCzSfocehiQASy
         FZLQvkz92um+FDyyxpFapsz1yzA5YYCbRagbGA9ZlYqO2RwkKtdxuXFa5ZX55o0OdrFl
         EUWHAkca0+zym+xWMe61sPUZ7Ytw84VD4nv7Yp6uJ+DjohD4E2KtmCJOEC0WfTTOR8eo
         xhh1oumazleuFp57TFXq4/3QPsbp5QqRpOBA7N65hN+gkG07s+Rtg9ACm6WFHkokraAX
         JrcQ==
X-Gm-Message-State: AOAM533yxewdDiczyFYnBC2Cm0QjbXqrd/npsMz7Ucjl9IPhiWBOzrTR
        nmWy44wazpv0JCSQD7M4KEI=
X-Google-Smtp-Source: ABdhPJzCz1SScO5K5WMk42sNNUHDduT151VVMmwmfrFLD06mb1OSOonxN18dxAhnMniTGouCFYIiqg==
X-Received: by 2002:a05:620a:2234:: with SMTP id n20mr2018847qkh.89.1636076538393;
        Thu, 04 Nov 2021 18:42:18 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y14sm1781124qta.86.2021.11.04.18.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 18:42:18 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, sboyd@kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] selftests: timers: Remove unneeded semicolon
Date:   Fri,  5 Nov 2021 01:42:08 +0000
Message-Id: <20211105014208.75204-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

Eliminate the following coccinelle check warning:
tools/testing/selftests/timers/inconsistency-check.c:75:2-3

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 tools/testing/selftests/timers/inconsistency-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
 
-- 
2.25.1

