Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B434050E62
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfFXOd1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:33:27 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:38033 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbfFXOdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:24 -0400
Received: by mail-vk1-f202.google.com with SMTP id u202so6487540vku.5
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6wOlIN9RCqtC4EMjbsO9NIyMZhz6XW377zGYJAhhjSw=;
        b=EdyxEJFnWG9rQS7GXNgeJyNTxEu5LtqPTYYbN/QLe+5zlbDexboGyDqBC815Hrokjj
         qfAzqSeaTKPFvVv9WWYIndqnAPiRljjB3TIDjGP/0IMssQbdVP4BzrpsfzCXDKI9BDHt
         WeSswvJDxczfbCTt3IQqYPH1jX0VOQ5O+GZOEn825FLst0HqKs8RjnFS0DrDqqOlKlcm
         +N5mzxkUilj5uw0wDqYjDhK1/db8t8dLQzbwnNuEhal4y8tjJfxP9svgAu0LB4ORTyVD
         OZMU426HgS0vYo8hjqCwVk8ERda/jHZQ5JXLr2v38JKqFFajbtzb+/rl5BB+KXJN5rjD
         80IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6wOlIN9RCqtC4EMjbsO9NIyMZhz6XW377zGYJAhhjSw=;
        b=sRwSTMvpruSOp3rRUHKE30D4QDy6oKsQ903TmHJwu4uttYIPQ92lIJkx4GT7tXTH4U
         AXIG1s+mKmfsu/yPx9rYUmUnwzhnrnxyyy+1w070vr+sbzeG/W0R5SNCxt+73+dIvFX9
         GY03X9iZQbNJ/SnmWVE90b6T4seXLaquy7K+sBHfCMQZT8wzd90maTZ+WdpanYGlqyTB
         /IPdsz3m806Nhd6eHUEMgfyFzLckSjiOxiQv6zqtVoi9Gi4l6QvWUk7cHq0GpTocUwQA
         CuPlrzwgunLSlNz8I41htHOWHvgzz31QaWA7h8UmMG2Gu1W7+LrVRXFKbOf8zGhKicIa
         Gj5A==
X-Gm-Message-State: APjAAAXHPedpbEafXi8BxBGeiJdKdIoBxxZZ8gPG2nCvrVy+Sditog7x
        wFcid3QERcFnpfuOSUdW17fi4iuJ0ZcEdo0v
X-Google-Smtp-Source: APXvYqypfx2HThdGezp/oUedjYKv44Fb8n5lNK45oyS/vOtxc58Rwt4c9Y+yK17e0xs6J7fV+AYN9l/kG2KmENab
X-Received: by 2002:ab0:5c8:: with SMTP id e66mr54849002uae.10.1561386803022;
 Mon, 24 Jun 2019 07:33:23 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:51 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <cf7bc20a86d45f690c211ebf284e9ecdaf6d4869.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 06/15] mm: untag user pointers in get_vaddr_frames
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

This patch is a part of a series that extends kernel ABI to allow to pass
tagged user pointers (with the top byte set to something else other than
0x00) as syscall arguments.

get_vaddr_frames uses provided user pointers for vma lookups, which can
only by done with untagged pointers. Instead of locating and changing
all callers of this function, perform untagging in it.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/frame_vector.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/frame_vector.c b/mm/frame_vector.c
index c64dca6e27c2..c431ca81dad5 100644
--- a/mm/frame_vector.c
+++ b/mm/frame_vector.c
@@ -46,6 +46,8 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	if (WARN_ON_ONCE(nr_frames > vec->nr_allocated))
 		nr_frames = vec->nr_allocated;
 
+	start = untagged_addr(start);
+
 	down_read(&mm->mmap_sem);
 	locked = 1;
 	vma = find_vma_intersection(mm, start, start + 1);
-- 
2.22.0.410.gd8fdbe21b5-goog

