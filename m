Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47E974310D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjF2XZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjF2XZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:25:07 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714611FC2
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 16:25:06 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b5d7e60015so1048553a34.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688081106; x=1690673106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XkUN0EizrcPJdxYDyml9MD9K5nwnJEgupZt44caww4=;
        b=DIOrkzvu8itXrRDVqrYwNUO8RR/O0uEKATtMBGoLT7ZDMAULfOV2+XLpRMwb4lSo1H
         o8f4vm7uBwP6nRhUwyvViY15Yn73fB6S5rSl+En04NKl9NuKOjDAks0aqXtGB6itZkTx
         hFE5wR4rTEM4DrLYzlMegMS5O2+oAyJQsqHkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688081106; x=1690673106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XkUN0EizrcPJdxYDyml9MD9K5nwnJEgupZt44caww4=;
        b=ECvz/wl0OVODWZJzkNT8rCrFTEGxJtrT7j5FPoeSWIoVvKDuUNnf6eBCwRm3UeyoxO
         x+XRoJG1Zn4Ix5WLufhbLMx2fdeh8QVkJyQICbAOjdjGUd8yA3d0OR7LtrG9JoO6VFWi
         GLSUG74hzary+um68BedM/eZGzeDq/+b7miKT6AYyvtJyqbG+5Xz93hyNKFscPMTS3b6
         T7jwnPLTOyJFK90g2vNUKVc3mDuf7NQpgrH1zLXmrQ1fH3Ve5O0GBNpzteaaysXE4OzO
         mdjhdrMPVh2PO092sRimGZmOWWPeohFzUrBOX6RspqK6Aewe963D7iJ2ZaaED5eS4t9t
         NvjQ==
X-Gm-Message-State: AC+VfDxDpQ+UJipYEUBi1Gl7auTFrWYT+HVJ/MYKUcuyEUl1jJiyKfI+
        nW5wbhE1PLhtcy2f4+JUuS0pOw==
X-Google-Smtp-Source: APBJJlGFQhB9pXlX/BZEhpArHhanMF0PsxvAgS8Ray5hkbYflejU/wjfaf/Ywe+hLWqeUIiTbaazMw==
X-Received: by 2002:a05:6870:3c8c:b0:1aa:9eb6:974d with SMTP id gl12-20020a0568703c8c00b001aa9eb6974dmr1593876oab.41.1688081105835;
        Thu, 29 Jun 2023 16:25:05 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id g15-20020a17090ace8f00b002636e5c224asm573038pju.56.2023.06.29.16.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 16:25:05 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] Documentation: mm/memfd: vm.memfd_noexec
Date:   Thu, 29 Jun 2023 23:25:01 +0000
Message-ID: <20230629232501.4157671-1-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Jeff Xu <jeffxu@google.com>

Add documentation for sysctl vm.memfd_noexec

Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
Reported-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 Documentation/admin-guide/sysctl/vm.rst | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 45ba1f4dc004..71923c3d7044 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -424,6 +424,35 @@ e.g., up to one or two maps per allocation.
 
 The default value is 65530.
 
+memfd_noexec:
+=============
+This pid namespaced sysctl controls memfd_create().
+
+The new MFD_NOEXEC_SEAL and MFD_EXEC flags of memfd_create() allows
+application to set executable bit at creation time.
+
+When MFD_NOEXEC_SEAL is set, memfd is created without executable bit
+(mode:0666), and sealed with F_SEAL_EXEC, so it can't be chmod to
+be executable (mode: 0777) after creation.
+
+when MFD_EXEC flag is set, memfd is created with executable bit
+(mode:0777), this is the same as the old behavior of memfd_create.
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_EXEC was set.
+1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+        MFD_NOEXEC_SEAL was set.
+2: memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The default value is 0.
+
+Once set, it can't be downgraded at runtime, i.e. 2=>1, 1=>0
+are denied.
+
+This is pid namespaced sysctl, child processes inherit the parent
+process's pid at the time of fork. Changes to the parent process
+after fork are not automatically propagated to the child process.
 
 memory_failure_early_kill:
 ==========================
-- 
2.41.0.255.g8b1d071c50-goog

