Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C805EF0F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Sep 2022 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiI2I4c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Sep 2022 04:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiI2I4N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Sep 2022 04:56:13 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC4FEA599;
        Thu, 29 Sep 2022 01:56:05 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w10so689070pll.11;
        Thu, 29 Sep 2022 01:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=0cWeqUzaMnvJsketKHV5m3B9Lf16LWQNARMhtcdH+io=;
        b=ehTHs2nV2GGGpc0k4+HiEG1bx95nzdT2s331DZ53ruQ0ZAdVnTf+pwrWAAQa1b777K
         XRYdQFgOpO3383w0aBgNsnx5WdAUXVmbbYvSIJaehz+DXMUrhN9a1rcsjAB6MFm9fVm5
         q39KLk2CfeW/a9V0cyc3yzbq8yQ+UoREh8b52qfjCvSKNOkthgFbnPiso9CZ16MvnUKx
         nOf0jdfcOK+he1OtNeD9oIwPRSE8+D8/QzdhIFJKQfItQ4roErv2Z7mZqO9SP9AXbu4R
         QV1zZF/JyGfWAG+G3qhi9YveAfxW13b83+TktfrULAUW0lIS/I7+RjjZjCVawe/ZPp2u
         o9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=0cWeqUzaMnvJsketKHV5m3B9Lf16LWQNARMhtcdH+io=;
        b=AXhemCH8u2CWYbB8PWSInZ5aVgpjr2zt9ANxwam9tUlLNcPelu/jPxubfAbkGHPzLN
         oN6gI/ZMkd5ct0MCDKILG4nYz+0ibPnqdtPnjYped3zeFa1YavQtXMDv27+Iu6WVwDKK
         lMw9jsljiaUDZvRJl0B2VL+baw4oUYkFnIEG/030wl5OGhZ0NX69TGzrsaSFpWYXPS7e
         Jp60BT83IMKMN6dU8AU8JLixwEtRn/AtCkAM7wU5L+ly4st4WIpJLF6RyNhcOsVEsknU
         dFEybCWjI+DcxYdO1b1QyHHFkBSCHUzLCIAdiXL1hhQLlVRLf7XuWRw4JhmwVu0lTdtn
         ABvg==
X-Gm-Message-State: ACrzQf0a1Y05s/DuviInILi2EgsR5NzAlDBdd2EUQX1uGRBJsQNXJfkG
        lrcXVt5ufXizOWMpwtiWsnY=
X-Google-Smtp-Source: AMsMyM6nbIstL6rkLYMB924r1HlKquI+95HbQR8gQs/nzchuFmCdeeu8W7EsBEA182vfEHGRsbVEcw==
X-Received: by 2002:a17:902:ca01:b0:17a:487:d5f5 with SMTP id w1-20020a170902ca0100b0017a0487d5f5mr2451664pld.63.1664441764196;
        Thu, 29 Sep 2022 01:56:04 -0700 (PDT)
Received: from fedora.. ([103.230.106.49])
        by smtp.gmail.com with ESMTPSA id w16-20020a63d750000000b00439dfe09770sm4922796pgi.12.2022.09.29.01.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 01:56:03 -0700 (PDT)
From:   Khalid Masum <khalid.masum.92@gmail.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2] Documentation: Kunit: Use full path to .kunitconfig
Date:   Thu, 29 Sep 2022 14:53:32 +0600
Message-Id: <20220929085332.4155-1-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The fourth list item on writing test cases instructs adding Kconfig
fragments to .kunitconfig, which should have been full path to the file
(.kunit/.kunitconfig).

Cc: Sadiya Kazi <sadiyakazi@google.com>
Cc: David Gow <davidgow@google.com>
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
---
Changes since v1:
- Update commit message
- Make the instruction more descriptive

 Documentation/dev-tools/kunit/start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 867a4bba6bf6..69361065cda6 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -217,7 +217,7 @@ Now we are ready to write the test cases.
 
 	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
-4. Add the following lines to ``.kunitconfig``:
+4. Add following configuration fragments to ``.kunit/.kunitconfig``:
 
 .. code-block:: none
 
-- 
2.37.3

