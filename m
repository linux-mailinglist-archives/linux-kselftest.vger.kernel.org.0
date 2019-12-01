Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A41610E3E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 00:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfLAXZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 1 Dec 2019 18:25:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37081 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfLAXZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 1 Dec 2019 18:25:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so10980386wru.4;
        Sun, 01 Dec 2019 15:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FiRRG2p82soPNqcF4uwVMsDMa1xe32ae/CmIwI9GvRo=;
        b=FXWEsZWqdM0HtJD58FCT1Rj1Z26liaQf4IqJUi0Rf6/xRzsjNfQoGS82ulaf5B/0qI
         JlPa24PjmqeVDfW5/SF/h0escIGncSAxheBfa7OjAodBAzG0b4e0EvSO3+h/DXvbR+ZV
         s2ko6DLc+iohdp/tfA+8KsoBrM0Y8DSeHf0VlMN1zmi0zTyEwaD8bYb+OmGwBgK858eU
         xTefMN4a/l1gEuC1lX+RlDuQy43HfpVdoyxKhet6PgkVoFbHxV9NUOG6iiWSYjb8Iudo
         nF4P2YPXFGxuFQRaNDX3fYrGKIY4BRKUaR2misvmIxWaQQu28lJn0mnWQ7suktB59Vlq
         xCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FiRRG2p82soPNqcF4uwVMsDMa1xe32ae/CmIwI9GvRo=;
        b=f/3lfktvE/OR5ByeWJDEt6MwiZIC4l1iaux7DM74cDkQSVHisFixbSPRTS4tmYxDQJ
         dDz7gqu6bCshKyhFPh4Tvm3kbn9YfwM2CDIbUcQu54vg5PZnixXAeSqtTybYTD6e26nl
         aMtCugTx99A17dUbJhiGn+lFdeSGRTWvdr6Fo+GRTuFEvFpn+u/gzXv8xeXZPK5ad8Ly
         GYY8kGTTxBqZK1as1eKm44Q0DGUBiLv2ZLSkvxZOComYrmIMIir3fsvzOfk3wSfJbAK6
         EicgAXN7ezpw729oicRvWUsuaWEb6Ts2CDnDl8qDreeKv42tBI5fd9VruMDHWFDHOmcJ
         GD9w==
X-Gm-Message-State: APjAAAXIroESDyiai7PWDWaXehPhcqDLC0bypHmhzTS0APcr/0/Et9aM
        AVLFoEUpFRe5fEyvL524428=
X-Google-Smtp-Source: APXvYqw0R3sFDkURJkd9Dz4MSbZHogznT9g0FuJ0XMlBrcykLtllZunRB4FDtIoRGmtGgER8S6VhIA==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr8853855wrv.358.1575242743809;
        Sun, 01 Dec 2019 15:25:43 -0800 (PST)
Received: from localhost.localdomain (cable-86-56-100-90.cust.telecolumbus.net. [86.56.100.90])
        by smtp.gmail.com with ESMTPSA id y6sm37450454wrl.17.2019.12.01.15.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Dec 2019 15:25:43 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     brendanhiggins@google.com, shuah@kernel.org
Cc:     corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: [PATCH 2/6] docs/kunit/start: Skip wrapper run command
Date:   Mon,  2 Dec 2019 08:25:20 +0900
Message-Id: <1575242724-4937-3-git-send-email-sj38.park@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

The kunit 'Getting Started' document first shows the wrapper running
command.  However, a new user who simply following the command might
encounter a failure like below:

    $ ./tools/testing/kunit/kunit.py run
    Traceback (most recent call last):
      File "./tools/testing/kunit/kunit.py", line 140, in <module>
        main(sys.argv[1:])
      File "./tools/testing/kunit/kunit.py", line 126, in main
        linux = kunit_kernel.LinuxSourceTree()
      File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
        self._kconfig.read_from_file(KUNITCONFIG_PATH)
      File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
        with open(path, 'r') as f:
    FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'

Though the reason of the failure ('kunitconfig') is explained in its
next section, it would be better to reduce any failure that user might
encounter.  This commit removes the example command for the reason.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/dev-tools/kunit/start.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 78a0aed..e25978d 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
 easily use and read KUnit output. It handles building and running the kernel, as
 well as formatting the output.
 
-The wrapper can be run with:
-
-.. code-block:: bash
-
-   ./tools/testing/kunit/kunit.py run
-
 Creating a kunitconfig
 ======================
 The Python script is a thin wrapper around Kbuild as such, it needs to be
-- 
2.7.4

