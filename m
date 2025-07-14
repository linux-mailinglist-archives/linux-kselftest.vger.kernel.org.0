Return-Path: <linux-kselftest+bounces-37272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E7B044C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFCC11744EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87C25F973;
	Mon, 14 Jul 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq5hB+B3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0C25A655;
	Mon, 14 Jul 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508377; cv=none; b=qqKnjGO9JHH385OTY/8itobVRzdP5wGFSj9oI7EXThj34XfG7cmSySNpfzjVDjdHf0wOAnv86CLUgLR/bqbPdF6B9XEW43ZC0A02t1M1aibQPrGnIaNUuY8ejTqNZwySmLjBR3nQrxyfkucEWWN8Ici2q1Vw4hhfkDPFSpcBLIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508377; c=relaxed/simple;
	bh=aY7+lwqzjxq2+7DTmWOz7PzESoPsMgwuJgkQHk5+Jik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jm2URLi4kIe0V7Q22MVRwEfLAaVmgDUdXmn5KC17LDuBymjMQdfQcEiG02TJzLd+wZScOFVVbUEXUxW3wPWns74pvRZy1YkMWkc39FS7I+0reDWr/ftWpnBnINl0+n9PZYTPqNk7jd9AkwLt0NMV43/0TwUZlPl0elUY2QMEl3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq5hB+B3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275AAC4CEF0;
	Mon, 14 Jul 2025 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752508377;
	bh=aY7+lwqzjxq2+7DTmWOz7PzESoPsMgwuJgkQHk5+Jik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pq5hB+B30PSCHFfDR6z4xbk/uJNmrBJs3/fOCJ2YA7SZwWsy6w+MpN8tXki3WKep5
	 Yl5o8l+sPsqXK/nAgw9gPKeISUHzfQ2KHlRNGL0SP0Zg53TMvDGTsbC9ahynRaaa0V
	 ecFKdSAfjE3VnQnuqkatlI9FERV11avUs+pq/0blzoKqku+2V7lDy3sWFGhUbi2vn7
	 Qad1x7WaPp2SbUgHwwqeWQcq4QvGJ22Zoy+7vuU9Xn3z7zMUg7B0de3eKeFSp7OB8V
	 ysmQYSKCB87v7NF7Ms1jaTqA5JdzPviDseq7mfZpmwSI5RNgpz+6OurTXuJ4oSeJ3Z
	 uQVROr6Jk3Meg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Jul 2025 17:52:33 +0200
Subject: [PATCH net 2/2] selftests: mptcp: connect: also cover checksum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-net-mptcp-sft-connect-alt-v1-2-bf1c5abbe575@kernel.org>
References: <20250714-net-mptcp-sft-connect-alt-v1-0-bf1c5abbe575@kernel.org>
In-Reply-To: <20250714-net-mptcp-sft-connect-alt-v1-0-bf1c5abbe575@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Christoph Paasch <cpaasch@apple.com>, 
 Davide Caratti <dcaratti@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1975; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=aY7+lwqzjxq2+7DTmWOz7PzESoPsMgwuJgkQHk5+Jik=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJK1c89+nb1W1HlnAdvFTZ+ELooJhsy54n/tAM3Z08Xs
 Io24OHd11HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRtN+MDDtePNK7sLCcz+BA
 5xTGL+/2dcZ4zWKv0mT8Gf5sBcdhS3dGhiNezdeMgj/krKp7/qZQfbbg8p++/vveuDVH615UDkh
 6wQUA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The checksum mode has been added a while ago, but it is only validated
when manually launching mptcp_connect.sh with "-C".

The different CIs were then not validating these MPTCP Connect tests
with checksum enabled. To make sure they do, add a new test program
executing mptcp_connect.sh with the checksum mode.

Fixes: 94d66ba1d8e4 ("selftests: mptcp: enable checksum in mptcp_connect.sh")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/Makefile                  | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/Makefile b/tools/testing/selftests/net/mptcp/Makefile
index c6b030babba8cf888101d6af44f3e56fe5ab831b..4c7e51336ab25c662f02719f1632fa2d27d148f1 100644
--- a/tools/testing/selftests/net/mptcp/Makefile
+++ b/tools/testing/selftests/net/mptcp/Makefile
@@ -5,7 +5,7 @@ top_srcdir = ../../../../..
 CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INCLUDES)
 
 TEST_PROGS := mptcp_connect.sh mptcp_connect_mmap.sh mptcp_connect_sendfile.sh \
-	      pm_netlink.sh mptcp_join.sh diag.sh \
+	      mptcp_connect_checksum.sh pm_netlink.sh mptcp_join.sh diag.sh \
 	      simult_flows.sh mptcp_sockopt.sh userspace_pm.sh
 
 TEST_GEN_FILES = mptcp_connect pm_nl_ctl mptcp_sockopt mptcp_inq mptcp_diag
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
new file mode 100755
index 0000000000000000000000000000000000000000..569340d4f00ae2e4655b30220bcfce695549a686
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"

-- 
2.48.1


