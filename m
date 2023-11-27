Return-Path: <linux-kselftest+bounces-682-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025E07FAE9F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Nov 2023 00:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346461C20A9E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 23:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39249F77;
	Mon, 27 Nov 2023 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrHaEoiI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19EB1B1;
	Mon, 27 Nov 2023 15:46:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c2066accc5so3253232a12.3;
        Mon, 27 Nov 2023 15:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701128765; x=1701733565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QqTttvrK+ydHCThErTWQGU78pwuFOyKaqUvf3Lt6j8=;
        b=NrHaEoiIGzswpw48UOOMgSE/w6JjfTItR35NDtUcjjGzgm4yBvBYHpIcoENC9fMcvp
         AdtPmEOGjksixBn1UqcKUyKFDtZxKMCFuWy07Pd+HDiMjc+e/VfXDPELs5MLEhOhA5hR
         kEj8EwHC2agx1EHc4vVNFx96OyjlvwqskFw5+kfGE0SG5CACgLAW5sf2rfSyKS73e+XR
         ZpWRAtF2ywuDXO6vv7VctR06WGcm/2ODALmWT8SY/NJmc0/xPAS+clrClkeQCddAZzdR
         7r5RR7/V8gcbcwzHs8GdnI+Y65EGLMjLfEJxj3JxzKmA2iA0Z4TXzQPkJ0E2jHXxuhYO
         /kcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701128765; x=1701733565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QqTttvrK+ydHCThErTWQGU78pwuFOyKaqUvf3Lt6j8=;
        b=a18pdayLB7pcOUSsXC4Bcm0KY8B9vP7SFjOro0ceqZ8hbN4NyaMl44qgW1hjalatCy
         iSnTJbCqOyLXW0xbBrlrmP8NPmRosSG/AJ6pABQw/yjS39ii5Ld+XJq2POZ94jBLFZ7e
         23mKTU9dSwRxPLpz8FQ7K3d9yWVTSUAuyIbpPROIbx2rvhJv2Va7L8bZVvVbiNkbHj53
         0x/PWNOI8I4ui3m3TGkH4mbXZssUJBLmwvn6UyS0RuDJcITN97+SvuF5S+54PfjILT+A
         rkwYuxMxM/ZGrYYs92KE3UwLHejGK2GtMY2e4f+eE4710OG7nqB0hzP1puHt8zlttqD5
         /ZWQ==
X-Gm-Message-State: AOJu0YxhsnthAwX9FnAQ5Mx51t5WhOkTOUhdhqDH0ij/jZw6OpD1J1bZ
	Qw8uNfvaJW/d4vmLZJv42Pk=
X-Google-Smtp-Source: AGHT+IExkmTDKAzglcJvC3UaGVQZ3+W9qPh/6zFr3PtHuO4ykPcK8P5QG1OBTphSE0yUc3YsgNVUPQ==
X-Received: by 2002:a17:90b:4d06:b0:27c:f9e7:30fd with SMTP id mw6-20020a17090b4d0600b0027cf9e730fdmr12623338pjb.7.1701128765215;
        Mon, 27 Nov 2023 15:46:05 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a031900b0027d0af2e9c3sm9103232pje.40.2023.11.27.15.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 15:46:04 -0800 (PST)
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
Subject: [PATCH v7 4/6] mm: memcg: add per-memcg zswap writeback stat
Date: Mon, 27 Nov 2023 15:45:58 -0800
Message-Id: <20231127234600.2971029-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127234600.2971029-1-nphamcs@gmail.com>
References: <20231127234600.2971029-1-nphamcs@gmail.com>
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
index 8c0f3f971179..f88c8fd03689 100644
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
index 5e397fc1f375..6a761753f979 100644
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

