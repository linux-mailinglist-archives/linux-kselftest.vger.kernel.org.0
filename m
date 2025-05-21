Return-Path: <linux-kselftest+bounces-33469-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6EFFABF7D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 16:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E7144E41D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF2C1A23BB;
	Wed, 21 May 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QLg4w/I5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-16.smtpout.orange.fr [193.252.22.16])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680917E
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 14:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837760; cv=none; b=ZHLWIeE+402euMnn/DhwGfLrOcHuT3AiZbpttZTgLtE1biZXMLr14mjYheUr3/p5CMogzI7YBD7j0jFAsQCUkFOn6byG6ofrlVmyocOkCrSoaaVsDAAWesCxAAHVbqnJBgM1mFbcKZsDXMEIP1FCAnwndHGlN+DJv35Zz+0htwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837760; c=relaxed/simple;
	bh=Q/STPmTu7RpLqcmifIG5b8s9o56dmo6SlfYvJbtLwzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bkdm5yErfMdU9bZqu0E+cUr6FyfVqVo3AwxZCO/WLTZYSLSstdms3+MgVj/rHgsRAKRyKiRiXq2VBpxPlZNx1EUPHX7drW3INeXE5cO0PZVcccvP/MXjy1aCg+a+oYsD2LRt32dSTQdWaiLo2P2rUCretr17yR4KusNJV3/0D9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QLg4w/I5; arc=none smtp.client-ip=193.252.22.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id HkIXuCBk7ftZ8HkIeuL17k; Wed, 21 May 2025 16:20:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747837209;
	bh=PQFIsv362059jYm/0PMO+rM0+yjRL3CD7EbulC0nNSI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QLg4w/I5Sxw1u6InMbClBmA8DSatqmS5NStAx8iXIEWjxFwxv4hV5nRLLPYayDcUK
	 vU8SVThwNsqnwjxA/mM+AIf3fsgFtv8zkLtj/OxuHTA1DXUQxyKcpUQBktER1cyO4k
	 k+R7UJ+f+ySz1mG+kUfWCTEubRiqkzRMqphr17sF+2UdRawaqEXHcgbM5ss8cHeLgO
	 Y7kDkfypt+F8XEybR+9FLlWXDmxfoMJoTFZfI6DW0jrrBhhe66EUgFBKfa0aV4xDuO
	 38T0HMDXodhtnoLoRplZb6A2Z57QARFcvCFjynDOafm1CyOUKUdlP7KRkkjZcXGanO
	 Syvx3Feb06n/g==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 21 May 2025 16:20:09 +0200
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Felix Maurer <fmaurer@redhat.com>,
	socketcan@hartkopp.net,
	mkl@pengutronix.de
Cc: shuah@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dcaratti@redhat.com,
	fstornio@redhat.com,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH] selftests: can: test_raw_filter.sh: add support of physical interfaces
Date: Wed, 21 May 2025 23:18:53 +0900
Message-ID: <20250521141945.13358-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <87d289f333cba7bbcc9d69173ea1c320e4b5c3b8.1747833283.git.fmaurer@redhat.com>
References: <87d289f333cba7bbcc9d69173ea1c320e4b5c3b8.1747833283.git.fmaurer@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=Q/STPmTu7RpLqcmifIG5b8s9o56dmo6SlfYvJbtLwzg=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDBm6DxnNjqcKHbfqNctwrS4oPrbn5bkH5+oPPjyg5eC/z e+F+IylHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYiOo3hf3jdlKN+y2MMV6vn LKt812i10O/n6/k6Lb3RfXMZslbFBDEyrD4dZr+80OLtZ0F7h1CXwDsN+/QFj88/Nfvjmiuz+ra KcAIA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Allow the user to specify a physical interface through the $CANIF
environment variable. Add a $BITRATE environment variable set with a
default value of 500000.

If $CANIF is omitted or if it starts with vcan (e.g. vcan1), the test
will use the virtual can interface type. Otherwise, it will assume
that the provided interface is a physical can interface.

For example:

  CANIF=can1 BITRATE=1000000 ./test_raw_filter.sh

will run set the can1 interface with a bitrate of one million and run
the tests on it.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
This depends on "selftests: can: Import tst-filter from can-tests"
from Felix.

Link: https://lore.kernel.org/linux-can/87d289f333cba7bbcc9d69173ea1c320e4b5c3b8.1747833283.git.fmaurer@redhat.com/
---
 tools/testing/selftests/net/can/test_raw_filter.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/can/test_raw_filter.sh b/tools/testing/selftests/net/can/test_raw_filter.sh
index 2216134b431b..276d6c06ac95 100755
--- a/tools/testing/selftests/net/can/test_raw_filter.sh
+++ b/tools/testing/selftests/net/can/test_raw_filter.sh
@@ -9,17 +9,25 @@ net_dir=$(dirname $0)/..
 source $net_dir/lib.sh
 
 export CANIF=${CANIF:-"vcan0"}
+BITRATE=${BITRATE:-500000}
 
 setup()
 {
-	ip link add name $CANIF type vcan || exit $ksft_skip
+	if [[ $CANIF == vcan* ]]; then
+		ip link add name $CANIF type vcan || exit $ksft_skip
+	else
+		ip link set dev $CANIF type can bitrate $BITRATE || exit $ksft_skip
+	fi
 	ip link set dev $CANIF up
 	pwd
 }
 
 cleanup()
 {
-	ip link delete $CANIF
+	ip link set dev $CANIF down
+	if [[ $CANIF == vcan* ]]; then
+		ip link delete $CANIF
+	fi
 }
 
 test_raw_filter()
-- 
2.49.0


