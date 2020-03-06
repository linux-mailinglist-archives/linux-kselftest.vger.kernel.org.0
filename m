Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A2E17C899
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Mar 2020 23:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFW5a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 17:57:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:46537 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFW5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 17:57:30 -0500
Received: by mail-io1-f67.google.com with SMTP id f3so3662774ioc.13
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Mar 2020 14:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=BeTIV8Blb2bscQU2tgJ8V+Zgbz1bhhhaWIgmESqFo5Y=;
        b=UNfpX8cR+Bs+xh5MvTq64F9IxBwUvToUcCoUDlz1BA7+ijTynKh4wgGi27nRfcACGj
         GZIJb3d6zsNHFneTmNI9Am2BAS+XC8rPBg5nVuUrDcUdTy83ajSJGsmEHi9l66Z911Om
         qUz5hIgiFjT15ciqsoYf0bYsW3kfSOQ/DURx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=BeTIV8Blb2bscQU2tgJ8V+Zgbz1bhhhaWIgmESqFo5Y=;
        b=YMr4A8KFnvNsFDRMyZvz+Czh6FlR11J3+bYKF0dsKZq6DzgZTPQ7n+VXbTxqi30q0R
         8LISOmRxHJPAAMXjI0kpzzvWrqpx1uqtfqvMcVuVTLw1ofrku3jaaUtJgGKJ9FjiyrNN
         N9b5T3zaaICxyQnuB869xeQTOll24fp0MTA8PW18N0qClT0JYkkL38ZQzDLMBPcJGoEy
         Bx4aP21qIG43wg+vP3pHAvFzvAtXkc8lCFG7AmMy6naDT+kH0+YPxUhos/O8w6fRnESs
         xck5Zg7t7tzYnk2AzFxiPi2hj6Xrig9Th0TpJjVMAOgx4/EhPBxk69f7FUnqSSxTO+KD
         eQuQ==
X-Gm-Message-State: ANhLgQ1RbR6MPUNiI5j3Ib+AoMjbRsqWOrFDK3iTfKOOFbhecLJ2ME4K
        lT8lActWWRHjQ9onF+xrHjhKMw==
X-Google-Smtp-Source: ADFU+vusP6+faYm/JgMp+FqgBpC8rSfhwpjR2JYbjYaZQVPTgibO5YDm5Bwcd1q11M9ZbD9ER5gpqA==
X-Received: by 2002:a02:962e:: with SMTP id c43mr5408955jai.26.1583535449050;
        Fri, 06 Mar 2020 14:57:29 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a21sm8637030ioh.29.2020.03.06.14.57.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 14:57:28 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest kunit update for Linux 5.6-rc5
Message-ID: <4d298617-f061-dda0-bde0-901c48247b4a@linuxfoundation.org>
Date:   Fri, 6 Mar 2020 15:57:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------0B8DD01EAE523C777F6EDB82"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------0B8DD01EAE523C777F6EDB82
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Keselftest update for Linux 5.6-rc5.

This Kselftest update for Linux 5.6-rc5 consists of a cleanup patch
to undo changes to global .gitignore that added selftests/lkdtm
objects and add them to a local selftests/lkdtm/.gitignore.

Summary of Linus's comments on local vs. global gitignore scope:

- Keep local gitignore patterns in local files.
- Put only global gitignore patterns in the top-level gitignore file.

Local scope keeps things much better separated. It also incidentally
means that if a directory gets renamed, the gitignore file continues
to work unless in the case of renaming the actual files themselves that
are named in the gitignore.

Diff is attached.

I took the liberty to include summary of your comments on local vs
global gitignore scope in the commit message.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit ef89d0545132d685f73da6f58b7e7fe002536f91:

   selftests/rseq: Fix out-of-tree compilation (2020-02-20 08:57:12 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-5.6-rc5

for you to fetch changes up to f3a60268f5cec7dae0e9713f5fc65aecc3734c09:

   selftest/lkdtm: Use local .gitignore (2020-03-02 08:39:39 -0700)

----------------------------------------------------------------
linux-kselftest-5.6-rc5

This Kselftest update for Linux 5.6-rc5 consists of a cleanup patch
to undo changes to global .gitignore that added selftests/lkdtm
objects and add them to a local selftests/lkdtm/.gitignore.

Summary of Linus's comments on local vs. global gitignore scope:

- Keep local gitignore patterns in local files.
- Put only global gitignore patterns in the top-level gitignore file.

Local scope keeps things much better separated. It also incidentally
means that if a directory gets renamed, the gitignore file continues
to work unless in the case of renaming the actual files themselves that
are named in the gitignore.

----------------------------------------------------------------
Christophe Leroy (1):
       selftest/lkdtm: Use local .gitignore

  .gitignore                               | 4 ----
  tools/testing/selftests/lkdtm/.gitignore | 2 ++
  2 files changed, 2 insertions(+), 4 deletions(-)
  create mode 100644 tools/testing/selftests/lkdtm/.gitignore

----------------------------------------------------------------

--------------0B8DD01EAE523C777F6EDB82
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-5.6-rc5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-5.6-rc5.diff"

diff --git a/.gitignore b/.gitignore
index 2763fce8766c..72ef86a5570d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -100,10 +100,6 @@ modules.order
 /include/ksym/
 /arch/*/include/generated/
 
-# Generated lkdtm tests
-/tools/testing/selftests/lkdtm/*.sh
-!/tools/testing/selftests/lkdtm/run.sh
-
 # stgit generated dirs
 patches-*
 
diff --git a/tools/testing/selftests/lkdtm/.gitignore b/tools/testing/selftests/lkdtm/.gitignore
new file mode 100644
index 000000000000..f26212605b6b
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/.gitignore
@@ -0,0 +1,2 @@
+*.sh
+!run.sh

--------------0B8DD01EAE523C777F6EDB82--
