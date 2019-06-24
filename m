Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 001A450E53
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2019 16:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfFXOdj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jun 2019 10:33:39 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:53111 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfFXOdj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jun 2019 10:33:39 -0400
Received: by mail-vk1-f202.google.com with SMTP id l186so6452761vke.19
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jun 2019 07:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BJsyngqG/QyGrxCP5QV1VgvY/ZIDb46yXFdUWUYcJjE=;
        b=tMmuoJLkJJRlr97nWuw9yp1dhBnjJgJJVctCCMOkVQAwVufIWjtRSJ98DeVWMAUpL7
         c/DDMKTfXjJ3AunXbS9PbtesoR3v6FwAquf/mPo2ipW5m7uKq3mz622OTJgF//P41VeY
         uBPVky3FH88ifuyXm9IjyMmdhNWu2I8INL87p4oZ1vAogbY0BRq3PmSNaYTl1n/7bnrO
         Lc9PPi+EV8QQhe4FjeigOim3EKL5tCU2OhJP5k8d+H2v0cMsX/+SwQBn01vR1S+aYe8q
         kmK501SZalx1YaFY0Y1ChZDATvY9Cs1dirj078l2AUk0ox9yU2Ud6XA8n+4rc4SVim6s
         D61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BJsyngqG/QyGrxCP5QV1VgvY/ZIDb46yXFdUWUYcJjE=;
        b=Lv3i5I8K1ND5JReINKoVo2RpSywq8oMGErxi3NtK1gnTUoxPuoQh1ZAJEyTzCGJN74
         i0MKMugxdqI8bx84SMnMY+1cKTTOggOB334kUAlwauDn+PPy6JAcUDgeaQtqGoRAO3Ti
         qY9tSnSvFDDkj83zzhRsYWh5x1F4MDDzqCuu2n7d/RUteDjo84HHSuHXRUBh64Zt0ldp
         tRVOdDjXwYLktyAZT4zQZn/iWi1laUlV4Um+lgwEHB+/kowgMb0QkHmpj5DPdsLAp0E9
         TzGA+29OGlHhRdZRZYE43mD1+esc3RviJnMYRafwHVNYMSu+DcHCKw6soixJTDAZeBE4
         tNXQ==
X-Gm-Message-State: APjAAAUBaIlNqnx7CLrejNlEht9ReYqNekE9agDr32l0YmOxz9Qp3qIM
        yS4VF0T+UbZrLAb8XP1zW9Rbh95F1eidvoX+
X-Google-Smtp-Source: APXvYqxgB5X/aCbKs9hmuZWtlXYS7x7msb4DLFufqsMoO6mME7B8su644ppdcEygFH1GnaKdKATNFxnkdsXw3C2U
X-Received: by 2002:ab0:7782:: with SMTP id x2mr22851192uar.140.1561386818133;
 Mon, 24 Jun 2019 07:33:38 -0700 (PDT)
Date:   Mon, 24 Jun 2019 16:32:55 +0200
In-Reply-To: <cover.1561386715.git.andreyknvl@google.com>
Message-Id: <61d800c35a4f391218fbca6f05ec458557d8d097.1561386715.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v18 10/15] drm/radeon: untag user pointers in radeon_gem_userptr_ioctl
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

In radeon_gem_userptr_ioctl() an MMU notifier is set up with a (tagged)
userspace pointer. The untagged address should be used so that MMU
notifiers for the untagged address get correctly matched up with the right
BO. This funcation also calls radeon_ttm_tt_pin_userptr(), which uses
provided user pointers for vma lookups, which can only by done with
untagged pointers.

This patch untags user pointers in radeon_gem_userptr_ioctl().

Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/gpu/drm/radeon/radeon_gem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 44617dec8183..90eb78fb5eb2 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -291,6 +291,8 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	uint32_t handle;
 	int r;
 
+	args->addr = untagged_addr(args->addr);
+
 	if (offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
-- 
2.22.0.410.gd8fdbe21b5-goog

