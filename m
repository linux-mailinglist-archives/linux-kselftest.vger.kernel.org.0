Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3601B3423
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Apr 2020 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDVAsv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Apr 2020 20:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726055AbgDVAsu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Apr 2020 20:48:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B118C0610D5
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Apr 2020 17:48:49 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 20so763541qkl.10
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Apr 2020 17:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63fb5nFeJN7PoJsX4tG8GdYMct2l/caN8RuSWQJuLEw=;
        b=KNhsmWT9X7NXWyY5qb/yjj1tgaB4Sc31PWWRCMn2oniNkKQO+l8nFnvWBfaZoB8LrW
         MdmRsF69wY3y2esQ1/pOy1OTG71Wa3LSfHHLpIoETLNZ5Ff06H0Zu3/8SJ4+aFm5yDaM
         InnJDDkCl8D/h1TdruetLvGvYX3Spyr9N3LVM40J4npyDDgpjQiN/lgbomNITF6ZsNsm
         uw9oIuZ8OKxunofr/JwEa8PnFT0VGMIofbo7dlMLMG3KuA0Ohe+Ke1zjLh7I66hRmOoF
         EQyPst2FljABILEn0ty9aYHmzBfeyWeX2XI8biSmgAZs2HeQ1Pi8Kg67NNjKB7m3Fk0D
         TZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=63fb5nFeJN7PoJsX4tG8GdYMct2l/caN8RuSWQJuLEw=;
        b=qvPvDg8rUlQ8a5WaNDRmrksF/lZBzetrIqPeOvWivxraKe4JvBtLPbw8LZgzwyqrbG
         WDNBtIcB9sFmtEkz5OVOo0EbBFEE1Y6tHKiuC/XfopmzL21xcINbh0KSBh12Vk2LZQdI
         UgaSpYUO25F7hLM8zpj1SNIetuUEHwWpvq0bF8fvGndvKU9wJqwc/Fuq+heP0UdLQ7lL
         3NGn/HYAtLmc5vLDgUlUNfRw70wNzjxoLT4q0JpMmansmVTX/uXJHiDKRihKk6AKhyUi
         rJ+8rr5lZvcIqWC9h4uc8nR1nxYZfesa1cb31st/8lTRS156oNdRNRHqBgHPkMRdII5O
         Ejpg==
X-Gm-Message-State: AGi0PualahTVdG+TWNksrRmaQ4Fjfq8rWV0pGqIKVJiQX5Uxj9NxQOVL
        P7puNAKpCDVP9cyfWOQNTTrw0g==
X-Google-Smtp-Source: APiQypKnVlQo7Y1vutvcGSf2A5oq23tHZdydqy9HFBp8gsiIfPRT3HdwngbfzECoA6y6lCBu7COf+w==
X-Received: by 2002:ae9:f30f:: with SMTP id p15mr23756693qkg.178.1587516528359;
        Tue, 21 Apr 2020 17:48:48 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id 60sm2867135qtb.95.2020.04.21.17.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 17:48:47 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     masahiroy@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3] um: ensure `make ARCH=um mrproper` removes arch/$(SUBARCH)/include/generated/
Date:   Tue, 21 Apr 2020 21:48:44 -0300
Message-Id: <20200422004844.53284-1-vitor@massaru.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In this workflow:

$ make ARCH=um defconfig && make ARCH=um -j8
  [snip]
$ make ARCH=um mrproper
  [snip]
$ make ARCH=um defconfig O=./build_um && make ARCH=um -j8 O=./build_um
  [snip]
  CC      scripts/mod/empty.o
In file included from ../include/linux/types.h:6,
                 from ../include/linux/mod_devicetable.h:12,
                 from ../scripts/mod/devicetable-offsets.c:3:
../include/uapi/linux/types.h:5:10: fatal error: asm/types.h: No such file or directory
    5 | #include <asm/types.h>
      |          ^~~~~~~~~~~~~
compilation terminated.
make[2]: *** [../scripts/Makefile.build:100: scripts/mod/devicetable-offsets.s] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/iha/sdb/opensource/lkmp/linux-kselftest.git/Makefile:1140: prepare0] Error 2
make[1]: Leaving directory '/home/iha/sdb/opensource/lkmp/linux-kselftest.git/build_um'
make: *** [Makefile:180: sub-make] Error 2

The cause of the error was because arch/$(SUBARCH)/include/generated files
weren't properly cleaned by `make ARCH=um mrproper`.

Fixes: a788b2ed81ab ("kbuild: check arch/$(SRCARCH)/include/generated
before out-of-tree build").
Reported-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Link: https://groups.google.com/forum/#!msg/kunit-dev/QmA27YEgEgI/hvS1kiz2CwAJ
---
v2:
 * Explains what this PATCH does and the importance as suggested
   by Brendan Higgins.
v3:
 * This problem only affects ARCH=um builds then arch/um/Makefile has
   been changed as suggested by Masahiro Yamada;
 * And with that the description has also been changed, and also to explain
   missing points and correct the tags as suggested by Masahiro Yamada:
   - Fix missing command `make ARCH=um mrproper`;
   - Add build error message; 
   - Add "Fixes" tag instead of "This bug was ...";
   - Add "Link" tag instead of "Related bug ...";
   - Add Reported-by and Suggested-by;
---
 arch/um/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index d2daa206872d..275f5ffdf6f0 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -140,6 +140,7 @@ export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
 # When cleaning we don't include .config, so we don't include
 # TT or skas makefiles and don't clean skas_ptregs.h.
 CLEAN_FILES += linux x.i gmon.out
+MRPROPER_DIRS += arch/$(SUBARCH)/include/generated
 
 archclean:
 	@find . \( -name '*.bb' -o -name '*.bbg' -o -name '*.da' \
-- 
2.25.1

