Return-Path: <linux-kselftest+bounces-6131-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8213A876CEC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF8B51F22845
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A782B657C7;
	Fri,  8 Mar 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fy8YAOpF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725CA657C4;
	Fri,  8 Mar 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935872; cv=none; b=idSxZAJiqW2GWiAG4llmlIW7wjvDj5+A354uaPNLqwB3sw/F2o76l74yfTXiUxZdFIIZR+jipsD1qLQrujgNlME6DAG0KQ7oQnAxTfgLEyqJz7Jl51wmTsysNatdQw04GDwi98VKkyDgNdwKo7yRvRHYj4ftmepuEFyMjwZQzFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935872; c=relaxed/simple;
	bh=qoHUiLkNsIx47I1kuK2C8KpRsVMntythSQv1v4fIqIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KfhUyhLknv/vMs+t7U6yB9kKSL0LzcjuO2dqZhD+5d4MElE9SSMQo+RjsXCR3rm8D8EIzNkPFJKSfbHUlshqZoWzoXajnAZKjpTodtF3CpSVvNpuK/9miSY8ag2aK2WZsSYCFHkDSyCRjBPEYkVnYd3jsCcLuXttcE8lrxa2VjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fy8YAOpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E146EC433F1;
	Fri,  8 Mar 2024 22:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935871;
	bh=qoHUiLkNsIx47I1kuK2C8KpRsVMntythSQv1v4fIqIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fy8YAOpFppiARung7CuASEVVtNjJClxY5s/BnIrI1ifgWd5lhi3rzVwj52gb2CJ8t
	 6YPIiDHZuyCByOi0JRwpvufqL1ax6Rltxb3INHXHZ2czsUzN1StWPs9q3xQvc9ZABm
	 +HDWj0sMNrCFD460FW50jZFMCp4kw9Jm+corE08ajFLOMR8e3x4KzswFys2njqC5Yf
	 54HqB8czQ6coA8HTGPHeuEEpY1oagrbXlaGP+L1HkOdxBE81d1kBXbo29Y6AIfcYRT
	 g6l9q45klhaYjjEJQyuuCGKAswQ2xIne0r6BZdA/KAxNrFM2/dnFKn4kUmj1RNFJ6v
	 ZNijpQmkRpoZw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:21 +0100
Subject: [PATCH net-next 14/15] selftests: mptcp: declare event macros in
 mptcp_lib
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-14-4f42c347b653@kernel.org>
References: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
In-Reply-To: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-0-4f42c347b653@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5514; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=CZSpCvGHHfieUfdGxngJ4O/ETYY90UBVLWZIKItSxzs=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJysgjwFRUD01v/+WgUciv4h+Zf/wWu+SPN
 0iroQDShyaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c6B2EAC8WLF3jebucBxcPTPikPb5Fvl5GMoT+pLWB5lez7p/qnk1RNKpmkVZbof3ljSB5TNjlZ8
 WW3YbUJzKT45u2lEGevrNXJtX5H4fpwMSKL+HaiDFDW+ZxaEfN7GwH5J8+nh2h8FBZFstkh64if
 I7AD2Eb8WDKkKEOX7erXdxXxCH/ngIYzXugX4BUyQJ8xA7YriSNCwfj3JuXC0l+N2J64IaWMd3f
 jWJJlfk/s5vuQkh5lTmBg6dt9pg9//Stld2Lu4ChaQgG9SA1dJxn+ziICeeJTbkBd1IlGezJUSQ
 Hx0yZT4r20s5bD9n8TIAl9tuUduvp7Lp7qfZZD0qkpmkSOVeMv3+H6NrLMsGbmO1eFZ6VVT7/Dr
 lR6fWjbpqghUyp6b2aAgLljjHwtg7UW6QhEP4u9pHoGRy4MIy1JGg6esZ944RvA+lM0Q/46FAmB
 UOrNasc11PO1mw9WTgAyzb6GKXpm490lFwg1EEt1kJwust4+zam7wkxemighDRor7rA4b1G8Unl
 GuGY1tYYXewTj39mLqXCX4RNzR83ghOPrNkZj6PoSsiVE8S+l+vQvhvml1J5OX2SeTm71kupdOL
 hSeMt8f8AQ0a5vCfJka5sIzit8TNVzJBfnF14BEMmxnriHkVnooGwa7Z4TwQtm/GBUP9fZGXM60
 UNLuVuxYNH00WCg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

MPTCP event macros (SUB_ESTABLISHED, LISTENER_CREATED, LISTENER_CLOSED),
and the protocol family macros (AF_INET, AF_INET6) are defined in both
mptcp_join.sh and userspace_pm.sh. In order not to duplicate code, this
patch declares them all in mptcp_lib.sh with MPTCP_LIB_ prefixs.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh   | 23 +++++++++--------------
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 11 +++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 16 ++++++++--------
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9b538a7071e7..728575fd86ea 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2785,13 +2785,6 @@ backup_tests()
 	fi
 }
 
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
-
-AF_INET=2
-AF_INET6=10
-
 verify_listener_events()
 {
 	local e_type=$2
@@ -2799,9 +2792,9 @@ verify_listener_events()
 	local e_sport=$5
 	local name
 
-	if [ $e_type = $LISTENER_CREATED ]; then
+	if [ $e_type = $MPTCP_LIB_EVENT_LISTENER_CREATED ]; then
 		name="LISTENER_CREATED"
-	elif [ $e_type = $LISTENER_CLOSED ]; then
+	elif [ $e_type = $MPTCP_LIB_EVENT_LISTENER_CLOSED ]; then
 		name="LISTENER_CLOSED "
 	else
 		name="$e_type"
@@ -2856,8 +2849,10 @@ add_addr_ports_tests()
 		chk_add_nr 1 1 1
 		chk_rm_nr 1 1 invert
 
-		verify_listener_events $evts_ns1 $LISTENER_CREATED $AF_INET 10.0.2.1 10100
-		verify_listener_events $evts_ns1 $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $MPTCP_LIB_EVENT_LISTENER_CREATED \
+				       $MPTCP_LIB_AF_INET 10.0.2.1 10100
+		verify_listener_events $evts_ns1 $MPTCP_LIB_EVENT_LISTENER_CLOSED \
+				       $MPTCP_LIB_AF_INET 10.0.2.1 10100
 		kill_events_pids
 	fi
 
@@ -3463,11 +3458,11 @@ userspace_tests()
 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
 		userspace_pm_rm_addr $ns1 10
-		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" \
 			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
 		userspace_pm_rm_addr $ns1 20
-		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
 		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
@@ -3494,7 +3489,7 @@ userspace_tests()
 			"subflow"
 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
 		userspace_pm_rm_addr $ns2 20
-		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
 		userspace_pm_chk_dump_addr "${ns2}" \
 			"" \
 			"after rm_addr 20"
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index a977a722fb3d..d529b4b37af8 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -8,6 +8,17 @@ readonly KSFT_SKIP=4
 # shellcheck disable=SC2155 # declare and assign separately
 readonly KSFT_TEST="${MPTCP_LIB_KSFT_TEST:-$(basename "${0}" .sh)}"
 
+# These variables are used in some selftests, read-only
+declare -rx MPTCP_LIB_EVENT_ANNOUNCED=6         # MPTCP_EVENT_ANNOUNCED
+declare -rx MPTCP_LIB_EVENT_REMOVED=7           # MPTCP_EVENT_REMOVED
+declare -rx MPTCP_LIB_EVENT_SUB_ESTABLISHED=10  # MPTCP_EVENT_SUB_ESTABLISHED
+declare -rx MPTCP_LIB_EVENT_SUB_CLOSED=11       # MPTCP_EVENT_SUB_CLOSED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CREATED=15 # MPTCP_EVENT_LISTENER_CREATED
+declare -rx MPTCP_LIB_EVENT_LISTENER_CLOSED=16  # MPTCP_EVENT_LISTENER_CLOSED
+
+declare -rx MPTCP_LIB_AF_INET=2
+declare -rx MPTCP_LIB_AF_INET6=10
+
 MPTCP_LIB_SUBTESTS=()
 MPTCP_LIB_SUBTESTS_DUPLICATED=0
 MPTCP_LIB_TEST_COUNTER=0
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 1e0b39e5525c..72dca742280f 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -19,15 +19,15 @@ if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 fi
 mptcp_lib_check_tools ip
 
-ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
-REMOVED=7          # MPTCP_EVENT_REMOVED
-SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
-SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
-LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
-LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
+ANNOUNCED=${MPTCP_LIB_EVENT_ANNOUNCED}
+REMOVED=${MPTCP_LIB_EVENT_REMOVED}
+SUB_ESTABLISHED=${MPTCP_LIB_EVENT_SUB_ESTABLISHED}
+SUB_CLOSED=${MPTCP_LIB_EVENT_SUB_CLOSED}
+LISTENER_CREATED=${MPTCP_LIB_EVENT_LISTENER_CREATED}
+LISTENER_CLOSED=${MPTCP_LIB_EVENT_LISTENER_CLOSED}
 
-AF_INET=2
-AF_INET6=10
+AF_INET=${MPTCP_LIB_AF_INET}
+AF_INET6=${MPTCP_LIB_AF_INET6}
 
 file=""
 server_evts=""

-- 
2.43.0


