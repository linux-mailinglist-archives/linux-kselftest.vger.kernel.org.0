Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BCD3A966D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Jun 2021 11:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPJmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Jun 2021 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbhFPJmq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Jun 2021 05:42:46 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047DDC061574;
        Wed, 16 Jun 2021 02:40:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k11so1932853qkk.1;
        Wed, 16 Jun 2021 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZWm4JaN0Kmx/gNs8N9UEjJY41D+Vbr7666aSQNGKto8=;
        b=XudP2yxXdQJoWvzBHIcIRC+UYlEfd3FMgVwNabFlarO1izNDVz7KfYpHBZzRKW/FLe
         M+sZRKIH2fWSfClk0sOR3XgbOSslZJFEXebAggVfMEcz+27mfDn/xa96jXpQwSTRlwUK
         DzDfFOfpNmlTqkR8y3RpfcTdVHcvGuljEMaePAh5vLSQoKR4pcEp4RjoWi6OR5PJOZhC
         mXHeXNAVn6SkiUtASItNWGACPO5kF9fD0boMLqxndCKEFx8Xoy+0yiMtJL539NjUEuH+
         v/b0cAWITrEKfG9NlSLaLcQrJ2YhQo2wNpPRbVjX1yU2PAVeqVnn1lfbuXaDGYS5LhpN
         UT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZWm4JaN0Kmx/gNs8N9UEjJY41D+Vbr7666aSQNGKto8=;
        b=Wzl8PyyuPveOEaMeFx2foWdzrfyHZ47qmNFvu+WNTDgxwActwT5pxl7ejhz3afGBaF
         rkyx8NdnpYyBhCqTFEoZITM0FaTs7hna9K/F04DUft0dkgDmkdpdrUjuFLJ6pym5gKNu
         OCBKpqRZ5UTNSe+MtUJqnaPUxd3V2EZvNgUkHTQ8h4VqqcB54QdLkBRez96KBKWBXmlf
         QM1IC1xan+W6KB+FkDERnR0H4UUrHRU8PsFBQbCJFbkwGHipYS78SgqA/i6qcrOAiBiJ
         fF8JNt933TQHrcMwa09j9pUBRaTCLMCyEOQpZcWvFXdGoji8YJLh8rbxnpPJGXBEFSGm
         nw5Q==
X-Gm-Message-State: AOAM5307akz3JuvDjoYnSZmgEH7dvqQPOsVWavEYD87VIWG1HGnOm6Cj
        87fnzQoX/auio4UKXFZPWVE=
X-Google-Smtp-Source: ABdhPJy+iFSQgzHh7vDNDyj6+uQYmWSxMvJxk9jcrglHul9SVPy54F1XDc+PA7B0PLlCHZtVQeqXGA==
X-Received: by 2002:a37:5cc6:: with SMTP id q189mr4336675qkb.305.1623836439267;
        Wed, 16 Jun 2021 02:40:39 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id y10sm378360qki.32.2021.06.16.02.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 02:40:38 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH] kunit: tool: Assert version requirement
Date:   Wed, 16 Jun 2021 09:40:33 +0000
Message-Id: <20210616094033.18246-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
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
        assert sys.version_info >= (3, 7)
    AssertionError

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/kunit/kunit.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index be8d8d4a4e08..748d88178506 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -12,6 +12,8 @@ import sys
 import os
 import time
 
+assert sys.version_info >= (3, 7)
+
 from collections import namedtuple
 from enum import Enum, auto
 
-- 
2.17.1

