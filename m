Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C50C49DD66
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 10:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiA0JLn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 04:11:43 -0500
Received: from mail1.bemta34.messagelabs.com ([195.245.231.2]:11426 "EHLO
        mail1.bemta34.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231837AbiA0JLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 04:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1643274702; i=@fujitsu.com;
        bh=TTJx396secFY4TWVsYG79piD7SwRnYamK3ghI0u+wu8=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=J62BY87SA+i4WxUnhEk4b8lgokPBfHhS5tDEm0svJES832gE1yMHoNM8B8y8oU37j
         7IxVsJ98E3rYRaTD/u4P4OI4Cd3M90uRSo5x0yljSvgnKrWU8+SOyQZSyUFI6uE6aZ
         1uxfwbdTPQLVOMR3qJZpFKXQvt+pWWDgBzbqX8W5H/wUOZTOR8Fr21imwe5w/BmGzN
         CejNZcKAqhA5eOVpY+DCa6eAz3LFnbPTxbN6bALbujOdXY9XGJfo/FqcwJdb17ssBO
         6sUR5mnH0eCHYmGD4Q860RDas2QihhnTvipMU6tHdodQsqZJKalUOpLMZqag4bAZDN
         hbUrj1CjA8rjQ==
Received: from [100.115.34.7] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-2.aws.ess.symcld.net id 91/4A-12680-EC162F16; Thu, 27 Jan 2022 09:11:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8MRons28VO
  iwf7v2haXd81hs5h+5z2bxa1P/BY/bt1gsdg7fRmrA6vHnWt72Dz2z13D7nFmwRF2j8+b5AJY
  olgz85LyKxJYM3p3rWUsmC9U8WTDVaYGxmn8XYxcHEICLxklmmbvYIZw9jBK7Fr1k72LkZODT
  UBT4lnnAmYQW0TASWLj1W5GEJtZoE5i077PbF2MHBzCAn4SDWtUQEwWAVWJfRsSQSp4BTwkvv
  x9zAZiSwgoSEx5+B5sCqeAp8S9vafZIVa1MEr0tncwQzQISpyc+YQFYryExMEXL5ghmhUlLnV
  8Y4SwKyRmzWpjmsDIPwtJyywkLQsYmVYxWicVZaZnlOQmZuboGhoY6BoamuoaW+oaGRjoJVbp
  JuqlluqWpxaX6BrpJZYX66UWF+sVV+Ym56To5aWWbGIEhnVKsfqJHYxPV/7UO8QoycGkJMq7x
  PxTohBfUn5KZUZicUZ8UWlOavEhRhkODiUJ3vxYoJxgUWp6akVaZg4wxmDSEhw8SiK8fglAad
  7igsTc4sx0iNQpRkUpcV43kIQASCKjNA+uDRbXlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCo
  J86aBTOHJzCuBm/4KaDET0OLf59+BLC5JREhJNTApWa9onJqzkXll16K3Ux34jtYt5n3SUHm4
  j3WjqneDcFjpwqIg9xdeJwW+1boniojNK2Yw3ZazvDUwzzJ7x4dNJSIar4r+8adXbFub8XyF2
  c5CmTWW9wRNS2dleq/9etdu4r/MW6pudzY0uqi7LvOZe3Zv7iFRrqWTkzOurm3fzW6r6MB1P/
  Dsue2nujua9rEL/ea/UNZ1NElGs2e1bFXg/j1zyz47Ouu+PfVIy2NTl079NOHjZ/sOp2/9v9+
  R87v97Hm7d9abem+TiBf4NulTpluHJ1eD66QtXxU8WVaJrBQqvHbAaAdH8awDi9eHJMhcDf8c
  r8U2b4V33m8HzStt87XWhJv0ancF5obdN1FiKc5INNRiLipOBACQ3EBnZgMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-24.tower-571.messagelabs.com!1643274701!215!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28723 invoked from network); 27 Jan 2022 09:11:41 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-24.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Jan 2022 09:11:41 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 20R9BXxU019758
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 27 Jan 2022 09:11:41 GMT
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Thu, 27 Jan 2022 09:11:36 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <skhan@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <pvorel@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 2/3] selftests/zram01.sh: Fix compression ratio calculation
Date:   Thu, 27 Jan 2022 17:11:36 +0800
Message-ID: <1643274697-3393-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <590c1f1c-2da1-583a-d055-83c15969cf80@linuxfoundation.org>
 <1643274697-3393-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---
fix this ie the fowlloing ltp patch does
https://github.com/linux-test-project/ltp/commit/7310e235
 tools/testing/selftests/zram/zram01.sh | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index 114863d9fb87..e9e9eb777e2c 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -33,8 +33,6 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
-
 	for i in $(seq 0 $(($dev_num - 1))); do
 		echo "fill zram$i..."
 		local b=0
@@ -45,29 +43,17 @@ zram_fill_fs()
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
2.23.0

