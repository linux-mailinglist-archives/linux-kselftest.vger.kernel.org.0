Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C3D1A8EE8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440989AbgDNXJ6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 19:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437942AbgDNXJ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 19:09:56 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343DC061A0E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 16:09:56 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i19so8893935qtp.13
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GmpDGYHNWO1HVRGOCC1HUE41KMOfYWwP4MYA86x9Hs=;
        b=d/XycrnOIE9zVNs85mQ8kiqfaX2FAKRGtTainrFJ0IzS2KMbTBKck6+HKcl12KMfi/
         mLyCl0M1OBOJwXwZ3mkeZWf734twgkheW3CbMFKK9vgo54UnwfYGSfuqlmm2nneOODqY
         lFI2ztDOic5VkmRttn366D+g3jqOHNKyx6SEMuHpgfwN4dMbeYlKBWMp7+Sx0VtOHgkw
         QAB6RJyglN5wdqlfuhGUcdCQiEH3Z01NDBhyXZH9qCDuhlHStFTK31cHPnoZ3HSzOw1n
         zELCk4JBQJoOxdIR6Znl2rOgnjsEmPOnLC0nGGBLDO2jdXjzhoB0uXDpMRgRXyQfNDmR
         X8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GmpDGYHNWO1HVRGOCC1HUE41KMOfYWwP4MYA86x9Hs=;
        b=BaMX2Nt2kZqwCkB790BwxaU8Go98iwz46LkB2YH3DLFgJr0Ktf/8VvtqvsfV/2l7FY
         oZWihl56LASxljSndLHjRf1QhYSqekthmG28VcqFhS14bq7qVM8t7H2QSy5dw8LUgcLr
         7FNdXshiakdcvrmhoKIaC4DLMXceO4Chr+ulqcT+jwSzLp41RXIK1WFTztQLTjrkSx/n
         zw6yXNcrE5Dncr+gumxdfeISjkDfbtUHLXOkD6hEO1LkqBn+kkUnkgg6aRjhHemcvnyf
         xMEvVE0Op/0iirDaYLIW/M8tiKRWOg0yLq7IrGqHvEQxZJYsUliPt02IZ/rJ5OevM3sl
         00vQ==
X-Gm-Message-State: AGi0PuaBWKeLwW7WszYLnFzk210O4svxphIrdds80KL9v/v6hzvHAnpN
        h8+OOKGwcG7bhAxn54YG8EsMWg==
X-Google-Smtp-Source: APiQypIq7HA/Rl7AQcDjE3FdKvf8IBKg1xI6rru45NLF9fLflB46Gk0TTOpZ6L0hLOq23HmizGMYBQ==
X-Received: by 2002:ac8:16e4:: with SMTP id y33mr19301422qtk.4.1586905795146;
        Tue, 14 Apr 2020 16:09:55 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id f1sm11455084qkl.72.2020.04.14.16.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:09:54 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RESEND] kunit: use --build_dir=.kunit as default
Date:   Tue, 14 Apr 2020 20:09:50 -0300
Message-Id: <20200414230950.83665-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To make KUnit easier to use, and to avoid overwriting object and
.config files, the default KUnit build directory is set to .kunit

 * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 tools/testing/kunit/kunit.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..5da190c79481 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -116,7 +116,7 @@ def main(argv, linux=None):
 	run_parser.add_argument('--build_dir',
 				help='As in the make command, it specifies the build '
 				'directory.',
-				type=str, default='', metavar='build_dir')
+				type=str, default='.kunit', metavar='build_dir')
 
 	run_parser.add_argument('--defconfig',
 				help='Uses a default .kunitconfig.',
@@ -136,12 +136,11 @@ def main(argv, linux=None):
 		if get_kernel_root_path():
 			os.chdir(get_kernel_root_path())
 
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
+		if not os.path.exists(cli_args.build_dir):
+			os.mkdir(cli_args.build_dir)
+		kunit_kernel.kunitconfig_path = os.path.join(
+			cli_args.build_dir,
+			kunit_kernel.kunitconfig_path)
 
 		if cli_args.defconfig:
 			create_default_kunitconfig()
-- 
2.25.1

