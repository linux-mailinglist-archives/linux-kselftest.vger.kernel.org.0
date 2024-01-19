Return-Path: <linux-kselftest+bounces-3247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0E832C29
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 16:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF441C2120F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 15:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061F5467F;
	Fri, 19 Jan 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7xIpVQf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B35466A;
	Fri, 19 Jan 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677171; cv=none; b=mkth1sxLXlVIr2+vwwUPMAK+6qpyZrNqrDUJWvBa5iBGBxZ1Dt37gAce9wVIOVW1+g0oiK5js/ImY8PPCbfyRlk7gFKlYR1n+U92EqRlcbS0rp5JG7VTAF2OqGO7JDRO3ADP4HV08Bb6WIW0XyhBsK1B099SzK1dHQeQipfsLlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677171; c=relaxed/simple;
	bh=zcH/nD7seF4AIzh6DZNUoYo/x9uPNtXIux7unOs7EAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KK3StvT157yvUKotOJQO4PiMQEvqYDoclwfD5zMDaV/hC9qLN7d8gz4PYF5Lroit5w8i0swJYTt+ioui1l0y0hsn1Tr81DPmqg7LXvuL+YnEbs81Vu8txRJ0bPXEOsSjgB3DjuXJRwIDzuSyswWZpZ90NhzeUd4J2ibNiKdmpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7xIpVQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89D3C433F1;
	Fri, 19 Jan 2024 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705677171;
	bh=zcH/nD7seF4AIzh6DZNUoYo/x9uPNtXIux7unOs7EAY=;
	h=From:To:Cc:Subject:Date:From;
	b=g7xIpVQfEfWTmyJWFRNKJOTKkcXJ6arCiwOfWeC4UMta2VgwJ4dGfEYtckX1l2Vec
	 qU+wi3eTnQE7LTLAApEk713HsNv15lRy5nm2i4tcKXALQL1KNS7ra5PTnxTcuZXEJq
	 0TrlA24IbM8oJitvvulWU3yVqbjeA3SijtblT2dfuD8/CsE1LUulLBoJdbFu07WkzS
	 pfVMX6jNfUgvjDIOF+rzlwvFJTeOGURWV2/JE8G73Bd2xBbIZPPn1thquffSIhYKm0
	 fzw7DslNL17dsiYy9X5MSWYqtoha4LS80R4a/V0praH4WqWpq3Og1+AAc7NQRI9vrd
	 evP8/vvJicmFw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: fix rps_default_mask with >32 CPUs
Date: Fri, 19 Jan 2024 07:12:48 -0800
Message-ID: <20240119151248.3476897-1-kuba@kernel.org>
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
CC: shuah@kernel.org
CC: horms@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/rps_default_mask.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/net/rps_default_mask.sh b/tools/testing/selftests/net/rps_default_mask.sh
index a26c5624429f..f8e786e220b6 100755
--- a/tools/testing/selftests/net/rps_default_mask.sh
+++ b/tools/testing/selftests/net/rps_default_mask.sh
@@ -33,6 +33,10 @@ chk_rps() {
 
 	rps_mask=$($cmd /sys/class/net/$dev_name/queues/rx-0/rps_cpus)
 	printf "%-60s" "$msg"
+
+	# In case there is more than 32 CPUs we need to remove commas from masks
+	rps_mask=${rps_mask/,}
+	expected_rps_mask=${expected_rps_mask/,}
 	if [ $rps_mask -eq $expected_rps_mask ]; then
 		echo "[ ok ]"
 	else
-- 
2.43.0


