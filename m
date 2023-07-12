Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3CD7505A3
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 13:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjGLLKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 07:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGLLKD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 07:10:03 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A11703
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Jul 2023 04:10:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D80411FEED;
        Wed, 12 Jul 2023 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689160199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x7zgIAftkwzcYcDISi/8HmUT5ELkCAKs56Mg9/YcXvU=;
        b=ybcRavIyJUOKd9CAxC1Car9SUWINBp10RewTiBBS8V+2OtGDJeXAkPUNG2o5MyL4CCZn66
        N5RVrIZYdBLpTxOt6c0Urm5Vf7NowlTEQX1y6GrQRed087cUdmbVtowqp9DHTMdFBCShj3
        7rwkIF8pPy8TNaBXFguIBLzXzdR41u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689160199;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=x7zgIAftkwzcYcDISi/8HmUT5ELkCAKs56Mg9/YcXvU=;
        b=q2q6K2qhS/mTCOVxlMxHAIzSils28gR1GDM1HfKWKg4tZApmngg275LcPUU2L93ECF2s4V
        xDdrmuIa/fOVGGBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B130133DD;
        Wed, 12 Jul 2023 11:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IjCmIweKrmRsIgAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 12 Jul 2023 11:09:59 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2] selftests/zram: avoid subshells and bc for ratio calculations
Date:   Wed, 12 Jul 2023 13:10:11 +0200
Message-Id: <20230712111009.31150-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Awk is already called for /sys/block/zram#/mm_stat parsing, so use it
to also perform the floating point capacity vs consumption ratio
calculations. The test output is unchanged.

This allows bc to be dropped as a dependency for the zram selftests.
The documented free dependency can also be removed following
d18da7ec37195 ("selftests/zram01.sh: Fix compression ratio calculation")

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tools/testing/selftests/zram/README    |  2 --
 tools/testing/selftests/zram/zram01.sh | 18 ++++++++----------
 2 files changed, 8 insertions(+), 12 deletions(-)

v2: drop unused dependencies from selftests/zram/README

diff --git a/tools/testing/selftests/zram/README b/tools/testing/selftests/zram/README
index 110b34834a6fa..510ca5a1087f5 100644
--- a/tools/testing/selftests/zram/README
+++ b/tools/testing/selftests/zram/README
@@ -27,9 +27,7 @@ zram01.sh: creates general purpose ram disks with ext4 filesystems
 zram02.sh: creates block device for swap
 
 Commands required for testing:
- - bc
  - dd
- - free
  - awk
  - mkswap
  - swapon
diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index 8f4affe34f3e4..df1b1d4158989 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -33,7 +33,7 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	for i in $(seq $dev_start $dev_end); do
+	for ((i = $dev_start; i <= $dev_end && !ERR_CODE; i++)); do
 		echo "fill zram$i..."
 		local b=0
 		while [ true ]; do
@@ -44,15 +44,13 @@ zram_fill_fs()
 		done
 		echo "zram$i can be filled with '$b' KB"
 
-		local mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
-		local v=$((100 * 1024 * $b / $mem_used_total))
-		if [ "$v" -lt 100 ]; then
-			 echo "FAIL compression ratio: 0.$v:1"
-			 ERR_CODE=-1
-			 return
-		fi
-
-		echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
+		awk -v b="$b" '{ v = (100 * 1024 * b / $3) } END {
+			if (v < 100) {
+				printf "FAIL compression ratio: 0.%u:1\n", v
+				exit 1
+			}
+			printf "zram compression ratio: %.2f:1: OK\n", v / 100
+		    }' "/sys/block/zram$i/mm_stat" || ERR_CODE=-1
 	done
 }
 
-- 
2.35.3

