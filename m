Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF43E4E7E31
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiCZAfk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCZAfj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 20:35:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8898D21F765
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 17:34:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e5db04460cso71936907b3.17
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 17:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=C7dMbml3WSQebbWw6NGPxmfuV7ri/a3Nzoj+G8yYBMI=;
        b=d8nP+2b1uGAGXGMvUnqLB8+Y34lm4z5ta+Dx/nWyUkg5Nk8Nr5hvblVJ5Amvv5JbbM
         8UzUDz7+iyr/l4XXNkeFhspC0LokUQnKtt4Un13iCxIqdPG6xdcMRNETArVDPVHn+lL7
         ZPnedwzy2NoxUVxD7+acT2ZnfpQbgD5dJTxBIkT2AMow8VgLyOT+UCUcOns6Gfm4OIS4
         chBINcQvyoxshZ3rnqPY4j78JNs8Cn7nINPbT0Sf68FPGWfRp3pdd2UQ36dV7e98J0KW
         8+nZkncbtbBUJAwhzESjJH5Y61tXU4fXKRKehzFJ1z8kW5HlBb5OYMNEG7LKX3bQiqc5
         uCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=C7dMbml3WSQebbWw6NGPxmfuV7ri/a3Nzoj+G8yYBMI=;
        b=ia0KRjg9sUwwOtqGV7s1R2ZjgeTazZOjdj5zZLPedwr4VogLcguUsvZuQ4HvWUBi0h
         u+iotEAwl3YoTqLz/tJJz4tpAekE9VInKiYm1Y1j5A1RFNEGQm1z1dXQ+4l7Fi13Oc8e
         0pWlWZgSpFOiDCZJLsjU3iLVQujd42Ta2AQc9v57i7ybQb1xfYLR7Pk9v9SA2QDxe6J6
         CVgVNnm1Tciups0h1v9yPS4uTJ/9QRUFpl/y0qoyni1afVvvrgnfroXyl3QfmHX8G/LX
         ZYs7pezY0ijLZ8pDodBOi/DaK+jcLq2hRvlxPYQyz+wu/l6nCQZLVFJhUDscEVi5WILX
         7lxQ==
X-Gm-Message-State: AOAM533SRdCNkUTlHXoqHeZUcefmB3jIHr1EKf8Iu5544jaI9NhcDIN/
        5RsM/WUILb3zy/dSZssuQRGDzDgwpGcJlw==
X-Google-Smtp-Source: ABdhPJx/3aUkebGQoOX/jm9fWIotMlnaay4/O3bwaTV1+wfuG9arENwwL+nbeyxXoh0LyEwRJ3SIvp/wl/3GRg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:be84:4a49:e731:f1fa])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1209:b0:637:cda:22c0 with SMTP
 id s9-20020a056902120900b006370cda22c0mr13018318ybu.358.1648254843840; Fri,
 25 Mar 2022 17:34:03 -0700 (PDT)
Date:   Fri, 25 Mar 2022 17:33:56 -0700
Message-Id: <20220326003356.487828-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] Documentation: kunit: update kconfig options needed for UML coverage
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        maxime@cerno.tech, Daniel Latypov <dlatypov@google.com>
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

Recent changes have made it so the current set is not sufficient.
Namely, CONFIG_DEBUG_INFO is not being set even when explicitly asked.

Specifying a version of the debug info fixes this.
Pick CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as an option that's
hopefully less fragile (esp. given we're tied to GCC 6 and lower).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/running_tips.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 7b6d26a25959..c36f6760087d 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -114,6 +114,7 @@ Instead of enabling ``CONFIG_GCOV_KERNEL=y``, we can set these options:
 
 	CONFIG_DEBUG_KERNEL=y
 	CONFIG_DEBUG_INFO=y
+	CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
 	CONFIG_GCOV=y
 
 
@@ -122,7 +123,7 @@ Putting it together into a copy-pastable sequence of commands:
 .. code-block:: bash
 
 	# Append coverage options to the current config
-	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
+	$ echo -e "CONFIG_DEBUG_KERNEL=y\nCONFIG_DEBUG_INFO=y\nCONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y\nCONFIG_GCOV=y" >> .kunit/.kunitconfig
 	$ ./tools/testing/kunit/kunit.py run
 	# Extract the coverage information from the build dir (.kunit/)
 	$ lcov -t "my_kunit_tests" -o coverage.info -c -d .kunit/

base-commit: b14ffae378aa1db993e62b01392e70d1e585fb23
-- 
2.35.1.1021.g381101b075-goog

