Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A923B8AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 12:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHDKSk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 06:18:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbgHDKSW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 06:18:22 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1k2u1U-0006aP-5v
        for linux-kselftest@vger.kernel.org; Tue, 04 Aug 2020 10:18:20 +0000
Received: by mail-pj1-f70.google.com with SMTP id k103so1772516pje.2
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 03:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9y6aVddCClGzQPDVtd0OG0Kza0yw4aTj1d1wJ/cWqtg=;
        b=h+VT5bXATy9oFeW7o605MKfKFiEG4pLcSjrJdTM+p0jWfS2sUhsN3N3TD6NuV0POrw
         qcUcmgKzqmck3LvqAs3A0lodG0Z+AsBPBHAtB3HVWcf7JdnJEtnpIYYwcrSIeXiQHaIl
         U6e5jIF+xv3QDK5QsEwUMWpR2ai1Od9SiymTQZn/h8Ld1g+4uNEj7ajkGNXuOuRA9NLq
         ocgrFTLGGBejybdk0wzF3htCg60M/a3Rf6bbDmnLQzzwiwlteXs4cTpy8Q+Q7yxjQXpo
         y9wZBbSqvSVxkLFIae/SfsrfAukNyRJ2vaVw7/6Vpne65jcULfwZBYzdb1WJT26eyz+0
         2xhQ==
X-Gm-Message-State: AOAM532Ac66g0XadNgqZ0nXXLUV3Xtl6L6x2phqdRmyNCYrzpoptLWil
        s7A2BiKnrlHavtHT8/HcXorlRQln3AdWyPqzG0PIOiY84j8wWtxw0Z5AiC62EJQQKBCPrBdPTeD
        dVqM7U/1V1i1WDSlBD6TxiO2eh+rHmobRYnmQ8JDfcctw
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr320658pfu.312.1596536298836;
        Tue, 04 Aug 2020 03:18:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsE+Fcirt/qLaliPJjElSz4ZKTaaDIQH60WMh+u73qbKMH7YGedwDZUr3UiAQLoAb4EXty9A==
X-Received: by 2002:a05:6a00:790:: with SMTP id g16mr320636pfu.312.1596536298468;
        Tue, 04 Aug 2020 03:18:18 -0700 (PDT)
Received: from localhost.localdomain (111-71-32-223.emome-ip.hinet.net. [111.71.32.223])
        by smtp.gmail.com with ESMTPSA id g15sm15578674pfh.70.2020.08.04.03.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 03:18:17 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: rtnetlink: make kci_test_encap() return sub-test result
Date:   Tue,  4 Aug 2020 18:18:03 +0800
Message-Id: <20200804101803.23062-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200804101803.23062-1-po-hsu.lin@canonical.com>
References: <20200804101803.23062-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kci_test_encap() is actually composed by two different sub-tests,
kci_test_encap_vxlan() and kci_test_encap_fou()

Therefore we should check the test result of these two in
kci_test_encap() to let the script be aware of the pass / fail status.
Otherwise it will generate false-negative result like below:
    $ sudo ./test.sh
    PASS: policy routing
    PASS: route get
    PASS: preferred_lft addresses have expired
    PASS: promote_secondaries complete
    PASS: tc htb hierarchy
    PASS: gre tunnel endpoint
    PASS: gretap
    PASS: ip6gretap
    PASS: erspan
    PASS: ip6erspan
    PASS: bridge setup
    PASS: ipv6 addrlabel
    PASS: set ifalias 5b193daf-0a08-46d7-af2c-e7aadd422ded for test-dummy0
    PASS: vrf
    PASS: vxlan
    FAIL: can't add fou port 7777, skipping test
    PASS: macsec
    PASS: bridge fdb get
    PASS: neigh get
    $ echo $?
    0

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/rtnetlink.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
index 9db66be..7c38a90 100755
--- a/tools/testing/selftests/net/rtnetlink.sh
+++ b/tools/testing/selftests/net/rtnetlink.sh
@@ -564,9 +564,12 @@ kci_test_encap()
 	check_err $?
 
 	kci_test_encap_vxlan "$testns"
+	check_err $?
 	kci_test_encap_fou "$testns"
+	check_err $?
 
 	ip netns del "$testns"
+	return $ret
 }
 
 kci_test_macsec()
-- 
2.7.4

