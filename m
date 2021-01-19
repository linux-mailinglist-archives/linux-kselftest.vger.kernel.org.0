Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9E62FB013
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jan 2021 06:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbhASEpM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jan 2021 23:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732773AbhASElt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jan 2021 23:41:49 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C61C0617A6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:36 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id z9so2973151qtv.6
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jan 2021 20:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FjN+we3a/4BMKfp2FRLzct/HukxeBsArEgb5Xvx6VvM=;
        b=T9ylunAntNqXbYouxPdl8dwV99Sb9aRtUlMsbQ3DW0BpmaX5STOjlICi/P/1VX+iSq
         kt/svqsK3J2GxzSqX5lXoqQmJP2+iNbWmPvkjVmaEHcFs6N8FiZXFLjD6tG8yc/d1266
         7kGqVnRQrD7dBZfp3UmZt8oaOBRYD5OlqK6E62Jx0AqsVal4ivecdWSKp+8msVVQ7ac+
         QPWCIOrOcBrSu2OHSILBYgFoCOoOq6CT0rIdYlEIlekGYvCa2Tn+1uWe+Y7t8pTMidFn
         WJ8rdhf71pe6Dl/7axwWPboK1r+EjkCTArUW2fpNBvq0NZp/xfZl5MRUEZi2s8WQ8ldf
         0iVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FjN+we3a/4BMKfp2FRLzct/HukxeBsArEgb5Xvx6VvM=;
        b=gP8LqsmkyCT7Ww1+a/ox+IimmbPZ0XWL+cHMasXmj3HGd4bapQMD0lYfsuyU7WpcrJ
         rWI6mto7duiyckMdOHFxbaAaDIfouFKdDm6snk+EvpUhdr9GNV7MkvSwfOksOyiXDI6V
         j3StLpeyivPgW+s1Um2bJegmumrPn7KMrkKnUsbx//Re5YR3aanIqEKreUMGfW+EWjQL
         vDCgQa7XEaAJQG/LXI3e8PdXB+XVQFP+vaBSVWDLsH8Ywf25/myVPCNmjIoeK3TF0Otb
         82Te3+GtLeO4LFpksZCRTa3LtChfvkwHDcG6mggsC+Z0yguSvHmN5rSvpY9rWm89S79V
         wcvg==
X-Gm-Message-State: AOAM5337A9//QpPngMDnWyYBrjZqzwuMnySuxu0hff+No0BHnp1pyvA8
        J1Mbbl0jKUSuKblWL5gINOpC+A==
X-Google-Smtp-Source: ABdhPJwv/MB7KhqSh2I2lnS9blqr0Aoc1I8RzA6d5NHQd3cXRN2dgkMdOi+5gZaNcp5Ro/P8Wu0Nvw==
X-Received: by 2002:ac8:5509:: with SMTP id j9mr2643575qtq.284.1611031175343;
        Mon, 18 Jan 2021 20:39:35 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id z20sm11934536qkz.37.2021.01.18.20.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 20:39:34 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v5 08/14] mm/gup: do not allow zero page for pinned pages
Date:   Mon, 18 Jan 2021 23:39:14 -0500
Message-Id: <20210119043920.155044-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119043920.155044-1-pasha.tatashin@soleen.com>
References: <20210119043920.155044-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Zero page should not be used for long term pinned pages. Once pages
are pinned their physical addresses cannot changed until they are unpinned.

Guarantee to always return real pages when they are pinned by adding
FOLL_WRITE.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 857b273e32ac..9a817652f501 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1668,8 +1668,16 @@ static long __gup_longterm_locked(struct mm_struct *mm,
 	unsigned long flags = 0;
 	long rc;
 
-	if (gup_flags & FOLL_LONGTERM)
+	if (gup_flags & FOLL_LONGTERM) {
+		/*
+		 * We are long term pinning pages and their PA's should not
+		 * change until unpinned. Without FOLL_WRITE we might get zero
+		 * page which we do not want. Force creating normal
+		 * pages by adding FOLL_WRITE.
+		 */
+		gup_flags |= FOLL_WRITE;
 		flags = memalloc_pin_save();
+	}
 
 	rc = __get_user_pages_locked(mm, start, nr_pages, pages, vmas, NULL,
 				     gup_flags);
-- 
2.25.1

