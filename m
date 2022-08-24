Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDCC59F279
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 06:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbiHXETm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 00:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiHXETj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 00:19:39 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB508B9AE
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 21:19:38 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id oo12-20020a17090b1c8c00b001faa0b549caso289983pjb.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Aug 2022 21:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=dtOhqGnkves9SrK5XswrClqDxN5tTmyAGGBi6bYs+Zk=;
        b=tEtIA9Lp7KvJbbWV+LV8/t585wsH87L2cPJeXJo0c0kZbJov9u2WsyRalajXFn0//w
         K/K+ThaQ1nCSV5Re3X/PjLLnf7RArWVcrNjgU6TtIJcZxmcRP0aUAqw6rFOl6m4RlKNp
         ITnoUSX/zMNTZ+B7mpKBmE1dUxAzF2kGkk6+RO1q91XzAz8lEUa7L6JPXwbORZQHhzWK
         7JXi4xWSClPzRX5jJt4zXLeWnyQVDcKtABJ6L5cKKRccQOCKmtvMoc/MlKDYlkxlk6z/
         bDiQYM3mvtOP4keT6ocnNDltSG8uw6uI+BzrWr0MfCU3eJB0OJTFcoD+NwipldNbJ7gV
         NT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=dtOhqGnkves9SrK5XswrClqDxN5tTmyAGGBi6bYs+Zk=;
        b=fcV0W8sQeyQl1fkpJHxDyDp/eT+asGDgoHsTNl0ymas98cixWfrt6vnFflcnQUNnlX
         X55GtNqYnuwEUoZ8KUmbChObCjPLQNtIDlkyNV85ATdZyhM0+q6sT3KZZaJuFBCYSX4a
         2eRr2zAXIoePc9OMSBAqJ/qNCN2O2OzrURlWVQYtWorJR19rRsbfOr6AuxbPqNtsPLhk
         x+63V27eF3BEF5hPXp5jygEerMitoOZT6V3CYkYFbs4GWp/Yn3n7iGNQJmVVPQjRghY9
         CgnEuyoUSPypsKXNYdeEaXAImsn7V9dGof8KuvHYjaH/4hb6FqwHXPqO/2Fs/mmmQM/2
         YUGw==
X-Gm-Message-State: ACgBeo0R9s6UhbpKHEJZT9QRhwwjVdqIflKl7AFftCtEs+g24m8IhOim
        wiBh7BxKo2vTKKOB83QKQRxHZqcQ5bXsihQ=
X-Google-Smtp-Source: AA6agR7HjRyExJ6lrTsRKgDm+dxDOHkPWEtM1slGQjLq/jBk6YXW5c/380xvW3vK7Nmv/VqCsFJ2l8spomHIhBxm
X-Received: from joefradley-custom-96.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:831])
 (user=joefradley job=sendgmr) by 2002:a05:6a00:13a2:b0:537:159c:4413 with
 SMTP id t34-20020a056a0013a200b00537159c4413mr3998928pfg.8.1661314777635;
 Tue, 23 Aug 2022 21:19:37 -0700 (PDT)
Date:   Tue, 23 Aug 2022 21:19:33 -0700
Message-Id: <20220824041933.822838-1-joefradley@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v2] tools: Add new "test" taint to kernel-chktaint
From:   Joe Fradley <joefradley@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        skhan@linuxfoundation.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        corbet@lwn.net, Joe Fradley <joefradley@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
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

Commit c272612cb4a2 ("kunit: Taint the kernel when KUnit tests are run")
added a new taint flag for when in-kernel tests run. This commit adds
recognition of this new flag in kernel-chktaint.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Joe Fradley <joefradley@google.com>
---
Changes in v2:
- based off of kselftest/kunit branch
- Added David's Reviewed-by tag

 tools/debugging/kernel-chktaint | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-chktaint
index f1af27ce9f20..279be06332be 100755
--- a/tools/debugging/kernel-chktaint
+++ b/tools/debugging/kernel-chktaint
@@ -187,6 +187,7 @@ else
 	echo " * auxiliary taint, defined for and used by distros (#16)"
 
 fi
+
 T=`expr $T / 2`
 if [ `expr $T % 2` -eq 0 ]; then
 	addout " "
@@ -195,6 +196,14 @@ else
 	echo " * kernel was built with the struct randomization plugin (#17)"
 fi
 
+T=`expr $T / 2`
+if [ `expr $T % 2` -eq 0 ]; then
+	addout " "
+else
+	addout "N"
+	echo " * an in-kernel test (such as a KUnit test) has been run (#18)"
+fi
+
 echo "For a more detailed explanation of the various taint flags see"
 echo " Documentation/admin-guide/tainted-kernels.rst in the Linux kernel sources"
 echo " or https://kernel.org/doc/html/latest/admin-guide/tainted-kernels.html"
-- 
2.37.1.595.g718a3a8f04-goog

