Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393EB5ED3BE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiI1EB0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 00:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI1EBW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 00:01:22 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6E17E27;
        Tue, 27 Sep 2022 21:01:21 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id b5so11139749pgb.6;
        Tue, 27 Sep 2022 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=2dGuShGJqjVxhZy9DhlIi4k5dtlUgw4YO+xFbiS+z1Q=;
        b=ZtAjMQNdst0bSoZkIUjj3nFTRVJy6Y8fMuzX2zNPl0D4xZtOFJwQIZZmL/se/J7h5I
         QQ0QoUPsyvbP4yLWYk4hdxrUeSvHcZGJQPMMPkxB11kF576hTmUWq9IhZuLIIMsOnwHy
         WLn6C2K6qIbE5a5PKAblI3c5ql2P/u4O2+gVGKjS8/1E2bSwabCcLPJNIdz6G9uvPFE6
         IlXavTjhfKMmwdIQMMD7inYu+aVvNEl7HyFZBkTRRs56OLDb+2iaFwz6BhDWSQZrnrZu
         EBXrVQaFeuo36tRM8qDqvQibCGd2JYbVwxAnDLrEDGKkxaGMs/BoPRmpKAr+vq8l/M47
         rPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=2dGuShGJqjVxhZy9DhlIi4k5dtlUgw4YO+xFbiS+z1Q=;
        b=X3mmPSKkwGnzZ70UMGMxHPnFwVy2BhJcdS0iEKEnQEw50v6N1RK5hrPeNawIsf5MUP
         xlP7aKWIEkVLWtR04ZLGoJTqilWNvzRpO61OQM2sqXgc7DbF+Vg5a/lVC4Lt3TA6Pt+x
         pdID8j9pU8Xq7BT6K8lNCSW4jTDlPgsDpfOamWEzwDy1EDLT7rNbepsy1YEfkuLOWQWI
         NV/5eBRf+euo9GJypfdKXfE1ZvNPeXqwX4F/8b9LoXHHaztPhOaf/4KoX+3LEs3QMK49
         YG4gGUX7UX03cfYIfDB/Vhqd0+sRivQVv3ZZghrBTXoxN8fStc+W8vts0lROnwpC+9b5
         8kCw==
X-Gm-Message-State: ACrzQf0Ue3ApzEo2vloLJrRgmeJonIplioLHJJA/EQbazClB0CIvEm6d
        7hiQcPw0qGA0dKojNjHue3M=
X-Google-Smtp-Source: AMsMyM4ePj6LHhM965i/Mvco2vo/HmGmi0UMJwElmb1gcknpsxkB+U8KHJghfGt6o057PNHA7amT7Q==
X-Received: by 2002:aa7:9605:0:b0:53e:8062:43fc with SMTP id q5-20020aa79605000000b0053e806243fcmr32780731pfg.39.1664337681307;
        Tue, 27 Sep 2022 21:01:21 -0700 (PDT)
Received: from fedora.. ([103.159.189.139])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0053e8fe8a705sm2756053pfj.17.2022.09.27.21.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 21:01:20 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>
Subject: [PATCH] Documentation: Kunit: Use full path to .kunitconfig
Date:   Wed, 28 Sep 2022 10:00:58 +0600
Message-Id: <20220928040058.37422-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The numbered list contains full path to every files that need to be
modified or created in order to implement misc-example kunit test.
Except for .kunitconfig. Which might make a newcommer confused about
where the file exists. Since there are multiple .kunitconfig files.

Fix this by using the full path to .kunitconfig.

Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
 Documentation/dev-tools/kunit/start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 867a4bba6bf6..69361065cda6 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -217,7 +217,7 @@ Now we are ready to write the test cases.
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
-4. Add the following lines to ``.kunitconfig``:
+4. Add the following lines to ``.kunit/.kunitconfig``:
 
 .. code-block:: none
 
-- 
2.37.3

