Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49661318FE4
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Feb 2021 17:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhBKQ1a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Feb 2021 11:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBKQZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Feb 2021 11:25:13 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E86C061788
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:31 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 2so2823005qvd.0
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Feb 2021 08:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Eb4Z5OA9Zh686EUEmFFrS5z1Iv7khNETxfPbVyT47Bw=;
        b=l/VZLQ8IiF9IIVyBOqtHnEGH2KT3DOse3oUidCCmKkGcdaf7QZmZsCP29d1dF1g18t
         rAghwGOCk+1WBqJn61TdveTUxo3yscxw15XN2DnWOrc0rlpxoqTQVhjvKzfaYqt3i8+8
         Xm5ua11oNKU9XyYAlFHQRzpyIXolK47tGgo+ryTw3HXiqK++AEyqaCUlBCc6g4QT7AWE
         JHS2Yf5XlillyXO2wauFwv1L8p3MN6DSAorqGHe+drg74h0gqpaB7IpJC84f9MFzMR0x
         sVtgd82vXTCXPo8WPhvShhYsRZ25YDY/VM3K1FDh1/ugiQAOKNT57Zhb+c7v6ZJ7s57G
         nttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eb4Z5OA9Zh686EUEmFFrS5z1Iv7khNETxfPbVyT47Bw=;
        b=ptDskqKSkxPfM/BvRdI58HYa4KrqizPVgwK4XImaFHrvsIvHP5WwHmPrTvYH3oozBS
         uLVWds9r5QUeOQf/agyf4zrvpPo+XPiLIPqCSLvIZXgAtgt/wXoIJ5+Xvljdzk/nN7FN
         9r4qTmB8T15JWewgBrfX5TCildPEmXBf3FQFAy8uO8InZmiuomh8lOBPBZfNf6FlGjkB
         aaQPdhl8NSZNykPSCQFOzbbWzk+BIif5EhhfHCdlo31zZMOzd7L5BaptqbneDDQFlHJa
         qYES5g3rlR9SuI69+DlBcXy7AaAZLs9VxypnZTE/w2hLi/XSe87tWCAKMggVvsTmgUSa
         4MQA==
X-Gm-Message-State: AOAM531Oub4Qqzi436D7of09LCNqg+B0Ox5vGq2HgrgKWdB7Rwu1kAF1
        ESZxftaS1jVnZpVwoyLNiM76mQ==
X-Google-Smtp-Source: ABdhPJw9rSf4xISC0Xn5LFKiNNWdqZ4YEh2Y2mQpMqsSCVHEgDugx+m0a9VyLYZFGp3Jt0z9q8GiVg==
X-Received: by 2002:ad4:4345:: with SMTP id q5mr8526952qvs.61.1613060671144;
        Thu, 11 Feb 2021 08:24:31 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id i23sm3831778qtq.42.2021.02.11.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 08:24:30 -0800 (PST)
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
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v10 01/14] mm/gup: don't pin migrated cma pages in movable zone
Date:   Thu, 11 Feb 2021 11:24:14 -0500
Message-Id: <20210211162427.618913-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210211162427.618913-1-pasha.tatashin@soleen.com>
References: <20210211162427.618913-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order not to fragment CMA the pinned pages are migrated. However,
they are migrated to ZONE_MOVABLE, which also should not have pinned pages.

Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
is allowed.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index e40579624f10..88441de65e34 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1555,7 +1555,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
 	long ret = nr_pages;
 	struct migration_target_control mtc = {
 		.nid = NUMA_NO_NODE,
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_NOWARN,
+		.gfp_mask = GFP_USER | __GFP_NOWARN,
 	};
 
 check_again:
-- 
2.25.1

