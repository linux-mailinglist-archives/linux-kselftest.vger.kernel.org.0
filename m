Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC79A444AE0
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Nov 2021 23:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhKCWdc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Nov 2021 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhKCWdc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Nov 2021 18:33:32 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E50BC06127A
        for <linux-kselftest@vger.kernel.org>; Wed,  3 Nov 2021 15:30:55 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id n13-20020a170902d2cd00b0014228ffc40dso699665plc.4
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Nov 2021 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iebf2W2QZ+CT/VCZU+Hm1RFCYYPaaTgdO1Vs4vFVk/g=;
        b=LJ5ydDCSfe34tiYb1rbrzNQ24lgoT6TOhnin7XQpu/6gmW1kRn4DkScXHuGgBkKCUq
         BkXZucHIe02xQdeU++xd4kRBgeMgmboKM7fXSDejgRwRmzYYjGZqgmpNaw6uzOqP1bZZ
         9tOuUWJ0axdnk88IW+OnOoVs8JaUOkAiOMMlwU6DRAqJuLIZ1NiEnpEsLhspJ/tdigaj
         E9R76pVGNNLPwhEw0rhCfK9skILdmPhjSWWcANMJxS6sbUZHC3eOBJGFyUWQ1q2A6Ger
         KMUfuh9T8BydYeUW+cjVSWIULMbeLTZba4zO5smWeyn88/aJcTURBZqw7C/X60OflDGY
         XsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iebf2W2QZ+CT/VCZU+Hm1RFCYYPaaTgdO1Vs4vFVk/g=;
        b=ZDEueK7RmhDEyKOs3aRWmQV7hU1GDfn3x/dqZWbOLYrhE0fPWGhIT+WTQg4QxZwybL
         twVI0PZlYCK1P3w/QHFulYMRvff9Cm6FSaxykGV1ABQbnnGiSpNEFkZp2SQipeE06Kqw
         XpAW5cm6oDq1S8LBSauY/rSjKDkL0M/5muzH55ZYIdAOln9WE2L0MpeSa3t21DlX6e+5
         wp6G9kS1sLRH2SyrNecGWZNb/8Ppzsh/mB6LR2NqF8MbIwcXZxHTNLkDdp0sJMbYZp5V
         CKEfj9WV1Mj/AAADA73Rk1z1A8uzIerPyliUevoNuLO4pHtlnKE6sQs1DDF1Sr6K7jd8
         o3+A==
X-Gm-Message-State: AOAM530pUnQDrC+AUb0tRZWqG3iOA6uMrVouiVtBu3WYpJlrlvHKBo3z
        k6giGjQYWMEREKRBMOoBhICguzi2CuTezA==
X-Google-Smtp-Source: ABdhPJwJIgl2hN2/bAUrlr4B5wueJajXtbw28t25Dj1nuV54iYV8938avoAn2/Ie+qSj5LLmk2ycxbYhH8OMbQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8673:8d2f:d693:6af])
 (user=dlatypov job=sendgmr) by 2002:a63:a319:: with SMTP id
 s25mr35997164pge.305.1635978655060; Wed, 03 Nov 2021 15:30:55 -0700 (PDT)
Date:   Wed,  3 Nov 2021 15:30:45 -0700
Message-Id: <20211103223045.725140-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH] Documentation: kunit: fix path to .kunitconfig in start.rst
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Yifan Yuan <alpc_metic@live.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
the default --build_dir, which had the side effect of making
`.kunitconfig` move to `.kunit/.kunitconfig`.

However, the first few lines of kunit/start.rst never got updated, oops.

Fix this by telling people to run kunit.py first, which will
automatically generate the .kunit directory and .kunitconfig file, and
then edit the file manually as desired.

Reported-by: Yifan Yuan <alpc_metic@live.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 1e00f9226f74..65f4ef6c1f4c 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -31,14 +31,15 @@ This file essentially contains the regular Kernel config, with the specific
 test targets as well. The ``.kunitconfig`` should also contain any other config
 options required by the tests.
 
-A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
+If you run KUnit, it'll generate one automatically for you.
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp tools/testing/kunit/configs/default.config .kunitconfig
+	./tools/testing/kunit/kunit.py run
+	cat .kunit/.kunitconfig
 
-You can then add any other Kconfig options you wish, e.g.:
+You can then edit that file to add any other Kconfig options you wish, e.g.:
 
 .. code-block:: none
 

base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
-- 
2.33.1.1089.g2158813163f-goog

