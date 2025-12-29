Return-Path: <linux-kselftest+bounces-47997-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC69CE7D24
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 19:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A998E3039319
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Dec 2025 18:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCD329376;
	Mon, 29 Dec 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="1HbAK+IW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host1-snip4-2.eps.apple.com [57.103.79.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C5832FA34
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Dec 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033241; cv=none; b=KcOMHUGxogNTG6oJWAPYqlViNBpNA6IcJnmn6ahTZQkbvKMHxji3eroLFwlGz/+pLK/bIyZuWtBoGiclm2myGnKvAwtIRH2QZQp2ubiLAbcHt33JrSPzkW0we/HU82heCCUhfxzQKGXehLAenRsPftd+RqTykLZgD3+lItMYEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033241; c=relaxed/simple;
	bh=vf47EyzY6AxVg0FPmbEQF9GrB5Lbr7opdeFV21ZDtUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lpc3+qhXtUCzgICyY7Kmc4xAKeRu7g7CvSQwqU3iEKdoknlLZwHJJXhYqZl3jNhXorU0GqbOwaOFo1tzTHt7E5mEKy3o7KLazRXamy4898tvqrAH2xCqhlFxXjh3eK4duUDKBimNdAP2oh0R8d29mwfS8GJ7GekEmmz2hyKQrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=1HbAK+IW reason="key not found in DNS"; arc=none smtp.client-ip=57.103.79.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id 79EDA18000AF;
	Mon, 29 Dec 2025 18:33:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=+gPJX72dm3Z/j64tA5+lwPP2RcIoUalSiRzTLH1ZISY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=1HbAK+IWPwqrsGBSIZnDYIlB1IeGYRcN/MRDsQcWtxvGSUBH8mECeTmWsDnmOd6D02PKGkjFlFyphltSdjZNujkUCyfeKUuNcGVUs1mqU5ji72i5Jr32YlKGawUtSlKw9CVVYlh18GgIj6UT2xrfODwokPUnvPaeFC9CJH0cOzJXIe2H0Ud1dQCJ/DqduJihhYp4Zmr/ynhV94ADJndgWKWfzhGuxn6n/bW7gU6+zRn72NvqrUT8EEPuPMgWCSxy12mkJZfFIiEJO3qcvw4hG4B9ExoU9IhF52nzJM9T98HJD8t+OtZ8fY/jTGx3IwjTOwCix8gLsT0myWTW59g+jA==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id 770AA18002A6;
	Mon, 29 Dec 2025 18:33:50 +0000 (UTC)
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
Subject: [PATCH net 3/5] selftests: netdevsim: add carrier state consistency test
Date: Tue, 30 Dec 2025 03:32:36 +0900
Message-ID: <f4264bde14461a0da4f40f175dd61053ddd360fa.1767032397.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767032397.git.yk@y-koj.net>
References: <cover.1767032397.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zj50itOK3l5NRwcahQB8NcmbhW8SSnsc
X-Proofpoint-ORIG-GUID: zj50itOK3l5NRwcahQB8NcmbhW8SSnsc
X-Authority-Info: v=2.4 cv=XeaEDY55 c=1 sm=1 tr=0 ts=6952c993 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=dxafgm9mWqSCDGKd2yIA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MCBTYWx0ZWRfX5Bv7oLHdkNc2
 fXptV5QKF+wea4ZhD6ktdLx2Z7o0u51NjVw1+G4g5o0d/xI+yICif7tdAAaJcLt5w5ggqx/Z8Vc
 mM6pfMDN8uV9JeJwmZeyNCL+boW8ngMYv/aGQN9BjqdB4d3cl/GnqFuL0ePCWKcmN51Y6aDNAsv
 7/O25Udu87RaD+I72U6VBvrn2lecEZuWgKiiVHoE9VXQc4YDQOqCrws5p4o1QscPM+QyWhkVRYh
 10QliU9mceWJzqsNqLKy2ptT4Y9q+vQmIG4+iQx0iDZ2DXKHnu4qxrWaNyptStiRFvbKrliEt0k
 QBfOIBfi3pmKefXw8M3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_05,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 clxscore=1030 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512290170
X-JNJ: AAAAAAABWuBkf2qcLYVgflAI/sq7U/fb2hEpVJcc/ZcsaZUSEPvJZNUSpclie8Q8e8kdVEeWqGZpFzpIWTrD5TwttIcKjNDxuAVZOAuFDAUWbVzv/WTTsqffvWpO4h7H9J2KXPL6D23lmdEXSBjIp/ld4F83mXgY5/GzOr6kQJnobOcnhQ5BYO3Kz91VxFtEJHaZTCmfGJ1JjA5O0UQYWYLkzR5pmROlB4QEaSHcpfx4/6OaMykE2NHzPyKuFZro0CBm4KoPWw7jhYqlJ5QoGJ7esN6ZazMn87q6rQPF7kl9h7e9YqA/yfVlgZl5q49OjfOQu77DplO0knbl6Hu7hnHLJKdHw1mOw7V/hkQuwhqEBTcDcKU2cHQ2cJE0YCe440TpEdYtaR6bXBNo3d4zlHTb8XzQ2idmEdOU02AJvRRBuphZDLwpFjk056zbYa5ueIsBxoDacDzc5zTdXmlPCdkQ+NTG4t6rVCEKvstdECQoWv1Y1bbxQLTXZyqSfSWkNE8BJf9z/1573JhTzgj43pdszwsVueO7p3Py0y3Z2tkezPniHFOCX+ST/1vShn+yF69z4nynRzdwO6V+vY1nTAD3Q7CmrfCOlhcbWhMbJkbWUzAwQeRPMU+80tRIU0+If/yCLw1kvOBgRC+gBVBmyPXdm+O9K+HLmRnIh71LBfPUrBoBb/YDGBPbZhp7byADjqH1DhfN3iMCyj9yg7p4hqiF4jtCzQ+Ci1EYRnQdbTld

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
index 338c844fe632..d15218e4bf5c 100755
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
@@ -121,6 +158,32 @@ if [ $? -eq 0 ]; then
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


