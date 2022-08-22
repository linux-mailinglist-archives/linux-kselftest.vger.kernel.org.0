Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0659CB1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 23:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbiHVVvU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 17:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiHVVvT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 17:51:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D952097
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 14:51:18 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id y17so2385736ilp.10
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:from:to:cc;
        bh=r7t9Oi0FWdEfU1/Gx1SJk3VkZlxWdHjkakFrtVUOi7s=;
        b=agu3gY8q8YWsKytAVqdigAB1K8zGLrb8hcHOudJ67sSIZy1vUpxCs8RJ2wmrcrjSpD
         YQkBMpTta7mX0lLZlMOVwJPc2NcyUX6quCmOY47mo+S/MdpSKN9Kj4EBbXwXO8wzMDaZ
         /qt7Ycv9JK9xddFlfvEhzwx/Eu9xz8EBsJnpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:x-gm-message-state:from:to:cc;
        bh=r7t9Oi0FWdEfU1/Gx1SJk3VkZlxWdHjkakFrtVUOi7s=;
        b=3BFahIAkmRX0+QlsLKpjREaIZiQ/O5cQhaPeE+2eKXyrzzz7yXxLjWO9cqbP2FXYZU
         6Kbbmh6VUMI0zi5Dwi0jzUtYhogJ3IxecAo3Nb1wUeJleKW41cYwfoFkhFfyYKEErwLX
         n4ej54Ul8Wq5aAy+3cOWnQe89/b+ulRZ9v1lXI4l20Ek+qqVUEumvOFKrLijMa11b2Y6
         mjJH6MuupV5A6XtJoC+7RW+TYqjJA8mydeILZPX0O9NHYZKVZdqVR6pjZtDHYvH6IDXc
         DPViwBpZA6tp9/ggYJBuB9O37nnbi1d2oQl3njT5dNpMtI0IX3nNYLDWEto5d8Ksttyy
         lAjQ==
X-Gm-Message-State: ACgBeo1Y4DUTAprEhqUrP3foZTWtXKjxpXVxGwXbdWxKQ++yv91jxA5H
        iUhwr/Bj+xx6XXSSziOdkaPd5rpaeTUnxA==
X-Google-Smtp-Source: AA6agR7HIZD7blMcGKGpRmmDGNb8NqdGLuyqB+yRwqzun7FNylmlIFlj+OasNJF/mrs0ivkEqHUjNg==
X-Received: by 2002:a05:6e02:12c2:b0:2de:d6b5:3d9c with SMTP id i2-20020a056e0212c200b002ded6b53d9cmr11137348ilm.165.1661205077480;
        Mon, 22 Aug 2022 14:51:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j131-20020a026389000000b00342b327d709sm5585987jac.71.2022.08.22.14.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 14:51:16 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 6.0-rc3
Message-ID: <2ccb5e70-2130-827a-5f05-c0264f1e3cf8@linuxfoundation.org>
Date:   Mon, 22 Aug 2022 15:51:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------768DA08281CF6AD3F86621CC"
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------768DA08281CF6AD3F86621CC
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 6.0-rc3.

This Kselftest fixes update for Linux 6.0-rc3 consists of fixes
and warnings to vm and sgx test builds.

sgx test fails to build without this change on new distros.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.0-rc3

for you to fetch changes up to bdbf0617bbc3641af158d1aeffeebb1505f76263:

   selftests/vm: fix inability to build any vm tests (2022-08-19 17:57:20 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.0-rc3

This Kselftest fixes update for Linux 6.0-rc3 consists of fixes
and warnings to vm and sgx test builds.

----------------------------------------------------------------
Axel Rasmussen (1):
       selftests/vm: fix inability to build any vm tests

Kristen Carlson Accardi (1):
       selftests/sgx: Ignore OpenSSL 3.0 deprecated functions warning

  tools/testing/selftests/lib.mk          | 1 +
  tools/testing/selftests/sgx/sigstruct.c | 6 ++++++
  2 files changed, 7 insertions(+)
----------------------------------------------------------------

--------------768DA08281CF6AD3F86621CC
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.0-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-6.0-rc3.diff"

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 947fc72413e9..d44c72b3abe3 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -40,6 +40,7 @@ ifeq (0,$(MAKELEVEL))
     endif
 endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
+top_srcdir = $(selfdir)/../../..
 
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 50c5ab1aa6fa..a07896a46364 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -17,6 +17,12 @@
 #include "defines.h"
 #include "main.h"
 
+/*
+ * FIXME: OpenSSL 3.0 has deprecated some functions. For now just ignore
+ * the warnings.
+ */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 struct q1q2_ctx {
 	BN_CTX *bn_ctx;
 	BIGNUM *m;

--------------768DA08281CF6AD3F86621CC--
