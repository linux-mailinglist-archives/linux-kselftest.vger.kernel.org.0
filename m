Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25E446CE2A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Dec 2021 08:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244464AbhLHHPw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Dec 2021 02:15:52 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:53104
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240517AbhLHHPv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Dec 2021 02:15:51 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6B5F940058
        for <linux-kselftest@vger.kernel.org>; Wed,  8 Dec 2021 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638947538;
        bh=HnHitcAxy5IK/OBfpwXFwbcANQpnXZnDkjq+md2LzKU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=f4P02E83eUUCRKAdM4e689RYuwEhZr6ixCcUv5HbrpqgZKx6n27Eta9GSJEkfdtuR
         53/lso+bOkynV20+u7pC7WcmbSFIxl/w6jRlpVJaAXAFuWM+2AJ8K8cHCEBUUE7aS5
         b4pONqyoJpJT1Crjzq/7IaSwJ8jx5FhSjUnCtlShNeipnBYK3t8W4nAZmX20H4FJao
         kia1Ev9dNZWqfnAyg3k7GR9ZnUN0JxmnkvMhXAsYbg9/domooFVDqY1xb8T9jzU1h6
         cualjG2hLnmBBLgohMsqIS/5/HrcD3dx2ZjNvlhfELcGFhn8CGR05zfzX5zdty069+
         tctAjlMYGMXlw==
Received: by mail-pg1-f199.google.com with SMTP id u22-20020a632356000000b003308cbcefb0so845994pgm.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Dec 2021 23:12:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HnHitcAxy5IK/OBfpwXFwbcANQpnXZnDkjq+md2LzKU=;
        b=HnqIwGjeDoWBAwBaIREdtNNh3ns9b86tyfAgkKjBl8QhEyCNU+OTBs543iLbJ9zp3+
         uV/1tHKzxLQs5sm7IprJS7UEbIimOl17RLEgyEpFua6OGreHiLQ/4RH7/vFMeEgDVkcC
         80rRLdix5r4Ka1EGKStofawUH3RvBTDNzL0UqdgyjIlcFei6dOra3p8QgGIu1uXydYJJ
         HogOnUX3Lz8bbFyKdm6UT9wDoi1rG+KSZ+YBct1a8ikOV0Yx371Q019hxjCPHtgvbNZu
         Py1EjL3c5MsMGGA4mVEMGyppqdmgpq8U1HXYih/gEMXfvlm+jIXlcAf3L8m+2siEtuBB
         iGlg==
X-Gm-Message-State: AOAM5319v/xMr0xgkVn/oowxhP1XzJJyeFj47O0DE0NhNGFw/9PSFmuT
        fQQxXaJIVXwZO6oD0ZilpebAJNwQtU+BH8ZukBLDnzCxmH4tfjCfZ3yC6ADpa+RA+naH8P9FuSS
        melnI8fzmA/3nyj/9kgVOvPMHSAKsFVKtLby2xw7uhhlt
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr4926232pjb.163.1638947536663;
        Tue, 07 Dec 2021 23:12:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwl/Wa5GJglcK7GX5ZcWjy7TK24G/ysS+nwdSmTg8a2IuruvhOXnZZNFhsAR+v08zrhmczRfg==
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr4926217pjb.163.1638947536421;
        Tue, 07 Dec 2021 23:12:16 -0800 (PST)
Received: from localhost.localdomain (223-140-212-111.emome-ip.hinet.net. [223.140.212.111])
        by smtp.gmail.com with ESMTPSA id y190sm1946116pfb.203.2021.12.07.23.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 23:12:15 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     po-hsu.lin@canonical.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org
Subject: [PATCH] selftests: icmp_redirect: pass xfail=0 to log_test() for non-xfail cases
Date:   Wed,  8 Dec 2021 15:11:51 +0800
Message-Id: <20211208071151.63971-1-po-hsu.lin@canonical.com>
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

