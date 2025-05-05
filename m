Return-Path: <linux-kselftest+bounces-32461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0335AAAB0E5
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFE07B7B29
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68AE32607D;
	Tue,  6 May 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDyD300x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72252BE7BC;
	Mon,  5 May 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485256; cv=none; b=ARxBH5yPwCv1IWHc0gtm6ATuFmXNOF5K1KXYpwYSCfhvov+1+RLwykdENP66zDoY9cNXx03TlvH/Aj0g4FKV5VuDBa0S+6Y7DDlzDPMbGV3Up9lo5KWat4RwnXFqC5uAD9PS8Ghv5tgM07FIpUsuD+/ghX9qeu2IxemPhkhWwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485256; c=relaxed/simple;
	bh=Z9n9wiIPdC41RfHmTwLHjKY+A1WrsoMrfXOJKYq3Qso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WAt0c20UcRLrBOhkpyJSkukq/j7fmHw4Us1Oc9YaGN256TGDLXGe9xMUVEonSgj/kxu1qhQZU075BIdBOMtn6J4AuQUkzYLRgcgp4PgFtQTUumHHjxub4RlUOPRLWv7g8ycmdTFqzj9aVbrCzim52mjtdIdLCU6PyOrtUEe498g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDyD300x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66005C4CEF2;
	Mon,  5 May 2025 22:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485256;
	bh=Z9n9wiIPdC41RfHmTwLHjKY+A1WrsoMrfXOJKYq3Qso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDyD300x/mOB4/lsXU4OZyGeOIHIeqSnl02RCN6FGVMEQGZsoontt6+hQZMOs/wTV
	 qSkHyrczLndDfIetP2ogs4xgRUQim+IlF8rsNlC3fDhOnbq3291S2Pe3tFt+VC1n+K
	 5gXq/SwVUd6fm1xTZgTsnXuZVeMUL5n0wV3FCk2Mb73JwgRvHlSOeldACRd2XRiaks
	 Iv6Z7Z3SfbjG9qpwp32loDHhJzlijT8mQFlTQZlYb6tM628h1FBqNiGpAcBQNQCL9k
	 JVazEfvUE2jFgNyyRbScVbl4qJjOYFuI58TyBSGtNluUt92JdOP191v7IgSyGJpw8N
	 3DexpyVpF76ew==
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
Subject: [PATCH AUTOSEL 6.12 239/486] selftests/net: have `gro.sh -t` return a correct exit code
Date: Mon,  5 May 2025 18:35:15 -0400
Message-Id: <20250505223922.2682012-239-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 02c21ff4ca81f..aabd6e5480b8e 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -100,5 +100,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.39.5


