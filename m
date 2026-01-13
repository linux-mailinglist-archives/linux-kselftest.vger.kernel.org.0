Return-Path: <linux-kselftest+bounces-48860-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 196C5D19545
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BD7C300CEF9
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B44F194AD7;
	Tue, 13 Jan 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="A5QRM1s8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host2-snip4-1.eps.apple.com [57.103.79.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612B6392B68
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313591; cv=none; b=tMaWB8N1tVqYXE/V7jXs1hsS2xZu4cfZf6rRrTZKPm00FotNIMZHppb+qP3Sy3YjgHHEDhaTwUUNAkdvGH05oGVpZv9UQ+zCBPbcFsAxLbwcIiFCaQJWIH0Kry5Ek7j75acW01g0Pby1uuR+Rjm4FSOme0nWcmEfjg26nR3Qx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313591; c=relaxed/simple;
	bh=GtHMg4wHwTN19B9+4lSKjM607bdkctJ2FDn216xvAOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJGT8gn2g08RdBQIpLGcpyQ6NEOD7VsxjMCVO5OtlOGQ2qNpumRmQytQJxmvSxirTkuT0vZCjgmL8CFEBN4TrV4JTNLHu6jHHJ5f0nheEv0h/bp7K3yBVN1ysuaa4ona2B8pNqEbMSGIniZTIr4VKZaLL6NFLBXqBFAUtYAtyA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=A5QRM1s8 reason="key not found in DNS"; arc=none smtp.client-ip=57.103.79.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id EB07318000AD;
	Tue, 13 Jan 2026 14:13:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=AJ3Z/Ka1MtkOkQP/yZPLVw1e30ndPtWd4EamEKxJ7OM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=A5QRM1s888hGj9r55WMah6ENAfVJHk5o3F2Nv5JTsxdgTGQK3zd2sIVYM2rCfA6gNSBaEdW/qhWtWUwVibr/dVh7dkrVwJUKR81DDA1N9P7dYdQjoRzDz+5eGIU4cFPXK4fdZeBUpdPskjsa2HYjW2rjOFyw0cD9Y5syknOrY8P6Iz+w4/iHaZ/vlcuyRQ76KQPBTHHq83O9DnYoZkGlQTjS7WgUL59xKzOkT71tj1CzieAkp0x6fa+RE8ZJYr3wGxKV1IraKOgTi/YcuE8iMgN4MJtewgy5pRQQU6o9z7ueOBZxtDBXP1POwvrbF9377OAHOJBAGuMTq3uYfJ1zRA==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id 17B5E180185D;
	Tue, 13 Jan 2026 14:13:02 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Markus Elfring <Markus.Elfring@web.de>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] selftests: net: fix passive TFO test to fail if child processes failed
Date: Tue, 13 Jan 2026 23:11:54 +0900
Message-ID: <214d399caec2e5de7738ced5736829915d507e4e.1768312014.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768312014.git.yk@y-koj.net>
References: <cover.1768312014.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=QeZrf8bv c=1 sm=1 tr=0 ts=696652f3
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jnl5ZKOAAAAA:8 a=LKZS6mpCBy3a3Cu_pwcA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: miEs5wjNB7qE8WCrCC6RmrweB695itMr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyMCBTYWx0ZWRfX0oyqXyMjeXPS
 AOqoykkjAFGQHId5HJk9ZBaqsqZIpG6GHKieuHgvyoElkxF1/eNnLeMWG7yhIKvu84sIl3U2M/h
 FnB/d11m86Ym9F30qd7Tfq4uEchP0tpprlOZrAxB1fOx9zREF3KI2TJGPRYguMLeQkR9jcxsQO1
 qqpCErtso5pMLS031tPJLQjFhUE6mMSvytRQFWja/SKzUklXTDmF7mKXbrihWNIYEf297/eC23S
 2oai5jNMTz5S6JB7sv5wxlUhVakl4oqUgyfhKi43jdYHQ5Gb48Bl1t9t2Hp6QOSZDYTcP1EIzV9
 vLQn4iT2Jd82tfnWiql
X-Proofpoint-ORIG-GUID: miEs5wjNB7qE8WCrCC6RmrweB695itMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 mlxscore=0 clxscore=1030 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601130120
X-JNJ: AAAAAAABrWYHjR+ZGTTG90aZaflijJOBJAY8Rka2n5lnY9uJgptrb3JLlIT9H86BlFx/+7aA8HaxGe3a05r6Ey1ZqyxopVz69kBl9ExItzfMkAXRufhr3qxswHsNixYuSZr9fAZjkn4tI0fbduLxiztqkIIb5fRGArzYDXuLDG8wqfk6xC8vFxL53wSWM6WnHRr5r1g5wooB5WXzDG0LdIIXKItCZhg0KXPdb4yTmqmCeKYaULpgBZDjoR82zWzven6HyzF0Pr+cx7tmhUDfdPqk6OsnrIDEsXisBUHgWT5ta0I6EFnkGwIjX70r+rNGyYEXNXrogFsSSUTGSU1KNvyfhHkpB0+RCTl60RhqtfkhHmJXnM9zUVMyIergR48NzZJh1sG/OhnBvcM2Kz7tPcubidWlwtA8DzRSm8X/WhCyYcdzI8s9kvO6a1iWCb4IMEYN0vSXsbKGxo+Ulw59KHTwFd1qd7amSZwdQy8XqsxAcOwYDHS2cXcKwVLVmPheyx/lzZfBGVNQ366WWCy9j/0cargDRK1rm1u0MfVaO3b8cYOfQ8CFEoShDlTcT5amX38r/YRGAbtUzzFTThaLwByo+CEBfIzWud4SramvYyYuSTpTyfGZj4GQZQS9DVlY3XaEapl9IQDhqCNs2zgQhykWuOgNjCgI2i2UmndhQFPx14U8WzovA3E+8DnYVQRJI4TGgOu6hQ60l/cZtI83R+mViOeGVBjWUEIs5SXwnjo8FNZtkQaHbSMgqDkTjKeHPMFXgBmvDTXrVuvjggz4JZATeEcYGDdX+JU6oUs2xJPda/Qn2zi4DdGLd/4pP6H7xg==

Improve the passive TFO test to report failure if the server or the
client timed out or exited with non-zero status.

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


