Return-Path: <linux-kselftest+bounces-24501-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D54A10F5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 19:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA0B169BB5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681CD22616C;
	Tue, 14 Jan 2025 18:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="No77RFiw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8BE204596;
	Tue, 14 Jan 2025 18:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877825; cv=none; b=pCicZFcV13mvpA+na8tA5j61csdixSAWWq5V+TpMw7aG9QtB/U714JyEHLzR6gmmcwOOsHv/pyQFSxZsDAvB3aQFdkukjUvHTZySbKPWaEzPHISAWhuOjKwy1GRRfSyMERU61Ro8WVvdqJAPJrrGzkS+xsUMv7nJtMSW0SwgPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877825; c=relaxed/simple;
	bh=9RqV9VOitD/yl/LHt5lao8q+RDNxnzlzwsxYtUPKLBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cnXPBERsGoKhDSwn/9l7SKW9iMUozpeIZR7/TJltqx09g5BV2d70Iyj+WDYXt3LLGbkkKGOWKf5oNxLZOwQ6QIUDzZPT2GRDNrZNv+drKuqrwHDI2H3ctHBKOP7+WTKzk+rIoV0+OpLDwg1pyIT8nXIqS3WNC0TSwiyKuNwWQ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=No77RFiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED01BC4CEE3;
	Tue, 14 Jan 2025 18:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736877824;
	bh=9RqV9VOitD/yl/LHt5lao8q+RDNxnzlzwsxYtUPKLBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=No77RFiw/FlcF6wxAtqZY//+k75F9ZdyWrcHTfrXozl24vTz2sa8eE6l4EQWBbmN0
	 4sD772CxwUXFxCnzZhm2akLObQqZZqVPdBmNtdV0UXWt/u98lYZDAKZiGenZopX26a
	 aiHeud+cldMs0fE8Dzc8BFEe0Q7z9is5ku9oxheq83qSvh5zyEfZSO0zz3QDy1mFm6
	 ejCJ7G8zybwZ90pDTkgW8vkB7ZLmOoYBbudjdptMCeP08+7UbBjsvUmUDkMtxK9QAm
	 F/5aP3yUoII75VfMl0NTC9HcM0Glk6M/LLpwWa3Ivh99OQi6voP+OBtQVVRN+4hm2A
	 o0un+CI5dihBw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 14 Jan 2025 19:03:16 +0100
Subject: [PATCH net-next 6/6] selftests: mptcp: connect: better display the
 files size
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-net-next-mptcp-st-more-debug-err-v1-6-2ffb16a6cf35@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=9RqV9VOitD/yl/LHt5lao8q+RDNxnzlzwsxYtUPKLBE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnhqbohA5xIeuKa7zqzxe8lDHpqG3pwXCmqbw65
 EYg/R7m6CqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ4am6AAKCRD2t4JPQmmg
 c5R1D/9tpJLn7hvzFt2nGluKO3ejHZEPXUDJP0D+z1+IOPNK1Jv05RTqcKhBHDoyyxJZQnjfWSf
 0qZYy8NgmpMR7GwPYwJn1KVGCo/VLMHT24CgUq7r+FOUUg+Q036c+Vnw6N7L18ed75kaK5Ug9sN
 LKClD6vnBncvbTAM6BWPX/hO1XqTX+TvN6mkqJiUzCHxQ0gefPe0K3IkNewrwD9SFOyNdPtFf6V
 Pb1ABc+s4b9gkjyzVJ68Ikrkfq4chbKpNqPKMCdd+gMnSh69r0e33BkzwszuGH90OJXzJ4XqFrI
 87WwbD5VW4lH9O4PNLLETR6nXQgCxAKYwGYzz4Fq0HwKfVa6upRI9DYbFz10ISgtYgQk37RfDWj
 tbOZajlwAUw+Ug1HwJ+QQgI7kqOG/03Eq0JzbyiQcHy0xZ9biFppO19V7FqWDhy7X6/hLBltYAX
 jETr1f94y8zl7NlZ49VVFvjVHiobzXfbkw6J1hG64D6HqEeFSi+lLAjk/M5VYBUp7zltr0JSA9t
 tlISgOr3Z6pfQrQUrbu0UhxP69qx++fhPUvO35mtKUFUrzuxQArIYBCkWJmJE5CiOHltf2YKBax
 orJ392Pc+tzqyWoeHH9YdzUx35huR/q+/TUyHvVEJ2UwYydNJtbY72h/CsbT6v4HmMSfAhzjsT3
 hxi7xrQIQt31www==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'du' will print the name of the file, which was already displayed
before, e.g.

  Created /tmp/tmp.UOyy0ghfmQ (size 4703740/tmp/tmp.UOyy0ghfmQ) containing data sent by client
  Created /tmp/tmp.xq3zvFinGo (size 1391724/tmp/tmp.xq3zvFinGo) containing data sent by server

'stat' can be used instead, to display this instead:

  Created /tmp/tmp.UOyy0ghfmQ (size 4703740 B) containing data sent by client
  Created /tmp/tmp.xq3zvFinGo (size 1391724 B) containing data sent by server

So easier to spot the file sizes.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e508d356fcdaebbfb95750bba0fa834a8463e32a..5e3c56253274a1f938d2ed9986c4290fcea8b96b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -582,7 +582,7 @@ make_file()
 	mptcp_lib_make_file $name 1024 $ksize
 	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
 
-	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
+	echo "Created $name (size $(stat -c "%s" "$name") B) containing data sent by $who"
 }
 
 run_tests_lo()

-- 
2.47.1


