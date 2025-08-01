Return-Path: <linux-kselftest+bounces-38186-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D2B1873D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93460AA09C0
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA2618DB01;
	Fri,  1 Aug 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks4sIqxz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BE78F26;
	Fri,  1 Aug 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754072202; cv=none; b=o0vEh1WswzqNBw85d03jNo03zMKYNqiakb8Q57ZD8xONnQZ4VXiqUtPsgW61vTHMlI5z/td0S4YAWn0h0fWrwcaS/XjhiavgK7A3u/kRhg7O6yW06tbUJeh+Z5GH7jqO+Ja7m5E9KgqMFpeMj04ObU9+lVldI+kFmtmEPMtQNds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754072202; c=relaxed/simple;
	bh=0IrsNJBAVrfvJy8OMpogVu+ndt+mu5rYr34n8P4lqHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ld/SZzOZxMtFjHjXzQDNNU/hO7wTRIXszYL2faECYhmwpm1fQ18Ii0nu5GN9jhcdr+OjoNexLyENkOro/tihDZRohsA1vLneMYDdYTIMCma13XRUjoJXTXM+/7cAh5J6YRcqSVuDcq8vYnCsSGS+OcH5d6KchUn/fJmHpBvdZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks4sIqxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6561DC4CEE7;
	Fri,  1 Aug 2025 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754072201;
	bh=0IrsNJBAVrfvJy8OMpogVu+ndt+mu5rYr34n8P4lqHY=;
	h=From:To:Cc:Subject:Date:From;
	b=ks4sIqxzchENMhb70XAXn7QVWcywSqX61sQTyTlrUrVKF6E3sgQEQctrrdGb2Hxq1
	 51n0fY3yuRMRDCdJ0EuWwMKWhNNsyUzcVtkTezA3OVlDRBBwwgAR8noQ3mgmDFQQJ6
	 ENVKnLKJdz8SmGws0Uf97+M6CY7eM86fQRi2YiCIqfRQu/21NXIoIaVpLcMjndhfXa
	 WvEBIhQ7hqThDpz2rhwPOpVaonJVgYPePoLq8Aj9y6k/+1P5hYiTC0ajLHvdrsJ0GT
	 0B1Oxn61zoe8FtVpgLht+jVvYjmd05Hpbgk483/M/OzG8yYQJorr8xiJjfFQLraQPV
	 4ba0hHdSyvEiQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	willemb@google.com,
	matttbe@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: packetdrill: xfail all problems on slow machines
Date: Fri,  1 Aug 2025 11:16:38 -0700
Message-ID: <20250801181638.2483531-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We keep seeing flakes on packetdrill on debug kernels, while
non-debug kernels are stable, not a single flake in 200 runs.
Time to give up, debug kernels appear to suffer from 10msec
latency spikes and any timing-sensitive test is bound to flake.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: matttbe@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../selftests/net/packetdrill/ksft_runner.sh  | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index c5b01e1bd4c7..a7e790af38ff 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -35,24 +35,7 @@ failfunc=ktap_test_fail
 
 if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 	optargs+=('--tolerance_usecs=14000')
-
-	# xfail tests that are known flaky with dbg config, not fixable.
-	# still run them for coverage (and expect 100% pass without dbg).
-	declare -ar xfail_list=(
-		"tcp_blocking_blocking-connect.pkt"
-		"tcp_blocking_blocking-read.pkt"
-		"tcp_eor_no-coalesce-retrans.pkt"
-		"tcp_fast_recovery_prr-ss.*.pkt"
-		"tcp_sack_sack-route-refresh-ip-tos.pkt"
-		"tcp_slow_start_slow-start-after-win-update.pkt"
-		"tcp_timestamping.*.pkt"
-		"tcp_user_timeout_user-timeout-probe.pkt"
-		"tcp_zerocopy_cl.*.pkt"
-		"tcp_zerocopy_epoll_.*.pkt"
-		"tcp_tcp_info_tcp-info-.*-limited.pkt"
-	)
-	readonly xfail_regex="^($(printf '%s|' "${xfail_list[@]}"))$"
-	[[ "$script" =~ ${xfail_regex} ]] && failfunc=ktap_test_xfail
+	failfunc=ktap_test_xfail
 fi
 
 ktap_print_header
-- 
2.50.1


