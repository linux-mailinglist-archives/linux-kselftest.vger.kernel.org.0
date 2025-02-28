Return-Path: <linux-kselftest+bounces-27909-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A556A49C33
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 15:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4852D17425E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96F7271268;
	Fri, 28 Feb 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWpqs9Lc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0CA270ECB;
	Fri, 28 Feb 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753551; cv=none; b=t4w858vjnvL+ZaVxfOR4n9ZtbekeSZKePQ/HMxTqSLSVqH8sFMGj4i00K7CUNzw+wlSzfwy7RJjJRsaozUD/ZqaKT3Jef+Yeeh4YJnQB0ETwmGaT8PQcrD8JECHFWagQ50q2OS42TqYdLCEZUWShVJqlqpt4xYxqQosz3J+ts7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753551; c=relaxed/simple;
	bh=PBull/qL4EnlVYCdULdKO210sRFlo5bSFoSY3Jb0pzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aX4z8Ykuxkxga9LyM4YFLj5KcS3XjUmlogZWgZtUeSLYKgcp+jCC84xP3VnW/flFz5hVRHU87jXCPrAbhE6NlNzBJD0LcKLlKLe3NRrEqkY4EMV3lGhAowzpmoD3AwwZ0dOltnt/4rvPOkEFjBlV7PHSt0CTTiPjTzUE6wDscFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWpqs9Lc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B727EC4CED6;
	Fri, 28 Feb 2025 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753551;
	bh=PBull/qL4EnlVYCdULdKO210sRFlo5bSFoSY3Jb0pzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SWpqs9Lc6dimnPbsk4V41IWpeD2dyWWTDm72cOXgmET/bxJi6dQ7Tn6DulOnihGYN
	 c8jGwLeDpqBTJot4zgIHGO8HcQl5Bj2aH0XEhmW4ZoaAHviIvz7OU64eo3T+3e3KV/
	 zwomc6zR1qGmzGC1YHV+70hTDYobt1neghFAElHfdpkyXEcSG3KanydBiMEzWMaKnx
	 S/MEzkz+Lh1uvNIXv3XRESf6Hrl9gxq1EdQ1lpxfcKWVmF/dnW5Yxv6zm3/AJlgPHa
	 HpvqDm9SN8EH7JVRqHoM6FTLGWBBD0keVZEwyxe90Bnbptqt0qA+VTYoM4o7eKlVfk
	 LKFtm84d8XaBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 15:38:36 +0100
Subject: [PATCH net-next 2/5] selftests: mptcp: add a test for
 mptcp_diag_dump_one
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-net-next-mptcp-coverage-small-opti-v1-2-f933c4275676@kernel.org>
References: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
In-Reply-To: <20250228-net-next-mptcp-coverage-small-opti-v1-0-f933c4275676@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1853; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=uJ3BowRDasHG/ibhvtm/YcPktKuZNbP0h9Q/mTsvLwk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwcqFl6DKH1VmIejGlssmsUc5aGHkWeKg9d1qU
 NWgRelVCr+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8HKhQAKCRD2t4JPQmmg
 c/2ZEADNWFnBscvZ3y1VpJ1S5qxzVrbpdLoGjxtTf4+BJaS/4RHKTq7fifwirEVWCHb081T0iPH
 X+croirikV6B5vfaHq5rX0IvQIXmcjBldc82JRsf7Bwx3GSKR2h6dgU4wU1NC0BKMHI+bzTKW+a
 1WgYWncqZscnNOPPeJDyEn6c/IVdSGEpMo5lUPgN60zFuKGRSe62Ju9LBbxrtxoZ5kHkgZ20RE4
 bKaUFbbnDEYqrQxjp/vrXlCBVKjff3Ed+iSck95lQhgC26jCDifN+2YPWbXwhTFMDmG+/Zq7G3j
 zbcyrxIkBsbsHySuOLHo9ha3baMuN6inr4K5D5uyW9tRpDt7R6qw1BgA+nEIFH+aE5qbtKq2MA1
 SyGH8Xc3pnkcR9Epn5UQ6Yi4QqBrZlCBXhdo5N+QoTTPhJung6kTKXyYqzkMWQoDIvVli4yUhzJ
 HfExWR86ColSunnLyTjS56bnwL++BSdvbSlifKFMbSuuCeERzhyysW9nXiqDkz0NeUEIuqLGEWD
 r+S1pNsdRpKVGdnsl7tI3X9XlGgZizsN9vPEQGAuoxRh2+RGKTckOMi3FM4dHCCt4puGEpc8Xm+
 BjiDu0Tpm8cu0yB/9KDJyQbJAK09aeLwZmTB1VEncNA7EMemJV9FLjzClXQn14l3IQp+z346DkW
 H1nMN5a+l7wfKqA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch introduces a new 'chk_diag' test in diag.sh. It retrieves
the token for a specified MPTCP socket (msk) using the 'ss' command and
then accesses the 'mptcp_diag_dump_one' in kernel via ./mptcp_diag
to verify if the correct token is returned.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/524
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 2bd0c1eb70c5b69b4ab364eec3f4017898ff7f03..4f55477ffe087721ad13774e82a5e2b1e6cec7c4 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -200,6 +200,32 @@ chk_msk_cestab()
 		 "${expected}" "${msg}" ""
 }
 
+chk_dump_one()
+{
+	local ss_token
+	local token
+	local msg
+
+	ss_token="$(ss -inmHMN $ns | grep 'token:' |\
+		    head -n 1 |\
+		    sed 's/.*token:\([0-9a-f]*\).*/\1/')"
+
+	token="$(ip netns exec $ns ./mptcp_diag -t $ss_token |\
+		 awk -F':[ \t]+' '/^token/ {print $2}')"
+
+	msg="....chk dump_one"
+
+	mptcp_lib_print_title "$msg"
+	if [ -n "$ss_token" ] && [ "$ss_token" = "$token" ]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	else
+		mptcp_lib_pr_fail "expected $ss_token found $token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	fi
+}
+
 msk_info_get_value()
 {
 	local port="${1}"
@@ -290,6 +316,7 @@ chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
+chk_dump_one
 flush_pids
 
 chk_msk_inuse 0 "2->0"

-- 
2.47.1


