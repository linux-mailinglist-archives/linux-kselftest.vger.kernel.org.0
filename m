Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3C245B285
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 04:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhKXDUE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Nov 2021 22:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhKXDUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Nov 2021 22:20:03 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71E1C061574;
        Tue, 23 Nov 2021 19:16:54 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id m25so1289914qtq.13;
        Tue, 23 Nov 2021 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTp9yZLPAioGvr+AUfhjJxCDu9lVAek1x4B5RUtmqPw=;
        b=idantvmKEY5mzlBZUu5hJipAc4fwB3Qjt+8W4rDrxORm6ix8cGAHDyOCnRvkTen6FD
         C36Y9N/XjU1ZHW5S9KzIS/u77uw/FxOnC3JDCNgCADePTvkrv7v9ywTtZh7EIl9dXzpk
         R2Ry265R5byS71+65pJ9b0XbT30eHZW52jcY+OrJBfFmxyzoPrIbtlElY/vbfHYyQ8ep
         Iey87eFLOIzs9TMDkXk8NjgdHBmivB4zWevpO8o5GTa5w+bC6D4fcyIqK8m6UENWteOC
         nSpV0M6XCEyS36HGEjF5N2tij+rHqTyuS208oxOJWpuA/AXHq9omCoILaJS7wAtKvtYr
         pTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cTp9yZLPAioGvr+AUfhjJxCDu9lVAek1x4B5RUtmqPw=;
        b=7GWRydwCJV6TQaIFID41oDgo4Q427fa9OLBmHQjF8twL9smJj/W/hjE3UWfC8uHUdP
         4q7FY0rvPfwoytZ9AkCj3z7E14VRk0EgX1Sw1/yW7PiETJWm5mFdR8meoX5ux4XBguaK
         G8B75rrhL9lTAttm27dih+PVgVy7MGWpOGCZc3zTwg7p1lBgJbFDXzoRKH91KVxGjaBq
         AF+HR8X79qAc1Q8HkdpgzL2NLUSZIskwneF7hiUFiIVl3464sf1ZXYkyPKKBgz04V/pR
         jlwTqil9lFVDZHOdB+uC0vsip1weBD177MleUH59ppXQni/9cpp2HHBQeqXLJJ0/bvU4
         PSnw==
X-Gm-Message-State: AOAM530xUxpW+DIFzm4UuWMP9wzfy2Z5mLoagU7vUwXMod+/seAIgg6G
        U+NITag+ruFf9sogf9dzmv4=
X-Google-Smtp-Source: ABdhPJxI27GYfxwVe5N2/QtmsxifdzSx3qi4BT9bBjRKClUfabcC6peDTBh825e5skl+CK7EW76DFw==
X-Received: by 2002:a05:622a:144f:: with SMTP id v15mr2993881qtx.340.1637723814121;
        Tue, 23 Nov 2021 19:16:54 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id bj30sm7510823qkb.58.2021.11.23.19.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 19:16:53 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] selftests:vm: use swap() to make code cleaner
Date:   Wed, 24 Nov 2021 03:16:32 +0000
Message-Id: <20211124031632.35317-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: chiminghao <chi.minghao@zte.com.cn>

Fix the following coccicheck REVIEW:
./tools/testing/selftests/vm/userfaultfd.c:1531:21-22:use swap() to make
code cleaner

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: chiminghao <chi.minghao@zte.com.cn>
---
 tools/testing/selftests/vm/userfaultfd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 8a09057d2f22..dedbe9c9287e 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1413,7 +1413,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 static int userfaultfd_stress(void)
 {
 	void *area;
-	char *tmp_area;
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	struct uffd_stats uffd_stats[nr_cpus];
@@ -1524,13 +1523,9 @@ static int userfaultfd_stress(void)
 					    count_verify[nr], nr);
 
 		/* prepare next bounce */
-		tmp_area = area_src;
-		area_src = area_dst;
-		area_dst = tmp_area;
+		swap(area_src, area_dst);
 
-		tmp_area = area_src_alias;
-		area_src_alias = area_dst_alias;
-		area_dst_alias = tmp_area;
+		swap(area_src_alias, area_dst_alias);
 
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
-- 
2.25.1


