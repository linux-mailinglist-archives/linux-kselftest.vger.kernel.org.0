Return-Path: <linux-kselftest+bounces-4805-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8530856C95
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 19:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662B41F21F1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CDC145B3F;
	Thu, 15 Feb 2024 18:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORXCFC7o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C2D145FF3;
	Thu, 15 Feb 2024 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021574; cv=none; b=csWKgK+fLuDhv01obknyVBDsF2u7DDFJO2Jnp5xKsOPrpDBx9u1VVvpOSlrS4y3VWXGQ+3+XM3EKOi9csy2Z5Penf4kuVhGYsGHrdSR9R8twX8Os/Wnx6byO6PmoKmL6i+6s+zxHdj+AKWQTJejMEIEsHb35d3r2tcwevmkFN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021574; c=relaxed/simple;
	bh=Y9v/Te9flpYVSoeQkyHDc5ogS5iYhmlGbBJS7seYJwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IDGbP7ogDc+E9VWpQiisusQ0TDsnvj12fhn+YaSJ8Lspyk92Mx17lmBRBB6VWItZ+qDtbR3lLHF32Fjn7+QTilhhc7DqMASiq9310xKpZCQb/pjxUwU99UnirSU/TbcQF5bdEnRnxQ/2NEAQu0uuRpJ7OA9LvX2BEQdPNhVmxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORXCFC7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACC1C433F1;
	Thu, 15 Feb 2024 18:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708021573;
	bh=Y9v/Te9flpYVSoeQkyHDc5ogS5iYhmlGbBJS7seYJwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ORXCFC7ohEI5eCA1JzxPRwBYjnbYEDRJ+Y5ChzfkgmwbN3t9vCVgh3ZSxFa5K08sk
	 BKQ9Tj6PoUMnQS7lLhr7vxg543UA0ymLhYFgN4k8Zh6fZQSrN3/IH2Zbys48wRoI1t
	 nHQhF1jkO/UDEyDemFxMTidXqJd/tvbINtErAFtWRaV6Nz4RBOuyhDq8y9TaNSlreH
	 ciZh+RH+2dJrPhC8/1sbrAyNii82JWgMxoxlvtDsmf1Stv1ZzQrn3+C74uPm5NXN04
	 sSMw/vfcX7tI9e36RifTg+AJMCMN/tIhJGj7MsIMLc9s1wH259hbkZGntPpDicmHrH
	 0nLh7rkN+eB3g==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Thu, 15 Feb 2024 19:25:38 +0100
Subject: [PATCH net 11/13] selftests: mptcp: userspace_pm: unique subtest
 names
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-upstream-net-20240215-misc-fixes-v1-11-8c01a55d8f6a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Y9v/Te9flpYVSoeQkyHDc5ogS5iYhmlGbBJS7seYJwg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlzlcdIjRZNJi41Pm9lXfI+qJul5HTX37GAbzab
 GkymdB1gMOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZc5XHQAKCRD2t4JPQmmg
 c2ILEAClrQTO0idvhNjmAnNJuDSfLUGPiZ9bE+tPNbX8wvRaDiEZ+Cv25xma9y/Pnwa0G5Bi2dG
 /J+xD/2Ct/cgJV48breEPLjgUhboAhx1rkKTnuNf2p2BYy5683Rn86vQWWO3jIAylkaGwL6hjV4
 O9VWK7To6C9viLDtLXdITAKIbnKMuKMT1JmGgiaHIIxBDGpl8lMYotnhmIwhWYDAqozMZ30wElK
 prS9aEEAmAQeL0IsIkHXAP6jg6N/ezbDdjl23v3tCNQ5OM7Mao2gGwpOuxPRl+3UfwMO6+ywDtP
 Fkj9FEdPHXHbU5Msnr3odbCjKQQIELNpmJ9Gb8cuo5oPPOPCuKt/Ua04hReBOiogmdj/kkF3z6i
 HulTZkpLdXGi8WK+cWdCT7nDKKtVH9mvMChwr3hu7/wVWlh1K/dMqspix4CCzpYHbTgggZCS2Gy
 fpCxgvIr+awTbVwgtCebzPpeHurr9q88Dh/RUfKbadoaKFzQ9PeF2F6A4CAqhnsS+IPUZfEZ/Wc
 C6aDLVSeMqXujgMzJ/XAYNtsYOxDwfNGx4EAe9lBXDs6n7JtV3IPGLrGF9BCA4yuaoIV3rFHPpP
 9OGXiF4EDwMP3edj4A/5twCqHPtMs/XnuLF2ZMw6LkMfUwdxBwPAtie4Mmy2JvQWSK+cclzauAe
 ukefiA5FWfOhrEA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

It is important to have a unique (sub)test name in TAP, because some CI
environments drop tests with duplicated names.

Some subtests from the userspace_pm selftest had the same names. That's
because different subflows are created (and deleted) between the same
pair of IP addresses.

Simply adding the destination port in the name is then enough to have
different names, because the destination port is always different.

Note that adding such info takes a bit more space, so we need to
increase a bit the width to print the name, simply to keep all the
'[ OK ]' aligned as before.

Fixes: f589234e1af0 ("selftests: mptcp: userspace_pm: format subtests results in TAP")
Cc: stable@vger.kernel.org
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 6167837f48e1..1b94a75604fe 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -75,7 +75,7 @@ print_test()
 {
 	test_name="${1}"
 
-	_printf "%-63s" "${test_name}"
+	_printf "%-68s" "${test_name}"
 }
 
 print_results()
@@ -542,7 +542,7 @@ verify_subflow_events()
 	local remid
 	local info
 
-	info="${e_saddr} (${e_from}) => ${e_daddr} (${e_to})"
+	info="${e_saddr} (${e_from}) => ${e_daddr}:${e_dport} (${e_to})"
 
 	if [ "$e_type" = "$SUB_ESTABLISHED" ]
 	then

-- 
2.43.0


