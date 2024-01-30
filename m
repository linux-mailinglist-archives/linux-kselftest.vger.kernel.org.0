Return-Path: <linux-kselftest+bounces-3727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E95584185D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 02:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868C71C2283A
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB2636119;
	Tue, 30 Jan 2024 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJQr6Eul"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFEB2CCD5;
	Tue, 30 Jan 2024 01:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578558; cv=none; b=bFoZLFEUYjxSSu/7griMMm6M6AufUWr8l67Y7qgTfWHdyiEBjqAyQKr2Ik5O0ADf8Jrp4iC+Caxyvb0MnTU2CnZ3QqfGQUpDmTiHnf3wwQ5NrP0MJeZ40hd4hQWYIldshUGsioA3Q2bBFZ3V8pDk3tWjjBcEBdH67S0Vt3XGh2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578558; c=relaxed/simple;
	bh=Vvkeu61i6vdOz/6no5T26QV127L9fGOYLD6tF9jpGww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ytw9+Gsw6k5Z4Hmf9HmOFpgRnyp8+bY6fxKd6L4mQ2NUMFz6PK0NN48g2LHf5sep7KLYBrXxV/9gtTaZnDRbahfzLnXOadK+Mcxbtc7UN2ilb+RNY87ranMUAp+MoLwgr0En3mODdLMEcKmBH5Er1kGRQGrrtW09HS6xWX16upg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJQr6Eul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C506C433F1;
	Tue, 30 Jan 2024 01:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578556;
	bh=Vvkeu61i6vdOz/6no5T26QV127L9fGOYLD6tF9jpGww=;
	h=From:To:Cc:Subject:Date:From;
	b=IJQr6Eul5PF/ZAc/M1vLjnFqj548hUzTdsNfcEbNG3K2p/kAuWlH2qTvnT2bzrE+d
	 mWjUbzlG1QCCcJ4u2TbppnxJHh4J3jnryLPGrBH/lmd4X2coK9IgzevxN/zxmElyyO
	 23aHtv534j1l73V9n1AUbU8trZta6Zj9NPJnpt+xi7Gg1zm3wL0XVCOnLSdNz1XFZv
	 0BeQlV0DrxYAOMhx8ThIwGbORXc1Z1Bb5gbD4dUnryBcJobN+UQ/k8N4GBmjzSaYJc
	 kPf+6QoU8OQ72RshjB0KU1FPbVBcCi7aacc3MATN+YVCZrGjTj2OTQ8gDGhnGvGRFp
	 gn8VwnSVSgbxQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Alex Shi <alexs@kernel.org>,
	Hu Haowen <2023002089@link.tyut.edu.cn>,
	Yanteng Si <siyanteng@loongson.cn>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] mm/damon: make DAMON debugfs interface deprecation unignorable
Date: Mon, 29 Jan 2024 17:35:39 -0800
Message-Id: <20240130013549.89538-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON debugfs interface is deprecated in February 2023, by commit
5445fcbc4cda ("Docs/admin-guide/mm/damon/usage: add DAMON debugfs
interface deprecation notice").  Make the fact unable to be easily
ignored by removing an example usage from the document (patch 1),
renaming the config (patch 2), adding a deprecation notice file to the
debugfs directory (patches 3-5), and renaming the debugfs file that
essnetial to be used for real use of DAMON (patches 6-9).

SeongJae Park (9):
  Docs/admin-guide/mm/damon/usage: use sysfs interface for tracepoints
    example
  mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_DEPRECATED
  mm/damon/dbgfs: implement deprecation notice file
  mm/damon/dbgfs: make debugfs interface deprecation message a macro
  Docs/admin-guide/mm/damon/usage: document 'DEPRECATED' file of DAMON
    debugfs interface
  selftets/damon: prepare for monitor_on file renaming
  mm/damon/dbgfs: rename monitor_on file to monitor_on_DEPRECATED
  Docs/admin-guide/mm/damon/usage: update for monitor_on renaming
  Docs/translations/damon/usage: update for monitor_on renaming

 Documentation/admin-guide/mm/damon/usage.rst  | 42 +++++++++++--------
 .../zh_CN/admin-guide/mm/damon/usage.rst      | 20 ++++-----
 .../zh_TW/admin-guide/mm/damon/usage.rst      | 20 ++++-----
 mm/damon/Kconfig                              |  7 +++-
 mm/damon/dbgfs.c                              | 27 +++++++++---
 .../selftests/damon/_chk_dependency.sh        | 11 ++++-
 .../selftests/damon/_debugfs_common.sh        |  7 ++++
 .../selftests/damon/debugfs_empty_targets.sh  | 12 +++++-
 8 files changed, 98 insertions(+), 48 deletions(-)


base-commit: f1ab2f51e99ffb94ce127d132b24be00dc130e6c
-- 
2.39.2


