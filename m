Return-Path: <linux-kselftest+bounces-14300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B2593DE02
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6071283B72
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB681763EE;
	Sat, 27 Jul 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm4FU4OT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B939E7605E;
	Sat, 27 Jul 2024 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071085; cv=none; b=PZqXVEQCT739aZ0jXmg1uxvYk7sLfOwlt0VVyfecLzUEJxl/vjlCA5T6L+GpP61DuWAq7TlpsUtQtRjc6DvfMpFrNplF5IJLa9snp+LIuc7oPWwnUqZ7LcBc030y0yg49MPRabmIo5aL6VLrKOG95ZnIydnf9E3nou6KUccBVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071085; c=relaxed/simple;
	bh=q39VdB8mNDwQCHK2MaVvtUOIGr7ySla1YQ4BspARZ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNOM3wh/s3RGCnbyQbYW8z98yLQAg2A2/geFgFRR+RYkOoxxU8nAq12MzxHhTbw36xho/PqthOa21VqXhJNfQhRmeRPtecaOhTiyJqMv5zSXYr0Ga7vMiWzQX3E7jVLvOoyso3GB0taf8XPe5RbqGIcNU7w/8E+hrX9orVme1F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm4FU4OT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752BEC32786;
	Sat, 27 Jul 2024 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071085;
	bh=q39VdB8mNDwQCHK2MaVvtUOIGr7ySla1YQ4BspARZ0s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Qm4FU4OT67yK7L/vLx+ZfptuNxuaf+R5Sj4eNaMkOoV1F6pEAG3DbzGmn+bPF4NGP
	 E5+hdwtIOdKKAojjYqpnPq1740xt8nbJCKtaWXwFGXE1AP7pQdnSek+rOx/nt7pHes
	 UzsrpRMuryE4+Q5+KorwqUqgSbBXZSqMy50p/JacPqe8dwF5RPqmh/J4/ZeaI9judE
	 McaqQVbE0O9iB896xZM+AxivktKL9IaFUYQJJbgJWfHJpBFfRYVLRLJ2OegbfCRA1W
	 7E6P/dB4EdrAKqtB8KsxgmMpT2yDZ1OAAN2KylExjXg0ygRAaWjqR3mJEz+QD9gYg8
	 vdfhZ5w7keybQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 11:04:03 +0200
Subject: [PATCH net 5/5] selftests: mptcp: always close input's FD if
 opened
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-5-1e7d25a23362@kernel.org>
References: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
In-Reply-To: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Liu Jing <liujing@cmss.chinamobile.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=NLv7vDmMfDiB+NnrIJN7GOD0VoD4/6JVrrZIzXMgiKk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpLgad50O+zraWBHV/l9cPIPKdcvCuD6dSZTjz
 MRljk8mIp+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqS4GgAKCRD2t4JPQmmg
 c1xbEADnqbeI0hlFn8X6aE504BR9NWZQuFFUH+RMgnSH1dUBjKorIj9cCF6z24fDPOjueOheMWu
 ab45Sf2hOSVTreB2dHmbgGgPHC2t5fUByAfCCqWQiUQiO3ImOnRqahiuZRXUm3a5J9Qxw/RCc8b
 XTiTpwdiYyt5Jk1ZTrtlLwjIdZ6v26CBbKHipatyh47Rbp/GrAXOndHg6nd9o1sx25xOkdmrcC4
 8pE+nykqWfkysh2Mm4rxS2y8zV5mfVXugQmfNOKO7Zm33ySxfkqGXbehFt/6FIEa9GrlSd2o+XP
 zKArv0xLIDWkLLYaW/LjprtExNyCe6Qdh9mGSyqlwnXD0cF38TdD/V70TozVjUHKhqQBmu48doJ
 7DH5uelxfowf7fsBAC0IkAAT1vqbpQNcKtTVWT3uN97DLncqvGox8M1A4sGCo6R3mvq31apTc7n
 WI2FccZgIe9L+KqxgbIPVJ2O8fZGBXkZZx88HL18tAOIx4yNz2lqnx3uL1mN3b5TyGUduOTusjf
 Y0VJiDSXijgVQO6FAIoat9nO5bW4kxAIDwbE4nEiwqKyZEjveFYtSSjsKqWcCB+5evAICiRs3h5
 JnwqOMKv3ak+1dqJyshuw0NWjp6Jwum9xuKpyB8UlJJCoVEN5mJGzzqtxQtejBRCP7s3f3nyYzt
 UjfU/hV9j8jPfSA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Liu Jing <liujing@cmss.chinamobile.com>

In main_loop_s function, when the open(cfg_input, O_RDONLY) function is
run, the last fd is not closed if the "--cfg_repeat > 0" branch is not
taken.

Fixes: 05be5e273c84 ("selftests: mptcp: add disconnect tests")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index d2043ec3bf6d..4209b9569039 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1115,11 +1115,11 @@ int main_loop_s(int listensock)
 		return 1;
 	}
 
-	if (--cfg_repeat > 0) {
-		if (cfg_input)
-			close(fd);
+	if (cfg_input)
+		close(fd);
+
+	if (--cfg_repeat > 0)
 		goto again;
-	}
 
 	return 0;
 }

-- 
2.45.2


