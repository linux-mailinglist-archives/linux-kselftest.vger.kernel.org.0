Return-Path: <linux-kselftest+bounces-36984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E96B005C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 16:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A921D1C44C9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 14:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78BF2727FC;
	Thu, 10 Jul 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4ROJ0yr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DE1B78F3;
	Thu, 10 Jul 2025 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752159202; cv=none; b=tRNRb8qpvNDzA5FDc3sAU4TWBT+T2QwCP/HWaxIHndixWhQ7TjJDr5zK65gCZjYMnlnEZJWD6+/q49Hn8+GUCAYARMapwutyfBa7/MHomyRu9+z3xugV6U/DpPb8UkhsVhdJ6hKsY/yeZ7NwaQKhP9xazITDdDE3+g3G//ctshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752159202; c=relaxed/simple;
	bh=Hif74UCdp68+W3HbrOPlCa82jqpB1IB8Fc/3N9wWzUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A65U0doDoN+SehyJcd/M/AxCagEsBFYId1eKU99El8A2PAwedpFnAFxH7LUGETIkye2VdH1rXgD52A854SWvRHCBi5HNAjkEGrLXed7D5JCVZ4HFEDKsGBJBPAvKPiUooUN/T2uOalsTWOJdur126+SKT3T8UydVGWhPJ/5BmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4ROJ0yr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FBCC4CEE3;
	Thu, 10 Jul 2025 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752159202;
	bh=Hif74UCdp68+W3HbrOPlCa82jqpB1IB8Fc/3N9wWzUk=;
	h=From:To:Cc:Subject:Date:From;
	b=m4ROJ0yrD9onQj9YY6iSIhCORI+HhAwd4ZPL9mvMjtuiQrY8/qy5KNvNP3wnxhzcP
	 tPk86AZwKPR2aDUNpcsOm16lldyy0K65z/BaVK4xUbYUryjInN+lGwlT4uxRI9eFjd
	 L1ajF1PLpXjVNnp32zfFCpjCgE/aW8sT5gzjYRhz/LOPyp475VFs3Up3hD9Rhift7o
	 Pt87NlTuFpTgi1YfURb+vh34bv0WH7vGjQZ/QZTncQkcNe16YRS9d6CD4ZyJHs/bKY
	 7zTjlslb37Z0lnjUWpWqdHbqNK5Mbo9k+AKc2dUwBpQ1+PotcSFYf4/WfMr3MUgOR/
	 d5blkuzXiEytw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: rtnetlink: try double sleep to give WQ a chance
Date: Thu, 10 Jul 2025 07:53:12 -0700
Message-ID: <20250710145312.3361964-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rtnetlink test for preferred lifetime of an address is quite flaky.
Problems started around the 6.16 merge window in May. The test fails
with:

   FAIL: preferred_lft addresses remaining

and unlike most of our flakes this one fails on the "normal" kernel
builds, not the builds with kernel/configs/debug.config. I suspect
the flakes may be related to power saving, since the expirations
run from a "power efficient" workqueue. Adding a short sleep seems
to decrease the flakes by 8x but they still happen. With this
patch in place we get a flake every couple of weeks, not every
couple of days. Better ideas welcome..

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: liuhangbin@gmail.com
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/rtnetlink.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 2e8243a65b50..b9e1497ea27a 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -299,6 +299,11 @@ kci_test_addrlft()
 	done
 
 	sleep 5
+	# Schedule out for a bit, address GC runs from the power efficient WQ
+	# if the long sleep above has put the whole system into sleep state
+	# the WQ may have not had a chance to run.
+	sleep 0.1
+
 	run_cmd_grep_fail "10.23.11." ip addr show dev "$devdummy"
 	if [ $? -eq 0 ]; then
 		check_err 1
-- 
2.50.0


