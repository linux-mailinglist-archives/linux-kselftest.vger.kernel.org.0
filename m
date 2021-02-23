Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5CC322588
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Feb 2021 06:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhBWFuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Feb 2021 00:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhBWFuQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Feb 2021 00:50:16 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA130C06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Feb 2021 21:49:36 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id z12so9344854pga.11
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Feb 2021 21:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7nwUfi6KIjUP86InROw8rezoggekF6NyvMMzvhEEfuc=;
        b=DdOC52yIOgIVLVqy8L6geNt6kv4oQHZ+0stdaEngdr1Pye0W8QrZeTNXPbURhvnd4H
         MV3AopjkbFvWVImM0k2cxPrdXxJj6N1VCceXHHnjjC0KJdEwS0LsnSjd8RvvTEMRkQY3
         FHf4uuuFKChbmvTs2tjeYyzMKK1+eC9w7PryHZMQ9tjm85QrNoFovn4yyVVqPbRk+Zru
         TnqgvSnII/+SJ1VLxizjfgRFh8wdtT/Yp0WMRWdKkLobs6QjQcvW/dQp/DVYnUpWlX16
         dgPj1t5sWBst4Qx5D5LiwlKlWjAiK2EHuRxPiHRhZHl9McNSOrB76M0BhGYWuNKnWsd2
         DuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7nwUfi6KIjUP86InROw8rezoggekF6NyvMMzvhEEfuc=;
        b=HOiWHfVvpI1dDos6oDXWVQQPTAwojn8UvwaM5gpJ9ZKLs54IMdwMBeq6nXSQo+vHcf
         vLXFAEJSP+NJ5ndSDVBMeWm1xrCmZIV/28neOOFxDMJJXsD4wqnsDckZZkR+935ggSzh
         dgneg9qDeP4u+pd1DGLTflonYxUc2VGeiNa6p1wgM7jNE83Zqs9G4hfIyN4ywdg1BvR0
         PjkyYAAYer/RY4Yap9DStokVzU1qf2RQB3LgjWZuSngwW8JLPLDyaWOOF4HoFt75ergQ
         LSNOF/n+IOYTka2V42R9vNffLl3uD3ajUUFtZVtnKLiQIDO2vApBljCQaiNEKYAj9UeU
         wAQQ==
X-Gm-Message-State: AOAM532JINZqsUXPGQu51KyzH0GHecvQlSrgAuUiZRPtDTfKuRDS9ACf
        imT/g9TyLCcwi1jmBsEcbAJ7D1KI2Ah1Ug==
X-Google-Smtp-Source: ABdhPJwAvKCuH2qeLRwQU63G6ZDF8lDWeVx5XsfZ/09EMAh51iJizxA7XPlCxfW7ayvniPe4PoJSbcX96tq+oQ==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:4d9f:f9a0:2f68:6a44])
 (user=davidgow job=sendgmr) by 2002:aa7:96cc:0:b029:1e7:c46b:2954 with SMTP
 id h12-20020aa796cc0000b02901e7c46b2954mr837722pfq.68.1614059376187; Mon, 22
 Feb 2021 21:49:36 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:49:30 -0800
Message-Id: <20210223054930.2345555-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] kunit: tool: Fix a python tuple typing error
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The first argument to namedtuple() should match the name of the type,
which wasn't the case for KconfigEntryBase.

Fixing this is enough to make mypy show no python typing errors again.

Fixes 97752c39bd ("kunit: kunit_tool: Allow .kunitconfig to disable config items")
Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 0b550cbd667d..1e2683dcc0e7 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -13,7 +13,7 @@ from typing import List, Set
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
-KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
+KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
 
 class KconfigEntry(KconfigEntryBase):
 
-- 
2.30.0.617.g56c4b15f3c-goog

