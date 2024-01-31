Return-Path: <linux-kselftest+bounces-3893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7E844A80
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B6F280C76
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CD73C469;
	Wed, 31 Jan 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm+evdqM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735CE3C06B;
	Wed, 31 Jan 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737849; cv=none; b=ZTbuH0gqeGjKmW+NdaSFoKphDOMagxQ7u4HuYTXWNY6qIyEiE5W2cGegIARNud01nJQG4E1btyuGyeSDsajQxvVoFKk5mLxpv5anz2axVKfeGHd2GG/GwbyFjOj9R7NNR4ze/u9GTrleOmj+ZQYjWhLqFwriSL2UhEX/VdYiJsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737849; c=relaxed/simple;
	bh=3E5/P7Z5DrvNOzf9PuQQ34OuKSGwwV8XI0lmvwYqA1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=syye0ulMtXEI0Ffhij40PjC7z66letBaCTTCAxb/jQ4iml98A3gu4YVJdvyC4ZQbKa1oW17uTvefolcmE9EdKIyvW0DVn2ii8mJR+/w772rDgJrUmtIcveOIBYft9lqtithkma+GnSj9TwQP4mx6LUNPGu6umaO2PoRDbBUYyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm+evdqM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526B8C433F1;
	Wed, 31 Jan 2024 21:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737848;
	bh=3E5/P7Z5DrvNOzf9PuQQ34OuKSGwwV8XI0lmvwYqA1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gm+evdqMoXSW09/HxZglSxeyd+zmBrVkCm9crYPm+Xw3wV7DoqyC22sZ4ciyU+Wbz
	 TY+9TwYByRnoQ+wLf9Q1lkWKt0h32ir3OCY3n6pawsJCMNK6vn8PlMxc12s4N137sl
	 X7qx1yqolEP0yUHNiT2bYo0K9gC8IjJso3O5iAilfouNHpESpmyKHXk3AaO3XVF1Sh
	 jBG3WWo5nC4J06dLSUxfTKp0SKYMOJZTlhYcwl3SqnAuEvNZJavkCKsSWl0g8Gg8KZ
	 3zmg8MGY7qqevCk+YGgAikGKfO07wjf1dpAAiYnMV9xAS8qXs9rY0trJ13Z+BECYpq
	 5NIUuvud9lmTw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:52 +0100
Subject: [PATCH net 7/9] selftests: mptcp: allow changing subtests prefix
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-7-4c1c11e571ff@kernel.org>
References: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
In-Reply-To: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-0-4c1c11e571ff@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang.tang@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3E5/P7Z5DrvNOzf9PuQQ34OuKSGwwV8XI0lmvwYqA1U=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCgVP/RyFJqdfuGCRCnqm7Lf+FC6U1XH1yrJ
 zwwxFX8ZHaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c2SOD/9Hf8EGy9fMdNRAEz3WHV6h5wtRScF/MbzimcqOMo82x+yjfx89KxHNd63DeJ4lxmnpohT
 cMV36JMIRnXr2xjs4FBF3blrI4jAWj12Z2bvAAGgfEJy1XFVaTe1gi3iS3+bzGmKXQb0KTNBd9a
 Rae3lTAsd3zh9TpHa4c3Hk71V3LtRc57JFESeulQ3XoKv9uV3FWR4bhlVXV0BfZjfup0/qD3Fc3
 wYqdSR/dSeTxGYBZK5npQpiH39joQAA/xn0TWbHWDSBZjvr7HV6vzmvNm5Z/XSKITUGUpV2GFaY
 ZSZJjP+/qVeIH/ks08wq164J6wntPEirzl3TPV9alPNE8U+UwYgqlYyphvzffCpJ5w0VB9M+I/8
 koAx3YO7Es8uqEU84jDa4pIlIWoKZF4ko6NTj+uMamxTH1ybTK2cTJCD6rdIQ3sNCBJFdxDB3PK
 CUieisApoLF1b/yvpcm5Eq4WJMLNiFRYWWenHvvki1KRAm82gfq/kysu7534D16Ts6gyfvyRXA8
 hrFz7Y79FVFNQqaUbB2koRav7qbseBkEb6GaiZdfOyBnk9No8gU1psHqEiDvQi4FfYIE1UHLWiD
 oE5lqPFfwT6WKHpBYrlD7gfHzxKzdY3qojP5DXBrolHQdIYz0pPzIZEzwl7FPhgMJ/4jzDZX5mR
 2u/nWeaKXbQrT+g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If a CI executes the same selftest multiple times with different
options, all results from the same subtests will have the same title,
which confuse the CI. With the same title printed in TAP, the tests are
considered as the same ones.

Now, it is possible to override this prefix by using MPTCP_LIB_KSFT_TEST
env var, and have a different title.

While at it, use 'basename' to remove the suffix as well instead of
using an extra 'sed'.

Fixes: c4192967e62f ("selftests: mptcp: lib: format subtests results in TAP")
Cc: stable@vger.kernel.org
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 022262a2cfe0..3a2abae5993e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -6,7 +6,7 @@ readonly KSFT_FAIL=1
 readonly KSFT_SKIP=4
 
 # shellcheck disable=SC2155 # declare and assign separately
-readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
+readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
 MPTCP_LIB_SUBTESTS=()
 

-- 
2.43.0


