Return-Path: <linux-kselftest+bounces-37271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70CB044BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB53E7A6675
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7089625EF9C;
	Mon, 14 Jul 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqSC137k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E23E25E814;
	Mon, 14 Jul 2025 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752508374; cv=none; b=mytnBOjnIibB0JS0Y2Yc2mZPyi1yi0bC7skIrp51qteNuwu4fBB4xrlgV+T9Bky/JNXRjPHbrPpAQbZiipnTIal70hXcF0ss6IKMJrhXqvve+RAtHKr5hHxN4epsTUxkL3+lZTbnHo+B5Y3vB6pjeFfktUH68B8N6aBtNU8Xkjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752508374; c=relaxed/simple;
	bh=vRHppQdSz4rg5inxkVZW9mtmlObDuSVHllJt+T5+y00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7srGd0mcJ0Cv07deS7rLbI9T4p38hof7To1C6MVr8h4E7bEjywhSD+ayxoonO17XWLx/NN4/QW2CAvhhh37KF+RE8ah6SwvVYK2PBfKEWaJAG+1xKIL6kkoel+b8ax0WQzZfWA6Jy2ovS2Krx0HwzXAIdLFVsXAPjDpHFjqV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gqSC137k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C459BC4CEF5;
	Mon, 14 Jul 2025 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752508373;
	bh=vRHppQdSz4rg5inxkVZW9mtmlObDuSVHllJt+T5+y00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gqSC137kDgHeMztqLsQtCCx2hTkK/Fleom2gSSm7XvD2LuYTWIpB/Pk3+jND9gmWY
	 ILPrrUtbDnDem3SlZ4xgBVSV7kGFIdhjfoWs2GbgRZrhuHzXYQ4elQhvCqSygEkSIO
	 MKsc6EzgwG0A7+9g5Wa3Rh7KSKkc5jyX6ZyHrQWoVju7vPnrYZycrj1szmESoZXbmo
	 ucT7ufZH225AB+PRVNaj34XT2oSiaoJgEDsP9oUMujMFKE/wcfmk8wBdeMv8i67kh8
	 4XA0ixwYtLJC94A+ZHyDrc6y/n3aZ2VCCu8lhKqkhVazRJkwR/+nSinbzofegGPEPG
	 NZ4+A7gVFUP2Q==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 14 Jul 2025 17:52:32 +0200
Subject: [PATCH net 1/2] selftests: mptcp: connect: also cover alt modes
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-net-mptcp-sft-connect-alt-v1-1-bf1c5abbe575@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2731; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=vRHppQdSz4rg5inxkVZW9mtmlObDuSVHllJt+T5+y00=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJK1c++PXx0wrNbz799OTwv4PBMo7XODIb3WU6HV0pfT
 GI7575DqaOUhUGMi0FWTJFFui0yf+bzKt4SLz8LmDmsTCBDGLg4BWAicnUM/4N3PP7DGpZoELrt
 9c7DPAe/BmtycnzhXcWYvigk/11YpD7D/8qp1+wiPk7SXjRT8IexQMKyE8s696g2Zbewt1QJL9l
 Xyg0A
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
 tools/testing/selftests/net/mptcp/Makefile                  | 3 ++-
 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..09bde1303bf79198fe9f7890cbe89901859d78e8
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -m mmap "${@}"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
new file mode 100755
index 0000000000000000000000000000000000000000..c50d08481581f0f8997c6f4f2174d606150bfa6a
--- /dev/null
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+"$(dirname "${0}")/mptcp_connect.sh" -m sendfile "${@}"

-- 
2.48.1


