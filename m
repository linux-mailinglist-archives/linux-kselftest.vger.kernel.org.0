Return-Path: <linux-kselftest+bounces-37377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C65B06633
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD7050401E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 18:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97C22BFC7F;
	Tue, 15 Jul 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POFu4SQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D212BE640;
	Tue, 15 Jul 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605031; cv=none; b=J0PVbvFRXs4lDZj5+FBs2WdKknmTv1mHifiN086J3Sho51a+m0U+REj4QZDNiYLR3K8KO7Q1xs+59M43gkDAIkYjswVCQ4Rp/suO6QdrJzkJ5oMzefs8iqy2hzM3hCDmpmmZptcUFCk7HtlEdLhlhHKqd8RVFCHxCTXdsXov3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605031; c=relaxed/simple;
	bh=bYWiZR1eTZ8EGDhusWSCdTYKC+ZSADShQnvxVOLvoMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbGqVJPChBWbRlv8T3JF4Z8/V6YXK5Uzm5m4RcChxjuWbz+3SVqkZWa6ECj83mPWUw/Tv21Fs0YeG+ii/kkEqhkhd6OadXa0svklgMAT46poIJwMO89FwDtNYWQJuCRNx+O6QpI/3ondXykQiOfJEj7ovAu/Lt8QpodqLTo6CDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POFu4SQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46300C4CEE3;
	Tue, 15 Jul 2025 18:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752605031;
	bh=bYWiZR1eTZ8EGDhusWSCdTYKC+ZSADShQnvxVOLvoMM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=POFu4SQ6CGPu2l3zuP3ifTTaMGCKRSZXdUv1uR12tFA2aw6ip5F4BHt0TAvc8yf09
	 GDy7f+hKgIAzGwP6tOqWGcKsugXXybIeHLfZ85plsG0+7jNZ2VnWLWME/YIFxnqAdy
	 Hq4r8JBKH6NguM3hXUXBUMrogM+FjDo5hErmAU4kIO+y3ey3bekEFo8T2JNqxVjWxm
	 9dvqjcCHVdyY8va8xFhw3eZ3gVrlcdR6xmRzIG7b+xgDokupEGNMerdGBtMFmiI/Nz
	 zWZRCZz0qzbRHsWdTsPUpkkuFFBULg0LX2X2+moWamveVSmGbcka3nhvaDw0Q/gNvg
	 JJWe0nRv83diw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 15 Jul 2025 20:43:29 +0200
Subject: [PATCH net v2 2/2] selftests: mptcp: connect: also cover checksum
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-net-mptcp-sft-connect-alt-v2-2-8230ddd82454@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2174; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=bYWiZR1eTZ8EGDhusWSCdTYKC+ZSADShQnvxVOLvoMM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLKFsa06FzyF8+Z5v3qu8br4ytDilJmH4zcse5i374gD
 u7oOKUjHaUsDGJcDLJiiizSbZH5M59X8ZZ4+VnAzGFlAhnCwMUpABPp92RkmFG6jbXuZVf11sju
 b/FRIrkBc3cxX9rH1yvzumfhw7Xukgz/s1ff2SO5xDG6p2Lhtwwmh0K2jFlqnZdyvmo92vZ9l8E
 DbgA=
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
Notes:
 - v2: force using a different prefix in the subtests to avoid having
       the same test names in all mptcp_connect*.sh selftests.
---
 tools/testing/selftests/net/mptcp/Makefile                  | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..ce93ec2f107fba2a699387188932a2680bc9ded7
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
@@ -0,0 +1,5 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -C "${@}"

-- 
2.48.1


