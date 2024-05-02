Return-Path: <linux-kselftest+bounces-9269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6252F8B9F77
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939851C220A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74216FF3F;
	Thu,  2 May 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hweUUaV8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C9313C820;
	Thu,  2 May 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670847; cv=none; b=HgKVwxE/uXRdlRSC+hnxKv2xL4/eiiDx1KCzD4T3lx/D0KkIPqzb8fFCVwI2MxQwI2YFV6TZEw4YhNj6kwTha0wBPrETP3na7CCfjlc0oCng6U0YCs1PuM/j8g78MqMfjVAWSxw/NEUFKwtwY8nemEqCVWWOZiunsOAlBsSbyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670847; c=relaxed/simple;
	bh=QLwaUzwohYnKP0PTSDFKLnYx6rSW06C0HwbtdZCDG40=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WxEL4nVI3Ab1OGP50OD39BgDFgZxQuvu99glPDNinRrU/QVfmhn8Y3JrdzRlSDSGrFvWKecnI1bdmgB1xy31/d/Q1a6wZKsbL2jXOUByqE4IiF8eXCRxnzF/aj7AKox+GX8CWonTFU3emn8dGGYOKa2Ywtwo9XjztWnANMMcklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hweUUaV8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D80BC113CC;
	Thu,  2 May 2024 17:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714670847;
	bh=QLwaUzwohYnKP0PTSDFKLnYx6rSW06C0HwbtdZCDG40=;
	h=From:To:Cc:Subject:Date:From;
	b=hweUUaV8NAQ5OShz8TXrOarDdyCdHeQcB9eoBXc2XrpK47V3t+hWmMsVlUqv/Z9A/
	 WZItfVTYB7JmcDflZ5Z7MJ9ep6TezH/1ffFWK2DF6gY+vobeoLlXcZhI9TOEjtGjIE
	 LDsSEoedb4dXfiMkHLbmJgD5tkEDPpz/zELvKCii5D4tQ1Q+NH0J6gfLsd+fxfsqWL
	 Xu49g230DHM2P9+XBCdLARIad/I+TF1FbNYyTVsnhy08HktxI4BJA+3NXfNIWVpPjt
	 sipGbDSK7Pfi3fQh9DDIT6rpBDeREDjXGpw9Zn0vZCOFLjRCsn2Tsw0aWQ1m7UpP7t
	 i+eX0cyIR4usQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] selftests/damon: add DAMOS quota goal test
Date: Thu,  2 May 2024 10:27:16 -0700
Message-Id: <20240502172718.74166-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON selftest-purpose sysfs wrapper to support DAMOS quota goal,
and implement a simple selftest for the feature using it.

SeongJae Park (2):
  selftests/damon/_damon_sysfs: support quota goals
  selftests/damon: add a test for DAMOS quota goal

 tools/testing/selftests/damon/Makefile        |  2 +-
 tools/testing/selftests/damon/_damon_sysfs.py | 84 ++++++++++++++++++-
 .../selftests/damon/damos_quota_goal.py       | 77 +++++++++++++++++
 3 files changed, 161 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/damon/damos_quota_goal.py


base-commit: ff0a7c4126d225e56aa3e0164c53e82aabf61921
-- 
2.39.2


