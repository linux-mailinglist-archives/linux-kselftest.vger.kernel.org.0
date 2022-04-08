Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6974F9D5D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiDHS6G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiDHS6E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 14:58:04 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B201E7A74
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 11:56:00 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e13so7070080ils.8
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 11:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=MtJXp4ifWK+ROOILZQ4cWtnaJgVJwVY9PT7bb9unDw8=;
        b=Y66OvL6qaiH5FrXOVeKqKjxG/ToD4rFZCGY/x6xYGqneFSiJzIIpNUCPsal26yDIFO
         Ct3F+no+VMujDfkGDUs/dhO7npqPP6aDt6wrwhBRECM9OBRyjtxUbSkcAsqfiKyuSiLP
         9ElZogAfwJybCN9v7/eNkRYHtXDWfMXbpe29A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=MtJXp4ifWK+ROOILZQ4cWtnaJgVJwVY9PT7bb9unDw8=;
        b=qy7rRRwAU64v+NJQWy1rtHGMW5W1ffoWaibcpSybsOfpuynvQeF8tvd1JANPCxj6zu
         YohYXRljDSqT2PuWbtrv/H/1Vs8BGd/oj4BMMUsvQqqpJ7CPePLnQC561ipxgXuYDa/r
         ROFku1dnYl9PcUNH7xFURaKz5uDQ/Oztw2DkN3U+Z8u6FVLPHkqhN8Q0B5RjS0jrAqcC
         uHp5jWdt2SaBF04bTw2neetunCLiwbgPiEAMTO0djZFq3F75sdL0s9G6KKC9RYD58iiv
         cXjPyRwtanPSFWeAXrmO0f8wCC5vh89wvygDPUtcwgtQFDI4nSxfXeatIEFVCst4PF4s
         dKbA==
X-Gm-Message-State: AOAM530E5ggqk5k+JLj4fRQwIhn2pVxKQIWJm1EkJxo4e4xsUCfDO6zR
        OIWryv8QQ2IeMWWX8VjlTDl+Jg==
X-Google-Smtp-Source: ABdhPJwmk9A0NNb9BOzV41cZdJOCwaiG/uQdtvC4TrjEXbXQGfb4WWIjHQOAVT/53rQzycPwg8eahQ==
X-Received: by 2002:a92:1303:0:b0:2c5:f030:3074 with SMTP id 3-20020a921303000000b002c5f0303074mr9514081ilt.134.1649444159561;
        Fri, 08 Apr 2022 11:55:59 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id g14-20020a92c7ce000000b002ca47b75772sm8643336ilk.44.2022.04.08.11.55.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 11:55:59 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuah@kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.18-rc2
Message-ID: <f8e5687f-958b-c97b-4ddb-7bbfbdfa036f@linuxfoundation.org>
Date:   Fri, 8 Apr 2022 12:55:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------85C0ADF20CB817C0B440F2DF"
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
--------------85C0ADF20CB817C0B440F2DF
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.18-rc2.

This KUnit update for Linux 5.18-rc2 consists of a single documentation
fix to incorrect and outdated usage information.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.18-rc2

for you to fetch changes up to 02c7efa43627163e489a8db87882445a0ff381f7:

   Documentation: kunit: fix path to .kunitconfig in start.rst (2022-04-04 12:02:44 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.18-rc2

This KUnit update for Linux 5.18-rc2 consists of a single documentation
fix to incorrect and outdated usage information.

----------------------------------------------------------------
Daniel Latypov (1):
       Documentation: kunit: fix path to .kunitconfig in start.rst

  Documentation/dev-tools/kunit/start.rst | 11 ++++++++---
  1 file changed, 8 insertions(+), 3 deletions(-)
----------------------------------------------------------------

--------------85C0ADF20CB817C0B440F2DF
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.18-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.18-rc2.diff"

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index ad168d16968f..867a4bba6bf6 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -41,13 +41,18 @@ or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
 	CONFIG_MSDOS_FS=y
 	CONFIG_FAT_KUNIT_TEST=y
 
-1. A good starting point for the ``.kunitconfig``, is the KUnit default
-   config. Run the command:
+1. A good starting point for the ``.kunitconfig`` is the KUnit default config.
+   You can generate it by running:
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp tools/testing/kunit/configs/default.config .kunitconfig
+	tools/testing/kunit/kunit.py config
+	cat .kunit/.kunitconfig
+
+.. note ::
+   ``.kunitconfig`` lives in the ``--build_dir`` used by kunit.py, which is
+   ``.kunit`` by default.
 
 .. note ::
    You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as

--------------85C0ADF20CB817C0B440F2DF--
