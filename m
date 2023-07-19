Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656D275904A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjGSIbN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 04:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjGSIbM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 04:31:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF1C172A
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 01:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689755424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zD3UEKBWOcid7vW1ZcdBVv5pq+DD5Ikq9fhBF2xLfgw=;
        b=cP7IpKjMkqcAStVlt1abeOrsbMML7AypAHDZvws4Rc08XmTcafh+3JmNHbEQAGvP9KlxMf
        YvNNA9AZN4T1Az7pYA2lGhPfyMxLthvxRZMc0lvNffQFG7e9DjWaKmlH9j/1c0MyemLE4X
        MZOSLz0SVd1rbY9H6xn4OXguVGdfomM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-MBgIf96iNoOs9k95X8862Q-1; Wed, 19 Jul 2023 04:30:23 -0400
X-MC-Unique: MBgIf96iNoOs9k95X8862Q-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7681da13a3fso418905685a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 01:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689755423; x=1690360223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zD3UEKBWOcid7vW1ZcdBVv5pq+DD5Ikq9fhBF2xLfgw=;
        b=RcEegK43YWosY5zXxCjq14Q2cH7dm4oKSMQ0OCfHPlHAuacdqot5M3DQw+ygdxyvvs
         5cNpfL+Mgo4yHuyMlXzJ8bCZ1I/1WEBAFgOgtbfatDh4Nw2Tj7e1Lerx0EYtK5CU2kuU
         jbrmmRoU1NLaHrV+jKrNgG5Od3MeWtWtHcLninBz4pQVsWozGjmcLJhRDTcswKEhkVug
         uH0Jv5PGXTmtknxA7SpygVLwG/eG927d3hgIm0Yti2BNXJuWNnwXvflw2BPSlhiwfW78
         eEdIzGctb5Cus2JO5nf1NZgmIt1KXZ1/MauUJSYv/xM3BY3gX6FBbJCM3XWBh5YpkF6R
         Hw6A==
X-Gm-Message-State: ABy/qLYZ36iyL4oM5GPT7yGPHdlrhTOLP3RZUvEr8t2qdagkL6IAn+oA
        tVoomRGiaRZuZP1s1XHgWFvVsnVVc/6BIQlyTCMBcjK/59Dms9JfbI1GymXgrAM1aQa/w11SHvf
        9d9klXiMDOLX1HWlMmNkkcEBMBqG7
X-Received: by 2002:a05:620a:2b84:b0:767:3efd:59f5 with SMTP id dz4-20020a05620a2b8400b007673efd59f5mr2324589qkb.17.1689755422947;
        Wed, 19 Jul 2023 01:30:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFMCuOmES+gmpHbJ8RQH1GhgKReqWzo74ERtS6ZoY4W1EuXrABnuZoQibujcjfYF9KZ3hQ1XA==
X-Received: by 2002:a05:620a:2b84:b0:767:3efd:59f5 with SMTP id dz4-20020a05620a2b8400b007673efd59f5mr2324560qkb.17.1689755422654;
        Wed, 19 Jul 2023 01:30:22 -0700 (PDT)
Received: from fedora.redhat.com ([2a06:c701:4b84:700:e5a3:9a79:b307:264a])
        by smtp.gmail.com with ESMTPSA id t11-20020a0cb38b000000b00632191a70aesm1305450qve.88.2023.07.19.01.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:30:21 -0700 (PDT)
From:   Dana Elfassy <delfassy@redhat.com>
To:     shuah@kernel.org, usama.anjum@collabora.com, eballetbo@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dana Elfassy <dangel101@gmail.com>,
        Dana Elfassy <delfassy@redhat.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3] selftests/input: add tests for the EVIOCSCLOCKID ioctl
Date:   Wed, 19 Jul 2023 11:30:03 +0300
Message-ID: <20230719083003.1562415-1-delfassy@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Dana Elfassy <dangel101@gmail.com>

This patch introduces tests for the EVIOCSCLOCKID ioctl, for full
coverage of the different clkids

Signed-off-by: Dana Elfassy <delfassy@redhat.com>
Reviewed-by: Enric Balletbo Serra <eballetbo@gmail.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes in v3:
- Modified signed-off-by email
- Added Reviewed-by tag

Changes in v2:
- Replaced clkids numerical values with their equivalent definition

This patch depends on '[v3] selftests/input: Introduce basic tests for evdev ioctls' [1] sent to the ML.
[1] https://patchwork.kernel.org/project/linux-input/patch/20230607153214.15933-1-eballetbo@kernel.org/

 tools/testing/selftests/input/evioc-test.c | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/input/evioc-test.c b/tools/testing/selftests/input/evioc-test.c
index ad7b93fe39cf..83ce1a3c9b84 100644
--- a/tools/testing/selftests/input/evioc-test.c
+++ b/tools/testing/selftests/input/evioc-test.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <time.h>
 #include <unistd.h>
+#include <linux/time.h>
 
 #include "../kselftest_harness.h"
 
@@ -234,4 +235,33 @@ TEST(eviocsrep_set_repeat_settings)
 	selftest_uinput_destroy(uidev);
 }
 
+TEST(eviocsclockid_set_clockid)
+{
+	struct selftest_uinput *uidev;
+	int clkid = CLOCK_REALTIME;
+	int rc;
+
+	rc = selftest_uinput_create_device(&uidev, -1);
+	ASSERT_EQ(0, rc);
+	ASSERT_NE(NULL, uidev);
+
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	clkid = CLOCK_MONOTONIC;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	clkid = CLOCK_BOOTTIME;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(0, rc);
+
+	// case default
+	clkid = -1;
+	rc = ioctl(uidev->evdev_fd, EVIOCSCLOCKID, &clkid);
+	ASSERT_EQ(-1, rc);
+
+	selftest_uinput_destroy(uidev);
+}
+
 TEST_HARNESS_MAIN
-- 
2.41.0

