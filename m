Return-Path: <linux-kselftest+bounces-7310-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084B89A32C
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 19:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8267A1C2309E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70BC172BAE;
	Fri,  5 Apr 2024 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M27p1m11";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="M27p1m11"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F79171654;
	Fri,  5 Apr 2024 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336757; cv=none; b=mZtJp9KNrsTiD/t+pznfVhkQZN4dNzhJ29fWM3rxvkZsUcHQmead0VzR8T2NFDmImSi6+R2OqJy+aJLuI6cXX0g+yJY4ZKhg5SNEU+GYIrLtg1xUjLB+rIqQum669P+7ATS6VdUEyktG79ALFyM4kwe3YnLC+sWIc87JNSPKFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336757; c=relaxed/simple;
	bh=sPWomlH42GSPC8FCYxN4QQe0f/8LW2MvH6awxWIfb6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ds1aAKdZhawULXzpij40sVdxjguemQngH/9muadPy1FFAogxx2eWbF2A2IPcZi4t2VtQE5ESGiIRANS+EdEXqsegnK24Pb3FDvmIold+mcJwrt2VEY81NqyxJ9NOHjqZ5AlieMZ/52z9sF80DkwWtfdE/L905Jab0HqcU48Xl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M27p1m11; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=M27p1m11; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34CA61F7F4;
	Fri,  5 Apr 2024 17:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRGyDW5BMfeGg/s6hpmSE9vhQP8y8fh2YoU5mcLt2yA=;
	b=M27p1m11Ht5Pu5PIP6UwT867d/DWm7V3SoiE7MT+oSH+eP+YBDBhAUaHdCaVwtkfZkaqnl
	qeaOIlQqkvI/KULz0GQb9OanZ2+S4ljfbYHtZ1uLMATYkB9wguanIERi1RAkH6BwSaNccK
	kTUazKSZODYMhyfwC49ebMM0kAlXSaM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712336752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WRGyDW5BMfeGg/s6hpmSE9vhQP8y8fh2YoU5mcLt2yA=;
	b=M27p1m11Ht5Pu5PIP6UwT867d/DWm7V3SoiE7MT+oSH+eP+YBDBhAUaHdCaVwtkfZkaqnl
	qeaOIlQqkvI/KULz0GQb9OanZ2+S4ljfbYHtZ1uLMATYkB9wguanIERi1RAkH6BwSaNccK
	kTUazKSZODYMhyfwC49ebMM0kAlXSaM=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9408713AAF;
	Fri,  5 Apr 2024 17:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4E9hI28vEGYteAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Fri, 05 Apr 2024 17:05:51 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Subject: [RFC PATCH v3 5/9] selftests: cgroup: Lexicographic order in Makefile
Date: Fri,  5 Apr 2024 19:05:44 +0200
Message-ID: <20240405170548.15234-6-mkoutny@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240405170548.15234-1-mkoutny@suse.com>
References: <20240405170548.15234-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLqco6ghhk4ot65weiawc5nc38)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]

This will reduce number of conflicts when modifying the lists.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 tools/testing/selftests/cgroup/Makefile | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

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


