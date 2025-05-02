Return-Path: <linux-kselftest+bounces-32183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86824AA71E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB521BC5260
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF53C2566E1;
	Fri,  2 May 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5Aq20Um"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37D2566D4;
	Fri,  2 May 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188996; cv=none; b=l/HY/LNeAVoNnYuUdXD3tio0+7m3fO9rA1qPrgMcrymPJfRsFslm1oKqfMp/R3btnE+2MGTGpPgbin5dErECcK5IILhXJBiFtiRYq9MqQI7GbJrZfa3lp7TmwjvC0UnqIce3icpX1Bf5Vs3CcIqBfHFN7ORO1J5RxFwV9tlkZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188996; c=relaxed/simple;
	bh=DGcYu+3DqZNwUOU60M33ZGmzLjkivOhGbY2ClBN8f/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jphPvsfU8ZX9qR/bvHcCwtb4BLo+AsAyh4nUyaetN2AMuOOOGNManzlQ6KU54SDOXAWnlcahHrKNiTHLq+CIoqTHmsnxJlnI31yuZfZ3Zoz/+3uFxToOa9hVcA8BhArzubnYzTiUFuEDsGVJpXUguHYkaTyIDmXbs4SgtTImgjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5Aq20Um; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5614C4CEEF;
	Fri,  2 May 2025 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746188996;
	bh=DGcYu+3DqZNwUOU60M33ZGmzLjkivOhGbY2ClBN8f/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A5Aq20UmZw/n8JuSJthdNPcL2VufHRnX86P9N5/lDJDQ1Nl3rYcA59uYY/tHf7Eqy
	 20yeBrxIabqqt93vElvDVvAyQqY2N8wWbX79hyCq3b9e4N4zjzMy3/byNpHlAL5yAh
	 DQpMs3dacjTe84NqvpFxzc8NxHhycI5HaqJVDtMWKS1N/sy1JScmUWxCCZuxrBRpps
	 DlT2947AWIfX/T6O1edUogJ4erzQ2TyPagA/1ITxwpg/XR/CsmxdK26jGoi/IozjK0
	 1CpV15GX7WDp3Yu8vk9AHPsAH7cRgry4JOTIw+o07lj+rQeZY4PE+9Dyh9jSJuMae0
	 3mYLlaeqq09VA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 02 May 2025 14:29:27 +0200
Subject: [PATCH net-next 7/7] selftests: mptcp: add chk_sublfow in diag.sh
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-net-next-mptcp-sft-inc-cover-v1-7-68eec95898fb@kernel.org>
References: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
In-Reply-To: <20250502-net-next-mptcp-sft-inc-cover-v1-0-68eec95898fb@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Gang Yan <yangang@kylinos.cn>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1984; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=JQOWlruNPp9QEkq2WeaRRQQFmYLUfEbcF8gyDviCmTk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJEdq2Naprr8HbH2oIpBw1DDmc9O66+ZMbL2eW/Sxarx
 gi4XdFO7ChlYRDjYpAVU2SRbovMn/m8irfEy88CZg4rE8gQBi5OAZjIknqGv2KBIuqsYbM0713X
 SJbXXm3n7VzL17fv+tTJn/mv3Yk9fYSR4X4Qg6TNhiwRyXtMXcYbb8xYXnR256/ZaZP4e3mEjWZ
 t4wEA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Gang Yan <yangang@kylinos.cn>

This patch aims to add chk_dump_subflow in diag.sh. The subflow's
info can be obtained through "ss -tin", then use the 'mptcp_diag'
to verify the token in subflow_info.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/524
Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index e7a75341f0f32304ff4e58c9b2500d405124dc74..7a3cb4c09e450f0ae570015c4724ec268c6dc19f 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -225,6 +225,37 @@ chk_dump_one()
 	fi
 }
 
+chk_dump_subflow()
+{
+	local inet_diag_token
+	local subflow_line
+	local ss_output
+	local ss_token
+	local msg
+
+	ss_output=$(ss -tniN $ns)
+
+	subflow_line=$(echo "$ss_output" | \
+		       grep -m1 -Eo '[0-9.]+:[0-9].+ +[0-9.]+:[0-9.]+')
+
+	ss_token=$(echo "$ss_output" | grep -m1 -Eo 'token:[^ ]+')
+
+	inet_diag_token=$(ip netns exec $ns ./mptcp_diag -s "$subflow_line" | \
+			  grep -Eo 'token:[^ ]+')
+
+	msg="....chk dump_subflow"
+
+	mptcp_lib_print_title "$msg"
+	if [ -n "$ss_token" ] && [ "$ss_token" = "$inet_diag_token" ]; then
+		mptcp_lib_pr_ok
+		mptcp_lib_result_pass "${msg}"
+	else
+		mptcp_lib_pr_fail "expected $ss_token found $inet_diag_token"
+		mptcp_lib_result_fail "${msg}"
+		ret=${KSFT_FAIL}
+	fi
+}
+
 msk_info_get_value()
 {
 	local port="${1}"
@@ -316,6 +347,7 @@ chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2
 chk_msk_cestab 2
 chk_dump_one
+chk_dump_subflow
 flush_pids
 
 chk_msk_inuse 0 "2->0"

-- 
2.48.1


