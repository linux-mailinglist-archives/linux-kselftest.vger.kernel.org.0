Return-Path: <linux-kselftest+bounces-900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F84F7FFB90
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13BD1C2083C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7C53E02;
	Thu, 30 Nov 2023 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0UCbEt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F1C10EA;
	Thu, 30 Nov 2023 11:40:28 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d03bcf27e9so7066955ad.0;
        Thu, 30 Nov 2023 11:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373228; x=1701978028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niZWwQJsg3s1qyFf7Pomuagp8ezW4TnieKlMs2EcKiM=;
        b=N0UCbEt1llaMGS5NVeWsQHtIr7AXbwC+liy73RKvhcNHQ+zFiTZWe29FVSE96euwkc
         hS8V/pw3x7ZXPvfhgkaJ2+5v6LKyeqPMlqBTW+wyp/q/QrKvCwagOSZakATKd75tdF0a
         EO3crZvlWFPDDj1G3VkS4BSmYNLJ3hxnr13Ko82MnZ22wCWL0RdpAp3N29IVd4bl5Vlj
         wEJyE4b+jN679hwQnGFf8NrrirMhMKiZ6zSshNmVJThFZ/ZzllZ5RhaN9vZ+oSsyev6j
         4+0of5hsnHE4jygvP6sJAexJchU+sSJUGEcJ+IQNMNW88QQERqSAEuZECmo0q49Tq79D
         1j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373228; x=1701978028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niZWwQJsg3s1qyFf7Pomuagp8ezW4TnieKlMs2EcKiM=;
        b=WeE29vg9GEhO31su0u2+OXVIih3hEAS65pqN9TQSmA30OVKGG/iYUAsW+KIJRrlY5P
         RflqGymzegtBVtCxM/dzz7y5KnFnvvI8z3nqg4vvm+kNIcrL4yvd3qDsMRn9GfugWU6Y
         CmxsjPM/I8Ob5hhi/OsNsQVjmuqqtIX9Gb9VR6NeDKk0h3dwj7FH1fIEJ25vAEuR8XUV
         1AZB74DhPSOvD6+04jb2vbJt7+EQ3gpxcKpgonwBWK4TFJoVQ4S+3UJZTUQ+O8hJ1cJR
         YxnH84EgWHzyh6MhI27s6Zh5VO9usgSa4eCs0QXnOYNvCEmqgl/QqcKtdIEZCAx13Tx6
         zf6w==
X-Gm-Message-State: AOJu0YxGoMraRiDuYCsbqEaTmmb7i8GcoGUntgXHHyajpk0AICLFtyFM
	XhMqjz3BOIStAsX04ymfZtU=
X-Google-Smtp-Source: AGHT+IFfTa0RqUbqN68E841pToksnDYD8v2JC5yPpULGd+IB0r6tjgvOZkq96Lrz0GR4iBzyYy4mBw==
X-Received: by 2002:a17:902:82c3:b0:1cc:237c:75d6 with SMTP id u3-20020a17090282c300b001cc237c75d6mr21599414plz.67.1701373227682;
        Thu, 30 Nov 2023 11:40:27 -0800 (PST)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902d30d00b001cf9eac2d3asm1781733plc.118.2023.11.30.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:40:27 -0800 (PST)
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
Subject: [PATCH v8 4/6] mm: memcg: add per-memcg zswap writeback stat
Date: Thu, 30 Nov 2023 11:40:21 -0800
Message-Id: <20231130194023.4102148-5-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-1-nphamcs@gmail.com>
References: <20231130194023.4102148-1-nphamcs@gmail.com>
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
 mm/zswap.c                    | 4 ++++
 4 files changed, 7 insertions(+)

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
index 792ca21c5815..21d79249c8b4 100644
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
index f323e45cbdc7..49b79393e472 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -760,6 +760,10 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	}
 	zswap_written_back_pages++;
 
+	if (entry->objcg)
+		count_objcg_event(entry->objcg, ZSWP_WB);
+
+	count_vm_event(ZSWP_WB);
 	/*
 	 * Writeback started successfully, the page now belongs to the
 	 * swapcache. Drop the entry from zswap - unless invalidate already
-- 
2.34.1

