Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710B46FB3F
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 08:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237462AbhLJH33 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 02:29:29 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45544
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237453AbhLJH33 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 02:29:29 -0500
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BDEC63F1B7
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Dec 2021 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1639121153;
        bh=76g9H+24WdaefKNkB80dgj1hR5XkeQFM1Oi8e8gaqLE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=RfFw4HbksWRmq6T0Z0A5zBMsjle+Wiw6jA1u2QdifklgBzmpg5BxTrq1QPcjI731/
         XJZ99GiSGNzHXj3n7hhu/drNPHsLauXFQ8kAJQoTg7iXSPimTwov6gbXVw57/JeRFU
         iNeBydvnodVUyelRAgL81ZsjA/t+eYmfgrqcrAyaBUngJ591apAVdlR5WHgIpX/T3Y
         Pj9G7eGpzwtBWN1MxIRh7yPVcSuNayGrWYdDtrkBv0Pw5YwHY6gXq4RHkcZJl84eje
         HWJeezO30NG7cacF3xnCAFmGUZ/JqmVRJYRva2DfnuCW2dOro+dFzI9naw8FGXNWEa
         u/UDwcEzrznyA==
Received: by mail-pg1-f200.google.com with SMTP id k11-20020a63d84b000000b003252e72da7eso4727861pgj.23
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 23:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=76g9H+24WdaefKNkB80dgj1hR5XkeQFM1Oi8e8gaqLE=;
        b=5uUacbuS/DuNibWHPMagvPrE/eTHx+I+qzYtdn4Rig0Hr7+hkp8Hyz1Kie91PB4FOz
         Y0gNU8fq5/RonY4vPBWE4vuDHsptkvGRbcMhzV1r4ip3c83hCwi0ti4hWOt1dNxjDT/F
         OtIev76og4czANsUHKr/CCQ8a9ft9W0yR+4d6LNqrgahfNIu+3Cc/D2wCDNowkYF4lqK
         B0NNtMRdNpkiQZMBWRI0ZRVjqhCTRYf05RO+vfbkyQyuyn2kb0JQ7Kzuwq7mli5otiJ/
         zxUwHvsF2+pNdGW4biBZWzJDmjxYllwAzBHGS5rFHP3PV5A2Zc9nJBAjzkY4P/R2JvUt
         SqVg==
X-Gm-Message-State: AOAM532ffxOTVYLIVHf2W1c/1R/mzCtl6pK3mjfmUg/bpnC3gReuLwgJ
        Nhf1rk7APWWqsLaKXD00Q861xrQmLxDUZ1M2ppzIPW6+GS9Zscg1X/R6KnIlCxh05gfnLkN6obD
        Buvmu3/VCbzgSjsoSXVp3sEGw+At3aRLhNXTnLSfHOQnW
X-Received: by 2002:a17:903:2352:b0:142:76bc:de3b with SMTP id c18-20020a170903235200b0014276bcde3bmr73296468plh.36.1639121152133;
        Thu, 09 Dec 2021 23:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzetkN44F8aKYW+okI7AjCcEBNigejRUZfb7v/OkzJmGpRM+L3VZl6OPtHP4nhDAV6iLWfvg==
X-Received: by 2002:a17:903:2352:b0:142:76bc:de3b with SMTP id c18-20020a170903235200b0014276bcde3bmr73296438plh.36.1639121151849;
        Thu, 09 Dec 2021 23:25:51 -0800 (PST)
Received: from localhost.localdomain (2001-b011-2014-bac3-aa4d-91f5-d678-c6c2.dynamic-ip6.hinet.net. [2001:b011:2014:bac3:aa4d:91f5:d678:c6c2])
        by smtp.gmail.com with ESMTPSA id c2sm2035762pfv.112.2021.12.09.23.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 23:25:50 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     po-hsu.lin@canonical.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org,
        andrea.righi@canonical.com, dsahern@kernel.org
Subject: [PATCHv2] selftests: icmp_redirect: pass xfail=0 to log_test()
Date:   Fri, 10 Dec 2021 15:25:23 +0800
Message-Id: <20211210072523.38886-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If any sub-test in this icmp_redirect.sh is failing but not expected
to fail. The script will complain:
    ./icmp_redirect.sh: line 72: [: 1: unary operator expected

This is because when the sub-test is not expected to fail, we won't
pass any value for the xfail local variable in log_test() and thus
it's empty. Fix this by passing 0 as the 4th variable to log_test()
for non-xfail cases.

v2: added fixes tag

Fixes: 0a36a75c6818 ("selftests: icmp_redirect: support expected failures")
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/icmp_redirect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/icmp_redirect.sh b/tools/testing/selftests/net/icmp_redirect.sh
index ecbf57f..7b9d6e3 100755
--- a/tools/testing/selftests/net/icmp_redirect.sh
+++ b/tools/testing/selftests/net/icmp_redirect.sh
@@ -311,7 +311,7 @@ check_exception()
 		ip -netns h1 ro get ${H1_VRF_ARG} ${H2_N2_IP} | \
 		grep -E -v 'mtu|redirected' | grep -q "cache"
 	fi
-	log_test $? 0 "IPv4: ${desc}"
+	log_test $? 0 "IPv4: ${desc}" 0
 
 	# No PMTU info for test "redirect" and "mtu exception plus redirect"
 	if [ "$with_redirect" = "yes" ] && [ "$desc" != "redirect exception plus mtu" ]; then
-- 
2.7.4

