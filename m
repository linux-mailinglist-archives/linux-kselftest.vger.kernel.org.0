Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF3C341C86
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2019 08:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFLGsE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jun 2019 02:48:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39926 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbfFLGsE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jun 2019 02:48:04 -0400
Received: from mail-pl1-f199.google.com ([209.85.214.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1hax3C-0000VY-3g
        for linux-kselftest@vger.kernel.org; Wed, 12 Jun 2019 06:48:02 +0000
Received: by mail-pl1-f199.google.com with SMTP id d19so9274324pls.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Jun 2019 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iQGtsCBn1c5Cv/4lGqwB4bSu8wIK/ZdJUuePfHlu3Os=;
        b=WI7Z3C0569LK8AIKrdo3y8bqfG+oGBkgOOHHGJmL0i0TMoiwmjyUmQo4KIByzPSmP2
         TCZ29cY5ZurdzgPZPiVMnG8+pnvAYcr4mIzM4E5dGkt6jBEfnpjlhxjG0BPkh8xQ1Lgr
         wutvJQiOr8py+9ZZzqaMObMMUhfmRbmPH2qomSqTf7Y5GkKrSXlfVGeuXwhWrxymKz2h
         fCjkh3NpQ+MwgMjlp6XzmZwpTSJaXCY75OfiHMdTBLEE6SJjfy/2kczPorKMNkSWueXS
         uIPU+RrnGYhVnvrmysNSIxNAxTA7/8YEYsxFajSZXwHuNxKNL2rSwsHlrP6WU3uHacLc
         fokw==
X-Gm-Message-State: APjAAAXfuIom34IituETEtlihy7GcYEqYCKdwRXTXV8YgJkgv7PS8yVc
        0cfSriGSlgnJaAnbAbRjGmw2QHlMglEphKqXOWWhnvIIydiAMM5K+9rM8qtbN9NEKhNaNtLXfcK
        9PbvfCSkZDwtysbg5Pi502jmok8WiLMk9A34Zaa/v0TFK
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr34534389plb.269.1560322080596;
        Tue, 11 Jun 2019 23:48:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqydXTegqwqULkVpf/E0LtN7OvqKB1CDRD/xCDPTfnA0oYlo/soUUvOX7voWPt0GmlHRFF0Cpg==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr34534368plb.269.1560322080271;
        Tue, 11 Jun 2019 23:48:00 -0700 (PDT)
Received: from Leggiero.taipei.internal (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id p68sm9888878pfb.80.2019.06.11.23.47.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 23:47:59 -0700 (PDT)
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: skip psock_tpacket test if KALLSYMS was not enabled
Date:   Wed, 12 Jun 2019 14:47:52 +0800
Message-Id: <20190612064752.6701-1-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The psock_tpacket test will need to access /proc/kallsyms, this would
require the kernel config CONFIG_KALLSYMS to be enabled first.

Check the file existence to determine if we can run this test.

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/run_afpackettests | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/run_afpackettests b/tools/testing/selftests/net/run_afpackettests
index ea5938e..8b42e8b 100755
--- a/tools/testing/selftests/net/run_afpackettests
+++ b/tools/testing/selftests/net/run_afpackettests
@@ -21,12 +21,16 @@ fi
 echo "--------------------"
 echo "running psock_tpacket test"
 echo "--------------------"
-./in_netns.sh ./psock_tpacket
-if [ $? -ne 0 ]; then
-	echo "[FAIL]"
-	ret=1
+if [ -f /proc/kallsyms ]; then
+	./in_netns.sh ./psock_tpacket
+	if [ $? -ne 0 ]; then
+		echo "[FAIL]"
+		ret=1
+	else
+		echo "[PASS]"
+	fi
 else
-	echo "[PASS]"
+	echo "[SKIP] CONFIG_KALLSYMS not enabled"
 fi
 
 echo "--------------------"
-- 
2.7.4

