Return-Path: <linux-kselftest+bounces-11240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAF8FC7A2
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 11:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E4E2B28704
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420CD19146F;
	Wed,  5 Jun 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uniIUkQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D719007C;
	Wed,  5 Jun 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579314; cv=none; b=VghSyVBwiCw6KG7AMwllVeWB7PFH9Kd/YqTyk8nG8KpuUj7IN6xoqSaL6OLwCOLbytjzbQQXiVQazjK3bca7F6hKKba2t1nOY2/FtbRESitgMJVlCg1nGLm3SMIJKjzfdwT1o1S9FdsXx55aSMqf6hkv/GYVXi0pCvTK1mEAkyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579314; c=relaxed/simple;
	bh=enGOqa2B+5IPGqxwH+TThhdDQRn5ztIFxzAZ0zyx8GY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkPyjLPkbMjqRDr/hhRr6RILstyRWMIxfsbeAwvRRGAqiB8NGpcHjxy5tYr6yGidHzJjXzz64IlKaMXXZHWE/ikoDnFZGgjG6gJYntAUU98SnqCJcwsIDqdoz74Qbo9fyiQJFOlAh/YfaIHJZ5VBa9N+939Wg2TGCdTx5e9+B/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uniIUkQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A628CC3277B;
	Wed,  5 Jun 2024 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579313;
	bh=enGOqa2B+5IPGqxwH+TThhdDQRn5ztIFxzAZ0zyx8GY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uniIUkQ6GLS+bp+dB3bacO+S48J+9YpCBVW0sOBrHTxxPcLQ89xQalHlpg5qRX03K
	 Mmm5hfV+mYWOWxNI+f+oLbPGclIsHRzvsZp1ANVNVlpbFY1nVz4enMCekp3Bs1f0Sy
	 x8n/S8GmkS1x1csFubwno0rc3Rh+zFI2eT1P/NMCQ+oXAExcGQRIIFEPylynEn08f1
	 pEuIsyWfHHhL7zHKBE0kmYwZlmGn0tgWyBSvY0Dw7tPvxGisoASFv7Epmucvu4xSsn
	 M+OT/oBu/QOL78wN5uWrEtD4OYAbAeBh7zp7IGN04HvIvv9QMtXlTmkcfDTzTneJB0
	 zwaRsEs8cCLsg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 11:21:17 +0200
Subject: [PATCH net 2/3] selftests: net: lib: avoid error removing empty
 netns name
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2281; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=enGOqa2B+5IPGqxwH+TThhdDQRn5ztIFxzAZ0zyx8GY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYC4nGiVW/UASfgQkNfz8Pi5KnqQIsBRBaxK9z
 e7j+EROYMyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAuJwAKCRD2t4JPQmmg
 cx+MEACqQPHx7QRfc4oIT4HcCVSlHyo3LxSqv1sAD4887LfJmt9UWzyTVIiJunL3DB1CUGZxyus
 wDObaEWBokUg2Yny6Gupsxjh0RW7qvjkTEmX+WLToYb7uWwpsll78ilBDS+3m8DbgERFSgCmWti
 3Z5QqDmiFaloTgUP7Q71nxN/znbGiU5B6b/yue2IDdMWJWjpMBEKbXl4vtpbTCFf0brz6wJEjQ9
 lwEEx+q6z6XjMFr7oHGdH7cL+l7fUTN2nGfCsYjCX1ri9GIulZ8D4ial+OSyZcyyOAumhd14oyZ
 znG9ycG9rpx+tNRr/aq72m0UPTLdjprWLUxdqsD81z+aOEO0Ygtf8OS9vzyTL/DEcQqFIegyzZn
 WweEgz6O+kiTlHUOxjrcc9OiTXQaoCdKOLbdZgWZjyIHdpHh9NgggbJJk8Eh7E04Iy4wfSUlO2M
 d9sszu3f+fqLwsPN93f0nknFFzftjqCEetQ/q3QnJPGBPhidjrbbfvA3nPUAoXBrEinxCwNyb+O
 fR5UUn3IOhR8GgpJRdTIQA7BJ66ShLIW74kzI/ZyLsV1WxKZhFMkv16xnIDwbOX8RT4nBoiHCWW
 C6cU0wlwiiWgmQWTBklNvELv3N3skyQ2vSpAkPFSdUBsDgisFxNji/OIgYh+CzZyEcW5Flb/y/n
 Nz2pQjsY+x3QVVg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

If there is an error to create the first netns with 'setup_ns()',
'cleanup_ns()' will be called with an empty string as first parameter.

The consequences is that 'cleanup_ns()' will try to delete an invalid
netns, and wait 20 seconds if the netns list is empty.

Instead of just checking if the name is not empty, convert the string
separated by spaces to an array. Manipulating the array is cleaner, and
calling 'cleanup_ns()' with an empty array will be a no-op.

Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
Cc: stable@vger.kernel.org
Acked-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index a422e10d3d3a..e2f51102d7e1 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -15,7 +15,7 @@ ksft_xfail=2
 ksft_skip=4
 
 # namespace list created by setup_ns
-NS_LIST=""
+NS_LIST=()
 
 ##############################################################################
 # Helpers
@@ -137,6 +137,7 @@ cleanup_ns()
 	fi
 
 	for ns in "$@"; do
+		[ -z "${ns}" ] && continue
 		ip netns delete "${ns}" &> /dev/null
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
@@ -150,7 +151,7 @@ cleanup_ns()
 
 cleanup_all_ns()
 {
-	cleanup_ns $NS_LIST
+	cleanup_ns "${NS_LIST[@]}"
 }
 
 # setup netns with given names as prefix. e.g
@@ -159,7 +160,7 @@ setup_ns()
 {
 	local ns=""
 	local ns_name=""
-	local ns_list=""
+	local ns_list=()
 	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
@@ -175,13 +176,13 @@ setup_ns()
 
 		if ! ip netns add "$ns"; then
 			echo "Failed to create namespace $ns_name"
-			cleanup_ns "$ns_list"
+			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list="$ns_list $ns"
+		! $ns_exist && ns_list+=("$ns")
 	done
-	NS_LIST="$NS_LIST $ns_list"
+	NS_LIST+=("${ns_list[@]}")
 }
 
 tc_rule_stats_get()

-- 
2.43.0


