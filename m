Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09F84315C1
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 12:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJRKT3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 06:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhJRKT3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 06:19:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600AAC061714;
        Mon, 18 Oct 2021 03:17:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id gn3so6339786pjb.0;
        Mon, 18 Oct 2021 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dE6BUNlKRDvrvUFU8xRZqRqp//ji4VPYoEE3V4V54Q=;
        b=fTEPapMgeDiTfjV3QdmIWxED8L1NWasC7hPgVgsZSQZoLhhmdePkRAEyzfM0aG6SrK
         DMMj0KkOK0SRfNd3DMyjVYIfYQ6XXO0hnSJyyCGxzuL/uWsdcXwWPnc3tksqQG8TEeV+
         pGijcP/1zOb/iHOtsC1Od8DO6+baLo4sOq/lAvdY6j7wdT4vFJ9qxMmHhi0slM67owMz
         IpkUEiKR1bP93G/em0Lz0KDU6hQRD5Yo5B+zBa+2DYBcemEvgCjTRqJVODsLiG8sA0Rc
         FLE7YaEfoFn6/9P3QTDNd4k1zzV2XauI7efpPuQF0i7xpvoF2A2d1g4AbG6rBGmNW7lR
         HWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/dE6BUNlKRDvrvUFU8xRZqRqp//ji4VPYoEE3V4V54Q=;
        b=mS+0+frUFJobpt1MwlWEbGSlSyVlpsOi4lWOD2hXaU6C7VtEHp2OJnt+g6WrORPcwX
         B+/2VaJKL/F40xtm4CsXMVxuCL5Q/MNs0t4R2OJthyYO4As3nVpoWE8takcDXeY+8TNM
         46ZyEYnipgwBEhpi1GCkJuJf6vBsL6lpPOp4EL4rIBvAzSa9J3t9pvbZmETc9S6AFOxN
         a74iZZ4HcJiZeVi9s3kV8nP/dHprxv+AGCShlPS6NcdCoFBHGA9UcUqYKE1pKBBaMSFG
         k+JCjk/LZ/bMldN0GPZaV6UN2Th7F3sL1DGEufB41W6a+N522gXuiB2u4+OLDt67fSi8
         38oQ==
X-Gm-Message-State: AOAM5332JRdCf6+N8jTFVuIb/OJw/BVbd6M2FvlRMUv306Eqgf391/VD
        peWuraUph87fmCsiNC8uGdM=
X-Google-Smtp-Source: ABdhPJwhKSJJMqaSV58YYFiyzv2RbJrZV+ulj8VgnQy2HskQ06jK6Y9SzakQgQlifX0FHP0+0G9H9g==
X-Received: by 2002:a17:902:8605:b0:13f:7c1d:56d1 with SMTP id f5-20020a170902860500b0013f7c1d56d1mr25078429plo.57.1634552237973;
        Mon, 18 Oct 2021 03:17:17 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y24sm13465958pfa.118.2021.10.18.03.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:17:17 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH]mm: remove duplicate include in hugepage-mremap.c
Date:   Mon, 18 Oct 2021 10:17:13 +0000
Message-Id: <20211018101713.868496-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ran Jianping <ran.jianping@zte.com.cn>

Remove duplicated include 'fcntl' included in
'/tools/testing/selftests/vm/hugepage-mremap.c'is duplicated.
It is also included on the 19 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ran Jianping <ran.jianping@zte.com.cn>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index e84b79922fe6..6fa6ac423cf1 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -16,7 +16,6 @@
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/mman.h>
-#include <fcntl.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
 #include <sys/syscall.h> /* Definition of SYS_* constants */
-- 
2.25.1

