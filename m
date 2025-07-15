Return-Path: <linux-kselftest+bounces-37376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8725B06632
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 20:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B0956748C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939052BEC42;
	Tue, 15 Jul 2025 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9xDQptl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF1B2BE644;
	Tue, 15 Jul 2025 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605028; cv=none; b=jCiDKVOC1f3D+RQP9jjDGAefSYyu++cr/+wpjm6Ra3irIwHqefHrpbVyS8u9HnGxT1DWhMsviTP895XQB3XIeHlEye6RczstRycmWf1Nlg/t1APne2y2muaaDYjj0Ub81NXd2U0CW4AhahDFYHWxGFeFuDfivikt67hF1F06aes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605028; c=relaxed/simple;
	bh=4xuV//Yw8N8IriUHaqCqs3ZkGyGudb2qnXCVaEqiGlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EhPRXsCuVxLj8o9pqfx8TgeDjNVNQRWbnacpWfGhMxQ1K20l7pz7uQD4CR5Ypu6xF+lTUIhoFEy/MrFn5oqoO0+MjhkiizlS+2YI1tfkN7w+fy5dDej4l4DqpNo6iZOk4dGPtKqZwtw/37pJS4h3gRqn5R88FNLKXUmPyW1PPo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9xDQptl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9777C4CEF8;
	Tue, 15 Jul 2025 18:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605027;
	bh=4xuV//Yw8N8IriUHaqCqs3ZkGyGudb2qnXCVaEqiGlE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s9xDQptlV5hi3Ug+OYKBvyU36EfoaVP0KczkaXteUd+ObXGQbW0hbauZnboVufCzK
	 y6wkWsy5cNsNt6eGYCujfL4eU5w22lpSbrDfKP3pIj/9mbvXEkSMIkt/sZspCQGa60
	 2yIE+XmMwKssWt5XRIzzcHvxiX4RmwjfkRweu1jt79gM9/hZPvytz2euoIWoBgIbkN
	 97cM9pXBCNGEgurhkqfxCiSLjBYgSski5v2GWBbZOIzp4GxItxblfxCYOmo7ECPzIS
	 0DuQbWqcO2uSQhYyyjMJ4FIUNO8tLVCBsPPgo5yZfOmR6dqLEgs/5KwlbywXS1bFLU
	 XLXT5tAVw7MZw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Jul 2025 20:43:28 +0200
Subject: [PATCH net v2 1/2] selftests: mptcp: connect: also cover alt modes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-net-mptcp-sft-connect-alt-v2-1-8230ddd82454@kernel.org>
References: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
In-Reply-To: <20250715-net-mptcp-sft-connect-alt-v2-0-8230ddd82454@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@openai.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2981; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=4xuV//Yw8N8IriUHaqCqs3ZkGyGudb2qnXCVaEqiGlE=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGh2oVugMaWmErWbSCvcCyozlz/tMN8MAFj6/Mgd5V7RIK442
 Yh1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmh2oVsACgkQfCLwwvNHCpd1+AEAqE9n
 tFif75S+l+KTfAFU7//prn8IkWJ50x3nLUI5K/UBAK/nC+6vtSdsrJyck/lvkHigSgfWBJpWoGZ
 Pg9RAiAEI
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The "mmap" and "sendfile" alternate modes for mptcp_connect.sh/.c are
available from the beginning, but only tested when mptcp_connect.sh is
manually launched with "-m mmap" or "-m sendfile", not via the
kselftests helpers.

The MPTCP CI was manually running "mptcp_connect.sh -m mmap", but not
"-m sendfile". Plus other CIs, especially the ones validating the stable
releases, were not validating these alternate modes.

To make sure these modes are validated by these CIs, add two new test
programs executing mptcp_connect.sh with the alternate modes.

Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
 - v2: force using a different prefix in the subtests to avoid having
       the same test names in all mptcp_connect*.sh selftests.
---
 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index e47788bfa671313f21d5ba95821121cdc3e5d2c7..c6b030babba8cf888101d6af44f3e56fe5ab831b 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -4,7 +4,8 @@ top_srcdir = ../../../../..
 
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
-TEST_PROGS := mptcp_connect.sh pm_netlink.sh mptcp_join.sh diag.sh \
+TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
+	      pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
new file mode 100755
index 0000000000000000000000000000000000000000..5dd30f9394af6a88b14936a64c50ac9566be2e6e
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
new file mode 100755
index 0000000000000000000000000000000000000000..1d16fb1cc9bb6d1f88a9fdc11206237ca2b790bb
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"

-- 
2.48.1


