Return-Path: <linux-kselftest+bounces-14299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE493DDFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 11:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 364B1B22760
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A879873478;
	Sat, 27 Jul 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6KJCa9C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83C7345B;
	Sat, 27 Jul 2024 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722071082; cv=none; b=DtYwS61zVxEs/j1g34skcOx7L+Nk7dm1VEAHSwlfMnWdGO6mAZ08gXW7a+SkC1m0834cOIFIY09pLFoGi45gXvr65K5R4s9DrcX7eAj1yakrylruSYVadSc5ycYHdzz8HfrMSmfaGRoBoCEMI2u2j5cqhomSoP0y8MJ/0XEe1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722071082; c=relaxed/simple;
	bh=bSOt8metnNP3/iqWxOWzMI46nYQl9PqNnxav/zmkGn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fQV0CYeNjpQPsiETQAmDUkhr8zEu0xoc0yjzraGhjhg/1DgPgKJ+ThGIV36tV5iAItzeefP7NJkM+p6nDN/Qk51zCGraKNPT7rTJzJaAwmeEiifI00kMFOYNDGOT8Q5ZxTmd13hZGwz7BRgGrM3DPp6539JJt/YsR3qyO/sLvEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6KJCa9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A12AC32781;
	Sat, 27 Jul 2024 09:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722071082;
	bh=bSOt8metnNP3/iqWxOWzMI46nYQl9PqNnxav/zmkGn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E6KJCa9CZCTMltum0Icev5f3AeNvpq7pGg48Q74ruuiIUMxwRA6goUWgASSyhoz3q
	 d7M4JtXA/j1lLLpaDuJ/Gdl6qjc/I4aBOw8tBVvCFLYIN4vFArGz6kx3+mU4unsH8R
	 0YuSg5FS0w4tbnc5+YNwTAULuZWp7BuvjjL4UJYxCPxGZF4R9gKAmnOuxY0G6WArMG
	 jqf3RgkpgHOgVbdHSA4vbVu9sl3P7o6btT3hRuIqSFZDbzukEx0uMJjG5+6FJdZ2AN
	 Hy5bnTw3XZ0VRBgYyu10/Dt3BJHZ/P3H3uoTWHyKt3Ljn2o4Pq7BOCn+A8AqhIHklT
	 XIOp+YGrhzTqQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 11:04:02 +0200
Subject: [PATCH net 4/5] selftests: mptcp: fix error path
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-4-1e7d25a23362@kernel.org>
References: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
In-Reply-To: <20240727-upstream-net-20240726-mptcp-fix-signal-readd-v1-0-1e7d25a23362@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=e5G+qBWEYbAT7+emrmtR+ukYBzYToM7rlgjg4Y+sDZE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpLga749PMCC/7juHKqBn/sepRpTMVAoI7FFvG
 hYa2qz00E2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqS4GgAKCRD2t4JPQmmg
 cw+oD/0YZ26mQwpGF/ugZqhRj8FrJhJJcFTPrK9O+MqePopy0NHUEK+M6PkqDx51RXMlwGzgpDH
 JDoyRB1ZDwhvX/vvKcKuyM+b0jiFIAfq17njzdgE1UTt0NFzwH/2pg4PRvU+nRPpW9t0CYRePuW
 Aru8SnouAY8SMtAgPlfWHjp5dNtqmhB/4SU7uS96bwuEPOAuHd8DeLLdcs6d/4Nh4jPoY1u/ima
 2xX8GlEZLo4p5rca//4dJQpk1WI3QfiOcAEETKEnqmivnik0k6M2FUaJauHzvuMLk8kJWIrM2W5
 gQJyrWZzEdBfQxiD+LaZ0NFMaIrJmluB7dczjfOe0N3SO756BWxKgyh67c5MMlR6FXiawOPSi6+
 5rEB9m+EyWVfC4b04I0Qop3tIkoBlBL8j9RNSqhqB8W2iSRxNIkW4Kya21AveOPftpIiBPXQzVD
 dYtoI6+pUpQYRnY8Xs0/ryME7CRuyq02FN/OzbS9sVZOec1iUwhUcqVzy7w7jfSjUvlVedo5beL
 BneJy+guyclTJZtefdWiB2HzI3hkGZOppQLx5z8rleBT3O4wECSsQpU9z8tRegaKSUB2Xu4TjJM
 yqYAffFYbyvclfA/HlJg7dm9qEKrzqIx9/PBHYbWKEiMHd2B6/hBIoRUO/YYBdePbK0xLsYEPGu
 eBwap7k/QRxGxVw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

pm_nl_check_endpoint() currently calls an not existing helper
to mark the test as failed. Fix the wrong call.

Fixes: 03668c65d153 ("selftests: mptcp: join: rework detailed report")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9c091fc267c4..55d84a1bde15 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -661,7 +661,7 @@ pm_nl_check_endpoint()
 	done
 
 	if [ -z "${id}" ]; then
-		test_fail "bad test - missing endpoint id"
+		fail_test "bad test - missing endpoint id"
 		return
 	fi
 

-- 
2.45.2


