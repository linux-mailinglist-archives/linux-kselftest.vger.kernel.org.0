Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8F5119FED
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2019 01:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfLKA1r (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Dec 2019 19:27:47 -0500
Received: from mail-il1-f175.google.com ([209.85.166.175]:38890 "EHLO
        mail-il1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbfLKA1r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Dec 2019 19:27:47 -0500
Received: by mail-il1-f175.google.com with SMTP id u17so17873347ilq.5
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Dec 2019 16:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+LjSD6sVRfH2//hYMsY7+rgc6dBShfyt7VWRkvvmBSw=;
        b=VzkfbA3JJVNZR2NqBWHOvSAOAEe3oUB5+qdGJh76ZlosSggwxkVIi1akfrjGwluYWI
         DtnR0OQfOHMR2lZf7vx+D5ACoQ8Ibrs8d6Y2R/dkLeCSWpoTirv+H8IwquERWvLsch1z
         BQpqvhvLtPvRfhAG1C/OU6PiObA9EjcuoOQOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+LjSD6sVRfH2//hYMsY7+rgc6dBShfyt7VWRkvvmBSw=;
        b=rf0zPRFvw306Rk+Ze8TXrlmewIkS1CXDAmrUuOL/rnKFfnm+5K2MpPOMF/vQYoZfYz
         RpX6IuWZavo96E/p94vGohpdMDTdN1TWxO7aERIewrGcSCejuXLTSTrVLDfpTtxP9m3j
         wplH7xeLYGF8tu2CdFNjlOcMn/dtdSUUX5DOCmV0gSpmlJYAk0f5KsprR2EMZOjjpJq0
         JJGsf60uNxm4KQ6HEWOfvbU7ggJvpzUZgAUbFacx91N2PdGW7hBv2a0fMpj28CcysYst
         lTJ0H5izLP4ZD72ZQzamc5TwbcHIU2xAM+VqJkbK9PmYxyjLi62G9/lIfakLtvmi7xe5
         GTNQ==
X-Gm-Message-State: APjAAAX/8mKjUJW+4b+u+FakZB9vQAY4Uvw0Vth+W7WzWXyfhpTPfY1c
        dHkbiy/6wETNHH0bFlUgm2efFg==
X-Google-Smtp-Source: APXvYqxMXre2lYtjHVTpvGNDP8qoZJnxHDDjM1l1v2+ZDWv9h6fWOXfMCkZNJWiclb+chQl/adutkQ==
X-Received: by 2002:a92:d609:: with SMTP id w9mr514333ilm.46.1576024066088;
        Tue, 10 Dec 2019 16:27:46 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id c4sm164062iln.24.2019.12.10.16.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 16:27:45 -0800 (PST)
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "skh >> Shuah Khan" <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.5=rc1 kselftest rseq test build failure
Message-ID: <2d53b409-31e0-2245-e163-1ab26f52c841@linuxfoundation.org>
Date:   Tue, 10 Dec 2019 17:27:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mathieu,

I am seeing rseq test build failure on Linux 5.5-rc1.

gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ 
param_test.c -lpthread -lrseq -o ...tools/testing/selftests/rseq/param_test
param_test.c:18:21: error: static declaration of ‘gettid’ follows 
non-static declaration
    18 | static inline pid_t gettid(void)
       |                     ^~~~~~
In file included from /usr/include/unistd.h:1170,
                  from param_test.c:11:
/usr/include/x86_64-linux-gnu/bits/unistd_ext.h:34:16: note: previous 
declaration of ‘gettid’ was here
    34 | extern __pid_t gettid (void) __THROW;
       |                ^~~~~~
make: *** [Makefile:28: ...tools/testing/selftests/rseq/param_test] Error 1


The following obvious change fixes it. However, there could be reason
why this was defined here. If you think this is the right fix, I can
send the patch. I started seeing this with gcc version 9.2.1 20191008

diff --git a/tools/testing/selftests/rseq/param_test.c 
b/tools/testing/selftests/rseq/param_test.c
index eec2663261f2..18a0fa1235a7 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -15,11 +15,6 @@
  #include <errno.h>
  #include <stddef.h>

-static inline pid_t gettid(void)
-{
-       return syscall(__NR_gettid);
-}
-

thanks,
-- Shuah
