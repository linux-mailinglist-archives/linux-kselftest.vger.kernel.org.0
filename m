Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69FB3D11
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Sep 2019 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfIPPDm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Sep 2019 11:03:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50277 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387705AbfIPPDl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Sep 2019 11:03:41 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <marcelo.cerri@canonical.com>)
        id 1i9sXU-0003V1-T6
        for linux-kselftest@vger.kernel.org; Mon, 16 Sep 2019 15:03:40 +0000
Received: by mail-wr1-f69.google.com with SMTP id w10so33444wrl.5
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2019 08:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UpaiSLVZTJH//yVMd4hniWSWY+v8c4Nt+/1LTwDfd60=;
        b=KJKmdtwJ/IQ5AhJcuJkuqhzGEIctcG8i/0mu6kMZFOfLdngntbYwBdjVE8mc/2ZHcZ
         lBHfJ6wppSr4feDtU0pdnAwRH6XCZXx4k3+38raZzcZbF358hkgTFh9/z6CABKhzV/dr
         o2zMcwMNzSDvzC14KHJMvPsKc9WaEDf47NCLD4pBnEvjAV3J92LYr+v85I8b+2TG4CzF
         2nzEwiJz31Q7CXYuL0fIrLjnW1CfSUe0ZRJXHSHnjpZUAFTnZkaP9UTL5qm8MM2odX5F
         5I1tBJDFOTLcG1X1CA1Blw1qdKngRTUaoBznivdwGKuSHNzeACx0lMy1EthCSRgg0PVt
         iYeA==
X-Gm-Message-State: APjAAAXn+M1ZSFUy9htvh5Uee7/nOIi8awbqKE2PpHd9bHQNNCAMJcny
        K2EIhVQnO3yUeRFurcdnU91bn+9/zog2T3CgOn/fpBs8Hr7Izq9duPwRIruZjByNb4PkyKTAL1C
        OisOeOeIZgFq4HVMp6YrkKNVbTI6T8n9PkF+EIljlA0Bf
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr159040wrs.191.1568646220536;
        Mon, 16 Sep 2019 08:03:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwQBkINemvJ4SG/cnXsg6i1JejX1kLd5HO272cp1ciclatRAjNPd1icxSBzVQh00CQOmLtm2A==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr159015wrs.191.1568646220250;
        Mon, 16 Sep 2019 08:03:40 -0700 (PDT)
Received: from localhost.localdomain (static-dcd-cqq-121001.business.bouyguestelecom.com. [212.194.121.1])
        by smtp.gmail.com with ESMTPSA id w125sm121823wmg.32.2019.09.16.08.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:03:39 -0700 (PDT)
From:   Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/net: replace AF_MAX with INT_MAX in socket.c
Date:   Mon, 16 Sep 2019 12:03:37 -0300
Message-Id: <20190916150337.18049-1-marcelo.cerri@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use INT_MAX instead of AF_MAX, since libc might have a smaller value
of AF_MAX than the kernel, what causes the test to fail.

Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
---
 tools/testing/selftests/net/socket.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/socket.c b/tools/testing/selftests/net/socket.c
index afca1ead677f..10e75ba90124 100644
--- a/tools/testing/selftests/net/socket.c
+++ b/tools/testing/selftests/net/socket.c
@@ -6,6 +6,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
+#include <limits.h>
 
 struct socket_testcase {
 	int	domain;
@@ -24,7 +25,10 @@ struct socket_testcase {
 };
 
 static struct socket_testcase tests[] = {
-	{ AF_MAX,  0,           0,           -EAFNOSUPPORT,    0 },
+	/* libc might have a smaller value of AF_MAX than the kernel
+	 * actually supports, so use INT_MAX instead.
+	 */
+	{ INT_MAX, 0,           0,           -EAFNOSUPPORT,    0  },
 	{ AF_INET, SOCK_STREAM, IPPROTO_TCP, 0,                1  },
 	{ AF_INET, SOCK_DGRAM,  IPPROTO_TCP, -EPROTONOSUPPORT, 1  },
 	{ AF_INET, SOCK_DGRAM,  IPPROTO_UDP, 0,                1  },
-- 
2.20.1

