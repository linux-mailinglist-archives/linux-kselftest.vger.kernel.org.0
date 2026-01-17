Return-Path: <linux-kselftest+bounces-49218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 104B2D38B69
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 03:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862C9303BE3A
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jan 2026 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4E52DB789;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiIzUxhG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898A924501B;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768615659; cv=none; b=TR8BNz4me995ACaSyG67j9/CtBcjrG78AmbblN/qjb5F8329VXWEErKQMH8VpG36jOlHn2BYrUUQoZG6C6iJRQ/FOMH8COmoFcDZXRibSvDoHDWgTSPsDaCUkb0Tu/Z5B0Akh6j3adRuOdPPKu8CpW51W8NlfOht9y/qatLewkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768615659; c=relaxed/simple;
	bh=ldDDpyWtiSre042DeL1/47rOCg6vyXlOAiFVAnaZ3ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1BDLQPvbHDtZe0UJx83VVSe8CHGWbQ5U8u1MbpphR17vAVwUTj1tlHTNU4Qp5Uf9pk7/b4gmLVFkHad2VugSOlFH7+EazYSZC2QTaHkfs5WmLPVosgWy3otyz3Wot64ZDtbB9qmuqZSXQjnx75NSIPDkibMHFE4jfWINl/QmKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiIzUxhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7F9C116C6;
	Sat, 17 Jan 2026 02:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768615659;
	bh=ldDDpyWtiSre042DeL1/47rOCg6vyXlOAiFVAnaZ3ow=;
	h=From:To:Cc:Subject:Date:From;
	b=ZiIzUxhGCq3SNZOl3oRQvfcs2C6g6pguzzZllXOOhGgbFCNCOu8AjPm/HvITzH56X
	 y9Gbu09aIwSIWlB8zOmR1YcUp/usxwgaaCvRxX8WG12d6MMt2jnZiSDkvQjWYlxVtM
	 G5TWiUW92dpw9zL/Uf7VrNvQxjlOgLWnz5BgKMwhX+wGZVm275IvvPXpJUtnns23xJ
	 e25K2Twcmze3LqxpCs6gsceLIB/W8KOtkZc7Zx9TJwPZdzb8Ae8BrOP7E0qT4sn8kL
	 ZDKqkv0HGo3zSZJ/5GJ0RlY9Psr6DaLCTJXmb7xQy4ZbXQ8lORPGwKSFCg9xARtmti
	 5Zl3cP1U41/Iw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/5] selftests/damon: improve leak detection and wss estimation reliability
Date: Fri, 16 Jan 2026 18:07:23 -0800
Message-ID: <20260117020731.226785-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two DAMON selftets, namely 'sysfs_memcg_leak' and
'sysfs_update_schemes_tried_regions_wss_estimation' frequently show
intermittent failures due to their unreliable leak detection and working
set size estimation.  Make those more reliable.

SeongJae Park (5):
  selftests/damon/sysfs_memcg_path_leak.sh: use kmemleak
  selftests/damon/wss_estimation: test for up to 160 MiB working set
    size
  selftests/damon/access_memory: add repeat mode
  selftests/damon/wss_estimation: ensure number of collected wss
  selftests/damon/wss_estimation: deduplicate failed samples output

 tools/testing/selftests/damon/access_memory.c | 29 +++++++++----
 .../selftests/damon/sysfs_memcg_path_leak.sh  | 26 ++++++------
 ...te_schemes_tried_regions_wss_estimation.py | 41 +++++++++++++++----
 3 files changed, 67 insertions(+), 29 deletions(-)


base-commit: 3944e89e2ad1bafac43daae60b56d2847227ab01
-- 
2.47.3

