Return-Path: <linux-kselftest+bounces-6128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDCD876CE1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647CF280FA9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD183633EC;
	Fri,  8 Mar 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHBK8uD5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F064633E9;
	Fri,  8 Mar 2024 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935861; cv=none; b=Tace2MQr4/gjijmJQtPNU1/eAb2/gE5eT3Os728xvwrGwfL2GUkwhrf7+W28R30h8bRIK5IzGaM3fsRYFpmnwatDPQEpel3mdrhuo4VMvQ4CeDg7nNRnlyeRlgnqt7Ax08mzROMF6fQ3yF1dO0LJpasS2On4VX6xGmSKIJQp//Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935861; c=relaxed/simple;
	bh=ST+FsQCbwuMBVVqFTYxSEcbjGdoTfeXer5gDUehfP2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nH6mS9fFN6yxKkSQXufqiSB2bxRh/kHa6b2dId/tH/aQEur/A+y5niqnk3qHWxbCXL+AIbdhBwPFTvWCZ6i4xXTvt56FEGNtzofHTlegRHZBYBRwQSIv5dFdqf8neUsaVPBbp5cjPdKgv0BySDwMqHwFTOfhjO1f3qEtlcboVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHBK8uD5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54791C433C7;
	Fri,  8 Mar 2024 22:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935861;
	bh=ST+FsQCbwuMBVVqFTYxSEcbjGdoTfeXer5gDUehfP2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cHBK8uD5RQVSmQiXqxgriZwQ+W4QztrbfPeS0Lsz/G42EsU6GZO4ojRLfzzomuF5S
	 vZN2EzL0QSzr5jNqfHUfqUL5pBJ4NUjQurCJcTec4fIjKtKPBMLfdEwj4/3/90ofhS
	 /Ixc5UCaYxT8ia3ieG+tezzhT1FldqkqPtEiIEzI+rfRZPAazgDB2K/jZTA4kO7Se4
	 iyDOwnayt20YoQWg5mZw2mvdH1esiV7Up0msTTq5ZTN56NKSMkSd5m5Gg0GV5yVRXe
	 E04glOiIzjsSVI+7BeSba04K0Qe+Bezp0En2ZtQ++07CAoRktohJLT2ixl7FWxawUu
	 FDmKdQDXI8MZg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:18 +0100
Subject: [PATCH net-next 11/15] selftests: mptcp: extract
 mptcp_lib_check_expected
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-11-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2950; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=HA9w5Ex3KPLfxV6h/+RxCQzHWGG3h+xZEiImAvFkmnk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJzChePs7yPb47ACIKF+toQ/i0dKUzsUcQi
 WbI28q2IamJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 c+FID/9LJigb2kitVlzLdDfNjOyz0zc3g5gLVt68PKE4Lhux4/PhPorepxHQII1OnKIg4KvDSLj
 0arLS6vh/0T5EgB80jk25NTVUBFweWH62QaslhoBppNqNeWFO9KrVRemyAIwTxJaohJ4ChINxdb
 ChPA1I+8e6eD1+FB8FxN5OUtNgAFF3VZDqsT0gTpt58+xfSMlfzp5YOf1vqrduBEVkjmsLM91hY
 u7Um3GLGcCJ2XO1PE9nteaVasfSxyzwFdeyegoTDD3MNud2+6+dREPe1w9ycLRAM+OioA2vbBOh
 FzyE8C1Ib+dV5+ZMYXdqDrR1muWFZGkXTa1Eu4IkEIIjfsns2ZhFk3JZ0MlaqBhBjqX+2UZlVXi
 cLh2SIybFRe+1R4CE1H2EJpLTZerauqNdFvYCKsg0k9MubxNrhuXT1mHvmq/b8qpLIba6ogarUk
 C3k2AL8uIGjWNvP2PfGaalmWE5cbMpBT4cO+2GzMnciDj9V5ubfJh3xLKfu5QM06RJPaC5A4QJ5
 Q2ydE+fa3ei/oarEWyzt3heSeG+7if9dEQc8MleS/H16WnMqg8QTPcMHWO5jwqK/acdq3e8gPLs
 SkOM9kzSpbVqT6PJZFkTHNRna9VnwTurd4nVwyUCeVQPQnK2h72ce2egmxiarRDhDArWSwqQrcP
 5XGh+ndGM3PYKTA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

Extract the main part of check_expected() in userspace_pm.sh to a new
function mptcp_lib_check_expected() in mptcp_lib.sh. It will be used
in both mptcp_john.sh and userspace_pm.sh. check_expected_one() is
moved into mptcp_lib.sh too as mptcp_lib_check_expected_one().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_lib.sh    | 30 +++++++++++++++++++++
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 33 ++---------------------
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index ea39392c68e7..44491f18ed17 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -438,3 +438,33 @@ mptcp_lib_print_title() {
 	# shellcheck disable=SC2059 # the format is in a variable
 	printf "${MPTCP_LIB_TEST_FORMAT}" "$((++MPTCP_LIB_TEST_COUNTER))" "${*}"
 }
+
+# $1: var name ; $2: prev ret
+mptcp_lib_check_expected_one() {
+	local var="${1}"
+	local exp="e_${var}"
+	local prev_ret="${2}"
+
+	if [ "${!var}" = "${!exp}" ]; then
+		return 0
+	fi
+
+	if [ "${prev_ret}" = "0" ]; then
+		mptcp_lib_pr_fail
+	fi
+
+	mptcp_lib_print_err "Expected value for '${var}': '${!exp}', got '${!var}'."
+	return 1
+}
+
+# $@: all var names to check
+mptcp_lib_check_expected() {
+	local rc=0
+	local var
+
+	for var in "${@}"; do
+		mptcp_lib_check_expected_one "${var}" "${rc}" || rc=1
+	done
+
+	return "${rc}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index bc2f0184b1eb..6d0862a1b68d 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -5,7 +5,7 @@
 # code but we accept it.
 #shellcheck disable=SC2086
 
-# Some variables are used below but indirectly, see check_expected_one()
+# Some variables are used below but indirectly, see verify_*_event()
 #shellcheck disable=SC2034
 
 . "$(dirname "${0}")/mptcp_lib.sh"
@@ -228,39 +228,10 @@ make_connection()
 	fi
 }
 
-# $1: var name ; $2: prev ret
-check_expected_one()
-{
-	local var="${1}"
-	local exp="e_${var}"
-	local prev_ret="${2}"
-
-	if [ "${!var}" = "${!exp}" ]
-	then
-		return 0
-	fi
-
-	if [ "${prev_ret}" = "0" ]
-	then
-		mptcp_lib_pr_fail
-	fi
-
-	mptcp_lib_print_err "\tExpected value for '${var}': '${!exp}', got '${!var}'."
-	return 1
-}
-
 # $@: all var names to check
 check_expected()
 {
-	local rc=0
-	local var
-
-	for var in "${@}"
-	do
-		check_expected_one "${var}" "${rc}" || rc=1
-	done
-
-	if [ ${rc} -eq 0 ]
+	if mptcp_lib_check_expected "${@}"
 	then
 		test_pass
 		return 0

-- 
2.43.0


