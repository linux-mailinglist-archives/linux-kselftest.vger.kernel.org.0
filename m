Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E402A3357D
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfFCQ4P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:56:15 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:49278 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfFCQ4K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:56:10 -0400
Received: by mail-oi1-f201.google.com with SMTP id a126so2222847oif.16
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UdKHGBZnbXnYOdacGwXVLbo2mp7I3OpbNnEy2rn9dE0=;
        b=aMwQlO/uqKNquhxQCaOybakc925QpZfJO8wh15xEZQIyCg72vlDGXrUg/ROAuoQDUD
         yCBHc/elg2gmmBaFllCt7o9fko/cMYEXNqMBN5Ib8jP974H6cgrFWFCLBOtmTziaRGQQ
         SwI/Xt1vXIDm1HuVmNbFHcArxU2bsmwx6xs/PbNEoDywCtOeBm47QoZ+wae08e7pzq/K
         a7mRKG2GqnFCVji4AY+94HQ5eVsYgsMp8E/PA4r/OPS0psFqvjDQbyz4YEbR/PgBj2Aq
         436HnabGuSm3Rvtg2LN9VhA8Rs2mRcn4xgL77EZC0LMuRu0EvZQAUUg9zFkbP9a8AWHr
         YN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UdKHGBZnbXnYOdacGwXVLbo2mp7I3OpbNnEy2rn9dE0=;
        b=kCbU+hjwmjv5DAi/Mrktc4ozo1StoV+M+pnOxj6zQVHSRl1R002W2WepWIJ99Uzxw2
         NZV8b8XoGdGJtbWkpyOXdGZxK0Efkg/6Ose47Ot9QJvS5NqguqGYH2FY+A4TPruHaGP9
         ONl2WuExLBozMyI6QLDI5BwHcfFh4czFWv8H+du/ysOeLWFs1uIG2XMpFUu1bzA4He8z
         Ae29OBwMJ3saZf08k/vZgcu/NIoSJ20Pv41VAl1Fi0/+c00/kxBtIrz6CPJkXRVudh3o
         M/mAmjWD/O+eF3pnLeiRzuKyqr/43PqFjEcASrC7XCqyaQHILZoF2s1254TmRJ23gQpl
         DyDg==
X-Gm-Message-State: APjAAAWmR5sfD3qcv0SUXX7+hg1wyWxWaaKBp1IHIcEL45duPorE7FGZ
        SkUwvweKvZW1Br1gRl+zGCzYVA2Nfhuf5FBl
X-Google-Smtp-Source: APXvYqxMjN/4yHR2ThXEEFJeDuxNxY18SC+MmNXgYJ7rlNGji/L0sGyo9f6aEs2c6lSgFUC7mMKDb3c6mMlyiMDt
X-Received: by 2002:a9d:4109:: with SMTP id o9mr1768838ote.353.1559580969728;
 Mon, 03 Jun 2019 09:56:09 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:16 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <dc3f3092abbc0d48e51b2e2a2ca8f4c4f69fa0f4.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 14/16] tee, arm64: untag user pointers in tee_shm_register
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

tee_shm_register()->optee_shm_unregister()->check_mem_type() uses provided
user pointers for vma lookups (via __check_mem_type()), which can only by
done with untagged pointers.

Untag user pointers in this function.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 49fd7312e2aa..96945f4cefb8 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -263,6 +263,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	shm->teedev = teedev;
 	shm->ctx = ctx;
 	shm->id = -1;
+	addr = untagged_addr(addr);
 	start = rounddown(addr, PAGE_SIZE);
 	shm->offset = addr - start;
 	shm->size = length;
-- 
2.22.0.rc1.311.g5d7573a151-goog

