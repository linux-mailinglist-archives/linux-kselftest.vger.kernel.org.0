Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137C14BAB4F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 21:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbiBQUxC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 15:53:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243461AbiBQUw5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 15:52:57 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C66606E5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 12:52:42 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d2c8f1221cso23753017b3.16
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 12:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zREWNOVmNCvVfd79yCGKVInkTtd6rFRbK0GKom12BeM=;
        b=Bmic+DwnC7ikZtMECQ5uZy//SeIQBEIvo9GXuYVdjp2cMD476BzGmQShgsNAz09qFQ
         hdC3pA7rNKa0pnu6URSrSCntkOs7fIcxbgopV3NLcMFxqsPkfwIMpL87FR+Ho0AnqglA
         MCe4AjFMt4zkAatrIOwiGIprmnFiHXMNavL0JgefnIiAa6ZOM287ogMpP41KcjaSEhkR
         BmLiC6FIDqbBLa59UrZOgr/V8Qig9WpHJ1Ri55HALpRYzwNC89dzA8dyBdoOqgkzi4Uh
         DERoePtXF/NSo2nd9XcqnjNtHnlvFZgr+reeBXgEaFbhJvBtAOghmZucbkQHjLyuf4D7
         IXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zREWNOVmNCvVfd79yCGKVInkTtd6rFRbK0GKom12BeM=;
        b=u8UyMg5M2/ptQIanpXm67Q81kJRFVdVXirLv6AX+/7am4sI+8hktvGEMFEZ7PXIv2Q
         /BaTR1QBMBoHnOKnpa6kqYvAxcjossrtBcfIxsylfp5tZ2SITx2kJgBZGnGytT9Azwiv
         HSyeLBhRZmEnMhZhDfiqzIIDnMGp6+rEbdKWeJeNQKu4ZSmG+H8U9eVvuHuVooCcf3pf
         kpS7JYDK+6LEcmPsrcMJDaHLXf1pMzadaU9AZtB9pZkNqJ+9RQFkO8xtsIDUEzhLuOMR
         uCUO/unO0LOjxDxEQHriKtHtr4GioX5Gv8AZthSirXhVsXcSIu/HGbWhb0e72c8cIH36
         hvtA==
X-Gm-Message-State: AOAM532kINHra5H2a5YMZa6nD8HqtQgOyajvSiE2G7sFihim7S3BMcXv
        nZxyY3luJx5ML7TPHInHN1KGp5VIG6bvHw==
X-Google-Smtp-Source: ABdhPJzFj8x+TdEvLzuXTd9/RlqXWmNrl/PKjfT4OeMEZi3o9WL2PomCJ1KnnYCY1+ycRe6daH2IHPZEWMRNwA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1d37:446c:f8bc:463])
 (user=dlatypov job=sendgmr) by 2002:a81:f92:0:b0:2d0:5383:7ca with SMTP id
 140-20020a810f92000000b002d0538307camr4582718ywp.268.1645131161501; Thu, 17
 Feb 2022 12:52:41 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:52:27 -0800
In-Reply-To: <20220217205227.4098452-1-dlatypov@google.com>
Message-Id: <20220217205227.4098452-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH 3/3] kunit: tool: properly report the used arch for --json, or
 '' if not known
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before, kunit.py always printed "arch": "UM" in its json output, but...
1. With `kunit.py parse`, we could be parsing output from anywhere, so
    we can't say that.
2. Capitalizing it is probably wrong, as it's `ARCH=um`
3. Commit 87c9c1631788 ("kunit: tool: add support for QEMU") made it so
   kunit.py could knowingly run a different arch, yet we'd still always
   claim "UM".

This patch addresses all of those. E.g.

1.
$ ./tools/testing/kunit/kunit.py parse .kunit/test.log --json | grep -o '"arch.*' | sort -u
"arch": "",

2.
$ ./tools/testing/kunit/kunit.py run --json | ...
"arch": "um",

3.
$ ./tools/testing/kunit/kunit.py run --json --arch=x86_64 | ...
"arch": "x86_64",

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py        | 4 ++--
 tools/testing/kunit/kunit_kernel.py | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dd6ed42141f..5ccdafd4d5aa 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -153,7 +153,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
 				filter_globs = [g + '.'+ test_glob for g in filter_globs]
 
-	metadata = kunit_json.Metadata(build_dir=request.build_dir)
+	metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir)
 
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
@@ -506,7 +506,7 @@ def main(argv, linux=None):
 			with open(cli_args.file, 'r', errors='backslashreplace') as f:
 				kunit_output = f.read().splitlines()
 		# We know nothing about how the result was created!
-		metadata = kunit_json.Metadata()
+		metadata = kunit_json.Metadata(arch='', build_dir='', def_config='')
 		request = KunitParseRequest(raw_output=cli_args.raw_output,
 					    json=cli_args.json)
 		result, _ = parse_tests(request, metadata, kunit_output)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index fe159e7ff697..bbbe2ffe30b7 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -248,6 +248,8 @@ class LinuxSourceTree(object):
 			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
 			self._kconfig.merge_in_entries(kconfig)
 
+	def arch(self) -> str:
+		return self._arch
 
 	def clean(self) -> bool:
 		try:
-- 
2.35.1.473.g83b2b277ed-goog

