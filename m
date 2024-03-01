Return-Path: <linux-kselftest+bounces-5760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFCA86E83B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC791C230F2
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4893B795;
	Fri,  1 Mar 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iI3zz6tS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA4F3EA7A;
	Fri,  1 Mar 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317142; cv=none; b=ca8+ckd1Q6Rvd4u1RCtYzXFMVGF620jScC/WnIkfchO34vRC2FYn158Xxg8f5M9evjCi+kHNWXM95p+iz9jnXegIoZVbImOgiew8AJkm1pPQrY/lphhAMJYPl2tH3mPdWvuajtWUq0a264DQN3E5hNFWGn2toshhDmB2NTOY3Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317142; c=relaxed/simple;
	bh=Y+h8oi0OzfKxtVKGinXDMV0yOHevjFEPPPzMtpCcEz8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e7mG+K1g1ZXhC+ik3WMKGQwy75xK2NFFqCHYg9nvpaFaPEkwDbpfQrtxJRdi//D54+eH+YpKJ9bBJiHoLBtsDhfG7KjESRNPLT1+ZIuktpPtPMr8UauZzYEOLkPZYFWuwk17ZR25LioH2CtHYysyxao1w/pV2LN07m2P0b52Hm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iI3zz6tS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128B3C43394;
	Fri,  1 Mar 2024 18:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709317142;
	bh=Y+h8oi0OzfKxtVKGinXDMV0yOHevjFEPPPzMtpCcEz8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iI3zz6tSSekg302o4vmsisle/5Q/bA0tqRpzsam2mFL6Wj9I6kJJ/qM3Xjo+QpAJD
	 UZ4xGKSiGy3+6ffJEvq824NfyfXrKJ/CpsLwpiBbGyi5XjzSPQVFtl+RUIm+iuKOO+
	 PZFinei0fIuvz/1P46l7J7Sz3vzUTmwpXcI5zYLsd4PbBQuwptvYqFCnXI28Wh32kd
	 W0wz+249j1HBUboChVKQx/YMTJnJzJEDWEnGR28RrFngMo2fJUudXawyREW09q8m+h
	 7TL5aE7oWAIb5+c0SAwplJnBNPR2pOmNBJeSReuICapa6Fp2hmOnpmtkZth+raWBK+
	 9hY5T1BznGhYw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 19:18:34 +0100
Subject: [PATCH net-next 10/15] selftests: mptcp: dump userspace addrs list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-10-dc30a420b3a0@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-userspace-pm-dump-addr-v1-0-dc30a420b3a0@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4013; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3qSB2EnzUGbXo6d4U4snvlpAoOYOPE6h5qmbyjUUfLE=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGXiG/SiQLHs83eh+Ot8YPNJ0iGE42bRFZjz6ShCFTpem784w
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJl4hv0AAoJEPa3gk9CaaBz/MUQAMDK
 LK7xpf+MlxWTFum7uz/dMbZ+HJfX9y0ghh5V1L0VlQHJ9mDsYaA1MSdyXDwmxNjN6jpnZzKnylo
 wWXFrDIr4bxyLxtbCiWIX6Wr2Si+AaZIiu3Y+WlP80F95ZTrx+mLNmsG/UkoINAk2clTAMjhOG1
 OxTDuGNvyDuXfBw0odEp4pZ2iKQNU6cXqvBg2uyxp9/aOe1QXVwJe5lGaBzgGqGWW8aQuHphKG6
 3XdXwgN9dKjKIc2fQ9vHYFgcDt/xqksMjqox0e7FxziWySKshbxyRmHY+iGL2Ory8VQwSzMVtYl
 nq2LNSgioRwvt8KYKXlTdk5OHssyd8WuCqiQBuokY2xC9HDS+NEv+C0BDp8XH6KW25Tci+6n95Z
 iaBI8s8Q8dFTfJ2G4+RGXQujekludO4b301fHg5sHXfdSReLuGleVjRzf+kyZqbfHcv2eSiER1H
 g3W9P+jbeS5CICUGX9UbFy5Tjaz573/0i615wkJ5dJhQPx3QFcgOULFgG4fzh57AW2Db9IK96Dt
 A89Gy+pIII0/AZfmZrRDmOngEpj9LfapoNt9J5aVm94LPo2gapTKze6kG5zFoQ5gVWKcvYgJwap
 y6594E8m5qNqsVg4N9H2I6v6pZZex7AbmHb6kcv6VjKm0VkDKy1DLrpnTYXUNUJ0A7up3Wt0ing
 GC8Vt
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new helper userspace_pm_dump() to dump addresses
for the userspace PM. Use this helper to check whether an ID 0 subflow
is listed in the output of dump command after creating an ID 0 subflow
in "userspace pm create id 0 subflow" test. Dump userspace PM addresses
list in "userspace pm add & remove address" test and in "userspace pm
create destroy subflow" test.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 61 +++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 1267d5708e13..8b6430642706 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -21,6 +21,7 @@ cinfail=""
 cinsent=""
 tmpfile=""
 cout=""
+err=""
 capout=""
 ns1=""
 ns2=""
@@ -189,6 +190,7 @@ init() {
 	cin=$(mktemp)
 	cinsent=$(mktemp)
 	cout=$(mktemp)
+	err=$(mktemp)
 	evts_ns1=$(mktemp)
 	evts_ns2=$(mktemp)
 
@@ -204,6 +206,7 @@ cleanup()
 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
 	rm -f "$tmpfile"
 	rm -rf $evts_ns1 $evts_ns2
+	rm -f "$err"
 	cleanup_partial
 }
 
@@ -3356,6 +3359,50 @@ userspace_pm_rm_sf()
 	wait_rm_sf $1 "${cnt}"
 }
 
+check_output()
+{
+	local cmd="$1"
+	local expected="$2"
+	local msg="$3"
+	local rc=0
+
+	mptcp_lib_check_output "${err}" "${cmd}" "${expected}" || rc=${?}
+	if [ ${rc} -eq 2 ]; then
+		fail_test "fail to check output # error ${rc}"
+	elif [ ${rc} -eq 0 ]; then
+		print_ok
+	elif [ ${rc} -eq 1 ]; then
+		fail_test "fail to check output # different output"
+	fi
+}
+
+# $1: ns
+userspace_pm_dump()
+{
+	local evts=$evts_ns1
+	local tk
+
+	[ "$1" == "$ns2" ] && evts=$evts_ns2
+	tk=$(mptcp_lib_evts_get_info token "$evts")
+
+	ip netns exec $1 ./pm_nl_ctl dump token $tk
+}
+
+userspace_pm_chk_dump_addr()
+{
+	local ns="${1}"
+	local exp="${2}"
+	local check="${3}"
+
+	print_check "dump addrs ${check}"
+
+	if mptcp_lib_kallsyms_has "mptcp_userspace_pm_dump_addr$"; then
+		check_output "userspace_pm_dump ${ns}" "${exp}"
+	else
+		print_skip
+	fi
+}
+
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
@@ -3447,10 +3494,16 @@ userspace_tests()
 		chk_mptcp_info subflows 2 subflows 2
 		chk_subflows_total 3 3
 		chk_mptcp_info add_addr_signal 2 add_addr_accepted 2
+		userspace_pm_chk_dump_addr "${ns1}" \
+			$'id 10 flags signal 10.0.2.1\nid 20 flags signal 10.0.3.1' \
+			"signal"
 		userspace_pm_rm_addr $ns1 10
 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
+		userspace_pm_chk_dump_addr "${ns1}" \
+			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
 		userspace_pm_rm_addr $ns1 20
 		userspace_pm_rm_sf $ns1 10.0.3.1 $SUB_ESTABLISHED
+		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
 		chk_rm_nr 2 2 invert
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3471,8 +3524,14 @@ userspace_tests()
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2
+		userspace_pm_chk_dump_addr "${ns2}" \
+			"id 20 flags subflow 10.0.3.2" \
+			"subflow"
 		userspace_pm_rm_addr $ns2 20
 		userspace_pm_rm_sf $ns2 10.0.3.2 $SUB_ESTABLISHED
+		userspace_pm_chk_dump_addr "${ns2}" \
+			"" \
+			"after rm_addr 20"
 		chk_rm_nr 1 1
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
@@ -3492,6 +3551,8 @@ userspace_tests()
 		chk_mptcp_info subflows 0 subflows 0
 		chk_subflows_total 1 1
 		userspace_pm_add_sf $ns2 10.0.3.2 0
+		userspace_pm_chk_dump_addr "${ns2}" \
+			"id 0 flags subflow 10.0.3.2" "id 0 subflow"
 		chk_join_nr 1 1 1
 		chk_mptcp_info subflows 1 subflows 1
 		chk_subflows_total 2 2

-- 
2.43.0


