Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E7A1E2A22
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 20:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgEZSen (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 14:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgEZSen (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 14:34:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EAAC03E96E
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 11:34:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c12so2787041qkk.13
        for <linux-kselftest@vger.kernel.org>; Tue, 26 May 2020 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6aXjORE3d23i1StkTonhzGHIalGKnrHwR2gVaYOR1Q=;
        b=KGN04Gs7yNeKZzj8Lcyig10HxzNnFYhK42ZHpbQ7VNBeH5oOdHxr0avRB6BsoYRpdg
         HHf0NqmqHMxFxlPGrp/dyvpQBszyjEKVlw2KCc1XphtusuGVsAUn7O1bVuxVSvUHzDAO
         qDMbPlvkjYEKPQMSqNb3avW9ZnJ1JV677JoYBfxCY8u2Sr2CGJV7eb2fYyH7YyCp1xfS
         BvD8LhMMJltV/8TSjKAidYgKWQplesk60AeoWpiEIsKiT1shwbBy0mYHMo8JS2ky0+sA
         cMfCEn2PRi6ogyHzvbfD+0swY8H9NjiTzeEUn4ariY/8fTEGzx/HoNwF6w30WHKRhxEb
         fquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X6aXjORE3d23i1StkTonhzGHIalGKnrHwR2gVaYOR1Q=;
        b=gHgEtwIqazC11pJtu4YRqK2YvXZ5W1XQbR/64nQaifFxRdYCLbrsc79cadVradZclw
         v2dHe/fe3GRcpt/Y/zgkVhArcsrv8vQ3ZSJPryfXzD1V+xOhbWvbeg2pB/+Bccvyi2hI
         DEFGzRbMdOLuj7SyJrujd7JF5oSxoG6RVFxwb2NzX/GvieHErO4mN99PxdeFc3kA8oc7
         TpepS19VMihqFm9o3xCnHEwH0yumMRiwo2G8dWqvcNcwqiHrIndnMRlb/6jIl+5S2DWv
         6IfemtjutBinOglaB4nCMvlLiwrDH8ENwM9yUqGEHpnDkPcWp/l3pf7zi4g3f8i9rrgp
         8TLg==
X-Gm-Message-State: AOAM5334gaG/d6C49NIyp8yjuMXLY/QR4fWfc579o5VS4W9nNRKMecbX
        AoiX0d9BwoVTQvKld8DWk22nvA==
X-Google-Smtp-Source: ABdhPJx197AECqahGr2mrLzhHicRNVl3wRfVxYHrdKQzzsTRV2BokxzXwXPWx0y9cHLpDk04xJuo0A==
X-Received: by 2002:a37:484e:: with SMTP id v75mr142237qka.79.1590518080875;
        Tue, 26 May 2020 11:34:40 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id l22sm342526qki.45.2020.05.26.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:34:40 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com, skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [fixup] kunit: use --build_dir=.kunit as default
Date:   Tue, 26 May 2020 15:34:36 -0300
Message-Id: <20200526183436.47026-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To make KUnit easier to use, and to avoid overwriting object and
.config files, the default KUnit build directory is set to .kunit

 * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221

Fixed up minor merge conflicts - Shuah Khan <skhan@linuxfoundation.org>

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
version after merge on kunit brach:
 * fix identation (tabs instead of spaces)
---
 tools/testing/kunit/kunit.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index b01838b6f5f9..b3490271a103 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -169,7 +169,7 @@ def add_common_opts(parser):
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-			    type=str, default='', metavar='build_dir')
+                            type=str, default='.kunit', metavar='build_dir')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
 			    action='append')
@@ -245,12 +245,11 @@ def main(argv, linux=None):
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
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
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
-- 
2.26.2

