Return-Path: <linux-kselftest+bounces-8156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 458748A6E04
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32931F2139D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A31D13441A;
	Tue, 16 Apr 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MePVtciE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MePVtciE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D713175F;
	Tue, 16 Apr 2024 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713277221; cv=none; b=oGG5XXw9/bzHxBLSfvu4AKxIfJSqh9kd4KRRgkojE9fcvnLvEwR9770zKKLSIiHFVp1fwpKMx7yU5kTs9WwV1ROsglM8TOcaIyBeAMIn83a36JxcRW4GO/fBxFVudPWdnXMqgc+tvTFCJ8sCDoR5r146wbWJxfHY2qYN66swEXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713277221; c=relaxed/simple;
	bh=MnnubNQb1MpU8uiY+ZKtpl12maQG0qaf4txwbrXwflI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CncX98PypunnwCzYYEjR45Y2kfTtOz26eL+0avJgcx/pqZjz99qT3+dzAQSBXzBj8gDlPYvQf7CMNxMmHkGPjZy+nBWeEBTcxLpztBry3JcRlh2xIp/D7VUXeDJ1lO2P9wjxJ3yn/mG5du5mEFhh07x1jBk98EJDzjtQqjCWdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MePVtciE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MePVtciE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D67C5F88E;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot2BLiwvisQGhvsJAggktKRXvdpvmoN0+S4HZX2j4vk=;
	b=MePVtciElh0ad4PI22jjey+pwl0GNxOUxsFZ4gvU6zOjVNiocr1bUMq5AYCC0REZknVhQt
	XsOtYwTHEBuZYjREYN43spoqJ7J9nzFI2FipkOakkll2eQy6MMhNHMR852m9cEXYheRgQK
	2hCd7m4IOdEI6xHj08X28Hb0qEz7nmI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MePVtciE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1713277216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ot2BLiwvisQGhvsJAggktKRXvdpvmoN0+S4HZX2j4vk=;
	b=MePVtciElh0ad4PI22jjey+pwl0GNxOUxsFZ4gvU6zOjVNiocr1bUMq5AYCC0REZknVhQt
	XsOtYwTHEBuZYjREYN43spoqJ7J9nzFI2FipkOakkll2eQy6MMhNHMR852m9cEXYheRgQK
	2hCd7m4IOdEI6xHj08X28Hb0qEz7nmI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 451B913976;
	Tue, 16 Apr 2024 14:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gOO9ECCJHmbAbQAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Tue, 16 Apr 2024 14:20:16 +0000
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
Subject: [PATCH v4 5/6] selftests: cgroup: Lexicographic order in Makefile
Date: Tue, 16 Apr 2024 16:20:13 +0200
Message-ID: <20240416142014.27630-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416142014.27630-1-mkoutny@suse.com>
References: <20240416142014.27630-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.51 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Queue-Id: 5D67C5F88E
X-Spam-Flag: NO
X-Spam-Score: -0.51
X-Spamd-Bar: /

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
index 00b441928909..f3e1ef69e88d 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -6,26 +6,27 @@ all: ${HELPER_PROGS}
 TEST_FILES     := with_stress.sh
 TEST_PROGS     := test_stress.sh test_cpuset_prs.sh
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


