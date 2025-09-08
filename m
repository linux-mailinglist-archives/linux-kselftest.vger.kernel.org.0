Return-Path: <linux-kselftest+bounces-40997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CB0B49BEC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 23:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5280F1BC6E28
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835D92E2851;
	Mon,  8 Sep 2025 21:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEab8R9/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E66621FF39;
	Mon,  8 Sep 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757366883; cv=none; b=UqqRaAPcGjtUzuFXzrtvgQjbA9y/23F3XDHsRaBsc9F3L8d033mUjFRkuwUVupVphjiJoOjP9n3n3wgiSeBZQNQq0JEu5U9n9JL1jzxg76WIYXZ/qKP2UzTud1oCtxtS0ijX9AV7diyvcv04wN+P+s/Xh+CdPJFnP1CVrzvnWWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757366883; c=relaxed/simple;
	bh=gDCZvvVNWEMCU3nT1uDyLwDLHgKoibMV4aiujAjJvhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJgElTdjlOZpJXpj4uwohBTJfEF0B56qVodRQUz+QKA23EO5MuwJs1bok0Oolj9GZp1j1c4Cw5ccg10TLH1lSLa87KJBdhyQT4PLigJfvh7Py4A7DmdQcCRqsD5AXds3Zl5NxjPtohg5tPYUHrYETNU6squt+NVDbEl033Hd7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEab8R9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3450C4CEF7;
	Mon,  8 Sep 2025 21:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757366882;
	bh=gDCZvvVNWEMCU3nT1uDyLwDLHgKoibMV4aiujAjJvhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UEab8R9/I2NlvC9GuptOXjwWyNik5bnCFfAaT+bUnuhIdp8hm8dbl9uEfbqbgtwOs
	 DUcb42pDgMcyyX9HOK5cwYHomGfx2vM1HDmVDhk+WGg4mKBCJoDheiAMk42G34YC8O
	 eGpIWySvhosZV/B41kL/bj8D8Gn2nK1cRE6ciIjN+u4kIlsROyOTS73gqBQ/IbZljZ
	 zxNt+qBgb3dQz+YXeI0mPwW4yIOfK10DNDDDQqgVTi9NVWswNEWSREJPOuX98l+CtO
	 g1oPRc7nlMOkd3oUtydwpR19nUsNy0eqhfcROTbLjLyP5AO98QTcxsLkEJlTsXmrHL
	 C+ptPjrmCfVfg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 08 Sep 2025 23:27:29 +0200
Subject: [PATCH net 3/3] selftests: mptcp: shellcheck: support v0.11.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-3-5f2168a66079@kernel.org>
References: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
In-Reply-To: <20250908-net-mptcp-misc-fixes-6-17-rc5-v1-0-5f2168a66079@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
 Davide Caratti <dcaratti@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4972; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=gDCZvvVNWEMCU3nT1uDyLwDLHgKoibMV4aiujAjJvhU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDL2e4Wc7vbjmbjuEffb+Geralk43bI4G44UyC9SZ5dYd
 GylNcuTjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgIl4nGb4xfw6bvuaFyxWMU7n
 omYfSjVc+7stxEl/336ZHY+v2lluPczw353N3qKedeqUGrW1fx2fz5sobSz7Py7066en9VsW5H6
 oZgAA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This v0.11.0 version introduces SC2329:

  Warn when (non-escaping) functions are never invoked.

Except that, similar to SC2317, ShellCheck is currently unable to figure
out functions that are invoked via trap, or indirectly, when calling
functions via variables. It is then needed to disable this new SC2329.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh          | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 2 +-
 tools/testing/selftests/net/mptcp/pm_netlink.sh    | 5 +++--
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 tools/testing/selftests/net/mptcp/userspace_pm.sh  | 2 +-
 7 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 7a3cb4c09e450f0ae570015c4724ec268c6dc19f..d847ff1737c30c0eae1cefeb5a83bd3223897707 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -28,7 +28,7 @@ flush_pids()
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGKILL &>/dev/null
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 5e3c56253274a1f938d2ed9986c4290fcea8b96b..c2ab9f7f0d2133559bb18ce884b613d21d1ec5f0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -134,7 +134,7 @@ ns4=""
 TEST_GROUP=""
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	rm -f "$cin_disconnect"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 82cae37d9c2026cc55466636d53a76f929a03452..7fd555b123b900c135bae5f61da30c21a3110eb3 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -8,7 +8,7 @@
 
 # ShellCheck incorrectly believes that most of the code here is unreachable
 # because it's invoked by variable name, see how the "tests" array is used
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 418a903c3a4d396bd733bf8b6f68b1447d4d1de3..f01989be6e9b3daeecc5a8f41b37c9a284efef61 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -95,7 +95,7 @@ init()
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index ac7ec6f9402376a34602ef1ca6c4822e8dde0ded..ec6a8758819194f2c53791d76ae68e088f188813 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -32,7 +32,7 @@ ns1=""
 err=$(mktemp)
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	rm -f "${err}"
@@ -70,8 +70,9 @@ format_endpoints() {
 	mptcp_lib_pm_nl_format_endpoints "${@}"
 }
 
+# This function is invoked indirectly
+#shellcheck disable=SC2317,SC2329
 get_endpoint() {
-	# shellcheck disable=SC2317 # invoked indirectly
 	mptcp_lib_pm_nl_get_endpoint "${ns1}" "${@}"
 }
 
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 2329c2f8519b7c336e9f90a705dfa7588207a543..1903e8e84a315175e2ffd620dd7b4e94dbf25dfb 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -35,7 +35,7 @@ usage() {
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	rm -f "$cout" "$sout"
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 333064b0b5ac03ae003417d2070f3c08f94743ed..970c329735ff14f87f0048ba0030dc7edaaa86bc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -94,7 +94,7 @@ test_fail()
 }
 
 # This function is used in the cleanup trap
-#shellcheck disable=SC2317
+#shellcheck disable=SC2317,SC2329
 cleanup()
 {
 	print_title "Cleanup"

-- 
2.51.0


