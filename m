Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDAA3F0A7C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Aug 2021 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRRto (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Aug 2021 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhHRRtj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Aug 2021 13:49:39 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B80C06179A
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j187so2900537pfg.4
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Aug 2021 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VAhCQA3MkM6rsCTMJO3M3k3MNEZtb/Tb2JXEPR3wc8=;
        b=SNCXq/5oc+O/tePHpiIlGQK1Jx7CqAUD8e5IdHI683aauQpDfGujbae9TjWFhkU046
         rLBkgjvQvx/rHbQXy9+zJe3cKrHceKrSA2AvGMxpnpE5p7VwcgX7ak86HeWswH40YbTw
         G64ACPxE1o2scPWySFI7B8j/z0C8bzgR+gr6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VAhCQA3MkM6rsCTMJO3M3k3MNEZtb/Tb2JXEPR3wc8=;
        b=ehaQksgw8X0NkyhE1aTGCFx1aUNOum+KD/RWNdbQlYtcCSAa7ovTZua8Bhsnj83PBy
         JukoK9l1xlG62l5CElOcnkA6Xi2iuN+a2m9ytdYpDYcQxiELoFbV2HjjBhIg6jpEkaeA
         GzF3gHu5IEn19r+z5vYyxJh+tJr+eNnXdEW0u3LadlZ9aWoKRkmOeB5NYpuYOKu5jbe/
         P/N25Zj8pWnuSm1Eh2oHVdrIwZB40K1mfvSwIbPL2n08Xolmfd1JEjwI15x6FXshUlkG
         dPi27J4EWJL5ntD+c3cggUgBcMMmYLkuTAOr0z86P2wsyRIOK8G3owqrOWM5oKR+kZ4v
         UzdQ==
X-Gm-Message-State: AOAM533hEHXw3Ovhy7z69NpUhT/kI9FXCf2tv0mseiC5kt3NFBBvYLwx
        mQVY6GSABUayovM+eIQwhJtpJA==
X-Google-Smtp-Source: ABdhPJzWo9rtC4QhANM5t54ZDvpGyVJ01qR9Trm8ucGnt71I36aBkBxsezedVbtcTSSr5oPNubf9dQ==
X-Received: by 2002:a63:ed50:: with SMTP id m16mr9989573pgk.231.1629308938931;
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q13sm5784525pjq.10.2021.08.18.10.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:48:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        linux-kernel@vger.kernel.org, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/4] lkdtm/heap: Avoid __alloc_size hint warning for VMALLOC_LINEAR_OVERFLOW
Date:   Wed, 18 Aug 2021 10:48:55 -0700
Message-Id: <20210818174855.2307828-5-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818174855.2307828-1-keescook@chromium.org>
References: <20210818174855.2307828-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1433; h=from:subject; bh=hEHwsjZSD/SYU1VoaQ5mTXOJ9xQG9V/0cWsn/qe6UfM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHUgGBUS/d6eL8MtIKgEouR7CqPpSrnry2WnQbOoB MJRkKMuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYR1IBgAKCRCJcvTf3G3AJq2QEA CYtjA8ExIWPk7JvqRI/61/kE99RMnZcDBn7KzqjP0m7JW5yqwlWBUMIz+ye1hV21EL2F5arOPH8BvR 3V9TjF+7swg9wtnWeIWdkurG6SE0wnSv9XECt+FpJzNKxsa9TsUw9OzP94iXOX0lhLJtiS5hbbDzvm 1xWlOJh9WnUVQVNHoQ0SWthtBbKyUGXh/xmr3ASedX9L6Ue100evlIwHgSaY4HK18yKW2oxesg9vRq 2nfod7QFT4T2wsrMrNBcPKnaillIzxm4xYIHVZ64iXPKFsSoxJAppeZ25QJS8u431AEsh7QC1vzUHN mYYvmqS5lBlfI4JWTTS2kh/l+646Yw6u2XmBhYm/auAnyQo6Y7uDXi4YZ0qxInN+fMocEm6/SG2Ts0 q+eQTj7eahrc7dPrq34ZqReM3Anssp+dl3jbBZ4qlHzyoL8i4QUkwHKBalsUDUu0AXanwZvIuUpVRE Xspwci5AKkP3cZFW92NW3seSikRnhZFP+SnAUf9FouV5pMfGgDfGEtAe+KcNGwOiaWjjArhEqeIHzt fiQFAZHI6CJUhJ+OdyXbeFfQfR/d0PG0GUn67vyUiVMF6oqs24HnZ7vRHm5paxs7yDRBfvhx+RD1sk 77kNe3nsroN6hhYbzbAgtAbYjR89fEwFvL1eLnnR4NI6p2wq7155My+YT1IA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Once __alloc_size hints have been added, the compiler will (correctly!)
see this as an overflow. We are, however, trying to test for this
condition at run-time (not compile-time), so work around it with a
volatile int offset.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/heap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 3d9aae5821a0..8a92f5a800fa 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -12,6 +12,13 @@ static struct kmem_cache *double_free_cache;
 static struct kmem_cache *a_cache;
 static struct kmem_cache *b_cache;
 
+/*
+ * Using volatile here means the compiler cannot ever make assumptions
+ * about this value. This means compile-time length checks involving
+ * this variable cannot be performed; only run-time checks.
+ */
+static volatile int __offset = 1;
+
 /*
  * If there aren't guard pages, it's likely that a consecutive allocation will
  * let us overflow into the second allocation without overwriting something real.
@@ -24,7 +31,7 @@ void lkdtm_VMALLOC_LINEAR_OVERFLOW(void)
 	two = vzalloc(PAGE_SIZE);
 
 	pr_info("Attempting vmalloc linear overflow ...\n");
-	memset(one, 0xAA, PAGE_SIZE + 1);
+	memset(one, 0xAA, PAGE_SIZE + __offset);
 
 	vfree(two);
 	vfree(one);
-- 
2.30.2

