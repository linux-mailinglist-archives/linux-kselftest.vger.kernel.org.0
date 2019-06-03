Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7110C33559
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbfFCQze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:55:34 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:52691 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbfFCQze (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:55:34 -0400
Received: by mail-ot1-f74.google.com with SMTP id a17so32733otd.19
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=20y1HOjqXQjYCoZ3FMKXhe3A/P2l0vyHswuOkJrBoHc=;
        b=LglK5GIUUx/pUH7d33srSrOdoxDJcf6k8RPUUYHzql61oC+wNFESJd5PKVtebHfEHg
         K4rjnwnmDpgmbEhEStseFjNPEkvS+OI72qtgGhLpDEtxWhTvC3aTgCw5FcWPqu/H8YrI
         EsZSEg5fuJNLUqDTf1Y4yx6ojgmyvktu2GiIy1cCbapuFQIW/4LxM06f8+NqNbEgrvNM
         UWcCXb3C0eM0WuvLRS+mPfo8NHHpXEwFgU2WjcbOUcfYUWB+71yFOhi1U1i0mgtvoovy
         MA4D4byZDDLHTtN4PLwPL3K21wgXq++wadXcb7ohaA0PX/0lh5439vbzfphRZaAPKsSb
         Z6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=20y1HOjqXQjYCoZ3FMKXhe3A/P2l0vyHswuOkJrBoHc=;
        b=N1vwPyQGF+xduku9tJuH1tbHYvMu6O8fofnMArT8Vc3pDzP1OAXgyOjT2YYLAzQlOQ
         +gsXIQl1CdLVEjzSzvLw9eJptxrXAgGyk2jt0U46k1UNXZwrjYDww0dsiBbt97ttuZPU
         MfyCSDoSly6HqXHGTJaux81ZQqy3Clrzz2Gs4zidKdNVubJoZzTkVMS7yp3D5IpmSqyT
         WDUqz3gP20gKteLcu1/ueSikvCtT4SwhATTLBxSCSSYfdTjVo9D8gGUnEJak9j1/oNx4
         Hr8GJVG3aaTBgEUHWjROAyuTfA9AS6MC11qbVIPkJc3Twa/ffeaOr5/HC92yZzub7CXj
         JqSg==
X-Gm-Message-State: APjAAAXOqPAXF6Woh4d6EFe8qLJtuTtwA18t6rccMXgisFebYNZeCOsh
        B2K2TAbJLrv4w/Mt3Lh0HYDC9JiLTvwiU72Q
X-Google-Smtp-Source: APXvYqzHKkB2rM9PXXWgsahc+U06gQo0dW3SgxcQRqFmx6XqPzOJDdvsIYpt6xPWzmKaja2zBdl1velx+1PVZjyJ
X-Received: by 2002:a9d:62d5:: with SMTP id z21mr1888837otk.202.1559580933129;
 Mon, 03 Jun 2019 09:55:33 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:05 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <14f17ef1902aa4f07a39f96879394e718a1f5dc1.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 03/16] lib, arm64: untag user pointers in strn*_user
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
2.22.0.rc1.311.g5d7573a151-goog

