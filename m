Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45513D6CFA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 03:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfJOBpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Oct 2019 21:45:09 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37765 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfJOBpI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Oct 2019 21:45:08 -0400
Received: by mail-io1-f66.google.com with SMTP id b19so42321752iob.4
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Oct 2019 18:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACbmiCYl1yVzW4bsJf2DTWEll5BNUiB3x+RCIAqbI2k=;
        b=B/InPDWweJaDl3CRrbzGkfGi/hdoMZPNiDIO6rLtffTrpYjG8EeSUb02dH+bdcxu2I
         anWL0/ff0D/uJ5yG7pCpu5+TiftEGQzHM14PmSZMSGHMfUSJwej0Mh38Neob10oWLJg/
         UUnndznfpgJw6o5s+/+DDiISKHbXeFzP+UTfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ACbmiCYl1yVzW4bsJf2DTWEll5BNUiB3x+RCIAqbI2k=;
        b=URL37PiKmxOqyUp89BzoA4cH2JqucODP3Wt0Aej/3jMsMs+g0DHjqnKWxR7cJLcxF/
         69mI0d/C9dT0qdDr4C8dIO5ICuF2rq2zszvJw7bZbhVzDgkTPKPrf71xQOuioFAezvQd
         EHLTJ9E9GgahOG/J93QsahmgHHYmSPCFIZ8iQrqmNZQ18IAICkEnSTtjptqIvDzUFrHV
         HE7BoWyuB/SeFOKSPpwihmHNdr/gVInCXuR73uq1iUaFfYpoTZN+Bz1B/PR1RLS0uLgj
         sMMn1KRlYC30dER0R2sRnd4r8/6dTNer21rYT77dLNas9Jm65TtmlYPrMLKK+8AZT6FS
         140A==
X-Gm-Message-State: APjAAAXgnRqxJileN0Yxt2JN8mVLWC3sX0c3jCmYMULIiopLsoeUX2Nz
        YZcZYLGR+UfF62NIEu/6+YeUww==
X-Google-Smtp-Source: APXvYqxoSvmS9iWN6kz0F/95cyO2GEurBj1hgNbVDCZa3i5PpREYM09NLtzvw6i2AGGLT8UHtm0otg==
X-Received: by 2002:a92:cb84:: with SMTP id z4mr3868224ilo.78.1571103907831;
        Mon, 14 Oct 2019 18:45:07 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q17sm1888383ile.5.2019.10.14.18.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 18:45:06 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Bird <Tim.Bird@sony.com>
Subject: [PATCH] selftests: Fix O= and KBUILD_OUTPUT handling for relative paths
Date:   Mon, 14 Oct 2019 19:45:05 -0600
Message-Id: <20191015014505.14259-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix O= and KBUILD_OUTPUT handling for relative paths.

export KBUILD_OUTPUT=../kselftest_size
make TARGETS=size kselftest-all

or

make O=../kselftest_size TARGETS=size kselftest-all

In both of these cases, targets get built in ../kselftest_size which is
a one level up from the size test directory.

make[1]: Entering directory '/mnt/data/lkml/kselftest_size'
make --no-builtin-rules INSTALL_HDR_PATH=$BUILD/usr \
        ARCH=x86 -C ../../.. headers_install
  INSTALL ../kselftest_size/usr/include
gcc -static -ffreestanding -nostartfiles -s    get_size.c  -o ../kselftest_size/size/get_size
/usr/bin/ld: cannot open output file ../kselftest_size/size/get_size: No such file or directory
collect2: error: ld returned 1 exit status
make[3]: *** [../lib.mk:138: ../kselftest_size/size/get_size] Error 1
make[2]: *** [Makefile:143: all] Error 2
make[1]: *** [/mnt/data/lkml/linux_5.4/Makefile:1221: kselftest-all] Error 2
make[1]: Leaving directory '/mnt/data/lkml/kselftest_size'
make: *** [Makefile:179: sub-make] Error 2

Use abs_objtree exported by the main Makefile.

Reported-by: Tim Bird <Tim.Bird@sony.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 4cdbae6f4e61..3405aa26a655 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,10 +86,10 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(O)
+	BUILD := $(abs_objtree)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(KBUILD_OUTPUT)/kselftest
+		BUILD := $(abs_objtree)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
@@ -102,6 +102,7 @@ include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
+#$(info abd_objtree = $(abs_objtree) BUILD = $(BUILD))
 
 # build and run gpio when output directory is the src dir.
 # gpio has dependency on tools/gpio and builds tools/gpio
-- 
2.20.1

