Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0A1468E31
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Dec 2021 01:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbhLFALG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Dec 2021 19:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhLFALF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Dec 2021 19:11:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F6C061751;
        Sun,  5 Dec 2021 16:07:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id iq11so6408642pjb.3;
        Sun, 05 Dec 2021 16:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdUoW978c4HLbkODJj8jA+h7g0V10B/h6DJUbLYNjB8=;
        b=dZ+gsyxqOi1PPZeUeFnccaM67mObWiH0pygj+oIObbEQfqy5awdiesvFM00f3gQ54p
         RRjxU03GvMpb70hjKnol1riJ/j3+q1PA6hlyNKoI7medyPa4LBx4dAICCDikG3v/7lRZ
         /xb4fqlxs/SNZhnZJyWpjE5uYOgiK6BK/45StuhglpVglGg5yVNv0qJoE7p6H3mLt/Cb
         yieUVj0yFpOOe9NZ1Q6/OfR8qqgdZjTQjIlPHymDj/Kks1yhYtZRyRr2oA+C3T328vPl
         230wmaHh02KYRLxjCAOjdRtvAaIWAHyXKGfqs7CmQscIQw9MgmcjZ2MQHX0ZDylts48w
         8Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdUoW978c4HLbkODJj8jA+h7g0V10B/h6DJUbLYNjB8=;
        b=8CIqNmCdfHE/xfQR1EsEjyyAQFmovba7tpJZqKeWaWM6D06YpIu7lkqYAjz3yN6tGw
         exuFXGkFfs4uBnxcYyoj9KpiJQvlI19Io6c+xbify7dnkw7H3ckTYKPbvS1LdOY2pNR3
         wzG/GMU1fgPXV7yElSnfZdMhqeDqIqVkBwloT8AzBIwuoicS+3fpsUyYbnCzNpKHuRiJ
         BDVWou8rRcjbbx92gRZ1ftn9rtWZ87GWBRPd1M52zHpPERGDnRt99YsLQ5f0pgrauQwn
         yffH85UMJIRqiKOvHzT29YHOxwlIDN1U5ZrW+jGJ70btL1I5fsh5RYiG8prlMnU8Jy1O
         Eqrw==
X-Gm-Message-State: AOAM532cOGRaEBQWLHRxZoXcsBRQ0pMRe2T26YaiCdlnZWS8C1XJCgkG
        qWHeSLRW7/6MUddQgzp7Gmw=
X-Google-Smtp-Source: ABdhPJwDxnjLfnDj8oqOPTDT+a6VPfh5ljdVRlRWQdR7LuBk4vfaQqOmqp0odBLoMm6ciAxffDjGxg==
X-Received: by 2002:a17:90b:1b04:: with SMTP id nu4mr33284064pjb.72.1638749257453;
        Sun, 05 Dec 2021 16:07:37 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id f7sm10092809pfv.89.2021.12.05.16.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 16:07:37 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     shuah@kernel.org
Cc:     skhan@linuxfoundation.org, davidcomponentone@gmail.com,
        ptikhomirov@virtuozzo.com, christian.brauner@ubuntu.com,
        yang.guang5@zte.com.cn, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] tests: remove unneeded conversion to bool
Date:   Mon,  6 Dec 2021 08:07:23 +0800
Message-Id: <9bca1d9eb8ccacf4a64a8813f9eefe7f7272b3d6.1638581673.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle report
./tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c:225:18-23:
WARNING: conversion to bool not needed here
Relational and logical operators evaluate to bool,
explicit conversion is overly verbose and unneeded.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>

---

Changes in v2:
- Change the return type to bool.
---
 .../move_mount_set_group/move_mount_set_group_test.c   | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index 860198f83a53..50ed5d475dd1 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -191,7 +191,7 @@ static bool is_shared_mount(const char *path)
 #define SET_GROUP_FROM	"/tmp/move_mount_set_group_supported_from"
 #define SET_GROUP_TO	"/tmp/move_mount_set_group_supported_to"
 
-static int move_mount_set_group_supported(void)
+static bool move_mount_set_group_supported(void)
 {
 	int ret;
 
@@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
 		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
 	umount2("/tmp", MNT_DETACH);
 
-	return ret < 0 ? false : true;
+	return ret >= 0;
 }
 
 FIXTURE(move_mount_set_group) {
@@ -232,7 +232,7 @@ FIXTURE(move_mount_set_group) {
 
 FIXTURE_SETUP(move_mount_set_group)
 {
-	int ret;
+	bool ret;
 
 	ASSERT_EQ(prepare_unpriv_mountns(), 0);
 
@@ -254,7 +254,7 @@ FIXTURE_SETUP(move_mount_set_group)
 
 FIXTURE_TEARDOWN(move_mount_set_group)
 {
-	int ret;
+	bool ret;
 
 	ret = move_mount_set_group_supported();
 	ASSERT_GE(ret, 0);
@@ -348,7 +348,7 @@ TEST_F(move_mount_set_group, complex_sharing_copying)
 		.shared = false,
 	};
 	pid_t pid;
-	int ret;
+	bool ret;
 
 	ret = move_mount_set_group_supported();
 	ASSERT_GE(ret, 0);
-- 
2.30.2

