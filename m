Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F13B45D285
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Nov 2021 02:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347654AbhKYBuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 20:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352722AbhKYBsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 20:48:17 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CF0C07E5C5;
        Wed, 24 Nov 2021 16:56:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso6436295pji.0;
        Wed, 24 Nov 2021 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFUCCRJ0w8ukkUkfynRWwva0cJAae/vXn5KqKDDKdmg=;
        b=p4YUWG41UrMIC3xiiGXWEuk38EfzcDtxJ3iSWPkSegr+EnM2+P/fcPWcXo3i2KB013
         mHiAcjapaLa/YgyVX0WeHbsmYY6cdq0mQzeA8X3Vwds9waP1zWHDwXRUBwkx7DVOWlOT
         B3keWLxnoG/SjiAycEWfQPOUVUfUT76Y5VkXkQxZmC6XB/YHxZ1YU+vozZ8j4HpkYfj8
         e00hemkF11Z/sH1XLQgRTzQj0lF/bBapNfIt1WCMoL3p/s7FBd2pFILAtdFlZK+g3p/d
         ekvl/hvdsEWxLJTmlcM8rwa5NS3ANzHy3EUKDxz6oQJWUZ5TsgsmVUnfBG4QU0c9BLNl
         JocA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vFUCCRJ0w8ukkUkfynRWwva0cJAae/vXn5KqKDDKdmg=;
        b=pfaDP5tHuaBEOaFOOlJ1lt7wLvICaQxO8T5hwzJ2ZXLWVDt/XgsEZnIUxqhClku9rH
         YUF4yVdwzsc+N5AMDzdNgnUwV6nW+wTunT5k1GIBJbDQgsy7YW2ugmPN7+osAv6cbw7L
         Z3GGLNOJnS/Oh0lBMpLa+emVXSDsCPATt6Gvc7/LZy5m5mVp6fwYPB+gBUBEsGWxJZ9m
         Q/L2hsg4woys6bM612wQVbTP3xyB3fHKZk+sXOroNKXibjywYJ8ZaBHu4I7HCHljjDvH
         jZAi1CHichqon15Mcp1yYb+qwCPyhSjoQFtfLm1WMFzE7ZEr2j+f531ydGYeLobUDxqG
         aLFQ==
X-Gm-Message-State: AOAM532+Wu0Lkn8Cp4MrPMVVKqYu5dYtrvVlNZVXJXzR6sUKcFvUl9BL
        Ks2QFxWCztD312M8Nr0CiFg=
X-Google-Smtp-Source: ABdhPJwCguLh0vQ2YDu7PSBaovB9V4aX72xX4Jse6LOmvjHbON3F9fSm2TAcZBbpk1vBQevG6CM6Tg==
X-Received: by 2002:a17:902:c204:b0:142:2441:aa26 with SMTP id 4-20020a170902c20400b001422441aa26mr24770715pll.84.1637801776457;
        Wed, 24 Nov 2021 16:56:16 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id o23sm868770pfp.209.2021.11.24.16.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 16:56:16 -0800 (PST)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     shuah@kernel.org
Cc:     davidcomponentone@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] mnt: remove unneeded conversion to bool
Date:   Thu, 25 Nov 2021 08:56:03 +0800
Message-Id: <3a7435c9e7e7aa8f24d22fd576ce912eb0540272.1637737086.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle report
./tools/testing/selftests/mount/unprivileged-remount-test.c:285:54-59:
WARNING: conversion to bool not needed here
./tools/testing/selftests/mount/unprivileged-remount-test.c:207:54-59:
WARNING: conversion to bool not needed here
Relational and logical operators evaluate to bool,
explicit conversion is overly verbose and unneeded.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index 584dc6bc3b06..d2917054fe3a 100644
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
2.30.2

