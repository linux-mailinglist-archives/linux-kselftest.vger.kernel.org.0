Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC4542324C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Oct 2021 22:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235949AbhJEUsd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Oct 2021 16:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbhJEUsc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Oct 2021 16:48:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D9DC06174E
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Oct 2021 13:46:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d1-20020a056902060100b005b9c7c04351so339091ybt.14
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Oct 2021 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=FO2aPS6pZorVRBf50npiyQHLDER/25pHVLgerA3vbnw=;
        b=nxZ5J3JjL9zO6250ntxxadz7P6bGzDZZbF0uQ1Nezk/oZEzsxgLwA6oiYSR36lkAju
         XO/vTS3YP+f1a3vaXlYnmDgkMbqA9+jcW03Uf7nfjRoe3hE5fhSIHWjodDpo1R5hGsJR
         42v/HL+BMlskuKM4D/fpVCZi8FGeoMIEL7cg/JLIFCToHF72KbXhBN5rbdjMt1yjkLZW
         xAoQKbZlBtBJH/XQtemXl6pzSVqX/UwNNgj8NhADrJ4WBWmmQ3qmYrB5G+jT5aoJ5Sxl
         FlLhHGEjArqRWhCm+C1pPWMItceRx8BzWfvWYkdyVoN2sNEYzBPIa5ahwc8t8cC5GW/u
         pQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=FO2aPS6pZorVRBf50npiyQHLDER/25pHVLgerA3vbnw=;
        b=Et0/vZeAaRDFv6fTFaJRig9+OroaYlgjPcArxXLR7uvRzH3rNTK/+EaugI3LZsPVHW
         9qilsU59YLdnNRgLN22TXrhmB7BgA4YB3LLUQkGIFHII7IsMKMsEnGBAjv6enUfIo2l4
         xzgx8TJPZv5WKqYfpYGiMNicGXXkEoGzEaVzXZm1QrVlUHyOvBBTZSe0HXtTrZscOM5L
         U/zopLOXHRagL+gmBA4jJQlCgzkaM0em9NRnqHoshZsruVa8ObP+CochLugpW9IaQ8Hh
         odnvgVkftKjcrLuszQaFmyZlSXSENbREtxbj4sNxvZsVJId5x+TGv84h8XCU0s6jZL2H
         FcOA==
X-Gm-Message-State: AOAM530evNMETJ/IdvW+OujljBUxZy8MCoJVPxRa0M+syXFH3Hy83D6p
        GmidK9mC2AUqqy9ZDHV82E3D5jdMQANE1g==
X-Google-Smtp-Source: ABdhPJywvvfcad0JOqum5sPHoZaLr0HdhWwsl/ZHK4gSxz2cvmVMuygei4IJ4c+14g7d2HnICdzK01c/hRyFHw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:d252:3bd5:53cc:fc46])
 (user=dlatypov job=sendgmr) by 2002:a25:3fc1:: with SMTP id
 m184mr25047881yba.236.1633466800517; Tue, 05 Oct 2021 13:46:40 -0700 (PDT)
Date:   Tue,  5 Oct 2021 13:46:32 -0700
Message-Id: <20211005204632.3132652-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] kunit: fix kernel-doc warnings due to mismatched arg names
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 7122debb4367 ("kunit: introduce
kunit_kmalloc_array/kunit_kcalloc() helpers") added new functions but
called last arg `flags`, unlike the existing code that used `gfp`.
This only is an issue in test.h, test.c still used `gfp`.

But the documentation was copy-pasted with the old names, leading to
kernel-doc warnings.

Do s/flags/gfp to make the names consistent and fix the warnings.

Fixes: 7122debb4367 ("kunit: introduce kunit_kmalloc_array/kunit_kcalloc() helpers")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 24b40e5c160b..018e776a34b9 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -613,7 +613,7 @@ void kunit_remove_resource(struct kunit *test, struct kunit_resource *res);
  * and is automatically cleaned up after the test case concludes. See &struct
  * kunit_resource for more information.
  */
-void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t flags);
+void *kunit_kmalloc_array(struct kunit *test, size_t n, size_t size, gfp_t gfp);
 
 /**
  * kunit_kmalloc() - Like kmalloc() except the allocation is *test managed*.
@@ -657,9 +657,9 @@ static inline void *kunit_kzalloc(struct kunit *test, size_t size, gfp_t gfp)
  *
  * See kcalloc() and kunit_kmalloc_array() for more information.
  */
-static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t flags)
+static inline void *kunit_kcalloc(struct kunit *test, size_t n, size_t size, gfp_t gfp)
 {
-	return kunit_kmalloc_array(test, n, size, flags | __GFP_ZERO);
+	return kunit_kmalloc_array(test, n, size, gfp | __GFP_ZERO);
 }
 
 void kunit_cleanup(struct kunit *test);

base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.882.g93a45727a2-goog

