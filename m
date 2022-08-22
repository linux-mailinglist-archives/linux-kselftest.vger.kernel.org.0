Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4548459CB4E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 00:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbiHVWIg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 18:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiHVWIe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 18:08:34 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FC515FCD
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 15:08:33 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n202so4005844iod.6
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:from:to:cc;
        bh=PO/x/lcGxwJuGHeoVdebBw0jfaxk4xanIPuLnTroQB8=;
        b=UE5morJYl8WKwxtRgQBozd/4eWed/1OLiDZS7ZAmPKt6wne8S0zSAY9a/pYk+SH1rF
         nN+evzFaSnpvy5ytnX40b+y8B4SEj/TLtUru5L+Kms6PMjkJ2aBuWvgOebNpyCWxyJ9V
         I4eHLvnYLZRoebAUvFi1J3diWyHq9kGpSQTfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-language:mime-version:user-agent:date:message-id:subject
         :from:cc:to:x-gm-message-state:from:to:cc;
        bh=PO/x/lcGxwJuGHeoVdebBw0jfaxk4xanIPuLnTroQB8=;
        b=bfPHpxq5r63IqGZeH1qRjXIBvXsE8bDocIT3S9F+o9h7JxldXQDL+gwZksnPK9Nk0Y
         G0A3gNS2r4lznwOOOOw6mD2z93mV5wvuCH6I0NPQSIQfkzJZNDm7GfzZ6bJmF3YP00IV
         EZFHv88zkczYQjA6I+Y4XtgoYr7kaGUuaRPJnanzE0KdpGXC8HUGsVrdayV6P4FqVsPx
         FHiG7S3m8JurJ1flQauHuccysAuV93nuaBK+t3nDzyz22ZQbO4HOTW6CmUBHkIoulUag
         f6eo9D3OIpIrhPb3jIfi+bK3E8XDTBgy6DbHUQjPN6ZKosA/sPE7hdIeEwaivRgQXTFp
         zvVw==
X-Gm-Message-State: ACgBeo1sS0ZE0t6QNHn3hlTg/QDoDTzOIehvKrejSiTnk9XZTlKaDxK9
        LU+P3YbJiAxQrQE8HFO2kHdhmRh3hNKw6w==
X-Google-Smtp-Source: AA6agR6nRT7b99pV0tfx6ExxJGTOZeine4C8N+sdZHFkmkeWW/t5r3gdGMTY7FrZj9i6iGSiHb69lg==
X-Received: by 2002:a05:6638:470d:b0:349:c2f7:59c4 with SMTP id cs13-20020a056638470d00b00349c2f759c4mr5674015jab.223.1661206112922;
        Mon, 22 Aug 2022 15:08:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d37-20020a023f25000000b0033197f42be0sm5518637jaa.157.2022.08.22.15.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 15:08:32 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.0-rc3
Message-ID: <83371a8c-9f40-3947-51d0-07efc15bdae2@linuxfoundation.org>
Date:   Mon, 22 Aug 2022 16:08:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------A398DC0BE7E221BC49E8E404"
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
--------------A398DC0BE7E221BC49E8E404
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.0-rc3.

This KUnit fixes update for Linux 6.0-rc3 consists of fixes to mmc
test and fix to load .kunit_test_suites section when CONFIG_KUNIT=m,
and not just when KUnit is built-in.

Please note that this KUnit update touches mmc driver Kconfig and
kernel/module/main.c.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-6.0-rc3

for you to fetch changes up to 41a55567b9e31cb852670684404654ec4fd0d8d6:

   module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m (2022-08-15 13:51:07 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-6.0-rc3

This KUnit fixes update for Linux 6.0-rc3 consists of fixes to mmc
test and fix to load .kunit_test_suites section when CONFIG_KUNIT=m,
and not just when KUnit is built-in.

----------------------------------------------------------------
David Gow (2):
       mmc: sdhci-of-aspeed: test: Fix dependencies when KUNIT=m
       module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m

  drivers/mmc/host/Kconfig | 1 +
  kernel/module/main.c     | 2 +-
  2 files changed, 2 insertions(+), 1 deletion(-)
----------------------------------------------------------------

--------------A398DC0BE7E221BC49E8E404
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-6.0-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-6.0-rc3.diff"

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 10c563999d3d..e63608834411 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -171,6 +171,7 @@ config MMC_SDHCI_OF_ASPEED
 config MMC_SDHCI_OF_ASPEED_TEST
 	bool "Tests for the ASPEED SDHCI driver" if !KUNIT_ALL_TESTS
 	depends on MMC_SDHCI_OF_ASPEED && KUNIT
+	depends on (MMC_SDHCI_OF_ASPEED=m || KUNIT=y)
 	default KUNIT_ALL_TESTS
 	help
 	  Enable KUnit tests for the ASPEED SDHCI driver. Select this
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 6a477c622544..a4e4d84b6f4e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2099,7 +2099,7 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					      sizeof(*mod->static_call_sites),
 					      &mod->num_static_call_sites);
 #endif
-#ifdef CONFIG_KUNIT
+#if IS_ENABLED(CONFIG_KUNIT)
 	mod->kunit_suites = section_objs(info, ".kunit_test_suites",
 					      sizeof(*mod->kunit_suites),
 					      &mod->num_kunit_suites);

--------------A398DC0BE7E221BC49E8E404--
