Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C02B4AFB98
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Feb 2022 19:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbiBISry (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Feb 2022 13:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241947AbiBISrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Feb 2022 13:47:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F3C1038E6;
        Wed,  9 Feb 2022 10:44:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 722566159E;
        Wed,  9 Feb 2022 18:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BF0C340E9;
        Wed,  9 Feb 2022 18:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644432265;
        bh=wDua54V40aYcPDnGD2qM9MjIhK8Jdh3ufrb+uJTT5ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sy3HNJa4ilybq8TAeSdWV/POC9AtYJX2sKvj44Vb5oy1FkvYlVYdT2iV8eE7bo1uV
         XRf9cdbLLT1ZjvLzzV4Pwj/GSACbTInphJh3M74aXAX8dmSp0FGb4UWZV0ykBtOAe+
         dDJPxoFsJDvxNsaz5U2VEBXe5GkyDDaStedioqN7if1tAJNKM0WIbzOheilmSxcX1n
         VTn2QX39u06fRG1kXsDlju9C8B1GXdWRvr/wzEsMo0Jwp6t0DM2ZMKDxuA94mJbZ7V
         Agx5PChPuJTZ4T7Y0rPr390fej7Tod4ekV7VKMdIgVLLD8C92P151MPWPxJNHJR2B7
         SXfAnoWuUqj5w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 03/10] selftests/zram01.sh: Fix compression ratio calculation
Date:   Wed,  9 Feb 2022 13:44:02 -0500
Message-Id: <20220209184410.48223-3-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209184410.48223-1-sashal@kernel.org>
References: <20220209184410.48223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Yang Xu <xuyang2018.jy@fujitsu.com>

[ Upstream commit d18da7ec3719559d6e74937266d0416e6c7e0b31 ]

zram01 uses `free -m` to measure zram memory usage. The results are no
sense because they are polluted by all running processes on the system.

We Should only calculate the free memory delta for the current process.
So use the third field of /sys/block/zram<id>/mm_stat to measure memory
usage instead. The file is available since kernel 4.1.

orig_data_size(first): uncompressed size of data stored in this disk.
compr_data_size(second): compressed size of data stored in this disk
mem_used_total(third): the amount of memory allocated for this disk

Also remove useless zram cleanup call in zram_fill_fs and so we don't
need to cleanup zram twice if fails.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/zram/zram01.sh | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index b9566a6478a9c..ac6e4ddd2604e 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -42,8 +42,6 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
-
 	for i in $(seq 0 $(($dev_num - 1))); do
 		echo "fill zram$i..."
 		local b=0
@@ -54,29 +52,17 @@ zram_fill_fs()
 			b=$(($b + 1))
 		done
 		echo "zram$i can be filled with '$b' KB"
-	done
 
-	local mem_free1=$(free -m | awk 'NR==2 {print $4}')
-	local used_mem=$(($mem_free0 - $mem_free1))
+		local mem_used_total=`awk '{print $3}' "/sys/block/zram$i/mm_stat"`
+		local v=$((100 * 1024 * $b / $mem_used_total))
+		if [ "$v" -lt 100 ]; then
+			 echo "FAIL compression ratio: 0.$v:1"
+			 ERR_CODE=-1
+			 return
+		fi
 
-	local total_size=0
-	for sm in $zram_sizes; do
-		local s=$(echo $sm | sed 's/M//')
-		total_size=$(($total_size + $s))
+		echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
 	done
-
-	echo "zram used ${used_mem}M, zram disk sizes ${total_size}M"
-
-	local v=$((100 * $total_size / $used_mem))
-
-	if [ "$v" -lt 100 ]; then
-		echo "FAIL compression ratio: 0.$v:1"
-		ERR_CODE=-1
-		zram_cleanup
-		return
-	fi
-
-	echo "zram compression ratio: $(echo "scale=2; $v / 100 " | bc):1: OK"
 }
 
 check_prereqs
-- 
2.34.1

