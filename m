Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC587CD058
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbjJQXV6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344285AbjJQXV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:21:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3E4F1;
        Tue, 17 Oct 2023 16:21:56 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-565334377d0so4666227a12.2;
        Tue, 17 Oct 2023 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697584916; x=1698189716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7v4RebQyJpdc4sQlri0EPJCRWGhgONmwRgz8BMi8es=;
        b=FJjUrDVNM245FBw75PZq6BIDq4hDWljDViMTS48XAb4zWxhQ9/EfhBzRsXfegH7Zu9
         zaISAdljETrWRwxggYurxfCsd05MpK1PAu/Zw/TgNqr0B1DVHfMeTbF+6mvgQqfIOOvy
         SXeSOYvTtZPzmlierwpu+LlwWNC2vzBZpU/BYTcpE7bSejjB3TD2IZg4K7bqaj2Og1Go
         sVqO1xtm1oOC6o5DHv/qaLgIvB+V9Dghs56iW8pggg3uR0nUjA0d6/G4JLzv91X6BtLZ
         W8XipcmBeFmjJOFpCynkvcbjTKh/1PdFQq61+eJtvYc/g6txSZpSOp8p5Fyhpwj+qA8i
         26nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697584916; x=1698189716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7v4RebQyJpdc4sQlri0EPJCRWGhgONmwRgz8BMi8es=;
        b=BE0hdc4f7iCzhJ1gYXxyaFHr7g7p6t9b7dvD+YxoF07hZwd+sjzokoZtRov9T7/T2t
         KsvchtWC/m0sWN737G3gj0jmFyWqpZAHiLqDatbIC9OOGcVMpy+lJMxfiw1Z1LRUxJBr
         C/LSBTknq2r/kjq3kCXi0UyUyQS2C3jA4JbwPsmt0YLRuXzrXPINWGqIV4czKiqKzqhC
         XcCzYJl3b/cDf/FAOWUav87ms6qN7N5TVwz8dMJWnKbtSS8QJdsRryunGcMIrQzU+eQS
         SZvpX5G6IEQ7ETrAOMIw9khn7BiKDuYTdddsa+ScM1MNPYgcxxfd0hm4jCsLblfJycK4
         Fmzg==
X-Gm-Message-State: AOJu0YyjDcNUr9x8Mrnoc1JYw6YuOK9muVMcTzyboN4u+CzMh7yXNOW8
        TVhwzQG3yT+TYA/gDuQqDeU=
X-Google-Smtp-Source: AGHT+IEfthOH1/vbuwx8GBxLp7AV5HAOVBnZLimkJePzXVxapwVFQUAgYitw91LLn8qQzfjU7hhxjw==
X-Received: by 2002:a05:6a20:938b:b0:17a:284:de50 with SMTP id x11-20020a056a20938b00b0017a0284de50mr4589053pzh.6.1697584915727;
        Tue, 17 Oct 2023 16:21:55 -0700 (PDT)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b001c735421215sm2116251pls.216.2023.10.17.16.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 16:21:55 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: [PATCH v3 3/5] mm: memcg: add per-memcg zswap writeback stat
Date:   Tue, 17 Oct 2023 16:21:50 -0700
Message-Id: <20231017232152.2605440-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017232152.2605440-1-nphamcs@gmail.com>
References: <20231017232152.2605440-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Since zswap now writes back pages from memcg-specific LRUs, we now need a
new stat to show writebacks count for each memcg.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/memcontrol.h |  2 ++
 mm/memcontrol.c            | 15 +++++++++++++++
 mm/zswap.c                 |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3de10fabea0f..7868b1e00bf5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -38,6 +38,7 @@ enum memcg_stat_item {
 	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
+	MEMCG_ZSWAP_WB,
 	MEMCG_NR_STAT,
 };
 
@@ -1884,6 +1885,7 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
 void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
+void obj_cgroup_report_zswap_wb(struct obj_cgroup *objcg);
 #else
 static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1bde67b29287..a9118871e5a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1505,6 +1505,7 @@ static const struct memory_stat memory_stats[] = {
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	{ "zswap",			MEMCG_ZSWAP_B			},
 	{ "zswapped",			MEMCG_ZSWAPPED			},
+	{ "zswap_wb",			MEMCG_ZSWAP_WB			},
 #endif
 	{ "file_mapped",		NR_FILE_MAPPED			},
 	{ "file_dirty",			NR_FILE_DIRTY			},
@@ -1541,6 +1542,7 @@ static int memcg_page_state_unit(int item)
 	switch (item) {
 	case MEMCG_PERCPU_B:
 	case MEMCG_ZSWAP_B:
+	case MEMCG_ZSWAP_WB:
 	case NR_SLAB_RECLAIMABLE_B:
 	case NR_SLAB_UNRECLAIMABLE_B:
 	case WORKINGSET_REFAULT_ANON:
@@ -7861,6 +7863,19 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	rcu_read_unlock();
 }
 
+void obj_cgroup_report_zswap_wb(struct obj_cgroup *objcg)
+{
+	struct mem_cgroup *memcg;
+
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	mod_memcg_state(memcg, MEMCG_ZSWAP_WB, 1);
+	rcu_read_unlock();
+}
+
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
diff --git a/mm/zswap.c b/mm/zswap.c
index d2989ad11814..15485427e3fa 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -704,6 +704,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
 	}
 	zswap_written_back_pages++;
 
+	if (entry->objcg)
+		obj_cgroup_report_zswap_wb(entry->objcg);
+
 	/*
 	 * Writeback started successfully, the page now belongs to the
 	 * swapcache. Drop the entry from zswap - unless invalidate already
-- 
2.34.1
