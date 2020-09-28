Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EEC27B5DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Sep 2020 22:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgI1UCe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Sep 2020 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1UCe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Sep 2020 16:02:34 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABAC061755
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:02:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e6so1448372qtg.13
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Sep 2020 13:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=qL5Syy8+3ttyyqiRvm5VTzTd/DUJS6pVMwN6er+/rg8=;
        b=kgMsNRR490LnADrp/cWDm0iw+yCuETRFvp/AyXuKQSSg/OVqUS+1S1+2pydIg3pAqZ
         v7ufhfqBqg1TC9YxQSh1Q7OVeyv5zVFTD3sox/lVUT5tAav9mqlM7uaUxkY8ySpKC6l2
         VGqHVCLeC72E2IpgGJHpavVEg1yPzu0mKXLJoSADzEBEIYnFXsWa1guYrAGbMWps+xnx
         2tEjBogTAp16uNh+rQazS/BA+NfQ3qyCsneXHFdeC9lMhy7eis2E13P/vypBK/2YJA4L
         Nvqfa/8elV0uvfG1+9Z1geOLOf+S7Yzh3DZn+BwX9MQJ01Vq15C6eehSKvjFVs3gtJjH
         JJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=qL5Syy8+3ttyyqiRvm5VTzTd/DUJS6pVMwN6er+/rg8=;
        b=MJT09VfOUUaMyYCjtFUFX978naUirFtYOZB1qGyWp1Ns0tY3LrW4aCtCu/yroKtD9R
         6XfvUx39JPRlvF95FRO4gDy7jGIO2QeE78Ghg+kSowDglhn/IlGWqMEoPW1hJgnpWsUR
         VaCHt/urc7hTNDz+PgmXvisKhiODY2hEiNztY5CFNN41u4MrREbc5eqxRQVJ67Wc0axp
         olS8LkUTnSVFRu1SiLFSJp/bKUJ/GHODpPWll39P5/WqMXa26nZhPURgzrqo1S4zemys
         q9tEdDyaRO8hp8ofMltSebSsO37AYBO4dVVCIpSiIdbIb5A3RL95V42RU+CCUoAHYHlh
         f/aw==
X-Gm-Message-State: AOAM532ST/CUQV5r85WYYF4Zh0ocWV1z3ZpD7SwjIGoVTYvUFuKT4Xve
        T4mLe33DrImVMUgjPmLmlSyq3Lduw1LDD2RsLvbw7w==
X-Google-Smtp-Source: ABdhPJwlpAgc49EHBQLGLvlfofCp56Etax44tKciebXkaioeGhdT0vhAr76RDGb4uh3NVGQltEf/a3Xpyxr4gf0hdYwV1w==
Sender: "brendanhiggins via sendgmr" 
        <brendanhiggins@mactruck.svl.corp.google.com>
X-Received: from mactruck.svl.corp.google.com ([2620:15c:2cb:201:c634:6bff:fe71:d8d1])
 (user=brendanhiggins job=sendgmr) by 2002:a0c:9d03:: with SMTP id
 m3mr1127139qvf.54.1601323353193; Mon, 28 Sep 2020 13:02:33 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:02:27 -0700
Message-Id: <20200928200227.835600-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v1] kunit: tool: handle when .kunit exists but .kunitconfig
 does not
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Right now .kunitconfig and the build dir are automatically created if
the build dir does not exists; however, if the build dir is present and
.kunitconfig is not, kunit_tool will crash.

Fix this by checking for both the build dir as well as the .kunitconfig.

NOTE: This depends on commit 5578d008d9e0 ("kunit: tool: fix running
kunit_tool from outside kernel tree")

Link: https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?id=5578d008d9e06bb531fb3e62dd17096d9fd9c853
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e2caf4e24ecb2..8ab17e21a3578 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -243,6 +243,8 @@ def main(argv, linux=None):
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
 			create_default_kunitconfig()
 
 		if not linux:
@@ -258,10 +260,12 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'config':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-				create_default_kunitconfig()
+		if cli_args.build_dir and (
+				not os.path.exists(cli_args.build_dir)):
+			os.mkdir(cli_args.build_dir)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()

base-commit: d96fe1a5485fa978a6e3690adc4dbe4d20b5baa4
-- 
2.28.0.681.g6f77f65b4e-goog

