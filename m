Return-Path: <linux-kselftest+bounces-34530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF46AD2AC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 02:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F1E918912D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 00:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A23119047C;
	Tue, 10 Jun 2025 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIRChqwG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC2412EBE7;
	Tue, 10 Jun 2025 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749513604; cv=none; b=fu730DPHVycddLE/joIh1bHSvxr5EnP1vhFAy2DF7Mn6cUI90tKNjbnAu4txxS4CAQQlkKYYwqmBHxn1dGmt/2nEsDIlCAd5gqaMalAejcB4UkgUySohz9SV5Ir/Fnd3Hm1t8WmMvb01jUOpCyCxWKly7qYnHk5B3Tl1DfIKxZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749513604; c=relaxed/simple;
	bh=2Dg9peVSh4pyIyoa+bHf8UIL1uvI3U4Fg9EzKdMtpAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNCRekNI4BnT4UZxjc15UCaPGOukjoduYaILDCvVPD/ZFUzqjJ5ZkTVgys+F45Cr3vJLpBywRAEvXfB2KewOlfDb3pIeR804OBlt5yPcwq4GwENYdrhhTP7U1CQXkbCK7MKXM8qEd6PrFq8txPgKCJhZOa2rAOA/QXIEsJfzYdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIRChqwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF54C4CEEB;
	Tue, 10 Jun 2025 00:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749513603;
	bh=2Dg9peVSh4pyIyoa+bHf8UIL1uvI3U4Fg9EzKdMtpAs=;
	h=From:To:Cc:Subject:Date:From;
	b=pIRChqwGS4AJ/PxjT2VL4e2DXkTitTkC5tQf1QPnPXy472SpPI+/HKEPm455Z1SEP
	 BbyMFLI2DKgz3H+nhlTzZa+ABZG8+NO3lo1HYMbZD3D8/qoR19Lp1QG2q8fvDY3mVU
	 vhpEKzDV9+J+m9uymoCQ3MV3/nXGEhl6/lsZBGCA3DQGHJNhbXOPguDvKC2chhhbQS
	 Uww0nq8RopRbX3u4rZRVbkNvh8pzTcD6X9B8xyTluue6i750MNOYx+FKkAkpEe2JhZ
	 oM+6foA/CX3r53KOnYhOjUK9hBzSpOoAhLUxdcoUofRSwlE67f/Oks1J7AXjbq0Asa
	 Q38NbzBOlhWdg==
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
Subject: [PATCH net-next] selftests/net: packetdrill: more xfail changes
Date: Mon,  9 Jun 2025 17:00:01 -0700
Message-ID: <20250610000001.1970934-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the packetdrill tests have not flaked once last week.
Add the few which did to the XFAIL list.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: willemb@google.com
CC: matttbe@kernel.org
CC: linux-kselftest@vger.kernel.org

Every time I sit down to add more I plan to just XFAIL all of packetdrill
on slow machines, but then I convince myself otherwise. One last time?
---
 tools/testing/selftests/net/packetdrill/ksft_runner.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/packetdrill/ksft_runner.sh b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
index ef8b25a606d8..c5b01e1bd4c7 100755
--- a/tools/testing/selftests/net/packetdrill/ksft_runner.sh
+++ b/tools/testing/selftests/net/packetdrill/ksft_runner.sh
@@ -39,11 +39,15 @@ if [[ -n "${KSFT_MACHINE_SLOW}" ]]; then
 	# xfail tests that are known flaky with dbg config, not fixable.
 	# still run them for coverage (and expect 100% pass without dbg).
 	declare -ar xfail_list=(
+		"tcp_blocking_blocking-connect.pkt"
+		"tcp_blocking_blocking-read.pkt"
 		"tcp_eor_no-coalesce-retrans.pkt"
 		"tcp_fast_recovery_prr-ss.*.pkt"
+		"tcp_sack_sack-route-refresh-ip-tos.pkt"
 		"tcp_slow_start_slow-start-after-win-update.pkt"
 		"tcp_timestamping.*.pkt"
 		"tcp_user_timeout_user-timeout-probe.pkt"
+		"tcp_zerocopy_cl.*.pkt"
 		"tcp_zerocopy_epoll_.*.pkt"
 		"tcp_tcp_info_tcp-info-.*-limited.pkt"
 	)
-- 
2.49.0


