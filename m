Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63C3C50E72
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfFXOdK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:33:10 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:49925 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfFXOdI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:08 -0400
Received: by mail-vk1-f201.google.com with SMTP id o202so6445694vko.16
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OFC24w2VYFjptSxPqCpbBEqhaUlc2rZ4vtg/DxWHKUY=;
        b=daRRCGEXfLHGLUQo//HRDLfqaBO4lfL42FrfPGRnRKOhn1XL6qGzvLE8amzWfXer5a
         WhALrZBTuSnnuN10/CaZpZqQ5oMU4MQefeNJm/AP0b4uEXgK32RunU93durvNp8XKKHL
         uQfK0a3nA5oC/DUYeVxUqLVQFd9uJpb2OtV7FV9mAWqDzJacQiBSNlyVGMSQHbzkOff3
         MC+xIW6PfIq1tVQloxoUTZ3GncOdewoLB+fLV/jb+kaJgM+7s5iRXhY273LkR2goOH7a
         Ap1pVnJAk4onxG8CZjucr85/ku+lb+LecGyuZhueMHSpk8X8CCgAIxuGrhQgzxcP8FnL
         C2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OFC24w2VYFjptSxPqCpbBEqhaUlc2rZ4vtg/DxWHKUY=;
        b=ojsVp+DsZItQIHYlPc7SW6qZhYZfouHmXbdtQyx6Ng4sPv4uyV7UGatQSMIzIwtTWQ
         Uea76SlXwkiW8lIcCK+PMYScPI/n+15QDtqKzSJh/PWfdAY+Yot1Eb0v9RyhsLZ2/MiY
         182W70226pN0nv4j/kwgRBuwBVJrskKa2i3hfqW5el1C/C70DKuxj7nJ+44zK8LRdaaW
         s3pKKZnhlB91UFIqfJUFEwMfho+H0ZKbhqbJdUoSlvTkZlEKAh9Qmbcjxei5eeaiDJ5h
         XvIr23zPN6gGXr9xguHC9oVDx6sxZ+XQ3PMdvBbgaqFJuzgwcUaJ2sPcSUfzoNZGNriK
         XCqA==
X-Gm-Message-State: APjAAAXXHPHeAtTu/SG9qJXvvu9XUqb1R37R8oa/N+6lmPqxc5zM1fkH
        R1GwuJ7r184C7u6Vjq1q+oIhRQ50HCThtrsc
X-Google-Smtp-Source: APXvYqztHTWRHYOC83H4IfNbENBsJMJpCmuVpe91PkFE56CWhu5KbIzw0hmUvviWu8/4yX8wEpc7iI+Lm7IC+LHT
X-Received: by 2002:a67:6e44:: with SMTP id j65mr66559877vsc.132.1561386787480;
 Mon, 24 Jun 2019 07:33:07 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:46 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <98cbd89549395d372a4a20ab2ac536bf19d37e52.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 01/15] arm64: untag user pointers in access_ok and __uaccess_mask_ptr
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

copy_from_user (and a few other similar functions) are used to copy data
from user memory into the kernel memory or vice versa. Since a user can
provided a tagged pointer to one of the syscalls that use copy_from_user,
we need to correctly handle such pointers.

Do this by untagging user pointers in access_ok and in __uaccess_mask_ptr,
before performing access validity checks.

Note, that this patch only temporarily untags the pointers to perform the
checks, but then passes them as is into the kernel internals.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/include/asm/uaccess.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 5a1c32260c1f..a138e3b4f717 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -62,6 +62,8 @@ static inline unsigned long __range_ok(const void __user *addr, unsigned long si
 {
 	unsigned long ret, limit = current_thread_info()->addr_limit;
 
+	addr = untagged_addr(addr);
+
 	__chk_user_ptr(addr);
 	asm volatile(
 	// A + B <= C + 1 for all A,B,C, in four easy steps:
@@ -215,7 +217,8 @@ static inline void uaccess_enable_not_uao(void)
 
 /*
  * Sanitise a uaccess pointer such that it becomes NULL if above the
- * current addr_limit.
+ * current addr_limit. In case the pointer is tagged (has the top byte set),
+ * untag the pointer before checking.
  */
 #define uaccess_mask_ptr(ptr) (__typeof__(ptr))__uaccess_mask_ptr(ptr)
 static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
@@ -223,10 +226,11 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
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
2.22.0.410.gd8fdbe21b5-goog

