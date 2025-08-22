Return-Path: <linux-kselftest+bounces-39681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB151B31AE2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 16:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB5B5E3810
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 14:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8BF3074AC;
	Fri, 22 Aug 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="gZCseIz5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m239-4.eu.mailgun.net (m239-4.eu.mailgun.net [185.250.239.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCEB30748F
	for <linux-kselftest@vger.kernel.org>; Fri, 22 Aug 2025 14:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.250.239.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871610; cv=none; b=ORqOQ+R3V39UqolRsnJY2OYeOKb6h0Y4VsjPGwoW9bKZAmxBLWfBdY+zqlMsh9yE+Xv149ZWKVGlcmzLVO9fG3uVaOs0OuMJw9Z/5Hi66VebFVhX6i4hMXBmi2RBYRoSUpPjWOg4+OLcBKlI5zNpqZaY3FGT9FB6mbN0Qj2RX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871610; c=relaxed/simple;
	bh=A49T0iTuxKuH9Iw8EBG9Ezz7qGMChLoiwF1vQk0mQf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUq2hsNZ+MiwRjHrQWJdDHJlMc/eHs5bFJBhEdNFktO9Qv9tzBeieRp3pZcoGgPpETrGxqj6xX4ggMZQ72nO9UBZsVolhnFl5KfHnif2vzp7RUoipArFNakVOXqv2Sh3/hofh+B4k63M6kv4g05IsolVS9N0CjBcETulMX+4cbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=gZCseIz5; arc=none smtp.client-ip=185.250.239.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755871606; x=1755878806;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=4zeVSA5+Gic3I+n2aSoobR2zbfUVYcXif4yIK24vQoo=;
 b=gZCseIz5PKL3fepoBJu0ekmadE1Nv+O4F0q8D2KO/RByuf8AyuLAQphDwsn5vKvby850FhtMdM6FIcHDV81VWpdy/iDQQXj1LQLAIzaMI+mNFXY6D89D63SN6pUkvL7PV2sg9CQ5VMcXLeo1umD2kPLZXWwc5Ih/58g1HCV6dqeRkZnp/M/OPQPA0MUk0qdUD2qqOXRxSJor/8GWINhgOx9oUx3AMpc2dIv2ryKScGHFR7iFjGUURkAKC4DsjEV3pdDsHeH3Jxw1+emWgsNJfjQYhEpEyY5egimYerfwEYXEY8YnHxmbGR2RsDLX5ex55IUmY5RFUrsgBeJXUhoi0g==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 6daba92ea63ccfff060124925e5e264487e90b9321cf65b2c1448e79f35e349c with SMTP id
 68a87974ec4fa32e70ac11e2; Fri, 22 Aug 2025 14:06:44 GMT
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
Subject: [PATCH net-next v3] selftests: rtnetlink: skip tests if tools or feats are missing
Date: Fri, 22 Aug 2025 16:03:40 +0200
Message-ID: <20250822140633.891360-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822140633.891360-1-alessandro@0x65c.net>
References: <aKhqmsheZAqThrSu@fedora>
 <20250822140633.891360-1-alessandro@0x65c.net>
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

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>

---
v2:
- Updated the patch based on review from Hangbin Liu
- Changed subject and commit message to better reflect updated behavior
- Added Reviewed-by tag

v3:
- Amend Reviewed-by tag position
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


