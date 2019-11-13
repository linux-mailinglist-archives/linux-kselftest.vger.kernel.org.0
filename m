Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21BFA020
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2019 02:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfKMB2f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Nov 2019 20:28:35 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47495 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726936AbfKMB2f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Nov 2019 20:28:35 -0500
Received: by mail-pf1-f202.google.com with SMTP id w16so275771pfq.14
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Nov 2019 17:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jKMqCQFEoSSTJ2SShJNtFv+iwOoSX52Fh5gJat66tHM=;
        b=hlsLs9h9D517WqWNmk3xWR52I1v68oK+sW9Wnfji3t5BOWHYMVK1woSQDT/LRD+Ecl
         bUwDdcScSuMkkgWV0nngRuhSBn0nRfX4Ky8i6HsrWMWc7coSO+MxtGdbZBAzGjjrm48j
         G9MlsV8nUNHSjvQL27HtJNSRm49r8bStInCo4cibWgvj/irzj5Ojh/zhr0doDNysZYiR
         1J+//S0frymecb+lIFxoimztvAzM0apP/Z8uQn6+QRDj58TCWJj5c0IN8cYFkJ3Hv64d
         fzRCE3z/Cla32108uLOMomqIBmeSkr/yf0t21/rjfNVO8CWo/Qq/Iya0zpivE3FmLX7Z
         7IYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jKMqCQFEoSSTJ2SShJNtFv+iwOoSX52Fh5gJat66tHM=;
        b=RlYTpqREpzMmPincLYJ79CxQ8YQRL+P5uO2eFlsvt2RdX0YJyvBs217VJx0QkdUSh2
         UCAdkOpn+7Zyl93nqAMQEEAzbkL+Rr5r3IcrtLoSgAqN16CW9KzBKv6ItdErobkJHYVx
         vGp1JT5Iv9MJHj2y7jb9bmqM2NW7SvY9HayqWskn5D0n4DVN3B9UQS1c9IrlgHnzOMfi
         Os6tEFe2W6/mCrUj+G++rzcX8X49kyUMQ/ZutZF9gRbYqKMe+LWV/MG2CExzTjWaU5jN
         XbNgF9yNMEufYkPty2yIU9i/NBTOlj5Ee6K0O1p7KHEH4YZzBCERxR3q5GWHZOAJvjE1
         Xtcw==
X-Gm-Message-State: APjAAAWZ6YfqMmAQdYsBdP/FKzqYwn+RrfmnyMRw4xUJHAxqOoRfbvvS
        QGm62BylxZ64wIL8Z2AdcDfFwPvUNYtsXjdSgUxFSw==
X-Google-Smtp-Source: APXvYqxc44Q6R+YXNLRxByMsegXzjdrZQJG4+hZKKdy8MCZim9YpQRM2AB9iS/NNXnkicVFZbuInpqJMFKxfkGR+XF2hZg==
X-Received: by 2002:a65:4085:: with SMTP id t5mr580684pgp.335.1573608512964;
 Tue, 12 Nov 2019 17:28:32 -0800 (PST)
Date:   Tue, 12 Nov 2019 17:27:46 -0800
Message-Id: <20191113012746.52804-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH linux-kselftest/test v1] Documentation: kunit: add
 documentation for kunit_tool
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, tytso@mit.edu,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add documentation for the Python script used to build, run, and collect
results from the kernel known as kunit_tool. kunit_tool
(tools/testing/kunit/kunit.py) was already added in previous commits.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 Documentation/dev-tools/kunit/index.rst      |  1 +
 Documentation/dev-tools/kunit/kunit-tool.rst | 57 ++++++++++++++++++++
 Documentation/dev-tools/kunit/start.rst      |  3 ++
 3 files changed, 61 insertions(+)
 create mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 26ffb46bdf99d..c60d760a0eed1 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -9,6 +9,7 @@ KUnit - Unit Testing for the Linux Kernel
 
 	start
 	usage
+	kunit-tool
 	api/index
 	faq
 
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
new file mode 100644
index 0000000000000..aa1a93649a45a
--- /dev/null
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=================
+kunit_tool How-To
+=================
+
+What is kunit_tool?
+===================
+
+kunit_tool is a set of scripts that aid in building the Linux kernel as UML
+(`User Mode Linux <http://user-mode-linux.sourceforge.net/old/>`_), running
+KUnit tests, parsing the test results and displaying them in a user friendly
+manner.
+
+What is a kunitconfig?
+======================
+
+It's just a defconfig that kunit_tool looks for in the base directory.
+kunit_tool uses it to generate a .config as you might expect. In addition, it
+verifies that the generated .config contains the CONFIG options in the
+kunitconfig; the reason it does this is so that it is easy to be sure that a
+CONFIG that enables a test actually ends up in the .config.
+
+How do I use kunit_tool?
+=================================
+
+If a kunitconfig is present at the root directory, all you have to do is:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run
+
+However, you most likely want to use it with the following options:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8
+
+- ``--timeout`` sets a maximum amount of time to allow tests to run.
+- ``--jobs`` sets the number of threads to use to build the kernel.
+
+If you just want to use the defconfig that ships with the kernel, you can
+append the ``--defconfig`` flag as well:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=8 --defconfig
+
+.. note::
+	This command is particularly helpful for getting started because it
+	just works. No kunitconfig needs to be present.
+
+For a list of all the flags supported by kunit_tool, you can run:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --help
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index aeeddfafeea20..1535c4394cfa2 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -21,6 +21,9 @@ The wrapper can be run with:
 
    ./tools/testing/kunit/kunit.py run
 
+For more information on this wrapper (also called kunit_tool) checkout the
+:doc:`kunit-tool` page.
+
 Creating a kunitconfig
 ======================
 The Python script is a thin wrapper around Kbuild as such, it needs to be
-- 
2.24.0.432.g9d3f5f5b63-goog

