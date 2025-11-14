Return-Path: <linux-kselftest+bounces-45669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5A4C5ED31
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 19:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 742E8361885
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 18:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7934334B1B6;
	Fri, 14 Nov 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2dDt7mr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D934B18B;
	Fri, 14 Nov 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143959; cv=none; b=F1f1S5myMHl03gy36x6LxGX/tBgM9SpK+E6yrJSQS6ccZT03ml7sXiwu0EgOD1t0ozpSrQqrAtN08czUdydNQEBbqQGk8KbzUzJ/YSNELubPf6aulpCSwrAf1du4fWo09xVGxR5P4vPd6lDMlWhBU6E2Gbz2gyld52CBIzgxIOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143959; c=relaxed/simple;
	bh=nEl2T66irRmp4tRPy8x4wUYialN5rIBEJihyOUMUTDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGfIZbdRkwwJ/61YwIzCc3+e0ej93NYnURBgbCpix8NeRxotKCoSEBDj3CXvfJMQAfguJya8WC5IGTNfI09FKfL7zfHaFa+f6feo0oNU3BJ4v54AXqlOg05l3VBg7zDfeVnCC3wgK720p9zvVzck747T4TRIjqWQucfTs60cXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r2dDt7mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB09C4CEF5;
	Fri, 14 Nov 2025 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763143959;
	bh=nEl2T66irRmp4tRPy8x4wUYialN5rIBEJihyOUMUTDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=r2dDt7mrCia0ncEYdI+eZONIldJ83NCTuw5j08iMa2CO+w0Bq1pfmR8AgVBHBtnDS
	 MZR3QfdIrKGKYj84UVp3NWvxyDon7JhYMX4cwJqd4ufTFRFiLTmvPVhHNHh9qybRrK
	 21wATF5eqFeM4HCMmzyyD8sVRb6qdcq5NhcYDdpTYrGIoXDVmtbcxy/2hXEH1xXnk/
	 QUQMhPWDuXG0OUX1hDpiudnm5L5TXJZcPriPmyVUGut4tQtn2Efhx9oLXyE9wyF8GZ
	 DsTycb4jR0ZylFpV1Jvkmz12+cw9SnqwWm3gPTS/YM6hLs/N9ZOzz6FxA2TZvociTH
	 mc33CFGzg+J9A==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 14 Nov 2025 19:12:10 +0100
Subject: [PATCH net-next 6/8] selftests: mptcp: connect: avoid double
 packet traces
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-6-863cb04e1b7b@kernel.org>
References: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
In-Reply-To: <20251114-net-next-mptcp-sft-count-cache-stats-timeout-v1-0-863cb04e1b7b@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1962; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=nEl2T66irRmp4tRPy8x4wUYialN5rIBEJihyOUMUTDU=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLFCxmtv57jlc52acpbqX9eyS3AhONDwIH1b/6eqmKwv
 1Ue3jy/o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCLm3IwMZ+4LTbc8GqPzNt/Q
 JuOGVer2Nwf63PcU8q3Zahng7SoewPBPidfSOG+ey9tLwgx/fIMv3w16lvw7d+Ea4zAdM50qvVJ
 mAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When the same netns is used for the listener and the connector, no need
to take exactly the same packet trace twice, one is enough.

This avoids confusions when the traces are the same, and wasting
resources which might not help reproducing an issue.

While at it, avoid long lines and double spaces now that these lines are
no longer aligned.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 3a804abebd2c..e0bfd9b4730c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -375,11 +375,15 @@ do_transfer()
 		local capfile="${rndh}-${connector_ns:0:3}-${listener_ns:0:3}-${cl_proto}-${srv_proto}-${connect_addr}-${port}"
 		local capopt="-i any -s 65535 -B 32768 ${capuser}"
 
-		ip netns exec ${listener_ns}  tcpdump ${capopt} -w "${capfile}-listener.pcap"  >> "${capout}" 2>&1 &
+		ip netns exec ${listener_ns} tcpdump ${capopt} \
+			-w "${capfile}-listener.pcap" >> "${capout}" 2>&1 &
 		local cappid_listener=$!
 
-		ip netns exec ${connector_ns} tcpdump ${capopt} -w "${capfile}-connector.pcap" >> "${capout}" 2>&1 &
-		local cappid_connector=$!
+		if [ ${listener_ns} != ${connector_ns} ]; then
+			ip netns exec ${connector_ns} tcpdump ${capopt} \
+				-w "${capfile}-connector.pcap" >> "${capout}" 2>&1 &
+			local cappid_connector=$!
+		fi
 
 		sleep 1
 	fi
@@ -416,7 +420,9 @@ do_transfer()
 	if $capture; then
 		sleep 1
 		kill ${cappid_listener}
-		kill ${cappid_connector}
+		if [ ${listener_ns} != ${connector_ns} ]; then
+			kill ${cappid_connector}
+		fi
 	fi
 
 	mptcp_lib_nstat_get "${listener_ns}"

-- 
2.51.0


