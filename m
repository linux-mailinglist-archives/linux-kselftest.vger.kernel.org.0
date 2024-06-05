Return-Path: <linux-kselftest+bounces-11241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F98FC7A5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 11:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B5D1C20F40
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Jun 2024 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67BD18FDBC;
	Wed,  5 Jun 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tATS6KKm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93111922D2;
	Wed,  5 Jun 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717579317; cv=none; b=tz9vY0W8wLb01v/hBEaKKOGVuqB1VDRsJGuTzRaRD4tz2jpqBjwTba9MCK6G61v2mp8a792N/WIttJof0OB+eZoOXaA5Oc8CCrE5x/Gtvlfek8UBVas+q5O1JLrIW9JaYcMgNg2/wgF6UkyQFF2wsL+FjKDAll2iMj92SNnpa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717579317; c=relaxed/simple;
	bh=8P3FRjsCJEzDXjJHU+ebT7e/zra1DAmqDTABQdJrGvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atirvqcldcwHAsU4O30GPDYQjf9e7Ypc2ysEmqBqNNwm/OO0jUlOiFq2T1d8NtWmDddySKN1KhwwFGGNhDJ6SrX4GN0VOIPc81lzzqHH4KjKvJx6pioEpkoaCEYAOF2n+cJVhViGSBp87Km48RdXvRzRjvibMbexE1HGUwiqAhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tATS6KKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CBFC32781;
	Wed,  5 Jun 2024 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717579317;
	bh=8P3FRjsCJEzDXjJHU+ebT7e/zra1DAmqDTABQdJrGvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tATS6KKmR+QkxjIT2Wsql1HRYBVZocSUE/m++vf3bWsXWw+VgFSQ99GDgzG3y41pJ
	 FtmMaENxUp3Yr5mjOcRM2C3e2dlU93M0fNMzfD/I08cNWyVQVsMK7XSmdW09FGby8S
	 u+0uIq+5gqgcvZhWkkC6zrn/hRHwM39OerV9bFRBsIqdSXvnRLpC2YB+7mLh8XfLT4
	 FOxIhgAUgwrVnSS+MwsLM2yafmH3/yPHdMWFugTr3OHuXFKmRjpgKaMXsPswX17fTX
	 gL0lSPLpYr5e0N/wdAMdENVE6qMWd1Axzm+hclOWc4jWhBn0dJUbBF4GtwTB9F3R99
	 joqeaV0razKig==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 11:21:18 +0200
Subject: [PATCH net 3/3] selftests: net: lib: set 'i' as local
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-3-b3afadd368c9@kernel.org>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8P3FRjsCJEzDXjJHU+ebT7e/zra1DAmqDTABQdJrGvg=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGZgLiehkfETklVcL6kiyeMZ25HVrqQyKurMNJfqTMuViABsq
 IkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmYC4nAAoJEPa3gk9CaaBztswP/AsM
 NFpBCj+QO3MUO5BAadFkNCsQXfDciG9ZoOUlQf0mnjcbK90K82iStHfA9uqQPInYWcECTl68/kD
 7Y91s96zW2ibzCS+FPgpJbuHyZCIYKEUT4I5kdsBgI1MiidWIROdY0Rc/scGgydeMhUWP2+Xmfy
 9ohF/+filwHnTCRyEeY95SCrJAi2BmGyz5q+oGpebZBfpaLLUjiWfThJbBGlQ+ZEalESJs2jhIQ
 QYa+fzDW+h/A87Q9nTjCxtCV/Jm+buo6Q/nNHfGdOJLiPwdNOprRGgxxJNzfb/jq5KG6xNNy3eB
 JIgrw81Xva5cqigPxgqDXicqd0NaDLKnjJf77zNmPUaPAy0slrpULXQyj7gW9bCSXdJQY+D4vyV
 XCYJdvtNZvV2abzJ6pw/xYGJj5xePTmqiOaI/AycmWw1jGe4smPe9lfkdXxNRnUyNF6GEdOdWM1
 229SXuw1TL86hEbV3ZtKfVV5w0+jc3vOkN+K7uABdHSqp8Kjs6UmJJmDk9btKNBiaBmIVw97QJY
 GFdHTHu2CZjmDGL2Um9NfxRvhHczrLdnn7UPDLJYfTOGzySPNibGYnV6/Pu6VPHgSZ6PZJGiQx1
 kXsDvE+SWvUjxy2b4KhLF9mO+VHUZN7i/UHXYmtzqQWomyx9YdZQ8Uq8HQ97pfoiqsdYAvOWsLn
 /miyX
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Without this, the 'i' variable declared before could be overridden by
accident, e.g.

  for i in "${@}"; do
      __ksft_status_merge "${i}"  ## 'i' has been modified
      foo "${i}"                  ## using 'i' with an unexpected value
  done

After a quick look, it looks like 'i' is currently not used after having
been modified in __ksft_status_merge(), but still, better be safe than
sorry. I saw this while modifying the same file, not because I suspected
an issue somewhere.

Fixes: 596c8819cb78 ("selftests: forwarding: Have RET track kselftest framework constants")
Acked-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/lib.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index e2f51102d7e1..9155c914c064 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -27,6 +27,7 @@ __ksft_status_merge()
 	local -A weights
 	local weight=0
 
+	local i
 	for i in "$@"; do
 		weights[$i]=$((weight++))
 	done

-- 
2.43.0


