Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6161D15155
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfEFQbm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:31:42 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:35562 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbfEFQbm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:31:42 -0400
Received: by mail-yw1-f73.google.com with SMTP id r23so9677722ywg.2
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=djVJuNgpi4hl4AvZn47gmwsvHOuvfT3jzvA6F10IO5w=;
        b=fxyQnlZpVUSYjQyqKRvVjTFbSpnAaN40vHoDyTt86Wr9XkiWv6H47O5fV6+YfqSjKb
         ya9LAHunO5tkq38NxGwIBHRUa8t3xRmbLIMp/Ei/Ay4bKwx0V2sP2cpbt1VZJxkDe/I+
         9QcnUwoNsbvRkE6TQ1eqETcSj1FHDhcRF+86nS+29Dm7yx2+fQzWUL/UiXGimZGBqjEk
         x92RLHdIO29i4yL8cPFFrUa5OfqGP4F8w4+T2ndS2TLCjkCTICe9DBa54uexWvxllQFG
         iUS8CZcMLYnxYz/mG/GVZOcto/nPYEof7WD9aPSyYBI6CjVI7kE5mMY0QntuPkboh2oc
         AONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=djVJuNgpi4hl4AvZn47gmwsvHOuvfT3jzvA6F10IO5w=;
        b=qpXvtyic0cGusbL8AFTKANGvYjOjlzS00JGvw9sdw81oXl8/RjSqY88zcl9lB5oeoo
         V5xScFkjEDI/7kcmwYIyJM4330WT/ySVxrxkB3Hd2tthqiijewxGzfXu7wLOWXDvsjDN
         qGICm52g/a0PXOBxfwVRcLNp+w8PTS/hJAx3grJWRkypph3zQQxn0lEmbDYikFE3MLZw
         oH6S9ZjK9wbFrAoF+5QJLay1kOim8x2+U5jBNSBVauq0sJp75KndM2ASUWvj06uQcfeq
         rkLtw82y7E8RSTKhp9vXijYvcD6a0A5TuATBlQ+uhxR4wzF5/zmVQPXQVdzpdSOp1qhj
         iiQw==
X-Gm-Message-State: APjAAAUrLbXLcaYduLTJzOMSp0FyoAoUJ2iqZ/jPT/kkESSC2b0yuhWh
        808qV/bLhPKAuZgRERC6+W6Gw+toY2CCYlVC
X-Google-Smtp-Source: APXvYqw1IXBcBTBvqlPhK0DepGTPQ34Nul5KO/wJ08CLzILZcvtlszbJT4QAmRZRcoo1MWPuYSMoe4MfIRPtaEwV
X-Received: by 2002:a0d:e60d:: with SMTP id p13mr8305580ywe.155.1557160301102;
 Mon, 06 May 2019 09:31:41 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:57 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <84676a97cec129eb7a10559ceae2bec526160ad6.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 11/17] drm/amdgpu, arm64: untag user pointers
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
        Andrey Konovalov <andreyknvl@google.com>, Kuehling@google.com
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

Suggested-by: Kuehling, Felix <Felix.Kuehling@amd.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 1921dec3df7a..20cac44ed449 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1121,7 +1121,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 		alloc_flags = 0;
 		if (!offset || !*offset)
 			return -EINVAL;
-		user_addr = *offset;
+		user_addr = untagged_addr(*offset);
 	} else if (flags & ALLOC_MEM_FLAGS_DOORBELL) {
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index d21dd2f369da..985cb82b2aa6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -286,6 +286,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
+	args->addr = untagged_addr(args->addr);
+
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
-- 
2.21.0.1020.gf2820cf01a-goog

