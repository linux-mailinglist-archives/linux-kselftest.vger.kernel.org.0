Return-Path: <linux-kselftest+bounces-9393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635708BB206
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 20:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B86B1C21B7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD731158212;
	Fri,  3 May 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/ANqK38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85329524BE;
	Fri,  3 May 2024 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759402; cv=none; b=JsKrOKooezk4uvVz8v5bDVY9QGZLzznfmhU2T1zJCAj8GC9r6ObE7MOk2NPfpCn96WzP32Rf+W/20+aANIsnatZ9M6ym/UXhTGB5FNuFsZ63+ViU7logW4BchfEcwbKlr+td//n1Mj7szriACJ3tIK/6ftBvaC+YapapiwJkyWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759402; c=relaxed/simple;
	bh=EaRqMYwfZ6CLfXPj4ijECU/OD147lD5SF+BXmhPmFBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uceVdSl6sN9NN4KRTunI5u2hk8Qu1dApxpOM4eZ5AiwdVSxy0yr20BqL4zvbXvYrAb/0FwEzJ3ZSE96mSovDxRXIzgLk1g8f0ytoZzYGMCSUZH1j5yVYTDwych84EI/wMwDaj7gdI14MmgEXZvLfX4omnguGgVUoWsz8uqqZths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/ANqK38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE58C116B1;
	Fri,  3 May 2024 18:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714759402;
	bh=EaRqMYwfZ6CLfXPj4ijECU/OD147lD5SF+BXmhPmFBE=;
	h=From:To:Cc:Subject:Date:From;
	b=c/ANqK38xQzyHdzDJOSTvZdEXbKgMhzGY+jpa3IIINQ5OxKUJ82vJj1zM62xdPM3G
	 r+tLJo6ZjzHqZqfU3EnC32lBEoCGOXpNeMUBz2yYvmemF5TBOcxwKdeIMiHJPjsCs4
	 LykAW/rdIX/geqNnFwcPAFHLJqEEDeutBud6EqKDgTvEy3dat0hI0PVmCpnI+D6aKk
	 stVO19TpNFgbvyHbqNpo99PWCK8zG2KfyMGTvYRUFrZ5AEZQbjZxvjO3WJZrIMN576
	 UFABaXUaLRtLTsLvWCzwsdoSMQcpWaM46DXMgelfpaHMLCM6Bj7XuLBhllHZYXr0DS
	 WMQVXowP7D5aA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] mm/damon: misc fixes and improvements
Date: Fri,  3 May 2024 11:03:08 -0700
Message-Id: <20240503180318.72798-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add miscelleneous and non-urgent fixes and improvements for DAMON code,
selftests, and documents.

SeongJae Park (10):
  mm/damon/core: initialize ->esz_bp from damos_quota_init_priv()
  selftests/damon/_damon_sysfs: check errors from nr_schemes file reads
  selftests/damon/_damon_sysfs: find sysfs mount point from /proc/mounts
  selftests/damon/_damon_sysfs: use 'is' instead of '==' for 'None'
  selftests/damon: classify tests for functionalities and regressions
  Docs/admin-guide/mm/damon/usage: fix wrong example of DAMOS filter
    matching sysfs file
  Docs/admin-guide/mm/damon/usage: fix wrong schemes effective quota
    update command
  Docs/mm/damon/design: use a list for supported filters
  Docs/mm/damon/maintainer-profile: change the maintainer's timezone
    from PST to PT
  Docs/mm/damon/maintainer-profile: allow posting patches based on
    damon/next tree

 Documentation/admin-guide/mm/damon/usage.rst  |  6 +-
 Documentation/mm/damon/design.rst             | 46 +++++----
 Documentation/mm/damon/maintainer-profile.rst | 13 +--
 mm/damon/core.c                               |  1 +
 tools/testing/selftests/damon/Makefile        | 13 ++-
 tools/testing/selftests/damon/_damon_sysfs.py | 95 +++++++++++--------
 6 files changed, 100 insertions(+), 74 deletions(-)


base-commit: fc7314cb6b750187a1366e0bf9da4c3ca8cfd064
-- 
2.39.2


