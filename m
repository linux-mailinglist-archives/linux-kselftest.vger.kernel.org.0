Return-Path: <linux-kselftest+bounces-24499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD791A10F50
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 158151889C3D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490122577E;
	Tue, 14 Jan 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZD2sdydy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FF1FA8C2;
	Tue, 14 Jan 2025 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877818; cv=none; b=F7TFRjcJBYb/4VSBMo5z9pYkxS2pUbNfLuJTO++OAGcI6biSdWDuYpBet3ynme1gATadESgq7PS6k8yChhmGkFcfiqFwExuXe7GUjGmvrh6RxoVibe6UjUAB60YCNUw4MIbs/RdEsx18Q3Xt7ltvo+QZXOKYQDJRU7LrUdyrxs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877818; c=relaxed/simple;
	bh=y+CXAJdHDVT9Nx7wej8EeVQL11x+r7crzxcSKe6+QUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HngC+Gly8oSc0BoxzWCHJ84F3gvjli+5YZb2Th31ddKdZTRfi1XnOMAh/nYrs4L0dbTawbeWA4daQWrAVrxjJKpnO+Jyu1m/FT6SPO7pf+zhB3QElemGsKY6/VhC2Usw95yT+S5gUnrg1RAAFocoVOgLe92iB6G9ETPfkDYm7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD2sdydy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E64FC4CEDD;
	Tue, 14 Jan 2025 18:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877818;
	bh=y+CXAJdHDVT9Nx7wej8EeVQL11x+r7crzxcSKe6+QUY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZD2sdydyZyCzzVjHWyWDXMh2kwlNgvVyLEbj0+vO38Oeo7WJSpJfPIB/wpXwjfTee
	 DOWwrKqcyOvxvpTbYsVAzFr1AjBgW41t0zTEQuamHGEJ/kQ4JcM8UJb7ZMRkqd6/hK
	 XAlyqg4KZe2hR85f36V901gkFnCsePYbBs+P+x6yN89+8MMABxJ+cj1IvbTemXhZqI
	 Pj8aIF34lMZM9nhf5myFUp09JNVhtTAS9yuGvqd7uEjVx1YH0yAIOgQrLupS8zX47v
	 teFvu0kig2bfk6AJoObPNv2I2WqVzaoORex0Y4i0mC0RSvjaXwQK3g7VqcYcEKlXXb
	 562hRkIh9AVYg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:03:14 +0100
Subject: [PATCH net-next 4/6] selftests: mptcp: add -m with ss in case of
 errors
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-4-2ffb16a6cf35@kernel.org>
References: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y+CXAJdHDVT9Nx7wej8EeVQL11x+r7crzxcSKe6+QUY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqboCZdKPhA1hKOI8CtsZszMsX5u9DgDrtMlN
 HgeuUKBg8GJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 cxGLEACHuw1y7dZUUJ5xr+GwVWMdY+VUJ3zDbce5xEmSEbNqq0HHsoBmCIZpe5fJMF1j0VLinD6
 B7R3p/qL2otqGCn9YElyt+i6YZ8kzB7bCvDiKi6m2DbtpUDvn/pJvp7bAuZlf6lBD2T/exMPNxx
 pvKiJ3rUBIfOYPD4BBYSRY+qpUVA4MOQmo6aZBV50iU/k0boKDA9Djz4ylr83by/sgNo3UcPmSu
 QIhyo+usv8mEm3YANRZpaY6scViw2q0HICjREf7U2rz3TqVdSHnJjO3N6ih0oDFM7h4X51XyyNt
 zg3xZAPMmpYje8cPByw45FJUr3sHOnDL1o+y09VPw45e8Uq0qDw8d/ApD9AAShuqtvQynC1oGTW
 ug2bZ4XQkHIpGGL5UBtBTDMDCMXj3ndgA2voeR/cOtV27Ai6b3suL46sXAiykzLzSA3fUK5q8Fm
 l2OWdXMHIQguOafio5yHgNUvSvKW3TsRLkyzNlCR9B6lFSWe++EIzQRlkF3LzeuafH44mIeVYZ0
 Cimyueu05zmSjq83SzxYzeh5OYAC2cH59i6j6ROmZ7yZ6STST7ivJY8nXc/idrOxtHnWAiYbuVh
 41ibR7TlsVa/FCeaykVyLf8wf59JUz/p8I/9NIi12jwesZ3huHaIVBm5R6El6DwtckrFDBykXTV
 xU28RUov3CWV1Lg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Recently, we had an issue where getting info about the memory would have
helped better understanding what went wrong.

Let add it just in case for later.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 91a1d3b76e664bd95fc36310ac2e2c89bfba1aa1..051e289d79676c5feb9f46da67a08116548f4b47 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -118,11 +118,11 @@ mptcp_lib_pr_err_stats() {
 	echo -en "${MPTCP_LIB_COLOR_RED}"
 	{
 		printf "\nnetns %s (listener) socket stat for %d:\n" "${lns}" "${port}"
-		ip netns exec "${lns}" ss -Menita -o "sport = :${port}"
+		ip netns exec "${lns}" ss -Menitam -o "sport = :${port}"
 		cat "${lstat}"
 
 		printf "\nnetns %s (connector) socket stat for %d:\n" "${cns}" "${port}"
-		ip netns exec "${cns}" ss -Menita -o "dport = :${port}"
+		ip netns exec "${cns}" ss -Menitam -o "dport = :${port}"
 		[ "${lstat}" != "${cstat}" ] && cat "${cstat}"
 	} 1>&2
 	echo -en "${MPTCP_LIB_COLOR_RESET}"

-- 
2.47.1


