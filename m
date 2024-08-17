Return-Path: <linux-kselftest+bounces-15586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05C95594B
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A8E1F21711
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A011422DC;
	Sat, 17 Aug 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTF9WOoc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C508BA3F;
	Sat, 17 Aug 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723919931; cv=none; b=IeOEWZN51EB2a6nbWGZdkTwqd6gvSBVn9b87+Vo4KhzDHxj9eoD1y40Nx6ua30lmu3qGbYhM5kI4dbXytBYnSj42NqyC1vVE3EhKQjRWf5jUE45QQMkaKgA+vTgcNbqLN0AjWpwcb6OWpa4xa3EXzqhQ4YoCgNRvOcpY1jKCYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723919931; c=relaxed/simple;
	bh=dCN6GTNUacysmqUJV2cDTTpTAWPQ9JV/LnomObAHzF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IgCzYwA4mYF0WyOJ/N7xcxgcGLAIizxKrGZ0DXmc1srE+PXGUuHyNmc4jozYAw974O6a0RpEaoAitKVMFDwe2DEZOaWd1RRfBsxAcHCClwjScE80YHwIL8AGpohKpOAFvotHhOwVVEDlx7cYen4OAF4tLyp/mDQMqiyV2XdE7Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTF9WOoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2DD3C116B1;
	Sat, 17 Aug 2024 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723919931;
	bh=dCN6GTNUacysmqUJV2cDTTpTAWPQ9JV/LnomObAHzF4=;
	h=From:To:Cc:Subject:Date:From;
	b=pTF9WOocWbcNgRO3CZPwV9z8aejwMSgmsNz2N9GDlGmJSqMl/lw+50KS9IavCC2EG
	 /mlw7k7v/7NAHcirsfzvs8oNKaqcbsC7OfDJbAYTmMGRUl4kezhMF/+dSdEHiXDe9O
	 5vcV/ZyNrkK54949SlI5rpcbnjN7OJ7VuKWFLyhSo/pwA0lJE05BgxE0553V0UMnZv
	 GEGSg1I8GxLEoyEOoh4RWpvYK5JJgxpwhnsIOc1yARsCWne/IbdvF43vkuD5sE8hJg
	 snSJX1kFEWOa3prhP+sVKtVDnepkOrQmb9QhcvE6UGxRWsLLFA66LsU4s7LbdNb8BJ
	 3u3VVDpE1j4Lg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: add helper for checking if nettest is available
Date: Sat, 17 Aug 2024 11:38:48 -0700
Message-ID: <20240817183848.658443-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few tests check if nettest exists in the $PATH before adding
$PWD to $PATH and re-checking. They don't discard stderr on
the first check (and nettest is built as part of selftests,
so it's pretty normal for it to not be available in system $PATH).
This leads to output noise:

  which: no nettest in (/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin)

Add a common helper for the check which does silence stderr.

There is another small functional change hiding here, because pmtu.sh
used to return from the test case rather than completely exit.
Building nettest is not hard, there should be no need to maintain
the ability to selectively skip cases in its absence.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/fcnal-test.sh         |  9 +--------
 tools/testing/selftests/net/lib.sh                | 15 +++++++++++++++
 tools/testing/selftests/net/pmtu.sh               |  8 +-------
 tools/testing/selftests/net/settings              |  1 +
 tools/testing/selftests/net/unicast_extensions.sh |  9 +--------
 5 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 386ebd829df5..899dbad0104b 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -4304,14 +4304,7 @@ elif [ "$TESTS" = "ipv6" ]; then
 	TESTS="$TESTS_IPV6"
 fi
 
-# nettest can be run from PATH or from same directory as this selftest
-if ! which nettest >/dev/null; then
-	PATH=$PWD:$PATH
-	if ! which nettest >/dev/null; then
-		echo "'nettest' command not found; skipping tests"
-		exit $ksft_skip
-	fi
-fi
+check_gen_prog "nettest"
 
 declare -i nfail=0
 declare -i nsuccess=0
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 8ee4489238ca..be8707bfb46e 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -125,6 +125,21 @@ slowwait_for_counter()
 	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
 }
 
+# Check for existence of tools which are built as part of selftests
+# but may also already exist in $PATH
+check_gen_prog()
+{
+	local prog_name=$1; shift
+
+	if ! which $prog_name >/dev/null 2>/dev/null; then
+		PATH=$PWD:$PATH
+		if ! which $prog_name >/dev/null; then
+			echo "'$prog_name' command not found; skipping tests"
+			exit $ksft_skip
+		fi
+	fi
+}
+
 remove_ns_list()
 {
 	local item=$1
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index 24a50622406c..569bce8b6383 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -681,13 +681,7 @@ setup_xfrm() {
 }
 
 setup_nettest_xfrm() {
-	if ! which nettest >/dev/null; then
-		PATH=$PWD:$PATH
-		if ! which nettest >/dev/null; then
-			echo "'nettest' command not found; skipping tests"
-			return 1
-		fi
-	fi
+	check_gen_prog "nettest"
 
 	[ ${1} -eq 6 ] && proto="-6" || proto=""
 	port=${2}
diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
index ed8418e8217a..a38764182822 100644
--- a/tools/testing/selftests/net/settings
+++ b/tools/testing/selftests/net/settings
@@ -1 +1,2 @@
 timeout=3600
+profile=1
diff --git a/tools/testing/selftests/net/unicast_extensions.sh b/tools/testing/selftests/net/unicast_extensions.sh
index f52aa5f7da52..3e751234ccfe 100755
--- a/tools/testing/selftests/net/unicast_extensions.sh
+++ b/tools/testing/selftests/net/unicast_extensions.sh
@@ -30,14 +30,7 @@
 
 source lib.sh
 
-# nettest can be run from PATH or from same directory as this selftest
-if ! which nettest >/dev/null; then
-	PATH=$PWD:$PATH
-	if ! which nettest >/dev/null; then
-		echo "'nettest' command not found; skipping tests"
-		exit $ksft_skip
-	fi
-fi
+check_gen_prog "nettest"
 
 result=0
 
-- 
2.46.0


