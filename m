Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421D83AFE45
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jun 2021 09:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhFVHtH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Jun 2021 03:49:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42507 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFVHtH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Jun 2021 03:49:07 -0400
Received: from mail-ej1-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <andrea.righi@canonical.com>)
        id 1lvb7S-00062d-Ua
        for linux-kselftest@vger.kernel.org; Tue, 22 Jun 2021 07:46:51 +0000
Received: by mail-ej1-f71.google.com with SMTP id g6-20020a1709064e46b02903f57f85ac45so2898926ejw.15
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Jun 2021 00:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=gkzHODbnM8daBg3AIPBb6tJrbxN6uQY+1xKALoYnH08=;
        b=MPBCcGmBy1owEUnNsRYZjyhem988z0dladwO2/xsqepahOePzgsTV3sncWGEDHg2Tt
         /1fnryIjY3nk/lARrmTmqWvAf5Hn7H0ix7gu8Jafb83qsSe9m5tr5sFn5D287AjCp634
         s+CyIeG6gwZQ8RgjVQTx8VM4spgXBZSqply7j89PKBhiWS6m78x/obKSSEL9BbNOH+Qm
         x4xiREPWZA0w7F2pnJDHrn0i+RawHn1SggGXadLDNBDORvhGaWS96U0FCerCQHS6usmW
         cQwFv6pGzNxYlOWCiSKehQKUw3K1vEC4p7AQkG3Nl/OHKQ7uLvH84nuMtvjhphMRYT1U
         SyVA==
X-Gm-Message-State: AOAM532baZeJCvm1gjyliripEuPAwDRFxVgA29c7I8XWdUAsL56J0T+T
        0tilzvROFIzJZoQexY8gGODECqTiQ5j+nddwV4HFskGfOetRDmA1XCDH1KwLr0ynIusDihypKuf
        Typv67S7b/fucsoXkMNzp4OYwwruHG3AJAhibcxsSmnddVQ==
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr2601237ejb.223.1624348010652;
        Tue, 22 Jun 2021 00:46:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIlw5fW0wDk/Ey6dRYR73+BZfoCZvTUZp9lpo+etdQ19/JfB47C77gI0Ydc8r+ywMF3Ler1A==
X-Received: by 2002:a17:906:dbd5:: with SMTP id yc21mr2601222ejb.223.1624348010488;
        Tue, 22 Jun 2021 00:46:50 -0700 (PDT)
Received: from localhost (host-82-55-56-150.retail.telecomitalia.it. [82.55.56.150])
        by smtp.gmail.com with ESMTPSA id t18sm6959701eds.86.2021.06.22.00.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 00:46:49 -0700 (PDT)
Date:   Tue, 22 Jun 2021 09:46:48 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: icmp_redirect: support expected failures
Message-ID: <YNGVaO0pN9VqR8tJ@xps-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

According to a comment in commit 99513cfa16c6 ("selftest: Fixes for
icmp_redirect test") the test "IPv6: mtu exception plus redirect" is
expected to fail, because of a bug in the IPv6 logic that hasn't been
fixed yet apparently.

We should probably consider this failure as an "expected failure",
therefore change the script to return XFAIL for that particular test and
also report the total amount of expected failures at the end of the run.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/net/icmp_redirect.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index bf361f30d6ef..c19ecc6a8614 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -63,10 +63,14 @@ log_test()
 	local rc=$1
 	local expected=$2
 	local msg="$3"
+	local xfail=$4
 
 	if [ ${rc} -eq ${expected} ]; then
 		printf "TEST: %-60s  [ OK ]\n" "${msg}"
 		nsuccess=$((nsuccess+1))
+	elif [ ${rc} -eq ${xfail} ]; then
+		printf "TEST: %-60s  [XFAIL]\n" "${msg}"
+		nxfail=$((nxfail+1))
 	else
 		ret=1
 		nfail=$((nfail+1))
@@ -322,7 +326,7 @@ check_exception()
 		ip -netns h1 -6 ro get ${H1_VRF_ARG} ${H2_N2_IP6} | \
 		grep -v "mtu" | grep -q "${R1_LLADDR}"
 	fi
-	log_test $? 0 "IPv6: ${desc}"
+	log_test $? 0 "IPv6: ${desc}" 1
 }
 
 run_ping()
@@ -488,6 +492,7 @@ which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 ret=0
 nsuccess=0
 nfail=0
+nxfail=0
 
 while getopts :pv o
 do
@@ -532,5 +537,6 @@ fi
 
 printf "\nTests passed: %3d\n" ${nsuccess}
 printf "Tests failed: %3d\n"   ${nfail}
+printf "Tests xfailed: %3d\n"  ${nxfail}
 
 exit $ret
-- 
2.31.1

