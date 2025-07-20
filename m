Return-Path: <linux-kselftest+bounces-37691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE4FB0B71C
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A52A175FD1
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FB322422A;
	Sun, 20 Jul 2025 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocTyl2Xv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E878223DD1;
	Sun, 20 Jul 2025 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753031821; cv=none; b=KuCERuI9uFdCRqRto7nRJ5WSTDSydziUNZ4nxunqpw6YwNjXm5P51RC7cvTUaOADt2/KIrnDnKfmviIraOcFjER4TM/JWy7bZEwoDXluaY14w0scgK0zVzGDN9R9wl+qv2gcww7a45z6M1hJDmO8b07fNzsWbu7938z/y1BNZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753031821; c=relaxed/simple;
	bh=sQuriqqTYEVG3BTXSxFPevEEtfd34DY9wOWswVQQEuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GtmRGHpN/lmw7s55P1215owN2+LW4H5QoOldyhRlIf0IXP4Snls++NoEn03E8UwHSjRagtrIUqcCrKpQikZDLezbYuQBYK1v/Nm6Yqr/oMiSfgqxRdniJ5utMzOYgsqpfpw8ERqFFDKi19ifUYmWOYQFYAoxRcwtya35vWrSa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocTyl2Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B99C4CEE7;
	Sun, 20 Jul 2025 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753031821;
	bh=sQuriqqTYEVG3BTXSxFPevEEtfd34DY9wOWswVQQEuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ocTyl2Xv2eeP4NMyxgyIB8jWC+zv1RRmEHjUFKBuk/I5xdk6tuPB8VSrD+m1rHO5Q
	 qA3MduI+aUkowBGIK/mRXV6oxHSfEAgU/Rr7NWUbiuMdtlcQ+XYRRSzdzEULyrnDyL
	 /jfRTPeNKw2V/1SlWUOGxE9BydOClcIdCf2uZeZcr0IfTElvFl0g7GXs9BxTfLDXTB
	 RF/tv7YU5yXT3fzPd1CjkPip7bM2PcYV4pB2mRgeVd41eTniKE8qYbUbGLkWIw/gws
	 45RmgbGVoiQBtyVDPc8dnsB5U38uvBYlMabFHYT3y4CRf3ZnhSj+omxEYQUpUf9Egv
	 15VmajDVksILQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/22] selftests/damon/_damon_sysfs: support DAMOS quota weights setup
Date: Sun, 20 Jul 2025 10:16:34 -0700
Message-Id: <20250720171652.92309-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720171652.92309-1-sj@kernel.org>
References: <20250720171652.92309-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_damon_sysfs.py contains code for test-purpose DAMON sysfs interface
control.  Add support of DAMOS quotas prioritization weights setup for
more tests.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index ec6230929d36..12d076260b2b 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -125,12 +125,20 @@ class DamosQuota:
     ms = None                   # time quota
     goals = None                # quota goals
     reset_interval_ms = None    # quota reset interval
+    weight_sz_permil = None
+    weight_nr_accesses_permil = None
+    weight_age_permil = None
     scheme = None               # owner scheme
 
-    def __init__(self, sz=0, ms=0, goals=None, reset_interval_ms=0):
+    def __init__(self, sz=0, ms=0, goals=None, reset_interval_ms=0,
+                 weight_sz_permil=0, weight_nr_accesses_permil=0,
+                 weight_age_permil=0):
         self.sz = sz
         self.ms = ms
         self.reset_interval_ms = reset_interval_ms
+        self.weight_sz_permil = weight_sz_permil
+        self.weight_nr_accesses_permil = weight_nr_accesses_permil
+        self.weight_age_permil = weight_age_permil
         self.goals = goals if goals is not None else []
         for idx, goal in enumerate(self.goals):
             goal.idx = idx
@@ -151,6 +159,20 @@ class DamosQuota:
         if err is not None:
             return err
 
+        err = write_file(os.path.join(
+            self.sysfs_dir(), 'weights', 'sz_permil'), self.weight_sz_permil)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(
+            self.sysfs_dir(), 'weights', 'nr_accesses_permil'),
+                         self.weight_nr_accesses_permil)
+        if err is not None:
+            return err
+        err = write_file(os.path.join(
+            self.sysfs_dir(), 'weights', 'age_permil'), self.weight_age_permil)
+        if err is not None:
+            return err
+
         nr_goals_file = os.path.join(self.sysfs_dir(), 'goals', 'nr_goals')
         content, err = read_file(nr_goals_file)
         if err is not None:
-- 
2.39.5

