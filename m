Return-Path: <linux-kselftest+bounces-27535-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A987A44FEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0595E19C4656
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 22:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCC1215773;
	Tue, 25 Feb 2025 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWWcxIsF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE121481A;
	Tue, 25 Feb 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522219; cv=none; b=IxocFemDDfgI5aqZqSip651g6sctsj/LoN4/L9LuwY7JCUSN2egv5jr50mWTglH7cV9Fpm2IeCj4oWL0GZYxvDXokB9RmNFwzvGduexFEcc132a+a6ByQGbzuI0ZZ0XqbJTLsGV1d2hNMKXENvfaY18FaepvKnfIzA7Sp45W1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522219; c=relaxed/simple;
	bh=tpWLGxlVf/4BpHaXx5/fixUy6zdm68z/SbHuewfrcEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZi0FPBKJLG6/nwqcYOZVHrjvDO3lqsi+jxMnkmCkZN8b7zf71lkroLFsexgjgsVIdqDkCCv4XTkjq3gvMgjFJuk7lo4fTMpy4/Jn0RiAAj927/ui48HKz0nPNZrs/eQOY5QtblEy0cuqfFMW+UHv0CV7cj8zyMm2GGK7MdhvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWWcxIsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F85C4CEE7;
	Tue, 25 Feb 2025 22:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740522218;
	bh=tpWLGxlVf/4BpHaXx5/fixUy6zdm68z/SbHuewfrcEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jWWcxIsF2IncuVjeXyx7WphGUorWp+m13Tbpub2EWCXKeluqggOAnnP4/G/4qV8EC
	 cSFf2COGUWDTC6nph6vuVsMX/H8iTJ1It5s3Lqu/ukZlT7kVVYwd9705nw820lnO+t
	 z6Jo7AFBT4fC8gKWvN2fY4vcyclMN5FPA+5AwkuXlANEIDbfmLPPiBhBJqwxkWU7hC
	 QASROGmWrkVlnE0GdwQIWKT0H5wiVIcgsJklhO3/HrBS9fJNxZNe+lbD99z7+teVpU
	 vYPHteMXN3kRkKwv1DoyVvlBvAyp2jTpxkN/gHoUHxJQDlO0+XbU6uqoyBu+KQUp7W
	 KXwA1caOlkhMw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] selftests/damon/damos_quota: make real expectation of quota exceeds
Date: Tue, 25 Feb 2025 14:23:31 -0800
Message-Id: <20250225222333.505646-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225222333.505646-1-sj@kernel.org>
References: <20250225222333.505646-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_quota.py assumes the quota will always exceeded.  But whether
quota will be exceeded or not depend on the monitoring results.
Actually the monitored workload has chaning access pattern and hence
sometimes the quota may not really be exceeded.  As a result, false
positive test failures happen.  Expect how much time the quota will be
exceeded by checking the monitoring results, and use it instead of the
naive assumption.

Fixes: 51f58c9da14b ("selftests/damon: add a test for DAMOS quota")
Cc: <stable@vger.kernel.org>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/damos_quota.py | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/damon/damos_quota.py b/tools/testing/selftests/damon/damos_quota.py
index 7d4c6bb2e3cd..57c4937aaed2 100755
--- a/tools/testing/selftests/damon/damos_quota.py
+++ b/tools/testing/selftests/damon/damos_quota.py
@@ -51,16 +51,19 @@ def main():
         nr_quota_exceeds = scheme.stats.qt_exceeds
 
     wss_collected.sort()
+    nr_expected_quota_exceeds = 0
     for wss in wss_collected:
         if wss > sz_quota:
             print('quota is not kept: %s > %s' % (wss, sz_quota))
             print('collected samples are as below')
             print('\n'.join(['%d' % wss for wss in wss_collected]))
             exit(1)
+        if wss == sz_quota:
+            nr_expected_quota_exceeds += 1
 
-    if nr_quota_exceeds < len(wss_collected):
-        print('quota is not always exceeded: %d > %d' %
-              (len(wss_collected), nr_quota_exceeds))
+    if nr_quota_exceeds < nr_expected_quota_exceeds:
+        print('quota is exceeded less than expected: %d < %d' %
+              (nr_quota_exceeds, nr_expected_quota_exceeds))
         exit(1)
 
 if __name__ == '__main__':
-- 
2.39.5

