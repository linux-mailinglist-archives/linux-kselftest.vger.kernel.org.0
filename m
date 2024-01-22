Return-Path: <linux-kselftest+bounces-3363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E283735C
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 20:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B078628C66B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDF53FE54;
	Mon, 22 Jan 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7N+Zg0U"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B43FE34;
	Mon, 22 Jan 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953499; cv=none; b=idt8yYh8Ig+RzjUZ+zDHdFGvug5uGtcvCkOmQTNsIm4QuhbI1n8/Q8n4RigTjWVN18JqCrCzo1JCwJBMgnSHXSUMFwYEN579FeElIKmie6xEKhbu9DgcjntizqRdXJgqBb37vEt5KpFlVFxJRQduNs6q3/Dxy6THuoI4QQ2V7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953499; c=relaxed/simple;
	bh=SvDANQnwOcPORJZ4jnQxUEiOmgexT1tNc0+JyPNkn/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZvNHoV/2ZVl8J1jmAM+F9m/9lHV1vplS2MuwBamHinJOKrcUIchHplSwWXRkrhSN3hd+itSzF5hGI+c9A383qDMZ08PhHUnRbdB6I8LcWd+XrzkoDZvmixsMGUr91dHYPW1YvEnSxcJ35qDRuDLsCfa2vrJ3akkwx0u6KqzsEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7N+Zg0U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44515C433F1;
	Mon, 22 Jan 2024 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705953498;
	bh=SvDANQnwOcPORJZ4jnQxUEiOmgexT1tNc0+JyPNkn/o=;
	h=From:To:Cc:Subject:Date:From;
	b=B7N+Zg0UcNLYD5fRN+kCvVjbq9Z3GPfJEIEw7e3CsoVKEUZnWSU+qSz/gfgeaMatw
	 aYMjh9ieUhO7BnyhUNBhEUzqrAD3HZZks/i3oMTQeJR9zwgjbId5BC2GCWTHDvJmog
	 fcSeWRbopCtVRu5H4JRrWWPeFbFxJXwcO04ylV3mkvP3Gmzsc17GLH9VaBSIIKR0bk
	 3PuYLIqAc06gFhWRKjYxtnfAQh4hORYPYzl4aCwLiXx/Zn+Wcvzzg8LLAQs/5EDJ7s
	 03YpLYPmCquBTpM0ICaeA+LCCsGD8/al7Z7Rpjh0pAL21rO5qKMEWWfT0LPFeWuuWF
	 A2YH+dLGhAS9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3] selftests: net: fix rps_default_mask with >32 CPUs
Date: Mon, 22 Jan 2024 11:58:15 -0800
Message-ID: <20240122195815.638997-1-kuba@kernel.org>
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
so that should be good enough. Switch to bash, Simon reports that
not all shells support this type of substitution.

Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - switch to bash
v2: https://lore.kernel.org/all/20240120210256.3864747-1-kuba@kernel.org/
 - remove all commas
v1: https://lore.kernel.org/all/20240119151248.3476897-1-kuba@kernel.org/

CC: shuah@kernel.org
CC: horms@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/rps_default_mask.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rps_default_mask.sh b/tools/testing/selftests/net/rps_default_mask.sh
index a26c5624429f..4287a8529890 100755
--- a/tools/testing/selftests/net/rps_default_mask.sh
+++ b/tools/testing/selftests/net/rps_default_mask.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
 readonly ksft_skip=4
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


