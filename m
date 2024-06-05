Return-Path: <linux-kselftest+bounces-11239-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C9D8FC79C
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 11:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C05671F21E55
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3018FDAD;
	Wed,  5 Jun 2024 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThviTDbk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142F19007C;
	Wed,  5 Jun 2024 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579310; cv=none; b=dGyAZxokgcEBLI36bFBQ26kznLh305MsyH+Q5B9RGt9yB17sQG+DAY+TkcmEm2aXDJN1rCBzzc3yEQXTq319LNgysdXPeAP8FikLYPx3V+LazwAxrG+orV1bKjQ23SxKmS9R/o2iXAcq1ROpYCPNCC/9/89H1jpED7OlX2YfySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579310; c=relaxed/simple;
	bh=emM8MpMZS/Q1Qm8W6JNJM/DOm/WxwjPphw2aJyCxtSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3+icHGraw3CbRGseadoT2n+vVeOUfc5mWLwInGaN1ntaDbhq8s3ag9giyjnQN3kO3LCY7cHutOCr7RenTK5TFsuPNrVqXgk/hQji0nBif0lBlc3AKcX5+mJBCzGh2GvLeAsACUmN5LOLiCfDCTmIXESrlL2bQ2G30dv7NhacfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThviTDbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8CBC32781;
	Wed,  5 Jun 2024 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579310;
	bh=emM8MpMZS/Q1Qm8W6JNJM/DOm/WxwjPphw2aJyCxtSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ThviTDbkdVhbhotmIbBjhdmrfpSZkOqYFb1Wdpc2hfMiR9Uz6s2VQEMAa7GA6OtDd
	 wQyG07UKhritiIOdphqYdk0M5i8NXHPvC1hZecqNGvn50z3g9BpDFvayaZrBopRf1M
	 UEQrVI0E/mLVpZTAFcUzTh8PKNoMSFM19T58DqWx22mBAGPJD0J6bZ6l2U8S/mt/hI
	 LTTwuPAaYre9I9WJZO/9Wk5AwvLb64dl51Hy5lL9Ll/s88+n6xG3XL/bQEYAsx+Xeg
	 XbJYL9W8lCTeuap0l7YIROl562ElIjjAe3tfqTj+/V942jcH5x8GLbdyvRHPtjU+wx
	 XGDlCwZn6MYDw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 11:21:16 +0200
Subject: [PATCH net 1/3] selftests: net: lib: support errexit with busywait
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-1-b3afadd368c9@kernel.org>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=emM8MpMZS/Q1Qm8W6JNJM/DOm/WxwjPphw2aJyCxtSA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYC4n+9+t10gx5+TjFlVOJh5uSwYhfP/lEbay5
 akmduvsXxuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAuJwAKCRD2t4JPQmmg
 c3uoEACZR4kugjErlhaqMqZy4acx3u6K4BiclibwUGA85iOBUlw6TX+n2xHYJAbhHlfVDInsc6S
 JveilSdtfbQWDiM9w6M9HqOq3sh116wYyMuPw7gdnZAZtpc+AnkdN65EBl+AUGY89SBkwNmr+pS
 mH/Uh3A7JwSFEM7T1aAZUxvKzhtZE4mwecjdMFgxT5Z8VEygWd6KJBWagGIxLLGtpxmE5qSBjlj
 ErJawSaNd3s0iHQm40tA9mZRcq621peIhQFxRBqtuTL6f1e88tpiWzNnAftdZLATGgRrtvHECJQ
 GHRfUOFXnFhT/yG0yk9YADynPQMTWp5I/vk06E14QHX1fBC9f5hDEu42Vq+nNPX6EwUOGY+ul8X
 81eZNToD5040V5K1RnXd4tlyPhunWIZ51Xa0zrhZk4kscGTOWczOB+38/gqxkvYmR6csHU8dIVH
 VjwoNoRoZr9mxVqHbZGv/k5YZtYgzXa9v8g1IQEjW0wDfkORsOcToJCdHrWMfULET+0rn1rZgkK
 JVlS59uPr1IdVksMXqnlZr/fxsC+gha5g2aYSFIXiim3HRsvzMM9FrqaZ5ej8HHesSlMblstF4L
 jiVJ0FiaxvRYPl6m9MQ3qLnRXKO/0khErnLSsww2h+MiEx2jTHju5kzuk6bN3nZuLGq30NvHe6P
 R4q9pM4bv9iurJw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If errexit is enabled ('set -e'), loopy_wait -- or busywait and others
using it -- will stop after the first failure.

Note that if the returned status of loopy_wait is checked, and even if
errexit is enabled, Bash will not stop at the first error.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Cc: stable@vger.kernel.org
Acked-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index edc030e81a46..a422e10d3d3a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -67,9 +67,7 @@ loopy_wait()
 	while true
 	do
 		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
+		if out=$("$@"); then
 			echo -n "$out"
 			return 0
 		fi

-- 
2.43.0


