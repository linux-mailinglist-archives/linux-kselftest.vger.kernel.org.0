Return-Path: <linux-kselftest+bounces-14307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ABF93DE96
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 865F51F2221D
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E7178C9C;
	Sat, 27 Jul 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlFCClXx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC74B78C93;
	Sat, 27 Jul 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722074620; cv=none; b=QoGWOhQGOrAKYwU30Q0yOvhu6rVo/Fxtm5xBE9tDx6BFfRNnAVmLp2qSDUm05Rr6p8PX2gmqF62Mp4ekN1Q8W5om0dUSk4Elw2oRFsBnvxGnwGdWg/+7p7vBOjnWxqXEP5taqabKAPRlSSWQBN8OMcZMgEeT5WeImfwniTjbMPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722074620; c=relaxed/simple;
	bh=3V9TCGueaEZQUXkdU2VKu/SHC9HRI7NdHfFI42aBr3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESNeoSuRGrQ2rfh8G1XqTtouzEZIHXdOAh+L7Ee2Yk9WDm2s1RDj5i38i0hzCw+m3x1IlkKys1lBhrhFCa80oLuOFCQm8afZd8HAW+jW210725TvgLobXwS1NoZlmWf18gkzk7pNiVLZhIk/2EbHZGAsVfKQ2ZIGApsS3OgUXcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlFCClXx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B040CC4AF11;
	Sat, 27 Jul 2024 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722074619;
	bh=3V9TCGueaEZQUXkdU2VKu/SHC9HRI7NdHfFI42aBr3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FlFCClXxcdg8jw1/Hef4qSfXxS2c7nYIpwxlIx70apQa7WHk1EB8fiAp5HysJVWIv
	 V330Pdgo8TArOq5I61DO+zhBYs764XziP7cyXUC55g/XZFZ0vwlecYlC6ksS06c2GW
	 tpUkMNIOVytTXwpfQhzM8VWKm+5VG5EcU3OLfbXsFBksTBa913GovnhQDqSI8+TyUp
	 S9LFv4moG6pppdRaidMiADnWN+JUaSsG5FO1zdeaTY/0bt5DnjDMJO9xmtCY8GyEFj
	 QZX+gsVnQnsHnvBCXItasmmOYEEzS84UiCOR3mza7Ihq6A2n8tNIXsf2KzRAe6duEy
	 U6b6/rzr2zaCQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Sat, 27 Jul 2024 12:01:27 +0200
Subject: [PATCH net 5/7] selftests: mptcp: join: validate backup in MPJ
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240727-upstream-net-20240727-mptcp-backup-signal-v1-5-f50b31604cf1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4226; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3V9TCGueaEZQUXkdU2VKu/SHC9HRI7NdHfFI42aBr3c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmpMXmLht7kjPPpRzQKMQGD7RbCYnNkQ+UMCqTB
 uTRx8bJ+EmJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZqTF5gAKCRD2t4JPQmmg
 c4i2EADL4Znu2EFJ/Cfo5a3oN7fgCL1ZZpEFYFztNQcodxiJ00nYUruG0B1vUxGT3ppz9QRpi1h
 A3Vtc6l8ZEGPV25tlMU6fP1MlNdCJ1j5OE9r4fo21WvQx33dzLCBwVZCnZtCLpNzLJjlSXBTapE
 rxnAOzydeAjK8FkAC9VnkwRDN3OR9s6qwPsk+4ZchdCwjc2p/ONvUeM7MbkNSBA1UNbl/JyMQ2x
 5mSDgDABw1eWOgOQZQtTvTG/N0+5h/jrfzcWvRrHdAEjku0i49bwr+cTyGDNKnutd7JmyIuHOKO
 8HmIJjdusL1wz1LKjLFAx4QUC95NKSSPuYZnEZNsgFHiRKv2XtQnHk8RUpbxfrdhJFzFCCi/9fP
 tAKkETZcocq0RLqCys61MXJHcWEh88L9ZmghpzudGk5bUByXn3gZSy7AaQour1nwszwfCA0jx1p
 VoX/WG8iBvlv455n01NtrH1VBzS19jybdlFcBk2XMrgkiHDK+jHmvutWpBVuCcZJKryWeibjJmy
 87fGxSZniDnaJp+a3o9cSb4Haoe1nwzWY2E8+Jr+4xBnF2mzzJ/hg5EFA1vWm0fG7Hgh25iBsXf
 g9jYQ65/5WQWpKPbgweCKkFuJk0j85pS/++NHW5A3yLms0C+VjwX1nfWN/UvllPs0oRKWskEsAm
 ZtSg02ltsmczc8Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A peer can notify the other one that a subflow has to be treated as
"backup" by two different ways: either by sending a dedicated MP_PRIO
notification, or by setting the backup flag in the MP_JOIN handshake.

The selftests were previously monitoring the former, but not the latter.
This is what is now done here by looking at these new MIB counters when
validating the 'backup' cases:

  MPTcpExtMPJoinSynBackupRx
  MPTcpExtMPJoinSynAckBackupRx

The 'Fixes' tag here below is the same as the one from the previous
commit: this patch here is not fixing anything wrong in the selftests,
but it will help to validate a new fix for an issue introduced by this
commit ID.

Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 42 +++++++++++++++++++------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 108aeeb84ef1..655715c8c6d9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1634,6 +1634,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 
 	print_check "ptx"
@@ -1655,6 +1657,26 @@ chk_prio_nr()
 	else
 		print_ok
 	fi
+
+	print_check "syn backup"
+	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn" ]; then
+		fail_test "got $count JOIN[s] syn with Backup expected $mpj_syn"
+	else
+		print_ok
+	fi
+
+	print_check "synack backup"
+	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		print_skip
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		fail_test "got $count JOIN[s] synack with Backup expected $mpj_syn_ack"
+	else
+		print_ok
+	fi
 }
 
 chk_subflow_nr()
@@ -2612,7 +2634,7 @@ backup_tests()
 		sflags=nobackup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 	fi
 
 	# single address, backup
@@ -2625,7 +2647,7 @@ backup_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	# single address with port, backup
@@ -2638,7 +2660,7 @@ backup_tests()
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 1
 		chk_add_nr 1 1
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc backup" &&
@@ -2647,7 +2669,7 @@ backup_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc backup both sides" &&
@@ -2657,7 +2679,7 @@ backup_tests()
 		speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 
 	if reset "mpc switch to backup" &&
@@ -2666,7 +2688,7 @@ backup_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 0 0
 	fi
 
 	if reset "mpc switch to backup both sides" &&
@@ -2676,7 +2698,7 @@ backup_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
-		chk_prio_nr 1 1
+		chk_prio_nr 1 1 0 0
 	fi
 }
 
@@ -3053,7 +3075,7 @@ fullmesh_tests()
 		addr_nr_ns2=1 sflags=backup,fullmesh speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 
@@ -3066,7 +3088,7 @@ fullmesh_tests()
 		sflags=nobackup,nofullmesh speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 2 2 2
-		chk_prio_nr 0 1
+		chk_prio_nr 0 1 1 0
 		chk_rm_nr 0 1
 	fi
 }
@@ -3318,7 +3340,7 @@ userspace_tests()
 		sflags=backup speed=slow \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 1 1 0
-		chk_prio_nr 0 0
+		chk_prio_nr 0 0 0 0
 	fi
 
 	# userspace pm type prevents rm_addr

-- 
2.45.2


