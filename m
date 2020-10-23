Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC41296895
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 04:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374728AbgJWCpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 22:45:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50190 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374725AbgJWCpu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 22:45:50 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kVn5P-0006lc-P7
        for linux-kselftest@vger.kernel.org; Fri, 23 Oct 2020 02:45:48 +0000
Received: by mail-pf1-f200.google.com with SMTP id g24so2568760pfo.1
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Oct 2020 19:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w+LvmvsmtGzZ1uHzJzeUdiay07yaHYmlemmh1WTIDHI=;
        b=jxOR4WHbU6RNYgYsl/4hWi0jhYl7yZUUli1ScZRnZ3C+zr4eVKaDANakmSfD/LfhNW
         T4WZjEJRdMpmIWzWZZ+Qu0E11ak5vzFeoKxOVzH6uYrwQlZP+eqHX4w0rx06ZA5QveOe
         C2aXQzqc0EG5Xip4ixTpQqjfcwpMQVBpQisqTNA08Gwy17BFl5VvpNqvzI5eYKVArqW5
         AklvirSYfkaT4kDfnJ9U6/7QXycsQdYsVwWvO5iBz8b+OXMbH4Kz9xDBmYd0ZaWOZSma
         I9LhlFg8FWmybBJ5yFwQtxe/sIbOi/iDa1bEo1dLs44S/97AjwXtttyBv1mlY2k3o3F2
         HVaQ==
X-Gm-Message-State: AOAM533KOikAibQVKB4vPFL76nTWtZjjg0xnBGK+aCJZk/jIzbhCHUDQ
        3wBvCZlpcuJ/Fr2lyZ8zJdVz+EXq8mPd/q4EOBBIDTzHqDCuphSsAliXsPpNGUoibW5XQfi8lrU
        VznuWIARWfLKjxCu67LBCDFk5JZsadRRoDRqCxN8V6DDa
X-Received: by 2002:aa7:93b6:0:b029:155:3b0b:d47a with SMTP id x22-20020aa793b60000b02901553b0bd47amr43913pff.47.1603421146345;
        Thu, 22 Oct 2020 19:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv5aNbWQd3UURPz7hMTf6/sNTaQY+8/+utv3JQsZSdOZBhomxuettop494BLNfghDk6NDxdA==
X-Received: by 2002:aa7:93b6:0:b029:155:3b0b:d47a with SMTP id x22-20020aa793b60000b02901553b0bd47amr43896pff.47.1603421145874;
        Thu, 22 Oct 2020 19:45:45 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id b10sm101465pfr.135.2020.10.22.19.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 19:45:45 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, mpe@ellerman.id.au
Cc:     po-hsu.lin@canonical.com, benh@kernel.crashing.org,
        shuah@kernel.org, mbenes@suse.cz, joe.lawrence@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: [PATCHv2] selftests/powerpc/eeh: disable kselftest timeout setting for eeh-basic
Date:   Fri, 23 Oct 2020 10:45:39 +0800
Message-Id: <20201023024539.9512-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The eeh-basic test got its own 60 seconds timeout (defined in commit
414f50434aa2 "selftests/eeh: Bump EEH wait time to 60s") per breakable
device.

And we have discovered that the number of breakable devices varies
on different hardware. The device recovery time ranges from 0 to 35
seconds. In our test pool it will take about 30 seconds to run on a
Power8 system that with 5 breakable devices, 60 seconds to run on a
Power9 system that with 4 breakable devices.

Extend the timeout setting in the kselftest framework to 5 minutes
to give it a chance to finish.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/powerpc/eeh/Makefile | 2 +-
 tools/testing/selftests/powerpc/eeh/settings | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/eeh/settings

diff --git a/tools/testing/selftests/powerpc/eeh/Makefile b/tools/testing/selftests/powerpc/eeh/Makefile
index b397bab..ae963eb 100644
--- a/tools/testing/selftests/powerpc/eeh/Makefile
+++ b/tools/testing/selftests/powerpc/eeh/Makefile
@@ -3,7 +3,7 @@ noarg:
 	$(MAKE) -C ../
 
 TEST_PROGS := eeh-basic.sh
-TEST_FILES := eeh-functions.sh
+TEST_FILES := eeh-functions.sh settings
 
 top_srcdir = ../../../../..
 include ../../lib.mk
diff --git a/tools/testing/selftests/powerpc/eeh/settings b/tools/testing/selftests/powerpc/eeh/settings
new file mode 100644
index 0000000..694d707
--- /dev/null
+++ b/tools/testing/selftests/powerpc/eeh/settings
@@ -0,0 +1 @@
+timeout=300
-- 
2.7.4

