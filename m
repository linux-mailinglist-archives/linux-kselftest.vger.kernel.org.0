Return-Path: <linux-kselftest+bounces-3892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56265844A79
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1421F2108B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFBC39FCC;
	Wed, 31 Jan 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW8dqBfH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C53B798;
	Wed, 31 Jan 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737846; cv=none; b=TlHupgKqurQBG6r4T+Q9F8Wj7zUJ5gIiC9kjImT7BYjrnBjzWrqotbfPnLA2AaD1AX0nGTX9OGxD2t9EDKBMQf0Im/QsSfedgHzqab+4BmqCjrKDonslyRjt/z3IIWFzcmXQvrfryab9rvbjQPxAqp2J/WHYxsAXLD4s0vRwb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737846; c=relaxed/simple;
	bh=BRW4EKaAi73O3JOekFDxgN9kn24cg0usCuUdEDXFcWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hifLjXpPYuDMtZ+b8uMQ4H67rI7bDszYdrmVldNYJei5qILfjKBG7OZpkSHmUVzJTJawfAx1/V71w55jdy80RWVyNrFtWGugnEXO9DYVktrMzhMYds7ulRilqmtMA9l2fokyCEx+kYtZmmdBJUJq2eDquAZY1iB/hPY2+urR2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mW8dqBfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D7EC433A6;
	Wed, 31 Jan 2024 21:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706737845;
	bh=BRW4EKaAi73O3JOekFDxgN9kn24cg0usCuUdEDXFcWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mW8dqBfHJEFQp6NQHDempDFInjUfgXVnmHADImy1NgUeO7guiAzYG0UqdQbJ8a4o2
	 S84aDFvumDKfa7nnUV9BzNPPC7ATL23BXnbhARqxhyXYTIVsLvJNQ41qAbiQ3Yqz3t
	 9UPOXo1h1JhGrHa52U0RUEwd6zqjdr6uHcHqRcR9ZTxcfAt8UiEGrqi6J8iX7svLte
	 oQwA1BuzA3nyPw+qKwRiGzWaskRe8nbgHWDOYriszH9CA1NH/GE7DawvgZcUrSA8PV
	 Ejxca3CB7seJHYsk3BpcrkrwYJ8x/hnL3oka3G/VNeJlSkHg1kr2XcXzGc2zUNOkMn
	 WKyaAfbmcUdLQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 31 Jan 2024 22:49:51 +0100
Subject: [PATCH net 6/9] selftests: mptcp: decrease BW in simult flows
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-upstream-net-20240131-mptcp-ci-issues-v1-6-4c1c11e571ff@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BRW4EKaAi73O3JOekFDxgN9kn24cg0usCuUdEDXFcWw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlusCgfggB2kN2QOjIOQrItHH/MVAI5v2TNUzze
 A8pEd2ZhkGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZbrAoAAKCRD2t4JPQmmg
 c9FOD/9LK5rKYnWEDzp/YruMxzGMONlK2bqHhmoBBdFVQHDNxom2Lw8WEmjTYH38FYA0K2Xiz0t
 jSGI8H/rMvCMfHcFmpfak56PnN6rlTHb2p6A+vOaTXbOyF/Tt2L1IMoZaVbDuLt3iafW6ZchHtg
 OaQwqTbW5+lJ6YR9+Z62C9pF9SUzJ+1XVACsNXjk8JzB3r1tMVBGBU9KeIhJWNIhHP8WU1d3Fmz
 6QLc9h4EK5oqDe+DqlVFfCi+JQXhcdEoW9NEXNhB+L9da1mfKohe2hQpOYeacYG9HxWaJBp0p/6
 frL5yhkEr3JtiAeA+zG9Pz21yMivtNdCNmvejGYwxKF7RFgFnPGgjVgYlI4DMTJVSxkx5FMCEZy
 94A5YrNd+L46xvwn30yktYbLK7/mOEB5Wpw+z5C6zvB19c7OxpoZCEbrBTdCw5Qfl6LKJRBxlt4
 m532leDnRFVan7/yCAImqwQYysOa80TqqC9EDVefi52S4L/cE28NY1uSEnLxmgMq8iiqHgXxl1k
 8XWqaMfufMk50K4t2Pyc1rLCk5XxB77qGx3USArSeYuSBDquh+rzeKHzfLwwMVj5IScNa0qPggV
 pXhnd61/gg/GmNcKdSKd3CjeHohusRapXoJkLpSe23Wqyx3dCKQqcVSjmSh7CIDBZ1/xkR/l5d8
 dtfVQz9e6VFu5ug==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When running the simult_flow selftest in slow environments -- e.g. QEmu
without KVM support --, the results can be unstable. This selftest
checks if the aggregated bandwidth is (almost) fully used as expected.

To help improving the stability while still keeping the same validation
in place, the BW and the delay are reduced to lower the pressure on the
CPU.

Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
Fixes: 219d04992b68 ("mptcp: push pending frames when subflow has free space")
Cc: stable@vger.kernel.org
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index ae8ad5d6fb9d..0cc964e6f2c1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -284,12 +284,12 @@ done
 
 setup
 run_test 10 10 0 0 "balanced bwidth"
-run_test 10 10 1 50 "balanced bwidth with unbalanced delay"
+run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 30 10 0 0 "unbalanced bwidth"
-run_test 30 10 1 50 "unbalanced bwidth with unbalanced delay"
-run_test 30 10 50 1 "unbalanced bwidth with opposed, unbalanced delay"
+run_test 10 3 0 0 "unbalanced bwidth"
+run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
+run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.43.0


