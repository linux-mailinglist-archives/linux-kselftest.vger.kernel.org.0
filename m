Return-Path: <linux-kselftest+bounces-39674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9395CB31767
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90B83B64171
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FBA2FB62B;
	Fri, 22 Aug 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="Uq1d4Z4h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDD6257448
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864908; cv=none; b=ndDjYnHHdAZVxvqyLgKDnR+hx+ijt85hiFe+MEHXqtJ1Be30JTjOAQ/Cm21Fx7Hv3Gl+QWjlzo8vYNrCInpl4Aieo8aH/TW1POfasJdAnt3Ae5RYo8TQ7T270uW4oRSEVHCoSh7JQpvFDyOz3SVMgbp0USI3nANKXCe/zJjK4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864908; c=relaxed/simple;
	bh=MbuzkpNpBJjd9jPnS8Jkw8wvr0U9HiopYBlW1Tz4bKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6n3a8+lm4cb9x0j6sPMrmZgRQ/rz2pN8oXwJqGoz++KxEcnq68yYr6LnTkobhQ5Kn+ANd1uSPa2s7voOr/3mcFwIdkky2cSba0Ie/QF3qYzdZTJL9ZNbkNbMMT+zCL3bdGFhG1wTHURwq+awvvfV2uCxTzYIa2oVPuUR0iTtSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=Uq1d4Z4h; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755864904; x=1755872104;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=B39wn23HoDhdp32XZbA3rEZPRynsttWmC21YDWxhBMk=;
 b=Uq1d4Z4hpjoFcdOu+mSRkzge8vEHaS3hnLRoGxNR/q2yXGyCIpBZ8mO11KK8u336/edSe/Cv4pSykrsxsVuidUKXE1FMyKDDBLZvoujMJ2CA0eI4kaUu3WWKw0KFxpQlIoe4scNBfQskjCuHoqO2s8QXIKrNPw8EdyV6PwWWujbJ7dHYOx6v1Aec9qhNIAY2eWu5lORfCph2xW/NXtJcY1EV8sUPhGPUoJKiAwVfraB5kCeR27JDgKsjeVgh5TJIpSh8xX9S0/85OKDHgXV9iFfPkUuyBe98VdMlX5vpX31ltuIZ9bZf+4zV/CLxrvdOcM5XqFtvxdJPPfeC2dssWw==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 768ff15aeb8381866dc49adec9f57767686591a2ec2869842b26002dbfcaba46 with SMTP id
 68a85f48ee121590a3baacc1; Fri, 22 Aug 2025 12:15:04 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: liuhangbin@gmail.com
Cc: alessandro@0x65c.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v2] selftests: rtnetlink: skip tests if tools or feats are missing
Date: Fri, 22 Aug 2025 14:08:42 +0200
Message-ID: <20250822121456.874759-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822121456.874759-1-alessandro@0x65c.net>
References: <aKfDOSx3C8NbMJsw@fedora>
 <20250822121456.874759-1-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some rtnetlink selftests assume the presence of ifconfig and iproute2
support for the `proto` keyword in `ip address` commands. These
assumptions can cause test failures on modern systems (e.g. Debian
Bookworm) where:

 - ifconfig is not installed by default
 - The iproute2 version lacks support for address protocol

This patch improves test robustness by:

 - Skipping kci_test_promote_secondaries if ifconfig is missing
 - Skipping do_test_address_proto if ip address help does not mention
   proto

These changes ensure the tests degrade gracefully by reporting SKIP
instead of FAIL when prerequisites are not met, improving portability
across systems.

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>

---
v2:
- Updated the patch based on review from Hangbin Liu
- Changed subject and commit message to better reflect updated behavior
- Added Reviewed-by tag

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index d6c00efeb664..c2a0e7f37391 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -323,6 +323,11 @@ kci_test_addrlft()
 
 kci_test_promote_secondaries()
 {
+	run_cmd ifconfig "$devdummy"
+	if [ $ret -ne 0 ]; then
+		end_test "SKIP: ifconfig not installed"
+		return $ksft_skip
+	fi
 	promote=$(sysctl -n net.ipv4.conf.$devdummy.promote_secondaries)
 
 	sysctl -q net.ipv4.conf.$devdummy.promote_secondaries=1
@@ -1201,6 +1206,12 @@ do_test_address_proto()
 	local ret=0
 	local err
 
+	run_cmd_grep 'proto' ip address help
+	if [ $? -ne 0 ];then
+		end_test "SKIP: addr proto ${what}: iproute2 too old"
+		return $ksft_skip
+	fi
+
 	ip address add dev "$devdummy" "$addr3"
 	check_err $?
 	proto=$(address_get_proto "$addr3")
-- 
2.39.5


