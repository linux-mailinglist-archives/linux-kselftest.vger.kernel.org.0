Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD8E48D92
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfFQTJC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 15:09:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38891 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfFQTJC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 15:09:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id f97so4511774plb.5
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2019 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ipYsalW++aWX/HtsH6Myu+O36LYB3AuGav4jjmdKhY=;
        b=V1gsP4U1ZAvYgIIX44tfu3K0svmBKLPfM8YWqLcWaE8CnIsyUHIsR38kFIdk/TwU82
         Q16qvIEGDpah4VJbFGCNMerl5Z9Iu7ZqP1X7FsxhvHB1bGhGKa7Nu7CA69KTmAFtT/H/
         S3IV+V1GZ2ThsoT5MUWxm4aJQ7U9mdL5HYQHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ipYsalW++aWX/HtsH6Myu+O36LYB3AuGav4jjmdKhY=;
        b=BzW80oTGLLvH0Nxaws3y9hi5sNCtdmwrNaSgU2cz+tnyThVzOBhDlEjjUQE7nqcf1r
         3U3g50dhDTqJCjxtEAS5rpqZurIzjYOKsPJ9ruv6nagUadKQtniyp1jFq36rxNZjkw9G
         9R5zdpIWRzvOkFjh/D6xnPZUasaILi8/s2YhsLQE3SOkXPUbJThzIF9w51K30oYOEB+y
         MNTg4nGwUQanqFGWyOUBvE5+hZlBa32duLnJktwKRYMFkpmB60nikd5rRscSEmEmuL2A
         Qeb1D3Vmh21MqPdiF7aa6pbkyByt7p8gQV+DMrpcYGN0EQj0mmriOBTCd6ACZwrAxKDW
         swmA==
X-Gm-Message-State: APjAAAWTLeb91pjMm7CkNdboCd8pIWM+H3W5NBWswCnnPmVgVNFM/6/M
        h1aJU43UWengu7B8g6FmUG9xJg==
X-Google-Smtp-Source: APXvYqzJkonvB6Ms1+/AeevQyjb7W+PF3loXMUqCBYgZ3saSHHea2O1KZwF9JCGV4PWV/NkUok3Z/w==
X-Received: by 2002:a17:902:b18f:: with SMTP id s15mr112568173plr.44.1560798541612;
        Mon, 17 Jun 2019 12:09:01 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id p43sm111063pjp.4.2019.06.17.12.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:09:00 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 2/3] net/udpgso_bench.sh add UDP GSO audit tests
Date:   Mon, 17 Jun 2019 12:08:36 -0700
Message-Id: <20190617190837.13186-3-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190617190837.13186-1-fklassen@appneta.com>
References: <20190617190837.13186-1-fklassen@appneta.com>
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
    Zerocopy acks:               82772 received

Errors are thrown if CMSG count does not equal send count,
example:

    Summary over 4.000 seconds...
    sum tcp tx:   7451 MB/s     493706 calls (123426/s)     493706 msgs (123426/s)
    ./udpgso_bench_tx: Unexpected number of Zerocopy completions:    493706 expected    493704 received

Also reduce individual test time from 4 to 3 seconds so that
overall test time does not increase significantly.

v3: Enhancements as per Willem de Bruijn <willemb@google.com>
    - document -P option for TCP audit

Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 tools/testing/selftests/net/udpgso_bench.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index 5670a9ffd8eb..d4d831dfd44d 100755
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
@@ -48,10 +60,15 @@ run_tcp() {
 
 	echo "tcp zerocopy"
 	run_in_netns ${args} -t -z
+
+	# excluding for now because test fails intermittently
+	# add -P option to include poll() to reduce possibility of lost messages
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

