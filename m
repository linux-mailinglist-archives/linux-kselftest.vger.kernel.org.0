Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC6113651
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2019 21:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLDUS1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Dec 2019 15:18:27 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36835 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUS0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Dec 2019 15:18:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so772687wru.3;
        Wed, 04 Dec 2019 12:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fspx7bIXXs0k8mMRF6gpjQkO0Aw1T/BQQAXOr83Gdx0=;
        b=OGD1AAIBRfKI9ILX7LQAD71WGGAgneQ4JeMfgK48KH192tYgTJ6giBomAZ5D9eRCzQ
         WgAcXUXe5q6LG9biKFxP1+8COGNIESLmTeQ/gdJIC4IldoJh33Yc8MOpi9gmlfEMUIf9
         JDxfHGBRg1myB11meMKI6pf+tRq/zLV/lHMhJDAW0O3DSprUy1doMLO2nzMoBOwDqdjG
         Mq/1qUsm7ppjBo+v5Gje/Zdu2RekbduiFSpTnreKdlUVe7Wg3GywwFTHzGBmn+XAsbUF
         qeKGccMOKkS0ItHdX0aO08IwnTRTefHkUwUAVMtWrAxp81zBHSWchP8+tbOTLGtMRX0p
         UhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fspx7bIXXs0k8mMRF6gpjQkO0Aw1T/BQQAXOr83Gdx0=;
        b=R6wx3ShOYYuraf9hPZyuloHEjmf9TxEH7tdN3POtfvF8cjGcv/ytV73TZWo6Vf/Idj
         Lxin3IwUAWou3Dd5DbRozDuultseu2KqB9KnDUD/Qo/gBZxOoDnv7MsfI93bNlcEgy2v
         FZK4J5BYb4LSuR1GaIorwE772Lo1sw1M1SOUmUmPHT3pYHFR87fLJWgvurrgwqmu4XzC
         Wpoys5lyctmOBWr2M0xPFIWEylvLZWNrvJECI5d+9AjTE9JF+Oqzlso5RkbLYlFpGwos
         Ey/fkDEidSgtrQyhaEUdilKDAPt8OThgx6Lih6iWPiXwRn3KEJKpHJCB/mjYwyEMLxRg
         4KlQ==
X-Gm-Message-State: APjAAAVz/RSJkNyg1Dp0BE0X+bt7mU4sjPbMihRHISWTnQ1c2wdDIImo
        QowDAyB0j+r/ANw6OeIewGU=
X-Google-Smtp-Source: APXvYqyToxoxVG/opBTg0RhduRGz4G4x9Ng/njheVevgxikuSza/iToW5KyEKX4Ykr7mTdh5klMn1A==
X-Received: by 2002:a5d:6349:: with SMTP id b9mr6364040wrw.346.1575490705024;
        Wed, 04 Dec 2019 12:18:25 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id f2sm7329254wmh.46.2019.12.04.12.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 12:18:24 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     corbet@lwn.net, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        sj38.park@gmail.com, sjpark@amazon.de
Subject: [PATCH v4 2/5] kunit: Remove duplicated defconfig creation
Date:   Thu,  5 Dec 2019 05:18:00 +0900
Message-Id: <1575490683-13015-3-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
References: <1575490683-13015-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

'--defconfig' option is handled by the 'main() of the 'kunit.py' but
again handled in following 'run_tests()'.  This commit removes this
duplicated handling of the option in the 'run_tests()'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index efe06d6..f8f2695 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -37,9 +37,6 @@ def create_default_kunitconfig():
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
-	if request.defconfig:
-		create_default_kunitconfig()
-
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir)
 	config_end = time.time()
-- 
2.7.4

