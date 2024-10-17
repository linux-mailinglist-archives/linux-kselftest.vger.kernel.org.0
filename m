Return-Path: <linux-kselftest+bounces-20013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0159A2B4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6A77B2654F
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91291DFE16;
	Thu, 17 Oct 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+eU8mM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808361DF99D;
	Thu, 17 Oct 2024 17:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729187020; cv=none; b=ZP0zU155Q89k2XyTHWx1MfvcHOscbSari6PnauRE7ecTzhJLVQ5iStVdgWeHxeFcTs7Ae+kRDqwDt5vBeAhxHKeE3xEgUgi/cbLjDq6YcD2ZHI83A87pED+6D4NcBo3gzioBn8J0ZbXuHhPNOZxU1hb6pebrCfTtaCJO0S9kC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729187020; c=relaxed/simple;
	bh=S6LzCFAMR6ixXUNBFX+2FpDuOFuVdXdxdGZ3jU5Sv4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=R3A/QdfSSbM2YAQtLaEVyUMzRpFzwLjAVKtX2mxB/sduQSFs/lgFvhR52Df3uedfTT36XiY4zncb8FSe6Nb1UaDMB3RFixSEdnZ/Obfqzdf8ze4LmqViszmqZzrXbviSYBlQ+Jro8Lx6wXvvq84TmHPM4AHiir1460KbVsTkYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+eU8mM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F1DC4CECD;
	Thu, 17 Oct 2024 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729187020;
	bh=S6LzCFAMR6ixXUNBFX+2FpDuOFuVdXdxdGZ3jU5Sv4Q=;
	h=From:Date:Subject:To:Cc:From;
	b=O+eU8mM5IPnAnePlpEjhg5/SEh5M+uvIUk7K6wrzZ9ck1pijgdg/YmmzLyoipH4X5
	 culxeqPrwxzC3WouQ1uIAi3OlhTFoOi/q/nQD0nhk9nkV7bhaBDwH/E3aWJwelbsca
	 ClPQVIS1A/YCmtXrVpL6pul6t5OWQQRvpWnIek01eXRHLYDALKP0/oG/YVImsG5Yu1
	 lLK0tLazHTuF/sOeff4b/jjy6na7kI1NnmWL6kAoD4YZNKZ5txVi+KqiQ2NdgdoVRr
	 sRVKFiqktHuSdoO6YBYKSZ51UNTR2DsIEDchIUrGPZdqXAlYlbESMJfyb+OFah9wCs
	 GSNMF4d2ecuHw==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 17 Oct 2024 18:43:31 +0100
Subject: [PATCH] kselftest/arm64: Fail the overall fp-stress test if any
 test fails
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-arm64-fp-stress-exit-code-v1-1-f528e53a2321@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMJMEWcC/x3MQQqDMBBG4avIrB1I0mCpVxEXNvljZ1GVGRFBv
 HtDl9/ivYsMKjDqm4sUh5isS4VvG0qfaZnBkqspuBC980+e9NtFLhvbrjBjnLJzWjP45QqCzym
 +04NqvymKnP/3MN73D262IztrAAAA
X-Change-ID: 20241017-arm64-fp-stress-exit-code-90fe21dc4bc3
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=broonie@kernel.org;
 h=from:subject:message-id; bh=S6LzCFAMR6ixXUNBFX+2FpDuOFuVdXdxdGZ3jU5Sv4Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnEUzJfMIUuE8fGYh7rfezGvYZWqHqhQzdtV1C9QXq
 jE/FgP+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxFMyQAKCRAk1otyXVSH0DWoB/
 kBJ2XzZEefjkyY1KnAt2UPjTFf4mR+8jnzwV6MW4ueY7jymz/7eY8KMREu4GbKjCltz4nD71Dv14WK
 Gf+nDWsfzU5Lqf5N3J3PzorJllgXqQYNXg2mRIVt+A3ebgRNlHOxhMd0QdVL5lZSVJulAgwESzt1Qb
 SuXURa4sA0/XVrUadpLrvlAeKX06XyxPCM8mJvKKdFmnlRvVzGBDCKeSzthRy8eo669e9i+1s+ju7d
 Ts5+ixiR1qq+LjvmSP/NoE/jhwTa3A6cfTuxwPOHwlU9mDnJD1AeiBD94gcXIY/bsne3s87DKMIQxu
 r8pTqI2RITespBnoXmrdxm77GfMI2e
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently fp-stress does not report a top level test result if it runs to
completion, it always exits with a return code 0. Use the ksft_finished()
helper to ensure that the exit code for the top level program reports a
failure if any of the individual tests has failed.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..e62c9dbad5010234d70b477cf8c52ba0b312910e 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -651,7 +651,5 @@ int main(int argc, char **argv)
 
 	drain_output(true);
 
-	ksft_print_cnts();
-
-	return 0;
+	ksft_finished();
 }

---
base-commit: 8e929cb546ee42c9a61d24fae60605e9e3192354
change-id: 20241017-arm64-fp-stress-exit-code-90fe21dc4bc3

Best regards,
-- 
Mark Brown <broonie@kernel.org>


