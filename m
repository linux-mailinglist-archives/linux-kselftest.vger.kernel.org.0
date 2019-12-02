Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14D210ECE1
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 17:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfLBQMx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 11:12:53 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37070 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfLBQMv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 11:12:51 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so30505372ioc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Dec 2019 08:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=R5zJ8In6LlJQbPpTqvTFgEgHr4r6MhNv3YRn/orOSDU=;
        b=P0HIc1/Dq5h4/jQB2TXzHRf3K6gk27bx6R5uWk/CR00EOzYwppxWoL/1BsZzDgWs5e
         EyMQSTG8AYaInxacsWOIZHE6Wywt9PIihQ8lFtL6OKbLNnm6h4RC35OiD1O/oz0Odt/T
         LifAG1XjlNA/L5q+h0QjqbZrZW2TQNJYGpXsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=R5zJ8In6LlJQbPpTqvTFgEgHr4r6MhNv3YRn/orOSDU=;
        b=KqHee2x1XIdwXGLu946m7XTWg+yMHtdRTnWMld3BtOG7t2c/ZifGVqKx++1q+CDAjm
         3T32Ketf5pBC/ulq9Ca1dcgWNqysyUAqZh6AKgjsMiYgU/CYD2zrcgsihu3ioJEWT4fj
         3QOO8ddcBhUI/beBn8dVdnJUTiXXspj+XGTsX3EQW4glFJ8GkePJpmiAnYSshIuUTTRf
         /T5tK5XarIHHl/lgQ3tmAp+zKfd6vVWttMv4nvCACwiCZ5k1Z9PfMAsg+Sesa/j5DgER
         q3BavYv6nN2PAlX0OYD5tC1S/N7rvmQKzDTL1uqDV5wWormdDRN5KoIZKw7UCFZSmVZ3
         E9Sg==
X-Gm-Message-State: APjAAAWiUuCAvUt+Hm1fS9ZfSS5lQMpBZOyQnkm/62zvj/6m9qEWHaGV
        Dx+NjJM6xiSu5A+ZS91I/Di/bA==
X-Google-Smtp-Source: APXvYqxRlhfblsNYn/5FSfPcwDEC+6JBjaNlTfqo/tQG7X1ZiydMZgmPU8uW7Saec8hQmqMdd+vmRw==
X-Received: by 2002:a6b:5914:: with SMTP id n20mr39940124iob.42.1575303170409;
        Mon, 02 Dec 2019 08:12:50 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c4sm1001193iln.24.2019.12.02.08.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2019 08:12:49 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes2 update for Linux 5.5.rc1
Message-ID: <2b0d6a6e-d135-f5dd-f8e9-74b3130d5e9e@linuxfoundation.org>
Date:   Mon, 2 Dec 2019 09:12:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------67779F6A768A6C04B0623C06"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------67779F6A768A6C04B0623C06
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull this second Kselftest fixes update for Linux 5.5-rc1.

This second Kselftest fixes update for Linux 5.5-rc1 consists of
an urgent revert to fix regression in CI coverage.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------

The following changes since commit ed2d8fa734e7759ac3788a19f308d3243d0eb164:

   selftests: sync: Fix cast warnings on arm (2019-11-07 14:54:37 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.5-rc1-fixes2

for you to fetch changes up to f60b85e83659b5fbd3eb2c8f68d33ef4e35ebb2c:

   Revert "selftests: Fix O= and KBUILD_OUTPUT handling for relative 
paths" (2019-11-28 16:27:44 -0700)

----------------------------------------------------------------
linux-kselftest-5.5-rc1-fixes2

This second Kselftest fixes update for Linux 5.5-rc1 consists of
an urgent revert to fix regression in CI coverage.

----------------------------------------------------------------
Shuah Khan (1):
       Revert "selftests: Fix O= and KBUILD_OUTPUT handling for relative 
paths"

  tools/testing/selftests/Makefile | 5 ++---
  1 file changed, 2 insertions(+), 3 deletions(-)

----------------------------------------------------------------

--------------67779F6A768A6C04B0623C06
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.5-rc1-fixes2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.5-rc1-fixes2.diff"

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e762c42d758..503a93afd452 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -86,10 +86,10 @@ override LDFLAGS =
 endif
 
 ifneq ($(O),)
-	BUILD := $(abs_objtree)
+	BUILD := $(O)
 else
 	ifneq ($(KBUILD_OUTPUT),)
-		BUILD := $(abs_objtree)/kselftest
+		BUILD := $(KBUILD_OUTPUT)/kselftest
 	else
 		BUILD := $(shell pwd)
 		DEFAULT_INSTALL_HDR_PATH := 1
@@ -102,7 +102,6 @@ include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
 export KSFT_KHDR_INSTALL_DONE := 1
 export BUILD
-#$(info abd_objtree = $(abs_objtree) BUILD = $(BUILD))
 
 # build and run gpio when output directory is the src dir.
 # gpio has dependency on tools/gpio and builds tools/gpio

--------------67779F6A768A6C04B0623C06--
