Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7331EB567
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 07:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgFBFm3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgFBFm2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 01:42:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6FFC061A0E
        for <linux-kselftest@vger.kernel.org>; Mon,  1 Jun 2020 22:42:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s90so9609058ybi.6
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Jun 2020 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bk5osaVJiGNv6HMFDDoa1BeWBizOC8AFnfdcBnX83HE=;
        b=MNwj43DNaxUfUwQ0rovjHIMZ1fTtleyHscFem2vWH5sI07j7Uv41fBVGKRbTXU0oWw
         j1F4Pwb5+/QYPcVef9jk/i96jtWKgFNe7jRGGUQ6bUOFkLugEihxCBRPmTWNOUioFbFe
         Bd8sM/zraHTpC736DqEwu7g+TQJW61V4ToQakrrYqLPOzbH64L+bUmz6QAUwBq47rLUd
         NhUQR19oBeZ+ny6qikeZL/jYnxwgLcDqHoIzqqLGOKfCg8+73A3BvSjxs7k/ppWJ8w/U
         U5xSqOSp4Tef13PWaNBeZ0un/Tk32Tc5lZ3FaTkFDgU2HKq6pLF+29weT6bmc/e6XCYt
         pofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bk5osaVJiGNv6HMFDDoa1BeWBizOC8AFnfdcBnX83HE=;
        b=dETe20MA1FOJy4NYsceBX8e3zsYYlyvZFK8vfmccnnthVrFlChwEv9RR5u3yfmf+by
         oRsZkTgloQjkiH12InZk8ypUJn+EdZNWB8DDpe9O9d9zVl/LkticA0+J/7BPCKpBuQaD
         hTvtxlq8Wrg5YiamFKV0qNbHD9y+6dc0Nhh4MX7TPelrcEjVnhRBiMV/YTtoFLoeW3jC
         FCpngNxLhl7ToDFvtS2gIn4S4A3wLL4/eD1iRbN4JfvqSeDWJoF2+Aszz4EbMjYCXmvH
         3QtHil6lyfx7JDPeBGXcjp+qkar7nM5NI8W2SHa5LGrvs5YyT9SAcBMt7J9BuDZ2O2n4
         rwSQ==
X-Gm-Message-State: AOAM532KeHmTr8DiVp2LpghZazjI5+D+PMKiAn1Uh9j+5gNFX4gFPKkl
        Sf4/JErXtIceT38AaMjGZuSJYl3lPbXMOw==
X-Google-Smtp-Source: ABdhPJx9vDHTXUY+CzoW3/vdoqwLoI1FfZ6/ud5mLimm+OjfZFVFhjoAVLYr/Go8lxvT6G+52qhwMG5A9nIiHQ==
X-Received: by 2002:a25:d295:: with SMTP id j143mr6686782ybg.65.1591076547649;
 Mon, 01 Jun 2020 22:42:27 -0700 (PDT)
Date:   Mon,  1 Jun 2020 22:42:16 -0700
Message-Id: <20200602054216.93122-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH] Documentation: kunit: Add some troubleshooting tips to the FAQ
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        alan.maguire@oracle.com, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add an FAQ entry to the KUnit documentation with some tips for
troubleshooting KUnit and kunit_tool.

These suggestions largely came from an email thread:
https://lore.kernel.org/linux-kselftest/41db8bbd-3ba0-8bde-7352-083bf4b947ff@intel.com/T/#m23213d4e156db6d59b0b460a9014950f5ff6eb03

Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kunit/faq.rst | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index ea55b2467653..40109d425988 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -61,3 +61,35 @@ test, or an end-to-end test.
   kernel by installing a production configuration of the kernel on production
   hardware with a production userspace and then trying to exercise some behavior
   that depends on interactions between the hardware, the kernel, and userspace.
+
+KUnit isn't working, what should I do?
+======================================
+
+Unfortunately, there are a number of things which can break, but here are some
+things to try.
+
+1. Try running ``./tools/testing/kunit/kunit.py run`` with the ``--raw_output``
+   parameter. This might show details or error messages hidden by the kunit_tool
+   parser.
+2. Instead of running ``kunit.py run``, try running ``kunit.py config``,
+   ``kunit.py build``, and ``kunit.py exec`` independently. This can help track
+   down where an issue is occurring. (If you think the parser is at fault, you
+   can run it manually against stdin or a file with ``kunit.py parse``.)
+3. Running the UML kernel directly can often reveal issues or error messages
+   kunit_tool ignores. This should be as simple as running ``./vmlinux`` after
+   building the UML kernel (e.g., by using ``kunit.py build``). Note that UML
+   has some unusual requirements (such as the host having a tmpfs filesystem
+   mounted), and has had issues in the past when built statically and the host
+   has KASLR enabled. (On older host kernels, you may need to run ``setarch
+   `uname -m` -R ./vmlinux`` to disable KASLR.)
+4. Make sure the kernel .config has ``CONFIG_KUNIT=y`` and at least one test
+   (e.g. ``CONFIG_KUNIT_EXAMPLE_TEST=y``). kunit_tool will keep its .config
+   around, so you can see what config was used after running ``kunit.py run``.
+   It also preserves any config changes you might make, so you can
+   enable/disable things with ``make ARCH=um menuconfig`` or similar, and then
+   re-run kunit_tool.
+5. Finally, running ``make ARCH=um defconfig`` before running ``kunit.py run``
+   may help clean up any residual config items which could be causing problems.
+
+If none of the above tricks help, you are always welcome to email any issues to
+kunit-dev@googlegroups.com.
-- 
2.27.0.rc2.251.g90737beb825-goog

