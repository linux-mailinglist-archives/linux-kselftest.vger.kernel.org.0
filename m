Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2232E3F255D
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 05:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbhHTDd0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 23:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237934AbhHTDdZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 23:33:25 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B4C061575;
        Thu, 19 Aug 2021 20:32:48 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jz1so4813639qvb.13;
        Thu, 19 Aug 2021 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lq4jd0zSrCBX3/pc5k6eEa/a+ZsZVD4zdAOfgEwrSTg=;
        b=KQJsIe4TnavjJI0C+2iipdDM4H5sTpnrVPQ2/FfsoJ+CKuO3iUoCE2d3Jjqlatg4uv
         4R8BYmhOfgMWMaOWm07YtDe6LFw4rQ3WBG8JUHHczp83cvB21WdTbZynN5rqD4HFdiGF
         xl3n4wiQRrNG8eDpIKjSFfHHl6xCh9UN0OqI6lmv7/Zi7UZ7qL8W3Uivu9VvtiEjBz48
         TNx/92vkGPXIhQv8854Y3SanzixduAVzQZLtFhup7iI7R03l1/2srL3FmnFc1QknfsK2
         x1q5sfFCOFlyj169CR3jRzE1TVNg+TKmx27uAoQlHrRK8/AGUgST4AeQ4epFRN97lX9a
         MdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lq4jd0zSrCBX3/pc5k6eEa/a+ZsZVD4zdAOfgEwrSTg=;
        b=EFiIIaKLQ6IePeHuH12IcigGAcJaI2OBeqSjNRbrGvhN1aaShYgk+Mx2adgc91vrAH
         5bdBUyb2AkkQtFsNIXSbZqnvIMMVY/DXmfN4drHY66c433i6ZkugRqopzwq9o/eNz4WP
         A1gcOre9ZwRQSmxAH/xxfABWeDolI2Qw8ZAQKtJMpuT1MmHSQeKrQPirr8kQnlcTR2tJ
         QT8bNN27Oj5i+TCxTJ4MYhT31/5DRg48ePpLqjgcMpqiMWyi9RUfVswieTOUrroWoToy
         cb/KxkAWQTQHXVlEmvniAWyz8kdG7LK4JwWreQ5cO1QkfhPTTzVGMsZK1tdtbXNlZTpo
         E07Q==
X-Gm-Message-State: AOAM533b0DH6NOhYwbV64K4PBSdBqF3xldqCvo5OF7F5GBceABkCw1r4
        d8ehTYtOa0xK71tMqSJfI53Y/ASvAuk=
X-Google-Smtp-Source: ABdhPJyhqurox63DCqv8cxqLw3k5tiXKrvW1aPCq2pbgjM5nexZuKXrAxtnjLtZRzWokW6SOjFtYtw==
X-Received: by 2002:a05:6214:5288:: with SMTP id kj8mr17759896qvb.62.1629430367975;
        Thu, 19 Aug 2021 20:32:47 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id g20sm2542943qki.73.2021.08.19.20.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 20:32:47 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <jing.yangyang@zte.com.cn>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tools:mount: Remove unnecessary conversion to bool
Date:   Thu, 19 Aug 2021 20:32:41 -0700
Message-Id: <20210820033241.13136-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: jing yangyang <jing.yangyang@zte.com.cn>

Suppress following warning from coccinelle:

./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59: WARNING conversion to bool not needed here
./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59: WARNING conversion to bool not needed here

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 tools/testing/selftests/mount/unprivileged-remount-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index 584dc6b..bc802f6 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
 		if (!WIFEXITED(status)) {
 			die("child did not terminate cleanly\n");
 		}
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	create_and_enter_userns();
@@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
 		if (!WIFEXITED(status)) {
 			die("child did not terminate cleanly\n");
 		}
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	orig_mnt_flags = read_mnt_flags(orig_path);
-- 
1.8.3.1


