Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5462EF71D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Jan 2021 19:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbhAHSPR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Jan 2021 13:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbhAHSPR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Jan 2021 13:15:17 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21434C061380
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Jan 2021 10:14:42 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id 81so10579709ioc.13
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Jan 2021 10:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=4pYuW2RQzkGNYe6pqrE6i2YoyXvOiNofhCQUPGZDd+k=;
        b=TZi/L8bvFoNzQt/wG+hOn2kDcHlSXn3CfoOQXXVEmgSQCX6LvWCyLfpTP+gHI3SuwY
         pfyF9JhC3oOw6VGCyhYyUIxVxKPVx718w7hj8OWsaaFQk/+nYPipQmwGA+w1X8Pc8hko
         UYOo9jRRArdBoIR07yLx6y38Ip95EhKsfh15M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=4pYuW2RQzkGNYe6pqrE6i2YoyXvOiNofhCQUPGZDd+k=;
        b=h6v38ibDx5dCY58hvyv5NTc3zcxcFjUgiym1X+F5KOX+NSOpod+dw46TWukvsQVCJA
         4zZea1/Ae4O58Z3A+EXjGrm0Rv4XWVI+RQjeJO2APiRUvbLwRg42TH5fIz8ytpHcumie
         psQfRcIBTMkhGVhArmU796oClAIUKaGdjrnZ9wzFKgAN8ZhHSfrwdI5yuKV+xDpV6Eb5
         QBwijMllLFVMlBmFg3Zu3XWveXXIJvkocQroo2P5UxU+AlBTtj5niYOQyPdozDLoq2tP
         PBcVLdwakacRmRxrhZPwZ+2zMHl0+kxJRsZrqLvwopUHkL75Wup7GGi5YfalPYysQ0Q8
         jWkQ==
X-Gm-Message-State: AOAM5333HC7NXGQarEUX016W0qrVu6s3Z9Ys+AgnBynD008prpFkD2zI
        iVSqAvhNQEeR427eefEtTjDEFA==
X-Google-Smtp-Source: ABdhPJxmuf43w45jGrHdUTOv6iywp2DdUyAYGnf9Xt7WbtdLB8PkRo9oa0ekQ4Dt3cRUUTxpB5lSKA==
X-Received: by 2002:a02:91c2:: with SMTP id s2mr4594597jag.48.1610129681309;
        Fri, 08 Jan 2021 10:14:41 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o7sm5411243iop.51.2021.01.08.10.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 10:14:40 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes for Linux 5.11-rc3
Message-ID: <2f3c419c-89ea-8a53-c2a4-ef8fa6312f23@linuxfoundation.org>
Date:   Fri, 8 Jan 2021 11:14:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------D9143DE09C878CF24D204415"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------D9143DE09C878CF24D204415
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following fixes update for Linux 5.11-rc3.

This fixes update for 5.11-rc3 consists of two minor fixes to vDSO test
changes in 5.11-rc1 update.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

   Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-next-5.11-rc3

for you to fetch changes up to df00d02989024d193a6efd1a85513a5658c6a10f:

   selftests/vDSO: fix -Wformat warning in vdso_test_correctness 
(2021-01-04 09:25:45 -0700)

----------------------------------------------------------------
linux-kselftest-next-5.11-rc3

This fixes update for 5.11-rc3 consists of two minor fixes to vDSO test
changes in 5.11-rc1 update.

----------------------------------------------------------------
Tobias Klauser (2):
       selftests/vDSO: add additional binaries to .gitignore
       selftests/vDSO: fix -Wformat warning in vdso_test_correctness

  tools/testing/selftests/vDSO/.gitignore              | 3 +++
  tools/testing/selftests/vDSO/vdso_test_correctness.c | 2 +-
  2 files changed, 4 insertions(+), 1 deletion(-)

----------------------------------------------------------------

--------------D9143DE09C878CF24D204415
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.11-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.11-rc3.diff"

diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftests/vDSO/.gitignore
index 5eb64d41e541..a8dc51af5a9c 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
+vdso_test_abi
+vdso_test_clock_getres
+vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
 vdso_standalone_test_x86
diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
index 5029ef9b228c..c4aea794725a 100644
--- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
+++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
@@ -349,7 +349,7 @@ static void test_one_clock_gettime64(int clock, const char *name)
 		return;
 	}
 
-	printf("\t%llu.%09ld %llu.%09ld %llu.%09ld\n",
+	printf("\t%llu.%09lld %llu.%09lld %llu.%09lld\n",
 	       (unsigned long long)start.tv_sec, start.tv_nsec,
 	       (unsigned long long)vdso.tv_sec, vdso.tv_nsec,
 	       (unsigned long long)end.tv_sec, end.tv_nsec);

--------------D9143DE09C878CF24D204415--
