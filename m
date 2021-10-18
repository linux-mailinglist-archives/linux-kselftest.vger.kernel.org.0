Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC8F4315F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 12:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhJRKZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRKZw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 06:25:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55136C06161C;
        Mon, 18 Oct 2021 03:23:41 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d9so7164372pfl.6;
        Mon, 18 Oct 2021 03:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrPiiB2kcibKU6+ejUkAMJME4md3m/gRD+fATWB7t9Y=;
        b=j+04VVOg3tkayqk7ZQfrUmTWf30IaLdo19MnGEZSzf4FcZ23lGwecjYoG1H0oGhYi1
         SksH0Vr80v/UQSOpP/8AXGmYduiWLqooF0zpcy5SqX4MaS6f1x3+KJpqjOvAwo67Sreb
         Kf7CCGX2ZvDir4P4Jq0NjsfoKoB1jV18iOwiSp+FFVo3wfF3DW39xiapSFmqVhMYlglR
         yI8UTxTzcU2t34PvgMU/qACAxrRnEF/4Yt/cZluqPJCaex3PCjiEwx2V1gCbWdLcEN8f
         NaWvTbTN+xpQEJ55AQbVZXJm5+wdkn5GsEIe/dBneDBGxXYUp4PesCKXdgS84rrw5NVj
         ZrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yrPiiB2kcibKU6+ejUkAMJME4md3m/gRD+fATWB7t9Y=;
        b=apQ7VI9XMJx93JfmP8KtltM4u/3zoGiEnStHA/tqx+8e5ue/XDi1xU7H52nF7qm3b5
         kbjusaC8gCx7Ke7JX9DaA3WBgfoe+dp+aFSjzERVg3JNvvltz7A2acWp1t7udPLbp/62
         qcrMLBAhav7JxD0j2bamvMu9OgdjBU4boaiHSTKlsiPYAoQLi68DcyXt4FChDNQ91ceC
         zhL2nd2Ipe4XX1gjoG6ZMTlfOPJcFNVf+34h2OCpDC2Rdmm9VQvkqM51mnaKUwIZr7Ml
         4cbeDB6Q2yPE4aT4AlGz1+xYoOXE92wHMZMrwesXldrbOGsuAgiGzY5SPPv+LeTrD4dZ
         BH5w==
X-Gm-Message-State: AOAM533jpt8cxByqX8OH2dSjYgdgfzgJnP/uk3Kk7oSOvbJfrOEAmkAz
        Rl7gaUoEG6rFa7nuTuGwZl7kKZ0CvY0=
X-Google-Smtp-Source: ABdhPJwhrbOzACNVsI3Ph9AAGKgy5A2nd8078KXicTfFwlrkMFPL1A1GfZs5dhoYvEsXxXAin+eOXw==
X-Received: by 2002:a63:d806:: with SMTP id b6mr23089341pgh.395.1634552620920;
        Mon, 18 Oct 2021 03:23:40 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d2sm18603610pjg.35.2021.10.18.03.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:23:40 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     shuah@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mm: remove duplicate include in hugepage-mremap.c
Date:   Mon, 18 Oct 2021 10:23:36 +0000
Message-Id: <20211018102336.869726-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

Remove duplicate includes 'unistd.h' included in
 '/tools/testing/selftests/vm/hugepage-mremap.c'  is duplicated.It is also
 included on 23 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index e84b79922fe6..0d8817ba6789 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -20,7 +20,6 @@
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
 #include <sys/syscall.h> /* Definition of SYS_* constants */
-#include <unistd.h>
 #include <linux/userfaultfd.h>
 #include <sys/ioctl.h>
 
-- 
2.25.1

