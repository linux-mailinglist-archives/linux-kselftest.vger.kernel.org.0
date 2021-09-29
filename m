Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B663341CFEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 01:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbhI2X1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346868AbhI2X1l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 19:27:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8A8C06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 16:25:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b5-20020a251b05000000b005b575f23711so5658277ybb.4
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3k/5/Q3FVmwGpvBlwOcSeIO10fDHqoiU1INzIKkbGck=;
        b=pyekV7dNkLHfcmd/KRNZyEpbmyCyLBiobS+q2fL0ZeZe9rvsOWfKuVu+sjI+iwE+PI
         AxvIrbxOweE3/UckGwwp6bXJyTV5+32MaZfGsmbq/SjMQ91PKfXmKrt+eFzLgp2fL1x0
         G1UKGN2eo93mzaAEK3PrymKslz7ayFLQRLSqPGvq/yv0Jw67CHqUoYfaBNzpKzo6Wxvb
         ZM3nWtOHFV/c1Xz5c0s7YHyPIng7ym2DjN8AbLfooZloJ1ByMBxpgqjKWYvo9VHkSDdT
         86LTqUojzoWw3kgRgP0v0IUiWMOd6AihM9rIp2kIob7O6c0gNIvhb1LKs8u3AUG9qiKF
         Vb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3k/5/Q3FVmwGpvBlwOcSeIO10fDHqoiU1INzIKkbGck=;
        b=zMHT+Mpv17i7/SWCbD1bZDv8hFtqACxjNvv8JJGnHXurNDhKO7Qym7qbERteEhbTOg
         LA68Sm+IF2+0elzo8t6PxqJYxBol2HqTU6228cB9yHNzIGrv2v1dBggbUbQcTiN5cDP8
         Quxj0ySbo+q1O/eunIH1kVA+DGTYc+k0kXDuG7RwuQsYHODj1Msg0StTaURPcKlAIAs1
         UYP6m/Y8EjoVGw4ywwGySItl2m2quu+9rWdo2c2b9+ctEE8uGX0aSZKdICGx5BmxRnBN
         AKDtsh2D+d/zbGRc/KFTX/wX2Ww5T80qAgDCOZR3DvxCanafC6zxsQjH08O6l7vLqs82
         kPOg==
X-Gm-Message-State: AOAM531ef+HFbYEb5twqIO5U9P/M1Tvn8oSscULZzfvK7tm0043UyCo2
        FUDgATE5ckri1X1v/IFMOSi1ebG6KC/wtw==
X-Google-Smtp-Source: ABdhPJwz46ZXct29xbVnwPzD0zpZwmHFQwxPnnJTy8QLu8SC0Q38KtTNwOddxfaK8BpFdIOsovpHYXnzMsqyjA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a25:db91:: with SMTP id
 g139mr2883604ybf.391.1632957959133; Wed, 29 Sep 2021 16:25:59 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:25:34 -0700
Message-Id: <20210929232534.1433720-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] kunit: tool: show list of valid --arch options when invalid
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Consider this attempt to run KUnit in QEMU:
$ ./tools/testing/kunit/kunit.py run --arch=x86

Before you'd get this error message:
kunit_kernel.ConfigError: x86 is not a valid arch

After:
kunit_kernel.ConfigError: x86 is not a valid arch, options are ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc', 'x86_64']

This should make it a bit easier for people to notice when they make
typos, etc. Currently, one would have to dive into the python code to
figure out what the valid set is.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py    | 5 +++--
 tools/testing/kunit/kunit_tool_test.py | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 1870e75ff153..a6b3cee3f0d0 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -198,8 +198,9 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
 	elif os.path.isfile(config_path):
 		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
-	else:
-		raise ConfigError(arch + ' is not a valid arch')
+
+	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
+	raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
 
 def get_source_tree_ops_from_qemu_config(config_path: str,
 					 cross_compile: Optional[str]) -> Tuple[
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index cad37a98e599..2ae72f04cbe0 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -289,6 +289,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				pass
 			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
+	def test_invalid_arch(self):
+		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
+			kunit_kernel.LinuxSourceTree('', arch='invalid')
+
 	# TODO: add more test cases.
 
 

base-commit: 865a0a8025ee0b54d1cc74834c57197d184a441e
-- 
2.33.0.685.g46640cef36-goog

