Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D68346606
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Mar 2021 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhCWRKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Mar 2021 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhCWRKT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Mar 2021 13:10:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2394C061763
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Mar 2021 10:10:18 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id v3so18803123ilj.12
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Mar 2021 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=nl7QaIos4KVB6wLD0CE4Fe3WB0mMHl24sYGz8H8gaAE=;
        b=Qh8RLG2/qYMPKJTZKqZJ6HOBgm//heQscHSAXDjVn8vG6tp1ZPCh+Ge/6Iq8z7rH78
         A74nTu9wLskgNP4YNSqRUGVAIUlDD9ChcRDLLklwaZP5d5gkNrUFtS/Nb1H8fgfZ15yX
         6B+IiqN4V3HmDuq1HuPqZ+GzGrBDkp8Cj/+uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=nl7QaIos4KVB6wLD0CE4Fe3WB0mMHl24sYGz8H8gaAE=;
        b=sgQJgpBQ5prOEvFDJ0Femw9dFldqMiYh9MPV7kdLFKim7MdaSJYWMY2ARs5eO/RVO1
         iWA8CVv3/MB9Joud74+UJb5Q9HTO/Rl5U7Jp1ZBnhVwGsvdoQYg1VQnauD4fCqgJro+Q
         udnW0WcgEDDhp6e+qv8yphFrlp2AULyaVn2x+2cQR9t+mi5scQ82t7yOPzGWGlZ609+s
         +16YBP4Uee5JKrstBtbcmi7hxmc//3gESmw6CGWOAClLOK8nl5VPy1R9m7cMdiNbFaxU
         MYkhynnPRWBY1uUDFWPyO5ql2noJYHFEVub4PMLlFuZ7dWqE72GtejLcVIRded7X7AUs
         NRFg==
X-Gm-Message-State: AOAM532RDxUlefN/uYRDpFkpkVDowu+NkTgnCwi2zUb4PCtmX/uHi8Uo
        RRARfllMgUgBpRI73H22J+zEhvAvNYukDw==
X-Google-Smtp-Source: ABdhPJz+oJMhX7q0O0fiu6m6Y9fiJBZzQtZ0uxeBctDr7oCjj8KnB2tkCVoj2a28N9rI/FLhMXuPeg==
X-Received: by 2002:a05:6e02:ee3:: with SMTP id j3mr5858838ilk.85.1616519418458;
        Tue, 23 Mar 2021 10:10:18 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id h2sm9304504ioj.30.2021.03.23.10.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 10:10:17 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 5.12-rc5
Message-ID: <13097e8e-2877-b63d-cd44-6393c1744a66@linuxfoundation.org>
Date:   Tue, 23 Mar 2021 11:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------4118C60156499C14911455A1"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------4118C60156499C14911455A1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5.12-rc5.

This KUnit update for Linux 5.12-rc5 consists of two fixes to kunit
tool from David Gow.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

   Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.12-rc5.1

for you to fetch changes up to 7fd53f41f771d250eb08db08650940f017e37c26:

   kunit: tool: Disable PAGE_POISONING under --alltests (2021-03-11 
14:37:37 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.12-rc5.1

This KUnit update for Linux 5.12-rc5 consists of two fixes to kunit
tool from David Gow.

----------------------------------------------------------------
David Gow (2):
       kunit: tool: Fix a python tuple typing error
       kunit: tool: Disable PAGE_POISONING under --alltests

  tools/testing/kunit/configs/broken_on_uml.config | 2 ++
  tools/testing/kunit/kunit_config.py              | 2 +-
  2 files changed, 3 insertions(+), 1 deletion(-)

----------------------------------------------------------------


--------------4118C60156499C14911455A1
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.12-rc5.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.12-rc5.1.diff"

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
index a7f0603d33f6..690870043ac0 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -40,3 +40,5 @@
 # CONFIG_RESET_BRCMSTB_RESCAL is not set
 # CONFIG_RESET_INTEL_GW is not set
 # CONFIG_ADI_AXI_ADC is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_PAGE_POISONING is not set
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 0b550cbd667d..1e2683dcc0e7 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -13,7 +13,7 @@ from typing import List, Set
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
-KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
+KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
 
 class KconfigEntry(KconfigEntryBase):
 

--------------4118C60156499C14911455A1--
