Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA1345AD8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Nov 2021 21:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbhKWUt4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 15:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235790AbhKWUt4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 15:49:56 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD524C061714
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Nov 2021 12:46:47 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a23-20020a62bd17000000b004a3f6892612so219231pff.22
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Nov 2021 12:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=UhzMC3gbpAhepjgGNXDGMQ9GMejl51H6Lr8A14dJ5WE=;
        b=A7Kq8VbNSvNKQE0EZ9WZyxUdcgsFAVwWgZbwDSqpOLFFET3/Q7BZ8cLiG1wFxadg0W
         ueej/38HwlGhbYGNBTuoLGi+5DGb+YanH6H1YXuou3OyfA9mTyRzK+K1K6h4Gi3IZqpA
         ZOheDpT/zyvOzIo2gKXo93/nPLpWB36WqBFqDuyAMzQUmwpqF4ZmurQ70oZ6eLpnSAJ7
         9Nkt9vmaedplWbz7IrDOJuNXT41bmk506mhzG3Pmx0f5myqN/MOTL2BslJ1pNY/1yEo1
         QC6pGUME+FRUx9iBDGFDPED7FdvUaOAgricu807+2Tn/kcaJYMk0qbfPyhISJVQiwfm7
         yfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=UhzMC3gbpAhepjgGNXDGMQ9GMejl51H6Lr8A14dJ5WE=;
        b=cSRnlpdPMq1wintHU3C8emTWlww13R4aW4bb2amopR8VBSVA8lun1ov7/8U3HI14nL
         wusz9tCsSuoWia8mbG8t2Ln9cWF+SKmTmtaEu4Jlw16Uq0mH+BILBhM8UnTIp5DtmKUo
         AHF06FN8FDsDYUgZTKXazd0hdeFTPc74D7pDemWHriP9XYzZRm27cZQM15VrgJBKBFuN
         1fD/vWEPhEgotbXthpnRcFpwqISabzGTSVYICRiuMbUzHtB9nm7H62KbOdxGVNoImVxf
         Ik5KQncXBrvlIvg+MuJQY9fRSJHhl/aFRFhrnDMj+aYTkv3vjT/n5YzJmie6uwny3GBX
         67yA==
X-Gm-Message-State: AOAM532/qvvampPIWqFzt2PqGHo0FAHtVL889RR3orvPoF6tVA6m28ii
        xt2tQwFqZaz+F8FFanxvuL/rr+xts21SN4Ef
X-Google-Smtp-Source: ABdhPJzB5qfoeMNXtsmN+t/EQtIL+awdoz0JM1gizNNZ15PIzzNjopwIwclnBVASYK+9+0A9FmUuHSa007j3Z+GI
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP
 id u7-20020a170903124700b00143b9b952a2mr10645431plh.35.1637700407314; Tue, 23
 Nov 2021 12:46:47 -0800 (PST)
Date:   Tue, 23 Nov 2021 20:46:44 +0000
Message-Id: <20211123204644.3458700-1-yosryahmed@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH] mm, hugepages: fix size in hugetlb mremap() test
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The hugetlb vma mremap() test mentions in the header comment that it
uses 10MB worth of huge pages, when it actually uses 1GB. This causes
the test to fail on devices with smaller memories.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 257df94697a5..551e68f97926 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -18,7 +18,7 @@
 #include <linux/userfaultfd.h>
 #include <sys/ioctl.h>
 
-#define LENGTH (1UL * 1024 * 1024 * 1024)
+#define LENGTH (10UL * 1024 * 1024)
 
 #define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
 #define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
-- 
2.34.0.rc2.393.gf8c9666880-goog

