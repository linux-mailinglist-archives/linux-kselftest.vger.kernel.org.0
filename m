Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BECE17ACF4
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 18:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgCERXe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Mar 2020 12:23:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgCERNk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Mar 2020 12:13:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 827FA21556;
        Thu,  5 Mar 2020 17:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583428420;
        bh=IUgSQBIgrx3acAIdWwuai6U1vJC+ObOnP/PsZf5UV9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ng1lynTsrk+X6mYwsrXYvUfmseBAmhMUVgPBqrG6+EAVRZMMzfeNgN9RdjV/+tta5
         gXgcvMe7JXSXAyLNvB0NcyK5RwKxGGmQDwrXRE40f6pMqZflw2/M+kBCo9Tj/EoZSW
         OxrJ/Oz9T2Wv5X4lwBW5/oH6EYw4Y1ytl+71PLMM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 22/67] selftests/rseq: Fix out-of-tree compilation
Date:   Thu,  5 Mar 2020 12:12:23 -0500
Message-Id: <20200305171309.29118-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305171309.29118-1-sashal@kernel.org>
References: <20200305171309.29118-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit ef89d0545132d685f73da6f58b7e7fe002536f91 ]

Currently if you build with O=... the rseq tests don't build:

  $ make O=$PWD/output -C tools/testing/selftests/ TARGETS=rseq
  make: Entering directory '/linux/tools/testing/selftests'
  ...
  make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./  -shared -fPIC rseq.c -lpthread -o /linux/output/rseq/librseq.so
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./  basic_test.c -lpthread -lrseq -o /linux/output/rseq/basic_test
  /usr/bin/ld: cannot find -lrseq
  collect2: error: ld returned 1 exit status

This is because the library search path points to the source
directory, not the output.

We can fix it by changing the library search path to $(OUTPUT).

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rseq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d6469535630af..708c1b3452454 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,7 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
-CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 
-- 
2.20.1

