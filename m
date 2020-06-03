Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873ED1EC7D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 05:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFCDhb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 23:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgFCDha (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 23:37:30 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F69BC08C5C1
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Jun 2020 20:37:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g15so1913158ybd.20
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jun 2020 20:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FsWqk4JcMUkanVuZpVmCgmQIB+DqTVnxIfhOfOsqCOo=;
        b=c999EjRT/7Z15PIXCNfzhP8YEo6EHnSk7cw1vtvkJ8G5sm28ldvUj1p33b2yvpelJt
         HpaHcO4AVGCgEx6+pQRXC8TdIXrZVfUGyLwn4bO20stfPkvxVzLvXY7N4DHK332AVxyA
         ZpPQKS1NfVE1pbRWEKxOIigceruxy94QDofqCuWy53fkLeBfEhx2shHQl54HO1wMXWw9
         8EbLTZQJg/cjVRTHLB1dXFs41FxDDB5dCNo5XKPYrjMqa3oZNYa/L2JHNhKUDiy+wIkO
         x9I2JQMBN4It0P8wukaoRLq9+dvFf/i3EJ5xX2VcIE6roAbGT77r3xQ53GGuQK1CAGqF
         tmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FsWqk4JcMUkanVuZpVmCgmQIB+DqTVnxIfhOfOsqCOo=;
        b=Aot8erKz/N5JopKWL6RPXPHEsbMTsH/fhYa/Hr4UbK4rD67QNA1Cq5fS6IIFIz4Hdz
         8mJ/yJ+HsWF8WSNCvF1sPzhWcunnePVH9IRcXIDA7I5eBqmOWELKjYio6JXd7/WTE8B+
         9hQQqfvySgU+xl3PI0Vx0hEr69iDoidxgMduwqDP2FXM0NhNZx7g78b+5rpbBqpukqGl
         VMk7zOHqp5d1xdaweUOlNWwXiwBIyiJFJnzS1zdX525a+J1EKrBb8fwrSB1jE9FA4/Xu
         miruJrPlJ8IFpg467HIvxRJBqYYbmcIhnkuFVPH98JNPgzfuEAVi3dK0nUa4Rdcf4FmL
         raWQ==
X-Gm-Message-State: AOAM532EGQ9CvAyUaGAIGjETuvMqK0W4a8GzpmAdOLvUG+4v5k+OFQz5
        TiK9cmlnBTEJpmqDzhjD4Tlq113ItvkDcQ==
X-Google-Smtp-Source: ABdhPJw1G4qnz/p2gcQoZLNm+pBZHUKz67lhSOqRhS2g/W8ZuvsPK9fKJbB+YgtSezGeuUEgjafhMA1rAVSpdg==
X-Received: by 2002:a25:d28d:: with SMTP id j135mr43629717ybg.208.1591155448553;
 Tue, 02 Jun 2020 20:37:28 -0700 (PDT)
Date:   Tue,  2 Jun 2020 20:37:25 -0700
Message-Id: <20200603033725.25460-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH v2] Documentation: kunit: Add some troubleshooting tips to the FAQ
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
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
Changes since v1[1]
- Added a section about running KUnit outside UML (based heavily on
  Alan's suggestion in the thread).

[1]: https://lore.kernel.org/linux-kselftest/20200602054216.93122-1-davidgow@google.com/


 Documentation/dev-tools/kunit/faq.rst | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/dev-tools/kunit/faq.rst b/Documentation/dev-tools/kunit/faq.rst
index ea55b2467653..1628862e7024 100644
--- a/Documentation/dev-tools/kunit/faq.rst
+++ b/Documentation/dev-tools/kunit/faq.rst
@@ -61,3 +61,43 @@ test, or an end-to-end test.
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
+5. Try to run ``make ARCH=um defconfig`` before running ``kunit.py run``. This
+   may help clean up any residual config items which could be causing problems.
+6. Finally, try running KUnit outside UML. KUnit and KUnit tests can run be
+   built into any kernel, or can be built as a module and loaded at runtime.
+   Doing so should allow you to determine if UML is causing the issue you're
+   seeing. When tests are built-in, they will execute when the kernel boots, and
+   modules will automatically execute associated tests when loaded. Test results
+   can be collected from ``/sys/kernel/debug/kunit/<test suite>/results``, and
+   can be parsed with ``kunit.py parse``. For more details, see "KUnit on
+   non-UML architectures" in :doc:`usage`.
+
+If none of the above tricks help, you are always welcome to email any issues to
+kunit-dev@googlegroups.com.
-- 
2.27.0.rc2.251.g90737beb825-goog

