Return-Path: <linux-kselftest+bounces-4803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C17856C8C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96EC41C21DE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA851145356;
	Thu, 15 Feb 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewC9O0Ii"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C31145340;
	Thu, 15 Feb 2024 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021567; cv=none; b=gqnAgws/1vLeK8rwds2q/5t0856VSVwfNwSVoPOGNSkUsnRcqITQeHL8rZuxXq4eRcd4b4Laa0URvcoGLl5deQVCGMC/cAPNmiAKkR1ZdL+2qQ/9Un4m6uDesq4uWdm1B1cwTVNs+mJBCCuBQSh1Bd2259idjQKbIdK1XTPYGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021567; c=relaxed/simple;
	bh=I8tMy3gnZsswLPWO4mHgqxW2pTFHXbmUfYVHfI6K9Jw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iM3bEGIsBykCaIkeTIXdbM9ykBPyulOQNd3AA96cXuGZlkJlCGbl/awrQNvvY9mdK3E7M7tNTtz51HeDQzQ5dQHcjOEjsYHG2QedVlnpjAczZOlnEYjUhRE+Z0fFoq7B+qx5CiwboIQy6bgBR173spCXg9w0h5zkxO5eLDrTCVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewC9O0Ii; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57816C433B2;
	Thu, 15 Feb 2024 18:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021567;
	bh=I8tMy3gnZsswLPWO4mHgqxW2pTFHXbmUfYVHfI6K9Jw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ewC9O0Ii2Ed82h/9pT3SnHkJ3t0Ei0dG/ES3LquE9YAXlQ/hhKYU0xTREvbnX/kkE
	 E1Osw8pix2a07pkOVEbz1/Bbf1o2hvAg5nokYwlesEWCkt+IKJwjaL8tg3FFqQr7hn
	 yci+AwOZplzpbOYUkPFgo5Ge8YYmaHpEHLWK/HXsZJ9eApFZwjRlFPLQcCZo0qrmKI
	 SVc72Xbzmbl9Rz1FmpUYeyrZZJukD1g17oDcG9bSobnwaqJuizCUVcEl3mLxo5kMRZ
	 qMB/dKNPuoa9opSokX8HliYKr2rfapqmypi/hAWGU8v4vqIJdYDxACN/ZZZqA3el5K
	 kbnvoUNZQ+RUg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:36 +0100
Subject: [PATCH net 09/13] selftests: mptcp: diag: fix bash warnings on
 older kernels
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-9-8c01a55d8f6a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=I8tMy3gnZsswLPWO4mHgqxW2pTFHXbmUfYVHfI6K9Jw=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcduQs28cu/Z97JCqjemC0Ze0BwKG58kPlXH
 Ruc/vurVkWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 c7PREADkxziI5UoNVMO+Go6c5uaYWKgVAgzf/DBBaXj+/A4UQHp2cRPpN7ZwB2l8tOu9JJ0oy6l
 17Ju2ZKGb1RKcBmUWAgO2+FJuU5hFfmczle7qyl9RzyL1OQ4kB3zLjjEg5SwS+hYXH9juSEBQV6
 zOCiYnTRjKnOmrAhZaDHgfh2Edo+PaoUi3/5hB7QX+f+gY86SnX4hKVdAg/TnUlnLA6PtcT3wch
 fu/MFwHpYuUjbO8dgj0FsK5+/HoKUd7H/UCXVhEepV9OX6sQYocHEs8atcIcyBT+rP67k9wK6MD
 FeyQ4Wmlw3iZMddOEmsj1AEYc0yiLuRnUEOJKVVVFcDr25BoBpNsT3xjs0c1ZZyKCTW0DMX0lWI
 heqII/9wrj7mHMFVGLQJgQsCGDqKZoRVPGnvgQ4TnFSjU8sgcD5ptF6oYbXhth7j4PxOnsrXaVu
 ubGPTp76ojN9cKk43nPyFGYWd67rFFaCR3n8mZ1gL+7ez9AgSXUoC93O/JKGPetLVgaWP3cJmNE
 Vb5PRYQf9bRUdzBhKuXfes6gedqhUC6RQaudxUJNacfhJtDKYE56GtrIsBt7Mtz2pZx0ahnBueX
 vU6+Fj+gMwd5pFuJRlmbAZKivZw524KIjtG/MZn/rG1KMe3QvIwebxpMy42ujyn6H0sMY0akMN7
 fjEdGZuKyjYdn7Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Since the 'Fixes' commit mentioned below, the command that is executed
in __chk_nr() helper can return nothing if the feature is not supported.
This is the case when the MPTCP CURRESTAB counter is not supported.

To avoid this warning ...

  ./diag.sh: line 65: [: !=: unary operator expected

... we just need to surround '$nr' with double quotes, to support an
empty string when the feature is not supported.

Fixes: 81ab772819da ("selftests: mptcp: diag: check CURRESTAB counters")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 04fcb8a077c9..e0615c6ffb8d 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -62,8 +62,8 @@ __chk_nr()
 	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
-	if [ $nr != $expected ]; then
-		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+	if [ "$nr" != "$expected" ]; then
+		if [ "$nr" = "$skip" ] && ! mptcp_lib_expect_all_features; then
 			echo "[ skip ] Feature probably not supported"
 			mptcp_lib_result_skip "${msg}"
 		else

-- 
2.43.0


