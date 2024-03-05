Return-Path: <linux-kselftest+bounces-5917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF88871C37
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 11:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9B22857EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Mar 2024 10:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472C629EE;
	Tue,  5 Mar 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCwGM0XE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABCA627FA;
	Tue,  5 Mar 2024 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635409; cv=none; b=dCX1RmAbdmcz1uFvCyXRV+/oVMo3MT8yf7da7Z9ne5ZKTYFPD1/bi2c7lGUa6CH9w3MVl7UVt4GXi5IvzsGOTMdlYbTQ4mdgnyGZNPBH6flkcAxkINNehaPHC0bkc+KnScaorxOvI3Z7xntYBWO+3WKh7tsNnn/aSpBpnkz3ZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635409; c=relaxed/simple;
	bh=QtfJT5E6kufllfcFPKcwgPK1Il9pci90VCMQW43RTRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MpdvxPE32xLD1x1CH4+LQBe+Xk+sDlCXIq62jy1Ifvgpv07l538Cw93UIp4pVA5IwTMqvrbtGQPeSCCBxqtQB/pdc1B3z7U0rQkAMc3wvUrBdPApqh8gq+9gd41wAWCCdrAvJZndd1XWopghi+FmCFa5N2/JL8RpddzD00TTXuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZCwGM0XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E372C433A6;
	Tue,  5 Mar 2024 10:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635408;
	bh=QtfJT5E6kufllfcFPKcwgPK1Il9pci90VCMQW43RTRo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZCwGM0XEt6P62ijtQFD8qpzWeflGR/wBtGc5n2PgR4pYkpO7vjPambe44QKg5bDmE
	 0dyeDR/65PiMgWBPoG5f5fq0heVKmJ/QYLuB1+Cnr7SgQfEa1MabbfKOWvtZQLW4Nb
	 pYssD51obEpexmryr0xBUcA0CctHkl6gzxvXIKphPhDzb4Jz/jrVUp0q81jr2vO1g0
	 d4s8GGmOIieMwvbmUWQo51AIuOBXkWdyRMPcOzhmqW+plJ4Sad23/Px/cKftOYYtXn
	 5tp2vXbE0af4qu1j1boRpzOXKjMALNfHG+F7Il932Pwn20z8Mtucq04RQiJ3t8riVh
	 5qhZuCckbmfmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 05 Mar 2024 11:42:42 +0100
Subject: [PATCH net-next 12/13] selftests: mptcp: simult flows: fix
 shellcheck warnings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-12-66618ea5504e@kernel.org>
References: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
In-Reply-To: <20240305-upstream-net-next-20240304-selftests-mptcp-shared-code-shellcheck-v1-0-66618ea5504e@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2107; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QtfJT5E6kufllfcFPKcwgPK1Il9pci90VCMQW43RTRo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl5vcdd5How8Yc22x+ON6/6wV9gS4fvwjKhJb8w
 b4wUPFNineJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeb3HQAKCRD2t4JPQmmg
 c2X6EACgvvfo2GzCA1eyXyCLnYa2KLuKWCUIe9KChl3U5IBG+sTXrOhaGYmVOs/YyuPeHK9KPtT
 Iv8sE0cOpWJluKhyYIlAq/aXSm6BDgY1rjUZdGsgQEeIleCPN95yY5/6ZSHDXH3eMDuEfp16sbM
 oS6imX2b6zrlQG1ZGKfewzp4JTfJVDm7vZluuzmZzJJeBtPEhs3UAe8Lu+IMAsrgZvP+9I5YxB3
 PTCBTZU8CCiGSltb1nXtN6VB08f6lh9g/iapSKeLobBWLfBu/mtAZzl7NkGiCJqFMKPmdNpgIo6
 z6PK0S+PK2oN5paChr2/Lk7RoTxgpvxqar3m8OBITWjlBqNQeR0GYK5ETw1JtPLnj3sCCfgucEB
 qBNag5JZz4/1inIhYSkq9q+WsI3TWe67FvtiYRAwH6tA3QXSS8FTTernqB6KsIaHWEG8FiN4pKS
 v6KI61DeV6ciPxPeiwkoanBpk7FJzbdJMP791CEXKAlOQ9TJrEp65UV43/82uxc6HJN1lK4H01A
 yxty8P9sKLB1oBs+zKnR5bLN00k1AupwOA6r7a1m+VqkI4aY80+nvWdiXoc2n+twTpcYxXSEuNx
 pF4GoOu+iWTbXxYEfZaw0m8393AADgbdrEaVEcx81bn2d/MPWO+HHY8lPnyGuCj8//j8ly78jVT
 J5Ahl5qupPIEr6A==
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
  - SC2004: $/${} is unnecessary on arithmetic variables.

Now this script is shellcheck (0.9.0) compliant. We can easily spot new
issues.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 5a4b83cdaaa9..365fb3d6ef55 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -1,13 +1,17 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Double quotes to prevent globbing and word splitting is recommended in new
+# code but we accept it, especially because there were too many before having
+# address all other issues detected by shellcheck.
+#shellcheck disable=SC2086
+
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 ns1=""
 ns2=""
 ns3=""
 capture=false
-ksft_skip=4
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 test_cnt=1
@@ -28,6 +32,8 @@ usage() {
 	echo -e "\t-d: debug this script"
 }
 
+# This function is used in the cleanup trap
+#shellcheck disable=SC2317
 cleanup()
 {
 	rm -f "$cout" "$sout"
@@ -120,7 +126,7 @@ do_transfer()
 	local sin=$2
 	local max_time=$3
 	local port
-	port=$((10000+$test_cnt))
+	port=$((10000+test_cnt))
 	test_cnt=$((test_cnt+1))
 
 	:> "$cout"

-- 
2.43.0


