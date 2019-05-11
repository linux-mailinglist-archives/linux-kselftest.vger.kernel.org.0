Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6138C1A65C
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2019 04:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfEKCwx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 22:52:53 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53451 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbfEKCwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 22:52:53 -0400
Received: by mail-it1-f196.google.com with SMTP id m141so11050931ita.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 May 2019 19:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1fNpqco5qTI/FVw/2N/OV6sdYiNRuMpuFae27tLYD8=;
        b=AsJhlTTxTVsHXRcV+TdHM1dqT6CDreRY5gyOr73MCbYVqnHrm9AQ3YBi3KpSl2YaBY
         AQA/RoOwihRXjLnMWyMT1lTIFCUMtWd/THzwzQ11ODv0V+hImkpFqMzlTyUA5vg4U8Lh
         iC7LdrFa9pBC97kV1H8nDMWfrZxoKKClWlX2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1fNpqco5qTI/FVw/2N/OV6sdYiNRuMpuFae27tLYD8=;
        b=dz3VSzD8JEACXnGkSdLAMqPfYSZ5c6utENoQJG1JBqx/TGiRhn0cpJATyuZbHpTs9f
         IFjWQA8HX31T6hsC/3RBYPGC+qc1qgdB7k/ruWf5EuUBX2S5px2WiUaB5D+h4MuDKT1T
         xy9CW+UbEbumQpNWhrDVz7dSm+l5Tw21PLoYns6IFMajuVYI5ViShp9grfEOcfbSeQwn
         9nNAYVeGKqZI+tZ+2sRrhrRYlTXSprWTFzKfllBIFu6m0b75eiIQFBF1UZCJJQlXZHVm
         e3nvX1a7qhUgtNvcu6YS+7PBRg+BvDp/iRDxioBLdciU6iYSWbpiJSNLaXM0DksfgcIL
         aNcw==
X-Gm-Message-State: APjAAAVKydqavRJlSNCSkf+8aRpDU0bSF9JbYxNprHs8b7H/l1I59h9O
        PpHvt4mQEN8NdB6j1ztboqfbBw==
X-Google-Smtp-Source: APXvYqyMyX9jt4xcnd1qUvb3Gz1jooVogYkic/p578UGF9RMWCcUnZVoGP84Uj7fcMIrKG/QoqQHKg==
X-Received: by 2002:a24:5258:: with SMTP id d85mr10156123itb.124.1557543172404;
        Fri, 10 May 2019 19:52:52 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm2962460ios.30.2019.05.10.19.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 19:52:51 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, alexei.starovoitov@gmail.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>, daniel@iogearbox.net,
        davem@davemloft.net, torvalds@linux-foundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH] selftests: fix bpf build/test workflow regression when KBUILD_OUTPUT is set
Date:   Fri, 10 May 2019 20:52:49 -0600
Message-Id: <20190511025249.32678-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")
broke bpf build/test workflow. When KBUILD_OUTPUT is set, bpf objects end
up in KBUILD_OUTPUT build directory instead of in ../selftests/bpf.

The following bpf workflow breaks when it can't find the test_verifier:

cd tools/testing/selftests/bpf; make; ./test_verifier;

Fix it to set OUTPUT only when it is undefined in lib.mk. It didn't need
to be set in the first place.

Fixes: commit 8ce72dc32578 ("selftests: fix headers_install circular dependency")

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/lib.mk | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 098dd0065fb1..077337195783 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -3,15 +3,9 @@
 CC := $(CROSS_COMPILE)gcc
 
 ifeq (0,$(MAKELEVEL))
-    ifneq ($(O),)
-	OUTPUT := $(O)
-    else
-	ifneq ($(KBUILD_OUTPUT),)
-		OUTPUT := $(KBUILD_OUTPUT)
-	else
-		OUTPUT := $(shell pwd)
-		DEFAULT_INSTALL_HDR_PATH := 1
-	endif
+    ifeq ($(OUTPUT),)
+	OUTPUT := $(shell pwd)
+	DEFAULT_INSTALL_HDR_PATH := 1
     endif
 endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
-- 
2.17.1

