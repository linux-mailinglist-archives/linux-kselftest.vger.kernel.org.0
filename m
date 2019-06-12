Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6A4246B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438445AbfFLLoH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:44:07 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:54398 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438469AbfFLLoG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:44:06 -0400
Received: by mail-yb1-f201.google.com with SMTP id p79so15119236yba.21
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=49lyybNUomf5TPPaYx2MdHbLNYXxhntLqw2Vq4fwp4Q=;
        b=ihFwqktAIqrJiTQwTjUhK+MAdfOsiouWKHqO7ZjSSZRmzOCHa96d8VJOaNVIZNxAcO
         AN6aXPp/RE1MrQ6zM8JJXD7nVRwFFfp5nOw9hthmPYYo49089cBtVFaOKAL5CUs7PfyJ
         QVJHzuksJxoSuikR4fgviWI+uxOP0qQaG3AiODD2sa8fpyWPMeWsTelFk8q9IMn10OKD
         +UNh5Ci6TXkOO1z7q/a2BisVOKAv5AoSV7//DSqtdeKoVvYLLBYkbZ3uB0cH3pp+Kewb
         rQGpoPMvtpdogBshUOOc5uWdI95iNZkAb+XnamPk3rh+8KJ/cKljnQO2b6iriftiFlMR
         wRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=49lyybNUomf5TPPaYx2MdHbLNYXxhntLqw2Vq4fwp4Q=;
        b=O9tDJyanKuxG4STIAq8pG/L6Fg6iRngQS3nrvjdSWT3b+D5T04zSoFZcJxC75lG6HS
         3gPkI5J8TXsFVkpGldLoKudSpPMDoh+FSCw2lN5br3SqUDkG9LHxPM2bfombtjUcjF0C
         zJ14csISJWX8i7/1KHN0vSs6HSJNi0zb4MMcq91VvmJr/lnYJKjuAasWhFPj0/Zhy1+C
         gFXgj3dbJ8wTPBfSnJU3HjLfSAUHaM8Vl60XR2HKRzY1hWm0eRBC1NzItFeGwpOQFfYs
         m4ySz4fEZRNPlw0mazKd0AvuDm9Zgry+b2VtjBmt7P7zD9t8EbIidWZZUL/rbIt4YgaX
         hKOg==
X-Gm-Message-State: APjAAAUYVBcHaNzlDJrCgQMfMzICktclTQXPw2Sumyb0mWf4AokiyFCy
        aCHQNbEK5LY7CRAeHIoOde72d8NIVMv03K8O
X-Google-Smtp-Source: APXvYqxF+/T3yPkem3l6CI+bv3/rmqxcJMbV/vABJbuoyeQcWj2Unps+PKPx2+cODkSgswAOZakXvU9OwOpzOWtl
X-Received: by 2002:a81:2717:: with SMTP id n23mr31165867ywn.423.1560339845094;
 Wed, 12 Jun 2019 04:44:05 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:26 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <d9cbdcc3c4926bf70fe0014110901a0755e8e869.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 09/15] drm/amdgpu, arm64: untag user pointers
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

In amdgpu_gem_userptr_ioctl() and amdgpu_amdkfd_gpuvm.c/init_user_pages()
an MMU notifier is set up with a (tagged) userspace pointer. The untagged
address should be used so that MMU notifiers for the untagged address get
correctly matched up with the right BO. This patch untag user pointers in
amdgpu_gem_userptr_ioctl() for the GEM case and in amdgpu_amdkfd_gpuvm_
alloc_memory_of_gpu() for the KFD case. This also makes sure that an
untagged pointer is passed to amdgpu_ttm_tt_get_user_pages(), which uses
it for vma lookups.

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a6e5184d436c..5d476e9bbc43 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1108,7 +1108,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		alloc_flags = 0;
 		if (!offset || !*offset)
 			return -EINVAL;
-		user_addr = *offset;
+		user_addr = untagged_addr(*offset);
 	} else if (flags & ALLOC_MEM_FLAGS_DOORBELL) {
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d4fcf5475464..e91df1407618 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -287,6 +287,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
+	args->addr = untagged_addr(args->addr);
+
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

