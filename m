Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6094D31BEFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 17:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbhBOQWA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 11:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbhBOQTh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 11:19:37 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BB5C061D7C
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:14:15 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h8so6817544qkk.6
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Feb 2021 08:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9bnQ1cYpKSogma2d9jSskcM/kWG+ieYizroT/wf+fYw=;
        b=fZdFf8Y10WJwP3iDSS3Z5VyVZRkc0J09nWK3ghTjLayZaQBtALZ8zAhfs0QfifSEkk
         9UCDPSqsKM90EEUU7EzN/KjQ+x1vD4LB875bg3UUqglChgzLgAyVi/Uyh8m6nO9cEpMt
         b7wkQN91QNBa4v28HydDX2RkbwWLvNrOVV9oodQvnyQfSxXC2fq8zvZoODL3os3uHDYN
         CmhqhnaZW2woCDh1PDNhzPD8JZcK9CkmdfedTTwMtsUUtu4aRa7FJ9BVU0As4/HoW2+R
         JUUAPf3HP2CRj37EmDMU3/PYEc4vc2IsqQHVBGVxXMgHNUlI51p/exyLfxOCpxQ3jXl6
         2sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9bnQ1cYpKSogma2d9jSskcM/kWG+ieYizroT/wf+fYw=;
        b=OFZarPSIZDXmH7SKaSIVxiw3+QKQjdKe5mFx22DSFYyyjREUhxM5BRURi1eP1MTkKF
         Q19O91hX2Q0u4ZJS5io3zmKZy1ECsohtIQlIR75lf86ZfuDTFXW73W9Z4/1hXq7vQPwS
         KlE2+u1zyeQGsAxyrrsV/qfu5BUbtDtmcr/+38psK5pItL+dCgESMtyS2YR3bG1Wew2O
         Pki++8tX+t+Z/zzRWSMM55gO1hlp688AhJxLh/OPsIifHRS0lvoYLLcU1x5aSa3Gvm1V
         52LRxNqfXMTA00Jq43sN26T68Ea8gG1aEApuHAZ6HDSQaNQbVXIT2r66A1UMfr3D6kga
         SlFw==
X-Gm-Message-State: AOAM532IHvD1Yeqf/cHWLnfedZi+waVa0FoML4+AX6W3ziByPwygfZFI
        lhinIs3Xja3LHfx0iOlGlQdQaA==
X-Google-Smtp-Source: ABdhPJzovM58HaLCClF3VUBYsDOrSP/+0sT1fDIUz4gtaDsL/dH2pL1TQ1nvopCVb2IFGgIQdJpNgA==
X-Received: by 2002:a37:57c7:: with SMTP id l190mr15700031qkb.487.1613405653668;
        Mon, 15 Feb 2021 08:14:13 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id u7sm10909213qta.75.2021.02.15.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Feb 2021 08:14:13 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, osalvador@suse.de,
        dan.j.williams@intel.com, sashal@kernel.org,
        tyhicks@linux.microsoft.com, iamjoonsoo.kim@lge.com,
        mike.kravetz@oracle.com, rostedt@goodmis.org, mingo@redhat.com,
        jgg@ziepe.ca, peterz@infradead.org, mgorman@suse.de,
        willy@infradead.org, rientjes@google.com, jhubbard@nvidia.com,
        linux-doc@vger.kernel.org, ira.weiny@intel.com,
        linux-kselftest@vger.kernel.org, jmorris@namei.org
Subject: [PATCH v11 14/14] selftests/vm: gup_test: test faulting in kernel, and verify pinnable pages
Date:   Mon, 15 Feb 2021 11:13:49 -0500
Message-Id: <20210215161349.246722-15-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210215161349.246722-1-pasha.tatashin@soleen.com>
References: <20210215161349.246722-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When pages are pinned they can be faulted in userland and migrated, and
they can be faulted right in kernel without migration.

In either case, the pinned pages must end-up being pinnable (not movable).

Add a new test to gup_test, to help verify that the gup/pup
(get_user_pages() / pin_user_pages()) behavior with respect to pinnable
and movable pages is reasonable and correct. Specifically, provide a
way to:

1) Verify that only "pinnable" pages are pinned. This is checked
automatically for you.

2) Verify that gup/pup performance is reasonable. This requires
comparing benchmarks between doing gup/pup on pages that have been
pre-faulted in from user space, vs. doing gup/pup on pages that are not
faulted in until gup/pup time (via FOLL_TOUCH). This decision is
controlled with the new -z command line option.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/gup_test.c                         |  6 ++++++
 tools/testing/selftests/vm/gup_test.c | 23 +++++++++++++++++++----
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index a6ed1c877679..d974dec19e1c 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -52,6 +52,12 @@ static void verify_dma_pinned(unsigned int cmd, struct page **pages,
 
 				dump_page(page, "gup_test failure");
 				break;
+			} else if (cmd == PIN_LONGTERM_BENCHMARK &&
+				WARN(!is_pinnable_page(page),
+				     "pages[%lu] is NOT pinnable but pinned\n",
+				     i)) {
+				dump_page(page, "gup_test failure");
+				break;
 			}
 		}
 		break;
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 943cc2608dc2..1e662d59c502 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -13,6 +13,7 @@
 
 /* Just the flags we need, copied from mm.h: */
 #define FOLL_WRITE	0x01	/* check pte is writable */
+#define FOLL_TOUCH	0x02	/* mark page accessed */
 
 static char *cmd_to_str(unsigned long cmd)
 {
@@ -39,11 +40,11 @@ int main(int argc, char **argv)
 	unsigned long size = 128 * MB;
 	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
 	unsigned long cmd = GUP_FAST_BENCHMARK;
-	int flags = MAP_PRIVATE;
+	int flags = MAP_PRIVATE, touch = 0;
 	char *file = "/dev/zero";
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHp")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
 		switch (opt) {
 		case 'a':
 			cmd = PIN_FAST_BENCHMARK;
@@ -110,6 +111,10 @@ int main(int argc, char **argv)
 		case 'H':
 			flags |= (MAP_HUGETLB | MAP_ANONYMOUS);
 			break;
+		case 'z':
+			/* fault pages in gup, do not fault in userland */
+			touch = 1;
+			break;
 		default:
 			return -1;
 		}
@@ -167,8 +172,18 @@ int main(int argc, char **argv)
 	else if (thp == 0)
 		madvise(p, size, MADV_NOHUGEPAGE);
 
-	for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
-		p[0] = 0;
+	/*
+	 * FOLL_TOUCH, in gup_test, is used as an either/or case: either
+	 * fault pages in from the kernel via FOLL_TOUCH, or fault them
+	 * in here, from user space. This allows comparison of performance
+	 * between those two cases.
+	 */
+	if (touch) {
+		gup.gup_flags |= FOLL_TOUCH;
+	} else {
+		for (; (unsigned long)p < gup.addr + size; p += PAGE_SIZE)
+			p[0] = 0;
+	}
 
 	/* Only report timing information on the *_BENCHMARK commands: */
 	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
-- 
2.25.1

