Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC20E475597
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 10:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbhLOJ4l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 04:56:41 -0500
Received: from mail1.bemta36.messagelabs.com ([85.158.142.1]:49456 "EHLO
        mail1.bemta36.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231747AbhLOJ4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 04:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1639562199; i=@fujitsu.com;
        bh=i/JRwlurL2KCK9xVmA3ssswUEl7pjQd43PSCeXdxb2U=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Infpt8Q1R/5Qyp+tf92EQnuMmlIWfvfdbzc/gVlJ72qHfWjLrBWubhopEuBVtld6s
         AWEycWDRTj3QyKRdLUGplgWABVISm/p1YyhlBcuF1Cw7pb6PLxE8qhEx3g4GQOARAr
         kIwkLKjMIHNePPMf4L/LSeqRIIgYnAlHCWxcErBMgUC2S9c7M7dWyndhVLtqmJmwAs
         KZwVEH3t5jM2CLkJKUaZ9YnOGXZKyDGN2iYLJcbwJ6AjZ+cIpEmk1ZdN1MUAgMzgjw
         qzCT5gNrBK99YUOmqRfA9rmJitU4KLFqfZ3skjKFsnXmAPYOd4W6LdlHkP1O03bnU5
         VoFRSKo3t2MpA==
Received: from [100.115.68.153] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-a.eu-central-1.aws.ess.symcld.net id 34/79-31213-6DBB9B16; Wed, 15 Dec 2021 09:56:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRWlGSWpSXmKPExsViZ8MxSffa7p2
  JBje/S1vs2z+f0eLyrjlsFtPvvGezuPWJ32LKy3XsDqweR16sZvfYtKqTzePOtT1sHp83yQWw
  RLFm5iXlVySwZhz9d4KtYKJYxbnD3UwNjP+Euhg5OYQEtjBKrNgg38XIBWQvYJL4dng5M4Szh
  1Hi3edmZpAqNgFNiWedC8BsEQFLiV2P97KCFDELtDBKNJw+wtTFyMEhLOAv0XjfG8RkEVCV2P
  ZTGaScV8BD4tObGewgtoSAgsSUh++ZIeKCEidnPmEBsZkFJCQOvnjBDFGjKHGp4xsjhF0hMWt
  WGxOErSZx9dwm5gmM/LOQtM9C0r6AkWkVo21SUWZ6RkluYmaOrqGBga6hoamumaWusbFeYpVu
  ol5qqW5yal5JUSJQVi+xvFgvtbhYr7gyNzknRS8vtWQTIzC0U4pdFXcwXuv7qXeIUZKDSUmUN
  2/TzkQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErwcO4FygkWp6akVaZk5wDiDSUtw8CiJ8J4HSf
  MWFyTmFmemQ6ROMSpKifOmA6NTSAAkkVGaB9cGi+1LjLJSwryMDAwMQjwFqUW5mSWo8q8YxTk
  YlYR5XUCm8GTmlcBNfwW0mAlo8bHc7SCLSxIRUlINTFVPvtW9/VF+50CvtNVJGet5qR7trY2H
  1eJ+tMY1dk+cv7s51OBJ6NNDi9K+VnPslnly+Mrc846/axRLvBLai1iMDk25F2ZzWcH8cgnjS
  qkJL7dLrOeYfV3yQJ+JQseZR3o349WnxqWcPrW95q1g/7feGGVzToa3/3I9V6Tqr/0Z8r8xNj
  z6rr3d6tVhnOfjrUTs1JPzdqi/lHGbudMoy2bD8ZJVz+ea2d7O3HbofYbL/gN7RJk7PoSFpTX
  dWX9KJiZ+n2DguVB+J62zC98l89mv8/8acOTGbMOfFz3V2R/ueFW35c2HXXn1OQxRIU+u7tSw
  doqekPbLQ7Rwx+JWN997YZOeBtg8nlUV+Za7T4mlOCPRUIu5qDgRAJK7G/JoAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-9.tower-532.messagelabs.com!1639562198!18669!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 9165 invoked from network); 15 Dec 2021 09:56:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-9.tower-532.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Dec 2021 09:56:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E6994100352;
        Wed, 15 Dec 2021 09:56:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id D98F51000E9;
        Wed, 15 Dec 2021 09:56:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 09:56:15 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <aleksei.kodanev@bell-sw.com>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 1/3] selftests/zram: Remove obsolete max_comp_streams interface
Date:   Wed, 15 Dec 2021 17:56:09 +0800
Message-ID: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since kernel commit 43209ea2d17a ("zram: remove max_comp_streams internals"), zram has
switched to per-cpu streams. Even kernel still keep this interface for some reasons, but
writing to max_comp_stream doesn't take any effect. So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tools/testing/selftests/zram/zram01.sh   |  4 ----
 tools/testing/selftests/zram/zram02.sh   |  4 ----
 tools/testing/selftests/zram/zram_lib.sh | 22 ----------------------
 3 files changed, 30 deletions(-)

diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index 114863d9fb87..28583e4ae546 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -15,9 +15,6 @@ ERR_CODE=0
 
 # Test will create the following number of zram devices:
 dev_num=1
-# This is a list of parameters for zram devices.
-# Number of items must be equal to 'dev_num' parameter.
-zram_max_streams="2"
 
 # The zram sysfs node 'disksize' value can be either in bytes,
 # or you can use mem suffixes. But in some old kernels, mem
@@ -72,7 +69,6 @@ zram_fill_fs()
 
 check_prereqs
 zram_load
-zram_max_streams
 zram_compress_alg
 zram_set_disksizes
 zram_set_memlimit
diff --git a/tools/testing/selftests/zram/zram02.sh b/tools/testing/selftests/zram/zram02.sh
index e83b404807c0..d664974a1317 100755
--- a/tools/testing/selftests/zram/zram02.sh
+++ b/tools/testing/selftests/zram/zram02.sh
@@ -14,9 +14,6 @@ ERR_CODE=0
 
 # Test will create the following number of zram devices:
 dev_num=1
-# This is a list of parameters for zram devices.
-# Number of items must be equal to 'dev_num' parameter.
-zram_max_streams="2"
 
 # The zram sysfs node 'disksize' value can be either in bytes,
 # or you can use mem suffixes. But in some old kernels, mem
@@ -30,7 +27,6 @@ zram_mem_limits="1M"
 
 check_prereqs
 zram_load
-zram_max_streams
 zram_set_disksizes
 zram_set_memlimit
 zram_makeswap
diff --git a/tools/testing/selftests/zram/zram_lib.sh b/tools/testing/selftests/zram/zram_lib.sh
index 6f872f266fd1..0c49f9d1d563 100755
--- a/tools/testing/selftests/zram/zram_lib.sh
+++ b/tools/testing/selftests/zram/zram_lib.sh
@@ -82,28 +82,6 @@ zram_load()
 	fi
 }
 
-zram_max_streams()
-{
-	echo "set max_comp_streams to zram device(s)"
-
-	local i=0
-	for max_s in $zram_max_streams; do
-		local sys_path="/sys/block/zram${i}/max_comp_streams"
-		echo $max_s > $sys_path || \
-			echo "FAIL failed to set '$max_s' to $sys_path"
-		sleep 1
-		local max_streams=$(cat $sys_path)
-
-		[ "$max_s" -ne "$max_streams" ] && \
-			echo "FAIL can't set max_streams '$max_s', get $max_stream"
-
-		i=$(($i + 1))
-		echo "$sys_path = '$max_streams' ($i/$dev_num)"
-	done
-
-	echo "zram max streams: OK"
-}
-
 zram_compress_alg()
 {
 	echo "test that we can set compression algorithm"
-- 
2.23.0

