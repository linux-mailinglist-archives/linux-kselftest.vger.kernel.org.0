Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A9352BF9B
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 18:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiERPk5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 11:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239509AbiERPkx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 11:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AD52E9C2;
        Wed, 18 May 2022 08:40:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BB77A1F8CD;
        Wed, 18 May 2022 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652888447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/VfT98eDaSoE5VMKiC0q6OouDpijrF5gH7LM1N1KeA=;
        b=k2d+vXCBAm/e+L/WEhM4ig/Az5Mm4+rmJrHEMYxxue2I23dt8xecICNQ2v5ID3l+LK6epR
        awB4numSb8SgyTXxoNR0VrKF0ze7zsp6jXtQKezfLUuWVv/S6BgX1aYtPu9KNvFtOnQ+8y
        tiE8oXjgMdidP4GubiG3j7iSm0CF/A0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BE4013ADC;
        Wed, 18 May 2022 15:40:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EKYKIX8ThWJDUgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 15:40:47 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH 3/4] selftests: memcg: Adjust expected reclaim values of protected cgroups
Date:   Wed, 18 May 2022 17:40:36 +0200
Message-Id: <20220518154037.18819-4-mkoutny@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220518154037.18819-1-mkoutny@suse.com>
References: <20220518154037.18819-1-mkoutny@suse.com>
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

The new values make the protection tests succeed more precisely.

	% run as: octave-cli script
	%
	% Input configurations
	% -------------------
	% E parent effective protection
	% n nominal protection of siblings set at the givel level
	% c current consumption -,,-

	% example from testcase (values in GB)
	E = 50 / 1024;
	n = [75 25 0 500 ] / 1024;
	c = [50 50 50 0] / 1024;

	% Reclaim parameters
	% ------------------

	% Minimal reclaim amount (GB)
	cluster = 32*4 / 2**20;

	% Reclaim coefficient (think as 0.5^sc->priority)
	alpha = .1

	% Simulation parameters
	% ---------------------
	epsilon = 1e-7;
	timeout = 1000;

	% Simulation loop
	% ---------------------
	% Simulation assumes siblings consumed the initial amount of memory (w/out
	% reclaim) and then the reclaim starts, all memory is reclaimable, i.e. treated
	% same. It simulates only non-low reclaim and assumes all memory.min = 0.

	ch = [];
	eh = [];
	rh = [];

	for t = 1:timeout
		% low_usage
		u = min(c, n);
		siblings = sum(u);

		% effective_protection()
		protected = min(n, c);                % start with nominal
		e = protected * min(1, E / siblings); % normalize overcommit

		% recursive protection
		unclaimed = max(0, E - siblings);
		parent_overuse = sum(c) - siblings;
		if (unclaimed > 0 && parent_overuse > 0)
			overuse = max(0, c - protected);
			e += unclaimed * (overuse / parent_overuse);
		endif

		% get_scan_count()
		r = alpha * c;             % assume all memory is in a single LRU list

		% commit 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection")
		sz = max(e, c);
		r .*= (1 - (e+epsilon) ./ (sz+epsilon));

		% uncomment to debug prints
		% e, c, r

		% nothing to reclaim, reached equilibrium
		if max(r) < epsilon
			break;
		endif

		% SWAP_CLUSTER_MAX
		r = max(r, (r > epsilon) .* cluster);
		% XXX here I do parallel reclaim of all siblings
		% in reality reclaim is serialized and each sibling recalculates own residual
		c = max(c - r, 0);

		ch = [ch ; c];
		eh = [eh ; e];
		rh = [rh ; r];
	endfor

	t
	c, e

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 .../selftests/cgroup/test_memcontrol.c        | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index eba252fa64ac..9ffacf024bbd 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -260,9 +260,9 @@ static int cg_test_proc_killed(const char *cgroup)
  * memory pressure in it.
  *
  * A/B    memory.current ~= 50M
- * A/B/C  memory.current ~= 33M
- * A/B/D  memory.current ~= 17M
- * A/B/F  memory.current ~= 0
+ * A/B/C  memory.current ~= 29M
+ * A/B/D  memory.current ~= 21M
+ * A/B/E  memory.current ~= 0
  *
  * After that it tries to allocate more than there is
  * unprotected memory in A available, and checks
@@ -365,10 +365,10 @@ static int test_memcg_min(const char *root)
 	for (i = 0; i < ARRAY_SIZE(children); i++)
 		c[i] = cg_read_long(children[i], "memory.current");
 
-	if (!values_close(c[0], MB(33), 10))
+	if (!values_close(c[0], MB(29), 10))
 		goto cleanup;
 
-	if (!values_close(c[1], MB(17), 10))
+	if (!values_close(c[1], MB(21), 10))
 		goto cleanup;
 
 	if (c[3] != 0)
@@ -417,9 +417,9 @@ static int test_memcg_min(const char *root)
  *
  * Then it checks actual memory usages and expects that:
  * A/B    memory.current ~= 50M
- * A/B/   memory.current ~= 33M
- * A/B/D  memory.current ~= 17M
- * A/B/F  memory.current ~= 0
+ * A/B/   memory.current ~= 29M
+ * A/B/D  memory.current ~= 21M
+ * A/B/E  memory.current ~= 0
  *
  * After that it tries to allocate more than there is
  * unprotected memory in A available,
@@ -512,10 +512,10 @@ static int test_memcg_low(const char *root)
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

