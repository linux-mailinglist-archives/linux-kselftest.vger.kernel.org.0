Return-Path: <linux-kselftest+bounces-4804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90B856C91
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A45D1F22304
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22098145340;
	Thu, 15 Feb 2024 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1fg1CfX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF39E145B22;
	Thu, 15 Feb 2024 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021571; cv=none; b=WiKWb+51UWyqEFsU7/ECe+Rqu6wS8LgqJfDvuYAlGehdjPnja9f5ws19n8ldRr3sPpJcYN+8JOEbzmY0TFY0MmIvY33dvlcQmlzF7wsNQQxc7J1Q2fzjbePmfMTl767lUJSVnEUYc6d/Jlq1neTwiLmeaVuZ0oWvdNH/BjvtTBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021571; c=relaxed/simple;
	bh=nSs3+BtV2/ff367YsFLdCP2QJFXRZLr2rZYWqLUTkaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IT2Cujd578W98Vk2QUZFBz3VbBCiEKymeD833rebu6eIsIlOCOPJZEdr482t9e+QnI+0mhWT5kCKPixf230pyDjc4m4kQrh3KsDGG1gHsT7rPwNptogOUTa+7i0n0lvMV4T3+SaCDToeVQJxsvH67V57l9wrGXKfM7Oy73EF6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1fg1CfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9140DC43601;
	Thu, 15 Feb 2024 18:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021570;
	bh=nSs3+BtV2/ff367YsFLdCP2QJFXRZLr2rZYWqLUTkaw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E1fg1CfXSObE8/kfIxsJmP+v/jEG0Thgw/EduNWRoELHyp70IVkPns2L8u24mf7NM
	 BnrKTedtORBmBI2ROagzzosqMpt6wOUnqYujZ4rui+DHrvtUw0bTgu4gFT0l9wszky
	 teK+gpVBRvLHHg9zIEzLn+iWc4m+kUhbJmozs22g3MtbZmMzSKOeJVK17PwvAGax8Q
	 BCHyQpWJAQQp2h0f7GvHoS7aBGHqRRp0uGdA82zJWbpwN874Dgljm8QTra6DDWK8Bd
	 yj7pp6XqSNt9htfBkI8Uycp6DZNN6NobSmyusYgtpDRBdIhIn5AXE0NtVxo+4DbBch
	 Fiy9+4iDANzQg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:37 +0100
Subject: [PATCH net 10/13] selftests: mptcp: simult flows: fix some subtest
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-10-8c01a55d8f6a@kernel.org>
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
In-Reply-To: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Davide Caratti <dcaratti@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nSs3+BtV2/ff367YsFLdCP2QJFXRZLr2rZYWqLUTkaw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdFM+5TfOdHD5haKNyDgG3OAhCJaATM2U2V
 4Ey8aah+taJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 c0R6D/4gBNd1KxJP6DujFTdHPSngx+eyZBvJ9rjifc7Ojc2PIj/350Yq1JlyJir8Siw210ZdXZ1
 qUC4dzieNjDM+PV9qnLXWcsvQeT4D6Xyw5vp+CPe7EG9IiWdhDUtKnANfH+yv+IyPNmFrEUp+Gs
 dY4G+Tee/FA8RWpK1JiH64rdAq1JnpFbrXBylU03RwBkFa7MDc0Aln2vJzpSDiYJuNxllD5f8i6
 nec7Fz5qe1VA5a7lTdm4voSZFcFGOqqd38TmMxBARZVV9ie1yG/G7HShKCIHCU+W7pZt38iI95e
 JfDrTVZ1Ps4nBDt3z/kbN3ZCyC1y/eSyr7yIcq7zoM2mWqIPUWfDdwr/L/Vpho2Gfa1TDX4ixEU
 +kYFyrdLYqVuJxBoBYmI4TzMdUSO+ce7u5B6P3nXH33obEJUwan2Q7vURwZEuej0iNM4qQg5pxC
 96hmKoeCgXGHCTIw2YSeThh9u90ywrmg6XMM+M9EpQaK99rr+OprZQmYVUrjyVwU+4LfLT4T40f
 b+93824pmCDGcp6P9TsrIGcx2vsbn32u/SUWUZa/Gk9Cmb1l7UjzUyrBMYW+t1PDZgb0hRaWB94
 BX8pfusDS0ZOlXe+rDGDnPR0ETXla9NVa2yUwWoJ+ek5xgMn8vrcIfJost+FbX4mR8gfZbc7+6O
 432ZUcEdKaCnxcA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The selftest was correctly recording all the results, but the 'reverse
direction' part was missing in the name when needed.

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated name.

Fixes: 675d99338e7a ("selftests: mptcp: simult flows: format subtests results in TAP")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/simult_flows.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 0cc964e6f2c1..8f9ddb3ad4fe 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -250,7 +250,8 @@ run_test()
 		[ $bail -eq 0 ] || exit $ret
 	fi
 
-	printf "%-60s" "$msg - reverse direction"
+	msg+=" - reverse direction"
+	printf "%-60s" "${msg}"
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"

-- 
2.43.0


