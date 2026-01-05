Return-Path: <linux-kselftest+bounces-48207-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43309CF45AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 16:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEC3D3023D2E
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 15:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA3630DEB6;
	Mon,  5 Jan 2026 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="AS0ElPIQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.ci.icloud.com (ci-2005j-snip4-10.eps.apple.com [57.103.89.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971AB3090E0
	for <linux-kselftest@vger.kernel.org>; Mon,  5 Jan 2026 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.89.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767626329; cv=none; b=m3Z47XQLPpQfLKrGUigXb0ar6PKHCFIDeqODvmoGETrWglyqfvS43FO9vcyTMPIOL9MlPmC+Ai48xEGd+t7L2+OotZ+cyfVQlqhWqKtreqy4hrvCXN5F7RYqJ8zrYzZT94ByNYp661k56gb/3ZMC1/AffseAGTibsK5eb5ao14E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767626329; c=relaxed/simple;
	bh=1mLLSDLrqDBxxnY7WEhyxV3W7d+OdA7gCMCNqwJkKwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ske7Txj301wKylkYHPLk2qqGvMFnCPITgrKZgzMqruEJ2Ar5rXF52Tb4CrlR8Jhe2qws3d23oNQkyv7h0XhCLOZu1Mr17dFDn3UTseX2mwPG7cSYKw76Ozykmyecp/QFSepcxT8AmF1gvDY1AhQdLLGUtq022pFY1L9VbRYJ7Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=AS0ElPIQ reason="key not found in DNS"; arc=none smtp.client-ip=57.103.89.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPS id 191621802808;
	Mon,  5 Jan 2026 15:18:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=CWiGzLWAaGYTukQE2sji50bXuS4xVvcD+phOiglkWuM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=AS0ElPIQzYOaFd8j+Uq1tnR4LAkC4SikM+MxD5s2qxAvFMeNt9Nu6lNmpBE4VgW/Y0gen2tSQAxuCQ7qAlF4tPTkigAvrT3fBrXIkvQh7Sgvkhebd3ogQRKXrmEl/rO+nnkdiPR6nrTmb27FmrtnCKpgP7MDM+l0wlGx5NFHDm/CxNYJ23kZW1NUryE7mYN4sFbTpuOvrWBoJ+0daaeJb9mc2cbGDwOxrgRGJ6sVB5B19sJgHmhvt+9+NZ+kMivBQ4Y9F0TFHWh+pl5MP4m3yYXXKDk7QUxlVepHvjJ30xfHc8/41oQFWpGP6wL29Vty1uhlxdix7DH4QNy3/y5aPA==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.57.156.36])
	by p00-icloudmta-asmtp-us-central-1k-60-percent-8 (Postfix) with ESMTPSA id AAEE7180011F;
	Mon,  5 Jan 2026 15:18:41 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
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
Subject: [PATCH net v3 2/2] selftests: netdevsim: add carrier state consistency test
Date: Tue,  6 Jan 2026 00:17:33 +0900
Message-ID: <481e2729e53b6074ebfc0ad85764d8feb244de8c.1767624906.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767624906.git.yk@y-koj.net>
References: <cover.1767624906.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 43L0P_ZGYm0T1XDrAQq9yfPDRn0fPnt5
X-Proofpoint-GUID: 43L0P_ZGYm0T1XDrAQq9yfPDRn0fPnt5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzNCBTYWx0ZWRfXxL3Fr8LdomxL
 42dJiO7LwP2VatNrDtQKlFV492Id9erbzMiQ8K27TzCwt5HW367lH5DQdEecbPnARQk2xswLnlG
 ljU9TqqVlmNzr0oM9rGlMFC8xSP7911qJEYFgWcrEjVHTAjY2YzkmBEj2tP+CUP6DAkChzAYQkD
 Imke6hRH4LuN4+S0GeqetlJIg9dVl08qgOQJY4S26efL304wZNSUDcPSJNkAVjjdkgPYQmBVOCn
 jV+EiBrGLEt/d4JJI2azC+eNFavCrD5aNYu5CyBdm4kEbBcPIDiLCYZnpBSA/Fy5j1K7vIksKQy
 abYO1B/CTPGQzMyqnvy
X-Authority-Info: v=2.4 cv=C7XkCAP+ c=1 sm=1 tr=0 ts=695bd655 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=dxafgm9mWqSCDGKd2yIA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601050134
X-JNJ: AAAAAAAB6zbODNCHc2pEGpkujMrlqlv3tsP/ekW+u9mSEvB5EdwXjtsoGvgXmmGzDlLLRNJ95Z4hQ8AwyzK5+nBgzf9DWOOBc4rn/mwhxUBHULfqcr8bhIh9Gy9bd7vGXqWK/WNHh+wqtIG/vBCOEoBXuLDOHCC+9z8jxXGb/qBUCLkx0SAjT1FKIPcbKEesiCD4Lv4Ke2uAAeq+ItUVZlLBVtWKlxPUK0J7KSKeokD6B7khK/YRwwcc0d4tbfJUiBWoTnBQpwY09EjKVw5EIbbMI8ZNKf+jTLGunaf7kD9IDTPnl8Z+yQAfsVP9PR2zLXUBa0RgXkfsDazfZ9ZU0n1PR/YD2Gu6KH0ME9AvCnO06PhvEvJv7Pw/e6XVLw7GVwZCHT9NdjyXung0UkU6cSuHIv+rK3V5gAgysHVt0Cqyvkyj/f3giOTfX21aehfjOqNWOmW8Lc8m/Cmy6fIsbzpRIy92zbFkUr16fq2w3oMlCqbWPk17fh1ZdTUvVueqeoMpOYR+FzKJMaL5Z6n/7pxMBcb0UV/JawHIIrFLocSIL5GyKcs/u0n64aKvY6NsL8n5W1Dy/nW3tXuqhVoyGMCi3gQWWY0h7ZfNqDITRFhfVQcoWRf85DpthnAnUZEX9CleaTIl9ndZvAh/xgZgrGcV6tXYaYldLg8KDE4XGxSkSddMhHNfTv00vsZHTCFLCzn5mxf9BCcQERw5E1z9r4M22jkbS1wwvGmjgbUu50pzTwfAcFS35vjM9rPxZhuDLaBgVXeVwPzGQuNHCo8RJq7S1NpdbOqV

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
 .../selftests/drivers/net/netdevsim/peer.sh   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/netdevsim/peer.sh b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
index 7f32b5600925..f4721f7636dd 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/peer.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/peer.sh
@@ -52,6 +52,39 @@ cleanup_ns()
 	ip netns del nssv
 }
 
+is_carrier_up()
+{
+	local netns="$1"
+	local nsim_dev="$2"
+
+	test "$(ip netns exec "$netns"	\
+		cat /sys/class/net/"$nsim_dev"/carrier 2>/dev/null)" -eq 1
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
@@ -113,6 +146,32 @@ if [ $? -eq 0 ]; then
 	exit 1
 fi
 
+# netdevsim carrier state consistency checking
+assert_carrier_up nssv "$NSIM_DEV_1_NAME"
+assert_carrier_up nscl "$NSIM_DEV_2_NAME"
+
+echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > "$NSIM_DEV_SYS_UNLINK"
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


