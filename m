Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F975988D8
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiHRQ0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344828AbiHRQZg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 12:25:36 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBAA20BDF
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 09:23:18 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w8so1051782ilj.5
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 09:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:from:to:cc;
        bh=0/wCJxjO+s3jAAwzMDqASEg4VhiuiYjiBbC5lGoereM=;
        b=b3Uus9U4Xd063qXLNUcR2fnBqdmdOcwULVXr8aOYwIMvS1aE/K8UD7SZ4x4KvhF7LX
         5QachpEpIdo9QfU/A8m9voK4bY+hJn2yqccCRxxadEoRmcoyH4S9pnTSNPeYPLuhrV04
         XA/VWByqM6ghyuO4coW/4hdL/5iyJx9+xYBdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:x-gm-message-state:from:to:cc;
        bh=0/wCJxjO+s3jAAwzMDqASEg4VhiuiYjiBbC5lGoereM=;
        b=5P1d4zJd+smk2Uvu3S8eCJK9bwAxF0Ss8nnIh114nSfv9S4eWQX65r6pECJlTw6svR
         Ps1UZmkfhqhAbIptVrMB8k0iSONUEAT2vvGSBaAqeliN5OgokkCa1cXlZHz8GbApE2RR
         DZ3uzLuHr9ILTFy8p2xOLYYTP3+be7XWZKO/hhkWnCI6y4eOjeEBQZRv3zbADm2B5Plj
         f1JvnTpea3CDqQL7qGHaETnpzXYuMR/FP6CYoQoSS7aHSB1+IvUDrykFnFjnr0OQT2bY
         9FkEltu577jNuF4DmMMR/QZg6qUfdTpmFrxSxOMS2PgrOU275MFkW4aEkkQjOOeG6dLI
         nzaQ==
X-Gm-Message-State: ACgBeo32xIm6+LPoRxm9mbOqsk9OsjZKNEXdixW3MbGOvIQvcwZ2bg0q
        ziY4DWZfo5Jwv1MRrzUdH+Nu6nVHXM+xaA==
X-Google-Smtp-Source: AA6agR70JdNFrNuIkACZJCUICmnzzxOm9YQTbOJqwbGPzKAcZRKWTg/qsPleIyFpHHtrVZDeGsUqcQ==
X-Received: by 2002:a05:6e02:1685:b0:2df:2dd5:80f3 with SMTP id f5-20020a056e02168500b002df2dd580f3mr1773113ila.17.1660839793303;
        Thu, 18 Aug 2022 09:23:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c4-20020a056e020cc400b002df56aceb87sm790804ilj.60.2022.08.18.09.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 09:23:12 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 6.0-rc2
Message-ID: <a764f978-b13d-ec73-5538-6aa3cb1d13b4@linuxfoundation.org>
Date:   Thu, 18 Aug 2022 10:23:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------411F1CA07AFD0104A9379105"
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------411F1CA07AFD0104A9379105
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 6.0-rc2.

This Kselftest fixes update for Linux 6.0-rc2 consists of a single
patch to fix landlock test build regression.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-6.0-rc2

for you to fetch changes up to f1227dc7d0411ee9a9faaa1e80cfd9d6e5d6d63e:

   selftests/landlock: fix broken include of linux/landlock.h (2022-08-15 11:26:12 -0600)

----------------------------------------------------------------
linux-kselftest-next-6.0-rc2

This Kselftest fixes update for Linux 6.0-rc2 consists of a single
patch to fix landlock test build regression.

----------------------------------------------------------------
Guillaume Tucker (1):
       selftests/landlock: fix broken include of linux/landlock.h

  tools/testing/selftests/landlock/Makefile | 7 +++++--
  1 file changed, 5 insertions(+), 2 deletions(-)
----------------------------------------------------------------

--------------411F1CA07AFD0104A9379105
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-6.0-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-6.0-rc2.diff"

diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
index a6959df28eb0..02868ac3bc71 100644
--- a/tools/testing/selftests/landlock/Makefile
+++ b/tools/testing/selftests/landlock/Makefile
@@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
 TEST_GEN_PROGS_EXTENDED := true
 
 OVERRIDE_TARGETS := 1
+top_srcdir := ../../../..
 include ../lib.mk
 
+khdr_dir = $(top_srcdir)/usr/include
+
 $(OUTPUT)/true: true.c
 	$(LINK.c) $< $(LDLIBS) -o $@ -static
 
-$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
-	$(LINK.c) $< $(LDLIBS) -o $@ -lcap
+$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
+	$(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)

--------------411F1CA07AFD0104A9379105--
