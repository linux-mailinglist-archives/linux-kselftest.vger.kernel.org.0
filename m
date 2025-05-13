Return-Path: <linux-kselftest+bounces-32887-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 260C2AB486E
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 02:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3AF8C2FAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48F17B506;
	Tue, 13 May 2025 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keqNycxn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC7A17A2FB;
	Tue, 13 May 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096047; cv=none; b=WQN8rUksWiozFXz+A2LJzdAoIg4gD9twsTciTmNJwnAoLrFHCt0I9NSE2sA62wtGV6cc7cqA+p9HLoWo9F6RRFWNfUZxJX85TCiT1TjMuQkCndGW9WKjSw8qqXd8r8DagdzyL01dAgpPxKE9NaNdUlYcIxsznV7NzfG/lQbeF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096047; c=relaxed/simple;
	bh=Kq774euQahjIko8eUiFaGLC1QQneONlcs60NmxkuDqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cWzBOVJ0y9n2jayX/LDWkRkNYRAnlDwUvkefr4y9qBVHwYt8O5/Eq2TL+TG+hSBRKipzlDlSdq8nBZWFkiwag4mGwRXehGzt3qRTlvqyLPYSvmCHL5mkyZ7d/v6Yq6UJe84EyeavfARbBX6/5k54d11Z3sRzcpq0Y9ZPL5MeW2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keqNycxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87761C4CEEE;
	Tue, 13 May 2025 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096046;
	bh=Kq774euQahjIko8eUiFaGLC1QQneONlcs60NmxkuDqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=keqNycxnz/pem+JSEuoq1rUfCCvG0qe8O55lYRRFzUAOz0a6Lzx4u/uxGEv/FGvm8
	 C3G7j+QzhDxCG/asMT6qQ9Bc7v1msNnNNWDrU3R5fFeNpGCkuo3fGWMYFYGnp3Lgws
	 vWDOEq2oLEM7Z4bPrkfwCw20KWQS+zDxfpLt2JzuBevPGu5uZZWkDzaVb1rigg8sjv
	 vzcv86UR1bowxSO4vKvcC6fpYaQSG2eHUv1fwWHwuLWIJk2vgMCX6G4/LiATQlHPdD
	 CQrt8abZBF+4/pcf0QcnemREPQ4OT9U3ovy3n63DHCAjvGlyqC7YR4EqowcKOJMMgg
	 M47Xa0H2pV4Cg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/6] selftests/damon/_damon_sysfs: read tried regions directories in order
Date: Mon, 12 May 2025 17:27:14 -0700
Message-Id: <20250513002715.40126-6-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250513002715.40126-1-sj@kernel.org>
References: <20250513002715.40126-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kdamond.update_schemes_tried_regions() reads and stores tried regions
information out of address order.  It makes debugging a test failure
difficult.  Change the behavior to do the reading and writing in the
address order.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 6e136dc3df19..1e587e0b1a39 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -420,11 +420,16 @@ class Kdamond:
                 tried_regions = []
                 tried_regions_dir = os.path.join(
                         scheme.sysfs_dir(), 'tried_regions')
+                region_indices = []
                 for filename in os.listdir(
                         os.path.join(scheme.sysfs_dir(), 'tried_regions')):
                     tried_region_dir = os.path.join(tried_regions_dir, filename)
                     if not os.path.isdir(tried_region_dir):
                         continue
+                    region_indices.append(int(filename))
+                for region_idx in sorted(region_indices):
+                    tried_region_dir = os.path.join(tried_regions_dir,
+                                                    '%d' % region_idx)
                     region_values = []
                     for f in ['start', 'end', 'nr_accesses', 'age']:
                         content, err = read_file(
-- 
2.39.5


