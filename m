Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB254434EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbhKBR6p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 13:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBR6p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 13:58:45 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74C1C061714
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 10:56:09 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id y17so22756650ilb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=+qNZ28+w6tKknyZQXZDBa8W1+zW67Gkd0XM9jOzlFcA=;
        b=fjCbPOe+zSGwICRtpTlasEOjrcc4cc9FFhDXgem3iKrRnnlL60mg9Bzjdn31uAbrit
         opp/23s5CfmRI4/3hJTqw4EwctWcYUgHhEeKPSFLL+8m2QbbRARVgTbzuw4CG+8gJ9/Z
         esZ17/MvVtuPqJiiGNXLjZ7F1rRAEWSn0VnmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=+qNZ28+w6tKknyZQXZDBa8W1+zW67Gkd0XM9jOzlFcA=;
        b=TWkWhoFsPP1yo8OHPVhBwQuZkz8Lnu/KHg9YoAP4oydQdbt5AJyKN6Cj2BwkeaqG/r
         vs/eLUXSMER41DUAEBNcdtOvmOL101Qxe+WY5TOCrxysVxqsbS/GFcdvGW2tyLlNusx/
         +uykvFK/q/vdB6EEgb+MDsTYJNQf5LBqJK7dg1E1vEdTihu8PdT8XcgN5Hp/pvsE/QpP
         Psh76xJ7ReEOsvd6VwEObWXOpTX/M9l5mFyz6NzywjJdsDxGD7HQG0GOS5P8sncpDTa+
         2kyVdjl2ZazJcQ8HnBWM6cPsLfcb82dPvPoGelnX8qZjo31SUj/k0QMMeDA8rVgTVWfV
         O39g==
X-Gm-Message-State: AOAM531GAeWac/pDighwbym/qnpADDEnJhUkAAGrZH1ePlgUkbZGoTVj
        pPJ6muwheca0gvQ1k3C+SoSFgc7R4sjEJw==
X-Google-Smtp-Source: ABdhPJzDxfNmBAvqmjEh/nzzXAJDO6dpUas1dONU+/YwgMI9LIVfhOb7eSaDzKU5I0G5N65RNBGyiQ==
X-Received: by 2002:a05:6e02:ef3:: with SMTP id j19mr21364793ilk.212.1635875769156;
        Tue, 02 Nov 2021 10:56:09 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id a5sm10974005ilf.27.2021.11.02.10.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 10:56:08 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest next update for Linux 5.16-rc1
Message-ID: <5ee0a2b3-d5c1-5664-cb02-c24a7f4cdeaa@linuxfoundation.org>
Date:   Tue, 2 Nov 2021 11:56:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------302F752F414E28FD40D17556"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------302F752F414E28FD40D17556
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest next update for Linux 5.16-rc1.

This Kselftest update for Linux 5.16-rc1 consists of fixes to compile
time errors and warnings.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

   Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-next-5.16-rc1

for you to fetch changes up to f35dcaa0a8a29188ed61083d153df1454cf89d08:

   selftests/core: fix conflicting types compile error for close_range() (2021-10-29 13:09:42 -0600)

----------------------------------------------------------------
linux-kselftest-next-5.16-rc1

This Kselftest update for Linux 5.16-rc1 consists of fixes to compile
time error and warnings.

----------------------------------------------------------------
Shuah Khan (3):
       selftests: kvm: fix mismatched fclose() after popen()
       selftests: x86: fix [-Wstringop-overread] warn in test_process_vm_readv()
       selftests/core: fix conflicting types compile error for close_range()

  tools/testing/selftests/core/close_range_test.c        | 2 +-
  tools/testing/selftests/kvm/x86_64/mmio_warning_test.c | 2 +-
  tools/testing/selftests/x86/test_vsyscall.c            | 2 +-
  3 files changed, 3 insertions(+), 3 deletions(-)
----------------------------------------------------------------

--------------302F752F414E28FD40D17556
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.16-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.16-rc1.diff"

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 73eb29c916d1..aa7d13d91963 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -54,7 +54,7 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 #endif
 
-TEST(close_range)
+TEST(core_close_range)
 {
 	int i, ret;
 	int open_fds[101];
diff --git a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
index 8039e1eff938..9f55ccd169a1 100644
--- a/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmio_warning_test.c
@@ -84,7 +84,7 @@ int get_warnings_count(void)
 	f = popen("dmesg | grep \"WARNING:\" | wc -l", "r");
 	if (fscanf(f, "%d", &warnings) < 1)
 		warnings = 0;
-	fclose(f);
+	pclose(f);
 
 	return warnings;
 }
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 65c141ebfbbd..5b45e6986aea 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -497,7 +497,7 @@ static int test_process_vm_readv(void)
 	}
 
 	if (vsyscall_map_r) {
-		if (!memcmp(buf, (const void *)0xffffffffff600000, 4096)) {
+		if (!memcmp(buf, remote.iov_base, sizeof(buf))) {
 			printf("[OK]\tIt worked and read correct data\n");
 		} else {
 			printf("[FAIL]\tIt worked but returned incorrect data\n");

--------------302F752F414E28FD40D17556--
