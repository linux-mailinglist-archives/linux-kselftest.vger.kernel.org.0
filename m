Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C582CEE2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2019 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfE1Src (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 May 2019 14:47:32 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33193 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfE1SrZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 May 2019 14:47:25 -0400
Received: by mail-pf1-f179.google.com with SMTP id z28so12028247pfk.0
        for <linux-kselftest@vger.kernel.org>; Tue, 28 May 2019 11:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=appneta.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GEQ1n/oEBDlyMtci6j+nHwcG1xlJk5jGvn6FttMMa9I=;
        b=nHz6brCdXv1SBf9KOaNq4ai8ItEU7CXjscWf/3mCEp9Or8drqkwYVLi3XGHxegLHs7
         PaQMR6YE4AcPTwMGpxM0fqHz/LABU8osUQ0+t1eYJ/OiOqhjkpk40sdQrqwMHJUuXamr
         DEwARfif1xO0sT52llKEg7onOa/HooMFn0z2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GEQ1n/oEBDlyMtci6j+nHwcG1xlJk5jGvn6FttMMa9I=;
        b=cT5QsJf2jg13dfkN25L6qtDZL+sf2zxfWlPpFE+LDMW4CkLL22DZjE5ikL2B15nIAm
         yi1TZ4AzY4u0QVw5wMv4FUB/HJikTsQysMBR7J873CbJ1sQO7UrFuLs01LSDxlYy01iQ
         4rVvVUs9vuavG7Qht0DJ4c/jaIQyREixa4mOX6RwJJr5CRCx6/V+l+VgisOvk0wGXnZP
         agvQZACazDwKchHDsCoSsYICsV6hMedRHbjfTbTPxt5K8GxEojJl/moLNUTGEnk5mdH2
         0QAFOXdCHhIOv6gx75GnPO4MMq6buBbbdEBWE8wW/cS7hm0a2iKZzvhzgOr8e2mcaBMK
         aAgA==
X-Gm-Message-State: APjAAAVzoWEOT6wxh1Do5CXL5Z8kuY8U3KRuuRGq4FNwIVpLYdXulIkb
        ZNpY4XPXBHVbL9KAMyYQdlgtdQ==
X-Google-Smtp-Source: APXvYqwpEQ4jyPsyWGKKc/+WwpmgAnxiutsae8V7JtWRZWdcxcAezFCLp8r5bP3IT9KQQQVPleqdOw==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr7372750pjc.3.1559069244681;
        Tue, 28 May 2019 11:47:24 -0700 (PDT)
Received: from linux-net-fred.jaalam.net ([2001:4958:15a0:24:5054:ff:fecb:7a95])
        by smtp.googlemail.com with ESMTPSA id m6sm3323766pjl.18.2019.05.28.11.47.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:47:24 -0700 (PDT)
From:   Fred Klassen <fklassen@appneta.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Cc:     Fred Klassen <fklassen@appneta.com>
Subject: [PATCH net-next v2 3/3] net/udpgso_bench.sh test fails on error
Date:   Tue, 28 May 2019 11:47:08 -0700
Message-Id: <20190528184708.16516-4-fklassen@appneta.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190528184708.16516-1-fklassen@appneta.com>
References: <20190528184708.16516-1-fklassen@appneta.com>
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
index 89c7de97b832..3a8543b14d3f 100755
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
 
@@ -29,59 +33,88 @@ run_in_netns() {
 
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

