Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B872ACAD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Nov 2020 03:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgKJCB3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Nov 2020 21:01:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42889 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730066AbgKJCBT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Nov 2020 21:01:19 -0500
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kcIyD-0001tM-Bx
        for linux-kselftest@vger.kernel.org; Tue, 10 Nov 2020 02:01:17 +0000
Received: by mail-pg1-f199.google.com with SMTP id a27so3759923pga.6
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Nov 2020 18:01:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Kx4/PLABbjYnKNkiHtBsxcWT2xciwp1tmLJYXsoWZU=;
        b=FJ+tCAEaYGsF8uQ7FzVGTNxFKpsDJ1vVvwoL94F27otmEWjIFrIP3qbQaQn6BtZGAp
         mZNxcWdON5TXGPhDb9lPZ/ztj4jPS4TN4RqVwSl5BH9/dMFKgtX+0I8YIc/dlBhAoewX
         c9BILfGeJTDUY6wFI9Utiwp3jKBgReLv8RAH0vvs7RuAGEKU3MYxouWpl154v19uf+yn
         ya9dkQnYWt7aU+UQSqde/MB7cxLgxnqA+CO5YVLsbbtWXUpVyAAYfJymcwMiy0O18uxp
         lUk9uTJIDUQ/SzSgzae4rfSl85d7dnUJLKj/+5h/yR51xtG+0KM0QYfmOTpC8cYPXXl+
         /bKA==
X-Gm-Message-State: AOAM53062SnP/3qZ8jKT6DLnz5w+c8ZAiAxHMvqLfBnPrR74Hd6VXgOO
        CfYBdgh5DlGFD/TitBE1oQdajegbbEo6QKZ1MCGZJ2wQWSOBV4vGKuq3lgOSOu1X6EDZhm6cNto
        AqxUUWSgvu0RHZxQ9wdM1m1oN+dL9p143HLRA0l0HKgHG
X-Received: by 2002:a63:6647:: with SMTP id a68mr14774506pgc.7.1604973676040;
        Mon, 09 Nov 2020 18:01:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy0B3U5VvdSOcU/vErmbB0v844zQxLGn9Arj0dwJAMg7XIjfxQj5kQ++rMnRkGehRdOtJL9Jg==
X-Received: by 2002:a63:6647:: with SMTP id a68mr14774484pgc.7.1604973675818;
        Mon, 09 Nov 2020 18:01:15 -0800 (PST)
Received: from localhost.localdomain (223-136-189-104.emome-ip.hinet.net. [223.136.189.104])
        by smtp.gmail.com with ESMTPSA id c193sm11855552pfb.78.2020.11.09.18.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 18:01:15 -0800 (PST)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, kuba@kernel.org
Cc:     davem@davemloft.net, skhan@linuxfoundation.org,
        po-hsu.lin@canonical.com
Subject: [PATCHv2 2/2] selftests: pmtu.sh: improve the test result processing
Date:   Tue, 10 Nov 2020 10:00:49 +0800
Message-Id: <20201110020049.6705-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110020049.6705-1-po-hsu.lin@canonical.com>
References: <20201110020049.6705-1-po-hsu.lin@canonical.com>
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
  * If any of them has failed with return code 1 or anything bad
    happened (e.g. return code 127 for command not found), the
    overall result will be FAIL

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/pmtu.sh | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index fb53987..464e31e 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1652,7 +1652,19 @@ run_test() {
 	return $ret
 	)
 	ret=$?
-	[ $ret -ne 0 ] && exitcode=1
+	case $ret in
+		0)
+			all_skipped=false
+			[ $exitcode=$ksft_skip ] && exitcode=0
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
@@ -1786,6 +1798,7 @@ usage() {
 #
 exitcode=0
 desc=0
+all_skipped=true
 
 while getopts :ptv o
 do
-- 
2.7.4

