Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7B9193472
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 00:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCYXRM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 19:17:12 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45022 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCYXRM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 19:17:12 -0400
Received: by mail-il1-f196.google.com with SMTP id j69so3611564ila.11
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrUjt8nDVmnXm/gavjIg5JPRcKfLAZSvtSkkEAXua/k=;
        b=RjmhVQsRoIu+fugIXEphOWQXXwrbR0U7o8lWymDH+s3khbIY7/LRMZ3OThF3LwAhei
         xgCmL4z4GqTUpxho/VqGuDeNXpMKRGxOqt7/iC/LlY1tvimZ1oWmTfj91db8mb5fHNhC
         +5JBygqDvynJlE7L5rcaTMaLAflMzw/o4zAsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrUjt8nDVmnXm/gavjIg5JPRcKfLAZSvtSkkEAXua/k=;
        b=AZYAx9+4vJ44YToqDn8fepy4tvV3Uln76lf5PvAIeOgZjaygYRBKGwJupzznYKJTVD
         QeO3UIpf2ZQqIY665kbBF4l+umc9kyUGJrYiATuNQoLpq6zZynejULsDh/s6N931jV5S
         Sud7KYC2CjxAetakVUNEaqtZblJ4XYu4kpbDqvIDvJiIstOm0FB2iXH/7zkzT+ypmWOW
         4uo42xrWGSBmOHKaVxLq7lUGvS5Nyd8AWTb/m4xgMy4VeY8+LJGKBkYXaCXZTSVuSGvY
         RS+CiH61Z1+W4mZGEcqlnYUWn4Fd38RVteADrTQOfNOjDado+Q0wrWcYzOTxVdqQxsJP
         kr/w==
X-Gm-Message-State: ANhLgQ1ot80V3TolcWdc/kqmCJ7vgOgvrZXDegJMVHiRMzmkpUjbwyiS
        OpLfrn1fberaOmUvBXExi1JjLgit0u8=
X-Google-Smtp-Source: ADFU+vsV0uKQgaC+DPxZJsuvX3hDBs66N7APb5XhYFy3EkxbDbwMY/ueRcdGw4a/l8TKdfdP3HG7nw==
X-Received: by 2002:a92:8741:: with SMTP id d1mr6251924ilm.167.1585178231660;
        Wed, 25 Mar 2020 16:17:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm202636ild.70.2020.03.25.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:17:11 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix memfd to support relocatable build (O=objdir)
Date:   Wed, 25 Mar 2020 17:17:09 -0600
Message-Id: <20200325231709.13122-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix memfd to support relocatable build (O=objdir). This calls out
source files necessary to build tests and simplfies the dependency
enforcement.

Tested the following:

Note that cross-build for fuse_mnt has dependency on -lfuse.

make all
make clean
make kselftest-install O=/arm64_build/ ARCH=arm64 HOSTCC=gcc \
CROSS_COMPILE=aarch64-linux-gnu- TARGETS=memfd

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/memfd/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 53a848109f7b..0a15f9e23431 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,9 +4,8 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_GEN_PROGS := memfd_test
+TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
-TEST_GEN_FILES := fuse_mnt fuse_test
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
@@ -14,7 +13,7 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
 
-$(OUTPUT)/memfd_test: memfd_test.c common.o
-$(OUTPUT)/fuse_test: fuse_test.c common.o
+$(OUTPUT)/memfd_test: memfd_test.c common.c
+$(OUTPUT)/fuse_test: fuse_test.c common.c
 
-EXTRA_CLEAN = common.o
+EXTRA_CLEAN = $(OUTPUT)/common.o
-- 
2.20.1

