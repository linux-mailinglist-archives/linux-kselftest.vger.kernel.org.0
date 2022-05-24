Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB81E532EFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 18:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiEXQaS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiEXQaQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 12:30:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78615D5D1;
        Tue, 24 May 2022 09:30:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C2571F941;
        Tue, 24 May 2022 16:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653409812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/28T1m86MB9ujlmLJb4eXjaHRV5vnP9lMxKKAV2s7M=;
        b=vMBWmf3N5rE2fTHBk4VnwarSBhJt3hyhYylDzlH2PRkMyihqTjMkaxfWkWEm9omCF2d7+N
        F4Wdv78zuDLvKFX2zcyhMnXZ3x0giump/GY+KsnYMHc1W15lPEb9OuoCnAEH6DkT9hrTll
        5D5Vr23Nb08SWTG8MT+Q5S4RbDV6EOE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 515A113ADF;
        Tue, 24 May 2022 16:30:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UN3dEhQIjWJaWgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 24 May 2022 16:30:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v3 4/5] selftests: memcg: Remove protection from top level memcg
Date:   Tue, 24 May 2022 18:29:54 +0200
Message-Id: <20220524162955.8635-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220524162955.8635-1-mkoutny@suse.com>
References: <20220524162955.8635-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The reclaim is triggered by memory limit in a subtree, therefore the
testcase does not need configured protection against external reclaim.

Also, correct respective comments

Signed-off-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 tools/testing/selftests/cgroup/test_memcontrol.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index dc2c7d6e3572..63c6a683a8c1 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -247,7 +247,7 @@ static int cg_test_proc_killed(const char *cgroup)
 
 /*
  * First, this test creates the following hierarchy:
- * A       memory.min = 50M,  memory.max = 200M
+ * A       memory.min = 0,    memory.max = 200M
  * A/B     memory.min = 50M
  * A/B/C   memory.min = 75M,  memory.current = 50M
  * A/B/D   memory.min = 25M,  memory.current = 50M
@@ -257,7 +257,7 @@ static int cg_test_proc_killed(const char *cgroup)
  * Usages are pagecache, but the test keeps a running
  * process in every leaf cgroup.
  * Then it creates A/G and creates a significant
- * memory pressure in it.
+ * memory pressure in A.
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
@@ -338,8 +338,6 @@ static int test_memcg_min(const char *root)
 			      (void *)(long)fd);
 	}
 
-	if (cg_write(parent[0], "memory.min", "50M"))
-		goto cleanup;
 	if (cg_write(parent[1], "memory.min", "50M"))
 		goto cleanup;
 	if (cg_write(children[0], "memory.min", "75M"))
@@ -407,7 +405,7 @@ static int test_memcg_min(const char *root)
 
 /*
  * First, this test creates the following hierarchy:
- * A       memory.low = 50M,  memory.max = 200M
+ * A       memory.low = 0,    memory.max = 200M
  * A/B     memory.low = 50M
  * A/B/C   memory.low = 75M,  memory.current = 50M
  * A/B/D   memory.low = 25M,  memory.current = 50M
@@ -495,8 +493,6 @@ static int test_memcg_low(const char *root)
 			goto cleanup;
 	}
 
-	if (cg_write(parent[0], "memory.low", "50M"))
-		goto cleanup;
 	if (cg_write(parent[1], "memory.low", "50M"))
 		goto cleanup;
 	if (cg_write(children[0], "memory.low", "75M"))
-- 
2.35.3

