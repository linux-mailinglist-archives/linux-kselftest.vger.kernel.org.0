Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42C3F45D6
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Aug 2021 09:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhHWHff (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Aug 2021 03:35:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:47410
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234993AbhHWHff (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Aug 2021 03:35:35 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5CF124075F
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 07:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629704092;
        bh=vpW+MmQwHzNcx/1v6dYqOYxABjq4D11QeSkA/JaBIuk=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=A+Oc9jNHMg86wkMYTdHM/gFMVeTHhsUr8T+vIjDhtVUMdjcBGzGEinslIoQ+qohVc
         niKRP9A+nACUHXQhDXaXaBopQzWoXV0byVqvrgof3aCyxoBsYkvpL8QO0QwMGi+ISZ
         NoGtyBrJnS6QSSFFaf3nUGLSR9Iwvmvjp7utRTf5u0/qCh8IHK53Uc30foLcQ6Ucn3
         QWX7Ip4FRW7pR3z3SjYdHSmuRJ/Vx8OY8U+zu3S3dloQE1CLkbhSX76EDN9mRbhOyx
         JCoNP8jkzaub8hUpKls+SHwMIJiU2ART4/v4XA9sleBGN3Sx7llg2tFiivrT8KPbi2
         AOWxOyJcNxXPQ==
Received: by mail-pg1-f197.google.com with SMTP id z19-20020a631913000000b00252ede336caso1985196pgl.4
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Aug 2021 00:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vpW+MmQwHzNcx/1v6dYqOYxABjq4D11QeSkA/JaBIuk=;
        b=HstRS1xcG70qRbm307txXiWFrSfMAnPcxKkgzbs7jtN3hyto/aGA+khMi94khMkVUr
         AAicY7x8IKwcYzQfVJGzM9Efas03d6uaR/CegdwP2fTz4sT++6ryQK1c529wVXPX8V+n
         UqkvuDZjY41cNtHE0382issaoYBtvV1yeUSIvZZ5H6/IF15bSUhkvIaLNtDIkDLMuvqO
         AvxswiBbBG6DlFLYnp2eNnFtYjIJ1NjBDDiXbGOYLxzBKsxM25kS96S6Ct7qoWt09Jl6
         1NYylnXg5X3euhv8gFb4vRUuZBGkytv6z4fcq4ZNFnydXUgzuRpMdgmj6N89gBGryzDZ
         hzZQ==
X-Gm-Message-State: AOAM5312czSSbYUpduiFb6NM0OapUKqAWPoDLNze1sZybqiWNWUKChYd
        bBMbRftFuVnuRr9VUbA4L2swl1CxuTGk12lqpCJWFl7N6CEDOB5GNXxhhc+ZYvpisBjGYVts3hD
        IPkZdkZBC07Cnx4bpyCAjslm4q6rczDnrcKFh0Mlr1XeE
X-Received: by 2002:a63:5d03:: with SMTP id r3mr30374606pgb.144.1629704090878;
        Mon, 23 Aug 2021 00:34:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLDs6LwEKpxKzmrkT2y3c9FukVNW8yy5ae0WiKKPyJAAGyulZ0vaYJ9HpM7spuQrBULhwB5A==
X-Received: by 2002:a63:5d03:: with SMTP id r3mr30374590pgb.144.1629704090541;
        Mon, 23 Aug 2021 00:34:50 -0700 (PDT)
Received: from localhost.localdomain (223-137-217-38.emome-ip.hinet.net. [223.137.217.38])
        by smtp.gmail.com with ESMTPSA id r14sm14939447pff.106.2021.08.23.00.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 00:34:50 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, skhan@linuxfoundation.org,
        po-hsu.lin@canonical.com
Subject: [PATCH] selftests/vm: Use kselftest skip code for skipped tests
Date:   Mon, 23 Aug 2021 15:34:33 +0800
Message-Id: <20210823073433.37653-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are several test cases in the vm directory are still using
exit 0 when they need to be skipped. Use kselftest framework skip
code instead so it can help us to distinguish the return status.

Criterion to filter out what should be fixed in vm directory:
  grep -r "exit 0" -B1 | grep -i skip

This change might cause some false-positives if people are running
these test scripts directly and only checking their return codes,
which will change from 0 to 4. However I think the impact should be
small as most of our scripts here are already using this skip code.
And there will be no such issue if running them with the kselftest
framework.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/vm/charge_reserved_hugetlb.sh  | 5 ++++-
 tools/testing/selftests/vm/hugetlb_reparenting_test.sh | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
index 18d3368..fe8fcfb 100644
--- a/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
+++ b/tools/testing/selftests/vm/charge_reserved_hugetlb.sh
@@ -1,11 +1,14 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 set -e
 
 if [[ $(id -u) -ne 0 ]]; then
   echo "This test must be run as root. Skipping..."
-  exit 0
+  exit $ksft_skip
 fi
 
 fault_limit_file=limit_in_bytes
diff --git a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
index d11d1fe..4a9a3af 100644
--- a/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
+++ b/tools/testing/selftests/vm/hugetlb_reparenting_test.sh
@@ -1,11 +1,14 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
 set -e
 
 if [[ $(id -u) -ne 0 ]]; then
   echo "This test must be run as root. Skipping..."
-  exit 0
+  exit $ksft_skip
 fi
 
 usage_file=usage_in_bytes
-- 
2.7.4

