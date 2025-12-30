Return-Path: <linux-kselftest+bounces-48017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 969D9CEA203
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 17:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F8EB300B686
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 16:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DFD284684;
	Tue, 30 Dec 2025 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="IMpeeOfK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster1-host5-snip4-1.eps.apple.com [57.103.76.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1531D726
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110658; cv=none; b=PqFEWyRsQ0tRpXcYhcCXJHMLNio31O+BeWdCdit2XhS3S9HcIsNA23eII54IEKioxw/nIy/cfttlj+oRvYYKRyKi4sxrU9gA57ujXcFy4A6et94VkQb90EnMaR1Bj9eNzwS/QRWdGN7cuL/OXDaB56CYlKSnT6w+HGpiPZgDDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110658; c=relaxed/simple;
	bh=MkTv3QKFQS2K4w87Zd6z6dxuBD0mi5/2F9cxHWGpcJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRA/iz1BHNSDpNcf5uzVxxL9d/eq05KjXlFKURPzgklXVijdp445DvZLuYbnyKjxCvqz1C8WJAi8lkEzRgNra0XtEpesgqZs8eaWDLRRlHl4mhEGsLdS+mvzHXuMGxbRSCWpozlyorkRc5g4zMXChS2eA5GdEjdcfwSzhrWXx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=IMpeeOfK reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id 41E4C1800BE6;
	Tue, 30 Dec 2025 16:04:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=GpF4ogiw53fTzVzp0SobYz28m0uHRxcdyzlZ3lDUN/s=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=IMpeeOfKB3ijUuhWl6PyzttfdQ4JSorNfoh5qqjnFAFymexs3QlPrX9qG5v3fycHd9VHIlygqnbSdfMb59a6vZ0doRF2TPg45UBnqeRFM3biLUf7pHv7rl0TpvIsqclw2BOoLJmgKC46+FruBvTfaSv7J7gqSU9i3q8rBTJkvR+t7KRtblOV1GXy3aDIexKG+1cAS4qY4ldyG0T47dG/2d02g9lXpkDudHo9ms3gl494IjFndlKwbClvNqn2Xxt2WTcp0QEKaex5cN3oRVpO9pqvlR3QWUEXQlDkhpjX3IEfX9fWXmHqEzYkaDAksxkwc7HUTbi4mrDR7Rx0RalbYg==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id 417F41800BE9;
	Tue, 30 Dec 2025 16:04:08 +0000 (UTC)
From: yk@y-koj.net
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 2/2] selftests: netdevsim: add carrier state consistency test
Date: Wed, 31 Dec 2025 01:03:30 +0900
Message-ID: <fb83c44f5194213fc9503ab2f66eefa0eeda8acd.1767108538.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767108538.git.yk@y-koj.net>
References: <cover.1767108538.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE0NSBTYWx0ZWRfX0CN0h5c+3lYo
 Xpi6UzO+z3kSVpKPJifuKDKg+fVZYSem2BLG5tmIs+fRIKknJQftNvoDLNPNbbv6dxRunwtkGWH
 mUbARlFeaoO1sWNoX2dbLPp0nmwtLEYe3WDpbES2v+H64a+//VJAkC74RwgO+js7gbGGPfR/onL
 y2MFd4cg5svJIydFQZ2Z8QpDHJ8eX1v1omtM2+sFd0eeW17s7PIJMDE9ay5duqHOXKmN7DNVceb
 OinpcJyrdQFdY0ZuERLyZiLNWGQtFQl/mVkQntUXRoZ7aqHyWKmVnpUAPFlA//KPJpzdmcqC09O
 lpU2pG/AxjtW4ewe3UX
X-Proofpoint-ORIG-GUID: S9HOWODBr4o_5uWp_s1_cektw52tRKGv
X-Authority-Info: v=2.4 cv=EfrFgfmC c=1 sm=1 tr=0 ts=6953f7fd cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=dxafgm9mWqSCDGKd2yIA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: S9HOWODBr4o_5uWp_s1_cektw52tRKGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_02,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1030 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512300145
X-JNJ: AAAAAAABQna/sCR3AEVgrarNS9gmppod68NjbQdDT1rhtV8HD1UVi69nEhDTzNIMdnVAgvplYYHnUTEpheagzaS37o2shg5D95C8zNQjrLHcGSPG+KXUhm/4Xdl0NPylmQrERJVbepOND/i1Fd3jjlLIXwEyQ0LaUYcYVHO+RG3HqmLkjV1A7oeZCgkEEOMsafVmGHcO2CwWR0GZalIPbKzZ+X5otiJRAeW3GCjM/uLWMtMo4XL7d9og+kkN48/ZflwDQb5WpLOHkdoy70Hy4RQKV64UMd7M5Vc+LOlyAS+v0xW75yKyXxkCEkqN+wnjTNQzBv0SWJC42rWVSx5sZuKvOxN4WEDeWDaZMZF1WoUOS+uNyRArQkUTtSO4EX/40PrgOyMTO7bMQF7dcpVPmRF9FsmWAbQxGBWQ/rq6e7wZpRwcarcukQAbE7fIo7u9nV2roJMYbFIe3cW1HTRKY6elMV/eJMn+L0MkVqWz/1rugzFpvQ9aMAEXrqw7jdBnQXRel/Pgbh5aapUekq8pnFVmOoX4A3DSGFG60ToCUb0rZqjmt2Qntxuy35IKwhLBAeg1yFPAJxe3sdtfeVl9nmmgaupr9keFt1tHIDSYoZ0hh8xnsDSVMm8OshWlbunpvdpGvihFN+pUk179oZz+InMHSWfNG2vj1Mt5jcKc+Rz2+2gj/Url451cHEzIpDsbDx3hHPmfc+SFgr/6A6BoxvnqtaSlPGpEoRoXT8kTPVLtpuckofET7Yk=

From: Yohei Kojima <yk@y-koj.net>

This commit adds a test case for netdevsim carrier state consistency.
Specifically, the added test verifies the carrier state during the
following operations:

1. Unlink two netdevsims
2. ifdown one netdevsim, then ifup again
3. Link the netdevsims again
4. ifdown one netdevsim, then ifup again

These steps verifies that the carrier is UP iff two netdevsims are
linked and ifuped.

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 .../selftests/drivers/net/netdevsim/peer.sh   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index 7f32b5600925..4ca994d2aa31 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -52,6 +52,43 @@ cleanup_ns()
 	ip netns del nssv
 }
 
+is_carrier_up()
+{
+	local netns="$1"
+	local nsim_dev="$2"
+
+	# 0: DOWN
+	# 1: UP
+	local is_up=$(ip netns exec "$netns"	\
+		cat /sys/class/net/"$nsim_dev"/carrier 2>/dev/null)
+
+	test "$is_up" -eq 1
+}
+
+assert_carrier_up()
+{
+	local netns="$1"
+	local nsim_dev="$2"
+
+	if ! is_carrier_up "$netns" "$nsim_dev"; then
+		echo "$nsim_dev's carrier should be UP, but it isn't"
+		cleanup_ns
+		exit 1
+	fi
+}
+
+assert_carrier_down()
+{
+	local netns="$1"
+	local nsim_dev="$2"
+
+	if is_carrier_up "$netns" "$nsim_dev"; then
+		echo "$nsim_dev's carrier should be DOWN, but it isn't"
+		cleanup_ns
+		exit 1
+	fi
+}
+
 ###
 ### Code start
 ###
@@ -113,6 +150,32 @@ if [ $? -eq 0 ]; then
 	exit 1
 fi
 
+# netdevsim carrier state consistency checking
+assert_carrier_up nssv "$NSIM_DEV_1_NAME"
+assert_carrier_up nscl "$NSIM_DEV_2_NAME"
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_UNLINK
+
+assert_carrier_down nssv "$NSIM_DEV_1_NAME"
+assert_carrier_down nscl "$NSIM_DEV_2_NAME"
+
+ip netns exec nssv ip link set dev "$NSIM_DEV_1_NAME" down
+ip netns exec nssv ip link set dev "$NSIM_DEV_1_NAME" up
+
+assert_carrier_down nssv "$NSIM_DEV_1_NAME"
+assert_carrier_down nscl "$NSIM_DEV_2_NAME"
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
+
+assert_carrier_up nssv "$NSIM_DEV_1_NAME"
+assert_carrier_up nscl "$NSIM_DEV_2_NAME"
+
+ip netns exec nssv ip link set dev "$NSIM_DEV_1_NAME" down
+ip netns exec nssv ip link set dev "$NSIM_DEV_1_NAME" up
+
+assert_carrier_up nssv "$NSIM_DEV_1_NAME"
+assert_carrier_up nscl "$NSIM_DEV_2_NAME"
+
 # send/recv packets
 
 tmp_file=$(mktemp)
-- 
2.51.2


