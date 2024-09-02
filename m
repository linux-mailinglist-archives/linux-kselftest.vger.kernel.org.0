Return-Path: <linux-kselftest+bounces-16947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D88968531
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 12:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4252E1C22C2E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 10:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756011D6791;
	Mon,  2 Sep 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaoacvPx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D071D414F;
	Mon,  2 Sep 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274000; cv=none; b=cJpPldeAHbyQaEguQo2yO2wXrrxqpBoStzimvcQ1UK7/6yISOy7xtakRdp5gV+vNIIE5UDjR0e/lbfgT8mz0L/5mG93Azq4bSZMEEe99swt8pxT1OYg4Xxgz634Hy/ZWPY5tA8VuSqWrSRFHK6zu0JRWaUVjfbyu2kFFL/2zwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274000; c=relaxed/simple;
	bh=6xnI2w/INMp2IQXw7wQ09BWYHS+4tqpRw4tfBXZ2UNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kzjd3ByWc85P2c336PCljqMLmce/REIOOH8/8N4maGav7qWmq3z8P9w2tvZUViubBGid+9mvdClKthSduXVD5IX9Dnc4usgn+40GjR2f+9Umy/dGK3jxj4ddVxR4lAc+C+mVObou5iKmkFqsJG8ejcYFk8b5gXmTyYxUAIGbSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaoacvPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58FD4C4CEC6;
	Mon,  2 Sep 2024 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725273999;
	bh=6xnI2w/INMp2IQXw7wQ09BWYHS+4tqpRw4tfBXZ2UNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gaoacvPxlYeXWDaXOElLcBwBdoX3dFBE39TyEUtZ+IRox8obB5wlrIZP+YAz6FVh1
	 A3B/CYE60XAlQ5j3A6yHFGBc2t8PomI/FudnfC4UwXx9p0PYmCpQVDPWiM2eG3janX
	 xTI0YPTzWBhopBtNmHOaO/R/1TqkTv2yu/2NplmTFMWil/VQDWx2vqaQt7zQYbMHxL
	 hqY61je/c63GS1v9xdUUtww4K97BVxWCvySSGFulxC7g3mZlvkOzYOodgXQYXHu7Jh
	 WatJ9TCX2nRri7S/koWyL1fPzz7NNQQDfc32JAbwWVSUv7mU3fX7Lda7X6fjJtdQ7J
	 rtcQOl/EWn04g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 02 Sep 2024 12:46:01 +0200
Subject: [PATCH net-next 10/11] selftests: mptcp: join: simplify
 checksum_tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-10-d3e0f3773b90@kernel.org>
References: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
In-Reply-To: <20240902-net-next-mptcp-mib-mpjtx-misc-v1-0-d3e0f3773b90@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=pLzsh5bACyzEg5mqd2S+G2QDX6il3VLPJs5I9rwx6m8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm1Zdu9aV/2VffKBClfleScV83CjA5zazB4MAhd
 YcEkgWrWzyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZtWXbgAKCRD2t4JPQmmg
 cwd3D/9ZBDfjhANlpRbqoWHyZqpnnyCnZZuAVqzXJOCCpavJrjecTL0VqhqJL6SvIGq7ZAhdhVk
 LAthvqVEc/BTrHkTXet2y0OBViiYj0LIrwCC/C/iN6okOWop/ReJvcLxSEUG/UGzYE60SU2Hr2m
 LYZ2xANB7DGjba9dsk/HDa1dfCZj0tkLeRUvS3OA3WLgYhYUR3ECrbDBtP2ROPAHvpZWIQ8ksXO
 5nC327X0kobewtAn88qFqJo8eLLav++u+YKm4Lux3qyU7tJ/AJp8Ow4DMmGNKNfAjB8TgQW8SnL
 8Rsg32BATQyoOfdtV/c/PyZyr9j9u2M+oncjD53Ich7ueYktytz7X/VERIucg0dZFJePcnoFoid
 tlzMv9KMdIZAFSFNW/i7oem9vZA0auSbuQlcIhwr0oc8WkrKJtqkAoc1APlnwpHNZn2Lr1W4WbK
 kHPDRBr6zelQ08l9CoLrdeBuuvjPmlmVvS2oiNHvOyjDJZOxLNtngRAQeRf/V1A3v9ApMY/Bila
 A3gXxXTlQoGIPiSzY32sH2NXjqd3pE+xYgm36J8kBUxYFS9u6Lw0xlGROkA2N4bQgsOfCsvblVA
 uwNpJz14vLL/28FXN3vMW5Y3Y84R93vUK8n+hs6QLaGf1aF+jjn8ZTGwNDbywAvJw//ACDmq9/P
 0Q9z/IpleNoGmIQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The four checksum tests are similar, only one line is different. So
a for-loop can be used to simplify these tests.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 43 +++++++------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 5d164abc18e5..43f8a9bd84c4 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -363,7 +363,7 @@ reset_with_checksum()
 	local ns1_enable=$1
 	local ns2_enable=$2
 
-	reset "checksum test ${1} ${2}" || return 1
+	reset "checksum test ${ns1_enable} ${ns2_enable}" || return 1
 
 	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=$ns1_enable
 	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=$ns2_enable
@@ -3032,37 +3032,16 @@ syncookies_tests()
 
 checksum_tests()
 {
-	# checksum test 0 0
-	if reset_with_checksum 0 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 1 1
-	if reset_with_checksum 1 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 0 1
-	if reset_with_checksum 0 1; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
-
-	# checksum test 1 0
-	if reset_with_checksum 1 0; then
-		pm_nl_set_limits $ns1 0 1
-		pm_nl_set_limits $ns2 0 1
-		run_tests $ns1 $ns2 10.0.1.1
-		chk_join_nr 0 0 0
-	fi
+	local checksum_enable
+	for checksum_enable in "0 0" "1 1" "0 1" "1 0"; do
+		# checksum test 0 0, 1 1, 0 1, 1 0
+		if reset_with_checksum ${checksum_enable}; then
+			pm_nl_set_limits $ns1 0 1
+			pm_nl_set_limits $ns2 0 1
+			run_tests $ns1 $ns2 10.0.1.1
+			chk_join_nr 0 0 0
+		fi
+	done
 }
 
 deny_join_id0_tests()

-- 
2.45.2


