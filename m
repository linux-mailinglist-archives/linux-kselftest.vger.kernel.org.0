Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE447074E
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 18:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241422AbhLJRhT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 12:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244519AbhLJRhQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 12:37:16 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D25C0698C9
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:37 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id r10-20020a056830080a00b0055c8fd2cebdso10312129ots.6
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DiZeUVUX8yxJeM10Cpt7v1VvqmpI5eFmoRBxYdddIiM=;
        b=K0OpNOeDoVajb3W4xt0KX7FV9FbcaAXSxNvrA6087bIQw7tap5Xv3ErI4wfxiVZEYz
         M6AfFqilfX8ijAknnwuE2KW46iOXBC7rxJrpuL1JwcedYnpdXUvl2dp2O008xrVpHkp/
         0+YC6YtffxgVuZdSYs9NfFLK09hxHT0eSo2gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DiZeUVUX8yxJeM10Cpt7v1VvqmpI5eFmoRBxYdddIiM=;
        b=K1P8icRo3V//wma7HrE8fy7qTE38LTrCde70AKovbHPhTeaWg75JvfuRXPUBUzr9/A
         9evBAOIDcgNZqo5hgkmJDfzgw96iTfDhfLqoT3Kiq13HWUBeqpoLRSYFxXcNwHJjMlqk
         BI+hOIfJxmIrjZ7ducoHk/TvV91LnEVrxdpGZYx6P3rDwwhtnNZOUd7EhORsncyWDEWM
         FigfhYURE6oieYnfVm10WvaQ1h7w7DObYVXXvk+8OVt1ZdvqjYM8tDVgSrPUeWY+oUuI
         gw9iYY4fgIlOxB07P9hnSUpCHcAKx/m1LgR8bEEx8OSAkuM57LJJ5Yy0x3ssc6yDqhwx
         bIiQ==
X-Gm-Message-State: AOAM532UKrDpNyc4O62Y7rHRK1PwPMniVPkRuyMcqGd6qekUUuAPlTQI
        4Vp04lnRqlXkSmADJsMo1Iq1+A==
X-Google-Smtp-Source: ABdhPJwjEnwr1b7d/xDdJEMULYxeBIxDwb3X/wQaHnBiudTS3BTD6SqME8GwsDGoPjchyNdPyOCytA==
X-Received: by 2002:a05:6830:1e4a:: with SMTP id e10mr12001687otj.58.1639157616590;
        Fri, 10 Dec 2021 09:33:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id x4sm892224oiv.35.2021.12.10.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 09:33:36 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        keescook@chromium.org, mic@digikod.net, davem@davemloft.net,
        kuba@kernel.org, peterz@infradead.org, paulmck@kernel.org,
        boqun.feng@gmail.com, akpm@linux-foundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 11/12] selftests/timens: remove ARRAY_SIZE define from individual tests
Date:   Fri, 10 Dec 2021 10:33:21 -0700
Message-Id: <5837749541102ed658cfae6ab4b68be9f7f96688.1639156389.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1639156389.git.skhan@linuxfoundation.org>
References: <cover.1639156389.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ARRAY_SIZE is defined in several selftests. Remove definitions from
individual test files and include header file for the define instead.
ARRAY_SIZE define is added in a separate patch to prepare for this
change.

Remove ARRAY_SIZE from timens tests and pickup the one defined in
kselftest.h.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/timens/procfs.c | 2 --
 tools/testing/selftests/timens/timens.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index f2519154208a..1833ca97eb24 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -24,8 +24,6 @@
 #define DAY_IN_SEC			(60*60*24)
 #define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 static int child_ns, parent_ns;
 
 static int switch_ns(int fd)
diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
index 52b6a1185f52..387220791a05 100644
--- a/tools/testing/selftests/timens/timens.c
+++ b/tools/testing/selftests/timens/timens.c
@@ -22,8 +22,6 @@
 #define DAY_IN_SEC			(60*60*24)
 #define TEN_DAYS_IN_SEC			(10*DAY_IN_SEC)
 
-#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
-
 struct test_clock {
 	clockid_t id;
 	char *name;
-- 
2.32.0

