Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDE050E42
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfFXOd4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:33:56 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42248 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfFXOdv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:51 -0400
Received: by mail-vk1-f202.google.com with SMTP id y198so6468615vky.9
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/YALAWfXM1Ec4B1lOAT/D+NA+cyFiVncn64tZ/r98OM=;
        b=Ql48XStLri/shxEZnh2m2bPKZuWW0LbLVZb7Ke39XzoW6tnlHJqvY/w3tAOiQXd+HY
         +m0w0vy4Nc92IOCtwaAefDtVWKaMPae0qEokqCFh/15Etg3mPj9l+0y/QojMsq+32GDL
         FCc4x1guuctj7Dh9w2rpqoJJMnqXSJhRdYAnuBaH1m5ApCPzHjNZOJsEgqVYOMqcq1IK
         z4bmcgqikB0YNciNmYj3+oZnFq+Z3IRAKc7+MbjrKJ0m2yo/N7qQZlR4Wduu+I3SYaAM
         An3oELmPbKJBGAW9gnsznPT0Ku3QQIngN9+ygpAFQEEHuUfYflrAf46HUzwiWP0xvwhX
         EWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/YALAWfXM1Ec4B1lOAT/D+NA+cyFiVncn64tZ/r98OM=;
        b=fx2JnPkf9L4pO1x4a0zMtJs8Fi3nHBrY8vYLQCPVELzG6r5T0wd/d7m9lIeENgaCQP
         CkQciql9urHsL+4rh4rMX3WL9+DY5YmzqBDxgqR6JUGXcQdPU00bUrosbhddUV1ust4r
         uWQf5mc9UF9Aa+vADKutanNQexXsOY7GrrF819C7EUkWQPm2/Lat2M9xkUFBFmczUt3D
         fPtPTNZgN5Y/Ha2RNwo8aokayNDME21tj7YQf+/gws4koNGc5tL7Bw1COtglUI/9Jmqn
         Nzhu8mngKxVyFnpAnnE2YdeTZiEP+t/ByZ31IBNCBK0H9Mr4r/YAlyGgBBax464OmOEq
         ay0g==
X-Gm-Message-State: APjAAAUz3UuyXNUssZ3WiVVPyojTSmXsouHHxwoBhu9Ri/NpKIBkLK+b
        vBLwO2MQCZVpTzNHEFSfVfg3vd7N71/htbfd
X-Google-Smtp-Source: APXvYqzcPL+MfuI0G9Nd/HSZW5720Hxob5Qe3sb32I8/yavc0Ub0kNUbvXmDnUxRuwL2tRyo+O0TaelZxw+BF2mv
X-Received: by 2002:a1f:7dc2:: with SMTP id y185mr1688822vkc.51.1561386830607;
 Mon, 24 Jun 2019 07:33:50 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:59 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <125994bfab8f29da8f58c8fcd0d94ef4bf55b3ea.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 14/15] vfio/type1: untag user pointers in vaddr_get_pfn
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
        Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

vaddr_get_pfn() uses provided user pointers for vma lookups, which can
only by done with untagged pointers.

Untag user pointers in this function.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/vfio/vfio_iommu_type1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index add34adfadc7..7b8283e33d10 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -381,6 +381,8 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
 
 	down_read(&mm->mmap_sem);
 
+	vaddr = untagged_addr(vaddr);
+
 	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
 
 	if (vma && vma->vm_flags & VM_PFNMAP) {
-- 
2.22.0.410.gd8fdbe21b5-goog

