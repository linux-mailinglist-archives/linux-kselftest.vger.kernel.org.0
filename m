Return-Path: <linux-kselftest+bounces-1210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7551C805EDA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 20:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18EB1F21656
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EB36ABAC;
	Tue,  5 Dec 2023 19:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaHEW5NG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE1AA5;
	Tue,  5 Dec 2023 11:54:21 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cfc9c4acb6so29817065ad.0;
        Tue, 05 Dec 2023 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701806061; x=1702410861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBZzT0/QbcprxNQTsHpzd6ven1aj0800Yb9/CoMbKBA=;
        b=JaHEW5NG9N4g2WwCC2nClWqC+0cKqCSR4aHci057CaRZZEu0/TmwvpaqSZTQa+2pdg
         rv63l77PYXQe5v5iGy9xgjYCNU7yMR+NWQRnJErQMiGZgI5V7uRhRvWqbXcnJr5D1Izz
         o+pOYe+RXiURTSjyflpWThGIr0RKc5HWAfSaWq0NoX//FiIanchdKev5ZGmHgWW0xRJC
         6Yuz4Kf1X3I3Y6/YXafRI8QCKQ5VMGKG/kNH5upcm7s/v4HtDqBGz3+BjpJLXPE+6Hna
         8UkUqwpmjOUqmaaLmhRUalxSKzYJXxc3GhzIxCTuNV5YI/sdL82hxkiQua3oJy3TGGqR
         iOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806061; x=1702410861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jBZzT0/QbcprxNQTsHpzd6ven1aj0800Yb9/CoMbKBA=;
        b=OH5TkFL5UBqlulU+oQgHtBEdTckLhXssKmdPyI+/tTuZjdbZhspoOT221kr+nh8ycS
         avoqsa9YWqHqlazetQTaCtM1tJDVaQnc/gRjBxcWIlL08SUjvVrUh8OgzYb47KlvvqgE
         XVWLrz0ea6QfvTBXQM5PVKb6bP3IeEKI4JtpV9Tr+wHIAe0wauYQWFSRVNBuz2d+msKC
         oxdAwv/VWSqG6mXH+iInoY4wq9tgjc/L4TOoLQtz00BBW4VjzLH1cj1keNYRhP4niWm2
         V8DcCvn/tMp/n5vvZQLurfAQaP7j5CLejOe+4eQe9lNv56jTZ3GItb9FavrrnqB0Cmu+
         DtXA==
X-Gm-Message-State: AOJu0Yxqyw98huwX1T0opIUi8mGPL3wHgxiNdM/X7KKYPvA61pI+ZLKp
	lnTQK2r4c5jtcJbogAqrBRM=
X-Google-Smtp-Source: AGHT+IHiN3u4lyG7cLPBE6NoEoYHDNHgelzGc9AxrA8KJTfHwHiCxIp8MO1xA3yLPhPxAMw1q8En6w==
X-Received: by 2002:a17:902:8696:b0:1d0:6ffd:6e8e with SMTP id g22-20020a170902869600b001d06ffd6e8emr3152372plo.134.1701806060641;
        Tue, 05 Dec 2023 11:54:20 -0800 (PST)
Received: from localhost (fwdproxy-prn-024.fbsv.net. [2a03:2880:ff:18::face:b00c])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001d0cd9e4248sm876201plg.196.2023.12.05.11.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:54:19 -0800 (PST)
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
Subject: [PATCH v8 3/6] zswap: make shrinking memcg-aware (fix)
Date: Tue,  5 Dec 2023 11:54:19 -0800
Message-Id: <20231205195419.2563217-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130194023.4102148-4-nphamcs@gmail.com>
References: <20231130194023.4102148-4-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct function for the onlineness check for the memcg
selection, and use mem_cgroup_iter_break() to break the iteration.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f323e45cbdc7..7a84c1454988 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -834,9 +834,9 @@ static void shrink_worker(struct work_struct *w)
 			goto resched;
 		}
 
-		if (!mem_cgroup_online(memcg)) {
+		if (!mem_cgroup_tryget_online(memcg)) {
 			/* drop the reference from mem_cgroup_iter() */
-			mem_cgroup_put(memcg);
+			mem_cgroup_iter_break(NULL, memcg);
 			pool->next_shrink = NULL;
 			spin_unlock(&zswap_pools_lock);
 
@@ -985,7 +985,7 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 	list_lru_destroy(&pool->list_lru);
 
 	spin_lock(&zswap_pools_lock);
-	mem_cgroup_put(pool->next_shrink);
+	mem_cgroup_iter_break(NULL, pool->next_shrink);
 	pool->next_shrink = NULL;
 	spin_unlock(&zswap_pools_lock);
 
-- 
2.34.1

