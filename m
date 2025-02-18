Return-Path: <linux-kselftest+bounces-26904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5ECA3A92D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 21:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33C34178227
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907D01D9663;
	Tue, 18 Feb 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DV0kAi9b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651CF1C6FF8;
	Tue, 18 Feb 2025 20:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910385; cv=none; b=FZKiGwiPWva8b3FITTby9krSwCfXdz11ttpeTszz2KkZpVzzXtH8ExemxfU0kR5mKSTfgrQdVnWWE0qqd8C0VsWKz+4VuauPIZ1xrivWeD1WkK75f5FhqYD0JiI+cxhnQmeLfmaty4mEFocPTB/gYVGQFgwURzWpG3zM98JX9kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910385; c=relaxed/simple;
	bh=yj7yeckAsn7iveez2V/kKZzDE6FaGZg3nxRZwDhhx+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UyqUXiwhVZhnAn/djEaSg4bqwHVC+QomgaJ7YRack+hnjeIns38Igr+8JhPOj1q6+RaccpmKaSnhL43/DNRR3a2BLCNUK5N9CoXHvTKim4J6pMmzPYLJRO8i9JVRhFEb+amfQRA7P0ojsFHZVHat7TRmkY3LPWFTc1YHAFLDQAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DV0kAi9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0088BC4CEE2;
	Tue, 18 Feb 2025 20:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910385;
	bh=yj7yeckAsn7iveez2V/kKZzDE6FaGZg3nxRZwDhhx+E=;
	h=From:To:Cc:Subject:Date:From;
	b=DV0kAi9bxoVXhH/V5gSvUvg+Mbk1cd9RjBaqxvD5rK4wLd0RsrYoc5IMAuQSDPgtk
	 zgO7www9SXcrOFxt6i4S+/esxKLTTmf3CXwgPU62ROuiXD4aVMYl+Y4WptE53yWum5
	 nkNWJDuIwSED7BPR8hj/79hIdouvzKsEAA4OeMtOhpEe9GsYFL88Y5Vlt8DmJVIs+j
	 wW77Dssy5h2X6Sq+ysim3aPVI+W0YHmevqBCP0WSbLIMDUR2ohO2GXWGRXN4aqMyH2
	 6OXH086kSj+QQfPnioLAndQX58aV4zmx+kkNUnMyoreLXcytM3Ufr+ynvjbrOWM16W
	 OWKClZwj7mhXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Ihor Solodrai <ihor.solodrai@pm.me>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	dvernet@meta.com,
	vishalc@linux.ibm.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 01/31] sched_ext: selftests/dsp_local_on: Fix sporadic failures
Date: Tue, 18 Feb 2025 15:25:47 -0500
Message-Id: <20250218202619.3592630-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
Content-Transfer-Encoding: 8bit

From: Tejun Heo <tj@kernel.org>

[ Upstream commit e9fe182772dcb2630964724fd93e9c90b68ea0fd ]

dsp_local_on has several incorrect assumptions, one of which is that
p->nr_cpus_allowed always tracks p->cpus_ptr. This is not true when a task
is scheduled out while migration is disabled - p->cpus_ptr is temporarily
overridden to the previous CPU while p->nr_cpus_allowed remains unchanged.

This led to sporadic test faliures when dsp_local_on_dispatch() tries to put
a migration disabled task to a different CPU. Fix it by keeping the previous
CPU when migration is disabled.

There are SCX schedulers that make use of p->nr_cpus_allowed. They should
also implement explicit handling for p->migration_disabled.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/sched_ext/dsp_local_on.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
index c9a2da0575a0f..eea06decb6f59 100644
--- a/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
+++ b/tools/testing/selftests/sched_ext/dsp_local_on.bpf.c
@@ -43,7 +43,7 @@ void BPF_STRUCT_OPS(dsp_local_on_dispatch, s32 cpu, struct task_struct *prev)
 	if (!p)
 		return;
 
-	if (p->nr_cpus_allowed == nr_cpus)
+	if (p->nr_cpus_allowed == nr_cpus && !p->migration_disabled)
 		target = bpf_get_prandom_u32() % nr_cpus;
 	else
 		target = scx_bpf_task_cpu(p);
-- 
2.39.5


