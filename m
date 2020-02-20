Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9F5165CDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 12:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgBTLh6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Feb 2020 06:37:58 -0500
Received: from ozlabs.org ([203.11.71.1]:40943 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgBTLh6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Feb 2020 06:37:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48NXdb56Bbz9sRN; Thu, 20 Feb 2020 22:37:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582198675;
        bh=0PSWQnV4dwtbFWEhb/W8Y1bno6l3vVQsEFwu7tdFrEU=;
        h=From:To:Cc:Subject:Date:From;
        b=eD/dz/6oFavYPAFlm4RSrV0jozd5zuxmigkXpeXi7lsb/bfHkMH+MSNpwBSDjqVXt
         7rvmLoUquCNkrqXPlRV+X7yJTpGB5FC58WBnFcAWQ6lMY42PEUBAXmKx9N0ufOIUqu
         FDxom2OxM99owVe0UtHlp/EYUjT1w4D1Kh19RTLJvS7QMGvNzbkL8jTX+aQo+Em4c8
         RDiYr8/Ds3zrVkYPHAR/0IkzBnO+QdN0GqoDEBKC29mznQrB1ltOFI4qH1QEakKOgV
         z0jdw5BOJDJnlOji+t9dJk8d1j6M9aHa7i+Q2+DXCFFIOxyaiXemC6FwYKpfBdgALm
         bHH2f+dy8Rm2g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linux-kselftest@vger.kernel.org
Cc:     skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@kernel.org, boqun.feng@gmail.com
Subject: [PATCH] selftests/rseq: Fix out-of-tree compilation
Date:   Thu, 20 Feb 2020 22:37:48 +1100
Message-Id: <20200220113748.15990-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
---

This works in all cases.

With O= set:

  $ make O=$PWD/output -C tools/testing/selftests/ TARGETS=rseq
  ...
  make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq -Wl,-rpath=./  basic_test.c -lpthread -lrseq -o /linux/output/rseq/basic_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq -Wl,-rpath=./  basic_percpu_ops_test.c -lpthread -lrseq -o /linux/output/rseq/basic_percpu_ops_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq -Wl,-rpath=./  param_test.c -lpthread -lrseq -o /linux/output/rseq/param_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq -Wl,-rpath=./  -DBENCHMARK param_test.c -lpthread -lrseq -o /linux/output/rseq/param_test_benchmark
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/output/rseq -Wl,-rpath=./  -DRSEQ_COMPARE_TWICE param_test.c -lpthread -lrseq -o /linux/output/rseq/param_test_compare_twice
  make[1]: Leaving directory '/linux/tools/testing/selftests/rseq'
  make: Leaving directory '/linux/tools/testing/selftests'

And also without, in which case the selftest makefiles set OUTPUT to
the full path of the source directory:

  $ make -C tools/testing/selftests/ TARGETS=rseq
  ...
  make[1]: Entering directory '/linux/tools/testing/selftests/rseq'
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -shared -fPIC rseq.c -lpthread -o /linux/tools/testing/selftests/rseq/librseq.so
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/basic_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_percpu_ops_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/basic_percpu_ops_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  param_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DBENCHMARK param_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test_benchmark
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DRSEQ_COMPARE_TWICE param_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test_compare_twice
  make[1]: Leaving directory '/linux/tools/testing/selftests/rseq'
  make: Leaving directory '/linux/tools/testing/selftests'

And finally, it also works if you build directly in the rseq
directory, eg:

  $ cd tools/testing/selftests/rseq
  $ make
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -shared -fPIC rseq.c -lpthread -o /linux/tools/testing/selftests/rseq/librseq.so
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/basic_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  basic_percpu_ops_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/basic_percpu_ops_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  param_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DBENCHMARK param_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test_benchmark
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L/linux/tools/testing/selftests/rseq -Wl,-rpath=./  -DRSEQ_COMPARE_TWICE param_test.c -lpthread -lrseq -o /linux/tools/testing/selftests/rseq/param_test_compare_twice
---
 tools/testing/selftests/rseq/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d6469535630a..708c1b345245 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -4,7 +4,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 CLANG_FLAGS += -no-integrated-as
 endif
 
-CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ \
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
 LDLIBS += -lpthread
 

base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
-- 
2.21.1

