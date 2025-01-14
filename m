Return-Path: <linux-kselftest+bounces-24496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1778CA10F52
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3114C3ADD60
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CFFA224894;
	Tue, 14 Jan 2025 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yh85gC+k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F3224890;
	Tue, 14 Jan 2025 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877809; cv=none; b=uwV9ACT4MYLmC2Cvi/SrvHoSJnfDIjPTVCewRGC6442kmVdJpCxB0OIP7T2Pd11XE7XEJrH10FvFtdClBTDWRd/NNn5ant3ynuDFt6YQkneLNk7Y2N/nF3Cti4SJyul1aeulx1CtC3vBjL4FtDOtxHSIRFKh3nfZfZr1uxJhYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877809; c=relaxed/simple;
	bh=/b63IGbH+aHXEuEpHipqlQZiw/AdT73vujdQ3l36d+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esjuLY7ZXgYEojBu5Tdnw1O8NHZwcmz6zeChdNAm48tClM7EhmEuP5rIe0UvKq3MUKLAPARaC16I9gHnFhrwxax5BA2MKFSS7wGuFqmsg+YpmBevKeEeefcnfYgYXtiX+ae/2eHHaFtCRPcw/h7V2O7ks/yF7/xgjjaZXblxk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yh85gC+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC197C4CEE4;
	Tue, 14 Jan 2025 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877807;
	bh=/b63IGbH+aHXEuEpHipqlQZiw/AdT73vujdQ3l36d+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yh85gC+kGk1luu2Q4/5QXVsiJVnYu00zigUQLda8r9HZy6mxD1VLLmuiVMHB/Z1ps
	 5RGLakHVe52MjiMvvGrt7ZuIr5g6FtM6aEKnaVWkOdwgtbtXroLesowp/7RsPU51Vt
	 HnPpBtgRvcpHna6sWumleIytU66MfJ8N+z5nnz0OLAjmiln0duw6xU6yLiNBp8dkfB
	 eRpVUYsVmuk9Qzvfyu2GzcJgmRBb2jU0PKkvLL/DobUPr0ono8nYoKGAzqkdxz7z1/
	 +ErC0zQPZjXg3aEzlpveq6WpQPTCu1FvXggBJTdpuVoJYi/zj+VEDO6MAX1ZCvjJ9+
	 nWRnLLDcw2bgw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:03:11 +0100
Subject: [PATCH net-next 1/6] selftests: mptcp: simult_flows: unify errors
 msgs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-1-2ffb16a6cf35@kernel.org>
References: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-st-more-debug-err-v1-0-2ffb16a6cf35@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2675; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=/b63IGbH+aHXEuEpHipqlQZiw/AdT73vujdQ3l36d+E=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqboaM5i5mtI9ikWTnu1wp1kA/LxAclN7NgM5
 oB25ecrt7CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 czPNEACCjH89Q0eWe3LoqfQz97B5voQRiWjytmGBqqYKjEdZqjn40cgTg9Ykaob8ADBh+YWLV0v
 u0cux3ENLegsdInqH3knq29B9RIO8q4lEQyi9EOBanvm2dFZITWq83mlJTalvzjwKWfcKG4wjDb
 +Ks9GAwsFDi1Kg7N+GfmCcVfSOLp0XPK1gphaTFvHq5RA1Psrn41ToMESgC2yahq2ChkM065pfo
 5f4FOryWZx8j/H5rlbUujzJWHPNdlB5UPbm9wJWwUW0ggaQP2kToEXeQVS1zgUrnZF3XWWhtVaB
 zbsDYzrXW+xPAwkqEzHnwMaQL5hFCh0/sJrZN8mXSta3uFCnqmkJJvR7y28V3vMx1vThamteRIu
 VcN6kIZja9fKWADh0xojBgO9AgFtFlJ5Hob2zosu6QFJd/0nUGI+NJgdbjNdUDyTJM347SVg2rI
 +TlVWcEFErHam2zSJbS5J2HtiZbNOoV1hA1Dp3l0Sjqc700mJ/gnZ8hJrl6diGVs5DkurdhbZfR
 d2Nm28DMAOq98Y0fmzX3GC8AvRvmvToP1ytSMOL5z+rQaKp2wZaQnEsuwVJ/exbG/7H4tnLGyNY
 h8Fi4+rIvCLT2t1g/2bj5Ao+mjlH3iyXf2eWZl2cM9En1Ci0yooc0TwWi7X6vVxyUAMMd0gvup0
 SPNXLTycYh2Fx7w==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

In order to unify what is printed in case of error, similar to what is
done in mptcp_connect.sh and mptcp_join.sh, it is interesting to do the
following modifications in simult_flows.sh:

- Print the rc errors at the end of the line.

- Print the MIB counters.

- Use the same ss options: add -M (MPTCP sockets) and -e (detailed
  socket information).

While at it, also print of the 'max' time only in case of success,
because 'mptcp_connect.c' will already print this info in case of error,
e.g.:

  transfer slower than expected! runtime 11948 ms, expected 11921 ms

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 8fa77c8e9b651171a34c89bfd5c9ded0288a5bde..e98e5907d52c2d0e9c0152efda82176861905cf1 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -155,6 +155,11 @@ do_transfer()
 		sleep 1
 	fi
 
+	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
+		nstat -n
+	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
+		nstat -n
+
 	timeout ${timeout_test} \
 		ip netns exec ${ns3} \
 			./mptcp_connect -jt ${timeout_poll} -l -p $port -T $max_time \
@@ -180,25 +185,31 @@ do_transfer()
 		kill ${cappid_connector}
 	fi
 
+	NSTAT_HISTORY=/tmp/${ns3}.nstat ip netns exec ${ns3} \
+		nstat | grep Tcp > /tmp/${ns3}.out
+	NSTAT_HISTORY=/tmp/${ns1}.nstat ip netns exec ${ns1} \
+		nstat | grep Tcp > /tmp/${ns1}.out
+
 	cmp $sin $cout > /dev/null 2>&1
 	local cmps=$?
 	cmp $cin $sout > /dev/null 2>&1
 	local cmpc=$?
 
-	printf "%-16s" " max $max_time "
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ] && \
 	   [ $cmpc -eq 0 ] && [ $cmps -eq 0 ]; then
+		printf "%-16s" " max $max_time "
 		mptcp_lib_pr_ok
 		cat "$capout"
 		return 0
 	fi
 
-	mptcp_lib_pr_fail
-	echo "client exit code $retc, server $rets" 1>&2
+	mptcp_lib_pr_fail "client exit code $retc, server $rets"
 	echo -e "\nnetns ${ns3} socket stat for $port:" 1>&2
-	ip netns exec ${ns3} ss -nita 1>&2 -o "sport = :$port"
+	ip netns exec ${ns3} ss -Menita 1>&2 -o "sport = :$port"
+	cat /tmp/${ns3}.out
 	echo -e "\nnetns ${ns1} socket stat for $port:" 1>&2
-	ip netns exec ${ns1} ss -nita 1>&2 -o "dport = :$port"
+	ip netns exec ${ns1} ss -Menita 1>&2 -o "dport = :$port"
+	cat /tmp/${ns1}.out
 	ls -l $sin $cout
 	ls -l $cin $sout
 

-- 
2.47.1


