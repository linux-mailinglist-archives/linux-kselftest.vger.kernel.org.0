Return-Path: <linux-kselftest+bounces-32447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3134AAA460
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 01:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362B91887253
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19C228C2CB;
	Mon,  5 May 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNOVf6Zk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49DB28C2C2;
	Mon,  5 May 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483974; cv=none; b=tC2wLXpHXit3Iunq37zh5n/MJE61DbHU47A0LtrQx+oORS2W5kg53oMWWMkJnaBRCGMULRsbodmttxusSUlH6T08js2fXJyPA5loP+xZgykFXSZPfW7idE8Y6Nwm1b/1xsQXCglnucUCz2WWX+Yls0YbyQ8ewvFInJ3z+jUxfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483974; c=relaxed/simple;
	bh=Z9n9wiIPdC41RfHmTwLHjKY+A1WrsoMrfXOJKYq3Qso=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jHdeavV6HDFYb11BH72mtkAcBucxkJx4j4Cwtm7+5icTybjb7jowa7PwSf5QYyiFuRao96mzoG0x3xRU3IEfjIviuMqMZNJC1wNDwr4SwGbd99T6ncFmQ8GiynCQmlA42vw653FZ66Rl4DE6PmEQXeEMiGtz65RPvNBf1Nn3gc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNOVf6Zk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9600C4CEF2;
	Mon,  5 May 2025 22:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483974;
	bh=Z9n9wiIPdC41RfHmTwLHjKY+A1WrsoMrfXOJKYq3Qso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SNOVf6Zk3IzSYeIwJCU4j+TwOTPd+FgdDWIal24FD6Xtd8GMgfTGD7ZJgXnpT/Ub3
	 Y4clKyk8lhngAr1NAxy1b8u63BgfF7YdYTd1DtCqejHu0yYYce4TJQ7ToCuFEPGb2F
	 yLJ2HzVTmVTckQsIRxBHNKcYwYFwZ49t/AJWrQgUjkgUCbXwYYxbCc93XRnUjkds/f
	 kFOleJgrCJcTltJ/y8dbBB9RgMlxi79KDakMaWzd5Mz7T/ktrL2c5pnYkumsPJ98M4
	 93MCeykcW2rsbr5+r0EQJxxJm8odZhvhcmReKOenvgg7ytDaWkIMECG6shZVB/86ff
	 adlQIb4kjjVfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kevin Krakauer <krakauer@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 300/642] selftests/net: have `gro.sh -t` return a correct exit code
Date: Mon,  5 May 2025 18:08:36 -0400
Message-Id: <20250505221419.2672473-300-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Kevin Krakauer <krakauer@google.com>

[ Upstream commit 784e6abd99f24024a8998b5916795f0bec9d2fd9 ]

Modify gro.sh to return a useful exit code when the -t flag is used. It
formerly returned 0 no matter what.

Tested: Ran `gro.sh -t large` and verified that test failures return 1.
Signed-off-by: Kevin Krakauer <krakauer@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250226192725.621969-2-krakauer@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/gro.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/gro.sh b/tools/testing/selftests/net/gro.sh
index 02c21ff4ca81f..aabd6e5480b8e 100755
--- a/tools/testing/selftests/net/gro.sh
+++ b/tools/testing/selftests/net/gro.sh
@@ -100,5 +100,6 @@ trap cleanup EXIT
 if [[ "${test}" == "all" ]]; then
   run_all_tests
 else
-  run_test "${proto}" "${test}"
+  exit_code=$(run_test "${proto}" "${test}")
+  exit $exit_code
 fi;
-- 
2.39.5


