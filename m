Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C6B45D294
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 02:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353263AbhKYBvu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 20:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346395AbhKYBtt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 20:49:49 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2860AC07E5E1;
        Wed, 24 Nov 2021 16:58:21 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id n8so3256789plf.4;
        Wed, 24 Nov 2021 16:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzIxUYIqkQOMo9SX2v8OF7Y8+z3ebsgKCPCZNs6Su4k=;
        b=bgkSczEDoMzlDJJ7SKa7gQVPKboIiNIfeCaj1JFlrssCRQw5rsodZXKh4ZZEdmJaAe
         hU3gzPL1oU3e+U2xXG7xWjzmQg6q7ZhyB1duovGIwU6bP7/D72zsD8UCcEf5qFf/AFCW
         ylHIVAqv5bpG5aLJg+s3Jo5bTC+NpmsmMmBaXvUVdeLwfyDHGva5IjOYCfkeMAAeNNuJ
         uUxXFhBKpDXT/U+HhkvgYq8Paz1AiTZEKjn3wyrdw6n6tvg+qn1LXPk8XIspMnggbFP5
         yCJevEeZKgYmwzTV9jnDZ5f4eYcRiYVfC7zq5eGAqTOiNfyTmaDMENn2dvKMqtt/XkcT
         VkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YzIxUYIqkQOMo9SX2v8OF7Y8+z3ebsgKCPCZNs6Su4k=;
        b=3WHXy3v3WNN2AJQGjrTRH2LekyMyrakvOyZGsBFyo2qHQon6hql/yCFFr8zwJOsmkl
         GnBCgFBD/JXNh1h6eA3XN/fgMz+ly4H1LghJ08zyYj9ClVRx21rtmzGeL8XFyolZzlTF
         TSW4RKC2zE8zRpisp3RhiCphB8lZhP3P3QSClWGjLTc+k2jJi9U2pYXuQ5M2nigF8v+7
         KFBBuIL3mYw0FioZ0wpz4w0kBzV2+O80d4N5TxTyoFRt+4WrXQsVmJ8w1mI0r2zrXjAa
         w2eZK7S5PQhotLsOjhTpqW0n3u1jq+82Lf5abhpnMAYCOmHb+mhN4QQMyBipZGVhcn+p
         aPPg==
X-Gm-Message-State: AOAM533Vzu5c11Bu8jI/hkVlqv6dXwabYVLcSWm99jeFF5M9gHqv5NIL
        ykLe0lQoGCrrW2cxjZssfc4=
X-Google-Smtp-Source: ABdhPJz8xeRoRvyefgULIBOU3wStHCHI/T1ERhp68O412PGD/a18RIkyOaFsJjG2Q/743nuYa9C6cA==
X-Received: by 2002:a17:902:6b47:b0:142:82e1:6cf5 with SMTP id g7-20020a1709026b4700b0014282e16cf5mr24710050plt.28.1637801900772;
        Wed, 24 Nov 2021 16:58:20 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id lx15sm759594pjb.44.2021.11.24.16.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 16:58:20 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     shuah@kernel.org
Cc:     davidcomponentone@gmail.com, christian.brauner@ubuntu.com,
        ptikhomirov@virtuozzo.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tests: remove unneeded conversion to bool
Date:   Thu, 25 Nov 2021 08:58:07 +0800
Message-Id: <f1fe5f6b00e62a6f70c47f1d8b4c41d5d7d03d7d.1637736469.git.yang.guang5@zte.com.cn>
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
 .../selftests/move_mount_set_group/move_mount_set_group_test.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index 860198f83a53..80ff0b692486 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
 		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
 	umount2("/tmp", MNT_DETACH);
 
-	return ret < 0 ? false : true;
+	return ret >= 0;
 }
 
 FIXTURE(move_mount_set_group) {
-- 
2.30.2

