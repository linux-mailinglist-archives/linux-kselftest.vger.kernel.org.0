Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6262F6CA1
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Jan 2021 21:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbhANUxY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 15:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbhANUxY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 15:53:24 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9745CC061575
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 12:52:43 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id q25so6484811otn.10
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 12:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=WMRVmV5maA7pUe5nDzLek/XXxNjHWhNj+CjmLV41vcA=;
        b=Jmjlv5d1UWTL0j3rIlEuXsEEDkB2v+tPtwKeqtBtCr4Q9IzYG/sM5pEm7K4sZki1cV
         nSO77MCo9ebaBhIkeT8RRKHdvb52Ej+RzKFSMU8QuM5Jf/YB0KA1+SXxHklV9WWgwFJv
         igCKELnB5exaKusRy3Iw9/ffN4vS7AE16IDt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=WMRVmV5maA7pUe5nDzLek/XXxNjHWhNj+CjmLV41vcA=;
        b=svG5NqQbLSBqrmOGMLDHcM/NH2wpNwWjtNEs/lqeJ0SrxT/wKAeIvzCecwcxJ2hv6f
         36RliHJhXkz28wks2blHWpaEXUKnzHXS0vNjAN+onFIBdPRNVSqzLGAnnsK77i1L57lt
         BYN+sSFXEXIT4b8nygf6bclJlCGbOcyO7Hp4yEkNP0Ksw/v4SShkgunke46jRTCXh9/B
         pk4vjF5WSk2yESMM1ZSiHIslCktGjzjFes2Xa1ZUq+X9l4KQeG4xoJpbMPgRwQKifnOS
         5EfZBB5qYWIHv/nGPwL20JlzjFEmxbmXTJWaPAw9x+jGq+K23/37peUHDkQx5LkQcHAK
         HjDQ==
X-Gm-Message-State: AOAM531/83pogU1pg34HW3Dv9eOidDyiNINGvM2nIGOwggTAaBBZ3swm
        EnaJm3LTIv/92n1s3AEMLwO+IMTxzMpMtA==
X-Google-Smtp-Source: ABdhPJwlSnSrE+ja7Jt3eFQnXVCVcATiFtvR+TKHwF9bwkcqrgJkIJUeo0xy9D9ox1PfAWOfCojd1A==
X-Received: by 2002:a9d:7746:: with SMTP id t6mr6119012otl.349.1610657562985;
        Thu, 14 Jan 2021 12:52:42 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 65sm1282557otp.35.2021.01.14.12.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jan 2021 12:52:42 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 5.11-rc4
Message-ID: <e60bdae0-2df1-9401-a8e0-3949884a7db0@linuxfoundation.org>
Date:   Thu, 14 Jan 2021 13:52:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C4F8C71A66D473BE00FD780B"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------C4F8C71A66D473BE00FD780B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.11-rc4

This Kselftest fixes update for Linux 5.11-rc4 consists of one single
fix to skip BPF selftests by default. BPF selftests have a hard
dependency on cutting edge versions of tools in the BPF ecosystem
including LLVM.

Skipping BPF allows by default will make it easier for users interested
in running kselftest as a whole. Users can include BPF in Kselftest
build by via SKIP_TARGETS variable.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

   Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-fixes-5.11-rc4

for you to fetch changes up to 7a6eb7c34a78498742b5f82543b7a68c1c443329:

   selftests: Skip BPF seftests by default (2021-01-04 09:27:20 -0700)

----------------------------------------------------------------
linux-kselftest-fixes-5.11-rc4

This Kselftest fixes update for Linux 5.11-rc4 consists of one single
fix to skip BPF selftests by default. BPF selftests have a hard
dependency on cutting edge versions of tools in the BPF ecosystem
including LLVM.

Skipping BPF allows by default will make it easier for users interested
in running kselftest as a whole. Users can include BPF in Kselftest
build by via SKIP_TARGETS variable.

----------------------------------------------------------------
Mark Brown (1):
       selftests: Skip BPF seftests by default

  tools/testing/selftests/Makefile | 6 ++++--
  1 file changed, 4 insertions(+), 2 deletions(-)

----------------------------------------------------------------

--------------C4F8C71A66D473BE00FD780B
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.11-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.11-rc4.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index afbab4aeef3c..8a917cb4426a 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -77,8 +77,10 @@ TARGETS += zram
 TARGETS_HOTPLUG = cpu-hotplug
 TARGETS_HOTPLUG += memory-hotplug
 
-# User can optionally provide a TARGETS skiplist.
-SKIP_TARGETS ?=
+# User can optionally provide a TARGETS skiplist.  By default we skip
+# BPF since it has cutting edge build time dependencies which require
+# more effort to install.
+SKIP_TARGETS ?= bpf
 ifneq ($(SKIP_TARGETS),)
 	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
 	override TARGETS := $(TMP)

--------------C4F8C71A66D473BE00FD780B--
