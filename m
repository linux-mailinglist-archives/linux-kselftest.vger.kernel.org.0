Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1DF3AADEF
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jun 2021 09:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhFQHsy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Jun 2021 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQHsx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Jun 2021 03:48:53 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88ED7C061574;
        Thu, 17 Jun 2021 00:46:46 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id p21so4011140qtw.6;
        Thu, 17 Jun 2021 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MnXTO/R9SYASJnegiIJxwe88I6hev7rMEEpPxN1h0Vo=;
        b=RW6nOfIfejwctXIEtUP37HAzZTn55Wq0WwCeAUTpSFTNrXoxNsFSOGzxBOEsL63nRP
         8gNvN/QTu/0GkAYvOKzN4108BHyhZbPE4tIWQ6Hm03OVOAmqVYRg9Gt07Us+x+ZeQULY
         1FAclID2Uoad86/13Z9GJHUJSxgTu9hrq+XP+X1u4iSoUGbHjdp29pm68rqPvvq2dCUu
         y6fN3A7Z2Lx2uw7GcpN+AUKDsjct0qgBdlrniuXkGwBDEQBUSerYeLHo+WGOxjJ6EpUt
         jeumKSQXb72vVjamqeJ8h/x5+reqHQtgjw+KR8vLw6l/XUUNh+4hvh/8ANDbtJ+GCH/y
         fMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MnXTO/R9SYASJnegiIJxwe88I6hev7rMEEpPxN1h0Vo=;
        b=j0zMZL8feHt8eDzO1fFNSC1a+BHNZ+q/IWeDzrzmxoTIj9ouKnZY1Zt7MUIkv5Yx6/
         r17+IBTTYDahaBWGFaXBMElaUzaInzJVJOSeLhL4sAAAICiSp8VjWlBubfv4Qs29ZV+u
         kpHHZlQ5tw/i06HjdKZVWObhfKd+lCYqY8juUoSLzl5ABygCFbI15/ukL/iMWhZNCwM9
         7kLellutwb5q9n1mZex00/LAnJ4dLiCz15iOVb4l7ozcfhapOsWTYU2XJffM3G6h1oga
         TzbqpWmDsRmXAfWO87qJ3BYNYEGIFhtBvi63RO1NZ6gMxZHQX3NYcVtXr+F3Wsk86d0u
         9CJA==
X-Gm-Message-State: AOAM533qrUjEizt5Z7fNZg/S4iJbcPqcanUhlTtmNrs+k5772SlE2m8q
        oTGggVgvB7I4eLeQTM+oqig=
X-Google-Smtp-Source: ABdhPJwqduBY52CnMg0dGDImsxPovS8sVypwtisrCrPp+CRUF96sWHf/0TOcpocu/Z6//SQ8mQdXmw==
X-Received: by 2002:ac8:718b:: with SMTP id w11mr3889943qto.354.1623916005794;
        Thu, 17 Jun 2021 00:46:45 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id v32sm2814990qtc.95.2021.06.17.00.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 00:46:45 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     brendanhiggins@google.com
Cc:     dlatypov@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: [PATCH v2] kunit: tool: Assert the version requirement
Date:   Thu, 17 Jun 2021 07:46:38 +0000
Message-Id: <20210617074638.16583-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210617073937.16281-1-sjpark@amazon.de>
References: <20210617073937.16281-1-sjpark@amazon.de>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

