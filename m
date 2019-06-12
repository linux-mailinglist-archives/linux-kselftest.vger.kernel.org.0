Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D593E42479
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438538AbfFLLoT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:44:19 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:35668 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438530AbfFLLoS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:44:18 -0400
Received: by mail-qk1-f201.google.com with SMTP id u128so13534738qka.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Tg03Gniv02ZbxFz4TR6ORKJ5z+YRDkk6YMGCeNMzVJA=;
        b=SFF/l4UFcejexpzLF8WLlQfmQ26wur6/Lp5UaETnaEcEawlk3l/6lGLaUMMooAgs8s
         H8BXtM8Po2kTy/ERZiKnsQjpEuZwCfivxhd6SyQ7RL+iB0sQfj/clPfIeMIPz6uKVDLv
         xUHwWlMKGfxD6gcgGhDGYlQ/8FvPYT93r6i2RnedCW6E6xVhUJOencUb8rKP9J6i4iHL
         r+rptZFaLXc6jhn3wSb4NX5Q2zQt78sd6zAnhaXM0vfZ1qtib0qyN9SWZBmopO4jCPUZ
         R6Ny3CDz7f0jULr5eWdVbsgq1nlATw+QzZpUThV+z5VYuwsEypjY/9FNseoLEmXCwIbk
         +Rew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Tg03Gniv02ZbxFz4TR6ORKJ5z+YRDkk6YMGCeNMzVJA=;
        b=G1CrBsqbTWAr5zA9TlqujzG38FSheq612SMRggu0TKMbqmRKnrUTlItwbLURCnBpNk
         2a3gbvqwqUmKZdTeFZ6stgdhJbdEEYTsjGpWkIWq5jpUHpMj0UU5dd9XTRU5/lXnP70m
         dXeuLj/7NVSly8/HeT/EvSnkpwKCg8tOnlLJFLC+IiczXFnKM0DpU4ym8fSZYwSeA3ic
         36RSSmrZ67nwKZ6n2pTgu2yBMcukwVFfNMBAG4FVSFzinOtKfweCDdHMbW3uos06Qqja
         cRcdabGSiwOa/vqV7TdpB7LXCo1rUUcuJ4Qpyz7pBsFeUOYuFPLvecz0bn0IqPWQxrFp
         4qTQ==
X-Gm-Message-State: APjAAAXBvSz0nYYJDn5tMZ2J5Culk4+cnV6x5OdzP03i409CFZXEPJ+Y
        VmkuRkchgOIujlf4nFTIla6s4LkZgtQngWqJ
X-Google-Smtp-Source: APXvYqyCeVb0C2VnUmKvZl/NXpmzEb8PXfZVfFDAeRPGCnyVezO7o0ITR/pw5X1cgaGDH/zdBw+sIaHhGO7/u0mq
X-Received: by 2002:ac8:5485:: with SMTP id h5mr67932284qtq.253.1560339857730;
 Wed, 12 Jun 2019 04:44:17 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:30 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <9d68d9e7f9f89900adb4cb58c34ffe532dfb964a.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 13/15] tee/shm, arm64: untag user pointers in tee_shm_register
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

Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/tee/tee_shm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 2da026fd12c9..09ddcd06c715 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -254,6 +254,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 	shm->teedev = teedev;
 	shm->ctx = ctx;
 	shm->id = -1;
+	addr = untagged_addr(addr);
 	start = rounddown(addr, PAGE_SIZE);
 	shm->offset = addr - start;
 	shm->size = length;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

