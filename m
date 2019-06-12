Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C50942450
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 13:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436531AbfFLLno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 07:43:44 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:44923 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409096AbfFLLnn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 07:43:43 -0400
Received: by mail-oi1-f202.google.com with SMTP id b124so5324701oii.11
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jun 2019 04:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UjHW3gvZNVNgT5aLmmsHnPxo+B7J7BC6tuQvc/RhPNk=;
        b=wWQdCeaEB2u6K2FokoVH57TiuY9+YM+iloWJZ9olfqp0zjmIdmC5f6DPCzUKmsxGdy
         S65EVOJIDT5V4zwCQfqNTJzphOcFWfUmY+gXBOeFncv77kXLYdKYGCkdMxc+OyweaWX0
         0fKTo4iZRRAvEu0L5K9N5O0E1jscX+Pk92PzQ1PknQ2YOc6xMrIj1RN7n/IEUROoLRHK
         DSyTNlm/Sr+vicrs5WJhiUx/1nLhQ5Q4ACjS55YPvH7eOOqFTP/CfYXsftMzptdGowR3
         ikQ6jhRMQBxQ3FPli1xBTZa23yNKdUvKN2sR5HTTLiPeqs1dY61XYlyLOGrjNBMaj6hd
         3iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UjHW3gvZNVNgT5aLmmsHnPxo+B7J7BC6tuQvc/RhPNk=;
        b=IefYMZmQSrDrjmbwEfM85s2hHOZFi72XPf+YV6188Lo3cN8h1q3Uo5QpJgu+N/8iQt
         vJOPlWTQRIbL23egb99RiHW5Q1n8Z5NqBTOHxW6x+6qNI7NKv/5NWIbDaTnSsexH6dry
         XzDR87WxaDI2kTGrGSwsTf/TcU3mOjlaoOHIOLJQc29ystMeIMel/AG6n+d+euP50elb
         VpKIBq1z0GnmJ5FIOnRnOfmprd0ma8AHtBiIhOSgfZ0GzAzLI5zHVUi/7R8rrWPpqQBR
         zZkEMa/Ze2hsh1CAggwcbZk5bLZ+pu0JZtfVP5PVaC3q5St62ilDnQpJKwaHik0sQvFJ
         BsqA==
X-Gm-Message-State: APjAAAV6ucL+A4PHeXgO4CyS7mKMkGc+xWf2zO97bXYTyyCpmmm0EDYq
        s7F17IRtQbkXcjYn9jo8VdHYV390CFFVkWce
X-Google-Smtp-Source: APXvYqwN3f56c3YdzV4vuBZtnTaXMq2rkbV7EZJhl+9vuDir+VdtrZMmSzDSSPuiOLJaxWwDb81r7VAwTgFT1eUN
X-Received: by 2002:a9d:764d:: with SMTP id o13mr6499138otl.298.1560339823090;
 Wed, 12 Jun 2019 04:43:43 -0700 (PDT)
Date:   Wed, 12 Jun 2019 13:43:19 +0200
In-Reply-To: <cover.1560339705.git.andreyknvl@google.com>
Message-Id: <a76c014f9b12a082d31ef1459907cabdab78491e.1560339705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1560339705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
Subject: [PATCH v17 02/15] lib, arm64: untag user pointers in strn*_user
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

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Note, that this patch only temporarily untags the pointers to perform
validity checks, but then uses them as is to perform user memory accesses.

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/strncpy_from_user.c | 3 ++-
 lib/strnlen_user.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
index 023ba9f3b99f..dccb95af6003 100644
--- a/lib/strncpy_from_user.c
+++ b/lib/strncpy_from_user.c
@@ -6,6 +6,7 @@
 #include <linux/uaccess.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
+#include <linux/mm.h>
 
 #include <asm/byteorder.h>
 #include <asm/word-at-a-time.h>
@@ -108,7 +109,7 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 		return 0;
 
 	max_addr = user_addr_max();
-	src_addr = (unsigned long)src;
+	src_addr = (unsigned long)untagged_addr(src);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
diff --git a/lib/strnlen_user.c b/lib/strnlen_user.c
index 7f2db3fe311f..28ff554a1be8 100644
--- a/lib/strnlen_user.c
+++ b/lib/strnlen_user.c
@@ -2,6 +2,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #include <asm/word-at-a-time.h>
 
@@ -109,7 +110,7 @@ long strnlen_user(const char __user *str, long count)
 		return 0;
 
 	max_addr = user_addr_max();
-	src_addr = (unsigned long)str;
+	src_addr = (unsigned long)untagged_addr(str);
 	if (likely(src_addr < max_addr)) {
 		unsigned long max = max_addr - src_addr;
 		long retval;
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

