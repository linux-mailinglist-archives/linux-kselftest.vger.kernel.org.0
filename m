Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D986742462
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438428AbfFLLn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:43:57 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:38581 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438424AbfFLLn4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:43:56 -0400
Received: by mail-yw1-f73.google.com with SMTP id p76so4631110ywg.5
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YVD/WVehggR5Wc73HNU/6Lbl/J+rO7t+BXcE3PMRRDE=;
        b=hBGTTVG6ghhZ3+0guLELKJ8wGbky2Qh0tZY2BONpI+zCvbTSjhlIF7W0/JokOx5TzR
         VO5Rbf4FBD1McYuvKbubXsd/VFsD/O7BipMIP18RAMdpnsTMlCRbLlZbiP7oKXwSNsh/
         7N4rlsaJS9M2NXxtFUlEJJPsr6p+or/nlT4Zv12ZmDZup6gUVLdgoPgHeFDcpmGNRrjd
         3ALIrSuYojaH/pslqsc0jXMozZhljZkCeYnT4XFg9eFUPMSJzEQdr0RcX9d6uIudOkk2
         t4M2C4U//NS1sNKKoHlt+ReZpRZW4iLnE+17ISBaStJwmRniOrfV+Za5ClmC/tGhrMxn
         H1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YVD/WVehggR5Wc73HNU/6Lbl/J+rO7t+BXcE3PMRRDE=;
        b=triARbA/dkKt3H0Pnms3gCE0adWPzZXTlUiKwruRujxxyj/67pOi77nvDEmJk4AE6R
         aP2U0gCy7VgMxo8kaYXCO0lo0fJV0jGyksmuiC6zQsZChpk37uvUZllhlB0VtUuMTEGo
         9kQbXNOXrtSBSB+oJ2G0eUqLLR3QQJxZI1pNZY/GKW6JwEY8YPTB60Sc4SSk6p7EfuAr
         4vS9n6s/klA0WpQB6Inb+JdUHMIczQIrt4QuSMYzPqW6x7HuFb3u3DgMLT3yLc5E6Ioe
         rDrKTZJIVWx4BIljAgdtpt8+LlqANdGymVPCqAoD8rd+/5J0f3kx9sXpfr+pY1OeEmLE
         A5sQ==
X-Gm-Message-State: APjAAAVEGjSlgqCP903nJmKwm1LP6VR8DxoMJ03ujt0nQONM5DmVLWII
        4baxeRvVjRdjBQ+LsB8ikYuJ4B9rMGg31MzW
X-Google-Smtp-Source: APXvYqzC8DIDqxpBDUE3Cs2MqoYPwBYxauFh78Yi9sE2QOVumKFBSV5WM5ycdrw0GZ9JIDvcxx34zgkY7MRSX6GJ
X-Received: by 2002:a81:9947:: with SMTP id q68mr46506819ywg.197.1560339835908;
 Wed, 12 Jun 2019 04:43:55 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:23 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <4c0b9a258e794437a1c6cec97585b4b5bd2d3bba.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 06/15] mm, arm64: untag user pointers in get_vaddr_frames
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

get_vaddr_frames uses provided user pointers for vma lookups, which can
only by done with untagged pointers. Instead of locating and changing
all callers of this function, perform untagging in it.

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
2.22.0.rc2.383.gf4fbbf30c2-goog

