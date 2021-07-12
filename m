Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037BE3C6442
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jul 2021 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhGLT4N (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jul 2021 15:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234045AbhGLT4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jul 2021 15:56:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E97C0613DD;
        Mon, 12 Jul 2021 12:53:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z18so11490907qtq.8;
        Mon, 12 Jul 2021 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R4CPNBCoRG/ROfLM0HKloJBj8kStk9mnjOTyhr8xRx8=;
        b=R59X894JLdoR5MoQS4IUrBFss14Z6OJd+MM6ghHtspOgMfWAzMgnu13B10jnNcHLfD
         4ifsF/ERI/VVk69f0UgLrM6vK/t4bRyf5FGMgT1SbwsYIK2jt+vYJ6qekOg8qfo6ag/X
         a6upF7hE64sGybxZpTvI9he9Txo1+6AG1bquftlGh8VZWxblnkEW9MXFUGV3Ao56H9xf
         KxXWTWgiB3yu3rUQ4Ola0iRPClqd4kLqNGYyJ97itK9GHw6/aK8cvIjcx10XKxrObpct
         PhElr4Uj+VkNj35UFm+Op3VeBF4oaHoCT7WCp48k0RMBLeRpZbG2MNVSGR+klCZQn3e1
         9Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R4CPNBCoRG/ROfLM0HKloJBj8kStk9mnjOTyhr8xRx8=;
        b=hg0ufPNOKinU9R7IM8OGTIN+4dVzSyuHIHZqkX7DcKK+wVRjlqkF3TU3jHYktwatLH
         rfmpYEhvGYJAKba3oirB4H1kyqjVn1rfk5doQYIZhNGq6rtrbgEFGwbmu6UL2He12u+h
         c8qdDZKPohy0KJmMiKMexjVOB6br4LaShdyX+/skzhpx7jfZW/xskdoOmYWdqAQ7eCpQ
         MOr8Uw4/uOSvQnMEdt4upIMr3psuCM6hzRA2pkswFfECysxD7JIBFASOFmBh7HdHJspA
         x6/EAAEOqmdu5egRy9+ZQbGFkA2ja28az7xJwWVwZINJ2Bzgxo3KxyI+AqcJEK9Qspto
         IirA==
X-Gm-Message-State: AOAM530dGNyCMJUDsskYJPDO2aBKdmzOg4uGEpk4QuaCQOyUj/3cNgCw
        uKVcgIANXaITthZOLh8gR54=
X-Google-Smtp-Source: ABdhPJz3V0DKCk1nopVALCxNXAoyma4UjFjBWdkGbEg+pKj01/gMuhtpHkCnshxddGmN7sImGNOj0w==
X-Received: by 2002:ac8:5e08:: with SMTP id h8mr548211qtx.54.1626119603942;
        Mon, 12 Jul 2021 12:53:23 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id 6sm3092744qkv.115.2021.07.12.12.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:53:23 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     skhan@linuxfoundation.org
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v3] kunit: tool: Assert the version requirement
Date:   Mon, 12 Jul 2021 19:52:58 +0000
Message-Id: <20210712195258.21074-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <6fb4706b-ce58-a397-d777-10338c2a8d4e@linuxfoundation.org>
References: <6fb4706b-ce58-a397-d777-10338c2a8d4e@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Commit 87c9c1631788 ("kunit: tool: add support for QEMU") on the 'next'
tree adds 'from __future__ import annotations' in 'kunit_kernel.py'.
Because it is supported on only >=3.7 Python, people using older Python
will get below error:

    Traceback (most recent call last):
      File "./tools/testing/kunit/kunit.py", line 20, in <module>
        import kunit_kernel
      File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 9
        from __future__ import annotations
        ^
    SyntaxError: future feature annotations is not defined

This commit adds a version assertion in 'kunit.py', so that people get
more explicit error message like below:

    Traceback (most recent call last):
      File "./tools/testing/kunit/kunit.py", line 15, in <module>
        assert sys.version_info >= (3, 7), "Python version is too old"
    AssertionError: Python version is too old

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Acked-by: Daniel Latypov <dlatypov@google.com>
---

Changes from v2
- Fix mismatch of Signed-off and from

Changes from v1
- Add assertion failure message (Daniel Latypov)
- Add Acked-by: Daniel Latypov <dlatypov@google.com>

 tools/testing/kunit/kunit.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index be8d8d4a4e08..6276ce0c0196 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -12,6 +12,8 @@ import sys
 import os
 import time
 
+assert sys.version_info >= (3, 7), "Python version is too old"
+
 from collections import namedtuple
 from enum import Enum, auto
 
-- 
2.17.1

