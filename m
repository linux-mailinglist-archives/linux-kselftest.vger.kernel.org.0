Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE59950E66
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfFXOer (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:34:47 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:50751 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbfFXOdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:20 -0400
Received: by mail-vk1-f201.google.com with SMTP id 184so6449424vku.17
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WdcdmcPYcZL0TsO1VpqXvB5XTsCD4Aa27drvhQYmelM=;
        b=icIOyvO3zCCmb1V8FS7xfJSkpaqM0fPXCTMb8P53l/4sddyw376GFk7VntBpgH40Jb
         dlVT0eEdK1fq5jmQgL2mnnKbFXpBzrZuKvOPspNemignJXsBOcwCLAzIsieht3b/IonX
         6zR53XzWDMowl976raMoG4ND2r1RJIjiKAB3ytw9JQwx/injyU+afKGG9i0hRkWS9CDw
         EATvoJg1LGBCFewFDqj3C9titqpFuwNcjn3ZH++ykTRmRXVgWgXvHOfj+CupsqyAB/Yo
         cDDXvnZegW7qBTu946VpVm0cbCpkrGmZnjcy3KK2CuBZhA9rQZ6St5/hoz/kt5af2Epi
         DXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WdcdmcPYcZL0TsO1VpqXvB5XTsCD4Aa27drvhQYmelM=;
        b=BqCFTHIJdeuNMpm8P8OtsGtiqlNtlYAVYOA4HlfjKT4Ik+GLOrLFcV2kHRo7/KOs+3
         j+JrRwOUEn1MGapkkfxF1zp1OpbwkX3JTYG9oDwOsS4blQLojLY0KLtkyYc9gjoizIvJ
         e0Q/YTznDKAgAQONLSKdB+/tM0dY+LG87fMyLZ9wsWT9j+2dD3RrOxwNAwqfKKU4/odi
         ML67JB42D/1RFlQPMZBhuyJRym5Kip8JqIUjH0ynyreGg9OswkRWmM49fmjvqcvBik+g
         PGgMVbaqnMdMH8Xzp8vdZsTBwiubvikniC/zbKgsd7c5xml00sYejNz2bbvquGH028k6
         Zu8w==
X-Gm-Message-State: APjAAAU35xrTzOmf+FFvFa/a2DP3KLvXEdOPxIAC3VSpNGzSqqPCGokC
        KhdGHJvalgjl+FC3BFvBfLRLW3R1X8XhR2jP
X-Google-Smtp-Source: APXvYqyeP684NrNNIM3KhbFTQXwcDTrmwl6IHcjELxzf0coSdSlRrTjZ+0PmPJg+BCNxcMTgBBiBdQWJwdq50pfN
X-Received: by 2002:a1f:ccc4:: with SMTP id c187mr4784377vkg.56.1561386799794;
 Mon, 24 Jun 2019 07:33:19 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:50 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <3f5c63a871c652369d3cf7741499d1d65413641c.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 05/15] mm: untag user pointers in mm/gup.c
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

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

mm/gup.c provides a kernel interface that accepts user addresses and
manipulates user pages directly (for example get_user_pages, that is used
by the futex syscall). Since a user can provided tagged addresses, we need
to handle this case.

Add untagging to gup.c functions that use user addresses for vma lookups.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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
2.22.0.410.gd8fdbe21b5-goog

