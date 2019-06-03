Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0DAB335C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfFCQzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:55:38 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42991 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfFCQzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:55:37 -0400
Received: by mail-qk1-f201.google.com with SMTP id l16so991748qkk.9
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=luHVeQDtsejNe05MbpEHIJ5FAOspLsm1rW4+f3IOXdc=;
        b=ew82e7NzIq+8fpVjdyGeAl2NjSKK4p0nGZ5QsTZKvqtsLjuuAXvE063KXb+pD0cHy3
         33+cPut/htgPr27GTzwOcJ20GBX2Ux9NssttTzwHChq9HvO45Yd1WsNH+qMaKhyQDDTc
         D+9zMoo5SrYePAGdOkXZXmMQhF2t0ypsOVpok1EOYB7sNktF/Rh9uldB40uKjOJapI1g
         axLdF69gRV4YSFbj/UQdIsHxS2aGe/kJaiIGVBIH5qRmQS2qsSWYGny0rQfE2+NQmVfF
         bjXTeOgusRer2Jz6pFuYk/PEgndLJQ02z9T1gNTKOM3uuFHRlwHl2aCc1w3EkCHnhf6g
         ZiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=luHVeQDtsejNe05MbpEHIJ5FAOspLsm1rW4+f3IOXdc=;
        b=qkeXpZvFfERMMmp74cBG4khuscaujxChRiJAAA7y9gCp68xemt6kCgHSSwEoIgxJ/Y
         NQW7XZiqW1YPTTa2b7w0EvJEu29mTW88hPoSyca8vPN6Bqocsg3o1d2LYniH8b0UR/As
         pwkOBmOzmcgS1MHxtEsQXzoYqCfq408qLPeMxGM+JBeBo19wLszFlbCuqMDmpPrRslHe
         ve8nyNHVB12Lh8YDgMqZOV7DQli4PFQ89PKltai/mkVU7xhdPRMrSOVLnGvDeknm3VLH
         Hsse/SObtboAdt33COD6hAj1dtiCdkKM6vaxvI6pe2REawv7BDHYU9TWLn4wds5ylpIF
         JIxw==
X-Gm-Message-State: APjAAAU9O6kyg0MHfrBgQhxZFOblMe8FF4y4lxw+ztrAJ3e0QP+UFuQF
        JpW5vVgu7hlxoiEfZUwXFmP8ReTmMM5YOWwZ
X-Google-Smtp-Source: APXvYqxWajnT2+NV3xTud3R56ZNhfS6I5UrUDe55n3y1jJe3OWUToUGKN+BmVqJ0YCPX/M4xXQWJhyPq+bf/72n5
X-Received: by 2002:a0c:ad23:: with SMTP id u32mr3896810qvc.39.1559580936412;
 Mon, 03 Jun 2019 09:55:36 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:06 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <e410843d00a4ecd7e525a7a949e605ffc6c394c4.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 04/16] mm: untag user pointers in do_pages_move
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

do_pages_move() is used in the implementation of the move_pages syscall.

Untag user pointers in this function.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index f2ecc2855a12..3930bb6fa656 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1617,6 +1617,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		if (get_user(node, nodes + i))
 			goto out_flush;
 		addr = (unsigned long)p;
+		addr = untagged_addr(addr);
 
 		err = -ENODEV;
 		if (node < 0 || node >= MAX_NUMNODES)
-- 
2.22.0.rc1.311.g5d7573a151-goog

