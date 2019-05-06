Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10798151A8
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 May 2019 18:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfEFQbQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 May 2019 12:31:16 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:56591 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfEFQbO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 May 2019 12:31:14 -0400
Received: by mail-oi1-f201.google.com with SMTP id e5so4511751oih.23
        for <linux-kselftest@vger.kernel.org>; Mon, 06 May 2019 09:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/Xcm/dv07E6tB6Fg+Bd1uLrNx0q2WagwUZqys5y8XCQ=;
        b=rAOt6QkMD/QKlKVog82fKw84EsQnaASzO/nI8W5EIDbrmmjV3gr6+15mZ10SMb6Rf5
         i/ZniLNvWV//CPRfADxSnSKtN/6Gg017m4Gik6Cenllh7RN6CfI/AKj72maW2yKQfmpN
         GrE1GcO1EKZaX0U+I3FWYiw4misL8V2knxuMTZnhd7+ifYq/drNNa4087ayYcqsu4RzV
         YnDg0sSjmZfX/PgQJ/vdVYIZT3u95MTKmAQy8Dfp2UhL6OXfBsqkSnVsPRCgY0ZcNTeM
         d3f8I7eWT+VKLfqWWZufhZUUDge/eC39ycIbKQ1fqVyQEg05Z5H0MBzHuW0wC/j81BOZ
         a7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/Xcm/dv07E6tB6Fg+Bd1uLrNx0q2WagwUZqys5y8XCQ=;
        b=DRLeTGn990PLJ1jCnpmS6UEEQ5XNXscOOjjr1rdwjmdR20loNrtlZjfyLxJbprODiQ
         kM1pJ80Zo1Td/hkKWuWdlhqDUTU6oBsi8HQUbEi4KRfYcpvocEo2l4gm2JEMMFMZNOfO
         vKzDnHc9YW5ssWAA5+31fSYnkMyXrGgL032N6/c92p+m467xr6mypLj0ywyh8qNDBqnK
         cRjYpOJWCIFAbJvIBErlYNJPKgmc1cFN3BClPCO7xFPz3htyjwIcX6nAk7p650RgE+Eu
         +1tyY0fHB5brV9mgQHpnpqup0MVcVbenQRSvokE2YBfGuwxNp4/l3Lf0aTQcrFQ21NkD
         +J8g==
X-Gm-Message-State: APjAAAWfcErlRxmWUxjUR+Ii8a484f0Vxg5Tkv9io1w7WFKXFQhaL1cL
        GehXFIzWNnqyjpsnm6BmTH4VnvXVQXvWLYKk
X-Google-Smtp-Source: APXvYqwsU29/a5rUuddp5tcfbPS3CQhzs1NWwE9FVJC7oUUpeYui7bu7Qsrr1jpZGFt27bCra6fHy1EBLcG5J9Rk
X-Received: by 2002:a9d:4917:: with SMTP id e23mr17423724otf.63.1557160273461;
 Mon, 06 May 2019 09:31:13 -0700 (PDT)
Date:   Mon,  6 May 2019 18:30:48 +0200
In-Reply-To: <cover.1557160186.git.andreyknvl@google.com>
Message-Id: <02e1242715cc1bf23a139e5e8152fb4feaa4b41d.1557160186.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1557160186.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH v15 02/17] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
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

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Note, that this patch only temporarily untags the pointers to perform the
checks, but then passes them as is into the kernel internals.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index e5d5f31c6d36..9164ecb5feca 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -94,7 +94,7 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 	return ret;
 }
 
-#define access_ok(addr, size)	__range_ok(addr, size)
+#define access_ok(addr, size)	__range_ok(untagged_addr(addr), size)
 #define user_addr_max			get_fs
 
 #define _ASM_EXTABLE(from, to)						\
@@ -226,7 +226,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -234,10 +235,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
 	void __user *safe_ptr;
 
 	asm volatile(
-	"	bics	xzr, %1, %2\n"
+	"	bics	xzr, %3, %2\n"
 	"	csel	%0, %1, xzr, eq\n"
 	: "=&r" (safe_ptr)
-	: "r" (ptr), "r" (current_thread_info()->addr_limit)
+	: "r" (ptr), "r" (current_thread_info()->addr_limit),
+	  "r" (untagged_addr(ptr))
 	: "cc");
 
 	csdb();
-- 
2.21.0.1020.gf2820cf01a-goog

