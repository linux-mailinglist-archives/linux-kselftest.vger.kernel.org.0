Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AC43B20CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jun 2021 21:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhFWTLz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Jun 2021 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWTLx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Jun 2021 15:11:53 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C2AC061756
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 12:09:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id b2-20020a0cf0420000b029025f56d0b50dso4151811qvl.0
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jun 2021 12:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J6FXlCH6GdU6G8KE2DrypG+FaXn/OBwuSoRNmfTEo4Y=;
        b=Zv53Jlk8RsxRXVXxyvdxFRA86daaO67Qno0OYRPiOYqDm704ItdVfLG/RTQRWPRWd0
         d8h50fETiRYyTsddvWgQoNke/RRXUz4gLq3fN85APG4SZ1PMWtSjHef2s3ACiksAn/rB
         qirS2ynXEGrmcmtz2etIQbisE11XpcBz6OrJqsWgw8r0AipAdjEF8J6hLsX3LuD+teGW
         qDIfRoRKiFkGQKafhpzD7dJFuUuo1eSCqrWmPoZcHFu0OyuqvMo1MftepJMeqISMaXvG
         FZqZ1HVBoAMJONmQ1JR8obgHPp3DPy6CvuUTjJzs7qpUb5oTgaTfAvXig4k8STXl4XqB
         C8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J6FXlCH6GdU6G8KE2DrypG+FaXn/OBwuSoRNmfTEo4Y=;
        b=buC+jDeIGbjS5aQHETAY0hnRbPHvUofWtxL1QBsQKb5m7ZVIQ/6i2fVmPymLzILeGS
         KiU3a1Eq3fSg06spn42ikafTkVaQ675yWubf51lVxC3UQI95s9p8r2kh1SQEmVZPPHD8
         oojw2XBQHduQ8l1FvnuZwjNxptDEq7ab83kKvglzQiyvq+B5q7Nd5jjTqm1V+MJMDsU5
         3DoouGVDwFoJJ1VEWVv2oCuNDQEWrZZf0Xci+vvx/BOU8xkqg7TwLLGNUTyFHT9kofP8
         FcdmWogrzYrKVPSz1GovFzM7g+Q+ddmTlG/8W2rgQRRTs7Hz+Y1MMXZWETXKqtG9bGPd
         FjLg==
X-Gm-Message-State: AOAM530qWs+uxG/4KRm5fwEY+jkT3DmY0dcnmkS0SzU50HKPOa2C1LQp
        49KoeulUEn6WXHFfZENTkNJklLKX/V9NNw==
X-Google-Smtp-Source: ABdhPJxDi48BGKHwxZ5fCr6+LLXgqU2ZiUABwokrBZKuGhuHj1qWSvi7pOGHas56dDEuDRZUgzHaAlL+0Trk7A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:bb8a:281b:ed1:24b3])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1028:: with SMTP id
 x8mr1465157ybt.140.1624475373332; Wed, 23 Jun 2021 12:09:33 -0700 (PDT)
Date:   Wed, 23 Jun 2021 12:09:19 -0700
Message-Id: <20210623190919.956814-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] kunit: tool: remove unnecessary "annotations" import
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The import was working around the fact "tuple[T]" was used instead of
typing.Tuple[T].

Convert it to use type.Tuple to be consistent with how the rest of the
code is anotated.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_kernel.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e1951fa60027..5987d5b1b874 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,15 +6,13 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-from __future__ import annotations
 import importlib.util
 import logging
 import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator
-from typing import Optional
+from typing import Iterator, Optional, Tuple
 
 from contextlib import ExitStack
 
@@ -208,7 +206,7 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 		raise ConfigError(arch + ' is not a valid arch')
 
 def get_source_tree_ops_from_qemu_config(config_path: str,
-					 cross_compile: Optional[str]) -> tuple[
+					 cross_compile: Optional[str]) -> Tuple[
 							 str, LinuxSourceTreeOperations]:
 	# The module name/path has very little to do with where the actual file
 	# exists (I learned this through experimentation and could not find it

base-commit: 87c9c16317882dd6dbbc07e349bc3223e14f3244
-- 
2.32.0.93.g670b81a890-goog

