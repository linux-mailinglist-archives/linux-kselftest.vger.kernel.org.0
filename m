Return-Path: <linux-kselftest+bounces-7562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851D89EF1C
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 11:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DB4F28225B
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 09:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407B158DDC;
	Wed, 10 Apr 2024 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHsIIZWT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14778158D99;
	Wed, 10 Apr 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742518; cv=none; b=NJLvO4pisRuve+89eL0W/PQ53O3JoNvhXw2/nyGdB+hdYJ6aaiTnrgG3BvH5PHGnLuJs4vxCQHD7fTaNTdSAaGi0jmklBqEWPpn7VeSpQ0iYyeqQXZcEBBTf+IXK5ruERo0ofv8znZpJMePArsAEzyre3LNE2T4D7hqmNkg4so0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742518; c=relaxed/simple;
	bh=cNRHTNoB1FjvRBTrgLJ9wDmPMMbth4hYAQoyT329fAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLsg/D3lR2zxs6EWKlLcaezGMlMMNaGk/ZnIR6k9kdiaxRzSaY1Q/Y+Ca7k0jomNM2tLQzBz6XpNjJJwORbCAsben5HFL/bIVagXlDHd2jscPpMfnwp+AYD5rgrpUcDvuOhIqVOY556BpU6Jebb7Dn1zWNWDFOyeDOAZTFU5s1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHsIIZWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11FAC433C7;
	Wed, 10 Apr 2024 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712742517;
	bh=cNRHTNoB1FjvRBTrgLJ9wDmPMMbth4hYAQoyT329fAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aHsIIZWTdrWCQTEQxm7maSsnNu5eWu3tl49W/CG76To3Em1c/kDOAfSjVyw3j70Df
	 rOi/dpuP6QNPEUk3QKEey98REJ9o8DaJoQnAXnSd+DSpMT7eHAvl/M9SMfngFQ+v9m
	 zi7QfvnssKU1GP5uQcHe3t0+bpBXWbrAPfhnR7wlKevTQOueLiizMMpadO70ZAkQOo
	 UH1N5TOqMvLiFXBdW1tKScQDK/mj88zHkwt317PA1NTNWxjV5DPVd0fzxHoQDDXJbx
	 M2RmsFJ2AGUnW3ipNaughqw6JioHOlBHfNwYyDFQXD3xTt72gv0GPxpHNT0vAnhKDS
	 9YsCvpBJwgYHA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 10 Apr 2024 11:48:25 +0200
Subject: [PATCH net-next v2 2/2] selftests: mptcp: test last time
 mptcp_info
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-2-f95bd6b33e51@kernel.org>
References: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
In-Reply-To: <20240410-upstream-net-next-20240405-mptcp-last-time-info-v2-0-f95bd6b33e51@kernel.org>
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
 b=owEBbAKT/ZANAwAIAfa3gk9CaaBzAcsmYgBmFmBs2dzr/QMaUnyVUnEaaqXee3OoP6+PiAo5P
 qTTczB3w3KJAjIEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZhZgbAAKCRD2t4JPQmmg
 c5zzD/UccNx5cv2z4AZgIwqtZAMNa9oSub2dtGGs7w4a37Dly9wnwevqLL6JZNEaKnicrH9EPCG
 G0E/yVBkNrjUyYbWkArW4Mb3O9QOqbuYCb24/8sIz5y20uXeuzsdQ4hFTSkq4f/C6wYtfrq7s6W
 EAdvYhARM7C4aQIH42Kmbq5+zLFaIpnZN2n7z6Bvdz+G0Uwx3wfrdZp5B9B/AHKpVgz/+HY+Ele
 PEwcxOt6rhsd373VBWS7YIPpL+mwmxw2+V/n8wJk1SNkm5VyXsxhy90H8HCc0o6aL14RM1QuCn5
 5wLCjwiTjLQGp+aYk3TMY2R0VVA7/kEf+jBTzF5r/a403BLCLquL5mdUxAeYMO3Qz7BtzXk/VyD
 wzvg6QOkIs2gF23yDf8dnIDIihEqoHMfbIW6zVzWUHYdsPkZS7dKul0qxwJsgrGWJfGHW0xhchD
 2EzyritNrntgeembKq0akTpVWdFNNwyk8ou7XbRSW8ZjBwioVwVgITbaswTopMZVGGTQInhG73n
 hyoiw+d/IzAFgLKpzNVsR8EMmycTBDmdlKXhobrNhefxdVurMBHzMsxeP9rtIrWUzpCcY2nm9oV
 RrxYa04qyPuBRxvVF3bbSx+nMoz+8sCJSpn4e3ZsR6sOjn53IT/n3ZDYFfJoupb+aAhRZhCrMnu
 YRkQ2xHh3G63r
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


