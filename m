Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF63F567B
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Aug 2021 05:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHXDIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 23:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbhHXDFo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 23:05:44 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6FC0613A3;
        Mon, 23 Aug 2021 20:03:48 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f22so11931054qkm.5;
        Mon, 23 Aug 2021 20:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DcXimKD9ktUTQ9h2I2cOvz7m+Ks/LKV85VIoEJzO/cY=;
        b=csPq3rt1tkj8/W1nEfwuuf9UZOKvUzQhVhlta8+9aic6joNZRE4lKsu8ufe20IKmEa
         4eESj3RxZAfjND8RNI+uSpldpy4/qow91j+6r1rgPZyjc7sTcJqdHv3CJGKMssq3yPrp
         zwUpeeKz4dPtZMU7RvK3/5jFjwTnw/s4hUiECEx/F2NRSa9O7eN2kdN8Pb2ocpCv+k2f
         jK6PKwJuFefezal882+JqNzWL9LrpyMoTku8b5jqze+6Q48gWlnpQc6PdjYfkLemVrDx
         5Hz3dcO+LdHt7nfUKFb1uJUSPsdTCzBud9TImS8oZWWSTv0ogz2E9u7yvGYhm554n8h9
         QyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DcXimKD9ktUTQ9h2I2cOvz7m+Ks/LKV85VIoEJzO/cY=;
        b=FiENhkOW1FFThrinLNkH9i5/h+cPWQQHBpRSKn8Av7McgfMZUFZpo5lSBFVMFD5d/z
         q6uPiCqpgJ1Lj6ARSRAytEY5DdnzX1XHNgvjwFol41WXCZ4WfkkQHUE21u+5afnwjMdn
         jrS16HkZK8JBBKhsuke/xz/rdXoMRq9yG0UQcyOqW9I/EvyjFJVLLlqh8DfiVKYY6n24
         eJpAn7qkzh4ZSDlVOhJ6Fn54Y5J0xKU6mEXjWq8sRJAfypOTvCzwPIp+ecMstzVdCnbJ
         5t4QoaKQSVd2eA5kG6ke9A22XXQeqXBd6CKpnKOSBFEvnKHEmZ3l97j+z387KH3DXfxR
         Nmlg==
X-Gm-Message-State: AOAM532KFDggFGro235XnclDa0+weKKRz+dG2Y+clALvwpqiNIN7sca1
        Y+gqdHwEWt3vjCvN3yg6uGU=
X-Google-Smtp-Source: ABdhPJzBSu2ILEuN5IUNETzEf6ebHzCaTXcz5UgSaQEIKJPmMq9w9KaPOTYEJby+ubs+Bd+PGr+4VQ==
X-Received: by 2002:a37:54f:: with SMTP id 76mr24597132qkf.226.1629774227994;
        Mon, 23 Aug 2021 20:03:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p22sm9667227qkj.16.2021.08.23.20.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 20:03:47 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Chris Hyser <chris.hyser@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] kselftest: remove duplicate include
Date:   Mon, 23 Aug 2021 20:03:38 -0700
Message-Id: <20210824030338.57396-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Clean up the following includecheck warning:

./tools/testing/selftests/sched/cs_prctl_test.c: sys/types.h and sys/wait.h
are included more than once.

No functional change.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/testing/selftests/sched/cs_prctl_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/sched/cs_prctl_test.c b/tools/testing/selftests/sched/cs_prctl_test.c
index 63fe652..7db9cf8 100644
--- a/tools/testing/selftests/sched/cs_prctl_test.c
+++ b/tools/testing/selftests/sched/cs_prctl_test.c
@@ -25,8 +25,6 @@
 #include <sys/types.h>
 #include <sched.h>
 #include <sys/prctl.h>
-#include <sys/types.h>
-#include <sys/wait.h>
 #include <unistd.h>
 #include <time.h>
 #include <stdio.h>
-- 
1.8.3.1


