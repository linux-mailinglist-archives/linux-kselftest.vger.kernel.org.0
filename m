Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B207741C2B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245522AbhI2KbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 06:31:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:46826
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245475AbhI2KbV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 06:31:21 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9C680405FB
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632911377;
        bh=DbOD0C5oNNiLE6C6+Qay26kE8pgt12Q4nTJI+OMiTsU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=R+nFcLZjz/qJ3jmpK4CyYtakx6/bbBmTK+HPlbkuqajeam1tPZTCrO6rfm4LPHJkE
         AcwV+6xrvYhbeWsglX8AOsSEmAO/vGBweit4+dCOkVAOFFrsSVfFxUwNfkFN94d7sS
         0kGpawsikg57J+3Tsd1sfP5cYAr+26FSA0eZEhVKgMc5pbWQBOlKQBfeAGcaUs9suv
         YUnDJxNRF2KgtSJHYhFnonISKDpJdGYrxfXadxFhN5PmUqmR8YtVOy5ITzSyYyf6P7
         prqYd8TazmaIbyytbyJSsXcZGs0TNmrgFdGBj3KFO0ArJ4bHfm+YA8kp7r3Z9x8zNT
         cDpNVcX1+U22g==
Received: by mail-pj1-f71.google.com with SMTP id v19-20020a17090a459300b0019c6f43c66fso1335065pjg.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 03:29:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DbOD0C5oNNiLE6C6+Qay26kE8pgt12Q4nTJI+OMiTsU=;
        b=xL367GwA+trDx24x4CCvu+5PkOSduU73xfnIpmKEfPrkLukpDz4z1lXrgdAKLj80jb
         OMxeBl5gNFb5Se/i3w6jzBKcMcXuWTAutYclSQ/IUG3o99EuzOp/WHcT1nsOo2Ba1KUc
         fomCQUA0xKZJEkYb+qHqC67m2K+cchhzoovNTzIwfLU0NI4XVjjFcksAD3ULscZmw7An
         znj2BgI+ObcHmMzQZAU/gAPNc6j1hBVdL/8KqBllxKA9jcagrXP+S5wUPde5/eJME57B
         3dzP39V3pcvusA7EUNM6ko8nE+LCkM2OJfTe1MiJF+ntkOcafOLFkOXyqxWuDhvOuK8f
         60HQ==
X-Gm-Message-State: AOAM531sF1U6W1cpwAcWH+Yo/VNy5Jo0CykTlN+c+KaE8Yt+xAKQJ2G0
        FCZgr/vRde7hypU/4MjKvf7783emILwXQWSgk6NCiVe9kODex7e1Xopqol8RtgiEVVY+46XS88P
        CWyONb4haCNXzXZQJ0mWooYhwdwLMsZfEpCiuSYIxce/Z
X-Received: by 2002:aa7:82ce:0:b0:44b:436b:b171 with SMTP id f14-20020aa782ce000000b0044b436bb171mr2613252pfn.21.1632911375996;
        Wed, 29 Sep 2021 03:29:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZzh2Mp9pgSih3XerMnOf17A+2UyCKpRU8SP4bN7YL0nUc2n2nsgAA9DQXoamAR348zg9/Dw==
X-Received: by 2002:aa7:82ce:0:b0:44b:436b:b171 with SMTP id f14-20020aa782ce000000b0044b436bb171mr2613241pfn.21.1632911375713;
        Wed, 29 Sep 2021 03:29:35 -0700 (PDT)
Received: from localhost.localdomain (223-136-83-121.emome-ip.hinet.net. [223.136.83.121])
        by smtp.gmail.com with ESMTPSA id f27sm2254786pfq.78.2021.09.29.03.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 03:29:34 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     po-hsu.lin@canonical.com, skhan@linuxfoundation.org,
        shalomt@mellanox.com
Subject: [PATCH] selftests/ptp: Use kselftest skip code for skipped tests
Date:   Wed, 29 Sep 2021 18:28:48 +0800
Message-Id: <20210929102848.27158-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The phc.sh script in the ptp directory is still using exit 0 when
the test has been skipped due to some unmet requirements.
Use kselftest framework skip code instead so it can help us to
distinguish the return status.

Criterion to filter out what should be fixed in ptp directory:
  grep -r "exit 0" -B1 | grep -i skip

This change might cause some false-positives if people are running
these test scripts directly and only checking their return codes,
which will change from 0 to 4. However I think the impact should be
small as most of our scripts here are already using this skip code.
And there will be no such issue if running them with the kselftest
framework.

Note that there are some SKIP messages exit with 1, I leave those
unchanged.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/ptp/phc.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ptp/phc.sh b/tools/testing/selftests/ptp/phc.sh
index ac6e5a6..0820544 100755
--- a/tools/testing/selftests/ptp/phc.sh
+++ b/tools/testing/selftests/ptp/phc.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+readonly KSFT_SKIP=4
+
 ALL_TESTS="
 	settime
 	adjtime
@@ -13,12 +16,12 @@ DEV=$1
 
 if [[ "$(id -u)" -ne 0 ]]; then
 	echo "SKIP: need root privileges"
-	exit 0
+	exit $KSFT_SKIP
 fi
 
 if [[ "$DEV" == "" ]]; then
 	echo "SKIP: PTP device not provided"
-	exit 0
+	exit $KSFT_SKIP
 fi
 
 require_command()
-- 
2.7.4

