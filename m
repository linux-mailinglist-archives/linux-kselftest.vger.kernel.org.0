Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F00571644
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Jul 2022 11:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiGLJ4m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jul 2022 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiGLJ4m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jul 2022 05:56:42 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2078FAA83A
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 02:56:40 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id o10-20020a655bca000000b00412787983b3so3100302pgr.12
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jul 2022 02:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=x/kle2uksxTcc6x66ftiegZgKc2BrTGOuQ67dMnzc4Y=;
        b=kwkTWMMQwkkHAKjVLJeMpSK64OpdmOgu236oC0XBqrX0D7J98KaB6ERHvVIsxhbZCI
         IjZbLhv6i+RjBhueyuRc2z89NREHndLUI7P+1cS2M3rofdySIBUefE8Zx/tKIC62tGPb
         sBLF+iClr+Zn5Bm0RSvEka+eTWzazkVC/3O2ZFBL8jIT9WJLQsAfwBZSbJkQMZTIfI89
         cORewAgFlyPdAdlkPiW7xz3O8SKElU7ZpBuFMq87gGR/aTiD/l0R19PUxl4Rt6t5Q2Qx
         4aT5W6gW5nD0vJVxsHCUz3+2p5cFeMveFo94NEWcVBwoseoOsr7S11L+fg9cG/HfuMvd
         wVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=x/kle2uksxTcc6x66ftiegZgKc2BrTGOuQ67dMnzc4Y=;
        b=oIPdBwq36Zd0GEXmG6K4tOd2OvIrsC/MoBx1mqdagSy/lSKJ20jkaraLrLYgpcuSbG
         sDDPH2b9b/JUDALrCl4GZaxLpJFyc5wsWwPmmAYrSLeacLueurxfcyevnDJB9+QAzvj9
         Ya9eooCG6iTwPvN0YrqY+KPmkhn37nolsrWMYOKDUreY6iU3aDqAIZ7UUcQftmjX+GR6
         GgvwHtbSyxuARGaz0aAuzs+JHGqRcytYtmwq24gBcW6XXgDtpxmetw0BQ/UqDDVheV79
         mgywqwhPmCcnrImJd/Kmw2S1aTr8vZWy+UbJUb9i1yUs8+Kl1k941VdRbfzhs2k/LEFg
         lLQw==
X-Gm-Message-State: AJIora9rgVNeMczRWHvtG37wVFhVQB4CikBcWfYSSfIh6aH1h5DXOt3I
        GNl/drqbjKS687cR31PdmrcDwpZF7Q9TYA==
X-Google-Smtp-Source: AGRyM1vvm3ysCBRhKyHvAVl7sjPZJlrlsNeD8k0D/UrZt0He9duZpcfV3smERgIMPPYL1yRGLfEhOGf5c4KqDg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr120662pje.0.1657619799129; Tue, 12 Jul
 2022 02:56:39 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:56:27 +0800
Message-Id: <20220712095627.1770312-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH] kunit: executor: Fix a memory leak on failure in kunit_filter_tests
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, kernel test robot <yujie.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's possible that memory allocation for the copy will fail, but for the
copy of the suite to succeed. In this case, the copy could be leaked.

Properly free 'copy' in the error case for the allocation of 'filtered'
failing.

Note that there may also have been a similar issue in
kunit_filter_subsuites, before it was removed in "kunit: flatten
kunit_suite*** to kunit_suite** in .kunit_test_suites".

This was reported by clang-analyzer via the kernel test robot, here:
https://lore.kernel.org/all/c8073b8e-7b9e-0830-4177-87c12f16349c@intel.com/

Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/executor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 6c489d6c5e5d..5e223327196a 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -74,8 +74,10 @@ kunit_filter_tests(const struct kunit_suite *const suite, const char *test_glob)
 		return ERR_PTR(-ENOMEM);
 
 	filtered = kcalloc(n + 1, sizeof(*filtered), GFP_KERNEL);
-	if (!filtered)
+	if (!filtered) {
+		kfree(copy);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	n = 0;
 	kunit_suite_for_each_test_case(suite, test_case) {
-- 
2.37.0.144.g8ac04bfd2-goog

