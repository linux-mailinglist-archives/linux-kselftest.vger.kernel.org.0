Return-Path: <linux-kselftest+bounces-10577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA3C8CBF68
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 12:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8D7DB22086
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 10:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8319C824B9;
	Wed, 22 May 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM5JRFm4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD7F8002E;
	Wed, 22 May 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374715; cv=none; b=oUFZJ7Y2+A1L2woZ/oa9ZXZjSzmECuYLdxTkjwjZ+BSsiKlSB43OORfaZauhVA02xCPQtFxgb/3XfWTguJ5zQ58FZebNXXtkB5r9WKg1fhOB566ta2dAndw8rvO0fYyRZMZPLkx6PQFxMEZIe1vCabm+nFZxpY7qG2n2Vdk0Vpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374715; c=relaxed/simple;
	bh=dRTc1r4KQhteacaPrdMDQDt2RjSh7lauv+03KZULIZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X3Nyv3cAjWRq3NlJDiJtl7p4cWj3r6u67ZW07N7+lSRvLdWWBCJHYoo3Oe7RF0Wzqt52Dsf1cOZu0GJp7NL1W8igm2/f9TXh4e7QDY6qwaNDbrmkPQSouW11/9RIYCrtZyreAfE+BCASwFQC9nNTuS8YmADGfp5lV5fpJhZ52fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM5JRFm4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6A9C4AF08;
	Wed, 22 May 2024 10:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716374715;
	bh=dRTc1r4KQhteacaPrdMDQDt2RjSh7lauv+03KZULIZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=XM5JRFm4pXd59QHTpj/f6eqrgggfmAwGhZ8MGmO2uCvBr687kA4xqQTZYhBs0KMMH
	 +dCJMRB+z9hbrKQVy9Rmno6fIyA4MyiSfZocMzLy5PFwTLYHIYraKIVEG9ELP+QDMZ
	 GGdOUQbcoamIdgDA4YW6JCPXMmEX21OHka6nvXsoYcXfESEae8lEHBRE5W4eOyCbtA
	 5mf2opDFrRTgdOxMmbTERjNi4UB5auQFHzSg5NJV1xcKUyuTSS1W4yMpv/45TgmEFe
	 r3MapVEviTpnmOZ38ca1rxD8xgwN+X/5zEg2FzQxJUQ4ZpNkq8VoDAdYN1tsEr8YRS
	 NZORcAc2MLb4w==
From: Geliang Tang <geliang@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukasz Majewski <lukma@denx.de>,
	Hangbin Liu <liuhangbin@gmail.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v2] selftests: hsr: Fix "File exists" errors for hsr_ping
Date: Wed, 22 May 2024 18:45:04 +0800
Message-ID: <6485d3005f467758d49f0f313c8c009759ba6b05.1716374462.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The hsr_ping test reports the following errors:

 INFO: preparing interfaces for HSRv0.
 INFO: Initial validation ping.
 INFO: Longer ping test.
 INFO: Cutting one link.
 INFO: Delay the link and drop a few packages.
 INFO: All good.
 INFO: preparing interfaces for HSRv1.
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 RTNETLINK answers: File exists
 Error: ipv4: Address already assigned.
 Error: ipv6: address already assigned.
 Error: ipv4: Address already assigned.
 Error: ipv6: address already assigned.
 Error: ipv4: Address already assigned.
 Error: ipv6: address already assigned.
 INFO: Initial validation ping.

That is because the cleanup code for the 2nd round test before
"setup_hsr_interfaces 1" is removed incorrectly in commit 680fda4f6714
("test: hsr: Remove script code already implemented in lib.sh").

This patch fixes it by re-setup the namespaces using

	setup_ns ns1 ns2 ns3

command before "setup_hsr_interfaces 1". It deletes previous namespaces
and create new ones.

Fixes: 680fda4f6714 ("test: hsr: Remove script code already implemented in lib.sh")
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - re-setup the namespaces as Hangbin suggested.
---
 tools/testing/selftests/net/hsr/hsr_ping.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index 790294c8af83..3684b813b0f6 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -174,6 +174,8 @@ trap cleanup_all_ns EXIT
 setup_hsr_interfaces 0
 do_complete_ping_test
 
+setup_ns ns1 ns2 ns3
+
 setup_hsr_interfaces 1
 do_complete_ping_test
 
-- 
2.43.0


