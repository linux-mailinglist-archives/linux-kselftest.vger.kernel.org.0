Return-Path: <linux-kselftest+bounces-29929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A63A75CCF
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6113A7D85
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0552B1DF270;
	Sun, 30 Mar 2025 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P1nh4vwQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C531DEFF5
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371631; cv=none; b=VAT6pwxhY6eFrwY76DmUHCQQyNhOSJ/480NpI9+/UzCAXAPYRA7UDTWUJfeoAv5tP1rMM4adkYEFaXJJ6TezdfjQz6lzTYIYG0x8ktVc8uJuaTf0+QAV7v/MkCATYLfk9IGwt6jfiaJOpLSeHph5g0fLlv53vf0N8OlR/VIjmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371631; c=relaxed/simple;
	bh=wuz7dQjW4GksKreG6OnLaCEiuCciU6dK1/UI8+XCnE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCB6+b3dCKn4KDjQW9EEfU+q79Ow+YlENJZ40J7weRpp/EHUHwG+ZTnaiVT3GxomhU59B2bgGmKBfSoRbPmCl/nr7WI444IfqnwUchSLFQWNwacbAL9EL4rDxbI3XfYvQwJZa62b7AcEnSLYSuVAntNsqEKM7Xz2vrjSAxFbybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P1nh4vwQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CB/Uv93M0XbdQ9W92LsZCAqbIiA807T8NNAvIq2S4qM=;
	b=P1nh4vwQdXmYXfQZCLFuhdrAE0K3yiD/JssxGkFyhOKy7hNFyeCxpHyHQ/1mZ/T1ACoCWL
	IzN8zGWwkXyrd4sa6l5hKC64kdumPeSdy1+OpMr+RHjp6jgb6agFdE/fzIUUwPNju9tqWf
	YWISlFkrenWShoEGrpkgMGYemL2w5zk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-JDlCuB1oM5uManP34w8Rsw-1; Sun,
 30 Mar 2025 17:53:46 -0400
X-MC-Unique: JDlCuB1oM5uManP34w8Rsw-1
X-Mimecast-MFC-AGG-ID: JDlCuB1oM5uManP34w8Rsw_1743371625
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D69D71801A06;
	Sun, 30 Mar 2025 21:53:44 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 236D01801750;
	Sun, 30 Mar 2025 21:53:42 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 02/10] cgroup/cpuset: Fix incorrect isolated_cpus update in update_parent_effective_cpumask()
Date: Sun, 30 Mar 2025 17:52:40 -0400
Message-ID: <20250330215248.3620801-3-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Before commit f0af1bfc27b5 ("cgroup/cpuset: Relax constraints to
partition & cpus changes"), a cpuset partition cannot be enabled if not
all the requested CPUs can be granted from the parent cpuset. After
that commit, a cpuset partition can be created even if the requested
exclusive CPUs contain CPUs not allowed its parent.  The delmask
containing exclusive CPUs to be removed from its parent wasn't
adjusted accordingly.

That is not a problem until the introduction of a new isolated_cpus
mask in commit 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in
isolated partitions") as the CPUs in the delmask may be added directly
into isolated_cpus.

As a result, isolated_cpus may incorrectly contain CPUs that are not
isolated leading to incorrect data reporting. Fix this by adjusting
the delmask to reflect the actual exclusive CPUs for the creation of
the partition.

Fixes: 11e5f407b64a ("cgroup/cpuset: Keep track of CPUs in isolated partitions")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 749994312d47..a4d7bfef855f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1679,9 +1679,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (nocpu)
 			return PERR_NOCPUS;
 
-		cpumask_copy(tmp->delmask, xcpus);
-		deleting = true;
-		subparts_delta++;
+		deleting = cpumask_and(tmp->delmask, xcpus, parent->effective_xcpus);
+		if (deleting)
+			subparts_delta++;
 		new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
 	} else if (cmd == partcmd_disable) {
 		/*
-- 
2.48.1


