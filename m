Return-Path: <linux-kselftest+bounces-2372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B9D81CA3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 13:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763491F22CF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Dec 2023 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296A11863F;
	Fri, 22 Dec 2023 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfxyJdrG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E2322314;
	Fri, 22 Dec 2023 12:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6706AC433C8;
	Fri, 22 Dec 2023 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703249284;
	bh=f8MxnKNl8aWOOpIhsgtOmNgNY2U+VCvmLARJV8km6Lw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NfxyJdrGlPtLvGrB4WosOs67jTR2/ZZocAKu9cNtbVnDaVoVQNGrgEOXTPkv6ncyh
	 oJ+XhP0SmyWs5MwOtFxgBGrbYBTYdXBhyq5ABRQBnbQmhtVY4+akSCgAOaxGYcXLdO
	 GonHpnDI6el3OfgYbbg183yb/CJNMjM/GPXlfDPFUG6AmddRCOXaAOkmj+F/meSlYU
	 KGhcWMKdpO81HcdgIfi07oYfSftBnY4KB1u55KApEXQCsnGFsg+mTvFryhzIiDz2rW
	 rpRsXQW0wruNYCT+oN3dNtw6Tmcm+yT+ryrkUGUYRrxjh+PICH5GwkuzoDO4vNefE8
	 O5xXw0URnzcFQ==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Fri, 22 Dec 2023 13:47:25 +0100
Subject: [PATCH net-next 4/4] selftests: mptcp: diag: check CURRESTAB
 counters
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-4-c1eb73d6b2b2@kernel.org>
References: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
In-Reply-To: <20231222-upstream-net-next-20231221-mptcp-currestab-v1-0-c1eb73d6b2b2@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Geliang Tang <geliang.tang@linux.dev>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QjbEHosfHcKKjU3RogRURLP58YI1j0WbbK15xL3Nrjc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlhYV27kvIeEPmFqwJYkWT0hr+wWSl24PB90bs3
 8+++PkN1wCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZYWFdgAKCRD2t4JPQmmg
 c1oID/9k9tbHs37JFpAk89njTgeXdt38bCqSe77DoL7Refyn9uXvhB0t3j43cDE3lXTkDHwXOCf
 vahWBybTiilXlCwgJzam49sZqdTEiW9MDxGxUzlGTCbr5bo8pF+YT2xRyJPKG7+Qk17CeBGsQLD
 iAMTl+v/965bw+QE+FcR8Vfbcnqvc0kdzy70iSZMfkFvx6nRDOHJn68p++r7WDzyrMrMYpqC61i
 b72TB97yRl6kzMzRlgOQyT4j46p3GwsuzL5QpUY6VxGdHAeWIQMDqAPG2tRRFsv8lF4pl97KfP4
 o9yXE3BEY/XMxMFx43sQU0RVzPdfM5+UmKmaeU9rrmsMHZ7p/hB2jmyLeCWPT/20raDCTNXuJ+Z
 usw3rUCiXm3/X10Lfn1zD9G89/tFgdkaraoCNvAatLTafEryh1c24T/a1uJyfskqKdHqIPwR07y
 oxfpHiGQ/qzptc6mRKwn3y5QUU/hMdK8UpPHKWSEY7KjouQnHcGTQ+9/U9S4S2fn7pq69x1jSA1
 oUlJ7jETdkdMQY2n2+zlSqcOGc8+GEwsa23b/B/xnBMuNZERizU/yCYi/wKnT7l8pqOmH2TAzaM
 q12dMzt88GQ8p8ZoOIkVPi2VqTp4ElYNjmG3r0B5d896lDCXTEv2wGAo89GPs6tFmk+RlCMnYkl
 DYPmcohz6PHPxXw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <geliang.tang@linux.dev>

This patch adds a new helper chk_msk_cestab() to check the current
established connections counter MIB_CURRESTAB in diag.sh. Invoke it
to check the counter during the connection after every chk_msk_inuse().

Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
Reviewed-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/diag.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 95b498efacd1..04fcb8a077c9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -56,7 +56,7 @@ __chk_nr()
 	local command="$1"
 	local expected=$2
 	local msg="$3"
-	local skip="${4:-SKIP}"
+	local skip="${4-SKIP}"
 	local nr
 
 	nr=$(eval $command)
@@ -182,6 +182,15 @@ chk_msk_inuse()
 	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
+# $1: cestab nr
+chk_msk_cestab()
+{
+	local cestab=$1
+
+	__chk_nr "mptcp_lib_get_counter ${ns} MPTcpExtMPCurrEstab" \
+		 "${cestab}" "....chk ${cestab} cestab" ""
+}
+
 wait_connected()
 {
 	local listener_ns="${1}"
@@ -219,9 +228,11 @@ chk_msk_nr 2 "after MPC handshake "
 chk_msk_remote_key_nr 2 "....chk remote_key"
 chk_msk_fallback_nr 0 "....chk no fallback"
 chk_msk_inuse 2 "....chk 2 msk in use"
+chk_msk_cestab 2
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab 0
 
 echo "a" | \
 	timeout ${timeout_test} \
@@ -237,9 +248,11 @@ echo "b" | \
 wait_connected $ns 10001
 chk_msk_fallback_nr 1 "check fallback"
 chk_msk_inuse 1 "....chk 1 msk in use"
+chk_msk_cestab 1
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab 0
 
 NR_CLIENTS=100
 for I in `seq 1 $NR_CLIENTS`; do
@@ -261,9 +274,11 @@ done
 
 wait_msk_nr $((NR_CLIENTS*2)) "many msk socket present"
 chk_msk_inuse $((NR_CLIENTS*2)) "....chk many msk in use"
+chk_msk_cestab $((NR_CLIENTS*2))
 flush_pids
 
 chk_msk_inuse 0 "....chk 0 msk in use after flush"
+chk_msk_cestab 0
 
 mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.43.0


