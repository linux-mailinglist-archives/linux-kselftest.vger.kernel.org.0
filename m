Return-Path: <linux-kselftest+bounces-2371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EF781CA3C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A99FB24D67
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F7720B33;
	Fri, 22 Dec 2023 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMG6POUd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63820B20;
	Fri, 22 Dec 2023 12:48:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8587AC433CB;
	Fri, 22 Dec 2023 12:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249282;
	bh=0XsZNMC7rZ4PpQo/nWnNMLjUOxV29/JKV7xPuiqrXVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rMG6POUdc5DynIACKIj1rikv4g1Dd7j7m8AkrRCMYPi6Ej80rc1fYgsxtxKpxFmUG
	 gNIaJUVmiiMKXjAE7jirCf21hNTOMiMKqxNVvHdmEwg3NroXsrro0ObWW6RoGNSdrE
	 WrU0jMBKyAQqEfhuZ2oEklvSijtSfZcajK+2bGJ6u9ozVgspBEqy2lB9SF0WUPscLk
	 19Em3qgVsJWfylFt3B9Y+BHK2zrUb77B2PdGfzDZ8wff8l7AEKZpQuWBc2SMZB7OXP
	 TFmHLTXNiyKkP02uFiwKhwKsBN2mlO3UyLVfEzBB2g/y7MJdidj6WN27RRTXaKEXr4
	 EgtPQxF+Os+4g==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 22 Dec 2023 13:47:24 +0100
Subject: [PATCH net-next 3/4] selftests: mptcp: join: check CURRESTAB
 counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-3-c1eb73d6b2b2@kernel.org>
References: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
In-Reply-To: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3657; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3vXnHeyEbokDd1nQmEOTmW/dnLowAGGgCm839d/zVb0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlhYV2f0aSUpzxzuPe70dXdaErfggTdZqjlCdi2
 BxLMFm4JC2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYWFdgAKCRD2t4JPQmmg
 c5PJEADrtwvBTQX86CRymC35dH1ag4ssAXqKqZUR0atN35a8bizXp23UDETNDo8JfKdFzunrt9j
 wReObWZpvQoWoRDRQOK50LmN4LnZ3oV5IKI/QpCWqjYIg48aIYeZOGQbt8S1xyI/kcAY/AyxrSL
 Qvau78vw1IV1Czok6RO6WvjNp5VbH3+0HAsF1p08ogbtFHphIAhnWDuLGHHX2/NH/Zdpb0VmS39
 MfInaZ10gWqP7GA+TEOrmcVQ9fjv5kSnOfEisvw7lABDKXqh6g+qfupt/qz4WMzs71IuzI7P6pE
 dUfjaVXXgSIBeZunITJ//J3YWDK5vNh8i1fgdqnkbM2qbSiHFKrnr7FE+6mdFa4UAnMfJeMT8f0
 6YkpMNtvB0iuoObTumgvbf51c4/5MgOlum4gvedLFmYRI7mzh1tM2yZK7Yest9gW0gJv6PKvSG/
 koWWdJ5RfzOZof1kw2zMHlDxrA+bUKxWUvs2nScQegmYO9NOtlot57ir3zo/YNRho5kbjBy3ba0
 DUzX44brz3/XV7zaZyExb/rTY8rZAfsMdIFp4AxjHjH75SphkZnHHYJi+TLWEwXwrHZglng2x0q
 ga7gvn7CyNhDEWapuTaUS0x7qWVuuwP+B0W1BL3zJCYXVuiLe2aQIy/49eBvGvgYqLGG+YN9PTy
 laK/thd8+toiIEA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@linux.dev>

This patch adds a new helper chk_cestab_nr() to check the current
established connections counter MIB_CURRESTAB. Set the newly added
variables cestab_ns1 and cestab_ns2 to indicate how many connections
are expected in ns1 or ns2.

Invoke check_cestab() to check the counter during the connection in
do_transfer() and invoke chk_cestab_nr() to re-check it when the
connection closed. These checks are embedded in add_tests().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 46 ++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 87590a43b50d..3a5b63026191 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -56,6 +56,8 @@ unset FAILING_LINKS
 unset test_linkfail
 unset addr_nr_ns1
 unset addr_nr_ns2
+unset cestab_ns1
+unset cestab_ns2
 unset sflags
 unset fastclose
 unset fullmesh
@@ -976,6 +978,34 @@ pm_nl_set_endpoint()
 	fi
 }
 
+chk_cestab_nr()
+{
+	local ns=$1
+	local cestab=$2
+	local count
+
+	print_check "cestab $cestab"
+	count=$(mptcp_lib_get_counter ${ns} "MPTcpExtMPCurrEstab")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$cestab" ]; then
+		fail_test "got $count current establish[s] expected $cestab"
+	else
+		print_ok
+	fi
+}
+
+# $1 namespace 1, $2 namespace 2
+check_cestab()
+{
+	if [ -n "${cestab_ns1}" ]; then
+		chk_cestab_nr ${1} ${cestab_ns1}
+	fi
+	if [ -n "${cestab_ns2}" ]; then
+		chk_cestab_nr ${2} ${cestab_ns2}
+	fi
+}
+
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1089,6 +1119,7 @@ do_transfer()
 	local cpid=$!
 
 	pm_nl_set_endpoint $listener_ns $connector_ns $connect_addr
+	check_cestab $listener_ns $connector_ns
 
 	wait $cpid
 	local retc=$?
@@ -2477,47 +2508,52 @@ add_tests()
 	if reset "add single subflow"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
-		addr_nr_ns2=1 speed=slow \
+		addr_nr_ns2=1 speed=slow cestab_ns2=1 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add signal address
 	if reset "add signal address"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
-		addr_nr_ns1=1 speed=slow \
+		addr_nr_ns1=1 speed=slow cestab_ns1=1 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
+		chk_cestab_nr $ns1 0
 	fi
 
 	# add multiple subflows
 	if reset "add multiple subflows"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=1 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple subflows IPv6
 	if reset "add multiple subflows IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
-		addr_nr_ns2=2 speed=slow \
+		addr_nr_ns2=2 speed=slow cestab_ns2=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
+		chk_cestab_nr $ns2 0
 	fi
 
 	# add multiple addresses IPv6
 	if reset "add multiple addresses IPv6"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 2 2
-		addr_nr_ns1=2 speed=slow \
+		addr_nr_ns1=2 speed=slow cestab_ns1=1 \
 			run_tests $ns1 $ns2 dead:beef:1::1
 		chk_join_nr 2 2 2
 		chk_add_nr 2 2
+		chk_cestab_nr $ns1 0
 	fi
 }
 

-- 
2.43.0


