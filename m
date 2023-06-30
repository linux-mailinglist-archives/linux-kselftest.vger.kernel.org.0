Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F0743325
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 05:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjF3DZm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 23:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjF3DZk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 23:25:40 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B6359E
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:25:39 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666edfc50deso892121b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Jun 2023 20:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG0p2NxJxfYPPHk57XaDb7PRgK5Ncrcc/zrK6bcWJBo=;
        b=bWbcBjLe/HmjBUDi0chJKHI1VfwXeVHFrwoWQ6d5F3ktM+1Hx4SU0oGAk43uPUCNJS
         fay+/AQYi1YyouUv9X87uiVa71QR3+42BgL6odKqwm0xDf4ur4NY6vRttiQcU8fa9H7C
         BbtQfAx2ouVJRy+ccgkoOOaFpSGcWKEme9h7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688095538; x=1690687538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG0p2NxJxfYPPHk57XaDb7PRgK5Ncrcc/zrK6bcWJBo=;
        b=Zk6OZN3cpsy/wqLR8iE0ZOyXr67aZVMMKVwrYBgcCjC9PeU8DqF9C7ci5mfQZyLL8c
         TR8V2lTjS6OdDD27zG/GzBXMbuxYglqDw8UEvcljCxcRjm9Fd6N2QawtJW6DrpFezRBA
         MQn6I3ZT47Esu4vRLtup+bXbrjDWaX6UQg+pJQ5MD9JGRo+YN/IcFufqJdqxZ6CSaD54
         KPFLjP5BNHInUi+Y2kNiWcg7b136WS5AkbuqmaXK5La4G/I/8gvbUt467NsMZHcAx+hz
         5p315POUQI/m/0Blc1pBkSxP4T/qvwaipKwsC4z2iBM632Ns7+4wXl8F3LDcHnZIjEjU
         gN2A==
X-Gm-Message-State: AC+VfDx+z8PHdFTOFNcaXwjfRcKgffiSHdFwDAqJucT27Cedw70JAqo6
        iJvddc7xMtYGF++n/wIicz+mPYaMJQqT5PICYjI=
X-Google-Smtp-Source: ACHHUZ5TBCQc99UAuCTq/sSZmqcHuuEfzJMPoZsd6eNZgMDz7INWJtHCNyWIS/wMBM2hYLOZS6QS3A==
X-Received: by 2002:a05:6a00:27aa:b0:657:1fe5:eb63 with SMTP id bd42-20020a056a0027aa00b006571fe5eb63mr7433745pfb.7.1688095538633;
        Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
Received: from localhost (183.43.230.35.bc.googleusercontent.com. [35.230.43.183])
        by smtp.gmail.com with UTF8SMTPSA id f4-20020aa78b04000000b0064fd4a6b306sm8973599pfd.76.2023.06.29.20.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:25:38 -0700 (PDT)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, asmadeus@codewreck.org, hughd@google.com,
        jeffxu@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v3 1/1] Documentation: mm/memfd: vm.memfd_noexec
Date:   Fri, 30 Jun 2023 03:25:35 +0000
Message-ID: <20230630032535.625390-2-jeffxu@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To: <20230630032535.625390-1-jeffxu@google.com>
References: <20230630032535.625390-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 Documentation/admin-guide/sysctl/vm.rst | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 45ba1f4dc004..621588041a9e 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -424,6 +424,36 @@ e.g., up to one or two maps per allocation.
 
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
+process's memfd_noexec at the time of fork. Changes to the parent
+process after fork are not automatically propagated to the child
+process.
 
 memory_failure_early_kill:
 ==========================
-- 
2.41.0.255.g8b1d071c50-goog

