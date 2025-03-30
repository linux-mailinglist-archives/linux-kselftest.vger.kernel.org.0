Return-Path: <linux-kselftest+bounces-29931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C88A75CDB
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25817168D46
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DC1E1A33;
	Sun, 30 Mar 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6A8cpys"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3620D1E0DD1
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371637; cv=none; b=ZusjyYZJsJ6hpH8DiREBWn8xN3eFPuvwHFUeYcTStgpnATfBXejxWIEaJLjB8A4kEQkQjlT0gvkTjQQ08RVPM1qunWQDEEHdpuVaA/rpbHYgIEKYVU/cT/AGiziSXA03UIDg/4buoXdOx68YFLbz62UOUTH6EPMsQ9igV3971tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371637; c=relaxed/simple;
	bh=Cz6884SAaOmN20Gj7gWlrb+G4c2tyI00nPi+340eiuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BEYM21SJl7dpf2Xr/Gl8qtHZViZhmT5T1/d4EVlnuDvHNNaLCt2bVghLJeTk3sdwKk1cwjDKP4046YQVI/XNxtmcGRG+lHs8HvIYGFte3h88Iuzg2+YN5q4HfiJ23/8hnRStw0n33ggGcwijoYUWDRZ8PvaqQJcQgmbdVfInwLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6A8cpys; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RE7E/EyT9BGrvfRb7ovoMR/KH5Tqv8Z9Rqs2/jUrC0=;
	b=J6A8cpys4ThNPOtHiUbiZIwJGaQk1W+h26gCrpNBzdEgSOJmphF+8DOwhQAFv3MP4T1v7e
	Es8F/GxJ6//YOMSpgWvz9md6AtxGH+of0r9e2BE9lUmx1f54K+sk79VOKHjKxrDy9aOmvx
	NCenHv4jIlfXAdaYZrXYkAvGeKfw+gU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-dXoSEkquPM-g1HzGxisFQg-1; Sun,
 30 Mar 2025 17:53:51 -0400
X-MC-Unique: dXoSEkquPM-g1HzGxisFQg-1
X-Mimecast-MFC-AGG-ID: dXoSEkquPM-g1HzGxisFQg_1743371630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DD9E18004A9;
	Sun, 30 Mar 2025 21:53:50 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DAFC51801752;
	Sun, 30 Mar 2025 21:53:48 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 05/10] cgroup/cpuset: Don't allow creation of local partition over a remote one
Date: Sun, 30 Mar 2025 17:52:43 -0400
Message-ID: <20250330215248.3620801-6-longman@redhat.com>
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

Currently, we don't allow the creation of a remote partition underneath
another local or remote partition. However, it is currently possible to
create a new local partition with an existing remote partition underneath
it if top_cpuset is the parent. However, the current cpuset code does
not set the effective exclusive CPUs correctly to account for those
that are taken by the remote partition.

Changing the code to properly account for those remote partition CPUs
under all possible circumstances can be complex. It is much easier to
not allow such a configuration which is not that useful. So forbid
that by making sure that exclusive_cpus mask doesn't overlap with
subpartitions_cpus and invalidate the partition if that happens.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 976a8bc3ff60..383963e28ac6 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -33,6 +33,7 @@ enum prs_errcode {
 	PERR_CPUSEMPTY,
 	PERR_HKEEPING,
 	PERR_ACCESS,
+	PERR_REMOTE,
 };
 
 /* bits in struct cpuset flags field */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ffa85d34ba51..f26f791e9323 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -61,6 +61,7 @@ static const char * const perr_strings[] = {
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 	[PERR_ACCESS]    = "Enable partition not permitted",
+	[PERR_REMOTE]    = "Have remote partition underneath",
 };
 
 /*
@@ -2855,6 +2856,19 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
+		/*
+		 * We don't support the creation of a new local partition with
+		 * a remote partition underneath it. This unsupported
+		 * setting can happen only if parent is the top_cpuset because
+		 * a remote partition cannot be created underneath an existing
+		 * local or remote partition.
+		 */
+		if ((parent == &top_cpuset) &&
+		    cpumask_intersects(cs->exclusive_cpus, subpartitions_cpus)) {
+			err = PERR_REMOTE;
+			goto out;
+		}
+
 		/*
 		 * If parent is valid partition, enable local partiion.
 		 * Otherwise, enable a remote partition.
-- 
2.48.1


