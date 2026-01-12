Return-Path: <linux-kselftest+bounces-48719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2805ED11579
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25751301F9E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED28346AC6;
	Mon, 12 Jan 2026 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="CWsK1CrV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host6-snip4-1.eps.apple.com [57.103.78.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4D3375C3
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768207973; cv=none; b=imXTMv4ebtmr0digSQsgrJaFPN40kD3SSSMhBs2Aiz0rOLFrRMdohavIMYN2M6jRsVr26zjCgwu5H8kdriFFIxfSmhtD74rYEO0XIMoqBzBfV4P6URh72rhIbDmxOfUka1lNlCUHn98egoW33FYD904N490NcAhRDuvKPo/2a3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768207973; c=relaxed/simple;
	bh=8jzkVNyIzEY2OeZAG2tyS95Rn7p59gwHlKarlepS/QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5QBySMf9nPJug9v0mfltv52C3wIxiunu2Ym9Y2yH+0tHM/RKVV9mRKIgyM6BsBMwy0J6Zw1D/ShcFQD8Yoew2LuN3JJ0agW8Kljz9JM1Pyhpq9QYxb6u815eeLudLO26oA3I3MiIhblmk6Z2bmF/3dR7btGCmVlbIpa96RyGX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=CWsK1CrV reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 3941318000A5;
	Mon, 12 Jan 2026 08:52:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=iBw/jihR12dcfjegs0/lwJ1bWrYhtdrmwFgkaFDJvfg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=CWsK1CrVTrihV+354ULBWdrCHj9WsBY3RQhxDTHjEqkne3ydiDbTApucy1bOmgpLbzsU76x2eO75i3ZWUpsjZfBMROO8ci7OlKOz0eubmctotwiDcn1rRDI5Z4xHOMzoFFDzm9sNpH8Nw1vDZUK2kswEPb6yEmG39ivV4ogldp8e56TgiHLG1q2kPn6EfES90MK2mPxsKDz8otMWARvQbeHMfZNPqAPNfwTci8D+gCs/sQ7HOLjooh6pY9WHzYOUTFGsrLTQQhQVBgv6mgjh3Ulg2+fCoY7skdEbCW4rmA8PvPIjqIAxfW1fUVMnDJIxwE6ryYUhJ5Jiq2W1xfdF+w==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id A0DF21800150;
	Mon, 12 Jan 2026 08:52:45 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] selftests: net: fix passive TFO test to fail if child processes failed
Date: Mon, 12 Jan 2026 17:51:43 +0900
Message-ID: <19d12f125d3f4df8fe8e8f2267b182a877ea672c.1768207347.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768207347.git.yk@y-koj.net>
References: <cover.1768207347.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6zE-PBl1VhKYaHGNlB3t723L41My0dnK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA2OSBTYWx0ZWRfX0s8E4ktXI3yi
 wQAsTZ7i2UPrJpAmuS4yE3oJCSdTY9x7piAEmR99LECd53JR/Vz9ckAuQ9qxB0+6iYgjJrgXXtR
 EZ+8igWq6jwC0VtGTv8OUGVUKCT+/lDJm8UDqYEjkhS1oKxpT2GbsrokfLOdUZUlcaddD/IrfDX
 dg3vGU03bKmGytc/39/Hr7JCPhSFM4HKnechXzMudzwO7ooPI+ji6xqlMjYTu3SLu4Rk+ioxKKd
 2DRQjduzjdXuztmdEARRCkfRYBAIVYdSj96nER14S/LgQchfHm+oWNFqtKP0VRUeQzKaLLLcgMf
 JnyXjLl+jX1WRCgrYLd
X-Proofpoint-GUID: 6zE-PBl1VhKYaHGNlB3t723L41My0dnK
X-Authority-Info: v=2.4 cv=GI0F0+NK c=1 sm=1 tr=0 ts=6964b661
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnl5ZKOAAAAA:8 a=DMn0v-ajJ4USD0-U4hgA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_02,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 mlxlogscore=965 clxscore=1030 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601120069
X-JNJ: AAAAAAAB0inQ/87hTFQ6Cj85yNi71cidjtAtEFtSnp8IdOCionP1nuT+V4/1DA0xdINQGFvjh+5WGGEIkT7VmjSNGtXjhwBrs+zB0CjnWeD+XlA86VqiuDWpsR6nt15eJdGF6aBdY00s4Pf3NCTnjxnU8+wJxwp2W/75Isyio3m8wazSQS+g4P2Q55fxxSUyrClDNvayQ6R+k0XLlnyGO0VeakInzD1PNjMd/jGmo9fJHnV6XIMBsPAaUA/6auoHSC8av7JzxuoqZXq0NQ6mVSpx/CAvXdeDhqEkp28wYCa7tftAosctoDTLrRtm8GTwXan9KtwUiQYs+RCUUcVbtD0PUa5Mt3PGXMrwckEMu5wvA9PBifw7V0n+SAXc/a5FSx7Jzs/hXClbxiZYt9ZnTIpBDjcf8ENfqZXIUg5mM0V2K9Gpy4yVpgJ4fBVvbCLNtn3bWqxAkS2GnKbgUDuOW9f7FWb4BWpR4I211jnH+8zObhIItf/8jZYorA6i6V8UUyn08RvQydtdkFFUMtdmu2j2oIigPwoQf0Q3c3vDpwE+HVAmZznqoYXTHYDiM0guLqhtS+Nj6nRE48DuuvQWeorvHAdsUHYT+VCoIEVIvSxT2DrK5dDyLHLYGxuFpya7slJkXUZA/n2y+cYVthySftVC7CnUvKTIS6ITDOjNN6yIxLIbIGabAJ95z6dhaEZoBBs60sgueI3ZgHUrefrRUymsku5LNRozP7okz8P5mfQ3eyemiYhma4TfSfXOLz0=

This commit improves the passive TFO test to report failure if the
server or the cliend timed out or exited with non-zero status.

Before this commit, TFO test didn't fail even if exit(EXIT_FAILURE) is
added to the first line of the run_server() and run_client() functions.

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 tools/testing/selftests/net/tfo_passive.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tfo_passive.sh b/tools/testing/selftests/net/tfo_passive.sh
index a4550511830a..f116f888b794 100755
--- a/tools/testing/selftests/net/tfo_passive.sh
+++ b/tools/testing/selftests/net/tfo_passive.sh
@@ -85,12 +85,15 @@ timeout -k 1s 30s ip netns exec nssv ./tfo        \
 				-s                \
 				-p ${SERVER_PORT} \
 				-o ${out_file}&
+server_pid="$!"
 
 wait_local_port_listen nssv ${SERVER_PORT} tcp
 
 ip netns exec nscl ./tfo -c -h ${SERVER_IP} -p ${SERVER_PORT}
+client_exit_status="$?"
 
-wait
+wait "$server_pid"
+server_exit_status="$?"
 
 res=$(cat $out_file)
 rm $out_file
@@ -101,6 +104,14 @@ if [ "$res" = "0" ]; then
 	exit 1
 fi
 
+if [ "$client_exit_status" -ne 0 ] || [ "$server_exit_status" -ne 0 ]; then
+	# Note: timeout(1) exits with 124 if it timed out
+	echo "client exited with ${client_exit_status}"
+	echo "server exited with ${server_exit_status}"
+	cleanup_ns
+	exit 1
+fi
+
 echo "$NSIM_SV_FD:$NSIM_SV_IFIDX" > $NSIM_DEV_SYS_UNLINK
 
 echo $NSIM_CL_ID > $NSIM_DEV_SYS_DEL
-- 
2.52.0


