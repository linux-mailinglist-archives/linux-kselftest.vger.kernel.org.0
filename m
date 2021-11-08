Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94244784D
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Nov 2021 02:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhKHBcd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Nov 2021 20:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbhKHBcd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Nov 2021 20:32:33 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C110C061570;
        Sun,  7 Nov 2021 17:29:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n8so14739449plf.4;
        Sun, 07 Nov 2021 17:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4vQkz8/qTxyaVcJnsKCjYn20bkfBzjk11/LAmMKs8G8=;
        b=cVnOCLuY/4b5KleH6K15LMLmcjDuPBXCm2Je0e7arrPgllRLmyI8WPbC0tz27LU7qZ
         WMIQEQEVpQFBucjcaNX83XUQkDJkk3PZ6Yv24CX1I4L+T92ik0oH11zTJ+PXg9lvGE6m
         H/X/xZT/6vmCaQbYbzr+yNRuENNC94Z1f9TmXIU3YTh2xKwJi7+xHgGB6Ymtz1xo5bST
         mCGPfBZ2lhwV6sI1tKZKtUAF0JwJYlnhN1d/0Z/aRLa8Nrdxt5KnOy8HOmmn6Xeufm25
         2mnSMvexRyRK6fh+rvXVZrABq73NciZf/GkE39LrQZXlnvzhT5n/+Wh78PxAAO+bdteA
         vo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4vQkz8/qTxyaVcJnsKCjYn20bkfBzjk11/LAmMKs8G8=;
        b=iysn6Ok9yUr3cKoplJ6Dbm1Gmj3nVxRit+aVk8QBsmnXXYlH0tLShndtfmj/Ojb1UB
         A+nflWfwBK3XFbpfADCEglJufOM3qewdKtvoObdQ7XWO7PKgwgs3MzGQsv0NoNenBdTo
         wjOuWJWf/A3pfZ6sTWTh2bG+Y4uULyNhhQet806AR9sgB9Y9qjF+T0Bt8ybMYHVM4Mhd
         U5eh3EpCGydlUOvW93oKEqNoJsNkXyqsoza7+KwIYVPJ+1IkWfEDt78WPtNJRMFSbjep
         p19Dnv0zd27UtECW42GuWVYuIGz0EqjqtE/cGP4V4uv+FKsyF20cOaDR2B1BKfIUr6wa
         c5KQ==
X-Gm-Message-State: AOAM533zawj+c/vgITscU0n8tYNRxmjp4UjhzCGYIMtl6WZZddXVdE+T
        NoymuQdkuABypNipRftzfdO/0NnRj3Yukw==
X-Google-Smtp-Source: ABdhPJxxL7QOhLDR+/mBpUfVFdvYw0dHURcw0MPeWokwJlcuw3v16O0QJE3TTdDWyXxlaYnOihsfzQ==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr48208378pjb.10.1636334988748;
        Sun, 07 Nov 2021 17:29:48 -0800 (PST)
Received: from sol.lan (14-201-12-235.tpgi.com.au. [14.201.12.235])
        by smtp.gmail.com with ESMTPSA id t4sm13800861pfj.166.2021.11.07.17.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 17:29:48 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, shuah@kernel.org, bamv2005@gmail.com,
        lizhijian@cn.fujitsu.com
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 3/3] selftests: gpio: restore CFLAGS options
Date:   Mon,  8 Nov 2021 09:28:51 +0800
Message-Id: <20211108012851.7772-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108012851.7772-1-warthog618@gmail.com>
References: <20211108012851.7772-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

All the CFLAGS options were incorrectly removed in the recent rework
of the GPIO selftests.  While some of the flags were specific to the old
implementation the remainder are still relevant.  Restore those options.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 tools/testing/selftests/gpio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/gpio/Makefile b/tools/testing/selftests/gpio/Makefile
index 42ea7d2aa844..d7b312b44a62 100644
--- a/tools/testing/selftests/gpio/Makefile
+++ b/tools/testing/selftests/gpio/Makefile
@@ -3,6 +3,6 @@
 TEST_PROGS := gpio-mockup.sh
 TEST_FILES := gpio-mockup-sysfs.sh
 TEST_GEN_PROGS_EXTENDED := gpio-mockup-cdev
-CFLAGS += -I../../../../usr/include
+CFLAGS += -O2 -g -Wall -I../../../../usr/include/
 
 include ../lib.mk
-- 
2.33.1

