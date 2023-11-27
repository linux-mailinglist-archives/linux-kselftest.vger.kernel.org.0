Return-Path: <linux-kselftest+bounces-660-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A17FAA66
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B5BB21253
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 19:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2888C405FC;
	Mon, 27 Nov 2023 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ighDkBR+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7F1B4;
	Mon, 27 Nov 2023 11:37:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c398717726so3818500b3a.2;
        Mon, 27 Nov 2023 11:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701113828; x=1701718628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5O5wu9Cq/51IfGIxfcOGm2UEiIvcNVg0blWRA633/+k=;
        b=ighDkBR+sbXXLHMFEBPzc2tMNeQGDU5KvZg/3mbqHD41lN1XtOmzUNZSldjr2V8Qxp
         e223lmVPg7/eLmynFUjafh1J42RPKNcHN5HJfOjt742LVxW7KeIeK7p8UUtnt83oQHVL
         J2bqe2nx8hnjlhqec51cx4ASKZIwvZ7Y3lZw81Zdg7TWemisNf+j+84caIWKHBHVV35k
         SiyDkeXf/Lia50GJ2oH2PEspAD9bSVna+p/aS+9uyVdXdUy5FUcTfgQNbIQWAQzvVUgI
         pdLkX4Th3YCiwW5LSqvhposWr7/ZnuJwzUMQZoijO3frc+CTA6OiCsR9D8GKuTlGeNBL
         mZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113828; x=1701718628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5O5wu9Cq/51IfGIxfcOGm2UEiIvcNVg0blWRA633/+k=;
        b=mIEpa92yVhC29vnb/8aZa64K/gIN7pIFWOo9o5V/zW2h9BxzkmrKyh7Rk8fNtdwUe9
         z1P2ybtrhmtPEY+ovay3SfL1CDSmiAAl3iCNaMNSq34tchKUsQvynvqXoVgKeU5B8Cw4
         RK9ZHPONx3owUvnvHmpbczY27SGppUEUX3u2lfuo7ycv/GyA0BAD0y6iL4vScTI0tmqL
         7z7LbwtWlg5e8Fh62WGOa5gsZIaLdAnAZSdQAtN26/axWhk1eVNdXNKYZI15thwIlGIO
         EYXqeI4mSeCJCcrL9bLp18x4PySsL+FiWrsWt81oTjcLuyZvdWCvCpFcV4yhfQHWkjDZ
         IAmQ==
X-Gm-Message-State: AOJu0YxrNNZcSTjfoIEmzMlUfiQ15xo6pIxehCBT9Mb/B4cALLLL8ABT
	GxwrLYULRx3GLWApFZ0UZ2w=
X-Google-Smtp-Source: AGHT+IEwXPRn/KjUwT82GUAwUvlbaVFt6ZyMPdi94ntaKv5CHgpItTfrPBYXTZevCB0RopFyqvfLqw==
X-Received: by 2002:a05:6a21:19a:b0:18c:ab4:f6c9 with SMTP id le26-20020a056a21019a00b0018c0ab4f6c9mr12929291pzb.56.1701113828278;
        Mon, 27 Nov 2023 11:37:08 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id x18-20020aa793b2000000b00688435a9915sm7569191pff.189.2023.11.27.11.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:37:07 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	cerasuolodomenico@gmail.com,
	yosryahmed@google.com,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH v6 4/6] mm: memcg: add per-memcg zswap writeback stat
Date: Mon, 27 Nov 2023 11:37:01 -0800
Message-Id: <20231127193703.1980089-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127193703.1980089-1-nphamcs@gmail.com>
References: <20231127193703.1980089-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Since zswap now writes back pages from memcg-specific LRUs, we now need a
new stat to show writebacks count for each memcg.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/memcontrol.c               | 1 +
 mm/vmstat.c                   | 1 +
 mm/zswap.c                    | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index d1b847502f09..f4569ad98edf 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -142,6 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_ZSWAP
 		ZSWPIN,
 		ZSWPOUT,
+		ZSWP_WB,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0399aec8c0e3..a82f9c695c6c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -703,6 +703,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	ZSWPIN,
 	ZSWPOUT,
+	ZSWP_WB,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index afa5a38fcc9c..2249f85e4a87 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1401,6 +1401,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_ZSWAP
 	"zswpin",
 	"zswpout",
+	"zswp_wb",
 #endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index e441cbcab9a9..9f5142524d48 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -754,6 +754,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	}
 	zswap_written_back_pages++;
 
+	if (entry->objcg)
+		count_objcg_event(entry->objcg, ZSWP_WB);
+
 	/*
 	 * Writeback started successfully, the page now belongs to the
 	 * swapcache. Drop the entry from zswap - unless invalidate already
-- 
2.34.1

