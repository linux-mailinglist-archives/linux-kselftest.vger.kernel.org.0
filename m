Return-Path: <linux-kselftest+bounces-7285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359F5899DF1
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 15:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66DC41C21EC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF72516D9C0;
	Fri,  5 Apr 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eo9q1mnx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2A16D9B8;
	Fri,  5 Apr 2024 13:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712322402; cv=none; b=mNqhzekuOZAMCMsIx20OVkL7SMZp0bacYLeEOrY48+gUnY0wtcbpgHb/ituq7V6ktj+WdK74UjU8Ilf5skNQaO4vEkpTHgspXk1tGALlz9zB0q+UVA1qHqOHQxPOROmvs3mzErHztaR4CjQwfbVFp7vc+XOdUD03DhDWwGNBV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712322402; c=relaxed/simple;
	bh=cNRHTNoB1FjvRBTrgLJ9wDmPMMbth4hYAQoyT329fAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sbbKNCVCe258ExBskiFRjCnse43M6DHvBSXf6SYyyHgtC+Utjr3Wk9fOFif/y9btGfXbc6Wxio2QwYH5Kk13lMSeNsyo/TJwjvI6K0kDehH85o6h73h/KJAKsZiUaidhjINESIxxpLwr7+drrSj0/CM1XgdgGYd4AaJEg6N6qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eo9q1mnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906EEC43394;
	Fri,  5 Apr 2024 13:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712322402;
	bh=cNRHTNoB1FjvRBTrgLJ9wDmPMMbth4hYAQoyT329fAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Eo9q1mnxk3HiIgK1O+yi4lv40j/Z8oeMYMP+Qk9c2Fn38NlrCsxnTwEp7zfk1Sjdb
	 DXUWGxiGqPNMXL6mbx9AuS9g/8wcYIrcUKUDBcLXfT3JNY5vZg6XBULa8mQiV8E/Gj
	 cXO/l8uWwGsMWuJ31cXfPU5kXYmM91rgIvmEHYpeRvVYazGfwXfYoHK6hN40tXu5nU
	 fp50vMrnzBnyTq8DCHq/NhSdXQJn1wUOmPY3OQ8wrYxQrY60IN2/V2hkcte2RBQNFF
	 6LInZiZHplslm/JlCOpS6ynr8Gx1tA4TXmwAehR8JLcp3cZ3ts0c7h8UBKduuZfHdE
	 bI3DHPs/qix7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 15:06:22 +0200
Subject: [PATCH net-next 2/2] selftests: mptcp: test last time mptcp_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-2-52dc49453649@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-last-time-info-v1-0-52dc49453649@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2718; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=y6e1hT6fB4Z4RvFtfA4YiCJgrUME8UDpc0J3qux4/kQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD/dYbuuYeNarkIzoMVcZDRom6JrJ+CHavZocI
 SL4My/XEYKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/3WAAKCRD2t4JPQmmg
 cxCvEACkenL2P9tgiLJFrD6OjhLMOMiZ2z1YWp3jcg59jMGlH4bKuLT2uIEFJr/sKdMUWK8Gluq
 sU8/w6dM0f8b3CdQWcuomUWrPuvzmZzj0QeILCdOsRwBMoabqjDVWlr0yZTw3MtW+9CW8WnRhRP
 dZ1ZISvYo93TSBW0PqtGUGuqRR/3Oi/P0egvGbco+rM8wHci0bZ9A7X6rejwshmGI1w/S8b2Uhe
 J8DZiNN02rUsNnHSpRDpbFdEGPL7URrplmu0XxWYQLfJ1XPBrKHB/jQjl2Wd8vt6ll2mG9vCFBZ
 oSoIy7v5QOzjSktUu8saIg48Ctl8ylBicPvn01ACIYfwhM/fKv0tg+ICE02CetmDIEFPBrzRKpP
 JaVdT0UgFnK/VCeUj9XyV+B2TbNVB3VgWfUZ1ISq0cUi8oWHb2nFu5Bv3qipvLr3NTO5iLAVzpe
 xjRIRXhHFYdQoZgP4L7gFGALdeCG+OsTNnNXiQ5EsqPkypIJ/NVvEbO8zpAwUt4xqjioHZDVexV
 ppNUIN689QbrnZ0hFomhSfk6aG9yzp6iZgyEcUAs+NMd7M14WCtVbqT4XeOFn3ZUmOHBFrYCO9x
 aeCgFKNYNhB8UOQTbhXQqK0uKtSyr56c988jkFV4fXmH52on1fPlv6+LY6mx+rQB8LXmAs/uuwq
 g1Ndvtzip/DiYzA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper chk_msk_info() to show the counters in
mptcp_info of the given info, and check that the timestamps move
forward. Use it to show newly added last_data_sent, last_data_recv
and last_ack_recv in mptcp_info in chk_last_time_info().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index bc97ab33a00e..776d43a6922d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,58 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+msk_info_get_value()
+{
+	local port="${1}"
+	local info="${2}"
+
+	ss -N "${ns}" -inHM dport "${port}" | \
+		mptcp_lib_get_info_value "${info}" "${info}"
+}
+
+chk_msk_info()
+{
+	local port="${1}"
+	local info="${2}"
+	local cnt="${3}"
+	local msg="....chk ${info}"
+	local delta_ms=250  # half what we waited before, just to be sure
+	local now
+
+	now=$(msk_info_get_value "${port}" "${info}")
+
+	mptcp_lib_print_title "${msg}"
+	if { [ -z "${cnt}" ] || [ -z "${now}" ]; } &&
+	   ! mptcp_lib_expect_all_features; then
+		mptcp_lib_pr_skip "Feature probably not supported"
+		mptcp_lib_result_skip "${msg}"
+	elif [ "$((cnt + delta_ms))" -lt "${now}" ]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	else
+		mptcp_lib_pr_fail "value of ${info} changed by $((now - cnt))ms," \
+				  "expected at least ${delta_ms}ms"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	fi
+}
+
+chk_last_time_info()
+{
+	local port="${1}"
+	local data_sent data_recv ack_recv
+
+	data_sent=$(msk_info_get_value "${port}" "last_data_sent")
+	data_recv=$(msk_info_get_value "${port}" "last_data_recv")
+	ack_recv=$(msk_info_get_value "${port}" "last_ack_recv")
+
+	sleep 0.5  # wait to check after if the timestamps difference
+
+	chk_msk_info "${port}" "last_data_sent" "${data_sent}"
+	chk_msk_info "${port}" "last_data_recv" "${data_recv}"
+	chk_msk_info "${port}" "last_ack_recv" "${ack_recv}"
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -233,6 +285,7 @@ echo "b" | \
 				127.0.0.1 >/dev/null &
 wait_connected $ns 10000
 chk_msk_nr 2 "after MPC handshake "
+chk_last_time_info 10000
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2

-- 
2.43.0


