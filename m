Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043D04A5167
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jan 2022 22:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380782AbiAaVXt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jan 2022 16:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358273AbiAaVXs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jan 2022 16:23:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4F9C06173B
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 13:23:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id c7-20020a25a2c7000000b00613e4dbaf97so28954676ybn.13
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jan 2022 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lu4osKhXkSihh+FVMzwd8VjhGxBSjKCVVpGwUKJw11E=;
        b=PPCUjkZOoyQxbNisqtoZ4J8+SO79v+KPink+rfEim5TUsEqAIojuQP42l8DsLylxrH
         ST6kDlWcTTgmx0OQ0NWKpZE/ss/tCPjCLL8Di3FuDV/jW1rTxOpyW8EaFlV3D1PUtsvC
         wTtjSTdNaF7a5/Pe6GAdwnD7qTPnN+ajm5ycu5pNYVgcPy6r8NC0RRm7Fe0UbM8tTWQ4
         VNrebPfY32Y46+d0TUIo+GoE21b+AF2c2ZeePUyHJpjP5c23TFh7Vtgr70RlSSjjDpBM
         L+1ROJnKWIRW7XJnfRt06jsA5eVyl8uXYpVTbDrhhKeDIoSHqJkm93UnohQlv8fDBRs3
         P+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lu4osKhXkSihh+FVMzwd8VjhGxBSjKCVVpGwUKJw11E=;
        b=DkbnztMmmlk3pMmj3WCR+Gyc8xX/SBf3BMLgDgMfZFSClSSJp5uJc8zgX4jXvqyOoJ
         KZwBJzsTY2bZSe/KmjwWQh91ZcYVcJg60ZusPxm0TIwDqT8iy2001osTsyuTBdD71RsR
         IUoN1UUE6af977HogZf3/KnuxkRbtnXTzj6uP5OfPWTlAkyZyXi2EhxON2CgmlR6xWtS
         wFTa6GIEJXlUkFVHyQKWF50CU8ZH0pJNUmGoGmracOZSR34HKa5EPTYL4PGMF8lTiC/R
         4yQv2UySKGHg1Pa4Sj8Cm7Xq0PnmKQHZrQlGgjw/84owRnFMZfqnEJJpjbbsibpLsc8K
         WI4Q==
X-Gm-Message-State: AOAM533OFwtbuGePzThzAGYRqjcG+KAXCHGsjPiktCkOG+UmfuttJl1X
        uyQajTfdxH/4A8148THQg/P64S+fy/Hn3A==
X-Google-Smtp-Source: ABdhPJxGiNUoXfyY89heKXtgjLZqfkcm9DS0WbJveQuDvU1bzastUO2LgK1W8fEm8DPj1Y5/kjisJ8EZQ4JOPw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:3713:8874:909d:a98b])
 (user=dlatypov job=sendgmr) by 2002:a0d:ca03:: with SMTP id
 m3mr1560ywd.450.1643664226882; Mon, 31 Jan 2022 13:23:46 -0800 (PST)
Date:   Mon, 31 Jan 2022 13:23:41 -0800
Message-Id: <20220131212341.1082577-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2] Documentation: kunit: fix path to .kunitconfig in start.rst
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Yifan Yuan <alpc_metic@live.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
the default --build_dir, which had the side effect of making
`.kunitconfig` move to `.kunit/.kunitconfig`.

However, the first few lines of kunit/start.rst never got updated, oops.

Fix this by telling people to run kunit.py first, which will
automatically generate the .kunit directory and .kunitconfig file, and
then edit the file manually as desired.

Reported-by: Yifan Yuan <alpc_metic@live.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
v1 -> v2: rebase onto 5.17 (had the kunit docs rewrite)
---
 Documentation/dev-tools/kunit/start.rst | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index ad168d16968f..867a4bba6bf6 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -41,13 +41,18 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
 	CONFIG_MSDOS_FS=y
 	CONFIG_FAT_KUNIT_TEST=y
 
-1. A good starting point for the ``.kunitconfig``, is the KUnit default
-   config. Run the command:
+1. A good starting point for the ``.kunitconfig`` is the KUnit default config.
+   You can generate it by running:
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp tools/testing/kunit/configs/default.config .kunitconfig
+	tools/testing/kunit/kunit.py config
+	cat .kunit/.kunitconfig
+
+.. note ::
+   ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
+   ``.kunit`` by default.
 
 .. note ::
    You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as

base-commit: c2741453478badf571ef020d160053e8d5e1ba94
-- 
2.35.0.rc2.247.g8bbb082509-goog

