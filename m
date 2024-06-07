Return-Path: <linux-kselftest+bounces-11416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F02B900A73
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAC61C219F1
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C519CD12;
	Fri,  7 Jun 2024 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MH3KD0JZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3219CD09;
	Fri,  7 Jun 2024 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777880; cv=none; b=B8ddteLRdaql40z1KBV0bbJ1Z5j3qksVzWPhA0ktBRlBcsPMKrPR6uPWCKpms2gapqSlpH6AS7XPr51X16FH4Y4CW3Ag2MXNcM+HHxyXslb4QkrIghGebOVZE+nwav0eSVT9GDAHzEABcTYz4V1KIY6H3ycQIasj7OLarK4jgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777880; c=relaxed/simple;
	bh=6RbGhN+bMcZIq2/c1ke5bRnZvFJErPXvE+YV49BWdw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qP1W2C4lK/5a8CveLP5ZfH7KTFrIpSPaulEv7tU1n7XROpFbqHOwEzu10RwxkFislSYRoRc2Tf0HQJDAox/7y/7BdvPPBag3kmXH9QR8oSTnbzxccQyr3+fUO3/3Z4fH2ZuvN4qiUREiawVLEkp8FqsJiGDuLefxbHPhoy1ZfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MH3KD0JZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AF9C4AF07;
	Fri,  7 Jun 2024 16:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777880;
	bh=6RbGhN+bMcZIq2/c1ke5bRnZvFJErPXvE+YV49BWdw8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MH3KD0JZQ7GSmKO66p3wQIZj+HD/W+UQYq2R3rr62t2FfopSDhclXelkVoyPsesql
	 5feMll8PGliWXsiDZkVRAP0a/f7n/hMgZDQCOD1bi8R508BToVkuQNM+jZwldhU5m3
	 Q4ZEbFryCiOzED2Ux2en3K5F/0inf650+Amyexmj5DVkqBx8Bq1csF0b0oh8fs9WDk
	 zLt/gkSJOH0WYZnqjIZscsPbL1w4X2nRWRMnWbFMIs5syi0e3dgruuaQO+Wgr60lS3
	 243uUoZZ+AnuzJ5wF80BHuLKINHsmnapGkJDg5IsrN8LlIoErq7WGYzcHoj9JZfgR3
	 9pH5mqPKmD+zw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 18:31:03 +0200
Subject: [PATCH net-next 2/6] selftests: net: lib: remove ns from list
 after clean-up
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-2-e36986faac94@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1913; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=6RbGhN+bMcZIq2/c1ke5bRnZvFJErPXvE+YV49BWdw8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYzXPn31eceTTnBcod8YZ+ik811HIoVAJkhvyb
 1w0KPrwq2yJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmM1zwAKCRD2t4JPQmmg
 c/ioEADulHeuQZQ3bKc1CTRM6WTJSmbbMWKj/7+qydn4avmXXYV3yiVP4kns3MDInMcONoNg6by
 1jPLyJvcfR7t5Y2ldOnYj0YWG2MTh31o+aV2/QFarCk2Vucf8Ytm/YgCCRfwphIR823Km0hnWth
 L2zGnAELs/fu1GMC3cbM2D9U5tdzl3RZhfGIcPeQ31mk+EilMVOfuo3R+LJyUf5vA9gi+SuJN75
 i2WPjR5F1NbiImX7eDmeRaw+kp41RO4YGbjVJ5H1iVC9Xnlk2ikQvx89a7VS2Lze8E5BNdtrjI2
 Ogvc/OsEpEU56xD95oNkecPD6niJM0Z9kZM1txKS9H+V8VEdd5CFN8kIDKSa07yDAoKpTWrZZ3b
 KrTZzVCzLOzlPRjHUzr02AmfOMViUIa3zcxHfZInQpPCYRIYiatxQcTGuepuLk6l5zG9gzNyQhF
 49abufmBSE8FRrNbDTKVMYOoUeSHQ/Ne0OolOo64xSQ/YxRGocwsD1FBsiEUD2bzePLQqHZ5B2V
 LB4NYuYQDwWqBATOMFrJHzKucR8Mi3UDt4qLGfaXR4/PI42AZEUvVBw4xo4FYx6ff7sCCPVQ8Vl
 VZ0ITURh8XgS3KiwYp/XwrvAXS9uZRrGTzT6dH6tLXqrkCK+RNeQqdEE1FkIERyNJwtrYDU4kDm
 Hv7mJV+J5zJeE/A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Instead of only appending items to the list, removing them when the
netns has been deleted.

By doing that, we can make sure 'cleanup_all_ns()' is not trying to
remove already deleted netns.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b2572aff6286..c7a8cfb477cc 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -125,6 +125,20 @@ slowwait_for_counter()
 	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+remove_ns_list()
+{
+	local item=$1
+	local ns
+	local ns_list=("${NS_LIST[@]}")
+	NS_LIST=()
+
+	for ns in "${ns_list[@]}"; do
+		if [ "${ns}" != "${item}" ]; then
+			NS_LIST+=("${ns}")
+		fi
+	done
+}
+
 cleanup_ns()
 {
 	local ns=""
@@ -136,6 +150,8 @@ cleanup_ns()
 		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
 			echo "Warn: Failed to remove namespace $ns"
 			ret=1
+		else
+			remove_ns_list "${ns}"
 		fi
 	done
 
@@ -154,17 +170,14 @@ setup_ns()
 	local ns=""
 	local ns_name=""
 	local ns_list=()
-	local ns_exist=
 	for ns_name in "$@"; do
 		# Some test may setup/remove same netns multi times
 		if unset ${ns_name} 2> /dev/null; then
 			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
 			eval readonly ${ns_name}="$ns"
-			ns_exist=false
 		else
 			eval ns='$'${ns_name}
 			cleanup_ns "$ns"
-			ns_exist=true
 		fi
 
 		if ! ip netns add "$ns"; then
@@ -173,7 +186,7 @@ setup_ns()
 			return $ksft_skip
 		fi
 		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list+=("$ns")
+		ns_list+=("$ns")
 	done
 	NS_LIST+=("${ns_list[@]}")
 }

-- 
2.43.0


