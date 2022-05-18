Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0543052C017
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 May 2022 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239996AbiERQTU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 May 2022 12:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239911AbiERQTP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 May 2022 12:19:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE21E3EFF;
        Wed, 18 May 2022 09:19:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D2CBF21BA9;
        Wed, 18 May 2022 16:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652890752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=knFXxowXAMafCbTNRCFjrywrAcg9buOc8PMOUQ0kGWY=;
        b=EXRlzvMzUHeQ2UHohN8HuutB3T/vKuHcHVFmzPd2+TcE5bsu3dVaiUK2iieWK96imrPi6H
        fl3D6w2W9YlrrSWEEKhK8T+XuZ7PETzEaj86LWkdZS1l+a4g+bczU1oGckuJVhDQdHvdZd
        qMKR4/c/QvpmQZqn7aoFtz4iHLdJ3m0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8B0513A6D;
        Wed, 18 May 2022 16:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eEJPKIAchWLqZAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 18 May 2022 16:19:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: [PATCH v2 4/5] selftests: memcg: Remove protection from top level memcg
Date:   Wed, 18 May 2022 18:18:58 +0200
Message-Id: <20220518161859.21565-5-mkoutny@suse.com>
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

The reclaim is triggered by memory limit in a subtree, therefore the
testcase does not need configured protection against external reclaim.

Also, correct respective comments

Signed-off-by: Michal Koutný <mkoutny@suse.com>
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

