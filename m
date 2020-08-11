Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578C82421F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 23:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgHKV2H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 17:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKV2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 17:28:07 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27962C06174A
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 14:28:07 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id d30so9910qve.5
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 14:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JEHvtyXY0PahDyTNTofnb+o70v/Ji63GK4tErbh+T7U=;
        b=v0rqLtrGjr6RFTcXhotnND/SQoYUh8qkJiSo07+iNVvoBLd/0LvoE9uKnK7QGigI+H
         lOsCUjwqLAQts0bZdwzMbO7m+/6LPejOxPT652Ef1zJyeKkPQSkF9eGFV3/wI4pSMeRp
         isxJ3DUdz3d9fsGLF27K1CDAphFRsyMlDSub4YXU/wtyuwsVmg/UBRfA7fMUtuj8F+1A
         pAnel/CZ/vbYM9gccjLQGsy3Ci7VH0lPDsxbjoTPiLf9Q6OUZzJxdx5r1EEyik+4xG++
         kqzgGblHuxo9mG+yOb/h8tavfSWnv8dalfViOp9SEWna1ZXzs8aeC49uvvL+01l7LkdW
         yAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JEHvtyXY0PahDyTNTofnb+o70v/Ji63GK4tErbh+T7U=;
        b=WFP+oYMsvCsZPpgZvzlQh55bANHftlc7ITuVysQqR/PyhU5ZtLG025HZfpc0NJQ0BY
         ourbXF7VPUJcav2ogj1Iz6ClFP7O6MKzKS4hqPpLoXBmUGsY3wAF9NKspaW2gv0XUGjx
         O/5ZS0rFcHL//YnBKJCK0MPUC7BogqspwGl0xEP+JSyzobszKiny0Wt+3KkgPpsM0fny
         cpeB2o5n4nV0rxHhtpL1Jc5mcyKH6ocLvp1kcZI5l1srCV1vhrShem5yJ+s4QKHETPXl
         aKmVmZwmWdvjntBWdqmkJYPHL5EG9F60KCcaT8b5mKkl8pujASbemFi6TuPHm2Aex3Qw
         voeQ==
X-Gm-Message-State: AOAM5303SSZr6Yrx1OaG9kLVSV3uw8geZtCf+zTxcxVBKuCD8xcCwM/l
        N/16KVnkpmMopS6mFJnDgkpGHSRnL8jWXMgAfBrseg==
X-Google-Smtp-Source: ABdhPJwe/D1QnjaomloZ5+oBlMTzK1X7S7cIeykWGHTCWPLu4m/3lcVHUxJZ3HD2LIOfXvjGcgC+f/3kwSG0yIrGgAyxqA==
X-Received: by 2002:a05:6214:1302:: with SMTP id a2mr3525273qvv.156.1597181286277;
 Tue, 11 Aug 2020 14:28:06 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:27:55 -0700
Message-Id: <20200811212756.3328740-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently kunit_tool does not work correctly when executed from a path
outside of the kernel tree, so make sure that the current working
directory is correct and the kunit_dir is properly initialized before
running.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 425ef40067e7e..e2caf4e24ecb2 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -237,9 +237,13 @@ def main(argv, linux=None):
 
 	cli_args = parser.parse_args(argv)
 
+	if get_kernel_root_path():
+		os.chdir(get_kernel_root_path())
+
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
+			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -257,6 +261,7 @@ def main(argv, linux=None):
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
+				create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -270,10 +275,6 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -288,10 +289,6 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 

base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
-- 
2.28.0.236.gb10cc79966-goog

