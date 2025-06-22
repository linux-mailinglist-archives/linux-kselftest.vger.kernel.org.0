Return-Path: <linux-kselftest+bounces-35577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCA6AE3227
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 23:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0D316F1D3
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Jun 2025 21:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0197262C;
	Sun, 22 Jun 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6atRP8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345230E84D;
	Sun, 22 Jun 2025 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750626215; cv=none; b=F8047g8DyIDg0jpHtsogG6GX1Q6uQJ6ZJUzW2op8DYL7z3/GmQMKbuKzQXW2zaMnVRm1lH8f2a7+o2Wfpflrq0tKintE6MV+dpUgrog6toMzdHrovDTOPkzlhEP9zLJoCFadeOM/l1CZUU9cx0xvEGSJYytoL9VUVd37czpfmyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750626215; c=relaxed/simple;
	bh=WdFiKIlovYuycCCc8P2+ZFAGDP/REZTo9X6Ln85VIKk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4DLgzYFXMQPrBkAWzF6A50QgirNiPmVBkPDqrgedIMU/P1dLrbchHR9qha3F5ecJJMMH2C6FvU5tvsK9ZFbEIRnATnei7rjXPOhKfW0wkja1EK/z4XD8WnxwtatJPbdIeondfvjyrDotKTs6doGuzxwz7rmMAA+Z3qD3Rmvpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6atRP8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70371C4CEE3;
	Sun, 22 Jun 2025 21:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750626214;
	bh=WdFiKIlovYuycCCc8P2+ZFAGDP/REZTo9X6Ln85VIKk=;
	h=From:To:Cc:Subject:Date:From;
	b=h6atRP8S6uD82GYvhupFBtVEwUunuKnqTp8t1ZyekZ/622X+cUFap/fVcbteHR2t8
	 4p6M39RzsDsO4V+fpXqlgUeHXpEskW7PsjDx1rr1LPiIzi1JFAA/YFgJeVXzLBVoC1
	 G+7HHjTXignSoIUtNBN7xSg0nMpYljh4LrzUnJANqwCWQ07BO0O6eHRGeAPJj68FU5
	 35AUA5QiQhWBYqktkbn27OY/4NFWdnwMvs1VSAO1e4pEYSG/3/Lki1pZziLU8IdnQ5
	 Vh4EsoQFDtvzil0pAKjbeyqWHyg3RRhkrLzh6DJN111hzXMUKFKZ0a6z4l6lbX9VIy
	 ZM8eRm7vjeEWQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 0/6] selftests/damon: add python and drgn based DAMON sysfs functionality tests
Date: Sun, 22 Jun 2025 14:03:24 -0700
Message-Id: <20250622210330.40490-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs interface is the bridge between the user space and the
kernel space for DAMON parameters.  There is no good and simple test to
see if the parameters are set as expected.  Existing DAMON selftests
therefore test end-to-end features.  For example, damos_quota_goal.py
runs a DAMOS scheme with quota goal set against a test program running
an artificial access pattern, and see if the result is as expected.
Such tests cover only a few part of DAMON.  Adding more tests is also
complicated.  Finally, the reliability of the test itself on different
systems is bad.

'drgn' is a tool that can extract kernel internal data structures like
DAMON parameters.  Add a test that passes specific DAMON parameters via
DAMON sysfs reusing _damon_sysfs.py, extract resulting DAMON parameters
via 'drgn', and compare those.  Note that this test is not adding
exhaustive tests of all DAMON parameters and input combinations but very
basic things.  Advancing the test infrastructure and adding more tests
are future works.

SeongJae Park (6):
  selftests/damon: add drgn script for extracting damon status
  selftests/damon/_damon_sysfs: set Kdamond.pid in start()
  selftests/damon: add python and drgn-based DAMON sysfs test
  selftests/damon/sysfs.py: test monitoring attribute parameters
  selftests/damon/sysfs.py: test adaptive targets parameter
  selftests/damon/sysfs.py: test DAMOS schemes parameters setup

 tools/testing/selftests/damon/Makefile        |   1 +
 tools/testing/selftests/damon/_damon_sysfs.py |   3 +
 .../selftests/damon/drgn_dump_damon_status.py | 161 ++++++++++++++++++
 tools/testing/selftests/damon/sysfs.py        | 115 +++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100755 tools/testing/selftests/damon/drgn_dump_damon_status.py
 create mode 100755 tools/testing/selftests/damon/sysfs.py


base-commit: 59f618c718d036132b59bcf997943d4f5520149f
-- 
2.39.5

