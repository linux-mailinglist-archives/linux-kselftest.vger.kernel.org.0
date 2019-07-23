Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF42271E75
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfGWSAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 14:00:47 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47245 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391252AbfGWR7X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 13:59:23 -0400
Received: by mail-qt1-f202.google.com with SMTP id s9so39164874qtn.14
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2019 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4Wn1GFyfxt3NCYf4PGNTFvqYM1MN1tNvgEFxNqktnk8=;
        b=XwZfpnbXFN1ibF12kJh4UX27GKqgHpAYVMgncvRg2XMsGuyHBAM2BbcbV2FMLG6KI2
         Eail8AtVvVEkdWyRNAKDAPdYJBEXOQRcSGAF4Z+pO2ORJP6spfMGKAIf7M0K0GlZ5J+x
         8yVEMOwDv+oyp2b+30vvjnV2SNVEvVcKU1T+4yjg+W1ok7J01teWzQ68jS7jmU8ro/kC
         Oxn9FlCYKBVtK3Jwi5MWr/zhUNuljezL1OPreJbqbiZZtnxrZ1CQ3LvL2shMV2iJ2vVT
         olnzEJp2mTvJs0fngbdCdc/sbDwJUI9/28M468SMn/xpTOjrRZ2LIWF7gDkmDS+GMcl9
         Q1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4Wn1GFyfxt3NCYf4PGNTFvqYM1MN1tNvgEFxNqktnk8=;
        b=K0EpHiwBkRsX9KIQ7+EbMFaPEMSvzoe2oG7HEshgbIfXnYbU+/kkYxaghOSRirVzoQ
         kA2uwLXFAZldM8pZk+LfZJ/y5nTCro9TSRkB7PrzSEc+Hvx686E1vAlK4soLw8V7/qRJ
         2d7p7dTcBWdDwa2Ats43G6m8a3FdnfqBA3Mc8+pycpRyGY6vZU2ZcpXuJR9CEBPTh0rs
         hFj7eI0FZ4cK/gD2Sjmd1DXODZWPi1gns+OJpvfQXNJ9OK90S/F4/D6R+/p/HiTl0lhK
         hJOz3IYOe01DULMtsVkPuARF7uGl8E4RAsmkWGisb1QD9x/8tR14E9dZjlo7tC35V6vt
         vPzw==
X-Gm-Message-State: APjAAAWLbWDC3sjg+yRiCRWaQlcL6mNsh289Xzi+vAYxMyIVz4l08E0J
        dwJgDocXjQtxCQ/LeazZdepnpx42FagelLbo
X-Google-Smtp-Source: APXvYqy0Hkccu8SUSwSAcf0RwepBseg9rSnBcrNaRpXVNhE8d6jRb6uSi4vWmbN3MkxTqVVfEdk8tSl4b+EbX0xe
X-Received: by 2002:a37:4f47:: with SMTP id d68mr50765232qkb.104.1563904762211;
 Tue, 23 Jul 2019 10:59:22 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:42 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <4731bddba3c938658c10ff4ed55cc01c60f4c8f8.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 05/15] mm: untag user pointers in mm/gup.c
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
index 98f13ab37bac..1c1c97ec63df 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -799,6 +799,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
 	if (!nr_pages)
 		return 0;
 
+	start = untagged_addr(start);
+
 	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
 
 	/*
@@ -961,6 +963,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	vm_fault_t ret, major = 0;
 
+	address = untagged_addr(address);
+
 	if (unlocked)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 
-- 
2.22.0.709.g102302147b-goog

