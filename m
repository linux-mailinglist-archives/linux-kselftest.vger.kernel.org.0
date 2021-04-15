Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7592136126B
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Apr 2021 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhDOSsg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 14:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbhDOSsS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 14:48:18 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB340C061346
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u128so3431906ybf.12
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 11:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kyyFN9AtGZG7sxPS2jLvKjxCRLZ+illjJVxTiN8fbrw=;
        b=bEO/DKD/YOTDKe4mprz2o/D25pBXvk5801YRzBcmlH29uJ7L3xw0LQeabTYhX1ZlgN
         Lw4e77/NBxGYXx1c1CWdXQlgp52Oi/tG7mccD2oT6Yhbwm4ef5UPHoCO4/ZslMvqvWf8
         VR32W9PLDLs/IO7IOSPEhFvbwEvSl2hxfNx3PFupE4ltWdrsbUtXrgT9AAI58yiLgW+V
         NUOYj78f0D/V/Q5P8RM6KcsCIHPk9XuO0Ntj3NWMQAT3DQ4ouPoR4wt78n1hHibp7Rs4
         /JAXARkjMuOyLTDNmJ3WOx4uRnizhdSBKLs5FWYGDJZFml7k+nPkfDGbyOL217bU+yYv
         /1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kyyFN9AtGZG7sxPS2jLvKjxCRLZ+illjJVxTiN8fbrw=;
        b=HfEc9Nlcm9+4S9QgrsZWfq+B3Iiz6eNM66HMz+iXK5JtcTsA21lWJA1EkSQ50XiT8B
         0hNyVfTZ69IxmD+5O4pBlI07rtmuEzBaSI6UxxUY+wgcinz8ENVUqlIkLwQum5YLZ+K7
         7iv1kS9NgAJXPDhbeaaOm/r/0M+gKFJdghLM6bARgPWTdRs7XWMRWfBoNUU7WrpPuhFR
         Y3FrWSc2mMBsa61QwbIk/jpsYBYuZ0kOHBkUKZboDbKPM4sxi6cij1O3lb9RXaoqKR9v
         g5xWlOG0HJ/o/Xcwy9jyEqWazGuZXIIFP9mgB3K2nXCNZbbmNaMv1StUM1Yl/yiKYVmh
         SvoA==
X-Gm-Message-State: AOAM532IA0YI832SJ6Y759RL1rwlbk3Ma59Oq/csst4FMXzPvwED/xQA
        ZE0VBAjzXzYbLqKhsY94PZe8wuW2bGjAa4wVk8Yp
X-Google-Smtp-Source: ABdhPJwmBq12z8GDJ7rlUmNNBf79/x8Y3kxDpNh/SNGdAB/gu2N2d4uyd6oRta1UttdpAtKCjxE1V3qBeKEVPtFqczMH
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:21b1:6e5c:b371:7e3])
 (user=axelrasmussen job=sendgmr) by 2002:a25:cf08:: with SMTP id
 f8mr7041943ybg.132.1618512466892; Thu, 15 Apr 2021 11:47:46 -0700 (PDT)
Date:   Thu, 15 Apr 2021 11:47:28 -0700
In-Reply-To: <20210415184732.3410521-1-axelrasmussen@google.com>
Message-Id: <20210415184732.3410521-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210415184732.3410521-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v3 06/10] userfaultfd/selftests: create alias mappings in the
 shmem test
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

Previously, we just allocated two shm areas: area_src and area_dst. With
this commit, change this so we also allocate area_src_alias, and
area_dst_alias.

area_*_alias and area_* (respectively) point to the same underlying
physical pages, but are different VMAs. In a future commit in this
series, we'll leverage this setup to exercise minor fault handling
support for shmem, just like we do in the hugetlb_shared test.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index fc40831f818f..1f65c4ab7994 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -278,13 +278,29 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
+
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED)
+		err("mmap of memfd alias failed");
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+}
+
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
 }
 
 struct uffd_test_ops {
@@ -314,7 +330,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.31.1.368.gbe11c130af-goog

