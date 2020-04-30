Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8C71C064C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Apr 2020 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgD3T0W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Apr 2020 15:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3T0V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Apr 2020 15:26:21 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAE6C035495
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 12:26:21 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id m5so2473593ilj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=tDimjc++p9z9/I8fVMD18UCvQaoCQ2HCiBnz8f0J4aA=;
        b=UG4RSoXfZpftFk0K6ibrWrZLY3kuW5ZJK3sZmGB4TYGYgKXOMaNF4Wwoc0loPT4+ga
         rsh4IZF/0mLKhSXMuJBeguRe0vq1J5Tti4rx1r8pX8ofZiZjU8k3i+2+rw9A+sqBPMjD
         ACF62ZmRvKpB7NuaLjZa5OwpyBFE1qsyd4bMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=tDimjc++p9z9/I8fVMD18UCvQaoCQ2HCiBnz8f0J4aA=;
        b=odsf80SnakIEcZpit+Nz5DRJV6iK0GRuXFklPVYm6Hy4S5HH9K4Jsmy+kmTOjehRDs
         lAV7p69yvAWWgtqRJLxYiRD3//MosIi3B4N9hchcloVRModVle6EkUmQ5m8AArfR8tsv
         +8NYSZYFlFuTwBKMpaXbODTlTQb80EUyKfIHrxb7fGPWr0mXwN5S/6Z7xnPYdepiNaSO
         AKBc+L0nJRBHhMw0nusXnegCu3Z0P2hWRrQ/plvhpF7HOGUbWrJP/IK3OkOSFlPkjoio
         rPh1YORgR4kPwP8zOzn6ru4/l1bRaZ6iTB+uU2FNcd2Gkl496DtsSor437k1bY2/HzVW
         9nTQ==
X-Gm-Message-State: AGi0PuYSnugnD66WqyXe0hjozX2SKEYOkE8/u8aAC51Xz+eU4rhLPHju
        QFUrv8dpZkQPaGHTjZWj0acQTaLDQhM=
X-Google-Smtp-Source: APiQypJTHulW4Ghd7hjLzHKd6NORfGAafoNGBlcfV6ly5LlCzrNsdReVQvv3oC0TjTfdkHSFm7l79g==
X-Received: by 2002:a92:b710:: with SMTP id k16mr3551743ili.270.1588274780844;
        Thu, 30 Apr 2020 12:26:20 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g87sm252226ile.25.2020.04.30.12.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 12:26:19 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     skhan@linuxfoundation.org,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit update for Linux 5.7-rc4
Message-ID: <c5edb7c4-c5ed-0209-3c7f-cace9d775d64@linuxfoundation.org>
Date:   Thu, 30 Apr 2020 13:26:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------10008E56FF95384B04969D10"
Content-Language: en-US
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------10008E56FF95384B04969D10
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kunit update for Linux 5.7-rc4.

This Kunit update for Linux 5.7-rc4 consists of a single fix to flush
the test summary to the console log without delay.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

   Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-5.7-rc4

for you to fetch changes up to 6cb1818798812fe7e2c8fe3f489ad1c86adfd6c4:

   kunit: Add missing newline in summary message (2020-04-23 15:42:00 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-5.7-rc4

This Kunit update for Linux 5.7-rc4 consists of a single fix to flush
the test summary to the console log without delay.

----------------------------------------------------------------
Marco Elver (1):
       kunit: Add missing newline in summary message

  lib/kunit/test.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

----------------------------------------------------------------

--------------10008E56FF95384B04969D10
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.7-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.7-rc4.diff"

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 7a6430a7fca0..ccb2ffad8dcf 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -93,7 +93,7 @@ static void kunit_print_ok_not_ok(void *test_or_suite,
 	 * representation.
 	 */
 	if (suite)
-		pr_info("%s %zd - %s",
+		pr_info("%s %zd - %s\n",
 			kunit_status_to_string(is_ok),
 			test_number, description);
 	else

--------------10008E56FF95384B04969D10--
