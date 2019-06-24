Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DE50E6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfFXOew (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:34:52 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:51876 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbfFXOdO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:14 -0400
Received: by mail-qt1-f201.google.com with SMTP id x1so1079738qtj.18
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QQXMFisLcqxTDxCx7mpHBfkykflxcDxM95yy0y46L4c=;
        b=nl7WANT+T3zzJdQNSfB9+m3b8ydqMfXiozgRLYeQCHFc4zWOn1Q8HlSZi7DGmunKcG
         m48YCubQKuyc5mIC9PWmc95WNcaYrn+rBkilmeEtWye/vcm/w7SgqxmZ+eLuRWNk+dBe
         ilcc0xwMAFdqkWVOavUtr03O5uEwSiv8ah8EA2ZNm/JYdo0vp1VaJuLVzssnLAaxlz0W
         +bGemSNE16fXrFDUhV0Eo7CJiC+zuIHkEvL14QgEfP6YhZ1zpRezDVdue+M4lC6Urd5x
         s/pZSUm/6UDNd/YlF2uYqWPTYuto+748pEjr815zYdNJlDljrtH9f8RpmzII6hCRLyFl
         B0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QQXMFisLcqxTDxCx7mpHBfkykflxcDxM95yy0y46L4c=;
        b=kVshJD/Lr234irnpuOtMN2YxtdH+UkI5M3IsBAg86R6hhPJbWtYW/BRenPIVmEgY8D
         kwFrKbIqpSfCENMmASOrG5kVXVdxd6Ejtmy5qs+rPF/uP0T5H+xI4JAofDB6t8Q696Z/
         2rSfuWpJcPHR+U4C3qFVqDN4HGkWx1MKomY8HrW2qAizOM4lNHZHSFG5Qvilgqpoj4mA
         0DdHQ5hzbYqy4KD2JWKniSYQ53LCHrxWEz5WiDU5Xpz2Q/ASsEGaD1RrFJV69K1gTAT9
         sl8OohUZfBNNCrKiJ+OolGRtT1eR41MRVdt78kwH4ClURQPTAxaZ3w1fgZ0O073nL1Bp
         Dyyw==
X-Gm-Message-State: APjAAAWIJ1o0kad3B6kH70RJCndM9MYIDqwiFWkFApgeyC+ro91S6agq
        Lwcjnr2rHJdKPjhzh3OsF0M5FuvFPe0ikBSF
X-Google-Smtp-Source: APXvYqzup51zNJearylpYQzBo2BoCcuJ3XXHspU9PtHQODnUVY/RZyP6CGJqukGO0YgO4GkOlCbGA2J//cHunZZU
X-Received: by 2002:a37:a2cc:: with SMTP id l195mr16730110qke.362.1561386793770;
 Mon, 24 Jun 2019 07:33:13 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:48 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <1a53da43d69d644793110e85671d20158ebf29cb.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 03/15] lib: untag user pointers in strn*_user
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

strncpy_from_user and strnlen_user accept user addresses as arguments, and
do not go through the same path as copy_from_user and others, so here we
need to handle the case of tagged user addresses separately.

Untag user pointers passed to these functions.

Note, that this patch only temporarily untags the pointers to perform
validity checks, but then uses them as is to perform user memory accesses.

Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
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
2.22.0.410.gd8fdbe21b5-goog

