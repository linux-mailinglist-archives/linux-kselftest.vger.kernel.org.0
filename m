Return-Path: <linux-kselftest+bounces-14309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C493DE9F
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B32839E6
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD15E7FBB7;
	Sat, 27 Jul 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdVqDUwj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44457CAC;
	Sat, 27 Jul 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074626; cv=none; b=OMdCmNvKgCOyMjeT2kTm0u3XjIMkHV65FAZvrnEedGslevaUVqT1LQFc/Co3RIjFyuL0SsNQvRA4N6+etcljiD+bQc8/DwCT3zi8cGGMW1duUFQ2zLPnJobtkpqJmzP7YkesO/xKmAvL7rD6LlNC136I7WM0MqAcWUOQuLuKwHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074626; c=relaxed/simple;
	bh=B2vhK+0RBBQJO+CkqazxYwoIfSfpFJCq0O68Tg4d5m0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQ4NtPFiAVCC/gutJPw8m83wvrmNH4d3R0erG1ZBWouVam2LSuMeS64PHwop1phbTT+QwnAjYQFXX06+u9gVN4M9M+bSGbgYajRDQHUY1jzTlWNookDNBY2doulHeSeuGuPbVSi5M0QCBIa3w0pWaNHW1Ex1Urrvv+mnn8FCrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdVqDUwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A790C4AF0E;
	Sat, 27 Jul 2024 10:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074626;
	bh=B2vhK+0RBBQJO+CkqazxYwoIfSfpFJCq0O68Tg4d5m0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RdVqDUwj4I/Mb/qdteXi0uD7bg/HXL9bqVg9UsM8vZZAey0WtwwBUc42TNwwV72KT
	 s9l15zbeQ6hql64CLydekW5QHaHSlni6FuS3TLfsqsfdYMWzbhG71ZO9kHBWDnJox7
	 pY2UIjsnju+ubfUg2MKuOuJpr0sAdIqjOrjHmFs+eIrJaRUy6YRjNwCrG+Y2xBeapS
	 XpXSB+5VrPTuB0llYQZhydq4JxxtIm3Wr3qNq4L59FbVH9Y729C1Y4n+4If4dPMX4U
	 PQ/LixXAGPXwNMwkrKbteis6a3ktSm/xuTTsHBQlvkAhBURmL5zFETcXaRB8aCDhTj
	 4fQ4EqOFkvMKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:29 +0200
Subject: [PATCH net 7/7] selftests: mptcp: join: check backup support in
 signal endp
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-7-f50b31604cf1@kernel.org>
References: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
In-Reply-To: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-0-f50b31604cf1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3761; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=B2vhK+0RBBQJO+CkqazxYwoIfSfpFJCq0O68Tg4d5m0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXm5+RoMvMHoX9uSbfCV0l6chDQbp4wHe0+n
 KM+1XYUaOyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5gAKCRD2t4JPQmmg
 c5f3D/9jwEMQsW92OQ4X+b2puhWmRoxg2fhuoJIECewgRDDWjb/W0+wywo1SPlKREk9Qd5G8Jht
 XwFNuQ0bvICTFN5/mZ+3uk3B0fPAo8AK86T0A+cTQT8xshLhsWRZmjA9lJlGHqynXPRmS7NzwhL
 jF/htRv0O3TN8kKfNjqCK41JqYxrCPEtNoaiwJ4BQfHnVZKaVjR+aX7H1V8i9pkNpTA+VF/+3Bq
 4lA3j+gC/8V4ftGkdVrd8vAgDU9L0GZSPeF88EbaURZMuHzPkjl5bP7wx0f6MzNAHkN4yrvxiLR
 y0BtlmavYPI15vFuuZFprhq9FrioSpg/rTqQ92/iNC4UmNQR6Y+6LA2qZ5IMZOUUQ3tCk17ilB7
 BuFamGHh0zIWiSjqO4fM1eVRITYtPPL8pkk+Yl5yl+DbE/gYgEnnDgY/dudbEYy8sbW+QtSqqzf
 XPR5QTSJ0wqUZb5SAnIZYlQl6zlMCBdZz6y82q8Cd/lNJvHvDigR3WM+uUT5y7a7AN6Yu3OetpI
 OZAbtA7263pb3EJss5ILLFPNuzG9O5e0QcnvAPEu8JCBpCbbF7zsS8MQ0SGEra7gwK1pFJ7l8AH
 s+TvNbSbFENuboBPanz30UaqEkNvKt8e9wELwbn+sA3Lc29ktMI8mEHO0A+JnhyfcXS3ysH1WEd
 pFLKIVnCc61O8Wg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before the previous commit, 'signal' endpoints with the 'backup' flag
were ignored when sending the MP_JOIN.

The MPTCP Join selftest has then been modified to validate this case:
the "single address, backup" test, is now validating the MP_JOIN with a
backup flag as it is what we expect it to do with such name. The
previous version has been kept, but renamed to "single address, switch
to backup" to avoid confusions.

The "single address with port, backup" test is also now validating the
MPJ with a backup flag, which makes more sense than checking the switch
to backup with an MP_PRIO.

The "mpc backup both sides" test is now validating that the backup flag
is also set in MP_JOIN from and to the addresses used in the initial
subflow, using the special ID 0.

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it validates the previous fix for an issue introduced by this commit
ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 34 ++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 655715c8c6d9..9c7d0ab106d0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2639,6 +2639,19 @@ backup_tests()
 
 	# single address, backup
 	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
+		pm_nl_set_limits $ns1 0 1
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup
+		pm_nl_set_limits $ns2 1 1
+		sflags=nobackup speed=slow \
+			run_tests $ns1 $ns2 10.0.1.1
+		chk_join_nr 1 1 1
+		chk_add_nr 1 1
+		chk_prio_nr 1 0 0 1
+	fi
+
+	# single address, switch to backup
+	if reset "single address, switch to backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2654,13 +2667,13 @@ backup_tests()
 	if reset "single address with port, backup" &&
 	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
-		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal,backup port 10100
 		pm_nl_set_limits $ns2 1 1
-		sflags=backup speed=slow \
+		sflags=nobackup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1 0 0
+		chk_prio_nr 1 0 0 1
 	fi
 
 	if reset "mpc backup" &&
@@ -2674,12 +2687,21 @@ backup_tests()
 
 	if reset "mpc backup both sides" &&
 	   continue_if mptcp_lib_kallsyms_doesnt_have "T mptcp_subflow_send_ack$"; then
-		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
+		pm_nl_set_limits $ns1 0 2
+		pm_nl_set_limits $ns2 1 2
+		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
+
+		# 10.0.2.2 (non-backup) -> 10.0.1.1 (backup)
+		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
+		# 10.0.1.2 (backup) -> 10.0.2.1 (non-backup)
+		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
+		ip -net "$ns2" route add 10.0.2.1 via 10.0.1.1 dev ns2eth1 # force this path
+
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-		chk_prio_nr 1 1 0 0
+		chk_join_nr 2 2 2
+		chk_prio_nr 1 1 1 1
 	fi
 
 	if reset "mpc switch to backup" &&

-- 
2.45.2


