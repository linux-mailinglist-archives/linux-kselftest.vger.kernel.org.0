Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF64245A
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438405AbfFLLny (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:43:54 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:44771 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438382AbfFLLnx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:43:53 -0400
Received: by mail-qk1-f201.google.com with SMTP id c207so10134377qkb.11
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lneYlz8LHaEiU1JdbWuWSlmR06MpCpkboyQbci6TbSY=;
        b=ZYQEd649LLsr0eo67tg5mBkc6yqoxRRkUvXmz72kCnd/9DceAYIH632RHTy/L9FYgN
         XB0cqiUT3202g16B44AOr6KGjUuUQCuOjjfhX/1rdyfTYvOLIoAOYVJQEyUECaYKw2EI
         wRT/I+bn5+fj2NWK1Uq2bsCtdk4XPg+CFAKbAVJ1PN2JQI+rUil/RmfEGI1P+fH7HVvB
         bi61I1IZdPLHbF9O0x6GFnVgN1H+PpiOuX7A6ltMyEW2b4fJxpc44OPAWrBW3bGwUHZL
         UOaZyEvgJIbhkL4J+WjiYsF7XS5CEf84amjDEh8dkaorHVY5qClgPk6YQHyQ5aqjEpT+
         PVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lneYlz8LHaEiU1JdbWuWSlmR06MpCpkboyQbci6TbSY=;
        b=Usf4g9cny2LEAayVbuDaDMFluODgxIFFKHlpzWYfoNlb3OvRWlmgFVtKEy48SD/ZY0
         zwZU5/7XgkZbelLQGyTBj6djF1R3Y7aN+U80yHgIjDqOQwFAkzWdvqkjWybzlrPj9WTr
         hQBOn0zEWSEnki2+IJoWncu9jcgAPQsGjuYEbyR1hwkGzJeNXEI47gNuqcfKCfh0Sl0f
         74O5HeZkFNcO1Bjyz4IZlZbyeYnnTdB91gjyVVuhwx+7Uc380oxndAeq3/kSV1jq4RPY
         bh0YH5kYmA8C4fnsD72JCDlHIbqnktsGp5YSbdLmWkiRrs6q+8uf1ZEGmpL+ZX0B5eYa
         iEYw==
X-Gm-Message-State: APjAAAU+nEBK/+8/p7KBwoI7kw26meN5FKwdYKsODS28a4jbM/8TYyTA
        NP5MGvlwHQXwIe8swUpB+qgy0JcGYXeiGWYN
X-Google-Smtp-Source: APXvYqycBZ/jgN95w1hvszVcRcdW7P9Dg7ub2DyBfBHGpLBHXa9MwJ+9kmDh7H9YZkcwArOGpwiZYJEXckCXcJ6D
X-Received: by 2002:a37:a5d5:: with SMTP id o204mr25506301qke.155.1560339832693;
 Wed, 12 Jun 2019 04:43:52 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:22 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <8f65548bef8544d49980a92d221b74440d544c1e.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 05/15] mm, arm64: untag user pointers in mm/gup.c
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle this case.

Add untagging to gup.c functions that use user addresses for vma lookups.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/gup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index ddde097cf9e4..c37df3d455a2 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -802,6 +802,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -964,6 +966,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

