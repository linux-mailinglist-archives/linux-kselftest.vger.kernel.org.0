Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2C555B110
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jun 2022 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiFZKQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Jun 2022 06:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiFZKQB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Jun 2022 06:16:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED51120B3
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jun 2022 03:15:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b7-20020a256707000000b00669b4b2c5daso5902768ybc.1
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jun 2022 03:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=A6ULT6qt3Y8m7tER4ibPrZPKIE4ZaUO512mygVxvB7M=;
        b=EWyKT6lVXQco7x0/YZIBkhh6XaHBmrYABXmXYWxpobNTufTvVuAh6R/hGaomB0gbk9
         MoDhbR6pLqoqhC0NtIrOylctzuk6nPlCi1SMitw8nT9b8tSsOKzQkzZCf6y9QyjNGyXf
         71YVbB+DiRPc7Rl/6UOPfPcl3n5D2XcNWbSEoNL+j9fL8ToVqSd77/n1ioORc/bfKoiv
         2ud53+X8DXDdazBwA7IHj7f6E+V5D21cZhmhRR0IWPkZ/FLATABE8cPEtJ7J/Ngp/NJz
         Lf66maTxduZrOD6INDIZqgVwS/MOeXOMPx/FNSfvlDXT6OOJXSHseDvPC63ceiCvfyrP
         HY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=A6ULT6qt3Y8m7tER4ibPrZPKIE4ZaUO512mygVxvB7M=;
        b=QP9vjx12zaIbADdcqZiuAnKbJH2g4BMFsmLhmuazDHxTGkftFoDqpEaHxbOS9Eg9m9
         6t9H80Xpu88WGdix/L/uxNTC4cTlUojnkXsyk+iY42iJ2mylirbugBkd464OoLcVH4/j
         tKl8O7iwkZC+2rprRDMCuFLS/4hA4WGFP0iBRRuxieTrRaUDAkIo0mpzZfJnz87ToweC
         20QekWYPNKgMj1CYv8pgKdATmD/uhfP4PLk3T6N05Hd5QttAQYxll/wa3csjc/9xHYz8
         WQh3bVP/iqbJZWRZqBStiakuV6lF1SLiHN7ZXXFym6+Yik5yCpvFx/heJWvfuDRXiZGb
         88eg==
X-Gm-Message-State: AJIora/do4QFOHTw3USn3vqwG419/04XHbNV3DI43JS8rbZeCvMKD6aS
        nr8jZ+lodESBOX4hP27/mEQERbvmsv2W8A==
X-Google-Smtp-Source: AGRyM1vCFOBXMZXYd2wjunuMNSNfbqV2Qv5fUQ3A41LP1Ll6863YkjO7hQah6BirT2fg3gXJc6cEcx8GXwqnqA==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a25:a08c:0:b0:66a:a7c3:d5a with SMTP id
 y12-20020a25a08c000000b0066aa7c30d5amr8229590ybh.82.1656238559009; Sun, 26
 Jun 2022 03:15:59 -0700 (PDT)
Date:   Sun, 26 Jun 2022 18:15:53 +0800
Message-Id: <20220626101553.1885428-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] Documentation: kunit: Cleanup run_wrapper, fix x-ref
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The "Run Tests on qemu" section of run_wrapper.rst had a few issues left
over from the last big documentation refactor[1]:
- It referenced a run_uml.rst page, which was integrated into the other
  pages (including run_wrapper.rst).
- It skimmed over the use of --arch= and --cross_compile= in favour of
  using a custom --qemu_config. Since most users will want to use the
  former, let's give examples.

Remove the reference to the non-existant page, and add a couple of
examples to encourage the use of --arch= and --cross_compile=.

With this change, there should be no more broken references in the KUnit
documentation (i.e., the one mentioned in [2] is gone).

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=46201d47d6c4be594c1d57b7f3251c371626a9c4
[2]: https://lore.kernel.org/linux-doc/cover.1656234456.git.mchehab@kernel.org/

Signed-off-by: David Gow <davidgow@google.com>
---

Thanks, Mauro, for noticing this in [2]: for whatever reason my version
of Sphinx wasn't warning on it.

Unless anyone objects, I'll add this to the list of things to be taken
in via the kunit/kunit-fixes tree.

Cheers,
-- David

---
 Documentation/dev-tools/kunit/run_wrapper.rst | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 653985ce9cae..a695f58cd64e 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -192,6 +192,20 @@ via UML. To run tests on qemu, by default it requires two flags:
     if we have downloaded the microblaze toolchain from the 0-day
     website to a directory in our home directory called toolchains.
 
+This means that for most architectures, running under qemu is as simple as:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --arch=x86_64
+
+If a special toolchain is required, it can be slightly more complicated:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run \
+		--arch=s390 \
+		--cross_compile=s390x-linux-gnu-
+
 If we want to run KUnit tests on an architecture not supported by
 the ``--arch`` flag, or want to run KUnit tests on qemu using a
 non-default configuration; then we can write our own``QemuConfig``.
@@ -214,9 +228,6 @@ as
 		--jobs=12 \
 		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
 
-To run existing KUnit tests on non-UML architectures, see:
-Documentation/dev-tools/kunit/non_uml.rst.
-
 Command-Line Arguments
 ======================
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

