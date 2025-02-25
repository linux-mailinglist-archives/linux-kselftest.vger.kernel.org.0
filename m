Return-Path: <linux-kselftest+bounces-27534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73314A44FFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 23:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B632D7AE33A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 22:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A52E2147FA;
	Tue, 25 Feb 2025 22:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEXNlCgu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA5211A18;
	Tue, 25 Feb 2025 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522218; cv=none; b=ghO/nC/fkzzYi4jGQypci5RXxITFNSuLcahVzI9Ni8kwJVYPdV4Nwhdrh/6R2CSeV4teUx8iv9eeBjSxEN1e+s39nhKdCl/3z7jt3LVebw1fGjDR+E3TGEoBp+zm1nDq9XuTjLx1taqnj+hQO6xgL4jnS3PGHr7pFVlf0vYIaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522218; c=relaxed/simple;
	bh=8MiSfz7lKrSko4hsypAi3qtfz/1ATk50H0CCwnqKVcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uobqtB36ItdKoWH6mfIFMklxKRMDyV+QXCevBpv3M+9eNWEv6yjXkp76gfMNbC41pPmxzAPvM2d0+uiL/s/X2/SwM4pmJITJHdIFIVeB82Y2CQGNJ+95hJAAZQWB3lLUZbI8MekfLK/9eDU2JRxy/ZanvpYBoIGwFPRVvW9cT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEXNlCgu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7614CC4CEDD;
	Tue, 25 Feb 2025 22:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740522217;
	bh=8MiSfz7lKrSko4hsypAi3qtfz/1ATk50H0CCwnqKVcg=;
	h=From:To:Cc:Subject:Date:From;
	b=nEXNlCguYk3pHb+Denbdpab4rdKObPvAj04AGmwT+0AC/z/tKTGa0oXuBUXRnlFhh
	 B14vVd9ypFybeKgUCrQSRGclR/Egk25YvfDda+zxp2J1F5RJ49AuaaM6/v2h5huHkf
	 N8koqrk6FnvrH2gwRaj/jrRGzrC+2SZmccoUGpGhI91Mjw1qdTOyHf68+I5U4VoUj8
	 rQswGvxZddhbLA7qjJTsxaqWmdppxasRwQZncFnne6tMnPIKHwFoA9bKTqA3B22fqa
	 wfdF/ZAxJRoiA2Jgq8w6DZ81kRkSxHjB1Hymyqm+U3m6cE/mfwfmShqlK0ShPwLy6p
	 rO3QFkcWd5qdg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 0/3] selftests/damon: three fixes for false results
Date: Tue, 25 Feb 2025 14:23:30 -0800
Message-Id: <20250225222333.505646-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix three DAMON selftest bugs that causes two and one false positive
failures and success.

SeongJae Park (3):
  selftests/damon/damos_quota: make real expectation of quota exceeds
  selftests/damon/damon_nr_regions: set ops update for merge results
    check to 100ms
  selftests/damon/damon_nr_regions: sort collected regiosn before
    checking with min/max boundaries

 tools/testing/selftests/damon/damon_nr_regions.py | 2 ++
 tools/testing/selftests/damon/damos_quota.py      | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)


base-commit: 0ab548cd0961a01f9ef65aa999ca84febcdb04ab
-- 
2.39.5

