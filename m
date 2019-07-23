Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19D71E65
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 20:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391339AbfGWR7e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 13:59:34 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:35018 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391332AbfGWR7d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 13:59:33 -0400
Received: by mail-qt1-f202.google.com with SMTP id f28so39177614qtg.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2019 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mo6ZyD7PJiiiTnkBfnFT33xmRSSjLb2erTRpgEGb4jw=;
        b=cRcOEH0iv2407FEeEXiGtfbNaRtJQIzg5XbYICzGVGc43sPOA3+CZIMWAHKgebQ1Fd
         NhXvQ2XcNcF8R9x/znx8/B+ZWBuFc0pppCQj6IxF/91ZQehMjq/FUgtTO1kgaD+sdo+u
         g0fX97ge7Kl52ZUaa6b+4pEh6IxUyFSuMDNJlzhUpxY5RLeNi8LIb5QOqygzH5YcXwTw
         u/vwHZkzfH96V/r4aumfuyQXlNmESoQtl9/gLW/U3oOdnKUbG/Ywu4Xo6BgLwOzrtBVU
         Gf76BaPylfmhv0ijCpRq3ZN2WZ9BE8VMsOdxcjRzxf/93AljoTsAfpUOJtPXkeNJ+1FY
         hU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mo6ZyD7PJiiiTnkBfnFT33xmRSSjLb2erTRpgEGb4jw=;
        b=ZD25CDWIO5M/Pytxq2OEKMGzdZVx8salCAJA58tNai/i00YVGGZT6iv0dghDbayMzj
         YhVi8G9+b9FFn0LXiqjsrTSRDTd8dGkcMgBHFs04edDZo3zws2lL8urAkGo3RrZGOPQH
         3byuEsSTLoH2jvfI4OQxddS03dM0weQDvFrXr7tI/SkBemPis60RrLdq1C53mfHifqnU
         /6/7x1RpBg2fdgI8zmZHgtER8j6W0AWBZXHINlNkjSelSI2Pvpoot+fc9XkRhAFw34fN
         RSAuE65ANHtKzQbIBy1d7wtUtmPp69WK2i1lLrCTdb6fHEZ6RgHc1AqZEMPjN0F5Bvoo
         QEIQ==
X-Gm-Message-State: APjAAAXarfqjeDR6hie1OeFd2Tr7ubiV1ts/51HgWCCISBUqbwGbYEUV
        cv5RuxotUc0CDzqu4UZXBSn9+Qj/CyPm+gc6
X-Google-Smtp-Source: APXvYqwqXUnbT9S2ecddRPfsS72rTxoBtLQXpIQx9JM0kIhhjvtv5eSOcsPLQ4y/4499Xb23XuIGaF+KOaOVjXRR
X-Received: by 2002:a37:47d1:: with SMTP id u200mr49170508qka.21.1563904772061;
 Tue, 23 Jul 2019 10:59:32 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:45 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <cdc59ddd7011012ca2e689bc88c3b65b1ea7e413.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 08/15] userfaultfd: untag user pointers
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
        Andrey Konovalov <andreyknvl@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>
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

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ccbdbd62f0d8..6284a4e719cb 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1271,21 +1271,23 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
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
@@ -1335,7 +1337,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		goto out;
 	}
 
-	ret = validate_range(mm, uffdio_register.range.start,
+	ret = validate_range(mm, &uffdio_register.range.start,
 			     uffdio_register.range.len);
 	if (ret)
 		goto out;
@@ -1524,7 +1526,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
 		goto out;
 
-	ret = validate_range(mm, uffdio_unregister.start,
+	ret = validate_range(mm, &uffdio_unregister.start,
 			     uffdio_unregister.len);
 	if (ret)
 		goto out;
@@ -1675,7 +1677,7 @@ static int userfaultfd_wake(struct userfaultfd_ctx *ctx,
 	if (copy_from_user(&uffdio_wake, buf, sizeof(uffdio_wake)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_wake.start, uffdio_wake.len);
+	ret = validate_range(ctx->mm, &uffdio_wake.start, uffdio_wake.len);
 	if (ret)
 		goto out;
 
@@ -1715,7 +1717,7 @@ static int userfaultfd_copy(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_copy)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_copy.dst, uffdio_copy.len);
+	ret = validate_range(ctx->mm, &uffdio_copy.dst, uffdio_copy.len);
 	if (ret)
 		goto out;
 	/*
@@ -1771,7 +1773,7 @@ static int userfaultfd_zeropage(struct userfaultfd_ctx *ctx,
 			   sizeof(uffdio_zeropage)-sizeof(__s64)))
 		goto out;
 
-	ret = validate_range(ctx->mm, uffdio_zeropage.range.start,
+	ret = validate_range(ctx->mm, &uffdio_zeropage.range.start,
 			     uffdio_zeropage.range.len);
 	if (ret)
 		goto out;
-- 
2.22.0.709.g102302147b-goog

