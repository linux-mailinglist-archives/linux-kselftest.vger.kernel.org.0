Return-Path: <linux-kselftest+bounces-5354-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D7F86177E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E082B269D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07A412A154;
	Fri, 23 Feb 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+m0Q/oS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26B1272CD;
	Fri, 23 Feb 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704906; cv=none; b=HvNsAlywj4bpsPRhLNtKseQrYlFXYEaBCAPqx+upHWlwiee798Do+pW9xRsZXJrhvUyzh1Vl1Sd3b4M9JfJhYJ2EVfQHHLy1gWcy8ApZLFlEZWsDQjb7eyVpRjcnbR1h3dM5yOwPcXv8gXkfPmujV4CLmJj7RyzqkrTKnxH1Je4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704906; c=relaxed/simple;
	bh=b+ZN3PITa9kkg8zOC0cUDaJjwPVoLTyK2mnUW7RNJsA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFMPqaA0KWkz7nIeMfwXmlVsZ7qeBBIaO3v5rZbU4MsgHTHUwzCA20QyBlK9Ya2ZjUxNYt9CE1DCpce4f83FAK0pbj3KxwPcgT4DNetxFjpUTTNypUwy3Eq7XV1XHzUILFmMHwPxtI/YRLJSXAVU6nHRX8nDU7meyKF9b3Ug/v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+m0Q/oS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4496EC433F1;
	Fri, 23 Feb 2024 16:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704905;
	bh=b+ZN3PITa9kkg8zOC0cUDaJjwPVoLTyK2mnUW7RNJsA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L+m0Q/oSLKJOkrbYpLsIewuZcckjXTCmKJM8dpHaK64RLuouMelF3H36YDOAxoCi0
	 m9fMAFIrBGDZ6DqONllUBxRVknx/DMzLMjLcta7//XTXjgdOfqgZH0IGSLzFJWFSUs
	 EgfTFmPVJ8Z7yfzsvvds1pEvR3eu0WdPDnbpBANksyl531f+svBfZ9wLMgdTWz+WrH
	 PJHsozMbxAJ2bD86baEezNgLiy40ll+btaWcn6I9qc+JgIdqR4PgXqjHsot9cdIbgq
	 wvrjzwJ32m6sY0DyFU6Ia4gICSqDzzDkIf+qzBhnIzq5ZKYWBDpKMdE8uWvPIuLlnD
	 A8CAClnzb1FPA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:17 +0100
Subject: [PATCH net 07/10] selftests: mptcp: join: add ss mptcp support
 check
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-7-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=KLB3MMq4NcEI7Evk8y2hay/amTn6SC9Wks/c0APaicY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRqp99SXmBP+BCtfm0cIfwhmR9owsF54p2/3
 jHTQHHFQBGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c6GiD/9ODQHMUmkHjQr/jjXIX7p5secWLqfKIUtaHgmsfuT30Z11zHFyfIEDJTzT6l1/ptn3CEn
 LRKZUnkDVYl4KaW9en5CKsvHDfgbyO5vIr62J4FaIHuCnWLVGeH4hH4rQj0A4k0TxVtGmAUqW0n
 2h3eW+addcNa3jREiKgxAXPguF16zr8hlrED92Oi7/oYwsjJYU9Zj5YRNXOWhchgp91qOjcpJ+I
 wfAuYKSQi47h0a30vDVWmzLjqhUR3mOtGVkLHBiMYl74mCeygJfDlSiEsW/CTVFr1Zkv12nRoSb
 1thkPABxV/1tFOngs85lQXZjzcnrH6y7YhF8PPMY6QkW99pGuBUwTfMN6qgYh9lyBCaappGcpTf
 pA9102wHwZfIOh50Pxw6pzN31ZsbY/sOtEs+2oYNXixpx/8MlNpl7xIU/OCxPKhS0i6M+gFi80+
 xwrHjMIubaWaKF0U/2HtyWjHOgup91/faSk+UaC6f2cNx0ZDoiaSsw9MnGrAlF+89kFV3EyQT4u
 7U9gnk4EegqZfnrtScP40gwPHtW4kNh+Ix4hq8PqYpKXg8jC/AUX3o6TnDZ29p6XSWsK+SfdIqH
 wKxOuyF1rDWDNAzFpRaO4yYlPPghdrZ05DzDhBptFm7UPX4Ay2HYxUPwWqsS7wzHB4HDgCMgKgn
 odeHoGcCPbjPRuQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Commands 'ss -M' are used in script mptcp_join.sh to display only MPTCP
sockets. So it must be checked if ss tool supports MPTCP in this script.

Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e68b1bc2c2e4..e4581b0dfb96 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -161,6 +161,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
+	if ! ss -h | grep -q MPTCP; then
+		echo "SKIP: ss tool does not support MPTCP"
+		exit $ksft_skip
+	fi
+
 	# Use the legacy version if available to support old kernel versions
 	if iptables-legacy -V &> /dev/null; then
 		iptables="iptables-legacy"

-- 
2.43.0


