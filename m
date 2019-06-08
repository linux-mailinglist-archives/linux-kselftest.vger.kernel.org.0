Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9A39A15
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2019 04:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfFHCLJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jun 2019 22:11:09 -0400
Received: from mail-it1-f179.google.com ([209.85.166.179]:51257 "EHLO
        mail-it1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbfFHCLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jun 2019 22:11:08 -0400
Received: by mail-it1-f179.google.com with SMTP id m3so5549000itl.1
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2019 19:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=SvnI0124RQyG3mZdpITe2RKpNEsDCUsmCfQu//JUzcY=;
        b=X09+drmRRIGFjuEz2GoZ5RiiSac8xIMyegzJZbLbA4yEx6SaI+WwsWCNvrkboqmVO5
         /3OKP6FqiuR27MeClWl3Hnlp9d8sGh+bYsQvvFD8ZWBAGrq/SIq74L4BZc5rVua/GBE2
         X2wo7BqzVQtAuLSgvtG91e0xPHf+yZs/xHARM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=SvnI0124RQyG3mZdpITe2RKpNEsDCUsmCfQu//JUzcY=;
        b=OP4OqCfGU0yBGWBtUA4wiLV8esK46fHZ2MuyfvP8oPMtnzgAcvV9sTZOHgRF9j6kSl
         78o8RbPxNqtQjmQTC35bQjIJP1CyHL901Jpl6CHfiphU5pBz/bDGSlPUWduWL+IXdylU
         mYLF/mi9xc9hHoJfvOKwSFmV3xhxtr3eIuECSNbGW3FJXTuQ8RkV6dizwPJZkqUSbMQ9
         8z1a5iFjttbVS8NebvmT8U0M3WDcf9eh790MayhXzJuO+zPQETrLeAz5VC1ZKGQg7gal
         cqs6BnToK08oNY7tYCDuKGBlkZuubzzNh/n51changaNq9FZgk/Rzh8cyCRZBup/QAO+
         4yJg==
X-Gm-Message-State: APjAAAUtwJeoXc0h/yxJaArBEkABZmdm7f8wnJukPfxde2DeSa5Xs0YZ
        isZ6qfpuFVWBCHqc0K+E9Vw7huzl4fU=
X-Google-Smtp-Source: APXvYqyvNxcDeEsIA5sWyry2m2CfkiS2/C5q6ZoBbN4kth6uYuymFdU5J9mFZl1P9fa7C82Zrr2Cww==
X-Received: by 2002:a24:d147:: with SMTP id w68mr6591208itg.176.1559959867659;
        Fri, 07 Jun 2019 19:11:07 -0700 (PDT)
Received: from [10.11.17.215] ([97.107.68.205])
        by smtp.gmail.com with ESMTPSA id z202sm1979011itb.2.2019.06.07.19.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 19:11:06 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     skhan@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest second fixes update for Linux 5.2-rc4
Message-ID: <f97f7947-db3b-07dd-157d-78ab9840a4dc@linuxfoundation.org>
Date:   Fri, 7 Jun 2019 20:11:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------C8926D04930EEB99C63E8D8F"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------C8926D04930EEB99C63E8D8F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following second Kselftest fixes update for
Linux 5.2 rc4.

This Kselftest second fixes update for Linux 5.2-rc4 consists of a
single fix for vm test build failure regression when it is built by
itself.

I found this while I was sanity checking the first fixes update for
Linux 5.2. Would like to get this into rc4.

diff is attached.

thanks,
-- Shuah


----------------------------------------------------------------
The following changes since commit bc2cce3f2ebcae02aa4bb29e3436bf75ee674c32:

   selftests: vm: install test_vmalloc.sh for run_vmtests (2019-05-30 
08:32:57 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.2-rc4-2

for you to fetch changes up to e2e88325f4bcaea51f454723971f7b5ee0e1aa80:

   selftests: vm: Fix test build failure when built by itself 
(2019-06-05 16:05:40 -0600)

----------------------------------------------------------------
linux-kselftest-5.2-rc4-2

This Kselftest second fixes update for Linux 5.2-rc4 consists of a single
fix for vm test build failure regression when it is built by itself.

----------------------------------------------------------------
Shuah Khan (1):
       selftests: vm: Fix test build failure when built by itself

  tools/testing/selftests/vm/Makefile | 4 ----
  1 file changed, 4 deletions(-)
----------------------------------------------------------------

--------------C8926D04930EEB99C63E8D8F
Content-Type: text/x-patch;
 name="linux-kselftest-5.2-rc4-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.2-rc4-2.diff"

diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 05306c58ff9f..9534dc2bc929 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm selftests
 
-ifndef OUTPUT
-  OUTPUT := $(shell pwd)
-endif
-
 CFLAGS = -Wall -I ../../../../usr/include $(EXTRA_CFLAGS)
 LDLIBS = -lrt
 TEST_GEN_FILES = compaction_test

--------------C8926D04930EEB99C63E8D8F--
