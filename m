Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA625475596
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Dec 2021 10:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241376AbhLOJ4k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Dec 2021 04:56:40 -0500
Received: from mail1.bemta32.messagelabs.com ([195.245.230.2]:7123 "EHLO
        mail1.bemta32.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233646AbhLOJ4k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Dec 2021 04:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1639562199; i=@fujitsu.com;
        bh=JsCLyLwQRCdIyX/uM1y20jxOZEFlv4Lm1Kc9IvtSS+I=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=E1uU6WIV1b8N5DsnGjNgbXKlFXQTlsXAnypTj0eTeusBXTx63pwBtZ9dYNlaUPs1l
         bKWN1UeTy4KuCQMJdC6u8IDflnI1w/xdCSKsIEO450aH1TL1waeZRjtnWmTYLCExjX
         difb762TmzbRP9SEKOHgdDRkcKRZjSWSt5RxKV5EXZ/H3KeS5ISEo1YIaUSswAeNeV
         05yf4SwGnHcOgob7Qya2BbGYR7OdvWb6/8CqUEbzxJTa9/Tyk6GsmLWKl+wZKElhFn
         xdWhMfvUE8wxRd3pmN8noucNUpM+tGuS+huSTJg5e4ax/HuCXswzStkxco30dlwDcL
         dskavUSCkFUrg==
Received: from [100.115.3.179] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-west-1.aws.ess.symcld.net id A5/43-10124-6DBB9B16; Wed, 15 Dec 2021 09:56:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRWlGSWpSXmKPExsViZ8MxSffa7p2
  JBtMey1ns2z+f0eLyrjlsFtPvvGezuPWJ32LKy3XsDqweR16sZvfYtKqTzePOtT1sHp83yQWw
  RLFm5iXlVySwZsw++pGt4KNAxdfXOxkbGP/zdjFycQgJbGGUOLV8AxOEs4BJov/ydBYIZw+jx
  KHug8xdjJwcbAKaEs86F4DZIgKWErse72UFKWIWaGGUaDh9hAkkISzgLbGwZwYriM0ioCqx4c
  JMdhCbV8BD4sjNrWA1EgIKElMevgcbxCngKfHp+AkWEFsIqObW/knMEPWCEidnPgGLMwtISBx
  88YIZoldR4lLHN0YIu0Ji1qw2qJlqElfPbWKewCg4C0n7LCTtCxiZVjFaJhVlpmeU5CZm5uga
  GhjoGhqa6proWhrrJVbpJuqlluqWpxaX6BrqJZYX66UWF+sVV+Ym56To5aWWbGIERkJKMUvsD
  satfT/1DjFKcjApifLmbdqZKMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mCl2MnUE6wKDU9tSItMw
  cYlTBpCQ4eJRHe8yBp3uKCxNzizHSI1ClGRSlx3oO7gBICIImM0jy4NlgiuMQoKyXMy8jAwCD
  EU5BalJtZgir/ilGcg1FJmHcSyBSezLwSuOmvgBYzAS0+lrsdZHFJIkJKqoHJYoLjUQlG/pyO
  ox8dr9uLPTmQevuS6+1DD2ZNbvQzn3vE60t6jmVdqXC4+5wHf0K+hfbb5z/LuK29+eJl07MT9
  D3jd1yIzrrN4bbp9qbVcVaad5YkXc/yjs3IeGJ3UzBBNF59bX1Dg8GGpDx+BffK2nde+8TiX6
  V9SjbNcxLSdFi67eFxweVzQiZqbC1/JKR9zVy0zkaGrdZ2qrRdQ5b2memTDT4nPrq9eutRkfV
  FG/xXng6+/YW3fam+/97CjRu1bY6XzpaZX1PZduekNZNZb+qWk/Fqpl/fnlsRkbdsc7lEdMWO
  jZfFzNfu+/HltZti65ddv6Sj3z5przny8uxBObk5OtYxs2+c2+YcxxalxFKckWioxVxUnAgAG
  X3moH8DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-591.messagelabs.com!1639562198!4704!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21238 invoked from network); 15 Dec 2021 09:56:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Dec 2021 09:56:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id EE253100445;
        Wed, 15 Dec 2021 09:56:37 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E190510032A;
        Wed, 15 Dec 2021 09:56:37 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.26; Wed, 15 Dec 2021 09:56:24 +0000
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <naresh.kamboju@linaro.org>,
        <aleksei.kodanev@bell-sw.com>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH 2/3] selftests/zram01.sh: Fix compression ratio calculation
Date:   Wed, 15 Dec 2021 17:56:10 +0800
Message-ID: <1639562171-4434-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1639562171-4434-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

zram01 uses `free -m` to measure zram memory usage. The results are nonsense
because they are polluted by all running processes on the system.

Use the third field of /sys/block/zram<id>/mm_stat to measure memory usage instead. The file is
available since kernel 4.1.

orig_data_size(first): uncompressed size of data stored in this disk.
compr_data_size(second): compressed size of data stored in this disk
mem_used_total(third): the amount of memory allocated for this disk

Also remove useless zram cleanup call in zram_fill_fs and so we don't need to cleanup
zram twice if fails.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tools/testing/selftests/zram/zram01.sh | 30 +++++++-------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/zram/zram01.sh b/tools/testing/selftests/zram/zram01.sh
index 28583e4ae546..e083a4c628a8 100755
--- a/tools/testing/selftests/zram/zram01.sh
+++ b/tools/testing/selftests/zram/zram01.sh
@@ -30,8 +30,6 @@ zram_algs="lzo"
 
 zram_fill_fs()
 {
-	local mem_free0=$(free -m | awk 'NR==2 {print $4}')
-
 	for i in $(seq 0 $(($dev_num - 1))); do
 		echo "fill zram$i..."
 		local b=0
@@ -42,29 +40,17 @@ zram_fill_fs()
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

