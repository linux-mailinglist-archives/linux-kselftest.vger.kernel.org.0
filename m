Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE742473
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436611AbfFLLoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:44:13 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:52160 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438507AbfFLLoM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:44:12 -0400
Received: by mail-qt1-f201.google.com with SMTP id a18so14357201qtj.18
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eb4SnUCHaoFPTU0EqMrx7H6L5ANcvzM3zwsiyq0FV40=;
        b=UD79Ay48r+Qt/fUB4eQQS+u7jB3BFWRYtdLCt6Qa95VfLfmvvw7Hya/RkyTUwkhx0D
         +1vmB8M4RBQZbJNIhwkYxv5AEL21ErrNvQCQ8+lOs4BCA4LMOTjJTuV8BlTNIfNEsvvi
         S8RTYx74gNWKftQMTjEJ+kHo6ZnD8masl8ZG8ezS9xy8uaiMn8te593VaiscKSGKojp2
         e5Cc4FqtUoN3q8YTe+OydLtjYtDNOm5Wm5t/bbuGQhbg9sf44AZgifS6zPiIE4WlbsCF
         2CX+HbBHE4vO/HCGylKIpSsIsXiK8frsZe8Lb15lkTfFpYP5OsKznhL91S0FrbJQy23X
         yoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eb4SnUCHaoFPTU0EqMrx7H6L5ANcvzM3zwsiyq0FV40=;
        b=oXJo+1gdXM2DFWU5J1h3HNHWEpLaJnXaxTZAEGRFORdHFSv+z1ecupjmkzqZuiep3w
         OZwxcxRqN5kI7q9Tu3CHrfhN1myBWs1DgcHJfO/wtBvYhZS/wpwy78tHUbqgnZXxbDis
         ISVdcRYmFwJHZTzk3aDGQkWET/QsX/tx5XEVNRFQPxnNAdy8rjG7WlwgnxVrFTOTrP+q
         uCfjpihJNPMVIHxK21CFmtaKG9gSA8dKvILaCKEPdUjbY/SKCNMI01GZT+oTkv2TQFsK
         08lInEQUlIoYktjGxlCjTuOs7xz2y5HBp4rRSjPbnoiYY99dCUXVKXZKfpehFmMX4KeO
         Cp4g==
X-Gm-Message-State: APjAAAUAu0nkgBL86564myw368pAh3xJMMnd3PDD8eCXwQn3xmWGI5Av
        6URVOL/hGrfc+QJzrL9j/gQ4Cq+i3mg++UMm
X-Google-Smtp-Source: APXvYqziQbsGJB+s1a1ziaRcl+e8Gmo6MzSM6gFLtwRxsTnl2K0xyr2RS7DkrrH2w0nPz/f56zeYNt9ix1U3jsHZ
X-Received: by 2002:ae9:f107:: with SMTP id k7mr2472892qkg.215.1560339851579;
 Wed, 12 Jun 2019 04:44:11 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:28 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <50293fea168d5252f79ee0bf160c64c72edbf270.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 11/15] IB/mlx4, arm64: untag user pointers in mlx4_get_umem_mr
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

mlx4_get_umem_mr() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/infiniband/hw/mlx4/mr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 355205a28544..13d9f917f249 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -378,6 +378,7 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
 	 * again
 	 */
 	if (!ib_access_writable(access_flags)) {
+		unsigned long untagged_start = untagged_addr(start);
 		struct vm_area_struct *vma;
 
 		down_read(&current->mm->mmap_sem);
@@ -386,9 +387,9 @@ static struct ib_umem *mlx4_get_umem_mr(struct ib_udata *udata, u64 start,
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
2.22.0.rc2.383.gf4fbbf30c2-goog

