Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCFFF9E4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfD3NZi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 09:25:38 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:37308 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbfD3NZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 09:25:37 -0400
Received: by mail-ua1-f74.google.com with SMTP id w19so1927304uar.4
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CVV6psz/Vns5azsm7jZt0BKocrzPfr2CsD5f51mITmQ=;
        b=pHAUFUPIK00HUvs8fYzbfMDhOtYuRZOYj18jl6SUOemiz8hMuVoEwpyBcBFZsdPfRy
         CP69mD/DWkxSBrhRr7+Ao/OQBLtynTBk0B9gn31tW8yWHjU69Q7PB4ZDpgvtdnhUTEzK
         8CbwpHg2uux/P91ru8mr0G2/NpJ+DVwloVARu7ft7n27vA6hkWJDGMY1mugB3YmYuyhT
         OwmXeDxT9woV4yHQlsAA+KWTEq0dG80iCwsoH+0J1dhKu1C33LiknxZR75he7h2J78XE
         ZKdvpYjQpomJrWqZzF9raVXk6z/lSdaqbAYdD0YzglrS0vRmztdJidedrkfiqCqRVd3N
         hnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CVV6psz/Vns5azsm7jZt0BKocrzPfr2CsD5f51mITmQ=;
        b=c1RfCySxInrSgYNaNEz372/LQ3hFy23C5qgdjHDbtl8lJ8LtdDhigrPqiIajakt73P
         z4aJeTWJ8X44/HLomZDA6J9kaFZYIKiarSuccAUBH3ALTbfYUGV+ynGFo8hb9zEzNdju
         1vqm6rA/WPtgX5ME2o8/OC1CkiKW2ZRzwQam1Fp7Y1zXjbvIEfMvowE6dQiKnUcwiXCl
         BaKDYQzB0bWbVCS6UD7f8WNYI59RZ0sLrRUFx+66U3OfNTnqhNHjdhhcn/JsiDsnPvTI
         cACofHhQG5h0C1wabisKBePOtNv5q1/dxrG3B5SK/IXelR07cuZcOK4tF/hbHiezCVdU
         0S1w==
X-Gm-Message-State: APjAAAXRC0hUJWdCbdhXr8CcjGZ9hJXNy/5aJDkwTpOe88phP56BGYd0
        wXHgNL5UOLsHuNZemqH5KsQsumzWOiJdLUET
X-Google-Smtp-Source: APXvYqxbH0hW8IUGPJRsH+MKg4I9yJOI2DrUXBayHbDSUEVQsqLwVaAkxsd+/0KcP5RvItcIqz2adgVjyHXkB8kF
X-Received: by 2002:a67:dd01:: with SMTP id y1mr18718014vsj.39.1556630736057;
 Tue, 30 Apr 2019 06:25:36 -0700 (PDT)
Date:   Tue, 30 Apr 2019 15:25:02 +0200
In-Reply-To: <cover.1556630205.git.andreyknvl@google.com>
Message-Id: <80f7d6a2f68adb1c41ef5baf8973537380c681b0.1556630205.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1556630205.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH v14 06/17] mm: untag user pointers in do_pages_move
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
        Yishai Hadas <yishaih@mellanox.com>, Kuehling@google.com,
        Felix <Felix.Kuehling@amd.com>, Deucher@google.com,
        Alexander <Alexander.Deucher@amd.com>, Koenig@google.com,
        Christian <Christian.Koenig@amd.com>,
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
        Chintan Pandya <cpandya@codeaurora.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/migrate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 663a5449367a..c014a07135f0 100644
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
2.21.0.593.g511ec345e18-goog

