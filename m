Return-Path: <linux-kselftest+bounces-6120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D62876CCA
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 23:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D60C1F21C5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2267D608ED;
	Fri,  8 Mar 2024 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dE16c/gk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79E760B98;
	Fri,  8 Mar 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709935833; cv=none; b=lJqmqkDzM1t789TALm0MIiRloHQm5S0nJhdTcMX42Tmrf81Nqzv3x59CRFzQ8nKmSNKAZ3t33B4WlyHlNNC6edvoHl6ZUU2uhe7JsdaTVssNuqT/Md1p3ZDVime4Wm4vfBLE+NB+M9HtxRHLgSnSHt2nDSWmRM6uHb7oXnQeziA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709935833; c=relaxed/simple;
	bh=AuyUJEy8/GFimI6CwhS0MaqX8nAZA6UQMnkCDSU/jzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bmyn3VUuXmvhRWUvS2sP3iMxcxTjVheiYvsCWd5NyeIyHe8dtqWcMiyOPipM+otxOzt5WfIy7jIH8b/P1mkcE3C/NC+8XqXm5mpx/ddh9gaMB3nN/12kyTJuHz1wpLKsDuljoxHvxoxqO8kLPc+AkjCnaAfSFV6rMFugM2Hsdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dE16c/gk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD58C43390;
	Fri,  8 Mar 2024 22:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709935832;
	bh=AuyUJEy8/GFimI6CwhS0MaqX8nAZA6UQMnkCDSU/jzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dE16c/gk17P/s1W7YESFsK5M6ClDFa10MAK1asHYMtg/78gmCGyk5KSv1a9GkLNju
	 aBtDtjReX9m6Y+RYBI32n1EqYQBQe1vpgV5vDOMB7ar2+Rxt5gD2+f/6khcijoOZ26
	 nFuwqtgPE0m0SxY5C76NNLpNZNU6/tNg0qvJjr05pw3RcaT5g/77ucfXq1BO4Lp3Mp
	 yP9AxgJu0nJ9GwfEWhxuOOi+/k8CvuWI820RgmtYvjDxQWbnvrjt4J2IcDHOrI4wtO
	 UMm7dK2lnP3yfeUy8/qP3Y8v2K5sVfoqAwWVVlAfXYkdBaQ7gWLmo5wSa2Tspl8fmN
	 YMOHtkXrvNtzg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 08 Mar 2024 23:10:10 +0100
Subject: [PATCH net-next 03/15] selftests: mptcp: connect: fix misaligned
 output
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-upstream-net-next-20240308-selftests-mptcp-unification-v1-3-4f42c347b653@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3136; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=prJQDSXkGk0bgVFnt5VqgYB54OTpymEkzl8crkakD0M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl64zJr7eRlLmjzQutMXiAAbc/UHNbZ4qHX1QDN
 109RZbK0suJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeuMyQAKCRD2t4JPQmmg
 cwcwEADuOeD0hasvEJzIzH758PoeKJ1DSXRsIOD1l46v2wVK0bZlRqobGALGM/yLLzJ68QHuzN8
 HOkF9GFmrtmBJRevF/6GaJU/GaYFCkQT+OgpNjAhmevn1fHg7AWv7FFVah8h+quHUidSqG5rZX0
 qdy7drZLNKa2/lqSA112NkbVEBYDBWqkIvg95wgXFrlxVa5WvO9sPGMFsYYGrKf993/QE123nUK
 SGFuN/lSQS8Pj/eI00h8Yaqlhjo2393IRMUi7R51UsehOxarojXLOAZKrwjb7rx1hCgNMEqKVnU
 nTrKS9LYpZJn4ddLqHyVMvt26C7ji4L30eOR3WkPCwuQlFzO2Pnsy0SE6vZKkl75nuJBxXL0xyN
 8lkt95kUJpzFJzCKfCX0k/0EfcLtA1oM/gi+qtgPnuEWTHrjDISmwtraHjMC/zM64mI3O7l8EJe
 i1rXE0I6EePQJUvxN9tK4/vTS1qXH0bCnWxqBQDk4iTKH6afvNunPUmwIdDG6Yv0zxMAsj7pqfZ
 vR8QY4IQLDZmAxjtdyDfK3cCK+9d0HEaQ5wj8jhIdi60Ro0e0NAOUR5HL0fGTR7RByBpHDUSOh0
 /xo2X4njtmCLcCcOYy9y7dB5cwabVRsAaGXaA2El0BfMVx+FUqj4qG0iXwmu2Xx0RrhFoAqbSTf
 zoUQATTRWsYe4hQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The first [ OK ] in the output of mptcp_connect.sh misaligns with the
others:

New MPTCP socket can be blocked via sysctl              [ OK ]
INFO: validating network environment with pings
INFO: Using loss of 0.85% delay 16 ms reorder 95% 70% with delay 4ms on
ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP   (duration   184ms) [ OK ]
ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP     (duration    50ms) [ OK ]
ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP   (duration    55ms) [ OK ]

This patch aligns them by using 69 chars to display the first two lines,
and 50 chars for the other. Since 19 chars are used to display duration
time. Also print out a [ OK ] at the end of the 2nd line for consistency.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index ab3f52434753..ce9342b241cd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -248,11 +248,17 @@ else
 	set_ethtool_flags "$ns4" ns4eth3 "$ethtool_args"
 fi
 
+print_larger_title() {
+	# here we don't have the time, a bit longer for the alignment
+	printf "%-69s" "${@}"
+}
+
 check_mptcp_disabled()
 {
 	local disabled_ns
 	mptcp_lib_ns_init disabled_ns
 
+	print_larger_title "New MPTCP socket can be blocked via sysctl"
 	# net.mptcp.enabled should be enabled by default
 	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then
 		echo -e "net.mptcp.enabled sysctl is not 1 by default\t\t[ FAIL ]"
@@ -274,7 +280,7 @@ check_mptcp_disabled()
 		return 1
 	fi
 
-	echo -e "New MPTCP socket can be blocked via sysctl\t\t[ OK ]"
+	echo "[ OK ]"
 	mptcp_lib_result_pass "New MPTCP socket can be blocked via sysctl"
 	return 0
 }
@@ -342,7 +348,7 @@ do_transfer()
 	addr_port=$(printf "%s:%d" ${connect_addr} ${port})
 	local result_msg
 	result_msg="$(printf "%.3s %-5s -> %.3s (%-20s) %-5s" ${connector_ns} ${cl_proto} ${listener_ns} ${addr_port} ${srv_proto})"
-	printf "%s\t" "${result_msg}"
+	printf "%-50s" "${result_msg}"
 
 	if $capture; then
 		local capuser
@@ -835,7 +841,7 @@ check_mptcp_disabled
 
 stop_if_error "The kernel configuration is not valid for MPTCP"
 
-echo "INFO: validating network environment with pings"
+print_larger_title "Validating network environment with pings"
 for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
 	do_ping "$ns1" $sender 10.0.1.1
 	do_ping "$ns1" $sender dead:beef:1::1
@@ -857,6 +863,7 @@ done
 mptcp_lib_result_code "${ret}" "ping tests"
 
 stop_if_error "Could not even run ping tests"
+echo "[ OK ]"
 
 [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
 echo -n "INFO: Using loss of $tc_loss "

-- 
2.43.0


