Return-Path: <linux-kselftest+bounces-17412-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E9E96FB6B
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 20:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FC061C2505F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 18:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142C71D5885;
	Fri,  6 Sep 2024 18:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyggxHX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58601D47A2;
	Fri,  6 Sep 2024 18:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725648389; cv=none; b=QZmRaWk9fua43dzM5hKjgAuIplWsmp73W1Dq/whBKlkvu44b7Bmxv5BBkvaFxjnJhPZvezQiu3g7/BInYh4smSxQUUXhupZ3UKy6UtATkSSTGoP6g6EbkzW2TejMuvPOeyLJhMx4wRZNxUXYb6HkUuV7odJTxWwEK9t+JPbRC7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725648389; c=relaxed/simple;
	bh=zXEnYXCgACDGfo7ZYt2ca6tuV3GlLu0vMdssd0apdYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0RT+GIsPd8Rdvs9KSeiynx64q1N28tk0cqLsUwSVjBlta7JZq8oTS+oQfpG0GPs0Gwcy5BQhQVJJTjrWlTRRiTYS3sUdYbx69TA07NFbr2rei94RpYQpXuMMBdODtj/HTF4vGUYdf8Jjc78H/bOijbXmWsW6hFYR+ymdsHzqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyggxHX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07766C4CEC8;
	Fri,  6 Sep 2024 18:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725648388;
	bh=zXEnYXCgACDGfo7ZYt2ca6tuV3GlLu0vMdssd0apdYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dyggxHX1hdmGjWT6qmq4X3tJ01YFPc/wkyW+RG4qcUYma/99IwWLvZqm6yg0BjR1I
	 svcw319eWF29qXPx2NtZKuV8WKixZOP2AEEYKwZ6A/Ayk5c37gsIwHziOMtDIMH7YK
	 86AclcIplwAd2ZHHZh96Ekrk5h7lH0qm6P71KPiFqT/aEUosRF0axcsLi/nYF9/p38
	 7VsT1m9XCgwHlw+rwQxfCfxcpWWJY2RDtuQHqpR6ATb/gdd6OV4lz8anmAA1NJbHE4
	 YJchYpx6pX9c2tE/chT1fHIIW3oFU0tZnLonwND9iUBGa5+a0vCXm1r5VEcJGJ9BpW
	 An2QwsgFFF/aQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 06 Sep 2024 20:46:08 +0200
Subject: [PATCH net-next v2 2/5] selftests: mptcp: connect: remote time in
 TAP output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-net-next-mptcp-ksft-subtest-time-v2-2-31d5ee4f3bdf@kernel.org>
References: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
In-Reply-To: <20240906-net-next-mptcp-ksft-subtest-time-v2-0-31d5ee4f3bdf@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1014; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=zXEnYXCgACDGfo7ZYt2ca6tuV3GlLu0vMdssd0apdYk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2037EesQgSqwUmMCyycaUfga+sDuRiUcClMEU
 m7zZQdLKc+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZttN+wAKCRD2t4JPQmmg
 c5wbEADgbkH58kRtpmtBHLlOjiZd4wgfiXKB9kKsCQyLsbARhOBK2tUqkmSM8A+lQkDgAVWiyDe
 vzyUtqLzCaJXGN2K0n/XY6W66zjTTqA5GdfftsJPRQxTcs/jqi5mW+EUmCOCPwZwJNziVmUg5Jc
 jeDg0kCg/blS9s21Z1LaaHiz2fo/1c4H9zuubehDPi3EZykh9Xk7gh6p8DE9RTrdU0Qk3kKNOqs
 CwZ1lkfWbs1TsktNUE3qxHrv/wMkQr6y9YXTAE+xTlgS4X7fCKuP7mhE68ZeoK5rlnlgWvZqme1
 YHYbSGqNhMusG+Ivb5TS033wYVEAGxX13YkgYeC6ckH5dhVnMEBbZiPlERN/MWu10s3A3qLmkoR
 q7S7uMGehBWOP0thYe83YyIGVAeig2Oa0vaMwGdt6jUWfiVibXeXKkQv6AbBLqFLMNvRQXtlwUR
 DvphVgQArk8L/3Jiv7tQdOiUMMls9zgOECNMI1Umbbi79D4heKUSzxYOgyVYQkg81+ym65gV9cw
 sYIjc/iDRGG9xznrcKaqjkvMCSXXQL/xRAv29sZsuSjjoV+LbWv68DHbQWbxdHpgN7oQnzWVrx/
 OLClcJ0Z4y09oP8HfTO1KPXGpIK+VyszkDtXzkO8qamhNiRe5uZK5H6DC6PONDa7Gf/NzrY+Ajd
 smskOdfUOabrZrw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is now added by the MPTCP lib automatically, see the parent commit.

The time in the TAP output might be slightly different from the one
displayed before, but that's OK.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2:
  - Fixed typo in the commit message (Jakub)
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index b77fb7065bfb..f61e2f5870ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -431,7 +431,6 @@ do_transfer()
 
 	local duration
 	duration=$((stop-start))
-	result_msg+=" # time=${duration}ms"
 	printf "(duration %05sms) " "${duration}"
 	if [ ${rets} -ne 0 ] || [ ${retc} -ne 0 ]; then
 		mptcp_lib_pr_fail "client exit code $retc, server $rets"

-- 
2.45.2


