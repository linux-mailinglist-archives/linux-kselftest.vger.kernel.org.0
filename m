Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4000E3FA3F9
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Aug 2021 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhH1GRX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Aug 2021 02:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhH1GRX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 28 Aug 2021 02:17:23 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C53C0613D9;
        Fri, 27 Aug 2021 23:16:33 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 14so9691669qkc.4;
        Fri, 27 Aug 2021 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VUds+tRV1uK7phslKLzaf41GwwvTN223apPtAuXFmk=;
        b=GXfkGWakY/bOllhKZrjBvfNKTjsv+bUgt3DHHkXijG096RcJbeJlh/LduoaoF/HDGL
         PZ4xfBmBdsRXsSKEN1K1cvFcW9RNerorYTNeIb2ssWKqKRJuThlKhmxbK9cQuVwIHqzO
         FqILQtSFk3TfCMsEE/3zVyReszNh48XmAcAnYYwdOeRit4Np/b+uPBBx6SOYMPQ4gURa
         mg5Gtyi4dMXOXLFUCus8R0Jt1T+D7jpCnXNL7j7HEQL0IHTBR7gnjcfVge81HfHuebYS
         p5coeofytq27BeEb/7xwL26swaYEeVRqFwb4w+h/OZZIJtLfGib6ydn0iIxFKYSvA/wU
         HRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2VUds+tRV1uK7phslKLzaf41GwwvTN223apPtAuXFmk=;
        b=LECIvwcDJ83dyDLrBlsZd0pIz43IT5oHCGff1RYW/TsK/mC3LjMYT7mqP0p0p55JMr
         ZM1lVxZC//YKCx+BD1VTvxBsKCemCFtf6S2XOZaw40PGYmdAosdvZVMcrQSboLSZZ6rX
         1JWGGHkotubRaSH+kw5DHfs4vwpwP9j0SWYNMjoVQ1Wpv36bZ1dTGpZiAb+1Qc6w0iaN
         KeMvzQNwwWakKg/pMLa1b39tAfgam7pIHD2mPIWrU2y7Vipgil3GO9ZvaBEwwCiC7Sgj
         hC4O8ItXkDyRjhQDjpHIJ/MVQXy5NpkfiNUBsnZYWkWArBKJ8XNlvrOWsi1IeciDNTBI
         SiQA==
X-Gm-Message-State: AOAM531Z6sSXKX6dbi12rmKXNPZ6ldp9hUKp8xplaEQN+pdPkS5V5X9i
        qbS7f9WduO4J36zMBLFc36s=
X-Google-Smtp-Source: ABdhPJznaXr+GP3MSznqlRERTrcL8ZxwT9b0CSeeHkGKNykNhTkMnCOGHONB+BOWhJOlhBITecqKNQ==
X-Received: by 2002:a37:453:: with SMTP id 80mr12517952qke.397.1630131392190;
        Fri, 27 Aug 2021 23:16:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e22sm4486377qte.57.2021.08.27.23.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 23:16:31 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] tests: remove unneeded conversions to bool
Date:   Fri, 27 Aug 2021 23:16:19 -0700
Message-Id: <20210828061619.12680-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c:
225:18-23:WARNING: conversion to bool not needed here
Because the definition of function is
"static int move_mount_set_group_supported(void)",
the return type should be int.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 .../testing/selftests/move_mount_set_group/move_mount_set_group_test.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
index 860198f..beade21 100644
--- a/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
+++ b/tools/testing/selftests/move_mount_set_group/move_mount_set_group_test.c
@@ -222,7 +222,7 @@ static int move_mount_set_group_supported(void)
 		      AT_FDCWD, SET_GROUP_TO, MOVE_MOUNT_SET_GROUP);
 	umount2("/tmp", MNT_DETACH);
 
-	return ret < 0 ? false : true;
+	return ret < 0 ? 0 : 1;
 }
 
 FIXTURE(move_mount_set_group) {
-- 
1.8.3.1


