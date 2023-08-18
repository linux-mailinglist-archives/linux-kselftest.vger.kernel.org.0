Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333C27812CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 20:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379433AbjHRSWC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 14:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379428AbjHRSVb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 14:21:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70FE74
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 11:21:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-68934672e7bso1052959b3a.2
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Aug 2023 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692382889; x=1692987689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Mzm4T06rvXuj49cisXwWcUEiRJPpjeCq/+lpHV6q6A=;
        b=jcZ1LeHgOzWr8KHfrb1uwBjtfMxGj9kgvAO3xhBCTcOnVAB/B0jUQ0+PZc8Ce1lqtd
         Nbi6JNII7zDP1BHnzEwNUje6nGWLEeVHvxXaDi+eewt+6tqWtr8ztlQ3MOtfsfyChCaZ
         mzd7OXycMeC48cybaOKP3u5nAzHbH9jHik8pRznq4c3CAbYn2hf/GVjIsX1Qzy+LGCHO
         /A474hgAvxwQfYXbyu6ihbfFL24Sz4iXNma6N1T8t2ewgehCuiSqeaZqAaMICWulM5DB
         tEtHs+Db5ZjEqdlJx6yU4G8MDb0kKZJnGs9/nSYPWh1X8W4ADk15FOiBceNKGyvC5kVk
         aBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692382889; x=1692987689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Mzm4T06rvXuj49cisXwWcUEiRJPpjeCq/+lpHV6q6A=;
        b=jneICA7DiKaDnjEECV0B5GfoOO5uwqKi1ub8IoZbt0UNMkJRGJ03f1OGjz0xoGdIUE
         sLuYOyvxm/WQhZcZuw5VNPomgRuOA/brHfwjddZBaEWwrv1A8WCyzCpH3rf9jwOnq+f9
         P3XWG7IHzGq3aby8PZoBtn9h+8OjMWE3Vb/z3bdLiyXrDOXHWsSMCO2ug3B9wIf+XS9G
         IK6+ukL2qf9ydCCgElpknIomSndG8EQc/xemM9ObVKAZlGADGgaqJqszMGLRLlc5Gie6
         d5YvvYHUMwZmM9dzf/SuB/pg/LCokMsEaqanixyjtT4F43oes0msOpSQT6HZRHVJPdGg
         L5RQ==
X-Gm-Message-State: AOJu0YydBcgKHEb66/a5Tbi5YgzrXcOvS5M+GIGmyaDNYL2K7TqIDzIE
        5PuF8wXJxprgUK5TNEMJeW8=
X-Google-Smtp-Source: AGHT+IF4wwelbS3mPIAfRPiD4NnWd+plYIOVtxW+9LOBj4aF9NDQZAv06r+Trwy6fpBa0KrTNvGuvw==
X-Received: by 2002:a05:6a20:3953:b0:133:215e:7230 with SMTP id r19-20020a056a20395300b00133215e7230mr4197391pzg.55.1692382889150;
        Fri, 18 Aug 2023 11:21:29 -0700 (PDT)
Received: from fanta-System-Product-Name.. ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id z1-20020aa791c1000000b006889664aa6csm1839020pfa.5.2023.08.18.11.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 11:21:28 -0700 (PDT)
From:   Anh Tuan Phan <tuananhlfc@gmail.com>
To:     sagis@google.com, shuah@kernel.org,
        kirill.shutemov@linux.intel.com, mika.westerberg@linux.intel.com,
        wander@redhat.com, kai.huang@intel.com,
        mathieu.desnoyers@efficios.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     Anh Tuan Phan <tuananhlfc@gmail.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/tdx: Add .gitignore
Date:   Sat, 19 Aug 2023 01:21:24 +0700
Message-Id: <20230818182124.220105-1-tuananhlfc@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add .gitignore to ignore tools/testing/selftests/tdx/tdx_guest_test. It
uses the same filter from tools/testing/selftests/kvm/.gitignore.

Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
---
Change from v1:
- Use the same filter from tools/testing/selftests/kvm/.gitignore
---
 tools/testing/selftests/tdx/.gitignore | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/tdx/.gitignore

diff --git a/tools/testing/selftests/tdx/.gitignore b/tools/testing/selftests/tdx/.gitignore
new file mode 100644
index 000000000000..6d9381d60172
--- /dev/null
+++ b/tools/testing/selftests/tdx/.gitignore
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+*
+!/**/
+!*.c
+!*.h
+!*.S
+!*.sh
-- 
2.34.1

