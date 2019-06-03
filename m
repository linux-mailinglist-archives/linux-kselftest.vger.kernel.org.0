Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFF4335C7
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbfFCQzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:55:31 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36245 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfFCQza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:55:30 -0400
Received: by mail-qt1-f202.google.com with SMTP id i64so8126932qtd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TMNTkBlmDGgOOZrctIfCYuVqOYCJYB+OoUZL57F6fkg=;
        b=KWmY1/MTf2lCSA8LP774r8p0/RElUafoWRXpiTV5M0FssBvd2DR+JnorkPH/h4Y5+f
         yR9XiiiNdq2i4QfOjofZ58b2UAQfK20Q+cucasNJuK58SVUF0twT9Bg5tEaVarSUnpM0
         CkXfb2ETfWkZvMjhhmX2MfDgGW4xKH4IotNUPi45ZU95oK+BdGaJ73sBg/cX0kzx4m8b
         MubK1pKIg9ehFkgM51KidZa6DmQaV4zELWE1kuJ9QUfecA/WQ31VKLS+QtHdLvI4uobs
         geOOZXZ26xHTUKbG4mCrjgzhEEUQSTlmmrjiggpRSIEqoJXM210SSB6rrtJIQUmyJUQs
         1hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TMNTkBlmDGgOOZrctIfCYuVqOYCJYB+OoUZL57F6fkg=;
        b=rrGhuT3cyoIvCwfHl/pdsfaHtKQ5omZXRQTlmpyalrpGpGfr972RtsBf3Fz33kRmMy
         Ngqj+m9PwtsJNRIXEIxeuaDmKKZO82Lpv98iP2rLDdORtJEP9awd5tUsqy91FbW9cezn
         hrvYLAlOspJjL1nT6WElx2m+J7QjY48TopxJdHLIuc7HQATgixAPHOL5Ng8N31BLkO2N
         JmOV9ncACFtEXKkPZY/Lqh8bcqYN/HYRBe0I8v6vs+QXJpE/iteQflMCC9oCqxskbAjt
         t6SiIipLadhaVtXPC55xHg24wbOhLcT1v+TugrjwBo4tHkPKHePDg7nelnfUInv/PK8v
         SDvw==
X-Gm-Message-State: APjAAAXHU2R0lilBiJgrPN2VyvjTp2MhnwDvmwp3BjlsTXhpDMOpAXIO
        0cC+DFNFD6mWSBr7MHhbK4DubF0U+/u0xaeV
X-Google-Smtp-Source: APXvYqyPiXiZoks5Ggp2WbCYXPXwRsXJyBinTtF4q2J+DeL6YZqEYLLUcsyCdMKT9rkSKMCpecR3goEaERoY/ZM9
X-Received: by 2002:a0c:d013:: with SMTP id u19mr1987564qvg.136.1559580929777;
 Mon, 03 Jun 2019 09:55:29 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:04 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <4327b260fb17c4776a1e3c844f388e4948cfb747.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 02/16] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
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
2.22.0.rc1.311.g5d7573a151-goog

