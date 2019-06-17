Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CEE48D95
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 21:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfFQTJF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 15:09:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37291 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbfFQTJE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 15:09:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id bh12so4505093plb.4
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2019 12:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AgZjqRyH2K7f5nt81N/Z9x10UGeAyLYjRs3Qaal5mvg=;
        b=tK6ioCCuHTYwjmhNb0zkVGqPYYSf0LG5fmMrPXYJEg6T4TKbEjl18BieKwOnAFp9V2
         +rnKaeoEh/x3eBralvFP43griB+gXtwyldSbfT/7gd1doKvqEtykuZUeZEMgyvFmupkZ
         8mkTaehAvn2QsQSE6D7nX3n3Uy263loL5hMzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AgZjqRyH2K7f5nt81N/Z9x10UGeAyLYjRs3Qaal5mvg=;
        b=mDpOg8zm0AQEcMQz6R9m34XcFagzJM+s87RsszCsDK4+67OgEznzTyh7Kwlw4tYpeQ
         LnZjFgQ9X4WWlZ6JSMifT4S65dhjih3PfYLDywGSV+zvHoWJlC0XR1i0m7shUDb36KmO
         jXjUQUO9ZiJOUPvfh0okbdDfe0j7EO0PAGSSmmnRPj/wad2mToqFmj6RHxuvVbtMGlhQ
         0Hz3ZWNvw8B1Ge5QJLHiKMYrIU8vm2UM3ztgnJ7xbz/FlqGp6Bww14JhMer3kNFYZ5tw
         M9GoutwyOzCfyh7tSb5vJ/XvdPoRpfcsxHhEl8wQ+BI3L3zl1W9bUWbJiGfr98DIbZzS
         K09A==
X-Gm-Message-State: APjAAAWEKjGad54b9r9p8IsXU9O48UvkEDlFX65g0rtZYj8UN79bW8yn
        SlY19BcJP7smXg9XF6lzV/S7yg==
X-Google-Smtp-Source: APXvYqw2g/5IBjCumoQRuoTgKrTyAScBK+YOe2q2oR9TTBVytYux8/m5VdvdVVDdtek7Th51xgWYuA==
X-Received: by 2002:a17:902:8205:: with SMTP id x5mr10889097pln.279.1560798544272;
        Mon, 17 Jun 2019 12:09:04 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id p43sm111063pjp.4.2019.06.17.12.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:09:03 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v3 3/3] net/udpgso_bench.sh test fails on error
Date:   Mon, 17 Jun 2019 12:08:37 -0700
Message-Id: <20190617190837.13186-4-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190617190837.13186-1-fklassen@appneta.com>
References: <20190617190837.13186-1-fklassen@appneta.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ensure that failure on any individual test results in an overall
failure of the test script.

Signed-off-by: Fred Klassen <fklassen@appneta.com>
---
 tools/testing/selftests/net/udpgso_bench.sh | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/udpgso_bench.sh b/tools/testing/selftests/net/udpgso_bench.sh
index d4d831dfd44d..4df1cd8d69d2 100755
--- a/tools/testing/selftests/net/udpgso_bench.sh
+++ b/tools/testing/selftests/net/udpgso_bench.sh
@@ -3,6 +3,10 @@
 #
 # Run a series of udpgso benchmarks
 
+GREEN='\033[0;92m'
+RED='\033[0;31m'
+NC='\033[0m' # No Color
+
 wake_children() {
 	local -r jobs="$(jobs -p)"
 
@@ -29,60 +33,89 @@ run_in_netns() {
 
 run_udp() {
 	local -r args=$@
+	local errors=0
 
 	echo "udp"
 	run_in_netns ${args}
+	errors=$(( $errors + $? ))
 
 	echo "udp gso"
 	run_in_netns ${args} -S 0
+	errors=$(( $errors + $? ))
 
 	echo "udp gso zerocopy"
 	run_in_netns ${args} -S 0 -z
+	errors=$(( $errors + $? ))
 
 	echo "udp gso timestamp"
 	run_in_netns ${args} -S 0 -T
+	errors=$(( $errors + $? ))
 
 	echo "udp gso zerocopy audit"
 	run_in_netns ${args} -S 0 -z -a
+	errors=$(( $errors + $? ))
 
 	echo "udp gso timestamp audit"
 	run_in_netns ${args} -S 0 -T -a
+	errors=$(( $errors + $? ))
 
 	echo "udp gso zerocopy timestamp audit"
 	run_in_netns ${args} -S 0 -T -z -a
+	errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 run_tcp() {
 	local -r args=$@
+	local errors=0
 
 	echo "tcp"
 	run_in_netns ${args} -t
+	errors=$(( $errors + $? ))
 
 	echo "tcp zerocopy"
 	run_in_netns ${args} -t -z
+	errors=$(( $errors + $? ))
 
 	# excluding for now because test fails intermittently
 	# add -P option to include poll() to reduce possibility of lost messages
 	#echo "tcp zerocopy audit"
 	#run_in_netns ${args} -t -z -P -a
+	#errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 run_all() {
 	local -r core_args="-l 3"
 	local -r ipv4_args="${core_args} -4 -D 127.0.0.1"
 	local -r ipv6_args="${core_args} -6 -D ::1"
+	local errors=0
 
 	echo "ipv4"
 	run_tcp "${ipv4_args}"
+	errors=$(( $errors + $? ))
 	run_udp "${ipv4_args}"
+	errors=$(( $errors + $? ))
 
 	echo "ipv6"
 	run_tcp "${ipv4_args}"
+	errors=$(( $errors + $? ))
 	run_udp "${ipv6_args}"
+	errors=$(( $errors + $? ))
+
+	return $errors
 }
 
 if [[ $# -eq 0 ]]; then
 	run_all
+	if [ $? -ne 0 ]; then
+		echo -e "$(basename $0): ${RED}FAIL${NC}"
+		exit 1
+	fi
+
+	echo -e "$(basename $0): ${GREEN}PASS${NC}"
 elif [[ $1 == "__subprocess" ]]; then
 	shift
 	run_one $@
-- 
2.11.0

