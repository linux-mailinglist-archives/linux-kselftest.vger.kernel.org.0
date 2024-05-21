Return-Path: <linux-kselftest+bounces-10472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 559838CAAA6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 11:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ED51C217F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7666A8BA;
	Tue, 21 May 2024 09:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BN8DHK2/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nuBuxa1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3C556757;
	Tue, 21 May 2024 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283296; cv=none; b=lRKIb0hJDcCwmQUGejDx3YjxKE/WSUcYj9ki1G/D8ZB81N6IeKekz4Duxpk99zpJ3LsPDCiIIPDthqk4CoOTQ4ur3HbQC/fyhCPaHwnVEpmMuAo2XdudrIban5Q9ig+FOkOj4RHtcdotYmbtbOzh6z2H6V/GZwH7Pu+Q1XIVOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283296; c=relaxed/simple;
	bh=aGGZqHMTeZl1PeVqd8ECTwkR1bDl0QvDFhmPr4T3YEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XiwU2lbxzGdL2GZUYsWlFI5kQEeH/KShECAkHrko1NQGYQwJRNNfERIhD/kAUFVnFpXZJk0kKGjyedRAGQ0Odx9Lt3m1ZqBqxuhnDi258xaVNmwyICbjxL1CNFQ7P5QtxthLUM8CnWjg0FycghaChMcdwEdSG1qxP4A3KTSPTbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BN8DHK2/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nuBuxa1C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6FDC5BFD7;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8p6Nf0GNnitwcvf22RgC/cjzL7uJnfLO+zroG70WaqA=;
	b=BN8DHK2//+ss9OrO3fqAEt97T21ZWZ7VCi2Yc9aLitXxrLk3qZyyuJSttuj8eFi6saoqg6
	v6E6o4VMIP0qRJvFOUWR6eLq7fkByAokkne0y92ZMig1qJndYHc9L4FXqJ9DmDBRwfVMV7
	aLmIMhiE1+2ooWJuwEE1u73dySd0ooA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716283291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8p6Nf0GNnitwcvf22RgC/cjzL7uJnfLO+zroG70WaqA=;
	b=nuBuxa1CvlJtz7LRXU/5dqAH04ghB5RKGTPKuoreKR3tdcHIWsNFvyc1DEfmMt5qBihxEg
	u9cqaYcii4qeqRXNmBf+zMW8LP0ItT12aQ54Nf5SLLi+tlQhBY++RuLG6FzydWswD9iUYA
	gw74s9T+dTFJ1QkTKJbYFs+KfhJOI8Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D67D713A7B;
	Tue, 21 May 2024 09:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QDE8NJtnTGaZYgAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 21 May 2024 09:21:31 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: [PATCH v5 4/5] selftests: cgroup: Lexicographic order in Makefile
Date: Tue, 21 May 2024 11:21:29 +0200
Message-ID: <20240521092130.7883-5-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240521092130.7883-1-mkoutny@suse.com>
References: <20240521092130.7883-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL6j1h7wxugqfdyj8pnx7tibp9)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

This will reduce number of conflicts when modifying the lists.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/.gitignore | 10 +++++-----
 tools/testing/selftests/cgroup/Makefile   | 23 ++++++++++++-----------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/selftests/cgroup/.gitignore
index 2732e0b29271..ec635a0ef488 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -1,11 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
-test_memcontrol
 test_core
-test_freezer
-test_kmem
-test_kill
 test_cpu
 test_cpuset
-test_zswap
+test_freezer
 test_hugetlb_memcg
+test_kill
+test_kmem
+test_memcontrol
+test_zswap
 wait_inotify
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index 16461dc0ffdf..b91f60f3402c 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -6,26 +6,27 @@ all: ${HELPER_PROGS}
 TEST_FILES     := with_stress.sh
 TEST_PROGS     := test_stress.sh test_cpuset_prs.sh test_cpuset_v1_hp.sh
 TEST_GEN_FILES := wait_inotify
-TEST_GEN_PROGS = test_memcontrol
-TEST_GEN_PROGS += test_kmem
-TEST_GEN_PROGS += test_core
-TEST_GEN_PROGS += test_freezer
-TEST_GEN_PROGS += test_kill
+# Keep the lists lexicographically sorted
+TEST_GEN_PROGS  = test_core
 TEST_GEN_PROGS += test_cpu
 TEST_GEN_PROGS += test_cpuset
-TEST_GEN_PROGS += test_zswap
+TEST_GEN_PROGS += test_freezer
 TEST_GEN_PROGS += test_hugetlb_memcg
+TEST_GEN_PROGS += test_kill
+TEST_GEN_PROGS += test_kmem
+TEST_GEN_PROGS += test_memcontrol
+TEST_GEN_PROGS += test_zswap
 
 LOCAL_HDRS += $(selfdir)/clone3/clone3_selftests.h $(selfdir)/pidfd/pidfd.h
 
 include ../lib.mk
 
-$(OUTPUT)/test_memcontrol: cgroup_util.c
-$(OUTPUT)/test_kmem: cgroup_util.c
 $(OUTPUT)/test_core: cgroup_util.c
-$(OUTPUT)/test_freezer: cgroup_util.c
-$(OUTPUT)/test_kill: cgroup_util.c
 $(OUTPUT)/test_cpu: cgroup_util.c
 $(OUTPUT)/test_cpuset: cgroup_util.c
-$(OUTPUT)/test_zswap: cgroup_util.c
+$(OUTPUT)/test_freezer: cgroup_util.c
 $(OUTPUT)/test_hugetlb_memcg: cgroup_util.c
+$(OUTPUT)/test_kill: cgroup_util.c
+$(OUTPUT)/test_kmem: cgroup_util.c
+$(OUTPUT)/test_memcontrol: cgroup_util.c
+$(OUTPUT)/test_zswap: cgroup_util.c
-- 
2.44.0


