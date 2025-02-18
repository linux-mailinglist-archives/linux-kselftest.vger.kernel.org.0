Return-Path: <linux-kselftest+bounces-26903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F30A3A8D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 21:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDED1747EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D031DDC11;
	Tue, 18 Feb 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbKJy47N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5741B1DDA3E;
	Tue, 18 Feb 2025 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910319; cv=none; b=s+nDPliZnJP4ML/ke8oNDVakiI6UMnLiri1xKI2cCDdw2yxEVqk5Z+5oBQyeckWFzxIT9YVARM9iAa8vQqZRAjQCaUo8EpFTg6KNbrwPULdAhafAd+/daum0Y0sNcX+/wJpm9X4MXFTWRrX/nI36VzUHa0+Wkhc8Ruv8yXVgt8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910319; c=relaxed/simple;
	bh=yk4IHKgNucYwIFhp/9zpYS3LX2NtKHju5BD07hNAIMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BrEojNIzpqcOTAaDWJoSEyrJL679s/yOD9tfq63dUxDhObYUADF+7kzFUH2WXfg8FkssFFTl2edayjdEnDR2qwrRaV97Z5NdcYtj6nXlYn09FoJIqL0iEwN8tl0Y/5tggNRE96ws5cshM67OdCzsPDHOZErXbU7u0675DdGYLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbKJy47N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E49CC4CEE9;
	Tue, 18 Feb 2025 20:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910319;
	bh=yk4IHKgNucYwIFhp/9zpYS3LX2NtKHju5BD07hNAIMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TbKJy47NCeFdVThrCd9OqVbnGnIJTpPgMeXScNZW4o3+8mhEaG+qXO3k33tGxAFZx
	 He6Vpy/zyDN2C9vVsY0H5u3ISJJYakXWxCAByvZjjSRUwwRffTmiYtO1xoc2SDhDnB
	 ka+9pSOPjtW8oxvuZP966q5hfo6DkOpXKuAXdCzLqaaxujtCw/u2+40bq/1KOFL0Ad
	 LhMDQ/31ujJaPYSwBhn607wA+q1LBAetEt0X5kr3BF6CaKBva9m/cv7zs/07hfAMba
	 p8ZA2rZ+0DYzCC3JK38bQAjtWo6GVEtv5BA1sfxB3NnLLMQCauR1fBiTpKIqUkHYxn
	 EJka1QYZNlOsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bharadwaj Raju <bharadwaj.raju777@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 09/31] selftests/cgroup: use bash in test_cpuset_v1_hp.sh
Date: Tue, 18 Feb 2025 15:24:29 -0500
Message-Id: <20250218202455.3592096-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit

From: Bharadwaj Raju <bharadwaj.raju777@gmail.com>

[ Upstream commit fd079124112c6e11c1bca2e7c71470a2d60bc363 ]

The script uses non-POSIX features like `[[` for conditionals and hence
does not work when run with a POSIX /bin/sh.

Change the shebang to /bin/bash instead, like the other tests in cgroup.

Signed-off-by: Bharadwaj Raju <bharadwaj.raju777@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
index 3f45512fb512e..7406c24be1ac9 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 #
 # Test the special cpuset v1 hotplug case where a cpuset become empty of
-- 
2.39.5


