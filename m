Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365D92A7C3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 11:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgKEKv5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 05:51:57 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55495 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbgKEKv5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 05:51:57 -0500
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kacrz-0001dB-Hr
        for linux-kselftest@vger.kernel.org; Thu, 05 Nov 2020 10:51:55 +0000
Received: by mail-pl1-f199.google.com with SMTP id q4so719149plr.11
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 02:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=alpUZmQGLbMuYK81rXNRCcjvcowcPh9T6MSx82lKiec=;
        b=YaUmqysqDdJymUj8eCtDsRCErtD7zTi9XlZ7lieixcsRJNuw2R9pXLsgAKJaHzNV18
         q0lX3DjlHNKHKOujHK8wrE+bynVc8HvT3aX/Wy+UBuauUHYO/b3yCBIAy75Kj/iUqpFY
         IUkSgUKPip8bFah9wXczYEnOZNWn88uLxWzTVGZzIr8b3aDycPc7TxEPHHaxoSd4Y091
         gyafnQ+r8HksHI0rZIxA8wx9WfX64zF8/5i5UvItMoF/Jm6852p1tQfQnslTaxCl09dR
         ovhIBZXiAL5IqThYqXkUuQD3Pi2WjcSECtkgKWMJT/LELe6i1Mm3Q56kbC6PG7Pr1zOT
         DYkg==
X-Gm-Message-State: AOAM531zrCYpTCKvrUmDVm4gdMQedsVeDNsoZpdlF4BWL95SXbmIaaKK
        3aQnBmOOvnWGShXdluLQeKBe/VBFWwUvMcSgg6Ys5s7mJIvKE9OhWY4pw68fr+mjIkd5iAZu5H/
        gp/oQeu7B1i1egJZ0P8MqF98aiAr7//SJmdzshXVhyHXt
X-Received: by 2002:a62:a20f:0:b029:18b:70ec:c75b with SMTP id m15-20020a62a20f0000b029018b70ecc75bmr1869756pff.56.1604573514104;
        Thu, 05 Nov 2020 02:51:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxm6D6AphgKi9umY76yGJvo+o3+E9e0cfpUr3OX61bXWYmCDZDOWKSumpKxjjcUertxQ3u01w==
X-Received: by 2002:a62:a20f:0:b029:18b:70ec:c75b with SMTP id m15-20020a62a20f0000b029018b70ecc75bmr1869733pff.56.1604573513836;
        Thu, 05 Nov 2020 02:51:53 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1560:8007::aac:c227])
        by smtp.gmail.com with ESMTPSA id c3sm1866852pjv.27.2020.11.05.02.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 02:51:53 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, skhan@linuxfoundation.org,
        po-hsu.lin@canonical.com
Subject: [PATCH 2/2] selftests: pmtu.sh: improve the test result processing
Date:   Thu,  5 Nov 2020 18:50:51 +0800
Message-Id: <20201105105051.64258-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105105051.64258-1-po-hsu.lin@canonical.com>
References: <20201105105051.64258-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test will treat all non-zero return codes as failures, it will
make the pmtu.sh test script being marked as FAILED when some
sub-test got skipped.

Improve the result processing by
  * Only mark the whole test script as SKIP when all of the
    sub-tests were skipped
  * If the sub-tests were either passed or skipped, the overall
    result will be PASS
  * If any of them has failed, the overall result will be FAIL
  * Treat other return codes (e.g. 127 for command not found) as FAIL

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/pmtu.sh | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index fb53987..5c86fb1 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1652,7 +1652,23 @@ run_test() {
 	return $ret
 	)
 	ret=$?
-	[ $ret -ne 0 ] && exitcode=1
+	case $ret in
+		0)
+			all_skipped=false
+			[ $exitcode=$ksft_skip ] && exitcode=0
+		;;
+		1)
+			all_skipped=false
+			exitcode=1
+		;;
+		$ksft_skip)
+			[ $all_skipped = true ] && exitcode=$ksft_skip
+		;;
+		*)
+			all_skipped=false
+			exitcode=1
+		;;
+	esac
 
 	return $ret
 }
@@ -1786,6 +1802,7 @@ usage() {
 #
 exitcode=0
 desc=0
+all_skipped=true
 
 while getopts :ptv o
 do
-- 
2.7.4

