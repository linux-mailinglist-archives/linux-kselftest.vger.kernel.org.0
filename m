Return-Path: <linux-kselftest+bounces-7266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC9899B50
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D61AB226FC
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD0116D31C;
	Fri,  5 Apr 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7FOEtKT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7F16D316;
	Fri,  5 Apr 2024 10:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314366; cv=none; b=qkAZmSZXg4iXL0i1eQXvehgJtVRPMSWR3O1mKVkzFxdBOIG0myHHbejD9NZ5d6sRhpMkHNluHT8BfhBfulhZk7waU8K2l/H81kpaBli9PYxv8YRGv5N6Ms6dND/MLJU4ZSAkQ8aBtX1XPRcv12Vnz1RyF1RssKD5SAD0FjxnmrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314366; c=relaxed/simple;
	bh=cklO41Gnr8RqkCP7eGl0T3qddR+iFR4uJimzzItAXao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAmJeWPt7LLCpsMsZa6P1cOE3VkaT2SVG8unbNGc9raDUClBhkcbvi03FPZ5/bsyhGidQeOeFdBj7H5ZwL3euqkMpYuEE5y+O7I1ZAyCqFk0PFJePD1QRserFYiyB7X9QRFE8kXNboFIs13ePxAb4tEzJ/tLFiEqFtCjQp4JZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7FOEtKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E0C433C7;
	Fri,  5 Apr 2024 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314366;
	bh=cklO41Gnr8RqkCP7eGl0T3qddR+iFR4uJimzzItAXao=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I7FOEtKTzEMEu0pZsYWX8dQUPdYd6r3dU+ikAr38R7hVYQ31vQsrE67saphXw7sSV
	 w/t8nuvRWGzFoK8ItXAKtRFf4rJFSvh1iJBFLVCIFB0odvMJbrVZc65VW/SSw8xaDO
	 YSzO55zK17FgMQfyMifniW+7GB34RJZ7QMvZ/nbVRP3tCVNWfIU04LrYODUp/O4ouU
	 T5YwiAn3hE6LjlLDIwVYpg/hdAEYUG65lTDsvrIY1CIhuz3CeeQ8xyYoXxkzjZJE4Y
	 KaXW7n4pkdjw0NkDOKDK4eQ0ELjDiiZffQw46czYOMrykXuf4Fiz1fOLUXRSRFFpCa
	 y8ZSKk1U3HycA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:11 +0200
Subject: [PATCH net-next 07/11] selftests: mptcp: join: update endpoint ops
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-7-eabc9b960966@kernel.org>
References: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
In-Reply-To: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-0-eabc9b960966@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9sKu4QP3l55pYCRc5lz8qgHWCijkZyX6+gKVicInu50=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmD9fl653O5H/NmNoUNMAGsdtrT1O/VZ9YGLCbr
 2ZPtO9oDceJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZg/X5QAKCRD2t4JPQmmg
 c0RTD/sEwyqvlwCzgdhDy6TfcPNucqi0gJ4vapixjhAnjBWQ5ObWcQB6gTvqIbq6xgdy9xy5aM2
 wBwNwgio3eT+rl58dNu2MWWIm3s9BMyGC632Y0eav7poqct3sdPUoinPLLBidoyXadCUrtCaiBB
 Nt1CjYRYSPdouMOOHsbNHCQvyDhxvpR1Gz7vQuvtptAX/T5+a6tXQ1peG/t15+y2SziDUx7kB5o
 WbWSpeAH0aqPi6K2HkYhAwNoZEvfYXsIJ5Fa5fox16rHYzodCSfvyfJAawT19c3yZBxcJsDW3EK
 a6FI1HFb+i5SjRSUOz5ePfz6pjxSytYUFLiZnWRaUX3zp+WaOX4IyAG0+yIk6o3PwP0/RZewSgH
 ezF42pNQdxGiq3HJf5XDpBWd7zHpb8/RLXJdwnhC65RGiIHhtFFxmco2DUX31yQe9fHKSfI9ttx
 YHw+3e3o2fy1MW3CjmV+M2YGwyLLrSNO+cAfhamQVoPevkrfIpB1SxNZcyx6ailWxG/rZkQ494+
 BqZGKUeOuP7HdjBKfRrCyUBDykj4FvO4duo1DOdkTwVm4u1MjD31/n3FaE+FfjiKUPh2TCETdw3
 1ouVN0C8z27GAnBrFzWRE9PCOdiNFZ+yiXAWYcZmnst63/D7wl1P1XAKuoH6ypj9Ustc8Wm0Nyi
 ehDvjVUtCvqcL1A==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch uses 'case' statements to simplify pm_nl_add_endpoint() and
pm_nl_check_endpoint(). And simplify pm_nl_check_endpoint() with
check_output() helper. Also update pm_nl_del_endpoint() to avoid the
'double quote' shellcheck warning.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 72 ++++++++-----------------
 1 file changed, 23 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index d48da81daa06..8862b6a5caa0 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -620,39 +620,27 @@ pm_nl_add_endpoint()
 {
 	local ns=$1
 	local addr=$2
-	local flags _flags
-	local port _port
-	local dev _dev
-	local id _id
+	local flags dev id port
 	local nr=2
 
 	local p
 	for p in "${@}"
 	do
-		if [ $p = "flags" ]; then
-			eval _flags=\$"$nr"
-			[ -n "$_flags" ]; flags="flags $_flags"
-		fi
-		if [ $p = "dev" ]; then
-			eval _dev=\$"$nr"
-			[ -n "$_dev" ]; dev="dev $_dev"
-		fi
-		if [ $p = "id" ]; then
-			eval _id=\$"$nr"
-			[ -n "$_id" ]; id="id $_id"
-		fi
-		if [ $p = "port" ]; then
-			eval _port=\$"$nr"
-			[ -n "$_port" ]; port="port $_port"
-		fi
+		case "${p}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${p}"=\$"${nr}"
+			;;
+		esac
 
 		nr=$((nr + 1))
 	done
 
 	if mptcp_lib_is_ip_mptcp; then
-		ip -n $ns mptcp endpoint add $addr ${_flags//","/" "} $dev $id $port
+		ip -n "${ns}" mptcp endpoint add "${addr}" ${flags//","/" "} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
 	else
-		ip netns exec $ns ./pm_nl_ctl add $addr $flags $dev $id $port
+		ip netns exec "${ns}" ./pm_nl_ctl add "${addr}" ${flags:+flags "${flags}"} \
+			${dev:+dev "${dev}"} ${id:+id "${id}"} ${port:+port "${port}"}
 	fi
 }
 
@@ -664,7 +652,7 @@ pm_nl_del_endpoint()
 
 	if mptcp_lib_is_ip_mptcp; then
 		[ $id -ne 0 ] && addr=''
-		ip -n $ns mptcp endpoint delete id $id $addr
+		ip -n $ns mptcp endpoint delete id $id ${addr:+"${addr}"}
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
 	fi
@@ -707,49 +695,35 @@ pm_nl_change_endpoint()
 
 pm_nl_check_endpoint()
 {
-	local line expected_line
 	local msg="$1"
 	local ns=$2
 	local addr=$3
-	local _flags=""
-	local _port
-	local dev
-	local _id
+	local flags dev id port
 
 	print_check "${msg}"
 
 	shift 3
 	while [ -n "$1" ]; do
-		if [ $1 = "flags" ]; then
-			_flags=$2
+		case "${1}" in
+		"flags" | "dev" | "id" | "port")
+			eval "${1}"="${2}"
 			shift
-		elif [ $1 = "dev" ]; then
-			[ -n "$2" ]; dev="$2"
-			shift
-		elif [ $1 = "id" ]; then
-			_id=$2
-			shift
-		elif [ $1 = "port" ]; then
-			_port=$2
-			shift
-		fi
+			;;
+		*)
+			;;
+		esac
 
 		shift
 	done
 
-	if [ -z "${_id}" ]; then
+	if [ -z "${id}" ]; then
 		test_fail "bad test - missing endpoint id"
 		return
 	fi
 
-	line=$(mptcp_lib_pm_nl_get_endpoint "${ns}" "${_id}")
-	expected_line=$(mptcp_lib_pm_nl_format_endpoints \
-		"${_id},${addr},${_flags//","/" "},${dev},${_port}")
-	if [ "$line" = "$expected_line" ]; then
-		print_ok
-	else
-		fail_test "expected '$expected_line' found '$line'"
-	fi
+	check_output "mptcp_lib_pm_nl_get_endpoint ${ns} ${id}" \
+		"$(mptcp_lib_pm_nl_format_endpoints \
+			"${id},${addr},${flags//","/" "},${dev},${port}")"
 }
 
 pm_nl_set_endpoint()

-- 
2.43.0


