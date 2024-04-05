Return-Path: <linux-kselftest+bounces-7260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9747899B3D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 12:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BF4283DC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 10:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E849716ABFB;
	Fri,  5 Apr 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxwrsM91"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B908516ABF3;
	Fri,  5 Apr 2024 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314348; cv=none; b=TFVnCZBuFwi6Pu8Ah50N7W21Xo9/p8HvnFaA4V/k+UDYPmstdLLsfVTuOS6DphTFKDP/DTOQ8X11BA3rNErnAcBtYqJ6D7CwVNzCmiEPzLa1M+cF0/QeEuNkPSkhLIcSUtS3olX1iydByrq8D22YmlKsXpRvejU7q/5OFWPbx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314348; c=relaxed/simple;
	bh=UXfjZkvZut68urB9bj4+Y2yUcm70M+M+IzmNYeZgUlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s3M0SV4TgtuiveBNKQ5MEUPV7S9X/cl2/a6QzRBLsPSmfJLwDrhoavNh0SmUN6Z9xlVP4KOkyyuNxkENaIVKXKcKHYwG92OSJl+MGMApL7oyZrLXgbl/m8cGt0oH42JXMZ3xGRTIGAmDUlWxAKso/5fMkzYPwV9+qthnk/mbFbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxwrsM91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA16C43330;
	Fri,  5 Apr 2024 10:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314348;
	bh=UXfjZkvZut68urB9bj4+Y2yUcm70M+M+IzmNYeZgUlA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RxwrsM9120vrjE918Km9VXpKmSl8jkBBhoKRn21+mXfMYDD1pzPwccokyz4V8okqO
	 ERWUq5F5BtbzTutoiIkfDUFcEVHK9ZKDEuOc8zCERlcmQcfMpQ/eZfkGads7ZvoWWp
	 871Fc1Y2/eoE/PeFcIJnfm4C94ov93r9UbZhipUrlZsSH1+F0sumE948lOP6ikFAtd
	 HZ30vgoPXR5csc3oMjLjKrHMUyFSL5fXj5dSHqJOFCMQJDjLVZU+NCLxWYAWeG3ZEW
	 YLUJ3U3z1wGFBUDjaGGSIhXjpHPKS+sMaGGhzCG0ecX8Svf68n1gF2Z7KH7Etfw77n
	 JAbfG0EbldE9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 05 Apr 2024 12:52:05 +0200
Subject: [PATCH net-next 01/11] selftests: mptcp: add tc check for
 check_tools
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-upstream-net-next-20240405-mptcp-selftests-refactoring-v1-1-eabc9b960966@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2829; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=7cBbg2dhMoVMioQPZfDCl3TcQx85MupKC/OecHlLWlE=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGYP1+WgO31O9a9x7v2LkGvt71BJBrLh7KVvkEe1ERsorPnTY
 YkCMgQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmD9flAAoJEPa3gk9CaaBzuEwP+Mtf
 m967ZBa/aPH3BzcIxGAh0rzXedUXTbUctd3QKYhQ/SlgUDFHhlHObU8nkyODLnZpO3OU2eZl6lb
 Q7xZqc6A7eMAsNiBDl/Dam/O4nHwDRrjv2eEbrHLK2t5Ei+06+58BK7MZuGBDQcVW2rh0LXYDOS
 BEK7G70NAgWVW/zChjDBXMqP7xW7KdqxUPC2TYl9ABiXrLt2BzTs3zCNZDn4VPx557r9Oas4IJj
 O5Wm+zSD8oPW7yv7WxRIJ/jB07LthGXusT0bNU8Eur4HfrlhHnXIOOxNWaMFvVZ+QklfUta8oJ9
 Ksdo6WZV6cWq8k7bPb+Onyql9dcPdjqXB0jRSzHlkeoI5RNC5Bv1D2ShDBoU0Afud1CCM5H2RnP
 eM+3g4YElySNJS0E1uVUFXKppSvs1dbKRYPbejUKlOC9ITBGh3TCMbX1+v/nYGqnByITlLohKU+
 rZ+QrSgHCm5MCHpw+nxYY27i+r9de6DyJ7zKkbK7BzVViQLcMsNR3B2ChpJLA/slaqXhEcp7Ai7
 ND6v4bFFDbWOsDExLLWIYTTpxEzXc1njpVr1kUqNbkb0J9WruNzouaTgTMOyLZA1R+l1TBZpb5S
 00fYho84mrv9OhvMvV365eQyNH1tPGA+1l1ZQTAs1JX78GGAGYlGYc4YxhZbfo8kDrB5pfhDPQx
 +jhI=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

tc are used in some test scripts: mptcp_connect.sh, mptcp_join.sh and
simult_flows.sh. It makes sense to check if tc is installed before running
these scripts, just like other tools. So this patch add 'tc' check for
mptcp_lib_check_tools(), and check it in these test scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 2 +-
 tools/testing/selftests/net/mptcp/mptcp_lib.sh     | 6 ++++++
 tools/testing/selftests/net/mptcp/simult_flows.sh  | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4131f3263a48..b77fb7065bfb 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -147,7 +147,7 @@ cleanup()
 
 mptcp_lib_check_mptcp
 mptcp_lib_check_kallsyms
-mptcp_lib_check_tools ip
+mptcp_lib_check_tools ip tc
 
 sin=$(mktemp)
 sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e4403236f655..5a95798eb40a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -142,7 +142,7 @@ init() {
 
 	mptcp_lib_check_mptcp
 	mptcp_lib_check_kallsyms
-	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}"
+	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
 
 	sin=$(mktemp)
 	sout=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index d529b4b37af8..1fa05405f65e 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -384,6 +384,12 @@ mptcp_lib_check_tools() {
 				exit ${KSFT_SKIP}
 			fi
 			;;
+		"tc")
+			if ! tc -help &> /dev/null; then
+				mptcp_lib_pr_skip "Could not run test without tc tool"
+				exit ${KSFT_SKIP}
+			fi
+			;;
 		"ss")
 			if ! ss -h | grep -q MPTCP; then
 				mptcp_lib_pr_skip "ss tool does not support MPTCP"
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 1b2366220388..497141c49ccd 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -45,7 +45,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
-mptcp_lib_check_tools ip
+mptcp_lib_check_tools ip tc
 
 #  "$ns1"              ns2                    ns3
 #     ns1eth1    ns2eth1   ns2eth3      ns3eth1

-- 
2.43.0


