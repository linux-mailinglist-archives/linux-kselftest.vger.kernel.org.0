Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4112DD30C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 15:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgLQOet (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 09:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQOet (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 09:34:49 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AF2C061794;
        Thu, 17 Dec 2020 06:34:09 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s21so19126100pfu.13;
        Thu, 17 Dec 2020 06:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vurp5AB62xjY65/6uguVYlQjjwgwSNtjp5iCAxAyneI=;
        b=mQHlNiaQxsFzbhdWdM8P5t7Y4gC7Vq+rIJaPFhhej/EzteBKWkrd56IP7D6vMsN/Tz
         W87E1rjQmJs9xHil0hDHw35VX+XSIx6LkSl7F/4jJkezlI/GwYUzl+ewLijeXJ4dmJ6c
         h1xm4gy4O8qUqAxPYEWGBCfynXDD5c9A2BZZ8UsfDvHvmzeiW2VvDNV2H1QckdndBSLQ
         ARMzby6c0ea7bKZaV+0Tmqh80eQgw5RvsBrLiEPZvj7eqP2ic90nEBS8+N8T67aNjfKP
         ztApQwzqGwzwWmjV2e7llLTqRXc08Wi3wW8+FZTW70+JNmQIjsxNQQjSOkgxgIedsQWQ
         wlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vurp5AB62xjY65/6uguVYlQjjwgwSNtjp5iCAxAyneI=;
        b=lI4NdXaOwc3vCIbqEdXHKjuYmDEI03jQYZmVHWlLimeDzW2ujgDtdLv8zT95NOBJKl
         L85xCg5AGulRthb/eHrHa3ugmaLlk/gvK34C11K0vJyFfIE59Qiv2Pom9oLkYtTOxCa4
         I2XksN/nLiLs3qUTYELCntc2XEBk7EWVnOaobKakP+O9xeViKYs9XzKzOIMgzwQjQElE
         kRWP/IeifyQT2RC6Bwl9GgU72CZoqaLnjbbHjI/TNFBdXXjY5zi0jIHVkWe8vPDz4ZHY
         tYGrcwAW79vJ/WUleJmo+Nw4WZVo7aGIUDLfQG7qC1P9QuN2WD4DA36+2jLDqUzCnbTF
         RXPw==
X-Gm-Message-State: AOAM531QzK7xqss5Z6MWDis3LrkBoyJavcVlEDm78+IGY43TLGUPYUGo
        tkPM/Y+vPwoho9RwKDOmwvDvY/Q8ttEF+A==
X-Google-Smtp-Source: ABdhPJwa6j3MTE+2geq5QFVRSZ6FWeyy5u/CFgRUCzuoGygyTQnGk8x2QESlE0g9fE4DJmTJIZbpOA==
X-Received: by 2002:aa7:8209:0:b029:19f:3002:513 with SMTP id k9-20020aa782090000b029019f30020513mr7206322pfi.49.1608215648491;
        Thu, 17 Dec 2020 06:34:08 -0800 (PST)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id v12sm6531052pgq.3.2020.12.17.06.34.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 06:34:08 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftest: parse the max cpu corretly from cpu list string
Date:   Thu, 17 Dec 2020 23:34:33 +0800
Message-Id: <20201217153434.10945-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20201217153434.10945-1-jiangshanlai@gmail.com>
References: <20201217153434.10945-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

"," is allowed in cpu list strings, such as "0-3,5".  We need
to handle these cases.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
index 5cdef96326a7..ac37bd54ea1c 100755
--- a/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
+++ b/tools/testing/selftests/cpu-hotplug/cpu-on-off-test.sh
@@ -30,7 +30,7 @@ prerequisite()
 
 	echo "CPU online/offline summary:"
 	online_cpus=`cat $SYSFS/devices/system/cpu/online`
-	online_max=${online_cpus##*-}
+	online_max=${online_cpus##*[-|,]}
 
 	if [[ "$online_cpus" = "$online_max" ]]; then
 		echo "$msg: since there is only one cpu: $online_cpus"
@@ -38,7 +38,7 @@ prerequisite()
 	fi
 
 	present_cpus=`cat $SYSFS/devices/system/cpu/present`
-	present_max=${present_cpus##*-}
+	present_max=${present_cpus##*[-|,]}
 	echo "present_cpus = $present_cpus present_max = $present_max"
 
 	echo -e "\t Cpus in online state: $online_cpus"
@@ -47,7 +47,7 @@ prerequisite()
 	if [[ "a$offline_cpus" = "a" ]]; then
 		offline_cpus=0
 	else
-		offline_max=${offline_cpus##*-}
+		offline_max=${offline_cpus##*[-|,]}
 	fi
 	echo -e "\t Cpus in offline state: $offline_cpus"
 }
-- 
2.19.1.6.gb485710b

