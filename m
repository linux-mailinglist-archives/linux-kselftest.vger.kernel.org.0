Return-Path: <linux-kselftest+bounces-24321-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AA2A0B1C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 09:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6A23A2350
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 08:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF1234967;
	Mon, 13 Jan 2025 08:53:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F1D19341F;
	Mon, 13 Jan 2025 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736758399; cv=none; b=mtzqHkySdXz8TGfLDrmpUWvgKy69oj/iDel/mfJyzsHEAq+U5Ql377NhOGnC9/+0SiCv1xQZh2yM6TCLl8KmFyjQYJolIRSk59y9PPztGF66Huvq1NrVPjAHgfYrupAB9jy732B28bTALhY4mrsRC3TBwrA89yH+2BF6XuSumO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736758399; c=relaxed/simple;
	bh=+kYpJ/KVCG2w+X4rMMgBTQbw+Rnog2FhHOywqZR6VLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5DppW6r0IU+2S3sBnbRVtuiWzq0q/ZKST29XXNVILeGx2rTt8i31rKH0R+U2Fq1iZZlyZTTHTi9rF2DBkOVZpzUapwykwMfhVN8Pw8gVvyC6D+MBcRkhlDYdPTUXpzU4LrvUI2VuaOlwtXPVsSECJ2U7SLm/nx6i59K8zfpxiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c7e4e5c4d18b11efa216b1d71e6e1362-20250113
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_DIGIT_LEN
	HR_FROM_NAME, HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER
	HR_SJ_NOR_SYM, HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT
	HR_TO_DOMAIN_COUNT, HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED
	SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:3b6df243-79cf-496c-9ad1-556d10a3544e,IP:15,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-24
X-CID-INFO: VERSION:1.1.45,REQID:3b6df243-79cf-496c-9ad1-556d10a3544e,IP:15,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-24
X-CID-META: VersionHash:6493067,CLOUDID:ef8c3a63588174d54e3754e1ba308b18,BulkI
	D:2501131652574KZ42GSN,BulkQuantity:0,Recheck:0,SF:17|19|24|38|45|66|78|81
	|82|102,TC:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:
	nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
	C:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: c7e4e5c4d18b11efa216b1d71e6e1362-20250113
X-User: liucong2@kylinos.cn
Received: from liucong.. [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <liucong2@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 989990396; Mon, 13 Jan 2025 16:52:55 +0800
From: Cong Liu <liucong2@kylinos.cn>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"'David S . Miller'" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Cong Liu <liucong2@kylinos.cn>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftests: mptcp: Fix input fd lifecycle in reconnection loop
Date: Mon, 13 Jan 2025 16:52:27 +0800
Message-ID: <20250113085228.121778-3-liucong2@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250113085228.121778-1-liucong2@kylinos.cn>
References: <20250113085228.121778-1-liucong2@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When both cfg_input and cfg_sockopt_types.mptfo are set, the input file
descriptor (fd_in) is opened before the reconnection loop but closed
within the loop. However, when mptfo is enabled, the descriptor is not
reopened in the loop, causing subsequent iterations to use an invalid
file descriptor.

Move the file open operation into the loop to ensure fd_in is always
valid when needed, regardless of mptfo setting.

Signed-off-by: Cong Liu <liucong2@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 31f4c5618569..4d4ea4627daa 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -1247,12 +1247,6 @@ int main_loop(void)
 	struct addrinfo *peer;
 	struct wstate winfo;
 
-	if (cfg_input && cfg_sockopt_types.mptfo) {
-		fd_in = open(cfg_input, O_RDONLY);
-		if (fd_in < 0)
-			xerror("can't open %s:%d", cfg_input, errno);
-	}
-
 	memset(&winfo, 0, sizeof(winfo));
 	fd = sock_connect_mptcp(cfg_host, cfg_port, cfg_sock_proto, &peer, fd_in, &winfo);
 	if (fd < 0)
@@ -1270,7 +1264,7 @@ int main_loop(void)
 	if (cfg_cmsg_types.cmsg_enabled)
 		apply_cmsg_types(fd, &cfg_cmsg_types);
 
-	if (cfg_input && !cfg_sockopt_types.mptfo) {
+	if (cfg_input) {
 		fd_in = open(cfg_input, O_RDONLY);
 		if (fd_in < 0)
 			xerror("can't open %s:%d", cfg_input, errno);
-- 
2.43.0


