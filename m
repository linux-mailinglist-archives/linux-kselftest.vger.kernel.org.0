Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225458E024
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Aug 2019 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfHNVtz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Aug 2019 17:49:55 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46745 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbfHNVtz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Aug 2019 17:49:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id n19so311346lfe.13
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Aug 2019 14:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=quNqjepPTnacbRHb7c2eVenKYgne2iNuWND1D+zRC8U=;
        b=sUjGo9yXU26Huey71Nv31NVxbfEQLci9On0kv2+ROoSDiFng0MELV4XmPa++4r0itW
         S5eWusmIAQMYTWT+1aGb4zEKFcnCYhWdDl+pGNDkM1RSxyeMjCdvmcu3q2o/2pUdi6UF
         DYPar1pHFv5KdFyV+Bu9Y501HsDE6mDRsdR39XWmJJhDySt3K/BsWTkoKw3Xh7QQYFj/
         O6req7zP9ZrhPa3rgIPBNu/n5wLAByRkzhzjvucDhDsLct1uEYj0qsmdcKIcxsqpsH6C
         ujz1gIvbPaMPB4Prv16krM7VDSlAFA4YPLD8H7yInX2sgJNZFZ4ySRsnEAfODauihknM
         tNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=quNqjepPTnacbRHb7c2eVenKYgne2iNuWND1D+zRC8U=;
        b=VPSAFhtjLgDg3LjEMczqXAFKBNSJKf81CoxK+YpCkPQj8EI3ZPLE9DQhKESqD1dyKT
         pzDvR5jSbeeIlVd7dkB654SSmJ71Ov2cMF4DUcAA3ijr6NgWFPX2+E5dQJxCbygXBGb2
         NRvHOM4YCldOOSUwtEy2Wz9F77yasEKd2dCrmasyBjUV0LEMXy29Z+QZI7ewGZSRafq3
         jCyTv7y91ZCFDcIGMDVbvRh230X1HC+EJgNcGffwnTE5wltbze7Z4f67Q5PmyGTxBi0y
         IJI01GjqC0EsHiu7tY19MLKCjYWd4UrEKSH5MwaH47Wg1vF4dlpgNQSKvrsFzslbYTeD
         NjAg==
X-Gm-Message-State: APjAAAWOUHVBB37t3h1afbarqDLzvvzy1rBkAONl2yACSBUx56+iSQlC
        kmDPbYenWUYYRSIJSbiZ7Syo7A==
X-Google-Smtp-Source: APXvYqx5hCgL1mgFSNzMB6K9DMlwFxrQNrI/rXad6WZ66DwVgNjvwjQt1QrWhgbNk0bmmtTuTQ7enQ==
X-Received: by 2002:ac2:484e:: with SMTP id 14mr783405lfy.50.1565819393263;
        Wed, 14 Aug 2019 14:49:53 -0700 (PDT)
Received: from localhost (c-243c70d5.07-21-73746f28.bbcust.telenor.se. [213.112.60.36])
        by smtp.gmail.com with ESMTPSA id z30sm132722lfj.63.2019.08.14.14.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:49:52 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: tcp_fastopen_backup_key.sh: fix shellcheck issue
Date:   Wed, 14 Aug 2019 23:49:48 +0200
Message-Id: <20190814214948.5571-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running tcp_fastopen_backup_key.sh the following issue was seen in
a busybox environment.
./tcp_fastopen_backup_key.sh: line 33: [: -ne: unary operator expected

Shellcheck showed the following issue.
$ shellcheck tools/testing/selftests/net/tcp_fastopen_backup_key.sh

In tools/testing/selftests/net/tcp_fastopen_backup_key.sh line 33:
        if [ $val -ne 0 ]; then
             ^-- SC2086: Double quote to prevent globbing and word splitting.

Rework to add double quotes around the variable 'val' that shellcheck
recommends.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/tcp_fastopen_backup_key.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_fastopen_backup_key.sh b/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
index 41476399e184..ba5ec3eb314e 100755
--- a/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
+++ b/tools/testing/selftests/net/tcp_fastopen_backup_key.sh
@@ -30,7 +30,7 @@ do_test() {
 	ip netns exec "${NETNS}" ./tcp_fastopen_backup_key "$1"
 	val=$(ip netns exec "${NETNS}" nstat -az | \
 		grep TcpExtTCPFastOpenPassiveFail | awk '{print $2}')
-	if [ $val -ne 0 ]; then
+	if [ "$val" -ne 0 ]; then
 		echo "FAIL: TcpExtTCPFastOpenPassiveFail non-zero"
 		return 1
 	fi
-- 
2.20.1

