Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F2A2DD8DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Dec 2020 19:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730885AbgLQSy0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Dec 2020 13:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgLQSyZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Dec 2020 13:54:25 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5A5C0619D8
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:53:00 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a6so20842975qtw.6
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Dec 2020 10:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q+nZQmLz+g6ZtD9UXQKwPL3A91wbKfX5nZj6XsBF5oE=;
        b=JO8qsADGPR4ZcKb3Gq+FKSW5aYA37eOaMrDgEiIcr5jzVShlVNKWtFcFGT0Tx3cMaS
         wJK8H4/qkQAa91lkrvvrvVhvqvRTRrc0cXVG9prRf5eIUUOYkeXykED77uULERb3qi2S
         aKhixRDGpTBTfOPxg4C7w3zrkZQYLiR0+RfMBR9kTP4vmjFrTmFN0H68z77PVURftvfT
         6zQWCURQR4W0gXHv3MUmiWL1LHTDZS/ikTWgkKkSVoypuey03I/hMAH2KRRKKfVV10dc
         iOwzTWGWVjztOR2Vx36yAmOnyLwBGqiXBWiq0B7YE4kuUgcKm865e7wWGRPqfZEu1nu8
         aVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q+nZQmLz+g6ZtD9UXQKwPL3A91wbKfX5nZj6XsBF5oE=;
        b=LxuneHaYHnBEV07Y6oRCfJg7j31h6l6RnT9PyC624yaQYXuTyGSemI0tlfj0ZF/CQP
         HLWwP1tXwzFzjerOkBEaSPVZr7vchhLdwDx+mce+0Fe0CyMRqiX3Ai61dY4dpDJ8p0Cm
         DP/f9BV+z3Vb1URdpfwyPHeYB5FSoOm/Ov8C15iKgaHpj9TVXCWQ+wFhbGv5f1lXp163
         scv6A5cFNLuhPMYpjPLTTYmla1I3vnLm90DjX7lXQAaVWKA5fWvIaosNjvkSOcpVHHgf
         nn42r8twKfg1Hwl1oZYNcYiFtYqw+yXvjCs1ONClid8Pr/OU5PUxU01F+LedeuVYvCZY
         mCHA==
X-Gm-Message-State: AOAM532zeDRYA8JMSWrfMPviZaVSwfRHLranVbujBrT7KlbT7I1/hgYO
        ZzJ9XCIMPVWARAUp3MF+H42MKg==
X-Google-Smtp-Source: ABdhPJyZTZTnodRThEF3jTIBRJYgZGD6V+Z5lINIuUMU1uZ/VPO4vM0YHNy5VdMEckiPuqDN6NjqBA==
X-Received: by 2002:aed:33a1:: with SMTP id v30mr196167qtd.50.1608231179869;
        Thu, 17 Dec 2020 10:52:59 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m8sm4127434qkn.41.2020.12.17.10.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 10:52:59 -0800 (PST)
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
Subject: [PATCH v4 07/10] mm/gup: change index type to long as it counts pages
Date:   Thu, 17 Dec 2020 13:52:40 -0500
Message-Id: <20201217185243.3288048-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
References: <20201217185243.3288048-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In __get_user_pages_locked() i counts number of pages which should be
long.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 591d8e2dfc70..1ebb7cc2fbe4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1481,7 +1481,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1

