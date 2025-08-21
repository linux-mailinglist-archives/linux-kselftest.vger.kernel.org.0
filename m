Return-Path: <linux-kselftest+bounces-39508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15EEB2FCED
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44B77582779
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7AB326D43;
	Thu, 21 Aug 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="FChdCC9T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B43274667
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786116; cv=none; b=qk9Mapa+uvK9t1wnQDtdvTqsEOGQtUNjxOhyGj/uBBAiHCS9cqFt9+H1P3Q21RgGm9oL4TGtxawrq0T1rOtxAariZSda5lpt4e+bTnjQOF+lPKxkWCbKmXFPBiSHAkmUF08UnZu5SPQMkiVmlluGV6nb+AOkTtT+DYqxph3mPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786116; c=relaxed/simple;
	bh=sc1LRY9wxfJhyEkCNT+gvnBzPwB1KzMkTYDX249gnLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB4V+sSXqqtBi9KGeBXGguHicqt0xPLVkOOBbly3LjbB3v2T4/o/C6m24fduUxcm67++HREvQ/HuGmMqj8LUGM3n/xVSRCWztn2uudwBmkafwfyUOPmErAgXU8ONazy0H+jCccD9cG1UBuiiT6eNo/t7NoXFxrY89Pjv5IbxkhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=FChdCC9T; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755786112; x=1755793312;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=5rawqhjXiGbRr3VXLAx+apZbtahFA21OZMMwwvU91HE=;
 b=FChdCC9TAuUjQVEF97qmRavTfj04W9/Vsbb6M+3EdfhmK8ZiH0RZexbjIKnPDgFKN2FTth89HCgvv67t4aKbIHCyuYO26E3URSB8QZfMfJ4tDx04YPqkr7j0h/e6H925GekA98ZOg6u2CaEyli0/i+nuU+xab+89utJ3MyCfHZmLP56DcvlyANj9wS8/c4TquI5I9yStRoRCbDsSS774sQSERh8byrYhiHRxka6naI+K6Yzs1lGiZK828j6Q1CwinlhnLs7YwSzWPYxB/my3FfbcmeGScvOQC2MJBRpRubz+tpSNpZdbKi26eeVrH1eHHsOk7uIfmvG3k0EsREnw9g==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 7b15455cfe8dbafdef49f89608815e4823a50a73c49b1f725c695bfcd1e1c385 with SMTP id
 68a72b80ca5807a38b2dd9b6; Thu, 21 Aug 2025 14:21:52 GMT
X-Mailgun-Sending-Ip: 185.250.239.4
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: alessandro@0x65c.net,
	linux-kselftest@vger.kernel.org,
	liuhangbin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Subject: [PATCH] selftests: rtnetlink: skip tests if tools or feats are missing
Date: Thu, 21 Aug 2025 16:16:51 +0200
Message-ID: <20250821142141.735075-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821142141.735075-1-alessandro@0x65c.net>
References: <CAKiXHKejzOAiieTxZpq8+v-vnzSEyuOuD0tYbzHL5R78iS+BMQ@mail.gmail.com>
 <20250821142141.735075-1-alessandro@0x65c.net>
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


