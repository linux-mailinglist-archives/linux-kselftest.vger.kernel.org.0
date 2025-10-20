Return-Path: <linux-kselftest+bounces-43603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55784BF38FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A5623BCE09
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160E8336ED1;
	Mon, 20 Oct 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVoz7j+G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D7B2E762D;
	Mon, 20 Oct 2025 20:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760993634; cv=none; b=WySquURWz6MBlb2+Xh0qNKaJZRojnlPzU0hqcariFyuNASkLh4jJ0LeEOcHZLDOEUddYa/NZhVK26WKXqalRAKtgsVDLlDXKsiemk+jkLVrqUq6GyJcljOYE3OAfbqUesNtpKt5FY6nJZHeJov4Cx8pe795sn2OKHb20RLy2bTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760993634; c=relaxed/simple;
	bh=xIa1OUBTl75WwgFA+OKNsrau5d81ys+xlnMTikT3Ck8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bap0OZTE1K3nNuarW/GHQECG6hJAN+bYgf0Ks4ij2GS1h9XIcEVOFmkiQ24CV4Kx/HHJsDz3sOCNZWU1TlnTcWW74f5Ap1vEIWMHVuNzKAurQ6uZrHoFXaXWU0gHBzQxVhqqP3I8pi97xJfZDGfJpJI/1sbGYoS+24ziEIkFDng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVoz7j+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA25BC116D0;
	Mon, 20 Oct 2025 20:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760993634;
	bh=xIa1OUBTl75WwgFA+OKNsrau5d81ys+xlnMTikT3Ck8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iVoz7j+GQ7WFko/Otp217DO57FIbND1aeylEq6e5yiaNTd3129Nkt+YfvfitoYKPu
	 ExGaW5s/O2ccuzX0xabdRdHQoPAjHY5wutvBUZDyTfwa1sRPqt3sHXohNR9a4nZooO
	 PnhLLsiRWXm2+nWaZ3c9hkrAeIolLqJsHjSmkzMQdFDy9EFOeDHlUnauFPd6p0BG/C
	 flzaalPjhR9KAu/7ghVrhwX7BnDn+GX39rrfq5srO64eSymZ3ixXxPdKX27wxSp+zA
	 LshpXugEoiNgTAMuYRgOKyUuxH1T0sASFg1dkoc9LNgEL3JidtUVkGY8x7Tke151CU
	 f1JwynhvHMvAQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 20 Oct 2025 22:53:27 +0200
Subject: [PATCH net 2/5] selftests: mptcp: join: mark 'flush re-add' as
 skipped if not supported
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-net-mptcp-c-flag-late-add-addr-v1-2-8207030cb0e8@kernel.org>
References: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
In-Reply-To: <20251020-net-mptcp-c-flag-late-add-addr-v1-0-8207030cb0e8@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xIa1OUBTl75WwgFA+OKNsrau5d81ys+xlnMTikT3Ck8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDK+LQz9Xhmrl3Jj09yiexsXFDt9urN29aQvU9ZK3uqTM
 WudVlwb31HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRxEkM/8MbHtVqu3IsfMrH
 pT31o8rLLKYJD63PxSyf/vjAsz0KPqoM/5Q3eVxWS1YrYXARXTdDMHL2hEetmwIeWv0vP/1JRCU
 lggsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The call to 'continue_if' was missing: it properly marks a subtest as
'skipped' if the attached condition is not valid.

Without that, the test is wrongly marked as passed on older kernels.

Fixes: e06959e9eebd ("selftests: mptcp: join: test for flush/re-add endpoints")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index c90d8e8b95cb..deba21ca5a97 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -4115,7 +4115,7 @@ endpoint_tests()
 
 	# flush and re-add
 	if reset_with_tcp_filter "flush re-add" ns2 10.0.3.2 REJECT OUTPUT &&
-	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 1 2
 		# broadcast IP: no packet for this address will be received on ns1

-- 
2.51.0


