Return-Path: <linux-kselftest+bounces-5357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F686178B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04FA41F2393F
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Feb 2024 16:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C265613DB91;
	Fri, 23 Feb 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBjLStuK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DCC13DB85;
	Fri, 23 Feb 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704917; cv=none; b=Wbm8oUwBQqm7BTW1jbSaya3ePCYa4OwVUDsWv5kar7R/5VExP4wb72s4pZ2wUelg+UwUXrZasKyP0qt82lTetXX/TrUpKAg4tMx39+h185hdGoCebJ6cq31XVPpKWu5gb+bscMgcY53BcR7/7KXIE4XPgjkniQHyS4X5XPW6EDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704917; c=relaxed/simple;
	bh=ZSGo7VHZyNR7YikLSbNgmp1YKx0wCf2OokDYsGJL+As=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgv0sSLclLHKuJTtPsgZ+jMGZ1ymmJx5n45LWKB8c+GEODZTRbS7kiUihKHTbV2KXmDrshRKNfRxhcFqq1rzT1/brozeLayGRMtbBS83EEW8nLIzpE8/YhoExCAJ7HQqucrrjKj0EUE81JPBq/pFDaje+oop2DBW9bgVkYKEUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBjLStuK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A43C43609;
	Fri, 23 Feb 2024 16:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708704917;
	bh=ZSGo7VHZyNR7YikLSbNgmp1YKx0wCf2OokDYsGJL+As=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JBjLStuKGQ0t48uwI1VrVmLaTDYnoIkrdhjftdozRlGVTAUAgw/hwuczEBCAHnt42
	 s/7ZzBInK7SOqpN+W+spe9ndugxSgTTgTFcLF2GdTWmIhaegZ/qGReKB08DYSLMcgR
	 o4PVQ0RSpoyENGUayzzKh5g+zccA3yQVpbcUwLLYD1ga/olLjjMPpeAt7YL0yTPGVF
	 6Ju1u3SfSLPMNK119vSfY9t8Qn3cMfOuVJUUjJyAfsimyUmxBljnYRnwqmhEIyXXol
	 eYRCseyWA+PhfOHGrtbTlq/T5SO2K0j17xZsu9m7CYUUTQdUqb5zUJygsUk88blg3Y
	 L9sDO7i68RI7A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 23 Feb 2024 17:14:20 +0100
Subject: [PATCH net 10/10] selftests: mptcp: explicitly trigger the
 listener diag code-path
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240223-upstream-net-20240223-misc-fixes-v1-10-162e87e48497@kernel.org>
References: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
In-Reply-To: <20240223-upstream-net-20240223-misc-fixes-v1-0-162e87e48497@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Kishen Maloor <kishen.maloor@intel.com>, Shuah Khan <shuah@kernel.org>, 
 Peter Krystad <peter.krystad@linux.intel.com>, 
 Christoph Paasch <cpaasch@apple.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Ne1BFOJ8rufpD6X3EV4YUBWac7B/xdGlwDdg9Uo0pFw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl2MRq0+MEzZSnwev80cxcGJ5DUjoTnWmkQGn+T
 ORD5K9o/5KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZdjEagAKCRD2t4JPQmmg
 c/eEEACXKB41A5Zk89fIhexgG1iewjTQEovm2Tk0ABOWuYJ3GncWoL7pzYh+pVQk5PlrilDozrM
 uQIU/48MtEPJ8JPAXZrhB/cTxWlZNJZiY20Zq0q+QWulujauQOBrc2/ZULjVuTVW1TrAlaIwO16
 aU3jjo4zmQg6EpG593OoRFcJgmwi77YW9kJ7z4oB0tx2o3nS/6jABZV/dUP+4SnNAQTyIgy3/sz
 ruCIS7ZYzYDPa7vogidjjQUEgtVQTNB0X8lDbnVdW72scYgBCLsOWWTUgFZ80qgNGJJsPQXBXKL
 NJchr6yND2BSHCw4Zp4bvcjfzKUk9zUyFwTnyYWmK5AJgn32fMUisvG38rFs5585NFoGhzqu5ty
 BixA4nIh08HLtcMd34s2Fho7KVN+Lgpxe5Sjr6ly9pfG8W7WQ3P0NB+1DeB0cWIH4j3Y7nA6BsP
 7BdaRdIvgn0M1ku5YMdEHlpnyhuv9cC8uJ0iNbD4GweZfn+SFgVfL7b2B335ZfkFCROOQGurj6M
 s8JmqDeoC/2asXLQNsB5Bgsmd5P3qxrEhyIwqkvn2rFS/Hm+0DdnoLamLoADPkh7cNDIhcsqqgK
 0zghC2hXr+jlrNGOBky+8rXgROoYa8x/n1lYs1N2ovGXh2KaR1BbvvfMKjkTarOsFTpbI9ho5av
 tqfJ2eOQnUWq4lg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

The mptcp diag interface already experienced a few locking bugs
that lockdep and appropriate coverage have detected in advance.

Let's add a test-case triggering the relevant code path, to prevent
similar issues in the future.

Be careful to cope with very slow environments.

Note that we don't need an explicit timeout on the mptcp_connect
subprocess to cope with eventual bug/hang-up as the final cleanup
terminating the child processes will take care of that.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 0a58ebb8b04c..f300f4e1eb59 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -20,7 +20,7 @@ flush_pids()
 
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
-	for _ in $(seq 10); do
+	for _ in $(seq $((timeout_poll * 10))); do
 		[ -z "$(ip netns pids "${ns}")" ] && break
 		sleep 0.1
 	done
@@ -91,6 +91,15 @@ chk_msk_nr()
 	__chk_msk_nr "grep -c token:" "$@"
 }
 
+chk_listener_nr()
+{
+	local expected=$1
+	local msg="$2"
+
+	__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
+	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+}
+
 wait_msk_nr()
 {
 	local condition="grep -c token:"
@@ -289,5 +298,24 @@ flush_pids
 chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0 "many->0"
 
+chk_listener_nr 0 "no listener sockets"
+NR_SERVERS=100
+for I in $(seq 1 $NR_SERVERS); do
+	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) \
+		-t ${timeout_poll} -l 0.0.0.0 >/dev/null 2>&1 &
+done
+
+for I in $(seq 1 $NR_SERVERS); do
+	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
+done
+
+chk_listener_nr $NR_SERVERS "many listener sockets"
+
+# graceful termination
+for I in $(seq 1 $NR_SERVERS); do
+	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 >/dev/null 2>&1 &
+done
+flush_pids
+
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.43.0


