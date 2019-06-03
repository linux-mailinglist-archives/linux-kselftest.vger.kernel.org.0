Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09937335BE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2019 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbfFCQzr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jun 2019 12:55:47 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:37076 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbfFCQzr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jun 2019 12:55:47 -0400
Received: by mail-qk1-f202.google.com with SMTP id k13so1001459qkj.4
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Jun 2019 09:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/k2k5Ar8aCCQf+9D9Tu+JwXv9rH7AXQNa2sn1Y51ZQ4=;
        b=MjNLlQZlNit0qhAOpvEzanta6aMm/HnKYesq3iqhkQTbbVYKucWsuURNV/pZ0fdIgr
         1ylaKkgQteB/frXQLyR10kOE8zU+ZyRD8TpKfDcQZGCnFFNsjXxOEavz8cj17GKJRCyB
         J2x5kMGyd9MMKiWAlK7ocfm8aGFbZzr0Rdh98fVFvwjIhfiuVXpvvAuYt2OnDM/XCpZC
         VWufB4qSPQOsK3r33NC8xnn++nCnsO734V+hLJqo/vulWZ1igyxoTiVpIzF6BQyRc9HL
         xirXgN3vt5YoqdUqHeQ92rql4obffE5Q5C/gZo+mx+uqLs8kG3FDDu05FA2VnYDjJKl9
         Kwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/k2k5Ar8aCCQf+9D9Tu+JwXv9rH7AXQNa2sn1Y51ZQ4=;
        b=Wy6zVi53w0pLn7SxtAYbzR3XYx3g9kbmJcPTHRg/BMbcBtglx/VDxg2qEMwqcB27Et
         rYGXHJNwyRK69lkdIxx2U6UmEFDcpu+zahzFI+qs4XBc3R1HI+KIXyW7cYZz/yzHKd8P
         rPfYoDOkm1ONy+JMlkKOUNdV03ykLXb5kntKWHVF+vgC+k3uEJrS3HqgWYVmJoEQodcZ
         E182IBZrmSP1Qg7mS3qFHRzADJLgqTKIo1g+H//Vw7RQDryz3bhG7NF4PyRLBeg/2SJt
         CINfM4o3yfj48NIO3GHQ5BTQgrr/iWbB2tfwl+FPpNVItOh1ysHrsarxUIa+knxoMJgd
         HU6g==
X-Gm-Message-State: APjAAAWBHuLtCuks9wwyPLcG0o3uhjfdUPqNXs4k9J0g1LKUuHrYeT/N
        Z8Oqph/vyINk9Gw4Y60Jo8ksZQxyNY7NejNR
X-Google-Smtp-Source: APXvYqwZjlBwbqsUyeG8rZrRtMFJQ4x0s68oHB37CApZiK1GoR+JjJPXBY4ob8DyF+o+kojgj7/dpioneK7jLRPa
X-Received: by 2002:a0c:b5c5:: with SMTP id o5mr3845483qvf.6.1559580946056;
 Mon, 03 Jun 2019 09:55:46 -0700 (PDT)
Date:   Mon,  3 Jun 2019 18:55:09 +0200
In-Reply-To: <cover.1559580831.git.andreyknvl@google.com>
Message-Id: <da1d0e0f6d69c15a12987379e372182f416cbc02.1559580831.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH v16 07/16] mm, arm64: untag user pointers in get_vaddr_frames
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
2.22.0.rc1.311.g5d7573a151-goog

