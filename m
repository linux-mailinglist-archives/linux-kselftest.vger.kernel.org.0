Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29861519B
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfEFQcx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:32:53 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:46550 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfEFQbj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:31:39 -0400
Received: by mail-yw1-f73.google.com with SMTP id 201so26170257ywr.13
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XsLXWNDlsBBI0M98p6y9Vt03OYjBcfLHAOwfOkL6Mk8=;
        b=kEClrhOVjhAItZ8ad4444tIss3a4M0x8Yot0yP0UgDJhkHPz5JJSrKt8hPGcBCGy4k
         n4A8xX+jnj6SxUqb5Teq0gUiCKNzkVcA04YhcbUNwlyz4R1O6RfjMZcPvXzWJ1RdceKB
         oQhTiP7SkvbOtmqbJ2RUuk4j1OYZLTrgQf9mkPglzFxH/VOrmTQ4nsN9RjYlhUC2s+eh
         3RVGdXHQ+PFLeCy7nvUg/hvDRpVltVdy/tgWDjXNd7yymqhFMcWgbq1pcJP1+YPDmRyD
         x5gmgR7lpn+iTAg+S4pO9Zaw/FFLdxShW6UDAYaJnd95g7v5e/84elY+8pkkjOlGa4Nw
         P+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XsLXWNDlsBBI0M98p6y9Vt03OYjBcfLHAOwfOkL6Mk8=;
        b=PnGLgpgxTiFuZzHPBo5rzbai2P7XdcYpWSVoB6asl17OyeAPWxCZaMSMhPeGgwXyLv
         hYso+owQ945n1UiDiXW8+jCy8kEndVBAjPX6cVBg7LmFrkZNPulLn1Sv50TB42HVaR3l
         sLmTX2dBI3ZGWTjzlyf0ZOhQOmabI5DbWw43nUPsTjDPKYauBHYmNxVNyD54z5opjejf
         4XbxEYV4kWMAX5OF/b2u4Fpz+lDJipB9gpHexzMb50ywsZUWmkqIJs21Q/oeo+Gh7PJC
         pg6J1b5AWsF5YT6IrakCRGWKrHwNqJ+lZSqRWU6kbDMONMEL9odjxU2vxm2X5isRa9aF
         Bjhg==
X-Gm-Message-State: APjAAAU263Www9gcqEHpAQ8GCxA8aBYGUvm0oRmXlwqFIHifsnzvCvjl
        BdEYQF7OWIJEhm3d1v41Uk2wme2YjqaLrJ4z
X-Google-Smtp-Source: APXvYqynTJlFStkm7itRuyZbu5fDIV0oTx6a8awLBBeIPofcOk875PcBne7EkMsm55r8chxW1lodIy8g+/aDw2aV
X-Received: by 2002:a81:7903:: with SMTP id u3mr17016403ywc.478.1557160297906;
 Mon, 06 May 2019 09:31:37 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:56 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <30b44d469bb545c608531faf01fb10248ed78887.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 10/17] fs, arm64: untag user pointers in fs/userfaultfd.c
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
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
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

userfaultfd code use provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in validate_range().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/userfaultfd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index f5de1e726356..aa47ed0969dd 100644
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
2.21.0.1020.gf2820cf01a-goog

