Return-Path: <linux-kselftest+bounces-1208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9873A805EA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F871C20E4C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D38692A1;
	Tue,  5 Dec 2023 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niiwfymB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B8135;
	Tue,  5 Dec 2023 11:33:08 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cb55001124so100983b3a.0;
        Tue, 05 Dec 2023 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701804788; x=1702409588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzmYrhMAdXLD+///kOQIC9tqV0WlC8PR4PrJXczDCuA=;
        b=niiwfymBFlnAEj91h3Up14afPf+5D76XaYmdiYxuGMuFQoJL5T4WExh9gU/luefC3X
         HxfFOAC5bPPE1J1uitSebgEVhXsFYe2C0OXw5agM7Gx0R3xvF62mHFQXnC5+jNcHQqkb
         wtw5j6oa9QePUXlBWlx2nKIvKRcyFzrIjHakqpiuaNi07wO6ZVCgWKcmBkfrQATy4oIC
         Ry5LmQdWTc7BJkRZ9vNhGfnEi0d8aKO6LIHCVGpHS/WxgvHYNgkPlbPX+uerWsAUo9is
         j2dPiKDkB8+b+FZhpRhId9o1QVNhV6h9+k7qzrMFtQBzi6KMrytqhOA+UOeZ41lp97Al
         LUEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701804788; x=1702409588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzmYrhMAdXLD+///kOQIC9tqV0WlC8PR4PrJXczDCuA=;
        b=EGWzylp1pRI+gMBbb3r7NpNrlFP4+IcSF/MviYoqy6He657yO4VqOfr+CsSKIzCQQT
         ELZx7+TPwUHdFX8z9/df7sb9ZXWDfofL8TAIa27ALwiRugn50/OJLuQqzb+RVped/h+l
         zNJpTboZkHeA6AfiLJIU5l9LIoQHRKq2oQ6dJa7gsXCaFaLNqKkVk9LjxoAlEMGYGZ19
         VYBcWovxd4eg09B4moGk9hYR46ZmdzI8g1bv4KzP/DLz306kEEkCrkOuCg5GJxRZ6+RQ
         e4HLm11hhqcThiLLo29y6xwidIM94oxTL37TFs+ijJCnx8K2NeiPptcXDWMUbgmeDp2n
         Hkqw==
X-Gm-Message-State: AOJu0Yw7jrMLo8iPKRiXQqxic2g7OxgdBKMeiRGf2G8OLCWM1v9PSQDT
	8sfkK7lHV1/zSZjnlomcrXc=
X-Google-Smtp-Source: AGHT+IF9r+jplWi+C3DggSGVvOK4fb3t6NnJTlcHQ8Doyqcaiilw07s+4VOK7eualppViE9dX8+beg==
X-Received: by 2002:a05:6a20:da86:b0:18b:cdd5:10c1 with SMTP id iy6-20020a056a20da8600b0018bcdd510c1mr2603327pzb.26.1701804788200;
        Tue, 05 Dec 2023 11:33:08 -0800 (PST)
Received: from localhost (fwdproxy-prn-005.fbsv.net. [2a03:2880:ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id o9-20020a056a0015c900b006cde4523767sm4612803pfu.22.2023.12.05.11.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:33:07 -0800 (PST)
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
Subject: [PATCH v8 4/6] mm: memcg: add per-memcg zswap writeback stat (fix)
Date: Tue,  5 Dec 2023 11:33:07 -0800
Message-Id: <20231205193307.2432803-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-5-nphamcs@gmail.com>
References: <20231130194023.4102148-5-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename ZSWP_WB to ZSWPWB to better match the existing counters naming
scheme.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/vm_event_item.h | 2 +-
 mm/memcontrol.c               | 2 +-
 mm/vmstat.c                   | 2 +-
 mm/zswap.c                    | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f4569ad98edf..747943bc8cc2 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -142,7 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_ZSWAP
 		ZSWPIN,
 		ZSWPOUT,
-		ZSWP_WB,
+		ZSWPWB,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 21d79249c8b4..0286b7d38832 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -703,7 +703,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	ZSWPIN,
 	ZSWPOUT,
-	ZSWP_WB,
+	ZSWPWB,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 2249f85e4a87..cfd8d8256f8e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1401,7 +1401,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_ZSWAP
 	"zswpin",
 	"zswpout",
-	"zswp_wb",
+	"zswpwb",
 #endif
 #ifdef CONFIG_X86
 	"direct_map_level2_splits",
diff --git a/mm/zswap.c b/mm/zswap.c
index c65b8ccc6b72..0fb0945c0031 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -761,9 +761,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	zswap_written_back_pages++;
 
 	if (entry->objcg)
-		count_objcg_event(entry->objcg, ZSWP_WB);
+		count_objcg_event(entry->objcg, ZSWPWB);
 
-	count_vm_event(ZSWP_WB);
+	count_vm_event(ZSWPWB);
 	/*
 	 * Writeback started successfully, the page now belongs to the
 	 * swapcache. Drop the entry from zswap - unless invalidate already
-- 
2.34.1

