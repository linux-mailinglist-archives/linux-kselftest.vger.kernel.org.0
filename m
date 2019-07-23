Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2271E68
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2019 20:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbfGWSAU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jul 2019 14:00:20 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:40216 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391377AbfGWR7n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jul 2019 13:59:43 -0400
Received: by mail-vs1-f73.google.com with SMTP id v9so11694899vsq.7
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2019 10:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zUOcAU6p00loQ1nrwWD7GDrs3KRhifPlQNEkBCXrSQU=;
        b=VYKldQtWxdBSrLk5sLC9xz+aQwiA+p9laEjbuJhQ+y14MW59AQItVZb4XUBX4o3STS
         L9JnHbRkn9qNr1J9IZZM0iJZeAOF+VZrFXTsiwFOiScu2zQivLlflg4hR7bzjUfOiPul
         +YlOCB2JPa3W1380wQB/LrhFWVtaDyOhlYe6qKxweJSR67HRGh68c9IWX3GDOjZKGFb5
         Q62/4pR5YzdGLIAhcCOdymu1+C97aJhL6hmlz2Cb/a02TQdVA66PchqiCSNf3yPDUKCI
         sPIwmB/L8x0Lmk1aIlxXadTx8+U7n7WnYlELCxDnDvSJNs7fU1kWK2fSsF6MBML60HXD
         zTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zUOcAU6p00loQ1nrwWD7GDrs3KRhifPlQNEkBCXrSQU=;
        b=BCvM4cuq2dN5+AhB48Pghy2z77YNCg/gMyrFwz2RUfJCo3IGsZ9xjo/+O8f08CfbFW
         usIVqaIEXRtqWspCm0dc1VyHC80QFCR38dac0/E1Dtm0Haveh6C7mDyp4BCWkVQBLBnD
         pPdsNM+f139O9EhSNDcG0P2pxWbiD+dV7BtEmDmTgNv9FaB8bVAdKOqskPfREXHHXlKp
         HeJwT47rPy21XBt/1mWUZswwrgJ+meXwWvIq/PwE5iKJjK9leKN1FJNDNMiSunsyUCQY
         OrvITsdoNC54GO72XdiGYbrJ+yCg+RJJMKKjvMc2bKa3d5nZqMv3p8/ef/eHOe9WWhvF
         T8ng==
X-Gm-Message-State: APjAAAVqPynJTb9ApgBeHm5CXnQk5rMaZAKi22fF5NVc5EtEgto4kRO6
        qprCy0TF+gbPVy7llQgpMw7jOJ5LhDZrbheZ
X-Google-Smtp-Source: APXvYqwKLPKDYRl/Wu0ROV1RQ4E/ZMl8ZV1EzuXeG4/TJA26mw9Ne5fKh3z8AD7u+iNI3pn1/I9GUafVuAQJAaix
X-Received: by 2002:a67:d60e:: with SMTP id n14mr49253950vsj.213.1563904781800;
 Tue, 23 Jul 2019 10:59:41 -0700 (PDT)
Date:   Tue, 23 Jul 2019 19:58:48 +0200
In-Reply-To: <cover.1563904656.git.andreyknvl@google.com>
Message-Id: <7969018013a67ddbbf784ac7afeea5a57b1e2bcb.1563904656.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1563904656.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v19 11/15] IB/mlx4: untag user pointers in mlx4_get_umem_mr
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
        Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 753479285ce9..6ae503cfc526 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -377,6 +377,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 	 * again
 	 */
 	if (!ib_access_writable(access_flags)) {
+		unsigned long untagged_start = untagged_addr(start);
 		struct vm_area_struct *vma;
 
 		down_read(&current->mm->mmap_sem);
@@ -385,9 +386,9 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 		 * cover the memory, but for now it requires a single vma to
 		 * entirely cover the MR to support RO mappings.
 		 */
-		vma = find_vma(current->mm, start);
-		if (vma && vma->vm_end >= start + length &&
-		    vma->vm_start <= start) {
+		vma = find_vma(current->mm, untagged_start);
+		if (vma && vma->vm_end >= untagged_start + length &&
+		    vma->vm_start <= untagged_start) {
 			if (vma->vm_flags & VM_WRITE)
 				access_flags |= IB_ACCESS_LOCAL_WRITE;
 		} else {
-- 
2.22.0.709.g102302147b-goog

