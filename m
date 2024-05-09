Return-Path: <linux-kselftest+bounces-9794-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ABA8C12A2
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2341C20881
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4816F8E9;
	Thu,  9 May 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSN8gp37"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5A650A6C;
	Thu,  9 May 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715271595; cv=none; b=Q3KlVR0v9RY4GJNDFWzlG0+QQLRTsIys/5TPb6qULOOofrI8lCAqs1BtIOLkwntow5jbPOx6h/7vymNyySYEXtfYb9aIffzf6Th2aeki81Uazexl0b4XiStnBRx8y4JB75OSkZvGunIinHNXBNCQR74j5zEwiHAFLDqYyAKJ+SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715271595; c=relaxed/simple;
	bh=TR8sCiB3bXcye6Ig9GARMb5o1wbHoQn+BlfS4ic1eMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJ9B/IlU+g0eFpKkpdiT+6Y5M3rixJO7H4XIqqqA++7XAkIqVzvoVLXNbpeGFd3yrynr0RtHgfuivPjyj0sbikIPAhs/zA3/K0/92w0K7E4IaC0rz3D+ThehVyJ/nK3U9PfgAsiAfDuQomFmilReVeTnWHYnI5rROhmnh9bGSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSN8gp37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9CFC116B1;
	Thu,  9 May 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715271595;
	bh=TR8sCiB3bXcye6Ig9GARMb5o1wbHoQn+BlfS4ic1eMM=;
	h=From:To:Cc:Subject:Date:From;
	b=WSN8gp37Q0c18hIXKhIV0B97UzTry+Yoetjsur+mtrEoT7E7m/zJv/SJD2W8bi+L+
	 ysCbsfX8dqQS2FulsNCf9Gs7hcEaorhNPDRwFV5RuF+4pegIlq8NiXZ1n3uPKSnn6P
	 W/MIA4kmVaFvjcgokX4lG/NNy6+QhcXQaj45qDqtWmUF9TBBNwfuqsVL7MeaGizYKc
	 pwoju04QW9WPqh5KRwmktfg7k9VF7DNcTbucAKGYxacb89fVtalvjDrsc6lE0a4+Yr
	 UCJ+JorzshuWlg1nvqTiGWnatoM2UJHhDtQNloxFRZnF3gIZczL1OYY+UQdZEA/ZnE
	 f6WX2XUkbYlPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	ap420073@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net] selftests: net: move amt to socat for better compatibility
Date: Thu,  9 May 2024 09:19:52 -0700
Message-ID: <20240509161952.3940476-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test seems to expect that nc will exit after the first
received message. This is not the case with Ncat 7.94.
There are multiple versions of nc out there, switch
to socat for better compatibility.

Tell socat to exit after 128 bytes and pad the message.

Since the test sets -e make sure we don't set exit code
(|| true) and print the pass / fail rather then silently
moving over the test and just setting non-zero exit code
with no output indicating what failed.

Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: ap420073@gmail.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/amt.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 75528788cb95..5175a42cbe8a 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -210,8 +210,8 @@ check_features()
 
 test_ipv4_forward()
 {
-	RESULT4=$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
-	if [ "$RESULT4" == "172.17.0.2" ]; then
+	RESULT4=$(ip netns exec "${LISTENER}" timeout 15 socat - UDP4-LISTEN:4000,readbytes=128 || true)
+	if echo "$RESULT4" | grep -q "172.17.0.2"; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
 		exit 0
 	else
@@ -222,8 +222,8 @@ test_ipv4_forward()
 
 test_ipv6_forward()
 {
-	RESULT6=$(ip netns exec "${LISTENER}" nc -w 1 -l -u ff0e::5:6 6000)
-	if [ "$RESULT6" == "2001:db8:3::2" ]; then
+	RESULT6=$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-LISTEN:6000,readbytes=128 || true)
+	if echo "$RESULT6" | grep -q "2001:db8:3::2"; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv6 amt multicast forwarding"
 		exit 0
 	else
@@ -236,14 +236,14 @@ send_mcast4()
 {
 	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
-		'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
+		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
 	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
-		'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
+		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }
 
 check_features
-- 
2.45.0


