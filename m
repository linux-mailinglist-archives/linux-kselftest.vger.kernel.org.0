Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FEB2FC727
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Jan 2021 02:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbhATBvF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jan 2021 20:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbhATBpb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jan 2021 20:45:31 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDDCC0617BB
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 17:43:54 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z6so8219591qtn.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jan 2021 17:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BKUj/6ZsJWAx+ypUtR8qlYsn81/heEPy52GNTY6EKsg=;
        b=oDhucAFFl5fFLBbUP6N7kYGPCWSid4rOxZEuV/K3xSEXxC+4t38NIYKbPweeJkN8y5
         0GqeWh662ZXEMhO81KR9IWGunuueM9R+TVXGrAKGPQY3/OpzYHXKsc7+IsWTeXUJKmhW
         uCG28rVcS09zX6wS2pt3JMesiEscQKi02L5+KN1POzu7GF4y+nKX4qWMxy1R5xDNYUux
         XxfepHhMK2sKBzZ2a3Xe6hIlNRm677mF9W9S7S81+wMhl/djsa2IRYo+fPYOibYFCU5b
         5/0FVlix0iE3DR+ayWoKmNXjF1/tlD0e0i/LSC1K1Cn50CPVGOxvVf3iObZ7fjoxUtI1
         kw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKUj/6ZsJWAx+ypUtR8qlYsn81/heEPy52GNTY6EKsg=;
        b=mU0RTs3mUl6viYqZmNJpHpj7uVouVxtk4tTXUayxUukVawnf//qYCyqZ2rZJs4A24M
         L9ZEpNK8OoBH8DlawwVNH6/IXGsHLj3X8mYnrtpi0MA7ustavn4JcGl294RltYhl6hBe
         slFPpdDSobLRkxrUE3XzxWPDJMN0JRj7mD+UYQcnSim1YH+vQNoI8hy6jg1z/WzwaPjY
         Vzg9Jg6JpMcR3edFfNkb+U6Om5/P6EgFE6PAJNq4q65cHOZBx0a2qHBVatvVmmM6EGJg
         FXUTwOUCSoICzdAfOJwWVc3O+8c0y2eNN9nuVv8yJhTYeGtRN06Tiu7Kg6NrHiFezVDR
         UpgA==
X-Gm-Message-State: AOAM532cn4lUVCUJVgXBLjvg0vAmGf9idX7lNRzvzYiIf95d4FLw73sx
        2miBhwkJxPOqgmVZA9CMDBKQMg==
X-Google-Smtp-Source: ABdhPJwGbcj3jYzIBgMMxo+ssO/F9JFenmluHPBNAtzaOONj3R/BAwlfKcVGPIBE5qq3N+6LdmcxGQ==
X-Received: by 2002:aed:3aa8:: with SMTP id o37mr6814179qte.239.1611107033730;
        Tue, 19 Jan 2021 17:43:53 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id a9sm391871qkk.39.2021.01.19.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 17:43:53 -0800 (PST)
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
Subject: [PATCH v6 11/14] mm/gup: change index type to long as it counts pages
Date:   Tue, 19 Jan 2021 20:43:30 -0500
Message-Id: <20210120014333.222547-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120014333.222547-1-pasha.tatashin@soleen.com>
References: <20210120014333.222547-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In __get_user_pages_locked() i counts number of pages which should be
long, as long is used in all other places to contain number of pages, and
32-bit becomes increasingly small for handling page count proportional
values.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/gup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 668795e5a816..c7abd5b37150 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1479,7 +1479,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	unsigned long vm_flags;
-	int i;
+	long i;
 
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
-- 
2.25.1

