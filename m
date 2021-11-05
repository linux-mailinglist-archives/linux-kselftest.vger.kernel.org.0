Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA944673D
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 17:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhKEQsF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbhKEQsB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 12:48:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AC7C061205
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 09:45:21 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id d12so16369519lfv.6
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgo3jVJmdTH5GxUz+5stwlmrOeYD79EfO01ThQfyjbQ=;
        b=Np1j9Uy0lGaSSTvDEzHqS2+yEZcf0ojz8egqSf66QCCCqHsOnZAexmX7yu+3L6iDXu
         060T/Ak0MJgayTUGaF5KsLjXVPir4Dn8b61gY+eHuQNJqnLLD6vQtJwQdMStoMJY/Ycm
         fSdP6w/3sUbhj7AlCG6dvw+ZFKYAm6pbzsZpYr/7PgAxWgdf+pqch6Hra/LBNRMDvVNo
         qkKTEltpflbo23In6QS2b53SJoqmpyS+TZryh3EY+vKvi8XKixQdcAOuh2PhtbDDPqfA
         qIc6+RevvSkXnHJREbGBcjxuCGGzQ6oFyPLhC2ut5mSw60mTYq4bLv8IJtZodz8BexgZ
         MZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vgo3jVJmdTH5GxUz+5stwlmrOeYD79EfO01ThQfyjbQ=;
        b=jQa26f7VV0hw+SDgiJ1P11m2bDAGrsJq8aZraT/cy20K2WR6yNtr8scUGGy3OmkeWz
         UgVD7UN4sHl4PMGAF/yJDPqIAq8SET5zu7c0wuGX3UcT0rksIUbfrEUkd3L6cdK/YDOc
         JOcY7OQBBZRTMFsR5pLwhcKtmS0ZSLZ/I0/qGoGoPciCHDBq+dpmJj9k6tXmonj3+DEx
         9sDPT2Rbx6d5kVMKetOSZE7ni37eggfTO01M4M+4sB2pVWKt4fe+Q4bddDRiS5xWCvr3
         Yji/97ClHSfvO/VYJ+1LozrOmFtynaGOtf+VETotmx1ixVAoADHOVn4TUKYsRwdDy1Z8
         Hs8Q==
X-Gm-Message-State: AOAM532BaHjAZ4FyU3PtoP5aW2sBb4SvVHNPgdkrYrrfStorrmHK5vm5
        vg/LTNMAKrvUJ37MZnT3bqW1yg==
X-Google-Smtp-Source: ABdhPJwG3G6cMAbQABxpQQEIsXi2suMLY513mTVfNIqk4LQDS9bdbO9qWIH1j5JI0FEk57La/1jifQ==
X-Received: by 2002:ac2:4c53:: with SMTP id o19mr55052413lfk.303.1636130719932;
        Fri, 05 Nov 2021 09:45:19 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id l15sm725734lfg.239.2021.11.05.09.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:45:19 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: net: tls: remove unused variable and code
Date:   Fri,  5 Nov 2021 17:45:11 +0100
Message-Id: <20211105164511.3360473-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/net with clang, the compiler warn about the
function abs() see below:

tls.c:657:15: warning: variable 'len_compared' set but not used [-Wunused-but-set-variable]
        unsigned int len_compared = 0;
                     ^

Rework to remove the unused variable and the for-loop where the variable
'len_compared' was assinged.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/net/tls.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index d3047e251fe9..e61fc4c32ba2 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -654,7 +654,6 @@ TEST_F(tls, recvmsg_single_max)
 TEST_F(tls, recvmsg_multiple)
 {
 	unsigned int msg_iovlen = 1024;
-	unsigned int len_compared = 0;
 	struct iovec vec[1024];
 	char *iov_base[1024];
 	unsigned int iov_len = 16;
@@ -675,8 +674,6 @@ TEST_F(tls, recvmsg_multiple)
 	hdr.msg_iovlen = msg_iovlen;
 	hdr.msg_iov = vec;
 	EXPECT_NE(recvmsg(self->cfd, &hdr, 0), -1);
-	for (i = 0; i < msg_iovlen; i++)
-		len_compared += iov_len;
 
 	for (i = 0; i < msg_iovlen; i++)
 		free(iov_base[i]);
-- 
2.33.0

