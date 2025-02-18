Return-Path: <linux-kselftest+bounces-26905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A7EA3A944
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 21:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20FBD176E6E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AC1F8671;
	Tue, 18 Feb 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buaL4ZhD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA351F76C2;
	Tue, 18 Feb 2025 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910405; cv=none; b=lY+yY4xGnYpQWA6x/Q9ULcTBz1UQaJo9wydEGRPTvi2XhjYkfQMVoQMOkoGU3Rv0B7yt/Is2Bk/A7eOO0fak324O8aIrYhyP/QxiOUsQ5/jj7MhYdEPLdUp6YDfVEbBxlVNIiUc29I2bvbo7P5rZtGHQvzKFk4fyvq2UCezXns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910405; c=relaxed/simple;
	bh=yk4IHKgNucYwIFhp/9zpYS3LX2NtKHju5BD07hNAIMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4rSwU+AO0E5I38FdaMaMw9WlVgy/vqrMR9E+O1Z7XlEXsLs1YHEgXM69F1t0sBFHTFrOIdMSw+bnjGmfRlThBKzlaJkpPx4F/gANlhpfaHg2Hi710lOGkjBBgFjA0Z+iQ96hSXWNDjtJ5dcKJSOeTV4yBlvmdZO8BmFKl+cjQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buaL4ZhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A111C4CEEA;
	Tue, 18 Feb 2025 20:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910404;
	bh=yk4IHKgNucYwIFhp/9zpYS3LX2NtKHju5BD07hNAIMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buaL4ZhDqyaGRsZ+MiQg3wsfAV8yTNO24qYr+SStPIA6UJTX0hrctwi40CWS55Hvd
	 9bKZ7fkYm0daEmr6AAjexUJhrcN8WeRdqAIFutnk0gsM3JJiARc7oSXwWrA7w+bQtp
	 hplswcNYwh3WSoCFRn3qVY1yi43zhecMe9TcTew/mblrBo/uJJCyQbnw0kdTO7dA+1
	 54crpmwgQegRJSSnfXrJFifT95imjQ+qbdIJpYMsd12R3BW9PauJwfjQ7F9R8ZBeOk
	 fIoNTLBS48xDnQ8x/EEdaJ6z6EagghPFu/zB18FCzRK8GCtkqOyT0Cl4hzmwIL1wIm
	 TDNkppa93oMvg==
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
Subject: [PATCH AUTOSEL 6.12 09/31] selftests/cgroup: use bash in test_cpuset_v1_hp.sh
Date: Tue, 18 Feb 2025 15:25:55 -0500
Message-Id: <20250218202619.3592630-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202619.3592630-1-sashal@kernel.org>
References: <20250218202619.3592630-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.15
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


