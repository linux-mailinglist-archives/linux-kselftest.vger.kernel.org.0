Return-Path: <linux-kselftest+bounces-11418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5714900A7B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 18:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E71AB26EAA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7419DF6C;
	Fri,  7 Jun 2024 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inonHEeP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252D19DF64;
	Fri,  7 Jun 2024 16:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717777886; cv=none; b=Jhov5XR0F+GELwkl5PKtDfrBgc8tZkmC1y/zmiSLPqiFzghEJP7mZ1wvBG2+9S5nGCWw6//+B7w5pkl9ebxY4K/JCaVH49WU6jFOPfATUGPuMzQuKyO8uIy5mIQyqCwRlTdTQeSuTrFTO17Mv3BcC6KCIjicLZo+jpON2DCxQBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717777886; c=relaxed/simple;
	bh=nRfiESxrDrocYFxIB1Kip5qknfzCi1RIKTdtLiW5IyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kKJITFjbzbaOMWFfUBoo9AwqCqwQMlDl3DrPDccXj0JgxRwOQuXDjsYisdRthiEPmRp/9yTYg+2tIYuothJV0wCANwGkcHtAO97A/LPtTeKH2V/YwhlIaX+mvl27sd47ynLDqqdt6NfMBCSQbYUXqiSAgoyKg3GrxsSyWYkXo3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inonHEeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37F2C2BBFC;
	Fri,  7 Jun 2024 16:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717777886;
	bh=nRfiESxrDrocYFxIB1Kip5qknfzCi1RIKTdtLiW5IyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=inonHEePc+NHcnQjqw5EDTyY0s73WTWaRkNKYqjSXgjOYTsZ6FprzAEbazKATXg/T
	 Tr9TfeKLT1iVy1m4Io5Bzn9ghESpiGI8hRDeG03bXbJSyJkZ2/qxSLw7VnSH9Oywzl
	 IjyLBloBy+lOxDhCZb7Up6YiLPIwT3tDMMBZ2YRrcTCrJZxPNanFHtrU9B2SoPo2/w
	 91D90jTham1EdskAI/2OHlqa6EPXjAHZfckhgdSMsaMKoRyZiommY4I3yhWVsL0/4H
	 9jurhfWtxTQixGgi5NPoAbTqGaiK5B+nq/2Qh373y4iMjBg/rByqENSRCn5vClG7bo
	 o6UqlNaGlWoOQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 07 Jun 2024 18:31:05 +0200
Subject: [PATCH net-next 4/6] selftests: net: lib: remove 'ns' var in
 setup_ns
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-4-e36986faac94@kernel.org>
References: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
In-Reply-To: <20240607-upstream-net-next-20240607-selftests-mptcp-net-lib-v1-0-e36986faac94@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=D5c13u12Kl+XtHG594jjGwtSMgGPVSAdcvwWA/5a7+c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYzXP/WyzHPrzjKKmcs/2bAAkzs5CbEkwMjgdY
 GjVU4Y55OOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmM1zwAKCRD2t4JPQmmg
 cxeND/9R9n+RCtk1TFBbtn3+MBYBxI7UZXr/eIomrFauiqYlnPcFWOZy5dbhdSAjVALGRvXN/J1
 9Jg43pncrub9Itx3OOZ4bj+R/8snftZWwYJyN1/VoBYOXexOSsyZf29eKKXKC0nSw0OGHm0wK8g
 MoXkic3MB5jtjagA7AYOGKwiPErE5VBMFQino9oMHkf24R7Ep80MeZ7rZchVApT0xrVHpByewVF
 4VDVCYYV+XsudJI6XrupwZsM7i26YLH79I6MEtwBtXAlckbJNVTlXxMJJKI5Ehg75uy1bb/8OCm
 mruWWIvhaAeYX9wku5Wx4MFAU6ZeYqY68vdA+HWaOXfVpJOuPYDSjJ6bn0+CQuThWM7jX8e5VD7
 KDbPALA9U0QMP+6nifCKtwIGIdLezyQdIVnuDOVYFK8PPK4uHs2nwvYUuL3hMdtVeyEx104D0gb
 DCHazYlB5oYEI8VyKXLVfKHmnweJ262y+u2KvEfktJnio33mgPJIuJmQDI5A8JCS11jb/x4hth5
 cK1k9lz62pq207bTKpbXz3W1FmQ6m/3Lt6MK3auCBbylKXlf9wQj5xxr91o9cCsBPWxC3yB9oNH
 EjadmKoI8BdTwQiSYRcY1GgDxhnIjsCnOyPl61CpGgYJAB8neAyv2m6ykz3+WbSxAdPN4LrX7DH
 n9EPj7hnF5sgcPw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The helper setup_ns() doesn't work when a net namespace named "ns" is
passed to it.

For example, in net/mptcp/diag.sh, the name of the namespace is "ns". If
"setup_ns ns" is used in it, diag.sh fails with errors:

  Invalid netns name "./mptcp_connect"
  Cannot open network namespace "10000": No such file or directory
  Cannot open network namespace "10000": No such file or directory

That is because "ns" is also a local variable in setup_ns, and it will
not set the value for the global variable that has been giving in
argument. To solve this, we could rename the variable, but it sounds
better to drop it, as we can resolve the name using the variable passed
in argument instead.

The other local variables -- "ns_list" and "ns_name" -- are more
unlikely to conflict with existing global variables. They don't seem to
be currently used in any other net selftests.

Co-developed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 114b927fee25..915f319bcc8b 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -167,26 +167,30 @@ cleanup_all_ns()
 # setup_ns local remote
 setup_ns()
 {
-	local ns=""
 	local ns_name=""
 	local ns_list=()
 	for ns_name in "$@"; do
-		# Some test may setup/remove same netns multi times
-		if [ -z "${!ns_name}" ]; then
-			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval "${ns_name}=${ns}"
-		else
-			ns="${!ns_name}"
-			cleanup_ns "$ns"
+		# avoid conflicts with local var: internal error
+		if [ "${ns_name}" = "ns_name" ]; then
+			echo "Failed to setup namespace '${ns_name}': invalid name"
+			cleanup_ns "${ns_list[@]}"
+			exit $ksft_fail
 		fi
 
-		if ! ip netns add "$ns"; then
+		# Some test may setup/remove same netns multi times
+		if [ -z "${!ns_name}" ]; then
+			eval "${ns_name}=${ns_name,,}-$(mktemp -u XXXXXX)"
+		else
+			cleanup_ns "${!ns_name}"
+		fi
+
+		if ! ip netns add "${!ns_name}"; then
 			echo "Failed to create namespace $ns_name"
 			cleanup_ns "${ns_list[@]}"
 			return $ksft_skip
 		fi
-		ip -n "$ns" link set lo up
-		ns_list+=("$ns")
+		ip -n "${!ns_name}" link set lo up
+		ns_list+=("${!ns_name}")
 	done
 	NS_LIST+=("${ns_list[@]}")
 }

-- 
2.43.0


