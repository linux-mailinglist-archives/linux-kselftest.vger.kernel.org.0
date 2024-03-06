Return-Path: <linux-kselftest+bounces-5985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C898732E4
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033CB285231
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF0604C7;
	Wed,  6 Mar 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkxsB5WF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99669604C1;
	Wed,  6 Mar 2024 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709718207; cv=none; b=pi8SEixGd7DYL77XIc1Oi6J6g4kxrRpXwm3TVX/aYa6fKsbFUsbHxFGNLnRjszBkieE/CG0UOp43bAJjIWeOBwK2NmqJA8GjzTLwT2Ntu6KB4J9Xakoi2E5UX9TiSGM0KJssSS67wD9u0zwX6PtvFzOb9rfnD1HoLoZ+k7RfeAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709718207; c=relaxed/simple;
	bh=nj5zy96gmKnlenBRjur2RORmXzndyrMua5IHgdDEcu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6+MwBte/hirZhYD5xAa7z9MeAChNTCsvCOmrgdMLgDHIEZ6DDNKI7Twclb9TbHOEF3poJGMWzqAQvdhyLZKFEDb2+6tiHO4hyLGPd6SfL5EbMlw/2iAV5TzKUKzwraOX30qnPJWjhaievb+VLAzh1+OpnIG557l/As3epB6HP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkxsB5WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0A2C43609;
	Wed,  6 Mar 2024 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709718207;
	bh=nj5zy96gmKnlenBRjur2RORmXzndyrMua5IHgdDEcu8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VkxsB5WFTnE8Dup6MvZLQsWp9sBoKdEg+cj28xY45LMjo4goxNNsmeF+O7/33R1//
	 IQPk0jzr6k8Pt3ilgyOaqsoGxPwk3cqqKSW8/OuHRaGSnlrNR9milZGky+BF3DBbPs
	 IUtSsd73FvNonWDNf/di1e0opsAOw5lTzj93VYTEbCQ/hYhuyg979vwk6t2q9K/Ubw
	 DJDW60T+Vsz87a0XN4Sp2jghUDUQNtpBd/k4qoihlTS6V0pfKhBPGwsWDqM6PVVI7N
	 azDIoRWh+d6uXN42BRq3avQrzIRK8uy7y2TTx5N8V6jeVFe1bwY1gRdmhuOBuPYe0v
	 ZexvtV5YR6DTQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 06 Mar 2024 10:42:56 +0100
Subject: [PATCH net-next v2 07/12] selftests: mptcp: diag: fix shellcheck
 warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-7-bc79e6e5e6a0@kernel.org>
References: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
In-Reply-To: <20240306-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v2-0-bc79e6e5e6a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nj5zy96gmKnlenBRjur2RORmXzndyrMua5IHgdDEcu8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl6DqmJcTLu/CnAFaZOKjFAR+ru2XnR4ADW48jR
 1fOZfde30OJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeg6pgAKCRD2t4JPQmmg
 c5VeD/9lYKuu+03U34D5FVNcoHmYV0Gy8WzeQ4AFJGZBJNnUsMCprBWeIuJ7l1d+fS3/isiI5mW
 loTs+pL8DOlx9FzKWqDD73T+rAcZY5gnzBxTty1e//c3mPWz/VimBxjCHNdHCN8jHF1kiYj3k4Z
 3lhxJRaoJv8FfggTrp24XAEmBgfZSYcEvPJCrqt/uIzO1pOzjcwHqL3PKScNLHXKg3Wx3/E7uCY
 hPKBV5+8I7MFsvdM9qUU9V3aKI3gDwY+MNG2XTekO2afVh5YGkVUOJbmZD9hxNFCnYQzakho1cP
 ZvJiIPd22rSsKeFfQbvEOiZkGVmIOnRQ0vLDLOxfgw2hrbpnrWr7AHlmB0JEsa5V0PT/GxQ/7V/
 xkroqBsTlmDvvyCAGuQ2BV2ijDYATXO6iy3C6hJRu7QqL0yT05AtIX6m71dlnfNlpcy0oLEsalx
 lGd5iZhimeEO+wIMAATQ37Aj08C6UTViD7H0oCsWnIv65tRG5gbnb/C3/FdEdwF7Ahuln5jkGuM
 /JCzpepQWjOYUcMY0+JUAsTZnerKSb5D635MR2wtmXzboDPQuHa8xQxPJ0tT6uZT80QKxRsu83/
 LpGdDqBfYuYv+Mnzr8TCOrzCMJFRjigG/w6D0fJkgePVxcqzuc/0WArlNTGs3lrc6bvhRyavAOA
 Fv1svB2XEFcNo2w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

shellcheck recently helped to prevent issues. It is then good to fix the
other harmless issues in order to spot "real" ones later.

Here, two categories of warnings are now ignored:

- SC2317: Command appears to be unreachable. The cleanup() function is
  invoked indirectly via the EXIT trap.

- SC2086: Double quote to prevent globbing and word splitting. This is
  recommended, but the current usage is correct and there is no need to
  do all these modifications to be compliant with this rule.

For the modifications:

  - SC2034: ksft_skip appears unused.
  - SC2046: Quote '$(get_msk_inuse)' to prevent word splitting.
  - SC2006: Use $(...) notation instead of legacy backticks `...`.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0ee93915bccb..d8f080f934ac 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -1,10 +1,14 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns=""
-ksft_skip=4
 test_cnt=1
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
@@ -24,6 +28,8 @@ flush_pids()
 	done
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
@@ -174,7 +180,7 @@ chk_msk_inuse()
 	expected=$((expected + listen_nr))
 
 	for _ in $(seq 10); do
-		if [ $(get_msk_inuse) -eq $expected ];then
+		if [ "$(get_msk_inuse)" -eq $expected ]; then
 			break
 		fi
 		sleep 0.1
@@ -260,7 +266,7 @@ chk_msk_inuse 0 "1->0"
 chk_msk_cestab 0 "1->0"
 
 NR_CLIENTS=100
-for I in `seq 1 $NR_CLIENTS`; do
+for I in $(seq 1 $NR_CLIENTS); do
 	echo "a" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \
@@ -269,7 +275,7 @@ for I in `seq 1 $NR_CLIENTS`; do
 done
 mptcp_lib_wait_local_port_listen $ns $((NR_CLIENTS + 10001))
 
-for I in `seq 1 $NR_CLIENTS`; do
+for I in $(seq 1 $NR_CLIENTS); do
 	echo "b" | \
 		timeout ${timeout_test} \
 			ip netns exec $ns \

-- 
2.43.0


