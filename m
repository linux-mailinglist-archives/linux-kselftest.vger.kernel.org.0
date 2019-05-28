Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06192CEE4
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 20:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbfE1SrX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 14:47:23 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35867 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfE1SrX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 14:47:23 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so8710476plr.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yB3ItIPtEUw2eZGEY3aSVErHK6RTuXYR3P9ZM9krb4k=;
        b=KxfdITFlLCIgGVWepRp7OKNXZdvFHywQLRda+kG7t19ksHD/JbG6XFA4HJJt+6/f0F
         3qYtCcGU0S/m6PU87YB75X3E5Q7ulwHeA7uGoy+dTcTNHW4ozb/xWQELfuejmOKUrbkp
         9MTfNddkNEW/6wik0fkf6q8vmcOiS6VGhxOgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yB3ItIPtEUw2eZGEY3aSVErHK6RTuXYR3P9ZM9krb4k=;
        b=dwoe0oA11QYR4WvrZFoobJWsm+vDkvB+hCa+1lbZXlqGaU+wmO5SUr6TJWe9k0/QO3
         08lI3ICLQMcHtOKXp6NCPw8Rbesl9defibbyeTVOD8cr7PftJJkhpGBeh0PvEJaswyFQ
         kq2rIxCTKaO/DpABDrPKoQROLgFboPWNqEnf0xfhn+cFDbTecXs1rMRDbx+zRy/Mzm8D
         /bR2p+PgZ9b+4ai0z1gH8979N4ELUBebp9xfQbqBHJ6eotT9ShsxW1UsNJo/FW4QcCbi
         8FV50EUsgWuL/iB8OUzDy2C1pPtOMstOdxmaurlaUg1YKEzpJn9548E5VbAZj3DibebV
         GQHA==
X-Gm-Message-State: APjAAAUjnpdtqyOXjQhdoU0cjyKRWhgf/XpQYmJjFsftBaB/mBrfi0vR
        KmEURp2al0Jf4WAMdAg7ZXG14Q==
X-Google-Smtp-Source: APXvYqw07DmvgaH6rrcnS2lswuSNUkH6uQSFP/SqouoWhuk3rcBu+8I4JrKW31+eYDYJLrgSeCteqA==
X-Received: by 2002:a17:902:14e:: with SMTP id 72mr91727811plb.36.1559069242561;
        Tue, 28 May 2019 11:47:22 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id m6sm3323766pjl.18.2019.05.28.11.47.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:47:21 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v2 2/3] net/udpgso_bench.sh add UDP GSO audit tests
Date:   Tue, 28 May 2019 11:47:07 -0700
Message-Id: <20190528184708.16516-3-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190528184708.16516-1-fklassen@appneta.com>
References: <20190528184708.16516-1-fklassen@appneta.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Audit tests count the total number of messages sent and compares
with total number of CMSG received on error queue. Example:

    udp gso zerocopy timestamp audit
    udp rx:   1599 MB/s  1166414 calls/s
    udp tx:   1615 MB/s    27395 calls/s  27395 msg/s
    udp rx:   1634 MB/s  1192261 calls/s
    udp tx:   1633 MB/s    27699 calls/s  27699 msg/s
    udp rx:   1633 MB/s  1191358 calls/s
    udp tx:   1631 MB/s    27678 calls/s  27678 msg/s
    Summary over 4.000 seconds...
    sum udp tx:   1665 MB/s      82772 calls (27590/s)      82772 msgs (27590/s)
    Tx Timestamps:               82772 received                 0 errors
    Zerocopy acks:               82772 received                 0 errors

Errors are thrown if CMSG count does not equal send count,
example:

    Summary over 4.000 seconds...
    sum tcp tx:   7451 MB/s     493706 calls (123426/s)     493706 msgs (123426/s)
    ./udpgso_bench_tx: Unexpected number of Zerocopy completions:    493706 expected    493704 received

Also reduce individual test time from 4 to 3 seconds so that
overall test time does not increase significantly.

Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 tools/testing/selftests/net/udpgso_bench.sh | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index 5670a9ffd8eb..89c7de97b832 100755
--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -38,6 +38,18 @@ run_udp() {
 
 	echo "udp gso zerocopy"
 	run_in_netns ${args} -S 0 -z
+
+	echo "udp gso timestamp"
+	run_in_netns ${args} -S 0 -T
+
+	echo "udp gso zerocopy audit"
+	run_in_netns ${args} -S 0 -z -a
+
+	echo "udp gso timestamp audit"
+	run_in_netns ${args} -S 0 -T -a
+
+	echo "udp gso zerocopy timestamp audit"
+	run_in_netns ${args} -S 0 -T -z -a
 }
 
 run_tcp() {
@@ -48,10 +60,14 @@ run_tcp() {
 
 	echo "tcp zerocopy"
 	run_in_netns ${args} -t -z
+
+	# excluding for now because test fails intermittently
+	#echo "tcp zerocopy audit"
+	#run_in_netns ${args} -t -z -P -a
 }
 
 run_all() {
-	local -r core_args="-l 4"
+	local -r core_args="-l 3"
 	local -r ipv4_args="${core_args} -4 -D 127.0.0.1"
 	local -r ipv6_args="${core_args} -6 -D ::1"
 
-- 
2.11.0

