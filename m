Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2797515195
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfEFQbj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:31:39 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:52453 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfEFQbf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:31:35 -0400
Received: by mail-qt1-f202.google.com with SMTP id f14so8471390qtq.19
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RiesdCLpp+R0f3O9XnLGGd6rw9hYPfKFlydZlXAyMMc=;
        b=Q6QAvdDCFNZuLS9ja3NkrMR3RvJ0S09G7HKj9q0ktYjp11DSu6sbwte4Z+MCgpdXSa
         OGL0kcCil/ti4co+BeFvhTmmJ7+RXsHFsfK1hhHv1eec6VZbNopqVkjLet50ydoaeiwT
         XvmlmBaXIzsx1T6Dyaajg7Bz5pq9Axsw6cJNm2DtIdCFs4IeQzb8CYH1eWRXRhTqPi8L
         9AZ0ieEA2P7xzH+IK3hHC6FzJl7z9XjQD9wvxFqfvRNHuz4Kvz+PKDcTznem4kO3i/YF
         7eAO6TlPEh3PGwlYJ/3xngzxB39JPbQ+aqDHIcDB8TtrzW/euZk2kR1+K4+g3OqdGfdF
         qJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RiesdCLpp+R0f3O9XnLGGd6rw9hYPfKFlydZlXAyMMc=;
        b=UiPLbO+fz8Ggfpi6R6AYLbf25iwbpOaGa4AEKawCw9Q8ICmMdlpxi0/wru0mj5LG52
         fDCrUTVwwXvKHKvajZGPySucmO+CZSD66jNCap+wfPZhoXcp6DNrmxi1iFPnq8cV4oM8
         Z6Re4tgNYQyyYe+01tXEWz9OMwMheJ8HvUwUlcKXYtzLBmFOx/2fkR/aAnPSJBWUh+L8
         QOSN56y8RNx5ml/GWlvP5o+4w4ZouOAv0WqhEkBuBS4fG5p9JMmg7DBiP8S7+0IoT6vE
         u4y++TEizyYjH+wqxY7IQueOFZQjMWOg8gh3GYMDiE/aABGqjJQnwjwUg8pNyKHdoRl5
         y3UQ==
X-Gm-Message-State: APjAAAVh+2gQ8oowu30Pko4iTCx0V6qZzf4u+dYJyHqi2iWQPUT9Geaw
        vqnSAA7zqfnHk0/DoC+7PWMd7CZcQqV8T+t9
X-Google-Smtp-Source: APXvYqxNt6uYI1SB2jQypHitLB3ZO6cfBHn8QWvA0b8eMRqYbeBN0u2XyLJdNX/EJB3bCPY6PcnOySobJPUt2l9F
X-Received: by 2002:a37:9ed6:: with SMTP id h205mr2433459qke.152.1557160294772;
 Mon, 06 May 2019 09:31:34 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:55 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <ac2ca3454b1ae8856ea2e29a1316fea50a30c788.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 09/17] fs, arm64: untag user pointers in copy_mount_options
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
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch is a part of a series that extends arm64 kernel ABI to allow to
pass tagged user pointers (with the top byte set to something else other
than 0x00) as syscall arguments.

In copy_mount_options a user address is being subtracted from TASK_SIZE.
If the address is lower than TASK_SIZE, the size is calculated to not
allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
However if the address is tagged, then the size will be calculated
incorrectly.

Untag the address before subtracting.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c9cab307fa77..c27e5713bf04 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2825,7 +2825,7 @@ void *copy_mount_options(const void __user * data)
 	 * the remainder of the page.
 	 */
 	/* copy_from_user cannot cross TASK_SIZE ! */
-	size = TASK_SIZE - (unsigned long)data;
+	size = TASK_SIZE - (unsigned long)untagged_addr(data);
 	if (size > PAGE_SIZE)
 		size = PAGE_SIZE;
 
-- 
2.21.0.1020.gf2820cf01a-goog

