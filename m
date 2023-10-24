Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAF57D5C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234576AbjJXUdN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 16:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344257AbjJXUdJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 16:33:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3957110C6;
        Tue, 24 Oct 2023 13:33:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b20a48522fso4044595b3a.1;
        Tue, 24 Oct 2023 13:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698179587; x=1698784387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct7ILXQfwShOguQLCzN2H+ZHxo/ASPBQwkijnwC3QMY=;
        b=mx/JAUfh/nssCcDKV4iKjOlIPymTxWU0hn8+/wV/rd+n3Ezj0tSSJ9uUBEZK2gsJDQ
         ZHKLg+IexB4qxfAd0nEzidsC01Nyo6VkQEvVGmXo5AtRXiCFzb+UGDGUO0311hzyuXCF
         OxuIBo7khh1w5z21aYaSk5qnTyU0BiUmxCx99Hd3DM/NVeBj3f9+rKcFwHqJzdzbkaR8
         6evTjSTrcyWCAOpsWO4MJgEKHdTK0gmNfoetr6bLNwqT2p8zh54RMdxWIUt0Di6JpMUz
         ayGf3noxlluMOy2kzXpiokQMDHSFfEAy8DQGprRXxTGwoag+8Hu4LvP2XHeLJ+x6LCgS
         m5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698179587; x=1698784387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct7ILXQfwShOguQLCzN2H+ZHxo/ASPBQwkijnwC3QMY=;
        b=RgaOlRizY+LHgf3dB0qm3BHZOL2Yh4TsiihJeefCHmyMot0D1ZBHyFeh+58HZ+wvcp
         uuHeyt1CdgFMXOwu0/ihqqr6I2ooTo8//24nxzy+5UQ1zpK/VUFF6mxS5hO64TJq+4NP
         lB6Ii49psIeqjMAWDNTRwGtO6kMCDwVFc00UFM6HK05c7dhTl00o+KyimDfpuoF2QAJ+
         i98D6CPJvjdgckilcsVVuN3SH2JUFU1GjZR5Avjt+AWBREUafkH/XNF7kbyeUIxqdY1y
         CsknWuNheHtZy1Qpydit/1dKyXAc+uYIGV5VmW2NKJUwgucHCoYmZxCSTyT3riDwqYAW
         /Lfg==
X-Gm-Message-State: AOJu0YyfprAS2CbcgLxf3MqNo2v3/Nwpk53n54jzfSiXA0QytyfKr6QO
        066fYzkWjGvfKWlm0eHE+zA=
X-Google-Smtp-Source: AGHT+IEqQ/yO6Q0UWV3ZQ4PNu7f2MkIruUL16KnuV71cH8iufU01U3EFGNtF5ep2fwen3nE8TNzFNg==
X-Received: by 2002:a05:6a00:1142:b0:6be:23dd:d612 with SMTP id b2-20020a056a00114200b006be23ddd612mr12348489pfm.16.1698179587511;
        Tue, 24 Oct 2023 13:33:07 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id z2-20020aa79f82000000b00692cac7a065sm7990229pfr.151.2023.10.24.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 13:33:06 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: [PATCH v4 3/5] mm: memcg: add per-memcg zswap writeback stat
Date:   Tue, 24 Oct 2023 13:33:00 -0700
Message-Id: <20231024203302.1920362-4-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024203302.1920362-1-nphamcs@gmail.com>
References: <20231024203302.1920362-1-nphamcs@gmail.com>
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
 include/linux/vm_event_item.h | 1 +
 mm/memcontrol.c               | 1 +
 mm/vmstat.c                   | 1 +
 mm/zswap.c                    | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 8abfa1240040..3153359c3841 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -145,6 +145,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 #ifdef CONFIG_ZSWAP
 		ZSWPIN,
 		ZSWPOUT,
+		ZSWP_WB,
 #endif
 #ifdef CONFIG_X86
 		DIRECT_MAP_LEVEL2_SPLIT,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 61c0c46c2d62..568d9d037a59 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -593,6 +593,7 @@ static const unsigned int memcg_vm_event_stat[] = {
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	ZSWPIN,
 	ZSWPOUT,
+	ZSWP_WB,
 #endif
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	THP_FAULT_ALLOC,
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 359460deb377..5e5572f3b456 100644
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
index ee8e227e7b0b..b87311e48de9 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -711,6 +711,9 @@ static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_o
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
