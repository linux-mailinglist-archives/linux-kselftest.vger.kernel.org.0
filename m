Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED401A8EC6
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 00:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633636AbgDNWvE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Apr 2020 18:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729551AbgDNWvA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Apr 2020 18:51:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37EC061A0C
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 15:51:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 20so7233750qkl.10
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Apr 2020 15:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GmpDGYHNWO1HVRGOCC1HUE41KMOfYWwP4MYA86x9Hs=;
        b=sVFynu6uxe/1IYpgyK5vHozGoALV27D0esYW0h/gqLr0R7i12qBcB6m3tuCoCBvSR/
         BarOB3ND2X8zcoVR8cG93fmbKXTwES+Bn+7jDRt+FBXoQbaacVQVx8McUH/AmdkYxbok
         63d5rf8DlAcQa7ADrPPCgPYw/57YH73qGw116x0sBUJRgUGLbVs/ytJr8gpCbqdD5ZvV
         OrGNjkvwP3rRhDPyjAAG6rolsWKXGZRj0Kaw1o1pkr7pArW8k6v1bvq/CXlpai1WXOua
         qU6t2iP7oSQPBPr8zmP6wqJUMsS3B03rNjKLW6BqaAQfxhEff/kntWZTIyXIafVTGvZM
         BGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8GmpDGYHNWO1HVRGOCC1HUE41KMOfYWwP4MYA86x9Hs=;
        b=N7MdR7tbxLDPrsFtnXIXndMZcz91wPwyrZGD9uSjFl+SRUq3YhDXeep7+02TsLecpJ
         /UVzlZx0oRNgyNgV3DkE7lg9sqk7s5+lSRvmdWy16PT7QKWdbOH1dnMEDKFDCm/nfDMw
         ofJKXqqUTiP3fygK4S8m4smLtJrZiZEKdPeFN/JixVMG8ypluas23N9N5iLS7ylGatec
         z1d8Fkji8zTUUdnsNeTi9eu8YYLKIPJhtmRQcTHdR2m39U0aPkgVLvgJKwkj+8sE8nnR
         Qsi0v7mm1Hor+0j9/g6WtBA6uzwMgfLpRwjKUXYMM0lUt1Pm5aeCljFDEngF3uMbgcYN
         KIGQ==
X-Gm-Message-State: AGi0PuaCypwD7g7G3K+f2Qof33PEfLt0qfwKQJLLI9595fvoliYndE/S
        /mhp59lUYisTBbydXXkhKA20CA==
X-Google-Smtp-Source: APiQypJcvNv4pDReOcJEKCheR7ohpA3eksDlyYI4BNeYNc+nCmyMn5w0jJ+afnHpid9Nx37EUAFj3A==
X-Received: by 2002:a37:4ed5:: with SMTP id c204mr23485573qkb.328.1586904659318;
        Tue, 14 Apr 2020 15:50:59 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id j90sm11747701qte.20.2020.04.14.15.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:50:58 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.or,
        brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] kunit: use --build_dir=.kunit as default
Date:   Tue, 14 Apr 2020 19:50:54 -0300
Message-Id: <20200414225054.81721-1-vitor@massaru.org>
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

