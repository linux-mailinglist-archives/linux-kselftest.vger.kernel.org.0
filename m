Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9411650E30
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbfFXOdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:33:33 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34082 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfFXOdd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:33 -0400
Received: by mail-qk1-f202.google.com with SMTP id h198so16389316qke.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xV4GbhfwTJs/VHD3XxRc3myky/6/dZivHKwnC5uKFNY=;
        b=VLugRRxW8NzEgheS31MNVa1Sf0NPG55w1n45MRa1PCRLK9hq7S2jBGoYLnFMFiHI5i
         hpX0xoMfsikUNRg8wsT/s7FiLojNQJbMZrLaUF3hUbhIT0quzLCgUnw+iuzryEs61l+O
         Ve0OmRPuLrSa3geOriI62VfPQqKbergnVirL4Oq9bZbq3yOHL4EORN4ukQhnIooC4ZN9
         PZ1lLy0eIBkrTz3zU6usqrjjK7ENTukF79xqMm8AaDpm29IyoVXUdy6JraPyjXn+72vp
         F+QX4V4XVS+gqXq9OgmVKgBE0AfC5B+46IUnSBLokKMZbLpJOxTVnXtB640hiGZTFThT
         nCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xV4GbhfwTJs/VHD3XxRc3myky/6/dZivHKwnC5uKFNY=;
        b=cg87qCQA20Auk99waL0nmwHFncK2uFpdCwytRwD4GluRZcw435SNGis6PlCxCTLXQG
         goi8Aeg3xnsffC/mNcycF1Sqln3KZ0/FOIKhSDhWFtv6SfEpVy7UiYb8/H4BStfAW4L1
         cuVkh6W8FdL2PUs3/UARDfBAW90RSpRWR/RPm62ZJZlT+RIp2QaJo5U9NP8W8Eq1VLyo
         7F23f9cea+ZOodAYwCacldyIXSv1ue6C9DgFP04iyrbOkk3ZWZH3jdFjHt/+q4ZW0fgB
         b/SiJc8ApqDPJr8BRYvr0EAk9nlD6Txe+yohKszMLbbD6C0zeDDTVVBp7tsp4fTUkYwC
         5psw==
X-Gm-Message-State: APjAAAWLg5/Zt8FuXxThWb91f9nK5fsxhFD206jL6K/zbzQhGe2zta9G
        o7lsmejVbB7tu4eCFsA2P0NiXZX0JA43beay
X-Google-Smtp-Source: APXvYqwe8X+4yuXQ7UlZtRYriaSj9tE/sKjuV5CxgHmn3yQIPlD9lif2nlCyzd6rbdataPXUKZA07t9k3oZM6sHi
X-Received: by 2002:a37:640f:: with SMTP id y15mr50777872qkb.79.1561386811824;
 Mon, 24 Jun 2019 07:33:31 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:53 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <d8e3b9a819e98d6527e506027b173b128a148d3c.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 08/15] userfaultfd: untag user pointers
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

userfaultfd code use provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in validate_range().

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ae0b8b5f69e6..c2be36a168ca 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1261,21 +1261,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 }
 
 static __always_inline int validate_range(struct mm_struct *mm,
-					  __u64 start, __u64 len)
+					  __u64 *start, __u64 len)
 {
 	__u64 task_size = mm->task_size;
 
-	if (start & ~PAGE_MASK)
+	*start = untagged_addr(*start);
+
+	if (*start & ~PAGE_MASK)
 		return -EINVAL;
 	if (len & ~PAGE_MASK)
 		return -EINVAL;
 	if (!len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
+	if (*start < mmap_min_addr)
 		return -EINVAL;
-	if (start >= task_size)
+	if (*start >= task_size)
 		return -EINVAL;
-	if (len > task_size - start)
+	if (len > task_size - *start)
 		return -EINVAL;
 	return 0;
 }
@@ -1325,7 +1327,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
-	ret = validate_range(mm, uffdio_register.range.start,
+	ret = validate_range(mm, &uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
 		goto out;
@@ -1514,7 +1516,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
-	ret = validate_range(mm, uffdio_unregister.start,
+	ret = validate_range(mm, &uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
 		goto out;
@@ -1665,7 +1667,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
+	ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
 	if (ret)
 		goto out;
 
@@ -1705,7 +1707,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_copy)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
+	ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
 	if (ret)
 		goto out;
 	/*
@@ -1761,7 +1763,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_zeropage)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
+	ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
 			     uffdio_zeropage.range.len);
 	if (ret)
 		goto out;
-- 
2.22.0.410.gd8fdbe21b5-goog

