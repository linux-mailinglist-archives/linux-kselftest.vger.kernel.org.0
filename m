Return-Path: <linux-kselftest+bounces-32468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CFDAAB344
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 06:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250423A6AFF
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 04:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADC21B9CF;
	Tue,  6 May 2025 00:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8s8HVJ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671F2D3226;
	Mon,  5 May 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486081; cv=none; b=N7C4yKi2d+rFpL4kbclR+uHvLVx9JsDl/cnlR+DxqIJNizSvAT9heX008KSGG7iUk42JlV+6m2gJHWjjmroMrw+2Nqu+lGdOUiPS3fRjuSCAyROojtKRse1vtrLzw5HfGAsShcVT1mqnWgtHWJoqxu6kdMd3GRty2b7wwcbTRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486081; c=relaxed/simple;
	bh=6nilLHw0VgDiTs0EsmbNUNsBYV4knhCYP34x5LqIndU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sUtE1iCqUlR5cBSZFzjLoaI1ff55XtLEFza6Db0PmL5Svl8im4KgGytpRzIsXG/AU+yd09lJwXf7HdAJzIMsOr0HJgrwDjnVzt2a3M7vJ5snQ/S7495mQCirhK/l9uAM7r/W37ypipqHS2sNKisFxjsMnNtbbE+Ch7kUeB+5UXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8s8HVJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7073FC4CEED;
	Mon,  5 May 2025 23:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486081;
	bh=6nilLHw0VgDiTs0EsmbNUNsBYV4knhCYP34x5LqIndU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8s8HVJ0EQ51wG16IL9pKq8av+Mp/l/1dlly6RghHvIuILSiQj9z7KLwu6nvhYoT4
	 wkBYKRSF9ksTSVEORBiVDgzU0wtjGYVOnXWrDCgKyclyMFGu4PyEP/QWa2k+HN8aj9
	 Qq11jX48v/eiQamvxjoTPOSqMBJLJmYhD30P3Wt9m0k2hJHhaw3VU2e89F0U1loLNa
	 pTQuQE/WngPT8EggCwBJ8/MKp12WeAZkD+m909e0mdv9epa0G+CSwuLf+yE/vl+2gQ
	 M00AmANPj0+vIpD+biYKnzfqpy9WN4hbPd3VvdIzXYDAdo93L64OY+jAZMv4OY3+Vt
	 Tw2LvS9cSg/DA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kevin Krakauer <krakauer@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 145/294] selftests/net: have `gro.sh -t` return a correct exit code
Date: Mon,  5 May 2025 18:54:05 -0400
Message-Id: <20250505225634.2688578-145-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Kevin Krakauer <krakauer@google.com>

[ Upstream commit 784e6abd99f24024a8998b5916795f0bec9d2fd9 ]

Modify gro.sh to return a useful exit code when the -t flag is used. It
formerly returned 0 no matter what.

Tested: Ran `gro.sh -t large` and verified that test failures return 1.
Signed-off-by: Kevin Krakauer <krakauer@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250226192725.621969-2-krakauer@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/gro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 342ad27f631b1..e771f5f7faa26 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -95,5 +95,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.39.5


