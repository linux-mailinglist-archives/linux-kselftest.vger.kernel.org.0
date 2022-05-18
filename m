Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F59352C04C
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239991AbiERQTS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 12:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiERQTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 12:19:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038AD1E3EFD;
        Wed, 18 May 2022 09:19:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5F4C21BA7;
        Wed, 18 May 2022 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652890752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jz175m5BintFEQXa5vYWU8KGZ2S2n3yhFMeXI9nACjg=;
        b=Y1AxG1HYouI9vt1vi8DXaHiuyCcPdQF77tXXyJcO8vKlHGlluMPvqEN6uU/uT190k+/mtU
        BCZEwbMcTL50/it95GxUSwvIs04TS7IMojPCAWt3IfzmGLzcCDKWGsHwQebF0gwHLzOTD+
        AvG2YknZyRCvnTYpb4etcd+9lQxbJTM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AA0113ADC;
        Wed, 18 May 2022 16:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EFkaHYAchWLqZAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 16:19:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH v2 3/5] selftests: memcg: Adjust expected reclaim values of protected cgroups
Date:   Wed, 18 May 2022 18:18:57 +0200
Message-Id: <20220518161859.21565-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518161859.21565-1-mkoutny@suse.com>
References: <20220518161859.21565-1-mkoutny@suse.com>
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

The numbers are not easy to derive in a closed form (certainly mere
protections ratios do not apply), therefore use a simulation to obtain
expected numbers.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 MAINTAINERS                                   |  1 +
 .../selftests/cgroup/memcg_protection.m       | 89 +++++++++++++++++++
 .../selftests/cgroup/test_memcontrol.c        | 29 +++---
 3 files changed, 107 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/cgroup/memcg_protection.m

diff --git a/MAINTAINERS b/MAINTAINERS
index 78c57046fa93..b28b6aeb8636 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5029,6 +5029,7 @@ L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/memcontrol.c
 F:	mm/swap_cgroup.c
+F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c
 
diff --git a/tools/testing/selftests/cgroup/memcg_protection.m b/tools/testing/selftests/cgroup/memcg_protection.m
new file mode 100644
index 000000000000..051daa3477b6
--- /dev/null
+++ b/tools/testing/selftests/cgroup/memcg_protection.m
@@ -0,0 +1,89 @@
+% SPDX-License-Identifier: GPL-2.0
+%
+% run as: octave-cli memcg_protection.m
+%
+% This script simulates reclaim protection behavior on a single level of memcg
+% hierarchy to illustrate how overcommitted protection spreads among siblings
+% (as it depends also on their current consumption).
+%
+% Simulation assumes siblings consumed the initial amount of memory (w/out
+% reclaim) and then the reclaim starts, all memory is reclaimable, i.e. treated
+% same. It simulates only non-low reclaim and assumes all memory.min = 0.
+%
+% Input configurations
+% --------------------
+% E number	parent effective protection
+% n vector	nominal protection of siblings set at the given level (memory.low)
+% c vector	current consumption -,,- (memory.current)
+
+% example from testcase (values in GB)
+E = 50 / 1024;
+n = [75 25 0 500 ] / 1024;
+c = [50 50 50 0] / 1024;
+
+% Reclaim parameters
+% ------------------
+
+% Minimal reclaim amount (GB)
+cluster = 32*4 / 2**20;
+
+% Reclaim coefficient (think as 0.5^sc->priority)
+alpha = .1
+
+% Simulation parameters
+% ---------------------
+epsilon = 1e-7;
+timeout = 1000;
+
+% Simulation loop
+% ---------------
+
+ch = [];
+eh = [];
+rh = [];
+
+for t = 1:timeout
+        % low_usage
+        u = min(c, n);
+        siblings = sum(u);
+
+        % effective_protection()
+        protected = min(n, c);                % start with nominal
+        e = protected * min(1, E / siblings); % normalize overcommit
+
+        % recursive protection
+        unclaimed = max(0, E - siblings);
+        parent_overuse = sum(c) - siblings;
+        if (unclaimed > 0 && parent_overuse > 0)
+                overuse = max(0, c - protected);
+                e += unclaimed * (overuse / parent_overuse);
+        endif
+
+        % get_scan_count()
+        r = alpha * c;             % assume all memory is in a single LRU list
+
+        % commit 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection")
+        sz = max(e, c);
+        r .*= (1 - (e+epsilon) ./ (sz+epsilon));
+
+        % uncomment to debug prints
+        % e, c, r
+
+        % nothing to reclaim, reached equilibrium
+        if max(r) < epsilon
+                break;
+        endif
+
+        % SWAP_CLUSTER_MAX roundup
+        r = max(r, (r > epsilon) .* cluster);
+        % XXX here I do parallel reclaim of all siblings
+        % in reality reclaim is serialized and each sibling recalculates own residual
+        c = max(c - r, 0);
+
+        ch = [ch ; c];
+        eh = [eh ; e];
+        rh = [rh ; r];
+endfor
+
+t
+c, e
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index 4924425639b0..dc2c7d6e3572 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -248,7 +248,7 @@ static int cg_test_proc_killed(const char *cgroup)
 /*
  * First, this test creates the following hierarchy:
  * A       memory.min = 50M,  memory.max = 200M
- * A/B     memory.min = 50M,  memory.current = 50M
+ * A/B     memory.min = 50M
  * A/B/C   memory.min = 75M,  memory.current = 50M
  * A/B/D   memory.min = 25M,  memory.current = 50M
  * A/B/E   memory.min = 0,    memory.current = 50M
@@ -259,10 +259,13 @@ static int cg_test_proc_killed(const char *cgroup)
  * Then it creates A/G and creates a significant
  * memory pressure in it.
  *
+ * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 33M
- * A/B/D  memory.current ~= 17M
- * A/B/F  memory.current ~= 0
+ * A/B/C  memory.current ~= 29M
+ * A/B/D  memory.current ~= 21M
+ * A/B/E  memory.current ~= 0
+ * A/B/F  memory.current  = 0
+ * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is
  * unprotected memory in A available, and checks
@@ -365,10 +368,10 @@ static int test_memcg_min(const char *root)
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(33), 10))
+	if (!values_close(c[0], MB(29), 10))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(17), 10))
+	if (!values_close(c[1], MB(21), 10))
 		goto cleanup;
 
 	if (c[3] != 0)
@@ -405,7 +408,7 @@ static int test_memcg_min(const char *root)
 /*
  * First, this test creates the following hierarchy:
  * A       memory.low = 50M,  memory.max = 200M
- * A/B     memory.low = 50M,  memory.current = 50M
+ * A/B     memory.low = 50M
  * A/B/C   memory.low = 75M,  memory.current = 50M
  * A/B/D   memory.low = 25M,  memory.current = 50M
  * A/B/E   memory.low = 0,    memory.current = 50M
@@ -417,9 +420,11 @@ static int test_memcg_min(const char *root)
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
- * A/B/   memory.current ~= 33M
- * A/B/D  memory.current ~= 17M
- * A/B/F  memory.current ~= 0
+ * A/B/C  memory.current ~= 29M
+ * A/B/D  memory.current ~= 21M
+ * A/B/E  memory.current ~= 0
+ * A/B/F  memory.current  = 0
+ * (for origin of the numbers, see model in memcg_protection.m.)
  *
  * After that it tries to allocate more than there is
  * unprotected memory in A available,
@@ -512,10 +517,10 @@ static int test_memcg_low(const char *root)
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(33), 10))
+	if (!values_close(c[0], MB(29), 10))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(17), 10))
+	if (!values_close(c[1], MB(21), 10))
 		goto cleanup;
 
 	if (c[3] != 0)
-- 
2.35.3

