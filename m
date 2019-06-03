Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06A5B3370C
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 19:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfFCRqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 13:46:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40615 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbfFCRqW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 13:46:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so10417372qtn.7
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3YD9QwJxecxdMHZGSRuYOcVyiXHhODdQ+7hG9X3IFEc=;
        b=Y8xQhEUl5VIp1CHI2GNhUWumFeridnSrDVLR4ophf+TEEqb9RYCBYUuzTaKnpS0N95
         PodsZw5QrRzXwcVAdLU8QbPx8UtppQyKINjpafz63KgI0mbZL1RBR/HG+Aw16qS1mL8x
         GbfoGarwImiN/E4mJOvSlkb1cLIeV/RY7kSfMlxm7UZhj+NafqRJ9xFMGOVfHXfBQNL8
         3KhvQIu3nzrYZ9gVumHcKZbTTOBDGZbVoC0PmchuHZfBO5itRE+CWVGivs8JV9Bdb68S
         oKMm5wdMIjQdNVuG5jJ5CkpKuMh+/TZa/xggfv/76T6HlvfgScQBIZzwwZTZ5LwtflBg
         nfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3YD9QwJxecxdMHZGSRuYOcVyiXHhODdQ+7hG9X3IFEc=;
        b=iT5LzBV/nO1uUtoUur/KeB05ULyjlBWq6Xdhlw8dqPa3m5/HiinnBCiubngzDVjtQr
         a+wnbE+ESZ95UPrB+gV1niN38KYXP7QMgkSL9w4/GbgTZbL1khDk8zOoKGu2VAArRbPe
         8YyYpjMhnd2hMGpWy25TeH7/z5A9RtR/DNhm6NiGgKuzNzz3YQjpQd/lzpeWLKPjyfvb
         dfdlKe3YZotNXloxQH8/bxsDx+qQrkqQZFBgdRCC8jCIy0FoL/UV16Vr/R9hgqPRcXYh
         gyIccm2pOWtXSK1nVoSevSuBmx5flRydZKQGqFcf3w3ql3R3whXm74pGeR/u1SQkIQvW
         9qSw==
X-Gm-Message-State: APjAAAX/pwkV7JcNBbBoV9nu+PZn1F8a93wAOynA7o/0UCLNeLW2A+Eo
        SBJmEI45AhMmtFL6U5+PRGXt8A==
X-Google-Smtp-Source: APXvYqx+ClbIfZmOUdY0b04TFbjW+3r9mnjIe7N0zaIfZmDOHWubw4QUOroagi67b9WugppzpkzydA==
X-Received: by 2002:ac8:7381:: with SMTP id t1mr24802701qtp.387.1559583980558;
        Mon, 03 Jun 2019 10:46:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id m40sm12874710qtm.2.2019.06.03.10.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 10:46:19 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hXr2J-00032t-AT; Mon, 03 Jun 2019 14:46:19 -0300
Date:   Mon, 3 Jun 2019 14:46:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v16 12/16] IB, arm64: untag user pointers in
 ib_uverbs_(re)reg_mr()
Message-ID: <20190603174619.GC11474@ziepe.ca>
References: <cover.1559580831.git.andreyknvl@google.com>
 <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c829f93b19ad6af1b13be8935ce29baa8e58518f.1559580831.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 03, 2019 at 06:55:14PM +0200, Andrey Konovalov wrote:
> This patch is a part of a series that extends arm64 kernel ABI to allow to
> pass tagged user pointers (with the top byte set to something else other
> than 0x00) as syscall arguments.
> 
> ib_uverbs_(re)reg_mr() use provided user pointers for vma lookups (through
> e.g. mlx4_get_umem_mr()), which can only by done with untagged pointers.
> 
> Untag user pointers in these functions.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>  drivers/infiniband/core/uverbs_cmd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 5a3a1780ceea..f88ee733e617 100644
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -709,6 +709,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
>  	if (ret)
>  		return ret;
>  
> +	cmd.start = untagged_addr(cmd.start);
> +
>  	if ((cmd.start & ~PAGE_MASK) != (cmd.hca_va & ~PAGE_MASK))
>  		return -EINVAL;

I feel like we shouldn't thave to do this here, surely the cmd.start
should flow unmodified to get_user_pages, and gup should untag it?

ie, this sort of direction for the IB code (this would be a giant
patch, so I didn't have time to write it all, but I think it is much
saner):

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 54628ef879f0ce..7b3b736c87c253 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -193,7 +193,7 @@ EXPORT_SYMBOL(ib_umem_find_best_pgsz);
  * @access: IB_ACCESS_xxx flags for memory being pinned
  * @dmasync: flush in-flight DMA when the memory region is written
  */
-struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
+struct ib_umem *ib_umem_get(struct ib_udata *udata, void __user *addr,
 			    size_t size, int access, int dmasync)
 {
 	struct ib_ucontext *context;
@@ -201,7 +201,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	struct page **page_list;
 	unsigned long lock_limit;
 	unsigned long new_pinned;
-	unsigned long cur_base;
+	void __user *cur_base;
 	struct mm_struct *mm;
 	unsigned long npages;
 	int ret;
diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 5a3a1780ceea4d..94389e7f12371f 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -735,7 +735,8 @@ static int ib_uverbs_reg_mr(struct uverbs_attr_bundle *attrs)
 		}
 	}
 
-	mr = pd->device->ops.reg_user_mr(pd, cmd.start, cmd.length, cmd.hca_va,
+	mr = pd->device->ops.reg_user_mr(pd, u64_to_user_ptr(cmd.start),
+					 cmd.length, cmd.hca_va,
 					 cmd.access_flags,
 					 &attrs->driver_udata);
 	if (IS_ERR(mr)) {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4d033796dcfcc2..bddbb952082fc5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -786,7 +786,7 @@ static int mr_cache_max_order(struct mlx5_ib_dev *dev)
 }
 
 static int mr_umem_get(struct mlx5_ib_dev *dev, struct ib_udata *udata,
-		       u64 start, u64 length, int access_flags,
+		       void __user *start, u64 length, int access_flags,
 		       struct ib_umem **umem, int *npages, int *page_shift,
 		       int *ncont, int *order)
 {
@@ -1262,8 +1262,8 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 				 attr->access_flags, mode);
 }
 
-struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
-				  u64 virt_addr, int access_flags,
+struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, void __user *start,
+				  u64 length, u64 virt_addr, int access_flags,
 				  struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index ec6446864b08e9..b3c8eaaa35c760 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2464,8 +2464,8 @@ struct ib_device_ops {
 	struct ib_mr *(*reg_user_mr)(struct ib_pd *pd, u64 start, u64 length,
 				     u64 virt_addr, int mr_access_flags,
 				     struct ib_udata *udata);
-	int (*rereg_user_mr)(struct ib_mr *mr, int flags, u64 start, u64 length,
-			     u64 virt_addr, int mr_access_flags,
+	int (*rereg_user_mr)(struct ib_mr *mr, int flags, void __user *start,
+			     u64 length, u64 virt_addr, int mr_access_flags,
 			     struct ib_pd *pd, struct ib_udata *udata);
 	int (*dereg_mr)(struct ib_mr *mr, struct ib_udata *udata);
 	struct ib_mr *(*alloc_mr)(struct ib_pd *pd, enum ib_mr_type mr_type,
