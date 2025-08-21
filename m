Return-Path: <linux-kselftest+bounces-39461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD83DB2F004
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 09:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FF5D176E15
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B382212D7C;
	Thu, 21 Aug 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b="T1LJ4G67"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m204-227.eu.mailgun.net (m204-227.eu.mailgun.net [161.38.204.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAAF2745E
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=161.38.204.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755762368; cv=none; b=N2Ht8qJJnD2RHVqYefLdD2fd/Msa+NmwJ3CtTXn5WSuJVOK2bFYc+4boWhP75uYbBzWfa95ubz14IJJl+gO0NPsVP03ZcRipAVLd3mmQ5ioXKh0jgdGp5n/dugy2BvR5CqFRTK9edJtcbm5KiZo+zhTGAb4nv6xHwmSixDm7Oa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755762368; c=relaxed/simple;
	bh=kTa6aPcLW7/bGWNd0ucEtWPY4hfPYvEDmPOMrh3xP64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mEHkKRpnxu7nzWgXk1/xD1iXmp/E9Ki8b//ZhFj8OA94x7V9f4O99/ho8OdjMr5yfezof5icOr62bdfwAYU/kRnv32g4MUk4HqEHBfqT3wzs1yQUf7DR4pFolXQqDBnpHsROIEnayBj40JOMZ6aUGWcnH5sKFFaWGb4s4Vy12hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net; spf=pass smtp.mailfrom=0x65c.net; dkim=pass (2048-bit key) header.d=0x65c.net header.i=@0x65c.net header.b=T1LJ4G67; arc=none smtp.client-ip=161.38.204.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x65c.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x65c.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=0x65c.net; q=dns/txt; s=email; t=1755762362; x=1755769562;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To: Message-ID: Date: Subject: Subject: Cc: To: To: From: From: Sender: Sender;
 bh=juB/gAYnTUiUjs6DHxjr6nOjFleWPqyUEmK9XSraXBY=;
 b=T1LJ4G67usJ8ut6dtMZQDaXooyGTAKqPVCLxU2NTn1rSpXn08/IJgMNm18IJwyhGwB4w3TAzh690y4vBpJC/O/AniW9hwCyPghj42PGZmg3ed8z8Z8lXeJkR7/8kkv6yk52n0L7s54zwrGBjpvhoFjk3yPPZLOsFgS342N5udmiuLagDxexAUm4xcjRbF2YGJOVqL6vbw8A9P/gP4CCqvEXEBse6mlGts3FYKfsyx3EAeBmL0vKDuwZXp4G7dQsRKA4BYyVuqBtMv9qqhRwNYKx2A4GL1/xRItBAgnB4gnWG+JjcACLHUThgKcUjsgT79DhZbFmFMr4KWrBpKARm5Q==
X-Mailgun-Sid: WyJlMmQxMSIsImxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmciLCI1NGVmNCJd
Received: from fedora (pub082136115007.dh-hfc.datazug.ch [82.136.115.7]) by
 0915ebfd771c1cc991a8a786c634850dbf8b05025dfa8b8697bc1d69e9166444 with SMTP id
 68a6ceb9ec4fa32e700a628f; Thu, 21 Aug 2025 07:46:01 GMT
X-Mailgun-Sending-Ip: 161.38.204.227
Sender: alessandro@0x65c.net
From: Alessandro Ratti <alessandro@0x65c.net>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skhan@linuxfoundation.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	alessandro.ratti@gmail.com,
	Alessandro Ratti <alessandro@0x65c.net>
Subject: [PATCH] selftests: rtnetlink: add checks for ifconfig and iproute2
Date: Thu, 21 Aug 2025 09:43:11 +0200
Message-ID: <20250821074552.682731-2-alessandro@0x65c.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821074552.682731-1-alessandro@0x65c.net>
References: <20250821074552.682731-1-alessandro@0x65c.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems where `ifconfig` is not available (e.g., modern Debian), the
`kci_test_promote_secondaries` test fails. Wrap the call in a check.

Additionally, `do_test_address_proto` fails on iproute2 versions that
lack support for `proto` in `ip address` commands. Add a minimal feature
check and skip the test with a proper message if unsupported.

These changes allow the tests to run and report SKIP instead of FAIL on
platforms with older tools.

Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
---
 tools/testing/selftests/net/rtnetlink.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index d6c00efeb664..9bff620ef595 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -330,7 +330,9 @@ kci_test_promote_secondaries()
 	for i in $(seq 2 254);do
 		IP="10.23.11.$i"
 		ip -f inet addr add $IP/16 brd + dev "$devdummy"
-		ifconfig "$devdummy" $IP netmask 255.255.0.0
+		if command -v ifconfig >/dev/null 2>&1; then
+			ifconfig "$devdummy" $IP netmask 255.255.0.0
+		fi
 	done
 
 	ip addr flush dev "$devdummy"
@@ -1201,6 +1203,12 @@ do_test_address_proto()
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


