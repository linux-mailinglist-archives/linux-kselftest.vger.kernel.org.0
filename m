Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDF2740F53
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjF1Kwj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 06:52:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39920 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjF1KwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 06:52:11 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0F7022188D;
        Wed, 28 Jun 2023 10:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687949530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9uHYzmfZ6QeQ/uYiOE6D0aCUq9cTMyuHgSeVgtagxb8=;
        b=VgwzMXp+UKb9bKDzPkogK4S0xPeZWHwAOwjw4FttlxX75sRE+6cVGaQ1hqgTBI1hdntwau
        ZaT81eVJkEoFWv+VuO+YfDrzRrNktuculrzfw4zv0MONOe3WLbPLdmmfozJFhQZHikPYCY
        Jp1KzElP1UP4T0T1kuMpGMVLiCaoJJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687949530;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9uHYzmfZ6QeQ/uYiOE6D0aCUq9cTMyuHgSeVgtagxb8=;
        b=KubZHdJbzxTIWBG4140W1JdqyJboh3I6d6lK7r2nLc/3KIdi3bmTkjaIL+mu0xEueQ2HPR
        gCl7umn4D3wf+LDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBF40138E8;
        Wed, 28 Jun 2023 10:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5cksNNkQnGQ1KAAAMHmgww
        (envelope-from <ddiss@suse.de>); Wed, 28 Jun 2023 10:52:09 +0000
From:   David Disseldorp <ddiss@suse.de>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH] selftests/zram: avoid subshells and bc for ratio calculations
Date:   Wed, 28 Jun 2023 12:53:45 +0200
Message-Id: <20230628105345.16952-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Awk is already called for /sys/block/zram#/mm_stat parsing, so use it
to also perform the floating point capacity vs consumption ratio
calculations. The test output is unchanged.
This allows bc to be dropped as a dependency for the zram selftests.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tools/testing/selftests/zram/zram01.sh | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

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

