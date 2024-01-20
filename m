Return-Path: <linux-kselftest+bounces-3273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C74983361C
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 22:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865211C20B40
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jan 2024 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4213AC5;
	Sat, 20 Jan 2024 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSFzBlWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72E712E69;
	Sat, 20 Jan 2024 21:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784578; cv=none; b=o5JRX4qbgCvrhaKn/tkbfOn315yC835bHE6Er2Mvf1wfEiorjfI4+deADwPkLGScEt3n8ZJM9RrDpHWiERYj6OxeGaXGQPL8amnBH+YsIQ2FSwtEz1a/4+FK5+0xUi3zn2IXZ4D7FQ72c5y4TUXj6xRFL3ILQHr/q366ns2ZH7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784578; c=relaxed/simple;
	bh=HZtnZz22bhkVzmMrX6D1vPt0YV3W51QQwUV0W2e0gwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrTjT8KPqn/Hi7zXSiL/LQ1rE8vijFBznTqsyjtdh+ZTo0t3gVz10dV71mWNoEj1Exq5tvjagHIFk5gFzLIa+gaWm8iyVSHF6/NzohpCwv4/kJ7ZNsc43G02RGeUt7B3SRyh0pSnS5LEvI9Zpnu2LXu4gWZW3qMzIOlB5gi8evM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSFzBlWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1E4C433C7;
	Sat, 20 Jan 2024 21:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784578;
	bh=HZtnZz22bhkVzmMrX6D1vPt0YV3W51QQwUV0W2e0gwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=RSFzBlWD9XBuD/7s8l5l01rPwNJlpFoj9Gh22E+gVlJm/FqjI0MDJCGnCYOQRn3Fl
	 rbiw+nkAnsTfzlUVscnL+M8K7RL1GU5CgjUkrQXUtXmgzB5dTz75zAXyJDqSihqxNJ
	 KFSHoCP6HLvspaKLRHDWDtdMfY60LSKmtBNcu53+XFCEqLMbLvXY7k2JpK1QUS9dtV
	 lhdN14hYpKwCbfGi79z/cyaK1UIw4bqCuVSBKv+vSozTmOp+BIAb0OrZKoZJ0cn1Ge
	 ZaoiWjCRR7bI+pcfGhCjtSQsQxnsq4WUqxJ6fu5ahU0HOx06FbvdadVG50cn9IxWQF
	 SJTyDCv8ijIEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2] selftests: net: fix rps_default_mask with >32 CPUs
Date: Sat, 20 Jan 2024 13:02:56 -0800
Message-ID: <20240120210256.3864747-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is more than 32 cpus the bitmask will start to contain
commas, leading to:

./rps_default_mask.sh: line 36: [: 00000000,00000000: integer expression expected

Remove the commas, bash doesn't interpret leading zeroes as oct
so that should be good enough.

Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove all commas
v1: https://lore.kernel.org/all/20240119151248.3476897-1-kuba@kernel.org/

CC: shuah@kernel.org
CC: horms@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/rps_default_mask.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/rps_default_mask.sh b/tools/testing/selftests/net/rps_default_mask.sh
index a26c5624429f..4729e7026a73 100755
--- a/tools/testing/selftests/net/rps_default_mask.sh
+++ b/tools/testing/selftests/net/rps_default_mask.sh
@@ -33,6 +33,10 @@ chk_rps() {
 
 	rps_mask=$($cmd /sys/class/net/$dev_name/queues/rx-0/rps_cpus)
 	printf "%-60s" "$msg"
+
+	# In case there is more than 32 CPUs we need to remove commas from masks
+	rps_mask=${rps_mask//,}
+	expected_rps_mask=${expected_rps_mask//,}
 	if [ $rps_mask -eq $expected_rps_mask ]; then
 		echo "[ ok ]"
 	else
-- 
2.43.0


