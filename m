Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C945A371F2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 May 2021 20:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhECSIk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 May 2021 14:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbhECSIj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 May 2021 14:08:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81303C06174A
        for <linux-kselftest@vger.kernel.org>; Mon,  3 May 2021 11:07:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so8683869ybo.11
        for <linux-kselftest@vger.kernel.org>; Mon, 03 May 2021 11:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iF80KwmGEZ/7b4uYBqluetUylLH4grXh0TbUAxV+2kI=;
        b=RBaGtZ3UwPJBS/xtU/kc4GQKbuH133C3lfAme4W8VCaU1RKlc5nDKtvUbga+6zpObW
         g17ZYU/XzSYpf+EEKwsm3Tl01IGznzMgj9IJbZvz+R0jb1BmXikZpaRSHp5g1jVureFl
         CO4iaT2SlqOP/Qr0RcLlWSegkiTfWr/JvyepMxcyyuG4uMIAV6P1to/7lDlGMYfLxQPz
         D9R4K6T8X+hX7Hwk23jnCCgksmrLfCdYXZEUsAEdjdigxky3YcZBIoKgQLmdCkjtMtAJ
         7El3SOybAPaO621rvXv6rrhU6ltuy/hgAXGcXFGlwyH6oK5Md8R/HNwsg+GdrYJDkG4s
         yLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iF80KwmGEZ/7b4uYBqluetUylLH4grXh0TbUAxV+2kI=;
        b=WCt8KvuWr+epTBvg+Lcl+1o222t1GdVwM0PKGuoUWJ/z/XDSqavyZASMhv1FCLBV+y
         +QI1AtBUdS6dkk1dv4akajWMq0GN9IUk5XCM0k5PZGbhbXCqA8vtKQE+JnylZ9LBWzDZ
         p5n5c/7MAIgwext8V9lINrYJwQSGtJgsUcwbWrfAD0ToA7J9IQFPrx2buByMKp5CJG8A
         41JkKDC2Utf+5frN61DU4YeWG7d3mlMxYNJor293vr0kCfL8iL70ay3lwzHgE48xNP32
         N1DNoIEI3cIOR023EXUV/bVyt1gGostIcgqWaRNpvM5rrg3wUjjyIkOechdnzTHTWMCM
         m0cQ==
X-Gm-Message-State: AOAM530VlmD9/Ed1aYYl0y660peW3qu2EHOFWZpIDFszrYQao1/VeuDz
        EiPVlJP+f883ZGj+jtGLM7jhgqSP0CUx7lpUvR/H
X-Google-Smtp-Source: ABdhPJzWNiyUBjvIsLk8ysQpiD8p9lQ7yUN6A2c6kxeGvBdTBCt2ouz3+SYVAmlnQ2Yq8UJSTS/hy6dEddxLnT/1zn/H
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:b186:: with SMTP id
 h6mr25474371ybj.455.1620065264666; Mon, 03 May 2021 11:07:44 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:28 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 01/10] userfaultfd/hugetlbfs: avoid including
 userfaultfd_k.h in hugetlb.h
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Minimizing header file inclusion is desirable. In this case, we can do
so just by forward declaring the enumeration our signature relies upon.

Reviewed-by: Peter Xu <peterx@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 2 +-
 mm/hugetlb.c            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index b92f25ccef58..c98269e61ff6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,11 +11,11 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
-#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
 struct mmu_gather;
+enum mcopy_atomic_mode;
 
 #ifndef is_hugepd
 typedef struct { unsigned long pd; } hugepd_t;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3db405dea3dc..d2212cafd335 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb_cgroup.h>
 #include <linux/node.h>
 #include <linux/page_owner.h>
+#include <linux/userfaultfd_k.h>
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
-- 
2.31.1.527.g47e6f16901-goog

